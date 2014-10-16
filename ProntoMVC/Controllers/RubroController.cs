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
using ProntoMVC.Data.Models; using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Text;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
using System.Reflection;
using System.Configuration;
using Pronto.ERP.Bll;

// using ProntoMVC.Controllers.Logica;

using System.Web.Security;

namespace ProntoMVC.Controllers
{
    public partial class RubroController : ProntoBaseController
    {

        //
        // GET: /Rubro/

        public virtual ViewResult Index()
        {

            if (db == null)
            {
                FormsAuthentication.SignOut();
                return View("ElegirBase", "Home");
            }

            var Rubros = db.Rubros
               // .Where(r => r.NumeroRubro > 0)
                .OrderByDescending(r => r.IdRubro); // .NumeroRubro);


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


            return View(Rubros.ToList());
        }

        //
        // GET: /Rubro/Details/5

        public virtual ViewResult Details(int id)
        {
            Rubro Rubro = db.Rubros.Find(id);
            return View(Rubro);
        }

        //



        private bool Validar(ProntoMVC.Data.Models.Rubro o, ref string sErrorMsg)
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
            //if (o.NumeroRubro == null) sErrorMsg += "\n" + "Falta el número de Rubro";
            //// if (o.IdPuntoVenta== null) sErrorMsg += "\n" + "Falta el punto de venta";
            //if (o.IdCodigoIva == null) sErrorMsg += "\n" + "Falta el codigo de IVA";
            //if (o.IdCondicionVenta == null) sErrorMsg += "\n" + "Falta la condicion venta";
            //if (o.IdListaPrecios == null) sErrorMsg += "\n" + "Falta la lista de precios";


            if (sErrorMsg != "") return false;
            return true;

        }



