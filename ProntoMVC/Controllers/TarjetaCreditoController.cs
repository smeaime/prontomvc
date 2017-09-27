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
    public partial class TarjetaCreditoController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.TarjetasCredito)) throw new Exception("No tenés permisos");

            return View();
        }

        public virtual ActionResult Edit(int id)
        {
            TarjetasCredito o;
            if (id <= 0)
            {
                o = new TarjetasCredito();
            }
            else
            {
                o = db.TarjetasCreditoes.SingleOrDefault(x => x.IdTarjetaCredito == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        void CargarViewBag(TarjetasCredito o)
        {
            Parametros parametros = db.Parametros.Find(1);
            int? i = parametros.IdTipoCuentaGrupoFF;
        }

        public bool Validar(ProntoMVC.Data.Models.TarjetasCredito o, ref string sErrorMsg)
        {
            Int32 mMaxLength = 0;

            if (o.Nombre.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta el nombre de la tarjeta";
            }
            else
            {
                mMaxLength = GetMaxLength<TarjetasCredito>(x => x.Nombre) ?? 0;
                if (o.Nombre.Length > mMaxLength) { sErrorMsg += "\n" + "El nombre de la tarjeta no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if ((o.IdCuenta ?? 0) == 0) { sErrorMsg += "\n" + "Falta la cuenta contable"; }

            if ((o.IdMoneda ?? 0) == 0) { sErrorMsg += "\n" + "Falta la moneda"; }

            if ((o.IdBanco ?? 0) == 0) { sErrorMsg += "\n" + "Falta el banco"; }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(TarjetasCredito TarjetasCredito)
        {
            if (!PuedeEditar(enumNodos.TarjetasCredito)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(TarjetasCredito, ref errs))
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
                    if (TarjetasCredito.IdTarjetaCredito > 0)
                    {
                        var EntidadOriginal = db.TarjetasCreditoes.Where(p => p.IdTarjetaCredito == TarjetasCredito.IdTarjetaCredito).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(TarjetasCredito);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.TarjetasCreditoes.Add(TarjetasCredito);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdTarjetaCredito = TarjetasCredito.IdTarjetaCredito, ex = "" });
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
            TarjetasCredito Entidad = db.TarjetasCreditoes.Find(Id);
            db.TarjetasCreditoes.Remove(Entidad);
            db.SaveChanges();
            return Json(new { Success = 1, IdTarjetaCredito = Id, ex = "" });
        }

        public class TarjetasCreditoes2
        {
            public int IdTarjetaCredito { get; set; }
            public int? IdCuenta { get; set; }
            public int? IdMoneda { get; set; }
            public int? IdBanco { get; set; }
            public string Nombre { get; set; }
            public string Cuenta { get; set; }
            public string Moneda { get; set; }
            public string BancoEmisor { get; set; }
            public int? Codigo { get; set; }
            public int? DiseñoRegistro { get; set; }
            public string TipoTarjeta { get; set; }
            public string NumeroEstablecimiento { get; set; }
            public string CodigoServicio { get; set; }
            public string NumeroServicio { get; set; }
        }

        public virtual JsonResult TarjetasCreditoes_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.TarjetasCreditoes
                        from b in db.Monedas.Where(o => o.IdMoneda == a.IdMoneda).DefaultIfEmpty()
                        from c in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        from d in db.Bancos.Where(o => o.IdBanco == a.IdBanco).DefaultIfEmpty()
                        select new TarjetasCreditoes2
                        {
                            IdTarjetaCredito = a.IdTarjetaCredito,
                            IdCuenta = a.IdCuenta,
                            IdMoneda = a.IdMoneda,
                            IdBanco = a.IdBanco,
                            Nombre = a.Nombre,
                            Cuenta = c != null ? c.Descripcion : "",
                            Moneda = b != null ? b.Nombre : "",
                            BancoEmisor = d != null ? d.Nombre : "",
                            Codigo = a.Codigo,
                            DiseñoRegistro = a.DiseñoRegistro,
                            TipoTarjeta = a.TipoTarjeta,
                            NumeroEstablecimiento = a.NumeroEstablecimiento,
                            CodigoServicio = a.CodigoServicio,
                            NumeroServicio = a.NumeroServicio
                        }).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<TarjetasCreditoes2>
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
                            id = a.IdTarjetaCredito.ToString(),
                            cell = new string[] { 
                                "",
                                a.IdTarjetaCredito.ToString(),
                                a.IdCuenta.NullSafeToString(),
                                a.IdMoneda.NullSafeToString(),
                                a.IdBanco.NullSafeToString(),
                                a.Nombre.NullSafeToString(),
                                a.Cuenta.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.BancoEmisor.NullSafeToString(),
                                a.Codigo.NullSafeToString(),
                                a.DiseñoRegistro.NullSafeToString(),
                                a.TipoTarjeta.NullSafeToString(),
                                a.NumeroEstablecimiento.NullSafeToString(),
                                a.CodigoServicio.NullSafeToString(),
                                a.NumeroServicio.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetTarjetasCreditoes()
        {
            Dictionary<int, string> Tabla = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.TarjetasCredito u in db.TarjetasCreditoes.OrderBy(x => x.Nombre).ToList())
                Tabla.Add(u.IdTarjetaCredito, u.Nombre);

            return PartialView("Select", Tabla);
        }

    }
}
