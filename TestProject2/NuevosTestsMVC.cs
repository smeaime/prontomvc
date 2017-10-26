#region MyRegion        

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
using MVCent = ProntoMVC.Data.Models;
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

using System.Configuration;

using OfficeOpenXml; //EPPLUS, no confundir con el OOXML


using ProntoMVC.ViewModels;

using System.Transactions;
using ProntoFlexicapture;

using System.IO;




//test de java lopez
// https://github.com/ajlopez/TddAppAspNetMvc/blob/master/Src/MyLibrary.Web.Tests/Controllers/HomeControllerTests.cs

namespace ProntoMVC.TestsMVC
{




    using System.Web.Mvc;
    using Microsoft.VisualStudio.TestTools.UnitTesting;







    [TestClass]
    public class TestsBasicos
    {

        //const string scbdlmaster =
        //          @"metadata=res://*/Models.bdlmaster.csdl|res://*/Models.bdlmaster.ssdl|res://*/Models.bdlmaster.msl;provider=System.Data.SqlClient;provider connection string=""data source=SERVERSQL3\TESTING;initial catalog=BDLMaster;user id=sa;password=.SistemaPronto.;multipleactiveresultsets=True;connect timeout=8;application name=EntityFramework""";

        //const string scEF = "metadata=res://*/Models.Pronto.csdl|res://*/Models.Pronto.ssdl|res://*/Models.Pronto.msl;provider=System.Data.SqlClient;provider connection string='data source=SERVERSQL3\\TESTING;initial catalog=DemoProntoWeb;User ID=sa;Password=.SistemaPronto.;multipleactiveresultsets=True;App=EntityFramework'";


        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 

        //const string nombreempresa = "DemoProntoWeb";
        const string nombreempresa = "VialAgro";
        //const string nombreempresa = "Pronto_Alemarsa";
        //const string nombreempresa = "Williams2";
        //const string nombreempresa = "Pronto";

        //const string usuario = "administrador";
        const string usuario = "supervisor";
        //string bldmasterappconfig = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
        string bldmasterappconfig; //  = "Data Source=SERVERSQL3\\TESTING;Initial catalog=BDLMaster;User ID=sa; Password=.SistemaPronto.;Connect Timeout=8";
        string scEF;
        string scSQL;
        string DirApp;
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 



        //http://stackoverflow.com/questions/334515/do-you-use-testinitialize-or-the-test-class-constructor-to-prepare-each-test-an
        [TestInitialize]
        public void Initialize()
        {
            string bldmastersql = System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
            bldmasterappconfig = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(bldmastersql);

            var orig = Generales.conexPorEmpresa(nombreempresa, bldmasterappconfig, usuario, true);
            scSQL = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(orig);
            scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(orig);

            DirApp = ConfigurationManager.AppSettings["AplicacionConImagenes"];

        }





        /// <summary>
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////




        [TestMethod]
        public void mail_de_error()
        {

            Pronto.ERP.Bll.EntidadManager.MandaEmail_Nuevo(ConfigurationManager.AppSettings["ErrorMail"],
                               "asuntoasuntoasunto ",
                            "cuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpo cuerpocuerpocuerpocuerpo",
                            ConfigurationManager.AppSettings["SmtpUser"],
                            ConfigurationManager.AppSettings["SmtpServer"],
                            ConfigurationManager.AppSettings["SmtpUser"],
                            ConfigurationManager.AppSettings["SmtpPass"],
                              "",
                           Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));
        }




        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// </summary>

        #endregion




        [TestMethod]
        public void webapi()
        {

            var c = new ClienteAPIController();
            //GetMockedControllerGenerico(c);

            var j= c.GetAllClientes();
        }






        [TestMethod]
        public void pend_24848()
        {
            // como puedo crear una RM para que aparezca en el "RMs Pendientes de Asignar"?

            var c = new RequerimientoController();
            GetMockedControllerGenerico(c);



            Requerimiento rm = new Requerimiento();
            var rmdet = new ProntoMVC.Data.Models.DetalleRequerimiento();
            rm.Aprobo = 700;
            rm.IdObra = 1;
            rmdet.IdArticulo = 5128;
            rmdet.Cantidad = 12;
            rmdet.IdUnidad = 33;
            rmdet.NumeroItem = 1;
            rmdet.OrigenDescripcion = 1;
            rmdet.IdControlCalidad = 1;
            rmdet.FechaEntrega = DateTime.Today;
            rm.DetalleRequerimientos.Add(rmdet);
            rm.DetalleRequerimientos.Add(new MVCent.DetalleRequerimiento { IdArticulo = 11, Cantidad = 3255 });
            JsonResult result = c.BatchUpdate(rm);





            JsonResult result2 = (JsonResult)c.RequerimientosPendientesAsignar_DynamicGridData("NumeroRequerimiento", "desc", 0, 50, false, "", "", "", "");
            jqGridJson listado = (jqGridJson)result2.Data;

            //habria problemas con los TipoDesignacion del detalle no? -si






            Assert.IsTrue(listado.records > 0);

        }





