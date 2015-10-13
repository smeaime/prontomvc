using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using Pronto.ERP.Bll;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace ProntoMVC.Controllers
{
    public partial class ResumenConciliacionController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Conciliaciones)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult Edit(int id)
        {
            Conciliacione o;

            try
            {
                if (!PuedeLeer(enumNodos.Conciliaciones))
                {
                    o = new Conciliacione();
                    CargarViewBag(o);
                    ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                    return View(o);
                }
            }
            catch (Exception)
            {
                o = new Conciliacione();
                CargarViewBag(o);
                ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                return View(o);
            }

            if (id <= 0)
            {
                o = new Conciliacione();
                inic(ref o);
                CargarViewBag(o);
                return View(o);
            }
            else
            {
                o = db.Conciliaciones.SingleOrDefault(x => x.IdConciliacion == id);
                CargarViewBag(o);
                Session.Add("Conciliaciones", o);
                return View(o);
            }
        }

        void CargarViewBag(Conciliacione o)
        {
            ViewBag.IdCuentaBancaria = new SelectList((from i in db.CuentasBancarias
                                                       where i.Activa == "SI"
                                                       select new { IdCuentaBancaria = i.IdCuentaBancaria, Nombre = i.Banco.Nombre + " " + i.Cuenta }).Distinct(), "IdCuentaBancaria", "Nombre", o.IdCuentaBancaria);
            ViewBag.IdRealizo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdRealizo);
            ViewBag.IdAprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdAprobo);
        }

        void inic(ref Conciliacione o)
        {
            o.FechaIngreso = DateTime.Today;
            o.FechaInicial = DateTime.Today;
            o.FechaFinal = DateTime.Today;
        }

        private bool Validar(ProntoMVC.Data.Models.Conciliacione o, ref string sErrorMsg, ref string sWarningMsg)
        {
            if (!PuedeEditar(enumNodos.Conciliaciones)) sErrorMsg += "\n" + "No tiene permisos de edición";

            Int32 mIdConciliacion = 0;
            Int32 mIdCuentaBancaria = 0;
            Int32 mMaxLength = 0;
            Int32 mIdValor = 0;

            string mNumero = "";

            decimal mNumeroValor = 0;

            DateTime mFecha = DateTime.Today;

            mIdConciliacion = o.IdConciliacion;
            mIdCuentaBancaria = o.IdCuentaBancaria ?? 0;

            if (o.Numero.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta el numero de resumen";
            }
            else
            {
                mMaxLength = GetMaxLength<Conciliacione>(x => x.Numero) ?? 0;
                if (o.Numero.Length > mMaxLength) { sErrorMsg += "\n" + "El numero de resumen no puede tener mas de " + mMaxLength + " digitos"; }
            }
            mNumero = o.Numero.NullSafeToString();

            if (mIdCuentaBancaria == 0) { sErrorMsg += "\n" + "Falta la cuenta bancaria"; }

            if ((o.IdRealizo ?? 0) == 0) { sErrorMsg += "\n" + "Falta indicar quien realizo"; }

            var Conciliaciones = db.Conciliaciones.Where(x => x.Numero == mNumero && x.IdCuentaBancaria == mIdCuentaBancaria && x.IdConciliacion != mIdConciliacion).Select(x => x.IdConciliacion).FirstOrDefault();
            if (Conciliaciones > 0) { sErrorMsg += "\n" + "El numero de resumen ya existe."; }

            if (o.DetalleConciliacionesContables.Count <= 0) sErrorMsg += "\n" + "El resumen no puede estar vacio";

            if (o.FechaIngreso == null) { sErrorMsg += "\n" + "Falta la fecha de ingreso"; }
            if (o.FechaInicial == null) { sErrorMsg += "\n" + "Falta la fecha inicial"; }
            if (o.FechaFinal == null) { sErrorMsg += "\n" + "Falta la fecha final"; }

            foreach (var d in o.DetalleConciliacionesContables)
            {
                if ((d.Conciliado ?? "SI") == "SI")
                {
                    mIdValor = d.IdValor ?? 0;
                    var det = o.DetalleConciliacionesContables.Where(x => (x.IdValor ?? 0) == mIdValor && (x.Conciliado ?? "SI") != "SI").Select(x => x.IdConciliacion).FirstOrDefault();
                    if (det > 0) {
                        Valore valor = db.Valores.Where(c => c.IdValor == mIdValor).SingleOrDefault();
                        if (valor != null) { mNumeroValor = valor.NumeroValor ?? 0; }
                        sErrorMsg += "\n" + "El numero de valor " + mNumeroValor.ToString() + " esta en la lista dentro y fuera del extracto simultaneamente."; 
                    }
                }
            }


            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
            sWarningMsg = sWarningMsg.Replace("\n", "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.Conciliacione Conciliacion)
        {
            if (!PuedeEditar(enumNodos.Conciliaciones)) throw new Exception("No tenés permisos");

            try
            {
                Int32 mIdConciliacion = 0;
                Int32 mIdAprobo = 0;
                Int32 mIdValor = 0;

                //decimal mTotalValores = 0;

                string mConciliado = "";
                string errs = "";
                string warnings = "";

                //bool mAnulado = false;

                Valore v;

                if (!Validar(Conciliacion, ref errs, ref warnings))
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
                    using (TransactionScope scope = new TransactionScope())
                    {
                        mIdConciliacion = Conciliacion.IdConciliacion;
                        mIdAprobo = Conciliacion.IdAprobo ?? 0;

                        if (mIdConciliacion > 0)
                        {
                            var EntidadOriginal = db.Conciliaciones.Where(p => p.IdConciliacion == mIdConciliacion).SingleOrDefault();

                            var EntidadoEntry = db.Entry(EntidadOriginal);
                            EntidadoEntry.CurrentValues.SetValues(Conciliacion);

                            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        else
                        {
                            db.Conciliaciones.Add(Conciliacion);
                            db.SaveChanges();
                        }

                        ////////////////////////////////////////////// VALORES //////////////////////////////////////////////
                        foreach (var d in Conciliacion.DetalleConciliacionesContables)
                        {
                            mConciliado = d.Conciliado ?? "SI";
                        
                            mIdValor = d.IdValor ?? -1;
                            v = db.Valores.Where(c => c.IdValor == mIdValor).SingleOrDefault();
                            if (v != null)
                            {
                                if (mIdAprobo > 0)
                                {
                                    if (mConciliado == "SI")
                                    {
                                        v.Conciliado = "SI";
                                        v.MovimientoConfirmadoBanco = "SI";
                                        v.FechaConfirmacionBanco = v.FechaConfirmacionBanco ?? Conciliacion.FechaFinal;
                                        v.IdUsuarioConfirmacionBanco = v.IdUsuarioConfirmacionBanco ?? mIdAprobo;
                                        v.IdConciliacion = mIdConciliacion;
                                    }
                                    else
                                    {
                                        var det = db.DetalleConciliacionesContables.Where(x => (x.IdValor ?? 0) == mIdValor && (x.Conciliado ?? "SI") == "SI").Select(x => x.IdConciliacion).FirstOrDefault();
                                        if (det == 0)
                                        {
                                            v.MovimientoConfirmadoBanco = "NO";
                                            v.FechaConfirmacionBanco = null;
                                        }
                                    }
                                }
                                else
                                {
                                    if (mConciliado == "SI")
                                    {
                                        v.MovimientoConfirmadoBanco = "SI";
                                        v.FechaConfirmacionBanco = v.FechaConfirmacionBanco ?? Conciliacion.FechaFinal;
                                    }
                                }
                                
                                db.Entry(v).State = System.Data.Entity.EntityState.Modified;
                            }
                        }
                        db.SaveChanges();

                        //db.Tree_TX_Actualizar(Tree_TX_ActualizarParam.ConciliacionesAgrupados.ToString(), Conciliacion.IdConciliacion, "Conciliacion");

                        scope.Complete();
                        scope.Dispose();
                    }

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdConciliacion = Conciliacion.IdConciliacion, ex = "" });
                }
                else
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El comprobante tiene datos invalidos";

                    return Json(res);
                }
            }

            catch (TransactionAbortedException ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;
                return Json("TransactionAbortedException Message: {0}", ex.Message);
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

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var data = (from a in db.Conciliaciones
                        from b in db.CuentasBancarias.Where(y => y.IdCuentaBancaria == a.IdCuentaBancaria).DefaultIfEmpty()
                        from c in db.Bancos.Where(y => y.IdBanco == b.IdBanco).DefaultIfEmpty()
                        from d in db.Empleados.Where(y => y.IdEmpleado == a.IdRealizo).DefaultIfEmpty()
                        from e in db.Empleados.Where(y => y.IdEmpleado == a.IdAprobo).DefaultIfEmpty()
                        select new
                        {
                            a.IdConciliacion,
                            a.IdCuentaBancaria,
                            a.IdRealizo,
                            a.IdAprobo,
                            Banco = c != null ? c.Nombre : "",
                            CuentaBancaria = b != null ? b.Cuenta : "",
                            a.FechaIngreso,
                            a.FechaInicial,
                            a.FechaFinal,
                            a.Numero,
                            a.SaldoInicialResumen,
                            a.SaldoFinalResumen,
                            a.ImporteAjuste,
                            a.Observaciones,
                            Realizo = d != null ? d.Nombre : "",
                            Aprobo = e != null ? e.Nombre : "",
                        }).AsQueryable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaFinal >= FechaDesde && a.FechaFinal <= FechaHasta select a).AsQueryable();
            }

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a).OrderBy(x => x.Banco).ThenBy(x => x.CuentaBancaria).ThenBy(x => x.FechaIngreso).ThenBy(x => x.Numero)
            //.Skip((currentPage - 1) * pageSize).Take(pageSize)
            .ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data1
                        select new jqGridRowJson
                        {
                            id = a.IdConciliacion.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdConciliacion} ) + ">Editar</>",
                                a.IdConciliacion.ToString(),
                                a.IdCuentaBancaria.NullSafeToString(),
                                a.IdRealizo.NullSafeToString(),
                                a.IdAprobo.NullSafeToString(),
                                a.Banco.NullSafeToString(),
                                a.CuentaBancaria.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaInicial == null ? "" : a.FechaInicial.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaFinal == null ? "" : a.FechaFinal.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Numero.NullSafeToString(),
                                a.SaldoInicialResumen.NullSafeToString(),
                                a.SaldoFinalResumen.NullSafeToString(),
                                a.ImporteAjuste.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.Realizo.NullSafeToString(),
                                a.Aprobo.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetConciliacionesConciliados(string sidx, string sord, int? page, int? rows, int IdConciliacion)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "DetConciliaciones_TX_Conciliados", IdConciliacion);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdDetalleConciliacion = a[0],
                            IdConciliacion = a[1],
                            TipoValor = a[2],
                            IdValor = a[3],
                            NumeroValor = (a[4].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[4].NullSafeToString()),
                            NumeroInterno = (a[5].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[5].NullSafeToString()),
                            FechaValor = a[6],
                            FechaDeposito = a[7],
                            NumeroDeposito = (a[8].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[8].NullSafeToString()),
                            Ingresos = (a[9].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[9].NullSafeToString()),
                            Egresos = (a[10].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[10].NullSafeToString()),
                            Iva = (a[11].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[11].NullSafeToString()),
                            BancoOrigen = a[12],
                            Tipo = a[13],
                            NumeroComprobante = (a[14].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[14].NullSafeToString()),
                            FechaComprobante = a[15],
                            Cliente = a[16],
                            Proveedor = a[17],
                            TotalIngresos = (a[18].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[18].NullSafeToString()),
                            TotalEgresos = (a[19].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[19].NullSafeToString()),
                            Controlado = a[20],
                            ControladoNoConciliado = a[22],
                            Cuenta = a[23]
                        }).OrderBy(s => s.IdDetalleConciliacion)
                        //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleConciliacion.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleConciliacion.ToString(), 
                            a.IdConciliacion.NullSafeToString(),
                            a.TipoValor.NullSafeToString(),
                            a.IdValor.NullSafeToString(),
                            a.NumeroValor.NullSafeToString(),
                            a.NumeroInterno.NullSafeToString(),
                            a.FechaValor.ToString(),
                            a.FechaDeposito.ToString(),
                            a.NumeroDeposito.ToString(),
                            a.Ingresos.ToString(),
                            a.Egresos.ToString(),
                            a.Iva.ToString(),
                            a.BancoOrigen.ToString(),
                            a.Tipo.ToString(),
                            a.NumeroComprobante.ToString(),
                            a.FechaComprobante.ToString(),
                            a.Cliente.ToString(),
                            a.Proveedor.ToString(),
                            a.TotalIngresos.ToString(),
                            a.TotalEgresos.ToString(),
                            a.Controlado.ToString(),
                            a.ControladoNoConciliado.ToString(),
                            a.Cuenta.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetConciliacionesNoConciliados(string sidx, string sord, int? page, int? rows, int IdConciliacion)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "DetConciliaciones_TX_NoConciliados", IdConciliacion);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdDetalleConciliacion = a[0],
                            IdConciliacion = a[1],
                            TipoValor = a[2],
                            IdValor = a[3],
                            NumeroValor = (a[4].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[4].NullSafeToString()),
                            NumeroInterno = (a[5].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[5].NullSafeToString()),
                            FechaValor = a[6],
                            FechaDeposito = a[7],
                            NumeroDeposito = (a[8].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[8].NullSafeToString()),
                            Ingresos = (a[9].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[9].NullSafeToString()),
                            Egresos = (a[10].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[10].NullSafeToString()),
                            Iva = (a[11].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[11].NullSafeToString()),
                            BancoOrigen = a[12],
                            Tipo = a[13],
                            NumeroComprobante = (a[14].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[14].NullSafeToString()),
                            FechaComprobante = a[15],
                            Cliente = a[16],
                            Proveedor = a[17],
                            TotalIngresos = (a[18].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[18].NullSafeToString()),
                            TotalEgresos = (a[19].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[19].NullSafeToString()),
                            Controlado = a[20],
                            ControladoNoConciliado = a[22],
                            Cuenta = a[23]
                        }).OrderBy(s => s.IdDetalleConciliacion)
                        //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleConciliacion.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleConciliacion.ToString(), 
                            a.IdConciliacion.NullSafeToString(),
                            a.TipoValor.NullSafeToString(),
                            a.IdValor.NullSafeToString(),
                            a.NumeroValor.NullSafeToString(),
                            a.NumeroInterno.NullSafeToString(),
                            a.FechaValor.ToString(),
                            a.FechaDeposito.ToString(),
                            a.NumeroDeposito.ToString(),
                            a.Ingresos.ToString(),
                            a.Egresos.ToString(),
                            a.Iva.ToString(),
                            a.BancoOrigen.ToString(),
                            a.Tipo.ToString(),
                            a.NumeroComprobante.ToString(),
                            a.FechaComprobante.ToString(),
                            a.Cliente.ToString(),
                            a.Proveedor.ToString(),
                            a.TotalIngresos.ToString(),
                            a.TotalEgresos.ToString(),
                            a.Controlado.ToString(),
                            a.ControladoNoConciliado.ToString(),
                            a.Cuenta.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetConciliacionesNoContables(string sidx, string sord, int? page, int? rows, int IdConciliacion)
        {
            var Det = db.DetalleConciliacionesNoContables.Where(p => p.IdConciliacion == IdConciliacion).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        select new
                        {
                            a.IdDetalleConciliacionNoContable,
                            a.IdConciliacion,
                            a.Detalle,
                            a.Ingresos,
                            a.Egresos,
                            a.FechaIngreso,
                            a.FechaCaducidad,
                            a.FechaRegistroContable
                        }).OrderBy(x => x.IdDetalleConciliacionNoContable)
                        //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleConciliacionNoContable.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleConciliacionNoContable.ToString(), 
                            a.IdConciliacion.ToString(), 
                            a.Detalle.ToString(), 
                            a.Ingresos.ToString(), 
                            a.Egresos.ToString(), 
                            a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.FechaCaducidad == null ? "" : a.FechaCaducidad.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.FechaRegistroContable == null ? "" : a.FechaRegistroContable.GetValueOrDefault().ToString("dd/MM/yyyy")
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdConciliacion, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
        {
            switch (oper)
            {
                case "add": //Validate Input ; Add Method
                    break;
                case "edit":  //Validate Input ; Edit Method
                    break;
                case "del": //Validate Input ; Delete Method
                    break;
                default: break;
            }
        }

        [HttpPost]
        public virtual ActionResult Uploadfile(System.ComponentModel.Container containers, HttpPostedFileBase file)
        {

            if (file.ContentLength > 0)
            {
                var fileName = System.IO.Path.GetFileName(file.FileName);
                var path = ""; //  = System.IO.Path.Combine(Server.MapPath("~/App_Data/Uploads"), containers.ContainerNo);
                file.SaveAs(path);
            }

            return RedirectToAction("Index");
        }

    }

}