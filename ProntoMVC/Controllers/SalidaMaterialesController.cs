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
    public partial class SalidaMaterialesController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.SalidaMateriales)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult Edit(int id)
        {
            SalidasMateriale o;

            try
            {
                if (!PuedeLeer(enumNodos.SalidaMateriales))
                {
                    o = new SalidasMateriale();
                    CargarViewBag(o);
                    ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                    return View(o);
                }
            }
            catch (Exception)
            {
                o = new SalidasMateriale();
                CargarViewBag(o);
                ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                return View(o);
            }

            if (id <= 0)
            {
                o = new SalidasMateriale();
                inic(ref o);
                CargarViewBag(o);
                return View(o);
            }
            else
            {
                o = db.SalidasMateriales.Include(x => x.DetalleSalidasMateriales).SingleOrDefault(x => x.IdSalidaMateriales == id);
                CargarViewBag(o);
                Session.Add("SalidaMateriales", o);
                return View(o);
            }
        }

        void CargarViewBag(SalidasMateriale o)
        {
            Int32 mIdMonedaPesos = 1;
            Int32 mIdMonedaDolar = 0;
            Int32 mIdMonedaEuro = 0;

            ViewBag.IdObraOrigen = new SelectList(db.Obras.OrderBy(x => x.NumeroObra), "IdObra", "NumeroObra", o.IdObraOrigen);
            ViewBag.IdObra = new SelectList(db.Obras.OrderBy(x => x.NumeroObra), "IdObra", "NumeroObra", o.IdObra);
            ViewBag.IdTransportista1 = new SelectList(db.Transportistas, "IdTransportista", "RazonSocial", o.IdTransportista1);
            ViewBag.Emitio = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.Emitio);
            ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.Aprobo);
            ViewBag.IdTarifaFlete = new SelectList(db.TarifasFletes, "IdEmpleado", "Nombre", o.IdTarifaFlete);

            string mProntoIni_OpcionesAdicionales = "";
            int mAuxI1 = 0;
            Dictionary<int, string> TiposSalida = new Dictionary<int, string>();
            TiposSalida.Add(0, "A Fabrica");
            TiposSalida.Add(1, "A Obra");
            TiposSalida.Add(2, "A Proveedor");
            mProntoIni_OpcionesAdicionales = BuscarClaveINI("Opciones adicionales para salida de materiales", -1) ?? "";
            if (mProntoIni_OpcionesAdicionales.Length > 0)
            {
                mAuxI1 = 3;
                string[] Opciones = mProntoIni_OpcionesAdicionales.Split(',');
                foreach (string Opcion in Opciones)
                {
                    TiposSalida.Add(mAuxI1, Opcion);
                    mAuxI1 = mAuxI1 + 1;
                }
            }
            ViewBag.ProntoIni_OpcionesAdicionales = mProntoIni_OpcionesAdicionales;
            ViewBag.TipoSalida = new SelectList(TiposSalida, "Key", "Value", o.TipoSalida);

            ViewBag.ProntoIni_OcultarCosto = BuscarClaveINI("Ocultar costo en salida de materiales") ?? "";
            ViewBag.ProntoIni_OcultarEquipoDestino_OT = BuscarClaveINI("Ocultar equipo destino y OT") ?? "";
            ViewBag.ProntoIni_TipoDeCosto = BuscarClaveINI("Costo para salida de materiales") ?? "";
            ViewBag.ProntoIni_ActivarFechaImputacion = BuscarClaveINI("Activar fecha de imputacion en salida de materiales") ?? "";
            ViewBag.ProntoIni_ExigirEquipoDestino = BuscarClaveINI("Exigir equipo destino en salida de materiales") ?? "";
            ViewBag.ProntoIni_PermitirImputarTodosLosEquipoDestino = BuscarClaveINI("Permitir imputar todos los equipos en salida de materiales") ?? "";
            ViewBag.ProntoIni_OTsDesdeMantenimiento = BuscarClaveINI("OTs desde Mantenimiento") ?? "";

            Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mIdMonedaPesos = parametros.IdMoneda ?? 1;
            mIdMonedaDolar = parametros.IdMonedaDolar ?? 0;
            mIdMonedaEuro = parametros.IdMonedaEuro ?? 0;

            ViewBag.IdMonedaPesos = mIdMonedaPesos;
            ViewBag.IdMonedaDolar = mIdMonedaDolar;
            ViewBag.IdMonedaEuro = mIdMonedaEuro;
        }

        void inic(ref SalidasMateriale o)
        {
            o.FechaSalidaMateriales = DateTime.Today;
            //o.TipoSalida = -1;
        }

        private bool Validar(ProntoMVC.Data.Models.SalidasMateriale o, ref string sErrorMsg, ref string sWarningMsg)
        {
            if (!PuedeEditar(enumNodos.SalidaMateriales)) sErrorMsg += "\n" + "No tiene permisos de edición";

            Int32 mIdSalidaMateriales = 0;
            Int32 mNumero1 = 0;
            Int32 mNumero2 = 0;
            Int32 mIdProveedor = 0;
            Int32 mIdTipoComprobante = 50;
            Int32 mIdArticulo = 0;
            Int32 mIdRubro = 0;
            Int32 mNumeroPedido = 0;
            Int32 mNumeroItemPE = 0;
            Int32 mIdDetalleValeSalida = 0;

            decimal mCantidad = 0;
            decimal mCantidadNeta = 0;
            decimal mCantidadPedida = 0;
            decimal mCantidadEntregada = 0;
            decimal mStockGlobal = 0;

            string mObservaciones = "";
            string mProntoIni_InhabilitarUbicaciones = "";
            string mAnulada = "";
            string mRegistrarStock = "";
            string mArticulo = "";

            DateTime mFechaSalidaMateriales = DateTime.Today;

            mIdSalidaMateriales = o.IdSalidaMateriales;
            mFechaSalidaMateriales = o.FechaSalidaMateriales ?? DateTime.MinValue;
            mNumero1 = o.NumeroSalidaMateriales2 ?? 0;
            mNumero2 = o.NumeroSalidaMateriales ?? 0;
            mIdProveedor = o.IdProveedor ?? 0;
            mObservaciones = o.Observaciones ?? "";
            mAnulada = o.Anulada ?? "";

            if ((o.NumeroSalidaMateriales2 ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número de sucursal"; }
            if ((o.NumeroSalidaMateriales ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número de salida"; }
            if ((o.IdObra ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la obra"; }

            //SalidasMateriale SalidaMateriales = db.SalidasMateriales.Where(c => (c.NumeroSalidaMateriales2 ?? 0) == mNumero1 && (c.NumeroSalidaMateriales ?? 0) == mNumero2).FirstOrDefault();
            //if (SalidaMateriales != null) { sErrorMsg += "\n" + "Salida ya ingresada"; }

            mProntoIni_InhabilitarUbicaciones = BuscarClaveINI("Inhabilitar ubicaciones en movimientos de stock", -1) ?? "";

            if (o.DetalleSalidasMateriales.Count <= 0) sErrorMsg += "\n" + "La Salida no tiene items";
            foreach (ProntoMVC.Data.Models.DetalleSalidasMateriale x in o.DetalleSalidasMateriales)
            {
                mIdArticulo = (x.IdArticulo ?? 0);
                mCantidad = x.Cantidad ?? 0;
                mIdDetalleValeSalida = x.IdDetalleValeSalida ?? 0;

                if (mIdArticulo == 0) { sErrorMsg += "\n" + "Hay items que no tienen articulo"; }
                if ((x.IdObra ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items sin obra"; }
                if ((x.IdUbicacion ?? 0) <= 0 && mProntoIni_InhabilitarUbicaciones != "SI") { sErrorMsg += "\n" + "Hay items sin ubicacion"; }
                if (mCantidad <= 0) { sErrorMsg += "\n" + "Hay items que no tienen la cantidad mayor a cero"; }
                if ((x.IdMoneda ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items sin moneda"; }
                if ((x.CostoUnitario ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items sin costo"; }

                mIdRubro = db.Articulos.Where(y => y.IdArticulo == x.IdArticulo).Select(y => y.IdRubro).FirstOrDefault() ;
            }

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
            sWarningMsg = sWarningMsg.Replace("\n", "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.SalidasMateriale SalidaMateriales)
        {
            if (!PuedeEditar(enumNodos.SalidaMateriales)) throw new Exception("No tenés permisos");

            try
            {
                Int32 mIdSalidaMateriales = 0;
                Int32 mNumero = 0;
                Int32 mIdTipoComprobante = 50;
                Int32 mIdDetalleRequerimiento = 0;
                Int32 mTipoSalida = -1;
                Int32 mAuxI1 = 0;

                decimal mCostoUnitario = 0;

                string errs = "";
                string warnings = "";
                string mAuxS1 = "";
                string mControlar = "";
                string mRegistrarStock = "";

                DateTime mFechaSalidaMateriales = DateTime.MinValue;

                bool mAnulada = false;

                string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

                string usuario = ViewBag.NombreUsuario;
                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                if (SalidaMateriales.IdSalidaMateriales > 0)
                {
                    SalidaMateriales.IdUsuarioModifico = IdUsuario;
                    SalidaMateriales.FechaModifico = DateTime.Now;
                }
                else
                {
                    SalidaMateriales.IdUsuarioIngreso = IdUsuario;
                    SalidaMateriales.FechaIngreso = DateTime.Now;
                }

                if (!Validar(SalidaMateriales, ref errs, ref warnings))
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
                        mIdSalidaMateriales = SalidaMateriales.IdSalidaMateriales;
                        if (SalidaMateriales.Anulada == "SI") { mAnulada = true; }
                        mFechaSalidaMateriales = SalidaMateriales.FechaSalidaMateriales ?? DateTime.MinValue;
                        mTipoSalida = SalidaMateriales.TipoSalida ?? 0;

                        if (mIdSalidaMateriales > 0)
                        {
                            var EntidadOriginal = db.SalidasMateriales.Where(p => p.IdSalidaMateriales == mIdSalidaMateriales).SingleOrDefault();

                            var EntidadoEntry = db.Entry(EntidadOriginal);
                            EntidadoEntry.CurrentValues.SetValues(SalidaMateriales);

                            //////////////////////////////////////////////// ITEMS ////////////////////////////////////////////////
                            foreach (var d in SalidaMateriales.DetalleSalidasMateriales)
                            {
                                var DetalleEntidadOriginal = EntidadOriginal.DetalleSalidasMateriales.Where(c => c.IdDetalleSalidaMateriales == d.IdDetalleSalidaMateriales && d.IdDetalleSalidaMateriales > 0).SingleOrDefault();
                                if (DetalleEntidadOriginal != null)
                                {
                                    mRegistrarStock = db.Articulos.Where(y => y.IdArticulo == d.IdArticulo).Select(y => y.RegistrarStock).FirstOrDefault() ?? "SI";
                                    if (mRegistrarStock == "SI")
                                    {
                                        // Subir stock 
                                        Stock Stock = db.Stocks.Where(
                                            c => c.IdArticulo == DetalleEntidadOriginal.IdArticulo &&
                                                 (c.Partida ?? "") == (DetalleEntidadOriginal.Partida ?? "") &&
                                                 (c.IdUbicacion ?? 0) == (DetalleEntidadOriginal.IdUbicacion ?? 0) &&
                                                 (c.IdObra ?? 0) == (DetalleEntidadOriginal.IdObra ?? 0) &&
                                                 (c.IdUnidad ?? 0) == (DetalleEntidadOriginal.IdUnidad ?? 0) &&
                                                 (c.NumeroCaja ?? 0) == (DetalleEntidadOriginal.NumeroCaja ?? 0) &&
                                                 (c.IdColor ?? 0) == (DetalleEntidadOriginal.IdColor ?? 0) &&
                                                 (c.Talle ?? "") == (DetalleEntidadOriginal.Talle ?? "")
                                        ).FirstOrDefault();
                                        if (Stock != null)
                                        {
                                            Stock.CantidadUnidades = (Stock.CantidadUnidades ?? 0) + (DetalleEntidadOriginal.Cantidad ?? 0);
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
                                            Stock.NumeroCaja = DetalleEntidadOriginal.NumeroCaja ?? 0;
                                            Stock.IdColor = DetalleEntidadOriginal.IdColor ?? 0;
                                            Stock.Talle = DetalleEntidadOriginal.Talle ?? "";
                                            Stock.CantidadUnidades = (DetalleEntidadOriginal.Cantidad ?? 0);
                                            db.Stocks.Add(Stock);
                                        }
                                    }

                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    EntidadOriginal.DetalleSalidasMateriales.Add(d);
                                }
                            }
                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleSalidasMateriales.Where(c => c.IdDetalleSalidaMateriales != 0).ToList())
                            {
                                if (!SalidaMateriales.DetalleSalidasMateriales.Any(c => c.IdDetalleSalidaMateriales == DetalleEntidadOriginal.IdDetalleSalidaMateriales))
                                {
                                    EntidadOriginal.DetalleSalidasMateriales.Remove(DetalleEntidadOriginal);
                                    db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
                            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        else
                        {
                            mNumero = SalidaMateriales.NumeroSalidaMateriales ?? 1;
                            if (mTipoSalida <= 2)
                            {
                                Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
                                if (parametros != null)
                                {
                                    if (mTipoSalida == 0 || mTipoSalida == 2)
                                    {
                                        mNumero = parametros.ProximoNumeroSalidaMateriales ?? 1;
                                        parametros.ProximoNumeroSalidaMateriales = mNumero + 1;
                                    }
                                    else
                                    {
                                        mNumero = parametros.ProximoNumeroSalidaMaterialesAObra ?? 1;
                                        parametros.ProximoNumeroSalidaMaterialesAObra = mNumero + 1;
                                    }
                                    db.Entry(parametros).State = System.Data.Entity.EntityState.Modified;
                                }
                                else
                                {
                                    Parametros2 Parametros2;
                                    mAuxI1 = 3;
                                    string mProntoIni_OpcionesAdicionales = BuscarClaveINI("Opciones adicionales para salida de materiales", -1) ?? "";
                                    if (mProntoIni_OpcionesAdicionales.Length > 0)
                                    {
                                        string[] Opciones = mProntoIni_OpcionesAdicionales.Split(',');
                                        foreach (string Opcion in Opciones)
                                        {
                                            if (mAuxI1 == mTipoSalida)
                                            {
                                                Parametros2 = db.Parametros2.Where(p => p.Campo == Opcion + "_2").FirstOrDefault();
                                                if (Parametros2 == null)
                                                {
                                                    Parametros2 = new Parametros2();
                                                    Parametros2.Campo = Opcion + "_2";
                                                    Parametros2.Valor = Convert.ToString(SalidaMateriales.NumeroSalidaMateriales2);
                                                    db.Parametros2.Add(Parametros2);
                                                }

                                                Parametros2 = db.Parametros2.Where(p => p.Campo == Opcion + "_1").FirstOrDefault();
                                                if (Parametros2 != null)
                                                {
                                                    mNumero = Convert.ToInt32(Parametros2.Valor ?? "1");
                                                    Parametros2.Valor = Convert.ToString(mNumero + 1);
                                                    db.Entry(Parametros2).State = System.Data.Entity.EntityState.Modified;
                                                }
                                                else
                                                {
                                                    mNumero = 1;
                                                    Parametros2 = new Parametros2();
                                                    Parametros2.Campo = Opcion + "_1";
                                                    Parametros2.Valor = "2";
                                                    db.Parametros2.Add(Parametros2);
                                                }
                                            }
                                            mAuxI1 = mAuxI1 + 1;
                                        }
                                    }
                                }
                            }
                            SalidaMateriales.NumeroSalidaMateriales = mNumero;

                            db.SalidasMateriales.Add(SalidaMateriales);
                            db.SaveChanges();
                        }

                        //////////////////////////////////////////////  STOCK  //////////////////////////////////////////////

                        if (!mAnulada)
                        {
                            foreach (var d in SalidaMateriales.DetalleSalidasMateriales)
                            {
                                //mIdDetalleRequerimiento = d.IdDetalleRequerimiento ?? 0;

                                mRegistrarStock = db.Articulos.Where(y => y.IdArticulo == d.IdArticulo).Select(y => y.RegistrarStock).FirstOrDefault() ?? "SI";
                                if (mRegistrarStock == "SI")
                                {
                                    // Bajar stock
                                    Stock Stock = db.Stocks.Where(
                                        c => c.IdArticulo == d.IdArticulo &&
                                             (c.Partida ?? "") == (d.Partida ?? "") &&
                                             (c.IdUbicacion ?? 0) == (d.IdUbicacion ?? 0) &&
                                             (c.IdObra ?? 0) == (d.IdObra ?? 0) &&
                                             (c.IdUnidad ?? 0) == (d.IdUnidad ?? 0) &&
                                             (c.NumeroCaja ?? 0) == (d.NumeroCaja ?? 0) &&
                                             (c.IdColor ?? 0) == (d.IdColor ?? 0) &&
                                             (c.Talle ?? "") == (d.Talle ?? "")
                                    ).FirstOrDefault();
                                    if (Stock != null)
                                    {
                                        Stock.CantidadUnidades = (Stock.CantidadUnidades ?? 0) - (d.Cantidad ?? 0);
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
                                        Stock.NumeroCaja = d.NumeroCaja ?? 0;
                                        Stock.IdColor = d.IdColor ?? 0;
                                        Stock.Talle = d.Talle ?? "";
                                        Stock.CantidadUnidades = (d.Cantidad ?? 0) * -1;
                                        db.Stocks.Add(Stock);
                                    }
                                }
                            }
                            db.SaveChanges();
                            db.Tree_TX_Actualizar("SalidaMaterialesAgrupadas", SalidaMateriales.IdSalidaMateriales, "SalidaMateriales");
                        }
                        scope.Complete();
                        scope.Dispose();
                    }

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdSalidaMateriales = SalidaMateriales.IdSalidaMateriales, ex = "" });
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
            string plantilla = DirApp + "Documentos\\" + "SalidaMateriales_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var s = new ServicioMVC.servi(SC);
            string mensajeError;
            s.ImprimirConPlantillaEXE(id, SC, DirApp, plantilla, output, out mensajeError);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            string nombrearchivo = "SalidaMateriales.pdf";
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, nombrearchivo);
        }

        public virtual FileResult ImprimirConPlantillaEXE(int id)
        {
            string DirApp = AppDomain.CurrentDomain.BaseDirectory;
            string output = DirApp + "Documentos\\" + "archivo.doc";
            string plantilla = DirApp + "Documentos\\" + "SalidaMateriales_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var s = new ServicioMVC.servi(SC);
            string mensajeError;
            s.ImprimirConPlantillaEXE(id, SC, DirApp, plantilla, output, out mensajeError);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            string nombrearchivo = "SalidaMateriales.doc";
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, nombrearchivo);
        }

        public virtual FileResult ImprimirConInteropPDF(int id)
        {
            object nulo = null;
            string baseP = this.HttpContext.Session["BasePronto"].ToString();
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.pdf";
            string plantilla;
            plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "SalidaMateriales_" + baseP + ".dotm";

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            EntidadManager.ImprimirWordDOT_VersionDLL_PDF(plantilla, ref nulo, SC, nulo, ref nulo, id, nulo, nulo, nulo, output, nulo);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "SalidaMateriales.pdf");
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var data = (from a in db.SalidasMateriales.Include(x => x.DetalleSalidasMateriales)
                        from b in db.Proveedores.Where(v => v.IdProveedor == a.IdProveedor).DefaultIfEmpty()
                        from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                        from d in db.Empleados.Where(y => y.IdEmpleado == a.Emitio).DefaultIfEmpty()
                        from e in db.Empleados.Where(y => y.IdEmpleado == a.Aprobo).DefaultIfEmpty()
                        from f in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from g in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        from h in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioAnulo).DefaultIfEmpty()
                        from i in db.Empleados.Where(y => y.IdEmpleado == a.RecibidosEnDestinoIdUsuario).DefaultIfEmpty()
                        from j in db.Transportistas.Where(y => y.IdTransportista == a.IdTransportista1).DefaultIfEmpty()
                        from k in db.Depositos.Where(y => y.IdDeposito == a.IdDepositoOrigen).DefaultIfEmpty()
                        from l in db.TarifasFletes.Where(y => y.IdTarifaFlete == a.IdTarifaFlete).DefaultIfEmpty()
                        select new
                        {
                            a.IdSalidaMateriales,
                            a.DetalleSalidasMateriales,
                            a.TipoSalida,
                            a.IdProveedor,
                            a.IdObra,
                            a.IdTransportista1,
                            a.NumeroSalidaMateriales2,
                            a.NumeroSalidaMateriales,
                            a.FechaSalidaMateriales,
                            a.ValePreimpreso,
                            Requerimientos = "",
                            Recepciones = "",
                            ValesSalida = "",
                            Obra = c != null ? c.NumeroObra : "",
                            Emitio = d != null ? e.Nombre : "",
                            Aprobo = e != null ? e.Nombre : "",
                            a.Cliente,
                            Proveedor = b.RazonSocial != null ? b.RazonSocial : "",
                            a.Direccion,
                            a.Localidad,
                            a.CodigoPostal,
                            Transportista = j != null ? j.RazonSocial : "",
                            CantidadItems = 0,
                            EquiposDestino = "",
                            TarifaFlete = l != null ? l.Descripcion : "",
                            a.Anulada,
                            Anulo = h != null ? h.Nombre : "",
                            a.FechaAnulacion,
                            a.MotivoAnulacion,
                            Confecciono = f != null ? f.Nombre : "",
                            a.FechaIngreso,
                            Modifico = g != null ? g.Nombre : "",
                            a.FechaModifico,
                            DepositoOrigen = k != null ? k.Descripcion : "",
                            a.NumeroOrdenProduccion,
                            a.Detalle,
                            a.NumeroPesada,
                            a.RecibidosEnDestino,
                            a.RecibidosEnDestinoFecha,
                            MarcoRecepcionEnDestino = i != null ? i.Nombre : "",
                            a.Observaciones
                        }).AsQueryable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaSalidaMateriales >= FechaDesde && a.FechaSalidaMateriales <= FechaHasta select a).AsQueryable();
            }

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .OrderByDescending(x => x.FechaSalidaMateriales)
                        .Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data1
                        select new jqGridRowJson
                        {
                            id = a.IdSalidaMateriales.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdSalidaMateriales} ) + ">Editar</>",
                                "<a href="+ Url.Action("ImprimirConInteropPDF",new {id = a.IdSalidaMateriales} ) + ">Emitir</a> ",
                                a.IdSalidaMateriales.ToString(),
                                a.TipoSalida.NullSafeToString(),
                                a.IdProveedor.NullSafeToString(),
                                a.IdObra.NullSafeToString(),
                                a.IdTransportista1.NullSafeToString(),
                                a.NumeroSalidaMateriales2.NullSafeToString().PadLeft(4,'0') + '-'+a.NumeroSalidaMateriales.NullSafeToString().PadLeft(8,'0'),
                                a.FechaSalidaMateriales == null ? "" : a.FechaSalidaMateriales.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.ValePreimpreso.NullSafeToString(),
                                string.Join(",", 
                                       a.DetalleSalidasMateriales
                                       .Select(x => 
                                           (x.DetalleValesSalida == null) ?
                                           "" :
                                           ((   x.DetalleValesSalida.DetalleRequerimiento == null) ? 
                                               "" :
                                               x.DetalleValesSalida.DetalleRequerimiento.Requerimientos.NumeroRequerimiento.NullSafeToString()
                                           )
                                       ).Distinct()
                                ),
                                string.Join(",", 
                                       a.DetalleSalidasMateriales
                                       .Select(x => 
                                           (x.DetalleRecepcione == null) ?
                                           "" :
                                           ((   x.DetalleRecepcione == null) ? 
                                               "" :
                                               x.DetalleRecepcione.Recepcione.NumeroRecepcionAlmacen.NullSafeToString()
                                           )
                                       ).Distinct()
                                ),
                                string.Join(",", 
                                       a.DetalleSalidasMateriales
                                       .Select(x => 
                                           (x.DetalleValesSalida == null) ?
                                           "" :
                                           ((   x.DetalleValesSalida.ValesSalida == null) ? 
                                               "" :
                                               x.DetalleValesSalida.ValesSalida.NumeroValeSalida.NullSafeToString()
                                           )
                                       ).Distinct()
                                ),
                                a.Obra.NullSafeToString(),
                                a.Emitio.NullSafeToString(),
                                a.Aprobo.NullSafeToString(),
                                a.Cliente.NullSafeToString(),
                                a.Proveedor.NullSafeToString(),
                                a.Direccion.NullSafeToString(),
                                a.Localidad.NullSafeToString(),
                                a.CodigoPostal.NullSafeToString(),
                                a.Transportista.NullSafeToString(),
                                db.DetalleSalidasMateriales.Where(x=>x.IdSalidaMateriales==a.IdSalidaMateriales).Select(x=>x.IdDetalleSalidaMateriales).Distinct().Count().ToString(),
                                a.EquiposDestino.NullSafeToString(),
                                a.TarifaFlete.NullSafeToString(),
                                a.Anulada.NullSafeToString(),
                                a.Anulo.NullSafeToString(),
                                a.FechaAnulacion.NullSafeToString(),
                                a.MotivoAnulacion.NullSafeToString(),
                                a.Confecciono.NullSafeToString(),
                                a.FechaIngreso.NullSafeToString(),
                                a.Modifico.NullSafeToString(),
                                a.FechaModifico.NullSafeToString(),
                                a.DepositoOrigen.NullSafeToString(),
                                a.NumeroOrdenProduccion.NullSafeToString(),
                                a.Detalle.NullSafeToString(),
                                a.NumeroPesada.NullSafeToString(),
                                a.RecibidosEnDestino.NullSafeToString(),
                                a.RecibidosEnDestinoFecha.NullSafeToString(),
                                a.MarcoRecepcionEnDestino.NullSafeToString(),
                                a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public class SalidasMateriales2
        {
            public int IdSalidaMateriales { get; set; }
            public string TipoSalida { get; set; }  //ClaveTipoSalida
            public string NumeroSalidaMateriales1 { get; set; }
            public string NumeroSalidaMateriales2 { get; set; }
            public DateTime? FechaSalidaMateriales { get; set; }
            public string Obra { get; set; }
            public string Cliente { get; set; }
            public string Proveedor { get; set; }
            public string Direccion { get; set; }
            public string Localidad { get; set; }
            public string CodigoPostal { get; set; }
            public string Transportista { get; set; }
            public string Observaciones { get; set; }
            public decimal? CostoTotal { get; set; }
            public int? ValePreimpreso { get; set; }
            public int? NumeroOrdenProduccion { get; set; }
            public string Requerimientos { get; set; }
            public string EquiposDestino { get; set; }
            public string Aprobo { get; set; }
            public decimal? ValorDeclarado { get; set; }
            public int? Bultos { get; set; }
            public string Anulada { get; set; }
            public string Anulo { get; set; }
            public DateTime? FechaAnulacion { get; set; }
            public string MotivoAnulacion { get; set; }
            public string Confecciono { get; set; }
            public DateTime? FechaIngreso { get; set; }
            public string Modifico { get; set; }
            public DateTime? FechaModifico { get; set; }
            public string Detalle { get; set; }
            public string Flete { get; set; }
            public string Chofer { get; set; }
            public string NumeroDocumento { get; set; }
            public string Patente1 { get; set; }
            public string NumeroRemitoTransporte { get; set; }
            public string NumeroRemitoTransporte2 { get; set; }
            public string NumeroRemitoTransporte1 { get; set; }
            public int? NumeroPesada { get; set; }
            public decimal? Progresiva1 { get; set; }
            public decimal? Progresiva2 { get; set; }
            public DateTime? FechaPesada { get; set; }
            public string ObservacionesPesada { get; set; }
            public decimal? PesoBruto { get; set; }
            public decimal? PesoNeto { get; set; }
            public decimal? Tara { get; set; }
            public decimal? CantidadEnOrigen { get; set; }
            public decimal? DistanciaRecorrida { get; set; }
            public string RecibidosEnDestino { get; set; }
            public DateTime? RecibidosEnDestinoFecha { get; set; }
            public string RecibioEnDestino { get; set; }
            public string DestinoEntreCalles { get; set; }
            public string CircuitoFirmasCompleto { get; set; }
            public int? Items { get; set; }
        }

        public virtual JsonResult SalidaMateriales_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal)
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

            var data = (from a in db.SalidasMateriales
                        from b in db.Obras.Where(o => o.IdObra == a.IdObra).DefaultIfEmpty()
                        from c in db.Proveedores.Where(o => o.IdProveedor == a.IdProveedor).DefaultIfEmpty()
                        from d in db.Transportistas.Where(o => o.IdTransportista == a.IdTransportista1).DefaultIfEmpty()
                        from e in db.Empleados.Where(o => o.IdEmpleado == a.Aprobo).DefaultIfEmpty()
                        from f in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioAnulo).DefaultIfEmpty()
                        from g in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from h in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        from i in db.Fletes.Where(o => o.IdFlete == a.IdFlete).DefaultIfEmpty()
                        from j in db.Choferes.Where(o => o.IdChofer == a.IdChofer).DefaultIfEmpty()
                        from k in db.Empleados.Where(o => o.IdEmpleado == a.RecibidosEnDestinoIdUsuario).DefaultIfEmpty()
                        from l in db.Calles.Where(o => o.IdCalle == a.IdCalle1).DefaultIfEmpty()
                        from m in db.Calles.Where(o => o.IdCalle == a.IdCalle2).DefaultIfEmpty()
                        from n in db.Calles.Where(o => o.IdCalle == a.IdCalle3).DefaultIfEmpty()
                        select new SalidasMateriales2
                        {
                            IdSalidaMateriales = a.IdSalidaMateriales,
                            TipoSalida = ((a.TipoSalida ?? 0) == 0 ? "Salida a fabrica" : ((a.TipoSalida ?? 0) == 1 ? "Salida a obra" : ((a.TipoSalida ?? 0) == 2 ? "A Proveedor" : (a.ClaveTipoSalida ?? "")))),
                            NumeroSalidaMateriales1 = SqlFunctions.Replicate("0", 4 - a.NumeroSalidaMateriales2.ToString().Length) + a.NumeroSalidaMateriales2.ToString(),
                            NumeroSalidaMateriales2 = SqlFunctions.Replicate("0", 8 - a.NumeroSalidaMateriales.ToString().Length) + a.NumeroSalidaMateriales.ToString(),
                            FechaSalidaMateriales = a.FechaSalidaMateriales,
                            Obra = b != null ? b.NumeroObra : "",
                            Cliente = a.Cliente,
                            Proveedor = c != null ? c.RazonSocial : "",
                            Direccion = a.Direccion,
                            Localidad = a.Localidad,
                            CodigoPostal = a.CodigoPostal,
                            Transportista = d != null ? d.RazonSocial : "",
                            Observaciones = a.Observaciones,
                            CostoTotal = a.DetalleSalidasMateriales.Sum(x => (x.Cantidad ?? 0) * (x.CostoUnitario ?? 0) * (x.CotizacionMoneda ?? 1)),
                            ValePreimpreso = a.ValePreimpreso,
                            NumeroOrdenProduccion = a.NumeroOrdenProduccion,
                            Requerimientos = ModelDefinedFunctions.SalidasMateriales_Requerimientos(a.IdSalidaMateriales).ToString(),
                            EquiposDestino = ModelDefinedFunctions.SalidasMateriales_EquiposDestino(a.IdSalidaMateriales).ToString(),
                            Aprobo = e != null ? e.Nombre : "",
                            ValorDeclarado = a.ValorDeclarado,
                            Bultos = a.Bultos,
                            Anulada = a.Anulada,
                            Anulo = f != null ? f.Nombre : "",
                            FechaAnulacion = a.FechaAnulacion,
                            MotivoAnulacion = a.MotivoAnulacion,
                            Confecciono = g != null ? g.Nombre : "",
                            FechaIngreso = a.FechaIngreso,
                            Modifico = h != null ? h.Nombre : "",
                            FechaModifico = a.FechaModifico,
                            Detalle = a.Detalle,
                            Flete = i != null ? i.Descripcion : "",
                            Chofer = j != null ? j.Nombre : "",
                            NumeroDocumento = a.NumeroDocumento,
                            Patente1 = a.Patente1,
                            NumeroRemitoTransporte = a.NumeroRemitoTransporte,
                            NumeroRemitoTransporte2 = SqlFunctions.Replicate("0", 4 - a.NumeroRemitoTransporte2.ToString().Length) + a.NumeroRemitoTransporte2.ToString(),
                            NumeroRemitoTransporte1 = SqlFunctions.Replicate("0", 8 - a.NumeroRemitoTransporte1.ToString().Length) + a.NumeroRemitoTransporte1.ToString(),
                            NumeroPesada = a.NumeroPesada,
                            Progresiva1 = a.Progresiva1,
                            Progresiva2 = a.Progresiva2,
                            FechaPesada = a.FechaPesada,
                            ObservacionesPesada = a.ObservacionesPesada,
                            PesoBruto = a.PesoBruto,
                            PesoNeto = a.PesoNeto,
                            Tara = a.Tara,
                            CantidadEnOrigen = a.CantidadEnOrigen,
                            DistanciaRecorrida = a.DistanciaRecorrida,
                            RecibidosEnDestino = a.RecibidosEnDestino,
                            RecibidosEnDestinoFecha = a.RecibidosEnDestinoFecha,
                            RecibioEnDestino = k != null ? k.Nombre : "",
                            DestinoEntreCalles = (l != null ? l.Nombre : "") + (m != null ? " entre "+m.Nombre : "") + (n != null ? " y "+n.Nombre : ""),
                            CircuitoFirmasCompleto = a.CircuitoFirmasCompleto,
                            Items = a.DetalleSalidasMateriales.Distinct().Count(),
                        }).Where(a => a.FechaSalidaMateriales >= FechaDesde && a.FechaSalidaMateriales <= FechaHasta).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<SalidasMateriales2>
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
                            id = a.IdSalidaMateriales.ToString(),
                            cell = new string[] {
                                "<a href="+ Url.Action("Edit",new {id = a.IdSalidaMateriales} ) + ">Editar</>",
                                "<a href="+ Url.Action("ImprimirConPlantillaEXE_PDF",new {id = a.IdSalidaMateriales} ) + ">Emitir</a> ",
                                a.IdSalidaMateriales.ToString(),
                                a.TipoSalida.NullSafeToString(),
                                a.NumeroSalidaMateriales1.NullSafeToString(),
                                a.NumeroSalidaMateriales2.NullSafeToString(),
                                a.FechaSalidaMateriales == null ? "" : a.FechaSalidaMateriales.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Obra.NullSafeToString(),
                                a.Cliente.NullSafeToString(),
                                a.Proveedor.NullSafeToString(),
                                a.Direccion.NullSafeToString(),
                                a.Localidad.NullSafeToString(),
                                a.CodigoPostal.NullSafeToString(),
                                a.Transportista.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.CostoTotal.NullSafeToString(),
                                a.ValePreimpreso.NullSafeToString(),
                                a.NumeroOrdenProduccion.NullSafeToString(),
                                a.Requerimientos.NullSafeToString(),
                                a.EquiposDestino.NullSafeToString(),
                                a.Aprobo.NullSafeToString(),
                                a.ValorDeclarado.NullSafeToString(),
                                a.Bultos.NullSafeToString(),
                                a.Anulada.NullSafeToString(),
                                a.Anulo.NullSafeToString(),
                                a.FechaAnulacion == null ? "" : a.FechaAnulacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.MotivoAnulacion.NullSafeToString(),
                                a.Confecciono.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Modifico.NullSafeToString(),
                                a.FechaModifico == null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Detalle.NullSafeToString(),
                                a.Flete.NullSafeToString(),
                                a.Chofer.NullSafeToString(),
                                a.NumeroDocumento.NullSafeToString(),
                                a.Patente1.NullSafeToString(),
                                a.NumeroRemitoTransporte.NullSafeToString(),
                                a.NumeroRemitoTransporte2.NullSafeToString(),
                                a.NumeroRemitoTransporte1.NullSafeToString(),
                                a.NumeroPesada.NullSafeToString(),
                                a.Progresiva1.NullSafeToString(),
                                a.Progresiva2.NullSafeToString(),
                                a.FechaPesada == null ? "" : a.FechaPesada.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.ObservacionesPesada.NullSafeToString(),
                                a.PesoBruto.NullSafeToString(),
                                a.PesoNeto.NullSafeToString(),
                                a.Tara.NullSafeToString(),
                                a.CantidadEnOrigen.NullSafeToString(),
                                a.DistanciaRecorrida.NullSafeToString(),
                                a.RecibidosEnDestino.NullSafeToString(),
                                a.RecibidosEnDestinoFecha == null ? "" : a.RecibidosEnDestinoFecha.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.RecibioEnDestino.NullSafeToString(),
                                a.DestinoEntreCalles.NullSafeToString(),
                                a.CircuitoFirmasCompleto.NullSafeToString(),
                                a.Items.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetSalidaMateriales(string sidx, string sord, int? page, int? rows, int? IdSalidaMateriales)
        {
            int IdSalidaMateriales1 = IdSalidaMateriales ?? 0;
            var Det = db.DetalleSalidasMateriales.Where(p => p.IdSalidaMateriales == IdSalidaMateriales1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Unidades.Where(o => o.IdUnidad == a.IdUnidad).DefaultIfEmpty()
                        from c in db.Depositos.Where(o => o.IdDeposito == a.Ubicacione.IdDeposito).DefaultIfEmpty()
                        from d in db.Colores.Where(o => o.IdColor == a.IdColor).DefaultIfEmpty()
                        from e in db.Obras.Where(o => o.IdObra == a.IdObra).DefaultIfEmpty()
                        from f in db.Monedas.Where(o => o.IdMoneda == a.IdMoneda).DefaultIfEmpty()
                        from g in db.Ubicaciones.Where(o => o.IdUbicacion == a.IdUbicacionDestino).DefaultIfEmpty()
                        from h in db.Depositos.Where(o => o.IdDeposito == g.IdDeposito).DefaultIfEmpty()
                        from i in db.PresupuestoObrasNodos.Where(o => o.IdPresupuestoObrasNodo == a.IdPresupuestoObrasNodo).DefaultIfEmpty()
                        from j in db.PresupuestoObrasNodos.Where(o => o.IdPresupuestoObrasNodo == i.IdNodoPadre).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleSalidaMateriales,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdColor,
                            a.IdUbicacion,
                            a.IdUbicacionDestino,
                            a.IdObra,
                            a.IdDetalleRecepcion,
                            a.IdDetalleValeSalida,
                            a.IdOrdenTrabajo,
                            a.DetalleValesSalida.IdDetalleRequerimiento,
                            a.IdMoneda,
                            a.IdEquipoDestino,
                            a.IdPresupuestoObrasNodo,
                            a.DetalleRecepcione.Recepcione.NumeroRecepcionAlmacen,
                            a.DetalleValesSalida.ValesSalida.NumeroValeSalida,
                            a.DetalleValesSalida.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            ItemRM = a.DetalleValesSalida.DetalleRequerimiento.NumeroItem,
                            Codigo = a.Articulo.Codigo,
                            Articulo = a.Articulo.Descripcion + (b != null ? " " + b.Descripcion : ""),
                            a.Cantidad,
                            Unidad = b != null ? b.Abreviatura : "",
                            Ubicacion = (c != null ? c.Abreviatura : "") + (a.Ubicacione.Descripcion != null ? " " + a.Ubicacione.Descripcion : "") + (a.Ubicacione.Estanteria != null ? " Est.:" + a.Ubicacione.Estanteria : "") + (a.Ubicacione.Modulo != null ? " Mod.:" + a.Ubicacione.Modulo : "") + (a.Ubicacione.Gabeta != null ? " Gab.:" + a.Ubicacione.Gabeta : ""),
                            UbicacionDestino = (h != null ? h.Abreviatura : "") + (g.Descripcion != null ? " " + g.Descripcion : "") + (g.Estanteria != null ? " Est.:" + g.Estanteria : "") + (g.Modulo != null ? " Mod.:" + g.Modulo : "") + (g.Gabeta != null ? " Gab.:" + g.Gabeta : ""),
                            Obra = e != null ? e.NumeroObra : "",
                            a.Partida,
                            a.CostoUnitario,
                            Moneda = f != null ? f.Abreviatura : "",
                            a.FechaImputacion,
                            EquipoDestino = "",
                            OrdenTrabajo = "",
                            PresupuestoObrasEtapa = (i != null ? i.Item + " " : "") + (j != null ? j.Descripcion : "") + (i != null ? " - " + i.Descripcion : ""),
                            a.Observaciones
                        }).OrderBy(x => x.IdDetalleSalidaMateriales)
                        //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList();

            //var data2 = (from a in data
                         
            //             from b in dbmant.OrdenesTrabajo.Where(o => o.IdOrdenTrabajo == a.IdOrdenTrabajo).DefaultIfEmpty()
            //             from c in dbmant.Articulos.Where(o => o.IdArticulo == a.IdEquipoDestino).DefaultIfEmpty()
            //             select new 
            //             { 
            //                    IdOrdenTrabajo = (a==null) ? 0 :  (a.IdOrdenTrabajo ?? 0),
            //                    NumeroOrdenTrabajo =  (b==null) ? 0 :  (b.NumeroOrdenTrabajo ??  0),
            //                    IdEquipoDestino = (a == null) ? 0 : (a.IdEquipoDestino ?? 0),
            //                    EquipoDestino = (c == null) ? "" : (c.Descripcion != null ? c.Descripcion : "")
            //             }).Distinct().ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleSalidaMateriales.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleSalidaMateriales.ToString(), 
                            a.IdArticulo.NullSafeToString(),
                            a.IdUnidad.NullSafeToString(),
                            a.IdColor.NullSafeToString(),
                            a.IdUbicacion.NullSafeToString(),
                            a.IdUbicacionDestino.NullSafeToString(),
                            a.IdObra.NullSafeToString(),
                            a.IdDetalleRecepcion.NullSafeToString(),
                            a.IdDetalleValeSalida.NullSafeToString(),
                            a.IdOrdenTrabajo.NullSafeToString(),
                            a.IdDetalleRequerimiento.NullSafeToString(),
                            a.IdMoneda.NullSafeToString(),
                            a.IdEquipoDestino.NullSafeToString(),
                            a.IdPresupuestoObrasNodo.NullSafeToString(),
                            a.NumeroRecepcionAlmacen.NullSafeToString(),
                            a.NumeroValeSalida.NullSafeToString(),
                            a.NumeroRequerimiento.NullSafeToString(),
                            a.ItemRM.NullSafeToString(),
                            a.Codigo.NullSafeToString(),
                            a.Articulo.NullSafeToString(),
                            a.Cantidad.NullSafeToString(),
                            a.Unidad.NullSafeToString(),
                            a.Ubicacion.NullSafeToString(),
                            a.UbicacionDestino.NullSafeToString(),
                            a.Obra.NullSafeToString(),
                            a.Partida.NullSafeToString(),
                            a.CostoUnitario.NullSafeToString(),
                            a.Moneda.NullSafeToString(),
                            a.FechaImputacion == null ? "" : a.FechaImputacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.EquipoDestino.NullSafeToString(), //data2.Where(x=>x.IdEquipoDestino==a.IdEquipoDestino).Select(x=>x.EquipoDestino ?? "").FirstOrDefault().NullSafeToString(),
                            a.OrdenTrabajo.NullSafeToString(), //data2.Where(x=>x.IdOrdenTrabajo==a.IdOrdenTrabajo).Select(x=>x.NumeroOrdenTrabajo ).FirstOrDefault().NullSafeToString(),
                            a.PresupuestoObrasEtapa.NullSafeToString(),
                            a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdSalidaMateriales, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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