        [HttpPost]
        public virtual JsonResult BatchUpdate(Rubro Rubro)
        {
            try
            {
                string erar = "";

                if (!Validar(Rubro, ref erar))
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    List<string> errors = new List<string>();
                    errors.Add(erar);
                    return Json(errors);
                }



                if (ModelState.IsValid || true)
                {
                    // Perform Update
                    if (Rubro.IdRubro > 0)
                    {
                        var originalRubro = db.Rubros.Where(p => p.IdRubro == Rubro.IdRubro)
                            //.Include(p => p.DetalleRubros)
                            .SingleOrDefault();
                        var RubroEntry = db.Entry(originalRubro);
                        RubroEntry.CurrentValues.SetValues(Rubro);

                        //foreach (var dr in Rubro.DetalleRubros)
                        //{
                        //    var originalDetalleRubro = originalRubro.DetalleRubros.Where(c => c.IdDetalleRubro == dr.IdDetalleRubro).SingleOrDefault();
                        //    // Is original child item with same ID in DB?
                        //    if (originalDetalleRubro != null)
                        //    {
                        //        // Yes -> Update scalar properties of child item
                        //        //db.Entry(originalDetalleRubro).CurrentValues.SetValues(dr);
                        //        var DetalleRubroEntry = db.Entry(originalDetalleRubro);
                        //        DetalleRubroEntry.CurrentValues.SetValues(dr);
                        //    }
                        //    else
                        //    {
                        //        // No -> It's a new child item -> Insert
                        //        originalRubro.DetalleRubros.Add(dr);
                        //    }
                        //}

                        // Now you must delete all entities present in parent.ChildItems but missing in modifiedParent.ChildItems
                        //// ToList should make copy of the collection because we can't modify collection iterated by foreach
                        //foreach (var originalDetalleRubro in originalRubro.DetalleRubros.Where(c => c.IdDetalleRubro != 0).ToList())
                        //{
                        //    // Are there child items in the DB which are NOT in the new child item collection anymore?
                        //    if (!Rubro.DetalleRubros.Any(c => c.IdDetalleRubro == originalDetalleRubro.IdDetalleRubro))
                        //        // Yes -> It's a deleted child item -> Delete
                        //        originalRubro.DetalleRubros.Remove(originalDetalleRubro);
                        //    //db.DetalleRubros.Remove(originalDetalleRubro);
                        //}
                        //db.Entry(originalRubro).State = System.Data.Entity.EntityState.Modified;


                        //foreach (DetalleRubro dr in Rubro.DetalleRubros)
                        //{
                        //    if (dr.IdDetalleRubro > 0)
                        //    {
                        //        db.Entry(dr).State = System.Data.Entity.EntityState.Modified;
                        //    }
                        //    else
                        //    {
                        //        db.Entry(dr).State = System.Data.Entity.EntityState.Added;
                        //        //db.DetalleRubros.Add(dr);
                        //    }
                        //}
                        //db.Entry(Rubro).State = System.Data.Entity.EntityState.Modified;
                    }
                    //Perform Save
                    else
                    {
                        db.Rubros.Add(Rubro);




                        //var pv = (from item in db.PuntosVentas
                        //          where item.Letra == Rubro.TipoABC && item.PuntoVenta == Rubro.PuntoVenta
                        //             && item.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Rubro
                        //          select item).SingleOrDefault();

                        //// var pv = db.PuntosVenta.Where(p => p.IdPuntoVenta == Rubro.IdPuntoVenta).SingleOrDefault();
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
                    //return RedirectToAction(( "Index",    "Rubro");
                    //redirectUrl = Url.Action("Index", "Home"), 
                    //isRedirect = true 

                    return Json(new { Success = 1, IdRubro = Rubro.IdRubro, ex = "" }); //, DetalleRubros = Rubro.DetalleRubros
                }
                else
                {
                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "La Rubro es inválida";
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









        //[HttpPost]
        //public ActionResult Create(Rubro Rubro)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.Rubros.Add(Rubro);
        //        db.SaveChanges();
        //        return RedirectToAction("Index");  
        //    }

        //    ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", Rubro.IdObra);
        //    ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Rubro.Aprobo);
        //    ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Rubro.IdSolicito);
        //    ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", Rubro.IdSector);
        //    return View(Rubro);
        //}


        public virtual FileResult Imprimir(int id) //(int id)
        {
            // string sBasePronto = (string)rc.HttpContext.Session["BasePronto"];
            // db = new DemoProntoEntities(Funciones.Generales.sCadenaConex(sBasePronto));

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));

            //  string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString);
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.docx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "RubroNET_Hawk.docx";
            /*
            string plantilla = Pronto.ERP.Bll.OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.RubroA, SC);
            */

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();



            System.IO.File.Copy(plantilla, output); // 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 
            //Pronto.ERP.BO.Rubro fac = RubroManager.GetItem(SC, id, true);
            //OpenXML_Pronto.RubroXML_DOCX(output, fac, SC);

            //byte[] contents = ;
            //return File(contents, "application/octet-stream");

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "Rubro.docx");
        }


        void inic(ref Rubro o)
        {
            //o.PorcentajeIva1 = 21;                  //  mvarP_IVA1_Tomado
            //o.FechaRubro = DateTime.Now;

            Parametros parametros = db.Parametros.Find(1);
            //o.OtrasPercepciones1 = 0;
            //o.OtrasPercepciones1Desc = ((parametros.OtrasPercepciones1 ?? "NO") == "SI") ? parametros.OtrasPercepciones1Desc : "";
            //o.OtrasPercepciones2 = 0;
            //o.OtrasPercepciones2Desc = ((parametros.OtrasPercepciones2 ?? "NO") == "SI") ? parametros.OtrasPercepciones2Desc : "";
            //o.OtrasPercepciones3 = 0;
            //o.OtrasPercepciones3Desc = ((parametros.OtrasPercepciones3 ?? "NO") == "SI") ? parametros.OtrasPercepciones3Desc : "";

            ////mvarP_IVA1 = .Fields("Iva1").Value
            //mvarP_IVA2 = .Fields("Iva2").Value
            //mvarPorc_IBrutos_Cap = .Fields("Porc_IBrutos_Cap").Value
            //mvarTope_IBrutos_Cap = .Fields("Tope_IBrutos_Cap").Value
            //mvarPorc_IBrutos_BsAs = .Fields("Porc_IBrutos_BsAs").Value
            //mvarTope_IBrutos_BsAs = .Fields("Tope_IBrutos_BsAs").Value
            //mvarPorc_IBrutos_BsAsM = .Fields("Porc_IBrutos_BsAsM").Value
            //mvarTope_IBrutos_BsAsM = .Fields("Tope_IBrutos_BsAsM").Value
            //mvarDecimales = .Fields("Decimales").Value
            //mvarAclaracionAlPie = .Fields("AclaracionAlPieDeRubro").Value
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
            var mvarCotizacion = 4.95; //  mo  Cotizacion(Date, glbIdMonedaDolar);
            //o.CotizacionMoneda = 1;
            ////  o.CotizacionADolarFijo=
            //o.CotizacionDolar = (decimal)mvarCotizacion;


        }



