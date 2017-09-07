using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using Pronto.ERP.Bll;

// using ProntoMVC.Controllers.Logica;

using mercadopago;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace ProntoMVC.Controllers
{
    public partial class OrdenCompraController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.OrdenesCompra)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult Edit(int id)
        {
            OrdenesCompra o;

            try
            {
                if (!PuedeLeer(enumNodos.OrdenesCompra))
                {
                    o = new OrdenesCompra();
                    CargarViewBag(o);
                    ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                    return View(o);
                }
            }
            catch (Exception)
            {
                o = new OrdenesCompra();
                CargarViewBag(o);
                ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                return View(o);
            }

            if (id <= 0)
            {
                o = new OrdenesCompra();
                inic(ref o);
                CargarViewBag(o);
                return View(o);
            }
            else
            {
                o = db.OrdenesCompras.Include(x => x.DetalleOrdenesCompras).Include(x => x.Cliente).SingleOrDefault(x => x.IdOrdenCompra == id);
                CargarViewBag(o);
                Session.Add("OrdenCompra", o);
                return View(o);
            }
        }

        void CargarViewBag(OrdenesCompra o)
        {
            ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.Aprobo);
            //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion");
            ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", o.IdObra);
            ViewBag.IdListaPrecios = new SelectList(db.ListasPrecios, "IdListaPrecios", "Descripcion", o.IdListaPrecios);
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdCondicionVenta = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionVenta);
            //Parametros parametros = db.Parametros.Find(1);
            //ViewBag.PercepcionIIBB = parametros.PercepcionIIBB;
        }

        void inic(ref OrdenesCompra o)
        {
            Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();

            o.NumeroOrdenCompra = parametros.ProximoNumeroOrdenCompra ?? 0;
            o.FechaOrdenCompra = DateTime.Today;
            o.IdMoneda = 1;
        }

        private bool Validar(ProntoMVC.Data.Models.OrdenesCompra o, ref string sErrorMsg, ref string sWarningMsg)
        {
            if (!PuedeEditar(enumNodos.OrdenesCompra)) sErrorMsg += "\n" + "No tiene permisos de edición";

            Int32 mIdOrdenCompra = 0;
            Int32 mNumero = 0;
            Int32 mIdMoneda = 1;
            Int32 mIdCliente = 1;
            Int32 mIdTipoComprobante = 3;

            decimal mImporteDetalle = 0;
            decimal mSubtotal = 0;

            string mObservaciones = "";
            string mProntoIni = "";
            string mAnulada = "";

            DateTime mFechaOrdenCompra = DateTime.Today;

            mIdOrdenCompra = o.IdOrdenCompra;
            mFechaOrdenCompra = o.FechaOrdenCompra ?? DateTime.MinValue;
            mNumero = o.NumeroOrdenCompra ?? 0;
            mIdMoneda = o.IdMoneda ?? 1;
            mIdCliente = o.IdCliente ?? 0;
            mObservaciones = o.Observaciones ?? "";
            mAnulada = o.Anulada ?? "";




            var reqsToDelete = o.DetalleOrdenesCompras.Where(x => (x.IdArticulo ?? 0) <= 0).ToList();
            foreach (var deleteReq in reqsToDelete)
            {
                o.DetalleOrdenesCompras.Remove(deleteReq);
            }
            if (o.DetalleOrdenesCompras.Count <= 0) sErrorMsg += "\n" + "El comprobante no tiene items";



            if ((o.NumeroOrdenCompra ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número"; }
            if ((o.NumeroOrdenCompraCliente ?? "") == "") { sErrorMsg += "\n" + "Falta el número de orden de compra del cliente"; }
            if (mIdMoneda <= 0) { sErrorMsg += "\n" + "Falta la moneda"; }
            if ((o.IdCondicionVenta ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la condicion de venta"; }

            if ((o.IdObra ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la obra"; };

            var OrdenesCompras = db.OrdenesCompras.Where(p => p.NumeroOrdenCompra == mNumero && p.IdOrdenCompra != mIdOrdenCompra).OrderByDescending(p => p.FechaOrdenCompra).FirstOrDefault();
            if (OrdenesCompras != null) { sErrorMsg += "\n" + "La orden de compra ya existe."; }

            var Cliente = db.Clientes.Where(p => p.IdCliente == mIdCliente).FirstOrDefault();
            if (Cliente != null)
            {
                if (Cliente.Estados_Proveedores != null) { if ((Cliente.Estados_Proveedores.Activo ?? "") != "SI") { sErrorMsg += "\n" + "Cliente inhabilitado"; } }
            }
            else
            {
                { sErrorMsg += "\n" + "Falta el cliente"; }
            }

            if (o.DetalleOrdenesCompras.Count <= 0) sErrorMsg += "\n" + "La orden de compra no tiene items";
            foreach (ProntoMVC.Data.Models.DetalleOrdenesCompra x in o.DetalleOrdenesCompras)
            {
                if ((x.IdArticulo ?? 0) == 0) { sErrorMsg += "\n" + "Hay items que no tienen articulo"; }
                if ((x.IdUnidad ?? 0) == 0) { sErrorMsg += "\n" + "Hay items que no tienen unidad"; }
                if ((x.OrigenDescripcion ?? 0) == 0) { sErrorMsg += "\n" + "Hay items que no tienen el origen de la descripcion"; }
                if ((x.TipoCancelacion ?? 0) == 0) { sErrorMsg += "\n" + "Hay items que no tienen definido el tipo de cancelacion"; }

                mImporteDetalle = (x.Cantidad ?? 0) * (x.Precio ?? 0);
                mSubtotal += mImporteDetalle;
            }
            if (mSubtotal <= 0) sErrorMsg += "\n" + "El subtotal de la orden de compra debe ser mayor a cero";

            if (mAnulada == "SI")
            {
            }

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.OrdenesCompra OrdenCompra)
        {
            if (!PuedeEditar(enumNodos.OrdenesCompra)) throw new Exception("No tenés permisos");

            try
            {
                decimal mImporteTotal = 0;
                decimal mImporteDetalle = 0;
                decimal mImporte = 0;

                Int32 mIdOrdenCompra = 0;
                Int32 mNumero = 0;
                Int32 mIdCliente = 0;
                Int32 mIdMonedaPesos = 1;

                string errs = "";
                string warnings = "";

                bool mAnulada = false;

                Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
                mIdMonedaPesos = parametros.IdMoneda ?? 0;

                string usuario = ViewBag.NombreUsuario;
                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                if (OrdenCompra.IdOrdenCompra <= 0)
                {
                    OrdenCompra.IdUsuarioIngreso = IdUsuario;
                    OrdenCompra.FechaIngreso = DateTime.Now;
                }

                if (!Validar(OrdenCompra, ref errs, ref warnings))
                {
                    try
                    {
                        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    }
                    catch (Exception)
                    {
                    }

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;

                    string[] words = errs.Split('\n');
                    res.Errors = words.ToList();
                    res.Message = "Hay datos invalidos";

                    return Json(res);
                }

                if (ModelState.IsValid)
                {
                    using (TransactionScope scope = new TransactionScope())
                    {
                        mIdOrdenCompra = OrdenCompra.IdOrdenCompra;
                        mIdCliente = OrdenCompra.IdCliente ?? 0;
                        if (OrdenCompra.Anulada == "SI") { mAnulada = true; }
                        mImporteTotal = (OrdenCompra.ImporteTotal ?? 0);

                        if (mIdOrdenCompra > 0)
                        {
                            var EntidadOriginal = db.OrdenesCompras.Where(p => p.IdOrdenCompra == mIdOrdenCompra).SingleOrDefault();

                            var EntidadoEntry = db.Entry(EntidadOriginal);
                            EntidadoEntry.CurrentValues.SetValues(OrdenCompra);

                            ////////////////////////////////////////////// ANULACION //////////////////////////////////////////////
                            if (mAnulada)
                            {
                            }

                            ////////////////////////////////////////////// CONCEPTOS //////////////////////////////////////////////
                            foreach (var d in OrdenCompra.DetalleOrdenesCompras)
                            {
                                var DetalleEntidadOriginal = EntidadOriginal.DetalleOrdenesCompras.Where(c => c.IdDetalleOrdenCompra == d.IdDetalleOrdenCompra && d.IdDetalleOrdenCompra > 0).SingleOrDefault();
                                if (DetalleEntidadOriginal != null)
                                {
                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    EntidadOriginal.DetalleOrdenesCompras.Add(d);
                                }
                            }
                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleOrdenesCompras.Where(c => c.IdDetalleOrdenCompra != 0).ToList())
                            {
                                if (!OrdenCompra.DetalleOrdenesCompras.Any(c => c.IdDetalleOrdenCompra == DetalleEntidadOriginal.IdDetalleOrdenCompra))
                                {
                                    EntidadOriginal.DetalleOrdenesCompras.Remove(DetalleEntidadOriginal);
                                    db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
                            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        else
                        {
                            Parametros parametros2 = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
                            mNumero = parametros2.ProximoNumeroOrdenCompra ?? 1;
                            OrdenCompra.NumeroOrdenCompra = mNumero;
                            parametros2.ProximoNumeroOrdenCompra = mNumero + 1;
                            db.Entry(parametros2).State = System.Data.Entity.EntityState.Modified;

                            db.OrdenesCompras.Add(OrdenCompra);
                            db.SaveChanges();
                        }

                        db.Tree_TX_Actualizar(Tree_TX_ActualizarParam.OrdenesCompraAgrupadas.ToString(), OrdenCompra.IdOrdenCompra, "OrdenCompra");

                        scope.Complete();
                        scope.Dispose();
                    }

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdOrdenCompra = OrdenCompra.IdOrdenCompra, ex = "" });
                }
                else
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El comprobante tiene datos invalidos";

                    return Json(res);
                }
            }

            catch (TransactionAbortedException ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;
                return Json("TransactionAbortedException Message: {0}", ex.Message);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;

                List<string> errors = new List<string>();
                errors.Add(ex.Message);
                return Json(errors);
            }
        }





        public class OrdenesCompra2
        {
            //public OrdenesCompra2();

            public int? Agrupacion2Facturacion { get; set; }
            public int? AgrupacionFacturacion { get; set; }
            public string Anulada { get; set; }
            //public int? Aprobo { get; set; }
            public string ArchivoAdjunto1 { get; set; }
            public string ArchivoAdjunto10 { get; set; }
            public string ArchivoAdjunto2 { get; set; }
            public string ArchivoAdjunto3 { get; set; }
            public string ArchivoAdjunto4 { get; set; }
            public string ArchivoAdjunto5 { get; set; }
            public string ArchivoAdjunto6 { get; set; }
            public string ArchivoAdjunto7 { get; set; }
            public string ArchivoAdjunto8 { get; set; }
            public string ArchivoAdjunto9 { get; set; }
            public string CircuitoFirmasCompleto { get; set; }
            //  public virtual Cliente Cliente { get; set; }
            public virtual Condiciones_Compra Condiciones_Compra { get; set; }
            public virtual ICollection<DetalleOrdenesCompra> DetalleOrdenesCompras { get; set; }
            public virtual Empleado Empleado { get; set; }
            public virtual Empleado Empleado1 { get; set; }
            public virtual Empleado Empleado2 { get; set; }
            public virtual Empleado Empleado3 { get; set; }
            public string Estado { get; set; }
            public DateTime? FechaAnulacion { get; set; }
            public DateTime? FechaAprobacion { get; set; }
            public DateTime? FechaCambioEstado { get; set; }
            public DateTime? FechaEntrega { get; set; }
            public DateTime? FechaIngreso { get; set; }
            public DateTime? FechaModifico { get; set; }
            public DateTime? FechaOrdenCompra { get; set; }
            public int? IdCliente { get; set; }
            public int? IdCondicionVenta { get; set; }
            public int? IdDetalleClienteLugarEntrega { get; set; }
            public int? IdListaPrecios { get; set; }
            public int? IdMoneda { get; set; }
            public int? IdObra { get; set; }
            public int IdOrdenCompra { get; set; }
            public int? IdUsuarioAnulacion { get; set; }
            public int? IdUsuarioCambioEstado { get; set; }
            public int? IdUsuarioIngreso { get; set; }
            public int? IdUsuarioModifico { get; set; }
            public decimal? ImporteTotal { get; set; }
            public virtual ListasPrecio ListasPrecio { get; set; }
            // public virtual Moneda Moneda { get; set; }
            public int? NumeroOrdenCompra { get; set; }
            public string NumeroOrdenCompraCliente { get; set; }
            //public virtual Obra Obra { get; set; }
            public string Observaciones { get; set; }
            public decimal? PorcentajeBonificacion { get; set; }
            public string SeleccionadaParaFacturacion { get; set; }
            public decimal PendienteRemitir { get; set; }
            public decimal PendienteFacturar { get; set; }

            public string Producido { get; set; }
            public string Cumplido { get; set; }
            public int? ClienteCodigo { get; set; }
            public string ClienteNombre { get; set; }
            public string ClienteCuit { get; set; }
            public string Aprobo { get; set; }
            public string Remitos { get; set; }
            public string Facturas { get; set; }
            public string CondicionVenta { get; set; }
            public int Items { get; set; }
            public string FacturarA { get; set; }
            public string UsuarioAnulo { get; set; }
            public string UsuarioIngreso { get; set; }
            public string UsuarioModifico { get; set; }
            public string GrupoFacturacion { get; set; }
            public string TipoOC { get; set; }
            public string MayorFechaEntrega { get; set; }
            public string ListaDePrecio { get; set; }
            public string Obra { get; set; }
            public string Moneda { get; set; }


        }

        public virtual ActionResult TT_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters
            , string FechaInicial, string FechaFinal, string PendienteRemito = "", string PendienteFactura = "")
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

            //        }

            //IQueryable<Data.Models.Factura> q = (from a in db.Facturas where a.FechaFactura >= FechaDesde && a.FechaFactura <= FechaHasta select a).AsQueryable();





            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

          
            string campo = String.Empty;
            int pageSize = rows;
            int currentPage = page;
            decimal cien = 100;


            var context = ((System.Data.Entity.Infrastructure.IObjectContextAdapter)db).ObjectContext;

            // var data = (ObjectQuery<OrdenesCompra2>)(from ....
            var data = (from a in db.OrdenesCompras // context.OrdenesCompras
                        //from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                        //from d in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        //from e in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        //from f in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioAnulacion).DefaultIfEmpty()
                        //from g in db.Empleados.Where(v => v.IdEmpleado == a.Aprobo).DefaultIfEmpty()
                        //from i in db.Condiciones_Compras.Where(v => v.IdCondicionCompra == a.IdCondicionVenta).DefaultIfEmpty()
                        //from j in db.ListasPrecios.Where(v => v.IdListaPrecios == a.IdListaPrecios).DefaultIfEmpty()
                        select new OrdenesCompra2
                        {
                            IdOrdenCompra = a.IdOrdenCompra,
                            IdCliente = a.IdCliente,
                            IdObra = a.IdObra,
                            IdCondicionVenta = a.IdCondicionVenta,
                            IdListaPrecios = a.IdListaPrecios,
                            IdMoneda = a.IdMoneda,
                            NumeroOrdenCompraCliente = a.NumeroOrdenCompraCliente,
                            NumeroOrdenCompra = a.NumeroOrdenCompra,
                            FechaOrdenCompra = a.FechaOrdenCompra,
                            Anulada = a.Anulada,
                            SeleccionadaParaFacturacion = a.SeleccionadaParaFacturacion,
                            Obra = a.Obra != null ? a.Obra.NumeroObra : "",
                            Producido = a.Estado,
                            Cumplido = "",

                            ClienteCodigo = a.Cliente.CodigoCliente,
                            ClienteNombre = a.Cliente.RazonSocial,
                            ClienteCuit = a.Cliente.Cuit,
                            Aprobo = a.Empleado3.Nombre,
                            Remitos = "",
                            Facturas = "",
                            CondicionVenta = a.Condiciones_Compra != null ? a.Condiciones_Compra.Descripcion : "",
                            Items = 0,
                            FacturarA = (a.AgrupacionFacturacion ?? 1) == 1 ? "Cliente" :
                                ((a.AgrupacionFacturacion ?? 1) == 2 ? "Obra" : ((a.AgrupacionFacturacion ?? 1) == 3 ? "U.Operativa" : "")),
                            UsuarioAnulo = a.Empleado != null ? a.Empleado.Nombre : "",
                            UsuarioIngreso = a.Empleado2 != null ? a.Empleado2.Nombre : "",
                            UsuarioModifico = a.Empleado1 != null ? a.Empleado1.Nombre : "",
                            GrupoFacturacion = (a.Agrupacion2Facturacion ?? 1) == 1 ? "Grupo 1" : ((a.Agrupacion2Facturacion ?? 1) == 2 ? "Grupo 2" : ((a.Agrupacion2Facturacion ?? 1) == 3 ? "Grupo 3" : "")),
                            TipoOC = "",
                            MayorFechaEntrega = "",
                            ListaDePrecio = a.ListasPrecio != null ? "Lista " + a.ListasPrecio.NumeroLista.ToString() + " " + a.ListasPrecio.Descripcion : "",
                            FechaAnulacion = a.FechaAnulacion,
                            FechaIngreso = a.FechaIngreso,
                            FechaModifico = a.FechaModifico,

                            PorcentajeBonificacion = a.PorcentajeBonificacion,
                            ImporteTotal = a.ImporteTotal,
                            Moneda = a.Moneda.Abreviatura,
                            Observaciones = a.Observaciones,
                            PendienteRemitir = PendienteRemito == "SI"
                                                ? ((db.DetalleOrdenesCompras.Where(x => x.IdOrdenCompra == a.IdOrdenCompra && (a.Anulada ?? "NO") != "SI")
                                                    .Sum(y => ((y.TipoCancelacion ?? 1) == 1 ? y.Cantidad : 100) - (db.DetalleRemitos.Where(x => x.IdDetalleOrdenCompra == y.IdDetalleOrdenCompra && (x.Remito.Anulado ?? "NO") != "SI").Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.Cantidad : z.PorcentajeCertificacion)) ?? 0)
                                                    )) ?? 0)
                                                : 1,
                            PendienteFacturar = PendienteFactura == "SI"
                                                ? (db.DetalleOrdenesCompras.Where(x => x.IdOrdenCompra == a.IdOrdenCompra && (a.Anulada ?? "NO") != "SI")
                                                    .Sum(y => ((y.TipoCancelacion ?? 1) == 1 ? y.Cantidad : 100) -
                                                        (db.DetalleFacturasOrdenesCompras.Where(x => x.IdDetalleOrdenCompra == y.IdDetalleOrdenCompra && (x.DetalleFactura.Factura.Anulada ?? "NO") != "SI").Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.DetalleFactura.Cantidad : z.DetalleFactura.PorcentajeCertificacion)) ?? 0) +
                                                        (db.DetalleNotasCreditoOrdenesCompras.Where(x => x.IdDetalleOrdenCompra == y.IdDetalleOrdenCompra && (x.NotasCredito.Anulada ?? "NO") != "SI").Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.Cantidad : z.PorcentajeCertificacion)) ?? 0)
                                                    )) ?? 0
                                                : 1
                        }).AsQueryable();









            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            // Oleg: filtros avanzados con jqgrid y LINQ    http://stackoverflow.com/questions/5500805/asp-net-mvc-2-0-implementation-of-searching-in-jqgrid/5501644#5501644
            // usando dbcontext en lugar de objectcontext   http://stackoverflow.com/questions/9027150/jqgrid-asp-net-4-mvc-how-to-make-search-implementation-on-a-dbcontext-reposit

            //var sc = Generales.sCadenaConex("Autotrol");
            //var dbcontext = new ProntoMVC.Data.Models.DemoProntoEntities(sc);
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ObjectQuery<OrdenesCompra2> set;
            // set = context.CreateObjectSet<Data.Models.OrdenesCompra>()


            IQueryable<OrdenesCompra2> aaaa = data
                // .Include("Obra,Condiciones_Compra,Empleado,ListasPrecio,Transportista,DetalleOrdenesCompra,OrdenesCompra")
                        .Where(x => (PendienteRemito != "SI" || (PendienteRemito == "SI" && x.PendienteRemitir > 0))
                                 && (PendienteFactura != "SI" || (PendienteFactura == "SI" && x.PendienteFacturar > 0)))
                        .Where(a =>  a.FechaOrdenCompra >= FechaDesde && a.FechaOrdenCompra <= FechaHasta ).AsQueryable()
                        ;


            List<OrdenesCompra2> fff = data.ToList();
            List<OrdenesCompra2> zzzzzz = aaaa.ToList();
            set = aaaa as ObjectQuery<OrdenesCompra2>;

            // estoy usando un include adicional porque no anduvo bien pasar en uno solo una lista doble de subcolecciones (por ejemplo
            //                   el caso del maestro de requerimientos:
            //                  db.Requerimientos.Include("DetalleRequerimientos.DetallePresupuestos,DetalleRequerimientos.DetallePedidos")  no funciona
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////


            int totalRecords = 0;

            //var pagedQuery2 = Filters.FiltroGenerico_PasandoQueryEntera<OrdenesCompra2>
            //                    (data
            //                    , sidx, sord, page, rows, _search, filters, ref totalRecords);

            var pagedQuery = Filters.FiltroGenerico_UsandoStoreOLista<OrdenesCompra2>
                                (sidx, sord, page, rows, _search, filters, db, ref totalRecords, zzzzzz);


            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////

            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////

            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////






            var jsonData = new jqGridJson()
            {
                total = (totalRecords + rows - 1) / rows,
                page = currentPage,
                records = totalRecords,
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdOrdenCompra.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdOrdenCompra} ) + ">Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdOrdenCompra} ) + ">Emitir</a> ",
                                a.IdOrdenCompra.ToString(),
                                a.IdCliente.NullSafeToString(),
                                a.IdObra.NullSafeToString(),
                                a.IdCondicionVenta.NullSafeToString(),
                                a.IdListaPrecios.NullSafeToString(),
                                a.IdMoneda.NullSafeToString(),
                                a.NumeroOrdenCompraCliente.NullSafeToString(),
                                a.NumeroOrdenCompra.NullSafeToString(),
                                a.FechaOrdenCompra == null ? "" : a.FechaOrdenCompra.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Producido.NullSafeToString(),
                                a.Cumplido.NullSafeToString(),
                                a.Anulada.NullSafeToString(),
                                a.SeleccionadaParaFacturacion.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.ClienteCodigo.NullSafeToString(),
                                a.ClienteNombre.NullSafeToString(),
                                a.ClienteCuit.NullSafeToString(),
                                a.Aprobo.NullSafeToString(),
                                a.Remitos.NullSafeToString(),
                                a.Facturas.NullSafeToString(),
                                a.CondicionVenta.NullSafeToString(),
                                db.DetalleOrdenesCompras.Where(x=>x.IdOrdenCompra==a.IdOrdenCompra).Select(x=>x.IdDetalleOrdenCompra).Distinct().Count().ToString(),
                                a.FacturarA.NullSafeToString(),
                                a.FechaAnulacion == null ? "" : a.FechaAnulacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioAnulo.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioIngreso.NullSafeToString(),
                                a.FechaModifico == null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioModifico.NullSafeToString(),
                                a.GrupoFacturacion.NullSafeToString(),
                                a.TipoOC.NullSafeToString(),
                                a.MayorFechaEntrega.NullSafeToString(),
                                a.ListaDePrecio.NullSafeToString(),
                                a.PorcentajeBonificacion.NullSafeToString(),
                                a.ImporteTotal.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }



        public virtual ActionResult TT_DynamicGridData_original(string sidx, string sord, int page, int rows, bool _search, string filters)
        {



            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.OrdenesCompra>
                                ("Obra,Condiciones_Compra,Empleado,ListasPrecio,Transportista,DetalleOrdenesCompra,OrdenesCompra"
                                , sidx, sord, page, rows, _search, filters, db, ref totalRecords);



            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            string PendienteRemito = "";
            string PendienteFactura = "";


            string campo = String.Empty;
            int pageSize = rows;
            int currentPage = page;
            decimal cien = 100;

            var data = (from a in pagedQuery
                        //from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                        //from d in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        //from e in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        //from f in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioAnulacion).DefaultIfEmpty()
                        //from g in db.Empleados.Where(v => v.IdEmpleado == a.Aprobo).DefaultIfEmpty()
                        //from i in db.Condiciones_Compras.Where(v => v.IdCondicionCompra == a.IdCondicionVenta).DefaultIfEmpty()
                        //from j in db.ListasPrecios.Where(v => v.IdListaPrecios == a.IdListaPrecios).DefaultIfEmpty()
                        select new
                        {
                            a.IdOrdenCompra,
                            a.IdCliente,
                            a.IdObra,
                            a.IdCondicionVenta,
                            a.IdListaPrecios,
                            a.IdMoneda,
                            a.NumeroOrdenCompraCliente,
                            a.NumeroOrdenCompra,
                            a.FechaOrdenCompra,
                            Producido = a.Estado,
                            // Case When Exists(Select Top 1 doc.IdOrdenCompra From DetalleOrdenesCompra doc Where doc.IdOrdenCompra=OrdenesCompra.IdOrdenCompra and IsNull(doc.Cumplido,'NO')='NO') Then Null Else 'SI' End as [Cumplido],
                            Cumplido = "",
                            a.Anulada,
                            a.SeleccionadaParaFacturacion,
                            Obra = a.Obra != null ? a.Obra.NumeroObra : "",
                            ClienteCodigo = a.Cliente.CodigoCliente,
                            ClienteNombre = a.Cliente.RazonSocial,
                            ClienteCuit = a.Cliente.Cuit,
                            Aprobo = a.Empleado3.Nombre,
                            //#Auxiliar3.Remitos as [Remitos],
                            Remitos = "",
                            //#Auxiliar5.Facturas as [Facturas],
                            Facturas = "",
                            CondicionVenta = a.Condiciones_Compra != null ? a.Condiciones_Compra.Descripcion : "",
                            // (Select Count(*) From DetalleOrdenesCompra Where DetalleOrdenesCompra.IdOrdenCompra=OrdenesCompra.IdOrdenCompra) as [Cant.Items],
                            Items = 0,
                            FacturarA = (a.AgrupacionFacturacion ?? 1) == 1 ? "Cliente" :
                                ((a.AgrupacionFacturacion ?? 1) == 2 ? "Obra" : ((a.AgrupacionFacturacion ?? 1) == 3 ? "U.Operativa" : "")),
                            a.FechaAnulacion,
                            UsuarioAnulo = a.Empleado != null ? a.Empleado.Nombre : "",
                            a.FechaIngreso,
                            UsuarioIngreso = a.Empleado2 != null ? a.Empleado2.Nombre : "",
                            a.FechaModifico,
                            UsuarioModifico = a.Empleado1 != null ? a.Empleado1.Nombre : "",
                            GrupoFacturacion = (a.Agrupacion2Facturacion ?? 1) == 1 ? "Grupo 1" : ((a.Agrupacion2Facturacion ?? 1) == 2 ? "Grupo 2" : ((a.Agrupacion2Facturacion ?? 1) == 3 ? "Grupo 3" : "")),
                            //IsNull(#Auxiliar2.Automatica+' ','')+IsNull(#Auxiliar2.Manual,'') as [Tipo OC],
                            TipoOC = "",
                            //(Select Max(Det.FechaEntrega) From DetalleOrdenesCompra Det Where Det.IdOrdenCompra=OrdenesCompra.IdOrdenCompra) as [Mayor fecha entrega],
                            MayorFechaEntrega = "",
                            ListaDePrecio = a.ListasPrecio != null ? "Lista " + a.ListasPrecio.NumeroLista.ToString() + " " + a.ListasPrecio.Descripcion : "",
                            a.PorcentajeBonificacion,
                            a.ImporteTotal,
                            Moneda = a.Moneda.Abreviatura,
                            a.Observaciones,
                            PendienteRemitir = PendienteRemito == "SI"
                                                ? ((db.DetalleOrdenesCompras.Where(x => x.IdOrdenCompra == a.IdOrdenCompra && (a.Anulada ?? "NO") != "SI")
                                                    .Sum(y => ((y.TipoCancelacion ?? 1) == 1 ? y.Cantidad : 100) - (db.DetalleRemitos.Where(x => x.IdDetalleOrdenCompra == y.IdDetalleOrdenCompra && (x.Remito.Anulado ?? "NO") != "SI").Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.Cantidad : z.PorcentajeCertificacion)) ?? 0)
                                                    )) ?? 0)
                                                : 1,
                            PendienteFacturar = PendienteFactura == "SI"
                                                ? (db.DetalleOrdenesCompras.Where(x => x.IdOrdenCompra == a.IdOrdenCompra && (a.Anulada ?? "NO") != "SI")
                                                    .Sum(y => ((y.TipoCancelacion ?? 1) == 1 ? y.Cantidad : 100) -
                                                        (db.DetalleFacturasOrdenesCompras.Where(x => x.IdDetalleOrdenCompra == y.IdDetalleOrdenCompra && (x.DetalleFactura.Factura.Anulada ?? "NO") != "SI").Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.DetalleFactura.Cantidad : z.DetalleFactura.PorcentajeCertificacion)) ?? 0) +
                                                        (db.DetalleNotasCreditoOrdenesCompras.Where(x => x.IdDetalleOrdenCompra == y.IdDetalleOrdenCompra && (x.NotasCredito.Anulada ?? "NO") != "SI").Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.Cantidad : z.PorcentajeCertificacion)) ?? 0)
                                                    )) ?? 0
                                                : 1
                        }).AsQueryable();


            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .Where(x => (PendienteRemito != "SI" || (PendienteRemito == "SI" && x.PendienteRemitir > 0))
                                 && (PendienteFactura != "SI" || (PendienteFactura == "SI" && x.PendienteFacturar > 0)))
                        .OrderByDescending(x => x.NumeroOrdenCompra)

