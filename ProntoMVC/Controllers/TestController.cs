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
using Pronto.ERP.Bll;

using Moq;

//using Microsoft.VisualStudio.TestTools.UnitTesting;
//using System.Diagnostics;

using System.Web.Security;

namespace ProntoMVC.Controllers
{
    public partial class TestController : Controller
    {

        //public static class AssertActionResult
        //{
        //    public static void IsContentResult(ActionResult result, string contentToMatch)
        //    {
        //        var contentResult = result as ContentResult;
        //       Debug.Assert.NotNull(contentResult);
        //       Assert.AreEqual(contentToMatch, contentResult.Content);
        //    }
        //}

        // [TestMethod]

        public void TestError()
        {
            // http://stackoverflow.com/questions/8308899/unit-test-a-file-upload-how

            // arrange


            throw new Exception("Test: Excepcion");
        }


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







        public void RequerimientoParcialConFirmas_Asserts()
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


            string sc;
            this.Session["BasePronto"] = Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey);
            string sss = this.Session["BasePronto"].ToString();
            sc = Generales.sCadenaConex(sss);

            PedidoController target = new PedidoController(); // TODO: Initialize to an appropriate value
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

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            Presupuesto Presupuesto = db.Presupuestos.Where(p => p.IdPresupuesto == 7627).Include(p => p.DetallePresupuestos).SingleOrDefault();

            Presupuesto.IdProveedor = db.Proveedores.Where(c => c.RazonSocial == "TRANSCONTROL S.R.L.").Select(c => c.IdProveedor).First();
            // Presupuesto.PuntoVenta = 1;
            //      Presupuesto.TipoABC = "E"; // TipoABC debería ser readonly... ademas, la factelect no depende ni del cliente, sino del punto de venta
            Presupuesto.IdMoneda = 1;
            Presupuesto.CotizacionMoneda = 1;

            //   Presupuesto.FechaPresupuesto = DateTime.Now;
            //          Presupuesto.FechaIngreso = DateTime.Now;


            //        Presupuesto.ImporteTotal = 222;


            //Presupuesto. = "Esta solicitud fue creada para Demo de Web";

            Presupuesto.Observaciones = "Solicitud para Demo de Web";
            //            Presupuesto.IdVendedor = 3; ///'IdUsuarioEnProntoVB6()




            var myDetF = new DetallePresupuesto();
            myDetF.IdArticulo = db.Articulos.Where(c => c.Descripcion == "LING.ALUMINIO  SILUMIN Kgrs").Select(c => c.IdArticulo).First();
            //myDetF.= DateAdd(DateInterval.Weekday, 3, Now);

            myDetF.Cantidad = 30;
            //myDetF.PrecioUnitario = (decimal)1.41;
            //myDetF.Bonificacion = 0;
            // myDetF. = 21;

            Presupuesto.DetallePresupuestos.Add(myDetF);


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
            target.db = db;
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
            target.db = db;
            actual = target.BatchUpdate(Pedido);



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



        private ComprobanteProveedorController GetMockedComprobanteProveedorController()
        {

            var accountController = new ComprobanteProveedorController();


            //var httpContextMock = new Mock<HttpContextBase>();
            //var serverMock = new Mock<HttpServerUtilityBase>();
            //serverMock.Setup(x => x.MapPath("~/App_Data")).Returns(@"C:\Backup\BDL\ProntoMVC\ProntoMVC\App_Data");  // es case sensitive!!!!  no pongas "app_data"    // (@"C:\Users\Mariano\Desktop");
            //httpContextMock.Setup(x => x.Server).Returns(serverMock.Object);
            //var sut = new ComprobanteProveedorController();
            //sut.ControllerContext = new ControllerContext(httpContextMock.Object, new System.Web.Routing.RouteData(), sut);



            var controllerContext = new Mock<ControllerContext>();
            controllerContext.SetupGet(p => p.HttpContext.Session["BasePronto"]).Returns(Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey));
            //  controllerContext.SetupGet(p => p.HttpContext.User.Identity.Name).Returns(_testEmail);
            controllerContext.SetupGet(p => p.HttpContext.Request.IsAuthenticated).Returns(true);
            controllerContext.SetupGet(p => p.HttpContext.Response.Cookies).Returns(new HttpCookieCollection());

            controllerContext.Setup(p => p.HttpContext.Request.Form.Get("ReturnUrl")).Returns("sample-return-url");
            controllerContext.Setup(p => p.HttpContext.Request.Params.Get("q")).Returns("sample-search-term");

            accountController.ControllerContext = controllerContext.Object;

            return accountController;
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


            string sc;
            this.Session["BasePronto"] = Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey);
            string sss = this.Session["BasePronto"].ToString();
            sc = Generales.sCadenaConex(sss);





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


            o.IdProveedorEventual = db.Proveedores.Where(c => c.RazonSocial == "LYDIA E. FERRANDE Y ALCIRA E PEREZ S.H.").Select(c => c.IdProveedor).First();
            o.IdProveedor = db.Proveedores.Where(c => c.RazonSocial == "LYDIA E. FERRANDE Y ALCIRA E PEREZ S.H.").Select(c => c.IdProveedor).First();
            o.IdCuenta = db.Cuentas.Where(c => c.Descripcion == "FONDO FIJO COMPRAS MENORES TERMINIELLO").Select(c => c.IdCuenta).First();

            



            o.NumeroRendicionFF = 12;

            o.FechaRecepcion = DateTime.Today;

            
            o.NumeroComprobante1 = 1;
            o.NumeroComprobante2 = 2351;
            o.Letra = "A"; // TipoABC debería ser readonly... ademas, la factelect no depende ni del cliente, sino del punto de venta
            o.IdMoneda = 1;
            o.CotizacionMoneda = 1;
            o.CotizacionDolar = 7;
            o.NumeroCAI = "6464646";
            o.IdTipoComprobante = db.TiposComprobantes.Where(c => c.Descripcion == "Factura compra").Select(c => c.IdTipoComprobante).First();
            o.IdCondicionCompra = db.Condiciones_Compras.Where(c => c.Descripcion == "30 Dias Fecha Factura").Select(c => c.IdCondicionCompra).First();
            //   Presupuesto.FechaPresupuesto = DateTime.Now;
            //          Presupuesto.FechaIngreso = DateTime.Now;


            //        Presupuesto.ImporteTotal = 222;


            //Presupuesto. = "Esta solicitud fue creada para Demo de Web";

            o.Observaciones = "Solicitud para Demo de Web";
            //            Presupuesto.IdVendedor = 3; ///'IdUsuarioEnProntoVB6()




            var myDetF = new DetalleComprobantesProveedore();
            myDetF.IdCuenta = db.Cuentas.Where(c => c.Descripcion == "ACCIONES EN CIRCULACION").Select(c => c.IdCuenta).First();
            //myDetF.= DateAdd(DateInterval.Weekday, 3, Now);

            myDetF.Importe = 30.45M;
            //myDetF.PrecioUnitario = (decimal)1.41;
            //myDetF.Bonificacion = 0;
            // myDetF. = 21;

            o.DetalleComprobantesProveedores.Add(myDetF);


            //target.db = db;
            JsonResult actual2 =null; //= target.BatchUpdate(o);

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

        public void CircuitoCompras()
        {
            //http://msdn.microsoft.com/en-us/library/gg416511(v=vs.98).aspx

            string sc;
            this.Session["BasePronto"] = Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey);
            string sss = this.Session["BasePronto"].ToString();
            sc = Generales.sCadenaConex(sss);

            PedidoController target = new PedidoController(); // TODO: Initialize to an appropriate value
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

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            Presupuesto Presupuesto = db.Presupuestos.Where(p => p.IdPresupuesto == 7627).Include(p => p.DetallePresupuestos).SingleOrDefault();

            Presupuesto.IdProveedor = db.Proveedores.Where(c => c.RazonSocial == "TRANSCONTROL S.R.L.").Select(c => c.IdProveedor).First();
            // Presupuesto.PuntoVenta = 1;
            //      Presupuesto.TipoABC = "E"; // TipoABC debería ser readonly... ademas, la factelect no depende ni del cliente, sino del punto de venta
            Presupuesto.IdMoneda = 1;
            Presupuesto.CotizacionMoneda = 1;

            //   Presupuesto.FechaPresupuesto = DateTime.Now;
            //          Presupuesto.FechaIngreso = DateTime.Now;


            //        Presupuesto.ImporteTotal = 222;


            //Presupuesto. = "Esta solicitud fue creada para Demo de Web";

            Presupuesto.Observaciones = "Solicitud para Demo de Web";
            //            Presupuesto.IdVendedor = 3; ///'IdUsuarioEnProntoVB6()




            var myDetF = new DetallePresupuesto();
            myDetF.IdArticulo = db.Articulos.Where(c => c.Descripcion == "LING.ALUMINIO  SILUMIN Kgrs").Select(c => c.IdArticulo).First();
            //myDetF.= DateAdd(DateInterval.Weekday, 3, Now);

            myDetF.Cantidad = 30;
            //myDetF.PrecioUnitario = (decimal)1.41;
            //myDetF.Bonificacion = 0;
            // myDetF. = 21;

            Presupuesto.DetallePresupuestos.Add(myDetF);


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
            target.db = db;
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
            target.db = db;
            actual = target.BatchUpdate(Pedido);



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

        public void CircuitoVentas()
        {
            //http://msdn.microsoft.com/en-us/library/gg416511(v=vs.98).aspx

            string sc;
            this.Session["BasePronto"] = Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey);
            string sss = this.Session["BasePronto"].ToString();
            sc = Generales.sCadenaConex(sss);

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



    }
}


//using ProntoMVC.Controllers;
////using Microsoft.VisualStudio.TestTools.UnitTesting;
//using System;
////using Microsoft.VisualStudio.TestTools.UnitTesting.Web;
//using ProntoMVC.Data.Models; using ProntoMVC.Models;
//using System.Web.Mvc;
//using System.Web;
//using System.Web.SessionState;
//using System.Reflection;
//using System.Data.Entity;
//using System.Linq;
//using System.Linq.Dynamic;
//using System.Linq.Expressions;

//namespace TestProject2
//{


//    /// <summary>
//    ///This is a test class for FacturaControllerTest and is intended
//    ///to contain all FacturaControllerTest Unit Tests
//    ///</summary>
//    [TestClass()]
//    public class FacturaControllerTest
//    {


//        private TestContext testContextInstance;

//        /// <summary>
//        ///Gets or sets the test context which provides
//        ///information about and functionality for the current test run.
//        ///</summary>
//        public TestContext TestContext
//        {
//            get
//            {
//                return testContextInstance;
//            }
//            set
//            {
//                testContextInstance = value;
//            }
//        }

//        #region Additional test attributes
//        // 
//        //You can use the following additional attributes as you write your tests:
//        //
//        //Use ClassInitialize to run code before running the first test in the class
//        //[ClassInitialize()]
//        //public static void MyClassInitialize(TestContext testContext)
//        //{
//        //}
//        //
//        //Use ClassCleanup to run code after all tests in a class have run
//        //[ClassCleanup()]
//        //public static void MyClassCleanup()
//        //{
//        //}
//        //
//        //Use TestInitialize to run code before running each test
//        //[TestInitialize()]
//        //public void MyTestInitialize()
//        //{
//        //}
//        //
//        //Use TestCleanup to run code after each test has run
//        //[TestCleanup()]
//        //public void MyTestCleanup()
//        //{
//        //}
//        //
//        #endregion



//        string sc = "metadata=res://*/Models.Pronto.csdl|res://*/Models.Pronto.ssdl|res://*/Models.Pronto.msl;provider=System.Data.SqlClient;provider connection string='data source=MARIANO-PC\\SQLEXPRESS;initial catalog=Autotrol;integrated security=True;multipleactiveresultsets=True;App=EntityFramework'";


//        /// <summary>
//        ///A test for BatchUpdate
//        ///</summary>
//        // TODO: Ensure that the UrlToTest attribute specifies a URL to an ASP.NET page (for example,
//        // http://.../Default.aspx). This is necessary for the unit test to be executed on the web server,
//        // whether you are testing a page, web service, or a WCF service.
//        //[HostType("ASP.NET")]
//        //[AspNetDevelopmentServerHost("E:\\Backup\\BDL\\ProntoWeb\\ProntoMVC\\ProntoMVC", "/Pronto2")]
//        //[UrlToTest("http://localhost:40053/Pronto2/")]
//        [TestMethod()]
//        public void BatchUpdateTest()
//        {
//            //http://msdn.microsoft.com/en-us/library/gg416511(v=vs.98).aspx

//            FacturaController target = new FacturaController(); // TODO: Initialize to an appropriate value
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            DemoProntoEntities db = new DemoProntoEntities(sc);
//            // Generales.sCadenaConexSQL("Autotrol", new Guid("5211110C-AF10-4D39-80CC-2542F69D3179"))

//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//            Factura Factura = db.Facturas.Where(p => p.IdFactura == 7627).Include(p => p.DetalleFacturas).SingleOrDefault();

//            Factura.IdCliente = db.Clientes.Where(c => c.RazonSocial == "TRANSCONTROL S.R.L.").Select(c => c.IdCliente).First();
//            Factura.PuntoVenta = 1;
//            Factura.TipoABC = "E"; // TipoABC debería ser readonly... ademas, la factelect no depende ni del cliente, sino del punto de venta
//            Factura.IdMoneda = 1;
//            Factura.CotizacionMoneda = 1;