        [TestMethod]
        public void usuariosdecompras_46429()
        {

            // CargarEmpleadosParaAprobar() en pronto.js;
            // CargarEmpleadosParaAprobar_Compras
            //    Empleado / EmpleadosParaComboSectorCompras
            // hay que volver a llenar el combo del popup
        }



        [TestMethod]
        public void traerdatos()
        {
            var IdProveedor = -1;
            var pendiente = "S";
            Pronto.ERP.Bll.EntidadManager.TraerDatos2(scSQL, "CtasCtesA_TXPorTrs", IdProveedor, -1, DateTime.Now, null, null, pendiente);
            // exec CtasCtesA_TXPorTrs -1, -1, null, null, null, 'S'
        }









        [TestMethod]
        public void testenviomailsdeniro_41340()
        {
            DemoProntoEntities db = new DemoProntoEntities(scEF);
            BDLMasterEntities dbmaster = new BDLMasterEntities(Auxiliares.FormatearConexParaEntityFrameworkBDLMASTER_2(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(bldmasterappconfig)));


            // verificar q el cuit de la op esta como usuario
            var opid = 11;
            var marianoguid = new Guid("920688E1-7E8F-4DA7-A793-9D0DAC7968E6");
            var mail = "mscalella911@gmail.com";

            var op = db.OrdenesPago.Find(opid);
            var cuitproveedor = op.Proveedore.Cuit.Replace(" ", "").Replace("-", "");
            var marianoext = dbmaster.UserDatosExtendidos.Where(x => x.UserId == marianoguid).FirstOrDefault();
            var marianouser = dbmaster.aspnet_Membership.Where(x => x.UserId == marianoguid).FirstOrDefault();
            marianoext.RazonSocial = cuitproveedor;
            marianouser.Email = mail;
            dbmaster.SaveChanges();



            db.ColaCorreosComprobantes.Add(new ColaCorreosComprobante
            {
                IdComprobante = opid,
                IdTipoComprobante = 17 // orden de pago
            });
            db.ColaCorreosComprobantes.Add(new ColaCorreosComprobante
            {
                IdComprobante = opid,
                IdTipoComprobante = 17 // orden de pago
            });

            db.SaveChanges();

            var s = new ProntoWindowsService.Service1();

            //ProntoWindowsService.Service1.DoWorkEnvioCorreos();
            ProntoWindowsService.Service1.TandaCorreos(scEF, bldmasterappconfig, "12345678");


        }




