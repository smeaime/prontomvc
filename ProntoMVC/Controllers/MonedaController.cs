using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProntoMVC.Controllers
{
    public partial class MonedaController : ProntoBaseController
    {

        public virtual JsonResult Moneda_Cotizacion(DateTime? fecha, int IdMoneda)
        {
            if (db == null) return null;
            if (fecha == null) fecha = DateTime.Now;

            decimal cotizacion;

            if (false)
            {
                // increíbleeeeeee   http://stackoverflow.com/questions/4144873/entity-framework-stored-procedure-error-with-datetime


                cotizacion = db.Cotizaciones_TX_PorFechaMoneda(fecha, IdMoneda);


            }
            else
            {

                DateTime desde = fecha.Value.Date;
                DateTime hasta = desde.AddDays(1);

                var mvarCotizacion = db.Cotizaciones.Where(x => x.Fecha >= desde && x.Fecha <= hasta && x.IdMoneda == IdMoneda).FirstOrDefault();
                if (mvarCotizacion == null) cotizacion = -1; else cotizacion = mvarCotizacion.Cotizacion ?? -1;
            }



            return Json(cotizacion, JsonRequestBehavior.AllowGet);

        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}
