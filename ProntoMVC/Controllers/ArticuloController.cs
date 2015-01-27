using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Text;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
using System.Reflection;
using System.Configuration;
using Pronto.ERP.Bll;

using System.Data.SqlClient;

// using ProntoMVC.Controllers.Logica;

using System.Web.Security;

namespace ProntoMVC.Controllers
{
    //[Authorize(Roles = "Administrador,SuperAdmin,FacturaElectronica,Comercial")] //guarda con esto, que no van a responder los autocomplete

    public partial class ArticuloController : ProntoBaseController
    {

        //
        // GET: /Articulo/

        public virtual ViewResult Index()
        {

            if (db == null)
            {
                FormsAuthentication.SignOut();
                return View("ElegirBase", "Home");
            }

            var Articulos = db.Articulos
                //.Where(r => r.NumeroArticulo > 0)
                .OrderByDescending(r => r.IdArticulo); // .NumeroArticulo);


            string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster, "SELECT * FROM BASES");
            // List<string> baselistado = new List<string>();
            List<SelectListItem> baselistado = new List<SelectListItem>();
            foreach (DataRow r in dt.Rows)
            {
                baselistado.Add(new SelectListItem { Text = r["Descripcion"] as string, Value = "" });
            }


            ViewBag.Bases = baselistado; // baselistado; // new SelectList(dt.Rows, "IdBD", "Descripcion"); // StringConnection

            //DDLEmpresas.DataSource = EmpresaManager.GetEmpresasPorUsuario(SC, session(SESSIONPRONTO_UserId))
            //DDLEmpresas.DataTextField = "Descripcion"
            //DDLEmpresas.DataValueField = "Id"


            return View();
        }

        //
        // GET: /Articulo/Details/5

        public virtual ViewResult Details(int id)
        {
            Articulo Articulo = db.Articulos.Find(id);
            return View(Articulo);
        }

        //

        public virtual ViewResult IndexResumido()
        {

            if (db == null)
            {
                FormsAuthentication.SignOut();
                return View("ElegirBase", "Home");
            }

            var Articulos = db.Articulos
                //.Where(r => r.NumeroArticulo > 0)
                .OrderByDescending(r => r.IdArticulo); // .NumeroArticulo);


            string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster, "SELECT * FROM BASES");
            // List<string> baselistado = new List<string>();
            List<SelectListItem> baselistado = new List<SelectListItem>();
            foreach (DataRow r in dt.Rows)
            {
                baselistado.Add(new SelectListItem { Text = r["Descripcion"] as string, Value = "" });
            }


            ViewBag.Bases = baselistado; // baselistado; // new SelectList(dt.Rows, "IdBD", "Descripcion"); // StringConnection

            //DDLEmpresas.DataSource = EmpresaManager.GetEmpresasPorUsuario(SC, session(SESSIONPRONTO_UserId))
            //DDLEmpresas.DataTextField = "Descripcion"
            //DDLEmpresas.DataValueField = "Id"


