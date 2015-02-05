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
using System.Transactions;
using System.Reflection;
using System.Web.Security;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using Newtonsoft.Json;
using Pronto.ERP.Bll;

namespace ProntoMVC.Controllers
{
    public partial class NotaCreditoController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin") &&
                !Roles.IsUserInRole(Membership.GetUser().UserName, "Administrador") &&
               !Roles.IsUserInRole(Membership.GetUser().UserName, "Compras")
                ) throw new Exception("No tenés permisos");

            return View();
        }
        public virtual ActionResult Edit(int id)
        {

            if (!Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin") &&
               !Roles.IsUserInRole(Membership.GetUser().UserName, "Administrador") &&
               !Roles.IsUserInRole(Membership.GetUser().UserName, "Compras")
               ) throw new Exception("No tenés permisos");

            if (id == -1)
            {
                NotasCredito NotaCredito = new NotasCredito();

                inic(ref NotaCredito);
                CargarViewBag(NotaCredito);
                return View(NotaCredito);
            }
            else
            {
                NotasCredito NotaCredito = db.NotasCreditoes.Find(id);

                CargarViewBag(NotaCredito);
                Session.Add("NotaCredito", NotaCredito);
                return View(NotaCredito);
            }
        }

        public virtual ActionResult Delete(int id)
        {
            NotasCredito NotaCredito = db.NotasCreditoes.Find(id);
            return View(NotaCredito);
        }

        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            NotasCredito NotaCredito = db.NotasCreditoes.Find(id);
            db.NotasCreditoes.Remove(NotaCredito);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        void inic(ref NotasCredito o)
        {
            Parametros parametros = db.Parametros.Find(1);

            Int32 mIdMonedaDolar;
            Int32 mIdMonedaEuro;

            mIdMonedaDolar = parametros.IdMonedaDolar ?? 0;
            mIdMonedaEuro = parametros.IdMonedaEuro ?? 0;

            o.CtaCte = "SI";
            o.AplicarEnCtaCte = "SI";
            o.PorcentajeIva1 = parametros.Iva1;
            o.IdMoneda = 1;
            o.CotizacionMoneda = 1;
            o.FechaIngreso = DateTime.Today;
            o.FechaNotaCredito = DateTime.Today;

            Cotizacione Cotizaciones = db.Cotizaciones.Where(x => x.IdMoneda == mIdMonedaDolar && x.Fecha == DateTime.Today).FirstOrDefault();
            if (Cotizaciones != null) { o.CotizacionDolar = Cotizaciones.Cotizacion ?? 0; }
        }

        class DatosJson
        {
            public string campo1 { get; set; }
            public string campo2 { get; set; }
            public string campo3 { get; set; }
            public string campo4 { get; set; }
            public string campo5 { get; set; }
        }

        void CargarViewBag(NotasCredito o)
        {
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdIBCondicion = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);
            ViewBag.IdIBCondicion2 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion2);
            ViewBag.IdIBCondicion3 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion3);
            ViewBag.IdObra = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra);
            ViewBag.IdPuntoVenta = new SelectList(db.PuntosVentas.Where(x => x.IdTipoComprobante == 4), "IdPuntoVenta", "PuntoVenta", o.IdPuntoVenta);

        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var data = (from a in db.NotasCreditoes
                        from b in db.DescripcionIvas.Where(v => v.IdCodigoIva == a.IdCodigoIva).DefaultIfEmpty()
                        from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                        from d in db.Vendedores.Where(v => v.IdVendedor == a.IdVendedor).DefaultIfEmpty()
                        from e in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from f in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioAnulacion).DefaultIfEmpty()
                        from g in db.Provincias.Where(v => v.IdProvincia == a.IdProvinciaDestino).DefaultIfEmpty()
                        select new
                        {
                            a.IdNotaCredito,
                            Tipo = a.CtaCte == "SI" ? "Normal" : "Interna",
                            a.TipoABC,
                            a.PuntoVenta,
                            a.NumeroNotaCredito,
                            a.FechaNotaCredito,
                            a.Anulada,
                            ClienteCodigo = a.Cliente.CodigoCliente,
                            ClienteNombre = a.Cliente.RazonSocial,
                            DescripcionIva = b != null ? b.Descripcion : "",
                            ClienteCuit = a.Cliente.Cuit,
                            TotalGravado = (a.ImporteTotal ?? 0) - (a.ImporteIva1 ?? 0) - (a.PercepcionIVA ?? 0) - (a.RetencionIBrutos1 ?? 0) - (a.RetencionIBrutos2 ?? 0) - (a.RetencionIBrutos3 ?? 0) - (a.OtrasPercepciones1 ?? 0) - (a.OtrasPercepciones2 ?? 0) - (a.OtrasPercepciones3 ?? 0),
                            TotalIva = a.ImporteIva1,
                            TotalIIBB = (a.RetencionIBrutos1 ?? 0) + (a.RetencionIBrutos2 ?? 0) + (a.RetencionIBrutos3 ?? 0),
                            TotalPercepcionIVA = a.PercepcionIVA,
                            TotalOtrasPercepciones = (a.OtrasPercepciones1 ?? 0) + (a.OtrasPercepciones2 ?? 0) + (a.OtrasPercepciones3 ?? 0),
                            a.ImporteTotal,
                            MonedaAbreviatura = a.Moneda.Abreviatura,
                            Obra = c != null ? c.NumeroObra : "",
                            Vendedor = d != null ? d.Nombre : "",
                            ProvinciaDestino = g != null ? g.Nombre : "",
                            a.FechaAnulacion,
                            UsuarioAnulo = f != null ? f.Nombre : "",
                            a.FechaIngreso,
                            UsuarioIngreso = e != null ? e.Nombre : "",
                            a.CAE,
                            a.RechazoCAE,
                            a.FechaVencimientoORechazoCAE,
                            a.Observaciones
                        }).AsQueryable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaNotaCredito >= FechaDesde && a.FechaNotaCredito <= FechaHasta select a).AsQueryable();
            }

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .OrderByDescending(x => x.FechaNotaCredito)
                        .Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data1
                        select new jqGridRowJson
                        {
                            id = a.IdNotaCredito.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdNotaCredito} ) + ">Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdNotaCredito} ) + ">Emitir</a> ",
                                a.IdNotaCredito.NullSafeToString(),
                                a.Tipo.NullSafeToString(),
                                a.TipoABC.NullSafeToString(),
                                a.PuntoVenta.NullSafeToString(),
                                a.NumeroNotaCredito.NullSafeToString(),
                                a.FechaNotaCredito == null ? "" : a.FechaNotaCredito.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Anulada.NullSafeToString(),
                                a.ClienteCodigo.NullSafeToString(),
                                a.ClienteNombre.NullSafeToString(),
                                a.DescripcionIva.NullSafeToString(),
                                a.ClienteCuit.NullSafeToString(),
                                a.TotalGravado.NullSafeToString(),
                                a.TotalIva.NullSafeToString(),
                                a.TotalIIBB.NullSafeToString(),
                                a.TotalPercepcionIVA.NullSafeToString(),
                                a.TotalOtrasPercepciones.NullSafeToString(),
                                a.ImporteTotal.NullSafeToString(),
                                a.MonedaAbreviatura.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.Vendedor.NullSafeToString(),
                                a.ProvinciaDestino.NullSafeToString(),
                                a.FechaAnulacion == null ? "" : a.FechaAnulacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioAnulo.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioIngreso.NullSafeToString(),
                                a.CAE.NullSafeToString(),
                                a.RechazoCAE.NullSafeToString(),
                                a.FechaVencimientoORechazoCAE.NullSafeToString(),
                                a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetNotaCredito(string sidx, string sord, int? page, int? rows, int? IdNotaCredito)
        {
            int IdNotaCredito1 = IdNotaCredito ?? 0;
            var Det = db.DetalleNotasCreditoes.Where(p => p.IdNotaCredito == IdNotaCredito1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Conceptos.Where(o => o.IdConcepto == a.IdConcepto).DefaultIfEmpty()
                        from c in db.Cajas.Where(p => p.IdCaja == a.IdCaja).DefaultIfEmpty()
                        from d in db.CuentasBancarias.Where(q => q.IdCuentaBancaria == a.IdCuentaBancaria).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleNotaCredito,
                            a.IdConcepto,
                            a.IdCuentaBancaria,
                            a.IdCaja,
                            a.IdDiferenciaCambio,
                            Concepto = b != null ? b.Descripcion : "",
                            CuentaBancaria = d != null ? d.Cuenta : "",
                            Caja = c != null ? c.Descripcion : "",
                            a.Gravado,
                            a.Importe
                        }).OrderBy(x => x.IdDetalleNotaCredito).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleNotaCredito.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleNotaCredito.ToString(), 
                            a.IdConcepto.NullSafeToString(),
                            a.IdCuentaBancaria.NullSafeToString(),
                            a.IdCaja.NullSafeToString(),
                            a.IdDiferenciaCambio.NullSafeToString(),
                            a.Concepto.NullSafeToString(),
                            a.CuentaBancaria.NullSafeToString(),
                            a.Caja.NullSafeToString(),
                            a.Gravado.NullSafeToString(),
                            a.Importe.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetNotaCreditoImputaciones(string sidx, string sord, int? page, int? rows, int? IdNotaCredito)
        {
            int IdNotaCredito1 = IdNotaCredito ?? 0;
            var Det = db.DetalleNotasCreditoImputaciones.Where(p => p.IdNotaCredito == IdNotaCredito1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            Int32 mIdMonedaDolar = 0;

            Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mIdMonedaDolar = parametros.IdMonedaDolar ?? 2;

            var data = (from a in Det
                        from b in db.CuentasCorrientesDeudores.Where(o => o.IdCtaCte == a.IdImputacion).DefaultIfEmpty()
                        from c in db.TiposComprobantes.Where(p => p.IdTipoComprobante == b.IdTipoComp).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleNotaCreditoImputaciones,
                            a.IdImputacion,
                            CotizacionMoneda = b != null ? b.CotizacionMoneda : 1,
                            IdTipoComp = b != null ? b.IdTipoComp : 0,
                            IdComprobante = b != null ? b.IdComprobante : 0,
                            Tipo = (a.IdImputacion ?? 0) <= 0 ? "S/I" : (c != null ? c.DescripcionAb : ""),
                            Numero = b.NumeroComprobante,
                            b.Fecha,
                            ImporteOriginal = (a.NotasCredito.IdMoneda ?? 0) == mIdMonedaDolar ? b.ImporteTotalDolar * (c.Coeficiente ?? 1) : b.ImporteTotal * (c.Coeficiente ?? 1),
                            Saldo = (a.NotasCredito.IdMoneda ?? 0) == mIdMonedaDolar ? b.SaldoDolar * (c.Coeficiente ?? 1) : b.Saldo * (c.Coeficiente ?? 1),
                            a.Importe
                        }).OrderBy(x => x.IdDetalleNotaCreditoImputaciones).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleNotaCreditoImputaciones.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleNotaCreditoImputaciones.ToString(), 
                            a.IdImputacion.NullSafeToString(),
                            a.CotizacionMoneda.NullSafeToString(),
                            a.IdTipoComp.NullSafeToString(),
                            a.IdComprobante.NullSafeToString(),
                            a.Tipo.NullSafeToString(),
                            a.Numero.NullSafeToString(),
                            a.Fecha == null ? "" : a.Fecha.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.ImporteOriginal.NullSafeToString(),
                            a.Saldo.NullSafeToString(),
                            a.Importe.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetNotaCreditoProvincias(string sidx, string sord, int? page, int? rows, int? IdNotaCredito)
        {
            int IdNotaCredito1 = IdNotaCredito ?? 0;
            var Det = db.DetalleNotasCreditoProvincias.Where(p => p.IdNotaCredito == IdNotaCredito1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Provincias.Where(o => o.IdProvincia == a.IdProvinciaDestino).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleNotaCreditoProvincias,
                            a.IdProvinciaDestino,
                            Provincia = b != null ? b.Nombre : "",
                            a.Porcentaje
                        }).OrderBy(x => x.IdDetalleNotaCreditoProvincias).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleNotaCreditoProvincias.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleNotaCreditoProvincias.NullSafeToString(),
                            a.IdProvinciaDestino.NullSafeToString(),
                            a.Provincia.ToString(), 
                            a.Porcentaje.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdArticulo, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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

        private bool Validar(ProntoMVC.Data.Models.NotasCredito o, ref string sErrorMsg, ref string sWarningMsg)
        {
            Int32 mIdNotaCredito = 0;
            Int32 mNumero = 0;
            Int32 mIdMoneda = 1;
            Int32 mIdCliente = 1;
            Int32 mIdPuntoVenta = 0;

            string mObservaciones = "";
            string mTipoABC = "";
            string mCAI = "";
            string mWS = "";
            string mWSModoTest = "";
            string mCAEManual = "";
            string mProntoIni = "";
            string mCtaCte = "";
            string mAnulada = "";

            DateTime mFechaNotaCredito = DateTime.Today;
            DateTime mFechaUltimoCierre = DateTime.Today;
            DateTime mFechaCAI = DateTime.MinValue;

            mIdNotaCredito = o.IdNotaCredito;
            mFechaNotaCredito = o.FechaNotaCredito ?? DateTime.MinValue;
            mNumero = o.NumeroNotaCredito ?? 0;
            mIdMoneda = o.IdMoneda ?? 1;
            mIdCliente = o.IdCliente ?? 0;
            mObservaciones = o.Observaciones ?? "";
            mIdPuntoVenta = o.IdPuntoVenta ?? 0;
            mTipoABC = o.TipoABC ?? "";
            mCtaCte = o.CtaCte ?? "";
            mAnulada = o.Anulada ?? "";

            var parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mFechaUltimoCierre = parametros.FechaUltimoCierre ?? DateTime.Today;

            if ((o.NumeroNotaCredito ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número"; }
            if ((o.TipoABC ?? "") == "") { sErrorMsg += "\n" + "Falta la letra del comprobante"; }
            if ((o.AplicarEnCtaCte ?? "") == "") { sErrorMsg += "\n" + "Falta definir si va a cuenta corriente"; }
            if ((o.CtaCte ?? "") == "") { sErrorMsg += "\n" + "Falta definir si es normal o interna"; }
            if (o.FechaNotaCredito < mFechaUltimoCierre) { sErrorMsg += "\n" + "La fecha no puede ser anterior a la del ultimo cierre contable"; }
            if (BuscarClaveINI("Requerir obra en OP", -1) == "SI") { if ((o.IdObra ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la obra"; } }
            if ((o.CotizacionMoneda ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cotización de equivalencia a pesos"; }
            if ((o.CotizacionDolar ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cotización dolar"; }
            if (mIdMoneda <= 0) { sErrorMsg += "\n" + "Falta la moneda"; }
            if (mCtaCte == "SI")
            {
                if ((o.IdPuntoVenta ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el punto de venta"; }
                if ((o.PuntoVenta ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el numero de sucursal"; }
            }
            else
            {
                if ((o.ImporteIva1 ?? 0) != 0) { sErrorMsg += "\n" + "Una nota de credito interna no puede tener iva"; }
            }

            if (mIdPuntoVenta > 0)
            {
                var PuntoVenta = db.PuntosVentas.Where(p => p.IdPuntoVenta == mIdPuntoVenta).FirstOrDefault();
                if (PuntoVenta != null)
                {
                    if (mTipoABC == "A" || mTipoABC == "M")
                    {
                        mCAI = PuntoVenta.NumeroCAI_C_A ?? "";
                        mFechaCAI = PuntoVenta.FechaCAI_C_A ?? DateTime.MinValue;
                    }
                    if (mTipoABC == "B")
                    {
                        mCAI = PuntoVenta.NumeroCAI_C_B ?? "";
                        mFechaCAI = PuntoVenta.FechaCAI_C_B ?? DateTime.MinValue;
                    }
                    if (mTipoABC == "E")
                    {
                        mCAI = PuntoVenta.NumeroCAI_C_E ?? "";
                        mFechaCAI = PuntoVenta.FechaCAI_C_E ?? DateTime.MinValue;
                    }
                    mWS = PuntoVenta.WebService ?? "";
                    mWSModoTest = PuntoVenta.WebServiceModoTest ?? "";
                    mCAEManual = PuntoVenta.CAEManual ?? "";
                }
                if ((mTipoABC == "A" || mTipoABC == "M") && mWS.Length == 0 && mCAI.Length == 0) { sErrorMsg += "\n" + "No existe numero de CAI"; }
                if (mWS.Length == 0 && mCAI.Length > 0 && mFechaNotaCredito > mFechaCAI) { sErrorMsg += "\n" + "El CAI vencio el " + mFechaCAI.ToString() + "."; }
                if (mCAEManual == "SI" && (o.CAE ?? "").Length != 14) { sErrorMsg += "\n" + "Numero de CAE incorrecto (debe tener 14 digitos)"; }
                if (mCAI.Length > 0)
                {
                    o.NumeroCAI = Convert.ToDecimal(mCAI);
                    o.FechaVencimientoCAI = mFechaCAI;
                }
            }

            mProntoIni = BuscarClaveINI("Validar fecha de facturas nuevas", -1);
            if ((mProntoIni ?? "") == "SI" && mIdNotaCredito <= 0 && mIdPuntoVenta > 0)
            {
                var NotaCredito = db.NotasCreditoes.Where(p => p.IdPuntoVenta == mIdPuntoVenta).OrderByDescending(p => p.FechaNotaCredito).FirstOrDefault();
                if (NotaCredito != null)
                { if (NotaCredito.FechaNotaCredito > mFechaNotaCredito) { sErrorMsg += "\n" + "La fecha de la ultima nota de credito es " + NotaCredito.FechaNotaCredito.ToString() + " para este punto de venta."; } }
            }

            var Cliente = db.Clientes.Where(p => p.IdCliente == mIdCliente).FirstOrDefault();
            if (Cliente != null)
            {
                if (Cliente.Estados_Proveedores != null) { if ((Cliente.Estados_Proveedores.Activo ?? "") != "SI") { sErrorMsg += "\n" + "Cliente inhabilitado"; } }
            }

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(NotasCredito NotaCredito)
        {
            try
            {
                decimal mCotizacionMoneda = 0;
                decimal mCotizacionDolar = 0;
                decimal mImporteTotal = 0;
                decimal mIvaNoDiscriminado = 0;
                decimal mIvaNoDiscriminadoItem = 0;
                decimal mImporteDDetalle = 0;
                decimal mImporte = 0;
                decimal mImportePesos = 0;
                decimal mImporteDolares = 0;
                decimal mSaldoPesos = 0;
                decimal mSaldoDolares = 0;
                
                Int32 mIdNotaCredito = 0;
                Int32 mNumero = 0;
                Int32 mNumeroElectronico = 0;
                Int32 mIdCliente = 0;
                Int32 mIdCuenta = 0;
                Int32 mIdCuentaOtrasPercepciones1 = 0;
                Int32 mIdCuentaOtrasPercepciones2 = 0;
                Int32 mIdCuentaOtrasPercepciones3 = 0;
                Int32 mIdCuentaPercepcionesIVA = 0;
                Int32 mIdCuentaIvaInscripto = 0;
                Int32 mIdProvincia = 0;
                Int32 mIdCuentaVentasTitulo = 0;
                Int32 mIdMonedaPesos = 1;
                Int32 mIdCtaCte = 0;
                Int32 mIdTipoComprobante = 4;
                Int32 mIdImputacion = 0;
                Int32 mIdValor = 0;
                Int32 mIdBanco = 0;
                
                string errs = "";
                string warnings = "";

                bool mAnulada = false;
                bool mAplicarEnCtaCte = true;
                bool mBorrarEnValores = false;

                Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
                mIdCuentaVentasTitulo = parametros.IdCuentaVentasTitulo ?? 0;
                mIdMonedaPesos = parametros.IdMoneda ?? 0;
                mIdCuentaIvaInscripto = parametros.IdCuentaIvaInscripto ?? 0;
                mIdCuentaOtrasPercepciones1 = parametros.IdCuentaOtrasPercepciones1 ?? 0;
                mIdCuentaOtrasPercepciones2 = parametros.IdCuentaOtrasPercepciones2 ?? 0;
                mIdCuentaOtrasPercepciones3 = parametros.IdCuentaOtrasPercepciones3 ?? 0;
                mIdCuentaPercepcionesIVA = parametros.IdCuentaPercepcionesIVA ?? 0;

                string usuario = ViewBag.NombreUsuario;
                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                if (NotaCredito.IdNotaCredito <= 0)
                {
                    NotaCredito.IdUsuarioIngreso = IdUsuario;
                    NotaCredito.FechaIngreso = DateTime.Now;
                }

                if (!Validar(NotaCredito, ref errs, ref warnings))
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
                        mIdNotaCredito = NotaCredito.IdNotaCredito;
                        mIdCliente = NotaCredito.IdCliente ?? 0;
                        mCotizacionMoneda = NotaCredito.CotizacionMoneda ?? 1;
                        mCotizacionDolar = NotaCredito.CotizacionDolar ?? 0;
                        if (NotaCredito.Anulada == "SI") { mAnulada = true; }
                        if ((NotaCredito.AplicarEnCtaCte ?? "") == "NO") { mAplicarEnCtaCte = false; }
                        mImporteTotal = NotaCredito.ImporteTotal ?? 0;
                        mIvaNoDiscriminado = NotaCredito.IVANoDiscriminado ?? 0;

                        if (mIdNotaCredito > 0)
                        {
                            var EntidadOriginal = db.NotasCreditoes.Where(p => p.IdNotaCredito == mIdNotaCredito).SingleOrDefault();

                            var EntidadoEntry = db.Entry(EntidadOriginal);
                            EntidadoEntry.CurrentValues.SetValues(NotaCredito);

                            // Restiruir los saldos de las imputaciones ya registradas
                            foreach (var d in EntidadOriginal.DetalleNotasCreditoImputaciones.Where(c => c.IdDetalleNotaCreditoImputaciones != 0).ToList())
                            {
                                CuentasCorrientesDeudor CtaCteAnterior = db.CuentasCorrientesDeudores.Where(c => c.IdDetalleNotaCreditoImputaciones == d.IdDetalleNotaCreditoImputaciones).FirstOrDefault();
                                if (CtaCteAnterior != null)
                                {
                                    mImportePesos = (CtaCteAnterior.ImporteTotal ?? 0) - (CtaCteAnterior.Saldo ?? 0);
                                    mImporteDolares = (CtaCteAnterior.ImporteTotalDolar ?? 0) - (CtaCteAnterior.SaldoDolar ?? 0);
                                    mIdImputacion = d.IdImputacion ?? 0;

                                    if (mIdImputacion > 0)
                                    {
                                        CuentasCorrientesDeudor CtaCteImputadaAnterior = db.CuentasCorrientesDeudores.Where(c => c.IdCtaCte == mIdImputacion).SingleOrDefault();
                                        if (CtaCteImputadaAnterior != null)
                                        {
                                            CtaCteImputadaAnterior.Saldo += mImportePesos;
                                            CtaCteImputadaAnterior.SaldoDolar += mImporteDolares;

                                            db.Entry(CtaCteImputadaAnterior).State = System.Data.Entity.EntityState.Modified;
                                        }
                                    }
                                    db.Entry(CtaCteAnterior).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            foreach (var d in EntidadOriginal.DetalleNotasCreditoes.Where(c => c.IdDetalleNotaCredito != 0).ToList())
                            {
                                var Valores = db.Valores.Where(c => c.IdDetalleNotaCredito == d.IdDetalleNotaCredito).ToList();
                                if (Valores != null)
                                {
                                    foreach (Valore v in Valores)
                                    {
                                        db.Entry(v).State = System.Data.Entity.EntityState.Deleted;
                                    }
                                }
                            }

                            ////////////////////////////////////////////// CONCEPTOS //////////////////////////////////////////////
                            foreach (var d in NotaCredito.DetalleNotasCreditoes)
                            {
                                var DetalleEntidadOriginal = EntidadOriginal.DetalleNotasCreditoes.Where(c => c.IdDetalleNotaCredito == d.IdDetalleNotaCredito && d.IdDetalleNotaCredito > 0).SingleOrDefault();
                                if (DetalleEntidadOriginal != null)
                                {
                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    EntidadOriginal.DetalleNotasCreditoes.Add(d);
                                }
                            }
                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleNotasCreditoes.Where(c => c.IdDetalleNotaCredito != 0).ToList())
                            {
                                if (!NotaCredito.DetalleNotasCreditoes.Any(c => c.IdDetalleNotaCredito == DetalleEntidadOriginal.IdDetalleNotaCredito))
                                {
                                    EntidadOriginal.DetalleNotasCreditoes.Remove(DetalleEntidadOriginal);
                                    db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// IMPUTACIONES //////////////////////////////////////////////
                            foreach (var d in NotaCredito.DetalleNotasCreditoImputaciones)
                            {
                                var DetalleEntidadOriginal = EntidadOriginal.DetalleNotasCreditoImputaciones.Where(c => c.IdDetalleNotaCreditoImputaciones == d.IdDetalleNotaCreditoImputaciones && d.IdDetalleNotaCreditoImputaciones > 0).SingleOrDefault();
                                if (DetalleEntidadOriginal != null)
                                {
                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    EntidadOriginal.DetalleNotasCreditoImputaciones.Add(d);
                                }
                            }
                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleNotasCreditoImputaciones.Where(c => c.IdDetalleNotaCreditoImputaciones != 0).ToList())
                            {
                                if (!NotaCredito.DetalleNotasCreditoImputaciones.Any(c => c.IdDetalleNotaCreditoImputaciones == DetalleEntidadOriginal.IdDetalleNotaCreditoImputaciones))
                                {
                                    EntidadOriginal.DetalleNotasCreditoImputaciones.Remove(DetalleEntidadOriginal);
                                    db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// PROVINCIAS //////////////////////////////////////////////
                            foreach (var d in NotaCredito.DetalleNotasCreditoProvincias)
                            {
                                var DetalleEntidadOriginal = EntidadOriginal.DetalleNotasCreditoProvincias.Where(c => c.IdDetalleNotaCreditoProvincias == d.IdDetalleNotaCreditoProvincias && d.IdDetalleNotaCreditoProvincias > 0).SingleOrDefault();
                                if (DetalleEntidadOriginal != null)
                                {
                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    EntidadOriginal.DetalleNotasCreditoProvincias.Add(d);
                                }
                            }
                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleNotasCreditoProvincias.Where(c => c.IdDetalleNotaCreditoProvincias != 0).ToList())
                            {
                                if (!NotaCredito.DetalleNotasCreditoProvincias.Any(c => c.IdDetalleNotaCreditoProvincias == DetalleEntidadOriginal.IdDetalleNotaCreditoProvincias))
                                {
                                    EntidadOriginal.DetalleNotasCreditoProvincias.Remove(DetalleEntidadOriginal);
                                    db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
                            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        else
                        {
                            if ((NotaCredito.CtaCte ?? "") == "SI")
                            {
                                ProntoMVC.Data.Models.PuntosVenta PuntoVenta = db.PuntosVentas.Where(c => c.IdPuntoVenta == NotaCredito.IdPuntoVenta).SingleOrDefault();
                                if (PuntoVenta != null)
                                {
                                    if (mNumeroElectronico == 0) { mNumero = PuntoVenta.ProximoNumero ?? 1; }
                                    else { mNumero = mNumeroElectronico; }
                                    PuntoVenta.ProximoNumero = mNumero + 1;
                                    db.Entry(PuntoVenta).State = System.Data.Entity.EntityState.Modified;
                                }
                            }
                            else
                            {
                                Parametros parametros2 = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
                                mNumero = parametros2.ProximaNotaCreditoInterna ?? 1;
                                parametros2.ProximaNotaCreditoInterna = mNumero + 1;
                                db.Entry(parametros2).State = System.Data.Entity.EntityState.Modified;
                            }
                            NotaCredito.NumeroNotaCredito = mNumero;


                            // HACER REGISTRO ELECTRONICO

                            db.NotasCreditoes.Add(NotaCredito);
                            db.SaveChanges();
                        }

                        ////////////////////////////////////////////// IMPUTACIONES //////////////////////////////////////////////
                        if (!mAnulada && mAplicarEnCtaCte)
                        {
                            foreach (var d in NotaCredito.DetalleNotasCreditoImputaciones)
                            {
                                mImporte = d.Importe ?? 0;
                                mImportePesos = mImporte * mCotizacionMoneda;
                                mImporteDolares = 0;
                                if (mCotizacionDolar != 0) { mImporteDolares = decimal.Round(mImportePesos / mCotizacionDolar, 2); }
                                mIdImputacion = d.IdImputacion ?? 0;

                                CuentasCorrientesDeudor CtaCte = new CuentasCorrientesDeudor();
                                CtaCte.IdCliente = NotaCredito.IdCliente;
                                CtaCte.NumeroComprobante = NotaCredito.NumeroNotaCredito;
                                CtaCte.Fecha = NotaCredito.FechaNotaCredito;
                                CtaCte.FechaVencimiento = NotaCredito.FechaNotaCredito;
                                CtaCte.Cotizacion = NotaCredito.CotizacionDolar;
                                CtaCte.CotizacionMoneda = NotaCredito.CotizacionMoneda;
                                CtaCte.IdComprobante = NotaCredito.IdNotaCredito;
                                CtaCte.IdTipoComp = mIdTipoComprobante;
                                CtaCte.ImporteTotal = mImportePesos;
                                CtaCte.Saldo = mImportePesos;
                                CtaCte.ImporteTotalDolar = mImporteDolares;
                                CtaCte.SaldoDolar = mImporteDolares;
                                CtaCte.IdMoneda = NotaCredito.IdMoneda;
                                CtaCte.IdDetalleNotaCreditoImputaciones = d.IdDetalleNotaCreditoImputaciones;
                                CtaCte.IdCtaCte = 0;

                                if (mIdImputacion > 0)
                                {
                                    CuentasCorrientesDeudor CtaCteImputada = db.CuentasCorrientesDeudores.Where(c => c.IdCtaCte == mIdImputacion).SingleOrDefault();
                                    if (CtaCteImputada != null)
                                    {
                                        mSaldoPesos = CtaCteImputada.Saldo ?? 0;
                                        mSaldoDolares = CtaCteImputada.SaldoDolar ?? 0;
                                    }
                                    else
                                    {
                                        mSaldoPesos = 0;
                                        mSaldoDolares = 0;
                                    }
                                    if (mImportePesos > mSaldoPesos)
                                    {
                                        mImportePesos = decimal.Round(mImportePesos - mSaldoPesos, 2);
                                        CtaCteImputada.Saldo = 0;
                                        CtaCte.Saldo = mImportePesos;
                                    }
                                    else
                                    {
                                        mSaldoPesos = decimal.Round(mSaldoPesos - mImportePesos, 2);
                                        CtaCteImputada.Saldo = mSaldoPesos;
                                        CtaCte.Saldo = 0;
                                    }
                                    if (mImporteDolares > mSaldoDolares)
                                    {
                                        mImporteDolares = decimal.Round(mImporteDolares - mSaldoDolares, 2);
                                        CtaCteImputada.SaldoDolar = 0;
                                        CtaCte.SaldoDolar = mImporteDolares;
                                    }
                                    else
                                    {
                                        mSaldoDolares = decimal.Round(mSaldoDolares - mImporteDolares, 2);
                                        CtaCteImputada.SaldoDolar = mSaldoDolares;
                                        CtaCte.SaldoDolar = 0;
                                    }
                                    CtaCte.IdImputacion = CtaCteImputada.IdImputacion;

                                    db.Entry(CtaCteImputada).State = System.Data.Entity.EntityState.Modified;
                                }

                                db.CuentasCorrientesDeudores.Add(CtaCte);
                                if ((CtaCte.IdImputacion ?? 0) == 0)
                                {
                                    db.SaveChanges();
                                    CtaCte.IdImputacion = CtaCte.IdCtaCte;
                                    db.Entry(CtaCte).State = System.Data.Entity.EntityState.Modified;
                                }
                            }
                            db.SaveChanges();
                        }

                        ////////////////////////////////////////////// VALORES //////////////////////////////////////////////
                        if (!mAnulada)
                        {
                            foreach (var d in NotaCredito.DetalleNotasCreditoes)
                            {
                                mBorrarEnValores = true;
                                Valore v;

                                mIdValor = -1;
                                Valore valor = db.Valores.Where(c => c.IdDetalleNotaCredito == d.IdDetalleNotaCredito).SingleOrDefault();
                                if (valor != null) { mIdValor = valor.IdValor; }

                                if ((d.IdCaja ?? 0) > 0)
                                {
                                    if (mIdValor <= 0) { v = new Valore(); } else { v = db.Valores.Where(c => c.IdValor == mIdValor).SingleOrDefault(); }

                                    v.IdCaja = d.IdCaja;
                                    v.IdTipoValor = 4;
                                    v.Importe = d.Importe;
                                    v.NumeroComprobante = NotaCredito.NumeroNotaCredito;
                                    v.NumeroValor = 0;
                                    v.NumeroInterno = 0;
                                    v.FechaValor = NotaCredito.FechaNotaCredito;
                                    v.FechaComprobante = NotaCredito.FechaNotaCredito;
                                    if ((NotaCredito.IdCliente ?? 0) > 0) { v.IdCliente = NotaCredito.IdCliente; }
                                    v.IdTipoComprobante = mIdTipoComprobante;
                                    v.IdDetalleNotaDebito = d.IdDetalleNotaCredito;
                                    v.IdMoneda = NotaCredito.IdMoneda;
                                    v.CotizacionMoneda = NotaCredito.CotizacionMoneda;
                                    v.IdValor = mIdValor;
                                    if (mIdValor <= 0) { db.Valores.Add(v); } else { db.Entry(v).State = System.Data.Entity.EntityState.Modified; }
                                    mBorrarEnValores = false;
                                }
                                if ((d.IdCuentaBancaria ?? 0) > 0)
                                {
                                    mIdBanco = -1;
                                    CuentasBancaria CuentaBancaria = db.CuentasBancarias.Where(c => c.IdCuentaBancaria == d.IdCuentaBancaria).SingleOrDefault();
                                    if (CuentaBancaria != null) { mIdBanco = CuentaBancaria.IdBanco ?? 0; }

                                    if (mIdBanco > 0)
                                    {
                                        if (mIdValor <= 0) { v = new Valore(); } else { v = db.Valores.Where(c => c.IdValor == mIdValor).SingleOrDefault(); }

                                        v.IdCuentaBancaria = d.IdCuentaBancaria;
                                        v.IdBanco = mIdBanco;
                                        v.IdTipoValor = 4;
                                        v.Importe = d.Importe;
                                        v.NumeroComprobante = NotaCredito.NumeroNotaCredito;
                                        v.NumeroValor = 0;
                                        v.NumeroInterno = 0;
                                        v.FechaValor = NotaCredito.FechaNotaCredito;
                                        v.FechaComprobante = NotaCredito.FechaNotaCredito;
                                        if ((NotaCredito.IdCliente ?? 0) > 0) { v.IdCliente = NotaCredito.IdCliente; }
                                        v.IdTipoComprobante = mIdTipoComprobante;
                                        v.IdDetalleNotaDebito = d.IdDetalleNotaCredito;
                                        v.IdMoneda = NotaCredito.IdMoneda;
                                        v.CotizacionMoneda = NotaCredito.CotizacionMoneda;
                                        v.IdValor = mIdValor;
                                        if (mIdValor <= 0) { db.Valores.Add(v); } else { db.Entry(v).State = System.Data.Entity.EntityState.Modified; }
                                        mBorrarEnValores = false;
                                    }
                                }
                                if (mBorrarEnValores)
                                {
                                    var Valores = db.Valores.Where(c => c.IdDetalleNotaCredito == d.IdDetalleNotaCredito).ToList();
                                    if (Valores != null)
                                    {
                                        foreach (Valore v1 in Valores)
                                        {
                                            db.Entry(v1).State = System.Data.Entity.EntityState.Deleted;
                                        }
                                    }
                                }
                            }
                            db.SaveChanges();
                        }

                        ////////////////////////////////////////////// ASIENTO //////////////////////////////////////////////
                        if (mIdNotaCredito > 0 || mAnulada)
                        {
                            var Subdiarios = db.Subdiarios.Where(c => c.IdTipoComprobante == mIdTipoComprobante && c.IdComprobante == mIdNotaCredito).ToList();
                            if (Subdiarios != null) { foreach (Subdiario s in Subdiarios) { db.Entry(s).State = System.Data.Entity.EntityState.Deleted; } }
                            db.SaveChanges();
                        }

                        if (!mAnulada)
                        {
                            Subdiario s;

                            Cliente Cliente = db.Clientes.Where(c => c.IdCliente == mIdCliente).SingleOrDefault();
                            mIdCuenta = 0;
                            if (Cliente != null) { mIdCuenta = Cliente.IdCuenta ?? 0; }

                            if (mIdCuenta > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuenta;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = NotaCredito.NumeroNotaCredito;
                                s.FechaComprobante = NotaCredito.FechaNotaCredito;
                                s.IdComprobante = NotaCredito.IdNotaCredito;
                                s.Haber = mImporteTotal;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = NotaCredito.ImporteIva1 ?? 0;
                            if (mImporte != 0 && mIdCuentaIvaInscripto > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaIvaInscripto;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = NotaCredito.NumeroNotaCredito;
                                s.FechaComprobante = NotaCredito.FechaNotaCredito;
                                s.IdComprobante = NotaCredito.IdNotaCredito;
                                s.Debe = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = NotaCredito.IVANoDiscriminado ?? 0;
                            if (mImporte != 0 && mIdCuentaIvaInscripto > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaIvaInscripto;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = NotaCredito.NumeroNotaCredito;
                                s.FechaComprobante = NotaCredito.FechaNotaCredito;
                                s.IdComprobante = NotaCredito.IdNotaCredito;
                                s.Debe = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = NotaCredito.RetencionIBrutos1 ?? 0;
                            if (mImporte != 0)
                            {
                                mIdCuenta = 0;
                                var IBCondicion = db.IBCondiciones.Where(c => c.IdIBCondicion == NotaCredito.IdIBCondicion).FirstOrDefault();
                                if (IBCondicion != null)
                                {
                                    mIdCuenta = IBCondicion.IdCuentaPercepcionIIBB ?? 0;
                                    mIdProvincia = IBCondicion.IdProvincia ?? 0;
                                    if (mIdProvincia != 0)
                                    {
                                        var Provincia = db.Provincias.Where(c => c.IdProvincia == mIdProvincia).FirstOrDefault();
                                        if (Provincia != null)
                                        {
                                            if ((Provincia.IdCuentaPercepcionIBrutos ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIBrutos ?? 0; }
                                            if ((NotaCredito.ConvenioMultilateral ?? "") == "SI" && (Provincia.IdCuentaPercepcionIIBBConvenio ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIIBBConvenio ?? 0; }
                                        }
                                    }
                                }

                                if (mIdCuenta > 0)
                                {
                                    s = new Subdiario();
                                    s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                    s.IdCuenta = mIdCuenta;
                                    s.IdTipoComprobante = mIdTipoComprobante;
                                    s.NumeroComprobante = NotaCredito.NumeroNotaCredito;
                                    s.FechaComprobante = NotaCredito.FechaNotaCredito;
                                    s.IdComprobante = NotaCredito.IdNotaCredito;
                                    s.Debe = mImporte;
                                    s.IdMoneda = mIdMonedaPesos;
                                    s.CotizacionMoneda = 1;

                                    db.Subdiarios.Add(s);
                                }
                            }

                            mImporte = NotaCredito.RetencionIBrutos2 ?? 0;
                            if (mImporte != 0)
                            {
                                mIdCuenta = 0;
                                var IBCondicion = db.IBCondiciones.Where(c => c.IdIBCondicion == NotaCredito.IdIBCondicion2).FirstOrDefault();
                                if (IBCondicion != null)
                                {
                                    mIdCuenta = IBCondicion.IdCuentaPercepcionIIBB ?? 0;
                                    mIdProvincia = IBCondicion.IdProvincia ?? 0;
                                    if (mIdProvincia != 0)
                                    {
                                        var Provincia = db.Provincias.Where(c => c.IdProvincia == mIdProvincia).FirstOrDefault();
                                        if (Provincia != null)
                                        {
                                            if ((Provincia.IdCuentaPercepcionIBrutos ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIBrutos ?? 0; }
                                            if ((NotaCredito.ConvenioMultilateral ?? "") == "SI" && (Provincia.IdCuentaPercepcionIIBBConvenio ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIIBBConvenio ?? 0; }
                                        }
                                    }
                                }

                                if (mIdCuenta > 0)
                                {
                                    s = new Subdiario();
                                    s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                    s.IdCuenta = mIdCuenta;
                                    s.IdTipoComprobante = mIdTipoComprobante;
                                    s.NumeroComprobante = NotaCredito.NumeroNotaCredito;
                                    s.FechaComprobante = NotaCredito.FechaNotaCredito;
                                    s.IdComprobante = NotaCredito.IdNotaCredito;
                                    s.Debe = mImporte;
                                    s.IdMoneda = mIdMonedaPesos;
                                    s.CotizacionMoneda = 1;

                                    db.Subdiarios.Add(s);
                                }
                            }

                            mImporte = NotaCredito.RetencionIBrutos3 ?? 0;
                            if (mImporte != 0)
                            {
                                mIdCuenta = 0;
                                var IBCondicion = db.IBCondiciones.Where(c => c.IdIBCondicion == NotaCredito.IdIBCondicion3).FirstOrDefault();
                                if (IBCondicion != null)
                                {
                                    mIdCuenta = IBCondicion.IdCuentaPercepcionIIBB ?? 0;
                                    mIdProvincia = IBCondicion.IdProvincia ?? 0;
                                    if (mIdProvincia != 0)
                                    {
                                        var Provincia = db.Provincias.Where(c => c.IdProvincia == mIdProvincia).FirstOrDefault();
                                        if (Provincia != null)
                                        {
                                            if ((Provincia.IdCuentaPercepcionIBrutos ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIBrutos ?? 0; }
                                            if ((NotaCredito.ConvenioMultilateral ?? "") == "SI" && (Provincia.IdCuentaPercepcionIIBBConvenio ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIIBBConvenio ?? 0; }
                                        }
                                    }
                                }

                                if (mIdCuenta > 0)
                                {
                                    s = new Subdiario();
                                    s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                    s.IdCuenta = mIdCuenta;
                                    s.IdTipoComprobante = mIdTipoComprobante;
                                    s.NumeroComprobante = NotaCredito.NumeroNotaCredito;
                                    s.FechaComprobante = NotaCredito.FechaNotaCredito;
                                    s.IdComprobante = NotaCredito.IdNotaCredito;
                                    s.Debe = mImporte;
                                    s.IdMoneda = mIdMonedaPesos;
                                    s.CotizacionMoneda = 1;

                                    db.Subdiarios.Add(s);
                                }
                            }

                            mImporte = NotaCredito.OtrasPercepciones1 ?? 0;
                            if (mImporte != 0 && mIdCuentaOtrasPercepciones1 > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaOtrasPercepciones1;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = NotaCredito.NumeroNotaCredito;
                                s.FechaComprobante = NotaCredito.FechaNotaCredito;
                                s.IdComprobante = NotaCredito.IdNotaCredito;
                                s.Debe = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = NotaCredito.OtrasPercepciones2 ?? 0;
                            if (mImporte != 0 && mIdCuentaOtrasPercepciones2 > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaOtrasPercepciones2;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = NotaCredito.NumeroNotaCredito;
                                s.FechaComprobante = NotaCredito.FechaNotaCredito;
                                s.IdComprobante = NotaCredito.IdNotaCredito;
                                s.Debe = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = NotaCredito.OtrasPercepciones3 ?? 0;
                            if (mImporte != 0 && mIdCuentaOtrasPercepciones3 > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaOtrasPercepciones3;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = NotaCredito.NumeroNotaCredito;
                                s.FechaComprobante = NotaCredito.FechaNotaCredito;
                                s.IdComprobante = NotaCredito.IdNotaCredito;
                                s.Debe = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = NotaCredito.PercepcionIVA ?? 0;
                            if (mImporte != 0 && mIdCuentaPercepcionesIVA > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaPercepcionesIVA;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = NotaCredito.NumeroNotaCredito;
                                s.FechaComprobante = NotaCredito.FechaNotaCredito;
                                s.IdComprobante = NotaCredito.IdNotaCredito;
                                s.Debe = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            foreach (var d in NotaCredito.DetalleNotasCreditoes)
                            {
                                mImporteDDetalle = d.Importe ?? 0;
                                mIvaNoDiscriminadoItem = 0;
                                if (mIvaNoDiscriminado > 0 && (d.Gravado ?? "") == "SI") { mIvaNoDiscriminadoItem = d.IvaNoDiscriminado ?? 0; }

                                Concepto Concepto = db.Conceptos.Where(c => c.IdConcepto == d.IdConcepto).SingleOrDefault();
                                mIdCuenta = 0;
                                if (Concepto != null) { mIdCuenta = Concepto.IdCuenta ?? 0; }

                                if (mIdCuenta > 0)
                                {
                                    s = new Subdiario();
                                    s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                    s.IdCuenta = mIdCuenta;
                                    s.IdTipoComprobante = mIdTipoComprobante;
                                    s.NumeroComprobante = NotaCredito.NumeroNotaCredito;
                                    s.FechaComprobante = NotaCredito.FechaNotaCredito;
                                    s.IdComprobante = NotaCredito.IdNotaCredito;
                                    s.Debe = mImporteDDetalle - mIvaNoDiscriminadoItem;
                                    s.IdMoneda = mIdMonedaPesos;
                                    s.CotizacionMoneda = 1;

                                    db.Subdiarios.Add(s);
                                }
                            }
                            db.SaveChanges();
                        }

                        scope.Complete();
                        scope.Dispose();
                    }

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdNotaCredito = NotaCredito.IdNotaCredito, ex = "" });
                }
                else
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "La orden de pago tiene datos invalidos";

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

    }
}
