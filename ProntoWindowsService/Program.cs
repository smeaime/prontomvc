using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;

using System;
using System.Collections.Generic;
using System.Configuration.Install; 
using System.IO;
using System.Linq;
using System.Reflection; 
using System.ServiceProcess;
using System.Text;
using System.Reflection;


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
                }
            }
            else
            {
                ServiceBase.Run(new Service1());
            }


        }


       
    }

}
