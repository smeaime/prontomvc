﻿using System;
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
    public partial class UnidadesOperativaController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.UnidadesOperativas
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.UnidadesOperativas.Count() / pageSize);

            return View(Tabla);
        }

        public bool Validar(ProntoMVC.Data.Models.UnidadesOperativa o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            Int32 mMaxLength = 0;
            string mProntoIni = "";
            string mExigirCUIT = "";
            Boolean result;

            if (o.Descripcion.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta la descripcion";
            }
            else
            {
                mMaxLength = GetMaxLength<UnidadesOperativa>(x => x.Descripcion) ?? 0;
                if (o.Descripcion.Length > mMaxLength) { sErrorMsg += "\n" + "La descripcion no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(UnidadesOperativa UnidadesOperativa)
        {
            if (!PuedeEditar(enumNodos.UnidadesOperativas)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(UnidadesOperativa, ref errs))
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
                    if (UnidadesOperativa.IdUnidadOperativa > 0)
                    {
                        var EntidadOriginal = db.UnidadesOperativas.Where(p => p.IdUnidadOperativa == UnidadesOperativa.IdUnidadOperativa).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(UnidadesOperativa);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.UnidadesOperativas.Add(UnidadesOperativa);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdUnidadOperativa = UnidadesOperativa.IdUnidadOperativa, ex = "" });
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
            UnidadesOperativa UnidadesOperativa = db.UnidadesOperativas.Find(Id);
            db.UnidadesOperativas.Remove(UnidadesOperativa);
            db.SaveChanges();
            return Json(new { Success = 1, IdUnidadOperativa = Id, ex = "" });
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.UnidadesOperativas.AsQueryable();
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
                            select new { IdCalle = a.IdUnidadOperativa }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdUnidadOperativa,
                            a.Descripcion
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
                            id = a.IdUnidadOperativa.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdUnidadOperativa.ToString(),
                                a.Descripcion.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetUnidadesOperativas()
        {
            Dictionary<int, string> unidadesoperativa = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.UnidadesOperativa u in db.UnidadesOperativas.OrderBy(x => x.Descripcion).ToList())
                unidadesoperativa.Add(u.IdUnidadOperativa, u.Descripcion);

            return PartialView("Select", unidadesoperativa);
        }
    }
}