        [TestMethod]
        public void testdecompras()
        {


            //Sub TestCompras_CP3_OP_Equimac(ByVal Yo As Object, ByVal scEF As String, ByRef Session As Object)
            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////
            //    'DEMO CON CERTIFICACIONES

            //    'resumen:
            //    'CTACTE: revisas
            //    'OC: me piden una autopista y una docena de planchuelas
            //    'FAC 1: anticipo de la autopista
            //    'REC 1: me pagan el anticipo?
            //    'REM 1: le mando media docena de las planchuelas (la autopista no)
            //    'FAC 2: contrato por las planchuelas -y esto incluye recibo? -NO ES AL CONTADO. El recibo se hace aparte. 
            //    'REC 2: me pagan las planchuelas?
            //    'FAC 3: con devolucion de anticipo. 1er tramo de la autopista 
            //    'REC 3: pagan la FAC 3
            //    'CONSULTA Clientes-Desarrollo de Items de OC: ves los anticipos
            //    'FAC 4, terminan rapidamente la autopista.
            //    'REC 4: pagan la FAC
            //    'CTACTE: revisas
            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////

            //    Dim myCP As ComprobanteProveedor
            //    Dim myDetCP As ComprobanteProveedorItem


            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////



            //    myCP = New ComprobanteProveedor
            //    With myCP


            //        '.IdCliente = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", scEF)
            //        '.PuntoVenta = 1
            //        .IdMoneda = 1
            //        .NumeroComprobante1 = Rnd(1000)
            //        .NumeroComprobante2 = Rnd(100000)
            //        .CotizacionMoneda = 1



            //        .IdTipoComprobante = BuscaIdTipoComprobantePreciso("Factura compra", scEF)
            //        If.IdTipoComprobante = -1 Then Stop

            //        '.Fecha = Now
            //        .FechaComprobante = Now
            //        .FechaIngreso = Now
            //        .FechaVencimiento = Now
            //        .FechaRecepcion = Now
            //        .Confirmado = "SI"
            //        '.FechaAprobacion = Now
            //        '.FechaNotaCredito = Now

            //        '.Detalle = "Esta solicitud fue creada para Demo de Web"

            //        .Observaciones = "Solicitud para Demo de Web"
            //        '.IdComprador = 3 'IdUsuarioEnProntoVB6()





            //        myDetCP = New ComprobanteProveedorItem
            //        With myDetCP
            //            .Nuevo = True
            //            .IdCuenta = BuscaIdConceptoPreciso("Instalación y Mantenimiento de Obra 1022892", scEF)
            //            .Importe = 542.11
            //            '.IdConcepto = BuscaIdConceptoPreciso("Ajuste", scEF)
            //            '.Gravado = "SI"
            //            '.IdCaja = 2
            //            '.ImporteTotalItem = 232
            //        End With

            //        .Detalles.Add(myDetCP)
            //        myDetCP = Nothing






            //    End With

            //    ComprobanteProveedorManager.Save(scEF, myCP)
            //    myCP = Nothing

            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////

            //    '//////////////////////////////////////////////////
            //    'Alta de Orden de Pago para asignar un monto tope a la cuenta de fondo fijo (ver manual)
            //    '//////////////////////////////////////////////////
            //    '//////////////////////////////////////////////////


            //    Dim myOP As OrdenPago
            //    Dim myDetOP As OrdenPagoItem
            //    Dim myDetOPvalor As OrdenPagoValoresItem
            //    Dim myDetOPcuenta As OrdenPagoCuentasItem
            //    Dim myDetOPrubro As OrdenPagoRubrosContablesItem
            //    Dim myDetOPimpuest As OrdenPagoImpuestosItem
            //    Dim myDetOPanticipo As OrdenPagoAnticiposAlPersonalItem



            //    myOP = New OrdenPago
            //    With myOP

            //        .IdProveedor = BuscaIdCliente("CAMINO DEL ATLANTICO S.A. CONCESIONARIA VIAL", scEF)
            //        .IdMoneda = 1
            //        '.PuntoVenta = 1
            //        .NumeroOrdenPago = Rnd() * 100000
            //        .CotizacionMoneda = 4
            //        .FechaIngreso = Now
            //        .FechaOrdenPago = Now
            //        '.FechaRecibo = Now
            //        .Observaciones = "OrdenPago para Demo de Web"



            //        myDetOP = New OrdenPagoItem
            //        With myDetOP
            //            .Nuevo = True
            //            .IdImputacion = 100 'BuscaIdComprobante("FACTURA 10110-2136464", scEF)
            //            .Importe = 215.48
            //        End With
            //        .DetallesImputaciones.Add(myDetOP)


            //        myDetOPvalor = New OrdenPagoValoresItem
            //        With myDetOPvalor
            //            .Nuevo = True
            //            .IdTipoValor = 6
            //            .FechaVencimiento = #1/1/2050#
            //            .IdBanco = 1
            //            .NumeroInterno = Int(Rnd() * 1000000)
            //            .NumeroValor = Int(Rnd() * 1000000)
            //            .Importe = 215.48
            //        End With
            //        .DetallesValores.Add(myDetOPvalor)


            //        myDetOPimpuest = New OrdenPagoImpuestosItem
            //        With myDetOPimpuest
            //            .Nuevo = True
            //            '.IdImtacion = 100 'BuscaIdComprobante("FACTURA 10110-2136464", scEF)
            //            '.Importe = 215.48
            //        End With
            //        .DetallesImpuestos.Add(myDetOPimpuest)


            //        myDetOPrubro = New OrdenPagoRubrosContablesItem
            //        With myDetOPrubro
            //            .Nuevo = True
            //            .IdRubroContable = 100 'BuscaIdComprobante("FACTURA 10110-2136464", scEF)
            //            .Importe = 215.48
            //        End With
            //        .DetallesRubrosContables.Add(myDetOPrubro)


            //        myDetOPanticipo = New OrdenPagoAnticiposAlPersonalItem
            //        With myDetOPanticipo
            //            .Nuevo = True
            //            '.IdImputacion = 100 'BuscaIdComprobante("FACTURA 10110-2136464", scEF)
            //            '.Importe = 215.48
            //        End With
            //        .DetallesAnticiposAlPersonal.Add(myDetOPanticipo)


            //        myDetOPcuenta = New OrdenPagoCuentasItem
            //        With myDetOPcuenta
            //            .Nuevo = True
            //            .IdCuenta = 100 'BuscaIdComprobante("FACTURA 10110-2136464", scEF)
            //            '.Importe = 215.48
            //        End With
            //        .DetallesCuentas.Add(myDetOPcuenta)




            //    End With


            //    'OrdenPagoManager.Save(scEF, myOP)



            //    '//////////////////////////////////////////////////

            //End Sub

        }





