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




        public virtual ViewResult EditPendientesRm(int id,string ItemsDeRm)
        {
            ValesSalida o;

            try
            {
                if (!PuedeLeer(enumNodos.ValesSalida))
                {
                    o = new ValesSalida();
                    CargarViewBag(o);
                    ViewBag.AlertaEnLayout = "No tiene permisos de lectura";

                    return View("Edit", o);

                }
            }
            catch (Exception)
            {
                o = new ValesSalida();
                CargarViewBag(o);
                ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                return View("Edit", o);
            }

            if (id <= 0)
            {
                o = new ValesSalida();
                inic(ref o);
                CargarViewBag(o);
                return View("Edit", o);
            }
            else
            {
                o = db.ValesSalidas.Include(x => x.DetalleValesSalidas).SingleOrDefault(x => x.IdValeSalida == id);
                CargarViewBag(o);
                Session.Add("ValeSalida", o);
                return View("Edit", o);
            }
        }











        void CargarViewBag(ValesSalida o)
        {
            ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.Aprobo);
            ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", o.IdObra);
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

            if ((o.IdObra ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la obra"; }

            foreach (ProntoMVC.Data.Models.DetalleValesSalida x in o.DetalleValesSalidas)
            {
                if ((x.IdArticulo ?? 0) == 0 && (x.Cantidad ?? 0) != 0)
                {
                    sErrorMsg += "\n" + "Hay items que no tienen articulo";
                }
            }

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

        public virtual FileResult ImprimirConInteropPDF(int id)
        {
            int idcliente = buscaridclienteporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));
            //if (db.Facturas.Find(id).IdCliente != idcliente
            //     && !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
            //!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") && 
            //    !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Comercial")
            //    ) throw new Exception("Sólo podes acceder a facturas a tu nombre");


            string baseP = this.HttpContext.Session["BasePronto"].ToString();
            // baseP = "Vialagro";
            // baseP = "BDLConsultores";

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.pdf"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            string plantilla;
            plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "SolicitudMateriales_" + baseP + ".dotm";

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            object nulo = null;
            var mvarClausula = false;
            var mPrinter = "";
            var mCopias = 1;
            string mArgs = "";

            EntidadManager.ImprimirWordDOT_VersionDLL_PDF(plantilla, ref nulo, SC, nulo, ref nulo, id, nulo, nulo, nulo, output, nulo);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "SolicitudMateriales.pdf");
        }





        public virtual ActionResult DetValesSalida(string sidx, string sord, int? page, int? rows, int? IdValeSalida, string idDetalleRequerimientosString)
        {


            int IdValeSalida1 = IdValeSalida ?? 0;
            var Det = db.DetalleValesSalidas.Where(p => p.IdValeSalida == IdValeSalida1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;





            if ((idDetalleRequerimientosString ?? "") != "")

            {



                List<int> idDetalleRequerimientos = idDetalleRequerimientosString.Split(',').Select(Int32.Parse).ToList();


                if (idDetalleRequerimientos == null) return null;

                var vale = new ValesSalida();

                var reqs = db.DetalleRequerimientos.Where(x => idDetalleRequerimientos.Contains(x.IdDetalleRequerimiento));

                foreach (Data.Models.DetalleRequerimiento detrm in reqs)
                {
                    var detvale = new DetalleValesSalida();
                    detvale.IdArticulo = detrm.IdArticulo;
                    detvale.Articulo = detrm.Articulo;
                    detvale.IdDetalleRequerimiento = detrm.IdDetalleRequerimiento;
                    detvale.Cantidad = detrm.Cantidad;
                    vale.DetalleValesSalidas.Add(detvale);
                }



                var data2 = (from a in vale.DetalleValesSalidas
                                //from b in db.Unidades.Where(y => y.IdUnidad == a.IdUnidad).DefaultIfEmpty()
                                //from c in db.Obras.Where(y => y.IdObra == a.ValesSalida.IdObra).DefaultIfEmpty()
                            select new
                            {
                                a.IdDetalleValeSalida,
                                //a.IdValeSalida,
                                a.IdArticulo,
                                a.IdUnidad,
                                //IdObra = 0,//a.ValesSalida.IdObra,
                                //a.IdDetalleRequerimiento,
                                Codigo = a.Articulo.Codigo,
                                Articulo = a.Articulo.Descripcion,
                                a.Cantidad,
                                Unidad = "",// db.Unidades.Where(y => y.IdUnidad == a.IdUnidad).DefaultIfEmpty() != null ? b.Abreviatura : "",
                                a.Cumplido,
                                a.Estado,
                                //NumeroRequerimiento = a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                                //ItemRM = a.DetalleRequerimiento.Item,
                                //TipoRequerimiento = a.DetalleRequerimiento.Requerimientos.TipoRequerimiento
                            }).OrderBy(p => p.IdDetalleValeSalida).ToList();



                var jsonData2 = new jqGridJson()
                {
                    total = totalPages,
                    page = currentPage,
                    records = totalRecords,
                    rows = (from a in data2
                            select new jqGridRowJson
                            {
                                id = a.IdDetalleValeSalida.ToString(),
                                cell = new string[] {
                            string.Empty,
                            a.IdDetalleValeSalida.ToString(),
                            a.IdArticulo.NullSafeToString(),
                            a.IdUnidad.NullSafeToString(),
                            a.Codigo.NullSafeToString(),
                            a.Articulo.NullSafeToString(),
                            a.Cantidad.NullSafeToString(),
                            a.Unidad.NullSafeToString(),
                            a.Cumplido.NullSafeToString(),
                            a.Estado.NullSafeToString(),
                            //a.NumeroRequerimiento.NullSafeToString(),
                            //a.ItemRM.NullSafeToString(),
                            //a.TipoRequerimiento.NullSafeToString()
                            }
                            }).ToArray()
                };

                return Json(jsonData2, JsonRequestBehavior.AllowGet);
                


            }





            

            var data = (from a in Det
                        from b in db.Unidades.Where(o => o.IdUnidad == a.IdUnidad).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleValeSalida,
                            a.IdArticulo,
                            a.IdUnidad,
                            Codigo = a.Articulo.Codigo,
                            Articulo = a.Articulo.Descripcion,
                            a.Cantidad,
                            Unidad = (b != null ? b.Abreviatura : ""),
                            a.Cumplido,
                            a.Estado,
                            NumeroRequerimiento = a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            ItemRM = a.DetalleRequerimiento.Item,
                            TipoRequerimiento = a.DetalleRequerimiento.Requerimientos.TipoRequerimiento
                        }).OrderBy(x => x.IdDetalleValeSalida)
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
                            string.Empty,
                            a.IdDetalleValeSalida.ToString(),
                            a.IdArticulo.NullSafeToString(),
                            a.IdUnidad.NullSafeToString(),
                            a.Codigo.NullSafeToString(),
                            a.Articulo.NullSafeToString(),
                            a.Cantidad.NullSafeToString(),
                            a.Unidad.NullSafeToString(),
                            a.Cumplido.NullSafeToString(),
                            a.Estado.NullSafeToString(),
                            a.NumeroRequerimiento.NullSafeToString(),
                            a.ItemRM.NullSafeToString(),
                            a.TipoRequerimiento.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
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
                            Entregado = db.DetalleSalidasMateriales.Where(x => x.IdDetalleValeSalida == a.IdDetalleValeSalida && (x.SalidasMateriale.Anulada ?? "") != "SI").Select(x => x.Cantidad).Sum().ToString(),
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

        public class ValesSalida2
        {
            public int IdValeSalida { get; set; }
            public int? NumeroValeSalida { get; set; }
            public int? NumeroValePreimpreso { get; set; }
            public DateTime? FechaValeSalida { get; set; }
            public string NumeroObra { get; set; }
            public string Aprobo { get; set; }
            public string Cumplido { get; set; }
            public string Salidas { get; set; }
            public string Observaciones { get; set; }
            public string Anulo { get; set; }
            public DateTime? FechaAnulacion { get; set; }
            public string MotivoAnulacion { get; set; }
            public string DioPorCumplido { get; set; }
            public DateTime? FechaDioPorCumplido { get; set; }
            public string MotivoDioPorCumplido { get; set; }
        }

        public virtual JsonResult ValesSalida_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal)
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

            var data = (from a in db.ValesSalidas
                        from b in db.Obras.Where(o => o.IdObra == a.IdObra).DefaultIfEmpty()
                        from c in db.Empleados.Where(o => o.IdEmpleado == a.Aprobo).DefaultIfEmpty()
                        from d in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioAnulo).DefaultIfEmpty()
                        from e in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioDioPorCumplido).DefaultIfEmpty()
                        select new ValesSalida2
                        {
                            IdValeSalida = a.IdValeSalida,
                            NumeroValeSalida = a.NumeroValeSalida,
                            NumeroValePreimpreso = a.NumeroValePreimpreso,
                            FechaValeSalida = a.FechaValeSalida,
                            NumeroObra = b != null ? b.NumeroObra : "",
                            Aprobo = c != null ? c.Nombre : "",
                            Cumplido = a.Cumplido,
                            Salidas = ModelDefinedFunctions.ValesSalida_Salidas(a.IdValeSalida).ToString(),
                            Observaciones = a.Observaciones,
                            Anulo = d != null ? d.Nombre : "",
                            FechaAnulacion = a.FechaAnulacion,
                            MotivoAnulacion = a.MotivoAnulacion,
                            DioPorCumplido = e != null ? e.Nombre : "",
                            FechaDioPorCumplido = a.FechaDioPorCumplido,
                            MotivoDioPorCumplido = a.MotivoDioPorCumplido,
                        }).Where(a => a.FechaValeSalida >= FechaDesde && a.FechaValeSalida <= FechaHasta).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<ValesSalida2>
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
                            id = a.IdValeSalida.ToString(),
                            cell = new string[] {
                                "<a href="+ Url.Action("Edit",new {id = a.IdValeSalida} ) + ">Editar</>",
                                "<a href="+ Url.Action("ImprimirConInteropPDF",new {id = a.IdValeSalida} ) + ">Emitir</a> ",
                                a.IdValeSalida.ToString(),
                                a.NumeroValeSalida.NullSafeToString(),
                                a.NumeroValePreimpreso.NullSafeToString(),
                                a.FechaValeSalida == null ? "" : a.FechaValeSalida.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.NumeroObra.NullSafeToString(),
                                a.Aprobo.NullSafeToString(),
                                a.Cumplido.NullSafeToString(),
                                a.Salidas.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.Anulo.NullSafeToString(),
                                a.FechaAnulacion == null ? "" : a.FechaAnulacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.MotivoAnulacion.NullSafeToString(),
                                a.DioPorCumplido.NullSafeToString(),
                                a.FechaDioPorCumplido == null ? "" : a.FechaDioPorCumplido.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.MotivoDioPorCumplido.NullSafeToString()
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