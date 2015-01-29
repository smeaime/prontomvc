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
using System.Reflection;
using System.Text;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using Pronto.ERP.Bll;

using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using Newtonsoft.Json;

namespace ProntoMVC.Controllers
{
    public partial class ReciboController : ProntoBaseController
    {

        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Recibos)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ActionResult EditCC(int id)
        {
            if (!PuedeLeer(enumNodos.Recibos)) throw new Exception("No tenés permisos");
            if (id == -1)
            {
                Recibo Recibo = new Recibo();

                inic(ref Recibo);
                Recibo.Tipo = "CC";
                CargarViewBag(Recibo);
                return View(Recibo);
            }
            else
            {
                Recibo Recibo = db.Recibos.Find(id);
                CargarViewBag(Recibo);
                return View(Recibo);
            }
        }

        public virtual ActionResult EditOT(int id)
        {
            if (!PuedeLeer(enumNodos.Recibos)) throw new Exception("No tenés permisos");
            if (id == -1)
            {
                Recibo Recibo = new Recibo();

                inic(ref Recibo);
                Recibo.Tipo = "OT";
                CargarViewBag(Recibo);
                return View(Recibo);
            }
            else
            {
                Recibo Recibo = db.Recibos.Find(id);
                CargarViewBag(Recibo);
                return View(Recibo);
            }
        }

        void inic(ref Recibo o)
        {
            Parametros parametros = db.Parametros.Find(1);

            Int32 mIdMonedaDolar;
            Int32 mIdMonedaEuro;

            mIdMonedaDolar = parametros.IdMonedaDolar ?? 0;
            mIdMonedaEuro = parametros.IdMonedaEuro ?? 0;

            o.IdMoneda = 1;
            o.CotizacionMoneda = 1;
            o.FechaIngreso = DateTime.Today;
            o.FechaRecibo = DateTime.Today;
            o.CotizacionMoneda = 1;

            Cotizacione Cotizaciones = db.Cotizaciones.Where(x => x.IdMoneda == mIdMonedaDolar && x.Fecha == DateTime.Today).FirstOrDefault();
            if (Cotizaciones != null) { o.Cotizacion = Cotizaciones.Cotizacion ?? 0; }
        }