        [TestMethod]
        public void probar_context_de_Pedidos()
        {

            var c = new PedidoController();
            GetMockedControllerGenerico(c);

            //c.GenerarEnWord((new int[] { 48858 }).ToList(), "administrador", "");
            //c.BorradorWord((new int[] { 48858 }).ToList(), "administrador", "");
            //c.MarcarComoImpresa((new int[] { 48858 }).ToList(), "administrador", "");
            //c.DesmarcarComoImpresa((new int[] { 48858 }).ToList(), "administrador", "");
            //c.RegistrarSalidaDelPedido((new int[] { 48858 }).ToList(), "administrador", "");

        }


        [TestMethod]
        public void probar_context_de_rms()
        {

            var c = new RequerimientoController();
            GetMockedControllerGenerico(c);

            //c.AsignaComprador((new int[] { 48858 }).ToList(), "administrador", "");
            //c.MarcarComoImpresa((new int[] { 48858 }).ToList(), "administrador", "");
            //c.DesmarcarComoImpresa((new int[] { 48858 }).ToList(), "administrador", "");
            //c.EnviarAProveedoresPorCorreo((new int[] { 48858 }).ToList(), "administrador", "");
            //c.EnviarAProveedoresPorFax((new int[] { 48858 }).ToList(), "administrador", "");


        }




        [TestMethod]
        public void CircuitoDeCompras()
        {


            // hago un RM por 
            // RMsPEND: en la grilla de RM pendientes le asigno un 
            // 3 COTIZ: el empleado toma el RM y pide presupuestos a 3 proveedores
            // COMP:  el empleado hace la comparativa
            // PED:  hay un ganador, hago el pedido


            var cRM = new RequerimientoController();
            var cPED = new PedidoController();
            var cCOMP = new ComparativaController();
            var cPRES = new PresupuestoController();
            var cOP = new OrdenPagoController();
            var cCP = new ComprobanteProveedorController();
            var cRECEP = new RecepcionController();
            GetMockedControllerGenerico(cRM);
            GetMockedControllerGenerico(cPRES);
            GetMockedControllerGenerico(cCOMP);
            GetMockedControllerGenerico(cPED);
            DemoProntoEntities db = new DemoProntoEntities(scEF);





            Requerimiento rm = new Requerimiento();
            var rmdet = new ProntoMVC.Data.Models.DetalleRequerimiento();
            rmdet.IdArticulo = 12;
            rmdet.Cantidad = 230;
            rm.DetalleRequerimientos.Add(rmdet);
            rm.DetalleRequerimientos.Add(new MVCent.DetalleRequerimiento { IdArticulo = 11, Cantidad = 3255 });
            JsonResult result = cRM.BatchUpdate(rm);
            //Console.WriteLine(result.Data);


            cRM.AsignaComprador((new int[] { rm.IdRequerimiento }).ToList(), "administrador", "");







            Presupuesto pre = new Presupuesto();
            var predet = new ProntoMVC.Data.Models.DetallePresupuesto();
            predet.IdArticulo = 12;
            predet.Cantidad = 230;
            pre.DetallePresupuestos.Add(predet);
            pre.DetallePresupuestos.Add(new MVCent.DetallePresupuesto { IdArticulo = 11, Cantidad = 3255 });
            JsonResult resultpre = cPRES.BatchUpdate(pre);







            Comparativa comp = new Comparativa();
            comp.DetalleComparativas.Add(new MVCent.DetalleComparativa { IdPresupuesto = 22, Cantidad = 3255 });
            JsonResult resultcomp = cCOMP.BatchUpdate(comp);







            Pedido ped = new Pedido();

            var peddet = new ProntoMVC.Data.Models.DetallePedido();
            peddet.IdArticulo = 12;
            peddet.Cantidad = 230;
            ped.DetallePedidos.Add(peddet);
            ped.DetallePedidos.Add(new MVCent.DetallePedido { IdArticulo = 11, Cantidad = 3255 });

            JsonResult result2 = cPED.BatchUpdate(ped);
            //Console.WriteLine(result2.Data.Message);







            cRM.DarPorCumplido((new int[] { 48631 }).ToList(), "administrador", "", "administrador", "observacion de cumplido");








            OrdenPago op = new OrdenPago();
            op.DetalleOrdenesPagoes.Add(new MVCent.DetalleOrdenesPago { IdImputacion = 11, Importe = 3255 });
            JsonResult resultop = cOP.BatchUpdate(op);




            Recepcione recep = new Recepcione();
            recep.DetalleRecepciones.Add(new MVCent.DetalleRecepcione { IdArticulo = 11, Cantidad = 3255 });
            JsonResult resultorecep = cRECEP.BatchUpdate(recep);



            ViewModelComprobanteProveedor cp = new ViewModelComprobanteProveedor();
            cp.DetalleComprobantesProveedores.Add(new MVCent.DetalleComprobantesProveedore { IdArticulo = 11, Cantidad = 3255 });
            JsonResult resultocp = cCP.BatchUpdate(cp);



            // Assert.AreEqual(expected, actual);

        }











