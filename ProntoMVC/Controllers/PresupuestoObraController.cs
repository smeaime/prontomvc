using System;
using System.Collections.Generic;
using System.Configuration;
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

using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
//using Trirand.Web.Mvc;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using Pronto.ERP.Bll;
using Newtonsoft.Json;

namespace ProntoMVC.Controllers
{
    public partial class PresupuestoObraController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var PresupuestoObra = db.PresupuestoObrasNodos
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Sectores.Count() / pageSize);

            return View(PresupuestoObra);
        }

        public virtual JsonResult GetPresupuestoObraEtapas(int IdObra)
        {
            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));

            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "PresupuestoObrasNodos_TX_EtapasImputablesPorObraParaCombo", IdObra, "M");
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            var data1 = (from a in Entidad
                    select new
                    {
                        id = a["IdPresupuestoObrasNodo"].ToString(),
                        value = a["Titulo"].ToString()
                    }).ToList();
            return Json(data1, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetItemsPresupuestoObras(string term)
        {

            var q = (from item in db.PresupuestoObrasNodos
                     from b in db.PresupuestoObrasNodos.Where(o => o.IdPresupuestoObrasNodo == item.IdNodoPadre).DefaultIfEmpty()
                     where item.Item.StartsWith(term)
                     orderby item.Item
                     select new
                     {
                         id = item.IdPresupuestoObrasNodo,
                         value = item.Item + (b != null ? " " + b.Descripcion : "") + " - " + item.Descripcion, // esto es lo que se ve
                         title = (b != null ? " " + b.Descripcion : "") + " - " + item.Descripcion,
                         Descripcion = item.Descripcion
                     }).Take(100).ToList();

            if (q.Count == 0 && term != "No se encontraron resultados")
            {
                q.Add(new { id = 0, value = "No se encontraron resultados", title = "", Descripcion = "" });
            }

            var a = Json(q, JsonRequestBehavior.AllowGet);

            return a;
        }

        public virtual JsonResult GetPresupuestoObraPorId(int Id)
        {
            var filtereditems = (from a in db.PresupuestoObrasNodos
                                 from b in db.PresupuestoObrasNodos.Where(o => o.IdPresupuestoObrasNodo == a.IdNodoPadre).DefaultIfEmpty()
                                 where (a.IdPresupuestoObrasNodo == Id)
                                 select new
                                 {
                                     id = a.IdPresupuestoObrasNodo,
                                     value = a.Item + (b != null ? " " + b.Descripcion : "") + " - " + a.Descripcion,
                                     a.Item,
                                     DescripcionConPadre = (b != null ? " " + b.Descripcion : "") + " - " + a.Descripcion,
                                     Descripcion = a.Descripcion
                                 }).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}
