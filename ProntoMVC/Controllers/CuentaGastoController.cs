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
    public partial class CuentaGastoController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.CuentasGastos)) throw new Exception("No tenés permisos");

            return View();
        }

        public virtual ActionResult Edit(int id)
        {
            CuentasGasto o;
            if (id <= 0)
            {
                o = new CuentasGasto();
            }
            else
            {
                o = db.CuentasGastos.SingleOrDefault(x => x.IdCuentaGasto == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        void CargarViewBag(CuentasGasto o)
        {
            Parametros parametros = db.Parametros.Find(1);
            int? i = parametros.IdTipoCuentaGrupoFF;
        }

        public bool Validar(ProntoMVC.Data.Models.CuentasGasto o, ref string sErrorMsg)
        {
            if ((o.Descripcion ?? "") == "") { sErrorMsg += "\n" + "Falta la descripcion"; }

            if (sErrorMsg != "") return false;
            else return true;
        }


        public virtual JsonResult BatchUpdate(CuentasGasto CuentasGasto)
        {
            if (!PuedeEditar(enumNodos.CuentasGastos)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(CuentasGasto, ref errs))
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
                    if (CuentasGasto.IdCuentaGasto > 0)
                    {
                        var EntidadOriginal = db.CuentasGastos.Where(p => p.IdCuentaGasto == CuentasGasto.IdCuentaGasto).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(CuentasGasto);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.CuentasGastos.Add(CuentasGasto);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdCuentaGasto = CuentasGasto.IdCuentaGasto, ex = "" });
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
            CuentasGasto Entidad = db.CuentasGastos.Find(Id);
            db.CuentasGastos.Remove(Entidad);
            db.SaveChanges();
            return Json(new { Success = 1, IdCuentaGasto = Id, ex = "" });
        }

        public virtual ActionResult CuentasGastos_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.CuentasGasto>
                                ("RubrosContables,Cuentas", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            // esto filtro se debería aplicar antes que el filtrogenerico (queda mal paginado si no)
            //var Entidad = pagedQuery.Where(o => (o.Confirmado ?? "") != "NO").AsQueryable();

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)rows);

            var data = (from a in pagedQuery
                        from b in db.RubrosContables.Where(o => o.IdRubroContable == a.IdRubroContable).DefaultIfEmpty()
                        from c in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaMadre).DefaultIfEmpty()
                        select new
                        {
                            a.IdCuentaGasto,
                            a.IdRubroContable,
                            a.IdCuentaMadre,
                            a.Codigo,
                            a.Descripcion,
                            RubroContable = b != null ? b.Descripcion : "",
                            CuentaMadre = c != null ? c.Descripcion : "",
                            a.CodigoDestino,
                            a.Activa,
                            a.Titulo
                        }).OrderBy(sidx + " " + sord).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdCuentaGasto.ToString(),
                            cell = new string[] { 
                                "",
                                a.IdCuentaGasto.ToString(),
                                a.IdRubroContable.NullSafeToString(),
                                a.IdCuentaMadre.NullSafeToString(),
                                a.Codigo.NullSafeToString(),
                                a.Descripcion.NullSafeToString(),
                                a.RubroContable.NullSafeToString(),
                                a.CuentaMadre.NullSafeToString(),
                                a.CodigoDestino.NullSafeToString(),
                                a.Activa.NullSafeToString(),
                                a.Titulo.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetCuentasGasto()
        {
            Dictionary<int, string> registros = new Dictionary<int, string>();
            foreach (CuentasGasto u in db.CuentasGastos.OrderBy(x => x.Descripcion).ToList())
                registros.Add(u.IdCuentaGasto, u.Descripcion);

            return PartialView("Select", registros);
        }

        public virtual ActionResult GetCuentasGastos()
        {
            Dictionary<int, string> CuentaGasto = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.CuentasGasto u in db.CuentasGastos.OrderBy(x => x.Descripcion).ToList())
                CuentaGasto.Add(u.IdCuentaGasto, u.Descripcion);

            return PartialView("Select", CuentaGasto);
        }

    }
}