//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data1
                        select new jqGridRowJson
                        {
                            id = a.IdOrdenCompra.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdOrdenCompra} ) + ">Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdOrdenCompra} ) + ">Emitir</a> ",
                                a.IdOrdenCompra.ToString(),
                                a.IdCliente.NullSafeToString(),
                                a.IdObra.NullSafeToString(),
                                a.IdCondicionVenta.NullSafeToString(),
                                a.IdListaPrecios.NullSafeToString(),
                                a.IdMoneda.NullSafeToString(),
                                a.NumeroOrdenCompraCliente.NullSafeToString(),
                                a.NumeroOrdenCompra.NullSafeToString(),
                                a.FechaOrdenCompra == null ? "" : a.FechaOrdenCompra.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Producido.NullSafeToString(),
                                a.Cumplido.NullSafeToString(),
                                a.Anulada.NullSafeToString(),
                                a.SeleccionadaParaFacturacion.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.ClienteCodigo.NullSafeToString(),
                                a.ClienteNombre.NullSafeToString(),
                                a.ClienteCuit.NullSafeToString(),
                                a.Aprobo.NullSafeToString(),
                                a.Remitos.NullSafeToString(),
                                a.Facturas.NullSafeToString(),
                                a.CondicionVenta.NullSafeToString(),
                                db.DetalleOrdenesCompras.Where(x=>x.IdOrdenCompra==a.IdOrdenCompra).Select(x=>x.IdDetalleOrdenCompra).Distinct().Count().ToString(),
                                a.FacturarA.NullSafeToString(),
                                a.FechaAnulacion == null ? "" : a.FechaAnulacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioAnulo.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioIngreso.NullSafeToString(),
                                a.FechaModifico == null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioModifico.NullSafeToString(),
                                a.GrupoFacturacion.NullSafeToString(),
                                a.TipoOC.NullSafeToString(),
                                a.MayorFechaEntrega.NullSafeToString(),
                                a.ListaDePrecio.NullSafeToString(),
                                a.PorcentajeBonificacion.NullSafeToString(),
                                a.ImporteTotal.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }





        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper,
            string searchString, string FechaInicial, string FechaFinal, string PendienteRemito = "", string PendienteFactura = "")
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;
            decimal cien = 100;

            var data = (from a in db.OrdenesCompras
                        from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                        from d in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from e in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        from f in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioAnulacion).DefaultIfEmpty()
                        from g in db.Empleados.Where(v => v.IdEmpleado == a.Aprobo).DefaultIfEmpty()
                        from i in db.Condiciones_Compras.Where(v => v.IdCondicionCompra == a.IdCondicionVenta).DefaultIfEmpty()
                        from j in db.ListasPrecios.Where(v => v.IdListaPrecios == a.IdListaPrecios).DefaultIfEmpty()
                        select new
                        {
                            a.IdOrdenCompra,
                            a.IdCliente,
                            a.IdObra,
                            a.IdCondicionVenta,
                            a.IdListaPrecios,
                            a.IdMoneda,
                            a.NumeroOrdenCompraCliente,
                            a.NumeroOrdenCompra,
                            a.FechaOrdenCompra,
                            Producido = a.Estado,
                            // Case When Exists(Select Top 1 doc.IdOrdenCompra From DetalleOrdenesCompra doc Where doc.IdOrdenCompra=OrdenesCompra.IdOrdenCompra and IsNull(doc.Cumplido,'NO')='NO') Then Null Else 'SI' End as [Cumplido],
                            Cumplido = "",
                            a.Anulada,
                            a.SeleccionadaParaFacturacion,
                            Obra = c != null ? c.NumeroObra : "",
                            ClienteCodigo = a.Cliente.CodigoCliente,
                            ClienteNombre = a.Cliente.RazonSocial,
                            ClienteCuit = a.Cliente.Cuit,
                            Aprobo = g != null ? g.Nombre : "",
                            //#Auxiliar3.Remitos as [Remitos],
                            Remitos = "",
                            //#Auxiliar5.Facturas as [Facturas],
                            Facturas = "",
                            CondicionVenta = i != null ? i.Descripcion : "",
                            // (Select Count(*) From DetalleOrdenesCompra Where DetalleOrdenesCompra.IdOrdenCompra=OrdenesCompra.IdOrdenCompra) as [Cant.Items],
                            Items = 0,
                            FacturarA = (a.AgrupacionFacturacion ?? 1) == 1 ? "Cliente" : ((a.AgrupacionFacturacion ?? 1) == 2 ? "Obra" : ((a.AgrupacionFacturacion ?? 1) == 3 ? "U.Operativa" : "")),
                            a.FechaAnulacion,
                            UsuarioAnulo = f != null ? f.Nombre : "",
                            a.FechaIngreso,
                            UsuarioIngreso = d != null ? d.Nombre : "",
                            a.FechaModifico,
                            UsuarioModifico = e != null ? e.Nombre : "",
                            GrupoFacturacion = (a.Agrupacion2Facturacion ?? 1) == 1 ? "Grupo 1" : ((a.Agrupacion2Facturacion ?? 1) == 2 ? "Grupo 2" : ((a.Agrupacion2Facturacion ?? 1) == 3 ? "Grupo 3" : "")),
                            //IsNull(#Auxiliar2.Automatica+' ','')+IsNull(#Auxiliar2.Manual,'') as [Tipo OC],
                            TipoOC = "",
                            //(Select Max(Det.FechaEntrega) From DetalleOrdenesCompra Det Where Det.IdOrdenCompra=OrdenesCompra.IdOrdenCompra) as [Mayor fecha entrega],
                            MayorFechaEntrega = "",
                            ListaDePrecio = j != null ? "Lista " + j.NumeroLista.ToString() + " " + j.Descripcion : "",
                            a.PorcentajeBonificacion,
                            a.ImporteTotal,
                            Moneda = a.Moneda.Abreviatura,
                            a.Observaciones,
                            PendienteRemitir = PendienteRemito == "SI"
                                                ? ((db.DetalleOrdenesCompras.Where(x => x.IdOrdenCompra == a.IdOrdenCompra && (a.Anulada ?? "NO") != "SI")
                                                    .Sum(y => ((y.TipoCancelacion ?? 1) == 1 ? y.Cantidad : 100) - (db.DetalleRemitos.Where(x => x.IdDetalleOrdenCompra == y.IdDetalleOrdenCompra && (x.Remito.Anulado ?? "NO") != "SI").Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.Cantidad : z.PorcentajeCertificacion)) ?? 0)
                                                    )) ?? 0)
                                                : 1,
                            PendienteFacturar = PendienteFactura == "SI"
                                                ? (db.DetalleOrdenesCompras.Where(x => x.IdOrdenCompra == a.IdOrdenCompra && (a.Anulada ?? "NO") != "SI")
                                                    .Sum(y => ((y.TipoCancelacion ?? 1) == 1 ? y.Cantidad : 100) -
                                                        (db.DetalleFacturasOrdenesCompras.Where(x => x.IdDetalleOrdenCompra == y.IdDetalleOrdenCompra && (x.DetalleFactura.Factura.Anulada ?? "NO") != "SI").Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.DetalleFactura.Cantidad : z.DetalleFactura.PorcentajeCertificacion)) ?? 0) +
                                                        (db.DetalleNotasCreditoOrdenesCompras.Where(x => x.IdDetalleOrdenCompra == y.IdDetalleOrdenCompra && (x.NotasCredito.Anulada ?? "NO") != "SI").Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.Cantidad : z.PorcentajeCertificacion)) ?? 0)
                                                    )) ?? 0
                                                : 1
                        }).AsQueryable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaOrdenCompra >= FechaDesde && a.FechaOrdenCompra <= FechaHasta select a).AsQueryable();
            }

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .Where(x => (PendienteRemito != "SI" || (PendienteRemito == "SI" && x.PendienteRemitir > 0)) && (PendienteFactura != "SI" || (PendienteFactura == "SI" && x.PendienteFacturar > 0)))
                        .OrderByDescending(x => x.NumeroOrdenCompra)

