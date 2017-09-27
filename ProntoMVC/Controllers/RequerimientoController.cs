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
using System.Data.Entity.Core.Objects;
using System.Reflection;

using Pronto.ERP.Bll;


namespace ProntoMVC.Controllers
{
    public partial class RequerimientoController : ProntoBaseController
    {
        //
        // GET: /Requerimiento/

        //    [Authorize(Roles = "SuperAdmin,Requerimientos")] //ojo que el web.config tambien te puede bochar hacia el login




        public virtual ViewResult Index(bool bAConfirmar = false, bool bALiberar = false)
        {
            //var requerimientos = db.Requerimientos.Include(r => r.Obra).Include(r => r.Empleados).Include(r => r.Empleados1).Include(r => r.Sectores)
            //    .OrderBy(r => r.NumeroRequerimiento);
            //return View(db.Requerimientos.ToList());

            if (!PuedeLeer(enumNodos.Requerimientos)) throw new Exception("No tenés permisos");




            ViewBag.bAConfirmar = (bool)(Request.QueryString["bAConfirmar"].NullSafeToString() == "SI");
            ViewBag.bALiberar = (bool)(Request.QueryString["bALiberar"].NullSafeToString() == "SI");



            return View();
        }

        public virtual ViewResult RMsPendientesDeAsignar(bool bAConfirmar = false, bool bALiberar = false)
        {
            //var requerimientos = db.Requerimientos.Include(r => r.Obra).Include(r => r.Empleados).Include(r => r.Empleados1).Include(r => r.Sectores)
            //    .OrderBy(r => r.NumeroRequerimiento);
            //return View(db.Requerimientos.ToList());

            if (!PuedeLeer(enumNodos.Requerimientos)) throw new Exception("No tenés permisos");




            ViewBag.bAConfirmar = (bool)(Request.QueryString["bAConfirmar"].NullSafeToString() == "SI");
            ViewBag.bALiberar = (bool)(Request.QueryString["bALiberar"].NullSafeToString() == "SI");



            return View();
        }

        //
        // GET: /Requerimiento/Details/5

        public virtual ViewResult Details(int id)
        {
            Requerimiento requerimiento = db.Requerimientos.Find(id);
            return View(requerimiento);
        }

        //
        // GET: /Requerimiento/Create


        void inic(ref ProntoMVC.Data.Models.Requerimiento o)
        {
            //o.PorcentajeIva1 = 21;                  //  mvarP_IVA1_Tomado
            //o.FechaFactura = DateTime.Now;

            Parametros parametros = db.Parametros.Find(1);
            //o.OtrasPercepciones1 = 0;
            //o.OtrasPercepciones1Desc = ((parametros.OtrasPercepciones1 ?? "NO") == "SI") ? parametros.OtrasPercepciones1Desc : "";
            //o.OtrasPercepciones2 = 0;
            //o.OtrasPercepciones2Desc = ((parametros.OtrasPercepciones2 ?? "NO") == "SI") ? parametros.OtrasPercepciones2Desc : "";
            //o.OtrasPercepciones3 = 0;
            //o.OtrasPercepciones3Desc = ((parametros.OtrasPercepciones3 ?? "NO") == "SI") ? parametros.OtrasPercepciones3Desc : "";

            o.IdMoneda = 1;

            //string usuario = ViewBag.NombreUsuario;
            //var IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
            //var IdSector = (from item in db.Empleados where item.IdEmpleado == IdUsuario select item).SingleOrDefault().IdSector;
            //ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra");

            //o.IdSector = ;
            //o.IdSolicito=


            //mvarP_IVA1 = .Fields("Iva1").Value
            //mvarP_IVA2 = .Fields("Iva2").Value
            //mvarPorc_IBrutos_Cap = .Fields("Porc_IBrutos_Cap").Value
            //mvarTope_IBrutos_Cap = .Fields("Tope_IBrutos_Cap").Value
            //mvarPorc_IBrutos_BsAs = .Fields("Porc_IBrutos_BsAs").Value
            //mvarTope_IBrutos_BsAs = .Fields("Tope_IBrutos_BsAs").Value
            //mvarPorc_IBrutos_BsAsM = .Fields("Porc_IBrutos_BsAsM").Value
            //mvarTope_IBrutos_BsAsM = .Fields("Tope_IBrutos_BsAsM").Value
            //mvarDecimales = .Fields("Decimales").Value
            //mvarAclaracionAlPie = .Fields("AclaracionAlPieDeFactura").Value
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
            //var mvarCotizacion = db.Cotizaciones.OrderByDescending(x => x.IdCotizacion).FirstOrDefault().Cotizacion; //  mo  Cotizacion(Date, glbIdMonedaDolar);
            //o.CotizacionMoneda = 1;
            ////  o.CotizacionADolarFijo=
            //o.CotizacionDolar = (decimal)mvarCotizacion;

            o.DetalleRequerimientos.Add(new ProntoMVC.Data.Models.DetalleRequerimiento());
            o.DetalleRequerimientos.Add(new ProntoMVC.Data.Models.DetalleRequerimiento());
            o.DetalleRequerimientos.Add(new ProntoMVC.Data.Models.DetalleRequerimiento());

        }





