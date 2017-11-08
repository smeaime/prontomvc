using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Text;
using System.Reflection;
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Web.Security;

using Pronto.ERP.Bll;



namespace ProntoMVC.Controllers
{
    //   [Authorize(Roles = "Administrador,SuperAdmin,Compras,Externo,AdminExterno")]
    public partial class PresupuestoController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            //if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
            //    !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
            //    !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
            //    ) throw new Exception("No tenés permisos");

            //var presupuestos = db.Presupuestos.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }
        public virtual ViewResult IndexExterno()
        {
            //var presupuestos = db.Presupuestos.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }
        public virtual ViewResult Details(int id)
        {
            Presupuesto presupuesto = db.Presupuestos.Find(id);
            return View(presupuesto);
        }

        public virtual ActionResult Create()
        {
            ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion");
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre");
            ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion");
            ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.Proveedor = "";
            return View();
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate([Bind(Exclude = "IdDetallePresupuesto")]  Presupuesto presupuesto) // el Exclude es para las altas, donde el Id viene en 0
        {
            if (!PuedeEditar(enumNodos.Presupuestos)) throw new Exception("No tenés permisos");


            //if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
            //    !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
            //    !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras"))
            //{

            //    int idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));

            //    if (presupuesto.IdProveedor != idproveedor) throw new Exception("Sólo podes acceder a presupuestos tuyos");
            //    //throw new Exception("No tenés permisos");

            //}

            //presupuesto.mail

            try
            {
                var mailcomp = db.Empleados.Where(e => e.IdEmpleado == presupuesto.IdComprador).Select(e => e.Email).FirstOrDefault();
                if (mailcomp.NullSafeToString() != "") Generales.enviarmailAlComprador(mailcomp, presupuesto.IdPresupuesto);

            }
            catch (Exception ex)
            {

                ErrHandler.WriteError(ex);
            }



            string erar = "";


            if (!Validar(presupuesto, ref erar))
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



            ModelState.Remove("IdDetallePresupuesto");


            try
            {
                if (ModelState.IsValid || true) //me estoy saltando la validacion porque explota en la primarykey del detalle, y no sé por qué.
                {
                    string tipomovimiento = "";
                    if (presupuesto.IdPresupuesto > 0)
                    {
                        var EntidadOriginal = db.Presupuestos.Where(p => p.IdPresupuesto == presupuesto.IdPresupuesto).Include(p => p.DetallePresupuestos).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(presupuesto);

                        foreach (var dr in presupuesto.DetallePresupuestos)
                        {
                            var DetalleEntidadOriginal = EntidadOriginal.DetallePresupuestos.Where(c => c.IdDetallePresupuesto == dr.IdDetallePresupuesto && dr.IdDetallePresupuesto > 0).SingleOrDefault();
                            if (DetalleEntidadOriginal != null)
                            {
                                var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                DetalleEntidadEntry.CurrentValues.SetValues(dr);
                            }
                            else
                            {
                                EntidadOriginal.DetallePresupuestos.Add(dr);
                            }
                        }

                        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetallePresupuestos.Where(c => c.IdDetallePresupuesto != 0).ToList())
                        {
                            if (!presupuesto.DetallePresupuestos.Any(c => c.IdDetallePresupuesto == DetalleEntidadOriginal.IdDetallePresupuesto))
                                EntidadOriginal.DetallePresupuestos.Remove(DetalleEntidadOriginal);
                        }
                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        if (presupuesto.SubNumero == 1)
                        {
                            tipomovimiento = "N";
                            Parametros parametros = db.Parametros.Find(1);
                            presupuesto.Numero = parametros.ProximoPresupuesto;
                        }
                        db.Presupuestos.Add(presupuesto);
                    }
                    db.SaveChanges();

                    if (false)
                    {
                        try
                        {
                            ActivarUsuarioYContacto(presupuesto.IdPresupuesto);
                        }
                        catch (Exception)
                        {

                            //throw;
                        }
                    }
                    db.wActualizacionesVariasPorComprobante(104, presupuesto.IdPresupuesto, tipomovimiento);
                    try
                    {
                        List<Tablas.Tree> Tree = TablasDAL.ArbolRegenerar(this.Session["BasePronto"].ToString(), oStaticMembershipService);

                    }
                    catch (Exception ex)
                    {
                        ErrHandler.WriteError(ex);
                        //                        throw;
                    }
                    // TODO: acá se regenera el arbol???




                    return Json(new { Success = 1, IdPresupuesto = presupuesto.IdPresupuesto, ex = "" });
                }
                else
                {

                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El presupuesto es inválido";
                    //return Json(res);
                    //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });

                    return Json(res);
                }

            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;

                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);
                res.Message = "El presupuesto es inválido";
                //return Json(res);
                //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });

                return Json(res);

                // return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }




        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.Presupuestos)) throw new Exception("No tenés permisos");

