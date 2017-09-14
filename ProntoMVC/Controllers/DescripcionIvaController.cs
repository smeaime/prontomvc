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
    public partial class DescripcionIvaController : ProntoBaseController
    {
        public virtual ActionResult GetDescripcionesIva()
        {
            Dictionary<int, string> Tabla = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.DescripcionIva u in db.DescripcionIvas.OrderBy(x => x.Descripcion).ToList())
                Tabla.Add(u.IdCodigoIva, u.Descripcion);

            return PartialView("Select", Tabla);
        }

        public virtual JsonResult GetPorcentajes()
        {
            var q = (from item in db.Parametros2
                     where (item.Campo.ToLower()).Contains("PorcentajeIva".ToLower())
                     orderby item.Valor
                     select new
                     {
                         id = item.IdParametro,
                         value = (item.Valor ?? ""),
                         descripcion = (item.Campo ?? "")
                     }).ToList();
            return Json(q, JsonRequestBehavior.AllowGet);
        }

    }
}
