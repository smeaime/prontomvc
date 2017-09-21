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
using System.Web.Security;
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
//using Trirand.Web.Mvc;

namespace ProntoMVC.Controllers
{
    public partial class EmpleadoController : ProntoBaseController
    {

        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
           
            if (!PuedeLeer(enumNodos.Empleados)) throw new Exception("No tenés permisos");
            if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") 
                ) throw new Exception("No tenés permisos");



            var Empleados = db.Empleados
                .OrderBy(s => s.Nombre)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Sectores.Count() / pageSize);

            return View(Empleados);
        }

        // GET: /Empleado/Create
        public virtual ActionResult Create()
        {
            ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion");
            return View();
        }

        // POST: /Empleado/Create
        [HttpPost]
        public virtual ActionResult Create(Empleado empleado)
        {
            if (ModelState.IsValid)
            {
                db.Empleados.Add(empleado);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", empleado.IdSector);
            return View(empleado);
        }

        // GET: /Empleado/Edit
        public virtual ActionResult Edit(int id)
        {
            if (id == -1)
            {
                Empleado empleado = new Empleado();
                CargarViewBag(empleado);
                return View(empleado);
            }
            else
            {
                Empleado empleado = db.Empleados.Find(id);
                CargarViewBag(empleado);
                return View(empleado);
            }
        }

        // POST: /Empleado/Edit
        [HttpPost]
        public virtual ActionResult Edit(Empleado empleado)
        {
            if (!PuedeLeer(enumNodos.Empleados)) throw new Exception("No tenés permisos");
            if (ModelState.IsValid)
            {
                db.Entry(empleado).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", empleado.IdSector);
            ViewBag.IdCargo = new SelectList(db.Cargos, "IdCargo", "Descripcion", empleado.IdCargo);
            ViewBag.IdCuentaFondoFijo = new SelectList(GetCuentasFF(), "IdCuenta", "Descripcion", empleado.IdCuentaFondoFijo);
            ViewBag.IdObraAsignada = new SelectList(GetObras(), "IdObra", "Descripcion", empleado.IdObraAsignada);
            return View(empleado);
        }

        // GET: /Empleado/Delete
        public virtual ActionResult Delete(int id)
        {
            Empleado empleado = db.Empleados.Find(id);
            return View(empleado);
        }

        // POST: /Empleado/Delete
        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Empleado empleado = db.Empleados.Find(id);
            try
            {
                db.Empleados.Remove(empleado);
                //db.DetalleEmpleadosIngresosEgresos.Remove
                db.SaveChanges();

            }
            catch (Exception)
            {
                // salta fk en DetalleEmpleado. por que no aparece esa tabla en el modelo???? -Está renombrada como "DetalleEmpleadosIngresoEgreso"
                throw;
            }
            return RedirectToAction("Index");
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(Empleado Empleado)
        {
            if (!PuedeEditar(enumNodos.Empleados)) throw new Exception("No tenés permisos");

            try
            {
                string erar = "";
                if (!Validar(Empleado, ref erar))
                {
                    try
                    {
                        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                        Response.TrySkipIisCustomErrors = true;
                    }
                    catch (Exception)
                    {
                        //    throw;
                    }

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    string[] words = erar.Split('\n');
                    res.Errors = words.ToList();
                    res.Message = "Hay datos invalidos";

                    return Json(res);
                }

                if (ModelState.IsValid)
                {
                    if (Empleado.IdEmpleado > 0)
                    {
                        var EmpleadoOriginal = db.Empleados.Where(p => p.IdEmpleado == Empleado.IdEmpleado).Include(p => p.DetalleEmpleadosIngresosEgresos).SingleOrDefault();
                        var EmpleadoEntry = db.Entry(EmpleadoOriginal);
                        EmpleadoEntry.CurrentValues.SetValues(Empleado);

                        foreach (var d in Empleado.DetalleEmpleadosIngresosEgresos)
                        {
                            var DetalleEmpleadoOriginal = EmpleadoOriginal.DetalleEmpleadosIngresosEgresos.Where(c => c.IdDetalleEmpleado == d.IdDetalleEmpleado && d.IdDetalleEmpleado > 0).SingleOrDefault();
                            // Is original child item with same ID in DB?
                            if (DetalleEmpleadoOriginal != null)
                            {
                                // Yes -> Update scalar properties of child item
                                var DetalleEmpleadoEntry = db.Entry(DetalleEmpleadoOriginal);
                                DetalleEmpleadoEntry.CurrentValues.SetValues(d);
                            }
                            else
                            {
                                // No -> It's a new child item -> Insert
                                EmpleadoOriginal.DetalleEmpleadosIngresosEgresos.Add(d);
                            }
                        }
                        // Now you must delete all entities present in parent.ChildItems but missing in modifiedParent.ChildItems
                        // ToList should make copy of the collection because we can't modify collection iterated by foreach
                        foreach (var DetalleEmpleadoOriginal in EmpleadoOriginal.DetalleEmpleadosIngresosEgresos.Where(c => c.IdDetalleEmpleado != 0).ToList())
                        {
                            // Are there child items in the DB which are NOT in the new child item collection anymore?
                            if (!Empleado.DetalleEmpleadosIngresosEgresos.Any(c => c.IdDetalleEmpleado == DetalleEmpleadoOriginal.IdDetalleEmpleado))
                                // Yes -> It's a deleted child item -> Delete
                                // qué mierda pasa que no lo borra?
                                //Apparently there is a semantic difference between Remove and Delete where Remove will just orphan the row by 
                                //    removing the foreign key, and Delete will actually take the record out of the table.
                                // http://stackoverflow.com/questions/2554696/ef-4-removing-child-object-from-collection-does-not-delete-it-why
                                // http://stackoverflow.com/questions/13070365/calling-remove-is-executing-an-update-statement-instead-of-a-delete-and-resul
                                // http://stackoverflow.com/questions/17723626/entity-framework-remove-vs-deleteobject
                                // If the relationship is required (the FK doesn't allow NULL values) and the relationship is not
                                // identifying (which means that the foreign key is not part of the child's (composite) primary key) you have to
                                // either add the child to another parent or you have to explicitly delete the child (with DeleteObject then).
                                // If you don't do any of these a referential constraint is violated and EF will throw an exception when
                                // you call SaveChanges - the infamous "The relationship could not be changed because one or more of the
                                // foreign-key properties is non-nullable" exception or similar.

                                // http://stackoverflow.com/questions/9267991/deleteobject-method-is-missing-in-entity-framework-4-1
                                // pero, oia:
                                // The DbContext API defines DbSets not ObjectSets. DbSet has a Remove method not DeleteObject method. 
                                // You need to first decide which API you are going to use. If it the ObjectContext or DbContext.

                                // http://stackoverflow.com/questions/24755739/entity-framework-dbcontext-removeobj-vs-entryobj-state-entitystate-delet
                                // http://stackoverflow.com/questions/11584399/difference-between-dbset-remove-and-dbcontext-entryentity-state-entitystate
                            {
                                EmpleadoOriginal.DetalleEmpleadosIngresosEgresos.Remove(DetalleEmpleadoOriginal);
                                db.Entry(DetalleEmpleadoOriginal).State = System.Data.Entity.EntityState.Deleted;
                                // EmpleadoOriginal.DetalleEmpleadosIngresosEgresos.Delete
                            }
                        }

                        foreach (var d in Empleado.DetalleEmpleadosSectores)
                        {
                            var DetalleEmpleadoOriginal = EmpleadoOriginal.DetalleEmpleadosSectores.Where(c => c.IdDetalleEmpleadoSector == d.IdDetalleEmpleadoSector && d.IdDetalleEmpleadoSector > 0).SingleOrDefault();
                            if (DetalleEmpleadoOriginal != null)
                            {
                                var DetalleEmpleadoEntry = db.Entry(DetalleEmpleadoOriginal);
                                DetalleEmpleadoEntry.CurrentValues.SetValues(d);
                            }
                            else
                            {
                                EmpleadoOriginal.DetalleEmpleadosSectores.Add(d);
                            }
                        }
                        foreach (var DetalleEmpleadoOriginal in EmpleadoOriginal.DetalleEmpleadosSectores.Where(c => c.IdDetalleEmpleadoSector != 0).ToList())
                        {
                            if (!Empleado.DetalleEmpleadosSectores.Any(c => c.IdDetalleEmpleadoSector == DetalleEmpleadoOriginal.IdDetalleEmpleadoSector))
                            {
                                EmpleadoOriginal.DetalleEmpleadosSectores.Remove(DetalleEmpleadoOriginal);
                                db.Entry(DetalleEmpleadoOriginal).State = System.Data.Entity.EntityState.Deleted;
                            }
                        }

                        foreach (var d in Empleado.DetalleEmpleadosJornadas)
                        {
                            var DetalleEmpleadoOriginal = EmpleadoOriginal.DetalleEmpleadosJornadas.Where(c => c.IdDetalleEmpleadoJornada == d.IdDetalleEmpleadoJornada && d.IdDetalleEmpleadoJornada > 0).SingleOrDefault();
                            if (DetalleEmpleadoOriginal != null)
                            {
                                var DetalleEmpleadoEntry = db.Entry(DetalleEmpleadoOriginal);
                                DetalleEmpleadoEntry.CurrentValues.SetValues(d);
                            }
                            else
                            {
                                EmpleadoOriginal.DetalleEmpleadosJornadas.Add(d);
                            }
                        }
                        foreach (var DetalleEmpleadoOriginal in EmpleadoOriginal.DetalleEmpleadosJornadas.Where(c => c.IdDetalleEmpleadoJornada != 0).ToList())
                        {
                            if (!Empleado.DetalleEmpleadosJornadas.Any(c => c.IdDetalleEmpleadoJornada == DetalleEmpleadoOriginal.IdDetalleEmpleadoJornada))
                            {
                                EmpleadoOriginal.DetalleEmpleadosJornadas.Remove(DetalleEmpleadoOriginal);
                                db.Entry(DetalleEmpleadoOriginal).State = System.Data.Entity.EntityState.Deleted;
                            }
                        }

                        foreach (var d in Empleado.DetalleEmpleadosCuentasBancarias)
                        {
                            var DetalleEmpleadoOriginal = EmpleadoOriginal.DetalleEmpleadosCuentasBancarias.Where(c => c.IdDetalleEmpleadoCuentaBancaria == d.IdDetalleEmpleadoCuentaBancaria && d.IdDetalleEmpleadoCuentaBancaria > 0).SingleOrDefault();
                            if (DetalleEmpleadoOriginal != null)
                            {
                                var DetalleEmpleadoEntry = db.Entry(DetalleEmpleadoOriginal);
                                DetalleEmpleadoEntry.CurrentValues.SetValues(d);
                            }
                            else
                            {
                                EmpleadoOriginal.DetalleEmpleadosCuentasBancarias.Add(d);
                            }
                        }
                        foreach (var DetalleEmpleadoOriginal in EmpleadoOriginal.DetalleEmpleadosCuentasBancarias.Where(c => c.IdDetalleEmpleadoCuentaBancaria != 0).ToList())
                        {
                            if (!Empleado.DetalleEmpleadosCuentasBancarias.Any(c => c.IdDetalleEmpleadoCuentaBancaria == DetalleEmpleadoOriginal.IdDetalleEmpleadoCuentaBancaria))
                            {
                                EmpleadoOriginal.DetalleEmpleadosCuentasBancarias.Remove(DetalleEmpleadoOriginal);
                                db.Entry(DetalleEmpleadoOriginal).State = System.Data.Entity.EntityState.Deleted;
                            }
                        }

                        foreach (var d in Empleado.DetalleEmpleadosUbicaciones)
                        {
                            var DetalleEmpleadoOriginal = EmpleadoOriginal.DetalleEmpleadosUbicaciones.Where(c => c.IdDetalleEmpleadoUbicacion == d.IdDetalleEmpleadoUbicacion && d.IdDetalleEmpleadoUbicacion > 0).SingleOrDefault();
                            if (DetalleEmpleadoOriginal != null)
                            {
                                var DetalleEmpleadoEntry = db.Entry(DetalleEmpleadoOriginal);
                                DetalleEmpleadoEntry.CurrentValues.SetValues(d);
                            }
                            else
                            {
                                EmpleadoOriginal.DetalleEmpleadosUbicaciones.Add(d);
                            }
                        }
                        foreach (var DetalleEmpleadoOriginal in EmpleadoOriginal.DetalleEmpleadosUbicaciones.Where(c => c.IdDetalleEmpleadoUbicacion != 0).ToList())
                        {
                            if (!Empleado.DetalleEmpleadosUbicaciones.Any(c => c.IdDetalleEmpleadoUbicacion == DetalleEmpleadoOriginal.IdDetalleEmpleadoUbicacion))
                            {
                                EmpleadoOriginal.DetalleEmpleadosUbicaciones.Remove(DetalleEmpleadoOriginal);
                                db.Entry(DetalleEmpleadoOriginal).State = System.Data.Entity.EntityState.Deleted;
                            }
                        }

                        db.Entry(EmpleadoOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Empleados.Add(Empleado);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdEmpleado = Empleado.IdEmpleado, ex = "" });
                }
                else
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El empleado tiene datos invalidos";

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
            //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }

        public bool Validar(ProntoMVC.Data.Models.Empleado o, ref string sErrorMsg)
        {
            if (o.Activo == null) sErrorMsg += "\n" + "Falta el estado";

            if (o.Nombre == "") sErrorMsg += "\n" + "Falta el nombre del empleado";

            if ((o.Legajo ?? 0) <= 0) sErrorMsg += "\n" + "Falta el Legajo del empleado";

            if (db.Empleados.Any(x => x.Legajo == o.Legajo && !(x.IdEmpleado == o.IdEmpleado)))
            {
                sErrorMsg += "\n" + "El legajo ya existe";
            }

            if (sErrorMsg != "")
                return false;
            else
                return true;
        }

        void CargarViewBag(Empleado o)
        {
            ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", o.IdSector ?? 0);
            ViewBag.IdCargo = new SelectList(db.Cargos, "IdCargo", "Descripcion", o.IdCargo ?? 0);
            ViewBag.IdCuentaFondoFijo = new SelectList(GetCuentasFF(), "IdCuenta", "Descripcion", o.IdCuentaFondoFijo ?? 0);
            ViewBag.IdObraAsignada = new SelectList(GetObras(), "IdObra", "Descripcion", o.IdObraAsignada ?? 0);
        }

        public virtual JsonResult GetEmpleado(int id)
        {
            return Json((from item in db.Empleados
                         where (item.IdEmpleado == id)
                         select new
                         {
                             id = item.IdEmpleado,
                             value = item.Nombre,
                             Email = item.Email
                         }).Take(20).ToList(), JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult EmpleadosParaCombo()
        {
            if (db == null) return null;
            var empleados = (from x in db.Empleados.Where(x => (x.Activo ?? "SI") == "SI").OrderBy(x => x.Nombre)
                             select new { x.IdEmpleado, x.Nombre }).ToList();
            return Json(empleados, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult EmpleadosParaComboSectorCompras()
        {
            if (db == null) return null;

            string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            DataTable dt = EntidadManager.GetStoreProcedure(nSC, "Empleados_TX_PorSector", "Compras");
            IEnumerable<DataRow> rows = dt.AsEnumerable();
            var empleados = (from r in rows select new { IdEmpleado = r[0], Nombre = r[1] }).ToList();
            return Json(empleados, JsonRequestBehavior.AllowGet);
        }

        public string BuscarPass(int id, string pass)
        {
            if (oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin")) return id.ToString();

            var p = db.Empleados.Where(c => c.IdEmpleado == id).Where(c => c.Password == pass).FirstOrDefault();
            if (p != null)
                return p.IdEmpleado.ToString();
            //verificar si la pass es la de web
            var empleado = db.Empleados.Where(c => c.IdEmpleado == id).FirstOrDefault();
            try
            {
                if (Membership.ValidateUser(empleado.UsuarioNT, pass))
                    return empleado.IdEmpleado.ToString();
                else if (Membership.ValidateUser(empleado.Nombre, pass))  // no debería usar esto, pero por ahora...
                    return empleado.IdEmpleado.ToString();
                else
                    return "";
            }
            catch (Exception)
            {
                return "";
            }
        }

        public string BuscarPassSuperadmin(string pass)
        {
            //var p = db.Empleados.Where(c => c.IdEmpleado == id).Where(c => c.Password == pass).FirstOrDefault();
            if (pass == "ldb")
            {
                ViewBag.SuperadminPass = pass;
                this.Session["SuperadminPass"] = pass;
                return "ok";
            }
            else
                return "";
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

        public virtual ActionResult DetEmpleados(string sidx, string sord, int? page, int? rows, int? IdEmpleado)
        {
            int IdEmpleado1 = IdEmpleado ?? 0;
            var Det = db.DetalleEmpleadosIngresosEgresos.Where(p => p.IdEmpleado == IdEmpleado1 || IdEmpleado1 == -1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            switch (sidx.ToLower())
            {
                case "fechaingreso":
                    if (sord.Equals("desc"))
                        Det = Det.OrderByDescending(a => a.FechaIngreso);
                    else
                        Det = Det.OrderBy(a => a.FechaIngreso);
                    break;
                default:
                    if (sord.Equals("desc"))
                        Det = Det.OrderByDescending(a => a.IdEmpleado);
                    else
                        Det = Det.OrderBy(a => a.IdEmpleado);
                    break;
            }

            var data = (from a in Det
                        select new
                        {
                            a.IdDetalleEmpleado,
                            a.IdEmpleado,
                            a.FechaIngreso,
                            a.FechaEgreso
                        }).Skip((currentPage - 1) * pageSize).OrderBy(x => x.FechaIngreso).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleEmpleado.ToString(),
                            cell = new string[] { 
                                a.IdDetalleEmpleado.ToString(), 
                                a.IdEmpleado.ToString(), 
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaEgreso == null ? "" : a.FechaEgreso.GetValueOrDefault().ToString("dd/MM/yyyy")
                         }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetEmpleadosSectores(string sidx, string sord, int? page, int? rows, int? IdEmpleado)
        {
            int IdEmpleado1 = IdEmpleado ?? 0;
            var Det = db.DetalleEmpleadosSectores.Where(p => p.IdEmpleado == IdEmpleado1 || IdEmpleado1 == -1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            switch (sidx.ToLower())
            {
                case "fechacambio":
                    if (sord.Equals("desc"))
                        Det = Det.OrderByDescending(a => a.FechaCambio);
                    else
                        Det = Det.OrderBy(a => a.FechaCambio);
                    break;
                default:
                    if (sord.Equals("desc"))
                        Det = Det.OrderByDescending(a => a.IdEmpleado);
                    else
                        Det = Det.OrderBy(a => a.IdEmpleado);
                    break;
            }

            var data = (from a in Det
                        join b in db.Sectores on a.IdSectorNuevo equals b.IdSector into ab
                        from b in ab.DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleEmpleadoSector,
                            a.IdEmpleado,
                            a.FechaCambio,
                            Sector = b != null ? b.Descripcion : null,
                            a.IdSectorNuevo
                        }).OrderBy(x => x.FechaCambio)
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
                            id = a.IdDetalleEmpleadoSector.ToString(),
                            cell = new string[] { 
                                a.IdDetalleEmpleadoSector.ToString(), 
                                a.IdEmpleado.ToString(), 
                                a.FechaCambio == null ? "" : a.FechaCambio.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Sector,
                                a.IdSectorNuevo.ToString()
                         }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetEmpleadosJornadas(string sidx, string sord, int? page, int? rows, int? IdEmpleado)
        {
            int IdEmpleado1 = IdEmpleado ?? 0;
            var Det = db.DetalleEmpleadosJornadas.Where(p => p.IdEmpleado == IdEmpleado1 || IdEmpleado1 == -1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            switch (sidx.ToLower())
            {
                case "fechacambio":
                    if (sord.Equals("desc"))
                        Det = Det.OrderByDescending(a => a.FechaCambio);
                    else
                        Det = Det.OrderBy(a => a.FechaCambio);
                    break;
                default:
                    if (sord.Equals("desc"))
                        Det = Det.OrderByDescending(a => a.IdEmpleado);
                    else
                        Det = Det.OrderBy(a => a.IdEmpleado);
                    break;
            }

            var data = (from a in Det
                        select new
                        {
                            a.IdDetalleEmpleadoJornada,
                            a.IdEmpleado,
                            FechaCambio = a.FechaCambio,
                            a.HorasJornada
                        }).OrderBy(x => x.FechaCambio)
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
                            id = a.IdDetalleEmpleadoJornada.ToString(),
                            cell = new string[] { 
                                a.IdDetalleEmpleadoJornada.ToString(), 
                                a.IdEmpleado.ToString(), 
                                a.FechaCambio == null ? "" : a.FechaCambio.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.HorasJornada.ToString()
                         }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetEmpleadosCuentasBancarias(string sidx, string sord, int? page, int? rows, int? IdEmpleado)
        {
            int IdEmpleado1 = IdEmpleado ?? 0;
            var Det = db.DetalleEmpleadosCuentasBancarias.Where(p => p.IdEmpleado == IdEmpleado1 || IdEmpleado1 == -1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            switch (sidx.ToLower())
            {
                case "idcuentabancaria":
                    if (sord.Equals("desc"))
                        Det = Det.OrderByDescending(a => a.IdCuentaBancaria);
                    else
                        Det = Det.OrderBy(a => a.IdCuentaBancaria);
                    break;
                default:
                    if (sord.Equals("desc"))
                        Det = Det.OrderByDescending(a => a.IdEmpleado);
                    else
                        Det = Det.OrderBy(a => a.IdEmpleado);
                    break;
            }

            var data = (from a in Det
                        join b in db.CuentasBancarias on a.IdCuentaBancaria equals b.IdCuentaBancaria into ab from b in ab.DefaultIfEmpty()
                        join c in db.Bancos on b.IdBanco equals c.IdBanco into ac from c in ac.DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleEmpleadoCuentaBancaria,
                            a.IdEmpleado,
                            Banco = c != null ? c.Nombre : null,
                            CuentaBancaria = b != null ? b.Cuenta : null,
                            a.IdCuentaBancaria
                        }).OrderBy(x => x.Banco)
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
                            id = a.IdDetalleEmpleadoCuentaBancaria.ToString(),
                            cell = new string[] { 
                                a.IdDetalleEmpleadoCuentaBancaria.ToString(), 
                                a.IdEmpleado.ToString(), 
                                a.Banco,
                                a.CuentaBancaria,
                                a.IdCuentaBancaria.ToString()
                         }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetEmpleadosUbicaciones(string sidx, string sord, int? page, int? rows, int? IdEmpleado)
        {
            int IdEmpleado1 = IdEmpleado ?? 0;
            var Det = db.DetalleEmpleadosUbicaciones.Where(p => p.IdEmpleado == IdEmpleado1 || IdEmpleado1 == -1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            switch (sidx.ToLower())
            {
                case "idubicacion":
                    if (sord.Equals("desc"))
                        Det = Det.OrderByDescending(a => a.IdUbicacion);
                    else
                        Det = Det.OrderBy(a => a.IdUbicacion);
                    break;
                default:
                    if (sord.Equals("desc"))
                        Det = Det.OrderByDescending(a => a.IdEmpleado);
                    else
                        Det = Det.OrderBy(a => a.IdEmpleado);
                    break;
            }

            var data = (from a in Det
                        join b in db.Ubicaciones on a.IdUbicacion equals b.IdUbicacion into ab
                        from b in ab.DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleEmpleadoUbicacion,
                            a.IdEmpleado,
                            Ubicacion = b != null ? b.Descripcion : null,
                            a.IdUbicacion
                        }).OrderBy(x => x.Ubicacion)
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
                            id = a.IdDetalleEmpleadoUbicacion.ToString(),
                            cell = new string[] { 
                                a.IdDetalleEmpleadoUbicacion.ToString(), 
                                a.IdEmpleado.ToString(), 
                                a.Ubicacion,
                                a.IdUbicacion.ToString()
                         }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Listado_jqGrid(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Tabla = db.Empleados.AsQueryable();
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "nombre":
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

            var Tabla2 = (from a in Tabla
                          select new { Id = a.IdEmpleado }).Where(campo).ToList();

            int totalRecords = Tabla2.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Tabla
                        join b in db.Cuentas on a.IdCuentaFondoFijo equals b.IdCuenta into ab
                        from b in ab.DefaultIfEmpty()
                        join c in db.Obras on a.IdObraAsignada equals c.IdObra into ac
                        from c in ac.DefaultIfEmpty()
                        select new
                        {
                            a.IdEmpleado,
                            a.Nombre,
                            a.Legajo,
                            a.UsuarioNT,
                            Sector = a.Sectore.Descripcion,
                            Cargo = "", //a.Cargo.Descripcion,
                            a.Email,
                            a.Iniciales,
                            a.Administrador,
                            CuentaFFAsignada = b != null ? b.Descripcion : null,
                            ObraAsignada = c != null ? c.NumeroObra : null,
                            a.Activo
                        }
                        ).Where(campo).OrderBy(sidx + " " + sord)
.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdEmpleado.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdEmpleado}) +">Editar</>  -  <a href="+ Url.Action("Delete",new {id = a.IdEmpleado}) +">Eliminar</>",
                                a.IdEmpleado.ToString(),
                                a.Nombre,
                                a.Legajo.ToString(),
                                a.UsuarioNT,
                                a.Sector,
                                a.Cargo,
                                a.Email,
                                a.Iniciales,
                                a.Administrador,
                                a.CuentaFFAsignada,
                                a.ObraAsignada,
                                a.Activo
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public IList<Cuenta> GetCuentasFF()
        {
            Parametros parametros = db.Parametros.Find(1);
            int? mIdTipoCuentaGrupoFF = parametros.IdTipoCuentaGrupoFF;

            IQueryable<Cuenta> query = db.Cuentas.Where(c => c.IdTipoCuentaGrupo == mIdTipoCuentaGrupoFF);

            return query.ToList();
        }

        public IList<Obra> GetObras()
        {
            IQueryable<Obra> query = db.Obras;
            return query.ToList();
        }
    }
}