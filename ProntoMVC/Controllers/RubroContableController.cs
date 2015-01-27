using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Text;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using ProntoMVC.Data.Models; 
using ProntoMVC.Models;
using Pronto.ERP.Bll;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;
using OpenXmlPowerTools;
using ClosedXML.Excel;

namespace ProntoMVC.Controllers
{
    public partial class RubroContableController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.RubrosContables)) throw new Exception("No tenés permisos");

            return View();
        }
        public virtual ViewResult IndexExterno()
        {
            if (!PuedeLeer(enumNodos.RubrosContables)) throw new Exception("No tenés permisos");

            return View();
        }
        public virtual ActionResult GetRubrosContables()
        {
            Dictionary<int, string> rubrocontable = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.RubrosContable u in db.RubrosContables.OrderBy(x => x.Descripcion).ToList())
                rubrocontable.Add(u.IdRubroContable, u.Descripcion);

            return PartialView("Select", rubrocontable);
        }
    }
}
