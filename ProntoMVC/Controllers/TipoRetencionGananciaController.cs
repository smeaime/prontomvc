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
using ProntoMVC.Data.Models; using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Text;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
using System.Reflection;
using System.Configuration;
using Pronto.ERP.Bll;



using System.Web.Security;

namespace ProntoMVC.Controllers
{
    public partial class TipoRetencionGananciaController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var TipoGanancias = db.TiposRetencionGanancias
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.TiposRetencionGanancias.Count() / pageSize);

            return View(TipoGanancias);
        }

        public virtual ActionResult Listado_jqGrid(string sidx, string sord, int? page, int? rows,
                                         bool _search, string searchField, string searchOper, string searchString,
                                         string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.TiposRetencionGanancias.AsQueryable();
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
                            IdTipoRetencionGanancia = a.IdTipoRetencionGanancia,
                        }).Where(campo).ToList();

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Fac
                        select a).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdTipoRetencionGanancia.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdTipoRetencionGanancia} )  +" target='_blank' >Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdTipoRetencionGanancia} )  +">Imprimir</>" ,
                                
                                a.IdTipoRetencionGanancia.ToString(),
                                a.Descripcion.ToString(),
                                (a.CodigoImpuestoAFIP ?? 0).ToString(),
                                (a.CodigoRegimenAFIP ?? 0).ToString(),
                                (a.InformacionAuxiliar ?? string.Empty).ToString(),
                                (a.BienesOServicios ?? string.Empty).ToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Edit(int id)
        {
            if (id == -1)
            {
                TiposRetencionGanancia TiposRetencionGanancias = new TiposRetencionGanancia();
                return View(TiposRetencionGanancias);
            }
            else
            {

                TiposRetencionGanancia TiposRetencionGanancias = db.TiposRetencionGanancias.Find(id);
                return View(TiposRetencionGanancias);
            }
        }

        [HttpPost]
        public virtual ActionResult Edit(TiposRetencionGanancia TiposRetencionGanancias)
        {
            if (ModelState.IsValid)
            {
                if (TiposRetencionGanancias.IdTipoRetencionGanancia <= 0)
                {
                    db.TiposRetencionGanancias.Add(TiposRetencionGanancias);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                else
                {
                    db.Entry(TiposRetencionGanancias).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            return View(TiposRetencionGanancias);
        }

        public virtual ActionResult DeleteConfirmed(int id)
        {
            TiposRetencionGanancia TiposRetencionGanancias = db.TiposRetencionGanancias.Find(id);
            db.TiposRetencionGanancias.Remove(TiposRetencionGanancias);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult GetCategoriasGanancia()
        {
            Dictionary<int, string> categorias = new Dictionary<int, string>();
            foreach (TiposRetencionGanancia u in db.TiposRetencionGanancias.OrderBy(x => x.Descripcion).ToList())
                categorias.Add(u.IdTipoRetencionGanancia, u.Descripcion);

            return PartialView("Select", categorias);
        }

    }
}