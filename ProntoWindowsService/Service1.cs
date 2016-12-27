﻿//#define DEBUG_SERVICE

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;

using ProntoFlexicapture;
using FCEngine;

using ProntoMVC.Data.Models;

using System.Configuration;

using System.IO;
using System.Threading;


namespace ProntoWindowsService
{
    public partial class Service1 : ServiceBase
    {

        protected Thread m_thread;
        static protected ManualResetEvent m_shutdownEvent;
        static protected TimeSpan m_delay;


        static string DirApp1, DirApp2;
        static string SC1, SC2;
        static string plantilla;

        ///static string TempFolder;

        static IEngine engine = null;
        static IEngineLoader engineLoader = null;
        static IFlexiCaptureProcessor processor = null;


        [Conditional("DEBUG_SERVICE")]
        private static void DebugMode()
        {
            Debugger.Break();
        }




        public Service1()
        {
            //InitializeComponent();
        }



        protected override void OnStart(string[] args)
        {


            // create the manual reset event and
            // set it to an initial state of unsignaled
            m_shutdownEvent = new ManualResetEvent(false);


            DebugMode();

            m_thread = new System.Threading.Thread(DoWork);
            m_thread.Name = "MyWorker";
            m_thread.IsBackground = false;
            m_thread.Start();
        }


        protected override void OnStop()
        {
            // signal the event to shutdown
            m_shutdownEvent.Set();

            // wait for the thread to stop giving it 10 seconds
            m_thread.Join(20000);

            // Temillas con la parada del servicio
            //http://stackoverflow.com/questions/22534330/windows-service-onstop-wait-for-finished-processing
            //http://stackoverflow.com/questions/1528209/how-to-properly-stop-a-multi-threaded-net-windows-service

            Console.WriteLine("exit");
        }


        static public void Initialize()
        {

            /*
             DirApp = @"C:\Users\Administrador\Documents\bdl\prontoweb";

             SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(
                    @"Data Source=SERVERSQL3;Initial catalog=Williams;User ID=sa; Password=.SistemaPronto.;Connect Timeout=8");

             plantilla = @"C:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\cartaporte.afl";
            */


            plantilla = ConfigurationManager.AppSettings["PlantillaFlexicapture"];

            DirApp1 = ConfigurationManager.AppSettings["DirApp"];
            SC1 = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["SC"]);

