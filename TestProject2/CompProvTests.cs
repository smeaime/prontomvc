using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.VisualStudio.TestTools.UnitTesting.Web;
using System.Linq;
using System.Linq.Dynamic;
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
        public void ProbarGrabacionDelServicioDeComprobanteProveedor()
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

    }
}