using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;


namespace ProntoMVC.Data.Models
{

    // para hacer override del constructor del dbcontext y poder pasarle una conexion dinamica
    // lo hago en un archivo aparte para que no se pise al autogenerar




    public partial class DemoProntoEntities : DbContext
    {
        public DemoProntoEntities(string connectionString)
            : base(connectionString)
        {
        }
    }


    public partial class BDLMasterEntities : DbContext
    {
        public BDLMasterEntities(string connectionString)
            : base(connectionString)
        {
        }
    }


    //public partial class  ProntoMantenimientoEntities : DbContext
    //{
    //    public ProntoMantenimientoEntities(string connectionString)
    //        : base(connectionString)
    //    {
    //    }
    //}


    public static class Auxiliares
    {
        public static string FormatearConexParaEntityFramework(string s)
        {


            var parser = new System.Data.SqlClient.SqlConnectionStringBuilder(s);
            string servidorSQL = parser.DataSource; // "MARIANO-PC\\SQLEXPRESS";
            string basePronto = parser.InitialCatalog;  // "Autotrol";
            string user = parser.UserID;
            string pass = parser.Password;


            string SC =
                   "metadata=res://*/Models.Pronto.csdl|res://*/Models.Pronto.ssdl|res://*/Models.Pronto.msl;" +
                   "provider=System.Data.SqlClient;provider connection string=\"" +
                   "data source=" + servidorSQL + ";" +
                   "initial catalog=" + basePronto + ";" +
                   "persist security info=True;user id=" + user + ";" +
                   "password=" + pass + ";" +
                    "multipleactiveresultsets=True;App=EntityFramework\"";

            return SC;
        }
    }

}




namespace ProntoMVC.Data.Models.Mantenimiento
{

    public partial class ProntoMantenimientoEntities : DbContext
    {
        public ProntoMantenimientoEntities(string connectionString)
            : base(connectionString)
        {
        }
    }


}


