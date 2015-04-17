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
    public partial class CondicionVentaController : ProntoBaseController
    {

        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var CondicionVentas = db.Condiciones_Compras
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Condiciones_Compras.Count() / pageSize);

            return View(CondicionVentas);
        }

        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.CondicionesCompra)) throw new Exception("No tenés permisos");
            Condiciones_Compra o;
            if (id <= 0)
            {
                o = new Condiciones_Compra();
            }
            else
            {
                o = db.Condiciones_Compras.SingleOrDefault(x => x.IdCondicionCompra == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        void CargarViewBag(Condiciones_Compra o)
        {
            //ViewBag.IdProvincia = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvincia);
        }

        public bool Validar(ProntoMVC.Data.Models.Condiciones_Compra o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            string mProntoIni = "";
            Boolean result;

            if ((o.Descripcion ?? "") == "") { sErrorMsg += "\n" + "Falta la descripcion"; }
            if ((o.Porcentaje1 ?? 0) + (o.Porcentaje2 ?? 0) + (o.Porcentaje3 ?? 0) + (o.Porcentaje4 ?? 0) + (o.Porcentaje5 ?? 0) + (o.Porcentaje6 ?? 0) +
                (o.Porcentaje7 ?? 0) + (o.Porcentaje8 ?? 0) + (o.Porcentaje9 ?? 0) + (o.Porcentaje10 ?? 0) + (o.Porcentaje11 ?? 0) + (o.Porcentaje12 ?? 0) != 100)
                { sErrorMsg += "\n" + "La suma de los porcentajes debe ser 100"; }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(Condiciones_Compra CondicionCompra)
        {
            if (!PuedeEditar(enumNodos.CondicionesCompra)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(CondicionCompra, ref errs))
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
                    if (CondicionCompra.IdCondicionCompra > 0)
                    {
                        var EntidadOriginal = db.Condiciones_Compras.Where(p => p.IdCondicionCompra == CondicionCompra.IdCondicionCompra).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(CondicionCompra);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Condiciones_Compras.Add(CondicionCompra);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdCondicionCompra = CondicionCompra.IdCondicionCompra, ex = "" });
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
            Condiciones_Compra o = db.Condiciones_Compras.Find(Id);
            db.Condiciones_Compras.Remove(o);
            db.SaveChanges();
            return Json(new { Success = 1, IdCondicionCompra = Id, ex = "" });
        }

        public virtual ActionResult DeleteConfirmed(int id)
        {
            Condiciones_Compra o = db.Condiciones_Compras.Find(id);
            db.Condiciones_Compras.Remove(o);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        
        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Condiciones_Compras.AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdCondicionCompra = a.IdCondicionCompra }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select a).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdCondicionCompra.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdCondicionCompra} ) + ">Editar</>",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdCondicionCompra} )  +">Imprimir</>" ,
                                a.IdCondicionCompra.ToString(),
                                (a.CodigoCondicion ?? string.Empty) .ToString(),
                                (a.Descripcion ?? string.Empty).NullSafeToString(),
                                (a.CantidadDias1 ?? 0).ToString(),(a.Porcentaje1 ?? 0).ToString(),
                                (a.CantidadDias2 ?? 0).ToString(),(a.Porcentaje2 ?? 0).ToString(),
                                (a.CantidadDias3 ?? 0).ToString(),(a.Porcentaje3 ?? 0).ToString(),
                                (a.CantidadDias4 ?? 0).ToString(),(a.Porcentaje4 ?? 0).ToString(),
                                (a.CantidadDias5 ?? 0).ToString(),(a.Porcentaje5 ?? 0).ToString(),
                                (a.CantidadDias6 ?? 0).ToString(),(a.Porcentaje6 ?? 0).ToString(),
                                (a.CantidadDias7 ?? 0).ToString(),(a.Porcentaje7 ?? 0).ToString(),
                                (a.CantidadDias8 ?? 0).ToString(),(a.Porcentaje8 ?? 0).ToString(),
                                (a.CantidadDias9 ?? 0).ToString(),(a.Porcentaje9 ?? 0).ToString(),
                                (a.CantidadDias10 ?? 0).ToString(),(a.Porcentaje10 ?? 0).ToString(),
                                (a.CantidadDias11 ?? 0).ToString(),(a.Porcentaje11 ?? 0).ToString(),
                                (a.CantidadDias12 ?? 0).ToString(),(a.Porcentaje12 ?? 0).ToString(),
                                a.PorcentajeBonificacion.ToString(),
                                a.ContraEntregaDeValores.NullSafeToString(),
                                (a.Observaciones ?? string.Empty).NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCondicionVenta(int IdCondicionCompra = 0)
        {
            var filtereditems = (from a in db.Condiciones_Compras
                                 where ((IdCondicionCompra <= 0 || a.IdCondicionCompra == IdCondicionCompra))
                                 select new
                                 {
                                     IdCondicionCompra = a.IdCondicionCompra,
                                     Descripcion = a.Descripcion,
                                     CantidadDias1 = a.CantidadDias1
                                 }).ToList();

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }
    
    
    }
}