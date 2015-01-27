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
using System.Web.Security;

using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;

using ProntoMVC.Models;
using ProntoMVC.Data.Models;
using Pronto.ERP.Bll;

namespace ProntoMVC.Controllers
{
    public partial class ImpuestosDirectoController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.ImpuestosDirectos
                .OrderBy(s => s.IdImpuestoDirecto)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.ImpuestosDirectos.Count() / pageSize);

            return View(Tabla);
        }

        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.ImpuestosDirectos)) throw new Exception("No tenés permisos");
            ImpuestosDirecto o;
            if (id <= 0)
            {
                o = new ImpuestosDirecto();
            }
            else
            {
                o = db.ImpuestosDirectos.SingleOrDefault(x => x.IdImpuestoDirecto == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        void CargarViewBag(ImpuestosDirecto o)
        {
            ViewBag.IdTipoImpuesto = new SelectList(db.TiposImpuestoes, "IdTipoImpuesto", "Descripcion", o.IdTipoImpuesto);
            ViewBag.IdCuenta = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuenta);
        }

        public bool Validar(ProntoMVC.Data.Models.ImpuestosDirecto o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            string mProntoIni = "";
            Boolean result;

            if ((o.Descripcion ?? "") == "") { sErrorMsg += "\n" + "Falta la descripcion"; }
            if ((o.IdTipoImpuesto ?? 0) == 0) { sErrorMsg += "\n" + "Falta el tipo de impuesto"; }
            if ((o.ActivaNumeracionPorGrupo ?? "") == "") { sErrorMsg += "\n" + "Indique si activa la numeracion por grupo"; }
            if ((o.ActivaNumeracionPorGrupo ?? "") == "SI" && (o.Grupo ?? 0) == 0) { sErrorMsg += "\n" + "Falta el numero de grupo"; }
            
            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(ImpuestosDirecto ImpuestosDirecto)
        {
            if (!PuedeEditar(enumNodos.ImpuestosDirectos)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(ImpuestosDirecto, ref errs))
                {
                    try
                    { Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest; }
                    catch (Exception)
                    { }
                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;

                    string[] words = errs.Split('\n');
                    res.Errors = words.ToList();
                    res.Message = "Hay datos invalidos";

                    return Json(res);
                }

                if (ModelState.IsValid)
                {
                    if (ImpuestosDirecto.IdImpuestoDirecto > 0)
                    {
                        var EntidadOriginal = db.ImpuestosDirectos.Where(p => p.IdImpuestoDirecto == ImpuestosDirecto.IdImpuestoDirecto).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(ImpuestosDirecto);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.ImpuestosDirectos.Add(ImpuestosDirecto);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdImpuestoDirecto = ImpuestosDirecto.IdImpuestoDirecto, ex = "" });
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
            ImpuestosDirecto o = db.ImpuestosDirectos.Find(Id);
            db.ImpuestosDirectos.Remove(o);
            db.SaveChanges();
            return Json(new { Success = 1, IdImpuestoDirecto = Id, ex = "" });
        }

        public virtual ActionResult DeleteConfirmed(int id)
        {
            ImpuestosDirecto o = db.ImpuestosDirectos.Find(id);
            db.ImpuestosDirectos.Remove(o);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.ImpuestosDirectos.AsQueryable();
            //if (_search)
            //{
            //    switch (searchField.ToLower())
            //    {
            //        case "a":
            //            campo = String.Format("{0} = {1}", searchField, searchString);
            //            break;
            //        default:
            //            campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
            //            break;
            //    }
            //}
            //else
            //{
            //    campo = "true";
            //}

            var Entidad1 = (from a in Entidad
                            select new { IdImpuestoDirecto = a.IdImpuestoDirecto }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        from b in db.TiposImpuestoes.Where(o => o.IdTipoImpuesto == a.IdTipoImpuesto).DefaultIfEmpty()
                        from d in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        select new
                        {
                            a.IdImpuestoDirecto,
                            a.IdTipoImpuesto,
                            a.IdCuenta,

                            a.Descripcion,
                            TipoImpuesto = b != null ? b.Descripcion : "",
                            a.Codigo,
                            a.CodigoRegimen,
                            a.Tasa,
                            CuentaContable = d != null ? d.Descripcion : "",
                            a.BaseMinima,
                            a.ProximoNumeroCertificado,
                            a.ActivaNumeracionPorGrupo,
                            a.Grupo,
                            a.TopeAnual,
                            a.ParaInscriptosEnRegistroFiscalOperadoresGranos
                        }).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdImpuestoDirecto.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdImpuestoDirecto} ) + ">Editar</>",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdImpuestoDirecto.ToString(),
                                a.IdTipoImpuesto.ToString(),
                                a.IdCuenta.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.TipoImpuesto.NullSafeToString(),
                                a.Codigo.NullSafeToString(),
                                a.CodigoRegimen.ToString(),
                                a.Tasa.ToString(),
                                a.CuentaContable.NullSafeToString(),
                                a.BaseMinima.ToString(),
                                a.ProximoNumeroCertificado.ToString(),
                                a.ActivaNumeracionPorGrupo.NullSafeToString(),
                                a.Grupo.ToString(),
                                a.TopeAnual.ToString(),
                                a.ParaInscriptosEnRegistroFiscalOperadoresGranos.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
    }
}