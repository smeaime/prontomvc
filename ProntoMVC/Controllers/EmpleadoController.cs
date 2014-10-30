using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using ProntoMVC.Data.Models; 
using ProntoMVC.Models;
using System.Web.Security;
using Pronto.ERP.Bll;

namespace ProntoMVC.Controllers
{
    public partial class EmpleadoController : ProntoBaseController
    {
        // GET: /Empleado/Index
        public virtual ViewResult Index()
        {
            var empleados = db.Empleados.Include(e => e.Sector);
            return View(empleados.ToList());
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
            Empleado empleado = db.Empleados.Find(id);
            ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", empleado.IdSector);
            return View(empleado);
        }

        // POST: /Empleado/Edit
        [HttpPost]
        public virtual ActionResult Edit(Empleado empleado)
        {
            if (ModelState.IsValid)
            {
                db.Entry(empleado).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", empleado.IdSector);
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
            db.Empleados.Remove(empleado);
            db.SaveChanges();
            return RedirectToAction("Index");
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
            
            string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            DataTable dt = EntidadManager.GetStoreProcedure(nSC, "Empleados_TX_PorSector", "Compras");
            IEnumerable<DataRow> rows = dt.AsEnumerable();
            var empleados = (from r in rows select new { IdEmpleado = r[0], Nombre = r[1] }).ToList();
            return Json(empleados, JsonRequestBehavior.AllowGet);
        }

        public string BuscarPass(int id, string pass)
        {
            if (Roles.IsUserInRole(Membership.GetUser().UserName,"SuperAdmin"))  return id.ToString();

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
                          select new {Id = a.IdEmpleado}).Where(campo).ToList();

            int totalRecords = Tabla2.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Tabla
                        join b in db.Cuentas on a.IdCuentaFondoFijo equals b.IdCuenta into ab from b in ab.DefaultIfEmpty()
                        join c in db.Obras on a.IdObraAsignada equals c.IdObra into ac from c in ac.DefaultIfEmpty()
                        select new
                        {
                            a.IdEmpleado,
                            a.Nombre,
                            a.Legajo,
                            a.UsuarioNT,
                            Sector = a.Sector.Descripcion,
                            Cargo = a.Cargo.Descripcion, 
                            a.Email,
                            a.Iniciales,
                            a.Administrador,
                            CuentaFFAsignada = b != null ? b.Descripcion : null,
                            ObraAsignada = c != null ? c.NumeroObra : null,
                            a.Activo
                        }
                        ).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

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
    }
}