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
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;

namespace ProntoMVC.Controllers
{
    public partial class ProveedorController : ProntoBaseController
    {
        public virtual ActionResult Index()
        {
            return View();
        }

        public virtual ActionResult IndexEventuales()
        {
            return View();
        }

        public virtual ActionResult IndexAConfirmar()
        {
            return View();
        }

        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.Proveedores)) throw new Exception("No tenés permisos");
            Proveedor o;
            if (id <= 0)
            {
                o = new Proveedor();
            }
            else
            {
                o = db.Proveedores.SingleOrDefault(x => x.IdProveedor == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        public virtual ActionResult EditEventual(int id)
        {
            if (!PuedeLeer(enumNodos.Proveedores)) throw new Exception("No tenés permisos");
            Proveedor o;
            if (id <= 0)
            {
                o = new Proveedor();
            }
            else
            {
                o = db.Proveedores.SingleOrDefault(x => x.IdProveedor == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        [HttpPost]
        public virtual JsonResult Delete(int Id)
        {
            Proveedor o = db.Proveedores.Find(Id);
            db.Proveedores.Remove(o);
            db.SaveChanges();
            return Json(new { Success = 1, IdProveedor = Id, ex = "" });
        }

        public virtual ActionResult DeleteConfirmed(int id)
        {
            Proveedor o = db.Proveedores.Find(id);
            db.Proveedores.Remove(o);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        void CargarViewBag(Proveedor o)
        {
            ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion", o.IdCodigoIva);
            ViewBag.IdEstado = new SelectList(db.Estados_Proveedores, "IdEstado", "Descripcion", o.IdEstado);
            ViewBag.IdProvincia = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvincia);
            ViewBag.IdLocalidad = new SelectList(db.Localidades, "IdLocalidad", "Nombre", o.IdLocalidad);
            ViewBag.IdPais = new SelectList(db.Paises, "IdPais", "Descripcion", o.IdPais);
            ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", o.IdCodigoIva);
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionCompra);
            ViewBag.IdActividad = new SelectList(db.Actividades_Proveedores, "IdActividad", "Descripcion", o.IdActividad);
            ViewBag.IdListaPrecios = new SelectList(db.ListasPrecios, "IdListaPrecios", "Descripcion", o.IdListaPrecios);
            ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion",o.IdTipoRetencionGanancia);
            ViewBag.IdImpuestoDirectoSUSS = new SelectList(db.ImpuestosDirectos, "IdImpuestoDirecto", "Descripcion", o.IdImpuestoDirectoSUSS);
            ViewBag.IdIBCondicionPorDefecto = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion",o.IdIBCondicionPorDefecto);
            ViewBag.IdCuenta = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuenta);
            ViewBag.IdCuentaProvision = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuentaProvision);
            ViewBag.IdCuentaAplicacion = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuentaAplicacion);
            ViewBag.IdTransportista = new SelectList(db.Transportistas, "IdTransportista", "RazonSocial", o.IdTransportista);
            
        }

        public bool Validar(ProntoMVC.Data.Models.Proveedor o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            Int32 mMaxLength = 0;
            string mProntoIni = "";
            string mExigirCUIT = "";
            Boolean result;

            if (o.RazonSocial.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta la razon social";
            }
            else
            {
                mMaxLength = GetMaxLength<Cliente>(x => x.RazonSocial) ?? 0;
                if (o.RazonSocial.Length > mMaxLength) { sErrorMsg += "\n" + "La razon social no puede tener mas de " + mMaxLength + " digitos"; }
            }

            //if ((o.Cuit ?? "") == "") { sErrorMsg += "\n" + "Falta el CUIT del proveedor"; }

            if ((o.Eventual ?? "") != "SI")
            {
                if (o.IdEstado == null) sErrorMsg += "\n" + "Falta el estado";

                if ((o.CodigoProveedor ?? 0) == 0) { sErrorMsg += "\n" + "Falta el codigo del proveedor"; }

                if (o.Direccion.NullSafeToString() == "")
                {
                    sErrorMsg += "\n" + "Falta la dirección";
                }
                else
                {
                    mMaxLength = GetMaxLength<Cliente>(x => x.Direccion) ?? 0;
                    if (o.Direccion.Length > mMaxLength) { sErrorMsg += "\n" + "La Direccion no puede tener mas de " + mMaxLength + " digitos"; }
                }

                if ((o.IdCodigoIva ?? 0) == 0) { sErrorMsg += "\n" + "Falta la condicion de IVA del proveedor"; }

                if (((o.IBCondicion ?? 0) == 2 || (o.IBCondicion ?? 0) == 3) && (o.IBNumeroInscripcion ?? "") == "") { sErrorMsg += "\n" + "Falta el numero de inscripcion de IIBB del proveedor"; }

                if (o.RetenerSUSS == "SI" && (o.IdImpuestoDirectoSUSS ?? 0) == 0) { sErrorMsg += "\n" + "Falta la categoria SUSS del proveedor"; }

                if ((o.CodigoSituacionRetencionIVA ?? "") != "")
                {
                    if ((o.CodigoSituacionRetencionIVA ?? "").Length > 1) { sErrorMsg += "\n" + "El codigo de situacion de IVA puede tener solo 1 digito"; }
                    if (!(result = int.TryParse((o.CodigoSituacionRetencionIVA ?? ""), out mPruebaInt))) { sErrorMsg += "\n" + "El codigo de situacion de IVA debe ser numerico"; }
                }
            }

            string s = "asdasd";
            s = o.Cuit.NullSafeToString().Replace("-", "").PadLeft(11);
            o.Cuit = s.Substring(0, 2) + "-" + s.Substring(2, 8) + "-" + s.Substring(10, 1);

            if (!ProntoMVC.Data.FuncionesGenericasCSharp.CUITValido(o.Cuit.NullSafeToString())) { sErrorMsg += "\n" + "El CUIT es incorrecto"; }

            mProntoIni = BuscarClaveINI("Control estricto del CUIT", -1);
            if ((o.IdProveedor <= 0 || (mProntoIni ?? "") == "SI") && o.Cuit.Length > 0)
            {
                if (db.Proveedores.Any(x => x.Cuit == s && x.Confirmado == "SI")) { sErrorMsg += "\n" + "El CUIT ya existe"; }
            }

            if (db.Proveedores.Any(x => x.RazonSocial == s && x.Confirmado=="SI")) { sErrorMsg += "\n" + "La razon social y CUIT ya existen"; }

            DescripcionIva DescripcionIva = db.DescripcionIvas.Where(c => c.IdCodigoIva == o.IdCodigoIva).SingleOrDefault();
            if (DescripcionIva != null) { mExigirCUIT = DescripcionIva.ExigirCUIT; }
            if (mExigirCUIT == "SI" && o.Cuit.Length == 0) { sErrorMsg += "\n" + "Debe ingresar el CUIT para esta condicion de IVA"; }
            
            if (sErrorMsg != "") return false;
            else return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate([Bind(Exclude = "IdDetalleProveedor")] Proveedor Proveedor)
        {
            if (!PuedeEditar(enumNodos.Proveedores)) throw new Exception("No tenés permisos");

            try
            {
                var s = Proveedor.Cuit.Replace("-", "");
                Proveedor.Cuit = s.Substring(0, 2) + "-" + s.Substring(2, 8) + "-" + s.Substring(10, 1);

                string errs = "";
                if (!Validar(Proveedor, ref errs))
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

                if (ModelState.IsValid || true)
                {
                    string usuario = ViewBag.NombreUsuario;
                    int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                    if (Proveedor.IdProveedor > 0)
                    {
                        Proveedor.IdUsuarioModifico = IdUsuario;
                        Proveedor.FechaModifico = DateTime.Now;
                    }
                    else
                    {
                        Proveedor.IdUsuarioIngreso = IdUsuario;
                        Proveedor.FechaIngreso = DateTime.Now;
                    }

                    if (Proveedor.IdProveedor > 0)
                    {
                        var EntidadOriginal = db.Proveedores.Where(p => p.IdProveedor == Proveedor.IdProveedor).Include(p => p.DetalleProveedoresContactos).Include(p => p.DetalleProveedoresRubros).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Proveedor);

                        foreach (var d in Proveedor.DetalleProveedoresContactos)
                        {
                            var DetalleEntidadOriginal = EntidadOriginal.DetalleProveedoresContactos.Where(c => c.IdDetalleProveedor == d.IdDetalleProveedor && d.IdDetalleProveedor > 0).SingleOrDefault();
                            if (DetalleEntidadOriginal != null)
                            {
                                var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                DetalleEntidadEntry.CurrentValues.SetValues(d);
                            }
                            else
                            {
                                EntidadOriginal.DetalleProveedoresContactos.Add(d);
                            }
                        }
                        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleProveedoresContactos.Where(c => c.IdDetalleProveedor != 0).ToList())
                        {
                            if (!Proveedor.DetalleProveedoresContactos.Any(c => c.IdDetalleProveedor == DetalleEntidadOriginal.IdDetalleProveedor))
                            {
                                EntidadOriginal.DetalleProveedoresContactos.Remove(DetalleEntidadOriginal);
                                db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                            }
                        }

                        foreach (var d in Proveedor.DetalleProveedoresRubros)
                        {
                            var DetalleEntidadOriginal = EntidadOriginal.DetalleProveedoresRubros.Where(c => c.IdDetalleProveedorRubros == d.IdDetalleProveedorRubros && d.IdDetalleProveedorRubros > 0).SingleOrDefault();
                            if (DetalleEntidadOriginal != null)
                            {
                                var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                DetalleEntidadEntry.CurrentValues.SetValues(d);
                            }
                            else
                            {
                                EntidadOriginal.DetalleProveedoresRubros.Add(d);
                            }
                        }
                        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleProveedoresRubros.Where(c => c.IdDetalleProveedorRubros != 0).ToList())
                        {
                            if (!Proveedor.DetalleProveedoresRubros.Any(c => c.IdDetalleProveedorRubros == DetalleEntidadOriginal.IdDetalleProveedorRubros))
                            {
                                EntidadOriginal.DetalleProveedoresRubros.Remove(DetalleEntidadOriginal);
                                db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                            }
                        }

                        foreach (var d in Proveedor.DetalleProveedoresIBs)
                        {
                            var DetalleEntidadOriginal = EntidadOriginal.DetalleProveedoresIBs.Where(c => c.IdDetalleProveedorIB == d.IdDetalleProveedorIB && d.IdDetalleProveedorIB > 0).SingleOrDefault();
                            if (DetalleEntidadOriginal != null)
                            {
                                var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                DetalleEntidadEntry.CurrentValues.SetValues(d);
                            }
                            else
                            {
                                EntidadOriginal.DetalleProveedoresIBs.Add(d);
                            }
                        }
                        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleProveedoresIBs.Where(c => c.IdDetalleProveedorIB != 0).ToList())
                        {
                            if (!Proveedor.DetalleProveedoresIBs.Any(c => c.IdDetalleProveedorIB == DetalleEntidadOriginal.IdDetalleProveedorIB))
                            {
                                EntidadOriginal.DetalleProveedoresIBs.Remove(DetalleEntidadOriginal);
                                db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                            }
                        }

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Proveedores.Add(Proveedor);
                    }
                    db.SaveChanges();

                    return Json(new { Success = 1, IdProveedor = Proveedor.IdProveedor, ex = "" });
                }
                else
                {
                    var allErrors = ModelState.Values.SelectMany(v => v.Errors);
                    var mensajes = string.Join("; ", from i in allErrors select (i.ErrorMessage + (i.Exception == null ? "" : i.Exception.Message)));

                    ViewBag.Errores = mensajes;
                }
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException ex)
            {
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
                );
            }

            catch (Exception ex)
            {
                return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }

        public class Proveedores2
        {
            public int IdProveedor { get; set; }
            public string RazonSocial { get; set; }
            public string CodigoEmpresa { get; set; }
            public string Direccion { get; set; }
            public string Localidad { get; set; }
            public string CodigoPostal { get; set; }
            public string Provincia { get; set; }
            public string Pais { get; set; }
            public string Telefono1 { get; set; }
            public string Telefono2 { get; set; }
            public string Fax { get; set; }
            public string Email { get; set; }
            public string Cuit { get; set; }
            public string DescripcionIva { get; set; }
            public string Contacto { get; set; }
            public DateTime? FechaAlta { get; set; }
            public DateTime? FechaUltimaCompra { get; set; }
            public string Estado { get; set; }
            public string Actividad { get; set; }
            public string CondicionCompra { get; set; }
            public string PaginaWeb { get; set; }
            public string Habitual { get; set; }
            public string NombreComercial { get; set; }
            public string DatosAdicionales1 { get; set; }
            public string DatosAdicionales2 { get; set; }
            public string Observaciones { get; set; }
            public string ArchivoAdjunto1 { get; set; }
            public string ArchivoAdjunto2 { get; set; }
            public string ArchivoAdjunto3 { get; set; }
            public string ArchivoAdjunto4 { get; set; }
        }

        public virtual ActionResult Proveedores_DynamicGridData (string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            string campo = String.Empty;
            int pageSize = rows; // ?? 20;
            int currentPage = page; // ?? 1;
            int totalRecords = 0;

            var data = (from a in db.Proveedores
                        select new Proveedores2
                        {
                            IdProveedor = a.IdProveedor,
                            RazonSocial = a.RazonSocial,
                            CodigoEmpresa = a.CodigoEmpresa,
                            Direccion = a.Direccion,
                            Localidad = a.Localidad.Nombre,
                            CodigoPostal = a.CodigoPostal,
                            Provincia = a.Provincia.Nombre,
                            Pais = a.Pais.Descripcion,
                            Telefono1 = a.Telefono1,
                            Telefono2 = a.Telefono2,
                            Fax = a.Fax,
                            Email = a.Email,
                            Cuit = a.Cuit,
                            DescripcionIva = a.DescripcionIva.Descripcion,
                            Contacto = a.Contacto,
                            FechaAlta = a.FechaAlta,
                            FechaUltimaCompra = a.FechaUltimaCompra,
                            Estado = a.Estados_Proveedores != null ? a.Estados_Proveedores.Descripcion : "",
                            Actividad = "", // a.actividades_proveedores  != null ? c.Descripcion : "",
                            CondicionCompra = "", // a.condicion != null ? d.Descripcion : "",
                            PaginaWeb = a.PaginaWeb,
                            Habitual = a.Habitual,
                            NombreComercial = a.NombreFantasia,
                            DatosAdicionales1 = a.Nombre1,
                            DatosAdicionales2 = a.Nombre2,
                            Observaciones = a.Observaciones,
                            ArchivoAdjunto1 = a.ArchivoAdjunto1,
                            ArchivoAdjunto2 = a.ArchivoAdjunto2,
                            ArchivoAdjunto3 = a.ArchivoAdjunto3,
                            ArchivoAdjunto4 = a.ArchivoAdjunto4
                        }).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<Proveedores2>
                                     (sidx, sord, page, rows, _search, filters, db, ref totalRecords, data);

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);


            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdProveedor.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdProveedor} ) +" >Editar</>",
                                a.IdProveedor.NullSafeToString(),
                                a.RazonSocial.NullSafeToString(),
                                a.CodigoEmpresa.NullSafeToString(),
                                a.Direccion.NullSafeToString(),
                                a.Localidad.NullSafeToString(),
                                a.CodigoPostal.NullSafeToString(),
                                a.Provincia.NullSafeToString(),
                                a.Pais.NullSafeToString(),
                                a.Telefono1.NullSafeToString(),
                                a.Telefono2.NullSafeToString(),
                                a.Fax.NullSafeToString(),
                                a.Email.NullSafeToString(),
                                a.Cuit.NullSafeToString(),
                                a.DescripcionIva.NullSafeToString(),
                                a.Contacto.NullSafeToString(),
                                a.FechaAlta == null ? "" : a.FechaAlta.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaUltimaCompra == null ? "" : a.FechaUltimaCompra.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Estado.NullSafeToString(),
                                a.Actividad.NullSafeToString(),
                                a.CondicionCompra.NullSafeToString(),
                                a.PaginaWeb.NullSafeToString(),
                                a.Habitual.NullSafeToString(),
                                a.NombreComercial.NullSafeToString(),
                                a.DatosAdicionales1.NullSafeToString(),
                                a.DatosAdicionales2.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.ArchivoAdjunto2.NullSafeToString(),
                                a.ArchivoAdjunto3.NullSafeToString(),
                                a.ArchivoAdjunto4.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Proveedores_DynamicGridData_Resumido(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            string campo = String.Empty;
            int pageSize = rows; // ?? 20;
            int currentPage = page; // ?? 1;
            int totalRecords = 0;

            var data = (from a in db.Proveedores
                        select new Proveedores2
                        {
                            IdProveedor = a.IdProveedor,
                            RazonSocial = a.RazonSocial,
                            CodigoEmpresa = a.CodigoEmpresa,
                            Email = a.Email,
                            Cuit = a.Cuit
                        }).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<Proveedores2>
                                     (sidx, sord, page, rows, _search, filters, db, ref totalRecords, data);

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdProveedor.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdProveedor} ) +" >Editar</>",
                                a.IdProveedor.NullSafeToString(),
                                a.RazonSocial.NullSafeToString(),
                                a.CodigoEmpresa.NullSafeToString(),
                                a.Email.NullSafeToString(),
                                a.Cuit.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Proveedores(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numeroProveedor":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaProveedor":
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

            var data = (from a in db.Proveedores.Where(p => (p.Eventual ?? "") != "SI" && (p.Confirmado ?? "") != "NO").AsQueryable()
                        from b in db.Estados_Proveedores.Where(o => o.IdEstado == a.IdEstado).DefaultIfEmpty()
                        from c in db.Actividades_Proveedores.Where(o => o.IdActividad == a.IdActividad).DefaultIfEmpty()
                        from d in db.Condiciones_Compras.Where(o => o.IdCondicionCompra == a.IdCondicionCompra).DefaultIfEmpty()
                        from e in db.TiposRetencionGanancias.Where(o => o.IdTipoRetencionGanancia == a.IdTipoRetencionGanancia).DefaultIfEmpty()
                        from f in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        from g in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaProvision).DefaultIfEmpty()
                        from h in db.IBCondiciones.Where(o => o.IdIBCondicion == a.IdIBCondicionPorDefecto).DefaultIfEmpty()
                        from i in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from j in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        select new
                        {
                            a.IdProveedor,
                            a.RazonSocial,
                            a.CodigoEmpresa,
                            a.Direccion,
                            Localidad = a.Localidad.Nombre,
                            a.CodigoPostal,
                            Provincia = a.Provincia.Nombre,
                            Pais = a.Pais.Descripcion,
                            a.Telefono1,
                            a.Telefono2,
                            a.Fax,
                            a.Email,
                            a.Cuit,
                            DescripcionIva = a.DescripcionIva.Descripcion,
                            a.Contacto,
                            a.FechaAlta,
                            a.FechaUltimaCompra,
                            Estado = b != null ? b.Descripcion : "",
                            Actividad = c != null ? c.Descripcion : "",
                            CondicionCompra = d != null ? d.Descripcion : "",
                            a.PaginaWeb,
                            a.Habitual,
                            NombreComercial = a.NombreFantasia,
                            DatosAdicionales1 = a.Nombre1,
                            DatosAdicionales2 = a.Nombre2,
                            a.Observaciones,
                            InscriptoGanancias = (a.IGCondicion ?? 1) == 1 ? "NO" : "SI",
                            CategoriaGanancias = (a.IGCondicion ?? 1) == 1 ? "" : (e != null ? e.Descripcion : ""),
                            CuentaContable = f != null ? f.Descripcion : "",
                            CategoriaIIBB = (a.IBCondicion ?? 1) == 1 ? "Exento" : ((a.IBCondicion ?? 1) == 2 ? "Conv.Mult." : ((a.IBCondicion ?? 1) == 3 ? "Juris.Local" : ((a.IBCondicion ?? 1) == 4 ? "No alcanzado" : ""))),
                            a.FechaLimiteExentoIIBB,
                            a.IBNumeroInscripcion,
                            CondicionIIBB = h != null ? h.Descripcion : "",
                            a.FechaUltimaPresentacionDocumentacion,
                            a.CodigoSituacionRetencionIVA,
                            Ingreso = i != null ? i.Nombre : "",
                            a.FechaIngreso,
                            Modifico = j != null ? j.Nombre : "",
                            a.FechaModifico,
                            a.SujetoEmbargado,
                            a.SaldoEmbargo,
                            a.Calificacion,
                            CuentaContableProvision = g != null ? g.Descripcion : "",
                            a.ArchivoAdjunto1,
                            a.ArchivoAdjunto2,
                            a.ArchivoAdjunto3,
                            a.ArchivoAdjunto4
                        }).Where(campo).AsQueryable();
            
            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .OrderBy(x => x.RazonSocial)
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
                            id = a.IdProveedor.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdProveedor} ) +" >Editar</>",
                                a.IdProveedor.NullSafeToString(),
                                a.RazonSocial.NullSafeToString(),
                                a.CodigoEmpresa.NullSafeToString(),
                                a.Direccion.NullSafeToString(),
                                a.Localidad.NullSafeToString(),
                                a.CodigoPostal.NullSafeToString(),
                                a.Provincia.NullSafeToString(),
                                a.Pais.NullSafeToString(),
                                a.Telefono1.NullSafeToString(),
                                a.Telefono2.NullSafeToString(),
                                a.Fax.NullSafeToString(),
                                a.Email.NullSafeToString(),
                                a.Cuit.NullSafeToString(),
                                a.DescripcionIva.NullSafeToString(),
                                a.Contacto.NullSafeToString(),
                                a.FechaAlta == null ? "" : a.FechaAlta.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaUltimaCompra == null ? "" : a.FechaUltimaCompra.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Estado.NullSafeToString(),
                                a.Actividad.NullSafeToString(),
                                a.CondicionCompra.NullSafeToString(),
                                a.PaginaWeb.NullSafeToString(),
                                a.Habitual.NullSafeToString(),
                                a.NombreComercial.NullSafeToString(),
                                a.DatosAdicionales1.NullSafeToString(),
                                a.DatosAdicionales2.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.InscriptoGanancias.NullSafeToString(),
                                a.CategoriaGanancias.NullSafeToString(),
                                a.CuentaContable.NullSafeToString(),
                                a.CategoriaIIBB.NullSafeToString(),
                                a.FechaLimiteExentoIIBB.NullSafeToString(),
                                a.IBNumeroInscripcion.NullSafeToString(),
                                a.CondicionIIBB.NullSafeToString(),
                                a.FechaUltimaPresentacionDocumentacion == null ? "" : a.FechaUltimaPresentacionDocumentacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.CodigoSituacionRetencionIVA.NullSafeToString(),
                                a.Ingreso.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Modifico.NullSafeToString(),
                                a.FechaModifico == null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.SujetoEmbargado.NullSafeToString(),
                                a.SaldoEmbargo.NullSafeToString(),
                                a.Calificacion.NullSafeToString(),
                                a.CuentaContableProvision.NullSafeToString(),
                                a.ArchivoAdjunto1.NullSafeToString(),
                                a.ArchivoAdjunto2.NullSafeToString(),
                                a.ArchivoAdjunto3.NullSafeToString(),
                                a.ArchivoAdjunto4.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult ProveedoresEventuales(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numeroProveedor":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaProveedor":
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

            var data = (from a in db.Proveedores.Where(p => (p.Eventual ?? "") == "SI" && (p.Confirmado ?? "") != "NO").AsQueryable()
                        from c in db.Actividades_Proveedores.Where(o => o.IdActividad == a.IdActividad).DefaultIfEmpty()
                        from i in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from j in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        select new
                        {
                            a.IdProveedor,
                            a.RazonSocial,
                            a.Cuit,
                            DescripcionIva = a.DescripcionIva.Descripcion,
                            a.Telefono1,
                            a.Email,
                            Actividad = c != null ? c.Descripcion : "",
                            Ingreso = i != null ? i.Nombre : "",
                            a.FechaIngreso,
                            Modifico = j != null ? j.Nombre : "",
                            a.FechaModifico
                        }).Where(campo).AsQueryable();

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .OrderBy(x => x.RazonSocial)
                        
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
                            id = a.IdProveedor.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("EditEventual",new {id = a.IdProveedor} ) +" >Editar</>",
                                a.IdProveedor.NullSafeToString(),
                                a.RazonSocial.NullSafeToString(),
                                a.Cuit.NullSafeToString(),
                                a.DescripcionIva.NullSafeToString(),
                                a.Telefono1.NullSafeToString(),
                                a.Email.NullSafeToString(),
                                a.Actividad.NullSafeToString(),
                                a.Ingreso.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Modifico.NullSafeToString(),
                                a.FechaModifico == null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy")
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult ProveedoresAConfirmar(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numeroProveedor":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaProveedor":
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

            var data = (from a in db.Proveedores.Where(p => (p.Eventual ?? "") != "SI" && (p.Confirmado ?? "") == "NO").AsQueryable()
                        from b in db.Estados_Proveedores.Where(o => o.IdEstado == a.IdEstado).DefaultIfEmpty()
                        from c in db.Actividades_Proveedores.Where(o => o.IdActividad == a.IdActividad).DefaultIfEmpty()
                        from d in db.Condiciones_Compras.Where(o => o.IdCondicionCompra == a.IdCondicionCompra).DefaultIfEmpty()
                        from e in db.TiposRetencionGanancias.Where(o => o.IdTipoRetencionGanancia == a.IdTipoRetencionGanancia).DefaultIfEmpty()
                        from f in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        from g in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaProvision).DefaultIfEmpty()
                        from h in db.IBCondiciones.Where(o => o.IdIBCondicion == a.IdIBCondicionPorDefecto).DefaultIfEmpty()
                        from i in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from j in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        select new
                        {
                            a.IdProveedor,
                            a.RazonSocial,
                            a.CodigoEmpresa,
                            a.Direccion,
                            Localidad = a.Localidad.Nombre,
                            a.CodigoPostal,
                            Provincia = a.Provincia.Nombre,
                            Pais = a.Pais.Descripcion,
                            a.Telefono1,
                            a.Telefono2,
                            a.Fax,
                            a.Email,
                            a.Cuit,
                            DescripcionIva = a.DescripcionIva.Descripcion,
                            a.Contacto,
                            a.FechaAlta,
                            a.FechaUltimaCompra,
                            Estado = b != null ? b.Descripcion : "",
                            Actividad = c != null ? c.Descripcion : "",
                            CondicionCompra = d != null ? d.Descripcion : "",
                            a.PaginaWeb,
                            a.Habitual,
                            NombreComercial = a.NombreFantasia,
                            DatosAdicionales1 = a.Nombre1,
                            DatosAdicionales2 = a.Nombre2,
                            a.Observaciones,
                            InscriptoGanancias = (a.IGCondicion ?? 1) == 1 ? "NO" : "SI",
                            CategoriaGanancias = (a.IGCondicion ?? 1) == 1 ? "" : (e != null ? e.Descripcion : ""),
                            CuentaContable = f != null ? f.Descripcion : "",
                            CategoriaIIBB = (a.IBCondicion ?? 1) == 1 ? "Exento" : ((a.IBCondicion ?? 1) == 2 ? "Conv.Mult." : ((a.IBCondicion ?? 1) == 3 ? "Juris.Local" : ((a.IBCondicion ?? 1) == 4 ? "No alcanzado" : ""))),
                            a.FechaLimiteExentoIIBB,
                            a.IBNumeroInscripcion,
                            CondicionIIBB = h != null ? h.Descripcion : "",
                            a.FechaUltimaPresentacionDocumentacion,
                            a.CodigoSituacionRetencionIVA,
                            Ingreso = i != null ? i.Nombre : "",
                            a.FechaIngreso,
                            Modifico = j != null ? j.Nombre : "",
                            a.FechaModifico,
                            a.SujetoEmbargado,
                            a.SaldoEmbargo,
                            a.Calificacion,
                            CuentaContableProvision = g != null ? g.Descripcion : "",
                            a.ArchivoAdjunto1,
                            a.ArchivoAdjunto2,
                            a.ArchivoAdjunto3,
                            a.ArchivoAdjunto4
                        }).Where(campo).AsQueryable();

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .OrderBy(x => x.RazonSocial)
                        
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
                            id = a.IdProveedor.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdProveedor} ) +" >Editar</>",
                                a.IdProveedor.NullSafeToString(),
                                a.RazonSocial.NullSafeToString(),
                                a.CodigoEmpresa.NullSafeToString(),
                                a.Direccion.NullSafeToString(),
                                a.Localidad.NullSafeToString(),
                                a.CodigoPostal.NullSafeToString(),
                                a.Provincia.NullSafeToString(),
                                a.Pais.NullSafeToString(),
                                a.Telefono1.NullSafeToString(),
                                a.Telefono2.NullSafeToString(),
                                a.Fax.NullSafeToString(),
                                a.Email.NullSafeToString(),
                                a.Cuit.NullSafeToString(),
                                a.DescripcionIva.NullSafeToString(),
                                a.Contacto.NullSafeToString(),
                                a.FechaAlta == null ? "" : a.FechaAlta.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaUltimaCompra == null ? "" : a.FechaUltimaCompra.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Estado.NullSafeToString(),
                                a.Actividad.NullSafeToString(),
                                a.CondicionCompra.NullSafeToString(),
                                a.PaginaWeb.NullSafeToString(),
                                a.Habitual.NullSafeToString(),
                                a.NombreComercial.NullSafeToString(),
                                a.DatosAdicionales1.NullSafeToString(),
                                a.DatosAdicionales2.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.InscriptoGanancias.NullSafeToString(),
                                a.CategoriaGanancias.NullSafeToString(),
                                a.CuentaContable.NullSafeToString(),
                                a.CategoriaIIBB.NullSafeToString(),
                                a.FechaLimiteExentoIIBB.NullSafeToString(),
                                a.IBNumeroInscripcion.NullSafeToString(),
                                a.CondicionIIBB.NullSafeToString(),
                                a.FechaUltimaPresentacionDocumentacion == null ? "" : a.FechaUltimaPresentacionDocumentacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.CodigoSituacionRetencionIVA.NullSafeToString(),
                                a.Ingreso.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Modifico.NullSafeToString(),
                                a.FechaModifico == null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.SujetoEmbargado.NullSafeToString(),
                                a.SaldoEmbargo.NullSafeToString(),
                                a.Calificacion.NullSafeToString(),
                                a.CuentaContableProvision.NullSafeToString(),
                                a.ArchivoAdjunto1.NullSafeToString(),
                                a.ArchivoAdjunto2.NullSafeToString(),
                                a.ArchivoAdjunto3.NullSafeToString(),
                                a.ArchivoAdjunto4.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetProveedores(string sidx, string sord, int? page, int? rows, int? IdProveedor)
        {
            int IdProveedor1 = IdProveedor ?? 0;
            var Det = db.DetalleProveedoresContactos.Where(p => p.IdProveedor == IdProveedor).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        select new
                        {
                            a.IdDetalleProveedor,
                            a.Contacto,
                            a.Puesto,
                            a.Telefono,
                            a.Email
                        }).OrderBy(x => x.IdDetalleProveedor)
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
                            id = a.IdDetalleProveedor.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleProveedor.ToString(), 
                            a.Contacto.NullSafeToString(),
                            a.Puesto.NullSafeToString(),
                            a.Telefono.NullSafeToString(),
                            a.Email.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetProveedoresRubros(string sidx, string sord, int? page, int? rows, int? IdProveedor)
        {
            int IdProveedor1 = IdProveedor ?? 0;
            var Det = db.DetalleProveedoresRubros.Where(p => p.IdProveedor == IdProveedor).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Rubros.Where(o => o.IdRubro == a.IdRubro).DefaultIfEmpty()
                        from c in db.Subrubros.Where(p => p.IdSubrubro == a.IdSubrubro).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleProveedorRubros,
                            a.IdRubro,
                            a.IdSubrubro,
                            Rubro = b != null ? b.Descripcion : "",
                            Subrubro = c != null ? c.Descripcion : ""
                        }).OrderBy(x => x.IdDetalleProveedorRubros)
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
                            id = a.IdDetalleProveedorRubros.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleProveedorRubros.ToString(), 
                            a.IdRubro.NullSafeToString(),
                            a.IdSubrubro.NullSafeToString(),
                            a.Rubro.NullSafeToString(),
                            a.Subrubro.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetProveedoresIIBB(string sidx, string sord, int? page, int? rows, int? IdProveedor)
        {
            int IdProveedor1 = IdProveedor ?? 0;
            var Det = db.DetalleProveedoresIBs.Where(p => p.IdProveedor == IdProveedor).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.IBCondiciones.Where(o => o.IdIBCondicion == a.IdIBCondicion).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleProveedorIB,
                            a.IdIBCondicion,
                            Jurisdiccion = b != null ? b.Descripcion : "",
                            a.AlicuotaAAplicar,
                            a.FechaVencimiento
                        }).OrderBy(x => x.IdDetalleProveedorIB)
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
                            id = a.IdDetalleProveedorIB.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleProveedorIB.ToString(), 
                            a.IdIBCondicion.NullSafeToString(),
                            a.Jurisdiccion.NullSafeToString(),
                            a.AlicuotaAAplicar.NullSafeToString(),
                            a.FechaVencimiento == null ? "" : a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy")
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

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

        public virtual JsonResult GetProveedorPorId(int Id)
        {
            var filtereditems = (from a in db.Proveedores
                                 where (a.IdProveedor == Id)
                                 select new
                                 {
                                     id = a.IdProveedor,
                                     value = a.RazonSocial.Trim(),
                                     a.CodigoEmpresa,
                                     a.Direccion,
                                     Localidad = a.Localidad.Nombre,
                                     a.CodigoPostal,
                                     Provincia = a.Provincia.Nombre,
                                     Pais = a.Pais.Descripcion,
                                     Telefono = a.Telefono1,
                                     a.Fax,
                                     a.Email,
                                     a.Cuit,
                                     DescripcionIva = a.DescripcionIva.Descripcion
                                 }).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetProveedoresAutocomplete2(string term)
        {
            var q = (from item in db.Proveedores
                     where item.RazonSocial.StartsWith(term) && (item.Eventual ?? "NO") == "NO" && (item.Confirmado ?? "NO") == "SI"
                     orderby item.RazonSocial
                     select new
                     {
                         id = item.IdProveedor,
                         value = item.RazonSocial,
                         codigo = item.CodigoEmpresa,
                         IdCodigoIva = item.IdCodigoIva.ToString(),
                         IdCondicionCompra = item.IdCondicionCompra.ToString(),
                         Contacto = item.Contacto
                     }).Take(20).ToList();

            if (q.Count == 0 && term != "No se encontraron resultados") { q.Add(new { id = 0, value = "No se encontraron resultados", codigo = "", IdCodigoIva = "", IdCondicionCompra = "", Contacto = "" }); }
            //if (q.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCodigosProveedorAutocomplete(string term)
        {
            if (true) // Starwith o Contains
            {
                var q = (from item in db.Proveedores.Include(c => c.IBCondicion) // .Include(c => c.IBCondicionCat2).Include(c => c.IBCondicionCat3)
                         where item.RazonSocial.ToLower().StartsWith(term) && (item.Eventual ?? "NO") == "NO" && (item.Confirmado ?? "NO") == "SI"// .StartsWith(term, StringComparison.OrdinalIgnoreCase)
                         // where SqlFunctions.StringConvert((decimal?)item.IdArticulo).Contains(term)
                         //where (SqlFunctions.StringConvert((decimal?)item.CodigoProveedor).ToLower().Contains(term.ToLower()) || item.RazonSocial.ToLower().Contains(term.ToLower()))
                         orderby item.RazonSocial
                         select new
                         {
                             id = item.IdProveedor,
                             value = item.RazonSocial,
                             // value = SqlFunctions.StringConvert(item.Codigo) + " " + item.RazonSocial,
                             // value = item.Codigo + " " + item.RazonSocial, // esto trae problemas de COLLATION para linq... lo mejor parece ser resolver esos temas con una vista en sql

                             codigo = item.CodigoProveedor,
                             idCodigoIva = item.IdCodigoIva,
                             IdIBCondicionPorDefecto = item.IdIBCondicionPorDefecto,
                             Email = item.Email,
                             Direccion = item.Direccion,
                             Localidad = item.Localidad.Nombre,
                             Provincia = item.Provincia.Nombre,
                             Telefono = item.Telefono1,
                             Fax = item.Fax,
                             Cuit = item.Cuit,
                             IdCondicionCompra = item.IdCondicionCompra, //.IdCondicionVenta, //por qué no?
                             IdListaPrecios = item.IdListaPrecios,
                             NumeroCAI = "",
                             VencimientoCAI = ""
                         }).Take(10).ToList();

                if (q.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

                if (q.Count == 1)
                {
                    //q.First().NumeroCAI = "2222";
                    //q[0].VencimientoCAI = "adad";
                    //                                SELECT TOP 1 *  
                    //FROM ComprobantesProveedores cp  
                    //WHERE cp.IdProveedor=@IdProveedor or cp.IdProveedorEventual=@IdProveedor  
                    //ORDER BY cp.FechaComprobante DESC,cp.NumeroComprobante2 DESC  
                }

                return Json(q, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var q = (from item in db.Proveedores.Include(c => c.IBCondicion) // .Include(c => c.IBCondicionCat2).Include(c => c.IBCondicionCat3)
                         // where item.RazonSocial.StartsWith(term)
                         // where SqlFunctions.StringConvert((decimal?)item.IdArticulo).Contains(term)
                         where (SqlFunctions.StringConvert((decimal?)item.CodigoProveedor).ToLower().Contains(term.ToLower()) || item.RazonSocial.ToLower().Contains(term.ToLower()))
                         orderby item.RazonSocial
                         select new
                         {
                             id = item.IdProveedor,
                             value = item.RazonSocial,
                             codigo = item.CodigoProveedor,
                             idCodigoIva = item.IdCodigoIva,
                             IdIBCondicionPorDefecto = item.IdIBCondicionPorDefecto,
                             Email = item.Email,
                             Direccion = item.Direccion,
                             Localidad = item.Localidad.Nombre,
                             Provincia = item.Provincia.Nombre,
                             Telefono = item.Telefono1,
                             Fax = item.Fax,
                             Cuit = item.Cuit,
                             IdListaPrecios = item.IdListaPrecios //,
                         }).Take(10).ToList();
                return Json(q, JsonRequestBehavior.AllowGet);
            }
        }

        public virtual JsonResult GetCodigosProveedorAutocompleteEventuales2(int idproveedor)
        {
            var q = db.ComprobantesProveedor
                    .Where(x => x.IdProveedor == idproveedor || x.IdProveedorEventual == idproveedor)
                    .OrderByDescending(x => x.FechaComprobante).ThenByDescending(x => x.NumeroComprobante2).FirstOrDefault();

            if (q == null) return null;

            var q2 = new { q.NumeroCAI, q.FechaVencimientoCAI };

            return Json(q2, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCodigosProveedorAutocompleteEventuales(string term)
        {
            if (true) // Starwith o Contains
            {
                var q = (from item in db.Proveedores.Include(c => c.IBCondicion) // .Include(c => c.IBCondicionCat2).Include(c => c.IBCondicionCat3)
                         where item.RazonSocial.ToLower().StartsWith(term) // && (item.Eventual ?? "NO") == "NO" && (item.Confirmado ?? "NO") == "SI"// .StartsWith(term, StringComparison.OrdinalIgnoreCase)
                         orderby item.RazonSocial
                         select new
                         {
                             id = item.IdProveedor,
                             value = item.RazonSocial,
                             codigo = item.CodigoProveedor,
                             idCodigoIva = item.IdCodigoIva,
                             IdIBCondicionPorDefecto = item.IdIBCondicionPorDefecto,
                             Email = item.Email,
                             Direccion = item.Direccion,
                             Localidad = item.Localidad.Nombre,
                             Provincia = item.Provincia.Nombre,
                             Telefono = item.Telefono1,
                             Fax = item.Fax,
                             Cuit = item.Cuit,
                             IdCondicionCompra = item.IdCondicionCompra, //.IdCondicionVenta, //por qué no?
                             IdListaPrecios = item.IdListaPrecios,
                             NumeroCAI = "",
                             VencimientoCAI = ""
                         }).Take(10).ToList();

                if (q.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

                if (q.Count == 1)
                {

                }

                return Json(q, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var q = (from item in db.Proveedores.Include(c => c.IBCondicion) // .Include(c => c.IBCondicionCat2).Include(c => c.IBCondicionCat3)
                         where (SqlFunctions.StringConvert((decimal?)item.CodigoProveedor).ToLower().Contains(term.ToLower()) || item.RazonSocial.ToLower().Contains(term.ToLower()))
                         orderby item.RazonSocial
                         select new
                         {
                             id = item.IdProveedor,
                             value = item.RazonSocial,
                             codigo = item.CodigoProveedor,
                             idCodigoIva = item.IdCodigoIva,
                             IdIBCondicionPorDefecto = item.IdIBCondicionPorDefecto,
                             Email = item.Email,
                             Direccion = item.Direccion,
                             Localidad = item.Localidad.Nombre,
                             Provincia = item.Provincia.Nombre,
                             Telefono = item.Telefono1,
                             Fax = item.Fax,
                             Cuit = item.Cuit,
                             IdListaPrecios = item.IdListaPrecios //,
                         }).Take(10).ToList();
                return Json(q, JsonRequestBehavior.AllowGet);
            }
        }

    }
}
