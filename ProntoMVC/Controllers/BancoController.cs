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
using Pronto.ERP.Bll;
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;

namespace ProntoMVC.Controllers
{
    public partial class BancoController : ProntoBaseController
    {
        public virtual ActionResult GetBancosPropios(int? TipoEntidad)
        {
            int TipoEntidad1 = TipoEntidad ?? 0;
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            if (TipoEntidad == 1)
            {
                foreach (CuentasBancaria u in db.CuentasBancarias.Where(x => x.Activa == "SI").OrderBy(x => x.Banco.Nombre).ToList())
                    Datacombo.Add(u.IdCuentaBancaria, u.Banco.Nombre + " " + u.Cuenta);
            }
            if (TipoEntidad == 2)
            {
                foreach (Caja u in db.Cajas.OrderBy(x => x.Descripcion).ToList())
                    Datacombo.Add(u.IdCaja, u.Descripcion);
            }
            if (TipoEntidad == 3)
            {
                foreach (TarjetasCredito u in db.TarjetasCreditoes.OrderBy(x => x.Nombre).ToList())
                    Datacombo.Add(u.IdTarjetaCredito, u.Nombre);
            }
            return PartialView("Select", Datacombo);
        }

        public virtual ActionResult GetBancos()
        {
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            foreach (Banco u in db.Bancos.OrderBy(x => x.Nombre).ToList())
                Datacombo.Add(u.IdBanco, u.Nombre);

            return PartialView("Select", Datacombo);
        }

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

        public virtual JsonResult GetCuentasBancariasPorId(int IdCuentaBancaria)
        {
            var filtereditems = (from a in db.CuentasBancarias
                                 where (a.IdCuentaBancaria == IdCuentaBancaria)
                                 select new
                                 {
                                     id = a.IdCuentaBancaria,
                                     Cuenta = a.Cuenta.Trim(),
                                     value = a.Cuenta,
                                     Banco = a.Banco.Nombre,
                                     IdBanco = a.IdBanco
                                 }).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCuentasBancariasPorIdCuenta(int IdCuenta, int Filler = 0)
        {
            var filtereditems = (from a in db.CuentasBancarias
                                 where (a.Banco.IdCuenta == IdCuenta && a.Activa == "SI")
                                 orderby a.Cuenta
                                 select new
                                 {
                                     id = a.IdCuentaBancaria,
                                     Cuenta = a.Cuenta.Trim(),
                                     value = a.Cuenta, 
                                     Banco = a.Banco.Nombre
                                 }).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetCuentasBancariasPorIdCuenta2(int IdCuenta = 0)
        {
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            foreach (CuentasBancaria u in db.CuentasBancarias.Where(x => (IdCuenta == 0 || x.Banco.IdCuenta == IdCuenta) && x.Activa == "SI").OrderBy(x => x.Cuenta).ToList())
                Datacombo.Add(u.IdCuentaBancaria, u.Banco.Nombre + " " + u.Cuenta);

            return PartialView("Select", Datacombo);
        }

        public virtual JsonResult GetCajasPorIdCuenta(int IdCuenta, int Filler = 0)
        {
            var filtereditems = (from a in db.Cajas
                                 where (a.IdCuenta == IdCuenta)
                                 orderby a.Descripcion
                                 select new
                                 {
                                     id = a.IdCaja,
                                     Caja = a.Descripcion.Trim(),
                                     value = a.Descripcion
                                 }).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetCajasPorIdCuenta2(int IdCuenta = 0)
        {
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            foreach (Caja u in db.Cajas.Where(x => IdCuenta == 0 || x.IdCuenta == IdCuenta).OrderBy(x => x.Descripcion).ToList())
                Datacombo.Add(u.IdCaja, u.Descripcion);

            return PartialView("Select", Datacombo);
        }

        public virtual JsonResult GetTarjetasCreditoPorIdCuenta(int IdCuenta, int Filler = 0)
        {
            var filtereditems = (from a in db.TarjetasCreditoes
                                 where (a.IdCuenta == IdCuenta)
                                 orderby a.Nombre
                                 select new
                                 {
                                     id = a.IdTarjetaCredito,
                                     TarjetaCredito = a.Nombre.Trim(),
                                     value = a.Nombre
                                 }).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetTarjetasCreditoPorIdCuenta2(int IdCuenta = 0)
        {
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            foreach (TarjetasCredito u in db.TarjetasCreditoes.Where(x => x.IdCuenta == IdCuenta || IdCuenta == 0).OrderBy(x => x.Nombre).ToList())
                Datacombo.Add(u.IdTarjetaCredito, u.Nombre);

            return PartialView("Select", Datacombo);
        }

        public virtual JsonResult GetChequerasPorIdCuentaBancaria(int IdCuentaBancaria = 0)
        {
            var filtereditems = (from a in db.BancoChequeras
                                 where ((a.IdCuentaBancaria == IdCuentaBancaria || IdCuentaBancaria == 0) && a.Activa == "SI")
                                 orderby a.NumeroChequera
                                 select new
                                 {
                                     id = a.IdBancoChequera,
                                     value = a.NumeroChequera.ToString()
                                 }).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }
        public virtual JsonResult GetChequerasPorId(int IdBancoChequera = 0)
        {
            var filtereditems = (from a in db.BancoChequeras
                                 where (a.IdBancoChequera == IdBancoChequera)
                                 select new
                                 {
                                     id = a.IdBancoChequera,
                                     value = a.ProximoNumeroCheque.ToString()
                                 }).ToList();
            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetChequerasPorIdCuentaBancaria2(int IdCuentaBancaria = 0)
        {
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            foreach (BancoChequera u in db.BancoChequeras.Where(x => (IdCuentaBancaria <= 0 || x.IdCuentaBancaria == IdCuentaBancaria) && x.Activa == "SI").OrderBy(x => x.NumeroChequera).ToList())
                Datacombo.Add(u.IdBancoChequera, u.NumeroChequera.ToString());

            return PartialView("Select", Datacombo);
        }

    }
}