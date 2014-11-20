using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
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
                            Banco = b != null ? b.Nombre : "",
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
                                a.Banco,
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
    }

}
