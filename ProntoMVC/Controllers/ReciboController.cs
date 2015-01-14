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


 //   [Authorize(Roles = "Administrador,SuperAdmin,ReciboElectronica,Comercial")] //ojo que el web.config tambien te puede bochar hacia el login

    public partial class ReciboController : ProntoBaseController
    {

        //
        // GET: /Recibo/

        public virtual ViewResult Index()
        {

            //if (db == null)
            //{
            //    FormsAuthentication.SignOut();
            //    return View("ElegirBase", "Home");
            //}

            //var Recibos = db.Recibos
            //    .Where(r => r.NumeroRecibo > 0)
            //    .OrderByDescending(r => r.IdRecibo); // .NumeroRecibo);


            //string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            //DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster, "SELECT * FROM BASES");
            //List<SelectListItem> baselistado = new List<SelectListItem>();
            //foreach (DataRow r in dt.Rows)
            //{
            //    baselistado.Add(new SelectListItem { Text = r["Descripcion"] as string, Value = "" });
            //}


            //ViewBag.Bases = baselistado; // baselistado; // new SelectList(dt.Rows, "IdBD", "Descripcion"); // StringConnection



            //return View(Recibos.ToList());
            return View();
        }

        //
        // GET: /Recibo/Details/5

        public virtual ViewResult Details(int id)
        {
            Recibo Recibo = db.Recibos.Find(id);
            return View(Recibo);
        }

        //



        private bool Validar(ProntoMVC.Data.Models.Recibo o, ref string sErrorMsg)
        {
            // una opcion es extender el modelo autogenerado, para ensoquetar ahí las validaciones
            // si no, podemos usar una funcion como esta, y devolver los  errores de dos maneras:
            // con ModelState.AddModelError si los devolvemos en una ViewResult,
            // o con un array de strings si es una JsonResult.
            //
            // If you are returning JSON, you cannot use ModelState.
            // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json


            if (!PuedeEditar("Recibos")) sErrorMsg += "\n" + "No tiene permisos de edición";


            if (o.IdRecibo <= 0)
            {
                //  string connectionString = Generales.sCadenaConexSQL(this.Session["BasePronto"].ToString());
                //  o.NumeroRecibo = (int)Pronto.ERP.Bll.ReciboManager.ProximoNumeroReciboPorIdCodigoIvaYNumeroDePuntoVenta(connectionString,o.IdCodigoIva ?? 0,o.PuntoVenta ?? 0);
            }

            if ((o.IdCliente ?? 0) <= 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta el cliente";
                // return false;
            }
            if (o.NumeroRecibo == null) sErrorMsg += "\n" + "Falta el número de Recibo";
            // if (o.IdPuntoVenta== null) sErrorMsg += "\n" + "Falta el punto de venta";
            //if (o.IdCodigoIva == null) sErrorMsg += "\n" + "Falta el codigo de IVA";
            //if (o.IdCondicionVenta == null) sErrorMsg += "\n" + "Falta la condicion venta";
            //if (o.IdListaPrecios == null) sErrorMsg += "\n" + "Falta la lista de precios";
            //if (o.DetalleRecibos.Count <= 0) sErrorMsg += "\n" + "La Recibo no tiene items";

            if (sErrorMsg != "") return false;
            return true;

        }



        [HttpPost]
        public virtual JsonResult BatchUpdate(Recibo Recibo)
        {
            try
            {
                string erar = "";



                if (!Validar(Recibo, ref erar))
                {
                    try
                    {
                        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                        Response.TrySkipIisCustomErrors = true;


                    }
                    catch (Exception)
                    {

                        //    throw;
                    }
                    List<string> errors = new List<string>();
                    errors.Add(erar);
                    return Json(errors);
                }



                if (ModelState.IsValid || true)
                {
                    // Perform Update
                    if (Recibo.IdRecibo > 0)
                    {
                        var originalRecibo = db.Recibos.Where(p => p.IdRecibo == Recibo.IdRecibo).Include(p => p.DetalleRecibos).SingleOrDefault();
                        var ReciboEntry = db.Entry(originalRecibo);
                        ReciboEntry.CurrentValues.SetValues(Recibo);

                        foreach (var dr in Recibo.DetalleRecibos)
                        {
                            var originalDetalleRecibo = originalRecibo.DetalleRecibos.Where(c => c.IdDetalleRecibo == dr.IdDetalleRecibo).SingleOrDefault();
                            // Is original child item with same ID in DB?
                            if (originalDetalleRecibo != null)
                            {
                                // Yes -> Update scalar properties of child item
                                //db.Entry(originalDetalleRecibo).CurrentValues.SetValues(dr);
                                var DetalleReciboEntry = db.Entry(originalDetalleRecibo);
                                DetalleReciboEntry.CurrentValues.SetValues(dr);
                            }
                            else
                            {
                                // No -> It's a new child item -> Insert
                                originalRecibo.DetalleRecibos.Add(dr);
                            }
                        }

                        // Now you must delete all entities present in parent.ChildItems but missing in modifiedParent.ChildItems
                        // ToList should make copy of the collection because we can't modify collection iterated by foreach
                        foreach (var originalDetalleRecibo in originalRecibo.DetalleRecibos.Where(c => c.IdDetalleRecibo != 0).ToList())
                        {
                            // Are there child items in the DB which are NOT in the new child item collection anymore?
                            if (!Recibo.DetalleRecibos.Any(c => c.IdDetalleRecibo == originalDetalleRecibo.IdDetalleRecibo))
                                // Yes -> It's a deleted child item -> Delete
                                originalRecibo.DetalleRecibos.Remove(originalDetalleRecibo);
                            //db.DetalleRecibos.Remove(originalDetalleRecibo);
                        }
                        db.Entry(originalRecibo).State = System.Data.Entity.EntityState.Modified;


                        //foreach (DetalleRecibo dr in Recibo.DetalleRecibos)
                        //{
                        //    if (dr.IdDetalleRecibo > 0)
                        //    {
                        //        db.Entry(dr).State = System.Data.Entity.EntityState.Modified;
                        //    }
                        //    else
                        //    {
                        //        db.Entry(dr).State = System.Data.Entity.EntityState.Added;
                        //        //db.DetalleRecibos.Add(dr);
                        //    }
                        //}
                        //db.Entry(Recibo).State = System.Data.Entity.EntityState.Modified;
                    }
                    //Perform Save
                    else
                    {
                        db.Recibos.Add(Recibo);




                        var pv = (from item in db.PuntosVentas
                                  //where item.Letra == Recibo.TipoABC && item.PuntoVenta == Recibo.PuntoVenta
                                  //   && item.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Recibo
                                  select item).SingleOrDefault();

                        // var pv = db.PuntosVenta.Where(p => p.IdPuntoVenta == Recibo.IdPuntoVenta).SingleOrDefault();
                        pv.ProximoNumero += 1;

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
                    try
                    {
                        // Logica_ReciboElectronica(Recibo);
                    }
                    catch (Exception)
                    {

                        //throw;
                    }

                    Logica_RecalcularTotales(ref Recibo);
                    //Logica_ActualizarCuentaCorriente(Recibo);
                    //Logica_RegistroContable(Recibo);
                    Logica_RecuperoDeGastos(Recibo);
                    Logica_Loguear(Recibo);
                    Logica_ActualizarRemitos(Recibo);
                    Logica_ActualizarOrdenesCompra(Recibo);
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
                    //return RedirectToAction(( "Index",    "Recibo");
                    //redirectUrl = Url.Action("Index", "Home"), 
                    //isRedirect = true 

                    return Json(new { Success = 1, IdRecibo = Recibo.IdRecibo, ex = "" }); //, DetalleRecibos = Recibo.DetalleRecibos
                }
                else
                {
                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "La Recibo es inválida";
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

                try
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest; //lo pongo en un try porque si lo llama un test, no hay httpcontext

                }
                catch (Exception)
                {
                    //                    throw;
                }
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





        public virtual ActionResult IBCondicionPorId(int? id)
        {
            var o = db.IBCondiciones.Find(id);
            if (o == null) o = new IBCondicion();
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
        //public ActionResult Create(Recibo Recibo)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.Recibos.Add(Recibo);
        //        db.SaveChanges();
        //        return RedirectToAction("Index");  
        //    }

        //    ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", Recibo.IdObra);
        //    ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Recibo.Aprobo);
        //    ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Recibo.IdSolicito);
        //    ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", Recibo.IdSector);
        //    return View(Recibo);
        //}


        public virtual FileResult Imprimir(int id) //(int id)
        {
            // string sBasePronto = (string)rc.HttpContext.Session["BasePronto"];
            // db = new DemoProntoEntities(Funciones.Generales.sCadenaConex(sBasePronto));

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));

            //  string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString);
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.docx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "ReciboNET_Hawk.docx";
            /*
            string plantilla = Pronto.ERP.Bll.OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.ReciboA, SC);
            */

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();



            System.IO.File.Copy(plantilla, output); // 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 
            Pronto.ERP.BO.Recibo fac = ReciboManager.GetItem(SC, id, true);
           // OpenXML_Pronto.ReciboXML_DOCX(output, fac, SC);

            //byte[] contents = ;
            //return File(contents, "application/octet-stream");

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "Recibo.docx");
        }


        public virtual ActionResult Anular(int id) //(int id)
        {



            Recibo o = db.Recibos
                    .Include(x => x.DetalleRecibos)
                  .Include(x => x.Cliente)
                  .SingleOrDefault(x => x.IdRecibo == id);


            //         Dim oRs As ADOR.Recordset
            //Dim oRs1 As ADOR.Recordset

            //Set oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PorId", dcfields(10).BoundText)
            //If oRs.RecordCount > 0 Then
            //   If Len(IIf(IsNull(oRs.Fields("WebService").Value), "", oRs.Fields("WebService").Value)) > 0 Then
            //      Set oRs = Nothing
            //      MsgBox "No puede anular un comprobante electronico (CAE)", vbExclamation
            //      Exit Sub
            //   End If
            //End If
            //oRs.Close

            //Set oRs = Aplicacion.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(mvarId, 1))
            //If oRs.RecordCount > 0 Then
            //   If oRs.Fields("ImporteTotal").Value <> oRs.Fields("Saldo").Value Then
            //      oRs.Close
            //      Set oRs = Nothing
            //      MsgBox "La Recibo ha sido cancelada parcial o totalmente y no puede anularse", vbExclamation
            //      Exit Sub
            //   End If
            //End If
            //oRs.Close
            //Set oRs = Nothing


            //o.Anulada = "SI";
            //o.FechaAnulacion = DateTime.Now;
            //o.IdAutorizaAnulacion = 1;


            //If Check3.Value = 1 Then
            //   Set oRs = Aplicacion.Recibos.TraerFiltrado("_NCs_RecuperoGastos", mvarId)
            //   If oRs.RecordCount > 0 Then
            //      If oRs.Fields("IdNotaCredito").Value <> 0 Then
            //         Dim oNC As ComPronto.NotaCredito
            //         Set oNC = Aplicacion.NotasCredito.Item(oRs.Fields("IdNotaCredito").Value)
            //         With oNC
            //            With .Registro
            //               .Fields("Anulada").Value = "OK"
            //               .Fields("IdUsuarioAnulacion").Value = mIdAutorizaAnulacion
            //               .Fields("FechaAnulacion").Value = Now
            //            End With
            //            .Guardar


            ////////////////////////////////////

            ProntoMVC.Data.Models.CuentasCorrientesDeudor a = new CuentasCorrientesDeudor();
            a.ImporteTotal = 0;
          //  a.Saldo = 0 - o.ImporteTotal; //  a.Saldo = a.Saldo - mImporteAnterior;
            a.ImporteTotalDolar = 0;
            a.SaldoDolar = 0;



            var f = db.Subdiarios.Where(x => x.IdComprobante == o.IdRecibo);
            foreach (Subdiario reg in f)
            {
                db.Subdiarios.Remove(reg);
            }


            //             If mvarIdentificador > 0 Or mvarAnulada = "SI" Then
            //   Set DatosAnt = oDet.TraerFiltrado("Subdiarios", "_PorIdComprobante", Array(mvarIdentificador, 1))
            //   With DatosAnt
            //      If .RecordCount > 0 Then
            //         .MoveFirst
            //         Do While Not .EOF
            //            oDet.Eliminar "Subdiarios", .Fields(0).Value
            //            .MoveNext
            //         Loop
            //      End If
            //      .Close
            //   End With
            //   Set DatosAnt = Nothing
            //End If
            ///////////////////////////////////////////


            //If oRs.Fields("IdComprobanteProveedor").Value <> 0 Then
            //   Dim oCP As ComPronto.ComprobanteProveedor
            //   Set oCP = Aplicacion.ComprobantesProveedores.Item(oRs.Fields("IdComprobanteProveedor").Value)
            //   With oCP
            //      With .Registro
            //         .Fields("TotalBruto").Value = 0
            //         .Fields("TotalIva1").Value = 0
            //         .Fields("TotalIva2").Value = 0
            //         .Fields("TotalComprobante").Value = 0
            //      End With
            //      Set oRs1 = .DetComprobantesProveedores.TraerTodos
            //      If oRs1.RecordCount > 0 Then
            //         oRs1.MoveFirst
            //         Do While Not oRs1.EOF
            //            With .DetComprobantesProveedores.Item(oRs1.Fields(0).Value)
            //               With .Registro
            //                  .Fields("Importe").Value = 0
            //                  .Fields("IdCuentaIvaCompras1").Value = Null
            //                  .Fields("IVAComprasPorcentaje1").Value = 0
            //                  .Fields("ImporteIVA1").Value = 0
            //                  .Fields("AplicarIVA1").Value = "NO"
            //               End With
            //               .Modificado = True
            //            End With
            //            oRs1.MoveNext
            //         Loop
            //      End If
            //      .Guardar
            //      Set oRs1 = Nothing
            //   End With
            //   Set oCP = Nothing
            //End If
            db.SaveChanges();

            return RedirectToAction("Index");
        }




        void inic(ref Recibo o)
        {
            //o.PorcentajeIva1 = 21;                  //  mvarP_IVA1_Tomado
            o.FechaRecibo = DateTime.Now;

            Parametros parametros = db.Parametros.Find(1);
            //o.OtrasPercepciones1 = 0;
            //o.OtrasPercepciones1Desc = ((parametros.OtrasPercepciones1 ?? "NO") == "SI") ? parametros.OtrasPercepciones1Desc : "";
            //o.OtrasPercepciones2 = 0;
            //o.OtrasPercepciones2Desc = ((parametros.OtrasPercepciones2 ?? "NO") == "SI") ? parametros.OtrasPercepciones2Desc : "";
            //o.OtrasPercepciones3 = 0;
            //o.OtrasPercepciones3Desc = ((parametros.OtrasPercepciones3 ?? "NO") == "SI") ? parametros.OtrasPercepciones3Desc : "";

            o.IdMoneda = 1;

            //mvarP_IVA1 = .Fields("Iva1").Value
            //mvarP_IVA2 = .Fields("Iva2").Value
            //mvarPorc_IBrutos_Cap = .Fields("Porc_IBrutos_Cap").Value
            //mvarTope_IBrutos_Cap = .Fields("Tope_IBrutos_Cap").Value
            //mvarPorc_IBrutos_BsAs = .Fields("Porc_IBrutos_BsAs").Value
            //mvarTope_IBrutos_BsAs = .Fields("Tope_IBrutos_BsAs").Value
            //mvarPorc_IBrutos_BsAsM = .Fields("Porc_IBrutos_BsAsM").Value
            //mvarTope_IBrutos_BsAsM = .Fields("Tope_IBrutos_BsAsM").Value
            //mvarDecimales = .Fields("Decimales").Value
            //mvarAclaracionAlPie = .Fields("AclaracionAlPieDeRecibo").Value
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
            var mvarCotizacion = db.Cotizaciones.OrderByDescending(x => x.IdCotizacion).FirstOrDefault().Cotizacion; //  mo  Cotizacion(Date, glbIdMonedaDolar);
            o.CotizacionMoneda = 1;
            //  o.CotizacionADolarFijo=
           // o.CotizacionDolar = (decimal)mvarCotizacion;

            o.DetalleRecibos.Add(new DetalleRecibo());
            o.DetalleRecibos.Add(new DetalleRecibo());
            o.DetalleRecibos.Add(new DetalleRecibo());

        }



        // GET: /Recibo/Edit/5
        public virtual ViewResult Edit(int id)
        {


            Recibo o;

            try
            {
                if (!PuedeLeer("Recibos"))
                {
                    o = new Recibo();
                    CargarViewBag(o);
                    ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                    return View(o);

                }

            }
            catch (Exception)
            {
                o = new Recibo();
                CargarViewBag(o);
                ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                return View(o);
                //throw;
            }




            if (id <= 0)
            {

                o = new Recibo();

                try
                {
                    string connectionString = Generales.sCadenaConexSQL(this.Session["BasePronto"].ToString());
                //    o.NumeroRecibo = (int)Pronto.ERP.Bll.ReciboManager.ProximoNumeroReciboPorIdCodigoIvaYNumeroDePuntoVenta(connectionString, 1, 6);
                    if (o.NumeroRecibo == -1) o.NumeroRecibo = null;
                }
                catch (Exception)
                {
                    // usando el dbcontext como corresponde, en lugar de tomar el nombre de la base de la session
                   // o.IdCodigoIva = 1;
                    o.PuntoVenta = 6;

                    //o.TipoABC = EntidadManager.LetraSegunTipoIVA(o.IdCodigoIva ?? 0);
                    //var mvarPuntoVenta = db.PuntosVentas
                    //    .Where(x => x.PuntoVenta == o.PuntoVenta && x.Letra == o.TipoABC && x.IdTipoComprobante == 1) // EntidadManager.IdTipoComprobante.Recibo);
                    //    .FirstOrDefault();

               //     o.NumeroRecibo = mvarPuntoVenta.ProximoNumero;
                }





                inic(ref o);

            }
            else
            {
                o = db.Recibos
                        .Include(x => x.DetalleRecibos)
                      .Include(x => x.Cliente)
                      .SingleOrDefault(x => x.IdRecibo == id);


            }
            CargarViewBag(o);





            //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Recibo.Aprobo);
            //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Recibo.IdSolicito);
            //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", Recibo.IdSector);
            // Session.Add("Recibo", o);
            return View(o);
        }

        void CargarViewBag(Recibo o)
        {
            ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion");
            ViewBag.PuntoVenta = new SelectList((from i in db.PuntosVentas
                                                 where i.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Recibo
                                                 select new { PuntoVenta = i.PuntoVenta })
                // http://stackoverflow.com/questions/2135666/databinding-system-string-does-not-contain-a-property-with-the-name-dbmake
                                                 .Distinct(), "PuntoVenta", "PuntoVenta"); //traer solo el Numero de PuntoVenta, no el Id


            //ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", o.IdObra);
            //ViewBag.IdCliente = new SelectList(db.Clientes, "IdCliente", "RazonSocial", o.IdCliente);
            //ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion", o.IdCodigoIva);
            //ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", o.IdCodigoIva);
            //ViewBag.IdListaPrecios = new SelectList(db.ListasPrecios, "IdListaPrecios", "Descripcion", o.IdListaPrecios);
            //ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            //ViewBag.IdCondicionVenta = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionVenta);

            //http://stackoverflow.com/questions/942262/add-empty-value-to-a-dropdownlist-in-asp-net-mvc
            // http://stackoverflow.com/questions/7659612/mvc3-dropdownlist-and-viewbag-how-add-new-items-to-collection
            //List<SelectListItem>  l = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);
            //l.ad
            //l.Add((new SelectListItem { IdIBCondicion = " ", Descripcion = "-1" }));
            //ViewBag.IdIBCondicionPorDefecto = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);



            //ViewBag.IdIBCondicionPorDefecto2 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion2);
            //ViewBag.IdIBCondicionPorDefecto3 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion3);



            Parametros parametros = db.Parametros.Find(1);
            ViewBag.PercepcionIIBB = parametros.PercepcionIIBB;

        }

        //// http://stackoverflow.com/questions/7659612/mvc3-dropdownlist-and-viewbag-how-add-new-items-to-collection

        //public static SelectList MakeSelectListDipendenze(SomeCollection Coll, bool emptyElem = true)
        //{
        //    List<SelectListItem> Items = new List<SelectListItem>();
        //    if (emptyElem)
        //        Items.Add((new SelectListItem { Text = " ", Value = "-1" }));
        //    foreach (ElemInCollection Item in Coll)
        //    {
        //        SelectListItem AddMe = new SelectListItem();
        //        AddMe.Text = Item.Description;
        //        AddMe.Value = Item.Id.ToString();
        //        Items.Add(AddMe);
        //    }
        //    SelectList Res = new SelectList(Items, "Value", "Text");
        //    return Res;
        //}


        // POST: /Recibo/Edit/5
        [HttpPost]
        public virtual ActionResult Edit(Recibo Recibo)
        {
            if (ModelState.IsValid)
            {
                db.Entry(Recibo).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", Recibo.IdObra);
            ViewBag.IdCliente = new SelectList(db.Clientes, "IdCliente", "RazonSocial", Recibo.IdCliente);
            //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Recibo.Aprobo);
            //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Recibo.IdSolicito);
            //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", Recibo.IdSector);
            return View(Recibo);
        }

        // GET: /Recibo/Delete/5
        public virtual ActionResult Delete(int id)
        {
            Recibo Recibo = db.Recibos.Find(id);
            return View(Recibo);
        }

        // POST: /Recibo/Delete/5
        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Recibo Recibo = db.Recibos.Find(id);
            db.Recibos.Remove(Recibo);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult Recibos(string sidx, string sord, int? page, int? rows, bool? _search, string searchField, string searchOper, string searchString,
                                            string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.Recibos.AsQueryable();
            if (IdObra != string.Empty)
            {
                int IdObra1 = Convert.ToInt32(IdObra);
                Fac = (from a in Fac where a.IdObra == IdObra1 select a).AsQueryable();
            }

            try
            {
                if (FechaInicial != string.Empty)
                {
                    DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                    DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                    Fac = (from a in Fac where a.FechaRecibo >= FechaDesde && a.FechaRecibo <= FechaHasta select a).AsQueryable();
                }

            }
            catch (Exception)
            {

                //throw;
            }


            if (_search ?? false)
            {
                switch (searchField.ToLower())
                {
                    case "numeroRecibo":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaRecibo":
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
                            IdRecibo = a.IdRecibo,
                            NumeroRecibo = a.NumeroRecibo,
                            FechaRecibo = a.FechaRecibo,
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
            //    case "numeroRecibo":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroRecibo);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroRecibo);
            //        break;
            //    case "fechaRecibo":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.FechaRecibo);
            //        else
            //            Fac = Fac.OrderBy(a => a.FechaRecibo);
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
            //            Fac = Fac.OrderByDescending(a => a.NumeroRecibo);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroRecibo);
            //        break;
            //}

            var data = (from a in Fac
                        //join c in db.Clientes on a.IdCliente equals c.IdCliente
                        select a)
                        .Include(x => x.Cliente)
                        //.Include(x => x.Moneda)
                        //.Include(x => x.Obra)
                        .Include(x => x.Cliente.DescripcionIva)
                      //  .Include(x => x.Vendedore)
                      //  .Include(x => x.Provincia)
                        .Include(x => x.DetalleRecibos)
                //.Include(x => x.i)
                        .Where(campo)
                //.OrderBy(sidx + " " + sord)
                        .OrderByDescending(x => x.FechaRecibo)
                        .Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdRecibo.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdRecibo} )  +" target='_blank' >Editar</>"
                                //+
                                //"|" +
                                //"<a href=/Recibo/Details/" + a.IdRecibo + ">Detalles</a> "
                                ,
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdRecibo} )  +">Imprimir</>" ,
                                a.IdRecibo.ToString(),
                            //    (a.TipoABC ?? string.Empty).ToString(),
                                (a.PuntoVenta ?? 0).ToString(),
                                (a.NumeroRecibo ?? 0).ToString(),
                                // create una vista y chau
                                 //a.Anulada.NullSafeToString(), //  as [Anulada],  
 (a.Cliente ?? new Cliente()).CodigoCliente.NullSafeToString(), // as [Cod.Cli.],   
  //(a.Cliente==null ? string.Empty : a.Cliente.RazonSocial ).ToString(),
((a.Cliente ?? new Cliente()).DescripcionIva ?? new DescripcionIva()).Descripcion.NullSafeToString(), //  as [Condicion IVA],   
 ( a.Cliente ?? new Cliente()).Cuit.NullSafeToString() , // as [Cuit],  

                                (a.FechaRecibo ?? DateTime.MinValue).ToString(),
//"", // a.DetalleRecibos.Select(x=> "", //a.DetalleRecibos.Select(x=>)   #Auxiliar1.OCompras , // as [Ordenes de compra],  // de querer hacerlo con una vista, tendría que reemplazar los cursores de Recibos_TT
//  "", //#Auxiliar3.Remitos, //  as [Remitos],  
//((a.ImporteTotal??0)-a.ImporteIva1.GetValueOrDefault()-a.ImporteIva2.GetValueOrDefault()-a.RetencionIBrutos1.GetValueOrDefault()-a.RetencionIBrutos2.GetValueOrDefault()-a.RetencionIBrutos3.GetValueOrDefault()-a.ImporteBonificacion.GetValueOrDefault()-a.IVANoDiscriminado.GetValueOrDefault()-a.PercepcionIVA.GetValueOrDefault()).ToString(), 
////a.ImporteTotal-Recibos.ImporteIva1-Recibos.ImporteIva2-Recibos.RetencionIBrutos1-Recibos.RetencionIBrutos2-Recibos.RetencionIBrutos3+   IsNull(Recibos.ImporteBonificacion,0)-IsNull(Recibos.IvaNoDiscriminado,0)-IsNull(Recibos.PercepcionIVA,0) , // as [Subtotal],  
//a.ImporteBonificacion.NullSafeToString(), //a.ImporteBonificacion.NullSafeToString(), //  as [Bonificacion],  
//((a.ImporteIva1??0)+a.IVANoDiscriminado.GetValueOrDefault()).NullSafeToString(), //a.ImporteIva1+IsNull(Recibos.IvaNoDiscriminado,0) as [Iva],  
//a.AjusteIva.GetValueOrDefault().NullSafeToString(), //  as [Ajuste IVA],  
//((a.RetencionIBrutos1??0)+a.RetencionIBrutos2+a.RetencionIBrutos3).NullSafeToString() , // as [IIBB],  
//a.PercepcionIVA.GetValueOrDefault().NullSafeToString() , // as [Perc.IVA],  
 
 
// (a.ImporteTotal ?? 0).NullSafeToString(),


//( a.Moneda ?? new Moneda()).Abreviatura.NullSafeToString(), // as [Mon.],  
// (a.Cliente ?? new Cliente()).Telefono.NullSafeToString(), //  as [Telefono del cliente],   
// (a.Vendedore ?? new Vendedor()).Nombre, //  as [Vendedor],  
// (a.Empleado ?? new Empleado()).Nombre, //   as [Ingreso],  
 
//a.FechaIngreso.NullSafeToString(), //  as [Fecha ingreso],  
//(a.Obra ?? new Obra()).NumeroObra,// as [Obra (x defecto)],  
//(a.Provincia ?? new Provincia()).Nombre, // Provincias.Nombre as [Provincia destino],  
//a.DetalleRecibos.Count().ToString(), // (Select Count(*) From DetalleRecibos df    Where df.IdRecibo=Recibos.IdRecibo) as [Cant.Items],  
//"", //(Select Count(*) From DetalleRecibos df    //Where df.IdRecibo=Recibos.IdRecibo and    // Patindex('%'+Convert(varchar,df.IdArticulo)+'%', @IdAbonos)<>0) as [Cant.Abonos],  
//"", //'Grupo '+Convert(varchar,   //(Select Top 1 oc.Agrupacion2Recibocion    //From DetalleRecibosOrdenesCompra dfoc    //Left Outer Join DetalleOrdenesCompra doc On doc.IdDetalleOrdenCompra=dfoc.IdDetalleOrdenCompra   //Left Outer Join OrdenesCompra oc On oc.IdOrdenCompra=doc.IdOrdenCompra   //Where dfoc.IdRecibo=Recibos.IdRecibo)) as [Grupo Recibocion automatica],  
//a.ActivarRecuperoGastos.NullSafeToString(), //  as [Act.Rec.Gtos.],  
// a.FechaRecibo.NullSafeToString(), //Case When IsNull(ContabilizarAFechaVencimiento,'NO')='NO'    //Thena.FechaRecibo   //Elsea.FechaVencimiento   //End as [Fecha Contab.],  
//a.CAE.NullSafeToString(), //  as [CAE],  
//a.RechazoCAE.NullSafeToString() , // as [Rech.CAE],  
//a.FechaVencimientoORechazoCAE.NullSafeToString() //  as [Fecha vto.CAE],  
 




                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetRecibos(string sidx, string sord, int? page, int? rows, int? IdRecibo)
        {
            int IdRecibo1 = IdRecibo ?? 0;
            var DetReq = db.DetalleRecibos.Where(p => p.IdRecibo == IdRecibo1).AsQueryable();
            bool Eliminado = false;

            int pageSize = rows ?? 20;
            int totalRecords = DetReq.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetReq
                        select new
                        {
                            a.IdDetalleRecibo,
                            //a.IdArticulo,
                            //a.IdUnidad,

                            //a.Cantidad,

                            //a.PrecioUnitario,
                            //a.Costo,

                            //// a.Unidad.Abreviatura, 
                            //CodigoArticulo = a.Articulo.Codigo,
                            //a.Articulo.Descripcion,
                            //a.Bonificacion,
                            //Unidad = a.Unidade.Descripcion,

                            ////a.FechaEntrega, 
                            //a.Observaciones
                            //a.Adjunto 

                        })
                                                      .OrderBy(p => p.IdDetalleRecibo)
                                                      .Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleRecibo.ToString(),
                            cell = new string[] { 
                                string.Empty, 
                                a.IdDetalleRecibo.ToString() // , 
                            //    a.IdArticulo.ToString(), 
                            //    a.IdUnidad.ToString(),
                                
                            //    "",
                            //       a.CodigoArticulo,
                            //       a.Descripcion,
                            //       a.Cantidad.ToString(),
                            //       a.Unidad,
                          
                            //a.Costo.NullSafeToString(),
                            //  a.PrecioUnitario.NullSafeToString(),
                            //// a.Unidad.Abreviatura, 
                          
                            //a.Bonificacion.NullSafeToString(),
                            //    //Eliminado.ToString(),
                            //    //a.NumeroItem.ToString(), 
                            //    "0",  // el total se recalcula en la vista
                            //    //a.Abreviatura,
                            //    //a.Codigo,
                            //    //a.Descripcion,
                            //    //a.FechaEntrega.ToString(),
                            //    //a.Adjunto,
                            //    a.Observaciones,
                            //                              "0" // ImporteBonificacion=0

                            } //a.PostedOn.Value.ToShortDateString()
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdRecibo, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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
        //public ActionResult Recibos2(string sidx, string sord, int? page, int? rows, bool _search, string filters) //, string searchField, string searchOper, string searchString)
        //{
        //    var serializer = new JavaScriptSerializer();
        //    Filters f = (!_search || string.IsNullOrEmpty(filters)) ? null : serializer.Deserialize<Filters>(filters);
        //    ObjectQuery<Recibo> filteredQuery = (f == null ? db.Recibos : f.FilterObjectSet(db.Recibos));
        //    filteredQuery.MergeOption = MergeOption.NoTracking; // we don't want to update the data
        //    var totalRecords = filteredQuery.Count();

        //    var pagedQuery = filteredQuery.Skip("it." + sidx + " " + sord, "@skip",
        //                                        new ObjectParameter("skip", (page - 1) * rows))
        //                                 .Top("@limit", new ObjectParameter("limit", rows));
        //    // to be able to use ToString() below which is NOT exist in the LINQ to Entity
        //    var queryDetails = (from item in pagedQuery
        //                        select new { item.IdRecibo, item.FechaRecibo, item.Detalle }).ToList();

        //    return Json(new
        //    {
        //        total = (totalRecords + rows - 1) / rows,
        //        page,
        //        records = totalRecords,
        //        rows = (from item in queryDetails
        //                select new[] {
        //                                item.IdRecibo.ToString(),
        //                                item.FechaRecibo.ToString(),
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






        public virtual ActionResult RemitosPendienteRecibocion(string sidx, string sord, int? page, int? rows,
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














        public virtual ActionResult OrdenesCompraPendientesRecibor(string sidx, string sord, int? page, int? rows,
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


        // si usas static, no tenes acceso al context
        public void Logica_Loguear(Recibo o)
        {
            //        'entidadmanager.Tarea("Log_InsertarRegistro", Array("FA", mvarIdentificador, 0, Now, 0, "COMIENZO CABECERA"))
            //        'Resp = iCompMTS_GuardarPorRef("Recibos", Recibo)
            //        'entidadmanager.Tarea("Log_InsertarRegistro", Array("FA", mvarIdentificador, 0, Now, 0, "FIN CABECERA"))


        }


        public void Logica_ActualizarRemitos(Recibo o)
        {
            //        '   Set DatosRem = entidadmanager.LeerUno("Remitos", Recibo.IdRemito)
            //        '   If DatosRem.RecordCount > 0 Then
            //        '      DatosRem.Recibodo = "SI"
            //        '      DatosRem.Update
            //        '      Resp = iCompMTS_GuardarPorRef("Remitos", DatosRem)
            //        '   End If

            //        If Not IsNull(myRecibo.ContabilizarAFechaVencimiento) And _
            //              myRecibo.ContabilizarAFechaVencimiento = "SI" Then
            //            mvarFecha = myRecibo.FechaVencimiento 'vencimiento
            //        Else
            //            mvarFecha = myRecibo.Fecha
            //        End If
            //    End With
        }
        public void Logica_ActualizarOrdenesCompra(Recibo o)
        {
            //        EntidadManager.Tarea(SC, "OrdenesCompra_ActualizarEstadoDetalles", 0, myRecibo.Id, 0)
        }



        public void Logica_RecuperoDeGastos(Recibo o)
        {
            //        EntidadManager.Tarea(SC, "OrdenesCompra_ActualizarEstadoDetalles", 0, myRecibo.Id, 0)
        }



        //public void Logica_RegistroContable(Recibo o)
        //{
        //    try
        //    {

        //        //        Public Function RegistroContable() As ador.Recordset

        //        //   Dim oSrv As InterFazMTS.iCompMTS
        //        //   Dim oRs As ador.Recordset
        //        //   Dim oRsAux As ador.Recordset
        //        //   Dim oRsCont As ador.Recordset
        //        //   Dim oRsDet As ador.Recordset
        //        //   Dim oRsDetBD As ador.Recordset
        //        //   Dim oFld As ador.Field
        //        //   Dim mvarEjercicio As Long, mvarCuentaVentas As Long, mvarCuentaCliente As Long, mvarCuentaBonificaciones As Long
        //        //   Dim mvarCuentaIvaInscripto As Long, mvarCuentaIvaNoInscripto As Long, mvarCuentaIvaSinDiscriminar As Long
        //        //   Dim mvarCuentaRetencionIBrutosBsAs As Long, mvarCuentaRetencionIBrutosCap As Long, mvarCuentaVentasTitulo As Long
        //        long mvarCuentaReventas, mvarCuentaIvaInscripto1 = 0, mvarCuentaPercepcionIIBB;
        //        //   Dim mvarCuentaOtrasPercepciones1 As Long, mvarCuentaOtrasPercepciones2 As Long, mvarCuentaOtrasPercepciones3 As Long
        //        //   Dim mvarCuentaPercepcionesIVA As Long
        //        //   Dim mvarCuentaIvaVenta(4, 2) As Long
        //        //   Dim i As Integer, mvarIdMonedaPesos As Integer
        //        Double mvarIvaNoDiscriminado, mvarSubtotal, mvarNetoGravadoItem, mvarAjusteIva;
        //        //   Dim mvarNetoGravadoItemSuma As Double


        //        //   Dim mvarEsta As Boolean
        //        //   Dim mvarFecha As Date

        //        //   Set oSrv = CreateObject("MTSPronto.General")

        //        Parametros parametros = db.Parametros.Find(1);
        //        var mvarEjercicio = parametros.EjercicioActual ?? 0;
        //        var mvarCuentaVentas = parametros.IdCuentaVentas ?? 0;
        //        var mvarCuentaVentasTitulo = parametros.IdCuentaVentasTitulo ?? 0;
        //        var mvarCuentaBonificaciones = parametros.IdCuentaBonificaciones ?? 0;
        //        var mvarCuentaIvaInscripto = parametros.IdCuentaIvaInscripto ?? 0;
        //        var mvarCuentaIvaNoInscripto = parametros.IdCuentaIvaNoInscripto ?? 0;
        //        var mvarCuentaIvaSinDiscriminar = parametros.IdCuentaIvaSinDiscriminar ?? 0;
        //        var mvarCuentaRetencionIBrutosBsAs = parametros.IdCuentaRetencionIBrutosBsAs ?? 0;
        //        var mvarCuentaRetencionIBrutosCap = parametros.IdCuentaRetencionIBrutosCap ?? 0;
        //        mvarCuentaReventas = parametros.IdCuentaReventas ?? 0;
        //        var mvarCuentaOtrasPercepciones1 = parametros.IdCuentaOtrasPercepciones1 ?? 0;
        //        var mvarCuentaOtrasPercepciones2 = parametros.IdCuentaOtrasPercepciones2 ?? 0;
        //        var mvarCuentaOtrasPercepciones3 = parametros.IdCuentaOtrasPercepciones3 ?? 0;
        //        var mvarCuentaPercepcionesIVA = parametros.IdCuentaPercepcionesIVA ?? 0;
        //        var mvarCuentaCliente = parametros.IdCuentaDeudoresVarios ?? 0;
        //        var mvarIdMonedaPesos = parametros.IdMoneda ?? 1;

        //        //   For i = 1 To 4
        //        //      If Not IsNull(oRs.Fields("IdCuentaIvaVentas" & i).Value) Then
        //        //         mvarCuentaIvaVenta(i, 0) = oRs.Fields("IdCuentaIvaVentas" & i).Value
        //        //         mvarCuentaIvaVenta(i, 1) = oRs.Fields("IVAVentasPorcentaje" & i).Value
        //        //      Else
        //        //         mvarCuentaIvaVenta(i, 0) = 0
        //        //         mvarCuentaIvaVenta(i, 1) = -1
        //        //      End If
        //        //   Next
        //        //   oRs.Close

        //        //   If Not IsNull(o.IdCliente) Then
        //        //      Set oRs = oSrv.LeerUno("Clientes", o.IdCliente)
        //        //      mvarCuentaCliente = IIf(IsNull(oRs.Fields("IdCuenta), 0, oRs.Fields("IdCuenta)
        //        //      If o.IdMoneda <> mvarIdMonedaPesos And _
        //        //            Not IsNull(oRs.Fields("IdCuentaMonedaExt) Then
        //        //         mvarCuentaCliente = oRs.Fields("IdCuentaMonedaExt
        //        //      End If
        //        //      oRs.Close
        //        //   End If

        //        //   Set oRsCont = CreateObject("ADOR.Recordset")
        //        //   Set oRs = oSrv.TraerFiltrado("Subdiarios", "_Estructura")

        //        ProntoMVC.Data.Models.Subdiario oRs = new Subdiario();

        //        var mvarFecha = o.ContabilizarAFechaVencimiento == "SI" ? o.FechaVencimiento : o.FechaRecibo;

        //        mvarSubtotal = (double)(o.ImporteTotal ?? 0 - o.ImporteIva1 ?? 0 -
        //                           o.ImporteIva2 ?? 0 - o.RetencionIBrutos1 -
        //                           o.RetencionIBrutos2 ?? 0 - o.RetencionIBrutos3 ?? 0 -
        //                           o.OtrasPercepciones1 ?? 0 -
        //                            o.OtrasPercepciones2 ?? 0 -
        //                            o.OtrasPercepciones3 ?? 0 -
        //                           o.PercepcionIVA ?? 0 -
        //                           o.AjusteIva ?? 0 +
        //                           o.ImporteBonificacion ?? 0);
        //        var mvarNetoGravadoItemSuma = 0;



        //        var s = new Subdiario();
        //        s.Ejercicio = mvarEjercicio;
        //        s.IdCuentaSubdiario = mvarCuentaVentasTitulo;
        //        s.IdCuenta = mvarCuentaCliente;
        //        s.IdTipoComprobante = 1;
        //        s.NumeroComprobante = o.NumeroRecibo;
        //        s.FechaComprobante = mvarFecha;
        //        s.IdComprobante = o.IdRecibo;
        //        s.Debe = o.ImporteTotal;
        //        s.IdMoneda = o.IdMoneda;
        //        s.CotizacionMoneda = o.CotizacionMoneda;
        //        if (s.Debe > 0) db.Subdiarios.Add(s);




        //        //     If o.ImporteBonificacion <> 0 Then
        //        //        With oRsCont
        //        s = new Subdiario();
        //        s.Ejercicio = mvarEjercicio;
        //        s.IdCuentaSubdiario = mvarCuentaVentasTitulo;
        //        s.IdCuenta = mvarCuentaBonificaciones;
        //        s.IdTipoComprobante = 1;
        //        s.NumeroComprobante = o.NumeroRecibo;
        //        s.FechaComprobante = mvarFecha;
        //        s.IdComprobante = o.IdRecibo;
        //        s.Debe = o.ImporteBonificacion;
        //        s.IdMoneda = o.IdMoneda;
        //        s.CotizacionMoneda = o.CotizacionMoneda;
        //        if (s.Debe > 0) db.Subdiarios.Add(s);
        //        //           .Update
        //        //        End With
        //        //     End If



        //        if (o.ImporteIva1 != 0)
        //        {
        //            mvarCuentaIvaInscripto1 = mvarCuentaIvaInscripto;
        //            for (int i = 1; i <= 4; i++)
        //            {
        //                //if (o.PorcentajeIva1 = mvarCuentaIvaVenta(i, 1))
        //                //{
        //                //    mvarCuentaIvaInscripto1 = mvarCuentaIvaVenta(i, 0);
        //                //    break;

        //                //}
        //            }
        //        }
        //        s = new Subdiario();

        //        s.Ejercicio = mvarEjercicio;
        //        s.IdCuentaSubdiario = mvarCuentaVentasTitulo;
        //        s.IdCuenta = (int)mvarCuentaIvaInscripto1;
        //        s.IdTipoComprobante = 1;
        //        s.NumeroComprobante = o.NumeroRecibo;
        //        s.FechaComprobante = mvarFecha;
        //        s.IdComprobante = o.IdRecibo;
        //        s.Haber = o.ImporteIva1;
        //        s.IdMoneda = o.IdMoneda;
        //        s.CotizacionMoneda = o.CotizacionMoneda;
        //        if (s.Haber > 0) db.Subdiarios.Add(s);
        //        //         .Update
        //        //      End With
        //        //   End If



        //        //mvarIvaNoDiscriminado = 0
        //        //   if (o.IvaNoDiscriminado > 0) {
        //        //      mvarIvaNoDiscriminado = o.IvaNoDiscriminado
        //        s = new Subdiario();

        //        s.Ejercicio = mvarEjercicio;
        //        s.IdCuentaSubdiario = mvarCuentaVentasTitulo;
        //        s.IdCuenta = mvarCuentaIvaInscripto;
        //        s.IdTipoComprobante = 1;
        //        s.NumeroComprobante = o.NumeroRecibo;
        //        s.FechaComprobante = mvarFecha;
        //        s.IdComprobante = o.IdRecibo;
        //        s.Haber = (decimal)(o.IVANoDiscriminado ?? 0);
        //        s.IdMoneda = o.IdMoneda;
        //        s.CotizacionMoneda = o.CotizacionMoneda;
        //        if (s.Haber > 0) db.Subdiarios.Add(s);

        //        //mvarAjusteIva = 0
        //        //   if (o.AjusteIva <> 0) {
        //        //      mvarAjusteIva = o.AjusteIva
        //        s = new Subdiario();

        //        s.Ejercicio = mvarEjercicio;
        //        s.IdCuentaSubdiario = mvarCuentaVentasTitulo;
        //        s.IdCuenta = mvarCuentaIvaInscripto;
        //        s.IdTipoComprobante = 1;
        //        s.NumeroComprobante = o.NumeroRecibo;
        //        s.FechaComprobante = mvarFecha;
        //        s.IdComprobante = o.IdRecibo;
        //        s.Haber = (decimal?)o.AjusteIva;
        //        s.IdMoneda = o.IdMoneda;
        //        s.CotizacionMoneda = o.CotizacionMoneda;
        //        if (s.Haber > 0) db.Subdiarios.Add(s);
        //        //         .Update
        //        //      End With
        //        //   }



        //        s = movimient(mvarEjercicio, mvarCuentaVentasTitulo, mvarCuentaIvaInscripto, 1, o.NumeroRecibo, mvarFecha, o.IdRecibo, o.ImporteIva2, o.IdMoneda, o.CotizacionMoneda);
        //        if (s != null) db.Subdiarios.Add(s);


        //        //   If Not IsNull(o.RetencionIBrutos1) Then
        //        //      If o.RetencionIBrutos1 <> 0 Then
        //        //         Set oRs = oSrv.LeerUno("IBCondiciones", o.IdIBCondicion)
        //        //         mvarCuentaPercepcionIIBB = IIf(IsNull(oRs.Fields("IdCuentaPercepcionIIBB), 0, oRs.Fields("IdCuentaPercepcionIIBB)
        //        //         If Not IsNull(oRs.Fields("IdProvincia) Then
        //        //            Set oRsAux = oSrv.LeerUno("Provincias", oRs.Fields("IdProvincia)
        //        //            If oRsAux.RecordCount > 0 Then
        //        //               If Not IsNull(oRsAux.Fields("IdCuentaPercepcionIBrutos) Then
        //        //                  mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIBrutos
        //        //               End If
        //        //               If o.ConvenioMultilateral = "SI" And _
        //        //                     Not IsNull(oRsAux.Fields("IdCuentaPercepcionIIBBConvenio) Then
        //        //                  mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIIBBConvenio
        //        //               End If
        //        //            End If
        //        //            oRsAux.Close
        //        //         End If
        //        //         oRs.Close
        //        //         With oRsCont
        //        //            .AddNew
        //        //           s.Ejercicio = mvarEjercicio
        //        //           s.IdCuentaSubdiario = mvarCuentaVentasTitulo
        //        //           s.IdCuenta = mvarCuentaPercepcionIIBB
        //        //           s.IdTipoComprobante = 1
        //        //           s.NumeroComprobante = o.NumeroRecibo
        //        //           s.FechaComprobante = mvarFecha
        //        //           s.IdComprobante = Registro.Fields(0).Value
        //        //           s.Haber = o.RetencionIBrutos1
        //        //           s.IdMoneda = o.IdMoneda
        //        //           s.CotizacionMoneda = o.CotizacionMoneda
        //        //            .Update
        //        //         End With
        //        //      End If
        //        //   End If

        //        s = movimient(mvarEjercicio, mvarCuentaVentasTitulo, mvarCuentaIvaInscripto, 1, o.NumeroRecibo, mvarFecha, o.IdRecibo, o.ImporteIva2, o.IdMoneda, o.CotizacionMoneda);
        //        if (s != null) db.Subdiarios.Add(s);


        //        //   If Not IsNull(o.RetencionIBrutos2) Then
        //        //      If o.RetencionIBrutos2 <> 0 Then
        //        //         Set oRs = oSrv.LeerUno("IBCondiciones", o.IdIBCondicion2)
        //        //         mvarCuentaPercepcionIIBB = IIf(IsNull(oRs.Fields("IdCuentaPercepcionIIBB), 0, oRs.Fields("IdCuentaPercepcionIIBB)
        //        //         If Not IsNull(oRs.Fields("IdProvincia) Then
        //        //            Set oRsAux = oSrv.LeerUno("Provincias", oRs.Fields("IdProvincia)
        //        //            If oRsAux.RecordCount > 0 Then
        //        //               If Not IsNull(oRsAux.Fields("IdCuentaPercepcionIBrutos) Then
        //        //                  mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIBrutos
        //        //               End If
        //        //               If o.ConvenioMultilateral = "SI" And _
        //        //                     Not IsNull(oRsAux.Fields("IdCuentaPercepcionIIBBConvenio) Then
        //        //                  mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIIBBConvenio
        //        //               End If
        //        //            End If
        //        //            oRsAux.Close
        //        //         End If
        //        //         oRs.Close
        //        //         With oRsCont
        //        //            .AddNew
        //        //           s.Ejercicio = mvarEjercicio
        //        //           s.IdCuentaSubdiario = mvarCuentaVentasTitulo
        //        //           s.IdCuenta = mvarCuentaPercepcionIIBB
        //        //           s.IdTipoComprobante = 1
        //        //           s.NumeroComprobante = o.NumeroRecibo
        //        //           s.FechaComprobante = mvarFecha
        //        //           s.IdComprobante = Registro.Fields(0).Value
        //        //           s.Haber = o.RetencionIBrutos2
        //        //           s.IdMoneda = o.IdMoneda
        //        //           s.CotizacionMoneda = o.CotizacionMoneda
        //        //            .Update
        //        //         End With
        //        //      End If
        //        //   End If
        //        s = movimient(mvarEjercicio, mvarCuentaVentasTitulo, mvarCuentaIvaInscripto, 1, o.NumeroRecibo, mvarFecha, o.IdRecibo, o.ImporteIva2, o.IdMoneda, o.CotizacionMoneda);
        //        if (s != null) db.Subdiarios.Add(s);

        //        //   If Not IsNull(o.RetencionIBrutos3) Then
        //        //      If o.RetencionIBrutos3 <> 0 Then
        //        //         Set oRs = oSrv.LeerUno("IBCondiciones", o.IdIBCondicion3)
        //        //         mvarCuentaPercepcionIIBB = IIf(IsNull(oRs.Fields("IdCuentaPercepcionIIBB), 0, oRs.Fields("IdCuentaPercepcionIIBB)
        //        //         If Not IsNull(oRs.Fields("IdProvincia) Then
        //        //            Set oRsAux = oSrv.LeerUno("Provincias", oRs.Fields("IdProvincia)
        //        //            If oRsAux.RecordCount > 0 Then
        //        //               If Not IsNull(oRsAux.Fields("IdCuentaPercepcionIBrutos) Then
        //        //                  mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIBrutos
        //        //               End If
        //        //               If o.ConvenioMultilateral = "SI" And _
        //        //                     Not IsNull(oRsAux.Fields("IdCuentaPercepcionIIBBConvenio) Then
        //        //                  mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIIBBConvenio
        //        //               End If
        //        //            End If
        //        //            oRsAux.Close
        //        //         End If
        //        //         oRs.Close
        //        //         With oRsCont
        //        //            .AddNew
        //        //           s.Ejercicio = mvarEjercicio
        //        //           s.IdCuentaSubdiario = mvarCuentaVentasTitulo
        //        //           s.IdCuenta = mvarCuentaPercepcionIIBB
        //        //           s.IdTipoComprobante = 1
        //        //           s.NumeroComprobante = o.NumeroRecibo
        //        //           s.FechaComprobante = mvarFecha
        //        //           s.IdComprobante = Registro.Fields(0).Value
        //        //           s.Haber = o.RetencionIBrutos3
        //        //           s.IdMoneda = o.IdMoneda
        //        //           s.CotizacionMoneda = o.CotizacionMoneda
        //        //            .Update
        //        //         End With
        //        //      End If
        //        //   End If

        //        s = movimient(mvarEjercicio, mvarCuentaVentasTitulo, mvarCuentaIvaInscripto, 1, o.NumeroRecibo, mvarFecha, o.IdRecibo, o.ImporteIva2, o.IdMoneda, o.CotizacionMoneda);
        //        if (s != null) db.Subdiarios.Add(s);

        //        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        //        //   If Not IsNull(o.OtrasPercepciones1) Then
        //        //      If o.OtrasPercepciones1 <> 0 Then
        //        //         With oRsCont
        //        //            .AddNew
        //        //           s.Ejercicio = mvarEjercicio
        //        //           s.IdCuentaSubdiario = mvarCuentaVentasTitulo
        //        //           s.IdCuenta = mvarCuentaOtrasPercepciones1
        //        //           s.IdTipoComprobante = 1
        //        //           s.NumeroComprobante = o.NumeroRecibo
        //        //           s.FechaComprobante = mvarFecha
        //        //           s.IdComprobante = Registro.Fields(0).Value
        //        //           s.Haber = o.OtrasPercepciones1
        //        //           s.IdMoneda = o.IdMoneda
        //        //           s.CotizacionMoneda = o.CotizacionMoneda
        //        //            .Update
        //        //         End With
        //        //      End If
        //        //   End If

        //        //   If Not IsNull(o.OtrasPercepciones2) Then
        //        //      If o.OtrasPercepciones2 <> 0 Then
        //        //         With oRsCont
        //        //            .AddNew
        //        //           s.Ejercicio = mvarEjercicio
        //        //           s.IdCuentaSubdiario = mvarCuentaVentasTitulo
        //        //           s.IdCuenta = mvarCuentaOtrasPercepciones2
        //        //           s.IdTipoComprobante = 1
        //        //           s.NumeroComprobante = o.NumeroRecibo
        //        //           s.FechaComprobante = mvarFecha
        //        //           s.IdComprobante = Registro.Fields(0).Value
        //        //           s.Haber = o.OtrasPercepciones2
        //        //           s.IdMoneda = o.IdMoneda
        //        //           s.CotizacionMoneda = o.CotizacionMoneda
        //        //            .Update
        //        //         End With
        //        //      End If
        //        //   End If
        //        s = movimient(mvarEjercicio, mvarCuentaVentasTitulo, mvarCuentaIvaInscripto, 1, o.NumeroRecibo, mvarFecha, o.IdRecibo, o.ImporteIva2, o.IdMoneda, o.CotizacionMoneda);
        //        if (s != null) db.Subdiarios.Add(s);


        //        //   If Not IsNull(o.OtrasPercepciones3) Then
        //        //      If o.OtrasPercepciones3 <> 0 Then
        //        //         With oRsCont
        //        //            .AddNew
        //        //           s.Ejercicio = mvarEjercicio
        //        //           s.IdCuentaSubdiario = mvarCuentaVentasTitulo
        //        //           s.IdCuenta = mvarCuentaOtrasPercepciones3
        //        //           s.IdTipoComprobante = 1
        //        //           s.NumeroComprobante = o.NumeroRecibo
        //        //           s.FechaComprobante = mvarFecha
        //        //           s.IdComprobante = Registro.Fields(0).Value
        //        //           s.Haber = o.OtrasPercepciones3
        //        //           s.IdMoneda = o.IdMoneda
        //        //           s.CotizacionMoneda = o.CotizacionMoneda
        //        //            .Update
        //        //         End With
        //        //      End If
        //        //   End If

        //        //   If Not IsNull(o.PercepcionIVA) Then
        //        //      If o.PercepcionIVA <> 0 Then
        //        //         With oRsCont
        //        //            .AddNew
        //        //           s.Ejercicio = mvarEjercicio
        //        //           s.IdCuentaSubdiario = mvarCuentaVentasTitulo
        //        //           s.IdCuenta = mvarCuentaPercepcionesIVA
        //        //           s.IdTipoComprobante = 1
        //        //           s.NumeroComprobante = o.NumeroRecibo
        //        //           s.FechaComprobante = mvarFecha
        //        //           s.IdComprobante = Registro.Fields(0).Value
        //        //           s.Haber = o.PercepcionIVA
        //        //           s.IdMoneda = o.IdMoneda
        //        //           s.CotizacionMoneda = o.CotizacionMoneda
        //        //            .Update
        //        //         End With
        //        //      End If
        //        //   End If
        //        movimient(mvarEjercicio, mvarCuentaVentasTitulo, mvarCuentaIvaInscripto, 1, o.NumeroRecibo, mvarFecha, o.IdRecibo, o.ImporteIva2, o.IdMoneda, o.CotizacionMoneda);

        //        foreach (DetalleRecibo i in o.DetalleRecibos)
        //        {
        //            s = new Subdiario();


        //            //var a= s.  db.Articulos.Include(x=>x.Cuenta).Where(
        //            //                   Set oRs = oSrv.TraerFiltrado("Articulos", "_DatosConCuenta",s.IdArticulo)
        //            mvarNetoGravadoItem = (double)((i.Cantidad ?? 0) * (i.PrecioUnitario ?? 0) * (1 - (i.Bonificacion ?? 0 / 100)));
        //            //                    mvarNetoGravadoItem = 0;
        //            //if (mvarIvaNoDiscriminado > 0 ) {
        //            //   mvarNetoGravadoItem = Round(mvarNetoGravadoItem * (mvarSubtotal - mvarIvaNoDiscriminado) / mvarSubtotal, 2)
        //            //   mvarNetoGravadoItemSuma = mvarNetoGravadoItemSuma + mvarNetoGravadoItem
        //            //}


        //            s.Ejercicio = mvarEjercicio;
        //            s.IdCuentaSubdiario = mvarCuentaVentasTitulo;

        //            var q = db.Articulos.Include("Rubro").Include("Cuenta").SingleOrDefault(x => x.IdArticulo == i.IdArticulo);

        //            s.IdCuenta = q.Rubro.IdCuenta; // db.Articulos_TX_DatosConCuenta(i.IdArticulo).Select(x => x.IdCuenta).FirstOrDefault();
        //            s.IdTipoComprobante = 1;
        //            s.NumeroComprobante = o.NumeroRecibo;
        //            s.FechaComprobante = mvarFecha;
        //            s.IdComprobante = o.IdRecibo;
        //            if (mvarNetoGravadoItem >= 0)
        //            { s.Haber = (decimal)mvarNetoGravadoItem; }
        //            else
        //            { s.Debe = (decimal)mvarNetoGravadoItem * -1; }

        //            s.IdMoneda = o.IdMoneda;
        //            s.CotizacionMoneda = o.CotizacionMoneda;

        //            if (mvarNetoGravadoItem > 0) db.Subdiarios.Add(s);
        //        }





        //        // modifica los registros nuevos

        //        //   Set oRsDetBD = oSrv.TraerFiltrado("DetRecibos", "_PorIdCabecera", Registro.Fields(0).Value)
        //        //            If Not mvarEsta Then
        //        //               Set oRs = oSrv.TraerFiltrado("Articulos", "_DatosConCuenta",s.IdArticulo)
        //        //               mvarNetoGravadoItem = Round(oRsDetBD.Fields("Cantidad * _
        //        //                                       IIf(IsNull(oRsDetBD.Fields("PrecioUnitario), 0, oRsDetBD.Fields("PrecioUnitario) * _
        //        //                                       (1 - IIf(IsNull(oRsDetBD.Fields("Bonificacion), 0, oRsDetBD.Fields("Bonificacion) / 100), 2)
        //        //               If mvarIvaNoDiscriminado > 0 Then
        //        //                  mvarNetoGravadoItem = Round(mvarNetoGravadoItem * (mvarSubtotal - mvarIvaNoDiscriminado) / mvarSubtotal, 2)
        //        //                  mvarNetoGravadoItemSuma = mvarNetoGravadoItemSuma + mvarNetoGravadoItem
        //        //               End If
        //        //               With oRsCont
        //        //                  .AddNew
        //        //                 s.Ejercicio = mvarEjercicio
        //        //                 s.IdCuentaSubdiario = mvarCuentaVentasTitulo
        //        //                 s.IdCuenta = oRs.Fields("IdCuenta
        //        //                 s.IdTipoComprobante = 1
        //        //                 s.NumeroComprobante = o.NumeroRecibo
        //        //                 s.FechaComprobante = mvarFecha
        //        //                 s.IdComprobante = Registro.Fields(0).Value
        //        //                  If mvarNetoGravadoItem >= 0 Then
        //        //                    s.Haber = mvarNetoGravadoItem
        //        //                  Else
        //        //                    s.Debe = mvarNetoGravadoItem * -1
        //        //                  End If
        //        //                 s.IdMoneda = o.IdMoneda
        //        //                 s.CotizacionMoneda = o.CotizacionMoneda
        //        //                  .Update
        //        //               End With



        //        //   If mvarIvaNoDiscriminado > 0 Then
        //        //      If Round(mvarNetoGravadoItemSuma + mvarIvaNoDiscriminado, 2) <> mvarSubtotal Then
        //        //         With oRsCont
        //        //           s.Haber =s.Haber + (mvarSubtotal - (mvarNetoGravadoItemSuma + mvarIvaNoDiscriminado))
        //        //            .Update
        //        //         End With
        //        //      End If
        //        //   End If


        //    }
        //    catch (Exception ex)
        //    {

        //        throw;
        //    }


        //    // verificar que el asiento da 0
        //    // http://stackoverflow.com/questions/3627801/is-it-possible-to-see-added-entities-from-an-unsaved-ef4-context
        //    //var addedCustomers = from se in db.ObjectContext.get db.ObjectStateManager.GetObjectStateEntries(System.Data.Entity.EntityState.Added)
        //    //     where se.Entity is Subdiario
        //    //     select se.Entity;

        //}


        private Subdiario movimient(int? mvarEjercicio, int? mvarCuentaVentasTitulo, int? mvarCuentaIvaInscripto, int? d, int? NumeroRecibo, DateTime? mvarFecha, int? Registr, decimal? ImporteIva2, int? IdMoneda, decimal? CotizacionMoneda)
        {
            //if (deber && haber =0) return;
            if ((ImporteIva2 ?? 0) <= 0) return null;
            var s = new Subdiario();
            s.Ejercicio = mvarEjercicio;
            s.IdCuentaSubdiario = mvarCuentaVentasTitulo;
            s.IdCuenta = mvarCuentaIvaInscripto;
            s.IdTipoComprobante = 1;
            s.NumeroComprobante = NumeroRecibo;
            s.FechaComprobante = mvarFecha;
            s.IdComprobante = Registr;


            //if
            //elseif 
            s.Haber = ImporteIva2 ?? 0;
            //else
            //s.Deber= Deber;
            //else


            s.IdMoneda = IdMoneda;
            s.CotizacionMoneda = CotizacionMoneda;
            return s;
        }



        //public void Logica_ActualizarCuentaCorriente(Recibo o)
        //{

        //    var mImporteAnterior = 0;
        //    var mTotalAnteriorDolar = 0;


        //    ProntoMVC.Data.Models.CuentasCorrientesDeudor a = new CuentasCorrientesDeudor();


        //    if (o.IdRecibo <= 0)
        //    {
        //        //            mImporteAnterior = iisNull(.Item("ImporteTotal"), 0)
        //        //            mTotalAnteriorDolar = iisNull(.Item("ImporteTotalDolar"), 0)
        //    }
        //    a.IdCliente = o.IdCliente;
        //    a.NumeroComprobante = o.NumeroRecibo;
        //    a.Fecha = o.FechaRecibo; // mvarFecha;
        //    a.IdTipoComp = 1;
        //    a.FechaVencimiento = o.FechaVencimiento;
        //    a.IdComprobante = o.IdRecibo;
        //    a.Cotizacion = o.CotizacionDolar;
        //    a.IdMoneda = o.IdMoneda;
        //    a.CotizacionMoneda = o.CotizacionMoneda;

        //    if (o.Anulada == "SI")
        //    {
        //        a.ImporteTotal = 0;
        //        a.Saldo = 0;
        //        a.ImporteTotalDolar = 0;
        //        a.SaldoDolar = 0;
        //    }
        //    else
        //    {
        //        a.ImporteTotal = Math.Round(o.ImporteTotal * o.CotizacionMoneda ?? 0, 2);
        //        a.Saldo = Math.Round(o.ImporteTotal * o.CotizacionMoneda ?? 0, 2) - mImporteAnterior;
        //        a.ImporteTotalDolar = o.ImporteTotal * o.CotizacionMoneda / o.CotizacionDolar;
        //        a.SaldoDolar = (o.ImporteTotal * o.CotizacionMoneda / o.CotizacionDolar) - mTotalAnteriorDolar;
        //    }

        //    db.CuentasCorrientesDeudores.Add(a);


        //    // ?????  a.IdImputacion=


        //    //    '////////////////////////////
        //    //    'cambio el saldo en la entidad cliente
        //    //    '////////////////////////////
        //    if (o.IdCliente > 0)
        //    {
        //        var c = db.Clientes.Find(o.IdCliente);

        //        if (o.Anulada == "SI")
        //        {
        //            c.Saldo += -mImporteAnterior;
        //        }
        //        else
        //        {
        //            c.Saldo += -mImporteAnterior + Math.Round((o.ImporteTotal ?? 0) * (o.CotizacionMoneda ?? 0), 2);
        //        }


        //    }






        //}


      






        void Logica_ReciboElectronica_BonosFiscales()
        {
            //If Len(Trim(glbArchivoAFIP)) = 0 Then
            //   Me.MousePointer = vbDefault
            //   MsgBox "No ha definido el archivo con el certificado AFIP, ingrese a los datos de la empresa y registrelo", vbInformation
            //   Exit Sub
            //End If

            //If mvarTipoABC = "A" Then
            //   mTipoComprobante = 1
            //Else
            //   mTipoComprobante = 6
            //End If

            //mCodigoMoneda = 0
            //Set oRs = Aplicacion.Monedas.TraerFiltrado("_PorId", dcfields(3).BoundText)
            //If oRs.RecordCount > 0 Then
            //   If Not IsNull(oRs.Fields("CodigoAFIP").Value) Then
            //      If IsNumeric(oRs.Fields("CodigoAFIP").Value) Then
            //         mCodigoMoneda = oRs.Fields("CodigoAFIP").Value
            //      End If
            //   End If
            //End If
            //oRs.Close
            //If mCodigoMoneda = 0 Then
            //   If dcfields(3).BoundText = glbIdMonedaPesos Then mCodigoMoneda = 1
            //   If dcfields(3).BoundText = glbIdMonedaDolar Then mCodigoMoneda = 2
            //   If dcfields(3).BoundText = glbIdMonedaEuro Then mCodigoMoneda = 60
            //End If


            // FE = CreateObject("WSAFIPFE.Recibo");


            /////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////

            /*
        mResul = FE.ActivarLicenciaSiNoExiste(Replace(glbCuit, "-", ""), glbPathPlantillas & "\FE_" & Replace(glbCuit, "-", "") & ".lic", "pronto.wsfex@gmail.com", "bdlconsultores")
        If glbDebugReciboElectronica Then
           MsgBox "ActivarLicencia : " & glbPathPlantillas & "\FE_" & Replace(glbCuit, "-", "") & ".lic" & " - UltimoMensajeError : " & FE.UltimoMensajeError
        End If
            
        'FE.ProxyConfigurar False
        mFecha = "" & Year(DTFields(0).Value) & Format(Month(DTFields(0).Value), "00") & Format(Day(DTFields(0).Value), "00")
        If mModoTest = "SI" Then
           mResul = FE.iniciar(0, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", "")
        Else
           'If Len(Dir(glbPathPlantillas & "\SCFE9.lic")) > 0 Then
              'mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", glbPathPlantillas & "\SCFE9.lic")
              mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", glbPathPlantillas & "\FE_" & Replace(glbCuit, "-", "") & ".lic")
           'Else
              'mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", "")
           'End If
        End If
              
        If mResul Then mResul = FE.bObtenerTicketAcceso()
        With FE
           If glbDebugReciboElectronica Then
              MsgBox "ObtenerTicketAcceso : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError
              mResul = .Dummy
              MsgBox "Dummy : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError
           End If
           If mResul Then
              .bTipo_Doc = 80
              .bNro_doc = Replace(txtCuit.Text, "-", "")
              .bTipo_cbte = mTipoComprobante
              .bPunto_vta = dcfields(10).Text
              .bImp_total = mvarTotalRecibo
              .bImp_neto = mvarSubTotal - mvarImporteBonificacion
              .bimpto_liq = 0
              .bimpto_liq_rni = 0
              .bimp_op_ex = 0
              .bImp_perc = Val(txtTotal(6).Text) + Val(txtTotal(7).Text) + Val(txtTotal(10).Text)
              .bImp_iibb = mvarPorcentajeIBrutos + mvarPorcentajeIBrutos2 + mvarPorcentajeIBrutos3
              .bImp_internos = 0
              .bImp_moneda_id = mCodigoMoneda
              .bImp_moneda_ctz = Val(txtCotizacionMoneda.Text)
              .bFecha_cbte = mFecha
              .bZona = 1

              Set oRs = origen.DetRecibos.TodosLosRegistros
              If oRs.Fields.Count > 0 Then
                 If oRs.RecordCount > 0 Then
                    mCantidadItem = 0
                    oRs.MoveFirst
                    Do While Not oRs.EOF
                       If oRs.Fields("Eliminado").Value <> "SI" Then mCantidadItem = mCantidadItem + 1
                       oRs.MoveNext
                    Loop
                    .bItemCantidad = mCantidadItem
                    mNumeroItem = 0
                    oRs.MoveFirst
                    Do While Not oRs.EOF
                       If oRs.Fields("Eliminado").Value <> "SI" Then
                          mDescripcion = ""
                          mNCM = ""
                          Set oRs1 = Aplicacion.Articulos.TraerFiltrado("_PorId", oRs.Fields("IdArticulo").Value)
                          If oRs1.RecordCount > 0 Then
                             mDescripcion = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
                             mNCM = IIf(IsNull(oRs1.Fields("AuxiliarString10").Value), "", oRs1.Fields("AuxiliarString10").Value)
                          End If
                          If Len(mNCM) = 0 Then mNCM = "99.99.99.99"
                          oRs1.Close
                          .bIndiceItem = mNumeroItem
                          .bITEMpro_codigo_sec = "0"
                          .bITEMpro_codigo_ncm = mNCM
                          .bITEMpro_ds = mDescripcion
                          .bITEMpro_precio_uni = oRs.Fields("PrecioUnitario").Value
                          .bITEMpro_qty = oRs.Fields("Cantidad").Value
                          .bITEMpro_umed = 7
                          .bITEMIva_id = 1
                          .bITEMimp_total = Round(IIf(IsNull(oRs.Fields("Cantidad").Value), 0, oRs.Fields("Cantidad").Value) * _
                                                        IIf(IsNull(oRs.Fields("PrecioUnitario").Value), 0, oRs.Fields("PrecioUnitario").Value) * _
                                                        (1 - (IIf(IsNull(oRs.Fields("Bonificacion").Value), 0, oRs.Fields("Bonificacion").Value) / 100)), 2)
                          .bITEMimp_bonif = Round(IIf(IsNull(oRs.Fields("Cantidad").Value), 0, oRs.Fields("Cantidad").Value) * _
                                                        IIf(IsNull(oRs.Fields("PrecioUnitario").Value), 0, oRs.Fields("PrecioUnitario").Value) * _
                                                        IIf(IsNull(oRs.Fields("Bonificacion").Value), 0, oRs.Fields("Bonificacion").Value) / 100, 2)
                          mNumeroItem = mNumeroItem + 1
                       End If
                       oRs.MoveNext
                    Loop
                 End If
              End If
              Set oRs = Nothing

              If glbDebugReciboElectronica Then
                 .ArchivoXMLEnviado = "C:\XMLEnviado.xml"
                 .ArchivoXMLRecibido = "C:\XMLRecibido.xml"
              End If
                  
              Randomize
              mIdentificador = CLng(Rnd * 100000000)
              mResul = .bRegistrar(dcfields(10).Text, mTipoComprobante, "" & mIdentificador)
              'mResul = .bRegistrarConNumero(dcfields(10).Text, mTipoComprobante, "" & mvarId, 1)
              If glbDebugReciboElectronica Then
                 MsgBox "Registrar : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError & " - Motivo : " & .FERespuestaMotivo
                 rchReciboElectronica.Text = "Request : " & FE.XMLRequest & vbCrLf & vbCrLf & "Response : " & FE.XMLResponse
              End If
                  
              If mResul Then
                 mCAE = .bRespuestaCAE
                 mDescripcion = Chr(10) + "CAE: " + .bRespuestaCAE + Chr(10) + "REPROCESO " + .bRespuestaReproceso + _
                                Chr(10) + "Evento " + .bEventMsg + Chr(10) + "Observacion: " + .bRespuestaOBS
                 With origen.Registro
                    .Fields("CAE").Value = mCAE
                    .Fields("IdIdentificacionCAE").Value = mIdentificador
                    If IsDate(FE.bRespuestaFch_venc_cae) Then
                       .Fields("FechaVencimientoORechazoCAE").Value = FE.bRespuestaFch_venc_cae
                    End If
                    '.Fields("Observaciones").Value = .Fields("Observaciones").Value + Chr(10) + mDescripcion
                 End With
              Else
                 Me.MousePointer = vbDefault
                 MsgBox "Error al obtener CAE : " + .Permsg + "Detalle: " + .UltimoMensajeError, vbExclamation
                 Exit Sub
              End If
           Else
              Me.MousePointer = vbDefault
              MsgBox "Error al obtener CAE : " + .Permsg + "Detalle: " + .UltimoMensajeError, vbExclamation
              Exit Sub
           End If
        End With
        Set FE = Nothing*/

        }






        void Logica_RecalcularTotales(ref Recibo myRecibo)
        {

            // myRecibo.ImporteTotal;
            //myRecibo.DetalleRecibos.Select(x=>x.IdArticulo)

            //    Dim mvarSubTotal, mvarIVA1 As Single




            //    With myRecibo

            //        If .IdCliente <= 0 Then
            //            Err.Raise(345, , "Para calcular la Recibo se necesita el IdCliente")
            //        End If

            //        Dim oRs As ADODB.Recordset
            //        Dim oL As ReciboItem 'As ListItem
            //        Dim i As Integer, mIdProvinciaIIBB As Integer
            //        Dim mNumeroCertificadoPercepcionIIBB As Long
            //        Dim t0 As Double, t1 As Double, t2 As Double, t3 As Double, mParteDolar As Double
            //        Dim mPartePesos As Double, mBonificacion As Double, mKilos As Double
            //        Dim mPrecioUnitario As Double, mCantidad As Double, mTopeIIBB As Double
            //        Dim mFecha1 As Date

            //        t0 = 0
            //        t1 = 0
            //        t2 = 0
            //        t3 = 0
            //        'Dim mvarSubTotal = 0
            //        Dim mvarIBrutos = 0
            //        Dim mvarIBrutos2 = 0
            //        Dim mvarIBrutos3 = 0
            //        Dim mvarPorcentajeIBrutos = 0
            //        Dim mvarPorcentajeIBrutos2 = 0
            //        Dim mvarPorcentajeIBrutos3 = 0
            //        Dim mvar_IBrutos_Cap = 0
            //        Dim mvar_IBrutos_BsAs = 0
            //        Dim mvar_IBrutos_BsAsM = 0
            //        Dim mvarMultilateral = "NO"
            //        'Dim mvarIVA1 = 0
            //        Dim mvarIVA2 = 0
            //        Dim mvarTotalRecibo As Double = 0
            //        Dim mvarParteDolares = 0
            //        Dim mvarPartePesos = 0
            //        Dim mvarImporteBonificacion = 0
            //        Dim mvarNetoGravado = 0
            //        Dim mvarPorcentajeBonificacion = 0
            //        Dim mvarIVANoDiscriminado = 0
            //        Dim mvarPercepcionIVA = 0
            //        Dim mvarDecimales = 2

            //        Dim mvarLocalidad
            //        Dim mvarZona
            //        Dim mvarProvincia
            //        Dim mvarTipoIVA
            //        Dim mvarCondicionVenta
            //        Dim mvarIBCondicion
            //        Dim mvarIdIBCondicion
            //        Dim mvarIdIBCondicion2
            //        Dim mvarIdIBCondicion3
            //        Dim mvarEsAgenteRetencionIVA
            //        Dim mvarPorcentajePercepcionIVA
            //        Dim mvarBaseMinimaParaPercepcionIVA
            //        Dim mAlicuotaDirecta
            //        Dim mFechaInicioVigenciaIBDirecto
            //        Dim mFechaFinVigenciaIBDirecto

            //        Dim oCli As Cliente = ClienteManager.GetItem(SC, .IdCliente)

            //        For Each oL In .Detalles
            //            With oL
            //                If Not .Eliminado Then
            //                    mPrecioUnitario = .Precio
            //                    mCantidad = .Cantidad
            //                    mBonificacion = .PorcentajeBonificacion 'IIf(IsNull(.Registro.Fields("Bonificacion").Value), 0, .Registro.Fields("Bonificacion").Value)

            //                    'EDU: que son estos t
            //                    t0 = t0 '+ Val(oL.ListSubItems(2))
            //                    t1 = t1 '+ Val(oL.ListSubItems(3))
            //                    t2 = t2 + mCantidad
            //                    t3 = t3 + Math.Round(mCantidad * mPrecioUnitario * (1 - mBonificacion / 100) + 0.0001, 2)
            //                    'Debug.PrintMath.round(mCantidad * mPrecioUnitario * (1 - mBonificacion / 100) + 0.0001, 2)
            //                End If
            //            End With
            //        Next




            //        With oCli
            //            mvarLocalidad = .IdLocalidad
            //            mvarZona = 0
            //            mvarProvincia = .IdProvincia
            //            mvarTipoIVA = .IdCodigoIva
            //            mvarCondicionVenta = .IdCondicionVenta
            //            mvarIBCondicion = .IBCondicion
            //            mvarIdIBCondicion = .IdIBCondicionPorDefecto
            //            mvarIdIBCondicion2 = .IdIBCondicionPorDefecto2
            //            mvarIdIBCondicion3 = .IdIBCondicionPorDefecto3
            //            mvarEsAgenteRetencionIVA = .esAgenteRetencionIVA
            //            mvarPorcentajePercepcionIVA = .PorcentajePercepcionIVA
            //            mvarBaseMinimaParaPercepcionIVA = iisNull(.BaseMinimaParaPercepcionIVA, 0)
            //            mAlicuotaDirecta = .PorcentajeIBDirecto
            //            mFechaInicioVigenciaIBDirecto = .FechaInicioVigenciaIBDirecto
            //            mFechaFinVigenciaIBDirecto = .FechaFinVigenciaIBDirecto
            //        End With



            //        mvarSubTotal = t3

            //        If .Id > 0 Then
            //            'Recibo EXISTENTE

            //            mvarTotalRecibo = .Total
            //            mvarIVA1 = .ImporteIva1
            //            mvarIVA2 = .ImporteIva2
            //            mvarIVANoDiscriminado = .IVANoDiscriminado
            //            mvarIBrutos = .RetencionIBrutos1
            //            mvarPorcentajeIBrutos = .PorcentajeIBrutos1
            //            mvarIBrutos2 = .RetencionIBrutos2
            //            mvarPorcentajeIBrutos2 = .PorcentajeIBrutos2
            //            mvarMultilateral = .ConvenioMultilateral
            //            mvarIBrutos3 = .RetencionIBrutos3
            //            mvarPorcentajeIBrutos3 = .PorcentajeIBrutos3
            //            mvarParteDolares = .ImporteParteEnDolares
            //            mvarPartePesos = .ImporteParteEnPesos
            //            mvarImporteBonificacion = .ImporteBonificacion
            //            mvarPorcentajeBonificacion = .PorcentajeBonificacion
            //            mvarPercepcionIVA = .PercepcionIVA
            //        Else

            //            'Recibo NUEVA



            //            mvarImporteBonificacion = Math.Round((mvarSubTotal - .TotalBonifEnItems) * Val(.Bonificacion) / 100, 2)
            //            mvarNetoGravado = mvarSubTotal - mvarImporteBonificacion



            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            'TIPO DE IVA
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////


            //            Try
            //                mvarTipoIVA = oCli.IdCodigoIva
            //            Catch ex As Exception

            //            End Try


            //            'If Session("glbIdCodigoIva") = 1 Then
            //            Select Case mvarTipoIVA
            //                Case 1
            //                    mvarIVA1 = Math.Round(mvarNetoGravado * Val(.PorcentajeIva1) / 100, mvarDecimales)
            //                    mvarPartePesos = mvarPartePesos + Math.Round((mvarPartePesos + (mvarParteDolares * .Cotizacion)) * Val(.PorcentajeIva1) / 100, mvarDecimales)
            //                    .TipoRecibo = "A"
            //                Case 2
            //                    mvarIVA1 = Math.Round(mvarNetoGravado * Val(.PorcentajeIva1) / 100, mvarDecimales)
            //                    mvarIVA2 = Math.Round(mvarNetoGravado * Val(.PorcentajeIva2) / 100, mvarDecimales)
            //                    mvarPartePesos = mvarPartePesos + Math.Round((mvarPartePesos + (mvarParteDolares * .Cotizacion)) * Val(.PorcentajeIva1) / 100, mvarDecimales) + _
            //                    Math.Round((mvarPartePesos + (mvarParteDolares * .Cotizacion)) * Val(.PorcentajeIva2) / 100, mvarDecimales)
            //                    'TipoRecibo = "A"
            //                Case 3
            //                    'TipoRecibo = "E"
            //                Case 8
            //                    'TipoRecibo = "B"
            //                Case 9
            //                    'mvarTipoABC = "A"
            //                Case Else
            //                    mvarIVANoDiscriminado = Math.Round(mvarNetoGravado - (mvarNetoGravado / (1 + (Val(.PorcentajeIva1) / 100))), mvarDecimales)
            //                    'mvarTipoABC = "B"
            //            End Select
            //            'Else
            //            '    TipoRecibo = "C"
            //            'End If

            //            .TipoRecibo = LetraSegunTipoIVA(mvarTipoIVA)



            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            'INGRESOS BRUTOS CATEGORIA 1
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////


            //            Dim NumeroCertificadoPercepcionIIBB = DBNull.Value
            //            Dim dr As DataRow

            //            If .IdIBCondicion Then
            //                dr = EntidadManager.GetItem(SC, "IBCondiciones", .IdIBCondicion)



            //                mTopeIIBB = IIf(IsNull(dr.Item("ImporteTopeMinimoPercepcion")), 0, dr.Item("ImporteTopeMinimoPercepcion"))
            //                mIdProvinciaIIBB = IIf(IsNull(dr.Item("IdProvincia")), 0, dr.Item("IdProvincia"))
            //                mFecha1 = IIf(IsNull(dr.Item("FechaVigencia")), Today, dr.Item("FechaVigencia"))

            //                If iisNull(dr.Item("IdProvinciaReal"), iisNull(dr.Item("IdProvincia"), 0)) = 2 And _
            //                       .Fecha >= mFechaInicioVigenciaIBDirecto And _
            //                       .Fecha <= mFechaFinVigenciaIBDirecto Then
            //                    'mAlicuotaDirecta <> 0 And

            //                    mvarPorcentajeIBrutos = mAlicuotaDirecta
            //                Else
            //                    If mvarNetoGravado > mTopeIIBB And .Fecha >= mFecha1 Then
            //                        If mvarIBCondicion = 2 Then
            //                            mvarPorcentajeIBrutos = IIf(IsNull(dr.Item("AlicuotaPercepcionConvenio")), 0, dr.Item("AlicuotaPercepcionConvenio"))
            //                            mvarMultilateral = "SI"
            //                        Else
            //                            mvarPorcentajeIBrutos = IIf(IsNull(dr.Item("AlicuotaPercepcion")), 0, dr.Item("AlicuotaPercepcion"))
            //                        End If
            //                    End If
            //                End If
            //                mvarIBrutos = Math.Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos / 100, 2)



            //                If mvarIBrutos <> 0 Then
            //                    'dr = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaIIBB)

            //                    Try
            //                        mNumeroCertificadoPercepcionIIBB = _
            //                              IIf(IsNull(dr.Item("ProximoNumeroCertificadoPercepcionIIBB")), 1, _
            //                                  dr.Item("ProximoNumeroCertificadoPercepcionIIBB"))
            //                    Catch ex As Exception

            //                    End Try

            //                    'origen.Registro.item("NumeroCertificadoPercepcionIIBB") = mNumeroCertificadoPercepcionIIBB
            //                End If
            //                dr = Nothing
            //            End If

            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            'INGRESOS BRUTOS CATEGORIA 2
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////

            //            If .IdIBCondicion2 Then
            //                dr = EntidadManager.GetItem(SC, "IBCondiciones", .IdIBCondicion2)


            //                mTopeIIBB = IIf(IsNull(dr.Item("ImporteTopeMinimoPercepcion")), 0, dr.Item("ImporteTopeMinimoPercepcion"))
            //                mIdProvinciaIIBB = IIf(IsNull(dr.Item("IdProvincia")), 0, dr.Item("IdProvincia"))
            //                If IIf(IsNull(dr.Item("IdProvinciaReal")), dr.Item("IdProvincia"), dr.Item("IdProvinciaReal")) = 2 And _
            //                      .Fecha >= mFechaInicioVigenciaIBDirecto And _
            //                      .Fecha <= mFechaFinVigenciaIBDirecto Then
            //                    'mAlicuotaDirecta <> 0 And
            //                    mvarPorcentajeIBrutos2 = mAlicuotaDirecta
            //                Else
            //                    If mvarNetoGravado > mTopeIIBB And .Fecha >= mFecha1 Then
            //                        If mvarIBCondicion = 2 Then
            //                            mvarPorcentajeIBrutos2 = IIf(IsNull(dr.Item("AlicuotaPercepcionConvenio")), 0, dr.Item("AlicuotaPercepcionConvenio"))
            //                            mvarMultilateral = "SI"
            //                        Else
            //                            mvarPorcentajeIBrutos2 = IIf(IsNull(dr.Item("AlicuotaPercepcion")), 0, dr.Item("AlicuotaPercepcion"))
            //                        End If
            //                    End If
            //                End If
            //                mvarIBrutos2 = Math.Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos2 / 100, 2)



            //            End If


            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            'INGRESOS BRUTOS CATEGORIA 3
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////

            //            If .IdIBCondicion3 Then
            //                dr = EntidadManager.GetItem(SC, "IBCondiciones", .IdIBCondicion3)


            //                mTopeIIBB = IIf(IsNull(dr.Item("ImporteTopeMinimoPercepcion")), 0, dr.Item("ImporteTopeMinimoPercepcion"))
            //                mIdProvinciaIIBB = IIf(IsNull(dr.Item("IdProvincia")), 0, dr.Item("IdProvincia"))
            //                If IIf(IsNull(dr.Item("IdProvinciaReal")), dr.Item("IdProvincia"), dr.Item("IdProvinciaReal")) = 2 And _
            //                      .Fecha >= mFechaInicioVigenciaIBDirecto And _
            //                      .Fecha <= mFechaFinVigenciaIBDirecto Then
            //                    'mAlicuotaDirecta <> 0 And
            //                    mvarPorcentajeIBrutos3 = mAlicuotaDirecta
            //                Else
            //                    If mvarNetoGravado > mTopeIIBB And .Fecha >= mFecha1 Then
            //                        If mvarIBCondicion = 2 Then
            //                            mvarPorcentajeIBrutos3 = IIf(IsNull(dr.Item("AlicuotaPercepcionConvenio")), 0, dr.Item("AlicuotaPercepcionConvenio"))
            //                            mvarMultilateral = "SI"
            //                        Else
            //                            mvarPorcentajeIBrutos3 = IIf(IsNull(dr.Item("AlicuotaPercepcion")), 0, dr.Item("AlicuotaPercepcion"))
            //                        End If
            //                    End If
            //                End If
            //                mvarIBrutos3 = Math.Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos3 / 100, 2)


            //            End If

            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            'PERCEPCIONES (si no es AGENTE de RETENCION)
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////

            //            If Not mvarEsAgenteRetencionIVA And mvarNetoGravado >= mvarBaseMinimaParaPercepcionIVA Then
            //                mvarPercepcionIVA = Math.Round(mvarNetoGravado * mvarPorcentajePercepcionIVA / 100, mvarDecimales)
            //            End If





            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            'TOTAL FINAL
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////

            //            mvarTotalRecibo = mvarNetoGravado + mvarIVA1 + mvarIVA2 + mvarIBrutos + mvarIBrutos2 _
            //                            + mvarIBrutos3 + mvarPercepcionIVA + _
            //                            .OtrasPercepciones1 + .OtrasPercepciones2 + .OtrasPercepciones3


            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            'FIN DE CALCULO PARA Recibo NUEVA
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //            '//////////////////////////////////////////////////////////////////////////////////////
            //        End If


            //        'txtTotal(3).Text = Format(mvarSubTotal, "#,##0.00")
            //        'txtTotal(9).Text = Format(mvarImporteBonificacion, "#,##0.00")
            //        'txtTotal(4).Text = Format(mvarIVA1, "#,##0.00")
            //        'txtTotal(5).Text = Format(mvarIBrutos + mvarIBrutos2 + mvarIBrutos3, "#,##0.00")
            //        'txtTotal(11).Text = Format(mvarPercepcionIVA, "#,##0.00")
            //        'txtTotal(8).Text = Format(mvarTotalRecibo, "#,##0.00")


            //        'tendrías que dejarlo como en pronto, donde se usan las variables locales para los calculos
            //        '.TotalBonifEnItems = 0
            //        .ImporteIva1 = 0


            //        For Each det As ReciboItem In .Detalles
            //            With det

            //                If .Eliminado Then Continue For
            //                '////////////////////////
            //                'codigo comentado: así lo hacía antes de mover todo al manager
            //                'Dim temp As Decimal
            //                'txtSubtotal.Text = StringToDecimal(txtSubtotal.Text) + det.Cantidad * det.Precio
            //                'temp = (det.Cantidad * det.Precio * ((100 + det.PorcentajeIVA) / 100) * ((100 + det.PorcentajeBonificacion) / 100))
            //                'temp = temp + txtTotal.Text 'StringToDecimal(txtTotal.Text)
            //                'Debug.Print(temp)
            //                'txtTotal.Text = temp
            //                '////////////////////////


            //                '////////////////////////
            //                'Cálculo del item
            //                Dim mImporte = Val(.Precio) * Val(.Cantidad)
            //                '.ImporteBonificacion = Math.Round(mImporte * Val(.PorcentajeBonificacion) / 100, 4)
            //                '.ImporteIVA = Math.Round((mImporte - .ImporteBonificacion) * Val(.PorcentajeIVA) / 100, 4)
            //                '.ImporteTotalItem = mImporte - .ImporteBonificacion + .ImporteIVA
            //                '////////////////////////


            //                '////////////////////////
            //                'Sumador de totales
            //                myRecibo.SubTotal += mImporte
            //                'myPresupuesto.TotalBonifEnItems += .ImporteBonificacion
            //                'mvarIVA1 += .ImporteIVA
            //                '////////////////////////
            //            End With
            //        Next


            //        '////////////////////////
            //        'Asigno totales generales
            //        .SubTotal = mvarSubTotal '+ .TotalBonifEnItems - mvarIVA1 'no sé en qué casos va esto

            //        .RetencionIBrutos1 = mvarIBrutos
            //        .RetencionIBrutos2 = mvarIBrutos2
            //        .RetencionIBrutos3 = mvarIBrutos3

            //        .PercepcionIVA = mvarPercepcionIVA
            //        .TotalBonifSobreElTotal = Math.Round((mvarSubTotal - .TotalBonifEnItems) * Val(.Bonificacion) / 100, 2)
            //        .TotalSubGravado = mvarSubTotal - .TotalBonifSobreElTotal - .TotalBonifEnItems
            //        .IVANoDiscriminado = mvarIVANoDiscriminado
            //        .ImporteIva1 = mvarIVA1
            //        .Total = mvarTotalRecibo ' .TotalSubGravado + mvarIVA1 '+ mvarIVA2
            //    End With
            //End Sub
        }







    }
}