            return View();
        }

        private bool Validar(ProntoMVC.Data.Models.Articulo o, ref string sErrorMsg)
        {
            // una opcion es extender el modelo autogenerado, para ensoquetar ahí las validaciones
            // si no, podemos usar una funcion como esta, y devolver los  errores de dos maneras:
            // con ModelState.AddModelError si los devolvemos en una ViewResult,
            // o con un array de strings si es una JsonResult.
            //
            // If you are returning JSON, you cannot use ModelState.
            // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json

            //if ((o.IdCliente ?? 0) <= 0)
            //{
            //    // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
            //    sErrorMsg += "\n" + "Falta el cliente";
            //    // return false;
            //}
            if ((o.Descripcion ?? "") == "") sErrorMsg += "\n" + "Falta la descripción";
            //// if (o.IdPuntoVenta== null) sErrorMsg += "\n" + "Falta el punto de venta";
            //if (o.IdCodigoIva == null) sErrorMsg += "\n" + "Falta el codigo de IVA";
            //if (o.IdCondicionVenta == null) sErrorMsg += "\n" + "Falta la condicion venta";
            //if (o.IdListaPrecios == null) sErrorMsg += "\n" + "Falta la lista de precios";


            if (sErrorMsg != "") return false;
            return true;

        }



        [HttpPost]
        public virtual JsonResult BatchUpdate([Bind(Exclude = "IdDetalleArticuloDocumento,IdDetalleArticuloUnidad")]  Articulo Articulo) // el Exclude es para las altas, donde el Id viene en 0
        {
            try
            {
                string erar = "";

                Articulo.FechaUltimaModificacion = DateTime.Now;


                if (!Validar(Articulo, ref erar))
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    List<string> errors = new List<string>();
                    errors.Add(erar);
                    return Json(errors);
                }



                if (ModelState.IsValid || true)
                {
                    // Perform Update
                    if (Articulo.IdArticulo > 0)
                    {

                        UpdateColecciones(ref Articulo);


                    }
                    //Perform Save
                    else
                    {
                        db.Articulos.Add(Articulo);




                        //var pv = (from item in db.PuntosVentas
                        //          where item.Letra == Articulo.TipoABC && item.PuntoVenta == Articulo.PuntoVenta
                        //             && item.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Articulo
                        //          select item).SingleOrDefault();

                        //// var pv = db.PuntosVenta.Where(p => p.IdPuntoVenta == Articulo.IdPuntoVenta).SingleOrDefault();
                        //pv.ProximoNumero += 1;

                        //   ClaseMigrar.AsignarNumeroATalonario(SC, myRemito.IdPuntoVenta, myRemito.Numero + 1);

                    }



                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    //using (Logica l = new Logica())  //shared, extension methods, sarasas
                    // http://stackoverflow.com/questions/511477/vb-net-shared-vs-c-sharp-static-accessibility-differences-why
                    // http://stackoverflow.com/questions/1188224/how-do-i-extend-a-class-with-c-sharp-extension-methods
                    // Singletons are essentially global data - they make your code hard to test (classes get coupled to the Singleton) 
                    // and (if mutable) hard to debug. Avoid them (and often static methods too) when possible. Consider using a DI/IoC Container library instead if you need to
                    //{
                    // Logica l = new Logica();
                    // si usas static, no tenes acceso al context
                    //Logica_ArticuloElectronica(Articulo);
                    //Logica_ActualizarCuentaCorriente(Articulo);
                    //Logica_RegistroContable(Articulo);
                    //Logica_RecuperoDeGastos(Articulo);
                    //Logica_Loguear(Articulo);
                    //Logica_ActualizarRemitos(Articulo);
                    //Logica_ActualizarOrdenesCompra(Articulo);
                    ////////////////////////////////////////////////////////////////////////////////
                    db.SaveChanges();
                    //}
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////



                    //http://stackoverflow.com/questions/2864972/how-to-redirect-to-a-controller-action-from-a-jsonresult-method-in-asp-net-mvc
                    //return RedirectToAction(( "Index",    "Articulo");
                    //redirectUrl = Url.Action("Index", "Home"), 
                    //isRedirect = true 

                    return Json(new { Success = 1, IdArticulo = Articulo.IdArticulo, ex = "" }); //, DetalleArticulos = Articulo.DetalleArticulos
                }
                else
                {
                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "La Articulo es inválida";
                    return Json(res);


                }



            }
            catch (System.Data.Entity.Validation.DbEntityValidationException ex)
            {
                //http://stackoverflow.com/questions/10219864/ef-code-first-how-do-i-see-entityvalidationerrors-property-from-the-nuget-pac
                StringBuilder sb = new StringBuilder();

                foreach (var failure in ex.EntityValidationErrors)
                {
                    sb.AppendFormat("{0} failed validation\n", failure.Entry.Entity.GetType());
                    foreach (var error in failure.ValidationErrors)
                    {
                        sb.AppendFormat("- {0} : {1}", error.PropertyName, error.ErrorMessage);
                        sb.AppendLine();
                    }
                }

                throw new System.Data.Entity.Validation.DbEntityValidationException(
                    "Entity Validation Failed - errors follow:\n" +
                    sb.ToString(), ex
                ); // Add the original exception as the innerException


            }
            catch (Exception ex)
            {
                // If Sucess== 0 then Unable to perform Save/Update Operation and send Exception to View as JSON
                JsonResponse res = new JsonResponse();

                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                //List<string> errors = new List<string>();
                //errors.Add(erar);
                //return Json(errors);

                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);
                res.Message = ex.Message.ToString();
                return Json(res);

                //return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }



        void UpdateColecciones(ref ProntoMVC.Data.Models.Articulo o)
        {
            // http://stackoverflow.com/questions/7968598/entity-4-1-updating-an-existing-parent-entity-with-new-child-entities

            var id = o.IdArticulo;
            var EntidadOriginal = db.Articulos.Where(p => p.IdArticulo == id)
                                    .Include(p => p.DetalleArticulosDocumentos)
                                    .Include(p => p.DetalleArticulosUnidades)
                                    .Include(p => p.DetalleArticulosImagenes)
                                    .SingleOrDefault();
            var EntidadEntry = db.Entry(EntidadOriginal);
            EntidadEntry.CurrentValues.SetValues(o);



            /////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////
            foreach (var dr in o.DetalleArticulosUnidades)
            {
                var DetalleEntidadOriginal = EntidadOriginal.DetalleArticulosUnidades.Where(c => c.IdDetalleArticuloUnidades == dr.IdDetalleArticuloUnidades && dr.IdDetalleArticuloUnidades > 0).SingleOrDefault();
                if (DetalleEntidadOriginal != null && dr.IdDetalleArticuloUnidades > 0)
                {
                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                    DetalleEntidadEntry.CurrentValues.SetValues(dr);
                }
                else
                {
                    EntidadOriginal.DetalleArticulosUnidades.Add(dr);
                }
            }

            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleArticulosUnidades.Where(c => c.IdDetalleArticuloUnidades != 0).ToList())
            {
                if (!o.DetalleArticulosUnidades.Any(c => c.IdDetalleArticuloUnidades == DetalleEntidadOriginal.IdDetalleArticuloUnidades))
                    EntidadOriginal.DetalleArticulosUnidades.Remove(DetalleEntidadOriginal);
            }

            /////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////

            foreach (var dr in o.DetalleArticulosDocumentos)
            {
                var DetalleEntidadOriginal = EntidadOriginal.DetalleArticulosDocumentos.Where(c => c.IdDetalleArticuloDocumentos == dr.IdDetalleArticuloDocumentos && dr.IdDetalleArticuloDocumentos > 0).SingleOrDefault();
                if (DetalleEntidadOriginal != null && dr.IdDetalleArticuloDocumentos > 0)
                {
                    // modificacion -ok, pero entonces el  IdDetalle no puede ser 0!

                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                    DetalleEntidadEntry.CurrentValues.SetValues(dr);
                }
                else
                {
                    // alta
                    EntidadOriginal.DetalleArticulosDocumentos.Add(dr);
                }
            }

            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleArticulosDocumentos.Where(c => c.IdDetalleArticuloDocumentos != 0).ToList())
            {
                if (!o.DetalleArticulosDocumentos.Any(c => c.IdDetalleArticuloDocumentos == DetalleEntidadOriginal.IdDetalleArticuloDocumentos))
                    EntidadOriginal.DetalleArticulosDocumentos.Remove(DetalleEntidadOriginal);
            }
            /////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////

            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;


        }




        public virtual ActionResult IBCondicionPorId(int id)
        {
            var o = db.IBCondiciones.Find(id);
            // y  JsonConvert.SerializeObject( ???

            return Json(new { o.Alicuota, o.AlicuotaPercepcion, o.AlicuotaPercepcionConvenio, o.ImporteTopeMinimoPercepcion }, JsonRequestBehavior.AllowGet);
        }


        /////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////
        // http://stackoverflow.com/questions/4690967/asp-net-mvc-3-json-model-binding-and-server-side-model-validation-mixed-with-cli

        public enum Status
        {
            Ok,
            Error
        }

        public class JsonResponse
        {
            public Status Status { get; set; }
            public string Message { get; set; }
            public List<string> Errors { get; set; }
        }
        private List<string> GetModelStateErrorsAsString(ModelStateDictionary state)
        {
            List<string> errors = new List<string>();

            foreach (var key in ModelState.Keys)
            {
                var error = ModelState[key].Errors.FirstOrDefault();
                if (error != null)
                {
                    errors.Add(error.ErrorMessage);
                }
            }

            return errors;
        }


        /////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////



        /// <summary>
        /// Get Json data for the grid
        /// </summary>
        /// <param name="sidx">Column to osrt on.  Do not change parameter name</param>
        /// <param name="sord">Sort direction.  Do not change parameter name</param>
        /// <param name="page">Current page.  Do not change parameter name</param>
        /// <param name="rows">Number of rows to get.  Do not change parameter name</param>
        /// <returns></returns>
        [HttpPost]
        public virtual ActionResult ArticulosGridData(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            var Articulos = db.Articulos.AsQueryable();
            if (_search)
            {

                Articulos = (from a in db.Articulos
                             where a.Descripcion.Contains(searchString) || a.Codigo.Contains(searchString)
                             select a).AsQueryable();

                // if (searchField == "Descripcion") { Articulos = (from a in db.Articulos where a.Descripcion.Contains(searchString) select a).AsQueryable(); }
                // else if (searchField == "Codigo") { Articulos = (from a in db.Articulos where a.Codigo.Contains(searchString) select a).AsQueryable(); }
            }

            int pageSize = rows ?? 20;
            int totalRecords = Articulos.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;
            string sortByColumnName = sidx ?? "Descripcion";
            string sortDirection = sord ?? "desc";

            if (sortByColumnName == "Descripcion")
            {
                if (sortDirection.Equals("desc"))
                    Articulos = Articulos.OrderByDescending(a => a.Descripcion);
                else
                    Articulos = Articulos.OrderBy(a => a.Descripcion);
            }
            else
            {
                if ("desc".Equals(sortDirection))
                    Articulos = Articulos.OrderByDescending(a => a.FechaUltimaModificacion);
                else
                    Articulos = Articulos.OrderBy(a => a.FechaUltimaModificacion);
            }




            var data = Articulos
                        .Include(x => x.Ubicacione)
                        .Include(x => x.Ubicacione.Deposito)
                        .Include(x => x.Rubro)
                        .Include(x => x.Subrubro)
                         .Skip((currentPage - 1) * pageSize).Take(pageSize).ToArray();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (
                    from a in data
                    select new jqGridRowJson
                    {
                        id = a.IdArticulo.ToString(),
                        cell = new string[] { 
                            //"<a href="+ Url.Action("Edit",new {id = a.IdArticulo} )  +" target='_blank' >Editar</>",
                            "<a href="+ Url.Action("Edit",new {id = a.IdArticulo} )  +"  >Editar</>",
                            "",
                            a.Codigo.NullSafeToString(), 
                            a.Descripcion.NullSafeToString(), 
                            
                            (a.Rubro ?? new Rubro()).Descripcion.NullSafeToString()   ,
                            (a.Subrubro ?? new Subrubro()).Descripcion.NullSafeToString()   ,
 
                            a.NumeroInventario ,  
                            a.AlicuotaIVA.NullSafeToString() ,  
                            a.CostoPPP.NullSafeToString(),  
                            a.CostoPPPDolar.NullSafeToString() ,  
                            a.CostoReposicion.NullSafeToString() ,  
                            a.CostoReposicionDolar.NullSafeToString(),  

                            a.StockMinimo.NullSafeToString(),  
                            a.StockReposicion.NullSafeToString() ,  

                            "0", // (Select Sum(Stock.CantidadUnidades) From Stock Where Stock.IdArticulo=Articulos.IdArticulo) as [Stock actual],  


                             (a.Unidad ?? new Unidad()).Abreviatura.NullSafeToString()   ,
                             
 
                             ((a.Ubicacione ?? new Ubicacion()).Deposito ?? new Data.Models.Deposito()).Descripcion.NullSafeToString() +
                             
                            (a.Ubicacione ?? new Ubicacion()).Descripcion.NullSafeToString() +
                            (a.Ubicacione ?? new Ubicacion()).Estanteria.NullSafeToString() +
                            (a.Ubicacione ?? new Ubicacion()).Modulo.NullSafeToString() +
                            (a.Ubicacione ?? new Ubicacion()).Gabeta.NullSafeToString() ,

                        
                            

                            a.FechaAlta.NullSafeToString(),  
                            a.UsuarioAlta.NullSafeToString(),  
                            a.FechaUltimaModificacion.NullSafeToString(),  
                            a.ParaMantenimiento.NullSafeToString() ,  
                            a.AuxiliarString10.NullSafeToString()   
 
                                        }



                    }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public virtual ActionResult ArticulosGridDataResumido(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            var Articulos = db.Articulos.AsQueryable();
            if (_search)
            {

                Articulos = (from a in db.Articulos
                             where a.Descripcion.Contains(searchString) || a.Codigo.Contains(searchString)
                             select a).AsQueryable();

                //if (searchField == "Descripcion") { Articulos = (from a in db.Articulos where a.Descripcion.Contains(searchString) select a).AsQueryable(); }
                //else if (searchField == "Codigo") { Articulos = (from a in db.Articulos where a.Codigo.Contains(searchString) select a).AsQueryable(); }
            }

            int pageSize = rows ?? 20;
            int totalRecords = Articulos.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;
            string sortByColumnName = sidx ?? "Descripcion";
            string sortDirection = sord ?? "desc";

            if (sortByColumnName == "Descripcion")
            {
                if (sortDirection.Equals("desc"))
                    Articulos = Articulos.OrderByDescending(a => a.Descripcion);
                else
                    Articulos = Articulos.OrderBy(a => a.Descripcion);
            }
            else
            {
                if ("desc".Equals(sortDirection))
                    Articulos = Articulos.OrderByDescending(a => a.FechaUltimaModificacion);
                else
                    Articulos = Articulos.OrderBy(a => a.FechaUltimaModificacion);
            }




            var data = Articulos
                        .Include(x => x.Ubicacione)
                        .Include(x => x.Ubicacione.Deposito)
                        .Include(x => x.Rubro)
                        .Include(x => x.Subrubro)
                         .Skip((currentPage - 1) * pageSize).Take(pageSize).ToArray();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (
                    from a in data
                    select new jqGridRowJson
                    {
                        id = a.IdArticulo.ToString(),
                        cell = new string[] { 
                            //"<a href="+ Url.Action("Edit",new {id = a.IdArticulo} )  +" target='_blank' >Editar</>",
                            "<a href="+ Url.Action("Edit",new {id = a.IdArticulo} )  +"  >Editar</>",
                            "",
                            a.Codigo.NullSafeToString(), 
                            a.Descripcion.NullSafeToString(), 
                            
                            (a.Rubro ?? new Rubro()).Descripcion.NullSafeToString()   ,
                            (a.Subrubro ?? new Subrubro()).Descripcion.NullSafeToString()   ,
 
                            a.NumeroInventario  
                            
 
                                        }



                    }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }






        //[HttpPost]
        //public ActionResult Create(Articulo Articulo)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.Articulos.Add(Articulo);
        //        db.SaveChanges();
        //        return RedirectToAction("Index");  
        //    }

        //    ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", Articulo.IdObra);
        //    ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Articulo.Aprobo);
        //    ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Articulo.IdSolicito);
        //    ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", Articulo.IdSector);
        //    return View(Articulo);
        //}


        public virtual FileResult Imprimir(int id) //(int id)
        {
            // string sBasePronto = (string)rc.HttpContext.Session["BasePronto"];
            // db = new DemoProntoEntities(Funciones.Generales.sCadenaConex(sBasePronto));

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));

            //  string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString);
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.docx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "ArticuloNET_Hawk.docx";
            /*
            string plantilla = Pronto.ERP.Bll.OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.ArticuloA, SC);
            */

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();



            System.IO.File.Copy(plantilla, output); // 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 
            //Pronto.ERP.BO.Articulo fac = ArticuloManager.GetItem(SC, id, true);
            //OpenXML_Pronto.ArticuloXML_DOCX(output, fac, SC);

            //byte[] contents = ;
            //return File(contents, "application/octet-stream");

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "Articulo.docx");
        }


        void inic(ref Articulo o)
        {
            //o.PorcentajeIva1 = 21;                  //  mvarP_IVA1_Tomado
            //o.FechaArticulo = DateTime.Now;

            //Parametros parametros = db.Parametros.Find(1);
            //o.OtrasPercepciones1 = 0;
            //o.OtrasPercepciones1Desc = ((parametros.OtrasPercepciones1 ?? "NO") == "SI") ? parametros.OtrasPercepciones1Desc : "";
            //o.OtrasPercepciones2 = 0;
            //o.OtrasPercepciones2Desc = ((parametros.OtrasPercepciones2 ?? "NO") == "SI") ? parametros.OtrasPercepciones2Desc : "";
            //o.OtrasPercepciones3 = 0;
            //o.OtrasPercepciones3Desc = ((parametros.OtrasPercepciones3 ?? "NO") == "SI") ? parametros.OtrasPercepciones3Desc : "";

            //mvarP_IVA1 = .Fields("Iva1").Value
            //mvarP_IVA2 = .Fields("Iva2").Value
            //mvarPorc_IBrutos_Cap = .Fields("Porc_IBrutos_Cap").Value
            //mvarTope_IBrutos_Cap = .Fields("Tope_IBrutos_Cap").Value
            //mvarPorc_IBrutos_BsAs = .Fields("Porc_IBrutos_BsAs").Value
            //mvarTope_IBrutos_BsAs = .Fields("Tope_IBrutos_BsAs").Value
            //mvarPorc_IBrutos_BsAsM = .Fields("Porc_IBrutos_BsAsM").Value
            //mvarTope_IBrutos_BsAsM = .Fields("Tope_IBrutos_BsAsM").Value
            //mvarDecimales = .Fields("Decimales").Value
            //mvarAclaracionAlPie = .Fields("AclaracionAlPieDeArticulo").Value
            //mvarIdMonedaPesos = .Fields("IdMoneda").Value
            //mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
            //mvarPercepcionIIBB = IIf(IsNull(.Fields("PercepcionIIBB").Value), "NO", .Fields("PercepcionIIBB").Value)
            //mvarOtrasPercepciones1 = IIf(IsNull(.Fields("OtrasPercepciones1").Value), "NO", .Fields("OtrasPercepciones1").Value)
            //mvarOtrasPercepciones1Desc = IIf(IsNull(.Fields("OtrasPercepciones1Desc").Value), "", .Fields("OtrasPercepciones1Desc").Value)
            //mvarOtrasPercepciones2 = IIf(IsNull(.Fields("OtrasPercepciones2").Value), "NO", .Fields("OtrasPercepciones2").Value)
            //mvarOtrasPercepciones2Desc = IIf(IsNull(.Fields("OtrasPercepciones2Desc").Value), "", .Fields("OtrasPercepciones2Desc").Value)
            //mvarOtrasPercepciones3 = IIf(IsNull(.Fields("OtrasPercepciones3").Value), "NO", .Fields("OtrasPercepciones3").Value)
            //mvarOtrasPercepciones3Desc = IIf(IsNull(.Fields("OtrasPercepciones3Desc").Value), "", .Fields("OtrasPercepciones3Desc").Value)
            //mvarConfirmarClausulaDolar = IIf(IsNull(.Fields("ConfirmarClausulaDolar").Value), "NO", .Fields("ConfirmarClausulaDolar").Value)
            //mvarNumeracionUnica = False
            //If .Fields("NumeracionUnica").Value = "SI" Then mvarNumeracionUnica = True
            //gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)


            // db.Cotizaciones_TX_PorFechaMoneda(fecha,IdMoneda)
            //var mvarCotizacion = 4.95; //  mo  Cotizacion(Date, glbIdMonedaDolar);
            //o.CotizacionMoneda = 1;
            ////  o.CotizacionADolarFijo=
            //o.CotizacionDolar = (decimal)mvarCotizacion;


        }



        // GET: /Articulo/Edit/5
        public virtual ActionResult Edit(int id)
        {

            Articulo o;
            if (id <= 0)
            {

                o = new Articulo();

                //string connectionString = Generales.sCadenaConexSQL(this.Session["BasePronto"].ToString());
                //o.NumeroArticulo = (int)Pronto.ERP.Bll.ArticuloManager.ProximoNumeroArticuloPorIdCodigoIvaYNumeroDePuntoVenta(connectionString, 1, 6);
                //if (o.NumeroArticulo == -1) o.NumeroArticulo = null;

                inic(ref o);

            }
            else
            {
                o = db.Articulos
                    .Include(x => x.Rubro)
                    .Include(x => x.Subrubro)
                    .SingleOrDefault(x => x.IdArticulo == id);


            }
            CargarViewBag(o);





            //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Articulo.Aprobo);
            //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Articulo.IdSolicito);
            //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", Articulo.IdSector);
            // Session.Add("Articulo", o);
            return View(o);
        }


        public virtual ActionResult RefrescarMascara(Articulo o)  // (IdRubro,IdSubRubro) 
        {
            CargarViewBag(o);
            return PartialView("PartialMascara", o);
        }



        void CargarViewBag(Articulo o)
        {

            // verificar que pongo el cuarto parametro de SelectList que elige el item del combo 




            ViewBag.IdRubro = new SelectList(db.Rubros, "IdRubro", "Descripcion", o.IdRubro);
            ViewBag.IdSubrubro = new SelectList(db.Subrubros, "IdSubrubro", "Descripcion", o.IdSubrubro);


            var q = (from i in db.DefinicionArticulos where (i.IdRubro == o.IdRubro && i.IdSubrubro == o.IdSubrubro) orderby i.Orden select i).ToList();
            ViewBag.Mascara = q;

            var SC = Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString());
            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC);

            foreach (ProntoMVC.Data.Models.DefinicionArticulo x in q)
            {

                if (x.TablaCombo == null && x.CampoSiNo != "SI") continue;

                DataTable dt;

                try
                {



                    if (x.CampoSiNo == "SI" || x.TablaCombo == "SiNo")
                    {
                        //ViewData.Add(x.Campo, new SelectList(db.Subrubros, "IdSubrubro", "Descripcion", o.IdSubrubro));

                        //EntidadManager.ExecDinamico(SC,"SELECT " & .campocombo "," & Titul  & "  FROM " &  .TablaCombo & "")

                        dt = EntidadManager.GetStoreProcedure(SC, "SiNo_TL");
                        // ViewData.Add(x.Campo, new SelectList(dt, x.Campo, "Titulo",     o.pr   ));

                        // entitylist.Select(p => p.GetType().GetProperty("PropertyName").GetValue(p, null));
                    }
                    else
                    {
                        // ViewData.Add(x.Campo, new SelectList(db.Subrubros, "IdSubrubro", "Descripcion", o.IdSubrubro));
                        dt = EntidadManager.GetStoreProcedure(SC, x.TablaCombo + "_TL");

                    }

                    IEnumerable<DataRow> rows = dt.AsEnumerable();
                    var sq = (from r in rows select new { id = r[0], texto = r[1] }).ToList();

                    var valor = o.GetType().GetProperty(x.Campo).GetValue(o, null);
                    // var lista = new SelectList(rows, x.CampoCombo, "Titulo", valor);
                    var lista = new SelectList(sq, "id", "texto", valor);
                    //var lista = new SelectList(rows, valor);


                    ViewData.Add(x.Campo, lista);


                }
                catch (Exception e)
                {
                    ErrHandler.WriteError(e);
                    //EntidadManager.LogPronto();
                    //throw;
                }


                //If .CampoSiNo = "SI" Then
                //      'cmbSubrubro.DataSource = EntidadManager.ExecDinamico(SC,"SELECT " & .campocombo "," & Titul  & "  FROM " &  .TablaCombo & "")
                //      dt = EntidadManager.GetStoreProcedure(SC, "SiNo_TL")
                //  Else
                //      dt = EntidadManager.GetStoreProcedure(SC, .TablaCombo & "_TL")
                //  End If
                //  comboDinamico.DataSource = dt
                //  'cmbSubrubro.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, .TablaCombo)
                //  comboDinamico.DataTextField = "Titulo"
                //  If .TablaCombo = "SiNo" Or .CampoSiNo = "SI" Then
                //      comboDinamico.DataValueField = "IdSiNo"
                //  Else
                //      comboDinamico.DataValueField = .CampoCombo
                //  End If
            }






            //ViewBag.PuntoVenta = new SelectList((from i in db.PuntosVentas
            //                                     where i.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Articulo
            //                                     select new { PuntoVenta = i.PuntoVenta })
            //     http://stackoverflow.com/questions/2135666/databinding-system-string-does-not-contain-a-property-with-the-name-dbmake
            //                                     .Distinct(), "PuntoVenta", "PuntoVenta"); //traer solo el Numero de PuntoVenta, no el Id


            //ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", o.IdObra);
            //ViewBag.IdCliente = new SelectList(db.Clientes, "IdCliente", "RazonSocial", o.IdCliente);
            //ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion", o.IdCodigoIva);
            //ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", o.IdCodigoIva);
            //ViewBag.IdListaPrecios = new SelectList(db.ListasPrecios, "IdListaPrecios", "Descripcion", o.IdListaPrecios);
            //ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            //ViewBag.IdCondicionVenta = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionVenta);
            //ViewBag.IdIBCondicionPorDefecto = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);
            //ViewBag.IdIBCondicionPorDefecto2 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion2);
            //ViewBag.IdIBCondicionPorDefecto3 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion3);

        }

        // POST: /Articulo/Edit/5
        [HttpPost]
        public virtual ActionResult Edit(Articulo Articulo)
        {
            if (ModelState.IsValid)
            {
                db.Entry(Articulo).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            //ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", Articulo.IdObra);
            //ViewBag.IdCliente = new SelectList(db.Clientes, "IdCliente", "RazonSocial", Articulo.IdCliente);
            ////ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Articulo.Aprobo);
            //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Articulo.IdSolicito);
            //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", Articulo.IdSector);
            return View(Articulo);
        }

        // GET: /Articulo/Delete/5
        public virtual ActionResult Delete(int id)
        {
            Articulo Articulo = db.Articulos.Find(id);
            return View(Articulo);
        }

        // POST: /Articulo/Delete/5
        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Articulo Articulo = db.Articulos.Find(id);
            db.Articulos.Remove(Articulo);
            db.SaveChanges();
            return RedirectToAction("Index");
        }


        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////

        public virtual ActionResult DetDocumentos(string sidx, string sord, int? page, int? rows, int? Id)
        {
            int IdArticulo1 = Id ?? 0;
            var DetEntidad = db.DetalleArticulosDocumentos.Where(p => p.IdArticulo == IdArticulo1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select new
                        {
                            a.IdDetalleArticuloDocumentos,
                            a.PathDocumento
                        }).OrderBy(p => p.IdDetalleArticuloDocumentos).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();


            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleArticuloDocumentos.ToString(),
                            cell = new string[] { 
                                string.Empty, // guarda con este espacio vacio
                                a.IdDetalleArticuloDocumentos.ToString(),
                                a.PathDocumento.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public void EditGridData(int? IdArticulo, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
        {
            switch (oper)
            {
                case "add": //Validate Input ; Add Method
                    break;
                case "edit":  //Validate Input ; Edit Method
                    break;
                case "del": //Validate Input ; Delete Method
                    break;
                default: break;
            }

        }

        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////

        public virtual ActionResult DetUnidades(string sidx, string sord, int? page, int? rows, int? Id)
        {
            int IdArticulo1 = Id ?? 0;
            var DetEntidad = db.DetalleArticulosUnidades.Where(p => p.IdArticulo == IdArticulo1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select new
                        {
                            a.IdDetalleArticuloUnidades,
                            a.IdUnidad,
                            a.Unidade,
                            a.Equivalencia
                        }).OrderBy(p => p.IdDetalleArticuloUnidades).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();


            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleArticuloUnidades.ToString(),
                            cell = new string[] { 
                                string.Empty, // guarda con este espacio vacio
                                a.IdDetalleArticuloUnidades.ToString(),
                                a.IdUnidad.NullSafeToString(),
                                (a.Unidade ?? new Unidad()).Abreviatura.NullSafeToString(),
                                a.Equivalencia.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        //[HttpPost]
        //public void EditGridData(int? IdArticulo, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
        //{
        //    switch (oper)
        //    {
        //        case "add": //Validate Input ; Add Method
        //            break;
        //        case "edit":  //Validate Input ; Edit Method
        //            break;
        //        case "del": //Validate Input ; Delete Method
        //            break;
        //        default: break;
        //    }

        //}

        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////





        //[HttpPost]
        //public ActionResult Articulos2(string sidx, string sord, int? page, int? rows, bool _search, string filters) //, string searchField, string searchOper, string searchString)
        //{
        //    var serializer = new JavaScriptSerializer();
        //    Filters f = (!_search || string.IsNullOrEmpty(filters)) ? null : serializer.Deserialize<Filters>(filters);
        //    ObjectQuery<Articulo> filteredQuery = (f == null ? db.Articulos : f.FilterObjectSet(db.Articulos));
        //    filteredQuery.MergeOption = MergeOption.NoTracking; // we don't want to update the data
        //    var totalRecords = filteredQuery.Count();

        //    var pagedQuery = filteredQuery.Skip("it." + sidx + " " + sord, "@skip",
        //                                        new ObjectParameter("skip", (page - 1) * rows))
        //                                 .Top("@limit", new ObjectParameter("limit", rows));
        //    // to be able to use ToString() below which is NOT exist in the LINQ to Entity
        //    var queryDetails = (from item in pagedQuery
        //                        select new { item.IdArticulo, item.FechaArticulo, item.Detalle }).ToList();

        //    return Json(new
        //    {
        //        total = (totalRecords + rows - 1) / rows,
        //        page,
        //        records = totalRecords,
        //        rows = (from item in queryDetails
        //                select new[] {
        //                                item.IdArticulo.ToString(),
        //                                item.FechaArticulo.ToString(),
        //                                item.Detalle
        //                            }).ToList()
        //    });
        //}






        [HttpPost]
        public virtual ActionResult Uploadfile(System.ComponentModel.Container containers, HttpPostedFileBase file)
        {

            if (file.ContentLength > 0)
            {
                var fileName = System.IO.Path.GetFileName(file.FileName);
                var path = ""; //  = System.IO.Path.Combine(Server.MapPath("~/App_Data/Uploads"), containers.ContainerNo);
                file.SaveAs(path);
            }

            return RedirectToAction("Index");
        }




        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////

        [HttpPost]
        public virtual JsonResult UpdateAwesomeGridData(string formulario, string grilla) // (IEnumerable<GridBoundViewModel> gridData)
        {
            // How to send jqGrid row data to server with form data
            // http://forums.asp.net/t/1702990.aspx/1

            //     http://stackoverflow.com/questions/10744694/submitting-jqgrid-row-data-from-view-to-controller-what-method
            //     http://stackoverflow.com/questions/11084066/jqgrid-get-json-data
            //            EDIT - Solution
            //For any other people that are as dumb as I am, here's how I got it to work:
            //First, on Oleg's suggestion, I added loadonce: true to the jqGrid definition. 
            // Then, changed my submit button function as follows:
            //
            // $("#submitButton").click(function () {
            //    var griddata = $("#awesomeGrid").jqGrid('getGridParam', 'data');
            //    var dataToSend = JSON.stringify(griddata);
            //    $.ajax({
            //        url: '@Url.Action("UpdateAwesomeGridData")',
            //        type: 'POST',
            //        contentType: 'application/json; charset=utf-8',
            //        data: dataToSend,
            //        dataType: 'json',
            //        success: function (result) {
            //            alert('success: ' + result.result);
            //        }
            //    });
            //    return true;
            //});
            //Then, changed my controller method signature:
            //public ActionResult UpdateAwesomeGridData(IEnumerable<GridBoundViewModel> gridData)
            //Hope this helps someone in the future.




            JavaScriptSerializer serializer = new JavaScriptSerializer();
            var myListOfData = serializer.Deserialize<List<List<string>>>(grilla);

            if (ModelState.IsValid)
            {
                string tipomovimiento = "";
                //if (Cliente.IdCliente > 0)
                //{


                //}


                // return RedirectToAction("Index");
            }

            //return View(); // View(Cliente);

            return Json(new { Success = 0, ex = "" });
        }






        public virtual ActionResult RemitosPendienteArticulocion(string sidx, string sord, int? page, int? rows,
                              bool _search, string searchField, string searchOper, string searchString,
                              string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;


            // el Include no se lleva bien con el Join    http://blogs.msdn.com/b/alexj/archive/2009/06/02/tip-22-how-to-make-include-really-include.aspx   y  http://stackoverflow.com/questions/794283/linq-to-entities-include-method-not-loading


            var Fac = db.DetalleRemitos
                        .Include(x => x.Remito).Include(x => x.Remito.Cliente).Include(x => x.Articulo).Include(x => x.Unidade)
                        .AsQueryable();  // si queres usar include, no usar "select new" mezclando con join



            //if (IdObra != string.Empty)
            //{
            //    int IdObra1 = Convert.ToInt32(IdObra);
            //    Fac = (from a in Fac where a.IdObra == IdObra1 select a).AsQueryable();
            //}
            //if (FechaInicial != string.Empty)
            //{
            //    DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            //    DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            //    Fac = (from a in Fac where a.FechaCliente >= FechaDesde && a.FechaCliente <= FechaHasta select a).AsQueryable();
            //}
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numeroCliente":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaCliente":
                        //No anda
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                    default:
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                }
            }
            else
            {
                campo = "true";
            }

            var Req1 = (from a in Fac
                        select new { a }
                        ).Where(campo).AsQueryable();

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Fac
                        //join c in db.IngresoBrutos on a.IdIBCondicion equals c.IdIBCondicion
                        select a).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleRemito.NullSafeToString(),
                            cell = new string[] { 
                                
                                "<a href="+ Url.Action("Edit",new {id = a.IdDetalleRemito} )  +" target='_blank' >Editar</>" 
                                ,
                                a.IdDetalleRemito.NullSafeToString(),
                                a.IdArticulo.NullSafeToString(),
                                                                 (a.Articulo ?? new Articulo()).Codigo.NullSafeToString(),

                                (a.Articulo ?? new Articulo()).Descripcion.NullSafeToString(),
                                a.Precio.NullSafeToString(),
                                a.Cantidad.NullSafeToString(),
                                a.IdUnidad.NullSafeToString(),
                                (a.Unidade ?? new Unidad()).Descripcion.NullSafeToString(),
                                a.Remito.IdCliente.NullSafeToString(),
                                a.Remito.Cliente.RazonSocial.NullSafeToString()
                                
 
                                
                            
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }





        const int MAXLISTA = 100;








        public virtual ActionResult OrdenesCompraPendientesArticulor(string sidx, string sord, int? page, int? rows,
                                 bool _search, string searchField, string searchOper, string searchString,
                                 string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.DetalleOrdenesCompras
                        .Include(x => x.OrdenesCompra).Include(x => x.OrdenesCompra.Cliente)
                        .Include(x => x.Articulo).Include(x => x.Unidade)
                        .AsQueryable();  // si queres usar include, no usar "select new" mezclando con join


            //if (IdObra != string.Empty)
            //{
            //    int IdObra1 = Convert.ToInt32(IdObra);
            //    Fac = (from a in Fac where a.IdObra == IdObra1 select a).AsQueryable();
            //}
            //if (FechaInicial != string.Empty)
            //{
            //    DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            //    DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            //    Fac = (from a in Fac where a.FechaCliente >= FechaDesde && a.FechaCliente <= FechaHasta select a).AsQueryable();
            //}
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numeroCliente":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaCliente":
                        //No anda
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                    default:
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                }
            }
            else
            {
                campo = "true";
            }

            var Req1 = (from a in Fac
                        select new
                        {
                            a
                            //NumeroObra=a.Obra.NumeroObra,
                            //Libero=a.Empleados.Nombre,
                            //Aprobo = a.Empleados1.Nombre,
                            //Sector=a.Sectores.Descripcion,
                            //Detalle=a.Detalle
                        }).Where(campo).AsQueryable(); // .ToList();

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Fac
                        //join c in db.IngresoBrutos on a.IdIBCondicion equals c.IdIBCondicion
                        select a).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleOrdenCompra.ToString(),
                            cell = new string[] { 
                                
                                "<a href="+ Url.Action("Edit",new {id = a.IdDetalleOrdenCompra} )  +" target='_blank' >Editar</>" 
                                ,
                                   a.IdDetalleOrdenCompra.NullSafeToString(),
                                a.IdArticulo.NullSafeToString(),
                                 (a.Articulo ?? new Articulo()).Codigo.NullSafeToString(),
                               (a.Articulo ?? new Articulo()).Descripcion.NullSafeToString(),
                                a.Precio.NullSafeToString(),
                                a.Cantidad.NullSafeToString(),
                                                                a.IdUnidad.NullSafeToString(),
                                 (a.Unidade ?? new Unidad()).Descripcion.NullSafeToString(),
                                
                                a.OrdenesCompra.Cliente.RazonSocial.NullSafeToString(),
                           
                               a.OrdenesCompra.IdCliente.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Articulos()
        {
            Dictionary<int, string> articulos = new Dictionary<int, string>();
            foreach (Articulo a in db.Articulos.ToList())
                articulos.Add(a.IdArticulo, a.Descripcion);
            return PartialView("Select", articulos);
        }

        public virtual JsonResult GetArticulosAutocomplete(string term)
        {
            return Json((from item in db.Articulos
                         where item.Descripcion.Contains(term)
                         select new
                         {
                             value = item.IdArticulo,
                             title = item.Descripcion,
                             codigo = item.Codigo
                         }).ToList(),
                         JsonRequestBehavior.AllowGet);
        }

        public virtual ContentResult GetCodigosArticulosAutocomplete(string q, int limit, Int64 timestamp)
        {
            StringBuilder responseContentBuilder = new StringBuilder();
            var Articulos = (from a in db.Articulos select new { a.IdArticulo, a.Codigo, a.Descripcion }).Where(a => a.Codigo.StartsWith(q)).OrderBy(a => a.Codigo).Take(limit);

            foreach (var a in Articulos)
                responseContentBuilder.Append(String.Format("{0}|{1}|{2}\n", a.IdArticulo, a.Codigo, a.Descripcion));

            return Content(responseContentBuilder.ToString());
        }

        public virtual JsonResult GetCodigosArticulosAutocomplete2(string term)
        {

            var q = (from item in db.Articulos
                     where item.Codigo.StartsWith(term)
                     orderby item.Codigo
                     select new
                     {
                         id = item.IdArticulo,


                         //value = SqlFunctions.StringConvert(item.Codigo)  + " " + item.Descripcion, // esto es lo que se ve
                         //value = item.Codigo + " " + item.Descripcion, // esto es lo que se ve   //problemas con el collate
                         value = item.Codigo, // esto es lo que se ve
                         codigo = item.Codigo,
                         title = item.Descripcion, // esto es lo que se pega

                         iva = item.AlicuotaIVA,
                         IdUnidad = item.IdUnidad,
                         Unidad = item.Unidad.Abreviatura
                     }).Take(MAXLISTA).ToList();



            if (q.Count == 0 && term != "No se encontraron resultados")
            {
                q.Add(new { id = 0, value = "No se encontraron resultados", codigo = "", title = "", iva = (decimal?)0, IdUnidad = (int?)0, Unidad = "" });
            }

            var a = Json(q, JsonRequestBehavior.AllowGet);


            return a;
        }

        //public virtual JsonResult GetArticulosAutocomplete2(string term)
        //{
        //    var q = (from item in db.Articulos
        //             where item.Descripcion.StartsWith(term)
        //             orderby item.Descripcion
        //             select new
        //             {
        //                 id = item.IdArticulo,
        //                 value = item.Descripcion,
        //                 codigo = item.Codigo
        //             }).Take(20).ToList();

        //    if (q.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

        //    return Json(q, JsonRequestBehavior.AllowGet);
        //}

        public virtual JsonResult GetArticulosAutocomplete2(string term)
        {


            Parametros parametros = db.Parametros.Find(1);
            int mvarIdUnidadCU = parametros.IdUnidadPorUnidad ?? 0;
            string mvarIdUnidadCUdesc;

            try
            {
                mvarIdUnidadCUdesc = mvarIdUnidadCU > 0 ? (db.Unidades.Find(mvarIdUnidadCU) ?? new Unidad()).Abreviatura : "";
            }
            catch (Exception ex)
            {
                ErrHandler.WriteError(ex);
                mvarIdUnidadCUdesc = "";
            }

            var s = parametros.IdControlCalidadStandar;
            var s2 = parametros.ControlCalidadDefault;



            var q = (from item in db.Articulos
                     where item.Descripcion.ToLower().Contains(term.ToLower())   //.StartsWith(term.ToLower())
                     //            where SqlFunctions.StringConvert((decimal?)item.IdArticulo).Contains(term) ||

                     orderby item.Descripcion
                     select new
                     {
                         id = item.IdArticulo,
                         value = item.Descripcion,
                         codigo = item.Codigo,
                         iva = item.AlicuotaIVA,
                         IdUnidad = item.IdUnidad ?? mvarIdUnidadCU,
                         Unidad = item.Unidad.Abreviatura ?? mvarIdUnidadCUdesc
                     }).Take(MAXLISTA).ToList();


            if (q.Count == 0 && term != "No se encontraron resultados")
            {
                q.Add(new { id = 0, value = "No se encontraron resultados", codigo = "", iva = (decimal?)0, IdUnidad = 0, Unidad = "" });
            }



            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetObrasAutocomplete2(string term)
        {




            var q = (from item in db.Obras
                     where (item.NumeroObra.ToLower() + " - " + item.Descripcion.ToLower()).Contains(term.ToLower())
                           && item.Activa != "NO"
                     //.StartsWith(term.ToLower())
                     //            where SqlFunctions.StringConvert((decimal?)item.IdArticulo).Contains(term) ||

                     orderby item.NumeroObra
                     select new
                     {
                         id = item.IdObra,
                         value = item.NumeroObra + " - " + (item.Descripcion ?? ""),
                         descripcion = (item.Descripcion ?? "")
                         // NumeroObra = y.NumeroObra + " - " + (y.Descripcion ?? "")
                         //iva = item.AlicuotaIVA,
                         //IdUnidad = item.IdUnidad,
                         //Unidad = item.Unidad.Abreviatura
                     }).Take(MAXLISTA).ToList();



            if (q.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetIdsArticulosAutocomplete(string term)
        {
            return Json((from item in db.Articulos
                         where SqlFunctions.StringConvert((decimal?)item.IdArticulo).Contains(term)
                         select new
                         {
                             value = item.IdArticulo,
                             title = item.Descripcion
                         }).ToList(),
                         JsonRequestBehavior.AllowGet);
        }



        private string GetFilter(string searchingName, JqGridSearchOperators searchingOperator, string searchingValue)
        {
            string searchingOperatorString = String.Empty;
            switch (searchingOperator)
            {
                case JqGridSearchOperators.Eq:
                    searchingOperatorString = "=";
                    break;
                case JqGridSearchOperators.Ne:
                    searchingOperatorString = "!=";
                    break;
                case JqGridSearchOperators.Lt:
                    searchingOperatorString = "<";
                    break;
                case JqGridSearchOperators.Le:
                    searchingOperatorString = "<=";
                    break;
                case JqGridSearchOperators.Gt:
                    searchingOperatorString = ">";
                    break;
                case JqGridSearchOperators.Ge:
                    searchingOperatorString = ">=";
                    break;
            }

            if ((searchingName == "ProductID") || (searchingName == "SupplierID") || (searchingName == "CategoryID"))
                return String.Format("{0} {1} {2}", searchingName, searchingOperatorString, searchingValue);

            if ((searchingName == "ProductName"))
            {
                switch (searchingOperator)
                {
                    case JqGridSearchOperators.Bw:
                        return String.Format("{0}.StartsWith(\"{1}\")", searchingName, searchingValue);
                    case JqGridSearchOperators.Bn:
                        return String.Format("!{0}.StartsWith(\"{1}\")", searchingName, searchingValue);
                    case JqGridSearchOperators.Ew:
                        return String.Format("{0}.EndsWith(\"{1}\")", searchingName, searchingValue);
                    case JqGridSearchOperators.En:
                        return String.Format("!{0}.EndsWith(\"{1}\")", searchingName, searchingValue);
                    case JqGridSearchOperators.Cn:
                        return String.Format("{0}.Contains(\"{1}\")", searchingName, searchingValue);
                    case JqGridSearchOperators.Nc:
                        return String.Format("!{0}.Contains(\"{1}\")", searchingName, searchingValue);
                    default:
                        return String.Format("{0} {1} \"{2}\"", searchingName, searchingOperatorString, searchingValue);
                }
            }

            return String.Empty;
        }

        public virtual JsonResult GetUnidades()
        {
            //Dictionary<int, string> unidades = new Dictionary<int, string>();
            //foreach (Unidad u in db.Unidades.ToList())
            //    unidades.Add(u.IdUnidad, u.Abreviatura);
            var unidades = (from u in db.Unidades
                            select new { u.IdUnidad, u.Descripcion }).ToList();

            return Json(unidades, JsonRequestBehavior.AllowGet);
            //return PartialView("Select", unidades);
        }

        public virtual ActionResult Unidades()
        {
            Dictionary<int, string> unidades = new Dictionary<int, string>();
            foreach (Unidad u in db.Unidades.OrderBy(x => x.Abreviatura).ToList())
                unidades.Add(u.IdUnidad, u.Abreviatura);

            return PartialView("Select", unidades);

            //var aaa = (from item in unidades
            //           select new
            //           {
            //               value = item.Key,
            //               title = item.Value
            //           }).ToList();

            //return PartialView("Select", aaa);
        }


        /// <summary>
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// </summary>

        // static public class Logica    {








        // Trae los articulos desde un store procedure
        public virtual ActionResult ArticulosGridDataSP(string sidx, string sord, int? page, int? rows)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;
            List<Articulo> Articulos = ProntoMVC.Models.ArticuloDAL.SelectArticulos("filtro", this.Session["BasePronto"].ToString());
            int totalRecords = Articulos.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            var data = Articulos.Skip((currentPage - 1) * pageSize).Take(pageSize).ToArray();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (
                    from a in data
                    select new jqGridRowJson
                    {
                        id = a.IdArticulo.ToString(),
                        cell = new string[] { 
                            "<a href='" + string.Format("./Articulo/Edit/{0}", a.IdArticulo.ToString()) + "'>Edit</a>",
                            "<a href='" + string.Format("./Articulo/Delete/{0}", a.IdArticulo.ToString()) + "'>Delete</a>",
                            a.Codigo, 
                            a.Descripcion } //a.PostedOn.Value.ToShortDateString()
                    }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult ArticulosGridData2(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Articulos = db.Articulos.AsQueryable();
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "idarticulo":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    default:
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                }
            }
            else
            {
                campo = "true";
            }

            var Articulos1 = (from a in Articulos select a).Where(campo).Select(a => a.IdArticulo);



            int totalRecords = Articulos1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Articulos
                        select new
                        {
                            IdArticulo = a.IdArticulo,
                            Codigo = a.Codigo,
                            Descripcion = a.Descripcion,
                            IdUnidad = a.IdUnidad,
                            Unidad = a.Unidad.Abreviatura,
                            Iva = a.AlicuotaIVA
                        }).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdArticulo.ToString(),
                            cell = new string[] { 
                                a.IdArticulo.ToString(), 
                                a.Codigo,
                                a.Descripcion,
                                a.IdUnidad.ToString(),
                                a.Unidad,
                                a.Iva.ToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }






        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // genericas que devuelven json


        /// <summary>

        /// </summary>
        /// <param name="sp"></param>
        /// <param name="p1"></param>
        /// <param name="p2"></param>
        /// <param name="p3"></param>
        /// <param name="p4"></param>
        /// <param name="p5"></param>
        /// <param name="p6"></param>
        /// <param name="p7"></param>
        /// <returns></returns>




        public virtual JsonResult GetStoreProc(string sp, string p1, string p2, string p3, string p4, string p5, string p6, string p7)
        {
            //Dictionary<int, string> unidades = new Dictionary<int, string>();
            //foreach (Unidad u in db.Unidades.ToList())
            //    unidades.Add(u.IdUnidad, u.Abreviatura);

            SqlParameter[] parametros;
            SqlParameter storedParam = new SqlParameter("@ip", p1);

            //var dt = TablasDAL.GetStore(this.Session["BasePronto"].ToString(), sp, parametros);
            var dt = EntidadManager.GetStoreProcedure(SCsql(), sp, p1);

            var unidades = (from DataRow u in dt.Rows
                            select new
                            {
                                value = u[0].ToString(),
                                title = u[1].ToString()
                            }
                           ).ToList();

            return Json(unidades, JsonRequestBehavior.AllowGet);
        }



        public virtual JsonResult GetParametro(string param)
        {
            //Dictionary<int, string> unidades = new Dictionary<int, string>();
            //foreach (Unidad u in db.Unidades.ToList())
            //    unidades.Add(u.IdUnidad, u.Abreviatura);


            Parametros parametros = db.Parametros.Find(1);
            var q = parametros.IdControlCalidadStandar ?? -1;



            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetArticuloPorId(int IdArticulo)
        {
            var filtereditems = (from a in db.Articulos
                                 where (a.IdArticulo == IdArticulo)
                                 select new
                                 {
                                     id = a.IdArticulo,
                                     Articulo = a.Descripcion.Trim(),
                                     value = a.Descripcion.Trim()
                                 }).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }


    }
}
