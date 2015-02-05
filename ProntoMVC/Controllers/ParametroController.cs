using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Text;
using System.Reflection;
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Web.Security;

namespace ProntoMVC.Controllers
{
    public partial class ParametroController : ProntoBaseController
    {
        public virtual JsonResult Parametros()
        {
            var tabla = db.Parametros.Where(p => p.IdParametro == 1).AsQueryable();

            var data = (from a in tabla
                        select new
                        {
                            a.IdMoneda,
                            a.IdMonedaDolar,
                            a.IdMonedaEuro,
                            a.IdTipoComprobanteCajaEgresos,
                            a.ProximoNumeroInternoChequeEmitido,
                            a.ProximaNotaDebitoInterna,
                            a.ProximaNotaCreditoInterna,
                            a.IdTipoComprobanteCajaIngresos,
                            a.IdTipoComprobanteTarjetaCredito
                        }).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

    }
}
