using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
//using System.Data.Entity.Core.Objects.ObjectQuery; //using System.Data.Objects;
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
    public partial class ValeSalidaController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.ValesSalida)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult Edit(int id)
        {
            ValesSalida o;

            try
            {
                if (!PuedeLeer(enumNodos.ValesSalida))
                {
                    o = new ValesSalida();
                    CargarViewBag(o);
                    ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                    return View(o);
                }
            }
            catch (Exception)
            {
                o = new ValesSalida();
                CargarViewBag(o);
                ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                return View(o);
            }

            if (id <= 0)
            {
                o = new ValesSalida();
                inic(ref o);
                CargarViewBag(o);
                return View(o);
            }
            else
            {
                o = db.ValesSalidas.Include(x => x.DetalleValesSalidas).SingleOrDefault(x => x.IdValeSalida == id);
                CargarViewBag(o);
                Session.Add("ValeSalida", o);
                return View(o);
            }
        }

        void CargarViewBag(ValesSalida o)
        {
            ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre",o.Aprobo);
        }

        void inic(ref ValesSalida o)
        {
            Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();

            o.NumeroValeSalida = parametros.ProximoNumeroValeSalida ?? 0;
            o.FechaValeSalida = DateTime.Today;
        }

        private bool Validar(ProntoMVC.Data.Models.ValesSalida o, ref string sErrorMsg, ref string sWarningMsg)
        {
            if (!PuedeEditar(enumNodos.ValesSalida)) sErrorMsg += "\n" + "No tiene permisos de edición";


            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.ValesSalida ValeSalida)
        {
            if (!PuedeEditar(enumNodos.ValesSalida)) throw new Exception("No tenés permisos");

            try
            {
                Int32 mIdValeSalida = 0;
                Int32 mNumero = 0;

                string errs = "";
                string warnings = "";

                bool mAnulada = false;

                string usuario = oStaticMembershipService.GetUser().UserName;
                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                if (!Validar(ValeSalida, ref errs, ref warnings))
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
                        mIdValeSalida = ValeSalida.IdValeSalida;

                        if (mIdValeSalida > 0)
                        {
                            var EntidadOriginal = db.ValesSalidas.Where(p => p.IdValeSalida == mIdValeSalida).SingleOrDefault();

                            var EntidadoEntry = db.Entry(EntidadOriginal);
                            EntidadoEntry.CurrentValues.SetValues(ValeSalida);

                            ////////////////////////////////////////////// ANULACION //////////////////////////////////////////////
                            if (mAnulada)
                            {
                            }

                            ////////////////////////////////////////////// CONCEPTOS //////////////////////////////////////////////
                            foreach (var d in ValeSalida.DetalleValesSalidas)
                            {
                                var DetalleEntidadOriginal = EntidadOriginal.DetalleValesSalidas.Where(c => c.IdDetalleValeSalida == d.IdDetalleValeSalida && d.IdDetalleValeSalida > 0).SingleOrDefault();
                                if (DetalleEntidadOriginal != null)
                                {
                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    EntidadOriginal.DetalleValesSalidas.Add(d);
                                }
                            }
                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleValesSalidas.Where(c => c.IdDetalleValeSalida != 0).ToList())
                            {
                                if (!ValeSalida.DetalleValesSalidas.Any(c => c.IdDetalleValeSalida == DetalleEntidadOriginal.IdDetalleValeSalida))
                                {
                                    EntidadOriginal.DetalleValesSalidas.Remove(DetalleEntidadOriginal);
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
                            mNumero = parametros2.ProximoNumeroValeSalida ?? 1;
                            ValeSalida.NumeroValeSalida = mNumero;
                            parametros2.ProximoNumeroValeSalida = mNumero + 1;
                            db.Entry(parametros2).State = System.Data.Entity.EntityState.Modified;

                            db.ValesSalidas.Add(ValeSalida);
                            db.SaveChanges();
                        }

                        scope.Complete();
                        scope.Dispose();
                    }

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdValeSalida = ValeSalida.IdValeSalida, ex = "" });
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

        //public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal, string PendienteRemito = "", string PendienteFactura = "")
        //{
        //    string campo = String.Empty;
        //    int pageSize = rows ?? 20;
        //    int currentPage = page ?? 1;
        //    decimal cien = 100;

        //    var data = (from a in db.ValesSalidas
        //                from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
        //                from d in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
        //                from e in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
        //                from f in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioAnulacion).DefaultIfEmpty()
        //                from g in db.Empleados.Where(v => v.IdEmpleado == a.Aprobo).DefaultIfEmpty()
        //                from i in db.Condiciones_Compras.Where(v => v.IdCondicionCompra == a.IdCondicionVenta).DefaultIfEmpty()
        //                from j in db.ListasPrecios.Where(v => v.IdListaPrecios == a.IdListaPrecios).DefaultIfEmpty()
        //                select new
        //                {
        //                    a.IdValeSalida,
        //                    a.IdCliente,
        //                    a.IdObra,
        //                    a.IdCondicionVenta,
        //                    a.IdListaPrecios,
        //                    a.IdMoneda,
        //                    a.NumeroValeSalidaCliente,
        //                    a.NumeroValeSalida,
        //                    a.FechaValeSalida,
        //                    Producido = a.Estado,
        //                    // Case When Exists(Select Top 1 doc.IdValeSalida From DetalleValesSalida doc Where doc.IdValeSalida=ValesSalida.IdValeSalida and IsNull(doc.Cumplido,'NO')='NO') Then Null Else 'SI' End as [Cumplido],
        //                    Cumplido = "",
        //                    a.Anulada,
        //                    a.SeleccionadaParaFacturacion,
        //                    Obra = c != null ? c.NumeroObra : "",
        //                    ClienteCodigo = a.Cliente.CodigoCliente,
        //                    ClienteNombre = a.Cliente.RazonSocial,
        //                    ClienteCuit = a.Cliente.Cuit,
        //                    Aprobo = g != null ? g.Nombre : "",
        //                    //#Auxiliar3.Remitos as [Remitos],
        //                    Remitos = "",
        //                    //#Auxiliar5.Facturas as [Facturas],
        //                    Facturas = "",
        //                    CondicionVenta = i != null ? i.Descripcion : "",
        //                    // (Select Count(*) From DetalleValesSalida Where DetalleValesSalida.IdValeSalida=ValesSalida.IdValeSalida) as [Cant.Items],
        //                    Items = 0,
        //                    FacturarA = (a.AgrupacionFacturacion ?? 1) == 1 ? "Cliente" : ((a.AgrupacionFacturacion ?? 1) == 2 ? "Obra" : ((a.AgrupacionFacturacion ?? 1) == 3 ? "U.Operativa" : "")),
        //                    a.FechaAnulacion,
        //                    UsuarioAnulo = f != null ? f.Nombre : "",
        //                    a.FechaIngreso,
        //                    UsuarioIngreso = d != null ? d.Nombre : "",
        //                    a.FechaModifico,
        //                    UsuarioModifico = e != null ? e.Nombre : "",
        //                    GrupoFacturacion = (a.Agrupacion2Facturacion ?? 1) == 1 ? "Grupo 1" : ((a.Agrupacion2Facturacion ?? 1) == 2 ? "Grupo 2" : ((a.Agrupacion2Facturacion ?? 1) == 3 ? "Grupo 3" : "")),
        //                    //IsNull(#Auxiliar2.Automatica+' ','')+IsNull(#Auxiliar2.Manual,'') as [Tipo OC],
        //                    TipoOC = "",
        //                     //(Select Max(Det.FechaEntrega) From DetalleValesSalida Det Where Det.IdValeSalida=ValesSalida.IdValeSalida) as [Mayor fecha entrega],
        //                     MayorFechaEntrega = "",
        //                    ListaDePrecio = j != null ? "Lista " + j.NumeroLista.ToString() + " " + j.Descripcion : "",
        //                    a.PorcentajeBonificacion,
        //                    a.ImporteTotal,
        //                    Moneda = a.Moneda.Abreviatura,
        //                    a.Observaciones,
        //                    PendienteRemitir = PendienteRemito == "SI"
        //                                        ? ((db.DetalleValesSalidas.Where(x => x.IdValeSalida == a.IdValeSalida && (a.Anulada ?? "NO") != "SI")
        //                                            .Sum(y => ((y.TipoCancelacion ?? 1) == 1 ? y.Cantidad : 100) - (db.DetalleRemitos.Where(x => x.IdDetalleValeSalida == y.IdDetalleValeSalida && (x.Remito.Anulado ?? "NO") != "SI").Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.Cantidad : z.PorcentajeCertificacion)) ?? 0)
        //                                            )) ?? 0)
        //                                        : 1,
        //                    PendienteFacturar = PendienteFactura == "SI"
        //                                        ? (db.DetalleValesSalidas.Where(x => x.IdValeSalida == a.IdValeSalida && (a.Anulada ?? "NO") != "SI")
        //                                            .Sum(y => ((y.TipoCancelacion ?? 1) == 1 ? y.Cantidad : 100) -
        //                                                (db.DetalleFacturasValesSalidas.Where(x => x.IdDetalleValeSalida == y.IdDetalleValeSalida && (x.DetalleFactura.Factura.Anulada ?? "NO") != "SI").Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.DetalleFactura.Cantidad : z.DetalleFactura.PorcentajeCertificacion)) ?? 0) +
        //                                                (db.DetalleNotasCreditoValesSalidas.Where(x => x.IdDetalleValeSalida == y.IdDetalleValeSalida && (x.NotasCredito.Anulada ?? "NO") != "SI").Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.Cantidad : z.PorcentajeCertificacion)) ?? 0)
        //                                            )) ?? 0
        //                                        : 1
        //                }).AsQueryable();

        //    if (FechaInicial != string.Empty)
        //    {
        //        DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
        //        DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
        //        data = (from a in data where a.FechaValeSalida >= FechaDesde && a.FechaValeSalida <= FechaHasta select a).AsQueryable();
        //    }

        //    int totalRecords = data.Count();
        //    int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

        //    var data1 = (from a in data select a)
        //                .Where(x => (PendienteRemito != "SI" || (PendienteRemito == "SI" && x.PendienteRemitir > 0)) && (PendienteFactura != "SI" || (PendienteFactura == "SI" && x.PendienteFacturar > 0)))
        //                .OrderByDescending(x => x.NumeroValeSalida)
        //                
        //.Skip((currentPage - 1) * pageSize).Take(pageSize)
        //.ToList();

        //    var jsonData = new jqGridJson()
        //    {
        //        total = totalPages,
        //        page = currentPage,
        //        records = totalRecords,
        //        rows = (from a in data1
        //                select new jqGridRowJson
        //                {
        //                    id = a.IdValeSalida.ToString(),
        //                    cell = new string[] { 
        //                        "<a href="+ Url.Action("Edit",new {id = a.IdValeSalida} ) + ">Editar</>",
        //                        "<a href="+ Url.Action("Imprimir",new {id = a.IdValeSalida} ) + ">Emitir</a> ",
        //                        a.IdValeSalida.ToString(),
        //                        a.IdCliente.NullSafeToString(),
        //                        a.IdObra.NullSafeToString(),
        //                        a.IdCondicionVenta.NullSafeToString(),
        //                        a.IdListaPrecios.NullSafeToString(),
        //                        a.IdMoneda.NullSafeToString(),
        //                        a.NumeroValeSalidaCliente.NullSafeToString(),
        //                        a.NumeroValeSalida.NullSafeToString(),
        //                        a.FechaValeSalida == null ? "" : a.FechaValeSalida.GetValueOrDefault().ToString("dd/MM/yyyy"),
        //                        a.Producido.NullSafeToString(),
        //                        a.Cumplido.NullSafeToString(),
        //                        a.Anulada.NullSafeToString(),
        //                        a.SeleccionadaParaFacturacion.NullSafeToString(),
        //                        a.Obra.NullSafeToString(),
        //                        a.ClienteCodigo.NullSafeToString(),
        //                        a.ClienteNombre.NullSafeToString(),
        //                        a.ClienteCuit.NullSafeToString(),
        //                        a.Aprobo.NullSafeToString(),
        //                        a.Remitos.NullSafeToString(),
        //                        a.Facturas.NullSafeToString(),
        //                        a.CondicionVenta.NullSafeToString(),
        //                        db.DetalleValesSalidas.Where(x=>x.IdValeSalida==a.IdValeSalida).Select(x=>x.IdDetalleValeSalida).Distinct().Count().ToString(),
        //                        a.FacturarA.NullSafeToString(),
        //                        a.FechaAnulacion == null ? "" : a.FechaAnulacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
        //                        a.UsuarioAnulo.NullSafeToString(),
        //                        a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
        //                        a.UsuarioIngreso.NullSafeToString(),
        //                        a.FechaModifico == null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy"),
        //                        a.UsuarioModifico.NullSafeToString(),
        //                        a.GrupoFacturacion.NullSafeToString(),
        //                        a.TipoOC.NullSafeToString(),
        //                        a.MayorFechaEntrega.NullSafeToString(),
        //                        a.ListaDePrecio.NullSafeToString(),
        //                        a.PorcentajeBonificacion.NullSafeToString(),
        //                        a.ImporteTotal.NullSafeToString(),
        //                        a.Moneda.NullSafeToString(),
        //                        a.Observaciones.NullSafeToString()
        //                    }
        //                }).ToArray()
        //    };
        //    return Json(jsonData, JsonRequestBehavior.AllowGet);
        //}

        //public virtual ActionResult DetValesSalida(string sidx, string sord, int? page, int? rows, int? IdValeSalida)
        //{
        //    int IdValeSalida1 = IdValeSalida ?? 0;
        //    var Det = db.DetalleValesSalidas.Where(p => p.IdValeSalida == IdValeSalida1).AsQueryable();
        //    int pageSize = rows ?? 20;
        //    int totalRecords = Det.Count();
        //    int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
        //    int currentPage = page ?? 1;

        //    var data = (from a in Det
        //                from b in db.Colores.Where(o => o.IdColor == a.IdColor).DefaultIfEmpty()
        //                select new
        //                {
        //                    a.IdDetalleValeSalida,
        //                    a.IdArticulo,
        //                    a.IdUnidad,
        //                    a.IdColor,
        //                    a.OrigenDescripcion,
        //                    a.TipoCancelacion,
        //                    a.NumeroItem,
        //                    Codigo = a.Articulo.Codigo,
        //                    Articulo = a.Articulo.Descripcion + (b != null ? " " + b.Descripcion : ""),
        //                    a.Cantidad,
        //                    Unidad = a.Unidade.Abreviatura,
        //                    Precio = Math.Round((double)a.Precio, 2),
        //                    a.PorcentajeBonificacion,
        //                    Importe = Math.Round((double)a.Cantidad * (double)a.Precio * (double)(1 - (a.PorcentajeBonificacion ?? 0) / 100), 2),
        //                    TiposDeDescripcion = (a.OrigenDescripcion ?? 1) == 1 ? "Solo material" : ((a.OrigenDescripcion ?? 1) == 2 ? "Solo observaciones" : ((a.OrigenDescripcion ?? 1) == 3 ? "Material + observaciones" : "")),
        //                    TiposCancelacion = (a.TipoCancelacion ?? 1) == 1 ? "Por cantidad" : ((a.TipoCancelacion ?? 1) == 2 ? "Por certificacion" : ""),
        //                    a.FechaNecesidad,
        //                    a.FechaEntrega,
        //                    a.FacturacionAutomatica,
        //                    a.FechaComienzoFacturacion,
        //                    a.CantidadMesesAFacturar,
        //                    a.FacturacionCompletaMensual,
        //                    a.Observaciones
        //                }).OrderBy(x => x.NumeroItem)
        //.Skip((currentPage - 1) * pageSize).Take(pageSize)
        //.ToList();

        //    var jsonData = new jqGridJson()
        //    {
        //        total = totalPages,
        //        page = currentPage,
        //        records = totalRecords,
        //        rows = (from a in data
        //                select new jqGridRowJson
        //                {
        //                    id = a.IdDetalleValeSalida.ToString(),
        //                    cell = new string[] { 
        //                    string.Empty, 
        //                    a.IdDetalleValeSalida.ToString(), 
        //                    a.IdArticulo.NullSafeToString(),
        //                    a.IdUnidad.NullSafeToString(),
        //                    a.IdColor.NullSafeToString(),
        //                    a.OrigenDescripcion.NullSafeToString(),
        //                    a.TipoCancelacion.NullSafeToString(),
        //                    a.NumeroItem.NullSafeToString(),
        //                    a.Codigo.NullSafeToString(),
        //                    a.Articulo.NullSafeToString(),
        //                    a.Cantidad.NullSafeToString(),
        //                    a.Unidad.NullSafeToString(),
        //                    a.Precio.NullSafeToString(),
        //                    a.PorcentajeBonificacion.NullSafeToString(),
        //                    a.Importe.NullSafeToString(),
        //                    a.TiposDeDescripcion.NullSafeToString(),
        //                    a.TiposCancelacion.NullSafeToString(),
        //                    a.FechaNecesidad == null ? "" : a.FechaNecesidad.GetValueOrDefault().ToString("dd/MM/yyyy"),
        //                    a.FechaEntrega == null ? "" : a.FechaEntrega.GetValueOrDefault().ToString("dd/MM/yyyy"),
        //                    a.FacturacionAutomatica.NullSafeToString(),
        //                    a.FechaComienzoFacturacion == null ? "" : a.FechaComienzoFacturacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
        //                    a.CantidadMesesAFacturar.NullSafeToString(),
        //                    a.FacturacionCompletaMensual.NullSafeToString(),
        //                    a.Observaciones.NullSafeToString()
        //                    }
        //                }).ToArray()
        //    };
        //    return Json(jsonData, JsonRequestBehavior.AllowGet);
        //}




        public virtual JsonResult DetValesSalidaSinFormatoSegunListaDeItemsDeRequerimientos(List<int> idDetalleRequerimientos)
        {

            var vale = new ValesSalida();

            var reqs = db.DetalleRequerimientos.Where(x => idDetalleRequerimientos.Contains(x.IdDetalleRequerimiento));

            foreach (Data.Models.DetalleRequerimiento detrm in reqs)
            {
                var detvale = new DetalleValesSalida();
                detvale.IdArticulo = detrm.IdArticulo;
                detvale.IdDetalleRequerimiento = detrm.IdDetalleRequerimiento;
                detvale.Cantidad = detrm.Cantidad;
                vale.DetalleValesSalidas.Add(detvale);
            }



            var data = (from a in vale.DetalleValesSalidas
                        //from b in db.Unidades.Where(y => y.IdUnidad == a.IdUnidad).DefaultIfEmpty()
                        //from c in db.Obras.Where(y => y.IdObra == a.ValesSalida.IdObra).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleValeSalida,
                            a.IdValeSalida,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.ValesSalida.IdObra,
                            a.IdDetalleRequerimiento,
                            a.ValesSalida.NumeroValeSalida,
                            a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            a.DetalleRequerimiento.NumeroItem,
                            ArticuloCodigo = a.Articulo.Codigo,
                            ArticuloDescripcion = a.Articulo.Descripcion,
                            a.Cantidad,
                            Unidad = "",// db.Unidades.Where(y => y.IdUnidad == a.IdUnidad).DefaultIfEmpty() != null ? b.Abreviatura : "",
                            Obra = "", //db.Obras.Where(y => y.IdObra == a.ValesSalida.IdObra).DefaultIfEmpty() != null ? c.NumeroObra : "",
                            Entregado = db.DetalleSalidasMateriales.Where(x => x.IdDetalleValeSalida == a.IdDetalleValeSalida && (x.SalidasMateriale.Anulada ?? "") != "SI").Select(x => x.Cantidad).Sum().ToString(),
                            Pendiente = (a.Cantidad ?? 0) - (db.DetalleSalidasMateriales.Where(x => x.IdDetalleValeSalida == a.IdDetalleValeSalida && (x.SalidasMateriale.Anulada ?? "") != "SI").Select(x => x.Cantidad).Sum() ?? 0),
                            a.Partida
                        }).OrderBy(p => p.IdDetalleValeSalida).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }



        public virtual JsonResult DetValesSalidaSinFormato(int? IdValeSalida, int? IdDetalleValeSalida)
        {
            int IdValeSalida1 = IdValeSalida ?? 0;
            int IdDetalleValeSalida1 = IdDetalleValeSalida ?? 0;
            var Det = db.DetalleValesSalidas.Where(p => (IdValeSalida1 <= 0 || p.IdValeSalida == IdValeSalida1) && (IdDetalleValeSalida1 <= 0 || p.IdDetalleValeSalida == IdDetalleValeSalida1)).AsQueryable();

            var data = (from a in Det
                        from b in db.Unidades.Where(y => y.IdUnidad == a.IdUnidad).DefaultIfEmpty()
                        from c in db.Obras.Where(y => y.IdObra == a.ValesSalida.IdObra).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleValeSalida,
                            a.IdValeSalida,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.ValesSalida.IdObra,
                            a.IdDetalleRequerimiento,
                            a.ValesSalida.NumeroValeSalida,
                            a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            a.DetalleRequerimiento.NumeroItem,
                            ArticuloCodigo = a.Articulo.Codigo,
                            ArticuloDescripcion = a.Articulo.Descripcion,
                            a.Cantidad,
                            Unidad = b != null ? b.Abreviatura : "",
                            Obra = c != null ? c.NumeroObra : "",
                            Entregado = db.DetalleSalidasMateriales.Where(x => x.IdDetalleValeSalida==a.IdDetalleValeSalida && (x.SalidasMateriale.Anulada ?? "") != "SI").Select(x => x.Cantidad).Sum().ToString(),
                            Pendiente = (a.Cantidad ?? 0) - (db.DetalleSalidasMateriales.Where(x => x.IdDetalleValeSalida == a.IdDetalleValeSalida && (x.SalidasMateriale.Anulada ?? "") != "SI").Select(x => x.Cantidad).Sum() ?? 0),
                            a.Partida
                        }).OrderBy(p => p.IdDetalleValeSalida).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult ValesSalidaPendientesDeSalidaMateriales(string sidx, string sord, int? page, int? rows)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "ValesSalida_TX_PendientesDetallado", -1);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdValeSalida = a[0],
                            IdArticulo = a[1],
                            NumeroValeSalida = a[2],
                            FechaValeSalida = a[3],
                            ArticuloCodigo = a[4],
                            ArticuloDescripcion = a[5],
                            Cantidad = a[6],
                            Unidad = a[10],
                            Entregado = a[11],
                            Pendiente = a[12],
                            IdDetalleValeSalida = a[13],
                            Obra = a[16],
                            Aprobo = a[17],
                            Ubicacion = a[18],
                            Observaciones = a[19],
                            ObservacionesRM = a[20],
                            EquipoDestino = a[21]
                        }).OrderByDescending(s => s.NumeroValeSalida)
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
                            id = a.IdDetalleValeSalida.ToString(),
                            cell = new string[] { 
                                  "<a href="+ Url.Action("Edit",new {id = a.IdValeSalida} ) + "  >Editar</>" ,
                                a.IdDetalleValeSalida.NullSafeToString(),
                                a.IdValeSalida.NullSafeToString(), 
                                a.IdArticulo.NullSafeToString(), 
                                a.NumeroValeSalida.NullSafeToString(), 
                                a.FechaValeSalida == null || a.FechaValeSalida.ToString() == "" ? "" : Convert.ToDateTime(a.FechaValeSalida.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.ArticuloCodigo.NullSafeToString(), 
                                a.ArticuloDescripcion.NullSafeToString(), 
                                a.Cantidad.NullSafeToString(), 
                                a.Unidad.NullSafeToString(), 
                                a.Entregado.NullSafeToString(), 
                                a.Pendiente.NullSafeToString(), 
                                a.Obra.NullSafeToString(), 
                                a.Aprobo.NullSafeToString(), 
                                a.Ubicacion.NullSafeToString(), 
                                a.Observaciones.NullSafeToString(), 
                                a.ObservacionesRM.NullSafeToString(), 
                                a.EquipoDestino.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdValeSalida, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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

    }
}