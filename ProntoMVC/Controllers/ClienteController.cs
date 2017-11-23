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
using Newtonsoft.Json;

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

        public virtual ActionResult IndexAConfirmar()
        {
            return View();
        }

        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.Clientes)) throw new Exception("No tenés permisos");
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
            Int32 mMaxLength = 0;
            string mProntoIni = "";
            string mExigirCUIT = "";
            Boolean result;

            if ((o.CodigoCliente ?? 0) == 0) { sErrorMsg += "\n" + "Falta el codigo de cliente"; }

            if (o.Codigo.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta el codigo de cliente";
            }
            else
            {
                mMaxLength = GetMaxLength<Cliente>(x => x.Codigo) ?? 0;
                if (o.Codigo.Length > mMaxLength) { sErrorMsg += "\n" + "El codigo no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.RazonSocial.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta la razon social";
            }
            else
            {
                mMaxLength = GetMaxLength<Cliente>(x => x.RazonSocial) ?? 0;
                if (o.RazonSocial.Length > mMaxLength) { sErrorMsg += "\n" + "La razon social no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.Direccion.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta la dirección";
            }
            else
            {
                mMaxLength = GetMaxLength<Cliente>(x => x.Direccion) ?? 0;
                if (o.Direccion.Length > mMaxLength) { sErrorMsg += "\n" + "La Direccion no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if ((o.IdCodigoIva ?? 0) == 0) { sErrorMsg += "\n" + "Falta el codigo de IVA"; }

            if (o.IdProvincia == null) { sErrorMsg += "\n" + "Falta la provincia"; }

            if (o.IdPais == null) { sErrorMsg += "\n" + "Falta el país"; }

            if (o.IdCondicionVenta == null) { sErrorMsg += "\n" + "Falta la condicion venta"; }

            if (o.IGCondicion == null) { sErrorMsg += "\n" + "Falta la condicion ganacias"; }

            if (o.IdListaPrecios == null) { sErrorMsg += "\n" + "Falta la lista de precios"; }

            if (o.IdCuentaMonedaExt == null) { sErrorMsg += "\n" + "Falta la cuenta contable en moneda extranjera"; }

            if (o.IdCuenta == null) { sErrorMsg += "\n" + "Falta la cuenta contable"; }

            if (o.Vendedor1 == null) { sErrorMsg += "\n" + "Falta el vendedor"; }

            if (o.IdEstado == null) { sErrorMsg += "\n" + "Falta el estado"; }

            string s = "asdasd";
            s = o.Cuit.NullSafeToString().Replace("-", "").PadLeft(11);
            o.Cuit = s.Substring(0, 2) + "-" + s.Substring(2, 8) + "-" + s.Substring(10, 1);
            if (!ProntoMVC.Data.FuncionesGenericasCSharp.CUITValido(o.Cuit.NullSafeToString())) { sErrorMsg += "\n" + "El CUIT es incorrecto"; }

            if (sErrorMsg != "") return false;
            else return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(Cliente Cliente)
        {
            if (!PuedeEditar(enumNodos.Clientes)) throw new Exception("No tenés permisos");

            try
            {
                if (Cliente.Cuit != null)
                {
                    var s = Cliente.Cuit.Replace("-", "");
                    Cliente.Cuit = s.Substring(0, 2) + "-" + s.Substring(2, 8) + "-" + s.Substring(10, 1);
                }

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




        public virtual JsonResult Clientes_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.Cliente>
                                ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            // esto filtro se debería aplicar antes que el filtrogenerico (queda mal paginado si no)
            var Entidad = pagedQuery.Where(o => (o.Confirmado ?? "") != "NO").AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdCliente = a.IdCliente }).ToList();

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
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
                            Subcodigo = a.Codigo != null ? a.Codigo.Substring(1, 2) : "",
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
                            LocalidadEntrega = a.LocalidadEntrega.Nombre, // b != null ? b.Nombre : "",
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
                        }).OrderBy(sidx + " " + sord).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
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


        public virtual ActionResult Clientes_obsoleto(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
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
                            Subcodigo = a.Codigo != null ? a.Codigo.Substring(1, 2) : "",
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

        public virtual ActionResult ClientesAConfirmar(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
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

            var Entidad = db.Clientes.Where(o => (o.Confirmado ?? "") == "NO").AsQueryable();

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
                            Subcodigo = a.Codigo != null ? a.Codigo.Substring(1, 2) : "",
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
                        }).OrderBy(x => x.IdDetalleCliente)
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
                        }).OrderBy(p => p.IdDetalleClienteLugarEntrega)
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
                        }).OrderBy(x => x.IdDetalleClienteDireccion)
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
                        }).OrderBy(x => x.IdDetalleClienteTelefono)
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
            var q = (from item in db.Clientes.Include(c => c.IBCondicionCat1).Include(c => c.IBCondicionCat2).Include(c => c.IBCondicionCat3)
                     where item.RazonSocial.ToLower().Contains(term.ToLower())
                            || item.Codigo.ToLower().Contains(term.ToLower())  
                     //where item.RazonSocial.StartsWith(term) || item.Codigo.StartsWith(term)
                     orderby item.RazonSocial
                     select new
                     {
                         id = item.IdCliente,
                         value = item.RazonSocial,
                         codigo = item.Codigo,
                         idCodigoIva = item.IdCodigoIva,
                         IdIBCondicionPorDefecto = item.IdIBCondicionPorDefecto,
                         IdIBCondicionPorDefecto2 = item.IdIBCondicionPorDefecto2,
                         IdIBCondicionPorDefecto3 = item.IdIBCondicionPorDefecto3,
                         AlicuotaPercepcion1 = (item.IBCondicionCat1).AlicuotaPercepcion,
                         AlicuotaPercepcion2 = (item.IBCondicionCat2).AlicuotaPercepcion,
                         AlicuotaPercepcion3 = (item.IBCondicionCat3).AlicuotaPercepcion,
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
                     }).Take(10).ToList();

            if (q.Count == 0 && term != "No se encontraron resultados")
            {
            }

            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetPuntosVenta(long IdCodigoIva)
        {
            string letra = Pronto.ERP.Bll.EntidadManager.LetraSegunTipoIVA((long)IdCodigoIva);

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
            string letra = Pronto.ERP.Bll.EntidadManager.LetraSegunTipoIVA((long)IdCodigoIva);

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

        public virtual JsonResult GetClientesAutocomplete(string term)
        {
            var q = (from item in db.Clientes
                     where item.RazonSocial.ToLower().Contains(term.ToLower())   //.StartsWith(term.ToLower())
                     orderby item.RazonSocial
                     select new
                     {
                         id = item.IdCliente,
                         value = item.RazonSocial,
                         codigo = item.Codigo,
                         IdCodigoIva = item.IdCodigoIva.ToString(),
                         IdCondicionVenta = item.IdCondicionVenta.ToString()
                     }).Take(100).ToList();

            if (q.Count == 0 && term != "No se encontraron resultados") { q.Add(new { id = 0, value = "No se encontraron resultados", codigo = "", IdCodigoIva = "", IdCondicionVenta = "" }); }

            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetClientePorId(int Id)
        {
            var filtereditems = (from a in db.Clientes
                                 where (a.IdCliente == Id)
                                 select new
                                 {
                                     id = a.IdCliente,
                                     value = a.RazonSocial.Trim(),
                                     a.Codigo,
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
                                     a.PorcentajePercepcionIVA,
                                     a.BaseMinimaParaPercepcionIVA,
                                     a.EsAgenteRetencionIVA,
                                     a.IdIBCondicionPorDefecto,
                                     a.IdIBCondicionPorDefecto2,
                                     a.IdIBCondicionPorDefecto3,
                                     a.IdCodigoIva
                                 }).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
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

        //[HttpPost]
        public virtual JsonResult CalcularPercepciones(Int32 IdCliente, decimal TotalGravado, Int32 IdMoneda, Int32 IdIBCondicion1, Int32 IdIBCondicion2, Int32 IdIBCondicion3, DateTime Fecha)
        {
            Int32 IBCondicion = 1;
            Int32 mIdProvinciaRealIIBB = 0;

            decimal mBaseMinimaParaPercepcionIVA = 0;
            decimal mPorcentajePercepcionIVA = 0;
            decimal mPercepcionIVA = 0;
            decimal mAlicuota = 0;
            decimal mAlicuota1 = 0;
            decimal mAlicuota2 = 0;
            decimal mAlicuota3 = 0;
            decimal mAlicuotaDirecta = 0;
            decimal mAlicuotaDirectaCapital = 0;
            decimal mImporteTopeMinimoPercepcion = 0;
            decimal mPercepcionIIBB1 = 0;
            decimal mPercepcionIIBB2 = 0;
            decimal mPercepcionIIBB3 = 0;

            string mEsAgenteRetencionIVA = "NO";
            string mGeneraImpuestos = "SI";
            string mCodigoProvincia = "";
            string mMultilateral = "";

            DateTime mFechaVigencia = DateTime.Now;
            DateTime mFechaInicioVigenciaIBDirecto = DateTime.Now;
            DateTime mFechaFinVigenciaIBDirecto = DateTime.Now;
            DateTime mFechaInicioVigenciaIBDirectoCapital = DateTime.Now;
            DateTime mFechaFinVigenciaIBDirectoCapital = DateTime.Now;

            var Cliente = db.Clientes.Where(p => p.IdCliente == IdCliente).FirstOrDefault();
            if (Cliente != null)
            {
                mBaseMinimaParaPercepcionIVA = Cliente.BaseMinimaParaPercepcionIVA ?? 0;
                mPorcentajePercepcionIVA = Cliente.PorcentajePercepcionIVA ?? 0;
                mEsAgenteRetencionIVA = Cliente.EsAgenteRetencionIVA ?? "";

                IBCondicion = Cliente.IBCondicion ?? 1;
                mAlicuotaDirecta = Cliente.PorcentajeIBDirecto ?? 0;
                mFechaInicioVigenciaIBDirecto = Cliente.FechaInicioVigenciaIBDirecto ?? DateTime.MinValue;
                mFechaFinVigenciaIBDirecto = Cliente.FechaFinVigenciaIBDirecto ?? DateTime.MinValue;
                mAlicuotaDirectaCapital = Cliente.PorcentajeIBDirectoCapital ?? 0;
                mFechaInicioVigenciaIBDirectoCapital = Cliente.FechaInicioVigenciaIBDirectoCapital ?? DateTime.MinValue;
                mFechaFinVigenciaIBDirectoCapital = Cliente.FechaFinVigenciaIBDirectoCapital ?? DateTime.MinValue;
            };

            var Monedas = db.Monedas.Where(p => p.IdMoneda == IdMoneda).FirstOrDefault();
            if (Monedas != null) { mGeneraImpuestos = Monedas.GeneraImpuestos ?? "NO"; }

            if (mGeneraImpuestos == "SI")
            {
                if (mEsAgenteRetencionIVA == "NO" && TotalGravado >= mBaseMinimaParaPercepcionIVA) { mPercepcionIVA = TotalGravado * mPorcentajePercepcionIVA / 100; }

                var IBCondiciones = db.IBCondiciones.Where(p => p.IdIBCondicion == IdIBCondicion1).FirstOrDefault();
                if (IBCondiciones != null)
                {
                    mImporteTopeMinimoPercepcion = IBCondiciones.ImporteTopeMinimoPercepcion ?? 0;
                    mIdProvinciaRealIIBB = IBCondiciones.IdProvinciaReal ?? 0;
                    mFechaVigencia = IBCondiciones.FechaVigencia ?? DateTime.MinValue;

                    var Provincia = db.Provincias.Where(p => p.IdProvincia == mIdProvinciaRealIIBB).FirstOrDefault();
                    if (Provincia != null) { mCodigoProvincia = Provincia.InformacionAuxiliar ?? ""; }

                    mAlicuota = 0;
                    if (mCodigoProvincia == "902" && Fecha >= mFechaInicioVigenciaIBDirecto && Fecha <= mFechaFinVigenciaIBDirecto)
                    {
                        mAlicuota = mAlicuotaDirecta;
                    }
                    else
                    {
                        if (mCodigoProvincia == "901" && Fecha >= mFechaInicioVigenciaIBDirectoCapital && Fecha <= mFechaFinVigenciaIBDirectoCapital)
                        {
                            mAlicuota = mAlicuotaDirectaCapital;
                        }
                        else
                        {
                            if (TotalGravado > mImporteTopeMinimoPercepcion && Fecha > mFechaVigencia)
                            {
                                if (IdIBCondicion1 == 2)
                                {
                                    mAlicuota = IBCondiciones.AlicuotaPercepcionConvenio ?? 0;
                                    mMultilateral = "SI";
                                }
                                else
                                {
                                    mAlicuota = IBCondiciones.AlicuotaPercepcion ?? 0;
                                }
                            }
                        }
                    }
                    mPercepcionIIBB1 = Math.Round(TotalGravado * mAlicuota / 100, 2);
                    mAlicuota1 = mAlicuota;
                }

                IBCondiciones = db.IBCondiciones.Where(p => p.IdIBCondicion == IdIBCondicion2).FirstOrDefault();
                if (IBCondiciones != null)
                {
                    mImporteTopeMinimoPercepcion = IBCondiciones.ImporteTopeMinimoPercepcion ?? 0;
                    mIdProvinciaRealIIBB = IBCondiciones.IdProvinciaReal ?? 0;
                    mFechaVigencia = IBCondiciones.FechaVigencia ?? DateTime.MinValue;

                    var Provincia = db.Provincias.Where(p => p.IdProvincia == mIdProvinciaRealIIBB).FirstOrDefault();
                    if (Provincia != null) { mCodigoProvincia = Provincia.InformacionAuxiliar ?? ""; }

                    mAlicuota = 0;
                    if (mCodigoProvincia == "902" && Fecha >= mFechaInicioVigenciaIBDirecto && Fecha <= mFechaFinVigenciaIBDirecto)
                    {
                        mAlicuota = mAlicuotaDirecta;
                    }
                    else
                    {
                        if (mCodigoProvincia == "901" && Fecha >= mFechaInicioVigenciaIBDirectoCapital && Fecha <= mFechaFinVigenciaIBDirectoCapital)
                        {
                            mAlicuota = mAlicuotaDirectaCapital;
                        }
                        else
                        {
                            if (TotalGravado > mImporteTopeMinimoPercepcion && Fecha > mFechaVigencia)
                            {
                                if (IdIBCondicion1 == 2)
                                {
                                    mAlicuota = IBCondiciones.AlicuotaPercepcionConvenio ?? 0;
                                    mMultilateral = "SI";
                                }
                                else
                                {
                                    mAlicuota = IBCondiciones.AlicuotaPercepcion ?? 0;
                                }
                            }
                        }
                    }
                    mPercepcionIIBB2 = Math.Round(TotalGravado * mAlicuota / 100, 2);
                    mAlicuota2 = mAlicuota;
                }

                IBCondiciones = db.IBCondiciones.Where(p => p.IdIBCondicion == IdIBCondicion3).FirstOrDefault();
                if (IBCondiciones != null)
                {
                    mImporteTopeMinimoPercepcion = IBCondiciones.ImporteTopeMinimoPercepcion ?? 0;
                    mIdProvinciaRealIIBB = IBCondiciones.IdProvinciaReal ?? 0;
                    mFechaVigencia = IBCondiciones.FechaVigencia ?? DateTime.MinValue;

                    var Provincia = db.Provincias.Where(p => p.IdProvincia == mIdProvinciaRealIIBB).FirstOrDefault();
                    if (Provincia != null) { mCodigoProvincia = Provincia.InformacionAuxiliar ?? ""; }

                    mAlicuota = 0;
                    if (mCodigoProvincia == "902" && Fecha >= mFechaInicioVigenciaIBDirecto && Fecha <= mFechaFinVigenciaIBDirecto)
                    {
                        mAlicuota = mAlicuotaDirecta;
                    }
                    else
                    {
                        if (mCodigoProvincia == "901" && Fecha >= mFechaInicioVigenciaIBDirectoCapital && Fecha <= mFechaFinVigenciaIBDirectoCapital)
                        {
                            mAlicuota = mAlicuotaDirectaCapital;
                        }
                        else
                        {
                            if (TotalGravado > mImporteTopeMinimoPercepcion && Fecha > mFechaVigencia)
                            {
                                if (IdIBCondicion1 == 2)
                                {
                                    mAlicuota = IBCondiciones.AlicuotaPercepcionConvenio ?? 0;
                                    mMultilateral = "SI";
                                }
                                else
                                {
                                    mAlicuota = IBCondiciones.AlicuotaPercepcion ?? 0;
                                }
                            }
                        }
                    }
                    mPercepcionIIBB3 = Math.Round(TotalGravado * mAlicuota / 100, 2);
                    mAlicuota3 = mAlicuota;
                }
            }

            DatosJson data = new DatosJson();
            data.campo1 = mPercepcionIIBB1.ToString();
            data.campo2 = mPercepcionIIBB2.ToString();
            data.campo3 = mPercepcionIIBB3.ToString();
            data.campo4 = mAlicuota1.ToString();
            data.campo5 = mAlicuota2.ToString();
            data.campo6 = mAlicuota3.ToString();
            data.campo7 = mPercepcionIVA.ToString();

            return Json(JsonConvert.SerializeObject(data), JsonRequestBehavior.AllowGet);
        }

        class DatosJson
        {
            public string campo1 { get; set; }
            public string campo2 { get; set; }
            public string campo3 { get; set; }
            public string campo4 { get; set; }
            public string campo5 { get; set; }
            public string campo6 { get; set; }
            public string campo7 { get; set; }
            public string campo8 { get; set; }
            public string campo9 { get; set; }
            public string campo10 { get; set; }
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);

        }


    }
}

