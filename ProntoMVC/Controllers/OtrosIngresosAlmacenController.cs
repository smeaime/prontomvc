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
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace ProntoMVC.Controllers
{
    public partial class OtroIngresoAlmacenController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.OtrosIngresosAlmacen)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult Edit(int id)
        {
            OtrosIngresosAlmacen o;

            try
            {
                if (!PuedeLeer(enumNodos.OtrosIngresosAlmacen))
                {
                    o = new OtrosIngresosAlmacen();
                    CargarViewBag(o);
                    ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                    return View(o);
                }
            }
            catch (Exception)
            {
                o = new OtrosIngresosAlmacen();
                CargarViewBag(o);
                ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                return View(o);
            }

            if (id <= 0)
            {
                o = new OtrosIngresosAlmacen();
                inic(ref o);
                CargarViewBag(o);
                return View(o);
            }
            else
            {
                o = db.OtrosIngresosAlmacens.SingleOrDefault(x => x.IdOtroIngresoAlmacen == id);
                CargarViewBag(o);
                Session.Add("OtroIngresoAlmacen", o);
                return View(o);
            }
        }

        void CargarViewBag(OtrosIngresosAlmacen o)
        {
            ViewBag.Emitio = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.Emitio);
            ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.Aprobo);
        }

        void inic(ref OtrosIngresosAlmacen o)
        {
            o.FechaOtroIngresoAlmacen = DateTime.Today;
            o.TipoIngreso = 0;
        }

        private bool Validar(ProntoMVC.Data.Models.OtrosIngresosAlmacen o, ref string sErrorMsg, ref string sWarningMsg)
        {
            if (!PuedeEditar(enumNodos.OtrosIngresosAlmacen)) sErrorMsg += "\n" + "No tiene permisos de edición";

            Int32 mIdOtroIngresoAlmacen = 0;
            Int32 mNumero = 0;
            Int32 mIdArticulo = 0;
            Int32 mIdArticuloAnterior = 0;

            decimal mCantidad = 0;
            decimal mCantidadAnterior = 0;
            decimal mCantidadNeta = 0;
            decimal mStockGlobal = 0;

            string mObservaciones = "";
            string mAnulado = "";
            string mRegistrarStock = "";
            string mArticulo = "";

            DateTime mFechaOtroIngresoAlmacen = DateTime.Today;

            mIdOtroIngresoAlmacen = o.IdOtroIngresoAlmacen;
            mFechaOtroIngresoAlmacen = o.FechaOtroIngresoAlmacen ?? DateTime.MinValue;
            mNumero = o.NumeroOtroIngresoAlmacen ?? 0;
            mObservaciones = o.Observaciones ?? "";

            if ((o.NumeroOtroIngresoAlmacen ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número"; }
            
            var OtrosIngresosAlmacen = db.OtrosIngresosAlmacens.Where(x => x.NumeroOtroIngresoAlmacen == mNumero && x.IdOtroIngresoAlmacen != mIdOtroIngresoAlmacen).Select(x => x.IdOtroIngresoAlmacen).FirstOrDefault();
            if (OtrosIngresosAlmacen > 0) { sErrorMsg += "\n" + "El numero de ingreso ya existe."; }

            if (o.DetalleOtrosIngresosAlmacens.Count <= 0) sErrorMsg += "\n" + "El ingreso no tiene items";
            foreach (ProntoMVC.Data.Models.DetalleOtrosIngresosAlmacen x in o.DetalleOtrosIngresosAlmacens)
            {
                mIdArticulo = (x.IdArticulo ?? 0);
                mRegistrarStock = db.Articulos.Where(y => y.IdArticulo == mIdArticulo).Select(y => y.RegistrarStock).FirstOrDefault() ?? "";
                mCantidad = (x.Cantidad ?? 0);

                if (mIdArticulo == 0) { sErrorMsg += "\n" + "Hay items que no tienen articulo"; }
                if ((x.IdUnidad ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items sin unidad"; }
                if ((x.IdObra ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items sin obra"; }
                if ((x.IdUbicacion ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items sin ubicacion"; }
                if ((x.CostoUnitario ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items sin costo"; }
                if ((x.Cantidad ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items sin cantidad positiva"; }
            }

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
            sWarningMsg = sWarningMsg.Replace("\n", "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.OtrosIngresosAlmacen OtroIngresoAlmacen)
        {
            if (!PuedeEditar(enumNodos.OtrosIngresosAlmacen)) throw new Exception("No tenés permisos");

            try
            {
                Int32 mIdOtroIngresoAlmacen = 0;
                Int32 mNumero = 0;

                string errs = "";
                string warnings = "";
                string mWebService = "";

                bool mAnulado = false;

                string usuario = ViewBag.NombreUsuario;
                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                if (!Validar(OtroIngresoAlmacen, ref errs, ref warnings))
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
                        mIdOtroIngresoAlmacen = OtroIngresoAlmacen.IdOtroIngresoAlmacen;

                        if (mIdOtroIngresoAlmacen > 0)
                        {
                            var EntidadOriginal = db.OtrosIngresosAlmacens.Where(p => p.IdOtroIngresoAlmacen == mIdOtroIngresoAlmacen).SingleOrDefault();

                            var EntidadoEntry = db.Entry(EntidadOriginal);
                            EntidadoEntry.CurrentValues.SetValues(OtroIngresoAlmacen);

                            //////////////////////////////////////////////// ITEMS ////////////////////////////////////////////////
                            foreach (var d in OtroIngresoAlmacen.DetalleOtrosIngresosAlmacens)
                            {
                                var DetalleEntidadOriginal = EntidadOriginal.DetalleOtrosIngresosAlmacens.Where(c => c.IdDetalleOtroIngresoAlmacen == d.IdDetalleOtroIngresoAlmacen && d.IdDetalleOtroIngresoAlmacen > 0).SingleOrDefault();
                                if (DetalleEntidadOriginal != null)
                                {
                                    // Restaurar stock 
                                    Stock Stock = db.Stocks.Where(
                                        c => c.IdArticulo == DetalleEntidadOriginal.IdArticulo &&
                                             (c.Partida ?? "") == (DetalleEntidadOriginal.Partida ?? "") &&
                                             (c.IdUbicacion ?? 0) == (DetalleEntidadOriginal.IdUbicacion ?? 0) &&
                                             (c.IdObra ?? 0) == (DetalleEntidadOriginal.IdObra ?? 0) &&
                                             (c.IdUnidad ?? 0) == (DetalleEntidadOriginal.IdUnidad ?? 0) &&
                                             //(c.NumeroCaja ?? 0) == (DetalleEntidadOriginal.NumeroCaja ?? 0) &&
                                             (c.IdColor ?? 0) == (DetalleEntidadOriginal.IdColor ?? 0) &&
                                             (c.Talle ?? "") == (DetalleEntidadOriginal.Talle ?? "")
                                    ).FirstOrDefault();
                                    if (Stock != null)
                                    {
                                        Stock.CantidadUnidades = (Stock.CantidadUnidades ?? 0) - (DetalleEntidadOriginal.Cantidad ?? 0);
                                        db.Entry(Stock).State = System.Data.Entity.EntityState.Modified;
                                    }
                                    else
                                    {
                                        Stock = new Stock();
                                        Stock.IdArticulo = DetalleEntidadOriginal.IdArticulo;
                                        Stock.Partida = DetalleEntidadOriginal.Partida ?? "";
                                        Stock.IdUbicacion = DetalleEntidadOriginal.IdUbicacion ?? 0;
                                        Stock.IdObra = DetalleEntidadOriginal.IdObra ?? 0;
                                        Stock.IdUnidad = DetalleEntidadOriginal.IdUnidad ?? 0;
                                        //Stock.NumeroCaja = DetalleEntidadOriginal.NumeroCaja ?? 0;
                                        Stock.IdColor = DetalleEntidadOriginal.IdColor ?? 0;
                                        Stock.Talle = DetalleEntidadOriginal.Talle ?? "";
                                        Stock.CantidadUnidades = (DetalleEntidadOriginal.Cantidad ?? 0) * -1;
                                        db.Stocks.Add(Stock);
                                    }

                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    EntidadOriginal.DetalleOtrosIngresosAlmacens.Add(d);
                                }
                            }
                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleOtrosIngresosAlmacens.Where(c => c.IdDetalleOtroIngresoAlmacen != 0).ToList())
                            {
                                if (!OtroIngresoAlmacen.DetalleOtrosIngresosAlmacens.Any(c => c.IdDetalleOtroIngresoAlmacen == DetalleEntidadOriginal.IdDetalleOtroIngresoAlmacen))
                                {
                                    EntidadOriginal.DetalleOtrosIngresosAlmacens.Remove(DetalleEntidadOriginal);
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
                            if (parametros2 != null)
                            {
                                mNumero = parametros2.ProximoNumeroOtroIngresoAlmacen ?? 1;
                                OtroIngresoAlmacen.NumeroOtroIngresoAlmacen = mNumero;
                                parametros2.ProximoNumeroOtroIngresoAlmacen = mNumero + 1;
                                db.Entry(parametros2).State = System.Data.Entity.EntityState.Modified;
                            }

                            db.OtrosIngresosAlmacens.Add(OtroIngresoAlmacen);
                            db.SaveChanges();
                        }

                        //////////////////////////////////////////////  STOCK  //////////////////////////////////////////////
                        if (!mAnulado)
                        {
                            // Registrar stock
                            foreach (var d in OtroIngresoAlmacen.DetalleOtrosIngresosAlmacens)
                            {
                                Stock Stock = db.Stocks.Where(
                                    c => c.IdArticulo == d.IdArticulo &&
                                         (c.Partida ?? "") == (d.Partida ?? "") &&
                                         (c.IdUbicacion ?? 0) == (d.IdUbicacion ?? 0) &&
                                         (c.IdObra ?? 0) == (d.IdObra ?? 0) &&
                                         (c.IdUnidad ?? 0) == (d.IdUnidad ?? 0) &&
                                         //(c.NumeroCaja ?? 0) == (d.NumeroCaja ?? 0) &&
                                         (c.IdColor ?? 0) == (d.IdColor ?? 0) &&
                                         (c.Talle ?? "") == (d.Talle ?? "")
                                ).FirstOrDefault();
                                if (Stock != null)
                                {
                                    Stock.CantidadUnidades = (Stock.CantidadUnidades ?? 0) + (d.Cantidad ?? 0);
                                    db.Entry(Stock).State = System.Data.Entity.EntityState.Modified;
                                }
                                else
                                {
                                    Stock = new Stock();
                                    Stock.IdArticulo = d.IdArticulo;
                                    Stock.Partida = d.Partida ?? "";
                                    Stock.IdUbicacion = d.IdUbicacion ?? 0;
                                    Stock.IdObra = d.IdObra ?? 0;
                                    Stock.IdUnidad = d.IdUnidad ?? 0;
                                    //Stock.NumeroCaja = d.NumeroCaja ?? 0;
                                    Stock.IdColor = d.IdColor ?? 0;
                                    Stock.Talle = d.Talle ?? "";
                                    Stock.CantidadUnidades = (d.Cantidad ?? 0);
                                    db.Stocks.Add(Stock);
                                }
                            }
                            db.SaveChanges();
                            db.Tree_TX_Actualizar("OtrosIngresosAlmacenAgrupados", OtroIngresoAlmacen.IdOtroIngresoAlmacen, "OtroIngresoAlmacen");
                        }

                        scope.Complete();
                        scope.Dispose();
                    }

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdOtroIngresoAlmacen = OtroIngresoAlmacen.IdOtroIngresoAlmacen, ex = "" });
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

        public virtual FileResult ImprimirConPlantillaEXE_PDF(int id)
        {
            string DirApp = AppDomain.CurrentDomain.BaseDirectory;
            string output = DirApp + "Documentos\\" + "archivo.pdf";
            string plantilla = DirApp + "Documentos\\" + "OtrosIngresosAlmacen_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var s = new ServicioMVC.servi(SC);
            string mensajeError;
            s.ImprimirConPlantillaEXE(id, SC, DirApp, plantilla, output, out mensajeError);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            string nombrearchivo = "OtrosIngresosAlmacen.pdf";
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, nombrearchivo);
        }

        public virtual FileResult ImprimirConPlantillaEXE(int id)
        {
            string DirApp = AppDomain.CurrentDomain.BaseDirectory;
            string output = DirApp + "Documentos\\" + "archivo.doc";
            string plantilla = DirApp + "Documentos\\" + "OtrosIngresosAlmacen_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var s = new ServicioMVC.servi(SC);
            string mensajeError;
            s.ImprimirConPlantillaEXE(id, SC, DirApp, plantilla, output, out mensajeError);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            string nombrearchivo = "OtrosIngresosAlmacen.doc";
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, nombrearchivo);
        }

        public virtual FileResult ImprimirConInteropPDF(int id)
        {
            object nulo = null;
            string baseP = this.HttpContext.Session["BasePronto"].ToString();
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.pdf";
            string plantilla;
            plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "OtrosIngresosAlmacen_" + baseP + ".dotm";

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            EntidadManager.ImprimirWordDOT_VersionDLL_PDF(plantilla, ref nulo, SC, nulo, ref nulo, id, nulo, nulo, nulo, output, nulo);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "OtrosIngresosAlmacen.pdf");
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var data = (from a in db.OtrosIngresosAlmacens
                        from b in db.Empleados.Where(y => y.IdEmpleado == a.Emitio).DefaultIfEmpty()
                        from c in db.Empleados.Where(y => y.IdEmpleado == a.Aprobo).DefaultIfEmpty()
                        from d in db.Empleados.Where(y => y.IdEmpleado == a.IdAutorizaAnulacion).DefaultIfEmpty()
                        select new
                        {
                            a.IdOtroIngresoAlmacen,
                            a.Emitio,
                            a.Aprobo,
                            a.TipoIngreso,
                            a.NumeroOtroIngresoAlmacen,
                            a.FechaOtroIngresoAlmacen,
                            TipoOtroIngresoAlmacen = (a.TipoIngreso ?? 0) == 0 ? "Devolucion de fabrica" : ((a.TipoIngreso ?? 0) == 1 ? "Devolucion prestamo" : ((a.TipoIngreso ?? 0) == 2 ? "Devolucion muestra" : ((a.TipoIngreso ?? 0) == 3 ? "Devolucion de obra" : ((a.TipoIngreso ?? 0) == 4 ? "Otros ingresos" : "")))),
                            a.Anulado,
                            EmitioNombre = b != null ? b.Nombre : "",
                            AproboNombre = c != null ? c.Nombre : "",
                            Anulo = d != null ? d.Nombre : "",
                            a.FechaAnulacion,
                            //(Select Count(*) From DetalleRemitos df Where df.IdRemito=Remitos.IdRemito) as [Cant.Items],
                            CantidadItems = 0,
                            a.Observaciones
                            //dbo.OtrosIngresosAlmacen_SolicitudesDeMateriales(OtrosIngresosAlmacen.IdOtroIngresoAlmacen)as [Solicitudes de materiales],
                        }).AsQueryable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaOtroIngresoAlmacen >= FechaDesde && a.FechaOtroIngresoAlmacen <= FechaHasta select a).AsQueryable();
            }

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .OrderByDescending(x => x.NumeroOtroIngresoAlmacen)
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
                            id = a.IdOtroIngresoAlmacen.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdOtroIngresoAlmacen} ) + ">Editar</>",
                                "<a href="+ Url.Action("ImprimirConPlantillaEXE_PDF",new {id = a.IdOtroIngresoAlmacen} ) + ">Emitir</a> ",
                                a.IdOtroIngresoAlmacen.ToString(),
                                a.Emitio.NullSafeToString(),
                                a.Aprobo.NullSafeToString(),
                                a.TipoIngreso.NullSafeToString(),
                                a.NumeroOtroIngresoAlmacen.NullSafeToString(),
                                a.FechaOtroIngresoAlmacen.NullSafeToString(),
                                a.TipoOtroIngresoAlmacen.NullSafeToString(),
                                a.EmitioNombre.NullSafeToString(),
                                a.AproboNombre.NullSafeToString(),
                                a.Anulo.NullSafeToString(),
                                a.FechaAnulacion.NullSafeToString(),
                                db.DetalleOtrosIngresosAlmacens.Where(x=>x.IdOtroIngresoAlmacen==a.IdOtroIngresoAlmacen).Select(x=>x.IdDetalleOtroIngresoAlmacen).Distinct().Count().ToString(),
                                a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public class OtrosIngresosAlmacens2
        {
            public int IdOtroIngresoAlmacen { get; set; }
            public int? Emitio { get; set; }
            public int? Aprobo { get; set; }
            public int? TipoIngreso { get; set; }
            public int? NumeroOtroIngresoAlmacen { get; set; }
            public DateTime? FechaOtroIngresoAlmacen { get; set; }
            public string TipoOtroIngresoAlmacen { get; set; }
            public string EmitioNombre { get; set; }
            public string AproboNombre { get; set; }
            public string Anulado { get; set; }
            public string Anulo { get; set; }
            public DateTime? FechaAnulacion { get; set; }
            public string Observaciones { get; set; }
            public int? CantidadItems { get; set; }
        }

        public virtual ActionResult OtrosIngresosAlmacen_DynamicGridData
                (string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal)
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

            var data = (from a in db.OtrosIngresosAlmacens
                        from b in db.Empleados.Where(o => o.IdEmpleado == a.Emitio).DefaultIfEmpty()
                        from c in db.Empleados.Where(o => o.IdEmpleado == a.Aprobo).DefaultIfEmpty()
                        from d in db.Empleados.Where(o => o.IdEmpleado == a.IdAutorizaAnulacion).DefaultIfEmpty()
                        select new OtrosIngresosAlmacens2
                        {
                            IdOtroIngresoAlmacen = a.IdOtroIngresoAlmacen,
                            Emitio = a.Emitio,
                            Aprobo = a.Aprobo,
                            TipoIngreso = a.TipoIngreso,
                            NumeroOtroIngresoAlmacen = a.NumeroOtroIngresoAlmacen,
                            FechaOtroIngresoAlmacen = a.FechaOtroIngresoAlmacen,
                            TipoOtroIngresoAlmacen = ((a.TipoIngreso ?? 0) == 0 ? "Devolucion de fabrica" : ((a.TipoIngreso ?? 0) == 1 ? "Devolucion prestamo" : ((a.TipoIngreso ?? 0) == 2 ? "Devolucion muestra" : ((a.TipoIngreso ?? 0) == 3 ? "Devolucion de obra" : ((a.TipoIngreso ?? 0) == 4 ? "Otros ingresos" : ""))))),
                            EmitioNombre = b != null ? b.Nombre : "",
                            AproboNombre = c != null ? c.Nombre : "",
                            Anulado = a.Anulado,
                            Anulo = d != null ? d.Nombre : "",
                            FechaAnulacion = a.FechaAnulacion,
                            Observaciones = a.Observaciones,
                            CantidadItems = a.DetalleOtrosIngresosAlmacens.Where(x => x.IdOtroIngresoAlmacen == a.IdOtroIngresoAlmacen).Count()
                        }).Where(a => a.FechaOtroIngresoAlmacen >= FechaDesde && a.FechaOtroIngresoAlmacen <= FechaHasta).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<OtrosIngresosAlmacens2>
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
                            id = a.IdOtroIngresoAlmacen.ToString(),
                            cell = new string[] {
                                "<a href="+ Url.Action("Edit",new {id = a.IdOtroIngresoAlmacen} ) + "  >Editar</>" ,
                                "<a href="+ Url.Action("ImprimirConPlantillaEXE",new {id = a.IdOtroIngresoAlmacen} )  +">Emitir</>" ,
                                a.IdOtroIngresoAlmacen.ToString(),
                                a.Emitio.NullSafeToString(),
                                a.Aprobo.NullSafeToString(),
                                a.TipoIngreso.NullSafeToString(),
                                a.NumeroOtroIngresoAlmacen.NullSafeToString(),
                                a.FechaOtroIngresoAlmacen==null ? "" :  a.FechaOtroIngresoAlmacen.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.TipoOtroIngresoAlmacen.NullSafeToString(),
                                a.EmitioNombre.NullSafeToString(),
                                a.AproboNombre.NullSafeToString(),
                                a.Anulado.NullSafeToString(),
                                a.Anulo.NullSafeToString(),
                                a.FechaAnulacion==null ? "" :  a.FechaAnulacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Observaciones.NullSafeToString(),
                                a.CantidadItems.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetOtroIngresoAlmacen(string sidx, string sord, int? page, int? rows, int? IdOtroIngresoAlmacen)
        {
            int IdOtroIngresoAlmacen1 = IdOtroIngresoAlmacen ?? 0;
            var Det = db.DetalleOtrosIngresosAlmacens.Where(p => p.IdOtroIngresoAlmacen == IdOtroIngresoAlmacen1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Articulos.Where(o => o.IdArticulo == a.IdArticulo).DefaultIfEmpty()
                        from c in db.Colores.Where(o => o.IdColor == a.IdColor).DefaultIfEmpty()
                        from d in db.Ubicaciones.Where(o => o.IdUbicacion == a.IdUbicacion).DefaultIfEmpty()
                        from e in db.Depositos.Where(o => o.IdDeposito == d.IdDeposito).DefaultIfEmpty()
                        from f in db.Unidades.Where(o => o.IdUnidad == a.IdUnidad).DefaultIfEmpty()
                        from g in db.Obras.Where(o => o.IdObra == a.IdObra).DefaultIfEmpty()
                        from h in db.Monedas.Where(o => o.IdMoneda == a.IdMoneda).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleOtroIngresoAlmacen,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdColor,
                            a.IdUbicacion,
                            a.IdObra,
                            a.IdMoneda,
                            Codigo = b.Codigo != null ? b.Codigo : "",
                            Articulo = (b.Descripcion != null ? b.Descripcion : "") + (c != null ? " " + c.Descripcion : ""),
                            a.Cantidad,
                            Unidad = f.Abreviatura != null ? f.Abreviatura : "",
                            a.Partida,
                            Obra = g.NumeroObra != null ? g.NumeroObra : "",
                            Ubicacion = (e != null ? e.Abreviatura : "") + (d.Descripcion != null ? " " + d.Descripcion : "") + (d.Estanteria != null ? " Est.:" + d.Estanteria : "") + (d.Modulo != null ? " Mod.:" + d.Modulo : "") + (d.Gabeta != null ? " Gab.:" + d.Gabeta : ""),
                            a.CostoUnitario,
                            Moneda = h.Abreviatura != null ? h.Abreviatura : "",
                            a.Observaciones,
                        }).OrderBy(x => x.IdDetalleOtroIngresoAlmacen)
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
                            id = a.IdDetalleOtroIngresoAlmacen.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleOtroIngresoAlmacen.ToString(), 
                            a.IdArticulo.NullSafeToString(),
                            a.IdUnidad.NullSafeToString(),
                            a.IdColor.NullSafeToString(),
                            a.IdUbicacion.NullSafeToString(),
                            a.IdObra.NullSafeToString(),
                            a.IdMoneda.NullSafeToString(),
                            a.Codigo.NullSafeToString(),
                            a.Articulo.NullSafeToString(),
                            a.Cantidad.NullSafeToString(),
                            a.Unidad.NullSafeToString(),
                            a.Partida.NullSafeToString(),
                            a.Obra.NullSafeToString(),
                            a.Ubicacion.NullSafeToString(),
                            a.CostoUnitario.NullSafeToString(),
                            a.Moneda.NullSafeToString(),
                            a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdOtroIngresoAlmacen, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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

    }

}