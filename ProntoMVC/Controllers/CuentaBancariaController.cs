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
    public partial class CuentaBancariaController : ProntoBaseController
    {

        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.CuentasBancarias)) throw new Exception("No tenés permisos");

            return View();
        }

        public virtual ActionResult Edit(int id)
        {
            CuentasBancaria o;
            if (id <= 0)
            {
                o = new CuentasBancaria();
            }
            else
            {
                o = db.CuentasBancarias.SingleOrDefault(x => x.IdCuentaBancaria == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        void CargarViewBag(CuentasBancaria o)
        {
            Parametros parametros = db.Parametros.Find(1);
            int? i = parametros.IdTipoCuentaGrupoFF;
        }

        public bool Validar(ProntoMVC.Data.Models.CuentasBancaria o, ref string sErrorMsg)
        {
            Int32 mMaxLength = 0;

            if (o.Detalle.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta el detalle";
            }
            else
            {
                mMaxLength = GetMaxLength<CuentasBancaria>(x => x.Detalle) ?? 0;
                if (o.Detalle.Length > mMaxLength) { sErrorMsg += "\n" + "El detalle no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.Cuenta.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta la cuenta";
            }
            else
            {
                mMaxLength = GetMaxLength<CuentasBancaria>(x => x.Cuenta) ?? 0;
                if (o.Cuenta.Length > mMaxLength) { sErrorMsg += "\n" + "La cuenta no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.CBU.NullSafeToString() == "")
            {
                //sErrorMsg += "\n" + "Falta la cuenta";
            }
            else
            {
                mMaxLength = GetMaxLength<CuentasBancaria>(x => x.CBU) ?? 0;
                if (o.CBU.Length > mMaxLength) { sErrorMsg += "\n" + "El CBU no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if ((o.IdBanco ?? 0) == 0) { sErrorMsg += "\n" + "Falta el banco"; }

            if ((o.IdMoneda ?? 0) == 0) { sErrorMsg += "\n" + "Falta la moneda"; }

            if ((o.IdProvincia ?? 0) == 0) { sErrorMsg += "\n" + "Falta la provincia"; }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(CuentasBancaria CuentasBancaria)
        {
            if (!PuedeEditar(enumNodos.CuentasBancarias)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(CuentasBancaria, ref errs))
                {
                    try
                    {
                        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    }
                    catch (Exception)
                    {
                    }

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;

                    string[] words = errs.Split('\n');
                    res.Errors = words.ToList();
                    res.Message = "Hay datos invalidos";

                    return Json(res);
                }

                if (ModelState.IsValid)
                {
                    if (CuentasBancaria.IdCuentaBancaria > 0)
                    {
                        var EntidadOriginal = db.CuentasBancarias.Where(p => p.IdCuentaBancaria == CuentasBancaria.IdCuentaBancaria).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(CuentasBancaria);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.CuentasBancarias.Add(CuentasBancaria);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdCuentaBancaria = CuentasBancaria.IdCuentaBancaria, ex = "" });
                }
                else
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El registro tiene datos invalidos";

                    return Json(res);
                }
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;

                List<string> errors = new List<string>();
                errors.Add(ex.Message);
                return Json(errors);
            }
        }

        [HttpPost]
        public virtual JsonResult Delete(int Id)
        {
            CuentasBancaria Entidad = db.CuentasBancarias.Find(Id);
            db.CuentasBancarias.Remove(Entidad);
            db.SaveChanges();
            return Json(new { Success = 1, IdCuentaBancaria = Id, ex = "" });
        }

        public class CuentasBancarias2
        {
            public int IdCuentaBancaria { get; set; }
            public int? IdBanco { get; set; }
            public int? IdMoneda { get; set; }
            public int? IdProvincia { get; set; }
            public string Detalle { get; set; }
            public string Cuenta { get; set; }
            public string Banco { get; set; }
            public string Moneda { get; set; }
            public string Provincia { get; set; }
            public string CBU { get; set; }
            public string InformacionAuxiliar { get; set; }
            public string Activa { get; set; }
            public string PlantillaChequera { get; set; }
            public int? ChequesPorPlancha { get; set; }
            public int? CaracteresBeneficiario { get; set; }
            public string DiseñoCheque { get; set; }
        }

        public virtual JsonResult CuentasBancarias_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.CuentasBancarias
                        from b in db.Bancos.Where(o => o.IdBanco == a.IdBanco).DefaultIfEmpty()
                        from c in db.Monedas.Where(o => o.IdMoneda == a.IdMoneda).DefaultIfEmpty()
                        from d in db.Provincias.Where(o => o.IdProvincia == a.IdProvincia).DefaultIfEmpty()
                        select new CuentasBancarias2
                        {
                            IdCuentaBancaria = a.IdCuentaBancaria,
                            IdBanco = a.IdBanco,
                            IdMoneda = a.IdMoneda,
                            IdProvincia = a.IdProvincia,
                            Detalle = a.Detalle,
                            Cuenta = a.Cuenta,
                            Banco = b != null ? b.Nombre : "",
                            Moneda = c != null ? c.Nombre : "",
                            Provincia = d != null ? d.Nombre : "",
                            CBU = a.CBU,
                            InformacionAuxiliar = a.InformacionAuxiliar,
                            Activa = a.Activa,
                            PlantillaChequera = a.PlantillaChequera,
                            ChequesPorPlancha = a.ChequesPorPlancha,
                            CaracteresBeneficiario = a.CaracteresBeneficiario,
                            DiseñoCheque = a.DiseñoCheque
                        }).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<CuentasBancarias2>
                                     (sidx, sord, page, rows, _search, filters, db, ref totalRecords, data);

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdCuentaBancaria.ToString(),
                            cell = new string[] { 
                                "",
                                a.IdCuentaBancaria.ToString(),
                                a.IdBanco.NullSafeToString(),
                                a.IdMoneda.NullSafeToString(),
                                a.IdProvincia.NullSafeToString(),
                                a.Detalle.NullSafeToString(),
                                a.Cuenta.NullSafeToString(),
                                a.Banco.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.Provincia.NullSafeToString(),
                                a.CBU.NullSafeToString(),
                                a.InformacionAuxiliar.NullSafeToString(),
                                a.Activa.NullSafeToString(),
                                a.PlantillaChequera.NullSafeToString(),
                                a.ChequesPorPlancha.NullSafeToString(),
                                a.CaracteresBeneficiario.NullSafeToString(),
                                a.DiseñoCheque.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetCuentasBancariasPorIdBanco(int IdBanco = 0)
        {
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            foreach (CuentasBancaria u in db.CuentasBancarias.Where(x => (IdBanco == 0 || x.Banco.IdBanco == IdBanco) && x.Activa == "SI").OrderBy(x => x.Cuenta).ToList())
                Datacombo.Add(u.IdCuentaBancaria, u.Banco.Nombre + " [" + u.Cuenta + "]");

            return PartialView("Select", Datacombo);
        }

    }
}