        void CargarViewBag(Recibo o)
        {
            ViewBag.IdVendedor = new SelectList(db.Vendedores, "IdVendedor", "Nombre");
            ViewBag.IdCobrador = new SelectList(db.Vendedores, "IdVendedor", "Nombre");
            ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion");
            ViewBag.IdObra = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra);
            ViewBag.IdObra1 = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra1);
            ViewBag.IdObra2 = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra2);
            ViewBag.IdObra3 = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra3);
            ViewBag.IdObra4 = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra4);
            ViewBag.IdObra5 = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra5);
            ViewBag.IdCuenta1 = new SelectList(db.Cuentas.Where(x => x.IdCuenta == -1), "IdCuenta", "Descripcion", o.IdCuenta1);
            ViewBag.IdCuenta2 = new SelectList(db.Cuentas.Where(x => x.IdCuenta == -1), "IdCuenta", "Descripcion", o.IdCuenta2);
            ViewBag.IdCuenta3 = new SelectList(db.Cuentas.Where(x => x.IdCuenta == -1), "IdCuenta", "Descripcion", o.IdCuenta3);
            ViewBag.IdCuenta4 = new SelectList(db.Cuentas.Where(x => x.IdCuenta == -1), "IdCuenta", "Descripcion", o.IdCuenta4);
            ViewBag.IdCuenta5 = new SelectList(db.Cuentas.Where(x => x.IdCuenta == -1), "IdCuenta", "Descripcion", o.IdCuenta5);
            ViewBag.IdCuentaGasto1 = new SelectList(db.CuentasGastos.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdCuentaGasto", "Descripcion", o.IdCuentaGasto1);
            ViewBag.IdCuentaGasto2 = new SelectList(db.CuentasGastos.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdCuentaGasto", "Descripcion", o.IdCuentaGasto2);
            ViewBag.IdCuentaGasto3 = new SelectList(db.CuentasGastos.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdCuentaGasto", "Descripcion", o.IdCuentaGasto3);
            ViewBag.IdCuentaGasto4 = new SelectList(db.CuentasGastos.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdCuentaGasto", "Descripcion", o.IdCuentaGasto4);
            ViewBag.IdCuentaGasto5 = new SelectList(db.CuentasGastos.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdCuentaGasto", "Descripcion", o.IdCuentaGasto5);
            ViewBag.IdTipoCuentaGrupo1 = new SelectList(db.TiposCuentaGrupos.OrderBy(x => x.Descripcion), "IdTipoCuentaGrupo", "Descripcion");
            ViewBag.IdTipoCuentaGrupo2 = new SelectList(db.TiposCuentaGrupos.OrderBy(x => x.Descripcion), "IdTipoCuentaGrupo", "Descripcion");
            ViewBag.IdTipoCuentaGrupo3 = new SelectList(db.TiposCuentaGrupos.OrderBy(x => x.Descripcion), "IdTipoCuentaGrupo", "Descripcion");
            ViewBag.IdTipoCuentaGrupo4 = new SelectList(db.TiposCuentaGrupos.OrderBy(x => x.Descripcion), "IdTipoCuentaGrupo", "Descripcion");
            ViewBag.IdTipoCuentaGrupo5 = new SelectList(db.TiposCuentaGrupos.OrderBy(x => x.Descripcion), "IdTipoCuentaGrupo", "Descripcion");
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdPuntoVenta = new SelectList(db.PuntosVentas.Where(x => x.IdTipoComprobante == 2), "IdPuntoVenta", "PuntoVenta", o.IdPuntoVenta);
            
        }

        private bool Validar(ProntoMVC.Data.Models.Recibo o, ref string sErrorMsg)
        {
            if (!PuedeEditar(enumNodos.Recibos)) sErrorMsg += "\n" + "No tiene permisos de edición";

            if (o.NumeroRecibo == null) sErrorMsg += "\n" + "Falta el número de Recibo";

            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(Recibo Recibo)
        {
            if (!PuedeEditar(enumNodos.Recibos)) throw new Exception("No tenés permisos");

            try
            {
                string erar = "";





            }
            catch (System.Data.Entity.Validation.DbEntityValidationException ex)
            {
                StringBuilder sb = new StringBuilder();

                foreach (var failure in ex.EntityValidationErrors)
                {
                    sb.AppendFormat("{0} failed validation\n", failure.Entry.Entity.GetType());
                    foreach (var error in failure.ValidationErrors)
                    {
                        sb.AppendFormat("- {0} : {1}", error.PropertyName, error.ErrorMessage);
                        sb.AppendLine();
                    }
                }

                throw new System.Data.Entity.Validation.DbEntityValidationException(
                    "Entity Validation Failed - errors follow:\n" +
                    sb.ToString(), ex
                );
            }
            catch (Exception ex)
            {
                JsonResponse res = new JsonResponse();
                try
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest; //lo pongo en un try porque si lo llama un test, no hay httpcontext

                }
                catch (Exception)
                {
                }

                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);
                res.Message = ex.Message.ToString();
                return Json(res);
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }

        public class JsonResponse
        {
            public Status Status { get; set; }
            public string Message { get; set; }
            public List<string> Errors { get; set; }
        }

        public virtual FileResult Imprimir(int id) //(int id)
        {
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));

            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.docx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "ReciboNET_Hawk.docx";

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            System.IO.File.Copy(plantilla, output); // 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 
            Pronto.ERP.BO.Recibo fac = ReciboManager.GetItem(SC, id, true);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "Recibo.docx");
        }

        public virtual ActionResult Recibos(string sidx, string sord, int? page, int? rows, bool? _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var data = (from a in db.Recibos
                        from b in db.Cuentas.Where(p => p.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        from c in db.Monedas.Where(q => q.IdMoneda == a.IdMoneda).DefaultIfEmpty()
                        from d in db.Obras.Where(u => u.IdObra == a.IdObra).DefaultIfEmpty()
                        from e in db.Empleados.Where(w => w.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from f in db.Empleados.Where(x => x.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        from g in db.Vendedores.Where(y => y.IdVendedor == a.IdVendedor).DefaultIfEmpty()
                        from h in db.Vendedores.Where(y => y.IdVendedor == a.IdCobrador).DefaultIfEmpty()
                        select new
                        {
                            a.IdRecibo,
                            a.PuntoVenta,
                            a.NumeroRecibo,
                            a.FechaRecibo,
                            a.Tipo,
                            a.Anulado,
                            CodigoCliente = a.Cliente.CodigoCliente,
                            NombreCliente = a.Cliente.RazonSocial,
                            Cuenta = b != null ? b.Descripcion : "",
                            Moneda = c != null ? c.Abreviatura : "",
                            a.Deudores,
                            a.Valores,
                            a.RetencionIVA,
                            a.RetencionGanancias,
                            a.RetencionIBrutos,
                            OtrosConceptos = (a.Otros1 ?? 0) + (a.Otros2 ?? 0) + (a.Otros3 ?? 0) + (a.Otros4 ?? 0) + (a.Otros5 ?? 0) + (a.Otros6 ?? 0) + (a.Otros7 ?? 0) + (a.Otros8 ?? 0) + (a.Otros9 ?? 0) + (a.Otros10 ?? 0),
                            Obra = d != null ? d.NumeroObra : "",
                            Vendedor = g != null ? g.Nombre : "",
                            Cobrador = h != null ? h.Nombre : "",
                            Ingreso = e != null ? e.Nombre : "",
                            a.FechaIngreso,
                            Modifico = f != null ? f.Nombre : "",
                            a.FechaModifico,
                            a.Observaciones,
                            a.Cotizacion
                        }).AsQueryable(); 

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaRecibo >= FechaDesde && a.FechaRecibo <= FechaHasta select a).AsQueryable();
            }

            if (_search ?? false)
            {
                switch (searchField.ToLower())
                {
                    case "numeroRecibo":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaRecibo":
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

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .OrderByDescending(x => x.FechaRecibo)
                        .Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            //switch (sidx.ToLower())
            //{
            //    case "numeroRecibo":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroRecibo);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroRecibo);
            //        break;
            //    case "fechaRecibo":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.FechaRecibo);
            //        else
            //            Fac = Fac.OrderBy(a => a.FechaRecibo);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroRecibo);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroRecibo);
            //        break;
            //}

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data1
                        select new jqGridRowJson
                        {
                            id = a.IdRecibo.ToString(),
                            cell = new string[] { 
                                a.Tipo=="CC" ? "<a href="+ Url.Action("EditCC",new {id = a.IdRecibo} ) + " target='' >Editar</>" : "<a href="+ Url.Action("EditOT",new {id = a.IdRecibo} ) + " target='' >Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdRecibo} ) + ">Emitir</a> ",
                                a.IdRecibo.ToString(),
                                a.PuntoVenta.NullSafeToString(),
                                a.NumeroRecibo.NullSafeToString(),
                                a.FechaRecibo == null ? "" : a.FechaRecibo.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Tipo.NullSafeToString(),
                                a.Anulado.NullSafeToString(),
                                a.CodigoCliente.NullSafeToString(),
                                a.NombreCliente.NullSafeToString(),
                                a.Cuenta.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.Deudores.NullSafeToString(),
                                a.Valores.NullSafeToString(),
                                a.RetencionIVA.NullSafeToString(),
                                a.RetencionGanancias.NullSafeToString(),
                                a.RetencionIBrutos.NullSafeToString(),
                                a.OtrosConceptos.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.Vendedor.NullSafeToString(),
                                a.Cobrador.NullSafeToString(),
                                a.Ingreso.NullSafeToString(),
                                a.FechaIngreso.NullSafeToString(),
                                a.Modifico.NullSafeToString(),
                                a.FechaModifico.NullSafeToString(),
                                a.Cotizacion.NullSafeToString(),
                                a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetRecibosImputaciones(string sidx, string sord, int? page, int? rows, int? IdRecibo)
        {
            int IdRecibo1 = IdRecibo ?? 0;
            var Det = db.DetalleRecibos.Where(p => p.IdRecibo == IdRecibo1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;
            int mIdMonedaPesos = 1;
            int mIdMonedaDolar = 0;
            int mIdTipoComprobanteFacturaVenta = 0;
            int mIdTipoComprobanteDevoluciones = 0;
            int mIdTipoComprobanteNotaDebito = 0;
            int mIdTipoComprobanteNotaCredito = 0;
            int mIdTipoComprobanteRecibo = 0;

            Parametros parametros = db.Parametros.Find(1);
            mIdMonedaPesos = parametros.IdMoneda ?? 1;
            mIdMonedaDolar = parametros.IdMonedaDolar ?? 0;
            mIdTipoComprobanteFacturaVenta = parametros.IdTipoComprobanteFacturaVenta ?? 0;
            mIdTipoComprobanteDevoluciones = parametros.IdTipoComprobanteDevoluciones ?? 0;
            mIdTipoComprobanteNotaDebito = parametros.IdTipoComprobanteNotaDebito ?? 0;
            mIdTipoComprobanteNotaCredito = parametros.IdTipoComprobanteNotaCredito ?? 0;
            mIdTipoComprobanteRecibo = parametros.IdTipoComprobanteRecibo ?? 0;

            var data = (from a in Det
                        from b in db.CuentasCorrientesDeudores.Where(o => o.IdCtaCte == a.IdImputacion).DefaultIfEmpty()
                        from c in db.Facturas.Where(p => p.IdFactura == (b.IdComprobante ?? 0) && (b.IdTipoComp ?? 0) == mIdTipoComprobanteFacturaVenta).DefaultIfEmpty()
                        from d in db.Devoluciones.Where(p => p.IdDevolucion == (b.IdComprobante ?? 0) && (b.IdTipoComp ?? 0) == mIdTipoComprobanteDevoluciones).DefaultIfEmpty()
                        from e in db.NotasDebitoes.Where(p => p.IdNotaDebito == (b.IdComprobante ?? 0) && (b.IdTipoComp ?? 0) == mIdTipoComprobanteNotaDebito).DefaultIfEmpty()
                        from f in db.NotasCreditoes.Where(p => p.IdNotaCredito == (b.IdComprobante ?? 0) && (b.IdTipoComp ?? 0) == mIdTipoComprobanteNotaCredito).DefaultIfEmpty()
                        from g in db.Recibos.Where(p => p.IdRecibo == (b.IdComprobante ?? 0) && (b.IdTipoComp ?? 0) == mIdTipoComprobanteRecibo).DefaultIfEmpty()
                        from h in db.TiposComprobantes.Where(o => o.IdTipoComprobante == b.IdTipoComp).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleRecibo,
                            a.IdImputacion,
                            b.CotizacionMoneda,
                            b.IdTipoComp,
                            b.IdComprobante,
                            Tipo = h != null ? h.DescripcionAb : "",
                            Letra = c != null ? c.TipoABC : (d != null ? d.TipoABC : (e != null ? e.TipoABC : (f != null ? f.TipoABC : ""))),
                            PuntoVenta = c != null ? c.PuntoVenta : (d != null ? d.PuntoVenta : (e != null ? e.PuntoVenta : (f != null ? f.PuntoVenta : (g != null ? g.PuntoVenta : 0)))),
                            Numero = c != null ? c.NumeroFactura : (d != null ? d.NumeroDevolucion : (e != null ? e.NumeroNotaDebito : (f != null ? f.NumeroNotaCredito : (g != null ? g.NumeroRecibo : b.NumeroComprobante)))),
                            b.Fecha,
                            ImporteOriginal = a.Recibo.IdMoneda == mIdMonedaDolar ? b.ImporteTotalDolar * h.Coeficiente : b.ImporteTotal * h.Coeficiente,
                            Saldo = a.Recibo.IdMoneda == mIdMonedaDolar ? b.Saldo * h.Coeficiente : b.Saldo * h.Coeficiente,
                            a.Importe
                        }).OrderBy(x => x.IdDetalleRecibo).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleRecibo.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleRecibo.ToString(), 
                            a.IdImputacion.ToString(), 
                            a.CotizacionMoneda.ToString(), 
                            a.IdTipoComp.ToString(), 
                            a.IdComprobante.ToString(), 
                            a.Tipo.NullSafeToString(),
                            a.Letra + '-' + a.PuntoVenta.NullSafeToString().PadLeft(4,'0') + '-' + a.Numero.NullSafeToString().PadLeft(8,'0'),
                            a.Fecha == null ? "" : a.Fecha.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.ImporteOriginal.ToString(),
                            a.Saldo.ToString(),
                            a.Importe.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetRecibosValores(string sidx, string sord, int? page, int? rows, int? IdRecibo)
        {
            int IdRecibo1 = IdRecibo ?? 0;
            var Det = db.DetalleRecibosValores.Where(p => p.IdRecibo == IdRecibo1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Bancos.Where(o => o.IdBanco == a.IdBanco).DefaultIfEmpty()
                        from c in db.Cajas.Where(p => p.IdCaja == a.IdCaja).DefaultIfEmpty()
                        from d in db.TarjetasCreditoes.Where(q => q.IdTarjetaCredito == a.IdTarjetaCredito).DefaultIfEmpty()
                        from f in db.TiposComprobantes.Where(s => s.IdTipoComprobante == a.IdTipoValor).DefaultIfEmpty()
                        from g in db.CuentasBancarias.Where(t => t.IdCuentaBancaria == a.IdCuentaBancariaTransferencia).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleReciboValores,
                            a.IdTipoValor,
                            a.IdBanco,
                            a.IdCuentaBancariaTransferencia,
                            a.IdCaja,
                            a.IdTarjetaCredito,
                            Tipo = f.DescripcionAb != null ? f.DescripcionAb : "",
                            a.FechaVencimiento,
                            a.Importe,
                            a.NumeroInterno,
                            a.NumeroValor,
                            a.NumeroTransferencia,
                            a.NumeroTarjetaCredito,
                            Banco = b != null ? b.Nombre : "",
                            Caja = c != null ? c.Descripcion : "",
                            TarjetaCredito = d != null ? d.Nombre : "",
                            CuentaBancaria = g != null ? g.Cuenta : "",
                            a.CuitLibrador
                        }).OrderBy(x => x.IdDetalleReciboValores).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleReciboValores.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleReciboValores.ToString(), 
                            a.IdTipoValor.NullSafeToString(),
                            a.IdBanco.NullSafeToString(),
                            a.IdCuentaBancariaTransferencia.NullSafeToString(),
                            a.IdCaja.NullSafeToString(),
                            a.IdTarjetaCredito.NullSafeToString(),
                            a.Tipo,
                            a.FechaVencimiento == null ? "" : a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.Importe.ToString(),
                            a.NumeroInterno.NullSafeToString(),
                            a.NumeroValor.NullSafeToString(),
                            a.NumeroTransferencia.NullSafeToString(),
                            a.NumeroTarjetaCredito.NullSafeToString(),
                            a.Banco,
                            a.Caja,
                            a.TarjetaCredito,
                            a.CuentaBancaria,
                            a.CuitLibrador
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetRecibosCuentas(string sidx, string sord, int? page, int? rows, int? IdRecibo)
        {
            int IdRecibo1 = IdRecibo ?? 0;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Det = db.DetalleRecibosCuentas.Where(p => p.IdRecibo == IdRecibo1).AsQueryable();

            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Det.AsEnumerable()
                        from b in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        from c in db.DetalleCuentas.Where(o => o.IdCuenta == a.IdCuenta && o.FechaCambio > a.Recibo.FechaRecibo).OrderByDescending(o => o.FechaCambio).DefaultIfEmpty()
                        from d in db.Cajas.Where(t => t.IdCaja == a.IdCaja).DefaultIfEmpty()
                        from f in db.Obras.Where(t => t.IdObra == a.IdObra).DefaultIfEmpty()
                        from g in db.CuentasBancarias.Where(t => t.IdCuentaBancaria == a.IdCuentaBancaria).DefaultIfEmpty()
                        from h in db.CuentasGastos.Where(t => t.IdCuentaGasto == a.IdCuentaGasto).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleReciboCuentas,
                            a.IdCuenta,
                            a.IdObra,
                            a.IdCuentaGasto,
                            a.IdCuentaBancaria,
                            a.IdCaja,
                            a.IdMoneda,
                            a.CotizacionMonedaDestino,
                            IdTipoCuentaGrupo = 0,
                            Codigo = b != null ? b.Codigo : 0,
                            Cuenta = b != null ? b.Descripcion : "",
                            CuentaBancaria = g != null ? g.Banco.Nombre + " " + g.Cuenta : "",
                            Caja = d != null ? d.Descripcion : "",
                            Obra = f != null ? f.Descripcion : "",
                            CuentaGasto = h != null ? h.Descripcion : "",
                            TipoCuentaGrupo = "",
                            a.Debe,
                            a.Haber
                        }).OrderBy(x => x.IdDetalleReciboCuentas).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleReciboCuentas.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleReciboCuentas.ToString(), 
                            a.IdCuenta.NullSafeToString(),
                            a.IdObra.ToString(),
                            a.IdCuentaGasto.ToString(),
                            a.IdCuentaBancaria.ToString(),
                            a.IdCaja.ToString(),
                            a.IdMoneda.ToString(),
                            a.CotizacionMonedaDestino.ToString(),
                            a.IdTipoCuentaGrupo.ToString(),
                            a.Codigo.NullSafeToString(),
                            a.Cuenta.NullSafeToString(),
                            a.Debe.ToString(),
                            a.Haber.ToString(),
                            a.CuentaBancaria.NullSafeToString(),
                            a.Caja.NullSafeToString(),
                            a.Obra.NullSafeToString(),
                            a.CuentaGasto.NullSafeToString(),
                            a.TipoCuentaGrupo.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetRecibosRubrosContables(string sidx, string sord, int? page, int? rows, int? IdRecibo)
        {
            int IdRecibo1 = IdRecibo ?? 0;
            var Det = db.DetalleRecibosRubrosContables.Where(p => p.IdRecibo == IdRecibo1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.RubrosContables.Where(o => o.IdRubroContable == a.IdRubroContable).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleReciboRubrosContables,
                            a.IdRubroContable,
                            RubroContable = b.Descripcion != null ? b.Descripcion : "",
                            a.Importe
                        }).OrderBy(x => x.IdDetalleReciboRubrosContables).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleReciboRubrosContables.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleReciboRubrosContables.ToString(), 
                            a.IdRubroContable.NullSafeToString(),
                            a.RubroContable.NullSafeToString(),
                            a.Importe.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult CalcularAsiento(Recibo Recibo)
        {
            List<DetalleRecibosCuenta> asiento = new List<DetalleRecibosCuenta>();
            DetalleRecibosCuenta rc;

            Int32 IdCliente = 0;
            Int32 mIdCuenta = 0;
            Int32 mIdCuentaPricipal = 0;
            Int32 mIdCuentaPricipalMonedaExtranjera = 0;
            Int32 mIdCuentaCaja = 0;
            Int32 mIdCuentaValores = 0;
            Int32 mIdCuentaValores1 = 0;
            Int32 mIdCuentaRetencionIVA = 0;
            Int32 mIdCuentaRetencionGanancias = 0;
            Int32 mIdCuentaRetencionIBrutos = 0;
            Int32 mIdCuentaDescuentos = 0;
            Int32 mIdCuentaOtros = 0;
            Int32 mIdMonedaPesos = 0;
            Int32 mIdAux = 0;

            decimal mDebeHaber = 0;
            decimal mRetencionGanancias = 0;
            decimal mRetencionIVA = 0;
            decimal mImporte = 0;
            decimal mRetencionIBrutos = 0;
            decimal mTotalValores = 0;
            decimal mOtros = 0;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));

            var Parametros2 = db.Parametros2.Where(p => p.Campo == "IdCuentaRetencionIvaCobros").FirstOrDefault();
            if (Parametros2 != null) { mIdCuentaRetencionIVA = Convert.ToInt32(Parametros2.Valor); }

            var Parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mIdCuentaCaja = Parametros.IdCuentaCaja ?? 0;
            if (mIdCuentaRetencionIVA == 0) { mIdCuentaRetencionIVA = Parametros.IdCuentaRetencionIva ?? 0; }
            mIdCuentaRetencionGanancias = Parametros.IdCuentaRetencionGananciasCobros ?? 0;
            mIdCuentaRetencionIBrutos = Parametros.IdCuentaRetencionIBrutos ?? 0;
            mIdCuentaDescuentos = Parametros.IdCuentaDescuentos ?? 0;
            mIdMonedaPesos = Parametros.IdMoneda ?? 1;

            mIdCuentaPricipal = Recibo.IdCuenta ?? 0;
            mIdCuentaPricipalMonedaExtranjera = mIdCuentaPricipal;

            IdCliente = Recibo.IdCliente ?? 0;
            if (IdCliente > 0)
            {
                var Cliente = db.Clientes.Where(p => p.IdCliente == IdCliente).FirstOrDefault();
                if (Cliente != null)
                {
                    mIdCuentaPricipal = Cliente.IdCuenta ?? 0;
                    mIdCuentaPricipalMonedaExtranjera = Cliente.IdCuentaMonedaExt ?? 0;
                };
            }

            mRetencionIVA = Recibo.RetencionIVA ?? 0;
            if (mImporte != 0)
            {
                rc = new DetalleRecibosCuenta();
                rc.IdCuenta = mIdCuentaRetencionIVA;
                if (mRetencionIVA >= 0) { rc.Debe = mRetencionIVA; } else { rc.Haber = mRetencionIVA * -1; };
                mDebeHaber += mRetencionIVA;
                asiento.Add(rc);
            };

            mRetencionGanancias = Recibo.RetencionGanancias ?? 0;
            if (mRetencionGanancias != 0)
            {
                rc = new DetalleRecibosCuenta();
                rc.IdCuenta = mIdCuentaRetencionGanancias;
                if (mRetencionGanancias >= 0) { rc.Debe = mRetencionGanancias; } else { rc.Haber = mRetencionGanancias * -1; };
                mDebeHaber += mRetencionGanancias;
                asiento.Add(rc);
            };

            mRetencionIBrutos = Recibo.RetencionIBrutos ?? 0;
            if (mRetencionGanancias != 0)
            {
                rc = new DetalleRecibosCuenta();
                rc.IdCuenta = mIdCuentaRetencionGanancias;
                if (mRetencionIBrutos >= 0) { rc.Debe = mRetencionIBrutos; } else { rc.Haber = mRetencionIBrutos * -1; };
                mDebeHaber += mRetencionIBrutos;
                asiento.Add(rc);
            };

            for (int i = 1; i<=10; i++)
            {
                if (i == 1) { mOtros = Recibo.Otros1 ?? 0; mIdCuentaOtros = Recibo.IdCuenta1 ?? 0; }
                if (i == 2) { mOtros = Recibo.Otros2 ?? 0; mIdCuentaOtros = Recibo.IdCuenta2 ?? 0; }
                if (i == 3) { mOtros = Recibo.Otros3 ?? 0; mIdCuentaOtros = Recibo.IdCuenta3 ?? 0; }
                if (i == 4) { mOtros = Recibo.Otros4 ?? 0; mIdCuentaOtros = Recibo.IdCuenta4 ?? 0; }
                if (i == 5) { mOtros = Recibo.Otros5 ?? 0; mIdCuentaOtros = Recibo.IdCuenta5 ?? 0; }
                if (i == 6) { mOtros = Recibo.Otros6 ?? 0; mIdCuentaOtros = Recibo.IdCuenta6 ?? 0; }
                if (i == 7) { mOtros = Recibo.Otros7 ?? 0; mIdCuentaOtros = Recibo.IdCuenta7 ?? 0; }
                if (i == 8) { mOtros = Recibo.Otros8 ?? 0; mIdCuentaOtros = Recibo.IdCuenta8 ?? 0; }
                if (i == 9) { mOtros = Recibo.Otros9 ?? 0; mIdCuentaOtros = Recibo.IdCuenta9 ?? 0; }
                if (i == 10) { mOtros = Recibo.Otros10 ?? 0; mIdCuentaOtros = Recibo.IdCuenta10 ?? 0; }

                if (mOtros != 0)
                {
                    rc = new DetalleRecibosCuenta();
                    rc.IdCuenta = mIdCuentaOtros;
                    if (mOtros >= 0) { rc.Debe = mOtros; } else { rc.Haber = mOtros * -1; };
                    mDebeHaber += mOtros;
                    asiento.Add(rc);
                }
            }
            
            mTotalValores = 0;
            foreach (var a in Recibo.DetalleRecibosValores)
            {
                mIdCuentaValores1 = a.IdCuenta ?? mIdCuentaValores;
                mTotalValores += a.Importe ?? 0;

                if (a.IdCaja != null)
                {
                    var Cajas = db.Cajas.Where(p => p.IdCaja == a.IdCaja).FirstOrDefault();
                    if (Cajas != null) { if (Cajas.IdCuenta != null) { mIdCuentaValores1 = Cajas.IdCuenta ?? 0; } }
                };

                if (a.IdTarjetaCredito != null)
                {
                    var TarjetasCreditoes = db.TarjetasCreditoes.Where(p => p.IdTarjetaCredito == a.IdTarjetaCredito).FirstOrDefault();
                    if (TarjetasCreditoes != null) { if (TarjetasCreditoes.IdCuenta != null) { mIdCuentaValores1 = TarjetasCreditoes.IdCuenta ?? 0; } }
                };
                
                rc = new DetalleRecibosCuenta();
                rc.IdCuenta = mIdCuentaValores1;
                rc.Debe = a.Importe ?? 0;
                mDebeHaber += a.Importe ?? 0;
                asiento.Add(rc);
            };

            rc = new DetalleRecibosCuenta();
            rc.IdCuenta = mIdCuentaPricipal;
            if (mDebeHaber >= 0) { rc.Debe = mDebeHaber * -1; } else { rc.Haber = mDebeHaber; };
            asiento.Add(rc);

            var data = (from a in asiento.ToList()
                        from b in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleReciboCuentas,
                            a.IdCuenta,
                            Codigo = b != null ? b.Codigo : 0,
                            Cuenta = b != null ? b.Descripcion : "",
                            a.Debe,
                            a.Haber
                        }).OrderBy(x => x.IdDetalleReciboCuentas).ToList();

            return Json(JsonConvert.SerializeObject(data), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdRecibo, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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