//#define DEBUG_SERVICE

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
        protected Thread m_thread2;
        protected Thread m_thread3;
        protected Thread m_thread4;

        static protected ManualResetEvent m_shutdownEvent;
        static protected TimeSpan m_delay;

        static bool bForzarShutdown = false;

        static string DirApp1, DirApp2;
        static string SC1, SC2;
        static string plantilla;

        ///static string TempFolder;



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


            // matar procesos FCEngine huerfanos
            foreach (var process in Process.GetProcessesByName("FCEngine"))
            {
                process.Kill();
            }


            // create the manual reset event and
            // set it to an initial state of unsignaled
            m_shutdownEvent = new ManualResetEvent(false);


            DebugMode();

            m_thread = new Thread(DoWorkSoloOCR);
            m_thread.Name = "MyWorker1";
            m_thread.IsBackground = false;
            m_thread.Start();



            System.Threading.Thread.Sleep(1000);


            ////http://stackoverflow.com/questions/11985308/multiple-threads-in-windows-service

            m_thread2 = new Thread(DoWorkSoloPegatinas);
            m_thread2.Name = "MyWorker2";
            m_thread2.IsBackground = false;
            m_thread2.Start();


            System.Threading.Thread.Sleep(1000);


            ////http://stackoverflow.com/questions/11985308/multiple-threads-in-windows-service

            m_thread3 = new Thread(DoWorkSoloOCR);
            m_thread3.Name = "MyWorker3";
            m_thread3.IsBackground = false;
            m_thread3.Start();


            System.Threading.Thread.Sleep(1000);


            ////http://stackoverflow.com/questions/11985308/multiple-threads-in-windows-service
            if (false)
            {
                m_thread4 = new Thread(DoWorkSoloOCR);
                m_thread4.Name = "MyWorker4";
                m_thread4.IsBackground = false;
                m_thread4.Start();
            }

            ////FlexiCapture Engine must be accessed on the same thread as it was initialized
            /*
             * http://knowledgebase.abbyy.com/article/794
        // https://abbyy.technology/en:kb:code-sample:fce_processor_pool

             * FREngine.dll can be loaded manually. This is the standard method that was used in the previous version 
                of ABBYY FineReader Engine. This method requires that all operations with the Engine object be 
                performed within the same thread where the Engine object was initialized. 
                In addition, it does not allow you to initialize more than one Engine object per process. This 
                considerably limits the performance of the server. For this reason we do not recommend 
                using this method. One advantage of this method is that it does not require registration of FREngine.dll 
                when installing the application on end user's computer.
             * */


        }


        protected override void OnStop()
        {
            // signal the event to shutdown
            m_shutdownEvent.Set();

            // wait for the thread to stop giving it 10 seconds
            m_thread.Join(20000);

            m_thread2.Join(10000);

            m_thread3.Join(10000);

            m_thread4.Join(10000);

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





        static public void DoWorkSoloOCR()
        {

            IEngine engine = null;
            IEngineLoader engineLoader = null;
            IFlexiCaptureProcessor processor = null;


            string idthread = "hilo #" + Thread.CurrentThread.ManagedThreadId.ToString() + ": ";



            try
            {


                //if (Debugger.IsAttached) Debugger.Break();

                Pronto.ERP.Bll.ErrHandler2.WriteError(idthread + "ssdssss");


                ClassFlexicapture.Log(idthread + "Empieza");

                Initialize();




                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                string cadena = Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC1));

                ClassFlexicapture.Log(idthread + "CONEXION: " + cadena);
                Console.WriteLine(idthread + "CONEXION: " + cadena);

                try
                {
                    DemoProntoEntities db = new DemoProntoEntities(cadena);
                    var q = db.Clientes.Take(1).ToList();

                }
                catch (Exception x)
                {
                    ClassFlexicapture.Log(idthread + x.ToString());
                    CartaDePorteManager.MandarMailDeError(x);
                    Console.WriteLine(idthread + x.ToString());
                    return;
                }


                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////





                ClassFlexicapture.Log(idthread + "llamo a iniciamotor");

                ClassFlexicapture.IniciaMotor(ref engine, ref  engineLoader, ref  processor, plantilla, ClassFlexicapture.EngineLoadingMode.LoadAsWorkprocess);



                ClassFlexicapture.Log(idthread + "Motor iniciado");


                // http://www.codeproject.com/Articles/3938/Creating-a-C-Service-Step-by-Step-Lesson-I

                //Console.WriteLine(idthread + "Busca imagenes Pendientes");


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
                        if (idthread == "")
                        {
                            throw new System.Runtime.InteropServices.COMException();
                        }



                        if ((bSignaled == true && !Debugger.IsAttached) || bForzarShutdown) break;
                        bSignaled = m_shutdownEvent.WaitOne(m_delay, true);
                        if ((bSignaled == true && !Debugger.IsAttached) || bForzarShutdown) break;

                        resultado = null;
                        resultado = Tanda(SC1, DirApp1, ref engine, ref processor, idthread);


                        resultado2 = null;
                        resultado2 = Tanda(SC2, DirApp2, ref engine, ref processor, idthread);



                        //TandaPegatinas(SC1, DirApp1, idthread);
                        //TandaPegatinas(SC2, DirApp2, idthread);


                        // esta bien hacerlo asi? -separar la tarea de pegatinas en un hilo aparte




                        if (resultado == null && resultado2 == null)
                        {
                            bSignaled = m_shutdownEvent.WaitOne(m_delay, true);
                            if ((bSignaled == true && !Debugger.IsAttached) || bForzarShutdown) break;
                            System.Threading.Thread.Sleep(1000 * 15);
                            if ((bSignaled == true && !Debugger.IsAttached) || bForzarShutdown) break;
                            System.Threading.Thread.Sleep(1000 * 15);
                            Console.Write(".");
                        }

                    }





