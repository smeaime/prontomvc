using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Text;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using ProntoMVC.Data.Models; 
using ProntoMVC.Models;
using Pronto.ERP.Bll;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;
using OpenXmlPowerTools;
using ClosedXML.Excel;

namespace ProntoMVC.Controllers
{
    public partial class RubroContableController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.RubrosContables)) throw new Exception("No tenés permisos");

            return View();
        }
        public virtual ViewResult IndexExterno()
        {
            if (!PuedeLeer(enumNodos.RubrosContables)) throw new Exception("No tenés permisos");

            return View();
        }
        public virtual ActionResult GetRubrosContables()
        {
            Dictionary<int, string> rubrocontable = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.RubrosContable u in db.RubrosContables.OrderBy(x => x.Descripcion).ToList())
                rubrocontable.Add(u.IdRubroContable, u.Descripcion);

            return PartialView("Select", rubrocontable);
        }

        public virtual ActionResult Edit(int id)
        {
            RubrosContable o;
            if (id <= 0)
            {
                o = new RubrosContable();
            }
            else
            {
                o = db.RubrosContables.SingleOrDefault(x => x.IdRubroContable == id);
            }
            CargarViewBag(o);
            return View(o);
        }

        void CargarViewBag(RubrosContable o)
        {
            Parametros parametros = db.Parametros.Find(1);
            int? i = parametros.IdTipoCuentaGrupoFF;

            //ViewBag.IdCliente = new SelectList(db.Clientes, "IdCliente", "RazonSocial", o.IdCliente);
            //ViewBag.IdUnidadOperativa = new SelectList(db.UnidadesOperativas, "IdUnidadOperativa", "Descripcion", o.IdUnidadOperativa);
            //ViewBag.IdGrupoObra = new SelectList(db.GruposObras, "IdGrupoObra", "Descripcion", o.IdGrupoObra);
            //ViewBag.IdMonedaValorObra = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMonedaValorObra);
            //ViewBag.IdCuentaContableFF = new SelectList(db.Cuentas.Where(x => (x.IdTipoCuenta == 2 || x.IdTipoCuenta == 4) && x.IdTipoCuentaGrupo == i).OrderBy(x => x.Codigo), "IdCuenta", "Descripcion", o.IdCuentaContableFF);
            //ViewBag.IdProvincia = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvincia);
            //ViewBag.IdPais = new SelectList(db.Paises, "IdPais", "Descripcion", o.IdPais);
            //ViewBag.IdJefeRegional = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdJefeRegional);
            //ViewBag.IdJefe = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdJefe);
            //ViewBag.IdSubjefe = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdSubjefe);

        }

        public bool Validar(ProntoMVC.Data.Models.RubrosContable o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            Int32 mMaxLength = 0;
            string mProntoIni = "";
            string mExigirCUIT = "";
            Boolean result;

            //if (o.Nombre.NullSafeToString() == "")
            //{
            //    sErrorMsg += "\n" + "Falta el nombre";
            //}
            //else
            //{
            //    mMaxLength = GetMaxLength<Localidad>(x => x.Nombre) ?? 0;
            //    if (o.Nombre.Length > mMaxLength) { sErrorMsg += "\n" + "El nombre de la localidad no puede tener mas de " + mMaxLength + " digitos"; }
            //}

            //if ((o.IdProvincia ?? 0) == 0) { sErrorMsg += "\n" + "Falta la provincia"; }

            //if ((o.Codigo ?? 0) == 0) { sErrorMsg += "\n" + "Falta el codigo"; }
            if ((o.Descripcion ?? "") == "") { sErrorMsg += "\n" + "Falta la descripcion"; }

            if (sErrorMsg != "") return false;
            else return true;
        }


        public virtual JsonResult BatchUpdate(RubrosContable RubrosContable)
        {
            if (!PuedeEditar(enumNodos.RubrosContables)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(RubrosContable, ref errs))
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
                    if (RubrosContable.IdRubroContable > 0)
                    {
                        var EntidadOriginal = db.RubrosContables.Where(p => p.IdRubroContable == RubrosContable.IdRubroContable).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(RubrosContable);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.RubrosContables.Add(RubrosContable);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdLocalidad = RubrosContable.IdRubroContable, ex = "" });
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

        public virtual ActionResult RubrosContables_DynamicGridData
    (string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            string campo = String.Empty;
            //int pageSize = rows ?? 20;
            int currentPage = page; // ?? 1;

            // var Entidad = db.Presupuestos.AsQueryable();


            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.RubrosContable>
                                ("",
                                sidx, sord, page, rows, _search, filters, db, ref totalRecords
                                 );
            //DetalleRequerimientos.DetallePedidos, DetalleRequerimientos.DetallePresupuestos
            //"Obra,DetalleRequerimientos.DetallePedidos.Pedido,DetalleRequerimientos.DetallePresupuestos.Presupuesto"
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






            //int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)rows);

            

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in pagedQuery.ToList()
                        select new jqGridRowJson
                        {
                            id = a.IdRubroContable.ToString(),
                            cell = new string[] { 
                                "", // "<a href="+ Url.Action("Edit",new {id = a.IdRubroContable} ) + " target='' >Editar</>" ,
								// +"|"+"<a href=../Presupuesto/Edit/" + a.IdPresupuesto + "?code=1" + ">Detalles</a> ",
                                a.IdRubroContable.ToString(), 
                                a.Codigo.NullSafeToString(),
                                a.Descripcion.NullSafeToString(),

                                a.CodigoAgrupacion.NullSafeToString(),
                                (a.DistribuirGastosEnResumen=="SI").NullSafeToString(),
                                (a.TomarMesDeVentaEnResumen=="SI").NullSafeToString(),
                                (a.TiposRubrosFinancierosGrupos==null) ?  "" :  a.TiposRubrosFinancierosGrupos.Descripcion.NullSafeToString(),

                                (a.Cuenta==null) ?  "" :  a.Cuenta.Descripcion,
                                //a.Cuenta.Descripcion.NullSafeToString(),
                                (a.Obra==null) ?  "" :  a.Obra.Descripcion.NullSafeToString(),
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        public virtual ActionResult GetTiposRubrosFinancierosGrupos()
        {
            Dictionary<int, string> provincias = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.TiposRubrosFinancierosGrupos u in db.TiposRubrosFinancierosGrupos.OrderBy(x => x.Descripcion).ToList())
                provincias.Add(u.IdTipoRubroFinancieroGrupo, u.Descripcion);

            return PartialView("Select", provincias);
        }

    }
}
