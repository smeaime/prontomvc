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
    public partial class UbicacionController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.Ubicaciones
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Ubicaciones.Count() / pageSize);

            return View(Tabla);
        }

        public bool Validar(ProntoMVC.Data.Models.Ubicacion o, ref string sErrorMsg)
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
                mMaxLength = GetMaxLength<Ubicacion>(x => x.Descripcion) ?? 0;
                if (o.Descripcion.Length > mMaxLength) { sErrorMsg += "\n" + "El nombre no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.Estanteria.NullSafeToString() == "")
            {
                o.Estanteria = "";
            }
            else
            {
                mMaxLength = GetMaxLength<Ubicacion>(x => x.Estanteria) ?? 0;
                if (o.Estanteria.Length > mMaxLength) { sErrorMsg += "\n" + "La estanteria no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.Modulo.NullSafeToString() == "")
            {
                o.Modulo = "";
            }
            else
            {
                mMaxLength = GetMaxLength<Ubicacion>(x => x.Modulo) ?? 0;
                if (o.Modulo.Length > mMaxLength) { sErrorMsg += "\n" + "El modulo no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.Gabeta.NullSafeToString() == "")
            {
                o.Gabeta = "";
            }
            else
            {
                mMaxLength = GetMaxLength<Ubicacion>(x => x.Gabeta) ?? 0;
                if (o.Gabeta.Length > mMaxLength) { sErrorMsg += "\n" + "La gabeta no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if ((o.IdDeposito ?? 0) == 0) { sErrorMsg += "\n" + "Falta el deposito"; }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.Ubicacion Ubicacion)
        {
            if (!PuedeEditar(enumNodos.Ubicaciones)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(Ubicacion, ref errs))
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
                    if (Ubicacion.IdUbicacion > 0)
                    {
                        var EntidadOriginal = db.Ubicaciones.Where(p => p.IdUbicacion == Ubicacion.IdUbicacion).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Ubicacion);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Ubicaciones.Add(Ubicacion);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdUbicacion = Ubicacion.IdUbicacion, ex = "" });
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
                ProntoMVC.Data.Models.Ubicacion Ubicacion = db.Ubicaciones.Find(Id);
                db.Ubicaciones.Remove(Ubicacion);
                db.SaveChanges();
                return Json(new { Success = 1, IdUbicacion = Id, ex = "" });
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

        public class Ubicaciones2
        {
            public int IdUbicacion { get; set; }
            public int? IdDeposito { get; set; }
            public string Descripcion { get; set; }
            public string Estanteria { get; set; }
            public string Modulo { get; set; }
            public string Gabeta { get; set; }
            public string DepositoActual { get; set; }
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Ubicaciones.AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdUbicacion = a.IdUbicacion }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        from b in db.Depositos.Where(o => o.IdDeposito == a.IdDeposito).DefaultIfEmpty()
                        select new
                        {
                            a.IdUbicacion,
                            a.IdDeposito,
                            a.Descripcion,
                            a.Estanteria,
                            a.Modulo,
                            a.Gabeta,
                            DepositoActual = b != null ? b.Descripcion : ""
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
                            id = a.IdUbicacion.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdUbicacion.ToString(),
                                a.IdDeposito.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Estanteria.NullSafeToString(),
                                a.Modulo.NullSafeToString(),
                                a.Gabeta.NullSafeToString(),
                                a.DepositoActual.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult Ubicaciones_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.Ubicaciones
                        from b in db.Depositos.Where(o => o.IdDeposito == a.IdDeposito).DefaultIfEmpty()
                        select new Ubicaciones2
                        {
                            IdUbicacion = a.IdUbicacion,
                            IdDeposito = a.IdDeposito,
                            Descripcion = a.Descripcion,
                            Estanteria = a.Estanteria,
                            Modulo = a.Modulo,
                            Gabeta = a.Gabeta,
                            DepositoActual = b != null ? b.Descripcion : ""
                        }).OrderBy(sidx + " " + sord).AsQueryable();

            //IQueryable<Rubros2> data2 = data.AsQueryable();
            //List<Rubros2> data3 = data2.ToList();

            var pagedQuery = Filters.FiltroGenerico_UsandoStoreOLista<Ubicaciones2>
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
                            id = a.IdUbicacion.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdUbicacion.ToString(),
                                a.IdDeposito.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Estanteria.NullSafeToString(),
                                a.Modulo.NullSafeToString(),
                                a.Gabeta.NullSafeToString(),
                                a.DepositoActual.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetUbicaciones()
        {
            Dictionary<int, string> ubicaciones = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.Ubicacion u in db.Ubicaciones.OrderBy(x => x.Descripcion).ToList())
                ubicaciones.Add(u.IdUbicacion, (u.Deposito.Abreviatura != null ? " " + u.Deposito.Abreviatura : "") + (u.Descripcion != null ? " " + u.Descripcion : "") + (u.Estanteria != null ? " Est.:" + u.Estanteria : "") + (u.Modulo != null ? " Mod.:" + u.Modulo : "") + (u.Gabeta != null ? " Gab.:" + u.Gabeta : ""));

            return PartialView("Select", ubicaciones);
        }

        public virtual ActionResult GetUbicacionesPorObra(int IdObra, int IdDeposito, int IdArticulo, int IdUsuario)
        {
            Dictionary<int, string> ubicaciones = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.Ubicacion u in
                db.Ubicaciones.Where(x =>
                    (x.Deposito.IdObra == IdObra || IdObra <= 0) &&
                    (x.IdDeposito == IdDeposito || IdDeposito <= 0) &&
                    ((db.Empleados.Where(y => y.IdEmpleado == IdUsuario).Select(y => y.PermitirAccesoATodasLasObras).FirstOrDefault() ?? "") == "SI" ||
                     (db.DetalleEmpleadosObras.Where(y => y.IdEmpleado == IdUsuario && y.IdObra == IdObra).Select(y => y.IdObra).FirstOrDefault() ?? 0) > 0 ||
                     IdUsuario <= 0)
                ).OrderBy(x => x.Descripcion).ToList())

                ubicaciones.Add(u.IdUbicacion, (u.Deposito.Abreviatura != null ? " " + u.Deposito.Abreviatura : "") + (u.Descripcion != null ? " " + u.Descripcion : "") + (u.Estanteria != null ? " Est.:" + u.Estanteria : "") + (u.Modulo != null ? " Mod.:" + u.Modulo : "") + (u.Gabeta != null ? " Gab.:" + u.Gabeta : ""));

            return PartialView("Select", ubicaciones);
        }

        public virtual JsonResult GetUbicacionesPorObra2(int IdObra, int IdDeposito, int IdArticulo, int IdUsuario)
        {
            var filtereditems = (from x in db.Ubicaciones
                                 where (x.Deposito.IdObra == IdObra || IdObra <= 0) &&
                                        (x.IdDeposito == IdDeposito || IdDeposito <= 0) &&
                                        ((db.Empleados.Where(y => y.IdEmpleado == IdUsuario).Select(y => y.PermitirAccesoATodasLasObras).FirstOrDefault() ?? "") == "SI" ||
                                         (db.DetalleEmpleadosObras.Where(y => y.IdEmpleado == IdUsuario && y.IdObra == IdObra).Select(y => y.IdObra).FirstOrDefault() ?? 0) > 0 || IdUsuario <= 0)
                                 orderby x.Descripcion
                                 select new
                                 {
                                     id = x.IdUbicacion,
                                     value = (x.Deposito.Abreviatura != null ? " " + x.Deposito.Abreviatura : "") + (x.Descripcion != null ? " " + x.Descripcion : "") + (x.Estanteria != null ? " Est." + x.Estanteria : "") + (x.Modulo != null ? " Mod." + x.Modulo : "") + (x.Gabeta != null ? " Gab." + x.Gabeta : "")
                                 }).ToList();

            //Dictionary<int, string> ubicaciones = new Dictionary<int, string>();
            //foreach (ProntoMVC.Data.Models.Ubicacion u in 
            //    db.Ubicaciones.Where(x => 
            //        (x.Deposito.IdObra == IdObra || IdObra <= 0) && 
            //        (x.IdDeposito == IdDeposito || IdDeposito <= 0) &&
            //        ((db.Empleados.Where(y => y.IdEmpleado == IdUsuario).Select(y => y.PermitirAccesoATodasLasObras).FirstOrDefault() ?? "") == "SI" ||
            //         (db.DetalleEmpleadosObras.Where(y => y.IdEmpleado == IdUsuario && y.IdObra == IdObra).Select(y => y.IdObra).FirstOrDefault() ?? 0) > 0 || 
            //         IdUsuario <= 0)
            //    ).OrderBy(x => x.Descripcion).ToList())

            //    ubicaciones.Add(u.IdUbicacion, (u.Deposito.Abreviatura != null ? " " + u.Deposito.Abreviatura : "") + (u.Descripcion != null ? " " + u.Descripcion : "") + (u.Estanteria != null ? " Est.:" + u.Estanteria : "") + (u.Modulo != null ? " Mod.:" + u.Modulo : "") + (u.Gabeta != null ? " Gab.:" + u.Gabeta : ""));

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }


    }
}
