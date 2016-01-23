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


namespace ProntoWindowsService
{
    public partial class Service1 : ServiceBase
    {

        string DirApp;
        string SC;
        string TempFolder;
        string plantilla;


        public Service1()
        {
            InitializeComponent();
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
        }


        public void Initialize()
        {
            
            DirApp = @"C:\Users\Administrador\Documents\bdl\prontoweb";
            
            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(
                   @"Data Source=SERVERSQL3;Initial catalog=Williams;User ID=sa; Password=.SistemaPronto.;Connect Timeout=8");

            plantilla = @"C:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\cartaporte.afl";

        }


        void DoWork()
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
                bSignaled = m_shutdownEvent.WaitOne(m_delay, true);

                // if we were signaled to shutdow, exit the loop
                if (bSignaled == true)
                    break;

                // let's do some work
                var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(engine,
                                    plantilla, 5,
                                     SC, DirApp, true, ref sError);


                var html = ClassFlexicapture.GenerarHtmlConResultado(resultado, sError);
            }


            ClassFlexicapture.unloadEngine(ref engine, ref engineLoader);

        }


    }
}
