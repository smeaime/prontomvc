using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Text;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using ProntoMVC.Data.Models; 
using ProntoMVC.Models;
using Pronto.ERP.Bll;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;
using OpenXmlPowerTools;
using ClosedXML.Excel;

namespace ProntoMVC.Controllers
{
    public partial class RubroContableController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.RubrosContables)) throw new Exception("No tenés permisos");

            return View();
        }
        public virtual ViewResult IndexExterno()
        {
            if (!PuedeLeer(enumNodos.RubrosContables)) throw new Exception("No tenés permisos");

            return View();
        }

        public virtual ActionResult Edit(int id)
        {
            RubrosContable o;
            if (id <= 0)
            {
                o = new RubrosContable();
            }
            else
            {
                o = db.RubrosContables.SingleOrDefault(x => x.IdRubroContable == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        void CargarViewBag(RubrosContable o)
        {
            Parametros parametros = db.Parametros.Find(1);
            int? i = parametros.IdTipoCuentaGrupoFF;
        }

        public bool Validar(ProntoMVC.Data.Models.RubrosContable o, ref string sErrorMsg)
        {
            if ((o.Descripcion ?? "") == "") { sErrorMsg += "\n" + "Falta la descripcion"; }

            if (sErrorMsg != "") return false;
            else return true;
        }


        public virtual JsonResult BatchUpdate(RubrosContable RubrosContable)
        {
            if (!PuedeEditar(enumNodos.RubrosContables)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(RubrosContable, ref errs))
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
                    if (RubrosContable.IdRubroContable > 0)
                    {
                        var EntidadOriginal = db.RubrosContables.Where(p => p.IdRubroContable == RubrosContable.IdRubroContable).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(RubrosContable);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.RubrosContables.Add(RubrosContable);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdLocalidad = RubrosContable.IdRubroContable, ex = "" });
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

        public virtual ActionResult RubrosContables_DynamicGridData (string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            string campo = String.Empty;
            int currentPage = page; 

            int totalRecords = 0;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.RubrosContable>
                                ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)rows);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in pagedQuery.ToList()
                        select new jqGridRowJson
                        {
                            id = a.IdRubroContable.ToString(),
                            cell = new string[] { 
                                "", 
                                a.IdRubroContable.ToString(), 
                                a.Codigo.NullSafeToString(),
                                a.Descripcion.NullSafeToString(),
                                a.CodigoAgrupacion.NullSafeToString(),
                                (a.DistribuirGastosEnResumen=="SI").NullSafeToString(),
                                (a.TomarMesDeVentaEnResumen=="SI").NullSafeToString(),
                                (a.TiposRubrosFinancierosGrupos==null) ?  "" :  a.TiposRubrosFinancierosGrupos.Descripcion.NullSafeToString(),
                                (a.Cuenta==null) ?  "" :  a.Cuenta.Descripcion,
                                (a.Obra==null) ?  "" :  a.Obra.Descripcion.NullSafeToString(),
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetRubrosContables()
        {
            Dictionary<int, string> tabla = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.RubrosContable u in db.RubrosContables.Where(x => (x.Financiero ?? "") != "SI").OrderBy(x => x.Descripcion).ToList())
                tabla.Add(u.IdRubroContable, u.Descripcion);

            return PartialView("Select", tabla);
        }

        public virtual ActionResult GetRubrosFinancierosEgresos()
        {
            Dictionary<int, string> tabla = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.RubrosContable u in db.RubrosContables.Where(x => (x.Financiero ?? "") == "SI" && (x.IngresoEgreso ?? "") == "E").OrderBy(x => x.Descripcion).ToList())
                tabla.Add(u.IdRubroContable, u.Descripcion);

            return PartialView("Select", tabla);
        }

        public virtual ActionResult GetTiposRubrosFinancierosGrupos()
        {
            Dictionary<int, string> tabla = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.TiposRubrosFinancierosGrupos u in db.TiposRubrosFinancierosGrupos.OrderBy(x => x.Descripcion).ToList())
                tabla.Add(u.IdTipoRubroFinancieroGrupo, u.Descripcion);

            return PartialView("Select", tabla);
        }

    }
}