//            Factura.FechaFactura = DateTime.Now;
//            Factura.FechaIngreso = DateTime.Now;


//            Factura.ImporteTotal = 222;


//            //Factura. = "Esta solicitud fue creada para Demo de Web";

//            Factura.Observaciones = "Solicitud para Demo de Web";
//            Factura.IdVendedor = 3; ///'IdUsuarioEnProntoVB6()




//            var myDetF = new DetalleFactura();
//            myDetF.IdArticulo = db.Articulos.Where(c => c.Descripcion == "LING.ALUMINIO  SILUMIN Kgrs").Select(c => c.IdArticulo).First();
//            //myDetF.= DateAdd(DateInterval.Weekday, 3, Now);

//            myDetF.Cantidad = 30;
//            myDetF.PrecioUnitario = (decimal)1.41;
//            myDetF.Bonificacion = 0;
//            // myDetF. = 21;

//            Factura.DetalleFacturas.Add(myDetF);


//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            JsonResult expected = null;            // TODO: Initialize to an appropriate value
//            expected = new JsonResult();
//            FacturaController.JsonResponse res = new FacturaController.JsonResponse();
//            // res.Status = Status.Error;
//            // res.Errors = GetModelStateErrorsAsString(this.ModelState);
//            //res.Message = "Error al obtener CAE : El nÃºmero o fecha del comprobante no se corresponde con el prÃ³ximo a autorizar. Consultar metodo FECompUltimoAutorizado. - Ultimo numero 974";
//            //expected = Controller.Json(res);
//            JsonResult actual;
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//            //si llamás prepo a BatchFactura, el initialize no se corrió, el controlador no tiene el contexto inicializado (db es null)
//            // http://stackoverflow.com/questions/5507505/why-does-my-asp-net-mvc-controller-not-call-its-base-class-initialize-method-d
//            target.db = db;
//            actual = target.BatchUpdate(Factura);



//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//            Console.Write(actual.Data);


//            // Assert.AreEqual(expected, actual);
//            // Assert.Inconclusive("Verify the correctness of this test method.");
//        }


//       // [TestMethod()]
//        public void ElectronicaTest_WSFE1_LetraE()
//        {
//            //http://msdn.microsoft.com/en-us/library/gg416511(v=vs.98).aspx

//            FacturaController target = new FacturaController(); // TODO: Initialize to an appropriate value
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            DemoProntoEntities db = new DemoProntoEntities(sc);
//            // Generales.sCadenaConexSQL("Autotrol", new Guid("5211110C-AF10-4D39-80CC-2542F69D3179"))

//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            Factura Factura;
//            if (false)
//            {
//                Factura = db.Facturas.Where(p => p.IdFactura == 7627).Include(p => p.DetalleFacturas).SingleOrDefault();
//            }

//            else
//            {
//                Factura = new Factura();
//            }

//            Factura.IdCliente = db.Clientes.Where(c => c.RazonSocial == "TRANSCONTROL S.R.L.").Select(c => c.IdCliente).First();
//            Factura.PuntoVenta = 6;

//           // Factura.NumeroFactura = (int)Pronto.ERP.Bll.FacturaManager.ProximoNumeroFacturaPorIdCodigoIvaYNumeroDePuntoVenta(sc, 1, Factura.PuntoVenta ?? 0);

//            Factura.TipoABC = "E"; // TipoABC debería ser readonly... ademas, la factelect no depende ni del cliente, sino del punto de venta
//            Factura.IdMoneda = 1;
//            Factura.CotizacionMoneda = 1;

//            Factura.FechaFactura = DateTime.Now;
//            Factura.FechaIngreso = DateTime.Now;


//            Factura.ImporteTotal = 222;


//            //Factura. = "Esta solicitud fue creada para Demo de Web";

//            Factura.Observaciones = "Solicitud para Demo de Web";
//            Factura.IdVendedor = 3; ///'IdUsuarioEnProntoVB6()




//            var myDetF = new DetalleFactura();
//            myDetF.IdArticulo = db.Articulos.Where(c => c.Descripcion == "LING.ALUMINIO  SILUMIN Kgrs").Select(c => c.IdArticulo).First();
//            //myDetF.= DateAdd(DateInterval.Weekday, 3, Now);

//            myDetF.Cantidad = 30;
//            myDetF.PrecioUnitario = (decimal)1.41;
//            myDetF.Bonificacion = 0;
//            // myDetF. = 21;

//            Factura.DetalleFacturas.Add(myDetF);


//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            JsonResult expected = null;            // TODO: Initialize to an appropriate value
//            expected = new JsonResult();
//            FacturaController.JsonResponse res = new FacturaController.JsonResponse();
//            // res.Status = Status.Error;
//            // res.Errors = GetModelStateErrorsAsString(this.ModelState);
//            //res.Message = "Error al obtener CAE : El nÃºmero o fecha del comprobante no se corresponde con el prÃ³ximo a autorizar. Consultar metodo FECompUltimoAutorizado. - Ultimo numero 974";
//            //expected = Controller.Json(res);
//            JsonResult actual;
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//            //si llamás prepo a BatchFactura, el initialize no se corrió, el controlador no tiene el contexto inicializado (db es null)
//            // http://stackoverflow.com/questions/5507505/why-does-my-asp-net-mvc-controller-not-call-its-base-class-initialize-method-d
//            target.db = db;
//            actual = target.BatchUpdate(Factura);



//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//            Console.Write(actual.Data);


//            // Assert.AreEqual(expected, actual);
//            // Assert.Inconclusive("Verify the correctness of this test method.");
//        }


//        //[TestMethod()]
//        public void AltaFactura()
//        {
//            //http://msdn.microsoft.com/en-us/library/gg416511(v=vs.98).aspx

//            FacturaController target = new FacturaController(); // TODO: Initialize to an appropriate value

//            //si llamás prepo a BatchFactura, el initialize no se corrió, el controlador no tiene el contexto inicializado (db es null)
//            // http://stackoverflow.com/questions/5507505/why-does-my-asp-net-mvc-controller-not-call-its-base-class-initialize-method-d
//            var contexto = new DemoProntoEntities(sc);
//            target.db = contexto;


//            // Factura Factura = contexto.Facturas.Find(7627);

//            HttpContext.Current = FakeHttpContext();
//            // System.Web.HttpContext httpContext = System.Web.HttpContext.Current;
//            HttpContext.Current.Session["BasePronto"] = "Autotrol";
//            ViewResult aaa = target.Edit(-1);
//            Factura Factura = aaa.ViewData.Model as Factura;

//            JsonResult expected = null;            // TODO: Initialize to an appropriate value
//            expected = new JsonResult();
//            FacturaController.JsonResponse res = new FacturaController.JsonResponse();
//            // res.Status = Status.Error;
//            // res.Errors = GetModelStateErrorsAsString(this.ModelState);
//            //res.Message = "Error al obtener CAE : El nÃºmero o fecha del comprobante no se corresponde con el prÃ³ximo a autorizar. Consultar metodo FECompUltimoAutorizado. - Ultimo numero 974";
//            //expected = Controller.Json(res);

//            JsonResult actual;

//            actual = target.BatchUpdate(Factura);

//            Console.Write(actual.Data);


//            // Assert.AreEqual(expected, actual);
//            //Assert.Inconclusive(actual.Data);
//        }




//        public static HttpContext FakeHttpContext()
//        {
//            var httpRequest = new HttpRequest("", "http://kindermusik/", "");
//            var stringWriter = new System.IO.StringWriter();
//            var httpResponce = new HttpResponse(stringWriter);
//            var httpContext = new HttpContext(httpRequest, httpResponce);

//            var sessionContainer = new HttpSessionStateContainer("id", new SessionStateItemCollection(),
//                                                    new HttpStaticObjectsCollection(), 10, true,
//                                                    HttpCookieMode.AutoDetect,
//                                                    SessionStateMode.InProc, false);

//            httpContext.Items["AspSession"] = typeof(HttpSessionState).GetConstructor(
//                                        BindingFlags.NonPublic | BindingFlags.Instance,
//                                        null, CallingConventions.Standard,
//                                        new[] { typeof(HttpSessionStateContainer) },
//                                        null)
//                                .Invoke(new object[] { sessionContainer });

//            return httpContext;
//        }
//    }
//}





