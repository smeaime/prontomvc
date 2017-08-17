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
using Newtonsoft.Json;

namespace ProntoMVC.Controllers
{
    public partial class MonedaController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Monedas = db.Monedas
                .OrderBy(s => s.Nombre)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Sectores.Count() / pageSize);

            return View(Monedas);
        }

        public bool Validar(ProntoMVC.Data.Models.Moneda o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            Int32 mMaxLength = 0;
            string mProntoIni = "";
            string mExigirCUIT = "";
            Boolean result;

            if (o.Nombre.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta el nombre";
            }
            else
            {
                mMaxLength = GetMaxLength<Moneda>(x => x.Nombre) ?? 0;
                if (o.Nombre.Length > mMaxLength) { sErrorMsg += "\n" + "El nombre no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.Abreviatura.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta el abreviatura";
            }
            else
            {
                mMaxLength = GetMaxLength<Moneda>(x => x.Abreviatura) ?? 0;
                if (o.Abreviatura.Length > mMaxLength) { sErrorMsg += "\n" + "El abreviatura no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.CodigoAFIP.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta el Codigo AFIP";
            }
            else
            {
                mMaxLength = GetMaxLength<Moneda>(x => x.CodigoAFIP) ?? 0;
                if (o.CodigoAFIP.Length > mMaxLength) { sErrorMsg += "\n" + "El codigo AFIP no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.GeneraImpuestos.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta el Codigo genera impuestos";
            }
            else
            {
                mMaxLength = GetMaxLength<Moneda>(x => x.GeneraImpuestos) ?? 0;
                if (o.GeneraImpuestos.Length > mMaxLength) { sErrorMsg += "\n" + "El codigo genera impuestos no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(Moneda Moneda)
        {
            if (!PuedeEditar(enumNodos.Monedas)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(Moneda, ref errs))
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
                    if (Moneda.IdMoneda > 0)
                    {
                        var EntidadOriginal = db.Monedas.Where(p => p.IdMoneda == Moneda.IdMoneda).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Moneda);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Monedas.Add(Moneda);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdMoneda = Moneda.IdMoneda, ex = "" });
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
            Moneda Moneda = db.Monedas.Find(id);
            return View(Moneda);
        }

        // POST: 
        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Moneda Moneda = db.Monedas.Find(id);
            db.Monedas.Remove(Moneda);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Monedas.AsQueryable();
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
                            select new { IdMoneda = a.IdMoneda }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdMoneda,
                            a.Nombre,
                            a.Abreviatura,
                            a.CodigoAFIP,
                            a.GeneraImpuestos
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
                            id = a.IdMoneda.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Edit",new {id = a.IdMoneda}) +">Editar</>  -  <a href="+ Url.Action("Delete",new {id = a.IdMoneda}) +">Eliminar</>",
                                a.IdMoneda.ToString(),
                                a.Nombre.NullSafeToString(),
                                a.Abreviatura.ToString(),
                                a.CodigoAFIP.NullSafeToString(),
                                a.GeneraImpuestos.NullSafeToString(),
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


    

        public virtual JsonResult Moneda_Cotizacion(DateTime? fecha, int IdMoneda)
        {
            //if (db == null) return null;
            //if (fecha == null) fecha = DateTime.Now;

            decimal? cotizacion;

            //DateTime desde = fecha.Value.Date;
            //DateTime hasta = desde.AddDays(1);

            //var mvarCotizacion = db.Cotizaciones.Where(x => x.Fecha >= desde && x.Fecha <= hasta && x.IdMoneda == IdMoneda).FirstOrDefault();
            //if (mvarCotizacion == null) cotizacion = -1; else cotizacion = (mvarCotizacion.CotizacionLibre ?? mvarCotizacion.Cotizacion) ?? -1;

            cotizacion = funcMoneda_Cotizacion(fecha, IdMoneda);

            return Json(cotizacion, JsonRequestBehavior.AllowGet);
        }



        public virtual JsonResult CotizacionesPorFecha(string fecha)
        {
            DateTime fecha1;
            if (db == null) return null;
            fecha1 = Convert.ToDateTime(fecha);

            decimal mCotizacionDolar = 0;
            decimal mCotizacionEuro = 0;

            Int32 mIdMonedaPrincipal;
            Int32 mIdMonedaDolar;
            Int32 mIdMonedaEuro;

            //DateTime desde = fecha1;
            //DateTime hasta = desde.AddDays(1);

            Parametros parametros = db.Parametros.Find(1);
            mIdMonedaPrincipal = parametros.IdMonedaPrincipal ?? 0;
            mIdMonedaDolar = parametros.IdMonedaDolar ?? 0;
            mIdMonedaEuro = parametros.IdMonedaEuro ?? 0;

            //var Cotizacion = db.Cotizaciones.Where(x => x.Fecha >= desde && x.Fecha <= hasta && x.IdMoneda == mIdMonedaDolar).FirstOrDefault();
            var Cotizacion = db.Cotizaciones.Where(x => x.Fecha == fecha1 && x.IdMoneda == mIdMonedaDolar).FirstOrDefault();
            if (Cotizacion != null) { mCotizacionDolar = (Cotizacion.CotizacionLibre ?? Cotizacion.Cotizacion) ?? 0; }

            //Cotizacion = db.Cotizaciones.Where(x => x.Fecha >= desde && x.Fecha <= hasta && x.IdMoneda == mIdMonedaEuro).FirstOrDefault();
            Cotizacion = db.Cotizaciones.Where(x => x.Fecha == fecha1 && x.IdMoneda == mIdMonedaEuro).FirstOrDefault();
            if (Cotizacion != null) { mCotizacionEuro = (Cotizacion.CotizacionLibre ?? Cotizacion.Cotizacion) ?? 0; }

            DatosJson data = new DatosJson();
            data.campo1 = mIdMonedaPrincipal.ToString();
            data.campo2 = mIdMonedaDolar.ToString();
            data.campo3 = mCotizacionDolar.ToString();
            data.campo4 = mIdMonedaEuro.ToString();
            data.campo5 = mCotizacionEuro.ToString();

            return Json(JsonConvert.SerializeObject(data), JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetMonedas()
        {
            Dictionary<int, string> monedas = new Dictionary<int, string>();
            foreach (Moneda u in db.Monedas.OrderBy(x => x.Nombre).ToList())
                monedas.Add(u.IdMoneda, u.Nombre);

            return PartialView("Select", monedas);
        }

        public virtual ActionResult GetMonedas2()
        {
            Dictionary<int, string> monedas = new Dictionary<int, string>();
            foreach (Moneda u in db.Monedas.OrderBy(x => x.Nombre).ToList())
                monedas.Add(u.IdMoneda, u.Abreviatura);

            return PartialView("Select", monedas);
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