        void CargarViewBag(Requerimiento o)
        {


            //ViewBag.IdObra = new SelectList(db.Obras.Where(x => x.Activa != "NO").OrderBy(x => x.NumeroObra)
            //                            .Select(y => new { y.IdObra, NumeroObra = y.NumeroObra + " - " + (y.Descripcion ?? "") }), "IdObra", "NumeroObra", o.IdObra);


            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            DataTable dt = EntidadManager.GetStoreProcedure(nSC, "Empleados_TX_PorSector", "Compras");
            IEnumerable<DataRow> rows = dt.AsEnumerable();
            var sq = (from r in rows orderby r[1] select new { IdEmpleado = r[0], Nombre = r[1] }).ToList();
            // ViewBag.Aprobo = new SelectList(db.Empleados.Where(x => (x.Activo ?? "SI") == "SI"  ).OrderBy(x => x.Nombre), "IdEmpleado", "Nombre", o.Aprobo);

            ViewBag.Aprobo = new SelectList(sq, "IdEmpleado", "Nombre", o.Aprobo);
            //ViewBag.Aprobo = new SelectList(db.Empleados.Where(x => (x.Activo ?? "SI") == "SI").OrderBy(x => x.Nombre), "IdEmpleado", "Nombre", o.Aprobo);



            ViewBag.IdSolicito = new SelectList(db.Empleados.Where(x => (x.Activo ?? "SI") == "SI").OrderBy(x => x.Nombre), "IdEmpleado", "Nombre", o.IdSolicito);
            ViewBag.IdSector = new SelectList(db.Sectores.OrderBy(x => x.Descripcion), "IdSector", "Descripcion", o.IdSector);
            ViewBag.CantidadAutorizaciones = db.Autorizaciones_TX_CantidadAutorizaciones((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.RequerimientoMateriales, 0, -1).Count();

            //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion");
            //ViewBag.PuntoVenta = new SelectList((from i in db.PuntosVentas
            //                                     where i.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Factura
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

            ////http://stackoverflow.com/questions/942262/add-empty-value-to-a-dropdownlist-in-asp-net-mvc
            //// http://stackoverflow.com/questions/7659612/mvc3-dropdownlist-and-viewbag-how-add-new-items-to-collection
            ////List<SelectListItem>  l = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);
            ////l.ad
            ////l.Add((new SelectListItem { IdIBCondicion = " ", Descripcion = "-1" }));
            //ViewBag.IdIBCondicionPorDefecto = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);



            //ViewBag.IdIBCondicionPorDefecto2 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion2);
            //ViewBag.IdIBCondicionPorDefecto3 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion3);



            Parametros parametros = db.Parametros.Find(1);
            ViewBag.PercepcionIIBB = parametros.PercepcionIIBB;

            //OrigenDescripcion en 3 cuando hay observaciones = SI
            string usuario = ViewBag.NombreUsuario;
            int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var idclav = db.ProntoIniClaves.Where(x => x.Clave == "OrigenDescripcion en 3 cuando hay observaciones").Select(x => x.IdProntoIniClave).FirstOrDefault();
            string idclava = db.ProntoIni.Where(x => x.IdProntoIniClave == idclav && x.IdUsuario == IdUsuario).Select(x => x.Valor).FirstOrDefault();
            idclava = BuscarClaveINI("OrigenDescripcion en 3 cuando hay observaciones");

            //   if (EntidadManager.BuscarClaveINI("OrigenDescripcion en 3 cuando hay observaciones", SC, IdUsuario) == "SI")
            if (idclava == "SI")
            {
                ViewBag.OrigenDescripcionDefault = 3;
            }
            else
            {
                ViewBag.OrigenDescripcionDefault = 1;
            }



            //ViewBag.IdEquipoDestino = GetCodigosArticulosAutocomplete_Equipos;


            if (o.IdRequerimiento > 0)
            {
                if (CantidadFirmasConfirmadas(Pronto.ERP.Bll.EntidadManager.EnumFormularios.RequerimientoMateriales, o.IdRequerimiento) == 0 &&
                     (o.Cumplido ?? "NO") != "SI")
                {
                    ActivarAnulacionLiberacion(true);
                }
                else
                {
                    ActivarAnulacionLiberacion(false);
                    ActivarAnulacionFirmas(true);
                }


            }

        }



        public void ActivarAnulacionLiberacion(bool Activar)
        {
            ViewBag.MostrarAnularLiberacion = false;

            if (Activar)
            {
                if (BuscarClaveINI("Habilitar eliminacion firmas en requerimientos") == "SI" || true)
                {
                    //With cmdAnularLiberacion
                    //   .Top = dcfields(4).Top
                    //   .Left = dcfields(4).Left
                    //   .Visible = True
                    //End With
                    //With dcfields(4)
                    //   .Left = cmdAnularLiberacion.Left + cmdAnularLiberacion.Width + 40
                    //   .Width = dcfields(4).Width - cmdAnularLiberacion.Width
                    //End With

                    ViewBag.MostrarAnularLiberacion = true;

                }
            }
            else
            {
                //With dcfields(4)
                //   .Left = dcfields(3).Left
                //   .Width = txtFechaAprobacion.Left - .Left
                //End With
                //cmdAnularLiberacion.Visible = False
                ViewBag.MostrarAnularLiberacion = false;
            }

        }

        public void ActivarAnulacionFirmas(bool Activar)
        {
            ViewBag.MostrarAnularFirmas = false; // y tapa al de anular liberacion

            if (Activar)
            {
                if (BuscarClaveINI("Habilitar eliminacion firmas en requerimientos") == "SI")
                {
                    ViewBag.MostrarAnularFirmas = true; // y tapa al de anular liberacion

                    //With cmdAnularFirmas
                    //   .Top = cmdAnularLiberacion.Top
                    //   .Left = cmdAnularLiberacion.Left
                    //   .Visible = True
                    //End With
                    //With dcfields(4)
                    //   .Left = cmdAnularLiberacion.Left + cmdAnularLiberacion.Width + 40
                    //   .Width = dcfields(4).Width - cmdAnularLiberacion.Width
                    //End With
                }
            }

        }






        private bool Validar(ProntoMVC.Data.Models.Requerimiento o, ref string sErrorMsg)
        {
            // una opcion es extender el modelo autogenerado, para ensoquetar ahí las validaciones
            // si no, podemos usar una funcion como esta, y devolver los  errores de dos maneras:
            // con ModelState.AddModelError si los devolvemos en una ViewResult,
            // o con un array de strings si es una JsonResult.
            //
            // If you are returning JSON, you cannot use ModelState.
            // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json


            if (!PuedeEditar(enumNodos.Facturas)) sErrorMsg += "\n" + "No tiene permisos de edición";


            if (o.IdRequerimiento <= 0)
            {
                //  string connectionString = Generales.sCadenaConexSQL(this.Session["BasePronto"].ToString());
                //  o.NumeroFactura = (int)Pronto.ERP.Bll.FacturaManager.ProximoNumeroFacturaPorIdCodigoIvaYNumeroDePuntoVenta(connectionString,o.IdCodigoIva ?? 0,o.PuntoVenta ?? 0);
            }

            if ((o.IdObra ?? 0) <= 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta la obra";
                // return false;
            }
            //if (o.NumeroFactura == null) sErrorMsg += "\n" + "Falta el número de factura";
            //// if (o.IdPuntoVenta== null) sErrorMsg += "\n" + "Falta el punto de venta";
            //if (o.IdCodigoIva == null) sErrorMsg += "\n" + "Falta el codigo de IVA";
            //if (o.IdCondicionVenta == null) sErrorMsg += "\n" + "Falta la condicion venta";
            //if (o.IdListaPrecios == null) sErrorMsg += "\n" + "Falta la lista de precios";



            string OrigenDescripcionDefault = BuscarClaveINI("OrigenDescripcion en 3 cuando hay observaciones");


            var reqsToDelete = o.DetalleRequerimientos.Where(x => (x.IdArticulo ?? 0) <= 0).ToList();
            foreach (var deleteReq in reqsToDelete)
            {
                o.DetalleRequerimientos.Remove(deleteReq);
            }
            if (o.DetalleRequerimientos.Count <= 0) sErrorMsg += "\n" + "El comprobante no tiene items";



            o.DirectoACompras = "SI";
            o.Confirmado = "SI";
            o.Adjuntos = "NO";


            Parametros parametros = db.Parametros.Find(1);
            var mvarIdUnidadCU = parametros.IdUnidadPorUnidad;
            var s = parametros.IdControlCalidadStandar;
            var s2 = parametros.ControlCalidadDefault;



            foreach (ProntoMVC.Data.Models.DetalleRequerimiento x in o.DetalleRequerimientos)
            {

                //   if (x.IdUnidad == null) x.IdUnidad = mvarIdUnidadCU;

                x.Adjunto = x.Adjunto ?? "NO";




                if (x.FechaEntrega == new DateTime(2001, 1, 1)) x.FechaEntrega = null;
                if (x.FechaEntrega < o.FechaRequerimiento && x.FechaEntrega != null)
                {
                    sErrorMsg += "\n" + "La fecha de entrega de " + db.Articulos.Find(x.IdArticulo).Descripcion + " es anterior a la del requerimiento";
                    //break;
                }





                if ((x.Cantidad ?? 0) <= 0) sErrorMsg += "\n" + (db.Articulos.Find(x.IdArticulo) ?? new Articulo()).Descripcion + " no tiene una cantidad válida";

                if (OrigenDescripcionDefault == "SI" && (x.Observaciones ?? "") != "") x.OrigenDescripcion = 3;

                //comparar con el original
                if (x.IdDetalleRequerimiento > 0)
                {
                    var detOriginal = db.DetalleRequerimientos.Find(x.IdDetalleRequerimiento);
                    if (detOriginal.Cumplido == "SI" && x.Cantidad != detOriginal.Cantidad)
                    {

                        sErrorMsg += "\n" + "El artículo " + db.Articulos.Find(x.IdArticulo).Descripcion + " no se puede modificar porque está cumplido";
                    }
                }
            }

            if ((o.Aprobo ?? 0) > 0 && o.FechaAprobacion == null) o.FechaAprobacion = DateTime.Now;

            if (sErrorMsg != "") return false;
            return true;

        }


        [HttpPost]
        public virtual JsonResult BatchUpdate(Requerimiento requerimiento)
        {


            // acá esta el temita de http://stackoverflow.com/questions/5538974/the-relationship-could-not-be-changed-because-one-or-more-of-the-foreign-key-pro

            if (!PuedeEditar(enumNodos.Requerimientos)) throw new Exception("No tenés permisos");


            try
            {


                string erar = "";


                if (!Validar(requerimiento, ref erar))
                {
                    try
                    {
                        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;


                        // http://stackoverflow.com/questions/434272/iis7-overrides-customerrors-when-setting-response-statuscode
                        Response.TrySkipIisCustomErrors = true;
                    }
                    catch (Exception)
                    {

                        //    throw;
                    }



                    //List<string> errors = new List<string>();
                    //errors.Add(erar);
                    //return Json(errors);




                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;



                    //List<string> errors = new List<string>();
                    //errors.Add(errs);
                    string[] words = erar.Split('\n');
                    res.Errors = words.ToList(); // GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El comprobante es inválido";

                    return Json(res);

                }


                if (ModelState.IsValid)
                {

                    requerimiento.ConfirmadoPorWeb = "SI";
                    //if (requerimiento.FechaAnulacion != null)
                    //{
                    //    requerimiento.Cumplido = "AN";
                    //    // requerimiento.UsuarioAnulacion = "";
                    //    requerimiento.FechaAnulacion = DateTime.Now;
                    //    requerimiento.MotivoAnulacion = requerimiento.MotivoAnulacion;
                    //}


                    string tipomovimiento = "";
                    // Perform Update


                    ValidaryReformatearRequerimiento(requerimiento);


                    if (requerimiento.IdRequerimiento > 0)
                    {
                        var originalrequerimiento = db.Requerimientos.Where(p => p.IdRequerimiento == requerimiento.IdRequerimiento).Include(p => p.DetalleRequerimientos).SingleOrDefault();
                        var requerimientoEntry = db.Entry(originalrequerimiento);
                        requerimientoEntry.CurrentValues.SetValues(requerimiento);

                        foreach (var dr in requerimiento.DetalleRequerimientos)
                        {
                            var originalDetalleRequerimiento = originalrequerimiento.DetalleRequerimientos.Where(c => c.IdDetalleRequerimiento == dr.IdDetalleRequerimiento && dr.IdDetalleRequerimiento > 0).SingleOrDefault();
                            // Is original child item with same ID in DB?
                            if (originalDetalleRequerimiento != null)
                            {
                                // Yes -> Update scalar properties of child item
                                //db.Entry(originalDetalleRequerimiento).CurrentValues.SetValues(dr);

                                // si estaba cumplido, no se puede editar -ok, pero hacelo en la validacion logica, no acá en la grabacion

                                var DetalleRequerimientoEntry = db.Entry(originalDetalleRequerimiento);
                                DetalleRequerimientoEntry.CurrentValues.SetValues(dr);
                            }
                            else
                            {
                                // No -> It's a new child item -> Insert
                                originalrequerimiento.DetalleRequerimientos.Add(dr);
                            }
                        }

                        // Now you must delete all entities present in parent.ChildItems but missing in modifiedParent.ChildItems
                        // ToList should make copy of the collection because we can't modify collection iterated by foreach
                        foreach (var originalDetalleRequerimiento in originalrequerimiento.DetalleRequerimientos.Where(c => c.IdDetalleRequerimiento != 0).ToList())
                        {
                            // Are there child items in the DB which are NOT in the new child item collection anymore?
                            if (!requerimiento.DetalleRequerimientos.Any(c => c.IdDetalleRequerimiento == originalDetalleRequerimiento.IdDetalleRequerimiento))
                                // Yes -> It's a deleted child item -> Delete
                                originalrequerimiento.DetalleRequerimientos.Remove(originalDetalleRequerimiento);
                            //db.DetalleRequerimientos.Remove(originalDetalleRequerimiento);
                        }
                        db.Entry(originalrequerimiento).State = System.Data.Entity.EntityState.Modified;

                        //foreach (DetalleRequerimiento dr in requerimiento.DetalleRequerimientos)
                        //{
                        //    if (dr.IdDetalleRequerimiento > 0)
                        //    {
                        //        db.Entry(dr).State = System.Data.Entity.EntityState.Modified;
                        //    }
                        //    else
                        //    {
                        //        db.Entry(dr).State = System.Data.Entity.EntityState.Added;
                        //        //db.DetalleRequerimientos.Add(dr);
                        //    }
                        //}
                        //db.Entry(requerimiento).State = System.Data.Entity.EntityState.Modified;
                    }
                    //Perform Save
                    else
                    {
                        tipomovimiento = "N";
                        Parametros parametros = db.Parametros.Find(1);
                        requerimiento.NumeroRequerimiento = parametros.ProximoNumeroRequerimiento;
                        db.Requerimientos.Add(requerimiento);
                    }


                    db.SaveChanges();


                    db.wActualizacionesVariasPorComprobante(103, requerimiento.IdRequerimiento, tipomovimiento);
                    db.Tree_TX_Actualizar("RequerimientosAgrupados", requerimiento.IdRequerimiento, "Requerimiento");


                    //////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////

                    try
                    {


                        // esto tarda 30 segundos en autotrol!!!
                        List<Tablas.Tree> Tree = TablasDAL.ArbolRegenerar(this.Session["BasePronto"].ToString(), oStaticMembershipService);

                    }
                    catch (Exception ex)
                    {
                        ErrHandler.WriteError(ex);
                        //                        throw;
                    }
                    // TODO: acá se regenera el arbol???

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdRequerimiento = requerimiento.IdRequerimiento, ex = "" }); //, DetalleRequerimientos = requerimiento.DetalleRequerimientos
                }
                else
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El requerimiento es inválido";
                    //return Json(res);
                    //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });

                    return Json(res);


                }
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;


                List<string> errors = new List<string>();
                errors.Add(ex.Message);
                return Json(errors);



                // If Sucess== 0 then Unable to perform Save/Update Operation and send Exception to View as JSON
                return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }



        public void ValidaryReformatearRequerimiento(Requerimiento requerimiento)
        {
            // migrando codigo que es del DetRequerimientos_A y DetRequerimientos_M

            Parametros parametros = db.Parametros.Find(1);

            foreach (var dr in requerimiento.DetalleRequerimientos)
            {




                //esto solo en el alta
                if (requerimiento.IdRequerimiento <= 0)
                {

                    if (parametros.ActivarSolicitudMateriales == "SI") dr.TipoDesignacion = "S/D";
                }


                string TipoDeCompraEnRMHabilitado = BuscarClaveINI("Habilitar tipo de compra en RM");
                //  SET @TipoDeCompraEnRMHabilitado=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni   
                //Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave  
                //Where pic.Clave='Habilitar tipo de compra en RM'),'')  




                if (TipoDeCompraEnRMHabilitado == "SI")
                {

                    string Modalidad = db.TiposCompras.Find(requerimiento.IdTipoCompra).Modalidad ?? "CC";


                    int IdDetallePedido = (from dp in dr.DetallePedidos
                                           join p in db.Pedidos on dp.IdPedido equals p.IdPedido
                                           where (dp.Cumplido ?? "NO") != "AN" && (p.Cumplido ?? "NO") != "AN"
                                           select dp.IdDetallePedido
                           ).FirstOrDefault();
                    //int IdDetallePedido=IsNull((Select Top 1 dp.IdDetallePedido From DetallePedidos dp   
                    //         Left Outer Join Pedidos On Pedidos.IdPedido = dp.IdPedido  
                    //         Where dp.IdDetalleRequerimiento=@IdDetalleRequerimiento and 
                    //             IsNull(dp.Cumplido,"NO")<>"AN" and IsNull(Pedidos.Cumplido,"NO")<>"AN"),0)  


                    if (Modalidad == "CR" && IdDetallePedido == 0 && dr.TipoDesignacion == null)
                        dr.TipoDesignacion = "S/D";
                    else if (Modalidad == "CO" && IdDetallePedido == 0 && dr.TipoDesignacion == "S/D")
                        dr.TipoDesignacion = null;
                    else if (Modalidad == "CN" && IdDetallePedido == 0 && dr.TipoDesignacion == "S/D")
                        dr.TipoDesignacion = null;

                }

                if (dr.IdComprador == null)
                {

                    /*
                DECLARE @AsignarLiberadorComoCompradorEnRM varchar(3), @Aprobo int, @Sector varchar(50)  
                SET @AsignarLiberadorComoCompradorEnRM=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo="AsignarLiberadorComoCompradorEnRM"),"NO")  
                SET @Aprobo=IsNull((Select Top 1 Requerimientos.Aprobo From Requerimientos Where Requerimientos.IdRequerimiento=@IdRequerimiento),0)  
                SET @Sector=IsNull((Select Top 1 Sectores.Descripcion From Empleados   
                     Left Outer Join Sectores On Sectores.IdSector=Empleados.IdSector  
                     Where Empleados.IdEmpleado=@Aprobo),"")  
                IF @AsignarLiberadorComoCompradorEnRM="SI" and @Aprobo<>0 and Upper(@Sector)="COMPRAS"  
                  BEGIN  
                 SET @IdComprador=@Aprobo  
                 SET @FechaAsignacionComprador=GetDate()  
                  END  
             
                     * */
                }


            }
        }



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
                    if (error.ErrorMessage == "") errors.Add(error.Exception.ToString());
                }
            }

            return errors;
        }

        /////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        //[HttpPost]
        //public ActionResult Create(Requerimiento requerimiento)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.Requerimientos.Add(requerimiento);
        //        db.SaveChanges();
        //        return RedirectToAction("Index");  
        //    }

        //    ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", requerimiento.IdObra);
        //    ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", requerimiento.Aprobo);
        //    ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", requerimiento.IdSolicito);
        //    ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", requerimiento.IdSector);
        //    return View(requerimiento);
        //}



        [HttpPost]
        public virtual ActionResult SubirPlantilla(System.Web.HttpPostedFileBase file)
        {
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            // Verify that the user selected a file
            if (file != null && file.ContentLength > 0)
            {
                // extract only the fielname
                var fileName = System.IO.Path.GetFileName(file.FileName);
                // store the file inside ~/App_Data/uploads folder
                var path = System.IO.Path.Combine(Server.MapPath("~/App_Data/uploads"), fileName); // "~/App_Data/uploads"
                file.SaveAs(path);

                // OpenXML_Pronto.GuardarEnSQL(SC, OpenXML_Pronto.enumPlantilla.FacturaA, fileName, "Requerimiento", path);
            }





            using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
            {
                file.InputStream.CopyTo(ms);
                byte[] array = ms.GetBuffer();
            }



            // redirect back to the index action to show the form once again
            //return RedirectToAction("Index");

            return View();

        }



        // GET: /Requerimiento/Edit/5
        public virtual ActionResult Edit(int id)
        {
            int? IdSector = -1, IdObra = -1;


            if (!PuedeLeer(enumNodos.Requerimientos)) throw new Exception("No tenés permisos");




            if (id == -1)
            {


                ProntoMVC.Data.Models.Requerimiento requerimiento = new ProntoMVC.Data.Models.Requerimiento();
                Parametros parametros = db.Parametros.Find(1);
                requerimiento.NumeroRequerimiento = parametros.ProximoNumeroRequerimiento;
                requerimiento.FechaRequerimiento = DateTime.Today;



                string usuario = ViewBag.NombreUsuario;
                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                if (IdUsuario <= 0)
                {

                    string nombrebase = this.Session["BasePronto"].ToString();
                    IdSector = db.Sectores.FirstOrDefault().IdSector;
                    IdObra = db.Obras.FirstOrDefault().IdObra;
                    CrearUsuarioProntoEnDichaBase(nombrebase, usuario, "ldb", IdSector, IdObra);

                    //ViewBag.Alerta = "El usuario no tiene usuario Pronto relacionado";
                    IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
                }


                try
                {
                    IdSector = (from item in db.Empleados where item.IdEmpleado == IdUsuario select item).SingleOrDefault().IdSector;
                    IdObra = (from item in db.Empleados where item.IdEmpleado == IdUsuario select item).SingleOrDefault().IdObraAsignada;

                    requerimiento.IdSector = IdSector;
                    requerimiento.IdObra = IdObra;
                    requerimiento.IdSolicito = IdUsuario;
                }
                catch (Exception ex)
                {
                    ErrHandler.WriteError(ex);
                }


                //ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", IdObra);
                //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", IdUsuario);
                //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", IdSector);


                ViewBag.CantidadAutorizaciones = db.Autorizaciones_TX_CantidadAutorizaciones((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.RequerimientoMateriales, 0, -1).Count();


                //ViewBag.Autorizaciones = db.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante(3, id);
                inic(ref requerimiento);
                CargarViewBag(requerimiento);


                return View(requerimiento);
            }
            else
            {

                Requerimiento requerimiento = db.Requerimientos
                   .Include(x => x.Obra)
                     .SingleOrDefault(x => x.IdRequerimiento == id);






                //ViewBag.Autorizaciones = db.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante(3, id);
                Session.Add("Requerimiento", requerimiento);

                CargarViewBag(requerimiento);

                return View(requerimiento);
            }
        }








        // POST: /Requerimiento/Edit/5
        //[HttpPost]
        //public ActionResult Edit(Requerimiento requerimiento)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        db.Entry(requerimiento).State = System.Data.Entity.EntityState.Modified;
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }
        //    //  ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", requerimiento.IdObra);
        //    ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", requerimiento.Aprobo);
        //    ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", requerimiento.IdSolicito);
        //    ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", requerimiento.IdSector);
        //    return View(requerimiento);
        //}

        // GET: /Requerimiento/Delete/5
        public virtual ActionResult Delete(int id)
        {
            Requerimiento requerimiento = db.Requerimientos.Find(id);
            return View(requerimiento);
        }

        // POST: /Requerimiento/Delete/5
        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Requerimiento requerimiento = db.Requerimientos.Find(id);
            db.Requerimientos.Remove(requerimiento);
            db.SaveChanges();
            return RedirectToAction("Index");
        }


        // GET: /Requerimiento/Delete/5
        public virtual ActionResult Anular(int id)
        {
            Requerimiento requerimiento = db.Requerimientos.Find(id);
            requerimiento.UsuarioAnulacion = "adfasd";
            db.SaveChanges();
            return RedirectToAction("Index");
        }





        [HttpPost]
        public virtual JsonResult AnularFirmas(Requerimiento Pedido)
        {


            //         Set oRs = Aplicacion.Pedidos.TraerFiltrado("_RecepcionesPorIdPedido", mvarId)
            //If oRs.RecordCount > 0 Then
            //   mError = mError & "Hay recepciones ya registradas contra este pedido, no puede eliminar las firmas"
            //End If



            //With origen.Registro
            //   .Fields("Aprobo").Value = Null
            //   .Fields("CircuitoFirmasCompleto").Value = Null
            //   .Fields("Subnumero").Value = IIf(IsNull(.Fields("Subnumero").Value), 1, .Fields("Subnumero").Value + 1)
            //End With
            int glbIdUsuario = Pedido.Aprobo ?? -1;
            if (glbIdUsuario <= 0) glbIdUsuario = -1;
            string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            Pronto.ERP.Bll.EntidadManager.Tarea(nSC, "AutorizacionesPorComprobante_EliminarFirmas",
                                                    (int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.RequerimientoMateriales,
                                                    Pedido.IdRequerimiento, -1, glbIdUsuario);  // idformulario,idcomprobante, orden autorizacion, idusuarioelimino




            //mError = ""
            //Set oRs = Aplicacion.Pedidos.TraerFiltrado("_RecepcionesPorIdPedido", mvarId)
            //If oRs.RecordCount > 0 Then
            //   mError = mError & "Hay recepciones ya registradas contra este pedido, no puede eliminar las firmas"
            //End If
            //oRs.Close


            Pedido.Aprobo = null;
            Pedido.CircuitoFirmasCompleto = null;
            // Pedido.SubNumero += 1;

            return BatchUpdate(Pedido);

        }

        [HttpPost]
        public virtual JsonResult AnularLiberacion(Requerimiento Requerimiento)
        {
            Requerimiento.Aprobo = null;
            Requerimiento.CircuitoFirmasCompleto = null;
            Requerimiento.IdUsuarioDeslibero = Requerimiento.Aprobo;
            Requerimiento.FechaDesliberacion = DateTime.Now;
            Requerimiento.NumeradorDesliberaciones++;


            //.Fields("Aprobo").Value = Null
            //.Fields("CircuitoFirmasCompleto").Value = Null
            //.Fields("IdUsuarioDeslibero").Value = mIdAprobo
            //.Fields("FechaDesliberacion").Value = Now
            //.Fields("NumeradorDesliberaciones").Value = IIf(IsNull(.Fields("NumeradorDesliberaciones").Value), 0, .Fields("NumeradorDesliberaciones").Value) + 1



            return BatchUpdate(Requerimiento);

        }



        public virtual ActionResult Requerimientos_DynamicGridData
                (string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal, string IdObra, bool bAConfirmar = false, bool bALiberar = false)
        {
            /*
            var aada =( db.Requerimientos
                    .Include("DetalleRequerimientos.DetallePedidos") // funciona tambien
                    .Include("DetalleRequerimientos.DetallePresupuestos") // funciona tambien
                    .Include("DetalleRequerimientos.DetallePresupuestos,DetalleRequerimientos.DetallePedidos") // funciona tambien
                    .Take(10) ).ToList();
            */

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            string campo = "true";
            int pageSize = rows;
            int currentPage = page;
            int totalPages = 0;
            int totalRecords = 0;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.Requerimiento>
                                ("DetalleRequerimientos.DetallePedidos", sidx, sord, page, rows, _search, filters, db, ref totalRecords, "DetalleRequerimientos.DetallePresupuestos");
            //DetalleRequerimientos.DetallePedidos, DetalleRequerimientos.DetallePresupuestos
            //"Obra,DetalleRequerimientos.DetallePedidos.Pedido,DetalleRequerimientos.DetallePresupuestos.Presupuesto"
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            if (false)
            {
                LinqToSQL_ProntoDataContext l2sqlPronto = new LinqToSQL_ProntoDataContext(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SCsql()));
                var qq = (from rm in l2sqlPronto.Requerimientos
                          select l2sqlPronto.Requerimientos_Pedidos(rm.IdRequerimiento)
                          ).Take(100).ToList();
            }

            var Req = pagedQuery
                          //.Include(x => x.Obra)
                          //.Include(x => x.SolicitoRequerimiento)
                          //.Include(x => x.AproboRequerimiento)
                          //.Include(x => x.Sectores)
                          //.Include(r => r.DetalleRequerimientos.Select(dr => dr.DetallePedidos.Select(dt => dt.Pedido)))
                          //  .Include("DetalleRequerimientos.DetallePedidos.Pedido") // funciona tambien
                          //   .Include("DetalleRequerimientos.DetallePresupuestos.Presupuesto") // funciona tambien
                          // .Include(x => x.Aprobo)
                          .AsQueryable();

            try
            {

                var Req1 = from a in Req.Where(campo) select a.IdRequerimiento;
                //totalRecords = Req1.Count();
                totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            }
            catch (Exception)
            {

                //                throw;
            }

            //switch (sidx.ToLower())
            //{
            //    case "numerorequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //    case "fecharequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.FechaRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.FechaRequerimiento);
            //        break;
            //    case "numeroobra":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Obra.NumeroObra);
            //        else
            //            Req = Req.OrderBy(a => a.Obra.NumeroObra);
            //        break;
            //    case "libero":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados.Nombre);
            //        break;
            //    case "aprobo":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados1.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados1.Nombre);
            //        break;
            //    case "sector":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Sectores.Descripcion);
            //        else
            //            Req = Req.OrderBy(a => a.Sectores.Descripcion);
            //        break;
            //    case "detalle":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Detalle);
            //        else
            //            Req = Req.OrderBy(a => a.Detalle);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //}


            var data = from a in Req
                       //.Where(campo).OrderBy(sidx + " " + sord)
                           //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList()
                       select a; //supongo que tengo que hacer la paginacion antes de hacer un select, para que me llene las colecciones anidadas

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdRequerimiento.ToString(),
                            cell = new string[] { 
                                //"<a href="+ Url.Action("Edit",new {id = a.IdRequerimiento} ) + " target="' >Editar</>" ,
                                "<a href="+ Url.Action("Edit",new {id = a.IdRequerimiento} ) + "  >Editar</>" ,
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdRequerimiento} )  +">Imprimir</>" ,
                                a.IdRequerimiento.ToString(),
                                a.NumeroRequerimiento.ToString(),
                                a.FechaRequerimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Cumplido,
                                a.Recepcionado,
                                a.Entregado,
                                a.Impresa,
                                a.Detalle,
                                //a.Obra.Descripcion, 
                              (a.Obra==null) ?  "" :  a.Obra.NumeroObra,

                                //  string.Join(" ",  a.DetalleRequerimientos.Select(x=> (x.DetallePresupuestos.Select(y=> y.IdPresupuesto))  )),
                                // string.Join(" ",  a.DetalleRequerimientos.Select(x=>(x.DetallePresupuestos   ==null) ? "" : x.DetallePresupuestos.Select(z=>z.Presupuesto.Numero.ToString()).NullSafeToString() ).Distinct()),
                                // Req ya viene con todos los datos para las colecciones hijas. lo paginé y ahí hice el select (arriba)

                                string.Join(",",  a.DetalleRequerimientos
                                    .SelectMany(x =>
                                        (x.DetallePresupuestos == null) ?
                                        null :
                                        x.DetallePresupuestos.Select(y =>
                                                    (y.Presupuesto == null) ?
                                                    null :
                                                    y.Presupuesto.Numero.NullSafeToString()
                                            )
                                    ).Distinct()
                                ),

                                "",

                                string.Join(",",  a.DetalleRequerimientos
                                    .SelectMany(x =>
                                        (x.DetallePedidos == null) ?
                                        null :
                                        x.DetallePedidos.Select(y =>
                                                    (y.Pedido == null) ?
                                                    null :
                                                    "<a href="+ Url.Action("Edit", "Pedido",new {id = y.Pedido.IdPedido} ) + "  >" + y.Pedido.NumeroPedido.NullSafeToString() + "</>"
                                            )
                                    ).Distinct()
                                ),


                                "", //recepciones
                                "", // salidas

                                //a.Comparativas,
                                //string.Join(" ",  a.DetalleRequerimientos.Select(x=> x.DetallePedidos.Count ))  ,

                                ////string.Join(" ",  a.DetalleRequerimientos.Select(x=>(x.DetallePedidos   ==null) ? "" : x.DetallePedidos.Select(z=>z.Pedido.NumeroPedido.ToString()).NullSafeToString() ).Distinct()),
                                //a.Recepciones,
                                
                                (a.SolicitoRequerimiento==null) ?  "" :   a.SolicitoRequerimiento.Nombre,
                                (a.AproboRequerimiento==null) ?  "" :  a.AproboRequerimiento.Nombre,
                                (a.Sectores==null) ?  "" : a.Sectores.Descripcion,

                                a.UsuarioAnulacion,
                                a.FechaAnulacion.NullSafeToString(),
                                a.MotivoAnulacion,
                                a.FechasLiberacion,

                                a.Observaciones,
                                a.LugarEntrega,
                                a.IdObra.ToString(),
                                a.IdSector.ToString(),
                                a.ConfirmadoPorWeb.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }





        public virtual ActionResult RequerimientosPendientesAsignar_DynamicGridData
              (string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal, string IdObra, bool bAConfirmar = false, bool bALiberar = false)
        {
            int pageSize = 20;  //rows ?? 20;
            int currentPage = 1;  //page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));


            DataTable dt;
            try
            {
                //dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Requerimientos_TX_PendientesDeAsignacion");
                dt = Pronto.ERP.Bll.EntidadManager.ExecDinamico(SC, "exec Requerimientos_TX_PendientesDeAsignacion", 180);


            }
            catch (Exception ex)
            {

                //throw new Exception("Error en Requerimientos_TX_PendientesDeAsignacion. Verificar que esté bien configurada la base de mantenimiento.");
                // tambien puede ser un timeout


                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;

                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;



                //List<string> errors = new List<string>();
                //errors.Add(errs);
                string[] words = { "Error en Requerimientos_TX_PendientesDeAsignacion. Verificar que esté bien configurada la base de mantenimiento." };
                res.Errors = words.ToList(); // GetModelStateErrorsAsString(this.ModelState);
                res.Message = ex.ToString();

                return Json(res);
            }



            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdDetalleRequerimiento = a[0],
                            NumeroRequerimiento = a[1],
                            IdAux1 = a[2],
                            IdAux2 = a[3],
                            IdAux3 = a[4],
                            IdAux4 = a[5],
                            Item = a[6],
                            Cant = a[7],
                            Unidad = a[8],
                            Vales = a[9],
                            Valess = a[10],
                            CantPed = a[11],
                            Recibido = a[12],
                            Recepcion = a[13],
                            UltRecepcion = a[14],

                            EnStock = a[15],
                            StkMin = a[16],

                            Articulo = a[17],
                            FEntrega = a[18],
                            Solicito = a[19],
                            TipoReq = a[20],
                            Obra = a[21],

                            Cump = a[22],
                            Recepcionado = a[23],
                            Observacionesitem = a[24],
                            Deposito = a[25],
                            Observacionesfirmante = a[26],
                            Firmanteobservo = a[27],
                            Fechaultobservacion = a[28],

                            CodEqDestino = a[29],
                            EquipoDestino = a[30]
                        }).ToList();





            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in Entidad
                        select new jqGridRowJson
                        {
                            id = a[0].ToString(),
                            cell = new string[] {
                                   a[0].ToString(),
                                   "<a href="+ Url.Action("Edit",new {id =  a[1] } ) + "  >Editar</>" ,
                                   a[2].ToString(),
                                   a[3].ToString(),
                                   a[4].ToString(),
                                   a[5].ToString(),
                                   a[6].ToString(),
                                   a[7].ToString(),
                                   a[8].ToString(),
                                   a[9].ToString(),
                                   a[10].ToString(),
                                   a[11].ToString(),
                                   a[12].ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }





        public virtual ActionResult Requerimientos(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString,
                                                   string FechaInicial, string FechaFinal, string IdObra, bool bAConfirmar = false, bool bALiberar = false)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            int totalRecords = 0;
            int totalPages = 0;


            if (true)
            {
                LinqToSQL_ProntoDataContext l2sqlPronto = new LinqToSQL_ProntoDataContext(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SCsql()));
                var qq = (from rm in l2sqlPronto.Requerimientos
                          select l2sqlPronto.Requerimientos_Pedidos(rm.IdRequerimiento)
                          ).Take(100).ToList();
            }

            var Req = db.Requerimientos
                    // .Include(x => x.DetallePedidos.Select(y => y.Unidad))
                    // .Include(x => x.DetallePedidos.Select(y => y.Moneda))
                    //.Include(x => x.DetallePedidos. .moneda)
                    //   .Include("DetallePedidos.Unidad") // funciona tambien
                    //    .Include(x => x.Moneda)
                    .Include(x => x.Obra)

                    .Include(x => x.SolicitoRequerimiento)
                    .Include(x => x.AproboRequerimiento)
                    .Include(x => x.Sectores)
                        //  .Include("DetallePedidos.IdDetalleRequerimiento") // funciona tambien
                        //   .Include("DetalleRequerimientos.DetallePedidos.Pedido") // funciona tambien
                        //.Include(x => x.DetalleRequerimientos)

                        //.Include(x => x.DetalleRequerimientos
                        //            .Select(y => y.DetallePedidos
                        //                )
                        //        )
                        //.Include(x => x.DetalleRequerimientos
                        //            .Select(y => y.DetallePresupuestos
                        //                )
                        //        )

                        .Include(r => r.DetalleRequerimientos.Select(dr => dr.DetallePedidos.Select(dt => dt.Pedido)))

                          //  .Include("DetalleRequerimientos.DetallePedidos.Pedido") // funciona tambien
                          //   .Include("DetalleRequerimientos.DetallePresupuestos.Presupuesto") // funciona tambien
                          // .Include(x => x.Aprobo)
                          .AsQueryable();


            // Requerimiento test = Req.Where(x => x.IdRequerimiento == 4).ToList().FirstOrDefault();


            if (bAConfirmar)
            {

                Req = (from a in Req where (a.Confirmado ?? "SI") == "NO" select a).AsQueryable();
                //            WHERE  IsNull(Confirmado,'SI')='NO' and 
                //(@IdObraAsignadaUsuario=-1 or Requerimientos.IdObra=@IdObraAsignadaUsuario)

            }
            if (bALiberar)
            {
                Req = (from a in Req where a.Aprobo == null select a).AsQueryable();
                //            WHERE  Requerimientos.Aprobo is null and 
                //(@IdObraAsignadaUsuario=-1 or Requerimientos.IdObra=@IdObraAsignadaUsuario)

            }




            if (IdObra != string.Empty)
            {
                int IdObra1 = Convert.ToInt32(IdObra);
                Req = (from a in Req where a.IdObra == IdObra1 select a).AsQueryable();
            }
            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                Req = (from a in Req where a.FechaRequerimiento >= FechaDesde && a.FechaRequerimiento <= FechaHasta select a).AsQueryable();
            }
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numerorequerimiento":
                        campo = String.Format("Obra.NumeroObra.Contains(\"{0}\") OR NumeroRequerimiento = {1} ", searchString, Generales.Val(searchString));

                        //if (searchString != "")
                        //{
                        //    campo = String.Format("{0} = {1}", searchField, Generales.Val(searchString));
                        //}
                        //else
                        //{
                        //    campo = "true";
                        //}
                        break;
                    case "fecharequerimiento":
                        //No anda
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                    default:
                        campo = String.Format("Obra.Descripcion.Contains(\"{0}\") OR NumeroRequerimiento = {1} ", searchString, Generales.Val(searchString));

                        //campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                }
            }
            else
            {
                campo = "true";
            }


            try
            {

                var Req1 = from a in Req.Where(campo) select a.IdRequerimiento;

                totalRecords = Req1.Count();
                totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            }
            catch (Exception)
            {

                //                throw;
            }

            //switch (sidx.ToLower())
            //{
            //    case "numerorequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //    case "fecharequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.FechaRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.FechaRequerimiento);
            //        break;
            //    case "numeroobra":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Obra.NumeroObra);
            //        else
            //            Req = Req.OrderBy(a => a.Obra.NumeroObra);
            //        break;
            //    case "libero":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados.Nombre);
            //        break;
            //    case "aprobo":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados1.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados1.Nombre);
            //        break;
            //    case "sector":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Sectores.Descripcion);
            //        else
            //            Req = Req.OrderBy(a => a.Sectores.Descripcion);
            //        break;
            //    case "detalle":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Detalle);
            //        else
            //            Req = Req.OrderBy(a => a.Detalle);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //}

            var data = from a in Req.Where(campo).OrderBy(sidx + " " + sord)