            DirApp2 = ConfigurationManager.AppSettings["DirApp_Test"];
            SC2 = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["SC_Test"]);




        }







        static public void DoWork()
        {


            if (Debugger.IsAttached) Debugger.Break();


            ClassFlexicapture.Log("Empieza");

            Initialize();




            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            string cadena = Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC1));

            ClassFlexicapture.Log("CONEXION: " + cadena);
            Console.WriteLine("CONEXION: " + cadena);

            try
            {
                DemoProntoEntities db = new DemoProntoEntities(cadena);
                var q = db.Clientes.Take(1).ToList();

            }
            catch (Exception x)
            {
                ClassFlexicapture.Log(x.ToString());
                CartaDePorteManager.MandarMailDeError(x);
                Console.WriteLine(x.ToString());
                return;
            }


            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////





            ClassFlexicapture.Log("llamo a iniciamotor");

            ClassFlexicapture.IniciaMotor(ref engine, ref  engineLoader, ref  processor, plantilla);



            ClassFlexicapture.Log("Motor iniciado");


            // http://www.codeproject.com/Articles/3938/Creating-a-C-Service-Step-by-Step-Lesson-I

            Console.WriteLine("Busca imagenes Pendientes");


            bool bSignaled = false;

            List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> resultado, resultado2;

            while (true)
            {
                // wait for the event to be signaled
                // or for the configured delay

                // let's do some work
                //no volver a cargar planilla!!!!


                try
                {


                    if (bSignaled == true && !Debugger.IsAttached) break;
                    bSignaled = m_shutdownEvent.WaitOne(m_delay, true);
                    if (bSignaled == true && !Debugger.IsAttached) break;

                    resultado = null;
                    resultado = Tanda(SC1, DirApp1);


                    resultado2 = null;
                    resultado2 = Tanda(SC2, DirApp2);


                    TandaPegatinas(SC1, DirApp1);
                    TandaPegatinas(SC2, DirApp2);







                    if (resultado == null && resultado2 == null)
                    {
                        bSignaled = m_shutdownEvent.WaitOne(m_delay, true);
                        if (bSignaled == true && !Debugger.IsAttached) break;
                        System.Threading.Thread.Sleep(1000 * 15);
                        if (bSignaled == true && !Debugger.IsAttached) break;
                        System.Threading.Thread.Sleep(1000 * 15);
                        Console.Write(".");
                    }

                }

                catch (System.Runtime.InteropServices.COMException x2)
                {
                    /*
System.Runtime.InteropServices.COMException (0x80004005): Error communicating with ABBYY Product 
     *                  Licensing Service on 186.18.248.116: The RPC server is unavailable.
        Diagnostic Message: 1710(0x000006BA) 1442(0x000006BA) 323(0x000006BA) 313(0x000004D5) 311(0x0000274C) 318(0x0000274C)
at FCEngine.IFlexiCaptureProcessor.RecognizeNextDocument()
at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, List`1 imagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 209
at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, Int32 cuantasImagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 123
at ProntoWindowsService.Service1.DoWork() in c:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\Service1.cs:line 197
    */


                    /*
                     * 
                     * 
                     * 
                    System.OutOfMemoryException: Insufficient memory to continue the execution of the program.
   at FCEngine.IFlexiCaptureProcessor.RecognizeNextDocument()
   at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, List`1 imagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 233
   at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, Int32 cuantasImagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 127
   at ProntoWindowsService.Service1.Tanda(String SC, String DirApp) in c:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\Service1.cs:line 328
   at ProntoWindowsService.Service1.DoWork() in c:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\Service1.cs:line 211


   
    with the event: 

System.Runtime.InteropServices.COMException (0x8000FFFF): Error interno del programa:
FCESupport\FCESupportImpl.h, 42.
   at FCEngine.IFlexiCaptureProcessor.SetCustomImageSource(IImageSource ImageSource)
   at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, List`1 imagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 198
   at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, Int32 cuantasImagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 127
   at ProntoWindowsService.Service1.Tanda(String SC, String DirApp) in c:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\Service1.cs:line 300


                     * 
                     * * 
                     * 
                     * 
                     * 
                     * */




                    CartaDePorteManager.MandarMailDeError(x2);

                    ClassFlexicapture.Log(x2.ToString());
                    ClassFlexicapture.Log("Problemas con la licencia? Paro y reinicio");
                    Pronto.ERP.Bll.ErrHandler2.WriteError(x2);

                    //hacer un unload y cargar de nuevo?

                    ClassFlexicapture.unloadEngine(ref engine, ref engineLoader);
                    processor = null;

                    ClassFlexicapture.IniciaMotor(ref engine, ref  engineLoader, ref  processor, plantilla); // explota en loadengine
                    //cuantas veces debo probar de nuevo?

                    ClassFlexicapture.Log("funciona?");

                }

                catch (Exception x)
                {

                    CartaDePorteManager.MandarMailDeError(x);

                    ClassFlexicapture.Log(x.ToString());
                    Pronto.ERP.Bll.ErrHandler2.WriteError(x);
                }

            }

            ClassFlexicapture.unloadEngine(ref engine, ref engineLoader);
            ClassFlexicapture.Log("Se apagó el motor");

        }



        static List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> Tanda(string SC, string DirApp)
        {
            List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> resultado = null;

            try
            {

                string sError = "";

                try
                {
                    resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(ref engine, ref processor,
                                   plantilla, Convert.ToInt32(ConfigurationManager.AppSettings["CantidadLote"]),
                                    SC, DirApp, true, ref sError);


                }
                catch (Exception x3)
                {
                    ClassFlexicapture.Log(x3.ToString());
                    throw;
                }



                string html = ClassFlexicapture.GenerarHtmlConResultado(resultado, sError);
                if ((html ?? "") != "")
                {
                    Console.WriteLine(html);
                    ClassFlexicapture.Log(html);




                    using (FileStream fs = new FileStream(DirApp + @"\Temp\log.html", FileMode.Append, FileAccess.Write))
                    using (StreamWriter sw = new StreamWriter(fs))
                    {
                        sw.WriteLine(html);
                    }
                }

            }

            catch (Exception x)
            {
                //System.Runtime.InteropServices.COMException (0x80004005):
                // que pasa si salto el error de la licencia? diferenciar si saltó por un archivo que no existe u otro error
                ClassFlexicapture.Log(x.ToString());
                throw;

            }

            return resultado;

        }




        static List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> TandaPegatinas(string SC, string DirApp)
        {
            List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> resultado = null;

            try
            {


                var lista = ClassFlexicapture.ExtraerListaDeExcelsQueNoHanSidoProcesados(5, DirApp);


                string log = "";
                //hay que pasar el formato como parametro 

                foreach (string f in lista)
                {
                    int m_IdMaestro = 0;

                    ClassFlexicapture.MarcarImagenComoProcesandose(f);

                    ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, f,
                                            LogicaImportador.FormatosDeExcel.Urenport, SC, 0, ref log, "", 0, "");

                    //var dt = LogicaImportador.TraerExcelDeBase(SC, ref  m_IdMaestro);

                }


            }

            catch (Exception x)
            {
                //System.Runtime.InteropServices.COMException (0x80004005):
                // que pasa si salto el error de la licencia? diferenciar si saltó por un archivo que no existe u otro error
                ClassFlexicapture.Log(x.ToString());
                throw;

            }

            return resultado;

        }


    }





    [RunInstaller(true)]
    public class Installer : System.Configuration.Install.Installer
    {
        private ServiceInstaller serviceInstaller;
        private ServiceProcessInstaller processInstaller;

        public Installer()
        {
            // Instantiate installers for process and services.
            processInstaller = new ServiceProcessInstaller();
            serviceInstaller = new ServiceInstaller();

            // The services run under the system account.
            processInstaller.Account = ServiceAccount.LocalSystem;

            // The services are started manually.
            serviceInstaller.StartType = ServiceStartMode.Automatic;

            // ServiceName must equal those on ServiceBase derived classes.
            serviceInstaller.ServiceName = "ProntoAgente";

            // Add installers to collection. Order is not important.
            Installers.Add(serviceInstaller);
            Installers.Add(processInstaller);
        }
    }
}
