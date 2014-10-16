using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProntoMVC.Data.Models; using ProntoMVC.Models;
using System.Linq.Expressions;
using System.Threading;

namespace ProntoMVC.Controllers
{
    public partial class SectorController : ProntoBaseController
    {
 

        const int pageSize = 10;

        //
        // GET: /Sector/

        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Sectores = db.Sectores
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Sectores.Count() / pageSize);

            return View(Sectores);
        }

        public virtual JsonResult GetSectoresJson()
        {
            var Sectores = db.Sectores.ToList();

            return Json(Sectores);
        }

        public List<Sector> ListaSectores(int startIndex, int count, string sorting)
        {
            IEnumerable<Sector> query = db.Sectores;

            //Sorting
            //This ugly code is used just for demonstration.
            //Normally, Incoming sorting text can be directly appended to an SQL query.
            if (string.IsNullOrEmpty(sorting) || sorting.Equals("Descripcion ASC"))
            {
                query = query.OrderBy(p => p.Descripcion);
            }
            else if (sorting.Equals("Descripcion DESC"))
            {
                query = query.OrderByDescending(p => p.Descripcion);
            }
            else
            {
                query = query.OrderBy(p => p.Descripcion); //Default!
            }

            return count > 0
                       ? query.Skip(startIndex).Take(count).ToList() //Paging
                       : query.ToList(); //No paging
        }

        [HttpPost]
        public virtual JsonResult ListaSectores2(int jtStartIndex = 0, int jtPageSize = 0, string jtSorting = null)
        {
            try
            {
                Thread.Sleep(200);
                var Sectores = ListaSectores(jtStartIndex, jtPageSize, jtSorting);

                return Json(new { Result = "OK", Records = Sectores, TotalRecordCount = Sectores.Count() });
            }
            catch (Exception ex)
            {
                return Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        //
        // GET: /Sector/Details/5

        public virtual ViewResult Details(int id)
        {
            Sector sector = db.Sectores.Find(id);
            return View(sector);
        }

        //
        // GET: /Sector/Create

        public virtual ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Sector/Create

        [HttpPost]
        public virtual ActionResult Create(Sector sector)
        {
            if (ModelState.IsValid)
            {
                db.Sectores.Add(sector);
                db.SaveChanges();
                return RedirectToAction("Index");  
            }

            return View(sector);
        }
        
        //
        // GET: /Sector/Edit/5

        public virtual ActionResult Edit(int id)
        {
            Sector sector = db.Sectores.Find(id);
            return View(sector);
        }

        //
        // POST: /Sector/Edit/5

        [HttpPost]
        public virtual ActionResult Edit(Sector sector)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sector).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(sector);
        }

        //
        // GET: /Sector/Delete/5

        public virtual ActionResult Delete(int id)
        {
            Sector sector = db.Sectores.Find(id);
            return View(sector);
        }

        //
        // POST: /Sector/Delete/5

        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {            
            Sector sector = db.Sectores.Find(id);
            db.Sectores.Remove(sector);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}