Log Entry : 
05/05/2017 01:10:18
Error in: . Error Message:System.Runtime.InteropServices.COMException (0x80004005): Error: No se ha podido exportar a 'Destino de exportación definido por el usuario' debido a un error en la exportación
   at FCEngine.IFlexiCaptureProcessor.ExportDocumentEx(IDocument Document, String ExportRootFolder, String FileName, IFileExportParams ExportParams)
   at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, List`1 imagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 555
   at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, Int32 cuantasImagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 310
   at ProntoWindowsService.Service1.Tanda(String SC, String DirApp, IEngine& engine, IFlexiCaptureProcessor& processor, String idthread) in c:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\Service1.cs:line 755








Log Entry : 
05/05/2017 17:57:07
Error in: . Error Message:System.Runtime.InteropServices.COMException (0x80004005): No se puede acceder a E:\Sites\Pronto\Temp\Lote 05may174347 cgoycochea PV4\ExportToXLS.xls.
Otro usuario bloqueó este proyecto.
   at FCEngine.IFlexiCaptureProcessor.ExportDocumentEx(IDocument Document, String ExportRootFolder, String FileName, IFileExportParams ExportParams)
   at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, List`1 imagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 555
   at ProntoFlexicapture.ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(IEngine& engine, IFlexiCaptureProcessor& processor, String plantilla, Int32 cuantasImagenes, String SC, String DirApp, Boolean bProcesar, String& sError) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 310
   at ProntoWindowsService.Service1.Tanda(String SC, String DirApp, IEngine& engine, IFlexiCaptureProcessor& processor, String idthread) in c:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\Service1.cs:line 746
__________________________







Log Entry : 
05/05/2017 19:32:10
Error in: . Error Message:System.Runtime.InteropServices.COMException (0x80080005): Retrieving the COM class factory for component
 with CLSID {B0003004-0000-48FF-9197-57B7554849BA} 
failed due to the following error: 80080005 Server execution failed (Exception from HRESULT: 0x80080005 (CO_E_SERVER_EXEC_FAILURE)).
   at System.RuntimeTypeHandle.CreateInstance(RuntimeType type, Boolean publicOnly, Boolean noCheck, Boolean& canBeCached, RuntimeMethodHandleInternal& ctor, Boolean& bNeedSecurityCheck)
   at System.RuntimeType.CreateInstanceSlow(Boolean publicOnly, Boolean skipCheckThis, Boolean fillCache)
   at System.RuntimeType.CreateInstanceDefaultCtor(Boolean publicOnly, Boolean skipVisibilityChecks, Boolean skipCheckThis, Boolean fillCache)
   at System.Activator.CreateInstance(Type type, Boolean nonPublic)
   at System.Activator.CreateInstance(Type type)
   at ProntoFlexicapture.ClassFlexicapture.loadEngine(EngineLoadingMode _engineLoadingMode, IEngineLoader& engineLoader) 
in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 2748
   at ProntoFlexicapture.ClassFlexicapture.IniciaMotor(IEngine& engine, IEngineLoader& engineLoader, IFlexiCaptureProcessor& processor, String plantilla,
 EngineLoadingMode engineLoadingMode) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 2398
   at ProntoWindowsService.Service1.DoWorkSoloOCR() in c:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\Service1.cs:line 417
__________________________


We will see in a second what can cause this, but the idea is that under heavy CPU load the machine can be pretty slow, and some out-of-process COM servers will fail to initialize properly. 

