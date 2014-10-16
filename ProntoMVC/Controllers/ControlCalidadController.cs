using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using ProntoMVC.Data.Models; using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Text;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
using System.Reflection;
using System.Configuration;
using Pronto.ERP.Bll;



using System.Web.Security;

namespace ProntoMVC.Controllers
{
    public partial class ControlCalidadController : ProntoBaseController
    {


        public virtual ActionResult ControlCalidades()
        {
            Dictionary<int, string> combo = new Dictionary<int, string>();
            foreach (ControlCalidad u in db.ControlesCalidads.OrderBy(x => x.Descripcion).ToList())
                combo.Add(u.IdControlCalidad, u.Descripcion);
            return PartialView("Select", combo);
        }


        public virtual JsonResult GetControlCalidadesAutocomplete(string term)
        {
            int id = Generales.Val(term); 

            var q= Json((from item in db.ControlesCalidads

                         where item.Descripcion.Contains(term) || item.IdControlCalidad == id
                         select new
                         {
                             value = item.IdControlCalidad,
                             title = item.Descripcion
                         }).ToList(),
                         JsonRequestBehavior.AllowGet);
            return q;
        }





        public virtual ActionResult ControlCalidadParaComboDeJqgridades(string sidx, string sord, int? page, int? rows, int? Id)
        {



            int IdArticulo1 = Id ?? 0;
            var DetEntidad = (from x in db.ControlesCalidads.OrderBy(x => x.Descripcion) select x).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select new
                        {
                            a.IdControlCalidad,
                            a.Descripcion,
                            a.Abreviatura
                        }).OrderBy(p => p.IdControlCalidad).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();


            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdControlCalidad.ToString(),
                            cell = new string[] { 
                                string.Empty, // guarda con este espacio vacio
                                a.IdControlCalidad.ToString(),
                                a.Descripcion.NullSafeToString(),
                                // (a.Unidade ?? new Unidad()).Abreviatura.NullSafeToString(),
                                a.Abreviatura.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }






        public virtual JsonResult GetControlCalidadAutocomplete(string term)
        {

            // http://stackoverflow.com/questions/444798/case-insensitive-containsstring

            var ci = new System.Globalization.CultureInfo("en-US");

            var filtereditems = (from item in db.Cuentas
                                 // TO DO: no me funciona el  .StartsWith(term, true, ci) !!!!!!!!! 
                                 // y usarlo con el int del codigo tambien es un dolor de cabeza!!!!!
                                 // http://stackoverflow.com/questions/1066760/problem-with-converting-int-to-string-in-linq-to-entities/3292773#3292773
                                 // http://stackoverflow.com/questions/10110266/why-linq-to-entities-does-not-recognize-the-method-system-string-tostring

                                 where ((item.Descripcion.StartsWith(term)
                                     //       || SqlFunctions.StringConvert((double)(item.Codigo ?? 0)).StartsWith(term)
                                         )
                                     && item.IdTipoCuenta == 2
                                     // && item.Descripcion.Trim().Length > 0
                                     )
                                 orderby item.Descripcion
                                 select new
                                 {
                                     id = item.IdCuenta,
                                     codigo = item.Codigo,
                                     value = item.Descripcion + " " + SqlFunctions.StringConvert((double)(item.Codigo ?? 0)),
                                     title = item.Descripcion + " " + SqlFunctions.StringConvert((double)(item.Codigo ?? 0))
                                 }).Take(20).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }


    }
}