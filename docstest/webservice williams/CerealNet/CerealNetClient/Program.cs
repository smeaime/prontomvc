using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Security.Cryptography.X509Certificates;
using System.Net.Security;

using CerealNet.WSCartasDePorte;

namespace CerealNetClient
{
    class Program
    {
        static void Main(string[] args)
        {
            //Trust all certificates
            System.Net.ServicePointManager.ServerCertificateValidationCallback = delegate(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };

            var cerealnet = new WS_CartasDePorteClient();

            string usuario = "fyo";
            string clave ="76075";
            string cuit = "30703605105";

            var respEntrega = cerealnet.obtenerDescargas(usuario, clave, cuit, "2016-10-01", "2016-10-25");
            foreach (var desc in respEntrega.descargas)
            {
                Console.WriteLine(string.Format("CP {0}", desc.cartaporte));

                if (desc.listaAnalisis != null && desc.listaAnalisis.Length > 0)
                {
                    foreach (analisis anal in desc.listaAnalisis)
                    {
                        Console.WriteLine(string.Format("\tRubro: {0} - %Analisis: {1} - %Merma: {2} - KgsMerma: {3}", anal.rubro.Trim(), anal.porcentajeAnalisis, anal.porcentajeMerma, anal.kilosMermas));
                    }
                }
            }
            Console.ReadKey();
        }
    }
}
