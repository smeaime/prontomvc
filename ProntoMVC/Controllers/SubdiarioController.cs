using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
//using System.Data.Entity.Core.Objects.ObjectQuery; //using System.Data.Objects;
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
    public partial class SubdiarioController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Subdiarios)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult Edit()
        {
            if (!PuedeLeer(enumNodos.Subdiarios)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var data = (from a in db.Subdiarios
                        from b in db.Titulos.Where(y => y.IdTitulo == a.IdCuentaSubdiario).DefaultIfEmpty()
                        select new
                        {
                            a.IdCuentaSubdiario,
                            Subdiario = b != null ? b.Titulo1 : "",
                            a.FechaComprobante,
                            Año = a.FechaComprobante.Value.Year,
                            Mes = a.FechaComprobante.Value.Month,
                            Debe = a.Debe != null ? a.Debe : 0,
                            Haber = a.Haber != null ? a.Haber : 0
                        }).AsQueryable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaComprobante >= FechaDesde && a.FechaComprobante <= FechaHasta select a).AsQueryable();
            }

            var data1 = (from r in data
                         group r by new
                         {  r.IdCuentaSubdiario,
                            r.Subdiario,
                            r.Año,
                            r.Mes
                            } into g
                            select new {
                                g.Key.IdCuentaSubdiario,
                                g.Key.Subdiario,
                                g.Key.Año,
                                g.Key.Mes,
                                Debe = g.Sum(x => x.Debe),
                                Haber = g.Sum(x => x.Haber),
                                Diferencia = g.Sum(x => x.Debe - x.Haber)
                            }).ToList();

            int totalRecords = data1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data1
                        select new jqGridRowJson
                        {
                            id = 1.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {IdCuentaSubdiario = a.IdCuentaSubdiario, Año = a.Año, Mes = a.Mes, Subdiario = a.Subdiario} ) + ">Ver</>",
                                a.Año.ToString(),
                                a.Mes.ToString(),
                                a.Subdiario.ToString(),
                                a.Debe.NullSafeToString(),
                                a.Haber.NullSafeToString(),
                                a.Diferencia.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Detalle(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string IdCuentaSubdiario, string Año, string Mes)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Subdiarios_TXSub", Mes, Año, IdCuentaSubdiario); // "FI", "EN", "CA"

            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count(); 
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdSubdiario = a[0],
                            IdCuentaSubdiario = a[1],
                            IdCuenta = a[2],
                            Codigo = a[3],
                            IdTipoComprobante = a[4],
                            IdComprobante = a[5],
                            Cuenta = a[6],
                            TipoComprobante = a[7],
                            Numero = a[8],
                            Fecha = a[9],
                            Formulario = (a[4].NullSafeToString() == "1") ? "Factura Venta" : ((a[4].NullSafeToString() == "2") ? "Recibo" : ((a[4].NullSafeToString() == "3") ? "Nota Debito" : ((a[4].NullSafeToString() == "4") ? "Nota Credito" : ((a[4].NullSafeToString() == "5") ? "Devolucion" : ((a[4].NullSafeToString() == "17") ? "Orden Pago" : ((a[4].NullSafeToString() == "28") ? "Gasto Bancario" : ((a[4].NullSafeToString() == "29") ? "Gasto Bancario" : ((a[4].NullSafeToString() == "39") ? "Plazo Fijo" : ((a[4].NullSafeToString() == "50") ? "Salida Materiales" : ((a[4].NullSafeToString() == "60") ? "Recepcion" : ((a[4].NullSafeToString() == "14") ? "Deposito" : "Comprobante Proveedores"))))))))))),
                            Debe = a[10],
                            Haber = a[11],
                            Detalle = a[12]
                        }).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdSubdiario.ToString(),
                            cell = new string[] { 
                                a.IdSubdiario.NullSafeToString(),
                                a.IdCuentaSubdiario.NullSafeToString(),
                                a.IdCuenta.NullSafeToString(),
                                a.Codigo.NullSafeToString(),
                                a.IdTipoComprobante.NullSafeToString(),
                                a.IdComprobante.NullSafeToString(),
                                a.Cuenta.NullSafeToString(),  
                                a.TipoComprobante.NullSafeToString(),  
                                a.Numero.NullSafeToString() ,  
                                a.Fecha.NullSafeToString(),
                                "<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=" +a.Formulario + "&Id=" + a.IdComprobante + "'>Ver comprobante</a>",  //"Certificado%20IVA&Id="
                                a.Debe.NullSafeToString(),
                                a.Haber.NullSafeToString(),
                                a.Detalle.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdOtroIngresoAlmacen, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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

    }

}