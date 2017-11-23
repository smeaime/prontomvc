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
    public partial class NotaDebitoController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            //if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
            //    !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
            //   !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
            //    ) throw new Exception("No tenés permisos");

            return View();
        }
        public virtual ActionResult Edit(int id)
        {

            //if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
            //   !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
            //   !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
            //   ) throw new Exception("No tenés permisos");

            if (id == -1)
            {
                NotasDebito NotaDebito = new NotasDebito();

                inic(ref NotaDebito);
                CargarViewBag(NotaDebito);
                return View(NotaDebito);
            }
            else
            {
                NotasDebito NotaDebito = db.NotasDebitoes.Find(id);

                CargarViewBag(NotaDebito);
                Session.Add("NotaDebito", NotaDebito);
                return View(NotaDebito);
            }
        }

        public virtual ActionResult Delete(int id)
        {
            NotasDebito NotaDebito = db.NotasDebitoes.Find(id);
            return View(NotaDebito);
        }

        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            NotasDebito NotaDebito = db.NotasDebitoes.Find(id);
            db.NotasDebitoes.Remove(NotaDebito);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult Anular(int id)
        {
            NotasDebito NotaDebito = db.NotasDebitoes.Find(id);
            NotaDebito.Anulada = "SI";
            NotaDebito.FechaAnulacion = DateTime.Now;
            NotaDebito.IdUsuarioAnulacion = 0;
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        void inic(ref NotasDebito o)
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
            o.FechaNotaDebito = DateTime.Today;

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

        void CargarViewBag(NotasDebito o)
        {
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdIBCondicion = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);
            ViewBag.IdIBCondicion2 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion2);
            ViewBag.IdIBCondicion3 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion3);
            ViewBag.IdObra = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra);
            ViewBag.IdPuntoVenta = new SelectList(db.PuntosVentas.Where(x => x.IdTipoComprobante == 3), "IdPuntoVenta", "PuntoVenta", o.IdPuntoVenta);
        }

        public virtual ActionResult TT // (string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
                                       (string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal)
        {

            DateTime FechaDesde, FechaHasta;
            try
            {
                FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            }
            catch (Exception)
            {

                FechaDesde = DateTime.MinValue;
            }
            try
            {
                FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            }
            catch (Exception)
            {

                FechaHasta = DateTime.MaxValue;
            }

            int totalRecords = 0;

            IQueryable<Data.Models.NotasDebito> q = (from a in db.NotasDebitoes where a.FechaNotaDebito >= FechaDesde && a.FechaNotaDebito <= FechaHasta select a).AsQueryable();
            List<Data.Models.NotasDebito> pagedQuery =
            Filters.FiltroGenerico_UsandoIQueryable<Data.Models.NotasDebito>(sidx, sord, page, rows, _search, filters, db, ref totalRecords, q);

            string campo = String.Empty;
            int pageSize = rows;
            int currentPage = page;

            var data = (from a in pagedQuery
                        from b in db.DescripcionIvas.Where(v => v.IdCodigoIva == a.IdCodigoIva).DefaultIfEmpty()
                        from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                        from d in db.Vendedores.Where(v => v.IdVendedor == a.IdVendedor).DefaultIfEmpty()
                        from e in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from f in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioAnulacion).DefaultIfEmpty()
                        from g in db.Provincias.Where(v => v.IdProvincia == a.IdProvinciaDestino).DefaultIfEmpty()
                        select new
                        {
                            a.IdNotaDebito,
                            Tipo = a.CtaCte == "SI" ? "Normal" : "Interna",
                            a.TipoABC,
                            a.PuntoVenta,
                            a.NumeroNotaDebito,
                            a.FechaNotaDebito,
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
                            a.NumeroCuota,
                            a.FechaIngreso,
                            UsuarioIngreso = e != null ? e.Nombre : "",
                            a.CAE,
                            a.RechazoCAE,
                            a.FechaVencimientoORechazoCAE,
                            a.Observaciones
                        }).AsQueryable();

            //if (FechaInicial != string.Empty)
            //{
            //    DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            //    DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            //    data = (from a in data where a.FechaNotaDebito >= FechaDesde && a.FechaNotaDebito <= FechaHasta select a).AsQueryable();
            //}

  //          int totalRecords = data.Count();  
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a);
                        //.OrderByDescending(x => x.FechaNotaDebito)
                        //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                        //.ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data1
                        select new jqGridRowJson
                        {
                            id = a.IdNotaDebito.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdNotaDebito} ) + ">Editar</>",
                                "<a href="+ Url.Action("ImprimirConInteropPDF",new {id = a.IdNotaDebito} ) + ">Emitir</a> ",
                                a.IdNotaDebito.NullSafeToString(),
                                a.Tipo.NullSafeToString(),
                                a.TipoABC.NullSafeToString(),
                                a.PuntoVenta.NullSafeToString(),
                                a.NumeroNotaDebito.NullSafeToString(),
                                a.FechaNotaDebito == null ? "" : a.FechaNotaDebito.GetValueOrDefault().ToString("dd/MM/yyyy"),
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
                                a.NumeroCuota.NullSafeToString(),
                                a.CAE.NullSafeToString(),
                                a.RechazoCAE.NullSafeToString(),
                                a.FechaVencimientoORechazoCAE.NullSafeToString(),
                                a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult TT_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal)
        {
            DateTime FechaDesde, FechaHasta;
            try
            {
                if (FechaInicial == "") FechaDesde = DateTime.MinValue;
                else FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            }
            catch (Exception)
            {
                FechaDesde = DateTime.MinValue;
            }

            try
            {
                if (FechaFinal == "") FechaHasta = DateTime.MaxValue;
                else FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            }
            catch (Exception)
            {
                FechaHasta = DateTime.MaxValue;
            }

            int totalRecords = 0;

            IQueryable<Data.Models.NotasDebito> q = (from a in db.NotasDebitoes where a.FechaNotaDebito >= FechaDesde && a.FechaNotaDebito <= FechaHasta select a).AsQueryable();

            List<Data.Models.NotasDebito> pagedQuery =
            Filters.FiltroGenerico_UsandoIQueryable<Data.Models.NotasDebito>(sidx, sord, page, rows, _search, filters, db, ref totalRecords, q);

            //var pagedQuery = Filters.FiltroGenerico<Data.Models.NotasDebito>
            //                    ("Localidade,Provincia,Vendedore,Empleado,Cuentas,Transportista", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            string campo = String.Empty;
            int pageSize = rows ;
            int currentPage = page ;

            var data = (from a in pagedQuery
                        //from b in db.DescripcionIvas.Where(v => v.IdCodigoIva == a.IdCodigoIva).DefaultIfEmpty()
                        //from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                        //from d in db.Vendedores.Where(v => v.IdVendedor == a.IdVendedor).DefaultIfEmpty()
                        //from e in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        //from f in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioAnulacion).DefaultIfEmpty()
                        //from g in db.Provincias.Where(v => v.IdProvincia == a.IdProvinciaDestino).DefaultIfEmpty()
                        select new
                        {
                            a.IdNotaDebito,
                            Tipo = a.CtaCte == "SI" ? "Normal" : "Interna",
                            a.TipoABC,
                            a.PuntoVenta,
                            a.NumeroNotaDebito,
                            a.FechaNotaDebito,
                            a.Anulada,
                            ClienteCodigo = a.Cliente.CodigoCliente,
                            ClienteNombre = a.Cliente.RazonSocial,
                            DescripcionIva = a.DescripcionIva != null ? a.DescripcionIva.Descripcion : "",
                            ClienteCuit = a.Cliente.Cuit,
                            TotalGravado = (a.ImporteTotal ?? 0) - (a.ImporteIva1 ?? 0) - (a.PercepcionIVA ?? 0) - (a.RetencionIBrutos1 ?? 0) - (a.RetencionIBrutos2 ?? 0) - (a.RetencionIBrutos3 ?? 0) - (a.OtrasPercepciones1 ?? 0) - (a.OtrasPercepciones2 ?? 0) - (a.OtrasPercepciones3 ?? 0),
                            TotalIva = a.ImporteIva1,
                            TotalIIBB = (a.RetencionIBrutos1 ?? 0) + (a.RetencionIBrutos2 ?? 0) + (a.RetencionIBrutos3 ?? 0),
                            TotalPercepcionIVA = a.PercepcionIVA,
                            TotalOtrasPercepciones = (a.OtrasPercepciones1 ?? 0) + (a.OtrasPercepciones2 ?? 0) + (a.OtrasPercepciones3 ?? 0),
                            a.ImporteTotal,
                            MonedaAbreviatura = a.Moneda.Abreviatura,
                            Obra = a.Obra != null ? a.Obra.NumeroObra : "",
                            Vendedor = a.Vendedore != null ? a.Vendedore.Nombre : "",
                            ProvinciaDestino = a.Provincia != null ? a.Provincia.Nombre : "",
                            a.FechaAnulacion,
                            UsuarioAnulo = a.Empleado != null ? a.Empleado.Nombre : "",
                            a.NumeroCuota,
                            a.FechaIngreso,
                            UsuarioIngreso = a.Empleado1 != null ? a.Empleado1.Nombre : "",
                            a.CAE,
                            a.RechazoCAE,
                            a.FechaVencimientoORechazoCAE,
                            a.Observaciones
                        }).AsQueryable();
            
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        //.OrderByDescending(x => x.FechaNotaDebito)
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
                            id = a.IdNotaDebito.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdNotaDebito} ) + ">Editar</>",
                                "<a href="+ Url.Action("ImprimirConInteropPDF",new {id = a.IdNotaDebito} ) + ">Emitir</a> ",
                                a.IdNotaDebito.NullSafeToString(),
                                a.Tipo.NullSafeToString(),
                                a.TipoABC.NullSafeToString(),
                                a.PuntoVenta.NullSafeToString(),
                                a.NumeroNotaDebito.NullSafeToString(),
                                a.FechaNotaDebito == null ? "" : a.FechaNotaDebito.GetValueOrDefault().ToString("dd/MM/yyyy"),
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
                                a.NumeroCuota.NullSafeToString(),
                                a.CAE.NullSafeToString(),
                                a.RechazoCAE.NullSafeToString(),
                                a.FechaVencimientoORechazoCAE.NullSafeToString(),
                                a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual FileResult ImprimirConInteropPDF(int id)
        {
            int idcliente = buscaridclienteporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));
            //if (db.Facturas.Find(id).IdCliente != idcliente
            //     && !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
            //!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") && 
            //    !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Comercial")
            //    ) throw new Exception("Sólo podes acceder a facturas a tu nombre");

            string baseP = this.HttpContext.Session["BasePronto"].ToString();

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.pdf"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            string plantilla;
            if (db.NotasDebitoes.Find(id).TipoABC == "A")
            {
                plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "NotaDebito_A_" + baseP + "";
            }
            else
            {
                plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "NotaDebito_B_" + baseP + "";
            }

            if (db.NotasDebitoes.Find(id).CAE.NullSafeToString() != "")
            {
                plantilla += "_NDE.dot";
            }
            else
            {
                plantilla += ".dot";
            }

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            //Pronto.ERP.BO.NotaDebito fac = NotaDebitoManager.GetItem(SC, id, true);

            object nulo = null;
            var mvarClausula = false;
            var mPrinter = "";
            var mCopias = 1;

            EntidadManager.ImprimirWordDOT_VersionDLL_PDF(plantilla, ref nulo, SC, nulo, ref nulo, id, mvarClausula, mPrinter, mCopias, output);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "NotaDebito.pdf");
        }

        public virtual ActionResult DetNotaDebito(string sidx, string sord, int? page, int? rows, int? IdNotaDebito)
        {
            int IdNotaDebito1 = IdNotaDebito ?? 0;
            var Det = db.DetalleNotasDebitoes.Where(p => p.IdNotaDebito == IdNotaDebito1).AsQueryable();
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
                            a.IdDetalleNotaDebito,
                            a.IdConcepto,
                            a.IdCuentaBancaria,
                            a.IdCaja,
                            a.IdDiferenciaCambio,
                            Concepto = b != null ? b.Descripcion : "",
                            CuentaBancaria = d != null ? d.Cuenta : "",
                            Caja = c != null ? c.Descripcion : "",
                            a.Gravado,
                            a.Importe,
                            a.PorcentajeIva,
                            a.ImporteIva,
                            a.IvaNoDiscriminado
                        }).OrderBy(x => x.IdDetalleNotaDebito)
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
                            id = a.IdDetalleNotaDebito.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleNotaDebito.ToString(), 
                            a.IdConcepto.NullSafeToString(),
                            a.IdCuentaBancaria.NullSafeToString(),
                            a.IdCaja.NullSafeToString(),
                            a.IdDiferenciaCambio.NullSafeToString(),
                            a.Concepto.NullSafeToString(),
                            a.CuentaBancaria.NullSafeToString(),
                            a.Caja.NullSafeToString(),
                            a.Gravado.NullSafeToString(),
                            a.PorcentajeIva.NullSafeToString(),
                            a.ImporteIva.NullSafeToString(),
                            a.IvaNoDiscriminado.NullSafeToString(),
                            a.Importe.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetNotaDebitoProvincias(string sidx, string sord, int? page, int? rows, int? IdNotaDebito)
        {
            int IdNotaDebito1 = IdNotaDebito ?? 0;
            var Det = db.DetalleNotasDebitoProvincias.Where(p => p.IdNotaDebito == IdNotaDebito1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Provincias.Where(o => o.IdProvincia == a.IdProvinciaDestino).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleNotaDebitoProvincias,
                            a.IdProvinciaDestino,
                            Provincia = b != null ? b.Nombre : "",
                            a.Porcentaje
                        }).OrderBy(x => x.IdDetalleNotaDebitoProvincias)
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
                            id = a.IdDetalleNotaDebitoProvincias.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleNotaDebitoProvincias.NullSafeToString(),
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

        private bool Validar(ProntoMVC.Data.Models.NotasDebito o, ref string sErrorMsg, ref string sWarningMsg)
        {
            Int32 mIdNotaDebito = 0;
            Int32 mNumero = 0;
            Int32 mIdMoneda = 1;
            Int32 mIdCliente = 1;
            Int32 mIdPuntoVenta = 0;
            Int32 mIdTipoComprobante = 3;
            
            string mObservaciones = "";
            string mTipoABC = "";
            string mCAI = "";
            string mWS = "";
            string mWSModoTest = "";
            string mCAEManual = "";
            string mProntoIni = "";
            string mCtaCte = "";
            string mAnulada = "";
            
            DateTime mFechaNotaDebito = DateTime.Today;
            DateTime mFechaUltimoCierre = DateTime.Today;
            DateTime mFechaCAI = DateTime.MinValue;

            mIdNotaDebito = o.IdNotaDebito;
            mFechaNotaDebito = o.FechaNotaDebito ?? DateTime.MinValue;
            mNumero = o.NumeroNotaDebito ?? 0;
            mIdMoneda = o.IdMoneda ?? 1;
            mIdCliente = o.IdCliente ?? 0;
            mObservaciones = o.Observaciones ?? "";
            mIdPuntoVenta = o.IdPuntoVenta ?? 0;
            mTipoABC = o.TipoABC ?? "";
            mCtaCte = o.CtaCte ?? "";
            mAnulada = o.Anulada ?? "";

            var parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mFechaUltimoCierre = parametros.FechaUltimoCierre ?? DateTime.Today;

            if ((o.NumeroNotaDebito ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número"; }
            if ((o.TipoABC ?? "") == "") { sErrorMsg += "\n" + "Falta la letra del comprobante"; }
            if ((o.AplicarEnCtaCte ?? "") == "") { sErrorMsg += "\n" + "Falta definir si va a cuenta corriente"; }
            if ((o.CtaCte ?? "") == "") { sErrorMsg += "\n" + "Falta definir si es normal o interna"; }
            if (o.FechaNotaDebito < mFechaUltimoCierre) { sErrorMsg += "\n" + "La fecha no puede ser anterior a la del ultimo cierre contable"; }
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
                if ((o.ImporteIva1 ?? 0) != 0) { sErrorMsg += "\n" + "Una nota de debito interna no puede tener iva"; }
            }

            if (mIdPuntoVenta > 0)
            {
                var PuntoVenta = db.PuntosVentas.Where(p => p.IdPuntoVenta == mIdPuntoVenta).FirstOrDefault();
                if (PuntoVenta != null)
                {
                    if (mTipoABC == "A" || mTipoABC == "M")
                    {
                        mCAI = PuntoVenta.NumeroCAI_D_A ?? "";
                        mFechaCAI = PuntoVenta.FechaCAI_D_A ?? DateTime.MinValue;
                    }
                    if (mTipoABC == "B")
                    {
                        mCAI = PuntoVenta.NumeroCAI_D_B ?? "";
                        mFechaCAI = PuntoVenta.FechaCAI_D_B ?? DateTime.MinValue;
                    }
                    if (mTipoABC == "E")
                    {
                        mCAI = PuntoVenta.NumeroCAI_D_E ?? "";
                        mFechaCAI = PuntoVenta.FechaCAI_D_E ?? DateTime.MinValue;
                    }
                    mWS = PuntoVenta.WebService ?? "";
                    mWSModoTest = PuntoVenta.WebServiceModoTest ?? "";
                    mCAEManual = PuntoVenta.CAEManual ?? "";
                }
                if ((mTipoABC == "A" || mTipoABC == "M") && mWS.Length == 0 && mCAI.Length == 0) { sErrorMsg += "\n" + "No existe numero de CAI"; }
                if (mWS.Length == 0 && mCAI.Length > 0 && mFechaNotaDebito > mFechaCAI) { sErrorMsg += "\n" + "El CAI vencio el " + mFechaCAI.ToString() + "."; }
                if (mCAEManual == "SI" && (o.CAE ?? "").Length != 14) { sErrorMsg += "\n" + "Numero de CAE incorrecto (debe tener 14 digitos)"; }
                if (mCAI.Length > 0)
                {
                    o.NumeroCAI = Convert.ToDecimal(mCAI);
                    o.FechaVencimientoCAI = mFechaCAI;
                }
            }

            mProntoIni = BuscarClaveINI("Validar fecha de facturas nuevas", -1);
            if ((mProntoIni ?? "") == "SI" && mIdNotaDebito <= 0 && mIdPuntoVenta > 0)
            {
                var NotaDebito = db.NotasDebitoes.Where(p => p.IdPuntoVenta == mIdPuntoVenta).OrderByDescending(p => p.FechaNotaDebito).FirstOrDefault();
                if (NotaDebito != null)
                { if (NotaDebito.FechaNotaDebito > mFechaNotaDebito) { sErrorMsg += "\n" + "La fecha de la ultima nota de debito es " + NotaDebito.FechaNotaDebito.ToString() + " para este punto de venta."; } }
            }

            var Cliente = db.Clientes.Where(p => p.IdCliente == mIdCliente).FirstOrDefault();
            if (Cliente != null)
            {
                if (Cliente.Estados_Proveedores != null) { if ((Cliente.Estados_Proveedores.Activo ?? "") == "NO") { sErrorMsg += "\n" + "Cliente inhabilitado"; } }
            }

            foreach (ProntoMVC.Data.Models.DetalleNotasDebito x in o.DetalleNotasDebitoes)
            {
                if ((x.IdCuentaBancaria ?? 0) > 0)
                {
                    CuentasBancaria CuentasBancaria = db.CuentasBancarias.Where(c => c.IdCuentaBancaria == x.IdCuentaBancaria).SingleOrDefault();
                    if (CuentasBancaria != null)
                    {
                        if (mIdMoneda != (CuentasBancaria.IdMoneda ?? 0)) { sErrorMsg += "\n" + "Hay valores con una moneda distinta a la del comprobante"; }
                    }
                    else
                    {
                        sErrorMsg += "\n" + "Hay valores que apuntan a cuentas bancarias inexistentes";
                    }
                }
                if ((x.IdCaja ?? 0) > 0)
                {
                    Caja Caja = db.Cajas.Where(c => c.IdCaja == x.IdCaja).SingleOrDefault();
                    if (Caja != null)
                    {
                        if (mIdMoneda != (Caja.IdMoneda ?? 0)) { sErrorMsg += "\n" + "Hay una caja con una moneda distinta a la del comprobante"; }
                    }
                }
            }

            if (mAnulada=="SI")
            {
                CuentasCorrientesDeudor CtaCte = db.CuentasCorrientesDeudores.Where(c => c.IdTipoComp == mIdTipoComprobante && c.IdComprobante == mIdNotaDebito).SingleOrDefault();
                if (CtaCte != null)
                {
                    if ((CtaCte.ImporteTotal ?? 0) != (CtaCte.Saldo ?? 0)) { sErrorMsg += "\n" + "La nota de debito ha sido cancelada parcial o totalmente y no puede anularse"; }
                }
            }
            
            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(NotasDebito NotaDebito)
        {
            try
            {
                decimal mCotizacionMoneda = 0;
                decimal mCotizacionDolar = 0;
                decimal mImporteTotal = 0;
                decimal mIvaNoDiscriminado = 0;
                decimal mIvaNoDiscriminadoItem = 0;
                decimal mImporteDetalle = 0;
                decimal mImporte = 0;

                Int32 mIdNotaDebito = 0;
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
                Int32 mIdTipoComprobante = 3;
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

                if (NotaDebito.IdNotaDebito <= 0)
                {
                    NotaDebito.IdUsuarioIngreso = IdUsuario;
                    NotaDebito.FechaIngreso = DateTime.Now;
                }

                if (!Validar(NotaDebito, ref errs, ref warnings))
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
                        mIdNotaDebito = NotaDebito.IdNotaDebito;
                        mIdCliente = NotaDebito.IdCliente ?? 0;
                        mCotizacionMoneda = NotaDebito.CotizacionMoneda ?? 1;
                        mCotizacionDolar = NotaDebito.CotizacionDolar ?? 0;
                        if (NotaDebito.Anulada == "SI") { mAnulada = true; }
                        if ((NotaDebito.AplicarEnCtaCte ?? "") == "NO") { mAplicarEnCtaCte = false; }
                        mImporteTotal = (NotaDebito.ImporteTotal ?? 0) * mCotizacionMoneda;
                        mIvaNoDiscriminado = (NotaDebito.IVANoDiscriminado ?? 0) * mCotizacionMoneda;
                        
                        if (mIdNotaDebito > 0)
                        {
                            var EntidadOriginal = db.NotasDebitoes.Where(p => p.IdNotaDebito == mIdNotaDebito).SingleOrDefault();

                            var EntidadoEntry = db.Entry(EntidadOriginal);
                            EntidadoEntry.CurrentValues.SetValues(NotaDebito);

                            ////////////////////////////////////////////// ANULACION //////////////////////////////////////////////
                            if (mAnulada)
                            {
                                CuentasCorrientesDeudor CtaCte = db.CuentasCorrientesDeudores.Where(c => c.IdTipoComp == mIdTipoComprobante && c.IdComprobante == mIdNotaDebito).SingleOrDefault();
                                if (CtaCte != null)
                                {
                                    if ((CtaCte.ImporteTotal ?? 0) == (CtaCte.Saldo ?? 0))
                                    {
                                        CtaCte.ImporteTotal = 0;
                                        CtaCte.Saldo = 0;
                                        CtaCte.ImporteTotalDolar = 0;
                                        CtaCte.SaldoDolar = 0;
                                        db.Entry(CtaCte).State = System.Data.Entity.EntityState.Modified;
                                    }
                                }

                                foreach (var d in EntidadOriginal.DetalleNotasDebitoes.Where(c => c.IdDetalleNotaDebito != 0).ToList())
                                {
                                    var Valores = db.Valores.Where(c => c.IdDetalleNotaDebito == d.IdDetalleNotaDebito).ToList();
                                    if (Valores != null)
                                    {
                                        foreach (Valore v in Valores)
                                        {
                                            db.Entry(v).State = System.Data.Entity.EntityState.Deleted;
                                        }
                                    }
                                }
                            }

                            ////////////////////////////////////////////// CONCEPTOS //////////////////////////////////////////////
                            //foreach (var d in NotaDebito.DetalleNotasDebitoes)
                            //{
                            //    var DetalleEntidadOriginal = EntidadOriginal.DetalleNotasDebitoes.Where(c => c.IdDetalleNotaDebito == d.IdDetalleNotaDebito && d.IdDetalleNotaDebito > 0).SingleOrDefault();
                            //    if (DetalleEntidadOriginal != null)
                            //    {
                            //        var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                            //        DetalleEntidadEntry.CurrentValues.SetValues(d);
                            //    }
                            //    else
                            //    {
                            //        EntidadOriginal.DetalleNotasDebitoes.Add(d);
                            //    }
                            //}
                            //foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleNotasDebitoes.Where(c => c.IdDetalleNotaDebito != 0).ToList())
                            //{
                            //    if (!NotaDebito.DetalleNotasDebitoes.Any(c => c.IdDetalleNotaDebito == DetalleEntidadOriginal.IdDetalleNotaDebito))
                            //    {
                            //        EntidadOriginal.DetalleNotasDebitoes.Remove(DetalleEntidadOriginal);
                            //        db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                            //    }
                            //}

                            ////////////////////////////////////////////// PROVINCIAS //////////////////////////////////////////////
                            //foreach (var d in NotaDebito.DetalleNotasDebitoProvincias)
                            //{
                            //    var DetalleEntidadOriginal = EntidadOriginal.DetalleNotasDebitoProvincias.Where(c => c.IdDetalleNotaDebitoProvincias == d.IdDetalleNotaDebitoProvincias && d.IdDetalleNotaDebitoProvincias > 0).SingleOrDefault();
                            //    if (DetalleEntidadOriginal != null)
                            //    {
                            //        var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                            //        DetalleEntidadEntry.CurrentValues.SetValues(d);
                            //    }
                            //    else
                            //    {
                            //        EntidadOriginal.DetalleNotasDebitoProvincias.Add(d);
                            //    }
                            //}
                            //foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleNotasDebitoProvincias.Where(c => c.IdDetalleNotaDebitoProvincias != 0).ToList())
                            //{
                            //    if (!NotaDebito.DetalleNotasDebitoProvincias.Any(c => c.IdDetalleNotaDebitoProvincias == DetalleEntidadOriginal.IdDetalleNotaDebitoProvincias))
                            //    {
                            //        EntidadOriginal.DetalleNotasDebitoProvincias.Remove(DetalleEntidadOriginal);
                            //        db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                            //    }
                            //}

                            ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
                            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        else
                        {
                            if ((NotaDebito.CtaCte ?? "") == "SI")
                            {
                                ProntoMVC.Data.Models.PuntosVenta PuntoVenta = db.PuntosVentas.Where(c => c.IdPuntoVenta == NotaDebito.IdPuntoVenta).SingleOrDefault();
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
                                mNumero = parametros2.ProximaNotaDebitoInterna ?? 1;
                                parametros2.ProximaNotaDebitoInterna = mNumero + 1;
                                db.Entry(parametros2).State = System.Data.Entity.EntityState.Modified;
                            }
                            NotaDebito.NumeroNotaDebito = mNumero;


                            // HACER REGISTRO ELECTRONICO

                            db.NotasDebitoes.Add(NotaDebito);
                            db.SaveChanges();
                        }

                        ////////////////////////////////////////////// IMPUTACION //////////////////////////////////////////////
                        if (mIdNotaDebito <= 0 && !mAnulada && mAplicarEnCtaCte)
                        {
                            CuentasCorrientesDeudor CtaCte = new CuentasCorrientesDeudor();
                            CtaCte.IdCliente = NotaDebito.IdCliente;
                            CtaCte.NumeroComprobante = NotaDebito.NumeroNotaDebito;
                            CtaCte.Fecha = NotaDebito.FechaNotaDebito;
                            CtaCte.FechaVencimiento = NotaDebito.FechaNotaDebito;
                            CtaCte.Cotizacion = NotaDebito.CotizacionDolar;
                            CtaCte.CotizacionMoneda = NotaDebito.CotizacionMoneda;
                            CtaCte.IdComprobante = NotaDebito.IdNotaDebito;
                            CtaCte.IdTipoComp = mIdTipoComprobante;
                            CtaCte.ImporteTotal = mImporteTotal;
                            CtaCte.Saldo = mImporteTotal;
                            if (mCotizacionDolar > 0)
                            {
                                CtaCte.ImporteTotalDolar = mImporteTotal * mCotizacionMoneda / mCotizacionDolar;
                                CtaCte.SaldoDolar = mImporteTotal * mCotizacionMoneda / mCotizacionDolar;
                            }
                            CtaCte.IdMoneda = NotaDebito.IdMoneda;
                            CtaCte.IdCtaCte = 0;

                            db.CuentasCorrientesDeudores.Add(CtaCte);
                            db.SaveChanges();
                            mIdCtaCte = CtaCte.IdCtaCte;

                            CtaCte = db.CuentasCorrientesDeudores.Where(c => c.IdCtaCte == mIdCtaCte).SingleOrDefault();
                            if (CtaCte != null)
                            {
                                CtaCte.IdImputacion = mIdCtaCte;
                                db.Entry(CtaCte).State = System.Data.Entity.EntityState.Modified;
                                db.SaveChanges();
                            }
                        }

                        ////////////////////////////////////////////// VALORES //////////////////////////////////////////////
                        if (mIdNotaDebito <= 0 && !mAnulada)
                        {
                            foreach (var d in NotaDebito.DetalleNotasDebitoes)
                            {
                                mBorrarEnValores = true;
                                Valore v;

                                mIdValor = -1;
                                Valore valor = db.Valores.Where(c => c.IdDetalleNotaDebito == d.IdDetalleNotaDebito).SingleOrDefault();
                                if (valor != null) { mIdValor = valor.IdValor; }

                                if ((d.IdCaja ?? 0) > 0)
                                {
                                    if (mIdValor <= 0) { v = new Valore(); } else { v = db.Valores.Where(c => c.IdValor == mIdValor).SingleOrDefault(); }

                                    v.IdCaja = d.IdCaja;
                                    v.IdTipoValor = 3;
                                    v.Importe = d.Importe;
                                    v.NumeroComprobante = NotaDebito.NumeroNotaDebito;
                                    v.NumeroValor = 0;
                                    v.NumeroInterno = 0;
                                    v.FechaValor = NotaDebito.FechaNotaDebito;
                                    v.FechaComprobante = NotaDebito.FechaNotaDebito;
                                    if ((NotaDebito.IdCliente ?? 0) > 0) { v.IdCliente = NotaDebito.IdCliente; }
                                    v.IdTipoComprobante = mIdTipoComprobante;
                                    v.IdDetalleNotaDebito = d.IdDetalleNotaDebito;
                                    v.IdMoneda = NotaDebito.IdMoneda;
                                    v.CotizacionMoneda = NotaDebito.CotizacionMoneda;
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
                                        v.IdTipoValor = 3;
                                        v.Importe = d.Importe;
                                        v.NumeroComprobante = NotaDebito.NumeroNotaDebito;
                                        v.NumeroValor = 0;
                                        v.NumeroInterno = 0;
                                        v.FechaValor = NotaDebito.FechaNotaDebito;
                                        v.FechaComprobante = NotaDebito.FechaNotaDebito;
                                        if ((NotaDebito.IdCliente ?? 0) > 0) { v.IdCliente = NotaDebito.IdCliente; }
                                        v.IdTipoComprobante = mIdTipoComprobante;
                                        v.IdDetalleNotaDebito = d.IdDetalleNotaDebito;
                                        v.IdMoneda = NotaDebito.IdMoneda;
                                        v.CotizacionMoneda = NotaDebito.CotizacionMoneda;
                                        v.IdValor = mIdValor;
                                        if (mIdValor <= 0) { db.Valores.Add(v); } else { db.Entry(v).State = System.Data.Entity.EntityState.Modified; }
                                        mBorrarEnValores = false;
                                    }
                                }
                                if (mBorrarEnValores) {
                                    var Valores = db.Valores.Where(c => c.IdDetalleNotaDebito == d.IdDetalleNotaDebito).ToList();
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
                        if (mAnulada)
                        {
                            var Subdiarios = db.Subdiarios.Where(c => c.IdTipoComprobante == mIdTipoComprobante && c.IdComprobante == mIdNotaDebito).ToList();
                            if (Subdiarios != null) { foreach (Subdiario s in Subdiarios) { db.Entry(s).State = System.Data.Entity.EntityState.Deleted; } }
                            db.SaveChanges();
                        }

                        if (mIdNotaDebito <= 0 && !mAnulada)
                        {
                           Data.Models.Subdiario s;

                            Cliente Cliente = db.Clientes.Where(c => c.IdCliente == mIdCliente).SingleOrDefault();
                            mIdCuenta = 0;
                            if (Cliente != null) { mIdCuenta = Cliente.IdCuenta ?? 0; }

                            if (mIdCuenta > 0) {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuenta;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = NotaDebito.NumeroNotaDebito;
                                s.FechaComprobante = NotaDebito.FechaNotaDebito;
                                s.IdComprobante = NotaDebito.IdNotaDebito;
                                s.Debe = mImporteTotal;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }
                            
                            mImporte = NotaDebito.ImporteIva1 ?? 0;
                            if (mImporte != 0 && mIdCuentaIvaInscripto > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaIvaInscripto;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = NotaDebito.NumeroNotaDebito;
                                s.FechaComprobante = NotaDebito.FechaNotaDebito;
                                s.IdComprobante = NotaDebito.IdNotaDebito;
                                s.Haber = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = NotaDebito.IVANoDiscriminado ?? 0;
                            if (mImporte != 0 && mIdCuentaIvaInscripto > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaIvaInscripto;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = NotaDebito.NumeroNotaDebito;
                                s.FechaComprobante = NotaDebito.FechaNotaDebito;
                                s.IdComprobante = NotaDebito.IdNotaDebito;
                                s.Haber = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = NotaDebito.RetencionIBrutos1 ?? 0;
                            if (mImporte != 0)
                            {
                                mIdCuenta = 0;
                                var IBCondicion = db.IBCondiciones.Where(c => c.IdIBCondicion == NotaDebito.IdIBCondicion).FirstOrDefault();
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
                                            if ((NotaDebito.ConvenioMultilateral ?? "") == "SI" && (Provincia.IdCuentaPercepcionIIBBConvenio ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIIBBConvenio ?? 0; }
                                        }
                                    }
                                }

                                if (mIdCuenta > 0)
                                {
                                    s = new Subdiario();
                                    s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                    s.IdCuenta = mIdCuenta;
                                    s.IdTipoComprobante = mIdTipoComprobante;
                                    s.NumeroComprobante = NotaDebito.NumeroNotaDebito;
                                    s.FechaComprobante = NotaDebito.FechaNotaDebito;
                                    s.IdComprobante = NotaDebito.IdNotaDebito;
                                    s.Haber = mImporte;
                                    s.IdMoneda = mIdMonedaPesos;
                                    s.CotizacionMoneda = 1;

                                    db.Subdiarios.Add(s);
                                }
                            }

                            mImporte = NotaDebito.RetencionIBrutos2 ?? 0;
                            if (mImporte != 0)
                            {
                                mIdCuenta = 0;
                                var IBCondicion = db.IBCondiciones.Where(c => c.IdIBCondicion == NotaDebito.IdIBCondicion2).FirstOrDefault();
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
                                            if ((NotaDebito.ConvenioMultilateral ?? "") == "SI" && (Provincia.IdCuentaPercepcionIIBBConvenio ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIIBBConvenio ?? 0; }
                                        }
                                    }
                                }

                                if (mIdCuenta > 0)
                                {
                                    s = new Subdiario();
                                    s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                    s.IdCuenta = mIdCuenta;
                                    s.IdTipoComprobante = mIdTipoComprobante;
                                    s.NumeroComprobante = NotaDebito.NumeroNotaDebito;
                                    s.FechaComprobante = NotaDebito.FechaNotaDebito;
                                    s.IdComprobante = NotaDebito.IdNotaDebito;
                                    s.Haber = mImporte;
                                    s.IdMoneda = mIdMonedaPesos;
                                    s.CotizacionMoneda = 1;

                                    db.Subdiarios.Add(s);
                                }
                            }

                            mImporte = NotaDebito.RetencionIBrutos3 ?? 0;
                            if (mImporte != 0)
                            {
                                mIdCuenta = 0;
                                var IBCondicion = db.IBCondiciones.Where(c => c.IdIBCondicion == NotaDebito.IdIBCondicion3).FirstOrDefault();
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
                                            if ((NotaDebito.ConvenioMultilateral ?? "") == "SI" && (Provincia.IdCuentaPercepcionIIBBConvenio ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIIBBConvenio ?? 0; }
                                        }
                                    }
                                }

                                if (mIdCuenta > 0)
                                {
                                    s = new Subdiario();
                                    s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                    s.IdCuenta = mIdCuenta;
                                    s.IdTipoComprobante = mIdTipoComprobante;
                                    s.NumeroComprobante = NotaDebito.NumeroNotaDebito;
                                    s.FechaComprobante = NotaDebito.FechaNotaDebito;
                                    s.IdComprobante = NotaDebito.IdNotaDebito;
                                    s.Haber = mImporte;
                                    s.IdMoneda = mIdMonedaPesos;
                                    s.CotizacionMoneda = 1;

                                    db.Subdiarios.Add(s);
                                }
                            }

                            mImporte = NotaDebito.OtrasPercepciones1 ?? 0;
                            if (mImporte != 0 && mIdCuentaOtrasPercepciones1 > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaOtrasPercepciones1;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = NotaDebito.NumeroNotaDebito;
                                s.FechaComprobante = NotaDebito.FechaNotaDebito;
                                s.IdComprobante = NotaDebito.IdNotaDebito;
                                s.Haber = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = NotaDebito.OtrasPercepciones2 ?? 0;
                            if (mImporte != 0 && mIdCuentaOtrasPercepciones2 > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaOtrasPercepciones2;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = NotaDebito.NumeroNotaDebito;
                                s.FechaComprobante = NotaDebito.FechaNotaDebito;
                                s.IdComprobante = NotaDebito.IdNotaDebito;
                                s.Haber = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = NotaDebito.OtrasPercepciones3 ?? 0;
                            if (mImporte != 0 && mIdCuentaOtrasPercepciones3 > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaOtrasPercepciones3;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = NotaDebito.NumeroNotaDebito;
                                s.FechaComprobante = NotaDebito.FechaNotaDebito;
                                s.IdComprobante = NotaDebito.IdNotaDebito;
                                s.Haber = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = NotaDebito.PercepcionIVA ?? 0;
                            if (mImporte != 0 && mIdCuentaPercepcionesIVA > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaPercepcionesIVA;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = NotaDebito.NumeroNotaDebito;
                                s.FechaComprobante = NotaDebito.FechaNotaDebito;
                                s.IdComprobante = NotaDebito.IdNotaDebito;
                                s.Haber = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }
                            
                            foreach (var d in NotaDebito.DetalleNotasDebitoes)
                            {
                                mImporteDetalle = d.Importe ?? 0;
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
                                    s.NumeroComprobante = NotaDebito.NumeroNotaDebito;
                                    s.FechaComprobante = NotaDebito.FechaNotaDebito;
                                    s.IdComprobante = NotaDebito.IdNotaDebito;
                                    s.Haber = mImporteDetalle - mIvaNoDiscriminadoItem;
                                    s.IdMoneda = mIdMonedaPesos;
                                    s.CotizacionMoneda = 1;

                                    db.Subdiarios.Add(s);
                                }
                            }
                            db.SaveChanges();
                        }

                        db.Tree_TX_Actualizar(Tree_TX_ActualizarParam.NotasDebitoAgrupadas.ToString(), NotaDebito.IdNotaDebito, "NotaDebito");

                        scope.Complete();
                        scope.Dispose();
                    }

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdNotaDebito = NotaDebito.IdNotaDebito, ex = "" });
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
