using System;
using System.Collections.Generic;
using System.Configuration;
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
using System.Web.Security;

using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;

using ProntoMVC.Models;
using ProntoMVC.Data.Models;
using Pronto.ERP.Bll;

namespace ProntoMVC.Controllers
{
    public partial class CajaController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Cajas)) throw new Exception("No tenés permisos");

            return View();
        }

        public virtual ActionResult Edit(int id)
        {
            Caja o;
            if (id <= 0)
            {
                o = new Caja();
            }
            else
            {
                o = db.Cajas.SingleOrDefault(x => x.IdCaja == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        void CargarViewBag(Caja o)
        {
            Parametros parametros = db.Parametros.Find(1);
            int? i = parametros.IdTipoCuentaGrupoFF;
        }

        public bool Validar(ProntoMVC.Data.Models.Caja o, ref string sErrorMsg)
        {
            if ((o.Descripcion ?? "") == "") { sErrorMsg += "\n" + "Falta la descripcion"; }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(Caja Caja)
        {
            if (!PuedeEditar(enumNodos.Cajas)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(Caja, ref errs))
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

                if (ModelState.IsValid)
                {
                    if (Caja.IdCaja > 0)
                    {
                        var EntidadOriginal = db.Cajas.Where(p => p.IdCaja == Caja.IdCaja).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Caja);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Cajas.Add(Caja);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdCaja = Caja.IdCaja, ex = "" });
                }
                else
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El registro tiene datos invalidos";

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
        }

        [HttpPost]
        public virtual JsonResult Delete(int Id)
        {
            Caja Entidad = db.Cajas.Find(Id);
            db.Cajas.Remove(Entidad);
            db.SaveChanges();
            return Json(new { Success = 1, IdCaja = Id, ex = "" });
        }

        public class Cajas2
        {
            public int IdCaja { get; set; }
            public int? IdCuenta { get; set; }
            public int? IdMoneda { get; set; }
            public string Descripcion { get; set; }
            public string Cuenta { get; set; }
            public string Moneda { get; set; }
        }

        public virtual JsonResult Cajas_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.Cajas
                        from b in db.Monedas.Where(o => o.IdMoneda == a.IdMoneda).DefaultIfEmpty()
                        from c in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        select new Cajas2
                        {
                            IdCaja = a.IdCaja,
                            IdCuenta = a.IdCuenta,
                            IdMoneda = a.IdMoneda,
                            Descripcion = a.Descripcion,
                            Cuenta = c != null ? c.Descripcion : "",
                            Moneda = b != null ? b.Nombre : ""
                        }).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<Cajas2>
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
                            id = a.IdCaja.ToString(),
                            cell = new string[] { 
                                "",
                                a.IdCaja.ToString(),
                                a.IdCuenta.NullSafeToString(),
                                a.IdMoneda.NullSafeToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Cuenta.NullSafeToString(),
                                a.Moneda.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetCajas()
        {
            Dictionary<int, string> Tabla = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.Caja u in db.Cajas.OrderBy(x => x.Descripcion).ToList())
                Tabla.Add(u.IdCaja, u.Descripcion);

            return PartialView("Select", Tabla);
        }

        public virtual ActionResult GetCajasPorIdCuenta2(int IdCuenta = 0)
        {
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            foreach (ProntoMVC.Data.Models.Caja u in db.Cajas.Where(x => IdCuenta == 0 || x.IdCuenta == IdCuenta).OrderBy(x => x.Descripcion).ToList())
                Datacombo.Add(u.IdCaja, u.Descripcion);

            return PartialView("Select", Datacombo);
        }

    }
}
