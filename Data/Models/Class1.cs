using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ProntoMVC.Data.Models
{

    // para hacer override del constructor del dbcontext y poder pasarle una conexion dinamica
    // lo hago en un archivo aparte para que no se pise al autogenerar

    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;



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


}
