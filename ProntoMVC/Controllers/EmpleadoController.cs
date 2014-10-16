using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
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
        //private DemoProntoEntities db;

        //protected override void Initialize(System.Web.Routing.RequestContext rc)
        //{
        //    base.Initialize(rc);
        //    db = new DemoProntoEntities(Generales.sCadenaConex(rc));
        //}

        //
        // GET: /Empleado/

        public virtual ViewResult Index()
        {
            var empleados = db.Empleados.Include(e => e.Sector);
            return View(empleados.ToList());
        }

        //
        // GET: /Empleado/Details/5

        public virtual ViewResult Details(int id)
        {
            Empleado empleado = db.Empleados.Find(id);
            return View(empleado);
        }

        //
        // GET: /Empleado/Create

        public virtual ActionResult Create()
        {
            ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion");
            return View();
        }

        //
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

        //
        // GET: /Empleado/Edit/5

        public virtual ActionResult Edit(int id)
        {
            Empleado empleado = db.Empleados.Find(id);
            ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", empleado.IdSector);
            return View(empleado);
        }

        //
        // POST: /Empleado/Edit/5

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

        //
        // GET: /Empleado/Delete/5

        public virtual ActionResult Delete(int id)
        {
            Empleado empleado = db.Empleados.Find(id);
            return View(empleado);
        }

        //
        // POST: /Empleado/Delete/5

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
            
            //var empleados = (from x in db.Empleados.Where(x => (x.Activo ?? "SI") == "SI").OrderBy(x => x.Nombre)
            //                 select new { x.IdEmpleado, x.Nombre }).ToList();
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

        //protected override void Dispose(bool disposing)
        //{
        //    db.Dispose();
        //    base.Dispose(disposing);
        //}
    }
}