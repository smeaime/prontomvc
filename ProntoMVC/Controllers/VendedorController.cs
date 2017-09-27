using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;

using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;

using ProntoMVC.Models;
using ProntoMVC.Data.Models;
using Pronto.ERP.Bll;

namespace ProntoMVC.Controllers
{
    public partial class VendedorController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.Vendedores
                .OrderBy(s => s.IdVendedor)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Vendedores.Count() / pageSize);

            return View(Tabla);
        }

        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.Vendedores)) throw new Exception("No tenés permisos");
            Vendedor o;
            if (id <= 0)
            {
                o = new Vendedor();
            }
            else
            {
                o = db.Vendedores.SingleOrDefault(x => x.IdVendedor == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        void CargarViewBag(Vendedor o)
        {
            ViewBag.IdLocalidad = new SelectList(db.Localidades, "IdLocalidad", "Nombre", o.IdLocalidad);
            ViewBag.IdProvincia = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvincia);
            ViewBag.IdEmpleado = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdEmpleado);
        }

        public bool Validar(ProntoMVC.Data.Models.Vendedor o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            string mProntoIni = "";
            Boolean result;

            if ((o.Nombre ?? "") == "") { sErrorMsg += "\n" + "Falta el nombre"; }
            if ((o.Direccion ?? "") == "") { sErrorMsg += "\n" + "Falta la direccion"; }
            if (o.IdLocalidad == 0) { sErrorMsg += "\n" + "Falta la localidad"; }
            if (o.IdProvincia == 0) { sErrorMsg += "\n" + "Falta la provincia"; }
            if ((o.TodasLasZonas ?? "") == "") { sErrorMsg += "\n" + "Indique si el aplica a todas las zonas o no"; }
            if ((o.EmiteComision ?? "") == "") { sErrorMsg += "\n" + "Indique si corresponde comision"; }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(Vendedor Vendedor, string IdsVendedoresAsignados = "")
        {
            if (!PuedeEditar(enumNodos.Vendedores)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(Vendedor, ref errs))
                {
                    try
                    { Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest; }
                    catch (Exception)
                    { }
                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;

                    string[] words = errs.Split('\n');
                    res.Errors = words.ToList();
                    res.Message = "Hay datos invalidos";

                    return Json(res);
                }

                if (ModelState.IsValid)
                {
                    string mIdsVendedoresAsignados = "";

                    if (IdsVendedoresAsignados.Length > 0)
                    {
                        char[] delimiterChars = { ',', '.', ':', '\t' };
                        string[] vector = IdsVendedoresAsignados.Split(delimiterChars);
                        foreach (string s in vector)
                        {
                            if (s != Vendedor.IdVendedor.ToString() && !mIdsVendedoresAsignados.Contains(s))
                            {
                                mIdsVendedoresAsignados = mIdsVendedoresAsignados + "(" + s + ")";
                            }
                        }
                    }
                    Vendedor.IdsVendedoresAsignados = mIdsVendedoresAsignados;

                    if (Vendedor.IdVendedor > 0)
                    {
                        var EntidadOriginal = db.Vendedores.Where(p => p.IdVendedor == Vendedor.IdVendedor).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Vendedor);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Vendedores.Add(Vendedor);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdVendedor = Vendedor.IdVendedor, ex = "" });
                }
                else
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El registro tiene datos invalidos";

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
            }
        }

        [HttpPost]
        public virtual JsonResult Delete(int Id)
        {
            Vendedor o = db.Vendedores.Find(Id);
            db.Vendedores.Remove(o);
            db.SaveChanges();
            return Json(new { Success = 1, IdVendedor = Id, ex = "" });
        }

        public virtual ActionResult DeleteConfirmed(int id)
        {
            Vendedor o = db.Vendedores.Find(id);
            db.Vendedores.Remove(o);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Vendedores.AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdVendedor = a.IdVendedor }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        from b in db.Localidades.Where(o => o.IdLocalidad == a.IdLocalidad).DefaultIfEmpty()
                        from c in db.Provincias.Where(o => o.IdProvincia == a.IdProvincia).DefaultIfEmpty()
                        from d in db.Empleados.Where(o => o.IdEmpleado == a.IdEmpleado).DefaultIfEmpty()
                        select new
                        {
                            a.IdVendedor,
                            a.IdLocalidad,
                            a.IdProvincia,
                            a.IdEmpleado,
                            a.IdsVendedoresAsignados,
                            a.Nombre,
                            a.CodigoVendedor,
                            a.Direccion,
                            Localidad = b != null ? b.Nombre : "",
                            Provincia = c != null ? c.Nombre : "",
                            a.CodigoPostal,
                            Empleado = d != null ? d.Nombre : "",
                            a.Telefono,
                            a.Fax,
                            a.Email,
                            a.Cuit,
                            a.Comision,
                            a.TodasLasZonas,
                            a.EmiteComision
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
                            id = a.IdVendedor.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdVendedor} ) + ">Editar</>",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdVendedor.ToString(),
                                a.IdLocalidad.ToString(),
                                a.IdProvincia.ToString(),
                                a.IdEmpleado.ToString(),
                                a.IdsVendedoresAsignados.NullSafeToString(),
                                a.Nombre.NullSafeToString(),
                                a.CodigoVendedor.ToString(),
                                a.Direccion.NullSafeToString(),
                                a.Localidad.NullSafeToString(),
                                a.Provincia.NullSafeToString(),
                                a.CodigoPostal.NullSafeToString(),
                                a.Empleado.NullSafeToString(),
                                a.Telefono.NullSafeToString(),
                                a.Fax.NullSafeToString(),
                                a.Email.NullSafeToString(),
                                a.Cuit.NullSafeToString(),
                                a.Comision.ToString(),
                                a.TodasLasZonas.NullSafeToString(),
                                a.EmiteComision.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public class Vendedores2
        {
            public int IdVendedor { get; set; }
            public int? IdLocalidad { get; set; }
            public int? IdProvincia { get; set; }
            public int? IdEmpleado { get; set; }
            public string IdsVendedoresAsignados { get; set; }
            public string Nombre { get; set; }
            public int? CodigoVendedor { get; set; }
            public string Direccion { get; set; }
            public string Localidad { get; set; }
            public string Provincia { get; set; }
            public int? CodigoPostal { get; set; }
            public string Empleado { get; set; }
            public string Telefono { get; set; }
            public string Fax { get; set; }
            public string Email { get; set; }
            public string Cuit { get; set; }
            public decimal? Comision { get; set; }
            public string TodasLasZonas { get; set; }
            public string EmiteComision { get; set; }
        }

        public virtual JsonResult Vendedores_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.Vendedores
                        from b in db.Localidades.Where(o => o.IdLocalidad == a.IdLocalidad).DefaultIfEmpty()
                        from c in db.Provincias.Where(o => o.IdProvincia == a.IdProvincia).DefaultIfEmpty()
                        from d in db.Empleados.Where(o => o.IdEmpleado == a.IdEmpleado).DefaultIfEmpty()
                        select new Vendedores2
                        {
                            IdVendedor = a.IdVendedor,
                            IdLocalidad = a.IdLocalidad,
                            IdProvincia = a.IdProvincia,
                            IdEmpleado = a.IdEmpleado,
                            IdsVendedoresAsignados = a.IdsVendedoresAsignados,
                            Nombre = a.Nombre,
                            CodigoVendedor = a.CodigoVendedor,
                            Direccion = a.Direccion,
                            Localidad = b != null ? b.Nombre : "",
                            Provincia = c != null ? c.Nombre : "",
                            CodigoPostal = a.CodigoPostal,
                            Empleado = d != null ? d.Nombre : "",
                            Telefono = a.Telefono,
                            Fax = a.Fax,
                            Email = a.Email,
                            Cuit = a.Cuit,
                            Comision = a.Comision,
                            TodasLasZonas = a.TodasLasZonas,
                            EmiteComision = a.EmiteComision
                        }).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<Vendedores2>
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
                            id = a.IdVendedor.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdVendedor} ) + ">Editar</>",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdVendedor.ToString(),
                                a.IdLocalidad.ToString(),
                                a.IdProvincia.ToString(),
                                a.IdEmpleado.ToString(),
                                a.IdsVendedoresAsignados.NullSafeToString(),
                                a.Nombre.NullSafeToString(),
                                a.CodigoVendedor.ToString(),
                                a.Direccion.NullSafeToString(),
                                a.Localidad.NullSafeToString(),
                                a.Provincia.NullSafeToString(),
                                a.CodigoPostal.NullSafeToString(),
                                a.Empleado.NullSafeToString(),
                                a.Telefono.NullSafeToString(),
                                a.Fax.NullSafeToString(),
                                a.Email.NullSafeToString(),
                                a.Cuit.NullSafeToString(),
                                a.Comision.ToString(),
                                a.TodasLasZonas.NullSafeToString(),
                                a.EmiteComision.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Subgrupo(string sidx, string sord, int? page, int? rows, int? IdVendedor)
        {
            int IdVendedor1 = IdVendedor ?? 0;
            string mIdsVendedoresAsignados = "";

            var Vendedor = db.Vendedores.Where(p => p.IdVendedor == IdVendedor1).FirstOrDefault();
            if (Vendedor != null)
            { mIdsVendedoresAsignados = Vendedor.IdsVendedoresAsignados ?? ""; }

            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var data = (from a in db.Vendedores
                        where mIdsVendedoresAsignados.Contains(a.IdVendedor.ToString())
                        select new
                        {
                            IdVendedor2 = a.IdVendedor,
                            Vendedor = a.Nombre
                        }).OrderBy(x => x.Vendedor)
//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList();

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdVendedor2.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdVendedor2.ToString(), 
                            a.Vendedor.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetVendedores()
        {
            Dictionary<int, string> vendedores = new Dictionary<int, string>();
            foreach (Vendedor u in db.Vendedores.OrderBy(x => x.Nombre).ToList())
                vendedores.Add(u.IdVendedor, u.Nombre);

            return PartialView("Select", vendedores);
        }

    }
}