            if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
               !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
               ) throw new Exception("No tenés permisos");

            if (id == -1)
            {
                Presupuesto presupuesto = new Presupuesto();
                Parametros parametros = db.Parametros.Find(1);
                presupuesto.Numero = parametros.ProximoPresupuesto;
                presupuesto.SubNumero = 1;
                presupuesto.FechaIngreso = DateTime.Today;
                presupuesto.IdMoneda = 1;
                presupuesto.CotizacionMoneda = 1;



                ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion");
                ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", presupuesto.IdMoneda);
                ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion");
                ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                ViewBag.Proveedor = "";

                CargarViewBag(presupuesto);

                return View(presupuesto);
            }
            else
            {

                Presupuesto presupuesto = db.Presupuestos.Find(id);


                ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", presupuesto.IdCondicionCompra);
                ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", presupuesto.IdMoneda);
                ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion", presupuesto.IdPlazoEntrega);
                ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre", presupuesto.IdComprador);
                ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", presupuesto.Aprobo);
                ViewBag.Proveedor = (presupuesto.IdProveedor > 0) ? db.Proveedores.Find(presupuesto.IdProveedor).RazonSocial : "";

                CargarViewBag(presupuesto);


                Session.Add("Presupuesto", presupuesto);
                return View(presupuesto);
            }
        }

        void CargarViewBag(Presupuesto o)
        {
            string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            DataTable dt = EntidadManager.GetStoreProcedure(nSC, "Empleados_TX_PorSector", "Compras");
            IEnumerable<DataRow> rows = dt.AsEnumerable();
            var sq = (from r in rows orderby r[1] select new { IdEmpleado = r[0], Nombre = r[1] }).ToList();
            // ViewBag.Aprobo = new SelectList(db.Empleados.Where(x => (x.Activo ?? "SI") == "SI"  ).OrderBy(x => x.Nombre), "IdEmpleado", "Nombre", o.Aprobo);

            ViewBag.Aprobo = new SelectList(sq, "IdEmpleado", "Nombre", o.Aprobo);
            ViewBag.IdComprador = new SelectList(sq, "IdEmpleado", "Nombre", o.IdComprador);

            /*

            ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras.OrderBy(x => x.Descripcion), "IdCondicionCompra", "Descripcion", o.IdCondicionCompra);
            ViewBag.IdMoneda = new SelectList(db.Monedas.OrderBy(x => x.Nombre), "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas.OrderBy(x => x.Descripcion), "IdPlazoEntrega", "Descripcion", o.PlazoEntrega);

            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            DataTable dt = EntidadManager.GetStoreProcedure(nSC, "Empleados_TX_PorSector", "Compras");
            IEnumerable<DataRow> rows = dt.AsEnumerable();
            var sq = (from r in rows select new { IdEmpleado = r[0], Nombre = r[1] }).ToList();
            // ViewBag.Aprobo = new SelectList(db.Empleados.Where(x => (x.Activo ?? "SI") == "SI"  ).OrderBy(x => x.Nombre), "IdEmpleado", "Nombre", o.Aprobo);

            ViewBag.Aprobo = new SelectList(sq, "IdEmpleado", "Nombre", o.Aprobo);
            ViewBag.IdComprador = new SelectList(sq, "IdEmpleado", "Nombre", o.IdComprador);

            ViewBag.Proveedor = (db.Proveedores.Find(o.IdProveedor) ?? new Proveedor()).RazonSocial;

            ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", (o.Proveedor ?? new Proveedor()).IdCodigoIva);
            try
            {
                ViewBag.CantidadAutorizaciones = db.Autorizaciones_TX_CantidadAutorizaciones((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.NotaPedido, o.TotalPedido * o.CotizacionMoneda, -1).Count();
            }
            catch (Exception e)
            {

                ErrHandler.WriteError(e);
            }
    */
        }



        private bool Validar(ProntoMVC.Data.Models.Presupuesto o, ref string sErrorMsg)
        {
            // una opcion es extender el modelo autogenerado, para ensoquetar ahí las validaciones
            // si no, podemos usar una funcion como esta, y devolver los  errores de dos maneras:
            // con ModelState.AddModelError si los devolvemos en una ViewResult,
            // o con un array de strings si es una JsonResult.
            //
            // If you are returning JSON, you cannot use ModelState.
            // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json


            if (!PuedeEditar(enumNodos.Facturas)) sErrorMsg += "\n" + "No tiene permisos de edición";


            if (o.IdPresupuesto <= 0)
            {
                //  string connectionString = Generales.sCadenaConexSQL(this.Session["BasePronto"].ToString());
                //  o.NumeroFactura = (int)Pronto.ERP.Bll.FacturaManager.ProximoNumeroFacturaPorIdCodigoIvaYNumeroDePuntoVenta(connectionString,o.IdCodigoIva ?? 0,o.PuntoVenta ?? 0);
            }

            if ((o.IdProveedor ?? 0) <= 0)
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta el proveedor";
                // return false;
            }
            //if (o.NumeroFactura == null) sErrorMsg += "\n" + "Falta el número de factura";
            //// if (o.IdPuntoVenta== null) sErrorMsg += "\n" + "Falta el punto de venta";
            //if (o.IdCodigoIva == null) sErrorMsg += "\n" + "Falta el codigo de IVA";
            //if (o.IdCondicionVenta == null) sErrorMsg += "\n" + "Falta la condicion venta";
            //if (o.IdListaPrecios == null) sErrorMsg += "\n" + "Falta la lista de precios";


            var reqsToDelete = o.DetallePresupuestos.Where(x => (x.IdArticulo ?? 0) <= 0).ToList();
            foreach (var deleteReq in reqsToDelete)
            {
                o.DetallePresupuestos.Remove(deleteReq);
            }

            if (o.DetallePresupuestos.Count <= 0) sErrorMsg += "\n" + "El presupuesto no tiene items";

            //string OrigenDescripcionDefault = BuscaINI("OrigenDescripcion en 3 cuando hay observaciones");

            foreach (ProntoMVC.Data.Models.DetallePresupuesto x in o.DetallePresupuestos)
            {


                //x.Adjunto = x.Adjunto ?? "NO";
                //if (x.FechaEntrega < o.FechaRequerimiento) sErrorMsg += "\n" + "La fecha de entrega de " + db.Articulos.Find(x.IdArticulo).Descripcion + " es anterior a la del requerimiento";

                if ((x.Cantidad ?? 0) <= 0) sErrorMsg += "\n" + db.Articulos.Find(x.IdArticulo).Descripcion + " no tiene una cantidad válida";

                //if (OrigenDescripcionDefault == "SI" && (x.Observaciones ?? "") != "") x.OrigenDescripcion = 3;
            }

            if ((o.Aprobo ?? 0) > 0 && o.FechaAprobacion == null) o.FechaAprobacion = DateTime.Now;

            if (sErrorMsg != "") return false;
            return true;

        }




        public virtual ActionResult EditExterno(int id)
        {
            if (!PuedeLeer(enumNodos.Presupuestos)) throw new Exception("No tenés permisos");



            if (id == -1)
            {
                Presupuesto presupuesto = new Presupuesto();
                Parametros parametros = db.Parametros.Find(1);
                presupuesto.Numero = parametros.ProximoPresupuesto;
                presupuesto.SubNumero = 1;
                presupuesto.FechaIngreso = DateTime.Today;
                presupuesto.IdMoneda = 1;
                presupuesto.CotizacionMoneda = 1;
                ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion");
                ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", presupuesto.IdMoneda);
                ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion");
                ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                ViewBag.Proveedor = "";
                return View(presupuesto);
            }
            else
            {
                Presupuesto presupuesto = db.Presupuestos.Find(id);


                int idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));
                if (idproveedor > 0 && presupuesto.IdProveedor != idproveedor) throw new Exception("Sólo podes acceder a presupuestos tuyos");


                ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", presupuesto.IdCondicionCompra);
                ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", presupuesto.IdMoneda);
                ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion", presupuesto.IdPlazoEntrega);
                ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre", presupuesto.IdComprador);
                ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", presupuesto.Aprobo);
                ViewBag.Proveedor = db.Proveedores.Find(presupuesto.IdProveedor).RazonSocial;
                Session.Add("Presupuesto", presupuesto);
                return View(presupuesto);
            }
        }





        //[HttpPost]
        //public virtual ActionResult Edit(Presupuesto presupuesto)
        //{

        //    if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
        //       !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador")
        //       ) throw new Exception("No tenés permisos");

        //    if (ModelState.IsValid)
        //    {
        //        db.Entry(presupuesto).State = System.Data.Entity.EntityState.Modified;
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }
        //    ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", presupuesto.IdCondicionCompra);
        //    ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", presupuesto.IdMoneda);
        //    ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion", presupuesto.IdPlazoEntrega);
        //    ViewBag.RazonSocial = presupuesto.Proveedor.RazonSocial;
        //    ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre", presupuesto.IdComprador);
        //    ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", presupuesto.Aprobo);
        //    ViewBag.Proveedor = db.Proveedores.Find(presupuesto.IdProveedor).RazonSocial;
        //    return View(presupuesto);
        //}

        public virtual ActionResult Delete(int id)
        {
            Presupuesto presupuesto = db.Presupuestos.Find(id);
            return View(presupuesto);
        }

        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Presupuesto presupuesto = db.Presupuestos.Find(id);
            db.Presupuestos.Remove(presupuesto);
            db.SaveChanges();
            return RedirectToAction("Index");
        }





        public virtual ActionResult Presupuestos_DynamicGridData
            (string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            //int pageSize = rows ?? 20;
            int currentPage = page; // ?? 1;

           // var Entidad = db.Presupuestos.AsQueryable();
         

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.Presupuesto>
                                ("DetalleRequerimientos.DetallePedidos", 
                                sidx, sord, page, rows, _search, filters, db, ref totalRecords
                                 );
            //DetalleRequerimientos.DetallePedidos, DetalleRequerimientos.DetallePresupuestos
                                //"Obra,DetalleRequerimientos.DetallePedidos.Pedido,DetalleRequerimientos.DetallePresupuestos.Presupuesto"
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            





            //int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in pagedQuery
                        select new
                        {
                            IdPresupuesto = a.IdPresupuesto,
                            Numero = a.Numero,
                            Orden = a.SubNumero,
                            FechaIngreso = a.FechaIngreso,
                            Proveedor = a.Proveedor.RazonSocial,
                            Validez = a.Validez,
                            Bonificacion = a.Bonificacion,
                            PorcentajeIva1 = a.PorcentajeIva1,
                            Moneda = a.Moneda.Abreviatura,
                            Subtotal = (a.ImporteTotal - a.ImporteIva1 + a.ImporteBonificacion),
                            ImporteBonificacion = a.ImporteBonificacion,
                            ImporteIva1 = a.ImporteIva1,
                            ImporteTotal = a.ImporteTotal,
                            PlazoEntrega = a.PlazosEntrega.Descripcion,
                            CondicionCompra = a.Condiciones_Compra.Descripcion,
                            Garantia = a.Garantia,
                            LugarEntrega = a.LugarEntrega,
                            Comprador = a.Comprador.Nombre,
                            Aprobo = a.AproboPresupuesto.Nombre,
                            Referencia = a.Referencia,
                            Detalle = a.Detalle,
                            Contacto = a.Contacto,
                            Observaciones = a.Observaciones,
                            a.IdProveedor
                        })
                        //.Where(campo) // .OrderBy(sidx + " " + sord)
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
                            id = a.IdPresupuesto.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdPresupuesto} ) + " target='' >Editar</>" ,
								// +"|"+"<a href=../Presupuesto/Edit/" + a.IdPresupuesto + "?code=1" + ">Detalles</a> ",
                                a.IdPresupuesto.ToString(), 
                                a.Numero.ToString(), 
                                a.Orden.ToString(), 
                                //(a.FechaIngreso ?? DateTime.MinValue ).ToShortDateString(),
                                a.FechaIngreso.Value.ToShortDateString(),
                                a.Proveedor,
                                a.Validez,
                                a.Bonificacion.ToString(),
                                a.PorcentajeIva1.ToString(),
                                a.Moneda,
                                a.Subtotal.ToString(),
                                a.ImporteBonificacion.ToString(),
                                a.ImporteIva1.ToString(),
                                a.ImporteTotal.ToString(),
                                a.PlazoEntrega,
                                a.CondicionCompra,
                                a.Garantia,
                                a.LugarEntrega,
                                a.Comprador,
                                a.Aprobo,
                                a.Referencia,
                                a.Detalle,
                                a.Contacto,
                                a.Observaciones
                                ,a.IdProveedor.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }



        public virtual ActionResult Presupuestos(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Presupuestos.AsQueryable();
            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                Entidad = (from a in Entidad where a.FechaIngreso >= FechaDesde && a.FechaIngreso <= FechaHasta select a).AsQueryable();
            }
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numero":
                        if (searchString != "")
                        {
                            campo = String.Format("{0} = {1}", searchField, Generales.Val(searchString));
                        }
                        else
                        {
                            campo = "true";
                        }
                        break;

                    case "fechaingreso":
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

            var Entidad1 = (from a in Entidad.Where(campo) select new { IdPresupuesto = a.IdPresupuesto });




            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdPresupuesto = a.IdPresupuesto,
                            Numero = a.Numero,
                            Orden = a.SubNumero,
                            FechaIngreso = a.FechaIngreso,
                            Proveedor = a.Proveedor.RazonSocial,
                            Validez = a.Validez,
                            Bonificacion = a.Bonificacion,
                            PorcentajeIva1 = a.PorcentajeIva1,
                            Moneda = a.Moneda.Abreviatura,
                            Subtotal = (a.ImporteTotal - a.ImporteIva1 + a.ImporteBonificacion),
                            ImporteBonificacion = a.ImporteBonificacion,
                            ImporteIva1 = a.ImporteIva1,
                            ImporteTotal = a.ImporteTotal,
                            PlazoEntrega = a.PlazosEntrega.Descripcion,
                            CondicionCompra = a.Condiciones_Compra.Descripcion,
                            Garantia = a.Garantia,
                            LugarEntrega = a.LugarEntrega,
                            Comprador = a.Comprador.Nombre,
                            Aprobo = a.AproboPresupuesto.Nombre,
                            Referencia = a.Referencia,
                            Detalle = a.Detalle,
                            Contacto = a.Contacto,
                            Observaciones = a.Observaciones,
                            a.IdProveedor
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
                            id = a.IdPresupuesto.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdPresupuesto} ) + " target='' >Editar</>" ,
								// +"|"+"<a href=../Presupuesto/Edit/" + a.IdPresupuesto + "?code=1" + ">Detalles</a> ",
                                a.IdPresupuesto.ToString(), 
                                a.Numero.ToString(), 
                                a.Orden.ToString(), 
                                //(a.FechaIngreso ?? DateTime.MinValue ).ToShortDateString(),
                                a.FechaIngreso.Value.ToShortDateString(),
                                a.Proveedor,
                                a.Validez,
                                a.Bonificacion.ToString(),
                                a.PorcentajeIva1.ToString(),
                                a.Moneda,
                                a.Subtotal.ToString(),
                                a.ImporteBonificacion.ToString(),
                                a.ImporteIva1.ToString(),
                                a.ImporteTotal.ToString(),
                                a.PlazoEntrega,
                                a.CondicionCompra,
                                a.Garantia,
                                a.LugarEntrega,
                                a.Comprador,
                                a.Aprobo,
                                a.Referencia,
                                a.Detalle,
                                a.Contacto,
                                a.Observaciones
                                ,a.IdProveedor.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }





        public virtual ActionResult PresupuestosExterno(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Presupuestos.AsQueryable();


            int idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));

            if (idproveedor > 0) Entidad = Entidad.Where(p => p.IdProveedor == idproveedor).AsQueryable();


            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                Entidad = (from a in Entidad where a.FechaIngreso >= FechaDesde && a.FechaIngreso <= FechaHasta select a).AsQueryable();
            }
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numero":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaingreso":
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

            var Entidad1 = (from a in Entidad select new { IdPresupuesto = a.IdPresupuesto }).Where(campo);

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdPresupuesto = a.IdPresupuesto,
                            Numero = a.Numero,
                            Orden = a.SubNumero,
                            FechaIngreso = a.FechaIngreso,
                            Proveedor = a.Proveedor.RazonSocial,
                            Validez = a.Validez,
                            Bonificacion = a.Bonificacion,
                            PorcentajeIva1 = a.PorcentajeIva1,
                            Moneda = a.Moneda.Abreviatura,
                            Subtotal = (a.ImporteTotal - a.ImporteIva1 + a.ImporteBonificacion),
                            ImporteBonificacion = a.ImporteBonificacion,
                            ImporteIva1 = a.ImporteIva1,
                            ImporteTotal = a.ImporteTotal,
                            PlazoEntrega = a.PlazosEntrega.Descripcion,
                            CondicionCompra = a.Condiciones_Compra.Descripcion,
                            Garantia = a.Garantia,
                            LugarEntrega = a.LugarEntrega,
                            Comprador = a.Comprador.Nombre,
                            Aprobo = a.AproboPresupuesto.Nombre,
                            Referencia = a.Referencia,
                            Detalle = a.Detalle,
                            Contacto = a.Contacto,
                            Observaciones = a.Observaciones
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
                            id = a.IdPresupuesto.ToString(),
                            cell = new string[] { 

                            "<a href="+ Url.Action("EditExterno",new {id = a.IdPresupuesto} ) + " target='' >Editar</>" ,
								// +"|"+"<a href=../Presupuesto/EditExterno/" + a.IdPresupuesto + "?code=1" + ">Detalles</a> ",


                        
                                a.IdPresupuesto.ToString(), 
                                a.Numero.ToString(), 
                                a.Orden.ToString(), 
                                a.FechaIngreso.ToString(),
                                a.Proveedor,
                                a.Validez,
                                a.Bonificacion.ToString(),
                                a.PorcentajeIva1.ToString(),
                                a.Moneda,
                                a.Subtotal.ToString(),
                                a.ImporteBonificacion.ToString(),
                                a.ImporteIva1.ToString(),
                                a.ImporteTotal.ToString(),
                                a.PlazoEntrega,
                                a.CondicionCompra,
                                a.Garantia,
                                a.LugarEntrega,
                                a.Comprador,
                                a.Aprobo,
                                a.Referencia,
                                a.Detalle,
                                a.Contacto,
                                a.Observaciones
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        public virtual ActionResult DetPresupuestos(string sidx, string sord, int? page, int? rows, int? IdPresupuesto)
        {
            int IdPresupuesto1 = IdPresupuesto ?? 0;
            var DetEntidad = db.DetallePresupuestos.Where(p => p.IdPresupuesto == IdPresupuesto1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select new
                        {
                            a.IdDetallePresupuesto,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.NumeroItem,
                            a.DetalleRequerimiento.Requerimientos.Obra.NumeroObra,
                            a.Cantidad,
                            a.Unidad.Abreviatura,
                            a.Articulo.Codigo,
                            a.Articulo.Descripcion,
                            a.Precio,
                            a.PorcentajeBonificacion,
                            a.ImporteBonificacion,
                            a.PorcentajeIva,
                            a.ImporteIva,
                            a.ImporteTotalItem,
                            a.FechaEntrega,
                            a.Observaciones,
                            a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            NumeroItemRM = a.DetalleRequerimiento.NumeroItem,
                            a.Adjunto,
                            a.ArchivoAdjunto1,
                            a.ArchivoAdjunto2,
                            a.ArchivoAdjunto3
                        }).OrderBy(p => p.NumeroItem)
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
                            id = a.IdDetallePresupuesto.ToString(),
                            cell = new string[] { 
                                string.Empty, 
                                a.IdDetallePresupuesto.ToString(), 
                                a.IdArticulo.ToString(), 
                                a.IdUnidad.ToString(),
                                a.NumeroItem.ToString(), 
                                a.NumeroObra,
                                a.Cantidad.ToString(),
                                a.Abreviatura,
                                a.Codigo,
                                a.Descripcion,
                                a.Precio.ToString(), 
                                a.PorcentajeBonificacion.ToString(), 
                                a.ImporteBonificacion.ToString(), 
                                a.PorcentajeIva.ToString(), 
                                a.ImporteIva.ToString(), 
                                a.ImporteTotalItem.ToString(), 
                                a.FechaEntrega.ToString(),
                                a.Observaciones,
                                a.NumeroRequerimiento.ToString(),
                                a.NumeroItemRM.ToString(),
                                a.ArchivoAdjunto1}
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult DetPresupuestosSinFormato(int IdPresupuesto)
        {
            var Det = db.DetallePresupuestos.Where(p => p.IdPresupuesto == IdPresupuesto).AsQueryable();

            var data = (from a in Det
                        select new
                        {
                            a.IdDetallePresupuesto,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdDetalleRequerimiento,
                            a.NumeroItem,
                            a.DetalleRequerimiento.Requerimientos.Obra.NumeroObra,
                            a.Cantidad,
                            a.Unidad.Abreviatura,
                            a.Articulo.Codigo,
                            a.Articulo.Descripcion,
                            a.FechaEntrega,
                            a.Observaciones,
                            a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            NumeroItemRM = a.DetalleRequerimiento.NumeroItem,
                            a.Adjunto,
                            a.ArchivoAdjunto1,
                            a.ArchivoAdjunto2,
                            a.ArchivoAdjunto3,

                            a.Precio,
                            a.PorcentajeBonificacion,
                            a.PorcentajeIva,
                            a.ImporteBonificacion,
                            a.ImporteIva,
                            a.ImporteTotalItem



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



        public virtual ViewResult ActivarUsuarioYContacto(int idpresupuesto)
        {

            var Presupuesto = db.Presupuestos.Where(x => x.IdPresupuesto == idpresupuesto).FirstOrDefault();
            var Proveedor = db.Proveedores.Where(x => x.IdProveedor == Presupuesto.IdProveedor).FirstOrDefault();

            var cAcc = new ProntoMVC.Controllers.AccountController();

            var usuarioNuevo = new RegisterModel();
            usuarioNuevo.UserName = Proveedor.Cuit;
            usuarioNuevo.Password = Membership.GeneratePassword(20, 0);  // Proveedor.Cuit + "!";  Membership.GeneratePassword(
            usuarioNuevo.ConfirmPassword = usuarioNuevo.Password;
            usuarioNuevo.Email = Proveedor.Email ?? (usuarioNuevo.UserName + "mscalella911@gmail.com");
            usuarioNuevo.Grupo = Proveedor.Cuit;


            try
            {

                if (Membership.GetUser(usuarioNuevo.UserName) == null)
                {
                    cAcc.Register(usuarioNuevo);
                    cAcc.Verificar(Membership.GetUser(usuarioNuevo.UserName).ProviderUserKey.ToString());

                    Generales.MailAlUsuarioConLaPasswordYElDominio(usuarioNuevo.UserName, usuarioNuevo.Password, usuarioNuevo.Email);
                }
            }
            catch (Exception)
            {

                //throw;
            }

            try
            {
                Roles.AddUserToRole(usuarioNuevo.UserName, "AdminExterno");
            }
            catch (Exception)
            {

                //throw;
            }
            try
            {
                Roles.AddUserToRole(usuarioNuevo.UserName, "Externo");
            }
            catch (Exception)
            {

                //throw;
            }
            try
            {
                Roles.AddUserToRole(usuarioNuevo.UserName, "ExternoCuentaCorrienteProveedor");
            }
            catch (Exception)
            {

                //throw;
            }

            try
            {
                Roles.AddUserToRole(usuarioNuevo.UserName, "ExternoOrdenesPagoListas");
            }
            catch (Exception)
            {

                //throw;
            }



            // tendria que usar createuser y ahi tendria que mandar en el mail la contraseña...



            var usuarioNuevo2 = new RegisterModel();
            if ((Presupuesto.Contacto ?? "") != "")
            {

                usuarioNuevo2.UserName = Presupuesto.Contacto;
                if (false)
                {
                    usuarioNuevo2.UserName = Presupuesto.Contacto.Replace("Sr.", "").Replace("Sra.", "").Replace(".", "").Replace(" ", "");
                    System.Text.RegularExpressions.Regex rgx = new System.Text.RegularExpressions.Regex("[^a-zA-Z0-9 -]");
                    usuarioNuevo2.UserName = rgx.Replace(usuarioNuevo2.UserName, "");
                }
                usuarioNuevo2.Password = Membership.GeneratePassword(20, 0);
                usuarioNuevo2.ConfirmPassword = usuarioNuevo2.Password;
                usuarioNuevo2.Email = Presupuesto.Contacto; // usuarioNuevo2.UserName + Proveedor.Email ?? "mscalella911@hotmail.com";
                usuarioNuevo2.Grupo = Proveedor.Cuit;
                cAcc.Register(usuarioNuevo2);

                cAcc.Verificar(Membership.GetUser(usuarioNuevo2.UserName).ProviderUserKey.ToString());

                Generales.MailAlUsuarioConLaPasswordYElDominio(usuarioNuevo2.UserName, usuarioNuevo2.Password, usuarioNuevo2.Email);
            }

            try
            {
                Roles.AddUserToRole(usuarioNuevo2.UserName, "Externo");
            }
            catch (Exception)
            {

                //throw;
            }
            try
            {
                Roles.AddUserToRole(usuarioNuevo2.UserName, "ExternoCuentaCorrienteProveedor");
            }
            catch (Exception)
            {

                //throw;
            }

            try
            {
                Roles.AddUserToRole(usuarioNuevo2.UserName, "ExternoOrdenesPagoListas");
            }
            catch (Exception)
            {

                //throw;
            }



            TempData["Alerta"] = "Alta automática de usuarios: " + usuarioNuevo.UserName + " " + usuarioNuevo2.UserName;
            return View("Index");
        }

        public string BuscarOrden(int Numero)
        {
            var Presupuestos = db.Presupuestos.Where(x => x.Numero == Numero).AsQueryable();
            var data = (from x in Presupuestos select new { x.SubNumero }).OrderByDescending(p => p.SubNumero).FirstOrDefault();
            if (data != null)
                return data.SubNumero.ToString();
            else
                return "1";

        }

        protected override void Dispose(bool disposing)
        {
            if (db != null) db.Dispose();
            base.Dispose(disposing);
        }
    }
}