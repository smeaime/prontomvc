using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace ProntoMVC.Controllers
{
    public class ClienteAPIController : ApiController
    {

        //public TestController() { }

        // GET api/<controller>
        //public IEnumerable<string> Get()
        //{
        //    return new string[] { "value1", "value2" };
        //}

        //GET api/<controller>/5
        public string Get(int id)
        {
            return "value";
        }



        public IEnumerable<string> GetAllClientes()
        {
            /*
            string SC;

            if (System.Diagnostics.Debugger.IsAttached)
                SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scLocal"]);
            else
                SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scWilliamsRelease"]);

            string scbdlmaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString);

            var a = new ServicioCartaPorte.servi();

            string output = a.CartasPorte_DynamicGridData_Orden3(
                            sortColumnName, sortOrderBy, Convert.ToInt32(pageIndex),
                            Convert.ToInt32(numberOfRows), isSearch == "true", filters, FechaInicial, FechaFinal, Convert.ToInt32(puntovent),
                            SQLdinamico.BuscaIdWilliamsDestinoPreciso(destino, SC),
                            SC, usuario, scbdlmaster);

            response.ContentType = "application/json";
            response.Write(output);
    */

            string SC = "Data Source = sqlmvc; Initial catalog = Pronto_Vialagro; User ID = sa; Password =.SistemaPronto.; Connect Timeout = 500";
            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(SC);
            var db = new ProntoMVC.Data.Models.DemoProntoEntities(scEF);

            //var q = db.Clientes.Select(x => new { x.RazonSocial, x.Cuit }).ToArray();
            var q = db.Clientes.Select(x => x.RazonSocial);

            return q;
        }


        //public IEnumerable<Product> GetAllProducts()
        //{
        //    return products;
        //}

        //public IHttpActionResult GetProduct(int id)
        //{
        //    var product = products.FirstOrDefault((p) => p.Id == id);
        //    if (product == null)
        //    {
        //        return NotFound();
        //    }
        //    return Ok(product);
        //}




        //https://stackoverflow.com/questions/24843264/how-to-add-custom-methods-to-asp-net-webapi-controller
        //   [Route("ChangePassword")]
        //[HttpPost] // There are HttpGet, HttpPost, HttpPut, HttpDelete.
        //public async Task<IHttpActionResult> ChangePassword(ChangePasswordModel model)
        //{
        //}

        //[Route("GetAllClientes2")]
        //[HttpGet] // There are HttpGet, HttpPost, HttpPut, HttpDelete.
        //public string[] GetAllClientes2()
        //{


        //    string SC = "Data Source = sqlmvc; Initial catalog = Pronto_Vialagro; User ID = sa; Password =.SistemaPronto.; Connect Timeout = 500";
        //    var db = new ProntoMVC.Data.Models.DemoProntoEntities(SC);

        //    //var q = db.Clientes.Select(x => new { x.RazonSocial, x.Cuit }).ToArray();
        //    var q = db.Clientes.Select(x => x.RazonSocial).ToArray();

        //    return q;

        //}


        [HttpGet]
        [Route("~/api/lala/{someParameter}")]
        public int SomeUrlSegment(string someParameter)
        {
            //do stuff
            return 3;
        }

    }
}