        [TestMethod]
        public void EditPresupuestoObraMoq_2()
        {

            //        Dim oRs As ADOR.Recordset
            //Set oRs = Aplicacion.PresupuestoObrasNodos.TraerTodos
            //If oRs.RecordCount = 0 Then Aplicacion.Tarea "PresupuestoObrasNodos_Inicializar"
            //oRs.Close

            //Set DataCombo1(0).RowSource = Aplicacion.Obras.TraerFiltrado("_TodasParaCombo")
            //CargarArbol
            //CargarArbolOpciones

            //CambiarLenguaje Me, "esp", glbIdiomaActual

            //ConfiguraGrilla
            //MostrarNodo (0)




            //     cargararbol

            //         configuraGrilla

            //     MostrarNodo (mIdPresupuestoObrasNodo)


            var c = new PresupuestoObraController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();


            //var result = c.CargarArbol();


            int nodo = 0;
            string sidx = "NumeroPedido";
            string sord = "desc";
            int page = 1;
            int rows = 100;
            bool _search = false;
            string filters = "";

            var result2 = c.LlenarGrilla(sidx, sord, page, rows, _search, filters, nodo);



        }



        [TestMethod]
        public void PresupuestoObra_CargarArbol()
        {

            var c = new PresupuestoObraController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            int IdObra = 77;

            //var f = new FormCollection();
            //collection["idsOfExpandedRows"]
            //    collection["nodeid"]
            var result2 = c.CargarArbol_PresupuestoObra_ParaGrillaNoTreeviewEnLocalStorage(IdObra);

        }








        [TestMethod]
        public void probar_context_del_rms_pendientesGenerarValesAlmacen()
        {

            // a veces no desaparecen desde web. desaparecen si lo hago desde el prontovb6?

            var c = new RequerimientoController();
            GetMockedControllerGenerico(c);

            c.GenerarValesAlmacen((new int[] { 48862 }).ToList(), "administrador", "");
        }








        [TestMethod]
        public void probar_context_del_rms_pendientesAsignaComprador()
        {

            var c = new RequerimientoController();
            GetMockedControllerGenerico(c);

            c.AsignaComprador((new int[] { 48858 }).ToList(), "administrador", "");
        }









        [TestMethod]
        public void probar_context_del_rms_pendientesDarPorCumplido()
        {

            var c = new RequerimientoController();
            GetMockedControllerGenerico(c);

            c.DarPorCumplido((new int[] { 48631 }).ToList(), "administrador", "", "administrador", "observacion de cumplido");
        }




        [TestMethod]
        public void probar_context_del_rms_pendientes()
        {

            var c = new RequerimientoController();
            GetMockedControllerGenerico(c);


            c.DarPorCumplido((new int[] { 1, 2, 3 }).ToList(), "administrador", "", "administrador", "observacion de cumplido");

            c.GenerarValesAlmacen((new int[] { 48631 }).ToList(), "administrador", "");
            c.AsignaComprador((new int[] { 1, 2, 3 }).ToList(), "administrador", "");
        }





