using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
//using System.Data.Entity.Core.Objects.ObjectQuery; //using System.Data.Objects;
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
    public partial class OrdenTrabajoController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var OrdenesTrabajo = db.OrdenesTrabajoes
                .OrderBy(s => s.NumeroOrdenTrabajo)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Sectores.Count() / pageSize);

            return View(OrdenesTrabajo);
        }

        public bool Validar(ProntoMVC.Data.Models.OrdenesTrabajo o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            Int32 mMaxLength = 0;
            string mProntoIni = "";
            string mExigirCUIT = "";
            Boolean result;

            //if (o.Nombre.NullSafeToString() == "")
            //{
            //    sErrorMsg += "\n" + "Falta el nombre";
            //}
            //else
            //{
            //    mMaxLength = GetMaxLength<OrdenTrabajo>(x => x.Nombre) ?? 0;
            //    if (o.Nombre.Length > mMaxLength) { sErrorMsg += "\n" + "El nombre no puede tener mas de " + mMaxLength + " digitos"; }
            //}

            //if (o.Abreviatura.NullSafeToString() == "")
            //{
            //    sErrorMsg += "\n" + "Falta el abreviatura";
            //}
            //else
            //{
            //    mMaxLength = GetMaxLength<OrdenTrabajo>(x => x.Abreviatura) ?? 0;
            //    if (o.Abreviatura.Length > mMaxLength) { sErrorMsg += "\n" + "El abreviatura no puede tener mas de " + mMaxLength + " digitos"; }
            //}

            //if (o.CodigoAFIP.NullSafeToString() == "")
            //{
            //    sErrorMsg += "\n" + "Falta el Codigo AFIP";
            //}
            //else
            //{
            //    mMaxLength = GetMaxLength<OrdenTrabajo>(x => x.CodigoAFIP) ?? 0;
            //    if (o.CodigoAFIP.Length > mMaxLength) { sErrorMsg += "\n" + "El codigo AFIP no puede tener mas de " + mMaxLength + " digitos"; }
            //}

            //if (o.GeneraImpuestos.NullSafeToString() == "")
            //{
            //    sErrorMsg += "\n" + "Falta el Codigo genera impuestos";
            //}
            //else
            //{
            //    mMaxLength = GetMaxLength<OrdenTrabajo>(x => x.GeneraImpuestos) ?? 0;
            //    if (o.GeneraImpuestos.Length > mMaxLength) { sErrorMsg += "\n" + "El codigo genera impuestos no puede tener mas de " + mMaxLength + " digitos"; }
            //}

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(OrdenesTrabajo OrdenTrabajo)
        {
            if (!PuedeEditar(enumNodos.OrdenesTrabajo)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(OrdenTrabajo, ref errs))
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
                    if (OrdenTrabajo.IdOrdenTrabajo > 0)
                    {
                        var EntidadOriginal = db.OrdenesTrabajoes.Where(p => p.IdOrdenTrabajo == OrdenTrabajo.IdOrdenTrabajo).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(OrdenTrabajo);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.OrdenesTrabajoes.Add(OrdenTrabajo);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdOrdenTrabajo = OrdenTrabajo.IdOrdenTrabajo, ex = "" });
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

        public virtual ActionResult Delete(int id)
        {
            OrdenesTrabajo OrdenTrabajo = db.OrdenesTrabajoes.Find(id);
            return View(OrdenTrabajo);
        }

        // POST: 
        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            OrdenesTrabajo OrdenTrabajo = db.OrdenesTrabajoes.Find(id);
            db.OrdenesTrabajoes.Remove(OrdenTrabajo);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.OrdenesTrabajoes.AsQueryable();
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "nombre":
                        campo = String.Format("{0} = {1}", searchField, searchString);
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

            var Entidad1 = (from a in Entidad
                            select new { IdOrdenTrabajo = a.IdOrdenTrabajo }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdOrdenTrabajo,
                            a.NumeroOrdenTrabajo,
                        }).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdOrdenTrabajo.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Edit",new {id = a.IdOrdenTrabajo}) +">Editar</>  -  <a href="+ Url.Action("Delete",new {id = a.IdOrdenTrabajo}) +">Eliminar</>",
                                a.IdOrdenTrabajo.ToString(),
                                a.NumeroOrdenTrabajo.NullSafeToString(),
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetOrdenesTrabajo(int IdEquipoDestino)
        {
            var ProntoIni = BuscarClaveINI("OTs desde Mantenimiento") ?? "";
            if (ProntoIni == "SI")
            {
                var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));

                var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "ProntoMantenimiento_TX_OTsPorEquipo", IdEquipoDestino);
                IEnumerable<DataRow> Entidad = dt.AsEnumerable();

                var data1 = (from a in Entidad
                        select new
                        {
                            id = a["IdOrdenTrabajo"].ToString(),
                            value = a["Titulo"].ToString()
                        }).ToList();
                return Json(data1, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var data2 = (from a in db.OrdenesTrabajoes
                        select new
                        {
                            id = a.IdOrdenTrabajo.ToString(),
                            value = a.NumeroOrdenTrabajo.ToString()
                        }).ToList();
                return Json(data2, JsonRequestBehavior.AllowGet);
            }
        }

        class DatosJson
        {
            public string campo1 { get; set; }
            public string campo2 { get; set; }
            public string campo3 { get; set; }
            public string campo4 { get; set; }
            public string campo5 { get; set; }
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}
