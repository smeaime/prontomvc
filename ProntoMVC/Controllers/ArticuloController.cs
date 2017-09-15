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
using System.Configuration;
using Pronto.ERP.Bll;

using System.Data.SqlClient;

// using ProntoMVC.Controllers.Logica;

using System.Web.Security;

namespace ProntoMVC.Controllers
{
    //[Authorize(Roles = "Administrador,SuperAdmin,FacturaElectronica,Comercial")] //guarda con esto, que no van a responder los autocomplete

    public partial class ArticuloController : ProntoBaseController
    {

        //
        // GET: /Articulo/

        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Articulos)) throw new Exception("No tenés permisos");

            if (db == null)
            {
                FormsAuthentication.SignOut();
                return View("ElegirBase", "Home");
            }

            var Articulos = db.Articulos
                //.Where(r => r.NumeroArticulo > 0)
                .OrderByDescending(r => r.IdArticulo); // .NumeroArticulo);


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
            return View();
        }

        public virtual ViewResult Details(int id)
        {
            Articulo Articulo = db.Articulos.Find(id);
            return View(Articulo);
        }

        public virtual ViewResult IndexResumido()
        {
            if (!PuedeLeer(enumNodos.Articulos)) throw new Exception("No tenés permisos");

            if (db == null)
            {
                FormsAuthentication.SignOut();
                return View("ElegirBase", "Home");
            }

            var Articulos = db.Articulos
                //.Where(r => r.NumeroArticulo > 0)
                .OrderByDescending(r => r.IdArticulo); // .NumeroArticulo);


            string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster, "SELECT * FROM BASES");
            // List<string> baselistado = new List<string>();
            List<SelectListItem> baselistado = new List<SelectListItem>();
            foreach (DataRow r in dt.Rows)
            {
                baselistado.Add(new SelectListItem { Text = r["Descripcion"] as string, Value = "" });
            }

            ViewBag.Bases = baselistado; // baselistado; // new SelectList(dt.Rows, "IdBD", "Descripcion"); // StringConnection

            return View();
        }

        private bool Validar(ProntoMVC.Data.Models.Articulo o, ref string sErrorMsg)
        {
            if ((o.Descripcion ?? "") == "") sErrorMsg += "\n" + "Falta la descripción";

            o.IdCuantificacion = 1;

            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate([Bind(Exclude = "IdDetalleArticuloDocumento,IdDetalleArticuloUnidad")]  Articulo Articulo) // el Exclude es para las altas, donde el Id viene en 0
        {
            if (!PuedeEditar(enumNodos.Articulos)) throw new Exception("No tenés permisos");

            try
            {
                string erar = "";

                Articulo.FechaUltimaModificacion = DateTime.Now;

                if (!Validar(Articulo, ref erar))
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    List<string> errors = new List<string>();
                    errors.Add(erar);
                    return Json(errors);
                }



                if (ModelState.IsValid || true)
                {
                    if (Articulo.IdArticulo > 0)
                    {
                        UpdateColecciones(ref Articulo);
                    }
                    else
                    {
                        db.Articulos.Add(Articulo);
                    }

                    db.SaveChanges();

                    return Json(new { Success = 1, IdArticulo = Articulo.IdArticulo, ex = "" }); //, DetalleArticulos = Articulo.DetalleArticulos
                }
                else
                {
                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "La Articulo es inválida";
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
                JsonResponse res = new JsonResponse();

                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);
                res.Message = ex.Message.ToString();
                return Json(res);
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }

        void UpdateColecciones(ref ProntoMVC.Data.Models.Articulo o)
        {
            // http://stackoverflow.com/questions/7968598/entity-4-1-updating-an-existing-parent-entity-with-new-child-entities

            var id = o.IdArticulo;
            var EntidadOriginal = db.Articulos.Where(p => p.IdArticulo == id)
                                    .Include(p => p.DetalleArticulosDocumentos)
                                    .Include(p => p.DetalleArticulosUnidades)
                                    .Include(p => p.DetalleArticulosImagenes)
                                    .SingleOrDefault();
            var EntidadEntry = db.Entry(EntidadOriginal);
            EntidadEntry.CurrentValues.SetValues(o);

            foreach (var dr in o.DetalleArticulosUnidades)
            {
                var DetalleEntidadOriginal = EntidadOriginal.DetalleArticulosUnidades.Where(c => c.IdDetalleArticuloUnidades == dr.IdDetalleArticuloUnidades && dr.IdDetalleArticuloUnidades > 0).SingleOrDefault();
                if (DetalleEntidadOriginal != null && dr.IdDetalleArticuloUnidades > 0)
                {
                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                    DetalleEntidadEntry.CurrentValues.SetValues(dr);
                }
                else
                {
                    EntidadOriginal.DetalleArticulosUnidades.Add(dr);
                }
            }

            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleArticulosUnidades.Where(c => c.IdDetalleArticuloUnidades != 0).ToList())
            {
                if (!o.DetalleArticulosUnidades.Any(c => c.IdDetalleArticuloUnidades == DetalleEntidadOriginal.IdDetalleArticuloUnidades))
                    EntidadOriginal.DetalleArticulosUnidades.Remove(DetalleEntidadOriginal);
            }

            foreach (var dr in o.DetalleArticulosDocumentos)
            {
                var DetalleEntidadOriginal = EntidadOriginal.DetalleArticulosDocumentos.Where(c => c.IdDetalleArticuloDocumentos == dr.IdDetalleArticuloDocumentos && dr.IdDetalleArticuloDocumentos > 0).SingleOrDefault();
                if (DetalleEntidadOriginal != null && dr.IdDetalleArticuloDocumentos > 0)
                {
                    // modificacion -ok, pero entonces el  IdDetalle no puede ser 0!

                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                    DetalleEntidadEntry.CurrentValues.SetValues(dr);
                }
                else
                {
                    // alta
                    EntidadOriginal.DetalleArticulosDocumentos.Add(dr);
                }
            }

            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleArticulosDocumentos.Where(c => c.IdDetalleArticuloDocumentos != 0).ToList())
            {
                if (!o.DetalleArticulosDocumentos.Any(c => c.IdDetalleArticuloDocumentos == DetalleEntidadOriginal.IdDetalleArticuloDocumentos))
                    EntidadOriginal.DetalleArticulosDocumentos.Remove(DetalleEntidadOriginal);
            }

            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
        }

        public virtual ActionResult IBCondicionPorId(int id)
        {
            var o = db.IBCondiciones.Find(id);
            return Json(new { o.Alicuota, o.AlicuotaPercepcion, o.AlicuotaPercepcionConvenio, o.ImporteTopeMinimoPercepcion }, JsonRequestBehavior.AllowGet);
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
                }
            }

            return errors;
        }



        [HttpPost]
        public virtual JsonResult ArticulosGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {


            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.Articulo>
                                ("Marcas,Modelos", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            string campo = String.Empty;
            int pageSize = rows;
            int currentPage = page;

            var data = (from a in pagedQuery
                        select new
                        {
                            a.IdArticulo,
                            a.IdRubro,
                            a.Codigo,
                            a.NumeroInventario,
                            a.Descripcion,
                            Rubro = (a.Rubro.Descripcion ?? ""),
                            Subrubro = (a.Subrubro.Descripcion ?? ""),
                            a.AlicuotaIVA,
                            a.CostoPPP,
                            a.CostoPPPDolar,
                            a.CostoReposicion,
                            a.CostoReposicionDolar,
                            a.StockMinimo,
                            a.StockReposicion,
                            StockActual = (db.Stocks.Where(x => x.IdArticulo == a.IdArticulo).Sum(y => y.CantidadUnidades)) ?? 0,
                            Unidad = (a.Unidad.Abreviatura ?? ""),
                            Ubicacion = (a.Ubicacione.Deposito.Abreviatura ?? "") + (a.Ubicacione.Descripcion != null ? " " + a.Ubicacione.Descripcion : "") + (a.Ubicacione.Estanteria != null ? " Est.:" + a.Ubicacione.Estanteria : "") + (a.Ubicacione.Modulo != null ? " Mod.:" + a.Ubicacione.Modulo : "") + (a.Ubicacione.Gabeta != null ? " Gab.:" + a.Ubicacione.Gabeta : ""),
                            Marca = a.Marca != null ? a.Marca.Descripcion : "",
                            Modelo = a.Modelo.Descripcion != null ? a.Modelo.Descripcion : "",
                            a.ParaMantenimiento,
                            CuentaCompra = (a.Cuenta.Descripcion ?? ""),
                            a.FechaAlta,
                            a.UsuarioAlta,
                            a.FechaUltimaModificacion
                        }).AsQueryable();

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            //if (sortByColumnName == "Descripcion")
            //{
            //    if (sortDirection.Equals("desc"))
            //        data = (from a in data select a).OrderByDescending(x => x.Descripcion);
            //    else
            //        data = (from a in data select a).OrderBy(x => x.Descripcion);
            //}
            //else
            //{
            //    if ("desc".Equals(sortDirection))
            //        data = data.OrderByDescending(a => a.FechaUltimaModificacion);
            //    else
            //        data = data.OrderBy(a => a.FechaUltimaModificacion);
            //}

            //var data1 = (from a in data select a).OrderBy(x => x.Descripcion)
            //.Skip((currentPage - 1) * pageSize).Take(pageSize)
            //.ToList();
            var data1 = from a in data.OrderBy(sidx + " " + sord)
//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList()
                        select a;

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (
                    from a in data1
                    select new jqGridRowJson
                    {
                        id = a.IdArticulo.ToString(),
                        cell = new string[] {
                            "<a href="+ Url.Action("Edit",new {id = a.IdArticulo} )  +"  >Editar</>",
                            "",
                            a.IdArticulo.ToString(),
                            a.Codigo.NullSafeToString(),
                            a.NumeroInventario.NullSafeToString(),
                            a.Descripcion.NullSafeToString(),
                            a.Rubro.NullSafeToString(),
                            a.Subrubro.NullSafeToString(),
                            a.AlicuotaIVA.NullSafeToString(),
                            a.CostoPPP.NullSafeToString(),
                            a.CostoPPPDolar.NullSafeToString(),
                            a.CostoReposicion.NullSafeToString(),
                            a.CostoReposicionDolar.NullSafeToString(),
                            a.StockMinimo.NullSafeToString(),
                            a.StockReposicion.NullSafeToString(),
                            a.StockActual.NullSafeToString(),
                            a.Unidad.NullSafeToString(),
                            a.Ubicacion.NullSafeToString(),
                            a.Marca.NullSafeToString(),
                            a.Modelo.NullSafeToString(),
                            a.ParaMantenimiento.NullSafeToString() ,
                            a.CuentaCompra.NullSafeToString() ,
                            a.FechaAlta.NullSafeToString(),
                            a.UsuarioAlta.NullSafeToString(),
                            a.FechaUltimaModificacion.NullSafeToString()
                    }
                    }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }



        [HttpPost]
        public virtual ActionResult ArticulosGridData_obsoleto(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, int IdRubro = 0)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;
            string sortByColumnName = sidx ?? "Descripcion";
            string sortDirection = sord ?? "desc";





            var data = (from a in db.Articulos
                        from b in db.Marcas.Where(o => o.IdMarca == a.IdMarca).DefaultIfEmpty()
                        from c in db.Modelos.Where(o => o.IdModelo == a.IdModelo).DefaultIfEmpty()
                        select new
                        {
                            a.IdArticulo,
                            a.IdRubro,
                            a.Codigo,
                            a.NumeroInventario,
                            a.Descripcion,
                            Rubro = (a.Rubro.Descripcion ?? ""),
                            Subrubro = (a.Subrubro.Descripcion ?? ""),
                            a.AlicuotaIVA,
                            a.CostoPPP,
                            a.CostoPPPDolar,
                            a.CostoReposicion,
                            a.CostoReposicionDolar,
                            a.StockMinimo,
                            a.StockReposicion,
                            StockActual = (db.Stocks.Where(x => x.IdArticulo == a.IdArticulo).Sum(y => y.CantidadUnidades)) ?? 0,
                            Unidad = (a.Unidad.Abreviatura ?? ""),
                            Ubicacion = (a.Ubicacione.Deposito.Abreviatura ?? "") + (a.Ubicacione.Descripcion != null ? " " + a.Ubicacione.Descripcion : "") + (a.Ubicacione.Estanteria != null ? " Est.:" + a.Ubicacione.Estanteria : "") + (a.Ubicacione.Modulo != null ? " Mod.:" + a.Ubicacione.Modulo : "") + (a.Ubicacione.Gabeta != null ? " Gab.:" + a.Ubicacione.Gabeta : ""),
                            Marca = b.Descripcion != null ? b.Descripcion : "",
                            Modelo = c.Descripcion != null ? c.Descripcion : "",
                            a.ParaMantenimiento,
                            CuentaCompra = (a.Cuenta.Descripcion ?? ""),
                            a.FechaAlta,
                            a.UsuarioAlta,
                            a.FechaUltimaModificacion
                        }).AsQueryable();

            data = (from a in data where (IdRubro == 0 || (IdRubro != 0 && a.IdRubro == IdRubro)) select a).AsQueryable();
            if (_search)
            {
                data = (from a in data where a.Descripcion.Contains(searchString) || a.Codigo.Contains(searchString) select a).AsQueryable();
            }

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            //if (sortByColumnName == "Descripcion")
            //{
            //    if (sortDirection.Equals("desc"))
            //        data = (from a in data select a).OrderByDescending(x => x.Descripcion);
            //    else
            //        data = (from a in data select a).OrderBy(x => x.Descripcion);
            //}
            //else
            //{
            //    if ("desc".Equals(sortDirection))
            //        data = data.OrderByDescending(a => a.FechaUltimaModificacion);
            //    else
            //        data = data.OrderBy(a => a.FechaUltimaModificacion);
            //}

            //var data1 = (from a in data select a).OrderBy(x => x.Descripcion)
            //.Skip((currentPage - 1) * pageSize).Take(pageSize)
            //.ToList();
            var data1 = from a in data.OrderBy(sidx + " " + sord)
//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList()
                        select a;

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (
                    from a in data1
                    select new jqGridRowJson
                    {
                        id = a.IdArticulo.ToString(),
                        cell = new string[] {
                            "<a href="+ Url.Action("Edit",new {id = a.IdArticulo} )  +"  >Editar</>",
                            "",
                            a.IdArticulo.ToString(),
                            a.Codigo.NullSafeToString(),
                            a.NumeroInventario.NullSafeToString(),
                            a.Descripcion.NullSafeToString(),
                            a.Rubro.NullSafeToString(),
                            a.Subrubro.NullSafeToString(),
                            a.AlicuotaIVA.NullSafeToString(),
                            a.CostoPPP.NullSafeToString(),
                            a.CostoPPPDolar.NullSafeToString(),
                            a.CostoReposicion.NullSafeToString(),
                            a.CostoReposicionDolar.NullSafeToString(),
                            a.StockMinimo.NullSafeToString(),
                            a.StockReposicion.NullSafeToString(),
                            a.StockActual.NullSafeToString(),
                            a.Unidad.NullSafeToString(),
                            a.Ubicacion.NullSafeToString(),
                            a.Marca.NullSafeToString(),
                            a.Modelo.NullSafeToString(),
                            a.ParaMantenimiento.NullSafeToString() ,
                            a.CuentaCompra.NullSafeToString() ,
                            a.FechaAlta.NullSafeToString(),
                            a.UsuarioAlta.NullSafeToString(),
                            a.FechaUltimaModificacion.NullSafeToString()
                    }
                    }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public virtual ActionResult ArticulosGridDataResumido(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            var Articulos = db.Articulos.AsQueryable();
            if (_search)
            {

                Articulos = (from a in db.Articulos
                             where a.Descripcion.Contains(searchString) || a.Codigo.Contains(searchString)
                             select a).AsQueryable();

                //if (searchField == "Descripcion") { Articulos = (from a in db.Articulos where a.Descripcion.Contains(searchString) select a).AsQueryable(); }
                //else if (searchField == "Codigo") { Articulos = (from a in db.Articulos where a.Codigo.Contains(searchString) select a).AsQueryable(); }
            }

            int pageSize = rows ?? 20;
            int totalRecords = Articulos.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;
            string sortByColumnName = sidx ?? "Descripcion";
            string sortDirection = sord ?? "desc";

            if (sortByColumnName == "Descripcion")
            {
                if (sortDirection.Equals("desc"))
                    Articulos = Articulos.OrderByDescending(a => a.Descripcion);
                else
                    Articulos = Articulos.OrderBy(a => a.Descripcion);
            }
            else
            {
                if ("desc".Equals(sortDirection))
                    Articulos = Articulos.OrderByDescending(a => a.FechaUltimaModificacion);
                else
                    Articulos = Articulos.OrderBy(a => a.FechaUltimaModificacion);
            }

            var data = Articulos
                        .Include(x => x.Ubicacione)
                        .Include(x => x.Ubicacione.Deposito)
                        .Include(x => x.Rubro)
                        .Include(x => x.Subrubro)

//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToArray();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (
                    from a in data
                    select new jqGridRowJson
                    {
                        id = a.IdArticulo.ToString(),
                        cell = new string[] { 
                            //"<a href="+ Url.Action("Edit",new {id = a.IdArticulo} )  +" target='_blank' >Editar</>",
                            "<a href="+ Url.Action("Edit",new {id = a.IdArticulo} )  +"  >Editar</>",
                            "",
                            a.Codigo.NullSafeToString(),
                            a.Descripcion.NullSafeToString(),

                            (a.Rubro ?? new Rubro()).Descripcion.NullSafeToString()   ,
                            (a.Subrubro ?? new Subrubro()).Descripcion.NullSafeToString()   ,

                            a.NumeroInventario


                                        }



                    }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual FileResult Imprimir(int id) //(int id)
        {
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            //  string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString);
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.docx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "ArticuloNET_Hawk.docx";
            /*
            string plantilla = Pronto.ERP.Bll.OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.ArticuloA, SC);
            */

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();



            System.IO.File.Copy(plantilla, output); // 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 
            //Pronto.ERP.BO.Articulo fac = ArticuloManager.GetItem(SC, id, true);
            //OpenXML_Pronto.ArticuloXML_DOCX(output, fac, SC);

            //byte[] contents = ;
            //return File(contents, "application/octet-stream");

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "Articulo.docx");
        }

        void inic(ref Articulo o)
        {

        }

        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.Articulos)) throw new Exception("No tenés permisos");
            Articulo o;
            if (id <= 0)
            {
                o = new Articulo();
                inic(ref o);
            }
            else
            {
                o = db.Articulos
                    .Include(x => x.Rubro)
                    .Include(x => x.Subrubro)
                    .SingleOrDefault(x => x.IdArticulo == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        public virtual ActionResult RefrescarMascara(Articulo o)  // (IdRubro,IdSubRubro) 
        {
            CargarViewBag(o);
            return PartialView("PartialMascara", o);
        }

        void CargarViewBag(Articulo o)
        {
            ViewBag.IdRubro = new SelectList(db.Rubros, "IdRubro", "Descripcion", o.IdRubro);
            ViewBag.IdSubrubro = new SelectList(db.Subrubros, "IdSubrubro", "Descripcion", o.IdSubrubro);
            ViewBag.IdUnidad = new SelectList(db.Unidades, "IdUnidad", "Descripcion");



            var q = (from i in db.DefinicionArticulos where (i.IdRubro == o.IdRubro && i.IdSubrubro == o.IdSubrubro) orderby i.Orden select i).ToList();
            ViewBag.Mascara = q;

            var SC = Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService);
            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC);

            foreach (ProntoMVC.Data.Models.DefinicionArticulo x in q)
            {
                if (x.TablaCombo == null && x.CampoSiNo != "SI") continue;

                DataTable dt;

                try
                {
                    if (x.CampoSiNo == "SI" || x.TablaCombo == "SiNo")
                    {
                        //ViewData.Add(x.Campo, new SelectList(db.Subrubros, "IdSubrubro", "Descripcion", o.IdSubrubro));

                        //EntidadManager.ExecDinamico(SC,"SELECT " & .campocombo "," & Titul  & "  FROM " &  .TablaCombo & "")

                        dt = EntidadManager.GetStoreProcedure(SC, "SiNo_TL");
                        // ViewData.Add(x.Campo, new SelectList(dt, x.Campo, "Titulo",     o.pr   ));

                        // entitylist.Select(p => p.GetType().GetProperty("PropertyName").GetValue(p, null));
                    }
                    else
                    {
                        // ViewData.Add(x.Campo, new SelectList(db.Subrubros, "IdSubrubro", "Descripcion", o.IdSubrubro));
                        dt = EntidadManager.GetStoreProcedure(SC, x.TablaCombo + "_TL");

                    }

                    IEnumerable<DataRow> rows = dt.AsEnumerable();
                    var sq = (from r in rows select new { id = r[0], texto = r[1] }).ToList();

                    var valor = o.GetType().GetProperty(x.Campo).GetValue(o, null);
                    // var lista = new SelectList(rows, x.CampoCombo, "Titulo", valor);
                    var lista = new SelectList(sq, "id", "texto", valor);
                    //var lista = new SelectList(rows, valor);

                    ViewData.Add(x.Campo, lista);
                }
                catch (Exception e)
                {
                    ErrHandler.WriteError(e);
                    //EntidadManager.LogPronto();
                    //throw;
                }

                //If .CampoSiNo = "SI" Then
                //      'cmbSubrubro.DataSource = EntidadManager.ExecDinamico(SC,"SELECT " & .campocombo "," & Titul  & "  FROM " &  .TablaCombo & "")
                //      dt = EntidadManager.GetStoreProcedure(SC, "SiNo_TL")
                //  Else
                //      dt = EntidadManager.GetStoreProcedure(SC, .TablaCombo & "_TL")
                //  End If
                //  comboDinamico.DataSource = dt
                //  'cmbSubrubro.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, .TablaCombo)
                //  comboDinamico.DataTextField = "Titulo"
                //  If .TablaCombo = "SiNo" Or .CampoSiNo = "SI" Then
                //      comboDinamico.DataValueField = "IdSiNo"
                //  Else
                //      comboDinamico.DataValueField = .CampoCombo
                //  End If
            }
        }

        [HttpPost]
        public virtual ActionResult Edit(Articulo Articulo)
        {
            if (ModelState.IsValid)
            {
                db.Entry(Articulo).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(Articulo);
        }

        public virtual ActionResult Delete(int id)
        {
            Articulo Articulo = db.Articulos.Find(id);
            return View(Articulo);
        }

        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Articulo Articulo = db.Articulos.Find(id);
            db.Articulos.Remove(Articulo);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult DetDocumentos(string sidx, string sord, int? page, int? rows, int? Id)
        {
            int IdArticulo1 = Id ?? 0;
            var DetEntidad = db.DetalleArticulosDocumentos.Where(p => p.IdArticulo == IdArticulo1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select new
                        {
                            a.IdDetalleArticuloDocumentos,
                            a.PathDocumento
                        }).OrderBy(p => p.IdDetalleArticuloDocumentos)
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
                            id = a.IdDetalleArticuloDocumentos.ToString(),
                            cell = new string[] {
                                string.Empty, // guarda con este espacio vacio
                                a.IdDetalleArticuloDocumentos.ToString(),
                                a.PathDocumento.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdArticulo, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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

        public virtual ActionResult DetUnidades(string sidx, string sord, int? page, int? rows, int? Id)
        {
            int IdArticulo1 = Id ?? 0;
            var DetEntidad = db.DetalleArticulosUnidades.Where(p => p.IdArticulo == IdArticulo1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select new
                        {
                            a.IdDetalleArticuloUnidades,
                            a.IdUnidad,
                            a.Unidade,
                            a.Equivalencia
                        }).OrderBy(p => p.IdDetalleArticuloUnidades)
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
                            id = a.IdDetalleArticuloUnidades.ToString(),
                            cell = new string[] {
                                string.Empty, // guarda con este espacio vacio
                                a.IdDetalleArticuloUnidades.ToString(),
                                a.IdUnidad.NullSafeToString(),
                                (a.Unidade ?? new Unidad()).Abreviatura.NullSafeToString(),
                                a.Equivalencia.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
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

        [HttpPost]
        public virtual JsonResult UpdateAwesomeGridData(string formulario, string grilla) // (IEnumerable<GridBoundViewModel> gridData)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            var myListOfData = serializer.Deserialize<List<List<string>>>(grilla);

            if (ModelState.IsValid)
            {
                string tipomovimiento = "";
            }

            return Json(new { Success = 0, ex = "" });
        }

        public virtual ActionResult RemitosPendienteArticulocion(string sidx, string sord, int? page, int? rows,
                              bool _search, string searchField, string searchOper, string searchString,
                              string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.DetalleRemitos
                        .Include(x => x.Remito).Include(x => x.Remito.Cliente).Include(x => x.Articulo).Include(x => x.Unidade)
                        .AsQueryable();  // si queres usar include, no usar "select new" mezclando con join

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
                        select a).Where(campo).OrderBy(sidx + " " + sord)
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

        const int MAXLISTA = 100;

        public virtual ActionResult OrdenesCompraPendientesArticulor(string sidx, string sord, int? page, int? rows,
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
                        }).Where(campo).AsQueryable(); // .ToList();

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Fac
                            //join c in db.IngresoBrutos on a.IdIBCondicion equals c.IdIBCondicion
                        select a).Where(campo).OrderBy(sidx + " " + sord)
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

        public virtual ActionResult Articulos()
        {
            Dictionary<int, string> articulos = new Dictionary<int, string>();
            foreach (Articulo a in db.Articulos.ToList())
                articulos.Add(a.IdArticulo, a.Descripcion);
            return PartialView("Select", articulos);
        }








        public virtual JsonResult GetCodigosArticulosAutocomplete_Equipos(string term)
        {



            string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            DataTable dt = EntidadManager.GetStoreProcedure(nSC, "Articulos_TX_ParaMantenimiento_ParaCombo", "Compras");
            IEnumerable<DataRow> rows = dt.AsEnumerable();
            var sq = (from r in rows orderby r[1] select new { IdArticulo = r[0].NullSafeToString(),
                                                                Titulo = r[1].NullSafeToString(),
                                                                NumeroInventario = r[2].NullSafeToString()
            }).ToList();

                        

            var q = (from item in sq
                     where item.Titulo.StartsWith(term)
                     orderby item.Titulo
                     select new
                     {
                         id = item.IdArticulo,
                         value = item.Titulo, // esto es lo que se ve
                         codigo = item.Titulo
                     }).Take(MAXLISTA).ToList();



            if (q.Count == 0 && term != "No se encontraron resultados")
            {
                q.Add(new { id = "0", value = "No se encontraron resultados", codigo = "" });
            }

            var a = Json(q, JsonRequestBehavior.AllowGet);


            return a;
        }




        public virtual JsonResult GetArticulosAutocomplete(string term)
        {
            return Json((from item in db.Articulos
                         where item.Descripcion.Contains(term)
                         select new
                         {
                             value = item.IdArticulo,
                             title = item.Descripcion,
                             codigo = item.Codigo
                         }).ToList(),
                         JsonRequestBehavior.AllowGet);
        }

        public virtual ContentResult GetCodigosArticulosAutocomplete(string q, int limit, Int64 timestamp)
        {
            StringBuilder responseContentBuilder = new StringBuilder();
            var Articulos = (from a in db.Articulos select new { a.IdArticulo, a.Codigo, a.Descripcion }).Where(a => a.Codigo.StartsWith(q)).OrderBy(a => a.Codigo).Take(limit);

            foreach (var a in Articulos)
                responseContentBuilder.Append(String.Format("{0}|{1}|{2}\n", a.IdArticulo, a.Codigo, a.Descripcion));

            return Content(responseContentBuilder.ToString());
        }

        public virtual JsonResult GetCodigosArticulosAutocomplete2(string term)
        {

            var q = (from item in db.Articulos
                     where item.Codigo.StartsWith(term)
                     orderby item.Codigo
                     select new
                     {
                         id = item.IdArticulo,
                         value = item.Codigo, // esto es lo que se ve
                         codigo = item.Codigo,
                         title = item.Descripcion, // esto es lo que se pega
                         iva = item.AlicuotaIVA,
                         IdUnidad = item.IdUnidad,
                         Unidad = item.Unidad.Abreviatura,
                         CostoReposicion = (item.CostoReposicion ?? 0).ToString()
                     }).Take(MAXLISTA).ToList();



            if (q.Count == 0 && term != "No se encontraron resultados")
            {
                q.Add(new { id = 0, value = "No se encontraron resultados", codigo = "", title = "", iva = (decimal?)0, IdUnidad = (int?)0, Unidad = "", CostoReposicion = "0" });
            }

            var a = Json(q, JsonRequestBehavior.AllowGet);


            return a;
        }

        public virtual JsonResult GetArticulosAutocomplete2(string term)
        {
            Parametros parametros = db.Parametros.Find(1);
            int mvarIdUnidadCU = parametros.IdUnidadPorUnidad ?? 0;
            string mvarIdUnidadCUdesc;

            try
            {
                mvarIdUnidadCUdesc = mvarIdUnidadCU > 0 ? (db.Unidades.Find(mvarIdUnidadCU) ?? new Unidad()).Abreviatura : "";
            }
            catch (Exception ex)
            {
                ErrHandler.WriteError(ex);
                mvarIdUnidadCUdesc = "";
            }

            var s = parametros.IdControlCalidadStandar;
            var s2 = parametros.ControlCalidadDefault;

            var q = (from item in db.Articulos
                     where item.Descripcion.ToLower().Contains(term.ToLower())   //.StartsWith(term.ToLower())
                     //            where SqlFunctions.StringConvert((decimal?)item.IdArticulo).Contains(term) ||

                     orderby item.Descripcion
                     select new
                     {
                         id = item.IdArticulo,
                         value = item.Descripcion,
                         codigo = item.Codigo,
                         iva = item.AlicuotaIVA,
                         IdUnidad = item.IdUnidad ?? mvarIdUnidadCU,
                         Unidad = item.Unidad.Abreviatura ?? mvarIdUnidadCUdesc,
                         CostoReposicion = (item.CostoReposicion ?? 0).ToString()
                     }).Take(MAXLISTA).ToList();

            if (q.Count == 0 && term != "No se encontraron resultados")
            {
                q.Add(new { id = 0, value = "No se encontraron resultados", codigo = "", iva = (decimal?)0, IdUnidad = 0, Unidad = "", CostoReposicion = "0" });
            }
            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetArticulosAutocompletePorIdTransportista(string term, Int32 IdTransportista = 0)
        {
            Parametros parametros = db.Parametros.Find(1);
            int mvarIdUnidadCU = parametros.IdUnidadPorUnidad ?? 0;
            string mvarIdUnidadCUdesc;

            try
            {
                mvarIdUnidadCUdesc = mvarIdUnidadCU > 0 ? (db.Unidades.Find(mvarIdUnidadCU) ?? new Unidad()).Abreviatura : "";
            }
            catch (Exception ex)
            {
                ErrHandler.WriteError(ex);
                mvarIdUnidadCUdesc = "";
            }

            var s = parametros.IdControlCalidadStandar;
            var s2 = parametros.ControlCalidadDefault;

            var q = (from item in db.Articulos
                     where item.Descripcion.ToLower().Contains(term.ToLower()) && (IdTransportista < 0 || (item.IdTransportista ?? -1) == IdTransportista)
                     orderby item.Descripcion
                     select new
                     {
                         id = item.IdArticulo,
                         value = item.Descripcion,
                         codigo = item.Codigo
                     }).Take(MAXLISTA).ToList();

            if (q.Count == 0 && term != "No se encontraron resultados")
            {
                q.Add(new { id = 0, value = "No se encontraron resultados", codigo = "" });
            }
            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetObrasAutocomplete2(string term)
        {




            var q = (from item in db.Obras
                     where (item.NumeroObra.ToLower() + " - " + item.Descripcion.ToLower()).Contains(term.ToLower())
                           && item.Activa != "NO"
                     //.StartsWith(term.ToLower())
                     //            where SqlFunctions.StringConvert((decimal?)item.IdArticulo).Contains(term) ||

                     orderby item.NumeroObra
                     select new
                     {
                         id = item.IdObra,
                         value = item.NumeroObra + " - " + (item.Descripcion ?? ""),
                         descripcion = (item.Descripcion ?? "")
                         // NumeroObra = y.NumeroObra + " - " + (y.Descripcion ?? "")
                         //iva = item.AlicuotaIVA,
                         //IdUnidad = item.IdUnidad,
                         //Unidad = item.Unidad.Abreviatura
                     }).Take(MAXLISTA).ToList();



            if (q.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetIdsArticulosAutocomplete(string term)
        {
            return Json((from item in db.Articulos
                         where SqlFunctions.StringConvert((decimal?)item.IdArticulo).Contains(term)
                         select new
                         {
                             value = item.IdArticulo,
                             title = item.Descripcion
                         }).ToList(),
                         JsonRequestBehavior.AllowGet);
        }

        private string GetFilter(string searchingName, JqGridSearchOperators searchingOperator, string searchingValue)
        {
            string searchingOperatorString = String.Empty;
            switch (searchingOperator)
            {
                case JqGridSearchOperators.Eq:
                    searchingOperatorString = "=";
                    break;
                case JqGridSearchOperators.Ne:
                    searchingOperatorString = "!=";
                    break;
                case JqGridSearchOperators.Lt:
                    searchingOperatorString = "<";
                    break;
                case JqGridSearchOperators.Le:
                    searchingOperatorString = "<=";
                    break;
                case JqGridSearchOperators.Gt:
                    searchingOperatorString = ">";
                    break;
                case JqGridSearchOperators.Ge:
                    searchingOperatorString = ">=";
                    break;
            }

            if ((searchingName == "ProductID") || (searchingName == "SupplierID") || (searchingName == "CategoryID"))
                return String.Format("{0} {1} {2}", searchingName, searchingOperatorString, searchingValue);

            if ((searchingName == "ProductName"))
            {
                switch (searchingOperator)
                {
                    case JqGridSearchOperators.Bw:
                        return String.Format("{0}.StartsWith(\"{1}\")", searchingName, searchingValue);
                    case JqGridSearchOperators.Bn:
                        return String.Format("!{0}.StartsWith(\"{1}\")", searchingName, searchingValue);
                    case JqGridSearchOperators.Ew:
                        return String.Format("{0}.EndsWith(\"{1}\")", searchingName, searchingValue);
                    case JqGridSearchOperators.En:
                        return String.Format("!{0}.EndsWith(\"{1}\")", searchingName, searchingValue);
                    case JqGridSearchOperators.Cn:
                        return String.Format("{0}.Contains(\"{1}\")", searchingName, searchingValue);
                    case JqGridSearchOperators.Nc:
                        return String.Format("!{0}.Contains(\"{1}\")", searchingName, searchingValue);
                    default:
                        return String.Format("{0} {1} \"{2}\"", searchingName, searchingOperatorString, searchingValue);
                }
            }

            return String.Empty;
        }

        public virtual JsonResult GetUnidades()
        {
            var unidades = (from u in db.Unidades
                            select new { u.IdUnidad, u.Descripcion }).ToList();

            return Json(unidades, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Unidades()
        {
            Dictionary<int, string> unidades = new Dictionary<int, string>();
            foreach (Unidad u in db.Unidades.OrderBy(x => x.Abreviatura).ToList())
                unidades.Add(u.IdUnidad, u.Abreviatura);

            return PartialView("Select", unidades);
        }

        public virtual ActionResult ArticulosGridDataSP(string sidx, string sord, int? page, int? rows)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;
            List<Articulo> Articulos = ProntoMVC.Models.ArticuloDAL.SelectArticulos("filtro", this.Session["BasePronto"].ToString());
            int totalRecords = Articulos.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            var data = Articulos
//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToArray();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (
                    from a in data
                    select new jqGridRowJson
                    {
                        id = a.IdArticulo.ToString(),
                        cell = new string[] {
                            "<a href='" + string.Format("./Articulo/Edit/{0}", a.IdArticulo.ToString()) + "'>Edit</a>",
                            "<a href='" + string.Format("./Articulo/Delete/{0}", a.IdArticulo.ToString()) + "'>Delete</a>",
                            a.Codigo,
                            a.Descripcion } //a.PostedOn.Value.ToShortDateString()
                    }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult ArticulosGridData2(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Articulos = db.Articulos.AsQueryable();
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "idarticulo":
                        campo = String.Format("{0} = {1}", searchField, searchString);
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

            var Articulos1 = (from a in Articulos select a).Where(campo).Select(a => a.IdArticulo);



            int totalRecords = Articulos1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Articulos
                        select new
                        {
                            IdArticulo = a.IdArticulo,
                            Codigo = a.Codigo,
                            Descripcion = a.Descripcion,
                            IdUnidad = a.IdUnidad,
                            Unidad = a.Unidad.Abreviatura,
                            Iva = a.AlicuotaIVA
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
                            id = a.IdArticulo.ToString(),
                            cell = new string[] {
                                a.IdArticulo.ToString(),
                                a.Codigo,
                                a.Descripcion,
                                a.IdUnidad.ToString(),
                                a.Unidad,
                                a.Iva.ToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        public virtual FileResult Articulos_DynamicGridData_GenerarExcel(string sidx, string sord, int page, int rows, bool _search, string filters)
        {


            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.Articulo>
                                ("Ubicacione,Deposito,Rubro,Subrubro", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            var q = (from a in pagedQuery
                     select new
                     {
                         aa = a.Codigo.ToString() + ", " + "adsasdasd"
                     }).ToList();



            string myCSV = string.Join("\n", q.Select(i => i.aa.ToString()).ToArray());




            var contentType = "text/csv";
            //var content = "<content>Your content</content>";
            var bytes = Encoding.UTF8.GetBytes(myCSV);
            var result = new FileContentResult(bytes, contentType);
            result.FileDownloadName = "Articulo.csv";
            return result;




            /*

            string output = "Articulo.csv";
            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();



            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, output);
            */

        }



        public virtual JsonResult Articulos_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, int IdRubro = 0)
        {

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;


            var data = (from a in db.Articulos where (IdRubro == 0 || (IdRubro != 0 && a.IdRubro == IdRubro)) select a).AsQueryable();

            //var pagedQuery = Filters.FiltroGenerico<Data.Models.Articulo>
            //                    ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<Data.Models.Articulo>
                                (sidx, sord, page, rows, _search, filters, db, ref totalRecords, data);

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            var q = pagedQuery.ToList();


            var jsonData = new ProntoMVC.Controllers.jqGridJson()
            {
                total = (totalRecords + rows - 1) / rows,
                page = page,
                records = totalRecords,
                rows = (from a in q
                        select new ProntoMVC.Controllers.jqGridRowJson
                        {
                            id = a.IdArticulo.ToString(),
                            cell = new string[] { 
                            //"<a href="+ Url.Action("Edit",new {id = a.IdArticulo} )  +" target='_blank' >Editar</>",
                            "<a href="+ Url.Action("Edit",new {id = a.IdArticulo} )  +"  >Editar</>",
                             a.IdArticulo.NullSafeToString(),

                            a.Codigo.NullSafeToString(),
                            a.NumeroInventario.NullSafeToString() ,

                            a.Descripcion.NullSafeToString(),

                            (a.Rubro ?? new Rubro()).Descripcion.NullSafeToString()   ,
                            (a.Subrubro ?? new Subrubro()).Descripcion.NullSafeToString()   ,
                            a.AlicuotaIVA.NullSafeToString(),
                            a.CostoPPP.NullSafeToString(),
                            a.CostoPPPDolar.NullSafeToString(),
                            a.CostoReposicion.NullSafeToString(),
                            a.CostoReposicionDolar.NullSafeToString(),
                            a.StockMinimo.NullSafeToString(),
                            a.StockReposicion.NullSafeToString(),

                           ((db.Stocks.Where(x => x.IdArticulo == a.IdArticulo).Sum(y => y.CantidadUnidades)) ?? 0).NullSafeToString() ,


                            (a.Unidad ?? new Unidad()).Abreviatura.NullSafeToString()   ,

                             (a.Ubicacione != null ?
                             (
                          (a.Ubicacione.Deposito != null ? " " + a.Ubicacione.Deposito.Abreviatura : "")
                          + (a.Ubicacione.Descripcion != null ? " " + a.Ubicacione.Descripcion : "")
                          + (a.Ubicacione.Estanteria != null ? " Est.:" + a.Ubicacione.Estanteria : "")
                          + (a.Ubicacione.Modulo != null ? " Mod.:" + a.Ubicacione.Modulo : "")
                          + (a.Ubicacione.Gabeta != null ? " Gab.:" + a.Ubicacione.Gabeta : "")
                          )
                          : "")
                          ,



                          a.Marca != null ? a.Marca.Descripcion : "",

                            (a.Modelo ?? new Modelo()).Descripcion.NullSafeToString()   ,


                            a.ParaMantenimiento.NullSafeToString() ,


                               (a.Cuenta ?? new Cuenta()).Descripcion.NullSafeToString()   ,



                            a.FechaAlta.NullSafeToString() ,
                            a.UsuarioAlta.NullSafeToString() ,
                            a.FechaUltimaModificacion.NullSafeToString() ,

                            a.NumeroInventario.NullSafeToString()  ,

                            a.IdArticulo.NullSafeToString(),
                            a.IdUnidad.NullSafeToString(),

                            (a.Unidad ?? new Unidad()).Abreviatura.NullSafeToString()   ,






                            }
                        }
                        ).ToArray()
            };


            return Json(jsonData, JsonRequestBehavior.AllowGet);

        }



        public virtual JsonResult GetStoreProc(string sp, string p1, string p2, string p3, string p4, string p5, string p6, string p7)
        {
            SqlParameter[] parametros;
            SqlParameter storedParam = new SqlParameter("@ip", p1);

            //var dt = TablasDAL.GetStore(this.Session["BasePronto"].ToString(), sp, parametros);

            var dt = EntidadManager.GetStoreProcedure(SCsql(), sp, p1);

            var unidades = (from DataRow u in dt.Rows
                            select new
                            {
                                value = u[0].ToString(),
                                title = u[1].ToString()
                            }
                           ).ToList();

            return Json(unidades, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetStoreProcSinParametros(string sp)
        {
            var dt = EntidadManager.GetStoreProcedure(SCsql(), sp);

            var unidades = (from DataRow u in dt.Rows
                            select new
                            {
                                value = u[0].ToString(),
                                title = u[1].ToString()
                            }
                           ).ToList();

            return Json(unidades, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetParametro(string param)
        {
            Parametros parametros = db.Parametros.Find(1);
            var q = parametros.IdControlCalidadStandar ?? -1;



            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetArticuloPorId(int IdArticulo)
        {
            var filtereditems = (from a in db.Articulos
                                 where (a.IdArticulo == IdArticulo)
                                 select new
                                 {
                                     id = a.IdArticulo,
                                     Articulo = a.Descripcion.Trim(),
                                     value = a.Descripcion.Trim()
                                 }).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetTiposDeDescripcion()
        {
            Dictionary<int, string> TiposDeDescripcion = new Dictionary<int, string>();
            TiposDeDescripcion.Add(1, "Solo material");
            TiposDeDescripcion.Add(2, "Solo observaciones");
            TiposDeDescripcion.Add(3, "Material + observaciones");

            return PartialView("Select", TiposDeDescripcion);
        }


        public virtual JsonResult GetEquiposPorObra(int IdObra)
        {
            //var oRsx = Pronto.ERP.Bll.EntidadManager.TraerFiltrado(SCsql(), ProntoFuncionesGenerales.enumSPs.Articulos_TX_BD_ProntoMantenimientoTodos, IdObra);
            //if (oRsx.Rows.Count > 0)
            //{
            //    if (oRsx.Rows[0]["Obra"] != null) PorObra = true;
            //    mIdObra = (int)oRsx.Rows[0]["IdObra"];
            //}

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Articulos_TX_BD_ProntoMantenimientoTodos", IdObra);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            var data = (from a in Entidad
                        select new
                        {
                            id = a["IdArticulo"].ToString(),
                            value = a["Titulo"].ToString()
                        }).ToList();

            return Json(data, JsonRequestBehavior.AllowGet);
        }

    }
}