        [TestMethod]
        public void probar_circuito_externo()
        {

            string sidx = "NumeroPedido";
            string sord = "desc";
            int page = 1;
            int rows = 100;
            bool _search = false;
            string filters = "";

            // crear un extadmin
            // y q este cree sus usuarios 

            var c = new RequerimientoController();
            GetMockedControllerGenerico(c);
            List<int> myValues = new List<int>(new int[] { 1, 2, 3 });
            string o = "lala.xlsx";


            //ExternoCuentaCorrienteCliente",
            //                                        "ExternoCuentaCorrienteProveedor",
            //                                        "ExternoOrdenesPagoListas",
            //                                        "ExternoPresupuestos

        }





        [TestMethod]
        public void informeResumnenPosicionFinanciera_usandoVBA_24897()
        {

            string sidx = "NumeroPedido";
            string sord = "desc";
            int page = 1;
            int rows = 100;
            bool _search = false;


            //ojo q en williams ya estoy usando xml para la factura. Esto es codigo obsoleto. Y ademas lo que quiero es sacar un excel, no un word
            //string p = DirApp() & "\Documentos\" & "Factura_Williams.dot"
            //output = ImprimirWordDOTyGenerarTambienTXT(p, Me, HFSC.Value, Session, Response, IdFactura, mvarClausula, mPrinter, mCopias, 

            string o = "lala.xlsx";


            System.Diagnostics.Process.Start(o);
        }



        [TestMethod]
        public void GenerarValesAlmacen_24848()
        {

            string sidx = "NumeroPedido";
            string sord = "desc";
            int page = 1;
            int rows = 100;
            bool _search = false;
            string filters = "";


            var c = new RequerimientoController();
            GetMockedControllerGenerico(c);
            //var f = c.GenerarValesAlmacen(new int[] {15,16,17});
            string o = "lala.xlsx";

        }







        [TestMethod]
        public void Exportacion_a_Excel_de_Entities_3()
        {

            string sidx = "NumeroPedido";
            string sord = "desc";
            int page = 1;
            int rows = 100;
            bool _search = false;
            string filters = "";


            var c = new FacturaController();
            GetMockedControllerGenerico(c);
            var f = c.TT_DynamicGridData_ExcelExportacion(sidx, sord, page, rows, _search, filters, "", "");
            string o = "lala.xlsx";

            // formatear el excel con encabezados, ancho de columna y totales...
            // http://stackoverflow.com/questions/10501528/openxml-libraries-alternatives-to-closedxml
            // http://stackoverflow.com/questions/10501528/openxml-libraries-alternatives-to-closedxml
            // http://stackoverflow.com/questions/10501528/openxml-libraries-alternatives-to-closedxml
            // http://stackoverflow.com/questions/10501528/openxml-libraries-alternatives-to-closedxml


            ToFile(f, o);
            FormatearConEPPLUS(o);


            System.Diagnostics.Process.Start(o);
        }



        void FormatearConEPPLUS(string archivo)
        {
            //http://fourleafit.wikispaces.com/EPPlus


            using (var package = new ExcelPackage(new FileInfo(archivo)))
            {
                //var ws = package.Workbook.Worksheets.SingleOrDefault(x => x.Name == "Test Grid");
                //if (wk != null) { package.Workbook.Worksheets.Delete(wk); }



                //ws.View.ShowGridLines = true;

                //ws.Column(4).OutlineLevel = 1;
                //ws.Column(4).Collapsed = true;
                //ws.Column(5).OutlineLevel = 1;
                //ws.Column(5).Collapsed = true;
                //ws.OutLineSummaryRight = true;

                //Headers
                //ws.Cells["B1"].Value = "Name";
                //ws.Cells["C1"].Value = "Size";
                //ws.Cells["D1"].Value = "Created";
                //ws.Cells["E1"].Value = "Last modified";
                //ws.Cells["B1:E1"].Style.Font.Bold = true;

                // calculate all formulas in the workbook
                //package.Workbook.Calculate();
                //// calculate one worksheet
                //package.Workbook.Worksheets["Test Grid"].Calculate();
                //// calculate a range
                //package.Workbook.Worksheets["Test Grid"].Cells["A1"].Calculate();


                //Create the worksheet
                //Dim ws As ExcelWorksheet = pck.Workbook.Worksheets.Add("Accounts")
                //Load the datatable into the sheet, starting from cell A1. Print the column names on row 1
                //ws.Cells("A1").LoadFromDataTable(pDataTable, True);
                // package.Save();


            }

        }



