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
    public partial class BancoChequeraController : ProntoBaseController
    {

        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.BancoChequeras)) throw new Exception("No tenés permisos");

            return View();
        }

        public virtual ActionResult Edit(int id)
        {
            BancoChequera o;
            if (id <= 0)
            {
                o = new BancoChequera();
            }
            else
            {
                o = db.BancoChequeras.SingleOrDefault(x => x.IdBancoChequera == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        void CargarViewBag(BancoChequera o)
        {
            Parametros parametros = db.Parametros.Find(1);
            int? i = parametros.IdTipoCuentaGrupoFF;
        }

        public bool Validar(ProntoMVC.Data.Models.BancoChequera o, ref string sErrorMsg)
        {
            Int32 mMaxLength = 0;

            if ((o.IdBanco ?? 0) == 0) { sErrorMsg += "\n" + "Falta el banco"; }

            if ((o.IdCuentaBancaria ?? 0) == 0) { sErrorMsg += "\n" + "Falta la cuenta bancaria"; }

            if ((o.DesdeCheque ?? 0) == 0) { sErrorMsg += "\n" + "Falta el numero inicial de cheque"; }

            if ((o.HastaCheque ?? 0) == 0) { sErrorMsg += "\n" + "Falta el numero final de cheque"; }

            if ((o.ProximoNumeroCheque ?? 0) == 0) { sErrorMsg += "\n" + "Falta el numero del proximo cheque"; }
            
            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(BancoChequera BancoChequera)
        {
            if (!PuedeEditar(enumNodos.BancoChequeras)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(BancoChequera, ref errs))
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
                    if (BancoChequera.IdBancoChequera > 0)
                    {
                        var EntidadOriginal = db.BancoChequeras.Where(p => p.IdBancoChequera == BancoChequera.IdBancoChequera).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(BancoChequera);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.BancoChequeras.Add(BancoChequera);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdBancoChequera = BancoChequera.IdBancoChequera, ex = "" });
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
            BancoChequera Entidad = db.BancoChequeras.Find(Id);
            db.BancoChequeras.Remove(Entidad);
            db.SaveChanges();
            return Json(new { Success = 1, IdBancoChequera = Id, ex = "" });
        }

        public virtual ActionResult BancoChequeras_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.BancoChequera>
                                ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            // esto filtro se debería aplicar antes que el filtrogenerico (queda mal paginado si no)
            //var Entidad = pagedQuery.Where(o => (o.Confirmado ?? "") != "NO").AsQueryable();

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)rows);

            var data = (from a in pagedQuery
                        from b in db.Bancos.Where(o => o.IdBanco == a.IdBanco).DefaultIfEmpty()
                        from c in db.CuentasBancarias.Where(o => o.IdCuentaBancaria == a.IdCuentaBancaria).DefaultIfEmpty()
                        select new
                        {
                            a.IdBancoChequera,
                            a.IdBanco,
                            a.IdCuentaBancaria,
                            Banco = b != null ? b.Nombre : "",
                            CuentaBancaria = c != null && b != null ? b.Nombre + " [" + c.Cuenta + "]" : "",
                            a.NumeroChequera,
                            a.Activa,
                            a.ChequeraPagoDiferido,
                            a.Fecha,
                            a.DesdeCheque,
                            a.HastaCheque,
                            a.ProximoNumeroCheque
                        }).OrderBy(sidx + " " + sord).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdBancoChequera.ToString(),
                            cell = new string[] { 
                                "",
                                a.IdBancoChequera.ToString(),
                                a.IdBanco.NullSafeToString(),
                                a.IdCuentaBancaria.NullSafeToString(),
                                a.Banco,
                                a.CuentaBancaria,
                                a.NumeroChequera.NullSafeToString(),
                                a.Activa,
                                a.ChequeraPagoDiferido,
                                a.Fecha == null ? "" : a.Fecha.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.DesdeCheque.NullSafeToString(),
                                a.HastaCheque.NullSafeToString(),
                                a.ProximoNumeroCheque.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        

    }
}