Si después de hacer todo lo que se indica en la pregunta sigue tirando ese error, el motivo es muy sencillo: Carga de CPU

-seria raro... cuando falla de esa manera, no lo resucito más por más intentos q haga. necesito reiniciar el servicio (y engancha enseguida)


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


                        if ((uint)x2.ErrorCode == 0x80080005)
                        { // (0x80080005) 80080005 Server execution failed (Exception from HRESULT: 0x80080005 (CO_E_SERVER_EXEC_FAILURE)).

                            ClassFlexicapture.Log(idthread + "Problemas CO_E_SERVER_EXEC_FAILURE");

                        }
                        else if ((uint)x2.ErrorCode == 0x80004005)
                        {  //(0x80004005): Error communicating with ABBYY Product 

                            ClassFlexicapture.Log(idthread + "Problemas al conectarse al licenciador");

                        }
else
{

    asdasd
}



                        //                     Error in: . Error Message:System.Runtime.InteropServices.COMException (0x80080005): Retrieving the COM class factory for component with CLSID {B0003004-0000-48FF-9197-57B7554849BA} failed due to the following error: 80080005 Server execution failed (Exception from HRESULT: 0x80080005 (CO_E_SERVER_EXEC_FAILURE)).
                        //at System.RuntimeTypeHandle.CreateInstance(RuntimeType type, Boolean publicOnly, Boolean noCheck, Boolean& canBeCached, RuntimeMethodHandleInternal& ctor, Boolean& bNeedSecurityCheck)
                        //at System.RuntimeType.CreateInstanceSlow(Boolean publicOnly, Boolean skipCheckThis, Boolean fillCache)
                        //at System.RuntimeType.CreateInstanceDefaultCtor(Boolean publicOnly, Boolean skipVisibilityChecks, Boolean skipCheckThis, Boolean fillCache)
                        //at System.Activator.CreateInstance(Type type, Boolean nonPublic)
                        //at System.Activator.CreateInstance(Type type)
                        //at ProntoFlexicapture.ClassFlexicapture.loadEngine(EngineLoadingMode _engineLoadingMode, IEngineLoader& engineLoader) in c:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\prontoflexicapture.cs:line 2741




                        CartaDePorteManager.MandarMailDeError(x2);

                        ClassFlexicapture.Log(idthread + x2.ToString());
                        ClassFlexicapture.Log(idthread + "Problemas con la licencia? Paro y reinicio");
                        Pronto.ERP.Bll.ErrHandler2.WriteError(idthread + x2);

                        //hacer un unload y cargar de nuevo?

                        ClassFlexicapture.unloadEngine(ref engine, ref engineLoader);
                        processor = null;

