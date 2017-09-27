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
    public partial class ObraController : ProntoBaseController
    {
        public virtual ActionResult Index()
        {
            return View();
        }

        public virtual ActionResult Edit(int id)
        {
            Obra o;
            if (id <= 0)
            {
                o = new Obra();
            }
            else
            {
                o = db.Obras.SingleOrDefault(x => x.IdObra == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        [HttpPost]
        public virtual JsonResult Delete(int Id)
        {
            Obra o = db.Obras.Find(Id);
            db.Obras.Remove(o);
            db.SaveChanges();
            return Json(new { Success = 1, IdObra = Id, ex = "" });
        }

        public virtual ActionResult DeleteConfirmed(int id)
        {
            Obra o = db.Obras.Find(id);
            db.Obras.Remove(o);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        void CargarViewBag(Obra o)
        {
            Parametros parametros = db.Parametros.Find(1);
            int? i = parametros.IdTipoCuentaGrupoFF;

            ViewBag.IdCliente = new SelectList(db.Clientes, "IdCliente", "RazonSocial", o.IdCliente);
            ViewBag.IdUnidadOperativa = new SelectList(db.UnidadesOperativas, "IdUnidadOperativa", "Descripcion", o.IdUnidadOperativa);
            ViewBag.IdGrupoObra = new SelectList(db.GruposObras, "IdGrupoObra", "Descripcion", o.IdGrupoObra);
            ViewBag.IdMonedaValorObra = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMonedaValorObra);
            ViewBag.IdCuentaContableFF = new SelectList(db.Cuentas.Where(x => (x.IdTipoCuenta == 2 || x.IdTipoCuenta == 4) && x.IdTipoCuentaGrupo == i).OrderBy(x => x.Codigo), "IdCuenta", "Descripcion", o.IdCuentaContableFF);
            ViewBag.IdProvincia = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvincia);
            ViewBag.IdPais = new SelectList(db.Paises, "IdPais", "Descripcion", o.IdPais);
            ViewBag.IdJefeRegional = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdJefeRegional);
            ViewBag.IdJefe = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdJefe);
            ViewBag.IdSubjefe = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdSubjefe);
            
        }

        public bool Validar(ProntoMVC.Data.Models.Obra o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            Int32 mMaxLength = 0;
            Int32 i = 0;

            string mProntoIni = "";
            string mExigirCUIT = "";
            string mAuxS1 = "";
            string[] mAux1;
            
            Boolean result;

            if (o.Descripcion.NullSafeToString() == "") {
                sErrorMsg += "\n" + "Falta la descripcion";
            }
            else
            {
                mMaxLength = GetMaxLength<Obra>(x => x.Descripcion) ?? 0;
                if (o.Descripcion.Length > mMaxLength) { sErrorMsg += "\n" + "La descripcion no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.NumeroObra.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta el codigo de la obra";
            }
            else
            {
                mMaxLength = GetMaxLength<Obra>(x => x.NumeroObra) ?? 0;
                if (o.NumeroObra.Length > mMaxLength) { sErrorMsg += "\n" + "El codigo de la obra no puede tener mas de " + mMaxLength + " digitos"; }
            }

            mProntoIni = BuscarClaveINI("Exigir jerarquia en alta de obra", -1);
            mAuxS1 = o.Jerarquia ?? "";
            if ((mProntoIni ?? "") == "SI" && mAuxS1.Length > 0 && mAuxS1 != "0.0.00.00.000")
            {
                mAux1 = mAuxS1.Split('.');
                if (mAux1.Length != 5) { 
                    sErrorMsg += "\n" + "La jerarquia debe tener el formato x.x.xx.xx.xxx";
                }
                else
                {
                    i = 1;
                    foreach (string mAux0 in mAux1)
                    {
                        if (i <= 2 && mAux0.Length != 1) { sErrorMsg += "\n" + "La jerarquia debe tener el formato x.x.xx.xx.xxx"; }
                        if ((i == 3 || i == 4) && mAux0.Length != 2) { sErrorMsg += "\n" + "La jerarquia debe tener el formato x.x.xx.xx.xxx"; }
                        if (i == 5 && mAux0.Length != 3) { sErrorMsg += "\n" + "La jerarquia debe tener el formato x.x.xx.xx.xxx"; }
                        i += 1;
                    }
                }
            }

            if (db.Obras.Any(x => x.NumeroObra == o.NumeroObra && x.IdObra != o.IdObra)) { sErrorMsg += "\n" + "El codigo de la obra ya existen"; }

            if (sErrorMsg != "") return false;
            else return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(Obra Obra)
        {
            try
            {
                string errs = "";
                if (!Validar(Obra, ref errs))
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
                    Boolean mCrearCuentasGasto = false;
                    string mJerarquiaAnterior = "";

                    if (Obra.IdObra > 0) { mJerarquiaAnterior = db.Obras.Where(x => x.IdObra == Obra.IdObra).Select(x => x.Jerarquia).FirstOrDefault() ?? ""; }
                    if ((Obra.Jerarquia ?? "").Length > 0 && (Obra.Jerarquia ?? "") != "0.0.00.00.000" && mJerarquiaAnterior.Length == 0) { mCrearCuentasGasto = true; }
                    
                    if (Obra.FechaFinalizacion != null) { db.Obras_EliminarCuentasNoUsadasPorIdObra(Obra.IdObra); }

                    string usuario = ViewBag.NombreUsuario;
                    int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                    if (Obra.IdObra > 0)
                    {
                        var EntidadOriginal = db.Obras.Where(p => p.IdObra == Obra.IdObra).Include(p => p.DetalleObrasPolizas).Include(p => p.DetalleObrasEquiposInstalados).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Obra);

                        foreach (var d in Obra.DetalleObrasPolizas)
                        {
                            var DetalleEntidadOriginal = EntidadOriginal.DetalleObrasPolizas.Where(c => c.IdDetalleObraPoliza == d.IdDetalleObraPoliza && d.IdDetalleObraPoliza > 0).SingleOrDefault();
                            if (DetalleEntidadOriginal != null)
                            {
                                var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                DetalleEntidadEntry.CurrentValues.SetValues(d);
                            }
                            else
                            {
                                EntidadOriginal.DetalleObrasPolizas.Add(d);
                            }
                        }
                        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleObrasPolizas.Where(c => c.IdDetalleObraPoliza != 0).ToList())
                        {
                            if (!Obra.DetalleObrasPolizas.Any(c => c.IdDetalleObraPoliza == DetalleEntidadOriginal.IdDetalleObraPoliza))
                            {
                                EntidadOriginal.DetalleObrasPolizas.Remove(DetalleEntidadOriginal);
                                db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                            }
                        }

                        foreach (var d in Obra.DetalleObrasEquiposInstalados)
                        {
                            var DetalleEntidadOriginal = EntidadOriginal.DetalleObrasEquiposInstalados.Where(c => c.IdDetalleObraEquipoInstalado == d.IdDetalleObraEquipoInstalado && d.IdDetalleObraEquipoInstalado > 0).SingleOrDefault();
                            if (DetalleEntidadOriginal != null)
                            {
                                var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                DetalleEntidadEntry.CurrentValues.SetValues(d);
                            }
                            else
                            {
                                EntidadOriginal.DetalleObrasEquiposInstalados.Add(d);
                            }
                        }
                        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleObrasEquiposInstalados.Where(c => c.IdDetalleObraEquipoInstalado != 0).ToList())
                        {
                            if (!Obra.DetalleObrasEquiposInstalados.Any(c => c.IdDetalleObraEquipoInstalado == DetalleEntidadOriginal.IdDetalleObraEquipoInstalado))
                            {
                                EntidadOriginal.DetalleObrasEquiposInstalados.Remove(DetalleEntidadOriginal);
                                db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                            }
                        }

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Obras.Add(Obra);
                    }
                    db.SaveChanges();

                    if (mCrearCuentasGasto && (Obra.Jerarquia ?? "").Length > 0 && (Obra.Jerarquia ?? "") != "0.0.00.00.000")
                    {
                        var CuentasGastos = db.CuentasGastos.Where(c => (c.Activa ?? "") == "SI").ToList();
                        if (CuentasGastos != null)
                        {
                            Parametros parametros = db.Parametros.Find(1);
                            int? mNumeroCuenta = parametros.ProximoNumeroCuentaContable;
                            mNumeroCuenta = mNumeroCuenta ?? 1;

                            Cuenta Cuenta = new Cuenta();
                            Cuenta.Codigo = mNumeroCuenta;
                            Cuenta.Descripcion = Obra.NumeroObra;
                            Cuenta.IdTipoCuenta = 1;
                            Cuenta.IdObra = Obra.IdObra;
                            Cuenta.Jerarquia = Obra.Jerarquia;
                            Cuenta.DebeHaber = "D";
                            db.Cuentas.Add(Cuenta);

                            mNumeroCuenta += 1;

                            string mJerarquia = "";
                            string mSubJerarquia = Obra.Jerarquia.Substring(0, 7);
                            Int32 mSubJerarquia4 = Convert.ToInt32(Obra.Jerarquia.Substring(7, 2));
                            Int32 mSubJerarquia5 = 1;

                            foreach (CuentasGasto d in CuentasGastos)
                            {
                                Int32 mIdRubroFinanciero = db.Cuentas.Where(x => x.IdCuenta == d.IdCuentaMadre).Select(x => x.IdRubroFinanciero).FirstOrDefault() ?? 0;

                                Cuenta = new Cuenta();
                                if ((d.Titulo ?? "") == "SI")
                                {
                                    Cuenta.IdTipoCuenta = 1;
                                    mSubJerarquia4 += 1;
                                    mSubJerarquia5 = 0;
                                }
                                else
                                {
                                    Cuenta.IdTipoCuenta = 2;
                                }
                                mJerarquia = mSubJerarquia + Convert.ToString(mSubJerarquia4).PadLeft(2, '0') + "." + Convert.ToString(mSubJerarquia5).PadLeft(3, '0');
                                
                                Cuenta.Codigo = mNumeroCuenta;
                                Cuenta.Descripcion = d.Descripcion;
                                Cuenta.IdObra = Obra.IdObra;
                                Cuenta.Jerarquia = mJerarquia;
                                Cuenta.DebeHaber = "D";
                                Cuenta.IdRubroContable = d.IdRubroContable;
                                Cuenta.IdRubroFinanciero = mIdRubroFinanciero;
                                Cuenta.IdCuentaGasto = d.IdCuentaGasto;
                                Cuenta.ImputarAPresupuestoDeObra = "SI";
                                db.Cuentas.Add(Cuenta);

                                mNumeroCuenta += 1;
                                mSubJerarquia5 += 1;
                            }
                            Parametros parametros2 = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
                            parametros2.ProximoNumeroCuentaContable = mNumeroCuenta;
                            db.Entry(parametros2).State = System.Data.Entity.EntityState.Modified;
                            
                            db.SaveChanges();
                        }
                    }
                    return Json(new { Success = 1, IdObra = Obra.IdObra, ex = "" });
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

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string activas)
        {
            if (activas == "") { activas = "SI"; }
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

            var data = (from a in db.Obras.Where(p => (p.Activa ?? "NO") == activas).AsQueryable()
                        from b in db.Clientes.Where(o => o.IdCliente == a.IdCliente).DefaultIfEmpty()
                        from c in db.UnidadesOperativas.Where(o => o.IdUnidadOperativa == a.IdUnidadOperativa).DefaultIfEmpty()
                        from d in db.Monedas.Where(o => o.IdMoneda == a.IdMonedaValorObra).DefaultIfEmpty()
                        from e in db.Articulos.Where(o => o.IdArticulo == a.IdArticuloAsociado).DefaultIfEmpty()
                        from f in db.GruposObras.Where(o => o.IdGrupoObra == a.IdGrupoObra).DefaultIfEmpty()
                        from g in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaContableFF).DefaultIfEmpty()
                        from h in db.Localidades.Where(o => o.IdLocalidad == a.IdLocalidad).DefaultIfEmpty()
                        from i in db.Provincias.Where(o => o.IdProvincia == a.IdProvincia).DefaultIfEmpty()
                        from j in db.Paises.Where(o => o.IdPais == a.IdPais).DefaultIfEmpty()
                        from k in db.Empleados.Where(o => o.IdEmpleado == a.IdJefeRegional).DefaultIfEmpty()
                        from l in db.Empleados.Where(o => o.IdEmpleado == a.IdJefe).DefaultIfEmpty()
                        from m in db.Empleados.Where(o => o.IdEmpleado == a.IdSubjefe).DefaultIfEmpty()
                        select new
                        {
                            a.IdObra,
                            a.Descripcion,
                            a.NumeroObra,
                            TipoObraDescripcion = (a.TipoObra ?? 1) == 1 ? "Taller" : ((a.TipoObra ?? 1) == 2 ? "Montaje" : ((a.TipoObra ?? 1) == 3 ? "Servicio" : "")),
                            a.Activa,
                            a.FechaInicio,
                            a.FechaFinalizacion,
                            a.FechaEntrega,
                            a.Jerarquia,
                            JefeRegional = k != null ? k.Nombre : "",
                            Jefe = l != null ? l.Nombre : "",
                            Subjefe = m != null ? m.Nombre : "",
                            CuentaContableFF = g != null ? g.Descripcion : "",
                            GrupoObra = f != null ? f.Descripcion : "",
                            ArticuloAsociado = e != null ? e.Descripcion : "",
                            a.ValorObra,
                            Moneda = d != null ? d.Abreviatura : "",
                            a.Direccion,
                            Localidad = h != null ? h.Nombre : "",
                            a.CodigoPostal,
                            Provincia = i != null ? i.Nombre : "",
                            Pais = j != null ? j.Descripcion : "",
                            a.Telefono,
                            a.Responsable,
                            a.LugarPago,
                            a.ProximoNumeroAutorizacionCompra,
                            a.OrdenamientoSecundario,
                            a.ActivarPresupuestoObra,
                            a.DiasLiquidacionCertificados,
                            a.Observaciones,
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
                        }).Where(campo).AsQueryable();

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .OrderBy(x => x.Descripcion)
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
                            id = a.IdObra.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdObra} ) +" >Editar</>",
                                a.IdObra.NullSafeToString(),
                                a.Descripcion.NullSafeToString(),
                                a.NumeroObra.NullSafeToString(),
                                a.TipoObraDescripcion.NullSafeToString(),
                                a.Activa.NullSafeToString(),
                                a.FechaInicio == null ? "" : a.FechaInicio.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaFinalizacion == null ? "" : a.FechaFinalizacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaEntrega == null ? "" : a.FechaEntrega.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Jerarquia.NullSafeToString(),
                                a.JefeRegional.NullSafeToString(),
                                a.Jefe.NullSafeToString(),
                                a.Subjefe.NullSafeToString(),
                                a.CuentaContableFF.NullSafeToString(),
                                a.GrupoObra.NullSafeToString(),
                                a.ArticuloAsociado.NullSafeToString(),
                                a.ValorObra.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.Direccion.NullSafeToString(),
                                a.Localidad.NullSafeToString(),
                                a.CodigoPostal.NullSafeToString(),
                                a.Provincia.NullSafeToString(),
                                a.Pais.NullSafeToString(),
                                a.Telefono.NullSafeToString(),
                                a.Responsable.NullSafeToString(),
                                a.LugarPago.NullSafeToString(),
                                a.ProximoNumeroAutorizacionCompra.NullSafeToString(),
                                a.OrdenamientoSecundario.NullSafeToString(),
                                a.DiasLiquidacionCertificados.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.ArchivoAdjunto1.NullSafeToString(),
                                a.ArchivoAdjunto2.NullSafeToString(),
                                a.ArchivoAdjunto3.NullSafeToString(),
                                a.ArchivoAdjunto4.NullSafeToString(),
                                a.ArchivoAdjunto5.NullSafeToString(),
                                a.ArchivoAdjunto6.NullSafeToString(),
                                a.ArchivoAdjunto7.NullSafeToString(),
                                a.ArchivoAdjunto8.NullSafeToString(),
                                a.ArchivoAdjunto9.NullSafeToString(),
                                a.ArchivoAdjunto10.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public class Obras2
        {
            public int IdObra { get; set; }
            public string Descripcion { get; set; }
            public string NumeroObra { get; set; }
            public string TipoObraDescripcion { get; set; }
            public string Activa { get; set; }
            public DateTime? FechaInicio { get; set; }
            public DateTime? FechaFinalizacion { get; set; }
            public DateTime? FechaEntrega { get; set; }
            public string Jerarquia { get; set; }
            public string JefeRegional { get; set; }
            public string Jefe { get; set; }
            public string Subjefe { get; set; }
            public string CuentaContableFF { get; set; }
            public string GrupoObra { get; set; }
            public string ArticuloAsociado { get; set; }
            public decimal? ValorObra { get; set; }
            public string Moneda { get; set; }
            public string Direccion { get; set; }
            public string Localidad { get; set; }
            public string CodigoPostal { get; set; }
            public string Provincia { get; set; }
            public string Pais { get; set; }
            public string Telefono { get; set; }
            public string Responsable { get; set; }
            public string LugarPago { get; set; }
            public int? ProximoNumeroAutorizacionCompra { get; set; }
            public int? OrdenamientoSecundario { get; set; }
            public string ActivarPresupuestoObra { get; set; }
            public int? DiasLiquidacionCertificados { get; set; }
            public string Observaciones { get; set; }
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
        }

        public virtual JsonResult Obras_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, string activas)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.Obras.Where(p => (p.Activa ?? "NO") == activas).AsQueryable()
                        from b in db.Clientes.Where(o => o.IdCliente == a.IdCliente).DefaultIfEmpty()
                        from c in db.UnidadesOperativas.Where(o => o.IdUnidadOperativa == a.IdUnidadOperativa).DefaultIfEmpty()
                        from d in db.Monedas.Where(o => o.IdMoneda == a.IdMonedaValorObra).DefaultIfEmpty()
                        from e in db.Articulos.Where(o => o.IdArticulo == a.IdArticuloAsociado).DefaultIfEmpty()
                        from f in db.GruposObras.Where(o => o.IdGrupoObra == a.IdGrupoObra).DefaultIfEmpty()
                        from g in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaContableFF).DefaultIfEmpty()
                        from h in db.Localidades.Where(o => o.IdLocalidad == a.IdLocalidad).DefaultIfEmpty()
                        from i in db.Provincias.Where(o => o.IdProvincia == a.IdProvincia).DefaultIfEmpty()
                        from j in db.Paises.Where(o => o.IdPais == a.IdPais).DefaultIfEmpty()
                        from k in db.Empleados.Where(o => o.IdEmpleado == a.IdJefeRegional).DefaultIfEmpty()
                        from l in db.Empleados.Where(o => o.IdEmpleado == a.IdJefe).DefaultIfEmpty()
                        from m in db.Empleados.Where(o => o.IdEmpleado == a.IdSubjefe).DefaultIfEmpty()
                        select new Obras2
                        {
                            IdObra = a.IdObra,
                            Descripcion = a.Descripcion,
                            NumeroObra = a.NumeroObra,
                            TipoObraDescripcion = (a.TipoObra ?? 1) == 1 ? "Taller" : ((a.TipoObra ?? 1) == 2 ? "Montaje" : ((a.TipoObra ?? 1) == 3 ? "Servicio" : "")),
                            Activa = a.Activa,
                            FechaInicio = a.FechaInicio,
                            FechaFinalizacion = a.FechaFinalizacion,
                            FechaEntrega = a.FechaEntrega,
                            Jerarquia = a.Jerarquia,
                            JefeRegional = k != null ? k.Nombre : "",
                            Jefe = l != null ? l.Nombre : "",
                            Subjefe = m != null ? m.Nombre : "",
                            CuentaContableFF = g != null ? g.Descripcion : "",
                            GrupoObra = f != null ? f.Descripcion : "",
                            ArticuloAsociado = e != null ? e.Descripcion : "",
                            ValorObra = a.ValorObra,
                            Moneda = d != null ? d.Abreviatura : "",
                            Direccion = a.Direccion,
                            Localidad = h != null ? h.Nombre : "",
                            CodigoPostal = a.CodigoPostal,
                            Provincia = i != null ? i.Nombre : "",
                            Pais = j != null ? j.Descripcion : "",
                            Telefono = a.Telefono,
                            Responsable = a.Responsable,
                            LugarPago = a.LugarPago,
                            ProximoNumeroAutorizacionCompra = a.ProximoNumeroAutorizacionCompra,
                            OrdenamientoSecundario = a.OrdenamientoSecundario,
                            ActivarPresupuestoObra = a.ActivarPresupuestoObra,
                            DiasLiquidacionCertificados = a.DiasLiquidacionCertificados,
                            Observaciones = a.Observaciones,
                            ArchivoAdjunto1 = a.ArchivoAdjunto1,
                            ArchivoAdjunto2 = a.ArchivoAdjunto2,
                            ArchivoAdjunto3 = a.ArchivoAdjunto3,
                            ArchivoAdjunto4 = a.ArchivoAdjunto4,
                            ArchivoAdjunto5 = a.ArchivoAdjunto5,
                            ArchivoAdjunto6 = a.ArchivoAdjunto6,
                            ArchivoAdjunto7 = a.ArchivoAdjunto7,
                            ArchivoAdjunto8 = a.ArchivoAdjunto8,
                            ArchivoAdjunto9 = a.ArchivoAdjunto9,
                            ArchivoAdjunto10 = a.ArchivoAdjunto10
                        }).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<Obras2>
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
                            id = a.IdObra.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdObra} ) +" >Editar</>",
                                a.IdObra.NullSafeToString(),
                                a.Descripcion.NullSafeToString(),
                                a.NumeroObra.NullSafeToString(),
                                a.TipoObraDescripcion.NullSafeToString(),
                                a.Activa.NullSafeToString(),
                                a.FechaInicio == null ? "" : a.FechaInicio.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaFinalizacion == null ? "" : a.FechaFinalizacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaEntrega == null ? "" : a.FechaEntrega.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Jerarquia.NullSafeToString(),
                                a.JefeRegional.NullSafeToString(),
                                a.Jefe.NullSafeToString(),
                                a.Subjefe.NullSafeToString(),
                                a.CuentaContableFF.NullSafeToString(),
                                a.GrupoObra.NullSafeToString(),
                                a.ArticuloAsociado.NullSafeToString(),
                                a.ValorObra.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.Direccion.NullSafeToString(),
                                a.Localidad.NullSafeToString(),
                                a.CodigoPostal.NullSafeToString(),
                                a.Provincia.NullSafeToString(),
                                a.Pais.NullSafeToString(),
                                a.Telefono.NullSafeToString(),
                                a.Responsable.NullSafeToString(),
                                a.LugarPago.NullSafeToString(),
                                a.ProximoNumeroAutorizacionCompra.NullSafeToString(),
                                a.OrdenamientoSecundario.NullSafeToString(),
                                a.DiasLiquidacionCertificados.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.ArchivoAdjunto1.NullSafeToString(),
                                a.ArchivoAdjunto2.NullSafeToString(),
                                a.ArchivoAdjunto3.NullSafeToString(),
                                a.ArchivoAdjunto4.NullSafeToString(),
                                a.ArchivoAdjunto5.NullSafeToString(),
                                a.ArchivoAdjunto6.NullSafeToString(),
                                a.ArchivoAdjunto7.NullSafeToString(),
                                a.ArchivoAdjunto8.NullSafeToString(),
                                a.ArchivoAdjunto9.NullSafeToString(),
                                a.ArchivoAdjunto10.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        public virtual ActionResult DetObrasPolizas(string sidx, string sord, int? page, int? rows, int? IdObra)
        {
            int IdObra1 = IdObra ?? 0;
            var Det = db.DetalleObrasPolizas.Where(p => p.IdObra == IdObra1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Proveedores.Where(o => o.IdProveedor == a.IdProveedor).DefaultIfEmpty()
                        from c in db.TiposPolizas.Where(o => o.IdTipoPoliza == a.IdTipoPoliza).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleObraPoliza,
                            a.IdProveedor,
                            a.IdTipoPoliza,
                            Proveedor = b != null ? b.RazonSocial : "",
                            TipoPoliza = c != null ? c.Descripcion : "",
                            a.NumeroPoliza,
                            a.FechaVigencia,
                            a.FechaVencimientoCuota,
                            a.Importe,
                            a.FechaEstimadaRecupero,
                            a.FechaRecupero,
                            a.FechaFinalizacionCobertura,
                            a.CondicionRecupero,
                            a.MotivoDeContratacionSeguro,
                            a.Observaciones
                        }).OrderBy(x => x.IdDetalleObraPoliza)
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
                            id = a.IdDetalleObraPoliza.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleObraPoliza.ToString(), 
                            a.IdProveedor.ToString(), 
                            a.IdTipoPoliza.ToString(), 
                            a.TipoPoliza.NullSafeToString(),
                            a.Proveedor.NullSafeToString(),
                            a.NumeroPoliza.ToString(), 
                            a.FechaVigencia == null ? "" : a.FechaVigencia.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.FechaVencimientoCuota == null ? "" : a.FechaVencimientoCuota.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.Importe.ToString(), 
                            a.FechaEstimadaRecupero == null ? "" : a.FechaEstimadaRecupero.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.FechaRecupero == null ? "" : a.FechaRecupero.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.FechaFinalizacionCobertura == null ? "" : a.FechaFinalizacionCobertura.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.CondicionRecupero.NullSafeToString(),
                            a.MotivoDeContratacionSeguro.NullSafeToString(),
                            a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetObrasEquiposInstalados(string sidx, string sord, int? page, int? rows, int? IdObra)
        {
            int IdObra1 = IdObra ?? 0;
            var Det = db.DetalleObrasEquiposInstalados.Where(p => p.IdObra == IdObra1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Articulos.Where(o => o.IdArticulo == a.IdArticulo).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleObraEquipoInstalado,
                            a.IdArticulo,
                            ArticuloCodigo = b != null ? b.Codigo : "",
                            ArticuloDescripcion = b != null ? b.Descripcion : "",
                            a.Cantidad,
                            a.FechaInstalacion,
                            a.FechaDesinstalacion,
                            a.Observaciones
                        }).OrderBy(x => x.IdDetalleObraEquipoInstalado)
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
                            id = a.IdDetalleObraEquipoInstalado.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleObraEquipoInstalado.ToString(), 
                            a.IdArticulo.NullSafeToString(),
                            a.ArticuloCodigo.NullSafeToString(),
                            a.ArticuloDescripcion.NullSafeToString(),
                            a.Cantidad.ToString(),
                            a.FechaInstalacion == null ? "" : a.FechaInstalacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.FechaDesinstalacion == null ? "" : a.FechaDesinstalacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.Observaciones.NullSafeToString()
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

        public virtual ActionResult GetObras()
        {
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            foreach (Obra u in db.Obras.Where(x => x.Activa == "SI").OrderBy(x => x.Descripcion).ToList())
                Datacombo.Add(u.IdObra, u.Descripcion);

            return PartialView("Select", Datacombo);
        }

        public virtual ActionResult GetObrasCodigo()
        {
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            foreach (Obra u in db.Obras.Where(x => x.Activa == "SI").OrderBy(x => x.NumeroObra).ToList())
                Datacombo.Add(u.IdObra, u.NumeroObra);

            return PartialView("Select", Datacombo);
        }

    }
}
