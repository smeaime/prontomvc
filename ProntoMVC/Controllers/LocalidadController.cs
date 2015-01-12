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

using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
//using Trirand.Web.Mvc;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using Pronto.ERP.Bll;

namespace ProntoMVC.Controllers
{
    public partial class LocalidadController : ProntoBaseController
    {
        public virtual JsonResult GetLocalidadesAutocomplete(string term)
        {
            var ci = new System.Globalization.CultureInfo("en-US");

            var filtereditems = (from item in db.Localidades
                                 where ((item.Nombre.StartsWith(term)))
                                 orderby item.Nombre
                                 select new
                                 {
                                     id = item.IdLocalidad,
                                     value = item.Nombre,
                                     title = item.Nombre + " " + item.CodigoPostal,
                                     idprovincia = item.IdProvincia
                                 }).Take(20).ToList();

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetLocalidades()
        {
            Dictionary<int, string> localidades = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.Localidad u in db.Localidades.OrderBy(x => x.Nombre).ToList())
                localidades.Add(u.IdLocalidad, u.Nombre);

            return PartialView("Select", localidades);
        }
    }
}

