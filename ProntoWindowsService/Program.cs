
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;

using System.Configuration.Install;
using System.IO;
using System.Reflection;

using System.Threading;

namespace ProntoWindowsService
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        static void Main(string[] args)
        {

            // cosa piola para no tener que instalar el servicio con algo aparte http://stackoverflow.com/questions/1449994/inno-setup-for-windows-service
            ServiceBase[] servicesToRun;
            servicesToRun = new ServiceBase[] 
                    {
                        new Service1()
                        // , new Service1()  // disparo dos hilos
                    };

            if (System.Environment.UserInteractive)
            {
                string parameter = string.Concat(args);
                switch (parameter)
                {
                    case "--install":
                        ManagedInstallerClass.InstallHelper(new string[] { Assembly.GetExecutingAssembly().Location });
                        break;
                    case "--uninstall":
                        ManagedInstallerClass.InstallHelper(new string[] { "/u", Assembly.GetExecutingAssembly().Location });
                        break;
                    case "": // depuracion
                            //http://stackoverflow.com/questions/125964/easier-way-to-debug-a-c-sharp-windows-service

                        RunInteractive(servicesToRun);
                        break;

                }
            }
            else
            {
                //System.Diagnostics.Debugger.Break();
                ServiceBase.Run(servicesToRun);
            }


        }


        static void RunInteractive(ServiceBase[] servicesToRun)
        {
            // http://stackoverflow.com/questions/125964/easier-way-to-debug-a-c-sharp-windows-service

            Console.WriteLine("Services running in interactive mode.");
            Console.WriteLine();



            MethodInfo onStartMethod = typeof(ServiceBase).GetMethod("OnStart",
                BindingFlags.Instance | BindingFlags.NonPublic);

            foreach (ServiceBase service in servicesToRun)
            {
                Console.Write("Starting {0}...", service.ServiceName);
                onStartMethod.Invoke(service, new object[] { new string[] { } });
                Console.Write("Started");
            }

            Console.WriteLine();
            Console.WriteLine();
            Console.WriteLine(
                "Press any key to stop the services and end the process...");
            //Console.ReadKey();
            Console.Read();
            Console.WriteLine();

            MethodInfo onStopMethod = typeof(ServiceBase).GetMethod("OnStop",
                BindingFlags.Instance | BindingFlags.NonPublic);
            foreach (ServiceBase service in servicesToRun)
            {
                Console.Write("Stopping {0}...", service.ServiceName);
                onStopMethod.Invoke(service, null);
                Console.WriteLine("Stopped");
            }

            Console.WriteLine("All services stopped.");
            // Keep the console alive for a second to allow the user to see the message.
            Thread.Sleep(1000);
        }

    }

}
