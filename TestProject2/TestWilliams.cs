﻿using System;
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


//test de java lopez
// https://github.com/ajlopez/TddAppAspNetMvc/blob/master/Src/MyLibrary.Web.Tests/Controllers/HomeControllerTests.cs

namespace ProntoMVC.Tests
{
    using System.Web.Mvc;
    using Microsoft.VisualStudio.TestTools.UnitTesting;








    [TestClass]
    public class TestsWilliams
    {

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
        string bdlmasterappconfig; //  = "Data Source=SERVERSQL3\\TESTING;Initial catalog=BDLMaster;User ID=sa; Password=.SistemaPronto.;Connect Timeout=8";

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
            //    string bldmastersql = System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
            //    bldmasterappconfig = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(bldmastersql);
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


            bdlmasterappconfig = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);

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


            string[] sincros = { "Beraza" };
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
                                    LogicaImportador.FormatosDeExcel.ReyserAnalisis, SC, Convert.ToInt32( carta.PuntoVenta) , ref log, 
                                    carta.FechaArribo.ToShortDateString(), 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref  m_IdMaestro);

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
            carta.FechaDescarga= new DateTime(2016, 1, 1);
            carta.PuntoVenta = 1;
            carta.Cosecha = "2016/17";
            carta.IdArticulo = 4;
            carta.NetoFinalSinMermas = 30160;
            carta.Merma = 0;
            carta.Humedad= 0; 
            carta.HumedadDesnormalizada = 0; 
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);




            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.ReyserAnalisis, SC, 0, ref log, DateTime.Today.ToShortDateString(), 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref  m_IdMaestro);

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
        public void InformeControlDeKilos_23685()
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

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref  m_IdMaestro);

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
        public void OCR_Tickets()
        {
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile;
            zipFile = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\tickets y cartas.zip";
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


            ClassFlexicapture.IniciaMotor(ref engine, ref engineLoader, ref  processor, plantilla);

            var ver = engine.Version;


            string sError = "";


            // cuanto va a estar andando esto? -le estás pasando la lista explícita "l"
            ClassFlexicapture.ActivarMotor(SC, l, ref sError, DirApp, "SI");



            var excels = ClassFlexicapture.BuscarExcelsGenerados(DirApp);

            System.Diagnostics.Process.Start(@"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\Temp\" + excels[0] + @"\ExportToXLS.xls");



        }




        [TestMethod]
        public void InformeControlDiario_22052_2()
        {


            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);


            List<CartasDePorteControlDescarga> control = (from a in db.CartasDePorteControlDescargas select a).ToList();


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


            ClassFlexicapture.IniciaMotor(ref engine, ref engineLoader, ref  processor, plantilla);

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
        public void DESCARGA_IMAGENES_22373_2()
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

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref  m_IdMaestro);

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


            ClassFlexicapture.IniciaMotor(ref engine, ref engineLoader, ref  processor, plantilla);

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
                var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(ref engine, ref  processor,
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

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref  m_IdMaestro);

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
        public void OCR_alta_automatica_de_clientes_22172()
        {
            var a = ProntoMVC.Data.FuncionesGenericasCSharp.mkf_validacuit("20");
            var b = ProntoMVC.Data.FuncionesGenericasCSharp.mkf_validacuit("30-53777127-4");
            var c = ProntoMVC.Data.FuncionesGenericasCSharp.mkf_validacuit("30-53772127-4");
            var d = CartaDePorteManager.VerfCuit("30537771274");
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

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref  m_IdMaestro);

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

            b1 = CartaDePorteManager.BajarImagenDeCartaPorte_DLL("Mariano", "pirulo!", 20488343, SC, DirApp, bdlmasterappconfig);
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
                                            1, "Todos", SC, -1, -1, -1);

        }







        [TestMethod]
        public void problema_informe_totalespormes()
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


            var q2 = ConsultasLinq.totpormessucursal(SC,
              "", "", "", 1, 10,
               CartaDePorteManager.enumCDPestado.Todas, "", -1, -1,
              -1, -1,
              -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
               new DateTime(2014, 1, 1),
               new DateTime(2014, 1, 1),
               -1, ref sTitulo, "Ambas", false, "");


            var q3 = ConsultasLinq.totpormesmodoysucursal(SC,
              "", "", "", 1, 10,
               CartaDePorteManager.enumCDPestado.Todas, "", -1, -1,
              -1, -1,
              -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
               new DateTime(2014, 1, 1),
               new DateTime(2014, 1, 1),
               -1, ref sTitulo, "Ambas", false, "");

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
        public void TambienParaFlexicaptureActivar_ImagenesTiffMultipaginaFormatoCPTK_CPTK_CPTK_20503()
        {

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile;
            zipFile = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\imagenes\3333.tif";
            zipFile = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\imagenes\CPTKCPTK.tif";

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            VaciarDirectorioTemp();


            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, true, false, false, 1);


            string sError = "";


            //CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, lista, -1, ref sError, DirApp);
            ClassFlexicapture.ActivarMotor(SC, l, ref sError, DirApp, "SI");
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

            var q = CartaDePorteManager.TraerCUITClientesSegunUsuario("BLDPIRULO", SC);
            var q2 = CartaDePorteManager.TraerCUITClientesSegunUsuario("BLD_ALABERN", SC);
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

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref  m_IdMaestro);

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


            ClassFlexicapture.IniciaMotor(ref engine, ref engineLoader, ref  processor, plantilla);

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
                var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(ref engine, ref  processor,
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

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref  m_IdMaestro);

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


        [TestMethod]
        public void LocalidadAprox()
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


            ClassFlexicapture.IniciaMotor(ref engine, ref engineLoader, ref  processor, plantilla);

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
                var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(ref engine, ref  processor,
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

            System.IO.DirectoryInfo di = new DirectoryInfo(@"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\Temp");

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

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref  m_IdMaestro);

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

            var ex1 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, desde, idarticulo, destino, destinatario);
            Debug.Print(ex1.ToString());
            var ex2 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, hasta, idarticulo, destino, destinatario);

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


            int idarticulo = SQLdinamico.BuscaIdArticuloPreciso("TRIGO PAN", SC);
            int destino = SQLdinamico.BuscaIdWilliamsDestinoPreciso("SASETRU - Sarandi ", SC);
            int destinatario = SQLdinamico.BuscaIdClientePreciso("BTG PACTUAL COMMODITIES S.A.", SC);

            var ex1 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, new DateTime(2015, 7, 26), idarticulo, destino, destinatario);
            Debug.Print(ex1.ToString());
            var ex2 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, new DateTime(2015, 7, 27), idarticulo, destino, destinatario);
            var ex3 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, new DateTime(2015, 10, 30), idarticulo, destino, destinatario);
            var ex4 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, new DateTime(2015, 10, 31), idarticulo, destino, destinatario);
            var ex5 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, new DateTime(2015, 11, 1), idarticulo, destino, destinatario);


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

            //yourParams(0) = New ReportParameter("webservice", "")
            //yourParams(1) = New ReportParameter("sServidor", ConfigurationManager.AppSettings("UrlDominio"))
            //yourParams(2) = New ReportParameter("idArticulo", -1)
            //yourParams(3) = New ReportParameter("idDestino", -1)
            //yourParams(4) = New ReportParameter("desde", New DateTime(2012, 11, 1)) ' txtFechaDesde.Text)
            //yourParams(5) = New ReportParameter("hasta", New DateTime(2012, 11, 1)) ', txtFechaHasta.Text)
            //yourParams(6) = New ReportParameter("quecontenga", "ghkgk")
            //yourParams(7) = New ReportParameter("Consulta", strSQL)
            //yourParams(8) = New ReportParameter("sServidorSQL", Encriptar(SC))

            Microsoft.Reporting.WebForms.ReportViewer rep = new Microsoft.Reporting.WebForms.ReportViewer();

            var output = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref rep,
                    "Williams - Listado de Clientes incompletos.rdl",
                             "", SC, false, ref ArchivoExcelDestino, sTitulo, false);

            rep.Dispose();




            //var output = SincronismosWilliamsManager.GenerarSincro("Diaz Riganti", txtMailDiazRiganti.Text, sErrores, bVistaPrevia);

            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output), true);
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


            ClassFlexicapture.IniciaMotor(ref engine, ref engineLoader, ref  processor, plantilla);

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
                var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(ref engine, ref  processor,
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
        public void MandarmeLosSincrosAutomaticos()
        {
            //aaaaaa



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

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref  m_IdMaestro);

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

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref  m_IdMaestro);

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