//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data1
                        select new jqGridRowJson
                        {
                            id = a.IdOrdenCompra.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdOrdenCompra} ) + ">Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdOrdenCompra} ) + ">Emitir</a> ",
                                a.IdOrdenCompra.ToString(),
                                a.IdCliente.NullSafeToString(),
                                a.IdObra.NullSafeToString(),
                                a.IdCondicionVenta.NullSafeToString(),
                                a.IdListaPrecios.NullSafeToString(),
                                a.IdMoneda.NullSafeToString(),
                                a.NumeroOrdenCompraCliente.NullSafeToString(),
                                a.NumeroOrdenCompra.NullSafeToString(),
                                a.FechaOrdenCompra == null ? "" : a.FechaOrdenCompra.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Producido.NullSafeToString(),
                                a.Cumplido.NullSafeToString(),
                                a.Anulada.NullSafeToString(),
                                a.SeleccionadaParaFacturacion.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.ClienteCodigo.NullSafeToString(),
                                a.ClienteNombre.NullSafeToString(),
                                a.ClienteCuit.NullSafeToString(),
                                a.Aprobo.NullSafeToString(),
                                a.Remitos.NullSafeToString(),
                                a.Facturas.NullSafeToString(),
                                a.CondicionVenta.NullSafeToString(),
                                db.DetalleOrdenesCompras.Where(x=>x.IdOrdenCompra==a.IdOrdenCompra).Select(x=>x.IdDetalleOrdenCompra).Distinct().Count().ToString(),
                                a.FacturarA.NullSafeToString(),
                                a.FechaAnulacion == null ? "" : a.FechaAnulacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioAnulo.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioIngreso.NullSafeToString(),
                                a.FechaModifico == null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioModifico.NullSafeToString(),
                                a.GrupoFacturacion.NullSafeToString(),
                                a.TipoOC.NullSafeToString(),
                                a.MayorFechaEntrega.NullSafeToString(),
                                a.ListaDePrecio.NullSafeToString(),
                                a.PorcentajeBonificacion.NullSafeToString(),
                                a.ImporteTotal.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetOrdenesCompra(string sidx, string sord, int? page, int? rows, int? IdOrdenCompra)
        {
            int IdOrdenCompra1 = IdOrdenCompra ?? 0;
            var Det = db.DetalleOrdenesCompras.Where(p => p.IdOrdenCompra == IdOrdenCompra1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Colores.Where(o => o.IdColor == a.IdColor).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleOrdenCompra,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdColor,
                            a.OrigenDescripcion,
                            a.TipoCancelacion,
                            a.NumeroItem,
                            Codigo = a.Articulo.Codigo,
                            Articulo = a.Articulo.Descripcion + (b != null ? " " + b.Descripcion : ""),
                            a.Cantidad,
                            Unidad = a.Unidade.Abreviatura,
                            Precio = Math.Round((double)a.Precio, 2),
                            a.PorcentajeBonificacion,
                            Importe = Math.Round((double)a.Cantidad * (double)a.Precio * (double)(1 - (a.PorcentajeBonificacion ?? 0) / 100), 2),
                            TiposDeDescripcion = (a.OrigenDescripcion ?? 1) == 1 ? "Solo material" : ((a.OrigenDescripcion ?? 1) == 2 ? "Solo observaciones" : ((a.OrigenDescripcion ?? 1) == 3 ? "Material + observaciones" : "")),
                            TiposCancelacion = (a.TipoCancelacion ?? 1) == 1 ? "Por cantidad" : ((a.TipoCancelacion ?? 1) == 2 ? "Por certificacion" : ""),
                            a.FechaNecesidad,
                            a.FechaEntrega,
                            a.FacturacionAutomatica,
                            a.FechaComienzoFacturacion,
                            a.CantidadMesesAFacturar,
                            a.FacturacionCompletaMensual,
                            a.Observaciones
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
                            id = a.IdDetalleOrdenCompra.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleOrdenCompra.ToString(), 
                            a.IdArticulo.NullSafeToString(),
                            a.IdUnidad.NullSafeToString(),
                            a.IdColor.NullSafeToString(),
                            a.OrigenDescripcion.NullSafeToString(),
                            a.TipoCancelacion.NullSafeToString(),
                            a.NumeroItem.NullSafeToString(),
                            a.Codigo.NullSafeToString(),
                            a.Articulo.NullSafeToString(),
                            a.Cantidad.NullSafeToString(),
                            a.Unidad.NullSafeToString(),
                            a.Precio.NullSafeToString(),
                            a.PorcentajeBonificacion.NullSafeToString(),
                            a.Importe.NullSafeToString(),
                            a.TiposDeDescripcion.NullSafeToString(),
                            a.TiposCancelacion.NullSafeToString(),
                            a.FechaNecesidad == null ? "" : a.FechaNecesidad.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.FechaEntrega == null ? "" : a.FechaEntrega.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.FacturacionAutomatica.NullSafeToString(),
                            a.FechaComienzoFacturacion == null ? "" : a.FechaComienzoFacturacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.CantidadMesesAFacturar.NullSafeToString(),
                            a.FacturacionCompletaMensual.NullSafeToString(),
                            a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult DetOrdenesCompraSinFormato(int IdOrdenCompra)
        {
            Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            decimal mPorcentajeIva = parametros.Iva1 ?? 0;

            var Det = db.DetalleOrdenesCompras.Where(p => p.IdOrdenCompra == IdOrdenCompra).AsQueryable();

            var data = (from a in Det
                        from b in db.Colores.Where(o => o.IdColor == a.IdColor).DefaultIfEmpty()
                        from c in db.Obras.Where(v => v.IdObra == a.OrdenesCompra.IdObra).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleOrdenCompra,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdColor,
                            a.OrigenDescripcion,
                            a.TipoCancelacion,
                            a.OrdenesCompra.IdObra,
                            a.NumeroItem,
                            Codigo = a.Articulo.Codigo,
                            Articulo = a.Articulo.Descripcion + (b != null ? " " + b.Descripcion : ""),
                            a.Cantidad,
                            PendienteRemitir = (a.TipoCancelacion ?? 1) == 1
                                                ? a.Cantidad - (db.DetalleRemitos.Where(x => x.IdDetalleOrdenCompra == a.IdDetalleOrdenCompra && (x.Remito.Anulado ?? "NO") != "SI").Sum(z => z.Cantidad) ?? 0)
                                                : 100 - (db.DetalleRemitos.Where(x => x.IdDetalleOrdenCompra == a.IdDetalleOrdenCompra && (x.Remito.Anulado ?? "NO") != "SI").Sum(z => z.PorcentajeCertificacion) ?? 0),
                            PendienteFacturar = (a.TipoCancelacion ?? 1) == 1
                                                ? a.Cantidad - (db.DetalleFacturasOrdenesCompras.Where(x => x.IdDetalleOrdenCompra == a.IdDetalleOrdenCompra && (x.DetalleFactura.Factura.Anulada ?? "NO") != "SI").Sum(z => z.DetalleFactura.Cantidad) ?? 0) + (db.DetalleNotasCreditoOrdenesCompras.Where(x => x.IdDetalleOrdenCompra == a.IdDetalleOrdenCompra && (x.NotasCredito.Anulada ?? "NO") != "SI").Sum(z => z.Cantidad) ?? 0)
                                                : 100 - (db.DetalleFacturasOrdenesCompras.Where(x => x.IdDetalleOrdenCompra == a.IdDetalleOrdenCompra && (x.DetalleFactura.Factura.Anulada ?? "NO") != "SI").Sum(z => z.DetalleFactura.PorcentajeCertificacion) ?? 0) + (db.DetalleNotasCreditoOrdenesCompras.Where(x => x.IdDetalleOrdenCompra == a.IdDetalleOrdenCompra && (x.NotasCredito.Anulada ?? "NO") != "SI").Sum(z => z.PorcentajeCertificacion) ?? 0),
                            Unidad = a.Unidade.Abreviatura,
                            Precio = Math.Round((double)a.Precio, 2),
                            a.PorcentajeBonificacion,
                            Importe = Math.Round((double)a.Cantidad * (double)a.Precio * (double)(1 - (a.PorcentajeBonificacion ?? 0) / 100), 2),
                            TiposDeDescripcion = (a.OrigenDescripcion ?? 1) == 1 ? "Solo material" : ((a.OrigenDescripcion ?? 1) == 2 ? "Solo observaciones" : ((a.OrigenDescripcion ?? 1) == 3 ? "Material + observaciones" : "")),
                            TiposCancelacion = (a.TipoCancelacion ?? 1) == 1 ? "Por cantidad" : ((a.TipoCancelacion ?? 1) == 2 ? "Por certificacion" : ""),
                            a.FechaNecesidad,
                            a.FechaEntrega,
                            a.FacturacionAutomatica,
                            a.FechaComienzoFacturacion,
                            a.CantidadMesesAFacturar,
                            a.FacturacionCompletaMensual,
                            a.Observaciones,
                            Obra = c != null ? c.NumeroObra : "",
                            OrdenCompraNumero = a.OrdenesCompra.NumeroOrdenCompra.ToString() + "/" + a.NumeroItem.ToString(),
                            PorcentajeIva = mPorcentajeIva,
                            IdCodigoIva = a.OrdenesCompra.Cliente.IdCodigoIva
                        }).OrderBy(p => p.NumeroItem).ToList();

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdOrdenCompra, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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

        public virtual ActionResult GetTiposCancelacion()
        {
            Dictionary<int, string> TiposCancelacion = new Dictionary<int, string>();
            TiposCancelacion.Add(1, "Por cantidad");
            TiposCancelacion.Add(2, "Por certificacion");

            return PartialView("Select", TiposCancelacion);
        }

    }

}