.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList()
                       select a; //supongo que tengo que hacer la paginacion antes de hacer un select, para que me llene las colecciones anidadas


            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdRequerimiento.ToString(),
                            cell = new string[] { 
                                //"<a href="+ Url.Action("Edit",new {id = a.IdRequerimiento} ) + " target='' >Editar</>" ,
                                "<a href="+ Url.Action("Edit",new {id = a.IdRequerimiento} ) + "  >Editar</>" ,
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdRequerimiento} )  +">Imprimir</>" ,
                                a.IdRequerimiento.ToString(),
                                a.NumeroRequerimiento.ToString(),
                                a.FechaRequerimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Cumplido,
                                a.Recepcionado,
                                a.Entregado,
                                a.Impresa,
                                a.Detalle,
                                //a.Obra.Descripcion, 
                              (a.Obra==null) ?  "" :  a.Obra.NumeroObra,

                                //  string.Join(" ",  a.DetalleRequerimientos.Select(x=> (x.DetallePresupuestos.Select(y=> y.IdPresupuesto))  )),
                                // string.Join(" ",  a.DetalleRequerimientos.Select(x=>(x.DetallePresupuestos   ==null) ? "" : x.DetallePresupuestos.Select(z=>z.Presupuesto.Numero.ToString()).NullSafeToString() ).Distinct()),


                                // Req ya viene con todos los datos para las colecciones hijas. lo paginé y ahí hice el select (arriba)
                                // Req ya viene con todos los datos para las colecciones hijas. lo paginé y ahí hice el select (arriba)
                                // Req ya viene con todos los datos para las colecciones hijas. lo paginé y ahí hice el select (arriba)
                                // Req ya viene con todos los datos para las colecciones hijas. lo paginé y ahí hice el select (arriba)

                                string.Join(",",  a.DetalleRequerimientos
                                    .SelectMany(x =>
                                        (x.DetallePresupuestos == null) ?
                                        null :
                                        x.DetallePresupuestos.Select(y =>
                                                    (y.Presupuesto == null) ?
                                                    null :
                                                    y.Presupuesto.Numero.NullSafeToString()
                                            )
                                    ).Distinct()
                                ),


                                "",



                                string.Join(",",  a.DetalleRequerimientos
                                    .SelectMany(x =>
                                        (x.DetallePedidos == null) ?
                                        null :
                                        x.DetallePedidos.Select(y =>
                                                    (y.Pedido == null) ?
                                                    null :
                                                    "<a href="+ Url.Action("Edit", "Pedido",new {id = y.Pedido.IdPedido} ) + "  >" + y.Pedido.NumeroPedido.NullSafeToString() + "</>"

                                            )
                                    ).Distinct()
                                ),


                                "", //recepciones
                                "", // salidas

                                //a.Comparativas,
                                //string.Join(" ",  a.DetalleRequerimientos.Select(x=> x.DetallePedidos.Count ))  ,


                                ////string.Join(" ",  a.DetalleRequerimientos.Select(x=>(x.DetallePedidos   ==null) ? "" : x.DetallePedidos.Select(z=>z.Pedido.NumeroPedido.ToString()).NullSafeToString() ).Distinct()),
                                //a.Recepciones,
                                
                                
                                
                                (a.SolicitoRequerimiento==null) ?  "" :   a.SolicitoRequerimiento.Nombre,
                                (a.AproboRequerimiento==null) ?  "" :  a.AproboRequerimiento.Nombre,
                                (a.Sectores==null) ?  "" : a.Sectores.Descripcion,

                                a.UsuarioAnulacion,
                                a.FechaAnulacion.NullSafeToString(),
                                a.MotivoAnulacion,
                                a.FechasLiberacion,

                                a.Observaciones,
                                a.LugarEntrega,
                                a.IdObra.ToString(),
                                a.IdSector.ToString(),
                                a.ConfirmadoPorWeb.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }










        public virtual ActionResult RequerimientosComprables_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            string campo = "true";
            int pageSize = rows;// ?? 20;
            int currentPage = page;// ?? 1;

            //int totalRecords = 0;
            int totalPages = 0;




            var Req = db.Requerimientos.AsQueryable();
            Req = Req.Where(r => r.Cumplido == null || (r.Cumplido != "AN" && r.Cumplido != "SI")).AsQueryable();




            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;


            // IQueryable<Data.Models.Remito> aaaa = db.Remitos.Take(19);


            // ObjectQuery<Data.Models.Requerimiento> set = Req as ObjectQuery<Data.Models.Requerimiento>;


            //var pagedQuery = Filters.FiltroGenerico_UsandoStoreOLista(
            //                 sidx, sord, page, rows, _search, filters, db, ref totalRecords, Req.ToList());

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable(
                             sidx, sord, page, rows, _search, filters, db, ref totalRecords, Req);




            //    var pagedQuery = Filters.FiltroGenerico_PasandoQueryEntera<Data.Models.Requerimiento>
            //                        (Req as ObjectQuery<Data.Models.Requerimiento>
            //                        , sidx, sord, page, rows, _search, filters, ref totalRecords);

            // .Where(x => (PendienteFactura != "SI" || (PendienteFactura == "SI" && x.PendienteFacturar > 0)))


            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////






            try
            {

                //var Req1 = from a in Req.Where(campo) select a.IdRequerimiento;

                //totalRecords = Req1.Count();
                totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            }
            catch (Exception)
            {

                //                throw;
            }

            //switch (sidx.ToLower())
            //{
            //    case "numerorequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //    case "fecharequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.FechaRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.FechaRequerimiento);
            //        break;
            //    case "numeroobra":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Obra.NumeroObra);
            //        else
            //            Req = Req.OrderBy(a => a.Obra.NumeroObra);
            //        break;
            //    case "libero":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados.Nombre);
            //        break;
            //    case "aprobo":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados1.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados1.Nombre);
            //        break;
            //    case "sector":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Sectores.Descripcion);
            //        else
            //            Req = Req.OrderBy(a => a.Sectores.Descripcion);
            //        break;
            //    case "detalle":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Detalle);
            //        else
            //            Req = Req.OrderBy(a => a.Detalle);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //}

            var data = (from a in pagedQuery
                        select new
                        {
                            IdRequerimiento = a.IdRequerimiento,
                            NumeroRequerimiento = a.NumeroRequerimiento,
                            FechaRequerimiento = a.FechaRequerimiento,
                            Cumplido = a.Cumplido,
                            Recepcionado = a.Recepcionado,
                            Entregado = a.Entregado,
                            Impresa = a.Impresa,
                            Detalle = a.Detalle,
                            NumeroObra = a.Obra.NumeroObra,
                            Presupuestos = a.Presupuestos,
                            Comparativas = a.Comparativas,
                            Pedidos = a.Pedidos,
                            Recepciones = a.Recepciones,
                            Salidas = a.SalidasMateriales,
                            Libero = (a.AproboRequerimiento != null) ? a.AproboRequerimiento.Nombre : "",
                            Solicito = (a.SolicitoRequerimiento != null) ? a.SolicitoRequerimiento.Nombre : "",
                            Sector = (a.Sectores != null) ? a.Sectores.Descripcion : "",
                            Usuario_anulo = a.UsuarioAnulacion,
                            Fecha_anulacion = a.FechaAnulacion,
                            Motivo_anulacion = a.MotivoAnulacion,
                            Fechas_liberacion = a.FechasLiberacion,
                            Observaciones = a.Observaciones,
                            LugarEntrega = a.LugarEntrega,
                            IdObra = a.IdObra,
                            IdSector = a.IdSector,
                            a.ConfirmadoPorWeb

                        })//.Where(campo)
                          //.OrderBy(sidx + " " + sord)
                          //.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdRequerimiento.ToString(),
                            cell = new string[] {
                                "<a href="+ Url.Action("Edit",new {id = a.IdRequerimiento} ) + " target='' >Editar</>" ,
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdRequerimiento} )  +">Imprimir</>" ,
                                a.IdRequerimiento.ToString(),
                                a.NumeroRequerimiento.ToString(),
                                a.FechaRequerimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Cumplido,
                                a.Recepcionado,
                                a.Entregado,
                                a.Impresa,
                                a.Detalle,
                                a.NumeroObra,
                                a.Presupuestos,
                                a.Comparativas,
                                a.Pedidos,
                                a.Recepciones,
                                a.Salidas,
                                a.Libero,
                                a.Solicito,
                                a.Sector,
                                a.Usuario_anulo,
                                a.Fecha_anulacion.ToString(),
                                a.Motivo_anulacion,
                                a.Fechas_liberacion,
                                a.Observaciones,
                                a.LugarEntrega,
                                a.IdObra.ToString(),
                                a.IdSector.ToString(),
                                a.ConfirmadoPorWeb.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }



        public virtual ActionResult RequerimientosComprables(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString,
                                            string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            int totalRecords = 0;
            int totalPages = 0;


            var Req = db.Requerimientos.AsQueryable();
            Req = Req.Where(r => r.Cumplido == null || (r.Cumplido != "AN" && r.Cumplido != "SI")).AsQueryable();

            if (IdObra != string.Empty)
            {
                int IdObra1 = Convert.ToInt32(IdObra);
                Req = (from a in Req where a.IdObra == IdObra1 select a).AsQueryable();
            }
            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                Req = (from a in Req where a.FechaRequerimiento >= FechaDesde && a.FechaRequerimiento <= FechaHasta select a).AsQueryable();
            }
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numerorequerimiento":
                        if (searchString != "")
                        {
                            campo = String.Format("{0} = {1}", searchField, Generales.Val(searchString));
                        }
                        else
                        {
                            campo = "true";
                        }
                        break;
                    case "fecharequerimiento":
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


            try
            {

                var Req1 = from a in Req.Where(campo) select a.IdRequerimiento;

                totalRecords = Req1.Count();
                totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            }
            catch (Exception)
            {

                //                throw;
            }

            //switch (sidx.ToLower())
            //{
            //    case "numerorequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //    case "fecharequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.FechaRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.FechaRequerimiento);
            //        break;
            //    case "numeroobra":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Obra.NumeroObra);
            //        else
            //            Req = Req.OrderBy(a => a.Obra.NumeroObra);
            //        break;
            //    case "libero":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados.Nombre);
            //        break;
            //    case "aprobo":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados1.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados1.Nombre);
            //        break;
            //    case "sector":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Sectores.Descripcion);
            //        else
            //            Req = Req.OrderBy(a => a.Sectores.Descripcion);
            //        break;
            //    case "detalle":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Detalle);
            //        else
            //            Req = Req.OrderBy(a => a.Detalle);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //}

            var data = (from a in Req
                        select new
                        {
                            IdRequerimiento = a.IdRequerimiento,
                            NumeroRequerimiento = a.NumeroRequerimiento,
                            FechaRequerimiento = a.FechaRequerimiento,
                            Cumplido = a.Cumplido,
                            Recepcionado = a.Recepcionado,
                            Entregado = a.Entregado,
                            Impresa = a.Impresa,
                            Detalle = a.Detalle,
                            NumeroObra = a.Obra.NumeroObra,
                            Presupuestos = a.Presupuestos,
                            Comparativas = a.Comparativas,
                            Pedidos = a.Pedidos,
                            Recepciones = a.Recepciones,
                            Salidas = a.SalidasMateriales,
                            Libero = a.AproboRequerimiento.Nombre,
                            Solicito = a.SolicitoRequerimiento.Nombre,
                            Sector = a.Sectores.Descripcion,
                            Usuario_anulo = a.UsuarioAnulacion,
                            Fecha_anulacion = a.FechaAnulacion,
                            Motivo_anulacion = a.MotivoAnulacion,
                            Fechas_liberacion = a.FechasLiberacion,
                            Observaciones = a.Observaciones,
                            LugarEntrega = a.LugarEntrega,
                            IdObra = a.IdObra,
                            IdSector = a.IdSector,
                            a.ConfirmadoPorWeb

                        }).Where(campo).OrderBy(sidx + " " + sord)
