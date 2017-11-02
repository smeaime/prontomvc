using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

using ProntoMVC.Data.Models;


//using Newtonsoft.Json;

//using System.Web.Mvc;


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
        //public string Get(int id)
        //{
        //    return "value";
        //},


        [HttpGet]
        [Route("~/api/Cliente/TraerTodosClientes")]
        public List<ClienteModelo> TraerTodosClientes()
        {
            /*
            string SC;s

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

            //var q = db.Clientes.Select(x => new string [] { x.RazonSocial, x.Cuit }).ToList();
            //var q = db.Clientes.Select(x => x.RazonSocial);
            var q = db.Clientes.Select(x => new ClienteModelo { Razonsocial= x.RazonSocial, Cuit=x.Cuit, DescripcionIva = x.DescripcionIva.Descripcion,
                                            CondicionVenta = x.Condiciones_Compra.Descripcion }).ToList();


            return q;
            //return Json(q);
           
        }


        public class ClienteModelo
        {
            public string Razonsocial { get; set; }

            public string Cuit { get; set; }

            public string DescripcionIva { get; set; }

            public string CondicionVenta { get; set; }

        }





        // devolver el modelo?

        [HttpGet]
        [Route("~/api/Cliente/TraerClientePorCuit/{sCUIT}")]
        public ClienteModelo TraerClientePorCuit(string sCUIT)
        {

            string SC = "Data Source = sqlmvc; Initial catalog = Pronto_Vialagro; User ID = sa; Password =.SistemaPronto.; Connect Timeout = 500";
            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(SC);
            var db = new ProntoMVC.Data.Models.DemoProntoEntities(scEF);

            //var q = db.Clientes.Select(x => new { x.RazonSocial, x.Cuit }).ToArray();
            var q = db.Clientes.Where(x => x.Cuit.Replace("-", "") == sCUIT.Replace("-","") ).Select(x => new ClienteModelo
                            { Razonsocial = x.RazonSocial, Cuit = x.Cuit, DescripcionIva = x.DescripcionIva.Descripcion, CondicionVenta = x.Condiciones_Compra.Descripcion }).FirstOrDefault();
            //string[] q = db.Clientes.Where(x=>x.Cuit==sCUIT).Select(x => new string[] { x.Cuit,  x.RazonSocial  }).SingleOrDefault();

            return q;
        }




    //    public string[] GetCliente(int id)
    //    {
    //        /*
    //        string SC;

    //        if (System.Diagnostics.Debugger.IsAttached)
    //            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scLocal"]);
    //        else
    //            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["scWilliamsRelease"]);

    //        string scbdlmaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString);

    //        var a = new ServicioCartaPorte.servi();

    //        string output = a.CartasPorte_DynamicGridData_Orden3(
    //                        sortColumnName, sortOrderBy, Convert.ToInt32(pageIndex),
    //                        Convert.ToInt32(numberOfRows), isSearch == "true", filters, FechaInicial, FechaFinal, Convert.ToInt32(puntovent),
    //                        SQLdinamico.BuscaIdWilliamsDestinoPreciso(destino, SC),
    //                        SC, usuario, scbdlmaster);

    //        response.ContentType = "application/json";
    //        response.Write(output);
    //*/

    //        string SC = "Data Source = sqlmvc; Initial catalog = Pronto_Vialagro; User ID = sa; Password =.SistemaPronto.; Connect Timeout = 500";
    //        var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(SC);
    //        var db = new ProntoMVC.Data.Models.DemoProntoEntities(scEF);

    //        var q = db.Clientes.Take(1).Select(x => new string [] { x.RazonSocial, x.Cuit }).SingleOrDefault();

    //        return q;
    //    }




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



     

        // POST: api/Default
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Default/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Default/5
        public void Delete(int id)
        {
        }

    }
}
