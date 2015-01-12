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
    public partial class PaisController : ProntoBaseController
    {
        public virtual ActionResult GetPaises()
        {
            Dictionary<int, string> paises = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.Pais u in db.Paises.OrderBy(x => x.Descripcion).ToList())
                paises.Add(u.IdPais, u.Descripcion);

            return PartialView("Select", paises);
        }
    }
}