//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdRequerimiento.ToString(),
                            cell = new string[] {
                                "<a href="+ Url.Action("Edit",new {id = a.IdRequerimiento} ) + " target='' >Editar</>" ,
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdRequerimiento} )  +">Imprimir</>" ,
                                a.IdRequerimiento.ToString(),
                                a.NumeroRequerimiento.ToString(),
                                a.FechaRequerimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Cumplido,
                                a.Recepcionado,
                                a.Entregado,
                                a.Impresa,
                                a.Detalle,
                                a.NumeroObra,
                                a.Presupuestos,
                                a.Comparativas,
                                a.Pedidos,
                                a.Recepciones,
                                a.Salidas,
                                a.Libero,
                                a.Solicito,
                                a.Sector,
                                a.Usuario_anulo,
                                a.Fecha_anulacion.ToString(),
                                a.Motivo_anulacion,
                                a.Fechas_liberacion,
                                a.Observaciones,
                                a.LugarEntrega,
                                a.IdObra.ToString(),
                                a.IdSector.ToString(),
                                a.ConfirmadoPorWeb.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }






        public virtual ActionResult DetRequerimientos(string sidx, string sord, int? page, int? rows, int? IdRequerimiento)
        {
            int IdRequerimiento1 = IdRequerimiento ?? 0;


            var DetReq = db.DetalleRequerimientos
                            .Include(x => x.ControlCalidad)
                            .Where(p => p.IdRequerimiento == IdRequerimiento1 || IdRequerimiento1 == -1).AsQueryable();



            bool Eliminado = false;

            int pageSize = rows ?? 20;
            int totalRecords = DetReq.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;


            switch (sidx.ToLower())
            {
                case "numerorequerimiento":
                    if (sord.Equals("desc"))
                        DetReq = DetReq.OrderByDescending(a => a.IdRequerimiento);
                    else
                        DetReq = DetReq.OrderBy(a => a.IdRequerimiento);
                    break;
                default:
                    if (sord.Equals("desc"))
                        DetReq = DetReq.OrderByDescending(a => a.IdRequerimiento);
                    else
                        DetReq = DetReq.OrderBy(a => a.IdRequerimiento);
                    break;
            }


            var data = (from a in DetReq
                        select new
                        {
                            a.IdDetalleRequerimiento,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.NumeroItem,
                            a.Cantidad,
                            a.Unidad.Abreviatura,
                            a.Articulo.Codigo,
                            a.Articulo.Descripcion,
                            a.FechaEntrega,
                            a.Observaciones,
                            a.Adjunto,
                            a.ArchivoAdjunto1,
                            a.ArchivoAdjunto2,
                            a.ArchivoAdjunto3,
                            a.Cumplido,
                            a.OrigenDescripcion,
                            a.IdRequerimiento,

                            IdControlCalidad = (a.ControlCalidad == null) ? 0 : a.ControlCalidad.IdControlCalidad,

                            ControlCalidadDesc = (a.ControlCalidad == null) ? "" : a.ControlCalidad.Descripcion

                        }).Skip((currentPage - 1) * pageSize).OrderBy(x => x.NumeroItem).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleRequerimiento.ToString(),
                            cell = new string[] {
                                string.Empty,
                                a.IdDetalleRequerimiento.ToString(),
                                a.IdArticulo.ToString(),
                                a.IdUnidad.ToString(),
                                //Eliminado.ToString(),
                                a.NumeroItem.ToString(),
                                a.Cantidad.ToString(),
                                a.Abreviatura,
                                a.Codigo,
                                "",
                                a.Descripcion,
                                a.FechaEntrega.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Observaciones,
                                a.Cumplido,
                                a.ArchivoAdjunto1,
                                a.OrigenDescripcion.ToString(),
                                a.IdRequerimiento.NullSafeToString(),

                                a.IdControlCalidad.NullSafeToString(),
                                a.ControlCalidadDesc.NullSafeToString()

                         }
                        }).ToArray()




                //           If .OrigenDescripcion = 1 Then
                //    RadioButtonList1.Items(0).Selected = True
                //ElseIf .OrigenDescripcion = 2 Then
                //    RadioButtonList1.Items(1).Selected = True
                //ElseIf .OrigenDescripcion = 3 Then
                //    RadioButtonList1.Items(2).Selected = True
                //Else
                //    RadioButtonList1.Items(0).Selected = True
                //End If
                //<asp:Label Width="300px" ID="Label7" runat="server" Text='<%# Eval("Codigo") & " " & IIf(Eval("OrigenDescripcion")<>2, Eval("Articulo"),"") & " " & IIf(Eval("OrigenDescripcion")<>1, Eval("Observaciones"),"") %>' />


            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }




        public virtual ActionResult DetRequerimientosComprables_DynamicGridData
            (string sidx, string sord, int page, int rows, bool _search, string filters,
                                                int? IdRequerimiento)
        {
            int IdRequerimiento1 = IdRequerimiento ?? -1;
            IQueryable<Data.Models.DetalleRequerimiento> DetReq = db.DetalleRequerimientos
                            .Include(x => x.Requerimientos)
                            .Where(r => r.Cumplido == null || (r.Cumplido != "AN" && r.Cumplido != "SI"))
                            .Where(p => p.IdRequerimiento == IdRequerimiento1 || IdRequerimiento1 == -1).AsQueryable();
            bool Eliminado = false;

            string campo = "true";


            DetReq = DetReq.Where(a =>
                                (a.Cantidad -
                                 db.DetallePedidos.Where(x => x.IdDetalleRequerimiento == a.IdDetalleRequerimiento
                                                                && ((x.Cumplido ?? "NO") != "AN"))
                                                        .Sum(z => z.Cantidad)
                                 ) > 0
                                 );



            //if (_search)
            //{
            //    switch (searchField.ToLower())
            //    {
            //        case "numerorequerimiento":
            //            campo = String.Format("Requerimientos.NumeroRequerimiento = {1} ", searchString, Generales.Val(searchString));

            //            //if (searchString != "")
            //            //{
            //            //    campo = String.Format("{0} = {1}", searchField, Generales.Val(searchString));
            //            //}
            //            //else
            //            //{
            //            //    campo = "true";
            //            //}
            //            break;
            //        case "fecharequerimiento":
            //            //No anda
            //            campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
            //            break;
            //        default:
            //            campo = String.Format("Obra.Descripcion.Contains(\"{0}\") OR NumeroRequerimiento = {1} ", searchString, Generales.Val(searchString));

            //            //campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
            //            break;
            //    }
            //}
            //else
            //{
            //    campo = "true";
            //}


            DetReq = DetReq.Where(campo);






            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;



            //IQueryable<Data.Models.DetalleRequerimiento> aaaa = ;


            //ObjectQuery<Data.Models.DetalleRequerimiento> set = aaaa as ObjectQuery<Data.Models.DetalleRequerimiento>;


            //var pagedQuery = Filters.FiltroGenerico_PasandoQueryEntera<Data.Models.DetalleRequerimiento>
            //                    (DetReq as ObjectQuery<Data.Models.DetalleRequerimiento   >
            //                    , sidx, sord, page, rows, _search, filters, ref totalRecords);

            //var pagedQuery = Filters.FiltroGenerico_UsandoStoreOLista(
            //    sidx, sord, page, rows, _search, filters, db, ref totalRecords, DetReq.ToList());


            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable(
                sidx, sord, page, rows, _search, filters, db, ref totalRecords, DetReq);


            //DetalleRequerimientos.DetallePedidos, DetalleRequerimientos.DetallePresupuestos
            //"Obra,DetalleRequerimientos.DetallePedidos.Pedido,DetalleRequerimientos.DetallePresupuestos.Presupuesto"
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



            int pageSize = rows; //?? 20;
            //            int totalRecords = DetReq.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page; // ?? 1;




            //switch (sidx.ToLower())
            //{
            //    case "numerorequerimiento":
            //        if (sord.Equals("desc"))
            //            DetReq = DetReq.OrderByDescending(a => a.IdRequerimiento);
            //        else
            //            DetReq = DetReq.OrderBy(a => a.IdRequerimiento);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            DetReq = DetReq.OrderByDescending(a => a.IdRequerimiento);
            //        else
            //            DetReq = DetReq.OrderBy(a => a.IdRequerimiento);
            //        break;
            //}


            var data = (from a in pagedQuery
                        select new
                        {
                            a.IdDetalleRequerimiento,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.NumeroItem,
                            a.Cantidad,
                            (a.Unidad ?? new Unidad()).Abreviatura,
                            (a.Articulo ?? new Articulo()).Codigo,
                            (a.Articulo ?? new Articulo()).Descripcion,
                            a.FechaEntrega,
                            a.Observaciones,
                            a.Adjunto,
                            a.ArchivoAdjunto1,
                            a.ArchivoAdjunto2,
                            a.ArchivoAdjunto3,
                            a.Cumplido,
                            a.OrigenDescripcion,
                            a.IdRequerimiento,
                            a.Requerimientos.NumeroRequerimiento

                        })
//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleRequerimiento.ToString(),
                            cell = new string[] {
                                string.Empty,
                                a.IdDetalleRequerimiento.ToString(),
                                a.IdArticulo.ToString(),
                                a.IdUnidad.ToString(),
                                //Eliminado.ToString(),
                                a.NumeroItem.ToString(), 
                                
                                
                                //a.Cantidad.ToString(), // - loquefigureenpedidos 
                                (a.Cantidad -
                                 db.DetallePedidos.Where(x=>x.IdDetalleRequerimiento==a.IdDetalleRequerimiento
                                                                && ((x.Cumplido ?? "NO" )!="AN"))
                                                        .Sum(z=>z.Cantidad)
                                 ).NullSafeToString(),
                                a.Abreviatura,
                                a.Codigo,
                                "",
                                a.Descripcion,
                                a.FechaEntrega.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Observaciones,
                                a.Cumplido,
                                a.ArchivoAdjunto1,
                                a.OrigenDescripcion.ToString(),
                                a.IdRequerimiento.NullSafeToString(),
                                a.NumeroRequerimiento.NullSafeToString(),
                                "<a href="+ Url.Action("Edit",new {id = a.IdRequerimiento} ) + " target='' >Editar</>"






                        }
                        }).ToArray()










                //           If .OrigenDescripcion = 1 Then
                //    RadioButtonList1.Items(0).Selected = True
                //ElseIf .OrigenDescripcion = 2 Then
                //    RadioButtonList1.Items(1).Selected = True
                //ElseIf .OrigenDescripcion = 3 Then
                //    RadioButtonList1.Items(2).Selected = True
                //Else
                //    RadioButtonList1.Items(0).Selected = True
                //End If
                //<asp:Label Width="300px" ID="Label7" runat="server" Text='<%# Eval("Codigo") & " " & IIf(Eval("OrigenDescripcion")<>2, Eval("Articulo"),"") & " " & IIf(Eval("OrigenDescripcion")<>1, Eval("Observaciones"),"") %>' />


            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }




        public virtual ActionResult DetRequerimientosComprables(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString,
                                                int? IdRequerimiento)
        {
            int IdRequerimiento1 = IdRequerimiento ?? 0;
            var DetReq = db.DetalleRequerimientos
                            .Include(x => x.Requerimientos)
                            .Where(r => r.Cumplido == null || (r.Cumplido != "AN" && r.Cumplido != "SI"))
                            .Where(p => p.IdRequerimiento == IdRequerimiento1 || IdRequerimiento1 == -1).AsQueryable();
            bool Eliminado = false;

            string campo = String.Empty;


            DetReq = DetReq.Where(a =>
                                (a.Cantidad -
                                 db.DetallePedidos.Where(x => x.IdDetalleRequerimiento == a.IdDetalleRequerimiento
                                                                && ((x.Cumplido ?? "NO") != "AN"))
                                                        .Sum(z => z.Cantidad)
                                 ) > 0
                                 );


            int pageSize = rows ?? 20;
            int totalRecords = DetReq.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numerorequerimiento":
                        campo = String.Format("Requerimientos.NumeroRequerimiento = {1} ", searchString, Generales.Val(searchString));

                        //if (searchString != "")
                        //{
                        //    campo = String.Format("{0} = {1}", searchField, Generales.Val(searchString));
                        //}
                        //else
                        //{
                        //    campo = "true";
                        //}
                        break;
                    case "fecharequerimiento":
                        //No anda
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                    default:
                        campo = String.Format("Obra.Descripcion.Contains(\"{0}\") OR NumeroRequerimiento = {1} ", searchString, Generales.Val(searchString));

                        //campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                }
            }
            else
            {
                campo = "true";
            }


            DetReq = DetReq.Where(campo);


            switch (sidx.ToLower())
            {
                case "numerorequerimiento":
                    if (sord.Equals("desc"))
                        DetReq = DetReq.OrderByDescending(a => a.IdRequerimiento);
                    else
                        DetReq = DetReq.OrderBy(a => a.IdRequerimiento);
                    break;
                default:
                    if (sord.Equals("desc"))
                        DetReq = DetReq.OrderByDescending(a => a.IdRequerimiento);
                    else
                        DetReq = DetReq.OrderBy(a => a.IdRequerimiento);
                    break;
            }


            var data = (from a in DetReq
                        select new
                        {
                            a.IdDetalleRequerimiento,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.NumeroItem,
                            a.Cantidad,
                            a.Unidad.Abreviatura,
                            a.Articulo.Codigo,
                            a.Articulo.Descripcion,
                            a.FechaEntrega,
                            a.Observaciones,
                            a.Adjunto,
                            a.ArchivoAdjunto1,
                            a.ArchivoAdjunto2,
                            a.ArchivoAdjunto3,
                            a.Cumplido,
                            a.OrigenDescripcion,
                            a.IdRequerimiento,
                            a.Requerimientos.NumeroRequerimiento

                        })