        public void ToFile(FileResult fileResult, string fileName)
        {
            if (fileResult is FileContentResult)
            {
                File.WriteAllBytes(fileName, ((FileContentResult)fileResult).FileContents);
            }
            else if (fileResult is FilePathResult)
            {
                File.Copy(((FilePathResult)fileResult).FileName, fileName, true); //overwrite file if it already exists
            }
            else if (fileResult is FileStreamResult)
            {
                //from http://stackoverflow.com/questions/411592/how-do-i-save-a-stream-to-a-file-in-c
                using (var fileStream = File.Create(fileName))
                {
                    var fileStreamResult = (FileStreamResult)fileResult;
                    fileStreamResult.FileStream.Seek(0, SeekOrigin.Begin);
                    fileStreamResult.FileStream.CopyTo(fileStream);
                    fileStreamResult.FileStream.Seek(0, SeekOrigin.Begin); //reset position to beginning. If there's any chance the FileResult will be used by a future method, this will ensure it gets left in a usable state - Suggestion by Steven Liekens
                }
            }
            else
            {
                throw new ArgumentException("Unsupported FileResult type");
            }
        }



        [TestMethod]
        public void Exportacion_a_Excel_de_Entities_2()
        {

            // la idea seria llamar a la funcion filtrador pero sin paginar, o diciendolo de
            // otro modo, pasandole como maxrows un numero grandisimo
            // http://stackoverflow.com/questions/8227898/export-jqgrid-filtered-data-as-excel-or-csv
            // I would recommend you to implement export of data on the server and just post the current searching filter to the back-end. Full information about the searching parameter defines postData parameter of jqGrid. Another boolean parameter of jqGrid search define whether the searching filter should be applied of not. You should better ignore _search property of postData parameter and use search parameter of jqGrid.

            // http://stackoverflow.com/questions/9339792/jqgrid-ef-mvc-how-to-export-in-excel-which-method-you-suggest?noredirect=1&lq=1



            string sidx = "NumeroPedido";
            string sord = "desc";
            int page = 1;
            int rows = 99999999;
            bool _search = false;
            string filters = "";


            DemoProntoEntities db = new DemoProntoEntities(scEF);



            //llamo directo a FiltroGenerico o a Pedidos_DynamicGridData??? -y, filtroGenerico no va a incluir las columnas recalculadas!!!!
            // Cuanto tarda ExportToExcelEntityCollection en crear el excel de un FiltroGenerico de toda la tabla de Pedidos?


            IQueryable<Data.Models.Factura> q = (from a in db.Facturas select a).AsQueryable();


            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;

            List<Data.Models.Factura> pagedQuery =
                    Filters.FiltroGenerico_UsandoIQueryable<Data.Models.Factura>(sidx, sord, page, rows, _search, filters, db, ref totalRecords, q);

            JsonResult result;

            if (true)
            {
                var c = new FacturaController();
                GetMockedControllerGenerico(c);
                result = (JsonResult)c.TT_DynamicGridData(sidx, sord, page, rows, _search, filters, "", "");

                // cómo convertir el JsonResult (o mejor dicho, un array de strings)  en un excel?
            }

            string output = "c:\\adasdasd.xls";

            List<string[]> lista = new List<string[]>();

            jqGridJson listado = (jqGridJson)result.Data;


            for (int n = 0; n < listado.rows.Count(); n++)
            {
                string[] renglon = listado.rows[n].cell;
                lista.Add(renglon);
            }



            var excelData = new jqGridWeb.DataForExcel(
                    // column Header
                    new[] { "Col1", "Col2", "Col3" },
                    new[]{jqGridWeb.DataForExcel.DataType.String, jqGridWeb.DataForExcel.DataType.Integer,
                          jqGridWeb.DataForExcel.DataType.String},
                    //      new List<string[]> {
                    //    new[] {"a", "1", "c1"},
                    //    new[] {"a", "2", "c2"}
                    //},
                    lista,


                    "Test Grid");
            Stream stream = new FileStream(output, FileMode.Create);
            excelData.CreateXlsxAndFillData(stream);
            stream.Close();



            List<Data.Models.Factura> control = pagedQuery.ToList();


            if (false)
            {
                FuncionesCSharpBLL.ExportToExcelEntityCollection<Data.Models.Factura>(control, output);
            }

            System.Diagnostics.Process.Start(output);
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
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            Pedido Pedido = db.Pedidos.OrderByDescending(x => x.IdPedido).First();

            var c = new PedidoController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(Pedido);

            // Assert.AreEqual(expected, actual);

        }

        [TestMethod]
        public void GrabaRequerimientoMoq()
        {
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            Requerimiento o = db.Requerimientos.OrderByDescending(x => x.IdRequerimiento).First();

            var c = new RequerimientoController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(o);

            // Assert.AreEqual(expected, actual);

        }

