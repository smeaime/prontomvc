using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Globalization;
using System.IO;
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
using System.Configuration;
using System.Diagnostics;

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

        public virtual ViewResult Details(int id)
        {
            Requerimiento requerimiento = db.Requerimientos.Find(id);
            return View(requerimiento);
        }

        void inic(ref ProntoMVC.Data.Models.Requerimiento o)
        {
            Parametros parametros = db.Parametros.Find(1);

            o.IdMoneda = 1;
            o.IdTipoCompra = 1;

            //string usuario = ViewBag.NombreUsuario;
            //var IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
            //var IdSector = (from item in db.Empleados where item.IdEmpleado == IdUsuario select item).SingleOrDefault().IdSector;
            //ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra");

            o.DetalleRequerimientos.Add(new ProntoMVC.Data.Models.DetalleRequerimiento());
            o.DetalleRequerimientos.Add(new ProntoMVC.Data.Models.DetalleRequerimiento());
            o.DetalleRequerimientos.Add(new ProntoMVC.Data.Models.DetalleRequerimiento());
        }

        void CargarViewBag(Requerimiento o)
        {
            //ViewBag.IdObra = new SelectList(db.Obras.Where(x => x.Activa != "NO").OrderBy(x => x.NumeroObra)
            //                            .Select(y => new { y.IdObra, NumeroObra = y.NumeroObra + " - " + (y.Descripcion ?? "") }), "IdObra", "NumeroObra", o.IdObra);
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
            ViewBag.IdObra = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra);

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

            dt = EntidadManager.GetStoreProcedure(nSC, "Articulos_TX_ParaMantenimiento_ParaCombo", 0, 0, 0, "");
            rows = dt.AsEnumerable();
            var sq2 = (from r in rows orderby r[1] select new { IdArticulo = r[0], Titulo = r[1] }).ToList();
            ViewBag.IdEquipoDestino = new SelectList(sq2, "IdArticulo", "Titulo", o.IdEquipoDestino);
            ViewBag.IdTipoCompra = new SelectList(db.TiposCompras.OrderBy(x => x.Descripcion), "IdTipoCompra", "Descripcion", o.IdTipoCompra);
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

            if ((o.IdTipoCompra ?? 0) <= 0)
            {
                sErrorMsg += "\n" + "Falta el tipo de compra";
            }

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

                //if (x.FechaEntrega == new DateTime(2001, 1, 1)) x.FechaEntrega = null;
                if (x.FechaEntrega == null)
                {
                    sErrorMsg += "\n" + "No ingreso la fecha de entrega de " + db.Articulos.Find(x.IdArticulo).Descripcion;
                }
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
                    if ((o.Cumplido ?? "NO") == "AN" && (x.Cumplido ?? "NO") != "AN") { x.Cumplido = "AN"; }
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
                    string tipomovimiento = "";

                    ValidaryReformatearRequerimiento(requerimiento);

                    if ((requerimiento.Aprobo ?? 0) > 0 && (requerimiento.CircuitoFirmasCompleto ?? "") != "SI")
                    {
                        var data = (from a in db.DetalleAutorizaciones
                                    from b in db.Autorizaciones.Where(o => o.IdAutorizacion == a.IdAutorizacion).DefaultIfEmpty()
                                    select new
                                    {
                                        IdAutorizacion = a.IdAutorizacion,
                                        IdFormulario = (b.IdFormulario ?? 0)
                                    }).Where(a => a.IdFormulario == 3).AsQueryable();
                        if (data.Count() == 0)
                        {
                            requerimiento.CircuitoFirmasCompleto = "SI";
                        }
                    }

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

                string TipoDeCompraEnRMHabilitado = BuscarClaveINI("Habilitar tipo de compra en RM", -1);

                if (TipoDeCompraEnRMHabilitado == "SI")
                {
                    string Modalidad = db.TiposCompras.Find(requerimiento.IdTipoCompra).Modalidad ?? "CC";

                    string TipoDesignacionActual = "-1";
                    int IdDetallePedido = 0;
                    if (dr.IdDetalleRequerimiento > 0)
                    {
                        TipoDesignacionActual = db.DetalleRequerimientos.Find(dr.IdDetalleRequerimiento).TipoDesignacion ?? null;
                        IdDetallePedido = (from dp in dr.DetallePedidos
                                           join p in db.Pedidos on dp.IdPedido equals p.IdPedido
                                           where (dp.IdDetalleRequerimiento ?? 0) == dr.IdDetalleRequerimiento && (dp.Cumplido ?? "NO") != "AN" && (p.Cumplido ?? "NO") != "AN"
                                           select dp.IdDetallePedido
                               ).FirstOrDefault();
                    }

                    if (Modalidad == "CR" && IdDetallePedido == 0 && (TipoDesignacionActual == "-1" || TipoDesignacionActual == null))
                        dr.TipoDesignacion = "S/D";
                    else if (Modalidad == "CO" && IdDetallePedido == 0 && (TipoDesignacionActual == "-1" || TipoDesignacionActual == "S/D"))
                        dr.TipoDesignacion = null;
                    else if (Modalidad == "CN" && IdDetallePedido == 0 && (TipoDesignacionActual == "-1" || TipoDesignacionActual == "S/D"))
                        dr.TipoDesignacion = null;
                }

                if (dr.IdComprador == null)
                {

                }
            }
        }

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
            int glbIdUsuario = Pedido.Aprobo ?? -1;
            if (glbIdUsuario <= 0) glbIdUsuario = -1;
            string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            Pronto.ERP.Bll.EntidadManager.Tarea(nSC, "AutorizacionesPorComprobante_EliminarFirmas",
                                                    (int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.RequerimientoMateriales,
                                                    Pedido.IdRequerimiento, -1, glbIdUsuario);  // idformulario,idcomprobante, orden autorizacion, idusuarioelimino

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

            return BatchUpdate(Requerimiento);
        }

        public class Requerimientos2
        {
            public int IdRequerimiento { get; set; }
            public int? IdObra { get; set; }
            public int? NumeroRequerimiento { get; set; }
            public DateTime? FechaRequerimiento { get; set; }
            public string NumeradorEliminacionesFirmas { get; set; }
            public string Cumplido { get; set; }
            public string Recepcionado { get; set; }
            public string Entregado { get; set; }
            public string Impresa { get; set; }
            public string Detalle { get; set; }
            public string Obra { get; set; }
            public string Presupuestos { get; set; }
            public string Comparativas { get; set; }
            public string Pedidos { get; set; }
            public string Recepciones { get; set; }
            public string Salidas { get; set; }
            public int? CantidadItems { get; set; }
            public string LiberadoPor { get; set; }
            public DateTime? FechaAprobacion { get; set; }
            public string SolicitadaPor { get; set; }
            public string Sector { get; set; }
            public string EquipoDestino { get; set; }
            public string UsuarioAnulacion { get; set; }
            public DateTime? FechaAnulacion { get; set; }
            public string MotivoAnulacion { get; set; }
            public string TipoCompra { get; set; }
            public string Comprador { get; set; }
            public string FechasLiberacionCompra { get; set; }
            public string DetalleImputacion { get; set; }
            public string Observaciones { get; set; }
            public string CircuitoFirmasCompleto { get; set; }
            public string Firmas { get; set; }
            public string Confirmado { get; set; }
            public string Modalidad { get; set; }
            public int? CantidadItemsNoComprables { get; set; }
        }

        public class DetalleRequerimientos2
        {
            public int IdDetalleRequerimiento { get; set; }
            public int? IdRequerimiento { get; set; }
            public int? IdArticulo { get; set; }
            public int? IdUnidad { get; set; }
            public int? IdControlCalidad { get; set; }
            public int? OrigenDescripcion { get; set; }
            public int? NumeroRequerimiento { get; set; }
            public DateTime? FechaRequerimiento { get; set; }
            public int? NumeroItem { get; set; }
            public decimal? Cantidad { get; set; }
            public decimal? CantidadPendiente { get; set; }
            public string Unidad { get; set; }
            public string Codigo { get; set; }
            public string Articulo { get; set; }
            public string Observaciones { get; set; }
            public string TiposDeDescripcion { get; set; }
            public DateTime? FechaEntrega { get; set; }
            public string Cumplido { get; set; }
            public string DescripcionControlCalidad { get; set; }
            public string ArchivoAdjunto1 { get; set; }
            public string ArchivoAdjunto2 { get; set; }
            public string ArchivoAdjunto3 { get; set; }
            public string ArchivoAdjunto4 { get; set; }
            public string ArchivoAdjunto5 { get; set; }
            public string ArchivoAdjunto6 { get; set; }
            public string ArchivoAdjunto7 { get; set; }
            public string ArchivoAdjunto8 { get; set; }
            public string ArchivoAdjunto9 { get; set; }
            public string ArchivoAdjunto10 { get; set; }
            public int? Aprobo { get; set; }
            public string CircuitoFirmasCompleto { get; set; }
            public string Modalidad { get; set; }
            public string TipoDesignacion { get; set; }
        }

        public virtual ActionResult Requerimientos_DynamicGridData
                (string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal, string IdObra, bool bAConfirmar = false, bool bALiberar = false)
        {
            DateTime FechaDesde, FechaHasta;
            try
            {
                if (FechaInicial == "") FechaDesde = DateTime.MinValue;
                else FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            }
            catch (Exception)
            {
                FechaDesde = DateTime.MinValue;
            }

            try
            {
                if (FechaFinal == "") FechaHasta = DateTime.MaxValue;
                else FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            }
            catch (Exception)
            {
                FechaHasta = DateTime.MaxValue;
            }

            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.Requerimientos
                        from b in db.Empleados.Where(o => o.IdEmpleado == a.Aprobo).DefaultIfEmpty()
                        from c in db.Empleados.Where(o => o.IdEmpleado == a.IdSolicito).DefaultIfEmpty()
                        from d in db.TiposCompras.Where(o => o.IdTipoCompra == a.IdTipoCompra).DefaultIfEmpty()
                        select new Requerimientos2
                        {
                            IdRequerimiento = a.IdRequerimiento,
                            IdObra = a.IdObra,
                            NumeroRequerimiento = a.NumeroRequerimiento,
                            FechaRequerimiento = a.FechaRequerimiento,
                            NumeradorEliminacionesFirmas = a.NumeradorEliminacionesFirmas.ToString(),
                            Cumplido = a.Cumplido,
                            Recepcionado = a.Recepcionado,
                            Entregado = a.Entregado,
                            Impresa = a.Impresa,
                            Detalle = a.Detalle,
                            Obra = a.Obra.NumeroObra + " " + a.Obra.Descripcion,
                            Presupuestos = ModelDefinedFunctions.Requerimientos_Presupuestos(a.IdRequerimiento).ToString(),
                            Comparativas = "",
                            Pedidos = ModelDefinedFunctions.Requerimientos_Pedidos(a.IdRequerimiento).ToString(),
                            Recepciones = ModelDefinedFunctions.Requerimientos_Recepciones(a.IdRequerimiento).ToString(),
                            Salidas = ModelDefinedFunctions.Requerimientos_SalidasMateriales(a.IdRequerimiento).ToString(),
                            CantidadItems = a.DetalleRequerimientos.Count(),
                            LiberadoPor = b != null ? b.Nombre : "",
                            FechaAprobacion = a.FechaAprobacion,
                            SolicitadaPor = c != null ? c.Nombre : "",
                            Sector = a.Sectores.Descripcion,
                            EquipoDestino = "",
                            UsuarioAnulacion = a.UsuarioAnulacion,
                            FechaAnulacion = a.FechaAnulacion,
                            MotivoAnulacion = a.MotivoAnulacion ?? "",
                            TipoCompra = d != null ? d.Descripcion : "",
                            Comprador = "",
                            FechasLiberacionCompra = "",
                            DetalleImputacion = a.DetalleImputacion,
                            Observaciones = a.Observaciones,
                            CircuitoFirmasCompleto = a.CircuitoFirmasCompleto,
                            Firmas = "",
                            Confirmado = a.Confirmado,
                            Modalidad = d != null ? d.Modalidad : "",
                            CantidadItemsNoComprables = a.DetalleRequerimientos.Where(x => (x.TipoDesignacion ?? "") == "S/D").Count()
                        }).Where(a => a.FechaRequerimiento >= FechaDesde && a.FechaRequerimiento <= FechaHasta && (IdObra == "" || a.IdObra.ToString() == IdObra) && (!bALiberar || a.LiberadoPor == "") && (!bAConfirmar || (a.Confirmado ?? "") != "SI")).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<Requerimientos2>
                                     (sidx, sord, page, rows, _search, filters, db, ref totalRecords, data);

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdRequerimiento.ToString(),
                            cell = new string[] {
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdRequerimiento} )  +">Imprimir</>" ,
                                "<a href="+ Url.Action("Edit",new {id = a.IdRequerimiento} ) + "  >Editar</>" ,
                                a.IdRequerimiento.ToString(),
                                a.NumeroRequerimiento.NullSafeToString(),
                                a.FechaRequerimiento==null ? "" :  a.FechaRequerimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.NumeradorEliminacionesFirmas.NullSafeToString(),
                                a.Cumplido.NullSafeToString(),
                                a.Recepcionado.NullSafeToString(),
                                a.Entregado.NullSafeToString(),
                                a.Impresa.NullSafeToString(),
                                a.Detalle.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.Presupuestos.NullSafeToString(),
                                a.Comparativas.NullSafeToString(),
                                a.Pedidos.NullSafeToString(),
                                a.Recepciones.NullSafeToString(),
                                a.Salidas.NullSafeToString(),
                                a.CantidadItems.NullSafeToString(),
                                a.LiberadoPor.NullSafeToString(),
                                a.FechaAprobacion.NullSafeToString(),
                                a.SolicitadaPor.NullSafeToString(),
                                a.Sector.NullSafeToString(),
                                a.EquipoDestino.NullSafeToString(),
                                a.UsuarioAnulacion.NullSafeToString(),
                                a.FechaAnulacion.NullSafeToString(),
                                a.MotivoAnulacion.NullSafeToString(),
                                a.TipoCompra.NullSafeToString(),
                                a.Comprador.NullSafeToString(),
                                a.FechasLiberacionCompra.NullSafeToString(),
                                a.DetalleImputacion.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.CircuitoFirmasCompleto.NullSafeToString(),
                                a.Firmas.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public PartialViewResult PartialPage1(string idDetalleRequerimientos)
        {
            //if (idDetalleRequerimientos == "") return PartialView();

            var idDetalleRequerimientos2 = idDetalleRequerimientos.Split(',').Select(Int32.Parse).ToList();

            var vale = CrearValeSegunItemDeRM(idDetalleRequerimientos2, "", "");

            //return PartialView("_PartialPage1", new ValesSalida());
            return PartialView("_PartialPage1", vale);
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
                            IdDetalleRequerimiento2 = a[2],
                            IdRequerimiento = a[3],
                            IdObra = a[4],
                            TipoDesignacion = a[5],
                            Item = a[6],
                            Cantidad = a[7],
                            Unidad = a[8],
                            CantidadVales = a[9],
                            CantidadPedida = a[10],
                            CantidadRecibida = a[11],
                            NumeroRecepcion = a[12],
                            UltimoNumeroRecepcion = a[13],
                            EnStock = a[14],
                            StockMinimo = a[15],
                            Articulo = a[16],
                            FechaEntrega = a[17],
                            Solicito = a[18],
                            TipoRequerimiento = a[19],
                            Obra = a[20],
                            Cumplido = a[21],
                            Recepcionado = a[22],
                            Observacionesitem = a[23],
                            Deposito = a[24],
                            ObservacionesFirmante = a[25],
                            FirmanteObservo = a[26],
                            FechaUltimaObservacion = a[27],
                            CodigoEquipoDestino = a[28],
                            EquipoDestino = a[29]
                        }).ToList();

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
                                "<a href="+ Url.Action("Edit",new {id = a.IdRequerimiento} ) + "  >Editar</>" ,
                                a.IdDetalleRequerimiento.ToString(),
                                a.IdRequerimiento.ToString(),
                                a.IdObra.ToString(),
                                a.TipoDesignacion.ToString(),
                                a.NumeroRequerimiento.ToString(),
                                a.Item.ToString(),
                                a.Cantidad.ToString(),
                                a.Unidad.ToString(),
                                a.CantidadVales.ToString(),
                                a.CantidadPedida.ToString(),
                                a.CantidadRecibida.ToString(),
                                a.NumeroRecepcion.ToString(),
                                a.UltimoNumeroRecepcion.ToString(),
                                a.EnStock.ToString(),
                                a.StockMinimo.ToString(),
                                a.Articulo.ToString(),
                                a.FechaEntrega.ToString(),
                                a.Solicito.ToString(),
                                a.TipoRequerimiento.ToString(),
                                a.Obra.ToString(),
                                a.Cumplido.ToString(),
                                a.Recepcionado.ToString(),
                                a.Observacionesitem.ToString(),
                                a.Deposito.ToString(),
                                a.ObservacionesFirmante.ToString(),
                                a.FirmanteObservo.ToString(),
                                a.FechaUltimaObservacion.ToString(),
                                a.CodigoEquipoDestino.ToString(),
                                a.EquipoDestino.ToString()
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
            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.Requerimientos
                        from b in db.Empleados.Where(o => o.IdEmpleado == a.Aprobo).DefaultIfEmpty()
                        from c in db.Empleados.Where(o => o.IdEmpleado == a.IdSolicito).DefaultIfEmpty()
                        from d in db.TiposCompras.Where(o => o.IdTipoCompra == a.IdTipoCompra).DefaultIfEmpty()
                        select new Requerimientos2
                        {
                            IdRequerimiento = a.IdRequerimiento,
                            IdObra = a.IdObra,
                            NumeroRequerimiento = a.NumeroRequerimiento,
                            FechaRequerimiento = a.FechaRequerimiento,
                            NumeradorEliminacionesFirmas = a.NumeradorEliminacionesFirmas.ToString(),
                            Cumplido = a.Cumplido,
                            Recepcionado = a.Recepcionado,
                            Entregado = a.Entregado,
                            Impresa = a.Impresa,
                            Detalle = a.Detalle,
                            Obra = a.Obra.NumeroObra + " " + a.Obra.Descripcion,
                            Presupuestos = "", //ModelDefinedFunctions.Pedidos_Requerimientos(a.IdPedido).ToString(),
                            Comparativas = "",
                            Pedidos = "",
                            Recepciones = "",
                            Salidas = "",
                            CantidadItems = a.DetalleRequerimientos.Count(),
                            LiberadoPor = b != null ? b.Nombre : "",
                            FechaAprobacion = a.FechaAprobacion,
                            SolicitadaPor = c != null ? c.Nombre : "",
                            Sector = a.Sectores.Descripcion,
                            EquipoDestino = "",
                            UsuarioAnulacion = a.UsuarioAnulacion,
                            FechaAnulacion = a.FechaAnulacion,
                            MotivoAnulacion = a.MotivoAnulacion ?? "",
                            TipoCompra = d != null ? d.Descripcion : "",
                            Comprador = "",
                            FechasLiberacionCompra = "",
                            DetalleImputacion = a.DetalleImputacion,
                            Observaciones = a.Observaciones,
                            CircuitoFirmasCompleto = a.CircuitoFirmasCompleto,
                            Firmas = "",
                            Confirmado = a.Confirmado,
                            Modalidad = d != null ? d.Modalidad : "",
                            CantidadItemsNoComprables = a.DetalleRequerimientos.Where(x => (x.TipoDesignacion ?? "") == "S/D").Count()
                        }).Where(a => (a.Cumplido == null || (a.Cumplido != "AN" && a.Cumplido != "SI")) && a.LiberadoPor.Length > 0 && (a.CircuitoFirmasCompleto ?? "NO") == "SI" && (a.Modalidad ?? "") != "CO" && a.CantidadItems > a.CantidadItemsNoComprables).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<Requerimientos2>(sidx, sord, page, rows, _search, filters, db, ref totalRecords, data);

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdRequerimiento.ToString(),
                            cell = new string[] {
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdRequerimiento} )  +">Imprimir</>" ,
                                "<a href="+ Url.Action("Edit",new {id = a.IdRequerimiento} ) + "  >Editar</>" ,
                                a.IdRequerimiento.ToString(),
                                a.NumeroRequerimiento.NullSafeToString(),
                                a.FechaRequerimiento==null ? "" :  a.FechaRequerimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.NumeradorEliminacionesFirmas.NullSafeToString(),
                                a.Cumplido.NullSafeToString(),
                                a.Recepcionado.NullSafeToString(),
                                a.Entregado.NullSafeToString(),
                                a.Impresa.NullSafeToString(),
                                a.Detalle.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.Presupuestos.NullSafeToString(),
                                a.Comparativas.NullSafeToString(),
                                a.Pedidos.NullSafeToString(),
                                a.Recepciones.NullSafeToString(),
                                a.Salidas.NullSafeToString(),
                                a.CantidadItems.NullSafeToString(),
                                a.LiberadoPor.NullSafeToString(),
                                a.FechaAprobacion.NullSafeToString(),
                                a.SolicitadaPor.NullSafeToString(),
                                a.Sector.NullSafeToString(),
                                a.EquipoDestino.NullSafeToString(),
                                a.UsuarioAnulacion.NullSafeToString(),
                                a.FechaAnulacion.NullSafeToString(),
                                a.MotivoAnulacion.NullSafeToString(),
                                a.TipoCompra.NullSafeToString(),
                                a.Comprador.NullSafeToString(),
                                a.FechasLiberacionCompra.NullSafeToString(),
                                a.DetalleImputacion.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.CircuitoFirmasCompleto.NullSafeToString(),
                                a.Firmas.NullSafeToString()
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

        public virtual JsonResult RequerimientoSinFormato(int IdRequerimiento)
        {
            var rm = db.Requerimientos.Where(p => p.IdRequerimiento == IdRequerimiento).AsQueryable();

            var data = (from a in rm
                        from b in db.Empleados.Where(o => o.IdEmpleado == a.Aprobo).DefaultIfEmpty()
                        from c in db.Empleados.Where(o => o.IdEmpleado == a.IdSolicito).DefaultIfEmpty()
                        from d in db.TiposCompras.Where(o => o.IdTipoCompra == a.IdTipoCompra).DefaultIfEmpty()
                        select new
                        {
                            IdRequerimiento = a.IdRequerimiento,
                            IdObra = a.IdObra,
                            IdSector = a.IdSector,
                            IdTipoCompra = a.IdTipoCompra,
                            IdEquipoDestino = a.IdEquipoDestino,
                            IdSolicito = a.IdSolicito,
                            Aprobo = a.Aprobo,
                            NumeroRequerimiento = a.NumeroRequerimiento,
                            FechaRequerimiento = a.FechaRequerimiento,
                            NumeradorEliminacionesFirmas = a.NumeradorEliminacionesFirmas.ToString(),
                            Cumplido = a.Cumplido,
                            Recepcionado = a.Recepcionado,
                            Entregado = a.Entregado,
                            Impresa = a.Impresa,
                            Detalle = a.Detalle,
                            Obra = a.Obra.NumeroObra + " " + a.Obra.Descripcion,
                            CantidadItems = a.DetalleRequerimientos.Count(),
                            LiberadoPor = b != null ? b.Nombre : "",
                            FechaAprobacion = a.FechaAprobacion,
                            SolicitadaPor = c != null ? c.Nombre : "",
                            Sector = a.Sectores.Descripcion,
                            EquipoDestino = "",
                            UsuarioAnulacion = a.UsuarioAnulacion,
                            FechaAnulacion = a.FechaAnulacion,
                            MotivoAnulacion = a.MotivoAnulacion ?? "",
                            TipoCompra = d != null ? d.Descripcion : "",
                            Comprador = "",
                            FechasLiberacionCompra = "",
                            DetalleImputacion = a.DetalleImputacion,
                            Observaciones = a.Observaciones,
                            CircuitoFirmasCompleto = a.CircuitoFirmasCompleto,
                            Firmas = "",
                        }).ToList();

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetRequerimientos(string sidx, string sord, int? page, int? rows, int? IdRequerimiento)
        {
            int IdRequerimiento1 = IdRequerimiento ?? 0;

            var DetReq = db.DetalleRequerimientos
                            .Include(x => x.ControlCalidad)
                            .Where(p => p.IdRequerimiento == IdRequerimiento1 || IdRequerimiento1 == -1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetReq.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetReq
                        select new
                        {
                            a.IdDetalleRequerimiento,
                            a.IdRequerimiento,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdControlCalidad,
                            a.OrigenDescripcion,
                            a.TipoDesignacion,
                            a.NumeroItem,
                            a.Cantidad,
                            Unidad = a.Unidad.Abreviatura,
                            Codigo = a.Articulo.Codigo,
                            Articulo = a.Articulo.Descripcion,
                            a.Observaciones,
                            TiposDeDescripcion = (a.OrigenDescripcion ?? 1) == 1 ? "Solo material" : ((a.OrigenDescripcion ?? 1) == 2 ? "Solo observaciones" : ((a.OrigenDescripcion ?? 1) == 3 ? "Material + observaciones" : "")),
                            a.FechaEntrega,
                            a.Cumplido,
                            DescripcionControlCalidad = (a.ControlCalidad == null) ? "" : a.ControlCalidad.Descripcion,
                            a.ArchivoAdjunto1,
                            a.ArchivoAdjunto2,
                            a.ArchivoAdjunto3,
                            a.ArchivoAdjunto4,
                            a.ArchivoAdjunto5,
                            a.ArchivoAdjunto6,
                            a.ArchivoAdjunto7,
                            a.ArchivoAdjunto8,
                            a.ArchivoAdjunto9,
                            a.ArchivoAdjunto10
                        }).OrderBy(x => x.NumeroItem)
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
                                a.IdRequerimiento.NullSafeToString(),
                                a.IdArticulo.ToString(),
                                a.IdUnidad.ToString(),
                                a.IdControlCalidad.NullSafeToString(),
                                a.OrigenDescripcion.ToString(),
                                a.TipoDesignacion.NullSafeToString(),
                                a.NumeroItem.ToString(),
                                a.Cantidad.ToString(),
                                a.Unidad,
                                a.Codigo,
                                a.Articulo,
                                a.Observaciones.NullSafeToString(),
                                a.TiposDeDescripcion,
                                a.FechaEntrega.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Cumplido.NullSafeToString(),
                                a.DescripcionControlCalidad.NullSafeToString(),
                                "", //"<input id='fileupload' type='file' name='files[]' multiple />",  //"<input style='height:22px;width:20px;' id='fileupload'+  type='file' name='files[]' multiple value='A' onclick=\"Adjunto;\"  />",
                                (a.ArchivoAdjunto1==null || a.ArchivoAdjunto1.Length == 0) ?  "" :  "<a href="+ Url.Action("ArchivosAdjuntos",new {filename = a.ArchivoAdjunto1} ) + ">" + a.ArchivoAdjunto1 + "</>",
                                (a.ArchivoAdjunto2==null || a.ArchivoAdjunto2.Length == 0) ?  "" :  "<a href="+ Url.Action("ArchivosAdjuntos",new {filename = a.ArchivoAdjunto2} ) + ">" + a.ArchivoAdjunto2 + "</>",
                                (a.ArchivoAdjunto3==null || a.ArchivoAdjunto3.Length == 0) ?  "" :  "<a href="+ Url.Action("ArchivosAdjuntos",new {filename = a.ArchivoAdjunto3} ) + ">" + a.ArchivoAdjunto3 + "</>",
                                (a.ArchivoAdjunto4==null || a.ArchivoAdjunto4.Length == 0) ?  "" :  "<a href="+ Url.Action("ArchivosAdjuntos",new {filename = a.ArchivoAdjunto4} ) + ">" + a.ArchivoAdjunto4 + "</>",
                                (a.ArchivoAdjunto5==null || a.ArchivoAdjunto5.Length == 0) ?  "" :  "<a href="+ Url.Action("ArchivosAdjuntos",new {filename = a.ArchivoAdjunto5} ) + ">" + a.ArchivoAdjunto5 + "</>",
                                (a.ArchivoAdjunto6==null || a.ArchivoAdjunto6.Length == 0) ?  "" :  "<a href="+ Url.Action("ArchivosAdjuntos",new {filename = a.ArchivoAdjunto6} ) + ">" + a.ArchivoAdjunto6 + "</>",
                                (a.ArchivoAdjunto7==null || a.ArchivoAdjunto7.Length == 0) ?  "" :  "<a href="+ Url.Action("ArchivosAdjuntos",new {filename = a.ArchivoAdjunto7} ) + ">" + a.ArchivoAdjunto7 + "</>",
                                (a.ArchivoAdjunto8==null || a.ArchivoAdjunto8.Length == 0) ?  "" :  "<a href="+ Url.Action("ArchivosAdjuntos",new {filename = a.ArchivoAdjunto8} ) + ">" + a.ArchivoAdjunto8 + "</>",
                                (a.ArchivoAdjunto9==null || a.ArchivoAdjunto9.Length == 0) ?  "" :  "<a href="+ Url.Action("ArchivosAdjuntos",new {filename = a.ArchivoAdjunto9} ) + ">" + a.ArchivoAdjunto9 + "</>",
                                (a.ArchivoAdjunto10==null || a.ArchivoAdjunto10.Length == 0) ?  "" :  "<a href="+ Url.Action("ArchivosAdjuntos",new {filename = a.ArchivoAdjunto10} ) + ">" + a.ArchivoAdjunto10 + "</>"
                         }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetRequerimientosComprables_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, int? IdRequerimiento)
        {
            int IdRequerimiento1 = IdRequerimiento ?? -1;

            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.DetalleRequerimientos
                        from d in db.TiposCompras.Where(o => o.IdTipoCompra == a.Requerimientos.IdTipoCompra).DefaultIfEmpty()
                        select new DetalleRequerimientos2
                        {
                            IdDetalleRequerimiento = a.IdDetalleRequerimiento,
                            IdRequerimiento = a.IdRequerimiento,
                            IdArticulo = a.IdArticulo,
                            IdUnidad = a.IdUnidad,
                            IdControlCalidad = a.IdControlCalidad,
                            OrigenDescripcion = a.OrigenDescripcion,
                            NumeroRequerimiento = a.Requerimientos.NumeroRequerimiento,
                            FechaRequerimiento = a.Requerimientos.FechaRequerimiento,
                            NumeroItem = a.NumeroItem,
                            Cantidad = a.Cantidad,
                            CantidadPendiente = (a.Cantidad - (db.DetallePedidos.Where(x => x.IdDetalleRequerimiento == a.IdDetalleRequerimiento && ((x.Cumplido ?? "NO") != "AN")).Sum(z => z.Cantidad) ?? 0)),
                            Unidad = a.Unidad.Abreviatura,
                            Codigo = a.Articulo.Codigo,
                            Articulo = a.Articulo.Descripcion,
                            Observaciones = a.Observaciones,
                            TiposDeDescripcion = (a.OrigenDescripcion ?? 1) == 1 ? "Solo material" : ((a.OrigenDescripcion ?? 1) == 2 ? "Solo observaciones" : ((a.OrigenDescripcion ?? 1) == 3 ? "Material + observaciones" : "")),
                            FechaEntrega = a.FechaEntrega,
                            Cumplido = a.Cumplido,
                            DescripcionControlCalidad = (a.ControlCalidad == null) ? "" : a.ControlCalidad.Descripcion,
                            ArchivoAdjunto1 = a.ArchivoAdjunto1,
                            ArchivoAdjunto2 = a.ArchivoAdjunto2,
                            ArchivoAdjunto3 = a.ArchivoAdjunto3,
                            ArchivoAdjunto4 = a.ArchivoAdjunto4,
                            ArchivoAdjunto5 = a.ArchivoAdjunto5,
                            ArchivoAdjunto6 = a.ArchivoAdjunto6,
                            ArchivoAdjunto7 = a.ArchivoAdjunto7,
                            ArchivoAdjunto8 = a.ArchivoAdjunto8,
                            ArchivoAdjunto9 = a.ArchivoAdjunto9,
                            ArchivoAdjunto10 = a.ArchivoAdjunto10,
                            Aprobo = a.Requerimientos.Aprobo,
                            CircuitoFirmasCompleto = a.Requerimientos.CircuitoFirmasCompleto,
                            Modalidad = d != null ? d.Modalidad : "",
                            TipoDesignacion = a.TipoDesignacion
                        }).Where(a => (IdRequerimiento1 <= 0 || a.IdRequerimiento == IdRequerimiento1) && (a.Cumplido == null || (a.Cumplido != "AN" && a.Cumplido != "SI")) && (a.Aprobo ?? 0) > 0 && (a.CircuitoFirmasCompleto ?? "NO") == "SI" && (a.Cantidad - (db.DetallePedidos.Where(x => x.IdDetalleRequerimiento == a.IdDetalleRequerimiento && ((x.Cumplido ?? "NO") != "AN")).Sum(z => z.Cantidad) ?? 0)) > 0 && (a.Modalidad ?? "") != "CO" && (a.TipoDesignacion ?? "") != "S/D").OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<DetalleRequerimientos2>(sidx, sord, page, rows, _search, filters, db, ref totalRecords, data);

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleRequerimiento.ToString(),
                            cell = new string[] {
                                a.IdDetalleRequerimiento.ToString(),
                                a.IdRequerimiento.NullSafeToString(),
                                a.IdArticulo.NullSafeToString(),
                                a.IdUnidad.NullSafeToString(),
                                a.IdControlCalidad.NullSafeToString(),
                                a.OrigenDescripcion.NullSafeToString(),
                                a.NumeroRequerimiento.NullSafeToString(),
                                a.FechaRequerimiento.NullSafeToString(),
                                a.NumeroItem.NullSafeToString(),
                                a.Cantidad.NullSafeToString(),
                                a.CantidadPendiente.NullSafeToString(),
                                a.Unidad.NullSafeToString(),
                                a.Codigo.NullSafeToString(),
                                a.Articulo.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.TiposDeDescripcion.NullSafeToString(),
                                a.FechaEntrega.NullSafeToString(),
                                a.Cumplido.NullSafeToString(),
                                a.DescripcionControlCalidad.NullSafeToString(),
                                a.ArchivoAdjunto1.NullSafeToString(),
                                a.ArchivoAdjunto2.NullSafeToString(),
                                a.ArchivoAdjunto3.NullSafeToString(),
                                a.ArchivoAdjunto4.NullSafeToString(),
                                a.ArchivoAdjunto5.NullSafeToString(),
                                a.ArchivoAdjunto6.NullSafeToString(),
                                a.ArchivoAdjunto7.NullSafeToString(),
                                a.ArchivoAdjunto8.NullSafeToString(),
                                a.ArchivoAdjunto9.NullSafeToString(),
                                a.ArchivoAdjunto10.NullSafeToString(),
                                a.Aprobo.NullSafeToString(),
                                a.CircuitoFirmasCompleto.NullSafeToString()
                            }
                        }).ToArray()
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
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult DetRequerimientosSinFormato(int IdRequerimiento)
        {
            var Det = db.DetalleRequerimientos.Where(p => p.IdRequerimiento == IdRequerimiento).AsQueryable();

            var data = (from a in Det
                        select new
                        {
                            IdDetalleRequerimiento = a.IdDetalleRequerimiento,
                            IdRequerimiento = a.IdRequerimiento,
                            IdArticulo = a.IdArticulo,
                            IdUnidad = a.IdUnidad,
                            IdControlCalidad = a.IdControlCalidad,
                            OrigenDescripcion = a.OrigenDescripcion,
                            NumeroItem = a.NumeroItem,
                            Cantidad = a.Cantidad,
                            CantidadPendiente = ((a.Cantidad ?? 0) - (db.DetallePedidos.Where(x => x.IdDetalleRequerimiento == a.IdDetalleRequerimiento && ((x.Cumplido ?? "NO") != "AN")).Sum(z => z.Cantidad) ?? 0)),
                            Unidad = a.Unidad.Abreviatura,
                            Codigo = a.Articulo.Codigo,
                            Articulo = a.Articulo.Descripcion,
                            Observaciones = a.Observaciones,
                            TiposDeDescripcion = (a.OrigenDescripcion ?? 1) == 1 ? "Solo material" : ((a.OrigenDescripcion ?? 1) == 2 ? "Solo observaciones" : ((a.OrigenDescripcion ?? 1) == 3 ? "Material + observaciones" : "")),
                            FechaEntrega = a.FechaEntrega,
                            Cumplido = a.Cumplido,
                            DescripcionControlCalidad = (a.ControlCalidad == null) ? "" : a.ControlCalidad.Descripcion,
                            ArchivoAdjunto1 = a.ArchivoAdjunto1,
                            ArchivoAdjunto2 = a.ArchivoAdjunto2,
                            ArchivoAdjunto3 = a.ArchivoAdjunto3,
                            ArchivoAdjunto4 = a.ArchivoAdjunto4,
                            ArchivoAdjunto5 = a.ArchivoAdjunto5,
                            ArchivoAdjunto6 = a.ArchivoAdjunto6,
                            ArchivoAdjunto7 = a.ArchivoAdjunto7,
                            ArchivoAdjunto8 = a.ArchivoAdjunto8,
                            ArchivoAdjunto9 = a.ArchivoAdjunto9,
                            ArchivoAdjunto10 = a.ArchivoAdjunto10,
                            NumeroRequerimiento = a.Requerimientos.NumeroRequerimiento,
                            NumeroObra = a.Requerimientos.Obra.NumeroObra,
                            PorcentajeIva = a.Articulo.AlicuotaIVA,
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

        public virtual FileResult ImprimirConPlantillaEXE(int id, string DirApp = "", string Tipo = "") //(int id)
        {
            if (DirApp.Length == 0) { 
                DirApp = AppDomain.CurrentDomain.BaseDirectory;
            }
            else
            {
                DirApp = DirApp + "\\";
            }
            
            string SCsinEncriptar = Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService);

            string output = DirApp + "Documentos\\" + "archivo.doc"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';

            string nombrearchivo = "requerimiento.doc";
            if (Tipo == "PDF") { 
                output = DirApp + "Documentos\\" + "archivo.pdf";
                nombrearchivo = "requerimiento.pdf";
            }

            string plantilla = DirApp + "Documentos\\" + "Requerimiento_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";

            System.IO.FileInfo MyFile2 = new System.IO.FileInfo(plantilla);//busca si ya existe el archivo a generar y en ese caso lo borra

            //if (!MyFile2.Exists)
            //{
            //    plantilla = Pronto.ERP.Bll.OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.FacturaA, SC);
            //}

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            //'How to Wait for a Shelled Process to Finish
            //'Get the name of the system folder.
            var sysFolder = Environment.GetFolderPath(Environment.SpecialFolder.System);
            //'Create a new ProcessStartInfo structure.
            var pInfo = new ProcessStartInfo();
            //'Set the file name member of pinfo to Eula.txt in the system folder.
            pInfo.FileName = DirApp + @"bin\Plantillas.exe";

            /*
            // -SC=Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa; Password=.SistemaPronto.;Initial catalog=Pronto;Data Source=serversql3\TESTING;Connect Timeout=45
            // en lugar de este formato, yo mandaba:
            // -SC=Data Source=sqlmvc;Initial catalog=Pronto_Vialagro;User ID=sa; Password=.SistemaPronto.;Connect Timeout=500
                LO QUE NO LE GUSTA ES QUE LE FALTE EL "PROVIDER="
             */
            //SCsinEncriptar = @"Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa; Password=.SistemaPronto.;Initial catalog=Pronto;Data Source=serversql3\TESTING;Connect Timeout=45";
                        
            if (!SCsinEncriptar.ToLower().Contains("provider="))
            {
                SCsinEncriptar +=";Provider=SQLOLEDB.1";
            }

            pInfo.Arguments = @"-Plantilla=" + plantilla + " -SC=" + SCsinEncriptar + @" -Id=" + id + " -FileOut=" + output;

            ErrHandler2.WriteError(pInfo.FileName + " " + pInfo.Arguments);

            //'Start the process.
            pInfo.UseShellExecute = false;
            Process p = Process.Start(pInfo);
            //'Wait for the process window to complete loading.
            p.WaitForInputIdle();
            //'Wait for the process to exit.
            p.WaitForExit();
            //'Continue with the code.
            //MessageBox.Show("Code continuing...");

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, nombrearchivo);
        }

        public virtual FileResult Imprimir(int id) //(int id)
        {
            return ImprimirConPlantillaEXE(id, AppDomain.CurrentDomain.BaseDirectory);

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.doc"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';

            //plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Requerimiento1_Autotrol_PUNTONET.docx";
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Requerimiento_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";
            //edu está usando .dotm para poder usar la exportacion pdf. Lo voy a volver a .dot para probar si el problema en el server viene por ahi
            //string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Requerimiento_" + this.HttpContext.Session["BasePronto"].ToString() + ".dot";

            System.IO.FileInfo MyFile2 = new System.IO.FileInfo(plantilla);//busca si ya existe el archivo a generar y en ese caso lo borra

            if (!MyFile2.Exists)
            {
                plantilla = Pronto.ERP.Bll.OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.FacturaA, SC);
            }

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            //System.IO.File.Copy(plantilla, output); // 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 
            //Pronto.ERP.BO.Requerimiento req = RequerimientoManager.GetItem(SC, id, true);
            //OpenXML_Pronto.RequerimientoXML_DOCX(output, req, SC);

            object nulo = null;
            EntidadManager.ImprimirWordDOT_VersionDLL(plantilla, ref nulo, SC, nulo, ref nulo, id, nulo, nulo, nulo, output, nulo, nulo);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "requerimiento.doc");
        }




        public virtual FileResult ImprimirPDF(int id, String output2 = "") //(int id)
        {
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            string output = "";
            if (output2.Length > 0)
            {
                output = output2;
            }
            else
            {
                output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.pdf"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            }

            //plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Requerimiento1_Autotrol_PUNTONET.docx";
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Requerimiento_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";

            System.IO.FileInfo MyFile2 = new System.IO.FileInfo(plantilla);//busca si ya existe el archivo a generar y en ese caso lo borra

            if (!MyFile2.Exists)
            {
                plantilla = Pronto.ERP.Bll.OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.FacturaA, SC);
            }

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            //System.IO.File.Copy(plantilla, output); // 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 
            //Pronto.ERP.BO.Requerimiento req = RequerimientoManager.GetItem(SC, id, true);
            //OpenXML_Pronto.RequerimientoXML_DOCX(output, req, SC);

            object nulo = null;
            EntidadManager.ImprimirWordDOT_VersionDLL_PDF(plantilla, ref nulo, SC, nulo, ref nulo, id, nulo, nulo, nulo, output, nulo, nulo);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "requerimiento.pdf");
        }

        public string EnviarEmail(String IdsRequerimiento, String IdsProveedor)
        {
            string NumeroRequerimiento = "";
            string output = "";
            string destinatario = "";
            string asunto = "RM";
            string cuerpo = "";
            string De = "";
            string resul = "";
            int IdRequerimiento;
            int IdProveedor;

            var Empresa = db.Empresas.Where(p => p.IdEmpresa == 1).FirstOrDefault();
            if (Empresa != null) { De = Empresa.Email.ToString(); }

            Char delimiter = '|';
            String[] Vector1 = IdsRequerimiento.Split(delimiter);
            String[] Vector2 = IdsProveedor.Split(delimiter);

            foreach (var valor1 in Vector1)
            {
                if (valor1.Length > 0)
                {
                    IdRequerimiento = Int32.Parse(valor1);
                    var Requerimiento = db.Requerimientos.Where(p => p.IdRequerimiento == IdRequerimiento).FirstOrDefault();
                    if (Requerimiento != null)
                    {
                        NumeroRequerimiento = Requerimiento.NumeroRequerimiento.ToString();
                        output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Requerimiento_" + NumeroRequerimiento + ".pdf"; ;
                    }
                    ImprimirPDF(IdRequerimiento, output).ToString();

                    foreach (var valor2 in Vector2)
                    {
                        if (valor2.Length > 0)
                        {
                            IdProveedor = Int32.Parse(valor2);

                            var Proveedor = db.Proveedores.Where(p => p.IdProveedor == IdProveedor).FirstOrDefault();
                            if (Proveedor != null)
                            {
                                destinatario = Proveedor.Email ?? "";
                            }

                            if (destinatario.Length > 0 && output.Length > 0 && De.Length > 0)
                            {
                                if (EntidadManager.MandaEmail_Nuevo(destinatario,
                                                                    asunto,
                                                                    cuerpo,
                                                                    De,
                                                                    ConfigurationManager.AppSettings["SmtpServer"],
                                                                    ConfigurationManager.AppSettings["SmtpUser"],
                                                                    ConfigurationManager.AppSettings["SmtpPass"],
                                                                    output,
                                                                    Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]))
                                    )
                                {
                                    resul = "Ok";
                                }
                                else
                                {
                                    resul = "Error";
                                }
                            }
                            else
                            {
                                resul = "Error";
                            }
                        }
                    }
                    FileInfo MyFile1 = new FileInfo(output);
                    if (MyFile1.Exists)
                    {
                        System.GC.Collect();
                        System.GC.WaitForPendingFinalizers();
                        System.IO.File.Delete(output);
                        //MyFile1.Delete();
                    }
                }
            }

            return resul;
        }

        void TraerFirmas(ref Requerimiento myRM)
        {
        }

        public JsonResult AsignaComprador(List<int> idDetalleRequerimientos, string userComprador, string passComprador)
        {
            int mvarIdComprador = db.Empleados.Where(x => x.Nombre == userComprador).Select(x => x.IdEmpleado).First();

            string usuario = oStaticMembershipService.GetUser().UserName;
            int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

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
            }

            db.SaveChanges();

            return Json(null, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DarPorCumplido(List<int> idDetalleRequerimientos, string userAutorizador, string passAutorizador, string userCumplidor, string sObsCumplido)
        {
            int mvarIdDioPorCumplido = db.Empleados.Where(x => x.Nombre == userCumplidor).Select(x => x.IdEmpleado).First();
            int mvarIdAutorizo = db.Empleados.Where(x => x.Nombre == userAutorizador).Select(x => x.IdEmpleado).First();

            DataTable oRs1;
            bool mvarOK;
            string mAux1;

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
            }
            return Json(null, JsonRequestBehavior.AllowGet);
        }







        public JsonResult GenerarValesAlmacen(List<int> idDetalleRequerimientos, string user, string pass)
        {
            bool mvarOK;
            long mvarIdAutorizo;

            DataTable oRs;

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

            if (user.Length > 0) { vale.Aprobo = db.Empleados.Where(x => x.Nombre == user).Select(x => x.IdEmpleado).First(); }
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

        public virtual JsonResult MarcarRM_Impresa(int IdRequerimiento, string Marca)
        {
            string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            EntidadManager.Tarea(nSC, "Requerimientos_RegistrarImpresion", IdRequerimiento, Marca, "", "", "");
            return Json(new { Success = 1, IdRequerimiento = IdRequerimiento, ex = "" });
        }

        public virtual FileResult ArchivosAdjuntos(String filename = "")
        {
            //string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Requerimiento_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";
            string plantilla = Path.Combine(Server.MapPath("~/Adjuntos"), filename);

            System.IO.FileInfo MyFile2 = new System.IO.FileInfo(plantilla);

            //if (!MyFile2.Exists)
            //{
            //    plantilla = Pronto.ERP.Bll.OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.FacturaA, SC);
            //}

            byte[] contents = System.IO.File.ReadAllBytes(plantilla);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, filename);
        }

        public JsonResult ValidarAnulacion(int IdRequerimiento)
        {
            string Errores = "";

            var regs = db.DetalleRequerimientos.Where(x => x.IdRequerimiento == IdRequerimiento).ToList();

            foreach (Data.Models.DetalleRequerimiento det in regs)
            {
                if ((det.Cumplido ?? "NO") != "NO")
                {
                    Errores = Errores + "[ " + det.NumeroItem.ToString() + " ] ";
                }
            }
            return Json(Errores, JsonRequestBehavior.AllowGet);
        }


    }
}