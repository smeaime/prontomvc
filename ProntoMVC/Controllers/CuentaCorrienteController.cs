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
using ProntoMVC.Data.Models; using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Web.Security;

namespace ProntoMVC.Controllers
{
    public partial class CuentaCorrienteController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin") &&
                !Roles.IsUserInRole(Membership.GetUser().UserName, "Administrador")
                ) throw new Exception("No tenés permisos");
            return View();
        }
        public virtual ViewResult IndexExterno()
        {
            return View();
        }

        // /////////////////////////////////////////// ACREEDORES //////////////////////////////////////////////

        public virtual ActionResult CuentaCorrienteAcreedorPendiente(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 50;
            int currentPage = page ?? 1;

            int idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)Membership.GetUser().ProviderUserKey));

            //var Entidad = db.CuentasCorrientesAcreedores.AsQueryable();
            //Entidad = Entidad.Where(p => p.IdProveedor == idproveedor).AsQueryable();

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var pendiente = "S"; //hay que usar S para traer solo lo pendiente
            if (true)
            {
                idproveedor = 2;
                pendiente = "N"; // "N"
            }
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC,"CtasCtesA_TXPorTrs", idproveedor, -1, DateTime.Now, null, null, pendiente);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                // Entidad = (from a in Entidad where a.FechaIngreso >= FechaDesde && a.FechaIngreso <= FechaHasta select a).AsQueryable();
            }
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numero":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaingreso":
                        //No anda
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                    default:
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                }
            }
            else
            {
                campo = "true";
            }

            // var Entidad1 = (from a in Entidad select new { IdPresupuesto = a.IdCtaCte }).Where(campo);

            int totalRecords = Entidad.Count();  // Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdCtaCte = a[0],
                            IdImputacion = (a[1].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[1].NullSafeToString()),
                            a2 = a[2],
                            a3 = a[3],
                            a4 = a[4],
                            Numero = a[5],
                            a6 = a[6],
                            fecha = a[7],
                            a8 = a[8],
                            a9 = a[9],
                            a10 = a[10],
                            a11 = a[11],
                            a12 = a[12],
                            a13 = a[13],
                            a14 = a[14],
                            Cabeza = a[15],
                            a16 = a[16],
                            a17 = a[17]
                        }).OrderBy(s => s.IdImputacion).ThenBy(s => s.Cabeza).ThenBy(s => s.fecha).ThenBy(s => s.Numero)
                          .Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdCtaCte.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("EditExterno",new {id = a.IdCtaCte} ) + " target='' >Editar</>" 
                                 +"|"+"<a href=../Presupuesto/EditExterno/" + a.IdCtaCte + "?code=1" + ">Detalles</a> ",
                                      
                                 a.IdCtaCte.ToString(),
                                 a.IdImputacion.ToString(),
                                 a.a2.ToString(),
                                 a.a3.ToString(),
                                 a.a4.ToString(),
                                 a.Numero.ToString(),
                                 a.a6.ToString(),
                                 a.fecha.ToString(),
                                 a.a8.ToString(),
                                 a.a9.ToString(),
                                 a.a10.ToString(),
                                 a.a11.ToString(),
                                 a.a12.ToString(),
                                 a.a13.ToString(),
                                 a.a14.ToString(),
                                 a.Cabeza.ToString(),
                                 a.a16.ToString(),
                                 a.a17.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult CuentaCorrienteAcreedorPendientePorProveedor(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, int? IdProveedor)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 50;
            int currentPage = page ?? 1;
            IdProveedor = IdProveedor ?? -1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var pendiente = "S"; 
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "CtasCtesA_TXPorTrs", IdProveedor, -1, DateTime.Now, null, null, pendiente);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numero":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaingreso":
                        //No anda
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                    default:
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                }
            }
            else
            {
                campo = "true";
            }

            int totalRecords = Entidad.Count();  // Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdCtaCte = a[0],
                            IdImputacion = (a[1].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[1].NullSafeToString()),
                            Tipo = a[2],
                            IdTipoComp = a[3],
                            IdComprobante = a[4],
                            Numero = a[5],
                            Referencia = a[6],
                            Fecha = a[7],
                            FechaVencimiento = a[8],
                            ImporteTotal = a[9],
                            Saldo = a[10],
                            SaldoTrs = a[11],
                            FechaComprobante = a[12],
                            IdImputacion2 = a[13],
                            Saldo2 = a[14],
                            Cabeza = a[15],
                            Moneda = a[16],
                            Observaciones = a[17]
                        }).OrderBy(s => s.IdImputacion).ThenBy(s => s.Cabeza).ThenBy(s => s.Fecha).ThenBy(s => s.Numero)
                          .Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdCtaCte.ToString(),
                            cell = new string[] { 
                                string.Empty,
                                a.IdCtaCte.ToString(),
                                a.IdImputacion.ToString(),
                                a.IdTipoComp.ToString(),
                                a.IdComprobante.ToString(),
                                a.Cabeza.ToString(),
                                a.Tipo.ToString(),
                                a.Numero.ToString(),
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.FechaVencimiento == null || a.FechaVencimiento.ToString() == "" ? "" : Convert.ToDateTime(a.FechaVencimiento.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.Moneda.ToString(),
                                a.ImporteTotal.ToString(),
                                a.Saldo.ToString(),
                                a.SaldoTrs.ToString(),
                                a.Observaciones.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult TraerUno(int IdCtaCte)
        {
            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "CtasCtesA_TX_PorIdConDatos", IdCtaCte);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            var data = (from a in Entidad
                        select new
                        {
                            IdCtaCte = a["IdCtaCte"],
                            IdImputacion = (a["IdImputacion"].NullSafeToString() == "") ? 0 : Convert.ToInt32(a["IdImputacion"].NullSafeToString()),
                            Tipo = a["Tipo"],
                            Numero = a["Numero"],
                            Fecha = a["Fecha"],
                            ImporteOriginal = a["ImporteTotal"],
                            Saldo = a["Saldo"],
                            ImportePagadoSinImpuestos = a["SinImpuestos"],
                            IvaTotal = a["TotalIva"],
                            TotalComprobante = a["TotalComprobante"],
                            BienesYServicios = a["BoS"],
                            NumeroOrdenPagoRetencionIVA = a["NumeroOrdenPagoRetencionIVA"],
                            IdTipoRetencionGanancia = a["IdTipoRetencionGanancia"],
                            IdIBCondicion = a["IdIBCondicion"],
                            BaseCalculoIIBB = a["BaseCalculoIIBB"],
                            FechaVencimiento = a["FechaVencimiento"],
                            FechaComprobante = a["FechaComprobante"],
                            GravadoIVA = a["GravadoIVA"],
                            CotizacionMoneda = a["CotizacionMoneda"],
                            PorcentajeIVAParaMonotributistas = a["PorcentajeIVAParaMonotributistas"],
                            IdTipoComp = a["IdTipoComp"],
                            IdComprobante = a["IdComprobante"],
                            CertificadoPoliza = a["CertificadoPoliza"],
                            NumeroEndosoPoliza = a["NumeroEndosoPoliza"],
                            Importe = a["Saldo"]
                        }).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }


        // /////////////////////////////////////////// DEUDORES //////////////////////////////////////////////

        public virtual ActionResult CuentaCorrienteDeudoresPendientePorCliente(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, int? IdCliente)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 50;
            int currentPage = page ?? 1;
            IdCliente = IdCliente ?? -1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var pendiente = "S";
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "CtasCtesD_TXPorTrs", IdCliente, -1, DateTime.Now, DateTime.Now, -1, pendiente);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numero":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaingreso":
                        //No anda
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                    default:
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                }
            }
            else
            {
                campo = "true";
            }

            int totalRecords = Entidad.Count();  
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdCtaCte = a[0],
                            IdImputacion = (a[1].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[1].NullSafeToString()),
                            Tipo = a[2],
                            IdTipoComp = a[3],
                            IdComprobante = a[4],
                            Numero = a[5],
                            Fecha = a[6],
                            FechaVencimiento = a[7],
                            ImporteTotal = a[8],
                            Saldo = a[9],
                            SaldoTrs = a[10],
                            Observaciones = a[11],
                            Cabeza = a[12],
                            IdImputacion2 = a[13],
                            Moneda = a[18]
                        }).OrderBy(s => s.IdImputacion).ThenBy(s => s.Cabeza).ThenBy(s => s.Fecha).ThenBy(s => s.Numero).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdCtaCte.ToString(),
                            cell = new string[] { 
                                string.Empty,
                                a.IdCtaCte.ToString(),
                                a.IdImputacion.ToString(),
                                a.IdTipoComp.ToString(),
                                a.IdComprobante.ToString(),
                                a.Cabeza.ToString(),
                                a.Tipo.ToString(),
                                a.Numero.ToString(),
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.FechaVencimiento == null || a.FechaVencimiento.ToString() == "" ? "" : Convert.ToDateTime(a.FechaVencimiento.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.Moneda.ToString(),
                                a.ImporteTotal.ToString(),
                                a.Saldo.ToString(),
                                a.SaldoTrs.ToString(),
                                a.Observaciones.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult TraerUnoDeudor(int IdCtaCte)
        {
            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "CtasCtesD_TX_PorIdConDatos", IdCtaCte);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            var data = (from a in Entidad
                        select new
                        {
                            IdCtaCte = a["IdCtaCte"],
                            IdImputacion = (a["IdImputacion"].NullSafeToString() == "") ? 0 : Convert.ToInt32(a["IdImputacion"].NullSafeToString()),
                            Tipo = a["Tipo"],
                            Numero = a["Numero"],
                            Fecha = a["Fecha"],
                            ImporteOriginal = a["ImporteTotal"],
                            Saldo = a["Saldo"],
                            FechaVencimiento = a["FechaVencimiento"],
                            CotizacionMoneda = a["CotizacionMoneda"],
                            IdTipoComp = a["IdTipoComp"],
                            IdComprobante = a["IdComprobante"],
                            Importe = a["Saldo"]
                        }).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        
        [HttpPost]
        public void EditGridData(int? IdRequerimiento, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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

        protected override void Dispose(bool disposing)
        {
            if (db != null) db.Dispose();
            base.Dispose(disposing);
        }
    }
}