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


namespace ProntoWindowsService
{
    public partial class Service1 : ServiceBase
    {

        static string DirApp;
        static string SC;
        static string TempFolder;
        static string plantilla;
        
        static IEngine engine = null;
        static IEngineLoader engineLoader = null;
        static IFlexiCaptureProcessor processor = null;


        public Service1()
        {
            //InitializeComponent();
        }



        protected override void OnStart(string[] args)
        {
            var worker = new System.Threading.Thread(DoWork);
            worker.Name = "MyWorker";
            worker.IsBackground = false;
            worker.Start();
        }


        protected override void OnStop()
        {
            Console.WriteLine("exit");
            ClassFlexicapture.unloadEngine(ref engine, ref engineLoader);
        }


       static public void Initialize()
        {

            DirApp = @"C:\Users\Administrador\Documents\bdl\prontoweb";

            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(
                   @"Data Source=SERVERSQL3;Initial catalog=Williams;User ID=sa; Password=.SistemaPronto.;Connect Timeout=8");

            plantilla = @"C:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\cartaporte.afl";

        }


        static void DoWork()
        {
            Initialize();

            string cadena = Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            Console.WriteLine("CONEXION: " + cadena);

            try
            {
                DemoProntoEntities db = new DemoProntoEntities(cadena);
                var q = db.Clientes.Take(1).ToList();

            }
            catch (Exception x)
            {
                Console.WriteLine(x.ToString());
                return;
            }


            ClassFlexicapture.IniciaMotor(ref engine, ref  engineLoader, ref  processor, plantilla);






            string sError = "";


            // http://www.codeproject.com/Articles/3938/Creating-a-C-Service-Step-by-Step-Lesson-I

            Console.WriteLine("Busca imagenes Pendientes");

            while (true)
            {
                // wait for the event to be signaled
                // or for the configured delay

                // let's do some work
                //no volver a cargar planilla!!!!



                try
                {
                    var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(ref engine, ref processor,
                                        plantilla, 5,
                                         SC, DirApp, true, ref sError);


                    string html = ClassFlexicapture.GenerarHtmlConResultado(resultado, sError);
                    if ((html ?? "") != "") Console.WriteLine(html);

                    if (resultado == null)
                    {
                        System.Threading.Thread.Sleep(1000 * 30);
                        Console.Write(".");
                    }

                }
                catch (Exception x)
                {
                    Pronto.ERP.Bll.ErrHandler2.WriteError(x);
                    ClassFlexicapture.unloadEngine(ref engine, ref engineLoader);
                    return;
                }

            }



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
            serviceInstaller.StartType = ServiceStartMode.Manual;

            // ServiceName must equal those on ServiceBase derived classes.
            serviceInstaller.ServiceName = "Pronto Agente";

            // Add installers to collection. Order is not important.
            Installers.Add(serviceInstaller);
            Installers.Add(processInstaller);
        }
    }
}