//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleRequerimiento.ToString(),
                            cell = new string[] {
                                string.Empty,
                                a.IdDetalleRequerimiento.ToString(),
                                a.IdArticulo.ToString(),
                                a.IdUnidad.ToString(),
                                //Eliminado.ToString(),
                                a.NumeroItem.ToString(), 
                                
                                
                                //a.Cantidad.ToString(), // - loquefigureenpedidos 
                                (a.Cantidad -
                                 db.DetallePedidos.Where(x=>x.IdDetalleRequerimiento==a.IdDetalleRequerimiento
                                                                && ((x.Cumplido ?? "NO" )!="AN"))
                                                        .Sum(z=>z.Cantidad)
                                 ).NullSafeToString(),
                                a.Abreviatura,
                                a.Codigo,
                                "",
                                a.Descripcion,
                                a.FechaEntrega.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Observaciones,
                                a.Cumplido,
                                a.ArchivoAdjunto1,
                                a.OrigenDescripcion.ToString(),
                                                            a.IdRequerimiento.NullSafeToString(),
                                                           a.NumeroRequerimiento.NullSafeToString(),
                                                           "<a href="+ Url.Action("Edit",new {id = a.IdRequerimiento} ) + " target='' >Editar</>"






                        }
                        }).ToArray()










                //           If .OrigenDescripcion = 1 Then
                //    RadioButtonList1.Items(0).Selected = True
                //ElseIf .OrigenDescripcion = 2 Then
                //    RadioButtonList1.Items(1).Selected = True
                //ElseIf .OrigenDescripcion = 3 Then
                //    RadioButtonList1.Items(2).Selected = True
                //Else
                //    RadioButtonList1.Items(0).Selected = True
                //End If
                //<asp:Label Width="300px" ID="Label7" runat="server" Text='<%# Eval("Codigo") & " " & IIf(Eval("OrigenDescripcion")<>2, Eval("Articulo"),"") & " " & IIf(Eval("OrigenDescripcion")<>1, Eval("Observaciones"),"") %>' />


            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }




        public virtual JsonResult DetRequerimientosSinFormato(int IdRequerimiento)
        {
            var Det = db.DetalleRequerimientos.Where(p => p.IdRequerimiento == IdRequerimiento).AsQueryable();

            //Det = Det.Where(a =>
            //                    (a.Cantidad -
            //                     db.DetallePedidos.Where(x => x.IdDetalleRequerimiento == a.IdDetalleRequerimiento
            //                                                    && ((x.Cumplido ?? "NO") != "AN"))
            //                                            .Sum(z => z.Cantidad)
            //                     ) > 0
            //                     );


            var data = (from a in Det
                        select new
                        {
                            IdDetalleRequerimiento = a.IdDetalleRequerimiento,
                            IdArticulo = a.IdArticulo,
                            IdUnidad = a.IdUnidad,
                            NumeroItem = a.NumeroItem,

                            // Cantidad = a.Cantidad,
                            Cantidad = ((a.Cantidad ?? 0) -
                                 (db.DetallePedidos.Where(x => x.IdDetalleRequerimiento == a.IdDetalleRequerimiento
                                                                && ((x.Cumplido ?? "NO") != "AN"))
                                                        .Sum(z => z.Cantidad) ?? 0)
                                 ),


                            Unidad = a.Unidad.Abreviatura,
                            Codigo = a.Articulo.Codigo,
                            Descripcion = a.Articulo.Descripcion,
                            FechaEntrega = a.FechaEntrega,
                            Observaciones = a.Observaciones,
                            Adjunto = a.Adjunto,
                            ArchivoAdjunto1 = a.ArchivoAdjunto1,
                            ArchivoAdjunto2 = a.ArchivoAdjunto2,
                            ArchivoAdjunto3 = a.ArchivoAdjunto3,
                            NumeroRequerimiento = a.Requerimientos.NumeroRequerimiento,
                            NumeroObra = a.Requerimientos.Obra.NumeroObra,
                            PorcentajeIva = a.Articulo.AlicuotaIVA,
                            OrigenDescripcion = a.OrigenDescripcion,
                            Cumplido = a.Cumplido
                        }).OrderBy(p => p.NumeroItem).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdRequerimiento, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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



        public virtual ActionResult EmpleadoSector(int IdEmpleado)
        {
            // var IdEmpleado = (from item in db.Obras where item.IdObra==IdObra select item).SingleOrDefault().IdJefe;
            var IdSector = (from item in db.Empleados where item.IdEmpleado == IdEmpleado select item).SingleOrDefault().IdSector;


            var q = (from item in db.Empleados
                     where item.IdEmpleado == IdEmpleado
                     select new
                     {
                         id = item.IdEmpleado,
                         value = item.IdEmpleado,
                         solicito = IdEmpleado,
                         sector = IdSector
                     }).ToList();


            return Json(q, JsonRequestBehavior.AllowGet);


        }




        public virtual JsonResult Autorizaciones(int IdRequerimiento)
        {
            var Autorizaciones = db.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.RequerimientoMateriales, IdRequerimiento);
            return Json(Autorizaciones, JsonRequestBehavior.AllowGet);
        }


        protected override void Dispose(bool disposing)
        {
            if (db != null) db.Dispose();
            base.Dispose(disposing);



        }












        public virtual FileResult Imprimir(int id) //(int id)
        {
            // string sBasePronto = (string)rc.HttpContext.Session["BasePronto"];
            // db = new DemoProntoEntities(Funciones.Generales.sCadenaConex(sBasePronto));

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            //  string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString);
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.docx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            //string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Requerimiento1_ESUCO_PUNTONET.docx";

            string plantilla = "";
            if (true)
            {
                plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Requerimiento1_Autotrol_PUNTONET.docx";
            }
            else
            {
                plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Requerimiento1_ESUCO_PUNTONET.docx";
            }


            System.IO.FileInfo MyFile2 = new System.IO.FileInfo(plantilla);//busca si ya existe el archivo a generar y en ese caso lo borra

            if (!MyFile2.Exists)
            {
                //usar la de sql
                plantilla = Pronto.ERP.Bll.OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.FacturaA, SC);

            }


            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();



            System.IO.File.Copy(plantilla, output); // 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 
            //Pronto.ERP.BO.Factura fac = FacturaManager.GetItem(SC, id, true);
            //OpenXML_Pronto.FacturaXML_DOCX(output, fac, SC);

            Pronto.ERP.BO.Requerimiento req = RequerimientoManager.GetItem(SC, id, true);
            OpenXML_Pronto.RequerimientoXML_DOCX(output, req, SC);


            //byte[] contents = ;
            //return File(contents, "application/octet-stream");

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "requerimiento.docx");
        }








        void TraerFirmas(ref Requerimiento myRM)
        {

            //If Not IsNull(myRM.Aprobo) Then
            //    Dim mIdAprobo = myRM.Aprobo
            //    If myRM.IdAprobo > 0 Then chkFirma0.Checked = 1
            //End If


            //Dim oRsAut As ADODB.Recordset
            //Dim mCantidadFirmas = 0
            //oRsAut = ConvertToRecordset(GetStoreProcedure(SC, enumSPs.Autorizaciones_TX_CantidadAutorizaciones, EnumFormularios.RequerimientoMateriales, 0))
            //If oRsAut.RecordCount > 0 Then
            //    oRsAut.MoveFirst()
            //    Do While Not oRsAut.EOF
            //        mCantidadFirmas = mCantidadFirmas + 1

            //        Dim check As WebControls.CheckBox = Master.FindControl("ContentPlaceHolder1").FindControl("chkFirma" & mCantidadFirmas)
            //        check.Visible = True
            //        check.ToolTip = oRsAut.Fields(0).Value

            //        oRsAut.MoveNext()
            //    Loop
            //End If

            //    oRsAut = ConvertToRecordset(GetStoreProcedure(SC, enumSPs.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante, EnumFormularios.RequerimientoMateriales, IdEntity))
            //If oRsAut.RecordCount > 0 Then
            //    oRsAut.MoveFirst()
            //    Do While Not oRsAut.EOF
            //        For i = 1 To mCantidadFirmas
            //            Dim check As WebControls.CheckBox = Master.FindControl("ContentPlaceHolder1").FindControl("chkFirma" & i)
            //            If check.ToolTip = oRsAut.Fields("OrdenAutorizacion").Value Then
            //                check.Checked = 1
            //                Exit For
            //            End If
            //        Next
            //        oRsAut.MoveNext()
            //    Loop
            //End If

        }







        public JsonResult AsignaComprador(List<int> idDetalleRequerimientos, string userComprador, string passComprador)
        {



            //autoriza
            //   Dim oF As frmAutorizacion2
            //   Set oF = New frmAutorizacion2
            //   With oF
            //      .Sector = "Compras"
            //      .Show vbModal, Me
            //   End With
            //   mvarOK = oF.Ok
            //   Unload oF
            //   Set oF = Nothing
            //   If Not mvarOK Then
            //'      MsgBox "Solo personal de COMPRAS puede asignar comprador", vbExclamation
            //      Exit Sub
            //   End If
            int mvarIdComprador = db.Empleados.Where(x => x.Nombre == userComprador).Select(x => x.IdEmpleado).First();

            string usuario = oStaticMembershipService.GetUser().UserName;
            int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();



            //asigna comprador
            //Dim oF1 As frmAsignaComprador
            //Dim oL As ListItem
            //Dim oReq As ComPronto.Requerimiento
            //Dim oDetR As ComPronto.DetRequerimiento
            //Dim oRs1 As ADOR.Recordset
            //Dim mvarIdComprador As Long
            //Dim iFilas As Integer
            //Dim mvarComprador As String
            //Dim Filas, Columnas

            //Set oF1 = New frmAsignaComprador

            //With oF1
            //   .Id = 1
            //   .Show vbModal, Me
            //   mvarOK = .Ok
            //   If IsNumeric(.DataCombo1(0).BoundText) Then
            //      mvarIdComprador = .DataCombo1(0).BoundText
            //      mvarComprador = .DataCombo1(0).Text
            //   End If
            //End With

            //Unload oF1
            //Set oF1 = Nothing

            //If Not mvarOK Then
            //   Exit Sub
            //End If

            //Me.MousePointer = vbHourglass

            int ModoConsulta = 0;

            var reqs = db.DetalleRequerimientos.Where(x => idDetalleRequerimientos.Contains(x.IdDetalleRequerimiento)).ToList();

            foreach (Data.Models.DetalleRequerimiento detrm in reqs)
            {
                if (ModoConsulta == 0)
                {

                    detrm.IdComprador = mvarIdComprador;
                    detrm.FechaAsignacionComprador = DateTime.Now;

                    detrm.TipoDesignacion = "CMP";
                    detrm.IdLiberoParaCompras = IdUsuario;
                }

                /*
Case 1
    If IsNumeric(Columnas(8)) Then '.SubItems(7)
       '.SubItems(3) = "" & mvarComprador
       Set oReq = Aplicacion.Requerimientos.Item(Columnas(8))
       oReq.Registro.Fields("IdComprador").Value = mvarIdComprador
       Set oRs1 = oReq.DetRequerimientos.TraerTodos
       With oRs1
          If .RecordCount > 0 Then
             .MoveFirst
             Do While Not .EOF
                Set oDetR = oReq.DetRequerimientos.Item(.Fields(0).Value)
                oDetR.Registro.Fields("IdComprador").Value = mvarIdComprador
                oDetR.Registro.Fields("FechaAsignacionComprador").Value = Now
                oDetR.Modificado = True
                Set oDetR = Nothing
                .MoveNext
             Loop
          End If
          .Close
       End With
       oReq.Guardar
       oReq.GuardarNovedadUsuario 1, mvarIdComprador, "RM: " & oReq.Registro.Fields("NumeroRequerimiento").Value
       Set oReq = Nothing
    End If
                 * */

            }

            db.SaveChanges();


            return Json(null, JsonRequestBehavior.AllowGet);
        }





        public JsonResult DarPorCumplido(List<int> idDetalleRequerimientos, string userAutorizador, string passAutorizador, string userCumplidor, string sObsCumplido)
        {


            int mvarIdDioPorCumplido = db.Empleados.Where(x => x.Nombre == userCumplidor).Select(x => x.IdEmpleado).First();
            int mvarIdAutorizo = db.Empleados.Where(x => x.Nombre == userAutorizador).Select(x => x.IdEmpleado).First();

            // pedir autorizacion    
            //Dim oF As frmAutorizacion2
            //Set oF = New frmAutorizacion2
            //With oF
            //   .Sector = "Compras"
            //   .Show vbModal, Me
            //End With
            //mvarOK = oF.Ok
            //mvarIdAutorizo = oF.IdAutorizo
            //Unload oF
            //Set oF = Nothing

            DataTable oRs1;
            bool mvarOK;
            string mAux1;


            //otra autorizacion?
            //Set oF1 = New frmAsignarComoCumplido
            //With oF1
            //   .Show vbModal, Me
            //   mvarOK = .Ok
            //   If IsNumeric(.dcfields(1).BoundText) Then mvarIdDioPorCumplido = .dcfields(1).BoundText
            //   rchObservacionesCumplido.Text = .rchObservacionesCumplido.Text
            //End With
            //Unload oF1
            //Set oF1 = Nothing

            //If Not mvarOK Then Exit Sub


            int ModoConsulta = 0; // esto depende de qué tipo de rmspendientes se listaron 

            mAux1 = BuscarClaveINI("Avisar al solicitante de la RM que fue dada por cumplida");

            var reqs = db.DetalleRequerimientos.Where(x => idDetalleRequerimientos.Contains(x.IdDetalleRequerimiento)).ToList();

            foreach (Data.Models.DetalleRequerimiento detrm in reqs)
            {

                if (ModoConsulta == 0)
                {

                    if (detrm.Cumplido != "SI")
                    {

                        detrm.Cumplido = "SI";
                        detrm.IdAutorizoCumplido = mvarIdAutorizo;
                        detrm.IdDioPorCumplido = mvarIdDioPorCumplido;
                        detrm.FechaDadoPorCumplido = DateTime.Now;
                        detrm.ObservacionesCumplido = sObsCumplido;
                        detrm.TipoDesignacion = "CMP";



                        if (mAux1 == "SI")
                        {
                            GuardarNovedadUsuario(1, detrm.Requerimientos.IdSolicito ?? 0,
                                    "RM " + detrm.Requerimientos.NumeroRequerimiento +
                                    " dada por cumplida : " + sObsCumplido.Substring(0, 175));
                        }

                        db.SaveChanges();
                        EntidadManager.Tarea(SCsql(), "Requerimientos_ActualizarEstado", detrm.Requerimientos.IdRequerimiento, 0);

                    }
                }

                /*     
                Case 1
                        If IsNumeric(Columnas(8)) And Columnas(7) <> "SI" Then
                           Columnas(7) = "SI"
                           Set oReq = Aplicacion.Requerimientos.Item(Columnas(8))
                           oReq.Registro.Fields("Cumplido").Value = "SI"
                           oReq.Registro.Fields("IdAutorizoCumplido").Value = mvarIdAutorizo
                           oReq.Registro.Fields("IdDioPorCumplido").Value = mvarIdDioPorCumplido
                           oReq.Registro.Fields("FechaDadoPorCumplido").Value = Now
                           oReq.Registro.Fields("ObservacionesCumplido").Value = rchObservacionesCumplido.Text
                           Set oRs1 = oReq.DetRequerimientos.TraerTodos
                           With oRs1
                              If .RecordCount > 0 Then
                                 .MoveFirst
                                 Do While Not .EOF
                                    Set oDetR = oReq.DetRequerimientos.Item(.Fields(0).Value)
                                    oDetR.Registro.Fields("Cumplido").Value = "SI"
                                    oDetR.Registro.Fields("IdAutorizoCumplido").Value = mvarIdAutorizo
                                    oDetR.Registro.Fields("IdDioPorCumplido").Value = mvarIdDioPorCumplido
                                    oDetR.Registro.Fields("FechaDadoPorCumplido").Value = Now
                                    oDetR.Registro.Fields("ObservacionesCumplido").Value = rchObservacionesCumplido.Text
                                    oDetR.Modificado = True
                                    Set oDetR = Nothing
                                    .MoveNext
                                 Loop
                              End If
                              .Close
                           End With
                           If mAux1 = "SI" Then oReq.GuardarNovedadUsuario 1, oReq.Registro.Fields("IdSolicito").Value, "RM " & oReq.Registro.Fields("NumeroRequerimiento").Value & " dada por cumplida : " & mId(rchObservacionesCumplido.Text, 1, 175)
                           oReq.Guardar
                           Set oReq = Nothing
                           Aplicacion.Tarea "Requerimientos_ActualizarEstado", Array(Columnas(8), 0)
                        End If
                 * */
            }

            return Json(null, JsonRequestBehavior.AllowGet);
        }






        public JsonResult GenerarValesAlmacen(List<int> idDetalleRequerimientos, string user, string pass)
        {


            bool mvarOK;
            long mvarIdAutorizo;

            DataTable oRs;





            ///////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////

            string mSector;
            mSector = "Compras"; // se usa para la autorizacion

            //bool glbDebugFacturaElectronica = false;
            //            var mAux1 = db.Parametros2.Where(p => p.Campo == "IdSectorReasignador").FirstOrDefault();
            //if ((mAux1.Valor ?? "") == "SI") { glbDebugFacturaElectronica = true; } 

            try
            {

                string mAux2 = ParametroManager.TraerValorParametro2(SCsql(), ParametroManager.eParam2.IdSectorReasignador);
                if (mAux2 != "")
                {
                    var sss = db.Sectores.Find(mAux2);
                    mSector = sss.Descripcion;
                }
            }
            catch (Exception)
            {

                ///   throw;
            }

            // hay que autorizar....
            //frmAutorizacion2 oF;
            //SetoF = new frmAutorizacion2();

            //            if (!mvarOK) {
            //    return;
            //}

            ///////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////


            object oAp;
            object oReq;
            object oDetR;
            object oF1;
            object oL;
            int i;
            string s;
            string s1;
            string mObra;
            string mAviso;
            object Filas;
            s = "";

            // le pasa mas datos en en string... ademas del id, pasa la obra, 

            var reqs = db.DetalleRequerimientos.Where(x => idDetalleRequerimientos.Contains(x.IdDetalleRequerimiento)).ToList();

            if (reqs.Select(x => x.Requerimientos.IdObra).Distinct().Count() > 1)
            {
                string sError = "Hay items con distinta Obra/C.Costos, deben ser iguales";
                return Json(sError);
            }




            if ((s.Length > 0))
            {
                s = s.Substring(0, (s.Length - 1));
            }




            mAviso = "";

            foreach (Data.Models.DetalleRequerimiento detrm in reqs)
            {
                oRs = EntidadManager.GetStoreProcedure(SCsql(), ProntoFuncionesGenerales.enumSPs.Requerimientos_TX_DatosRequerimiento, detrm.IdDetalleRequerimiento);
                if ((oRs.Rows.Count > 0))
                {
                    s1 = oRs.Rows[0]["ObservacionesFirmante"].ToString();
                    if ((s1.Length > 0))
                    {
                        mAviso = (mAviso + ("\r\n" + ("La RM "
                                    + (oRs.Rows[0]["NumeroRequerimiento"].ToString() + (" item "
                                    + (oRs.Rows[0]["NumeroItem"].ToString() + " esta observada por el firmante."))))));
                    }

                }
            }


            if ((mAviso.Length > 0))
            {
                //devolverlo al final
                //    MsgBox;    ("Notificaciones en generacion de vale : " + mAviso);    System.Windows.Forms.MessageBoxIcon.Information;
            }



            // acá tenemos otro formulario modal, UN ALTA DE VALE!!!
            var vale = CrearValeSegunItemDeRM(idDetalleRequerimientos, user, pass);

            var c = new ValeSalidaController(); //ese controlador no recibe el membership que estoy usando en este
            c.db = db;
            c.oStaticMembershipService = oStaticMembershipService;
            c.BatchUpdate(vale);
            c = null;



            //Set oF1 = New frmValesSalida
            //With oF1
            //   .DetalleRequerimientos = s
            //   .NivelAcceso = Alto
            //   .Id = -1
            //   .Show vbModal
            //   mvarOK = .Ok
            //End With
            //Set oF1 = Nothing
            //If Not mvarOK Then Exit Sub

            //Set oAp = Aplicacion



            string ss = db.Parametros.FirstOrDefault().ActivarSolicitudMateriales;
            bool ActivarSolicitudMateriales = (ss == "SI");

            foreach (Data.Models.DetalleRequerimiento detrm in reqs)
            {

                if (ActivarSolicitudMateriales)
                {
                    detrm.TipoDesignacion = "STK";
                    db.SaveChanges();
                }

                EntidadManager.Tarea(SCsql(), "Requerimientos_ActualizarEstado", detrm.Requerimientos.IdRequerimiento, detrm.IdDetalleRequerimiento);
            }


            return Json(null, JsonRequestBehavior.AllowGet);

        }






        ValesSalida CrearValeSegunItemDeRM(List<int> idDetalleRequerimientos, string user, string pass)
        {
            var vale = new ValesSalida();

            vale.Aprobo = db.Empleados.Where(x => x.Nombre == user).Select(x => x.IdEmpleado).First();
            vale.FechaValeSalida = DateTime.Today;

            var reqs = db.DetalleRequerimientos.Where(x => idDetalleRequerimientos.Contains(x.IdDetalleRequerimiento));

            foreach (Data.Models.DetalleRequerimiento detrm in reqs)
            {
                var detvale = new DetalleValesSalida();
                detvale.IdArticulo = detrm.IdArticulo;
                detvale.IdDetalleRequerimiento = detrm.IdDetalleRequerimiento;
                detvale.Cantidad = detrm.Cantidad;


                vale.DetalleValesSalidas.Add(detvale);
            }

            return vale;
        }
    }

}