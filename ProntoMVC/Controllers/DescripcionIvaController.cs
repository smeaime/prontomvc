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

        public virtual JsonResult GetPorcentajesIvaCompras()
        {
            Parametros parametros = db.Parametros.Find(1);
            List<SelectListItem> Tabla = new List<SelectListItem>();

            decimal IVAComprasPorcentaje = -1;
            string Cuenta = "";

            IVAComprasPorcentaje = (decimal)(parametros.IVAComprasPorcentaje1 ?? -1);
            Cuenta = db.Cuentas.Where(x => x.IdCuenta == (parametros.IdCuentaIvaCompras1 ?? 0)).Select(y => y.Descripcion).FirstOrDefault();
            if (IVAComprasPorcentaje >= 0) {
                Tabla.Add(new SelectListItem { Text = Cuenta as string, Value = IVAComprasPorcentaje.ToString() });
            };
            IVAComprasPorcentaje = (decimal)(parametros.IVAComprasPorcentaje2 ?? -1);
            Cuenta = db.Cuentas.Where(x => x.IdCuenta == (parametros.IdCuentaIvaCompras2 ?? 0)).Select(y => y.Descripcion).FirstOrDefault();
            if (IVAComprasPorcentaje >= 0)
            {
                Tabla.Add(new SelectListItem { Text = Cuenta as string, Value = IVAComprasPorcentaje.ToString() });
            };
            IVAComprasPorcentaje = (decimal)(parametros.IVAComprasPorcentaje3 ?? -1);
            Cuenta = db.Cuentas.Where(x => x.IdCuenta == (parametros.IdCuentaIvaCompras3 ?? 0)).Select(y => y.Descripcion).FirstOrDefault();
            if (IVAComprasPorcentaje >= 0)
            {
                Tabla.Add(new SelectListItem { Text = Cuenta as string, Value = IVAComprasPorcentaje.ToString() });
            };
            IVAComprasPorcentaje = (decimal)(parametros.IVAComprasPorcentaje4 ?? -1);
            Cuenta = db.Cuentas.Where(x => x.IdCuenta == (parametros.IdCuentaIvaCompras4 ?? 0)).Select(y => y.Descripcion).FirstOrDefault();
            if (IVAComprasPorcentaje >= 0)
            {
                Tabla.Add(new SelectListItem { Text = Cuenta as string, Value = IVAComprasPorcentaje.ToString() });
            };
            IVAComprasPorcentaje = (decimal)(parametros.IVAComprasPorcentaje5 ?? -1);
            Cuenta = db.Cuentas.Where(x => x.IdCuenta == (parametros.IdCuentaIvaCompras5 ?? 0)).Select(y => y.Descripcion).FirstOrDefault();
            if (IVAComprasPorcentaje >= 0)
            {
                Tabla.Add(new SelectListItem { Text = Cuenta as string, Value = IVAComprasPorcentaje.ToString() });
            };
            IVAComprasPorcentaje = (decimal)(parametros.IVAComprasPorcentaje6 ?? -1);
            Cuenta = db.Cuentas.Where(x => x.IdCuenta == (parametros.IdCuentaIvaCompras6 ?? 0)).Select(y => y.Descripcion).FirstOrDefault();
            if (IVAComprasPorcentaje >= 0)
            {
                Tabla.Add(new SelectListItem { Text = Cuenta as string, Value = IVAComprasPorcentaje.ToString() });
            };
            IVAComprasPorcentaje = (decimal)(parametros.IVAComprasPorcentaje7 ?? -1);
            Cuenta = db.Cuentas.Where(x => x.IdCuenta == (parametros.IdCuentaIvaCompras7 ?? 0)).Select(y => y.Descripcion).FirstOrDefault();
            if (IVAComprasPorcentaje >= 0)
            {
                Tabla.Add(new SelectListItem { Text = Cuenta as string, Value = IVAComprasPorcentaje.ToString() });
            };
            IVAComprasPorcentaje = (decimal)(parametros.IVAComprasPorcentaje8 ?? -1);
            Cuenta = db.Cuentas.Where(x => x.IdCuenta == (parametros.IdCuentaIvaCompras8 ?? 0)).Select(y => y.Descripcion).FirstOrDefault();
            if (IVAComprasPorcentaje >= 0)
            {
                Tabla.Add(new SelectListItem { Text = Cuenta as string, Value = IVAComprasPorcentaje.ToString() });
            };
            IVAComprasPorcentaje = (decimal)(parametros.IVAComprasPorcentaje9 ?? -1);
            Cuenta = db.Cuentas.Where(x => x.IdCuenta == (parametros.IdCuentaIvaCompras9 ?? 0)).Select(y => y.Descripcion).FirstOrDefault();
            if (IVAComprasPorcentaje >= 0)
            {
                Tabla.Add(new SelectListItem { Text = Cuenta as string, Value = IVAComprasPorcentaje.ToString() });
            };
            IVAComprasPorcentaje = (decimal)(parametros.IVAComprasPorcentaje10 ?? -1);
            Cuenta = db.Cuentas.Where(x => x.IdCuenta == (parametros.IdCuentaIvaCompras10 ?? 0)).Select(y => y.Descripcion).FirstOrDefault();
            if (IVAComprasPorcentaje >= 0)
            {
                Tabla.Add(new SelectListItem { Text = Cuenta as string, Value = IVAComprasPorcentaje.ToString() });
            };

            //return PartialView("Select", Tabla);
            return Json(Tabla, JsonRequestBehavior.AllowGet);
        }

    }
}
