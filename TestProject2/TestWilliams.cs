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

using FCEngine;

using ProntoFlexicapture;

using System.Transactions;

using System.IO;

using Pronto.ERP.Bll;




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
        //string bldmasterappconfig = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
        string bldmasterappconfig; //  = "Data Source=SERVERSQL3\\TESTING;Initial catalog=BDLMaster;User ID=sa; Password=.SistemaPronto.;Connect Timeout=8";
        string sc;

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


            DirApp = @"C:\Users\Administrador\Documents\bdl\prontoweb";
            TempFolder = DirApp + @"\Temp";
            // string SamplesFolder = @"C:\Users\Administrador\Desktop\tiff multipagina";

            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(
                   @"Data Source=SERVERSQL3;Initial catalog=Williams;User ID=sa; Password=.SistemaPronto.;Connect Timeout=8");

            plantilla = @"C:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\cartaporte.afl";

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
        public void InformeDeClientesIncompletos_16492()
        {
               
               
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

            //var output = SincronismosWilliamsManager.GenerarSincro("Diaz Riganti", txtMailDiazRiganti.Text, sErrores, bVistaPrevia);

            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output), true);
        }



        [TestMethod]
        public void InformeConAcopios_16451()
        {


        }


        [TestMethod]
        public void SincroPetroAgro_16516()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            var output = SincronismosWilliamsManager.GenerarSincro("PetroAgro", ref sErrores, SC, ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2014,  1, 1), new DateTime(2014, 1, 2),
                0, "Ambas", false);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }




        [TestMethod]
        public void SincroDiazRiganti_15362()
        {

            string sErrores = "", sTitulo = "";
            // LinqCartasPorteDataContext db = null;




            var output = SincronismosWilliamsManager.GenerarSincro("Diaz Riganti",  ref sErrores, SC, ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                    "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2014, 1, 2), new DateTime(2014, 1, 2),
                0, "Ambas", false);



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
        public void PruebaFlexicapture_sinListaexplicita()
        {

            string zipFile = @"ADasdasd";

            SuboElZip();

            // 2 caminos
            // ProcesoLasProximas10ImagenesDelFTPqueNoHayanSidoProcesadasAun_yDevuelvoListaDeIDsYdeErrores
            //o  ProcesoLaListaQueYoLePaso_yDevuelvoListaDeIDsYdeErrores

            IEngine engine = null;
            IEngineLoader engineLoader;

            ClassFlexicapture.EngineLoadingMode engineLoadingMode = ClassFlexicapture.EngineLoadingMode.LoadAsWorkprocess;
            System.Diagnostics.PerformanceCounter performanceCounter;

            if (engine == null)
            {
                engine = ClassFlexicapture.loadEngine(engineLoadingMode, out engineLoader);
            }


            var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(engine,
                                    plantilla, 10,
                                     SC, DirApp, true);


            var html = ClassFlexicapture.GenerarHtmlConResultado(resultado);

        }

        void SuboElZip()
        {


        }


        [TestMethod]
        public void PruebaFlexicapture()
        {

            //string SamplesFolder = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos";
            //string SamplesFolder = @"C:\Users\Administrador\Desktop\codigo barras\17-3-2015\entrega\14Williams\17-3-2015";
            string SamplesFolder = @"C:\Users\Administrador\Desktop\codigo barras\17-3-2015\entrega\14Williams\17-3-2015\lotechico";
            //string plantilla =  @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\cartaporte.afl"


            try
            {
                Copy(SamplesFolder, TempFolder);

            }
            catch (Exception)
            {

                //throw;
            }


            IEngine engine = null;
            IEngineLoader engineLoader;

            ClassFlexicapture.EngineLoadingMode engineLoadingMode = ClassFlexicapture.EngineLoadingMode.LoadAsWorkprocess;
            System.Diagnostics.PerformanceCounter performanceCounter;

            if (engine == null)
            {
                engine = ClassFlexicapture.loadEngine(engineLoadingMode, out engineLoader);
            }

            //levantar todo un directorio

            List<string> lista = new List<string>(); // { SamplesFolder + "\\SampleImages\\ZXING BIEN 545459461 (300dpi).jpg" , "" };

            DirectoryInfo d = new DirectoryInfo(SamplesFolder);//Assuming Test is your Folder
            FileInfo[] Files = d.GetFiles("*.*");
            foreach (FileInfo file in Files)
            {
                lista.Add(file.FullName);
            }




            var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture(engine,
                                        plantilla,
                                        lista, SC, DirApp, false);


            var html = ClassFlexicapture.GenerarHtmlConResultado(resultado);


        }









        [TestMethod]
        public void ProcesarTiffMultipagina_Reclamo14967()
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

            CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, lista, -1, ref sError, DirApp);
        }





        [TestMethod]
        public void FormatoImpresionPlantillaFactura_14851()
        {


            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            // buscar factura de LDC y de ACA
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
        }




        [TestMethod]
        public void FormatoImpresionPlantillaRemitoLDC()
        {



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
            string archivoExcel = @"C:\Users\Administrador\Downloads\Lima Noble (1).xls";
            int m_IdMaestro = 0;

            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel, null, SC, null, null, null, 0, "");

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



            var q = CartaDePorteManager.CartasLINQlocalSimplificadoTipadoConCalada(SC,
                "", "", "", 1, 300, CartaDePorteManager.enumCDPestado.Facturadas
                   , "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2014, 1, 1), new DateTime(2014, 1, 1),
                0, ref sTitulo, "Ambas", false, "", ref db, "", -1, -1, 0, "", "Ambas").ToList();


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



}