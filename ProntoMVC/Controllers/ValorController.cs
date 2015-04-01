using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
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
    public partial class ValorController : ProntoBaseController
    {
        public virtual ActionResult ValoresEnCartera(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Valores.Where(p => p.Estado == null && p.IdTipoComprobante != 17 && p.TiposComprobante1.Agrupacion1 == "CHEQUES").AsQueryable();

            var data = (from a in Entidad
                        from b in db.Bancos.Where(o => o.IdBanco == a.IdBanco).DefaultIfEmpty()
                        from c in db.Clientes.Where(o => o.IdCliente == a.IdCliente).DefaultIfEmpty()
                        select new
                        {
                            a.IdValor,
                            Tipo = a.TiposComprobante.DescripcionAb,
                            a.NumeroInterno,
                            a.NumeroValor,
                            a.FechaValor,
                            Entidad = b != null ? b.Nombre : "",
                            a.Importe,
                            TipoComprobante = a.TiposComprobante1.DescripcionAb,
                            a.NumeroComprobante,
                            a.FechaComprobante,
                            Cliente = c.RazonSocial
                        }).OrderBy(x => x.FechaValor).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdValor.ToString(),
                            cell = new string[] { 
                                string.Empty,
                                a.IdValor.ToString(),
                                a.Tipo,
                                a.NumeroInterno.ToString(),
                                a.NumeroValor.ToString(),
                                a.FechaValor == null ? "" : a.FechaValor.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Entidad,
                                a.Importe.ToString(),
                                a.TipoComprobante,
                                a.NumeroComprobante.ToString(),
                                a.FechaComprobante == null ? "" : a.FechaComprobante.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Cliente
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult TraerUno(int IdValor)
        {
            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Valores_TX_PorIdConDatos", IdValor);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            var data = (from a in Entidad
                        select new
                        {
                            IdValor = a["IdValor"],
                            Tipo = a["Tipo"],
                            NumeroInterno = a["NumeroInterno"],
                            NumeroValor = a["NumeroValor"],
                            FechaValor = a["FechaValor"],
                            Entidad = a["Banco"],
                            Importe = a["Importe"],
                            TipoComprobante = a["TipoComprobante"],
                            NumeroComprobante = a["NumeroComprobante"],
                            FechaComprobante = a["FechaComprobante"],
                            Cliente = a["Entidad"]
                        }).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetTiposValores()
        {
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();
            foreach (Data.Models.TiposComprobante u in db.TiposComprobantes.Where(x => x.EsValor == "SI").OrderBy(x => x.Descripcion).ToList())
                Datacombo.Add(u.IdTipoComprobante, u.DescripcionAb);
            return PartialView("Select", Datacombo);
        }
    }
}
