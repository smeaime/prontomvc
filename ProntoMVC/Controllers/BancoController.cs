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
using Pronto.ERP.Bll;
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;

namespace ProntoMVC.Controllers
{
    public partial class BancoController : ProntoBaseController
    {
        public virtual JsonResult GetCuentasBancariasAutocomplete(string term, int obra = 0)
        {
            var ci = new System.Globalization.CultureInfo("en-US");

            var filtereditems = (from item in db.CuentasBancarias
                                 join banco in db.Bancos on item.IdBanco equals banco.IdBanco
                                 where (
                                 item.Cuenta).StartsWith(term)
                                 orderby item.Cuenta
                                 select new
                                 {
                                     id = item.IdCuentaBancaria,
                                     codigo = item.Cuenta.Trim(), 
                                     value = item.Cuenta, // + " " + SqlFunctions.StringConvert((double)(cu.Codigo ?? 0)),
                                     title = item.Cuenta, 
                                     label = item.Cuenta,
                                     Banco = item.Banco.Nombre
                                 }).Take(20).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }
    
    }
}