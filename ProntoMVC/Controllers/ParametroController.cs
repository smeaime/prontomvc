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
                            a.IdTipoComprobanteTarjetaCredito,
                            a.ProximoNumeroAjusteStock,
                            a.ProximoNumeroOtroIngresoAlmacen,
                            a.ProximoNumeroInternoRecepcion
                        }).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult Parametros2(int TipoSalida)
        {
            Parametros2 Parametros2;
            Int32 mAuxI1 = 0;
            Int32 mAuxI2 = 0;
            Int32 mAuxI3 = 3;

            var tabla = db.Parametros.Where(p => p.IdParametro == 1).AsQueryable().FirstOrDefault();
            if (TipoSalida == 0 || TipoSalida == 2)
            {
                mAuxI1 = tabla.ProximoNumeroSalidaMateriales2 ?? 1;
                mAuxI2 = tabla.ProximoNumeroSalidaMateriales ?? 1;
            }
            if (TipoSalida == 1)
            {
                mAuxI1 = tabla.ProximoNumeroSalidaMaterialesAObra2 ?? 1;
                mAuxI2 = tabla.ProximoNumeroSalidaMaterialesAObra ?? 1;
            }
            if (TipoSalida > 2)
            {
                string mProntoIni_OpcionesAdicionales = BuscarClaveINI("Opciones adicionales para salida de materiales", -1) ?? "";
                if (mProntoIni_OpcionesAdicionales.Length > 0)
                {
                    string[] Opciones = mProntoIni_OpcionesAdicionales.Split(',');
                    foreach (string Opcion in Opciones)
                    {
                        if (mAuxI3 == TipoSalida)
                        {
                            Parametros2 = db.Parametros2.Where(p => p.Campo == Opcion + "_2").FirstOrDefault();
                            if (Parametros2 != null) { mAuxI1 = Convert.ToInt32(Parametros2.Valor ?? "1"); }
                            Parametros2 = db.Parametros2.Where(p => p.Campo == Opcion + "_1").FirstOrDefault();
                            if (Parametros2 != null) { mAuxI2 = Convert.ToInt32(Parametros2.Valor ?? "1"); }
                        }
                        mAuxI3 = mAuxI3 + 1;
                    }
                }
            }
            return Json(new { mAuxI1, mAuxI2 }, JsonRequestBehavior.AllowGet);
        }

    }
}
