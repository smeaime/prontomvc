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


using System.Diagnostics;

using Microsoft.Reporting.WebForms;

using System.Configuration;

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
        public void CartaPorteFuncionalidadBasica()
        {
            //adasdas

            string ms = "", warn = "";
            var carta = CartaDePorteManager.GetItem(SC, 4444);

            carta.CalidadDe = SQLdinamico.BuscaIdCalidadPreciso("GRADO 1", SC);
            carta.NobleGrado = 2;
            CartaDePorteManager.IsValid(SC, carta, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta, 1, "lalala");

            Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 1", SC), carta.CalidadDe);
            Assert.AreEqual(1, carta.NobleGrado);

            carta = null;
            carta = CartaDePorteManager.GetItem(SC, 4444);

            carta.CalidadDe = SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC);
            carta.NobleGrado = 3;
            CartaDePorteManager.IsValid(SC, carta, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta, 1, "lalala");

            Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC), carta.CalidadDe);
            Assert.AreEqual(2, carta.NobleGrado);

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
        public void movimientos_17679()
        {


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



            bool esvalido = CartaDePorteManager.IsValid(SC, carta, ref ms, ref warn);
            Assert.AreEqual(true, esvalido);
            int id = CartaDePorteManager.Save(SC, carta, 1, "lalala");
            Assert.AreNotEqual(-1, id);
            

            // Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC), carta.CalidadDe);
            // Assert.AreEqual(2, carta.NobleGrado);


        }



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
            CartaDePorteManager.IsValid(SC, carta, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta, 1, "lalala");

            Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 1", SC), carta.CalidadDe);
            Assert.AreEqual(1, carta.NobleGrado);

            carta = null;
            carta = CartaDePorteManager.GetItem(SC, 4444);

            carta.CalidadDe = SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC);
            carta.NobleGrado = 3;
            CartaDePorteManager.IsValid(SC, carta, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta, 1, "lalala");

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
        public void ZipdePDFsReducidos()
        {

            string titulo = "";
            var dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(SC, "",
                 "", "", 0, 100, CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2015, 10, 1), new DateTime(2015, 12, 30),
                0, ref titulo, "Ambas", false);


            var output = CartaDePorteManager.DescargarImagenesAdjuntas_PDF(dt, SC, false);
            System.Diagnostics.Process.Start(output);

        }

        [TestMethod]
        public void PDFdeCartaPorte()
        {
            //aaaaaa



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

            string sError = "";

            var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(engine,
                                    plantilla, 10,
                                     SC, DirApp, true, ref sError);


            var html = ClassFlexicapture.GenerarHtmlConResultado(resultado, sError);

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


            string sError = "";

            var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture(engine,
                                        plantilla,
                                        lista, SC, DirApp, false, ref sError);


            var html = ClassFlexicapture.GenerarHtmlConResultado(resultado, sError);


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

            //CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, lista, -1, ref sError, DirApp);
            ClassFlexicapture.ActivarMotor(SC, lista, ref sError, DirApp);
        }



        [TestMethod]
        public void FormatoImpresionPlantillaFactura_14851()
        {


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