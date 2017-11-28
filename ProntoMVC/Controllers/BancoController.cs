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

        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Bancos)) throw new Exception("No tenés permisos");

            return View();
        }

        public virtual ActionResult Edit(int id)
        {
            Banco o;
            if (id <= 0)
            {
                o = new Banco();
            }
            else
            {
                o = db.Bancos.SingleOrDefault(x => x.IdBanco == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        void CargarViewBag(Banco o)
        {
            Parametros parametros = db.Parametros.Find(1);
            int? i = parametros.IdTipoCuentaGrupoFF;
        }

        public bool Validar(ProntoMVC.Data.Models.Banco o, ref string sErrorMsg)
        {
            if ((o.Nombre ?? "") == "") { sErrorMsg += "\n" + "Falta la Nombre"; }

            if ((o.IdCodigoIva ?? 0) == 0) { sErrorMsg += "\n" + "Falta el codigo de IVA"; }

            if ((o.IdCuenta ?? 0) == 0) { sErrorMsg += "\n" + "Falta la cuenta contable"; }

            string s = "asdasd";
            s = o.Cuit.NullSafeToString().Replace("-", "").PadLeft(11);
            o.Cuit = s.Substring(0, 2) + "-" + s.Substring(2, 8) + "-" + s.Substring(10, 1);
            if (!ProntoMVC.Data.FuncionesGenericasCSharp.CUITValido(o.Cuit.NullSafeToString())) { sErrorMsg += "\n" + "El CUIT es incorrecto"; }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(Banco Banco)
        {
            if (!PuedeEditar(enumNodos.Bancos)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(Banco, ref errs))
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
                    if (Banco.IdBanco > 0)
                    {
                        var EntidadOriginal = db.Bancos.Where(p => p.IdBanco == Banco.IdBanco).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Banco);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Bancos.Add(Banco);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdBanco = Banco.IdBanco, ex = "" });
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
            Banco Entidad = db.Bancos.Find(Id);
            db.Bancos.Remove(Entidad);
            db.SaveChanges();
            return Json(new { Success = 1, IdBanco = Id, ex = "" });
        }

        public class Bancos2
        {
            public int IdBanco { get; set; }
            public int? IdCuenta { get; set; }
            public int? IdCuentaParaChequesDiferidos { get; set; }
            public int? IdCodigoIva { get; set; }
            public int? CodigoUniversal { get; set; }
            public string Nombre { get; set; }
            public string Cuenta { get; set; }
            public string CuentaParaChequesDiferidos { get; set; }
            public string Cuit { get; set; }
            public string DescripcionIva { get; set; }
            public int? CodigoResumen { get; set; }
            public int? Codigo { get; set; }
            public int? Entidad { get; set; }
            public int? Subentidad { get; set; }
        }

        public virtual JsonResult Bancos_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.Bancos
                        from b in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        from c in db.Cuentas.Where(o => o.IdCuenta == a.IdCuentaParaChequesDiferidos).DefaultIfEmpty()
                        from d in db.DescripcionIvas.Where(o => o.IdCodigoIva == a.IdCodigoIva).DefaultIfEmpty()
                        select new Bancos2
                        {
                            IdBanco = a.IdBanco,
                            IdCuenta = a.IdCuenta,
                            IdCuentaParaChequesDiferidos = a.IdCuentaParaChequesDiferidos,
                            IdCodigoIva = a.IdCodigoIva,
                            CodigoUniversal = a.CodigoUniversal,
                            Nombre = a.Nombre,
                            Cuenta = b != null ? b.Descripcion : "",
                            CuentaParaChequesDiferidos = c != null ? c.Descripcion : "",
                            Cuit = a.Cuit,
                            DescripcionIva = d != null ? d.Descripcion : "",
                            CodigoResumen = a.CodigoResumen,
                            Codigo = a.Codigo,
                            Entidad = a.Entidad,
                            Subentidad = a.Subentidad
                        }).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<Bancos2>
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
                            id = a.IdBanco.ToString(),
                            cell = new string[] { 
                                "",
                                a.IdBanco.ToString(),
                                a.IdCuenta.NullSafeToString(),
                                a.IdCuentaParaChequesDiferidos.NullSafeToString(),
                                a.IdCodigoIva.NullSafeToString(),
                                a.CodigoUniversal.NullSafeToString(),
                                a.Nombre.NullSafeToString(),
                                a.Cuenta.NullSafeToString(),
                                a.CuentaParaChequesDiferidos.NullSafeToString(),
                                a.Cuit.NullSafeToString(),
                                a.DescripcionIva.NullSafeToString(),
                                a.CodigoResumen.NullSafeToString(),
                                a.Codigo.NullSafeToString(),
                                a.Entidad.NullSafeToString(),
                                a.Subentidad.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetBancosPropios(int? TipoEntidad)
        {
            int TipoEntidad1 = TipoEntidad ?? 0;
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            if (TipoEntidad == 1)
            {
                foreach (CuentasBancaria u in db.CuentasBancarias.Where(x => x.Activa == "SI").OrderBy(x => x.Banco.Nombre).ToList())
                    Datacombo.Add(u.IdCuentaBancaria, u.Banco.Nombre + " " + u.Cuenta);
            }
            if (TipoEntidad == 10)
            {
                foreach (CuentasBancaria u in db.CuentasBancarias.Where(x => x.Activa == "SI").OrderBy(x => x.Banco.Nombre).ToList())
                    Datacombo.Add(u.IdCuentaBancaria, u.Banco.Nombre);
            }
            if (TipoEntidad == 11)
            {
                foreach (Banco u in db.Bancos.Where(x => (x.IdCuenta ?? 0) != 0).OrderBy(x => x.Nombre).ToList())
                    Datacombo.Add(u.IdBanco, u.Nombre);
            }
            if (TipoEntidad == 2)
            {
                foreach (Banco u in db.Bancos.OrderBy(x => x.Nombre).ToList())
                    Datacombo.Add(u.IdBanco, u.Nombre);
            }
            if (TipoEntidad == 3)
            {
                foreach (TarjetasCredito u in db.TarjetasCreditoes.OrderBy(x => x.Nombre).ToList())
                    Datacombo.Add(u.IdTarjetaCredito, u.Nombre);
            }
            if (TipoEntidad == 4)
            {
                foreach (Caja u in db.Cajas.OrderBy(x => x.Descripcion).ToList())
                    Datacombo.Add(u.IdCaja, u.Descripcion);
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

        public virtual JsonResult GetBancosPorIdCuenta(int IdCuenta, int Filler = 0)
        {
            var filtereditems = (from a in db.Bancos
                                 where (a.IdCuenta == IdCuenta)
                                 orderby a.Nombre
                                 select new
                                 {
                                     id = a.IdBanco,
                                     Banco = a.Nombre.Trim(),
                                     value = a.Nombre
                                 }).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetBancosPorIdCuenta2(int IdCuenta = 0)
        {
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            foreach (Banco u in db.Bancos.Where(x => IdCuenta == 0 || x.IdCuenta == IdCuenta).OrderBy(x => x.Nombre).ToList())
                Datacombo.Add(u.IdBanco, u.Nombre);

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