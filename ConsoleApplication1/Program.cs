using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProntoFlexicapture;
using FCEngine;

using System.Configuration;

using ProntoMVC.Data.Models;

namespace ConsoleApplication1
{
    class Program
    {


        static string DirApp;
        static string SC;
        static string plantilla;

        static IEngine engine = null;
        static IEngineLoader engineLoader;


        static void Main(string[] args)
        {
            AppDomain.CurrentDomain.ProcessExit += new EventHandler(CurrentDomain_ProcessExit);
            Initialize();
            DoWork();


        }

        static void CurrentDomain_ProcessExit(object sender, EventArgs e)
        {
            Console.WriteLine("exit");
            ClassFlexicapture.unloadEngine(ref engine, ref engineLoader);
        }

        static public void Initialize()
        {

            /*

            DirApp = @"C:\Users\Administrador\Documents\bdl\prontoweb";
            
            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(
                   @"Data Source=SERVERSQL3;Initial catalog=Williams;User ID=sa; Password=.SistemaPronto.;Connect Timeout=8");

            plantilla = @"C:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\cartaporte.afl";
            */


            DirApp = ConfigurationManager.AppSettings["DirApp"];

            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["SC"]);

            plantilla = ConfigurationManager.AppSettings["PlantillaFlexicapture"];



        }

        static void DoWork()
        {

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





            ClassFlexicapture.EngineLoadingMode engineLoadingMode = ClassFlexicapture.EngineLoadingMode.LoadAsWorkprocess;
            System.Diagnostics.PerformanceCounter performanceCounter;

            if (engine == null)
            {
                engine = ClassFlexicapture.loadEngine(engineLoadingMode, out engineLoader);
            }

            string sError = "";


            // http://www.codeproject.com/Articles/3938/Creating-a-C-Service-Step-by-Step-Lesson-I

            Console.WriteLine("Busca imagenes Pendientes");

            while (true)
            {
                // wait for the event to be signaled
                // or for the configured delay

                // let's do some work
                var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(engine,
                                    plantilla, 5,
                                     SC, DirApp, true, ref sError);

                string html = ClassFlexicapture.GenerarHtmlConResultado(resultado, sError);
                if ((html ?? "") != "") Console.WriteLine(html);
            }



        }

    }

}
