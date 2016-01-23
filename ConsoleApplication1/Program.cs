using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProntoFlexicapture;
using FCEngine;


namespace ConsoleApplication1
{
    class Program
    {


        static string DirApp;
        static string SC;
        static string plantilla;


        static void Main(string[] args)
        {
            Initialize();
            DoWork();
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



            IEngine engine = null;
            IEngineLoader engineLoader;

            ClassFlexicapture.EngineLoadingMode engineLoadingMode = ClassFlexicapture.EngineLoadingMode.LoadAsWorkprocess;
            System.Diagnostics.PerformanceCounter performanceCounter;

            if (engine == null)
            {
                engine = ClassFlexicapture.loadEngine(engineLoadingMode, out engineLoader);
            }

            string sError = "";


            // http://www.codeproject.com/Articles/3938/Creating-a-C-Service-Step-by-Step-Lesson-I

            while (true)
            {
                // wait for the event to be signaled
                // or for the configured delay

                // let's do some work
                var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(engine,
                                    plantilla, 5,
                                     SC, DirApp, true, ref sError);


                string html = ClassFlexicapture.GenerarHtmlConResultado(resultado, sError);
                Console.WriteLine(html);
            }


            ClassFlexicapture.unloadEngine(ref engine, ref engineLoader);

        }

    }

}
