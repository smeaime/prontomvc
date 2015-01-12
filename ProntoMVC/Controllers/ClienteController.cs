using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
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
using Pronto.ERP.Bll;

using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using Trirand.Web.Mvc;

using System.Data.Metadata.Edm;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Core.Objects.DataClasses;

namespace ProntoMVC.Controllers
{
    public partial class ClienteController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var clientes = db.Clientes
                .OrderBy(s => s.RazonSocial)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Clientes.Count() / pageSize);

            return View(clientes);
        }

        public virtual ViewResult Details(int id)
        {
            Cliente Cliente = db.Clientes.Find(id);
            return View(Cliente);
        }

        public virtual ActionResult Edit(int id)
        {
            Cliente o;
            if (id <= 0)
            {
                o = new Cliente();
            }
            else
            {
                o = db.Clientes
                        .Include(x => x.Cuenta).Include(x => x.CuentaMonedaExt)
                        .Include(x => x.Localidad).Include(x => x.LocalidadEntrega)
                        .SingleOrDefault(x => x.IdCliente == id);

            }
            CargarViewBag(o);

            return View(o);
        }

        public virtual ActionResult Delete(int id)
        {
            Cliente Cliente = db.Clientes.Find(id);
            return View(Cliente);
        }

        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Cliente Cliente = db.Clientes.Find(id);
            db.Clientes.Remove(Cliente);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        void CargarViewBag(Cliente o)
        {
            ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion", o.IdCodigoIva);
            ViewBag.IdEstado = new SelectList(db.Estados_Proveedores, "IdEstado", "Descripcion", o.IdEstado);
            ViewBag.IdProvincia = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvincia);
            ViewBag.IdLocalidad = new SelectList(db.Localidades, "IdLocalidad", "Nombre", o.IdLocalidad);
            ViewBag.IdPais = new SelectList(db.Paises, "IdPais", "Descripcion", o.IdPais);
            ViewBag.Vendedor1 = new SelectList(db.Vendedores, "IdVendedor", "Nombre", o.Vendedor1);
            ViewBag.Cobrador = new SelectList(db.Vendedores, "IdVendedor", "Nombre", o.Cobrador);
            ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", o.IdCodigoIva);
            ViewBag.IdListaPrecios = new SelectList(db.ListasPrecios, "IdListaPrecios", "Descripcion", o.IdListaPrecios);
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdCondicionVenta = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionVenta);
            ViewBag.IdBancoDebito = new SelectList(db.Bancos, "IdBanco", "Nombre", o.IdBancoDebito);
            ViewBag.IdBancoGestionador = new SelectList(db.Bancos, "IdBanco", "Nombre", o.IdBancoGestionador);
            ViewBag.IGCondicion = new SelectList(db.IGCondiciones, "IdIGCondicion", "Descripcion", o.IGCondicion);
            ViewBag.IdIBCondicionPorDefecto = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicionPorDefecto);
            ViewBag.IdIBCondicionPorDefecto2 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicionPorDefecto2);
            ViewBag.IdIBCondicionPorDefecto3 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicionPorDefecto3);
            ViewBag.IdProvinciaEntrega = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvinciaEntrega);
            ViewBag.IdLocalidadEntrega = new SelectList(db.Localidades, "IdLocalidad", "Nombre", o.IdLocalidadEntrega);
            ViewBag.IdTarjetaCredito = new SelectList(db.TarjetasCreditoes, "IdTarjetaCredito", "Nombre", o.IdLocalidadEntrega);
            ViewBag.IdTransportista = new SelectList(db.Transportistas, "IdTransportista", "RazonSocial", o.IdTransportista);
            ViewBag.IdRegion = new SelectList(db.Regiones, "IdRegion", "Descripcion", o.IdRegion);
            ViewBag.IdCuenta = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuenta);
            ViewBag.IdCuentaMonedaExt = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuentaMonedaExt);
            
        }

        private bool Validar(ProntoMVC.Data.Models.Cliente o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            string mProntoIni = "";
            string mExigirCUIT = "";
            Boolean result;

            if (o.CodigoCliente.NullSafeToString() == "") { sErrorMsg += "\n" + "Falta el codigo de cliente"; }

            if (o.RazonSocial.NullSafeToString() == "") { sErrorMsg += "\n" + "Falta la razon social"; }

            //var a = new DbModelBuilder().Entity<Cliente>().Property(p => p.RazonSocial);
            var a= GetMaxLength<Cliente>(x => x.RazonSocial);


            if (o.Direccion.NullSafeToString() == "") { sErrorMsg += "\n" + "Falta la dirección"; }

            if ((o.IdCodigoIva ?? 0) == 0) { sErrorMsg += "\n" + "Falta el codigo de IVA"; }
            
            if (o.IdProvincia == null) { sErrorMsg += "\n" + "Falta la provincia"; }
            
            if (o.IdPais == null) { sErrorMsg += "\n" + "Falta el país"; }
            
            if (o.IdCondicionVenta == null) { sErrorMsg += "\n" + "Falta la condicion venta"; }
            
            if (o.IGCondicion == null) { sErrorMsg += "\n" + "Falta la condicion ganacias"; }
            
            if (o.IdListaPrecios == null) { sErrorMsg += "\n" + "Falta la lista de precios"; }
            
            if (o.IdCuentaMonedaExt == null) { sErrorMsg += "\n" + "Falta la cuenta contable en moneda extranjera"; }
            
            if (o.IdCuenta == null) { sErrorMsg += "\n" + "Falta la cuenta contable"; }
            
            if (o.Vendedor1 == null) {sErrorMsg += "\n" + "Falta el vendedor";}

            if (o.IdEstado == null) { sErrorMsg += "\n" + "Falta el estado"; }

            string s = "asdasd";
            s = o.Cuit.NullSafeToString().Replace("-", "").PadLeft(11);
            o.Cuit = s.Substring(0, 2) + "-" + s.Substring(2, 8) + "-" + s.Substring(10, 1);

            if (!Generales.mkf_validacuit(o.Cuit.NullSafeToString())) { sErrorMsg += "\n" + "El CUIT es incorrecto"; }

            if (sErrorMsg != "") return false;
            else return true;
        }






        //public static int? GetMaxLength(string entityTypeName, string columnName)
        //{
        //    int? result = null;
           
        //    using (DbContext context = new DemoProntoEntities())
        //    {
        //        Type entType = Type.GetType(entityTypeName);


        //        var objectContext = ((IObjectContextAdapter)context).ObjectContext;

        //        var test = objectContext.MetadataWorkspace.GetItems(System.Data.Entity.Core.Metadata.Edm.DataSpace.CSpace  ); //.GetItems(DataSpace.CSpace);

        //        var q = from meta in test
        //                          // .Where(m => m.BuiltInTypeKind == BuiltInTypeKind.EntityType)
        //                from p in (meta as EntityType).Properties
        //                .Where(p => p.Name == columnName
        //                            && p.TypeUsage.EdmType.Name == "String")
        //                select p;

        //        var queryResult = q.Where(p =>
        //        {
        //            bool match = p.DeclaringType.Name == entityTypeName;
        //            if (!match && entType != null)
        //            {
        //                match = entType.Name == p.DeclaringType.Name;
        //            }

        //            return match;

        //        }).Select(sel => sel.TypeUsage.Facets["MaxLength"].Value);
        //        if (queryResult.Any())
        //        {
        //            result = Convert.ToInt32(queryResult.First());
        //        }

        //        return result;
        //    }
        //}


        public static int? GetMaxLength<T>(Expression<Func<T, string>> column)
        {
            int? result = null;
            //using (var context = new EfContext())
            using (DbContext context = new DemoProntoEntities())
            {
                var entType = typeof(T);
                var columnName = ((MemberExpression)column.Body).Member.Name;

                var objectContext = ((IObjectContextAdapter)context).ObjectContext;
                //var test = objectContext.MetadataWorkspace.GetItems(DataSpace.CSpace);
                var test = objectContext.MetadataWorkspace.GetItems(System.Data.Entity.Core.Metadata.Edm.DataSpace.CSpace); //.GetItems(DataSpace.CSpace);


                if (test == null)
                    return null;

                var q = test
                    .Where(m => m.BuiltInTypeKind == System.Data.Entity.Core.Metadata.Edm.BuiltInTypeKind.EntityType)
                    .SelectMany(meta => ((System.Data.Entity.Core.Metadata.Edm.EntityType)meta).Properties
                    .Where(p => p.Name == columnName && p.TypeUsage.EdmType.Name == "String"));

                var queryResult = q.Where(p =>
                {
                    var match = p.DeclaringType.Name == entType.Name;
                    if (!match)
                        match = entType.Name == p.DeclaringType.Name;

                    return match;

                })
                    .Select(sel => sel.TypeUsage.Facets["MaxLength"].Value)
                    .ToList();

                if (queryResult.Any())
                    result = Convert.ToInt32(queryResult.First());

                return result;
            }
        }


    //    public static int? GetMaxLength<T>(Expression<Func<T, string>> column)
    //    {
    //        int? result = null;
    //        using (var context = new DemoProntoEntities())
    //        {
    //            var entType = typeof(T);
    //            var columnName = ((MemberExpression)column.Body).Member.Name;

    //            var objectContext = ((IObjectContextAdapter)context).ObjectContext;
    //            var test = objectContext.MetadataWorkspace.GetItems(DataSpace.CSpace);
    //            if (test == null)
    //                return null;

    //            var q = test
    //                .Where(m => m.BuiltInTypeKind == BuiltInTypeKind.EntityType)
    //                .SelectMany(meta => ((EntityType)meta).Properties
    //                .Where(p => p.Name == columnName && p.TypeUsage.EdmType.Name == "String"));

    //            var queryResult = q.Where(p =>
    //            {
    //                var match = p.DeclaringType.Name == entType.Name;
    //                if (!match)
    //                    match = entType.Name == p.DeclaringType.Name;

    //                return match;

    //            })
    //                .Select(sel => sel.TypeUsage.Facets["MaxLength"].Value)
    //                .ToList();

    //            if (queryResult.Any())
    //                result = Convert.ToInt32(queryResult.First());

    //            return result;
    //        }
    //    }

        //public static int? GetMaxLength(this EntityObject entite, string nomPropriete)
        //{
        //    int? result = null;
        //    using (DbContext contexte = new DemoProntoEntities())
        //    {
        //        var queryResult = from meta in contexte.MetadataWorkspace.GetItems(DataSpace.CSpace)
        //                           .Where(m => m.BuiltInTypeKind == BuiltInTypeKind.EntityType)
        //                          from p in (meta as EntityType).Properties
        //                             .Where(p => p.DeclaringType.Name == entite.GetType().Name
        //                                 && p.Name == nomPropriete
        //                                 && p.TypeUsage.EdmType.Name == "String")
        //                          select p.TypeUsage.Facets["MaxLength"].Value;
        //        if (queryResult.Count() > 0)
        //        {
        //            result = Convert.ToInt32(queryResult.First());
        //        }
        //    }
        //    return result;
        //}







        [HttpPost]
        public virtual JsonResult BatchUpdate(Cliente Cliente)
        {
            try
            {
                var s = Cliente.Cuit.Replace("-", "");
                Cliente.Cuit = s.Substring(0, 2) + "-" + s.Substring(2, 8) + "-" + s.Substring(10, 1);

                string errs = "";
                if (!Validar(Cliente, ref errs))
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

                    if (Cliente.IdCliente > 0)
                    {
                        Cliente.IdUsuarioModifico = IdUsuario;
                        Cliente.FechaModifico = DateTime.Now;
                    }
                    else
                    {
                        Cliente.IdUsuarioIngreso = IdUsuario;
                        Cliente.FechaIngreso = DateTime.Now;
                    }

                    if (Cliente.IdCliente > 0)
                    {
                        var EntidadOriginal = db.Clientes.Where(p => p.IdCliente == Cliente.IdCliente).Include(p => p.DetalleClientesContactos).Include(p => p.DetalleClientesDirecciones).Include(p => p.DetalleClientesLugaresEntregas).Include(p => p.DetalleClientesTelefonos).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Cliente);

                        foreach (var d in Cliente.DetalleClientesContactos)
                        {
                            var DetalleEntidadOriginal = EntidadOriginal.DetalleClientesContactos.Where(c => c.IdDetalleCliente == d.IdDetalleCliente && d.IdDetalleCliente > 0).SingleOrDefault();
                            if (DetalleEntidadOriginal != null)
                            {
                                var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                DetalleEntidadEntry.CurrentValues.SetValues(d);
                            }
                            else
                            {
                                EntidadOriginal.DetalleClientesContactos.Add(d);
                            }
                        }
                        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleClientesContactos.Where(c => c.IdDetalleCliente != 0).ToList())
                        {
                            if (!Cliente.DetalleClientesContactos.Any(c => c.IdDetalleCliente == DetalleEntidadOriginal.IdDetalleCliente))
                            {
                                EntidadOriginal.DetalleClientesContactos.Remove(DetalleEntidadOriginal);
                                db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                            }
                        }

                        foreach (var d in Cliente.DetalleClientesDirecciones)
                        {
                            var DetalleEntidadOriginal = EntidadOriginal.DetalleClientesDirecciones.Where(c => c.IdDetalleClienteDireccion == d.IdDetalleClienteDireccion && d.IdDetalleClienteDireccion > 0).SingleOrDefault();
                            if (DetalleEntidadOriginal != null)
                            {
                                var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                DetalleEntidadEntry.CurrentValues.SetValues(d);
                            }
                            else
                            {
                                EntidadOriginal.DetalleClientesDirecciones.Add(d);
                            }
                        }
                        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleClientesDirecciones.Where(c => c.IdDetalleClienteDireccion != 0).ToList())
                        {
                            if (!Cliente.DetalleClientesDirecciones.Any(c => c.IdDetalleClienteDireccion == DetalleEntidadOriginal.IdDetalleClienteDireccion))
                            {
                                EntidadOriginal.DetalleClientesDirecciones.Remove(DetalleEntidadOriginal);
                                db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                            }
                        }

                        foreach (var d in Cliente.DetalleClientesLugaresEntregas)
                        {
                            var DetalleEntidadOriginal = EntidadOriginal.DetalleClientesLugaresEntregas.Where(c => c.IdDetalleClienteLugarEntrega == d.IdDetalleClienteLugarEntrega && d.IdDetalleClienteLugarEntrega > 0).SingleOrDefault();
                            if (DetalleEntidadOriginal != null)
                            {
                                var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                DetalleEntidadEntry.CurrentValues.SetValues(d);
                            }
                            else
                            {
                                EntidadOriginal.DetalleClientesLugaresEntregas.Add(d);
                            }
                        }
                        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleClientesLugaresEntregas.Where(c => c.IdDetalleClienteLugarEntrega != 0).ToList())
                        {
                            if (!Cliente.DetalleClientesLugaresEntregas.Any(c => c.IdDetalleClienteLugarEntrega == DetalleEntidadOriginal.IdDetalleClienteLugarEntrega))
                            {
                                EntidadOriginal.DetalleClientesLugaresEntregas.Remove(DetalleEntidadOriginal);
                                db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                            }
                        }

                        foreach (var d in Cliente.DetalleClientesTelefonos)
                        {
                            var DetalleEntidadOriginal = EntidadOriginal.DetalleClientesTelefonos.Where(c => c.IdDetalleClienteTelefono == d.IdDetalleClienteTelefono && d.IdDetalleClienteTelefono > 0).SingleOrDefault();
                            if (DetalleEntidadOriginal != null)
                            {
                                var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                DetalleEntidadEntry.CurrentValues.SetValues(d);
                            }
                            else
                            {
                                EntidadOriginal.DetalleClientesTelefonos.Add(d);
                            }
                        }
                        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleClientesTelefonos.Where(c => c.IdDetalleClienteTelefono != 0).ToList())
                        {
                            if (!Cliente.DetalleClientesTelefonos.Any(c => c.IdDetalleClienteTelefono == DetalleEntidadOriginal.IdDetalleClienteTelefono))
                            {
                                EntidadOriginal.DetalleClientesTelefonos.Remove(DetalleEntidadOriginal);
                                db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                            }
                        }

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Clientes.Add(Cliente);
                    }
                    db.SaveChanges();

                    return Json(new { Success = 1, IdCliente = Cliente.IdCliente, ex = "" });
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

        public virtual ActionResult Clientes(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

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

            var Entidad = db.Clientes.Where(o => (o.Confirmado ?? "") != "NO").AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdCliente = a.IdCliente }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        from b in db.Localidades.Where(o => o.IdLocalidad == a.IdLocalidadEntrega).DefaultIfEmpty()
                        from c in db.Provincias.Where(o => o.IdProvincia == a.IdProvinciaEntrega).DefaultIfEmpty()
                        from d in db.Vendedores.Where(o => o.IdVendedor == a.Vendedor1).DefaultIfEmpty()
                        from e in db.Vendedores.Where(o => o.IdVendedor == a.Cobrador).DefaultIfEmpty()
                        from f in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from g in db.Empleados.Where(o => o.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        from h in db.Estados_Proveedores.Where(o => o.IdEstado == a.IdEstado).DefaultIfEmpty()
                        from i in db.IBCondiciones.Where(o => o.IdIBCondicion == a.IdIBCondicionPorDefecto).DefaultIfEmpty()
                        from j in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        from k in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaMonedaExt).DefaultIfEmpty()
                        from l in db.Condiciones_Compras.Where(o => o.IdCondicionCompra == a.IdCondicionVenta).DefaultIfEmpty()
                        from m in db.Transportistas.Where(o => o.IdTransportista == a.IdTransportista).DefaultIfEmpty()
                        from n in db.Regiones.Where(o => o.IdRegion == a.IdRegion).DefaultIfEmpty()
                        select new
                        {
                            a.IdCliente,
                            a.RazonSocial,
                            a.Codigo,
                            Subcodigo = a.Codigo != null ? a.Codigo.Substring(1,2) : "",
                            a.Direccion,
                            Localidad = a.Localidad.Nombre,
                            a.CodigoPostal,
                            Provincia = a.Provincia.Nombre,
                            Pais = a.Pais.Descripcion,
                            a.Telefono,
                            a.Fax,
                            a.Email,
                            a.Cuit,
                            DescripcionIva = a.DescripcionIva.Descripcion,
                            a.Contacto,
                            a.DireccionEntrega,
                            LocalidadEntrega = b != null ? b.Nombre : "",
                            ProvinciaEntrega = c != null ? c.Nombre : "",
                            Vendedor = d != null ? d.Nombre : "",
                            Cobrador = e != null ? e.Nombre : "",
                            Estado = h != null ? h.Descripcion : "",
                            NombreComercial = a.NombreFantasia,
                            a.Observaciones,
                            Ingreso = f != null ? f.Nombre : "",
                            a.FechaIngreso,
                            Modifico = g != null ? g.Nombre : "",
                            a.FechaModifico,
                            CategoriaIIBB = (a.IBCondicion ?? 1) == 1 ? "Exento" : ((a.IBCondicion ?? 1) == 2 ? "Conv.Mult." : ((a.IBCondicion ?? 1) == 3 ? "Juris.Local" : ((a.IBCondicion ?? 1) == 4 ? "No alcanzado" : ""))),
                            CondicionIIBB = i != null ? i.Descripcion : "",
                            a.IBNumeroInscripcion,
                            CuentaContable = j != null ? j.Descripcion : "",
                            CuentaContableExterior = k != null ? k.Descripcion : "",
                            CondicionVenta = l != null ? l.Descripcion : "",
                            Transportista = m != null ? m.RazonSocial : "",
                            Region = n != null ? n.Descripcion : ""
                        }).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdCliente.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdCliente} ) + ">Editar</>",
                                // +"|" + "<a href=/Cliente/Details/" + a.IdCliente + ">Detalles</a> ","<a href="+ Url.Action("Imprimir",new {id = a.IdCliente} )  +">Imprimir</>" ,
                                a.IdCliente.ToString(),
                                a.RazonSocial.NullSafeToString(),
                                a.Codigo.NullSafeToString(),
                                a.Subcodigo.NullSafeToString(),
                                a.Direccion.NullSafeToString(),
                                a.Localidad.NullSafeToString(),
                                a.CodigoPostal.NullSafeToString(),
                                a.Provincia.NullSafeToString(),
                                a.Pais.NullSafeToString(),
                                a.Telefono.NullSafeToString(),
                                a.Fax.NullSafeToString(),
                                a.Email.NullSafeToString(),
                                a.Cuit.NullSafeToString(),
                                a.DescripcionIva.NullSafeToString(),
                                a.Contacto.NullSafeToString(),
                                a.DireccionEntrega.NullSafeToString(),
                                a.LocalidadEntrega.NullSafeToString(),
                                a.ProvinciaEntrega.NullSafeToString(),
                                a.Vendedor.NullSafeToString(),
                                a.Cobrador.NullSafeToString(),
                                a.Estado.NullSafeToString(),
                                a.NombreComercial.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.Ingreso.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Modifico.NullSafeToString(),
                                a.FechaModifico == null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.CategoriaIIBB.NullSafeToString(),
                                a.CondicionIIBB.NullSafeToString(),
                                a.IBNumeroInscripcion.NullSafeToString(),
                                a.CuentaContable.NullSafeToString(),
                                a.CuentaContableExterior.NullSafeToString(),
                                a.CondicionVenta.NullSafeToString(),
                                a.Transportista.NullSafeToString(),
                                a.Region.NullSafeToString(),
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetContactos(string sidx, string sord, int? page, int? rows, int? IdCliente)
        {
            int IdCliente1 = IdCliente ?? 0;
            var Det = db.DetalleClientesContactos.Where(p => p.IdCliente == IdCliente).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        select new
                        {
                            a.IdDetalleCliente,
                            a.Contacto,
                            a.Puesto,
                            a.Telefono,
                            a.Email
                        }).OrderBy(x => x.IdDetalleCliente).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleCliente.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleCliente.ToString(), 
                            a.Contacto.NullSafeToString(),
                            a.Puesto.NullSafeToString(),
                            a.Telefono.NullSafeToString(),
                            a.Email.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetLugaresEntrega(string sidx, string sord, int? page, int? rows, int? IdCliente)
        {
            int IdCliente1 = IdCliente ?? 0;
            var DetEntidad = db.DetalleClientesLugaresEntregas.Where(p => p.IdCliente == IdCliente1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select new
                        {
                            a.IdDetalleClienteLugarEntrega,
                            a.IdLocalidadEntrega,
                            a.IdProvinciaEntrega,
                            a.DireccionEntrega,
                            Localidad = a.Localidad.Nombre,
                            Provincia = a.Provincia.Nombre
                        }).OrderBy(p => p.IdDetalleClienteLugarEntrega).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleClienteLugarEntrega.ToString(),
                            cell = new string[] { 
                                string.Empty,  // guarda con este espacio vacio
                                a.IdDetalleClienteLugarEntrega.ToString(), 
                                a.IdLocalidadEntrega.NullSafeToString(),
                                a.IdProvinciaEntrega.NullSafeToString(),
                                a.DireccionEntrega.NullSafeToString(), 
                                a.Localidad.ToString(),
                                a.Provincia.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetDirecciones(string sidx, string sord, int? page, int? rows, int? IdCliente)
        {
            int IdCliente1 = IdCliente ?? 0;
            var Det = db.DetalleClientesDirecciones.Where(p => p.IdCliente == IdCliente).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Localidades.Where(o => o.IdLocalidad == a.IdLocalidad).DefaultIfEmpty()
                        from c in db.Provincias.Where(o => o.IdProvincia == a.IdProvincia).DefaultIfEmpty()
                        from d in db.Paises.Where(o => o.IdPais == a.IdPais).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleClienteDireccion,
                            a.IdLocalidad,
                            a.IdProvincia,
                            a.IdPais,
                            a.Direccion,
                            Localidad = b != null ? b.Nombre : "",
                            Provincia = c != null ? c.Nombre : "",
                            Pais = d != null ? d.Descripcion : "",
                        }).OrderBy(x => x.IdDetalleClienteDireccion).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleClienteDireccion.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleClienteDireccion.ToString(), 
                            a.IdLocalidad.ToString(), 
                            a.IdProvincia.ToString(), 
                            a.IdPais.ToString(), 
                            a.Direccion.NullSafeToString(),
                            a.Localidad.NullSafeToString(),
                            a.Provincia.NullSafeToString(),
                            a.Pais.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetTelefonos(string sidx, string sord, int? page, int? rows, int? IdCliente)
        {
            int IdCliente1 = IdCliente ?? 0;
            var Det = db.DetalleClientesTelefonos.Where(p => p.IdCliente == IdCliente).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        select new
                        {
                            a.IdDetalleClienteTelefono,
                            a.Detalle,
                            a.Telefono
                        }).OrderBy(x => x.IdDetalleClienteTelefono).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleClienteTelefono.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleClienteTelefono.ToString(), 
                            a.Detalle.NullSafeToString(),
                            a.Telefono.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCodigosClienteAutocomplete(string term)
        {
            return Json((from item in db.Clientes.Include(c => c.IBCondicionCat1).Include(c => c.IBCondicionCat2).Include(c => c.IBCondicionCat3)
                         where item.RazonSocial.StartsWith(term) || item.Codigo.StartsWith(term)
                         orderby item.RazonSocial
                         select new
                         {
                             id = item.IdCliente,
                             value = item.RazonSocial,
                             codigo = item.Codigo,

                             /////////////////////////////
                             idCodigoIva = item.IdCodigoIva,

                             //////////////////////////////////////////
                             IdIBCondicionPorDefecto = item.IdIBCondicionPorDefecto,
                             IdIBCondicionPorDefecto2 = item.IdIBCondicionPorDefecto2,
                             IdIBCondicionPorDefecto3 = item.IdIBCondicionPorDefecto3,
                             AlicuotaPercepcion1 = (item.IBCondicionCat1).AlicuotaPercepcion,
                             AlicuotaPercepcion2 = (item.IBCondicionCat2 ).AlicuotaPercepcion,
                             AlicuotaPercepcion3 = (item.IBCondicionCat3 ).AlicuotaPercepcion,
                             ///////////////////////////////////////


                             Email = item.Email,
                             Direccion = item.Direccion,

                             Localidad = item.Localidad.Nombre,
                             Provincia = item.Provincia.Nombre,

                             Telefono = item.Telefono,
                             Fax = item.Fax,
                             Cuit = item.Cuit,
                             IdCondicionVenta = item.IdCondicionVenta,
                             IdListaPrecios = item.IdListaPrecios,

                             item.EsAgenteRetencionIVA,
                             item.BaseMinimaParaPercepcionIVA,
                             item.PorcentajePercepcionIVA
                             // letra = EntidadManager.LetraSegunTipoIVA((long)item.IdCodigoIva)
                         }).Take(10).ToList(), JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetPuntosVenta(long IdCodigoIva)
        {
            string letra = EntidadManager.LetraSegunTipoIVA((long)IdCodigoIva);

            return Json((from item in db.PuntosVentas
                         where (item.Letra == letra) // item.RazonSocial.StartsWith(term)
                            && item.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Factura
                         //orderby item.RazonSocial
                         select new
                         {
                             id = item.IdPuntoVenta,
                             value = item.PuntoVenta,
                             proxnumero = item.ProximoNumero
                             // letra = EntidadManager.LetraSegunTipoIVA((long)item.IdCodigoIva)
                         }).Take(10).ToList(), JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult PuntosVenta(int IdCodigoIva, int PuntoVenta)
        {
            string letra = EntidadManager.LetraSegunTipoIVA((long)IdCodigoIva);

            var q = (from item in db.PuntosVentas
                     where item.Letra == letra && item.PuntoVenta == PuntoVenta
                            && item.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Factura
                     //orderby item.RazonSocial
                     select new
                     {
                         id = item.IdPuntoVenta,
                         value = item.PuntoVenta,
                         proxnumero = item.ProximoNumero,
                         letra = item.Letra
                         // letra = EntidadsManager.LetraSegunTipoIVA((long)item.IdCodigoIva)
                     }).ToList();

            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public string DescripcionIIBB(int? IdIBCondicion)
        {
            // no tiene mas sentido que ponga esto en una tabla aparte? estas son las modalidades.

            //           Case When IsNull(Clientes.IBCondicion,0)=1 Then 'Exento'  
            //When IsNull(Clientes.IBCondicion,0)=2 Then 'Inscr.Multi'  
            //When IsNull(Clientes.IBCondicion,0)=3 Then 'Inscr.local'  
            //When IsNull(Clientes.IBCondicion,0)=4 Then 'No alcanzado'  
            //Else ''  

            return "Exento";
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

        //public virtual ActionResult _GrillaContactos(int id)
        //{
        //    // Get the model (setup) of the grid defined in the /Models folder.
        //    var gridModel = new Models.DetalleClientesJqGridModel();
        //    var DetalleClientesGrid = gridModel.DetalleClientesGrid;

        //    // customize the default DetalleClientes grid model with custom settings
        //    // NOTE: you need to call this method in the action that fetches the data as well,
        //    // so that the models match
        //    SetUpGrid(DetalleClientesGrid);

        //    // Pass the custmomized grid model to the View
        //    return PartialView(gridModel);
        //}

        //public virtual JsonResult SearchGridDataRequested()
        //{
        //    // Get both the grid Model and the data Model
        //    // The data model in our case is an autogenerated linq2sql database based on Northwind.
        //    var gridModel = new ProntoMVC.Models.DetalleClientesJqGridModel();
        //    // var northWindModel = new NorthwindDataContext();

        //    // customize the default DetalleClientes grid model with our custom settings
        //    SetUpGrid(gridModel.DetalleClientesGrid);


        //    // return the result of the DataBind method, passing the datasource as a parameter
        //    // jqGrid for ASP.NET MVC automatically takes care of paging, sorting, filtering/searching, etc
        //    int id = 1;  // ViewBag.IdCliente;
        //    return gridModel.DetalleClientesGrid.DataBind(db.DetalleClientes.Where(x => x.IdCliente == id));
        //}

        //void LlenarModeloGrillaConDetalle()
        //{

        //}

        //public virtual ActionResult EditRows(ProntoMVC.Data.Models.DetalleCliente editedOrder)
        //{
        //    // Get the grid and database (northwind) models
        //    var gridModel = new Models.DetalleClientesJqGridModel();
        //    // var northWindModel = new NorthwindDataContext();

        //    // If we are in "Edit" mode
        //    if (gridModel.DetalleClientesGrid.AjaxCallBackMode == AjaxCallBackMode.EditRow)
        //    {
        //        // Get the data from and find the Order corresponding to the edited row
        //        ProntoMVC.Data.Models.DetalleCliente order = (from o in db.DetalleClientes
        //                                       where o.IdDetalleCliente == editedOrder.IdDetalleCliente
        //                                       select o).First<ProntoMVC.Data.Models.DetalleCliente>();

        //        // update the Order information
        //        order.Contacto = editedOrder.Contacto;
        //        order.IdCliente = 1; // editedOrder.IdCliente;
        //        order.Email = editedOrder.Email;
        //        order.Puesto = editedOrder.Puesto;

        //        db.SaveChanges();
        //    }
        //    // add
        //    if (gridModel.DetalleClientesGrid.AjaxCallBackMode == AjaxCallBackMode.AddRow)
        //    {
        //        // since we are adding a new Order, create a new istance
        //        ProntoMVC.Data.Models.DetalleCliente order = new ProntoMVC.Data.Models.DetalleCliente();
        //        // set the new Order information
        //        order.IdDetalleCliente = (from o in db.DetalleClientes
        //                                  select o)
        //                        .Max<ProntoMVC.Data.Models.DetalleCliente>(o => o.IdDetalleCliente) + 1;

        //        order.Contacto = editedOrder.Contacto;
        //        order.IdCliente = 1;  // editedOrder.IdCliente;
        //        order.Email = editedOrder.Email;
        //        order.Puesto = editedOrder.Puesto;

        //        db.DetalleClientes.Add(order);
        //        db.SaveChanges();

        //        List<ProntoMVC.Data.Models.DetalleCliente> lista = ViewBag.GrillaBag;
        //        if (lista == null) lista = new List<ProntoMVC.Data.Models.DetalleCliente>();
        //        lista.Add(order);
        //        ViewBag.GrillaBag = lista;
        //    }
        //    //borrar
        //    if (gridModel.DetalleClientesGrid.AjaxCallBackMode == AjaxCallBackMode.DeleteRow)
        //    {
        //        ProntoMVC.Data.Models.DetalleCliente order = (from o in db.DetalleClientes
        //                                       where o.IdDetalleCliente == editedOrder.IdDetalleCliente
        //                                       select o)
        //                       .First<ProntoMVC.Data.Models.DetalleCliente>();

        //        // delete the record                
        //        db.DetalleClientes.Remove(order);
        //        db.SaveChanges();
        //    }

        //    return RedirectToAction("_GrillaContactos", new { id = 1 }); // ViewBag.IdCliente });
        //}

        //private void SetUpGrid(JQGrid DetalleClientesGrid)
        //{
        //    // al principio se la llama dos veces seguidas, desde _GrillaContactos() y SearchGridDataRequested()
        //    // NOTE: you need to call this method in the action that fetches the data as well,
        //    // so that the models match

        //    // Customize/change some of the default settings for this model
        //    // ID is a mandatory field. Must by unique if you have several grids on one page.
        //    DetalleClientesGrid.ID = "DetalleClientesGrid";
        //    // Setting the DataUrl to an action (method) in the controller is required.
        //    // This action will return the data needed by the grid
        //    DetalleClientesGrid.DataUrl = Url.Action("SearchGridDataRequested");
        //    DetalleClientesGrid.EditUrl = Url.Action("EditRows");
        //    // show the search toolbar
        //    DetalleClientesGrid.ToolBarSettings.ShowSearchToolBar = true;
        //    DetalleClientesGrid.Columns.Find(c => c.DataField == "IdDetalleCliente").Searchable = false;
        //    // DetalleClientesGrid.Columns.Find(c => c.DataField == "FechaVigencia").Searchable = false;

        //    SetUpCustomerIDSearchDropDown(DetalleClientesGrid);
        //    SetUpFreightSearchDropDown(DetalleClientesGrid);
        //    SetShipNameSearchDropDown(DetalleClientesGrid);

        //    DetalleClientesGrid.ToolBarSettings.ShowEditButton = true;
        //    DetalleClientesGrid.ToolBarSettings.ShowAddButton = true;
        //    DetalleClientesGrid.ToolBarSettings.ShowDeleteButton = true;
        //    DetalleClientesGrid.EditDialogSettings.CloseAfterEditing = true;
        //    DetalleClientesGrid.AddDialogSettings.CloseAfterAdding = true;

        //    // setup the dropdown values for the CustomerID editing dropdown
        //    SetUpCustomerIDEditDropDown(DetalleClientesGrid);
        //}

        //private void SetUpCustomerIDSearchDropDown(JQGrid DetalleClientesGrid)
        //{
        //    // setup the grid search criteria for the columns
        //    JQGridColumn customersColumn = DetalleClientesGrid.Columns.Find(c => c.DataField == "IdDetalleCliente");
        //    customersColumn.Searchable = true;

        //    // DataType must be set in order to use searching
        //    customersColumn.DataType = typeof(string);
        //    customersColumn.SearchToolBarOperation = SearchOperation.IsEqualTo;
        //    customersColumn.SearchType = SearchType.DropDown;

        //    // Populate the search dropdown only on initial request, in order to optimize performance
        //    if (DetalleClientesGrid.AjaxCallBackMode == AjaxCallBackMode.RequestData)
        //    {
        //        // var northWindModel = new NorthwindDataContext();
        //        // http://stackoverflow.com/questions/10110266/why-linq-to-entities-does-not-recognize-the-method-system-string-tostring

        //        var searchList = (from customers in db.DetalleClientes
        //                          select customers.IdDetalleCliente)
        //                          .AsEnumerable()
        //                          .Select(x => new SelectListItem { Text = x.ToString(), Value = x.ToString() });





        //        customersColumn.SearchList = searchList.ToList<SelectListItem>();
        //        customersColumn.SearchList.Insert(0, new SelectListItem { Text = "All", Value = "" });
        //    }
        //}

        //private void SetUpFreightSearchDropDown(JQGrid DetalleClientesGrid)
        //{
        //    // setup the grid search criteria for the columns
        //    JQGridColumn freightColumn = DetalleClientesGrid.Columns.Find(c => c.DataField == "Contacto");
        //    freightColumn.Searchable = true;

        //    // DataType must be set in order to use searching
        //    freightColumn.DataType = typeof(decimal);
        //    freightColumn.SearchToolBarOperation = SearchOperation.IsGreaterOrEqualTo;
        //    freightColumn.SearchType = SearchType.DropDown;

        //    // Populate the search dropdown only on initial request, in order to optimize performance
        //    if (DetalleClientesGrid.AjaxCallBackMode == AjaxCallBackMode.RequestData)
        //    {
        //        List<SelectListItem> searchList = new List<SelectListItem>();
        //        searchList.Add(new SelectListItem { Text = "> 10", Value = "10" });
        //        searchList.Add(new SelectListItem { Text = "> 30", Value = "30" });
        //        searchList.Add(new SelectListItem { Text = "> 50", Value = "50" });
        //        searchList.Add(new SelectListItem { Text = "> 100", Value = "100" });

        //        freightColumn.SearchList = searchList.ToList<SelectListItem>();
        //        freightColumn.SearchList.Insert(0, new SelectListItem { Text = "All", Value = "" });
        //    }
        //}

        //private void SetShipNameSearchDropDown(JQGrid DetalleClientesGrid)
        //{
        //    JQGridColumn freightColumn = DetalleClientesGrid.Columns.Find(c => c.DataField == "Contacto");
        //    freightColumn.Searchable = true;
        //    freightColumn.DataType = typeof(string);
        //    freightColumn.SearchToolBarOperation = SearchOperation.Contains;
        //    freightColumn.SearchType = SearchType.TextBox;
        //}

        //private void SetUpCustomerIDEditDropDown(JQGrid DetalleClientesGrid)
        //{
        //    // setup the grid search criteria for the columns
        //    JQGridColumn customersColumn = DetalleClientesGrid.Columns.Find(c => c.DataField == "Contacto");
        //    customersColumn.Editable = true;
        //    customersColumn.EditType = EditType.DropDown;

        //    // Populate the search dropdown only on initial request, in order to optimize performance
        //    if (DetalleClientesGrid.AjaxCallBackMode == AjaxCallBackMode.RequestData)
        //    {

        //        // var northWindModel = new NorthwindDataContext();

        //        var editList = (from customers in db.DetalleClientes
        //                        select customers.IdDetalleCliente)
        //                       .AsEnumerable()
        //                       .Select(x => new SelectListItem { Text = x.ToString(), Value = x.ToString() });


        //        customersColumn.EditList = editList.ToList<SelectListItem>();
        //    }
        //}

        //[AcceptVerbs(HttpVerbs.Post)]
        //public virtual ActionResult OrderDetailsSubgrid(int id)
        //{
        //    JqGridResponse response = new JqGridResponse(true);
        //    response.Records.AddRange(from orderDetails in db.DetalleClientes.Where(x => x.IdCliente == id)
        //                              select new JqGridRecord<OrderDetailViewModel>(null, new OrderDetailViewModel(orderDetails)));

        //    return new JqGridJsonResult() { Data = response };
        //}

        //[HttpPost]
        //public virtual JsonResult UpdateAwesomeGridData(string dataToSend) // (IEnumerable<GridBoundViewModel> gridData)
        //{
        //    JavaScriptSerializer serializer = new JavaScriptSerializer();
        //    var myListOfData = serializer.Deserialize<List<List<string>>>(dataToSend);

        //    if (ModelState.IsValid)
        //    {
        //        string tipomovimiento = "";
        //    }

        //    return Json(new { Success = 0, ex = "" });
        //}

        //public virtual JsonResult GetLocalidadesAutocomplete(string term)
        //{
        //    var ci = new System.Globalization.CultureInfo("en-US");

        //    var filtereditems = (from item in db.Localidades
        //                         where ((item.Nombre.StartsWith(term)
        //                                 )
        //                             )
        //                         orderby item.Nombre
        //                         select new
        //                         {
        //                             id = item.IdLocalidad,
        //                             value = item.Nombre,  // item.CodigoPostal,
        //                             title = item.Nombre + " " + item.CodigoPostal, //  SqlFunctions.StringConvert((double)(item.CodigoPostal ?? 0))
        //                             idprovincia = item.IdProvincia
        //                         }).Take(20).ToList();

        //    return Json(filtereditems, JsonRequestBehavior.AllowGet);
        //}

        //public virtual ActionResult Provincias()
        //{
        //    Dictionary<int, string> unidades = new Dictionary<int, string>();
        //    foreach (Provincia u in db.Provincias.ToList())
        //        unidades.Add(u.IdProvincia, u.Nombre);
        //    return PartialView("Select", unidades);
        //}

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);

        }

    }
}