pruebo poner en null el engine y engineloader?

                        bool exito = false;
                        for (int n = 0; n < 800; n++)
                        {

                            ClassFlexicapture.Log(idthread + "Reconexion intento n°" + n.ToString());


                            try
                            {
                                ClassFlexicapture.IniciaMotor(ref engine, ref  engineLoader, ref  processor, plantilla); // explota en loadengine
                                //cuantas veces debo probar de nuevo?

                                ClassFlexicapture.Log(idthread + "Reconectó al intento n°" + n.ToString());

                                exito = true;

                                break;
                            }
                            catch (Exception ex4)
                            {

                                ClassFlexicapture.Log(ex4.ToString());
                            }


                            System.Threading.Thread.Sleep(1000 * 60); //espero un minuto

                        }

                        if (!exito)
                        {

                            ClassFlexicapture.Log(idthread + " no se pudo reconectar");
                            return;
                        }





                        //ClassFlexicapture.Log(idthread + "funciona?");

                    }

                    catch (Exception x)
                    {

                        CartaDePorteManager.MandarMailDeError(x);

                        ClassFlexicapture.Log(idthread + x.ToString());
                        Pronto.ERP.Bll.ErrHandler2.WriteError(x);
                    }
                    finally
                    {
                        //ClassFlexicapture.Log(idthread + " se retira");
                    }


                }




                ClassFlexicapture.unloadEngine(ref engine, ref engineLoader);

            }
            catch (Exception x)
            {

                ClassFlexicapture.Log(idthread + x.ToString());
                //throw;
            }
            finally
            {


                ClassFlexicapture.Log(idthread + "Se apagó el motor, chau");


            }


            //ClassFlexicapture.Log(x.ToString());

            //se podria intentar cerrar todos los FCEngine vivos?



        }


        public static void ThrowAnException(string message)
        {
            throw new ApplicationException(message);
        }



        static public void DoWorkSoloPegatinas()
        {


            //IEngine engine = null;
            //IEngineLoader engineLoader = null;
            //IFlexiCaptureProcessor processor = null;


            string idthread = "hilo #" + Thread.CurrentThread.ManagedThreadId.ToString() + ": ";


            //if (Debugger.IsAttached) Debugger.Break();

            Pronto.ERP.Bll.ErrHandler2.WriteError(idthread + "ssdssss");


            ClassFlexicapture.Log(idthread + "Empieza");

            Initialize();




            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            string cadena = Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC1));

            ClassFlexicapture.Log(idthread + "CONEXION: " + cadena);
            Console.WriteLine(idthread + "CONEXION: " + cadena);

            try
            {
                DemoProntoEntities db = new DemoProntoEntities(cadena);
                var q = db.Clientes.Take(1).ToList();

            }
            catch (Exception x)
            {
                ClassFlexicapture.Log(idthread + x.ToString());
                CartaDePorteManager.MandarMailDeError(x);
                Console.WriteLine(idthread + x.ToString());
                return;
            }


            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////





            //ClassFlexicapture.Log(idthread + "llamo a iniciamotor");

            //ClassFlexicapture.IniciaMotor(ref engine, ref  engineLoader, ref  processor, plantilla, ClassFlexicapture.EngineLoadingMode.LoadAsWorkprocess);



            //ClassFlexicapture.Log(idthread + "Motor iniciado");


            // http://www.codeproject.com/Articles/3938/Creating-a-C-Service-Step-by-Step-Lesson-I

            //Console.WriteLine(idthread + "Busca imagenes Pendientes");


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


                    if ((bSignaled == true && !Debugger.IsAttached) || bForzarShutdown) break;
                    bSignaled = m_shutdownEvent.WaitOne(m_delay, true);
                    if ((bSignaled == true && !Debugger.IsAttached) || bForzarShutdown) break;

                    resultado = null;
                    //resultado = Tanda(SC1, DirApp1, ref engine, ref processor, idthread);


                    resultado2 = null;
                    //resultado2 = Tanda(SC2, DirApp2, ref engine, ref processor, idthread);



                    TandaPegatinas(SC1, DirApp1, idthread);
                    TandaPegatinas(SC2, DirApp2, idthread);


                    // esta bien hacerlo asi? -separar la tarea de pegatinas en un hilo aparte




                    if (resultado == null && resultado2 == null)
                    {
                        bSignaled = m_shutdownEvent.WaitOne(m_delay, true);
                        if ((bSignaled == true && !Debugger.IsAttached) || bForzarShutdown) break;
                        System.Threading.Thread.Sleep(1000 * 15);
                        if ((bSignaled == true && !Debugger.IsAttached) || bForzarShutdown) break;
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

                    ClassFlexicapture.Log(idthread + x2.ToString());
                    //ClassFlexicapture.Log(idthread + "Problemas con la licencia? Paro y reinicio");
                    Pronto.ERP.Bll.ErrHandler2.WriteError(idthread + x2);

                    //hacer un unload y cargar de nuevo?

                    //ClassFlexicapture.unloadEngine(ref engine, ref engineLoader);
                    //processor = null;

                    //ClassFlexicapture.IniciaMotor(ref engine, ref  engineLoader, ref  processor, plantilla); // explota en loadengine
                    //cuantas veces debo probar de nuevo?

                    //ClassFlexicapture.Log(idthread + "funciona?");

                }

                catch (Exception x)
                {

                    CartaDePorteManager.MandarMailDeError(x);

                    ClassFlexicapture.Log(idthread + x.ToString());
                    Pronto.ERP.Bll.ErrHandler2.WriteError(x);
                }
                finally
                {

                }


            }
            //ClassFlexicapture.Log(x.ToString());

            //ClassFlexicapture.unloadEngine(ref engine, ref engineLoader);
            ClassFlexicapture.Log(idthread + "Se apagó el hilo de pegatinas");


        }















        static List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> Tanda(string SC, string DirApp, ref IEngine engine,
            ref IFlexiCaptureProcessor processor, string idthread)
        {
            List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> resultado = null;

            try
            {

                ClassFlexicapture.Log(idthread + "busco imagenes");


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




















        static List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> TandaPegatinas(string SC, string DirApp, string idthread)
        {
            List<ProntoMVC.Data.FuncionesGenericasCSharp.Resultados> resultado = null;

            try
            {

                ClassFlexicapture.Log(idthread + "busco pegatinas");


                var lista = ClassFlexicapture.ExtraerListaDeExcelsQueNoHanSidoProcesados(5, DirApp);


                string log = "";
                //hay que pasar el formato como parametro 

                foreach (string f in lista)
                {
                    int m_IdMaestro = 0;

                    ClassFlexicapture.MarcarArchivoComoProcesandose(f);

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
                // throw;

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







