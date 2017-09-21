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

using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
//using Trirand.Web.Mvc;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using Pronto.ERP.Bll;

namespace ProntoMVC.Controllers
{
    public partial class TiposComprobanteController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.TiposComprobantes
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.TiposComprobantes.Count() / pageSize);

            return View(Tabla);
        }

        public bool Validar(ProntoMVC.Data.Models.TiposComprobante o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            Int32 mMaxLength = 0;
            string mProntoIni = "";
            Boolean result;

            if (o.Descripcion.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta el nombre";
            }
            else
            {
                mMaxLength = GetMaxLength<TiposComprobante>(x => x.Descripcion) ?? 0;
                if (o.Descripcion.Length > mMaxLength) { sErrorMsg += "\n" + "El nombre no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.TiposComprobante TiposComprobante)
        {
            if (!PuedeEditar(enumNodos.TiposComprobante)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(TiposComprobante, ref errs))
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
                    if (TiposComprobante.IdTipoComprobante > 0)
                    {
                        var EntidadOriginal = db.TiposComprobantes.Where(p => p.IdTipoComprobante == TiposComprobante.IdTipoComprobante).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(TiposComprobante);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.TiposComprobantes.Add(TiposComprobante);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdTipoComprobante = TiposComprobante.IdTipoComprobante, ex = "" });
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
            ProntoMVC.Data.Models.TiposComprobante TiposComprobante = db.TiposComprobantes.Find(Id);
            db.TiposComprobantes.Remove(TiposComprobante);
            db.SaveChanges();
            return Json(new { Success = 1, IdTipoComprobante = Id, ex = "" });
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.TiposComprobantes.AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdTipoComprobante = a.IdTipoComprobante }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdTipoComprobante,
                            a.Descripcion,
                            a.DescripcionAb,
                            a.Coeficiente,
                            a.EsValor,
                            a.Agrupacion1,
                            a.VaAlLibro,
                            a.VaAlCiti,
                            a.VaAConciliacionBancaria,
                            a.VaAlRegistroComprasAFIP,
                            a.ExigirCAI,
                            a.CodigoDgi,
                            a.NumeradorAuxiliar,
                            a.CodigoAFIP_Letra_A,
                            a.CodigoAFIP_Letra_B,
                            a.CodigoAFIP_Letra_C,
                            a.CodigoAFIP_Letra_E,
                            a.CodigoAFIP2_Letra_A,
                            a.CodigoAFIP2_Letra_B,
                            a.CodigoAFIP2_Letra_C,
                            a.CodigoAFIP2_Letra_E,
                            a.CodigoAFIP3_Letra_A,
                            a.CodigoAFIP3_Letra_B,
                            a.CodigoAFIP3_Letra_C,
                            a.CodigoAFIP3_Letra_E
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
                            id = a.IdTipoComprobante.ToString(),
                            cell = new string[] { 
                                "",
                                a.IdTipoComprobante.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.DescripcionAb.NullSafeToString(),
                                a.Coeficiente.NullSafeToString(),
                                a.EsValor.NullSafeToString(),
                                a.Agrupacion1.NullSafeToString(),
                                a.VaAlLibro.NullSafeToString(),
                                a.VaAlCiti.NullSafeToString(),
                                a.VaAConciliacionBancaria.NullSafeToString(),
                                a.VaAlRegistroComprasAFIP.NullSafeToString(),
                                a.ExigirCAI.NullSafeToString(),
                                a.CodigoDgi.NullSafeToString(),
                                a.NumeradorAuxiliar.NullSafeToString(),
                                a.CodigoAFIP_Letra_A.NullSafeToString(),
                                a.CodigoAFIP_Letra_B.NullSafeToString(),
                                a.CodigoAFIP_Letra_C.NullSafeToString(),
                                a.CodigoAFIP_Letra_E.NullSafeToString(),
                                a.CodigoAFIP2_Letra_A.NullSafeToString(),
                                a.CodigoAFIP2_Letra_B.NullSafeToString(),
                                a.CodigoAFIP2_Letra_C.NullSafeToString(),
                                a.CodigoAFIP2_Letra_E.NullSafeToString(),
                                a.CodigoAFIP3_Letra_A.NullSafeToString(),
                                a.CodigoAFIP3_Letra_B.NullSafeToString(),
                                a.CodigoAFIP3_Letra_C.NullSafeToString(),
                                a.CodigoAFIP3_Letra_E.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult TiposComprobante_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.TiposComprobante>
                                ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            // esto filtro se debería aplicar antes que el filtrogenerico (queda mal paginado si no)
            var Entidad = pagedQuery.AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdTipoComprobante = a.IdTipoComprobante }).ToList();

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdTipoComprobante,
                            a.Descripcion,
                            a.DescripcionAb,
                            a.Coeficiente,
                            a.EsValor,
                            a.Agrupacion1,
                            a.VaAlLibro,
                            a.VaAlCiti,
                            a.VaAConciliacionBancaria,
                            a.VaAlRegistroComprasAFIP,
                            a.ExigirCAI,
                            a.CodigoDgi,
                            a.NumeradorAuxiliar,
                            a.CodigoAFIP_Letra_A,
                            a.CodigoAFIP_Letra_B,
                            a.CodigoAFIP_Letra_C,
                            a.CodigoAFIP_Letra_E,
                            a.CodigoAFIP2_Letra_A,
                            a.CodigoAFIP2_Letra_B,
                            a.CodigoAFIP2_Letra_C,
                            a.CodigoAFIP2_Letra_E,
                            a.CodigoAFIP3_Letra_A,
                            a.CodigoAFIP3_Letra_B,
                            a.CodigoAFIP3_Letra_C,
                            a.CodigoAFIP3_Letra_E
                        }).OrderBy(sidx + " " + sord).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdTipoComprobante.ToString(),
                            cell = new string[] { 
                                "",
                                a.IdTipoComprobante.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.DescripcionAb.NullSafeToString(),
                                a.Coeficiente.NullSafeToString(),
                                a.EsValor.NullSafeToString(),
                                a.Agrupacion1.NullSafeToString(),
                                a.VaAlLibro.NullSafeToString(),
                                a.VaAlCiti.NullSafeToString(),
                                a.VaAConciliacionBancaria.NullSafeToString(),
                                a.VaAlRegistroComprasAFIP.NullSafeToString(),
                                a.ExigirCAI.NullSafeToString(),
                                a.CodigoDgi.NullSafeToString(),
                                a.NumeradorAuxiliar.NullSafeToString(),
                                a.CodigoAFIP_Letra_A.NullSafeToString(),
                                a.CodigoAFIP_Letra_B.NullSafeToString(),
                                a.CodigoAFIP_Letra_C.NullSafeToString(),
                                a.CodigoAFIP_Letra_E.NullSafeToString(),
                                a.CodigoAFIP2_Letra_A.NullSafeToString(),
                                a.CodigoAFIP2_Letra_B.NullSafeToString(),
                                a.CodigoAFIP2_Letra_C.NullSafeToString(),
                                a.CodigoAFIP2_Letra_E.NullSafeToString(),
                                a.CodigoAFIP3_Letra_A.NullSafeToString(),
                                a.CodigoAFIP3_Letra_B.NullSafeToString(),
                                a.CodigoAFIP3_Letra_C.NullSafeToString(),
                                a.CodigoAFIP3_Letra_E.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetTiposComprobantes()
        {
            Dictionary<int, string> TiposComprobante = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.TiposComprobante u in db.TiposComprobantes.OrderBy(x => x.Descripcion).ToList())
                TiposComprobante.Add(u.IdTipoComprobante, u.Descripcion);

            return PartialView("Select", TiposComprobante);
        }
    }
}