/*



Imports System
Imports System.DateTime
Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.IO
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports Pronto.ERP.Bll.EntidadManager
Imports Microsoft.Office.Interop.Excel
Imports System.Text
Imports System.Data
Imports System.Diagnostics
Imports System.Web.UI
Imports Excel = Microsoft.Office.Interop.Excel


Imports ClaseMigrar.SQLdinamico
Imports ClaseMigrar.dsEncrypt
Imports clasemigrar

Public Module Tests

    '/////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////
    'DATOS GENERICOS SUELTOS
    '/////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////

    '////////////////////
    'MARCALBA
    '////////////////////

    'DOBLAMETAL SACIFIA      30-50516917-0
    'NICOLAS KOSC            20-04874347-2
    'EDITORIAL DISTAL SA     30-68897518-9




    '////////////////////
    'ALEMARSA
    '////////////////////
    Const P1 As String = "SHELL CIA ARGENTINA DE PETROLEO S.A."
    Const P1CUIT As String = "30-65663161-1"
    Const P2 As String = "LAMITE S.R.L."
    Const P2CUIT As String = "30-70849773-3"
    Const P3 As String = "PROPLASTO S.R.L."
    Const P3CUIT As String = "30-62880338-8"

    Const A1 As String = "Protector para cubierta 1000"
    'Protector para cubierta 1000
    'Tirante Pino Paraná de 3" x 8" x 1.10 mts.
    'Rollo de cinta de peligro (100 mts)



    '/////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////






    Function test1_ReclamoN9066(ByVal sc As String) As String

        Dim ds As New WillyInformesDataSet
        Dim adapter As New WillyInformesDataSetTableAdapters.wCartasDePorte_TX_InformesCorregidoTableAdapter

        '// Customize the connection string.
        Dim builder = New SqlClient.SqlConnectionStringBuilder(Encriptar(sc)) ' Properties.Settings.Default.DistXsltDbConnectionString)
        'builder.DataSource = builder.DataSource.Replace(".", Environment.MachineName)
        Dim desiredConnectionString = builder.ConnectionString

        '// Set it directly on the adapter.
        adapter.Connection.ConnectionString = desiredConnectionString 'tenes que cambiar el ConnectionModifier=Public http://weblogs.asp.net/rajbk/archive/2007/05/26/changing-the-connectionstring-of-a-wizard-generated-tableadapter-at-runtime-from-an-objectdatasource.aspx
        adapter.Fill(ds.wCartasDePorte_TX_InformesCorregido, -1, #4/1/2012#, #4/4/2012#)

        Dim sWHERE = ""
        ' Dim output As String = Sincronismo_Argencer(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)

        'Return output
    End Function


    Sub TestVentas_OC_REM_FAC_REC_CNSapag(ByVal Yo As Object, ByVal SC As String, ByRef Session As Object)

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'DEMO CON CERTIFICACIONES

        'resumen:
        'CTACTE: revisas
        'OC: me piden una autopista y una docena de planchuelas
        'FAC 1: anticipo de la autopista
        'REC 1: me pagan el anticipo?
        'REM 1: le mando media docena de las planchuelas (la autopista no)
        'FAC 2: contrato por las planchuelas -y esto incluye recibo? -NO ES AL CONTADO. El recibo se hace aparte. 
        'REC 2: me pagan las planchuelas?
        'FAC 3: con devolucion de anticipo. 1er tramo de la autopista 
        'REC 3: pagan la FAC 3
        'CONSULTA Clientes-Desarrollo de Items de OC: ves los anticipos
        'FAC 4, terminan rapidamente la autopista.
        'REC 4: pagan la FAC
        'CTACTE: revisas
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////

        Dim myFactura As Factura
        Dim myDetF As FacturaItem
        Dim myDetF_OC As FacturaOrdenesCompraItem
        Dim myDetF_REM As FacturaRemitosItem

        Dim myRecibo As Recibo
        Dim myDetImputacion As ReciboItem
        Dim myDetValor As ReciboValoresItem

        Dim myREM = New Remito
        Dim myDetREM As RemitoItem



        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////

        'verfico el saldo del cliente
        Dim oCli As Cliente
        'Dim saldo = ClienteManager.GetItem(SC, BuscaIdCliente("BAKER", SC)).Saldo
        Dim saldo = CtaCteDeudorManager.Saldo(SC, BuscaIdCliente("BAKER", SC))
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'OC: me piden una autopista y unos tornillos


        Dim myOC = New OrdenCompra
        Dim myDetOC As OrdenCompraItem

        With myOC


            .IdCliente = BuscaIdCliente("BAKER", SC)
            .NumeroOrdenCompraCliente = Int(Microsoft.VisualBasic.Rnd() * 10000)
            .IdMoneda = 1
            '.PuntoVenta = 1

            '.CotizacionMoneda = 4
            .FechaOrdenCompra = Now

            .Fecha = Now
            .FechaIngreso = Now
            '.FechaRecibo = Now
            .Observaciones = "OC para Demo de Web"



            myDetOC = New OrdenCompraItem
            With myDetOC
                .Nuevo = True

                .IdArticulo = BuscaIdArticuloNET("Certificacion Obra Privada UTE LUCIANO", SC) 'esta bien así? así se pide la obra?
                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)
                .Cantidad = 1
                .Precio = 1300000
                .TipoCancelacion = 1 'por certificacion
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetOC)


            myDetOC = New OrdenCompraItem
            With myDetOC
                .Nuevo = True

                .IdArticulo = BuscaIdArticuloNET("PLANCHUELA HIERRO 5/8", SC)
                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)
                .Cantidad = 12
                .TipoCancelacion = 0 'por cantidad
                .Precio = 3.48
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetOC)


            myDetOC = New OrdenCompraItem
            With myDetOC
                .Nuevo = True
            End With
            .Detalles.Add(myDetOC)


        End With

        OrdenCompraManager.Save(SC, myOC)


        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '1ra factura: anticipo de la autopista -pero de esto no hay recibo? -NO ES AL CONTADO
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////



        myFactura = New Pronto.ERP.BO.Factura
        With myFactura


            .IdCliente = BuscaIdCliente("BAKER", SC)
            .PuntoVenta = 1
            .IdMoneda = 1

            .CotizacionMoneda = 1
            .Fecha = Now
            .FechaIngreso = Now
            .FechaAprobacion = Now

            .Detalle = "Esta solicitud fue creada para Demo de Web"

            .Observaciones = "Solicitud para Demo de Web"
            .IdComprador = 3 'IdUsuarioEnProntoVB6()



            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True
                .IdArticulo = BuscaIdArticuloNET("Anticipo Financiero", SC)

                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

                .Cantidad = 30
                .Precio = 1.41
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)


            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True

                .IdArticulo = BuscaIdArticuloNET("CHAPA GRUESA 1.00 x 2.00 x 3", SC)
                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)
                .Cantidad = 65
                .Precio = 3.48
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)
            myDetF = Nothing

            'imputaciones

            myDetF_OC = New FacturaOrdenesCompraItem
            With myDetF_OC
                .Nuevo = True

                .IdDetalleFactura = 1
                .IdDetalleOrdenCompra = myOC.Detalles(0).Id
                .PorcentajeCertificacion = 20
                .ImporteTotalItem = 153.48
            End With
            .DetallesOrdenesCompra.Add(myDetF_OC)
            myDetF_OC = Nothing

        End With

        FacturaManager.Save(SC, myFactura)
        myFactura = Nothing



        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '2da factura: contrato por los tornillos
        myFactura = New Pronto.ERP.BO.Factura
        With myFactura


            .IdCliente = BuscaIdCliente("BAKER", SC)
            .PuntoVenta = 1
            .IdMoneda = 1

            .CotizacionMoneda = 1
            .Fecha = Now
            .FechaIngreso = Now
            .FechaAprobacion = Now

            .Detalle = "Esta solicitud fue creada para Demo de Web"

            .Observaciones = "Solicitud para Demo de Web"
            .IdComprador = 3 'IdUsuarioEnProntoVB6()



            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True
                .IdArticulo = BuscaIdArticuloNET("PLANCHUELA HIERRO 5/8", SC)

                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

                .Cantidad = 30
                .Precio = 1.41
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)


            'imputaciones

            myDetF_OC = New FacturaOrdenesCompraItem
            With myDetF_OC
                .Nuevo = True

                .IdDetalleFactura = 1
                .IdDetalleOrdenCompra = myOC.Detalles(0).Id
                .PorcentajeCertificacion = 20
                .ImporteTotalItem = 153.48
            End With
            .DetallesOrdenesCompra.Add(myDetF_OC)
            myDetF_OC = Nothing


            'myDetF_REM = New FacturaRemitosItem
            'With myDetF_REM
            '    .Nuevo = True

            '    .Id = myFactura.DetallesRemitos.Count
            '    .IdDetalleFactura = 1
            '    .IdDetalleRemito = myREM.Detalles(0).Id
            'End With
            '.DetallesRemitos.Add(myDetF_REM)
            'myDetF_REM = Nothing

        End With

        Dim IdFacturaDeLasPlanchuelas = FacturaManager.Save(SC, myFactura)
        myFactura = Nothing

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'REM: los tornillos se los mando (la autopista no)

        myREM = New Remito
        With myREM


            .IdCliente = BuscaIdCliente("BAKER", SC)

            .IdMoneda = 1
            .PuntoVenta = 1

            '.CotizacionMoneda = 4
            '.FechaRemito = Now
            .Fecha = Now


            '.FechaRecibo = Now
            .Observaciones = "remito para Demo de Web"



            myDetREM = New RemitoItem
            With myDetREM
                .Nuevo = True

                .IdArticulo = BuscaIdArticuloNET("PLANCHUELA HIERRO 5/8", SC)
                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)
                .Cantidad = 6
                .Observaciones = "Te mando media docena, la otra te la debo"
            End With
            .Detalles.Add(myDetREM)


        End With

        RemitoManager.Save(SC, myREM)






        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'REC: me pagan los tornillos -las planchuelas! -eso...

        myRecibo = New Recibo

        With myRecibo


            .IdCliente = BuscaIdCliente("BAKER", SC)

            .IdMoneda = 1
            .PuntoVenta = 1

            .CotizacionMoneda = 4
            .FechaIngreso = Today
            .FechaRecibo = Now
            .Observaciones = "Recibo para Demo de Web"



            myDetImputacion = New ReciboItem
            With myDetImputacion
                .Nuevo = True
                .IdImputacion = IdFacturaDeLasPlanchuelas 'BuscaIdComprobante("FACTURA 10110-2136464", SC)
                .Importe = 215.48
            End With
            .DetallesImputaciones.Add(myDetImputacion)



            myDetValor = New ReciboValoresItem
            With myDetValor
                .Nuevo = True
                .IdTipoValor = 6
                .FechaVencimiento = #1/1/2050#
                .IdBanco = 1
                .NumeroInterno = Int(Microsoft.VisualBasic.Rnd() * 1000000)
                .NumeroValor = Int(Microsoft.VisualBasic.Rnd() * 1000000)
                .Importe = 215.48
            End With
            .DetallesValores.Add(myDetValor)


        End With

        ReciboManager.Save(SC, myRecibo)


        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'factura: certificacion autopista con devolucion de anticipo de la autopista 
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////



        myFactura = New Pronto.ERP.BO.Factura
        With myFactura


            .IdCliente = BuscaIdCliente("BAKER", SC)
            .PuntoVenta = 1
            .IdMoneda = 1

            .CotizacionMoneda = 1
            .Fecha = Now
            .FechaIngreso = Now
            .FechaAprobacion = Now

            .Detalle = "Esta solicitud fue creada para Demo de Web"

            .Observaciones = "Solicitud para Demo de Web"
            .IdComprador = 3 'IdUsuarioEnProntoVB6()



            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True
                .IdArticulo = BuscaIdArticuloNET("Certificacion Obra Privada UTE LUCIANO", SC)

                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

                .Cantidad = 30
                .Precio = 1.41
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)


            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True

                .IdArticulo = BuscaIdArticuloNET("Devolucion anticipos", SC)
                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)
                .Cantidad = 65
                .Precio = 3.48
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)
            myDetF = Nothing

            'imputaciones

            myDetF_OC = New FacturaOrdenesCompraItem
            With myDetF_OC
                .Nuevo = True

                .IdDetalleFactura = 1
                .IdDetalleOrdenCompra = myOC.Detalles(0).Id
                .PorcentajeCertificacion = 20
                .ImporteTotalItem = 153.48
            End With
            .DetallesOrdenesCompra.Add(myDetF_OC)
            myDetF_OC = Nothing

        End With

        FacturaManager.Save(SC, myFactura)
        myFactura = Nothing

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'REC: me pagan el primer tramo de autopista

        myRecibo = New Recibo

        With myRecibo


            .IdCliente = BuscaIdCliente("BAKER", SC)

            .IdMoneda = 1
            .PuntoVenta = 1

            .CotizacionMoneda = 4
            .FechaIngreso = Now
            .FechaRecibo = Now
            .Observaciones = "Recibo para Demo de Web"



            myDetImputacion = New ReciboItem
            With myDetImputacion
                .Nuevo = True
                .IdImputacion = 100 'BuscaIdComprobante("FACTURA 10110-2136464", SC)
                .Importe = 215.48
            End With
            .DetallesImputaciones.Add(myDetImputacion)



            myDetValor = New ReciboValoresItem
            With myDetValor
                .Nuevo = True
                .IdTipoValor = 6
                .FechaVencimiento = #1/1/2050#
                .IdBanco = 1
                .NumeroInterno = Int(Microsoft.VisualBasic.Rnd() * 1000000)
                .NumeroValor = Int(Microsoft.VisualBasic.Rnd() * 1000000)
                .Importe = 215.48
            End With
            .DetallesValores.Add(myDetValor)


        End With

        ReciboManager.Save(SC, myRecibo)




        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'factura: certificacion del 2do tramo de autopista con devolucion de anticipo de la autopista 
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////



        myFactura = New Pronto.ERP.BO.Factura
        With myFactura


            .IdCliente = BuscaIdCliente("BAKER", SC)
            .PuntoVenta = 1
            .IdMoneda = 1

            .CotizacionMoneda = 1
            .Fecha = Now
            .FechaIngreso = Now
            .FechaAprobacion = Now

            .Detalle = "Esta solicitud fue creada para Demo de Web"

            .Observaciones = "Solicitud para Demo de Web"
            .IdComprador = 3 'IdUsuarioEnProntoVB6()



            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True
                .IdArticulo = BuscaIdArticuloNET("Certificacion Obra Privada UTE LUCIANO", SC)

                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

                .Cantidad = 30
                .Precio = 1.41
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)


            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True

                .IdArticulo = BuscaIdArticuloNET("101 - Anticipos Financieros Anticipo Financiero", SC)
                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)
                .Cantidad = 65
                .Precio = 3.48
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)
            myDetF = Nothing

            'imputaciones

            myDetF_OC = New FacturaOrdenesCompraItem
            With myDetF_OC
                .Nuevo = True

                .IdDetalleFactura = 1
                .IdDetalleOrdenCompra = myOC.Detalles(0).Id
                .PorcentajeCertificacion = 20
                .ImporteTotalItem = 153.48
            End With
            .DetallesOrdenesCompra.Add(myDetF_OC)
            myDetF_OC = Nothing


            myDetF_REM = New FacturaRemitosItem
            With myDetF_REM
                .Nuevo = True

                .Id = myFactura.DetallesRemitos.Count
                .IdDetalleFactura = 1
                .IdDetalleRemito = myREM.Detalles(0).Id
            End With
            .DetallesRemitos.Add(myDetF_REM)
            myDetF_REM = Nothing

        End With

        FacturaManager.Save(SC, myFactura)
        myFactura = Nothing

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'REC: me pagan el segundo tramo de autopista

        myRecibo = New Recibo
        With myRecibo


            .IdCliente = BuscaIdCliente("BAKER", SC)

            .IdMoneda = 1
            .PuntoVenta = 1

            .CotizacionMoneda = 4
            .FechaIngreso = Now
            .FechaRecibo = Now
            .Observaciones = "Recibo para Demo de Web"



            myDetImputacion = New ReciboItem
            With myDetImputacion
                .Nuevo = True
                .IdImputacion = 100 'BuscaIdComprobante("FACTURA 10110-2136464", SC)
                .Importe = 215.48
            End With
            .DetallesImputaciones.Add(myDetImputacion)



            myDetValor = New ReciboValoresItem
            With myDetValor
                .Nuevo = True
                .IdTipoValor = 6
                .FechaVencimiento = #1/1/2050#
                .IdBanco = 1
                .NumeroInterno = Int(Microsoft.VisualBasic.Rnd() * 1000000)
                .NumeroValor = Int(Microsoft.VisualBasic.Rnd() * 1000000)
                .Importe = 215.48
            End With
            .DetallesValores.Add(myDetValor)


        End With

        ReciboManager.Save(SC, myRecibo)



        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////


        'verfico el saldo del cliente
        ' Dim saldo2 = ClienteManager.GetItem(SC, BuscaIdCliente("BAKER", SC)).Saldo
        Dim saldo2 = CtaCteDeudorManager.Saldo(SC, BuscaIdCliente("BAKER", SC))

        ' MsgBoxAjax(Yo, "Saldo final: " & saldo2)
    End Sub



    Sub TestVentas_OC_REM_FAC_REC_Equimac(ByVal Yo As Object, ByVal SC As String, ByRef Session As Object)

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'DEMO CON CERTIFICACIONES

        'resumen:
        'CTACTE: revisas
        'OC: me piden una autopista y una docena de planchuelas
        'FAC 1: anticipo de la autopista
        'REC 1: me pagan el anticipo?
        'REM 1: le mando media docena de las planchuelas (la autopista no)
        'FAC 2: contrato por las planchuelas -y esto incluye recibo? -NO ES AL CONTADO. El recibo se hace aparte. 
        'REC 2: me pagan las planchuelas?
        'FAC 3: con devolucion de anticipo. 1er tramo de la autopista 
        'REC 3: pagan la FAC 3
        'CONSULTA Clientes-Desarrollo de Items de OC: ves los anticipos
        'FAC 4, terminan rapidamente la autopista.
        'REC 4: pagan la FAC
        'CTACTE: revisas
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////

        Dim myFactura As Factura
        Dim myDetF As FacturaItem
        Dim myDetF_OC As FacturaOrdenesCompraItem
        Dim myDetF_REM As FacturaRemitosItem

        Dim myRecibo As Recibo
        Dim myDetImputacion As ReciboItem
        Dim myDetValor As ReciboValoresItem

        Dim myREM = New Remito
        Dim myDetREM As RemitoItem



        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////

        'verfico el saldo del cliente
        Dim oCli As Cliente
        'Dim saldo = ClienteManager.GetItem(SC, BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)).Saldo
        Dim saldo = CtaCteDeudorManager.Saldo(SC, BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC))
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'OC: me piden una autopista y unos tornillos


        Dim myOC = New OrdenCompra
        Dim myDetOC As OrdenCompraItem

        With myOC


            .IdCliente = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)
            .NumeroOrdenCompraCliente = Int(Microsoft.VisualBasic.Rnd() * 10000)
            .IdMoneda = 1
            '.PuntoVenta = 1

            '.CotizacionMoneda = 4
            .FechaOrdenCompra = Now

            .Fecha = Now
            .FechaIngreso = Now
            '.FechaRecibo = Now
            .Observaciones = "OC para Demo de Web"



            myDetOC = New OrdenCompraItem
            With myDetOC
                .Nuevo = True

                .IdArticulo = BuscaIdArticuloNET("Certificado por trabajos realizados en vuestra obra: Autovia Mar del Plata - Balcarce", SC) 'esta bien así? así se pide la obra?
                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)
                .Cantidad = 1
                .Precio = 1300000
                .TipoCancelacion = 1 'por certificacion
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetOC)


            myDetOC = New OrdenCompraItem
            With myDetOC
                .Nuevo = True

                .IdArticulo = BuscaIdArticuloNET("Seguro uña excavadora Tortone ", SC)
                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)
                .Cantidad = 12
                .TipoCancelacion = 0 'por cantidad
                .Precio = 3.48
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetOC)


            myDetOC = New OrdenCompraItem
            With myDetOC
                .Nuevo = True
            End With
            .Detalles.Add(myDetOC)


        End With

        OrdenCompraManager.Save(SC, myOC)


        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '1ra factura: anticipo de la autopista -pero de esto no hay recibo? -NO ES AL CONTADO
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////



        myFactura = New Pronto.ERP.BO.Factura
        With myFactura


            .IdCliente = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)
            .PuntoVenta = 1
            .IdMoneda = 1

            .CotizacionMoneda = 1
            .Fecha = Now
            .FechaIngreso = Now
            .FechaAprobacion = Now

            .Detalle = "Esta solicitud fue creada para Demo de Web"

            .Observaciones = "Solicitud para Demo de Web"
            .IdComprador = 3 'IdUsuarioEnProntoVB6()



            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True
                .IdArticulo = BuscaIdArticuloNET("Anticipo Financiero", SC)

                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

                .Cantidad = 30
                .Precio = 1.41
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)


            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True

                .IdArticulo = BuscaIdArticuloNET("ASFALTO MEZCLA 70/30", SC)
                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)
                .Cantidad = 65
                .Precio = 3.48
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)
            myDetF = Nothing

            'imputaciones

            myDetF_OC = New FacturaOrdenesCompraItem
            With myDetF_OC
                .Nuevo = True

                .IdDetalleFactura = 1
                .IdDetalleOrdenCompra = myOC.Detalles(0).Id
                .PorcentajeCertificacion = 20
                .ImporteTotalItem = 153.48
            End With
            .DetallesOrdenesCompra.Add(myDetF_OC)
            myDetF_OC = Nothing

        End With

        FacturaManager.Save(SC, myFactura)
        myFactura = Nothing



        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '2da factura: contrato por los tornillos
        myFactura = New Pronto.ERP.BO.Factura
        With myFactura


            .IdCliente = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)
            .PuntoVenta = 1
            .IdMoneda = 1

            .CotizacionMoneda = 1
            .Fecha = Now
            .FechaIngreso = Now
            .FechaAprobacion = Now

            .Detalle = "Esta solicitud fue creada para Demo de Web"

            .Observaciones = "Solicitud para Demo de Web"
            .IdComprador = 3 'IdUsuarioEnProntoVB6()



            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True
                .IdArticulo = BuscaIdArticuloNET("Seguro uña excavadora Tortone ", SC)

                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

                .Cantidad = 30
                .Precio = 1.41
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)


            'imputaciones

            myDetF_OC = New FacturaOrdenesCompraItem
            With myDetF_OC
                .Nuevo = True

                .IdDetalleFactura = 1
                .IdDetalleOrdenCompra = myOC.Detalles(0).Id
                .PorcentajeCertificacion = 20
                .ImporteTotalItem = 153.48
            End With
            .DetallesOrdenesCompra.Add(myDetF_OC)
            myDetF_OC = Nothing


            'myDetF_REM = New FacturaRemitosItem
            'With myDetF_REM
            '    .Nuevo = True

            '    .Id = myFactura.DetallesRemitos.Count
            '    .IdDetalleFactura = 1
            '    .IdDetalleRemito = myREM.Detalles(0).Id
            'End With
            '.DetallesRemitos.Add(myDetF_REM)
            'myDetF_REM = Nothing

        End With

        Dim IdFacturaDeLasPlanchuelas = FacturaManager.Save(SC, myFactura)
        myFactura = Nothing

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'REM: los tornillos se los mando (la autopista no)

        myREM = New Remito
        With myREM


            .IdCliente = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)

            .IdMoneda = 1
            .PuntoVenta = 1

            '.CotizacionMoneda = 4
            '.FechaRemito = Now
            .Fecha = Now


            '.FechaRecibo = Now
            .Observaciones = "remito para Demo de Web"



            myDetREM = New RemitoItem
            With myDetREM
                .Nuevo = True

                .IdArticulo = BuscaIdArticuloNET("Seguro uña excavadora Tortone ", SC)
                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)
                .Cantidad = 6
                .Observaciones = "Te mando media docena, la otra te la debo"
            End With
            .Detalles.Add(myDetREM)


        End With

        RemitoManager.Save(SC, myREM)






        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'REC: me pagan los tornillos -las planchuelas! -eso...

        myRecibo = New Recibo

        With myRecibo


            .IdCliente = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)

            .IdMoneda = 1
            .PuntoVenta = 1

            .CotizacionMoneda = 4
            .FechaIngreso = Now
            .FechaRecibo = Now
            .Observaciones = "Recibo para Demo de Web"



            myDetImputacion = New ReciboItem
            With myDetImputacion
                .Nuevo = True
                .IdImputacion = IdFacturaDeLasPlanchuelas 'BuscaIdComprobante("FACTURA 10110-2136464", SC)
                .Importe = 215.48
            End With
            .DetallesImputaciones.Add(myDetImputacion)



            myDetValor = New ReciboValoresItem
            With myDetValor
                .Nuevo = True
                .IdTipoValor = 6
                .FechaVencimiento = #1/1/2050#
                .IdBanco = 1
                .NumeroInterno = Int(Rnd() * 1000000)
                .NumeroValor = Int(Rnd() * 1000000)
                .Importe = 215.48
            End With
            .DetallesValores.Add(myDetValor)


        End With

        ReciboManager.Save(SC, myRecibo)


        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'factura: certificacion autopista con devolucion de anticipo de la autopista 
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////



        myFactura = New Pronto.ERP.BO.Factura
        With myFactura


            .IdCliente = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)
            .PuntoVenta = 1
            .IdMoneda = 1

            .CotizacionMoneda = 1
            .Fecha = Now
            .FechaIngreso = Now
            .FechaAprobacion = Now

            .Detalle = "Esta solicitud fue creada para Demo de Web"

            .Observaciones = "Solicitud para Demo de Web"
            .IdComprador = 3 'IdUsuarioEnProntoVB6()



            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True
                .IdArticulo = BuscaIdArticuloNET("Certificado por trabajos realizados en vuestra obra: Autovia Mar del Plata - Balcarce", SC)

                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

                .Cantidad = 30
                .Precio = 1.41
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)


            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True

                .IdArticulo = BuscaIdArticuloNET("Devolucion anticipos", SC)
                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)
                .Cantidad = 65
                .Precio = 3.48
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)
            myDetF = Nothing

            'imputaciones

            myDetF_OC = New FacturaOrdenesCompraItem
            With myDetF_OC
                .Nuevo = True

                .IdDetalleFactura = 1
                .IdDetalleOrdenCompra = myOC.Detalles(0).Id
                .PorcentajeCertificacion = 20
                .ImporteTotalItem = 153.48
            End With
            .DetallesOrdenesCompra.Add(myDetF_OC)
            myDetF_OC = Nothing

        End With

        FacturaManager.Save(SC, myFactura)
        myFactura = Nothing

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'REC: me pagan el primer tramo de autopista

        myRecibo = New Recibo

        With myRecibo


            .IdCliente = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)

            .IdMoneda = 1
            .PuntoVenta = 1

            .CotizacionMoneda = 4
            .FechaIngreso = Now
            .FechaRecibo = Now
            .Observaciones = "Recibo para Demo de Web"



            myDetImputacion = New ReciboItem
            With myDetImputacion
                .Nuevo = True
                .IdImputacion = 100 'BuscaIdComprobante("FACTURA 10110-2136464", SC)
                .Importe = 215.48
            End With
            .DetallesImputaciones.Add(myDetImputacion)



            myDetValor = New ReciboValoresItem
            With myDetValor
                .Nuevo = True
                .IdTipoValor = 6
                .FechaVencimiento = #1/1/2050#
                .IdBanco = 1
                .NumeroInterno = Int(Rnd() * 1000000)
                .NumeroValor = Int(Rnd() * 1000000)
                .Importe = 215.48
            End With
            .DetallesValores.Add(myDetValor)


        End With

        ReciboManager.Save(SC, myRecibo)




        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'factura: certificacion del 2do tramo de autopista con devolucion de anticipo de la autopista 
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////



        myFactura = New Pronto.ERP.BO.Factura
        With myFactura


            .IdCliente = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)
            .PuntoVenta = 1
            .IdMoneda = 1

            .CotizacionMoneda = 1
            .Fecha = Now
            .FechaIngreso = Now
            .FechaAprobacion = Now

            .Detalle = "Esta solicitud fue creada para Demo de Web"

            .Observaciones = "Solicitud para Demo de Web"
            .IdComprador = 3 'IdUsuarioEnProntoVB6()



            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True
                .IdArticulo = BuscaIdArticuloNET("Certificado por trabajos realizados en vuestra obra: Autovia Mar del Plata - Balcarce", SC)

                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

                .Cantidad = 30
                .Precio = 1.41
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)


            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True

                .IdArticulo = BuscaIdArticuloNET("101 - Anticipos Financieros Anticipo Financiero", SC)
                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)
                .Cantidad = 65
                .Precio = 3.48
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)
            myDetF = Nothing

            'imputaciones

            myDetF_OC = New FacturaOrdenesCompraItem
            With myDetF_OC
                .Nuevo = True

                .IdDetalleFactura = 1
                .IdDetalleOrdenCompra = myOC.Detalles(0).Id
                .PorcentajeCertificacion = 20
                .ImporteTotalItem = 153.48
            End With
            .DetallesOrdenesCompra.Add(myDetF_OC)
            myDetF_OC = Nothing


            myDetF_REM = New FacturaRemitosItem
            With myDetF_REM
                .Nuevo = True

                .Id = myFactura.DetallesRemitos.Count
                .IdDetalleFactura = 1
                .IdDetalleRemito = myREM.Detalles(0).Id
            End With
            .DetallesRemitos.Add(myDetF_REM)
            myDetF_REM = Nothing

        End With

        FacturaManager.Save(SC, myFactura)
        myFactura = Nothing

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'REC: me pagan el segundo tramo de autopista

        myRecibo = New Recibo
        With myRecibo


            .IdCliente = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)

            .IdMoneda = 1
            .PuntoVenta = 1

            .CotizacionMoneda = 4
            .FechaIngreso = Now
            .FechaRecibo = Now
            .Observaciones = "Recibo para Demo de Web"



            myDetImputacion = New ReciboItem
            With myDetImputacion
                .Nuevo = True
                .IdImputacion = 100 'BuscaIdComprobante("FACTURA 10110-2136464", SC)
                .Importe = 215.48
            End With
            .DetallesImputaciones.Add(myDetImputacion)



            myDetValor = New ReciboValoresItem
            With myDetValor
                .Nuevo = True
                .IdTipoValor = 6
                .FechaVencimiento = #1/1/2050#
                .IdBanco = 1
                .NumeroInterno = Int(Rnd() * 1000000)
                .NumeroValor = Int(Rnd() * 1000000)
                .Importe = 215.48
            End With
            .DetallesValores.Add(myDetValor)


        End With

        ReciboManager.Save(SC, myRecibo)



        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////


        'verfico el saldo del cliente
        ' Dim saldo2 = ClienteManager.GetItem(SC, BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)).Saldo
        Dim saldo2 = CtaCteDeudorManager.Saldo(SC, BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC))
        '
        ' MsgBoxAjax(Yo, "Saldo final: " & saldo2)
    End Sub

    Sub TestAsiento(ByVal Yo As Object, ByVal SC As String, ByRef Session As Object)

        '//////////////////////////////////////////////////


        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'REC: me pagan los tornillos -las planchuelas! -eso...
        Dim oAs As New Asiento

        With oAs

            .FechaAsiento = Now
            .Concepto = "asdasd"
            .AsientoApertura = "NO"
            .AsignarAPresupuestoObra = "NO"


            Dim i As New AsientoItem
            With i
                .Nuevo = True
                .IdCuenta = 333
                .Debe = 234
            End With
            .Detalles.Add(i)


            Dim i2 As New AsientoItem
            With i2
                .Nuevo = True
                .IdCuenta = 333
                .Haber = 234
            End With
            .Detalles.Add(i2)




            Dim h As New AsientoAnticiposItem
            With h
                .IdEmpleado = BuscaIdEmpleadoPreciso("Carlitos", SC)
                .Importe = 5454
                .CantidadCuotas = 1
                .Detalle = "asdasd"

                .Nuevo = True
                '    .IdTipoValor = 6
                '    .FechaVencimiento = #1/1/2050#
                '    .IdBanco = 1
                '    .NumeroInterno = Int(Rnd() * 1000000)
                '    .NumeroValor = Int(Rnd() * 1000000)
                '    .Importe = 215.48
            End With
            .DetallesAnticipos.Add(h)


        End With

        AsientoManager.Save(SC, oAs)


        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'factura: certificacion autopista con devolucion de anticipo de la autopista 
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////


        'verfico el saldo del cliente
        ' Dim saldo2 = ClienteManager.GetItem(SC, BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)).Saldo
        Dim saldo2 = CtaCteDeudorManager.Saldo(SC, BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC))

        '   MsgBoxAjax(Yo, "Saldo final: " & saldo2)
    End Sub


    Sub TestVentas_FAC_Equimac(ByVal Yo As Object, ByVal SC As String, ByRef Session As Object)

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'DEMO CON CERTIFICACIONES

        'resumen:
        'CTACTE: revisas
        'OC: me piden una autopista y una docena de planchuelas
        'FAC 1: anticipo de la autopista
        'REC 1: me pagan el anticipo?
        'REM 1: le mando media docena de las planchuelas (la autopista no)
        'FAC 2: contrato por las planchuelas -y esto incluye recibo? -NO ES AL CONTADO. El recibo se hace aparte. 
        'REC 2: me pagan las planchuelas?
        'FAC 3: con devolucion de anticipo. 1er tramo de la autopista 
        'REC 3: pagan la FAC 3
        'CONSULTA Clientes-Desarrollo de Items de OC: ves los anticipos
        'FAC 4, terminan rapidamente la autopista.
        'REC 4: pagan la FAC
        'CTACTE: revisas
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////

        Dim myFactura As Factura
        Dim myDetF As FacturaItem
        Dim myDetF_OC As FacturaOrdenesCompraItem
        Dim myDetF_REM As FacturaRemitosItem

        Dim myRecibo As Recibo
        Dim myDetImputacion As ReciboItem
        Dim myDetValor As ReciboValoresItem

        Dim myREM = New Remito
        Dim myDetREM As RemitoItem



        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////

        'verfico el saldo del cliente
        Dim oCli As Cliente
        'Dim saldo = ClienteManager.GetItem(SC, BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)).Saldo
        Dim saldo = CtaCteDeudorManager.Saldo(SC, BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC))
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////




        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '2da factura: contrato por los tornillos
        myFactura = New Pronto.ERP.BO.Factura
        With myFactura


            .IdCliente = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)
            .PuntoVenta = 1
            .IdMoneda = 1

            .CotizacionMoneda = 1
            .Fecha = Now
            .FechaIngreso = Now
            .FechaAprobacion = Now

            .Detalle = "Esta solicitud fue creada para Demo de Web"

            .Observaciones = "Solicitud para Demo de Web"
            .IdComprador = 3 'IdUsuarioEnProntoVB6()



            myDetF = New FacturaItem
            With myDetF
                .Nuevo = True
                .IdArticulo = BuscaIdArticuloNET("Seguro uña excavadora Tortone ", SC)

                .FechaEntrega = DateAdd(DateInterval.Weekday, 3, Now)

                .Cantidad = 30
                .Precio = 1.41
                .PorcentajeBonificacion = 0
                .PorcentajeIVA = 21
            End With
            .Detalles.Add(myDetF)


            'imputaciones

            'myDetF_OC = New FacturaOrdenesCompraItem
            'With myDetF_OC
            '    .Nuevo = True

            '    .IdDetalleFactura = 1
            '    .IdDetalleOrdenCompra = myOC.Detalles(0).Id
            '    .PorcentajeCertificacion = 20
            '    .ImporteTotalItem = 153.48
            'End With
            '.DetallesOrdenesCompra.Add(myDetF_OC)
            'myDetF_OC = Nothing


            'myDetF_REM = New FacturaRemitosItem
            'With myDetF_REM
            '    .Nuevo = True

            '    .Id = myFactura.DetallesRemitos.Count
            '    .IdDetalleFactura = 1
            '    .IdDetalleRemito = myREM.Detalles(0).Id
            'End With
            '.DetallesRemitos.Add(myDetF_REM)
            'myDetF_REM = Nothing

        End With

        Dim IdFacturaDeLasPlanchuelas = FacturaManager.Save(SC, myFactura)
        myFactura = Nothing







        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////


        'verfico el saldo del cliente
        'Dim saldo2 = ClienteManager.GetItem(SC, BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)).Saldo
        Dim saldo2 = CtaCteDeudorManager.Saldo(SC, BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC))

        ' MsgBoxAjax(Yo, "Saldo final: " & saldo2)
    End Sub


    Sub TestVentas_NC_ND_CNSapag(ByVal Yo As Object, ByVal SC As String, ByRef Session As Object)

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'DEMO CON CERTIFICACIONES

        'resumen:
        'CTACTE: revisas
        'OC: me piden una autopista y una docena de planchuelas
        'FAC 1: anticipo de la autopista
        'REC 1: me pagan el anticipo?
        'REM 1: le mando media docena de las planchuelas (la autopista no)
        'FAC 2: contrato por las planchuelas -y esto incluye recibo? -NO ES AL CONTADO. El recibo se hace aparte. 
        'REC 2: me pagan las planchuelas?
        'FAC 3: con devolucion de anticipo. 1er tramo de la autopista 
        'REC 3: pagan la FAC 3
        'CONSULTA Clientes-Desarrollo de Items de OC: ves los anticipos
        'FAC 4, terminan rapidamente la autopista.
        'REC 4: pagan la FAC
        'CTACTE: revisas
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////

        Dim myFactura As Factura
        Dim myDetF As FacturaItem
        Dim myDetF_OC As FacturaOrdenesCompraItem
        Dim myDetF_REM As FacturaRemitosItem

        Dim myRecibo As Recibo
        Dim myDetImputacion As ReciboItem
        Dim myDetValor As ReciboValoresItem

        Dim myREM = New Remito
        Dim myDetREM As RemitoItem

        Dim myNC As NotaDeCredito
        Dim myDetNC As NotaDeCreditoItem

        Dim myND As NotaDeDebito
        Dim myDetND As NotaDeDebitoItem

        Dim myDetNC_FAC As NotaDeCreditoImpItem
        Dim myDetNC_OC As NotaDeCreditoOCItem

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////



        myNC = New NotaDeCredito
        With myNC


            .IdCliente = BuscaIdCliente("BAKER", SC)
            .PuntoVenta = 1
            .IdMoneda = 1

            .CotizacionMoneda = 1
            .Fecha = Now
            .FechaIngreso = Now
            .FechaAprobacion = Now
            '.FechaNotaCredito = Now

            .Detalle = "Esta solicitud fue creada para Demo de Web"

            .Observaciones = "Solicitud para Demo de Web"
            .IdComprador = 3 'IdUsuarioEnProntoVB6()





            myDetNC = New NotaDeCreditoItem
            With myDetNC
                .Nuevo = True

                .IdConcepto = BuscaIdConceptoPreciso("Ajuste clientes", SC)
                .Gravado = "SI"
                .IdCaja = 2
                .ImporteTotalItem = 232
            End With

            .Detalles.Add(myDetNC)
            myDetNC = Nothing



            'imputaciones FAC

            myDetNC_FAC = New NotaDeCreditoImpItem
            With myDetNC_FAC
                .Nuevo = True

                .IdImputacion = 20
                .Importe = 153.48
            End With
            .DetallesImp.Add(myDetNC_FAC)
            myDetNC_FAC = Nothing



            'imputaciones OC
            myDetNC_OC = New NotaDeCreditoOCItem
            With myDetNC_OC
                .Nuevo = True

                .IdDetalleOrdenCompra = 21 ' myOC.Detalles(0).Id
                .Cantidad = 22
                .PorcentajeCertificacion = 20
            End With
            .DetallesOC.Add(myDetNC_OC)
            myDetNC_OC = Nothing





        End With

        NotaDeCreditoManager.Save(SC, myNC)
        myNC = Nothing

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////



        myND = New NotaDeDebito
        With myND


            .IdCliente = BuscaIdCliente("BAKER", SC)
            .PuntoVenta = 1
            .IdMoneda = 1

            .CotizacionMoneda = 1
            .Fecha = Now
            .FechaIngreso = Now
            .FechaAprobacion = Now
            '.FechaNotaDebito = Now

            .Detalle = "Esta solicitud fue creada para Demo de Web"

            .Observaciones = "Solicitud para Demo de Web"
            .IdComprador = 3 'IdUsuarioEnProntoVB6()


            myDetND = New NotaDeDebitoItem
            With myDetND
                .Nuevo = True



                .IdConcepto = BuscaIdConceptoPreciso("Ajuste clientes", SC)
                .Gravado = "SI"
                .IdCaja = 1
                .ImporteTotalItem = 232

            End With
            .Detalles.Add(myDetND)

        End With

        NotaDeDebitoManager.Save(SC, myND)
        myND = Nothing


    End Sub




    Sub TestCompras_CP3_OP_Equimac(ByVal Yo As Object, ByVal SC As String, ByRef Session As Object)
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'DEMO CON CERTIFICACIONES

        'resumen:
        'CTACTE: revisas
        'OC: me piden una autopista y una docena de planchuelas
        'FAC 1: anticipo de la autopista
        'REC 1: me pagan el anticipo?
        'REM 1: le mando media docena de las planchuelas (la autopista no)
        'FAC 2: contrato por las planchuelas -y esto incluye recibo? -NO ES AL CONTADO. El recibo se hace aparte. 
        'REC 2: me pagan las planchuelas?
        'FAC 3: con devolucion de anticipo. 1er tramo de la autopista 
        'REC 3: pagan la FAC 3
        'CONSULTA Clientes-Desarrollo de Items de OC: ves los anticipos
        'FAC 4, terminan rapidamente la autopista.
        'REC 4: pagan la FAC
        'CTACTE: revisas
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////

        Dim myCP As ComprobanteProveedor
        Dim myDetCP As ComprobanteProveedorItem


        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////



        myCP = New ComprobanteProveedor
        With myCP


            '.IdCliente = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)
            '.PuntoVenta = 1
            .IdMoneda = 1
            .NumeroComprobante1 = Rnd(1000)
            .NumeroComprobante2 = Rnd(100000)
            .CotizacionMoneda = 1



            .IdTipoComprobante = BuscaIdTipoComprobantePreciso("Factura compra", SC)
            If .IdTipoComprobante = -1 Then Stop

            '.Fecha = Now
            .FechaComprobante = Now
            .FechaIngreso = Now
            .FechaVencimiento = Now
            .FechaRecepcion = Now
            .Confirmado = "SI"
            '.FechaAprobacion = Now
            '.FechaNotaCredito = Now

            '.Detalle = "Esta solicitud fue creada para Demo de Web"

            .Observaciones = "Solicitud para Demo de Web"
            '.IdComprador = 3 'IdUsuarioEnProntoVB6()





            myDetCP = New ComprobanteProveedorItem
            With myDetCP
                .Nuevo = True
                .IdCuenta = BuscaIdConceptoPreciso("Instalación y Mantenimiento de Obra 1022892", SC)
                .Importe = 542.11
                '.IdConcepto = BuscaIdConceptoPreciso("Ajuste", SC)
                '.Gravado = "SI"
                '.IdCaja = 2
                '.ImporteTotalItem = 232
            End With

            .Detalles.Add(myDetCP)
            myDetCP = Nothing






        End With

        ComprobanteProveedorManager.Save(SC, myCP)
        myCP = Nothing

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////

        '//////////////////////////////////////////////////
        'Alta de Orden de Pago para asignar un monto tope a la cuenta de fondo fijo (ver manual)
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////


        Dim myOP As OrdenPago
        Dim myDetOP As OrdenPagoItem
        Dim myDetOPvalor As OrdenPagoValoresItem
        Dim myDetOPcuenta As OrdenPagoCuentasItem
        Dim myDetOPrubro As OrdenPagoRubrosContablesItem
        Dim myDetOPimpuest As OrdenPagoImpuestosItem
        Dim myDetOPanticipo As OrdenPagoAnticiposAlPersonalItem



        myOP = New OrdenPago
        With myOP

            .IdProveedor = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)
            .IdMoneda = 1
            '.PuntoVenta = 1
            .NumeroOrdenPago = Rnd() * 100000
            .CotizacionMoneda = 4
            .FechaIngreso = Now
            .FechaOrdenPago = Now
            '.FechaRecibo = Now
            .Observaciones = "OrdenPago para Demo de Web"



            myDetOP = New OrdenPagoItem
            With myDetOP
                .Nuevo = True
                .IdImputacion = 100 'BuscaIdComprobante("FACTURA 10110-2136464", SC)
                .Importe = 215.48
            End With
            .DetallesImputaciones.Add(myDetOP)


            myDetOPvalor = New OrdenPagoValoresItem
            With myDetOPvalor
                .Nuevo = True
                .IdTipoValor = 6
                .FechaVencimiento = #1/1/2050#
                .IdBanco = 1
                .NumeroInterno = Int(Rnd() * 1000000)
                .NumeroValor = Int(Rnd() * 1000000)
                .Importe = 215.48
            End With
            .DetallesValores.Add(myDetOPvalor)


            myDetOPimpuest = New OrdenPagoImpuestosItem
            With myDetOPimpuest
                .Nuevo = True
                '.IdImtacion = 100 'BuscaIdComprobante("FACTURA 10110-2136464", SC)
                '.Importe = 215.48
            End With
            .DetallesImpuestos.Add(myDetOPimpuest)


            myDetOPrubro = New OrdenPagoRubrosContablesItem
            With myDetOPrubro
                .Nuevo = True
                .IdRubroContable = 100 'BuscaIdComprobante("FACTURA 10110-2136464", SC)
                .Importe = 215.48
            End With
            .DetallesRubrosContables.Add(myDetOPrubro)


            myDetOPanticipo = New OrdenPagoAnticiposAlPersonalItem
            With myDetOPanticipo
                .Nuevo = True
                '.IdImputacion = 100 'BuscaIdComprobante("FACTURA 10110-2136464", SC)
                '.Importe = 215.48
            End With
            .DetallesAnticiposAlPersonal.Add(myDetOPanticipo)


            myDetOPcuenta = New OrdenPagoCuentasItem
            With myDetOPcuenta
                .Nuevo = True
                .IdCuenta = 100 'BuscaIdComprobante("FACTURA 10110-2136464", SC)
                '.Importe = 215.48
            End With
            .DetallesCuentas.Add(myDetOPcuenta)




        End With


        'OrdenPagoManager.Save(SC, myOP)



        '//////////////////////////////////////////////////












    End Sub




    Sub TestVentas_NC_ND_Equimac(ByVal Yo As Object, ByVal SC As String, ByRef Session As Object)

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'DEMO CON CERTIFICACIONES

        'resumen:
        'CTACTE: revisas
        'OC: me piden una autopista y una docena de planchuelas
        'FAC 1: anticipo de la autopista
        'REC 1: me pagan el anticipo?
        'REM 1: le mando media docena de las planchuelas (la autopista no)
        'FAC 2: contrato por las planchuelas -y esto incluye recibo? -NO ES AL CONTADO. El recibo se hace aparte. 
        'REC 2: me pagan las planchuelas?
        'FAC 3: con devolucion de anticipo. 1er tramo de la autopista 
        'REC 3: pagan la FAC 3
        'CONSULTA Clientes-Desarrollo de Items de OC: ves los anticipos
        'FAC 4, terminan rapidamente la autopista.
        'REC 4: pagan la FAC
        'CTACTE: revisas
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////

        Dim myFactura As Factura
        Dim myDetF As FacturaItem
        Dim myDetF_OC As FacturaOrdenesCompraItem
        Dim myDetF_REM As FacturaRemitosItem

        Dim myRecibo As Recibo
        Dim myDetImputacion As ReciboItem
        Dim myDetValor As ReciboValoresItem

        Dim myREM = New Remito
        Dim myDetREM As RemitoItem

        Dim myNC As NotaDeCredito
        Dim myDetNC As NotaDeCreditoItem

        Dim myND As NotaDeDebito
        Dim myDetND As NotaDeDebitoItem

        Dim myDetNC_FAC As NotaDeCreditoImpItem
        Dim myDetNC_OC As NotaDeCreditoOCItem

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////



        myNC = New NotaDeCredito
        With myNC


            .IdCliente = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)
            .PuntoVenta = 1
            .IdMoneda = 1

            .CotizacionMoneda = 1
            .Fecha = Now
            .FechaIngreso = Now
            .FechaAprobacion = Now
            '.FechaNotaCredito = Now

            .Detalle = "Esta solicitud fue creada para Demo de Web"

            .Observaciones = "Solicitud para Demo de Web"
            .IdComprador = 3 'IdUsuarioEnProntoVB6()





            myDetNC = New NotaDeCreditoItem
            With myDetNC
                .Nuevo = True

                .IdConcepto = BuscaIdConceptoPreciso("Ajuste", SC)
                .Gravado = "SI"
                .IdCaja = 2
                .ImporteTotalItem = 232
            End With

            .Detalles.Add(myDetNC)
            myDetNC = Nothing



            'imputaciones FAC

            myDetNC_FAC = New NotaDeCreditoImpItem
            With myDetNC_FAC
                .Nuevo = True

                .IdImputacion = 20
                .Importe = 153.48
            End With
            .DetallesImp.Add(myDetNC_FAC)
            myDetNC_FAC = Nothing



            'imputaciones OC
            myDetNC_OC = New NotaDeCreditoOCItem
            With myDetNC_OC
                .Nuevo = True

                .IdDetalleOrdenCompra = 21 ' myOC.Detalles(0).Id
                .Cantidad = 22
                .PorcentajeCertificacion = 20
            End With
            .DetallesOC.Add(myDetNC_OC)
            myDetNC_OC = Nothing





        End With

        NotaDeCreditoManager.Save(SC, myNC)
        myNC = Nothing

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////



        myND = New NotaDeDebito
        With myND


            .IdCliente = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", SC)
            .PuntoVenta = 1
            .IdMoneda = 1

            .CotizacionMoneda = 1
            .Fecha = Now
            .FechaIngreso = Now
            .FechaAprobacion = Now
            '.FechaNotaDebito = Now

            .Detalle = "Esta solicitud fue creada para Demo de Web"

            .Observaciones = "Solicitud para Demo de Web"
            .IdComprador = 3 'IdUsuarioEnProntoVB6()


            myDetND = New NotaDeDebitoItem
            With myDetND
                .Nuevo = True



                .IdConcepto = BuscaIdConceptoPreciso("Ajuste", SC)
                .Gravado = "SI"
                .IdCaja = 1
                .ImporteTotalItem = 232

            End With
            .Detalles.Add(myDetND)

        End With

        NotaDeDebitoManager.Save(SC, myND)
        myND = Nothing


    End Sub
















    





    Sub ScriptTestPuntoNET(ByVal SC As String, ByRef Session As Object)
        'a traves del bus creo una solicitud
        Dim myPresupuesto As New Pronto.ERP.BO.Presupuesto
        Dim myProveedor As Pronto.ERP.BO.Proveedor

        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'creo un proveedor
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////

        If BuscaIdProveedorNET(P1, SC) = -1 Then
            myProveedor = New Pronto.ERP.BO.Proveedor
        Else
            myProveedor = ProveedorManager.GetItem(SC, BuscaIdProveedorNET(P1, SC))
        End If
        With myProveedor
            .Confirmado = "SI"
            .RazonSocial = P1
            .Cuit = P1CUIT
            .EnviarEmail = 1
            'If mLetra = ""B"" Or mLetra = ""C"" Then
            .IdCodigoIva = 0
            'mIdCodigoIva = 0
            'Else
            'mIdCodigoIva = 1
            'End If

            .IdCondicionCompra = ""


            Dim myContacto As New Pronto.ERP.BO.ProveedorContacto
            With myContacto
                .Contacto = "xx"
                .Email = "mscalella911@gmail.com"
            End With
            myProveedor.DetallesContactos.Add(myContacto)



        End With
        ProveedorManager.Save(SC, myProveedor)
        myProveedor = Nothing
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////

        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'creo una solicitud de presupuesto


        With myPresupuesto
            .ConfirmadoPorWeb = "NO"
            .IdProveedor = BuscaIdProveedorNET(P1, SC)
            '.Cuit = txtCUIT.Text
            '.EnviarEmail = 1
            '        If mLetra = ""B"" Or mLetra = ""C"" Then
            '    mIdCodigoIva = 0
            'Else
            '    mIdCodigoIva = 1
            'End If

            '.IdCodigoIva = mIdCodigoIva
            '.IdCondicionCompra = cmbCondicionIVA.SelectedValue
        End With
        PresupuestoManager.Save(SC, myPresupuesto)
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////


    End Sub








    Sub ScriptTestVB6(ByVal SC As String, ByRef Session As Object)
        Dim Aplicacion
        'Aplicacion = CreateObject("ComPronto.Aplicacion") dfgh


        Dim oArt 'As ComPronto.Articulo 
        Dim oPvdr 'As ComPronto.Proveedor 
        Dim oRbr 'As ComPronto.Rubro 
        Dim oSubRbr 'As ComPronto.Subrubro 
        Dim oUni 'As ComPronto.Unidad 




        'Componente VB6
        Dim VB6Presupuesto 'As ComPronto.Presupuesto 

        'creo un empleado (comprador y con permisos administrativos y con usuario LeoAdmin) con mi mail

        'creo 3 proveedores con mi mail
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Agrego el proveedor que necesito para el script

        If BuscaIdProveedor(P1, SC) = -1 Then
            oPvdr = Aplicacion.Proveedores.Item(-1)
            With oPvdr
                With .Registro
                    .Fields("RazonSocial").Value = P1
                    .Fields("Email").Value = "mscalella@yahoo.com.ar"
                End With
                .Guardar()
            End With
            oPvdr = Nothing
        End If
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////



        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'creo una solicitud de presupuesto


        Dim myPresupuesto As New Pronto.ERP.BO.Presupuesto
        With myPresupuesto
            .ConfirmadoPorWeb = "NO"
            .IdProveedor = BuscaIdProveedor("ACRON SRL", SC)
            '.Cuit = txtCUIT.Text
            '.EnviarEmail = 1
            '        If mLetra = ""B"" Or mLetra = ""C"" Then
            '    mIdCodigoIva = 0
            'Else
            '    mIdCodigoIva = 1
            'End If

            '.IdCodigoIva = mIdCodigoIva
            '.IdCondicionCompra = cmbCondicionIVA.SelectedValue
        End With
        PresupuestoManager.Save(SC, myPresupuesto)
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////




        'se los mando a los tres










        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'ARTICULOS
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Agrego el artículo que necesito para el script

        If BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado") = -1 Then
            oArt = Aplicacion.Articulos.Item(-1)
            With oArt
                With .Registro
                    .Fields("descripcion").Value = "Light 1/15 A002 Crudo B Vaporizado"
                    .Fields("Codigo").Value = "LA0021/15"
                    .Fields("IdRubro").Value = 1
                    .Fields("IdSubRubro").Value = 1
                End With
                .Guardar()
            End With
            oArt = Nothing
        End If


        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////

        If BuscaIdUnidad("Kilos") = -1 Then
            oUni = Aplicacion.Unidades.Item(-1)
            With oUni
                With .Registro
                    .Fields("descripcion").Value = "Kilos"
                    .Fields("Abreviatura").Value = "Kg"
                End With
                .Guardar()
            End With
            oUni = Nothing
        End If
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////










        '///////////////////////////////
        'llamo a la pagina
        'Dim pagina As presupresupuesto

        'redirect()

        'antes me debiera loguear como usuario del proveedor

        'cambio la cantidad de un articulo

        'Le doy al aceptar



    End Sub






    Public Sub mnuScriptInicializador_Click(ByVal SC As String)
        'Script para usar en el testing, que prueba directamente la capa de negocios
        Dim mN As Long
        Dim oPar 'As ComPronto.Parametro 

        Dim Orden 'As ComPronto.ProduccionOrden 
        Dim DetProduccionOrden 'As ComPronto.DetProduccionOrden 
        Dim DetProduccionOrdenProceso 'As ComPronto.DetProdOrdenProceso 

        Dim ficha 'As ComPronto.ProduccionFicha 
        Dim DetProduccionFicha 'As ComPronto.DetProduccionFicha 
        Dim DetProduccionFichaProceso 'As ComPronto.DetProdFichaProceso 

        Dim PP 'As ComPronto.ProduccionParte 
        Dim TipoCC 'As ComPronto.ControlCalidadTipo 

        Dim OC 'As ComPronto.OrdenCompra 
        Dim DetOC 'As ComPronto.DetOrdenCompra 

        Dim oI 'As ComPronto.OtroIngresoAlmacen 
        Dim DetOI 'As ComPronto.DetOtroIngresoAlmacen 

        Dim RM 'As ComPronto.Requerimiento 
        Dim DetRM 'As ComPronto.DetRequerimiento 

        Dim NP 'As ComPronto.Pedido 
        Dim DetNP 'As ComPronto.DetPedido 

        Dim oArt 'As ComPronto.Articulo 
        Dim oPvdr 'As ComPronto.Proveedor 
        Dim oRbr 'As ComPronto.Rubro 
        Dim oSubRbr 'As ComPronto.Subrubro 

        Dim oUni 'As ComPronto.Unidad 

        Dim rs As ADODB.Recordset

        'Const K_ART1 = 210
        'Const K_ART2 = 211

        Dim Aplicacion
        'Aplicacion = CreateObject("ComPronto.Aplicacion") dfgh


        'InicializaConstantesDeScripts

        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////

        Dim tipo 'As ComPronto.Tipo 

        rs = Aplicacion.Tipos.TraerTodos

        rs.Filter = "Descripcion='Insumo'"
        If rs.EOF Then
            tipo = Aplicacion.Tipos.Item(-1)
            With tipo
                With .Registro
                    .Fields("descripcion").Value = "Insumo"
                    .Fields("Abreviatura").Value = "IN"
                    .Fields("Codigo").Value = "31"
                    .Fields("Grupo").Value = 2
                End With
                .Guardar()
            End With
            tipo = Nothing
        End If

        rs.Filter = "Descripcion='Semielaborado'"
        If rs.EOF Then
            tipo = Aplicacion.Tipos.Item(-1)
            With tipo
                With .Registro
                    .Fields("descripcion").Value = "Semielaborado"
                    .Fields("Abreviatura").Value = "SE"
                    .Fields("Codigo").Value = "32"
                    .Fields("Grupo").Value = 2
                End With
                .Guardar()
            End With
            tipo = Nothing
        End If

        rs.Filter = "Descripcion='Terminado'"
        If rs.EOF Then
            tipo = Aplicacion.Tipos.Item(-1)
            With tipo
                With .Registro
                    .Fields("descripcion").Value = "Terminado"
                    .Fields("Abreviatura").Value = "TE"
                    .Fields("Codigo").Value = "33"
                    .Fields("Grupo").Value = 2
                End With
                .Guardar()
            End With
            tipo = Nothing
        End If


        'prefijar con _PRUEBA?


        'tendría que agregar algunos articulos de ejemplo. unos pares. como en el script
        ' que está en sql... -Pero si está hecho, por qué lo seguís en vb en lugar de sql?
        ' -Porque justamente quiero dejar de hacer scripts en sql, y usar los objetos










        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Agrego el rubro de terceros

        'If BuscaIdRubro("Camion Sarasa") = -1 Then
        'If IsNull(TraerValorParametro2("IdRubroEquiposTerceros")) Then

        '    oRbr = Aplicacion.Rubros.Item(-1)
        '    With oRbr
        '        With .Registro
        '            .Fields("descripcion").Value = "Rubro Camiones"
        '            '.Fields("Codigo = "RUBCAM"
        '        End With
        '        .Guardar()
        '        GuardarValorParametro2("IdRubroEquiposTerceros", .Registro.Fields(0))
        '    End With
        '    oRbr = Nothing
        'End If

        '//////////////////////////////////////////////////////////////////
        'Agrego el subrubro de terceros

        '    'If BuscaIdRubro("Camion Sarasa") = -1 Then
        '    If IsNull(TraerValorParametro2("IdSubrubroEquiposTerceros")) Then
        '
        '        Set oSubRbr = Aplicacion.Subrubros.Item(-1)
        '        With oSubRbr
        '            With .Registro
        '                .Fields("Descripcion = "Subrubro Camiones"
        '                .Fields("Codigo = "SUBRUBCAM"
        '            End With
        '            .Guardar
        '            GuardarValorParametro2 "IdSubrubroEquiposTerceros", .Registro.Fields(0)
        '        End With
        '        Set oSubRbr = Nothing
        '    End If



        '
        '    '//////////////////////////////////////////////////////////////////
        '    '//////////////////////////////////////////////////////////////////
        '    'Agrego el artículo que necesito para el script
        '
        '    Debug.Print TraerValorParametro2("IdRubroEquiposTerceros"), TraerValorParametro2("IdSubrubroEquiposTerceros")
        '
        '    If BuscaIdCamion("Camion Sarasa") = -1 Then
        '        Set oArt = Aplicacion.Articulos.Item(-1)
        '        With oArt
        '            With .Registro
        '                .Fields("Descripcion = "Camion Sarasa"
        '                .Fields("Codigo = "BFS646"
        '
        '                .Fields("IdRubro = iisNull(TraerValorParametro2("IdRubroEquiposTerceros"), "115")
        '                .Fields("IdSubRubro = iisNull(TraerValorParametro2("IdSubrubroEquiposTerceros"), 105)
        '
        '            End With
        '            .Guardar
        '        End With
        '        Set oArt = Nothing
        '    End If
        '
        '

        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Agrego el proveedor que necesito para el script

        If BuscaIdProveedor("ACRON SRL", SC) = -1 Then
            oPvdr = Aplicacion.Proveedores.Item(-1)
            With oPvdr
                With .Registro
                    .Fields("RazonSocial").Value = "ACRON SRL"
                End With
                .Guardar()
            End With
            oPvdr = Nothing
        End If
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////


        Dim oCol 'As ComPronto.Color 

        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////

        If BuscaIdColor("11227 Brownie") = -1 Then
            oCol = Aplicacion.Colores.Item(-1)
            With oCol
                With .Registro
                    .Fields("descripcion").Value = "11227 Brownie"
                    .Fields("Abreviatura").Value = "11227"
                End With
                .Guardar()
            End With
            oCol = Nothing
        End If

        '//////////////////////////////////////////////////////////////////

        If BuscaIdColor("LW419 Celeste") = -1 Then
            oCol = Aplicacion.Colores.Item(-1)
            With oCol
                With .Registro
                    .Fields("descripcion").Value = "LW419 Celeste"
                    .Fields("Abreviatura").Value = "LW419"
                End With
                .Guardar()
            End With
            oCol = Nothing
        End If

        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////




        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////

        If BuscaIdUnidad("Kilos") = -1 Then
            oUni = Aplicacion.Unidades.Item(-1)
            With oUni
                With .Registro
                    .Fields("descripcion").Value = "Kilos"
                    .Fields("Abreviatura").Value = "Kg"
                End With
                .Guardar()
            End With
            oUni = Nothing
        End If
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////




        Dim oDep 'As ComPronto.Deposito 
        Dim oUbi 'As ComPronto.Ubicacion 

        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////

        If BuscaIdDeposito("_PRUEBA Deposito de Produccion") = -1 Then
            oDep = Aplicacion.Depositos.Item(-1)
            With oDep
                With .Registro
                    .Fields("descripcion").Value = "_PRUEBA Deposito de Produccion"
                    .Fields("Abreviatura").Value = "PROD"
                    .Fields("IdObra").Value = 1
                End With
                .Guardar()
            End With
            oDep = Nothing
        End If

        '//////////////////////////////////////////////////////////////////

        If BuscaIdUbicacion("Mezcla") = -1 Then
            oUbi = Aplicacion.Ubicaciones.Item(-1)
            With oUbi
                With .Registro
                    .Fields("descripcion").Value = "Mezcla"
                    .Fields("IdDeposito").Value = BuscaIdDeposito("_PRUEBA Deposito de Produccion")

                    .Fields("Estanteria").Value = "AA"
                    .Fields("Modulo").Value = "VDC"
                    .Fields("Gabeta").Value = 4
                End With
                .Guardar()
            End With
            oUbi = Nothing
        End If
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////



        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'ARTICULOS
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Agrego el artículo que necesito para el script

        If BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado") = -1 Then
            oArt = Aplicacion.Articulos.Item(-1)
            With oArt
                With .Registro
                    .Fields("descripcion").Value = "Light 1/15 A002 Crudo B Vaporizado"
                    .Fields("Codigo").Value = "LA0021/15"
                    .Fields("IdRubro").Value = 1
                    .Fields("IdSubRubro").Value = 1
                End With
                .Guardar()
            End With
            oArt = Nothing
        End If

        '//////////////////////////////////////////////////////////////////



    End Sub



    Private Sub ScriptazoDeOPsQueSeEnganchan(ByVal SC As String)
        Dim pausa As Double
        pausa = 0.05




        Dim mN As Long
        Dim oPar 'As ComPronto.Parametro 

        Dim Orden 'As ComPronto.ProduccionOrden 
        Dim DetProduccionOrden 'As ComPronto.DetProduccionOrden 
        Dim DetProduccionOrdenProceso 'As ComPronto.DetProdOrdenProceso 

        Dim ficha 'As ComPronto.ProduccionFicha 
        Dim DetProduccionFicha 'As ComPronto.DetProduccionFicha 
        Dim DetProduccionFichaProceso 'As ComPronto.DetProdFichaProceso 

        Dim PP 'As ComPronto.ProduccionParte 
        Dim TipoCC 'As ComPronto.ControlCalidadTipo 

        Dim OC 'As ComPronto.OrdenCompra 
        Dim DetOC 'As ComPronto.DetOrdenCompra 

        Dim oI 'As ComPronto.OtroIngresoAlmacen 
        Dim DetOI 'As ComPronto.DetOtroIngresoAlmacen 

        Dim RM 'As ComPronto.Requerimiento 
        Dim DetRM 'As ComPronto.DetRequerimiento 

        Dim NP 'As ComPronto.Pedido 
        Dim DetNP 'As ComPronto.DetPedido 


        Dim SM 'As ComPronto.SalidaMateriales 
        Dim DetSM 'As ComPronto.DetSalidaMateriales 

        Dim art 'As ComPronto.Articulo 

        Dim i As Long
        Dim OC1 As Long

        Dim Aplicacion
        'Aplicacion = CreateObject("ComPronto.Aplicacion") fdghgh

        Dim NumeroOP1 As Long
        Dim NumeroOP2 As Long
        Dim NumeroOP3 As Long



        'prefijar con _PRUEBA?

        '   ahora no me debe preocupar tanto los permisos de procesos como el manejo de los
        '     consumos en los depositos
        'hay un movimiento de churruca a fabrica
        'me hacen la op
        'el parte consume lo que está en su depósito. puede ser el de fabrica, o usar uno "mezcla"
        '2 hilos se van procesando en dos mezcladoras
        'en el medio vamos viendo los cardex para confirmar los movimientos
        '1 va pasando a la carda
        'uno aventaja al otro y termina una tanda de semielaborado
        'voy abriendo otra op para generar un "terminado"
        'cuando llego al final, me fijo en la parte de terminado. va a estar deshabilitado
        'comprobar el numero de partida generado




        'Soft Lambswool  1/15 Vaporizado
        '
        '
        'Light 1/15 A002 Crudo B Vaporizado
        '    Fibra de lana carbonizada Cordero Cruda 21 Mic
        '    Pelo de Angora 2da nacional
        '    Pelo flandes crudo
        '    Fibra de poliamida 6,6  2.2 cruda
        '    Agua
        '
        '
        'Cashmere season 8/15 CS225 Rosa capullo Teñido


        mnuScriptInicializador_Click(SC)





        '///////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////
        'creo stock para hacer los movimientos
        '///////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////







        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        'OI - Alta (por COMPronto)
        'Creo algo de stock con OtrosIngresos
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////


        oPar = Aplicacion.Parametros.Item(1)
        With oPar.Registro
            mN = .Fields("ProximoNumeroOtroIngresoAlmacen").Value
            .Fields("ProximoNumeroOtroIngresoAlmacen").Value = mN + 1
        End With
        oPar.Guardar()


        oI = Aplicacion.OtrosIngresosAlmacen.Item(-1)
        With oI.Registro
            .Fields("NumeroOtroIngresoAlmacen").Value = mN
            '.Fields("Cliente = Registro.Fields("Cliente
            .Fields("FechaOtroIngresoAlmacen").Value = Today
            '.Fields("IdColor = 33
            .Fields("TipoIngreso").Value = 4
            .Fields("IdObra").Value = 1
            .Fields("Observaciones").Value = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        End With

        DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)
        With DetOI.Registro
            .Fields("IdArticulo").Value = BuscaIdArticulo("Fibra de poliamida 6,6  2.2 cruda")
            .Fields("Cantidad").Value = 80
            .Fields("IdUnidad").Value = BuscaIdUnidad("Kilos")
            .Fields("Partida").Value = "XRT4011"
            .Fields("IdUbicacion").Value = BuscaIdUbicacion("Mezcla")
            .Fields("Observaciones").Value = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        End With
        DetOI.Modificado = True


        DetOI = oI.DetOtrosIngresosAlmacen.Item(-1)
        With DetOI.Registro
            .Fields("IdArticulo").Value = BuscaIdArticulo("Agua")
            .Fields("Cantidad").Value = 80
            .Fields("IdUnidad").Value = BuscaIdUnidad("Kilos")
            .Fields("Partida").Value = ""
            '.Fields("IdUbicacion = BuscaIdUbicacion("Mezcla")
            .Fields("Observaciones").Value = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        End With
        DetOI.Modificado = True

        oI.Guardar()



        '///////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////
        'OC - Alta (por COMPronto)
        'La creo usando una OC (de la que hay una ficha)
        '///////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////

        oPar = Aplicacion.Parametros.Item(1)
        With oPar.Registro
            mN = .Fields("ProximoNumeroOrdenCompra").Value
            .Fields("ProximoNumeroOrdenCompra").Value = mN + 1
        End With
        oPar.Guardar()


        OC = Aplicacion.OrdenesCompra.Item(-1)
        With OC.Registro
            .Fields("NumeroOrdenCompra").Value = mN
            '.Fields("IdCliente").Value = KID_Cliente2
            '.Fields("FechaOrdenCompra").Value = Today - 2
            .Fields("Observaciones").Value = "_PRUEBA Creado por Script de Test de Modulo de Produccion"
        End With


        DetOC = OC.DetOrdenesCompra.Item(-1)
        With DetOC.Registro
            '.Fields("FechaNecesidad").Value = Today + 5
            .Fields("IdArticulo").Value = BuscaIdArticulo("Light 1/15 A002 Crudo B Vaporizado")
            .Fields("Cantidad").Value = 1500
            .Fields("IdUnidad").Value = BuscaIdUnidad("Kilos")

            .Fields("IdColor").Value = BuscaIdColor("11227 Brownie")

        End With
        DetOC.Modificado = True

        DetOC = OC.DetOrdenesCompra.Item(-1)
        With DetOC.Registro
            '.Fields("FechaNecesidad").Value = Today + 5
            .Fields("IdArticulo").Value = BuscaIdArticulo("Cashmere season 8/15 CS225 Rosa capullo Teñido")
            .Fields("Cantidad").Value = 700
            .Fields("IdUnidad").Value = BuscaIdUnidad("Kilos")

            .Fields("IdColor").Value = BuscaIdColor("LW419 Celeste")
        End With
        DetOC.Modificado = True


        OC.Guardar()
        OC1 = OC.Registro.Fields("IdOrdenCompra").Value
        OC = Nothing

    End Sub



























    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////




    


   

    Function f(ByVal o As Object) As String
        Dim oRng As Range
        oRng = CType(o, Microsoft.Office.Interop.Excel.Range)
        Dim strValue As String = oRng.Text.ToString()
        Return strValue
    End Function

    

  

    'Sub Importador()
    '    Dim DOCPATH As String
    '    Dim INIRENGLON As Long
    '    Dim FINRENGLON As Long
    '    Dim CurrentRow As Long

    '    Dim appExcel As Excel.Application
    '    Dim wk As Excel.Workbook
    '    Dim wh As Excel.Worksheet


    '    Dim oArt 'As ComPronto.Articulo 



    '    DOCPATH = "\doc\electrochance\gonza Maquinarias.xls"
    '    INIRENGLON = 4
    '    FINRENGLON = 2265

    '    K_UN1 = BuscaIdUnidad("Unidad")

    '    'Hacer funcion que descule cual es el campo que tira errores



    '    appExcel =CreateObject("Excel.Application")
    '    wk = appExcel.Workbooks.Open(App.Path & DOCPATH)
    '    'OpenCN cn, False, "", cConexionBASE             'Abrir conexion
    '    wh = wk.Worksheets(1)


    '    CurrentRow = INIRENGLON
    '    'While wh.Cells(CurrentRow, 1) <> "FIN"
    '    While CurrentRow < FINRENGLON

    '        Debug.Print(CurrentRow, wh.Cells(CurrentRow, "F"))
    '        If wh.Cells(CurrentRow, "F") <> "" Then

    '            '///////////////////////////////////////////////////////////////////
    '            '///////////////////////////////////////////////////////////////////
    '            'Creacion de Articulo
    '            '///////////////////////////////////////////////////////////////////
    '            '///////////////////////////////////////////////////////////////////
    '            If BuscaIdArticulo(wh.Cells(CurrentRow, "F")) = -1 Then
    '                oArt = Aplicacion.Articulos.Item(-1)
    '                With oArt
    '                    With .Registro
    '                        If wh.Cells(CurrentRow, "E") <> "" Then
    '                            !Codigo = wh.Cells(CurrentRow, "E")
    '                            !Idtipo = 13
    '                        ElseIf wh.Cells(CurrentRow, "D") <> "" Then
    '                            !Codigo = wh.Cells(CurrentRow, "D")
    '                            !Idtipo = 12
    '                        ElseIf wh.Cells(CurrentRow, "C") <> "" Then
    '                            !Codigo = wh.Cells(CurrentRow, "C")
    '                            !Idtipo = 11
    '                        ElseIf wh.Cells(CurrentRow, "B") <> "" Then
    '                            !Codigo = wh.Cells(CurrentRow, "B")
    '                            !Idtipo = 10
    '                        Else
    '                            Stop
    '                        End If

    '                        !descripcion = wh.Cells(CurrentRow, "F")
    '                        !IdRubro = 2
    '                        !IdSubRubro = 1
    '                    End With
    '                    .Guardar()
    '                End With
    '                oArt = Nothing
    '            Else
    '                'Stop
    '            End If
    '            '///////////////////////////////////////////////////////////////////
    '            '///////////////////////////////////////////////////////////////////
    '        Else
    '            'Stop
    '        End If



    '        CurrentRow = CurrentRow + 1
    '        'txtROW = CurrentRow
    '        If CurrentRow Mod 1000 = 0 Then DoEvents()
    '    End While



    '    wk.Close()
    '    MsgBox("fin")
    'End Sub

End Module




Public Module TEG


    '/////////////////////////////
    'GVA12 - Comprobantes de cuenta corriente
    'GVA53 - Renglones de comprobantes de facturación
    'STA12 - Precios artículos compra / costo
    'GVA08 - Encabezado de Comprobantes de Cotizaciones
    'GVA09 - Renglones de Comprobantes de Cotizaciones
    '/////////////////////////////
    'remitos
    'STA14 - Encabezados de movimientos de stock
    'STA20 - Renglones de movimientos de stock
    'GVA43 - Talonarios
    '/////////////////////////////
    'GVA14 - Clientes
    'CPA01 - Proveedores
    '/////////////////////////////
    'STA11 - Artículos
    'GVA17 - Precios
    'STA22 - Depósitos
    'STA36 - Unidades de medida de compra
    'STA19 - Saldos de Stock
    '/////////////////////////////



    'Private Const cConexionBASE = "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initial Catalog=empresa_ejemplo_3;Data Source=fondo"
    'Private Const cConexionBASE = "Provider=SQLOLEDB.1;Persist Security Info=False;;Trusted_Connection=Yes;Initial Catalog=EK1;Data Source=fondo\SQLEXPRESS"

    'Private fs As New Scripting.FileSystemObject
    'Private f As TextStream

    'Private appExcel As Excel.Application
    'Private wk As Excel.Workbook
    'Private wh As Excel.Worksheet
    'Dim cn As Connection
    'Private CurrentRow As Long







    'Private Sub Articulos()
    '    appExcel =CreateObject("Excel.Application")
    '    wk = appExcel.Workbooks.Open(App.Path & "\doc\precios.xls")
    '    f = fs.CreateTextFile(App.Path & "\articuls.sql", True)
    '    'OpenCN cn, False, "", cConexionBASE             'Abrir conexion
    '    wh = wk.Worksheets(2)


    '    CurrentRow = 2
    '    'While wh.Cells(CurrentRow, 1) <> "FIN"
    '    While CurrentRow < 445
    '        RenglonArticulo()
    '        CurrentRow = CurrentRow + 1
    '        txtROW = CurrentRow
    '        If CurrentRow Mod 1000 = 0 Then DoEvents()
    '    End While


    '    f.Close()
    '    wk.Close()
    '    MsgBox("fin")
    'End Sub




    'Private Sub RenglonArticulo()
    '    On Error Resume Next
    '    Dim RazonSocial As String, _
    '        Direccion As String, _
    '        rsSplit() As String, dirSplit() As String, _
    '        Query As New CQuery, _
    '        i As Long

    '    Dim ra As Long


    '    '//////////////////////////////////////////////////////////////////////////////
    '    'Articulos

    '    Dim cod As String
    '    cod = wh.Cells(CurrentRow, 2) & wh.Cells(CurrentRow, 3) & wh.Cells(CurrentRow, 4) & wh.Cells(CurrentRow, 5) & wh.Cells(CurrentRow, 6) & wh.Cells(CurrentRow, 7)

    '    Dim s As String
    '    With Query
    '        .ClearAll()
    '        .TABLE = "STA11"

    '        .SetF("COD_ARTICU") = cod
    '        .SetF("DESCRIPCIO") = Left(wh.Cells(CurrentRow, 1), 30)
    '        .SetF("DESC_ADIC") = Mid(wh.Cells(CurrentRow, 1), 31, 20)


    '        .SetF("COD_IVA") = 1
    '        .SetF("COD_S_IVA") = 11
    '        .SetF("COD_II") = 21
    '        .SetF("COD_S_II") = 41

    '        .SetF("COD_ACTIVI") = 1
    '        .SetF("CL_SIAP_CP") = "SIN"
    '        .SetF("CL_SIAP_GV") = "V1"

    '        .SetF("COD_II_CO") = 40
    '        .SetF("COD_IVA_CO") = 1

    '        .SetF("USA_ESC") = "N"
    '        .SetF("UNIDAD_MED") = "UNI"
    '        .SetF("UNIDAD_VE") = "UNI"


    '        'pendiente!!!
    '        'Clasificar a todos los productos como de venta.
    '        'Todos los productos deben llevar stock asociado.

    '        .SetF("STOCK") = 1

    '    End With
    '    s = Query.InsertQuery

    '    'Debug.Print Query.InsertQuery
    '    If InStr(1, s, "NULL") Then
    '        Err.Raise(1111)
    '    End If

    '    If Len(cod) <> 15 Then
    '        Err.Raise(1111)
    '    End If

    '    'f.WriteLine s


    '    '//////////////////////////////////////////////////////////////////////////////
    '    'Listas de precios

    '    With Query
    '        .ClearAll()
    '        .TABLE = "GVA17"


    '        .SetF("COD_ARTICU") = cod
    '        .SetF("NRO_DE_LIS") = 1
    '        .SetF("PRECIO") = wh.Cells(CurrentRow, 8)
    '     .SetF("FECHA_MODI") = Date
    '    End With

    '    s = Query.InsertQuery

    '    'Debug.Print Query.InsertQuery
    '    If InStr(1, s, "NULL") Then
    '        Debug.Print(s)
    '        'Err.Raise 1111
    '    End If
    '    'cn.Execute Query.InsertQuery, ra, adCmdText
    '    f.WriteLine(s)


    '    '///////////////////////



    '    With Query
    '        .ClearAll()
    '        .TABLE = "GVA17"


    '        .SetF("PRECIO") = wh.Cells(CurrentRow, 9)
    '     .SetF("FECHA_MODI") = Date

    '        .WHERE = "COD_ARTICU = '" & cod & "'" & " AND NRO_DE_LIS=" & 1
    '    End With

    '    s = Query.UpdateQuery

    '    'Debug.Print Query.InsertQuery
    '    If InStr(1, s, "NULL") Then
    '        Debug.Print(s)
    '        'Err.Raise 1111
    '    End If
    '    'cn.Execute Query.InsertQuery, ra, adCmdText
    '    f.WriteLine(s)


    '    '///////////////////////


    '    With Query
    '        .ClearAll()
    '        .TABLE = "GVA17"


    '        .SetF("COD_ARTICU") = cod
    '        .SetF("NRO_DE_LIS") = 2
    '        .SetF("PRECIO") = wh.Cells(CurrentRow, 9)
    '     .SetF("FECHA_MODI") = Date
    '    End With

    '    s = Query.InsertQuery

    '    'Debug.Print Query.InsertQuery
    '    If InStr(1, s, "NULL") Then
    '        Debug.Print(s)
    '        'Err.Raise 1111
    '    End If
    '    'cn.Execute Query.InsertQuery, ra, adCmdText
    '    f.WriteLine(s)


    '    '///////////////////////



    '    With Query
    '        .ClearAll()
    '        .TABLE = "GVA17"


    '        .SetF("PRECIO") = wh.Cells(CurrentRow, 9)
    '     .SetF("FECHA_MODI") = Date

    '        .WHERE = "COD_ARTICU = '" & cod & "'" & " AND NRO_DE_LIS=" & 2
    '    End With

    '    s = Query.UpdateQuery

    '    'Debug.Print Query.InsertQuery
    '    If InStr(1, s, "NULL") Then
    '        Debug.Print(s)
    '        'Err.Raise 1111
    '    End If
    '    'cn.Execute Query.InsertQuery, ra, adCmdText
    '    f.WriteLine(s)



    '    '//////////////////////////////////////////////////////////////////////////////
    '    'Unidades de medida

    '    With Query
    '        .ClearAll()
    '        .TABLE = "STA36"


    '        .SetF("COD_ARTICU") = cod
    '        .SetF("COD_PRE_CO") = "UC"
    '        .SetF("EQUIVALENC") = 1
    '        .SetF("PRE_HABIT") = "S"
    '        .SetF("UNIDAD_M_C") = "UNI"
    '    End With

    '    s = Query.InsertQuery

    '    'Debug.Print Query.InsertQuery
    '    If InStr(1, s, "NULL") Then
    '        Debug.Print(s)
    '        'Err.Raise 1111
    '    End If
    '    'cn.Execute Query.InsertQuery, ra, adCmdText
    '    'f.WriteLine s


    'End Sub


    ''//////////////////////////////////////////////////////////////////////////////
    ''//////////////////////////////////////////////////////////////////////////////
    ''//////////////////////////////////////////////////////////////////////////////



    'Private Sub Clientes()
    '    appExcel =CreateObject("Excel.Application")
    '    wk = appExcel.Workbooks.Open(App.Path & "\doc\clientes.xls")
    '    f = fs.CreateTextFile(App.Path & "\clientes.sql", True)
    '    'OpenCN cn, False, "", cConexionBASE             'Abrir conexion
    '    wh = wk.Worksheets(1)


    '    CurrentRow = 2
    '    'While wh.Cells(CurrentRow, 1) <> "FIN"
    '    While CurrentRow < 874
    '        RenglonCliente()
    '        CurrentRow = CurrentRow + 1
    '        txtROW = CurrentRow
    '        If CurrentRow Mod 1000 = 0 Then DoEvents()
    '    End While


    '    f.Close()
    '    wk.Close()
    '    MsgBox("fin")
    'End Sub




End Module

*/