        // GET: /Rubro/Edit/5
        public virtual ActionResult Edit(int id)
        {

            Rubro o;
            if (id <= 0)
            {

                o = new Rubro();

                string connectionString = Generales.sCadenaConexSQL(this.Session["BasePronto"].ToString());
               // o.NumeroRubro = (int)Pronto.ERP.Bll.RubroManager.ProximoNumeroRubroPorIdCodigoIvaYNumeroDePuntoVenta(connectionString, 1, 6);
               // if (o.NumeroRubro == -1) o.NumeroRubro = null;

                inic(ref o);

            }
            else
            {
                o = db.Rubros
                       // .Include(x => x.DetalleRubros)
                      //.Include(x => x.Cliente)
                      .SingleOrDefault(x => x.IdRubro == id);


            }
            CargarViewBag(o);





            //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Rubro.Aprobo);
            //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Rubro.IdSolicito);
            //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", Rubro.IdSector);
            // Session.Add("Rubro", o);
            return View(o);
        }

        void CargarViewBag(Rubro o)
        {
            //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion");
            //ViewBag.PuntoVenta = new SelectList((from i in db.PuntosVentas
            //                                     where i.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Rubro
            //                                     select new { PuntoVenta = i.PuntoVenta })
            //    // http://stackoverflow.com/questions/2135666/databinding-system-string-does-not-contain-a-property-with-the-name-dbmake
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

        // POST: /Rubro/Edit/5
        [HttpPost]
        public virtual ActionResult Edit(Rubro Rubro)
        {
            if (ModelState.IsValid)
            {
                db.Entry(Rubro).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            //ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", Rubro.IdObra);
            //ViewBag.IdCliente = new SelectList(db.Clientes, "IdCliente", "RazonSocial", Rubro.IdCliente);
            ////ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Rubro.Aprobo);
            //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Rubro.IdSolicito);
            //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", Rubro.IdSector);
            return View(Rubro);
        }

        // GET: /Rubro/Delete/5
        public virtual ActionResult Delete(int id)
        {
            Rubro Rubro = db.Rubros.Find(id);
            return View(Rubro);
        }

        // POST: /Rubro/Delete/5
        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Rubro Rubro = db.Rubros.Find(id);
            db.Rubros.Remove(Rubro);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult Rubros(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString,
                                            string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.Rubros.AsQueryable();
            //if (IdObra != string.Empty)
            //{
            //    int IdObra1 = Convert.ToInt32(IdObra);
            //    Fac = (from a in Fac where a.IdObra == IdObra1 select a).AsQueryable();
            //}
            //if (FechaInicial != string.Empty)
            //{
            //    DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            //    DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            //    Fac = (from a in Fac where a.FechaRubro >= FechaDesde && a.FechaRubro <= FechaHasta select a).AsQueryable();
            //}
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numeroRubro":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaRubro":
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
                            IdRubro = a.IdRubro//,
                            //NumeroRubro = a.NumeroRubro,
                            //FechaRubro = a.FechaRubro,
                            //NumeroObra=a.Obra.NumeroObra,
                            //Libero=a.Empleados.Nombre,
                            //Aprobo = a.Empleados1.Nombre,
                            //Sector=a.Sectores.Descripcion,
                            //Detalle=a.Detalle
                        }).Where(campo).ToList();

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            //switch (sidx.ToLower())
            //{
            //    case "numeroRubro":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroRubro);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroRubro);
            //        break;
            //    case "fechaRubro":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.FechaRubro);
            //        else
            //            Fac = Fac.OrderBy(a => a.FechaRubro);
            //        break;
            //    case "numeroobra":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Obra.NumeroObra);
            //        else
            //            Fac = Fac.OrderBy(a => a.Obra.NumeroObra);
            //        break;
            //    case "libero":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Empleados.Nombre);
            //        else
            //            Fac = Fac.OrderBy(a => a.Empleados.Nombre);
            //        break;
            //    case "aprobo":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Empleados1.Nombre);
            //        else
            //            Fac = Fac.OrderBy(a => a.Empleados1.Nombre);
            //        break;
            //    case "sector":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Sectores.Descripcion);
            //        else
            //            Fac = Fac.OrderBy(a => a.Sectores.Descripcion);
            //        break;
            //    case "detalle":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Detalle);
            //        else
            //            Fac = Fac.OrderBy(a => a.Detalle);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroRubro);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroRubro);
            //        break;
            //}

            var data = (from a in Fac
                        //join c in db.Clientes on a.IdCliente equals c.IdCliente
                        select a)
                        //.Include(x => x.Cliente)
                        .Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdRubro.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdRubro} )  +" target='_blank' >Editar</>" +
                                "|" +
                                "<a href=/Rubro/Details/" + a.IdRubro + ">Detalles</a> ",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdRubro} )  +">Imprimir</>" ,
                                a.IdRubro.ToString(),
                                //(a.TipoABC ?? string.Empty).ToString(),
                                //(a.PuntoVenta ?? 0).ToString(),
                                //(a.NumeroRubro ?? 0).ToString(),
                                //(a.FechaRubro ?? DateTime.MinValue).ToString(),
                                ////a.FechaRubro.ToString(),
                                //(a.Cliente==null ? string.Empty : a.Cliente.RazonSocial ).ToString(),
                                //(a.IdCliente ?? 0).ToString(),
                                //(a.ImporteTotal ?? 0).ToString(),
                                //a.ImporteTotal.ToString()
                                //a.NumeroObra, 
                                //a.Libero,
                                //a.Aprobo,
                                //a.Sector,
                                //a.Detalle
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

  
        [HttpPost]
        public void EditGridData(int? IdRubro, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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

        //[HttpPost]
        //public ActionResult Rubros2(string sidx, string sord, int? page, int? rows, bool _search, string filters) //, string searchField, string searchOper, string searchString)
        //{
        //    var serializer = new JavaScriptSerializer();
        //    Filters f = (!_search || string.IsNullOrEmpty(filters)) ? null : serializer.Deserialize<Filters>(filters);
        //    ObjectQuery<Rubro> filteredQuery = (f == null ? db.Rubros : f.FilterObjectSet(db.Rubros));
        //    filteredQuery.MergeOption = MergeOption.NoTracking; // we don't want to update the data
        //    var totalRecords = filteredQuery.Count();

        //    var pagedQuery = filteredQuery.Skip("it." + sidx + " " + sord, "@skip",
        //                                        new ObjectParameter("skip", (page - 1) * rows))
        //                                 .Top("@limit", new ObjectParameter("limit", rows));
        //    // to be able to use ToString() below which is NOT exist in the LINQ to Entity
        //    var queryDetails = (from item in pagedQuery
        //                        select new { item.IdRubro, item.FechaRubro, item.Detalle }).ToList();

        //    return Json(new
        //    {
        //        total = (totalRecords + rows - 1) / rows,
        //        page,
        //        records = totalRecords,
        //        rows = (from item in queryDetails
        //                select new[] {
        //                                item.IdRubro.ToString(),
        //                                item.FechaRubro.ToString(),
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






        public virtual ActionResult RemitosPendienteRubrocion(string sidx, string sord, int? page, int? rows,
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














        public virtual ActionResult OrdenesCompraPendientesRubror(string sidx, string sord, int? page, int? rows,
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


    




    }
}