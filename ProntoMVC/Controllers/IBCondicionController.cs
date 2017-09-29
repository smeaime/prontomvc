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
    public partial class IBCondicionController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.IBCondiciones
                .OrderBy(s => s.IdIBCondicion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.IBCondiciones.Count() / pageSize);

            return View(Tabla);
        }

        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.IBCondiciones)) throw new Exception("No tenés permisos");
            IBCondicion o;
            if (id <= 0)
            {
                o = new IBCondicion();
            }
            else
            {
                o = db.IBCondiciones.SingleOrDefault(x => x.IdIBCondicion == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        void CargarViewBag(IBCondicion o)
        {
            ViewBag.IdProvincia = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvincia);
            ViewBag.IdProvinciaReal = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvinciaReal);
            ViewBag.IdCuentaPercepcionIIBB = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuentaPercepcionIIBB);
            ViewBag.IdCuentaPercepcionIIBBConvenio = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuentaPercepcionIIBBConvenio);
            ViewBag.IdCuentaPercepcionIIBBCompras = new SelectList(db.Cuentas, "IdCuenta", "Descripcion", o.IdCuentaPercepcionIIBBCompras);
        }

        public bool Validar(ProntoMVC.Data.Models.IBCondicion o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            string mProntoIni = "";
            Boolean result;

            if ((o.Descripcion ?? "") == "") { sErrorMsg += "\n" + "Falta la descripcion"; }
            if ((o.IdProvincia ?? 0) == 0) { sErrorMsg += "\n" + "Falta la provincia contable"; }
            if ((o.IdProvinciaReal ?? 0) == 0) { sErrorMsg += "\n" + "Falta la provincia real"; }
            if ((o.FechaVigencia ?? DateTime.MinValue) == DateTime.MinValue) { sErrorMsg += "\n" + "Falta la fecha de vigencia"; }
            if ((o.AcumulaMensualmente ?? "") == "") { sErrorMsg += "\n" + "Indique si el calculo es mensual"; }
            if ((o.BaseCalculo ?? "") == "") { sErrorMsg += "\n" + "Indique la base de calculo a tomar"; }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(IBCondicion IBCondicion)
        {
            if (!PuedeEditar(enumNodos.IBCondiciones)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(IBCondicion, ref errs))
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
                    if (IBCondicion.IdIBCondicion > 0)
                    {
                        var EntidadOriginal = db.IBCondiciones.Where(p => p.IdIBCondicion == IBCondicion.IdIBCondicion).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(IBCondicion);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.IBCondiciones.Add(IBCondicion);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdIBCondicion = IBCondicion.IdIBCondicion, ex = "" });
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
            IBCondicion o = db.IBCondiciones.Find(Id);
            db.IBCondiciones.Remove(o);
            db.SaveChanges();
            return Json(new { Success = 1, IdIBCondicion = Id, ex = "" });
        }

        public virtual ActionResult DeleteConfirmed(int id)
        {
            IBCondicion o = db.IBCondiciones.Find(id);
            db.IBCondiciones.Remove(o);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.IBCondiciones.AsQueryable();
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
                            select new { IdIBCondicion = a.IdIBCondicion }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        from b in db.Provincias.Where(o => o.IdProvincia == a.IdProvincia).DefaultIfEmpty()
                        from c in db.Provincias.Where(o => o.IdProvincia == a.IdProvinciaReal).DefaultIfEmpty()
                        from d in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaPercepcionIIBB).DefaultIfEmpty()
                        from e in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaPercepcionIIBBConvenio).DefaultIfEmpty()
                        from f in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaPercepcionIIBBCompras).DefaultIfEmpty()
                        select new
                        {
                            a.IdIBCondicion,
                            a.IdProvincia,
                            a.IdProvinciaReal,
                            a.IdCuentaPercepcionIIBB,
                            a.IdCuentaPercepcionIIBBConvenio,
                            a.IdCuentaPercepcionIIBBCompras,

                            a.Descripcion,
                            ProvinciaContable = b != null ? b.Nombre : "",
                            ProvinciaReal = c != null ? c.Nombre : "",
                            a.FechaVigencia,
                            a.Codigo,
                            a.CodigoActividad,
                            a.CodigoAFIP,
                            a.InformacionAuxiliar,
                            a.CodigoArticuloInciso,

                            a.ImporteTopeMinimo,
                            a.Alicuota,
                            a.PorcentajeATomarSobreBase,
                            a.PorcentajeAdicional,
                            a.LeyendaPorcentajeAdicional,
                            a.CodigoNormaRetencion,

                            a.ImporteTopeMinimoPercepcion,
                            a.AlicuotaPercepcion,
                            PercepcionCuentaNormal = d != null ? d.Descripcion : "",
                            a.AlicuotaPercepcionConvenio,
                            PercepcionCuentaConvenio = e != null ? e.Descripcion : "",
                            PercepcionCuentaCompras = f != null ? f.Descripcion : "",
                            a.CodigoNormaPercepcion,

                            a.AcumulaMensualmente,
                            a.BaseCalculo
                        }).Where(campo).OrderBy(sidx + " " + sord)
                        .Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdIBCondicion.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdIBCondicion} ) + ">Editar</>",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdIBCondicion.ToString(),
                                a.IdProvincia.ToString(),
                                a.IdProvinciaReal.ToString(),
                                a.IdCuentaPercepcionIIBB.ToString(),
                                a.IdCuentaPercepcionIIBBConvenio.ToString(),
                                a.IdCuentaPercepcionIIBBCompras.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.ProvinciaContable.NullSafeToString(),
                                a.ProvinciaReal.NullSafeToString(),
                                a.FechaVigencia == null ? "" : a.FechaVigencia.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Codigo.ToString(),
                                a.CodigoActividad.ToString(),
                                a.CodigoAFIP.ToString(),
                                a.InformacionAuxiliar.NullSafeToString(),
                                a.CodigoArticuloInciso.NullSafeToString(),
                                a.ImporteTopeMinimo.ToString(),
                                a.Alicuota.ToString(),
                                a.PorcentajeATomarSobreBase.ToString(),
                                a.PorcentajeAdicional.ToString(),
                                a.LeyendaPorcentajeAdicional.NullSafeToString(),
                                a.CodigoNormaRetencion.ToString(),
                                a.ImporteTopeMinimoPercepcion.ToString(),
                                a.AlicuotaPercepcion.ToString(),
                                a.PercepcionCuentaNormal.NullSafeToString(),
                                a.AlicuotaPercepcionConvenio.ToString(),
                                a.PercepcionCuentaConvenio.NullSafeToString(),
                                a.PercepcionCuentaCompras.NullSafeToString(),
                                a.CodigoNormaPercepcion.ToString(),
                                a.AcumulaMensualmente.NullSafeToString(),
                                a.BaseCalculo.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetTiposArchivoExportado2()
        {
            Dictionary<int, string> TiposArchivoExportado = new Dictionary<int, string>();
            TiposArchivoExportado.Add(1, "SIFERE");
            TiposArchivoExportado.Add(2, "e-SICOL");

            return PartialView("Select", TiposArchivoExportado);
        }

        public virtual JsonResult GetTiposArchivoExportado()
        {
            var jsonData = new {items = new[] {new {value = "1" , title = "SIFERE"}, new {value = "2" , title = "e-SICOL"}}};

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

    }
}