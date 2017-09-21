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
    public partial class RubroController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.Rubros
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Rubros.Count() / pageSize);

            return View(Tabla);
        }

        public bool Validar(ProntoMVC.Data.Models.Rubro o, ref string sErrorMsg)
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
                mMaxLength = GetMaxLength<Rubro>(x => x.Descripcion) ?? 0;
                if (o.Descripcion.Length > mMaxLength) { sErrorMsg += "\n" + "El nombre no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.Abreviatura.NullSafeToString() == "")
            {
                //sErrorMsg += "\n" + "Falta la abreviatura";
            }
            else
            {
                mMaxLength = GetMaxLength<Rubro>(x => x.Abreviatura) ?? 0;
                if (o.Abreviatura.Length > mMaxLength) { sErrorMsg += "\n" + "La abreviatura no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if ((o.IdCuenta ?? 0) == 0) { sErrorMsg += "\n" + "Falta la cuenta para ventas"; }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(Rubro Rubro)
        {
            if (!PuedeEditar(enumNodos.Rubros)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(Rubro, ref errs))
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
                    if (Rubro.IdRubro > 0)
                    {
                        var EntidadOriginal = db.Rubros.Where(p => p.IdRubro == Rubro.IdRubro).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Rubro);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Rubros.Add(Rubro);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdRubro = Rubro.IdRubro, ex = "" });
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
            try
            {
                Rubro Rubro = db.Rubros.Find(Id);
                db.Rubros.Remove(Rubro);
                db.SaveChanges();
                return Json(new { Success = 1, IdRubro = Id, ex = "" });
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

        public class Rubros2
        {
            public int IdRubro { get; set; }
            public int? IdTipoOperacion { get; set; }
            public int? IdCuenta { get; set; }
            public int? IdCuentaCompras { get; set; }
            public int? IdCuentaComprasActivo { get; set; }
            public int? IdCuentaCompras1 { get; set; }
            public int? IdCuentaCompras2 { get; set; }
            public int? IdCuentaCompras3 { get; set; }
            public int? IdCuentaCompras4 { get; set; }
            public int? IdCuentaCompras5 { get; set; }
            public int? IdCuentaCompras6 { get; set; }
            public int? IdCuentaCompras7 { get; set; }
            public int? IdCuentaCompras8 { get; set; }
            public int? IdCuentaCompras9 { get; set; }
            public int? IdCuentaCompras10 { get; set; }
            public string Descripcion { get; set; }
            public int? Codigo { get; set; }
            public string Abreviatura { get; set; }
            public string TipoOperacion { get; set; }
            public string CuentaVentas { get; set; }
            public string CuentaCompras { get; set; }
            public string CuentaActivo { get; set; }
            public string CuentaAdicionalCompras1 { get; set; }
            public string CuentaAdicionalCompras2 { get; set; }
            public string CuentaAdicionalCompras3 { get; set; }
            public string CuentaAdicionalCompras4 { get; set; }
            public string CuentaAdicionalCompras5 { get; set; }
            public string CuentaAdicionalCompras6 { get; set; }
            public string CuentaAdicionalCompras7 { get; set; }
            public string CuentaAdicionalCompras8 { get; set; }
            public string CuentaAdicionalCompras9 { get; set; }
            public string CuentaAdicionalCompras10 { get; set; }
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Rubros.AsQueryable();
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
                            select new { IdRubro = a.IdRubro }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        from b in db.TiposOperaciones.Where(o => o.IdTipoOperacion == a.IdTipoOperacion).DefaultIfEmpty()
                        from c in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        from d in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras).DefaultIfEmpty()
                        from e in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaComprasActivo).DefaultIfEmpty()
                        from f in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras1).DefaultIfEmpty()
                        from g in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras2).DefaultIfEmpty()
                        from h in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras3).DefaultIfEmpty()
                        from i in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras4).DefaultIfEmpty()
                        from j in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras5).DefaultIfEmpty()
                        from k in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras6).DefaultIfEmpty()
                        from l in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras7).DefaultIfEmpty()
                        from m in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras8).DefaultIfEmpty()
                        from n in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras9).DefaultIfEmpty()
                        from o in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras10).DefaultIfEmpty()
                        select new
                        {
                            a.IdRubro,
                            a.IdTipoOperacion,
                            a.IdCuenta,
                            a.IdCuentaCompras,
                            a.IdCuentaComprasActivo,
                            a.IdCuentaCompras1,
                            a.IdCuentaCompras2,
                            a.IdCuentaCompras3,
                            a.IdCuentaCompras4,
                            a.IdCuentaCompras5,
                            a.IdCuentaCompras6,
                            a.IdCuentaCompras7,
                            a.IdCuentaCompras8,
                            a.IdCuentaCompras9,
                            a.IdCuentaCompras10,
                            a.Descripcion,
                            a.Codigo,
                            a.Abreviatura,
                            TipoOperacion = b != null ? b.Descripcion : "",
                            CuentaVentas = c != null ? c.Codigo + " " + c.Descripcion : "",
                            CuentaCompras = d != null ? d.Codigo + " " + d.Descripcion : "",
                            CuentaActivo = e != null ? e.Codigo + " " + e.Descripcion : "",
                            CuentaAdicionalCompras1 = f != null ? f.Codigo+" "+f.Descripcion : "",
                            CuentaAdicionalCompras2 = g != null ? g.Codigo + " " + g.Descripcion : "",
                            CuentaAdicionalCompras3 = h != null ? h.Codigo + " " + h.Descripcion : "",
                            CuentaAdicionalCompras4 = i != null ? i.Codigo + " " + i.Descripcion : "",
                            CuentaAdicionalCompras5 = j != null ? j.Codigo + " " + j.Descripcion : "",
                            CuentaAdicionalCompras6 = k != null ? k.Codigo + " " + k.Descripcion : "",
                            CuentaAdicionalCompras7 = l != null ? l.Codigo + " " + l.Descripcion : "",
                            CuentaAdicionalCompras8 = m != null ? m.Codigo + " " + m.Descripcion : "",
                            CuentaAdicionalCompras9 = n != null ? n.Codigo + " " + n.Descripcion : "",
                            CuentaAdicionalCompras10 = o != null ? o.Codigo + " " + o.Descripcion : ""
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
                            id = a.IdRubro.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdRubro.ToString(),
                                a.IdTipoOperacion.ToString(),
                                a.IdCuenta.ToString(),
                                a.IdCuentaCompras.ToString(),
                                a.IdCuentaComprasActivo.ToString(),
                                a.IdCuentaCompras1.ToString(),
                                a.IdCuentaCompras2.ToString(),
                                a.IdCuentaCompras3.ToString(),
                                a.IdCuentaCompras4.ToString(),
                                a.IdCuentaCompras5.ToString(),
                                a.IdCuentaCompras6.ToString(),
                                a.IdCuentaCompras7.ToString(),
                                a.IdCuentaCompras8.ToString(),
                                a.IdCuentaCompras9.ToString(),
                                a.IdCuentaCompras10.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Codigo.ToString(),
                                a.Abreviatura.NullSafeToString(),
                                a.TipoOperacion.NullSafeToString(),
                                a.CuentaVentas.NullSafeToString(),
                                a.CuentaCompras.NullSafeToString(),
                                a.CuentaActivo.NullSafeToString(),
                                a.CuentaAdicionalCompras1.NullSafeToString(),
                                a.CuentaAdicionalCompras2.NullSafeToString(),
                                a.CuentaAdicionalCompras3.NullSafeToString(),
                                a.CuentaAdicionalCompras4.NullSafeToString(),
                                a.CuentaAdicionalCompras5.NullSafeToString(),
                                a.CuentaAdicionalCompras6.NullSafeToString(),
                                a.CuentaAdicionalCompras7.NullSafeToString(),
                                a.CuentaAdicionalCompras8.NullSafeToString(),
                                a.CuentaAdicionalCompras9.NullSafeToString(),
                                a.CuentaAdicionalCompras10.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult Rubros_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.Rubros
                        from b in db.TiposOperaciones.Where(o => o.IdTipoOperacion == a.IdTipoOperacion).DefaultIfEmpty()
                        //from c in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        //from d in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras).DefaultIfEmpty()
                        from e in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaComprasActivo).DefaultIfEmpty()
                        from f in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras1).DefaultIfEmpty()
                        from g in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras2).DefaultIfEmpty()
                        from h in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras3).DefaultIfEmpty()
                        from i in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras4).DefaultIfEmpty()
                        from j in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras5).DefaultIfEmpty()
                        from k in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras6).DefaultIfEmpty()
                        from l in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras7).DefaultIfEmpty()
                        from m in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras8).DefaultIfEmpty()
                        from n in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras9).DefaultIfEmpty()
                        from o in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaCompras10).DefaultIfEmpty()
                        select new Rubros2
                        {
                            IdRubro = a.IdRubro,
                            IdTipoOperacion = a.IdTipoOperacion,
                            IdCuenta = a.IdCuenta,
                            IdCuentaCompras = a.IdCuentaCompras,
                            IdCuentaComprasActivo = a.IdCuentaComprasActivo,
                            IdCuentaCompras1 = a.IdCuentaCompras1,
                            IdCuentaCompras2 = a.IdCuentaCompras2,
                            IdCuentaCompras3 = a.IdCuentaCompras3,
                            IdCuentaCompras4 = a.IdCuentaCompras4,
                            IdCuentaCompras5 = a.IdCuentaCompras5,
                            IdCuentaCompras6 = a.IdCuentaCompras6,
                            IdCuentaCompras7 = a.IdCuentaCompras7,
                            IdCuentaCompras8 = a.IdCuentaCompras8,
                            IdCuentaCompras9 = a.IdCuentaCompras9,
                            IdCuentaCompras10 = a.IdCuentaCompras10,
                            Descripcion = a.Descripcion,
                            Codigo = a.Codigo,
                            Abreviatura = a.Abreviatura,
                            TipoOperacion = b != null ? b.Descripcion : "",
                            CuentaVentas = a.Cuenta.Codigo + " " + a.Cuenta.Descripcion,  // c != null ? c.Codigo + " " + c.Descripcion : "",
                            CuentaCompras = a.Cuenta1.Codigo + " " + a.Cuenta1.Descripcion,  // d != null ? d.Codigo + " " + d.Descripcion : "",
                            CuentaActivo = e != null ? e.Codigo + " " + e.Descripcion : "",
                            CuentaAdicionalCompras1 = f != null ? f.Codigo + " " + f.Descripcion : "",
                            CuentaAdicionalCompras2 = g != null ? g.Codigo + " " + g.Descripcion : "",
                            CuentaAdicionalCompras3 = h != null ? h.Codigo + " " + h.Descripcion : "",
                            CuentaAdicionalCompras4 = i != null ? i.Codigo + " " + i.Descripcion : "",
                            CuentaAdicionalCompras5 = j != null ? j.Codigo + " " + j.Descripcion : "",
                            CuentaAdicionalCompras6 = k != null ? k.Codigo + " " + k.Descripcion : "",
                            CuentaAdicionalCompras7 = l != null ? l.Codigo + " " + l.Descripcion : "",
                            CuentaAdicionalCompras8 = m != null ? m.Codigo + " " + m.Descripcion : "",
                            CuentaAdicionalCompras9 = n != null ? n.Codigo + " " + n.Descripcion : "",
                            CuentaAdicionalCompras10 = o != null ? o.Codigo + " " + o.Descripcion : ""
                        }).OrderBy(sidx + " " + sord).AsQueryable();

            //IQueryable<Rubros2> data2 = data.AsQueryable();
            //List<Rubros2> data3 = data2.ToList();
            
            var pagedQuery = Filters.FiltroGenerico_UsandoStoreOLista<Rubros2>
                                (sidx, sord, page, rows, _search, filters, db, ref totalRecords, data.ToList());
            
            //var pagedQuery = Filters.FiltroGenerico<Data.Models.Rubro>
            //                    ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdRubro.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdRubro.ToString(),
                                a.IdTipoOperacion.ToString(),
                                a.IdCuenta.ToString(),
                                a.IdCuentaCompras.ToString(),
                                a.IdCuentaComprasActivo.ToString(),
                                a.IdCuentaCompras1.ToString(),
                                a.IdCuentaCompras2.ToString(),
                                a.IdCuentaCompras3.ToString(),
                                a.IdCuentaCompras4.ToString(),
                                a.IdCuentaCompras5.ToString(),
                                a.IdCuentaCompras6.ToString(),
                                a.IdCuentaCompras7.ToString(),
                                a.IdCuentaCompras8.ToString(),
                                a.IdCuentaCompras9.ToString(),
                                a.IdCuentaCompras10.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Codigo.ToString(),
                                a.Abreviatura.NullSafeToString(),
                                a.TipoOperacion.NullSafeToString(),
                                a.CuentaVentas.NullSafeToString(),
                                a.CuentaCompras.NullSafeToString(),
                                a.CuentaActivo.NullSafeToString(),
                                a.CuentaAdicionalCompras1.NullSafeToString(),
                                a.CuentaAdicionalCompras2.NullSafeToString(),
                                a.CuentaAdicionalCompras3.NullSafeToString(),
                                a.CuentaAdicionalCompras4.NullSafeToString(),
                                a.CuentaAdicionalCompras5.NullSafeToString(),
                                a.CuentaAdicionalCompras6.NullSafeToString(),
                                a.CuentaAdicionalCompras7.NullSafeToString(),
                                a.CuentaAdicionalCompras8.NullSafeToString(),
                                a.CuentaAdicionalCompras9.NullSafeToString(),
                                a.CuentaAdicionalCompras10.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetRubros()
        {
            Dictionary<int, string> rubro = new Dictionary<int, string>();
            foreach (Rubro u in db.Rubros.OrderBy(x => x.Descripcion).ToList())
                rubro.Add(u.IdRubro, u.Descripcion);

            return PartialView("Select", rubro);
        }

    }
}
