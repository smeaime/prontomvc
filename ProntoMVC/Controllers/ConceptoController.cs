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
    public partial class ConceptoController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.Conceptos
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.PuntosVentas.Count() / pageSize);

            return View(Tabla);
        }

        [HttpGet]
        public virtual ActionResult IndexOP(int page = 1)
        {
            var Tabla = db.Conceptos
                .Where(s => (s.Grupo ?? 0) != 0)
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.PuntosVentas.Count() / pageSize);

            return View(Tabla);
        }

        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.Conceptos)) throw new Exception("No tenés permisos");
            Concepto o;
            if (id <= 0)
            {
                o = new Concepto();
            }
            else
            {
                o = db.Conceptos.SingleOrDefault(x => x.IdConcepto == id);
            }
            return View(o);
        }

        public bool Validar(ProntoMVC.Data.Models.Concepto o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            string mProntoIni = "";
            Boolean result;

            if ((o.Descripcion ?? "") == "") { sErrorMsg += "\n" + "Falta la descripcion"; }
            if ((o.GravadoDefault ?? "") == "") { sErrorMsg += "\n" + "Indique si el concepto esta gravado por default"; }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(Concepto Concepto)
        {
            if (!PuedeEditar(enumNodos.Conceptos)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(Concepto, ref errs))
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
                    if (Concepto.IdConcepto > 0)
                    {
                        var EntidadOriginal = db.Conceptos.Where(p => p.IdConcepto == Concepto.IdConcepto).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Concepto);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Conceptos.Add(Concepto);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdConcepto = Concepto.IdConcepto, ex = "" });
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
            Concepto o = db.Conceptos.Find(Id);
            db.Conceptos.Remove(o);
            db.SaveChanges();
            return Json(new { Success = 1, IdConcepto = Id, ex = "" });
        }

        public virtual ActionResult DeleteConfirmed(int id)
        {
            Concepto o = db.Conceptos.Find(id);
            db.Conceptos.Remove(o);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string congrupo)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Conceptos.Where(s => (congrupo == "SI" && (s.Grupo ?? 0) != 0) || (congrupo != "SI" && (s.Grupo ?? 0) == 0)).AsQueryable();
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
                            select new { IdConcepto = a.IdConcepto }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdConcepto,
                            a.IdCuenta,
                            a.Grupo,
                            a.Descripcion,
                            Cuenta = a.Cuenta.Descripcion,
                            a.ValorRechazado,
                            a.CodigoConcepto,
                            a.GravadoDefault,
                            a.CodigoAFIP,
                            a.CoeficienteAuxiliar_1,
                            a.GeneraComision,
                            TiposConcepto = ((a.Grupo ?? 0) == 1 ? "Otros conceptos para OP" : ((a.Grupo ?? 0) == 2 ? "Clasificacion por tipo de cancelacion" : ((a.Grupo ?? 0) == 3 ? "Modalidades de pago" : ((a.Grupo ?? 0) == 4 ? "Enviar a" : ((a.Grupo ?? 0) == 5 ? "Textos auxiliares para OP" : "")))))
                        }).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdConcepto.ToString(),
                            cell = new string[] { 
                                congrupo == "SI" ? "" : "<a href="+ Url.Action("Edit",new {id = a.IdConcepto} ) + ">Editar</>", 
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdConcepto.ToString(),
                                a.IdCuenta.ToString(),
                                a.Grupo.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Cuenta.NullSafeToString(),
                                a.ValorRechazado.NullSafeToString(),
                                a.CodigoConcepto.ToString(),
                                a.GravadoDefault.NullSafeToString(),
                                a.CodigoAFIP.NullSafeToString(),
                                a.CoeficienteAuxiliar_1.ToString(),
                                a.GeneraComision.NullSafeToString(),
                                a.TiposConcepto.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetTiposGrupoConcepto()
        {
            Dictionary<int, string> tiposconcepto = new Dictionary<int, string>();
            tiposconcepto.Add(1, "Otros conceptos para OP");
            tiposconcepto.Add(2, "Clasificacion por tipo de cancelacion");
            tiposconcepto.Add(3, "Modalidades de pago");
            tiposconcepto.Add(4, "Enviar a");
            tiposconcepto.Add(5, "Textos auxiliares para OP");

            return PartialView("Select", tiposconcepto);
        }

    }
}