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
    public partial class ProvinciaController : ProntoBaseController
    {
       [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.Provincias
                .OrderBy(s => s.IdProvincia)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Provincias.Count() / pageSize);

            return View(Tabla);
        }

        public virtual ActionResult Edit(int id)
       {
           if (!PuedeLeer(enumNodos.Provincias)) throw new Exception("No tenés permisos");
            Provincia o;
            if (id <= 0)
            {
                o = new Provincia();
            }
            else
            {
                o = db.Provincias.SingleOrDefault(x => x.IdProvincia == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        void CargarViewBag(Provincia o)
        {
            ViewBag.IdPais = new SelectList(db.Paises, "IdPais", "Descripcion", o.IdPais);
            ViewBag.IdCuentaRetencionIBrutos = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuentaRetencionIBrutos);
            ViewBag.IdCuentaPercepcionIBrutos = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuentaPercepcionIBrutos);
            ViewBag.IdCuentaRetencionIBrutosCobranzas = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuentaRetencionIBrutosCobranzas);
            ViewBag.IdCuentaPercepcionIIBBConvenio = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuentaPercepcionIIBBConvenio);
            ViewBag.IdCuentaPercepcionIIBBCompras = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuentaPercepcionIIBBCompras);
            ViewBag.IdCuentaSIRCREB = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuentaSIRCREB);
            ViewBag.IdCuentaPercepcionIIBBComprasJurisdiccionLocal = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuentaPercepcionIIBBComprasJurisdiccionLocal);
        }

        public bool Validar(ProntoMVC.Data.Models.Provincia o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            Int32 mMaxLength = 0;
            string mProntoIni = "";
            Boolean result;


            if (o.Nombre.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta el nombre";
            }
            else
            {
                mMaxLength = GetMaxLength<Provincia>(x => x.Nombre) ?? 0;
                if (o.Nombre.Length > mMaxLength) { sErrorMsg += "\n" + "El nombre no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if ((o.IdPais ?? 0) == 0) { sErrorMsg += "\n" + "Falta el pais"; }

            if (o.Codigo.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta el codigo";
            }
            else
            {
                mMaxLength = GetMaxLength<Provincia>(x => x.Codigo) ?? 0;
                if (o.Codigo.Length > mMaxLength) { sErrorMsg += "\n" + "El codigo no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.InformacionAuxiliar.NullSafeToString() != "")
            {
                mMaxLength = GetMaxLength<Provincia>(x => x.InformacionAuxiliar) ?? 0;
                if (o.InformacionAuxiliar.Length > mMaxLength) { sErrorMsg += "\n" + "El codigo de jurisdiccion no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.PlantillaRetencionIIBB.NullSafeToString() != "")
            {
                mMaxLength = GetMaxLength<Provincia>(x => x.PlantillaRetencionIIBB) ?? 0;
                if (o.PlantillaRetencionIIBB.Length > mMaxLength) { sErrorMsg += "\n" + "La plantilla para retencion IIBB no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.CodigoESRI_1.NullSafeToString() != "")
            {
                mMaxLength = GetMaxLength<Provincia>(x => x.CodigoESRI_1) ?? 0;
                if (o.CodigoESRI_1.Length > mMaxLength) { sErrorMsg += "\n" + "El codigo ESRI no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(Provincia Provincia)
        {
            if (!PuedeEditar(enumNodos.Provincias)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(Provincia, ref errs))
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
                    if (Provincia.IdProvincia > 0)
                    {
                        var EntidadOriginal = db.Provincias.Where(p => p.IdProvincia == Provincia.IdProvincia).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Provincia);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Provincias.Add(Provincia);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdProvincia = Provincia.IdProvincia, ex = "" });
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
            Provincia o = db.Provincias.Find(Id);
            db.Provincias.Remove(o);
            db.SaveChanges();
            return Json(new { Success = 1, IdProvincia = Id, ex = "" });
        }

        public virtual ActionResult DeleteConfirmed(int id)
        {
            Provincia o = db.Provincias.Find(id);
            db.Provincias.Remove(o);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Provincias.AsQueryable();
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
                            select new { IdProvincia = a.IdProvincia }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        from b in db.Paises.Where(o => o.IdPais == a.IdPais).DefaultIfEmpty()
                        from c in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaRetencionIBrutos).DefaultIfEmpty()
                        from d in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaPercepcionIBrutos).DefaultIfEmpty()
                        from e in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaPercepcionIIBBConvenio).DefaultIfEmpty()
                        from f in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaRetencionIBrutosCobranzas).DefaultIfEmpty()
                        from g in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaPercepcionIIBBCompras).DefaultIfEmpty()
                        from h in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaPercepcionIIBBComprasJurisdiccionLocal).DefaultIfEmpty()
                        select new
                        {
                            a.IdProvincia,
                            a.IdPais,
                            a.IdCuentaRetencionIBrutos,
                            a.IdCuentaPercepcionIBrutos,
                            a.IdCuentaPercepcionIIBBConvenio,
                            a.IdCuentaRetencionIBrutosCobranzas,
                            a.IdCuentaPercepcionIIBBCompras,
                            a.IdCuentaPercepcionIIBBComprasJurisdiccionLocal,
                            a.Nombre,
                            a.Codigo,
                            Pais = b != null ? b.Descripcion : "",
                            a.ProximoNumeroCertificadoRetencionIIBB,
                            a.ProximoNumeroCertificadoPercepcionIIBB,
                            CuentaRetencionIIBB = c != null ? c.Descripcion : "",
                            CuentaPercepcionIIBB = d != null ? d.Descripcion : "",
                            CuentaPercepcionIIBBConvenio = e != null ? e.Descripcion : "",
                            CuentaRetencionIIBBCobranzas = f != null ? f.Descripcion : "",
                            CuentaPercepcionIIBBConvenioCompras = g != null ? g.Descripcion : "",
                            CuentaPercepcionIIBBCompras = h != null ? h.Descripcion : "",
                            a.EsAgenteRetencionIIBB,
                            a.CodigoESRI_1,
                            a.Codigo2,
                            a.InformacionAuxiliar
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
                            id = a.IdProvincia.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdProvincia} ) + ">Editar</>",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdProvincia.ToString(),
                                a.IdPais.ToString(),
                                a.IdCuentaRetencionIBrutos.ToString(),
                                a.IdCuentaPercepcionIBrutos.ToString(),
                                a.IdCuentaPercepcionIIBBConvenio.ToString(),
                                a.IdCuentaRetencionIBrutosCobranzas.ToString(),
                                a.IdCuentaPercepcionIIBBCompras.ToString(),
                                a.IdCuentaPercepcionIIBBComprasJurisdiccionLocal.ToString(),
                                a.Nombre.NullSafeToString(),
                                a.Codigo.NullSafeToString(),
                                a.Pais.NullSafeToString(),
                                a.ProximoNumeroCertificadoRetencionIIBB.ToString(),
                                a.ProximoNumeroCertificadoPercepcionIIBB.ToString(),
                                a.CuentaRetencionIIBB.NullSafeToString(),
                                a.CuentaPercepcionIIBB.NullSafeToString(),
                                a.CuentaPercepcionIIBBConvenio.NullSafeToString(),
                                a.CuentaRetencionIIBBCobranzas.NullSafeToString(),
                                a.CuentaPercepcionIIBBConvenioCompras.NullSafeToString(),
                                a.CuentaPercepcionIIBBCompras.NullSafeToString(),
                                a.EsAgenteRetencionIIBB.NullSafeToString(),
                                a.CodigoESRI_1.NullSafeToString(),
                                a.Codigo2.ToString(),
                                a.InformacionAuxiliar.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult Provincias_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.Provincia>
                                ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            // esto filtro se debería aplicar antes que el filtrogenerico (queda mal paginado si no)
            var Entidad = pagedQuery.AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdProvincia = a.IdProvincia }).ToList();

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        from b in db.Paises.Where(o => o.IdPais == a.IdPais).DefaultIfEmpty()
                        from c in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaRetencionIBrutos).DefaultIfEmpty()
                        from d in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaPercepcionIBrutos).DefaultIfEmpty()
                        from e in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaPercepcionIIBBConvenio).DefaultIfEmpty()
                        from f in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaRetencionIBrutosCobranzas).DefaultIfEmpty()
                        from g in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaPercepcionIIBBCompras).DefaultIfEmpty()
                        from h in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaPercepcionIIBBComprasJurisdiccionLocal).DefaultIfEmpty()
                        select new
                        {
                            a.IdProvincia,
                            a.IdPais,
                            a.IdCuentaRetencionIBrutos,
                            a.IdCuentaPercepcionIBrutos,
                            a.IdCuentaPercepcionIIBBConvenio,
                            a.IdCuentaRetencionIBrutosCobranzas,
                            a.IdCuentaPercepcionIIBBCompras,
                            a.IdCuentaPercepcionIIBBComprasJurisdiccionLocal,
                            a.Nombre,
                            a.Codigo,
                            Pais = a.Pais.Descripcion, // b != null ? b.Descripcion : "",
                            a.ProximoNumeroCertificadoRetencionIIBB,
                            a.ProximoNumeroCertificadoPercepcionIIBB,
                            CuentaRetencionIIBB = c != null ? c.Descripcion : "",
                            CuentaPercepcionIIBB = d != null ? d.Descripcion : "",
                            CuentaPercepcionIIBBConvenio = e != null ? e.Descripcion : "",
                            CuentaRetencionIIBBCobranzas = f != null ? f.Descripcion : "",
                            CuentaPercepcionIIBBConvenioCompras = g != null ? g.Descripcion : "",
                            CuentaPercepcionIIBBCompras = h != null ? h.Descripcion : "",
                            a.EsAgenteRetencionIIBB,
                            a.CodigoESRI_1,
                            a.Codigo2,
                            a.InformacionAuxiliar
                        }).OrderBy(sidx + " " + sord).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdProvincia.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdProvincia} ) + ">Editar</>",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdProvincia.ToString(),
                                a.IdPais.ToString(),
                                a.IdCuentaRetencionIBrutos.ToString(),
                                a.IdCuentaPercepcionIBrutos.ToString(),
                                a.IdCuentaPercepcionIIBBConvenio.ToString(),
                                a.IdCuentaRetencionIBrutosCobranzas.ToString(),
                                a.IdCuentaPercepcionIIBBCompras.ToString(),
                                a.IdCuentaPercepcionIIBBComprasJurisdiccionLocal.ToString(),
                                a.Nombre.NullSafeToString(),
                                a.Codigo.NullSafeToString(),
                                a.Pais.NullSafeToString(),
                                a.ProximoNumeroCertificadoRetencionIIBB.ToString(),
                                a.ProximoNumeroCertificadoPercepcionIIBB.ToString(),
                                a.CuentaRetencionIIBB.NullSafeToString(),
                                a.CuentaPercepcionIIBB.NullSafeToString(),
                                a.CuentaPercepcionIIBBConvenio.NullSafeToString(),
                                a.CuentaRetencionIIBBCobranzas.NullSafeToString(),
                                a.CuentaPercepcionIIBBConvenioCompras.NullSafeToString(),
                                a.CuentaPercepcionIIBBCompras.NullSafeToString(),
                                a.EsAgenteRetencionIIBB.NullSafeToString(),
                                a.CodigoESRI_1.NullSafeToString(),
                                a.Codigo2.ToString(),
                                a.InformacionAuxiliar.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetProvincias()
        {
            Dictionary<int, string> provincias = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.Provincia u in db.Provincias.OrderBy(x => x.Nombre).ToList())
                provincias.Add(u.IdProvincia, u.Nombre);

            return PartialView("Select", provincias);
        }
    }
}