        [TestMethod]
        public void GrabaPresupuestoMoq()
        {
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            Presupuesto o = db.Presupuestos.OrderByDescending(x => x.IdPresupuesto).First();

            var c = new PresupuestoController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(o);

            // Assert.AreEqual(expected, actual);

        }

        [TestMethod]
        public void GrabaComparativaMoq()
        {
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            Comparativa o = db.Comparativas.OrderByDescending(x => x.IdComparativa).First();

            var c = new ComparativaController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(o);

            // Assert.AreEqual(expected, actual);

        }

        [TestMethod]
        public void GrabaComprobanteProveedorMoq()
        {
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            ComprobanteProveedor o = db.ComprobantesProveedor.OrderByDescending(x => x.IdComprobanteProveedor).First();



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
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            OrdenPago o = db.OrdenesPago.OrderByDescending(x => x.IdOrdenPago).First();


            var c = new OrdenPagoController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(o);

            // Assert.AreEqual(expected, actual);

        }


        [TestMethod]
        public void GrabaFacturaMoq()
        {
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            Factura o = db.Facturas.OrderByDescending(x => x.IdFactura).First();


            var c = new FacturaController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(o);

            // Assert.AreEqual(expected, actual);
        }


        [TestMethod]
        public void GrabaReciboMoq()
        {
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            Recibo o = db.Recibos.OrderByDescending(x => x.IdRecibo).First();


            var c = new ReciboController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(o);

            // Assert.AreEqual(expected, actual);
            //Assert.AreEqual(result, actual);
        }



        [TestMethod]
        public void GrabaArticuloMoq()
        {

            DemoProntoEntities db = new DemoProntoEntities(scEF);

            Articulo o = db.Articulos.OrderByDescending(x => x.IdArticulo).First();


            var c = new ArticuloController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(o);

            // Assert.AreEqual(expected, actual);
            //Assert.AreEqual(result, actual);
        }


        [TestMethod]
        public void GrabaClienteMoq()
        {

            DemoProntoEntities db = new DemoProntoEntities(scEF);

            Cliente o = db.Clientes.OrderByDescending(x => x.IdCliente).First();


            var c = new ClienteController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(o);

            // Assert.AreEqual(expected, actual);
            //Assert.AreEqual(result, actual);
        }

        [TestMethod]
        public void GrabaProveedorMoq()
        {
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            Proveedor o = db.Proveedores.OrderByDescending(x => x.IdProveedor).First();


            var c = new ProveedorController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(o);

            // Assert.AreEqual(expected, actual);
            //Assert.AreEqual(result, actual);
        }




        [TestMethod]
        public void MaestroPedidoMoq()
        {

            var c = new PedidoController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.Pedidos_DynamicGridData("NumeroPedido", "desc", 0, 50, false, "", "", "");

        }


        [TestMethod]
        public void MaestroRequerimientosMoq()
        {

            var c = new RequerimientoController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.Requerimientos_DynamicGridData("NumeroRequerimiento", "desc", 0, 50, false, "", "", "", "");

        }

        [TestMethod]
        public void MaestroPresupuestosMoq()
        {

            var c = new PresupuestoController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.Presupuestos_DynamicGridData("Numero", "desc", 0, 50, false, "", "", "");

        }


        [TestMethod]
        public void MaestroComparativasMoq()
        {

            var c = new ComparativaController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.Comparativas_DynamicGridData("NumeroComparativa", "desc", 0, 50, false, "", "", "", "");

        }


        [TestMethod]
        public void MaestroClientesMoq()
        {

            var c = new ClienteController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.Clientes_DynamicGridData("RazonSocial", "desc", 0, 50, false, "");

        }


        [TestMethod]
        public void MaestroProveedoresMoq()
        {

            var c = new ProveedorController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.Proveedores_DynamicGridData("RazonSocial", "desc", 1, 50, false, "");

        }


        [TestMethod]
        public void MaestroArticulosMoq()
        {

            var c = new ArticuloController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.Articulos_DynamicGridData("Descripcion", "desc", 1, 50, false, "");

        }




        [TestMethod]
        public void MaestroComprobanteProvMoq()
        {

            var c = new ComprobanteProveedorController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.ComprobantesProveedor_DynamicGridData("NumeroReferencia", "desc", 1, 50, false, "", "", "");

        }





        static public void GetMockedControllerGenerico(ProntoBaseController c)
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




        }



    }




}