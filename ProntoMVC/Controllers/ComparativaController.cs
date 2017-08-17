using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Text;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects; // using System.Data.Entity.Core.Objects;
using System.Reflection;
using System.Configuration;
using Pronto.ERP.Bll;

// using ProntoMVC.Controllers.Logica;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
//using DocumentFormat.OpenXml.Wordprocessing;
//using OpenXmlPowerTools;
using System.Diagnostics;
using ClosedXML.Excel;

using oxNameSpace;
//using oxNameSpace.ox;

using System.Web.Security;

namespace ProntoMVC.Controllers
{


    //[Authorize(Roles = "Administrador,SuperAdmin,Comparativas,Compras,Firmas")] //ojo que el web.config tambien te puede bochar hacia el login

    public partial class ComparativaController : ProntoBaseController
    {

        //
        // GET: /Comparativa/

        public virtual ViewResult Edit(int id)
        {
            if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
                   !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
                   !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
                   ) throw new Exception("No tenés permisos");

            if (id == -1)
            {
                Comparativa Comparativa = new Comparativa();

                inic(ref Comparativa);

                CargarViewBag(Comparativa);


                return View(Comparativa);
            }
            else
            {

                Comparativa Comparativa = db.Comparativas.Find(id);
                CargarViewBag(Comparativa);
                Session.Add("Comparativa", Comparativa);
                return View(Comparativa);
            }


        }




        void inic(ref Comparativa o)
        {


            Parametros parametros = db.Parametros.Find(1);
            o.Numero = parametros.ProximaComparativa;
            //o.SubNumero = 1;
            o.Fecha = DateTime.Today;
            //o.IdMoneda = 1;
            //o.CotizacionMoneda = 1;
            ViewBag.Proveedor = "";

            //o.PorcentajeIva1 = 21;                  //  mvarP_IVA1_Tomado
            //o.FechaFactura = DateTime.Now;


            string usuario = ViewBag.NombreUsuario;
            var IdUsuario = db.Empleados.Where(x => x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
            o.IdConfecciono = IdUsuario;
            //var IdSector = (from item in db.Empleados where item.IdEmpleado == IdUsuario select item).SingleOrDefault().IdSector;
            //ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra");


            //ViewBag.IdObra = new SelectList(db.Obras.Where(x => x.Activa != "NO").OrderBy(x => x.NumeroObra)
            //            .Select(y => new { y.IdObra, NumeroObra = y.NumeroObra + " - " + (y.Descripcion ?? "") }), "IdObra", "NumeroObra", o.IdObra);

            //Parametros parametros = db.Parametros.Find(1);
            //o.OtrasPercepciones1 = 0;
            //o.OtrasPercepciones1Desc = ((parametros.OtrasPercepciones1 ?? "NO") == "SI") ? parametros.OtrasPercepciones1Desc : "";
            //o.OtrasPercepciones2 = 0;
            //o.OtrasPercepciones2Desc = ((parametros.OtrasPercepciones2 ?? "NO") == "SI") ? parametros.OtrasPercepciones2Desc : "";
            //o.OtrasPercepciones3 = 0;
            //o.OtrasPercepciones3Desc = ((parametros.OtrasPercepciones3 ?? "NO") == "SI") ? parametros.OtrasPercepciones3Desc : "";

            //o.IdMoneda = 1;

            //mvarP_IVA1 = .Fields("Iva1").Value
            //mvarP_IVA2 = .Fields("Iva2").Value
            //mvarPorc_IBrutos_Cap = .Fields("Porc_IBrutos_Cap").Value
            //mvarTope_IBrutos_Cap = .Fields("Tope_IBrutos_Cap").Value
            //mvarPorc_IBrutos_BsAs = .Fields("Porc_IBrutos_BsAs").Value
            //mvarTope_IBrutos_BsAs = .Fields("Tope_IBrutos_BsAs").Value
            //mvarPorc_IBrutos_BsAsM = .Fields("Porc_IBrutos_BsAsM").Value
            //mvarTope_IBrutos_BsAsM = .Fields("Tope_IBrutos_BsAsM").Value
            //mvarDecimales = .Fields("Decimales").Value
            //mvarAclaracionAlPie = .Fields("AclaracionAlPieDeFactura").Value
            //mvarIdMonedaPesos = .Fields("IdMoneda").Value
            //mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
            //mvarPercepcionIIBB = IIf(IsNull(.Fields("PercepcionIIBB").Value), "NO", .Fields("PercepcionIIBB").Value)
            //mvarOtrasPercepciones1 = IIf(IsNull(.Fields("OtrasPercepciones1").Value), "NO", .Fields("OtrasPercepciones1").Value)
            //mvarOtrasPercepciones1Desc = IIf(IsNull(.Fields("OtrasPercepciones1Desc").Value), "", .Fields("OtrasPercepciones1Desc").Value)
            //mvarOtrasPercepciones2 = IIf(IsNull(.Fields("OtrasPercepciones2").Value), "NO", .Fields("OtrasPercepciones2").Value)
            //mvarOtrasPercepciones2Desc = IIf(IsNull(.Fields("OtrasPercepciones2Desc").Value), "", .Fields("OtrasPercepciones2Desc").Value)
            //mvarOtrasPercepciones3 = IIf(IsNull(.Fields("OtrasPercepciones3").Value), "NO", .Fields("OtrasPercepciones3").Value)
            //mvarOtrasPercepciones3Desc = IIf(IsNull(.Fields("OtrasPercepciones3Desc").Value), "", .Fields("OtrasPercepciones3Desc").Value)
            //mvarConfirmarClausulaDolar = IIf(IsNull(.Fields("ConfirmarClausulaDolar").Value), "NO", .Fields("ConfirmarClausulaDolar").Value)
            //mvarNumeracionUnica = False
            //If .Fields("NumeracionUnica").Value = "SI" Then mvarNumeracionUnica = True
            //gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)


            // db.Cotizaciones_TX_PorFechaMoneda(fecha,IdMoneda)
            // var mvarCotizacion = db.Cotizaciones.OrderByDescending(x => x.IdCotizacion).FirstOrDefault().Cotizacion; //  mo  Cotizacion(Date, glbIdMonedaDolar);
            //o.CotizacionMoneda = 1;
            //  o.CotizacionADolarFijo=
            //o.CotizacionDolar = (decimal)mvarCotizacion;

            //o.DetalleFacturas.Add(new DetalleFactura());
            //o.DetalleFacturas.Add(new DetalleFactura());
            //o.DetalleFacturas.Add(new DetalleFactura());

        }


        void CargarViewBag(Comparativa o)
        {

            ViewBag.IdConfecciono = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdConfecciono);
            ViewBag.IdAprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdAprobo);
            ViewBag.CantidadAutorizaciones = db.Autorizaciones_TX_CantidadAutorizaciones((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.Comparativa, 0, -1).Count();


            //ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionCompra);
            //ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            //ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion", o.PlazoEntrega);
            //ViewBag.Proveedor = (db.Proveedores.Find(o.IdProveedor) ?? new Proveedor()).RazonSocial;

            //ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", (o.Proveedor ?? new Proveedor()).IdCodigoIva);

            //ViewBag.TotalBonificacionGlobal = o.Bonificacion;

            //ViewBag.PuntoVenta = new SelectList((from i in db.PuntosVentas
            //                                     where i.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Factura
            //                                     select new { PuntoVenta = i.PuntoVenta })
            //    // http://stackoverflow.com/questions/2135666/databinding-system-string-does-not-contain-a-property-with-the-name-dbmake
            //                                     .Distinct(), "PuntoVenta", "PuntoVenta"); //traer solo el Numero de PuntoVenta, no el Id

            //Parametros parametros = db.Parametros.Find(1);
            //ViewBag.PercepcionIIBB = parametros.PercepcionIIBB;

        }


        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Comparativas)) throw new Exception("No tenés permisos");

            //if (db == null)
            //{
            //    FormsAuthentication.SignOut();
            //    return View("ElegirBase", "Home");
            //}

            //var Comparativas = db.Comparativas
            //    .Where(r => r.NumeroComparativa > 0)
            //    .OrderByDescending(r => r.IdComparativa); // .NumeroComparativa);


            //string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            //DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster, "SELECT * FROM BASES");
            //List<SelectListItem> baselistado = new List<SelectListItem>();
            //foreach (DataRow r in dt.Rows)
            //{
            //    baselistado.Add(new SelectListItem { Text = r["Descripcion"] as string, Value = "" });
            //}


            //ViewBag.Bases = baselistado; // baselistado; // new SelectList(dt.Rows, "IdBD", "Descripcion"); // StringConnection



            //return View(Comparativas.ToList());
            return View();
        }



        public virtual ActionResult Comparativas_DynamicGridData
            (string sidx, string sord, int page, int rows, bool _search, string filters,
            string FechaInicial, string FechaFinal, string IdObra)
        {



            string campo = "true"; // String.Empty;
            int pageSize = rows; // ?? 20;
            int currentPage = page; //  ?? 1;

            var Fac = db.Comparativas.AsQueryable();
            if (IdObra != string.Empty)
            {
                int IdObra1 = Convert.ToInt32(IdObra);
                Fac = (from a in Fac select a).AsQueryable();
            }

            try
            {
                if (FechaInicial != string.Empty)
                {
                    DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                    DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                    Fac = (from a in Fac where a.Fecha >= FechaDesde && a.Fecha <= FechaHasta select a).AsQueryable();
                }

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }


            //if (_search ?? false)
            //{
            //    switch (searchField.ToLower())
            //    {
            //        case "numerocomparativa":
            //            if (searchString != "")
            //            {
            //                campo = String.Format("{0} = {1}", searchField, Generales.Val(searchString));
            //            }
            //            else
            //            {
            //                campo = "true";
            //            }
            //            break;
            //        case "fechacomparativa":
            //            //No anda
            //            campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
            //            break;
            //        default:
            //            if (searchOper == "eq")
            //            {
            //                campo = String.Format("{0} = {1}", searchField, searchString);
            //            }
            //            else
            //            {
            //                campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
            //            }
            //            break;
            //    }
            //}
            //else
            //{
            //    campo = "true";
            //}




            var Req = Fac.Where(campo);




            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;


            // IQueryable<Data.Models.Remito> aaaa = db.Remitos.Take(19);


            // ObjectQuery<Data.Models.Requerimiento> set = Req as ObjectQuery<Data.Models.Requerimiento>;


            var pagedQuery = Filters.FiltroGenerico_UsandoStoreOLista(
                    sidx, sord, page, rows, _search, filters, db, ref totalRecords, Req.ToList());


            //var pagedQuery = Filters.FiltroGenerico_PasandoQueryEntera<Data.Models.Comparativa>
            //                    (Req as ObjectQuery<Data.Models.Comparativa>
            //                    , sidx, sord, page, rows, _search, filters, ref totalRecords);

            // .Where(x => (PendienteFactura != "SI" || (PendienteFactura == "SI" && x.PendienteFacturar > 0)))


            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



            //int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            //switch (sidx.ToLower())
            //{
            //    case "numeroComparativa":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroComparativa);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroComparativa);
            //        break;
            //    case "fechaComparativa":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.FechaComparativa);
            //        else
            //            Fac = Fac.OrderBy(a => a.FechaComparativa);
            //        break;
            //    case "numeroobra":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Obra.NumeroObra);
            //        else
            //            Fac = Fac.OrderBy(a => a.Obra.NumeroObra);
            //        break;
            //    case "libero":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Empleados.Nombre);
            //        else
            //            Fac = Fac.OrderBy(a => a.Empleados.Nombre);
            //        break;
            //    case "aprobo":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Empleados1.Nombre);
            //        else
            //            Fac = Fac.OrderBy(a => a.Empleados1.Nombre);
            //        break;
            //    case "sector":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Sectores.Descripcion);
            //        else
            //            Fac = Fac.OrderBy(a => a.Sectores.Descripcion);
            //        break;
            //    case "detalle":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Detalle);
            //        else
            //            Fac = Fac.OrderBy(a => a.Detalle);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroComparativa);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroComparativa);
            //        break;
            //}

            var data = (from a in pagedQuery // Fac.Where(campo)
                                             //join c in db.Clientes on a.IdCliente equals c.IdCliente
                        select a)
//.OrderBy(sidx + " " + sord)
//             .OrderByDescending(x => x.Fecha).ThenByDescending(x => x.Numero)

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
                            id = a.IdComparativa.ToString(),
                            cell = new string[] {
                                "<a href="+ Url.Action("Edit",new {id = a.IdComparativa} )  +" target='_blank' >Editar</>"
                                //+
                                //"|" +
                                //"<a href=/Comparativa/Details/" + a.IdComparativa + ">Detalles</a> "
                                ,
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdComparativa} )  +">Excel</>" ,
                                
                                //"<a href="+ Url.Action("Firmar",new {id = a.IdComparativa} )  +">Firmar</>", // con action
                                "<a  id='firmalink' value='"+ a.IdComparativa +"' href='#' >Firmar</>",                                // con jscript
                                // puede firmarlo? -si no está el circuito completo
                                a.CircuitoFirmasCompleto ?? "NO",
                               //  ( a.Cliente ?? new Cliente()).Cuit.NullSafeToString() 

                                a.IdComparativa.NullSafeToString(),
                                a.Numero.NullSafeToString(),
                                a.Fecha.NullSafeToString(),
                                 (a.PresupuestoSeleccionado??0)!=-1 ? "Monopresupuesto" : "Multipresupuesto",


                                 (db.Empleados.Find(a.IdConfecciono) ?? new Empleado()).Nombre,
                                 (db.Empleados.Find(a.IdAprobo) ?? new Empleado()).Nombre,
                                  //E1.Nombre as [Confecciono],  
                                  // E2.Nombre as [Aprobo],  
                                 
                                 
                                 a.MontoPrevisto.NullSafeToString() ,
                                 a.MontoParaCompra.NullSafeToString() ,  

                                 //db.AutorizacionesPorComprobante1
                                 //.Where(x=>x.IdComprobante==a.IdComparativa && x.IdFormulario==(int)EntidadManager.EnumFormularios.Comparativa)
                                 //.Count().ToString(),


                                 //string.Join(",", db.AutorizacionesPorComprobante1
                                 //.Where(f=>(f.IdFormulario == (int)EntidadManager.EnumFormularios.Comparativa && f.IdComprobante == a.IdComparativa))
                                 // .Select(f=>f.IdAutorizo).ToArray()),

                                 ///////////
                                 //tarda mucho hacerlo así
                              db.DetalleComparativas.Where(x=>x.IdComparativa==a.IdComparativa).Select(x=>x.IdPresupuesto).Distinct().Count().ToString() , //  (Select Count(*) From #Auxiliar0 Where #Auxiliar0.IdComparativa=Cmp.IdComparativa) as [Cant.Sol.],  
                              ///db.DetalleComparativas.Where(x=>x.IdComparativa==a.IdComparativa).Select(x=>x.IdArticulo).Distinct().Count().ToString() , 
                              "",// "",
                                /////////

                                 a.ArchivoAdjunto1.NullSafeToString(),
                                 a.ArchivoAdjunto2.NullSafeToString() ,
                                 a.Anulada.NullSafeToString() ,
                                 a.FechaAnulacion.NullSafeToString() ,  
                                 //E3.Nombre as [Anulo],  
                                 a.MotivoAnulacion.NullSafeToString()   
 
                                //LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=Cmp.IdConfecciono  
                                //LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado=Cmp.IdAprobo  
                                //LEFT OUTER JOIN Empleados E3 ON E3.IdEmpleado=Cmp.IdUsuarioAnulo  
                                //ORDER BY Cmp.Fecha Desc, Cmp.Numero Desc  


                                                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }



        public virtual ActionResult Comparativas(string sidx, string sord, int? page, int? rows, bool? _search, string searchField, string searchOper, string searchString,
                                         string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.Comparativas.AsQueryable();
            if (IdObra != string.Empty)
            {
                int IdObra1 = Convert.ToInt32(IdObra);
                Fac = (from a in Fac select a).AsQueryable();
            }

            try
            {
                if (FechaInicial != string.Empty)
                {
                    DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                    DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                    Fac = (from a in Fac where a.Fecha >= FechaDesde && a.Fecha <= FechaHasta select a).AsQueryable();
                }

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }


            if (_search ?? false)
            {
                switch (searchField.ToLower())
                {
                    case "numerocomparativa":
                        if (searchString != "")
                        {
                            campo = String.Format("{0} = {1}", searchField, Generales.Val(searchString));
                        }
                        else
                        {
                            campo = "true";
                        }
                        break;
                    case "fechacomparativa":
                        //No anda
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                    default:
                        if (searchOper == "eq")
                        {
                            campo = String.Format("{0} = {1}", searchField, searchString);
                        }
                        else
                        {
                            campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        }
                        break;
                }
            }
            else
            {
                campo = "true";
            }

            var Req1 = (from a in Fac.Where(campo)
                        select new
                        {
                            IdComparativa = a.IdComparativa,
                            NumeroComparativa = a.Numero,
                            FechaComparativa = a.Fecha,
                            //NumeroObra=a.Obra.NumeroObra,
                            //Libero=a.Empleados.Nombre,
                            //Aprobo = a.Empleados1.Nombre,
                            //Sector=a.Sectores.Descripcion,
                            //Detalle=a.Detalle
                        }).ToList();

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            //switch (sidx.ToLower())
            //{
            //    case "numeroComparativa":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroComparativa);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroComparativa);
            //        break;
            //    case "fechaComparativa":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.FechaComparativa);
            //        else
            //            Fac = Fac.OrderBy(a => a.FechaComparativa);
            //        break;
            //    case "numeroobra":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Obra.NumeroObra);
            //        else
            //            Fac = Fac.OrderBy(a => a.Obra.NumeroObra);
            //        break;
            //    case "libero":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Empleados.Nombre);
            //        else
            //            Fac = Fac.OrderBy(a => a.Empleados.Nombre);
            //        break;
            //    case "aprobo":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Empleados1.Nombre);
            //        else
            //            Fac = Fac.OrderBy(a => a.Empleados1.Nombre);
            //        break;
            //    case "sector":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Sectores.Descripcion);
            //        else
            //            Fac = Fac.OrderBy(a => a.Sectores.Descripcion);
            //        break;
            //    case "detalle":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Detalle);
            //        else
            //            Fac = Fac.OrderBy(a => a.Detalle);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroComparativa);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroComparativa);
            //        break;
            //}

            var data = (from a in Fac.Where(campo)
                            //join c in db.Clientes on a.IdCliente equals c.IdCliente
                        select a)
                        //.OrderBy(sidx + " " + sord)
                        .OrderByDescending(x => x.Fecha).ThenByDescending(x => x.Numero)

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
                            id = a.IdComparativa.ToString(),
                            cell = new string[] {
                                "<a href="+ Url.Action("Edit",new {id = a.IdComparativa} )  +" target='_blank' >Editar</>"
                                //+
                                //"|" +
                                //"<a href=/Comparativa/Details/" + a.IdComparativa + ">Detalles</a> "
                                ,
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdComparativa} )  +">Excel</>" ,
                                
                                //"<a href="+ Url.Action("Firmar",new {id = a.IdComparativa} )  +">Firmar</>", // con action
                                "<a  id='firmalink' value='"+ a.IdComparativa +"' href='#' >Firmar</>",                                // con jscript
                                // puede firmarlo? -si no está el circuito completo
                                a.CircuitoFirmasCompleto ?? "NO",
                               //  ( a.Cliente ?? new Cliente()).Cuit.NullSafeToString() 

                                a.IdComparativa.NullSafeToString(),
                                a.Numero.NullSafeToString(),
                                a.Fecha.NullSafeToString(),
                                 (a.PresupuestoSeleccionado??0)!=-1 ? "Monopresupuesto" : "Multipresupuesto",


                                 (db.Empleados.Find(a.IdConfecciono) ?? new Empleado()).Nombre,
                                 (db.Empleados.Find(a.IdAprobo) ?? new Empleado()).Nombre,
                                  //E1.Nombre as [Confecciono],  
                                  // E2.Nombre as [Aprobo],  
                                 
                                 
                                 a.MontoPrevisto.NullSafeToString() ,
                                 a.MontoParaCompra.NullSafeToString() ,  

                                 //db.AutorizacionesPorComprobante1
                                 //.Where(x=>x.IdComprobante==a.IdComparativa && x.IdFormulario==(int)EntidadManager.EnumFormularios.Comparativa)
                                 //.Count().ToString(),


                                 //string.Join(",", db.AutorizacionesPorComprobante1
                                 //.Where(f=>(f.IdFormulario == (int)EntidadManager.EnumFormularios.Comparativa && f.IdComprobante == a.IdComparativa))
                                 // .Select(f=>f.IdAutorizo).ToArray()),

                                 ///////////
                                 //tarda mucho hacerlo así
                              db.DetalleComparativas.Where(x=>x.IdComparativa==a.IdComparativa).Select(x=>x.IdPresupuesto).Distinct().Count().ToString() , //  (Select Count(*) From #Auxiliar0 Where #Auxiliar0.IdComparativa=Cmp.IdComparativa) as [Cant.Sol.],  
                              ///db.DetalleComparativas.Where(x=>x.IdComparativa==a.IdComparativa).Select(x=>x.IdArticulo).Distinct().Count().ToString() , 
                              "",// "",
                                /////////

                                 a.ArchivoAdjunto1.NullSafeToString(),
                                 a.ArchivoAdjunto2.NullSafeToString() ,
                                 a.Anulada.NullSafeToString() ,
                                 a.FechaAnulacion.NullSafeToString() ,  
                                 //E3.Nombre as [Anulo],  
                                 a.MotivoAnulacion.NullSafeToString()   
 
                                //LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=Cmp.IdConfecciono  
                                //LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado=Cmp.IdAprobo  
                                //LEFT OUTER JOIN Empleados E3 ON E3.IdEmpleado=Cmp.IdUsuarioAnulo  
                                //ORDER BY Cmp.Fecha Desc, Cmp.Numero Desc  


                                                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        void UpdateColeccion(Comparativa Comparativa)
        {
            var EntidadOriginal = db.Comparativas.Where(p => p.IdComparativa == Comparativa.IdComparativa).Include(p => p.DetalleComparativas).SingleOrDefault();


            EntidadOriginal.DetalleComparativas.Clear();
            foreach (var dr in Comparativa.DetalleComparativas)
            {
                dr.IdComparativa = Comparativa.IdComparativa;
            }


            var EntidadEntry = db.Entry(EntidadOriginal);
            EntidadEntry.CurrentValues.SetValues(Comparativa);


            foreach (var dr in Comparativa.DetalleComparativas)
            {

                var DetalleEntidadOriginal = EntidadOriginal.DetalleComparativas.Where(c => c.IdDetalleComparativa == dr.IdDetalleComparativa && dr.IdDetalleComparativa > 0).SingleOrDefault();
                if (DetalleEntidadOriginal != null)
                {
                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                    DetalleEntidadEntry.CurrentValues.SetValues(dr);
                }
                else
                {
                    EntidadOriginal.DetalleComparativas.Add(dr);
                }
            }


            // la grilla esta perdiendo los IdDetalleComparativa originales. no usar esta parte 
            if (false)
            {
                foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleComparativas.Where(c => c.IdDetalleComparativa != 0).ToList())
                {
                    if (!Comparativa.DetalleComparativas.Any(c => c.IdDetalleComparativa == DetalleEntidadOriginal.IdDetalleComparativa))
                        EntidadOriginal.DetalleComparativas.Remove(DetalleEntidadOriginal);
                }
            }

            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
        }



        private bool Validar(ProntoMVC.Data.Models.Comparativa o, ref string sErrorMsg, ref string sWarningMsg)
        {
            // una opcion es extender el modelo autogenerado, para ensoquetar ahí las validaciones
            // si no, podemos usar una funcion como esta, y devolver los  errores de dos maneras:
            // con ModelState.AddModelError si los devolvemos en una ViewResult,
            // o con un array de strings si es una JsonResult.
            //
            // if you are returning JSON, you cannot use ModelState.
            // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json



            //res.Errors = GetModelStateErrorsAsString(this.ModelState);




            //List<int?> duplicates = o.DetalleComparativas.Where(s => (s.IdDetalleRequerimiento ?? 0) > 0).GroupBy(s => s.IdDetalleRequerimiento)
            //             .Where(g => g.Count() > 1)
            //             .Select(g => g.Key)
            //             .ToList();


            //if (duplicates.Count > 0)
            //{
            //    // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");

            //    foreach (int? i in duplicates)
            //    {
            //        List<DetalleComparativa> q = o.DetalleComparativas.Where(x => x.IdDetalleRequerimiento == i).Select(x => x).Skip(1).ToList();
            //        foreach (DetalleComparativa x in q)
            //        {

            //            // tacharlo de la grilla, no eliminarlo de pantalla
            //            // tacharlo de la grilla, no eliminarlo de pantalla
            //            string nombre = x.NumeroItem + " El item " + x.NumeroItem + "  (" + db.Articulos.Find(x.IdArticulo).Descripcion + ") ";
            //            sErrorMsg += "\n" + nombre + " usa un item de requerimiento que ya se está usando ";  // tacharlo de la grilla, no eliminarlo de pantalla
            //            // tacharlo de la grilla, no eliminarlo de pantalla
            //            // tacharlo de la grilla, no eliminarlo de pantalla

            //        }


            //    }

            //    // verificar tambien si el  item ya se usa enum otro peddido
            //    //sss

            //    // return false;
            //}

            if (!PuedeEditar(enumNodos.Comparativas)) sErrorMsg += "\n" + "No tiene permisos de edición";


            if (o.IdComparativa <= 0)
            {
                //  string connectionString = Generales.sCadenaConexSQL(this.Session["BasePronto"].ToString());
                //  o.NumeroFactura = (int)Pronto.ERP.Bll.FacturaManager.ProximoNumeroFacturaPorIdCodigoIvaYNumeroDePuntoVenta(connectionString,o.IdCodigoIva ?? 0,o.PuntoVenta ?? 0);
            }

            //if (o.IdCodigoIva == null) sErrorMsg +="\n"+ "\n" + "Falta el codigo de IVA";
            //if (o.IdCondicionVenta == null) sErrorMsg +="\n"+ "\n" + "Falta la condicion venta";
            //if (o.IdListaPrecios == null) sErrorMsg +="\n"+ "\n" + "Falta la lista de precios";
            if (o.DetalleComparativas.Count <= 0) sErrorMsg += "\n" + "La comparativa no tiene items";

            //string OrigenDescripcionDefault = BuscaINI("OrigenDescripcion en 3 cuando hay observaciones");


            //         Dim mvarImprime As Integer, mvarNumero As Integer, i As Integer
            //         Dim mvarErr As String, mvarControlFechaNecesidad As String, mAuxS5 As String, mAuxS6 As String
            //         Dim PorObra As Boolean, mTrasabilidad_RM_LA As Boolean, mConAdjuntos As Boolean

            bool mExigirTrasabilidad_RMLA_PE = false, PorObra, mTrasabilidad_RM_LA = false;
            string mvarControlFechaNecesidad = "";
            string mAuxS5 = "";
            int mIdObra = 0;
            int mIdTipoCuenta = 0;





            var mvarMontoMinimo = BuscarClaveINI("Monto minimo para registrar Comparativa");

            //if (mvarTotalComparativa * Val(txtCotizacionMoneda.Text) < Val(mvarMontoMinimo)) {
            //    sErrorMsg +="\n"+ "El importe total dla comparativa debe ser mayor a " & Format(Val(mvarMontoMinimo), "#,##0.00");
            //    return;
            //   }

            mvarControlFechaNecesidad = BuscarClaveINI("Quitar control fecha necesidad en Comparativas");
            mAuxS5 = BuscarClaveINI("Deshabilitar control de cuentas de obras");

            foreach (ProntoMVC.Data.Models.DetalleComparativa x in o.DetalleComparativas)
            {


                //x.Adjunto = x.Adjunto ?? "NO";
                //if (x.FechaEntrega < o.FechaRequerimiento) sErrorMsg +="\n"+ "\n" + "La fecha de entrega de " + db.Articulos.Find(x.IdArticulo).Descripcion + " es anterior a la del requerimiento";

                //    string nombre = "";
                //    try
                //    {

                //        nombre = x.NumeroItem + " El item " + x.NumeroItem + "  (" + db.Articulos.Find(x.IdArticulo).Descripcion + ") ";

                //    }
                //    catch (Exception ex)
                //    {
                //        ErrHandler.WriteError(ex);
                //        nombre = x.NumeroItem + " El item " + x.NumeroItem;
                //        sErrorMsg += "\n " + nombre + " no tiene un artículo válido";

                //    }

                //    if ((x.Cantidad ?? 0) <= 0) sErrorMsg += "\n" + nombre + " no tiene una cantidad válida";

                //    //if (OrigenDescripcionDefault == "SI" && (x.Observaciones ?? "") != "") x.OrigenDescripcion = 3;
                //    if (x.ArchivoAdjunto == null && x.ArchivoAdjunto1 == null) x.Adjunto = "NO";


                //    if ((x.Precio ?? 0) <= 0 && o.IdComparativaAbierto == null)
                //    {
                //        if (o.Aprobo != null)
                //        {
                //            sErrorMsg += "\n " + nombre + " no tiene precio unitario";
                //        }
                //        else
                //        {
                //            // solo un aviso
                //            sWarningMsg += "\n " + nombre + " no tiene precio unitario. Cuando libere la comparativa deberá ingresarse.";
                //        }
                //        //break;
                //    }

                //    if (x.IdControlCalidad == null)
                //    {
                //        // sErrorMsg +="\n"+ "Hay items de Comparativa que no tienen indicado control de calidad";
                //        //break;
                //    }

                //    if (x.FechaEntrega < o.FechaComparativa)
                //    {
                //        sErrorMsg += "\n " + nombre + " tiene una fecha de entrega anterior a la dla comparativa";
                //        //break;
                //    }

                //    if (x.FechaNecesidad != null && x.FechaNecesidad < o.FechaComparativa && mvarControlFechaNecesidad != "SI")
                //    {
                //        sErrorMsg += "\n " + nombre + " tiene una fecha de necesidad anterior a la dla comparativa";
                //        //break;
                //    }

                //    if (x.IdCentroCosto == null)
                //    {
                //        PorObra = false;
                //        mTrasabilidad_RM_LA = false;

                //        if (x.IdDetalleAcopios != null || x.IdDetalleLMateriales != null)
                //        {
                //            PorObra = true;
                //        }

                //        if (x.IdDetalleRequerimiento != null)
                //        {

                //            var oRsx = Pronto.ERP.Bll.EntidadManager.TraerFiltrado(SCsql(), ProntoFuncionesGenerales.enumSPs.Requerimientos_TX_DatosObra, x.IdDetalleRequerimiento);

                //            if (oRsx.Rows.Count > 0)
                //            {
                //                if (oRsx.Rows[0]["Obra"] != null) PorObra = true;
                //                mIdObra = (int)oRsx.Rows[0]["IdObra"];
                //            }

                //        }


                //        if (mIdObra > 0 && mAuxS5 != "SI")
                //        {
                //            var oRsx = Pronto.ERP.Bll.EntidadManager.TraerFiltrado(SCsql(), ProntoFuncionesGenerales.enumSPs.Articulos_TX_DatosConCuenta, x.IdArticulo);

                //            mIdTipoCuenta = 0;
                //            //no anda, arreglar    if (oRsx.Rows.Count > 0) mIdTipoCuenta = (int)oRsx.Rows[0]["IdTipoCuentaCompras"];

                //            if (mIdTipoCuenta == 4)
                //            {
                //                var oRs = Pronto.ERP.Bll.EntidadManager.TraerFiltrado(SCsql(), ProntoFuncionesGenerales.enumSPs.Cuentas_TX_PorObraCuentaMadre, mIdObra, 0, x.IdArticulo, o.FechaComparativa);
                //                if (oRs.Rows.Count == 0)
                //                {
                //                    sErrorMsg += "\n" + nombre + " no tiene una cuenta contable para la obra-cuenta de compras";
                //                    //break;
                //                }

                //            }
                //        }

                //        if (false && !PorObra)
                //        {
                //            sErrorMsg += "\n" + nombre + " no tiene indicado centro de costo";
                //            //break;
                //        }



                //        if (mExigirTrasabilidad_RMLA_PE && x.IdDetalleAcopios == null && x.IdDetalleRequerimiento == null)
                //        {
                //            sErrorMsg += "\n" + nombre + " no tiene trazabilidad a RM o LA";
                //            //break;
                //        }

                //    }


                //}

                //if ((o.Aprobo ?? 0) > 0 && o.FechaAprobacion == null) o.FechaAprobacion = DateTime.Now;


                //if (db.Comparativas.Any(p => p.NumeroComparativa == o.NumeroComparativa && p.SubNumero == o.SubNumero && p.IdComparativa != o.IdComparativa))
                //{

                //    sErrorMsg += "\n" + "Numero/Subnumero de Comparativa ya existente";
                //}





                //         if Len(mvarErr) {
                //            if mIdAprobo = 0 {
                //               mvarErr = mvarErr & vbCrLf & "Cuando libere la comparativa estos errores deberan estar corregidos"
                //               MsgBox "Errores encontrados :" & vbCrLf & mvarErr, vbExclamation
                //            Else
                //               MsgBox "Errores encontrados :" & vbCrLf & mvarErr, vbExclamation
                //               GoTo Salida
                //            }
                //         }


                //if Not mNumeracionPorPuntoVenta {
                //            if mvarId = -1 And mNumeracionAutomatica <> "SI" And txtNumeroComparativa.Text = mNumeroComparativaOriginal {
                //               Set oPar = oAp.Parametros.Item(1)
                //               if Check2.Value = 0 {
                //                  mNum = oPar.Registrox.ProximoNumeroComparativa").Value
                //               Else
                //                  mNum = oPar.Registrox.ProximoNumeroComparativaExterior").Value
                //               }
                //               origen.Registrox.NumeroComparativa").Value = mNum
                //               mNumeroComparativaOriginal = mNum
                //               Set oPar = Nothing
                //            }

                //            Set oRs = oAp.Comparativas.TraerFiltrado("_PorNumero", Array(Val(txtNumeroComparativa.Text), Val(txtSubnumero.Text), -1, Check2.Value))
                //            if oRs.RecordCount > 0 {
                //               if mvarId < 0 Or (mvarId > 0 And oRs.Fields(0).Value <> mvarId) {
                //                  oRs.Close
                //                  Set oRs = Nothing
                //                  mvarNumero = MsgBox("Numero/Subnumero de Comparativa ya existente" & vbCrLf & "Desea actualizar el numero ?", vbYesNo, "Numero de Comparativa")
                //                  if mvarNumero = vbYes {
                //                     Set oPar = oAp.Parametros.Item(1)
                //                     if Check2.Value = 0 {
                //                        mNum = oPar.Registrox.ProximoNumeroComparativa").Value
                //                     Else
                //                        mNum = oPar.Registrox.ProximoNumeroComparativaExterior").Value
                //                     }
                //                     origen.Registrox.NumeroComparativa").Value = mNum
                //                     Set oPar = Nothing
                //                  }
                //                  GoTo Salida
                //               }
                //            }
                //            oRs.Close
                //            Set oRs = Nothing
                //         Else
                //            Set oRs = oAp.Comparativas.TraerFiltrado("_PorNumero", Array(Val(txtNumeroComparativa.Text), Val(txtSubnumero.Text), dcfields(10).BoundText))
                //            if oRs.RecordCount > 0 {
                //               if mvarId < 0 Or (mvarId > 0 And oRs.Fields(0).Value <> mvarId) {
                //                  oRs.Close
                //                  Set oRs = Nothing
                //                  MsgBox "Numero/Subnumero de Comparativa ya existente", vbExclamation
                //                  GoTo Salida
                //               }
                //            }
                //            oRs.Close
                //         }

                //         mAuxS6 = BuscarClaveINI("Exigir adjunto en Comparativas con subcontrato")

                //            if mAuxS6 = "SI" And Iif(IsNull(x.NumeroSubcontrato").Value), 0, x.NumeroSubcontrato").Value) > 0 {
                //               mConAdjuntos = False
                //               For i = 1 To 10
                //                  if Len(Iif(IsNull(x.ArchivoAdjunto" & i).Value), "", x.ArchivoAdjunto" & i).Value)) > 0 {
                //                     mConAdjuntos = True
                //                     Exit For
                //                  }
                //               Next
                //               if Not mConAdjuntos {
                //                  MsgBox "Para un Comparativa - subcontrato es necesario ingresar como adjunto las condiciones generales", vbExclamation
                //                  GoTo Salida
                //               }
                //            }

                //            if Not IsNull(x.IdComparativaAbierto").Value) {
                //               mTotalComparativaAbierto = 0
                //               mvarTotalComparativas = 0
                //               mFechaLimite = 0
                //               Set oRs1 = Aplicacion.ComparativasAbiertos.TraerFiltrado("_Control", x.IdComparativaAbierto").Value)
                //               if oRs1.RecordCount > 0 {
                //                  mTotalComparativaAbierto = Iif(IsNull(oRs1x.ImporteLimite").Value), 0, oRs1x.ImporteLimite").Value)
                //                  mvarTotalComparativas = Iif(IsNull(oRs1x.SumaComparativas").Value), 0, oRs1x.SumaComparativas").Value)
                //                  mFechaLimite = Iif(IsNull(oRs1x.FechaLimite").Value), 0, oRs1x.FechaLimite").Value)
                //               }
                //               oRs1.Close
                //               if mvarId > 0 {
                //                  Set oRs1 = Aplicacion.Comparativas.TraerFiltrado("_PorId", mvarId)
                //                  if oRs1.RecordCount > 0 {
                //                     mvarTotalComparativas = mvarTotalComparativas - Iif(IsNull(oRs1x.TotalComparativa").Value), 0, oRs1x.TotalComparativa").Value)
                //                  }
                //                  oRs1.Close
                //               }
                //               mvarTotalComparativas = mvarTotalComparativas + mvarTotalComparativa
                //               if mTotalComparativaAbierto > 0 And mTotalComparativaAbierto < mvarTotalComparativas {
                //                  MsgBox "Se supero el importe limite dla comparativa abierto : " & mTotalComparativaAbierto, vbCritical
                //                  GoTo Salida
                //               }
                //               if mFechaLimite > 0 And mFechaLimite < DTFields(0).Value {
                //                  MsgBox "Se supero la fecha limite dla comparativa abierto : " & mFechaLimite, vbCritical
                //                  GoTo Salida
                //               }
                //            }
                //            if mNumeracionPorPuntoVenta {
                //               x.PuntoVenta").Value = Val(dcfields(10).Text)
                //            Else
                //               if mvarId = -1 And mNumeracionAutomatica <> "SI" And txtNumeroComparativa.Text = mNumeroComparativaOriginal {
                //                  Set oPar = oAp.Parametros.Item(1)
                //                  if Check2.Value = 0 {
                //                     mNum = oPar.Registrox.ProximoNumeroComparativa").Value
                //                     x.NumeroComparativa").Value = mNum
                //                     oPar.Registrox.ProximoNumeroComparativa").Value = mNum + 1
                //                  Else
                //                     mNum = oPar.Registrox.ProximoNumeroComparativaExterior").Value
                //                     x.NumeroComparativa").Value = mNum
                //                     oPar.Registrox.ProximoNumeroComparativaExterior").Value = mNum + 1
                //                  }
                //                  oPar.Guardar
                //                  Set oPar = Nothing
                //               }
                //            }
                //            x.Bonificacion").Value = mvarBonificacion
                //            if IsNumeric(txtPorcentajeBonificacion.Text) { x.PorcentajeBonificacion").Value = Val(txtPorcentajeBonificacion.Text)
                //            x.TotalIva1").Value = mvarIVA1
                //            'x.TotalIva2").Value = mvarIVA2
                //            x.TotalComparativa").Value = mvarTotalComparativa
                //            x.PorcentajeIva1").Value = mvarP_IVA1
                //            x.PorcentajeIva2").Value = mvarP_IVA2
                //            x.TipoCompra").Value = Combo1(0).ListIndex + 1
                //            x.CotizacionMoneda").Value = txtCotizacionMoneda.Text
                //            x.CotizacionDolar").Value = txtCotizacionDolar.Text
                //            if Check2.Value = 1 {
                //               x.ComparativaExterior").Value = "SI"
                //            Else
                //               x.ComparativaExterior").Value = "NO"
                //            }
                //            if Not IsNull(x.NumeroSubcontrato").Value) {
                //               x.Subcontrato").Value = "SI"
                //            Else
                //               x.Subcontrato").Value = "NO"
                //            }
                //            if Check4.Value = 1 {
                //               x.Transmitir_a_SAT").Value = "SI"
                //            Else
                //               x.Transmitir_a_SAT").Value = "NO"
                //            }
                //            x.EnviarEmail").Value = 1
                //            if mvarId <= 0 { x.NumeracionAutomatica").Value = mNumeracionAutomatica
                //            x.Observaciones").Value = rchObservaciones.Text
                //            x.IdTipoCompraRM").Value = origen.IdTipoCompraRM




            }

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>"); //     ,"&#13;&#10;"); // "<br/>");
            if (sErrorMsg != "") return false;
            return true;

        }



        [HttpPost]
        public virtual JsonResult BatchUpdateConGrilla(Comparativa o, List<RenglonJQgrid> grilla = null)
        {
            if (!PuedeEditar(enumNodos.Comparativas)) throw new Exception("No tenés permisos");


            o.DetalleComparativas.Clear();
            DeGrillaHaciaObjeto(grilla, o);

            return BatchUpdate(o);
        }


        [HttpPost]
        public virtual JsonResult BatchUpdate(Comparativa Comparativa)
        {
            if (!PuedeEditar(enumNodos.Comparativas)) throw new Exception("No tenés permisos");


            if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
                )
            {

                int idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));

                //if (Comparativa.IdProveedor != idproveedor) throw new Exception("Sólo podes acceder a Comparativas tuyos");
                ////throw new Exception("No tenés permisos");

            }


            //Comparativa.mail

            try
            {
                //var mailcomp = db.Empleados.Where(e => e.IdEmpleado == Comparativa.IdComprador).Select(e => e.Email).FirstOrDefault();
                //Generales.enviarmailAlComprador(mailcomp   ,Comparativa.IdComparativa );

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }



            string errs = "";
            string warnings = "";

            if (!Validar(Comparativa, ref errs, ref warnings))
            {
                try
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;


                }
                catch (Exception)
                {

                    //    throw;
                }



                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;

                //List<string> errors = new List<string>();
                //errors.Add(errs);
                string[] words = errs.Split('\n');
                res.Errors = words.ToList(); // GetModelStateErrorsAsString(this.ModelState);
                res.Message = "La Comparativa es inválida";



                return Json(res);
            }




            try
            {
                if (ModelState.IsValid)
                {
                    string tipomovimiento = "";
                    if (Comparativa.IdComparativa > 0)
                    {

                        UpdateColeccion(Comparativa);

                        if (true)
                        {
                            //metodo 1
                            // var original = db.Comparativas.Where(p => p.IdRequerimiento == requerimiento.IdRequerimiento).Include(p => p.DetalleRequerimientos).SingleOrDefault();

                        }
                        else
                        {
                            db.Comparativas.Attach(Comparativa);
                            // var entry = db.Entry(Comparativa);
                            // entry.State = System.Data.Entity.EntityState.Modified;
                        }


                        //var entry = db.Entry(original);
                        //entry.CurrentValues.SetValues(Comparativa);
                        //db.Entry(originalrequerimiento).State = System.Data.Entity.EntityState.Modified;

                    }
                    else
                    {
                        //if (Comparativa.SubNumero == 1)
                        //{
                        tipomovimiento = "N";
                        Parametros parametros = db.Parametros.Find(1);
                        Comparativa.Numero = parametros.ProximaComparativa;
                        parametros.ProximaComparativa += 1;
                        //}
                        db.Comparativas.Add(Comparativa);
                    }
                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    try
                    {
                        //  ActivarUsuarioYContacto(Comparativa.IdComparativa);
                    }
                    catch (Exception e)
                    {
                        ErrHandler.WriteError(e); //throw;
                    }
                    db.wActualizacionesVariasPorComprobante(104, Comparativa.IdComparativa, tipomovimiento);


                    try
                    {
                        List<Tablas.Tree> Tree = TablasDAL.ArbolRegenerar(this.Session["BasePronto"].ToString(), oStaticMembershipService);

                    }
                    catch (Exception ex)
                    {
                        ErrHandler.WriteError(ex);
                        //                        throw;
                    }
                    // TODO: acá se regenera el arbol???


                    return Json(new { Success = 1, IdComparativa = Comparativa.IdComparativa, ex = "" });
                }
                else
                {

                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "la comparativa es inválido";
                    //return Json(res);
                    //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });


                    return Json(res);
                }

            }
            catch (System.Data.Entity.Validation.DbEntityValidationException ex)
            {
                //http://stackoverflow.com/questions/10219864/ef-code-first-how-do-i-see-entityvalidationerrors-property-from-the-nuget-pac
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

                //throw new System.Data.Entity.Validation.DbEntityValidationException(
                //    "Entity Validation Failed - errors follow:\n" +
                //    sb.ToString(), ex
                //); // Add the original exception as the innerException

                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;

                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);

                res.Errors.Add(sb.ToString());
                res.Errors.Add(ex.ToString());
                res.Message = "la comparativa es inválido. " + ex.ToString();
                //return Json(res);
                //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });

                return Json(res);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;

                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);
                res.Errors.Add(ex.ToString());
                res.Message = "la comparativa es inválido. " + ex.ToString();
                //return Json(res);
                //return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });

                return Json(res);

                // return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });


        }


        public class ModeloVista
        {
            public int IdComparativa { get; set; }
            public List<RenglonJQgrid> grilla { get; set; }
        }

        [HttpPost]
        public virtual ActionResult PostGrilla(ModeloVista o)
        {
            return Json("");
        }



        [HttpPost]
        public virtual ActionResult ArmarGrillaSegunPresupuestosHackeada2(Comparativa o, int IdPresupuestoAgregado = -1, List<RenglonJQgrid> grilla = null)
        {
            //int IdComparativa = 5;

            //if (o == null)
            //{
            //    var Det = db.DetalleComparativas.Where(p => p.IdComparativa == IdComparativa).Include("Articulo");
            //    o = new Comparativa();
            //    o.DetalleComparativas = Det.ToList();
            //}

            return ArmarGrillaSegunPresupuestos(o, IdPresupuestoAgregado, grilla);
        }




        public class RenglonJQgrid
        {
            public string act { get; set; }

            public int? IdDetalleComparativa { get; set; }
            public int? IdPresupuesto { get; set; }
            public int? IdDetallePresupuesto { get; set; }
            public int? IdArticulo { get; set; }
            public int? IdUnidad { get; set; }

            public string Codigo { get; set; }
            public string Descripcion { get; set; }
            public decimal? Cantidad { get; set; }
            public string DescUnidad { get; set; }


            public string PrecioA { get; set; }
            public string Total_A { get; set; }
            public string Check_A { get; set; }

            public string PrecioB { get; set; }
            public string Total_B { get; set; }
            public string Check_B { get; set; }

            public string PrecioC { get; set; }
            public string Total_C { get; set; }
            public string Check_C { get; set; }

            public string PrecioD { get; set; }
            public string Total_D { get; set; }
            public string Check_D { get; set; }

            public string PrecioE { get; set; }
            public string Total_E { get; set; }
            public string Check_E { get; set; }

            public string PrecioF { get; set; }
            public string Total_F { get; set; }
            public string Check_F { get; set; }

            public string PrecioG { get; set; }
            public string Total_G { get; set; }
            public string Check_G { get; set; }

            public string PrecioH { get; set; }
            public string Total_H { get; set; }
            public string Check_H { get; set; }

        }


        //[HttpPost]
        //public ActionResult ArmarGrillaSegunPresupuestosHackeada
        //                                (string sidx, string sord, int? page, int? rows, // bool? _search, string searchField, string searchOper, string searchString,
        //                                     int? IdComparativa,
        //                                           Comparativa o, int IdPresupuestoAgregado = -1)
        //{


        //    if (o == null)
        //    {
        //        //if (IdComparativa != null)                {
        //        var Det = db.DetalleComparativas.Where(p => p.IdComparativa == IdComparativa).Include("Articulo");
        //        o = new Comparativa();
        //        o.DetalleComparativas = Det.ToList();
        //        //}
        //    }

        //    return ArmarGrillaSegunPresupuestos(o, IdPresupuestoAgregado);
        //}



        DetalleComparativa itemObjeto(Comparativa o, RenglonJQgrid r, string total, string precio, string check, int subnumero)
        {

            DetalleComparativa it;

            /////////////////////////////////////   
            it = new DetalleComparativa();
            it.IdArticulo = r.IdArticulo;
            it.Cantidad = r.Cantidad;
            it.IdUnidad = r.IdUnidad;
            // it.IdDetalleComparativa = null;
            it.IdPresupuesto = -1;
            it.IdDetallePresupuesto = -1;



            if (total == null) return null;
            it.IdPresupuesto = int.Parse(total); // esconder en Total el IdPresupuesto


            var p = db.Presupuestos.Find(it.IdPresupuesto);
            var pdet = p.DetallePresupuestos.Where(x => x.IdArticulo == it.IdArticulo).FirstOrDefault();

            it.IdDetallePresupuesto = pdet.IdDetallePresupuesto;
            it.Precio = decimal.Parse(precio ?? "0");
            it.Estado = (check == "True") ? "MR" : "";
            it.SubNumero = subnumero; // esto hay que corregirlo
            it.NumeroPresupuesto = p.Numero;
            it.FechaPresupuesto = p.FechaIngreso;
            it.IdUnidad = pdet.IdUnidad;
            it.OrigenDescripcion = pdet.OrigenDescripcion;
            it.CotizacionMoneda = p.CotizacionMoneda;
            it.Observaciones = p.Observaciones;
            it.IdMoneda = p.IdMoneda;
            it.PorcentajeBonificacion = p.Bonificacion;



            o.DetalleComparativas.Add(it);

            return it;

        }




        void DeGrillaHaciaObjeto(List<RenglonJQgrid> grilla, Comparativa o)
        {


            if (grilla == null) return;

            foreach (var r in grilla)
            {
                if (r.IdArticulo == null) continue;




                itemObjeto(o, r, grilla[0].Total_A, r.PrecioA, r.Check_A, 1);
                itemObjeto(o, r, grilla[0].Total_B, r.PrecioB, r.Check_B, 2);
                itemObjeto(o, r, grilla[0].Total_C, r.PrecioC, r.Check_C, 3);
                itemObjeto(o, r, grilla[0].Total_D, r.PrecioD, r.Check_D, 4);
                itemObjeto(o, r, grilla[0].Total_E, r.PrecioE, r.Check_E, 5);
                itemObjeto(o, r, grilla[0].Total_F, r.PrecioF, r.Check_F, 6);
                itemObjeto(o, r, grilla[0].Total_G, r.PrecioG, r.Check_G, 7);
                itemObjeto(o, r, grilla[0].Total_H, r.PrecioH, r.Check_H, 8);

            }



            // refrescar datos de resumen
            //List<DetalleComparativa> Det = o.DetalleComparativas
            //                           .Where(x => x.IdArticulo != null)
            //                           .ToList();



            List<int> provs2 = o.DetalleComparativas.Select(x => (x.IdPresupuesto ?? 0)).Distinct().ToList();
            var rms = db.DetallePresupuestos.Where(c => provs2.Contains(c.IdPresupuesto ?? 0)).Select(p => p.IdDetalleRequerimiento).ToList();
            var cabrms = db.DetalleRequerimientos.Where(r => rms.Contains(r.IdDetalleRequerimiento)).Select(p => p.IdRequerimiento).Distinct().ToList();
            var num = db.Requerimientos.Include(x => x.Obra).Where(r => cabrms.Contains(r.IdRequerimiento)).Select(p => p.NumeroRequerimiento).ToList();


            var conobra = db.Requerimientos.Include(x => x.Obra).Where(r => cabrms.Contains(r.IdRequerimiento)).Select(p => p.Obra.Descripcion).ToList();
            var obras = string.Join(",", conobra);



            o.Obras = obras.Substring(0, (obras.Length > 20) ? 20 : obras.Length);
            o.NumeroRequerimiento = 0;
            o.PresupuestoSeleccionado = 0;
            o.MontoParaCompra = "0";
            o.MontoPrevisto = 0;

            //o.plazoentrega


        }

        List<RenglonJQgrid> DeObjetoHaciaGrilla(Comparativa o)
        {

            List<DetalleComparativa> Det = o.DetalleComparativas
                                    .Where(x => x.IdArticulo != null)
                                    .ToList();

            List<int> provs2 = Det.Select(x => (x.IdPresupuesto ?? 0)).Distinct().ToList();   // .Count();
            // http://stackoverflow.com/questions/269058/how-do-you-add-an-index-field-to-linq-results

            var provs = provs2.Select((i, index) => new { numcol = index, IdPresupuesto = i }).ToList();


            List<int?> ArticulosDistintos = Det.Select(x => x.IdArticulo).Distinct().ToList();



            int pageSize = ArticulosDistintos.Count();  //rows; // ?? 20;
            int totalRecords = ArticulosDistintos.Count();
            int totalPages = 1; // (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = 1; // page ?? 1;

            //var q = db.DetalleComparativas.Where(c => c.IdComparativa == a.IdComparativa).Select(c => c.IdPresupuesto).ToList();
            //              var rms = db.DetallePresupuestos.Where(c => q.Contains(c.IdPresupuesto)).Select(p => p.IdDetalleRequerimiento).ToList();
            //              var cabrms = db.DetalleRequerimientos.Where(r => rms.Contains(r.IdDetalleRequerimiento)).Select(p => p.IdRequerimiento).Distinct().ToList();
            //              var aaaas = db.Requerimientos.Include(x => x.Obra).Where(r => cabrms.Contains(r.IdRequerimiento)).Select(p => p.Obra.Descripcion).ToList();
            //              var num = db.Requerimientos.Include(x => x.Obra).Where(r => cabrms.Contains(r.IdRequerimiento)).Select(p => p.NumeroRequerimiento).ToList();
            //              var ssss = string.Join(",", aaaas);
            //              var eeeee = string.Join(",", num);

            // http://stackoverflow.com/questions/11986656/entityframework-retrieve-data-with-a-condition-on-two-different-context
            // http://stackoverflow.com/a/11987291


            var data = new List<RenglonJQgrid>();

            var pr = provs2.Count;
            int dd0 = (pr > 0) ? provs2[0] : -1;
            int dd1 = (pr > 1) ? provs2[1] : -1;
            int dd2 = (pr > 2) ? provs2[2] : -1;
            int dd3 = (pr > 3) ? provs2[3] : -1;
            int dd4 = (pr > 4) ? provs2[4] : -1;
            int dd5 = (pr > 5) ? provs2[5] : -1;
            int dd6 = (pr > 6) ? provs2[6] : -1;
            int dd7 = (pr > 7) ? provs2[7] : -1;
            //var razsoc1 = (pr > 0) ? db.Presupuestos.Include("Proveedor").SingleOrDefault(x => x.IdPresupuesto == ddd).Proveedor.RazonSocial : "";
            //
            //            for (int i = 0; i < 7; i++)
            //{
            //    int ddd = (pr > 0) ? provs2[0] : -1;
            //    var razsoc1 = (pr > 0) ? db.Presupuestos.Include("Proveedor").SingleOrDefault(x => x.IdPresupuesto == ddd).Proveedor.RazonSocial : "";
            //}



            RenglonJQgrid encabezado = new RenglonJQgrid
            {
                IdDetalleComparativa = null,
                Cantidad = null,



                PrecioA = (pr > 0) ? "Presupuesto " + db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd0).Numero + " " +
                                    db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd0).SubNumero + " del " +
                                    db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd0).FechaIngreso.Value.ToShortDateString() + " " +
                                    db.Presupuestos.Include("Proveedor").SingleOrDefault(x => x.IdPresupuesto == dd0).Proveedor.RazonSocial +
                                    " (" + db.Presupuestos.Include("Moneda").SingleOrDefault(x => x.IdPresupuesto == dd0).Moneda.Abreviatura + ")"
                                        : "",
                Total_A = (pr > 0) ? provs2[0].ToString("#.##") : "",

                PrecioB = (pr > 1) ? "Presupuesto " + db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Numero + " " +
                                    db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).SubNumero + " del " +
                                    db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).FechaIngreso.Value.ToShortDateString() + " " +
                                    db.Presupuestos.Include("Proveedor").SingleOrDefault(x => x.IdPresupuesto == dd1).Proveedor.RazonSocial +
                                    " (" + db.Presupuestos.Include("Moneda").SingleOrDefault(x => x.IdPresupuesto == dd1).Moneda.Abreviatura + ")"
                                        : "",
                Total_B = (pr > 1) ? provs2[1].ToString("#.##") : "",

                PrecioC = (pr > 2) ? "Presupuesto " + db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd2).Numero + " " +
                                    db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd2).SubNumero + " del " +
                                    db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd2).FechaIngreso.Value.ToShortDateString() + " " +
                                    db.Presupuestos.Include("Proveedor").SingleOrDefault(x => x.IdPresupuesto == dd2).Proveedor.RazonSocial +
                                    " (" + db.Presupuestos.Include("Moneda").SingleOrDefault(x => x.IdPresupuesto == dd2).Moneda.Abreviatura + ")"
                                        : "",
                Total_C = (pr > 2) ? provs2[2].ToString("#.##") : "",

                PrecioD = (pr > 3) ? db.Presupuestos.Include("Proveedor").SingleOrDefault(x => x.IdPresupuesto == dd3).Proveedor.RazonSocial : "",
                Total_D = (pr > 3) ? provs2[3].ToString("#.##") : "",

                PrecioE = (pr > 4) ? db.Presupuestos.Include("Proveedor").SingleOrDefault(x => x.IdPresupuesto == dd4).Proveedor.RazonSocial : "",
                Total_E = (pr > 4) ? provs2[4].ToString() : "",

                PrecioF = (pr > 5) ? db.Presupuestos.Include("Proveedor").SingleOrDefault(x => x.IdPresupuesto == dd5).Proveedor.RazonSocial : "",
                Total_F = (pr > 5) ? provs2[5].ToString() : "",

                PrecioG = (pr > 6) ? db.Presupuestos.Include("Proveedor").SingleOrDefault(x => x.IdPresupuesto == dd6).Proveedor.RazonSocial : "",
                Total_G = (pr > 6) ? provs2[6].ToString() : "",

                PrecioH = (pr > 7) ? db.Presupuestos.Include("Proveedor").SingleOrDefault(x => x.IdPresupuesto == dd7).Proveedor.RazonSocial : "",
                Total_H = (pr > 7) ? provs2[7].ToString() : "",

            };







            data.Add(encabezado);


            foreach (int? i in ArticulosDistintos)
            {

                var ArticuloPorPresupuestos = (
                             from d in Det
                             join p in provs on d.IdPresupuesto equals p.IdPresupuesto
                             where d.IdArticulo == i
                             select new { d, p }
                            ).ToList();


                var aaa = db.Articulos.Find(i);

                RenglonJQgrid it = new RenglonJQgrid
                {
                    IdDetalleComparativa = null, // esto no sirve para nada. la grilla no tiene iddetallecomparativa
                    IdPresupuesto = -1,
                    IdDetallePresupuesto = -1,
                    IdArticulo = i,



                };

                foreach (var x in ArticuloPorPresupuestos)
                {

                    var a = x.d;
                    a.Articulo = db.Articulos.Find(a.IdArticulo);
                    var p = x.p;


                    ///////// esto podria estar fuera del for
                    it.IdUnidad = a.IdUnidad;
                    it.Codigo = (a.Articulo == null) ? "" : a.Articulo.Codigo;
                    it.Descripcion = (a.Articulo == null) ? "" : a.Articulo.Descripcion;
                    it.Cantidad = a.Cantidad;
                    it.DescUnidad = (a.Unidade == null ? "" : a.Unidade.Abreviatura);
                    /////////


                    if (p.numcol == 0)
                    {
                        it.PrecioA = (p.numcol == 0) ? a.Precio.ToString() : 0.ToString();
                        it.Total_A = ((p.numcol == 0) ? a.Precio * a.Cantidad ?? 0 : 0).ToString("#.##");
                        it.Check_A = (p.numcol == 0) ? (a.Estado == "MR").ToString() : "false";
                    }

                    if (p.numcol == 1)
                    {
                        it.PrecioB = (p.numcol == 1) ? a.Precio.ToString() : 0.ToString();
                        it.Total_B = ((p.numcol == 1) ? a.Precio * a.Cantidad ?? 0 : 0).ToString("#.##");
                        it.Check_B = (p.numcol == 1) ? (a.Estado == "MR").ToString() : "false";
                    }

                    if (p.numcol == 2)
                    {
                        it.PrecioC = (p.numcol == 2) ? a.Precio.ToString() : 0.ToString();
                        it.Total_C = ((p.numcol == 2) ? a.Precio * a.Cantidad ?? 0 : 0).ToString("#.##");
                        it.Check_C = (p.numcol == 2) ? (a.Estado == "MR").ToString() : "false";
                    }

                    if (p.numcol == 3)
                    {
                        it.PrecioD = ((p.numcol == 3) ? a.Precio : 0).ToString();
                        it.Total_D = ((p.numcol == 3) ? a.Precio * a.Cantidad : 0).ToString();
                        it.Check_D = (p.numcol == 3) ? (a.Estado == "MR").ToString() : "false";
                    }

                    if (p.numcol == 4)
                    {
                        it.PrecioE = (p.numcol == 4) ? a.Precio.ToString() : 0.ToString();
                        it.Total_E = ((p.numcol == 4) ? a.Precio * a.Cantidad : 0).ToString();
                        it.Check_E = (p.numcol == 4) ? (a.Estado == "MR").ToString() : "false";
                    }

                    if (p.numcol == 5)
                    {
                        it.PrecioF = (p.numcol == 5) ? a.Precio.ToString() : 0.ToString();
                        it.Total_F = ((p.numcol == 5) ? a.Precio * a.Cantidad : 0).ToString();
                        it.Check_F = (p.numcol == 5) ? (a.Estado == "MR").ToString() : "false";
                    }

                    if (p.numcol == 6)
                    {
                        it.PrecioG = (p.numcol == 6) ? a.Precio.ToString() : 0.ToString();
                        it.Total_G = ((p.numcol == 6) ? a.Precio * a.Cantidad : 0).ToString();
                        it.Check_G = (p.numcol == 6) ? (a.Estado == "MR").ToString() : "false";
                    }

                    if (p.numcol == 7)
                    {
                        it.PrecioH = (p.numcol == 7) ? a.Precio.ToString() : 0.ToString();
                        it.Total_H = ((p.numcol == 7) ? a.Precio * a.Cantidad : 0).ToString();
                        it.Check_H = (p.numcol == 7) ? (a.Estado == "MR").ToString() : "false";
                    }





                }
                data.Add(it);
            }


            RenglonJQgrid pie = new RenglonJQgrid
            {
                IdDetalleComparativa = null,
                Cantidad = null,

                Descripcion = "SubTotal",


                Total_A = (pr > 0) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd0).ImporteTotal.NullSafeToString() : "",
                Total_B = (pr > 1) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteTotal.NullSafeToString() : "",
                Total_C = (pr > 2) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteTotal.NullSafeToString() : "",
                Total_D = (pr > 3) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteTotal.NullSafeToString() : "",
                Total_E = (pr > 4) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteTotal.NullSafeToString() : "",
                Total_F = (pr > 5) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteTotal.NullSafeToString() : "",
                Total_G = (pr > 6) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd2).ImporteTotal.NullSafeToString() : "",
                Total_H = (pr > 7) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteTotal.NullSafeToString() : ""



            };

            data.Add(pie);





            RenglonJQgrid pie3 = new RenglonJQgrid
            {
                IdDetalleComparativa = null,
                Cantidad = null,

                Descripcion = "Bonificacion",
                Total_A = (pr > 0) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd0).ImporteBonificacion.NullSafeToString() : "",
                Total_B = (pr > 1) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteBonificacion.NullSafeToString() : "",
                Total_C = (pr > 2) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteBonificacion.NullSafeToString() : "",
                Total_D = (pr > 3) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteBonificacion.NullSafeToString() : "",
                Total_E = (pr > 4) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteBonificacion.NullSafeToString() : "",
                Total_F = (pr > 5) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteBonificacion.NullSafeToString() : "",
                Total_G = (pr > 6) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd2).ImporteBonificacion.NullSafeToString() : "",
                Total_H = (pr > 7) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteBonificacion.NullSafeToString() : ""


            };
            data.Add(pie3);



            RenglonJQgrid pie4 = new RenglonJQgrid
            {
                IdDetalleComparativa = null,
                Cantidad = null,

                Descripcion = "TOTAL",
                Total_A = (pr > 0) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd0).ImporteTotal.NullSafeToString() : "",
                Total_B = (pr > 1) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteTotal.NullSafeToString() : "",
                Total_C = (pr > 2) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteTotal.NullSafeToString() : "",
                Total_D = (pr > 3) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteTotal.NullSafeToString() : "",
                Total_E = (pr > 4) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteTotal.NullSafeToString() : "",
                Total_F = (pr > 5) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteTotal.NullSafeToString() : "",
                Total_G = (pr > 6) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd2).ImporteTotal.NullSafeToString() : "",
                Total_H = (pr > 7) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).ImporteTotal.NullSafeToString() : ""
            };
            data.Add(pie4);


            RenglonJQgrid pie5 = new RenglonJQgrid
            {
                IdDetalleComparativa = null,
                Cantidad = null,

                Descripcion = "Plazo de entrega",
                PrecioA = (pr > 0) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd0).Plazo.NullSafeToString() : "",
                PrecioB = (pr > 1) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Plazo.NullSafeToString() : "",
                PrecioC = (pr > 2) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Plazo.NullSafeToString() : "",
                PrecioD = (pr > 3) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Plazo.NullSafeToString() : "",
                PrecioE = (pr > 4) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Plazo.NullSafeToString() : "",
                PrecioF = (pr > 5) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Plazo.NullSafeToString() : "",
                PrecioG = (pr > 6) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd2).Plazo.NullSafeToString() : "",
                PrecioH = (pr > 7) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Plazo.NullSafeToString() : ""
            };
            data.Add(pie5);



            RenglonJQgrid pie55 = new RenglonJQgrid
            {
                IdDetalleComparativa = null,
                Cantidad = null,

                Descripcion = "Condicion de pago",
                PrecioA = (pr > 0) ? db.Presupuestos.Include(x => x.Condiciones_Compra).SingleOrDefault(x => x.IdPresupuesto == dd0).Condiciones_Compra.Descripcion.NullSafeToString() : "",
                PrecioB = (pr > 1) ? db.Presupuestos.Include(x => x.Condiciones_Compra).SingleOrDefault(x => x.IdPresupuesto == dd1).Condiciones_Compra.Descripcion.NullSafeToString() : "",
                PrecioC = (pr > 2) ? db.Presupuestos.Include(x => x.Condiciones_Compra).SingleOrDefault(x => x.IdPresupuesto == dd1).Condiciones_Compra.Descripcion.NullSafeToString() : "",
                PrecioD = (pr > 3) ? db.Presupuestos.Include(x => x.Condiciones_Compra).SingleOrDefault(x => x.IdPresupuesto == dd1).Condiciones_Compra.Descripcion.NullSafeToString() : "",
                PrecioE = (pr > 4) ? db.Presupuestos.Include(x => x.Condiciones_Compra).SingleOrDefault(x => x.IdPresupuesto == dd1).Condiciones_Compra.Descripcion.NullSafeToString() : "",
                PrecioF = (pr > 5) ? db.Presupuestos.Include(x => x.Condiciones_Compra).SingleOrDefault(x => x.IdPresupuesto == dd1).Condiciones_Compra.Descripcion.NullSafeToString() : "",
                PrecioG = (pr > 6) ? db.Presupuestos.Include(x => x.Condiciones_Compra).SingleOrDefault(x => x.IdPresupuesto == dd2).Condiciones_Compra.Descripcion.NullSafeToString() : "",
                PrecioH = (pr > 7) ? db.Presupuestos.Include(x => x.Condiciones_Compra).SingleOrDefault(x => x.IdPresupuesto == dd1).Condiciones_Compra.Descripcion.NullSafeToString() : ""
            };
            data.Add(pie55);


            RenglonJQgrid pie6 = new RenglonJQgrid
            {
                IdDetalleComparativa = null,
                Cantidad = null,

                Descripcion = "Observaciones",
                PrecioA = (pr > 0) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd0).Observaciones.NullSafeToString() : "",
                PrecioB = (pr > 1) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Observaciones.NullSafeToString() : "",
                PrecioC = (pr > 2) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Observaciones.NullSafeToString() : "",
                PrecioD = (pr > 3) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Observaciones.NullSafeToString() : "",
                PrecioE = (pr > 4) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Observaciones.NullSafeToString() : "",
                PrecioF = (pr > 5) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Observaciones.NullSafeToString() : "",
                PrecioG = (pr > 6) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd2).Observaciones.NullSafeToString() : "",
                PrecioH = (pr > 7) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Observaciones.NullSafeToString() : ""


            };
            data.Add(pie6);

            RenglonJQgrid pie7 = new RenglonJQgrid
            {
                IdDetalleComparativa = null,
                Cantidad = null,

                Descripcion = "Solicitud cot. No.",
                PrecioA = (pr > 0) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd0).Numero.NullSafeToString() : "",
                PrecioB = (pr > 1) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Numero.NullSafeToString() : "",
                PrecioC = (pr > 2) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Numero.NullSafeToString() : "",
                PrecioD = (pr > 3) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Numero.NullSafeToString() : "",
                PrecioE = (pr > 4) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Numero.NullSafeToString() : "",
                PrecioF = (pr > 5) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Numero.NullSafeToString() : "",
                PrecioG = (pr > 6) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd2).Numero.NullSafeToString() : "",
                PrecioH = (pr > 7) ? db.Presupuestos.SingleOrDefault(x => x.IdPresupuesto == dd1).Numero.NullSafeToString() : ""

            };
            data.Add(pie7);




            return data;
        }


        [HttpPost]
        public virtual ActionResult ArmarGrillaSegunPresupuestos(Comparativa o, int IdPresupuestoAgregado = -1, List<RenglonJQgrid> grilla = null)
        {
            //int IdComparativa = 0;
            //var Det = db.DetalleComparativas.Where(p => p.IdComparativa == IdComparativa).Include("Articulo").ToList();

            // DataTable tab = ComparativaManager.GUI_DeDetalleAGrilla(SC,  myComparativa);

            if (grilla == null)
            {

                // sería la primera llamada de la grilla
                if (o.IdComparativa > 0)
                {
                    o = db.Comparativas.Where(p => p.IdComparativa == o.IdComparativa).Include(p => p.DetalleComparativas).SingleOrDefault();
                }
            }

            else
            {
                o.DetalleComparativas.Clear();
                DeGrillaHaciaObjeto(grilla, o);
            }





            if (IdPresupuestoAgregado > 0)
            {

                if (!o.DetalleComparativas.Any(x => x.IdPresupuesto == IdPresupuestoAgregado)) // si está presente, no agregarlo 
                {
                    var d = db.DetallePresupuestos.Where(x => x.IdPresupuesto == IdPresupuestoAgregado).ToList();
                    foreach (DetallePresupuesto i in d)
                    {
                        var x = new DetalleComparativa();
                        x.IdArticulo = i.IdArticulo;
                        x.IdPresupuesto = i.IdPresupuesto;
                        x.Articulo = db.Articulos.Find(i.IdArticulo);

                        x.Precio = i.Precio;
                        //                            x.Cantidad=

                        o.DetalleComparativas.Add(x);
                    }
                }
            }


            var data = DeObjetoHaciaGrilla(o);


            var jsonData = new jqGridJson()
            {
                total = 1,
                page = 1,
                records = data.Count(),
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleComparativa.ToString(),
                            cell = new string[] {
                                string.Empty,
                                a.IdDetalleComparativa.NullSafeToString(),
                                a.IdArticulo.NullSafeToString(),
                                a.IdPresupuesto.NullSafeToString(),
                                a.Codigo.NullSafeToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Cantidad.NullSafeToString()
                                ,a.PrecioA.NullSafeToString()
                                ,a.Total_A.NullSafeToString()
                                 ,a.Check_A.NullSafeToString()
                                ,a.PrecioB.NullSafeToString()
                                ,a.Total_B.NullSafeToString()
                                ,a.Check_B.NullSafeToString()
                                ,a.PrecioC.NullSafeToString()
                                ,a.Total_C.NullSafeToString()
                                ,a.Check_C.NullSafeToString()
                                ,a.PrecioD.NullSafeToString()
                                ,a.Total_D.NullSafeToString()
                                ,a.Check_D.NullSafeToString()
                                ,a.PrecioE.NullSafeToString()
                                ,a.Total_E.NullSafeToString()
                                ,a.Check_E.NullSafeToString()
                                ,a.PrecioF.NullSafeToString()
                                ,a.Total_F.NullSafeToString()
                                ,a.Check_F.NullSafeToString()
                                ,a.PrecioG.NullSafeToString()
                                ,a.Total_G.NullSafeToString()
                                ,a.Check_G.NullSafeToString()
                                ,a.PrecioH.NullSafeToString()
                                ,a.Total_H.NullSafeToString()
                                ,a.Check_H.NullSafeToString()

                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);



        }




        public virtual ActionResult DetComparativaParaJQgrid(string sidx, string sord, int? page, int? rows, int? IdComparativa)
        {

            // los detalles de comprobante no deberían paginarse!!!!


            IdComparativa = IdComparativa ?? 0;
            var Det = db.DetalleComparativas.Where(p => p.IdComparativa == IdComparativa).Include("Articulo");
            Comparativa o = new Comparativa();
            o.DetalleComparativas = Det.ToList();


            return ArmarGrillaSegunPresupuestos(o);

        }





        public virtual JsonResult DetComparativasSinFormato(int IdComparativa)
        {
            var Det = db.DetalleComparativas.Where(p => p.IdComparativa == IdComparativa).AsQueryable();

            var data = (from a in Det
                        select new
                        {
                            a.IdDetalleComparativa,
                            a.IdPresupuesto,
                            a.IdDetallePresupuesto,
                            a.IdArticulo,
                            a.Cantidad,
                            a.Precio,
                            a.IdUnidad,
                            a.Observaciones,
                            a.Estado

                        }).OrderBy(p => p.IdDetalleComparativa).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }


        public virtual FileResult Imprimir(int id) //(int id)
        {
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.xlsx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Comparativa.xlsx";

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            System.IO.File.Copy(plantilla, output); // 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 



            Pronto.ERP.BO.Comparativa comp = ComparativaManager.GetItem(SC, id, true);

            //ComparativaManager.ImpresionDeComparativaPorDLLconXML
            //OpenXML_Pronto.FacturaXML_DOCX(output, fac, SC);

            var c = ComparativaXML_XLSX_MVC_ConTags(output, comp, SC, id);
            c = null;
            //ComparativaManager.TraerPieDLL

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "Comparativa.xlsx");
        }





        public SpreadsheetDocument ComparativaXML_XLSX_MVC_ConTags(string xlt, Pronto.ERP.BO.Comparativa myComparativa, string SC, int idComparativa)
        {



            var a = db.Comparativas.Find(idComparativa);






            //OpenXML_Pronto.ComparativaXML_XLSX(xlt, myComparativa, SC);

            DataTable tab = ComparativaManager.GUI_DeDetalleAGrilla(SC, myComparativa, true);
            DataTable gvcompara = tab;
            DataTable tabpie;
            try
            {
                tabpie = ComparativaManager.TraerPieDLL(SC, myComparativa);
            }


            catch (Exception e)
            {
                tabpie = new DataTable();
                ErrHandler.WriteError(e); //throw;
            }
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            var wb = new XLWorkbook(xlt);
            var worksheet = wb.Worksheet(1);



            //agrego las filas de articulos
            if (gvcompara.Rows.Count > 1) worksheet.Row(10).InsertRowsBelow(gvcompara.Rows.Count - 1); // Range starts on B3


            //borro las columnas de proveedores sobreantes
            var provs = myComparativa.Detalles.Select(x => x.IdPresupuesto).Distinct().Count();
            var rng = worksheet.Range(GetExcelColumnName(4 + 2 * provs + 1) + "1:ZZ50");
            rng.Clear();
            //for (int t = 4 + 2 * provs + 1; t < 50; t += 2)
            //{
            //    //worksheet.Column(t).Delete();
            //    //worksheet.Column(t+1).Delete();
            //}

            //            ws.Range("A1:").Delete(XLShiftDeletedCells.ShiftCellsLeft);
            //worksheet.Column(4+2*5+1).Delete(); // Range starts on B3

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // pongo en negrita los mejores precios -tambien podría aprovechar para reordenar las columnas

            if (false)
            {

                try
                {


                    //var wb2 = new XLWorkbook(xlt);
                    //var worksheet2 = wb2.Worksheet(1);

                    var wb2 = wb;
                    var worksheet2 = worksheet;

                    for (int cl = 0; cl < provs; cl++)
                    {

                        for (int fl = 0; fl < tab.Rows.Count; fl++)
                        {

                            int subnumero = cl + 1;
                            try
                            {
                                if (tab.Rows[fl].Field<bool>("M" + subnumero))
                                {
                                    worksheet2.Cell(fl + 9 + 1, 5 + cl * 2).Style.Font.Bold = true;
                                }
                            }
                            catch (Exception)
                            {


                            }

                        }

                    }
                    //wb2.Save();

                }
                catch (Exception)
                {

                    //   throw;
                }

            }

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            try
            {
                wb.Save();
            }
            catch (Exception)
            {
                //            http://closedxml.codeplex.com/workitem/8972
                //            Error occurs while using saveAs method:
                //Could not load type 'DocumentFormat.OpenXml.Spreadsheet.SmartTags' from assembly 'DocumentFormat.OpenXml, Version=2.5.5631.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.

                //    You must use the DocumentFormat.OpenXml.dll v2.0 (not v2.5)

                //                https://closedxml.codeplex.com/discussions/405533

                //                You have to use OpenXML dll 2.0 with ClosedXML for .Net 3.5 
                //OpenXML dll 2.5 works fine with ClosedXML for .Net 4+


                throw;
            }


            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            SpreadsheetDocument spreadSheet = null;
            SharedStringTablePart sharedStringTablePart;
            WorkbookStylesPart workbookStylesPart;


            using (spreadSheet = SpreadsheetDocument.Open(xlt, true))
            {
                try
                {

                    // Create the parts and the corresponding objects
                    // Workbook
                    //spreadSheet.AddWorkbookPart();
                    //spreadSheet.WorkbookPart.Workbook = new Workbook();
                    //spreadSheet.WorkbookPart.Workbook.Save();

                    //// Shared string table
                    //sharedStringTablePart = spreadSheet.WorkbookPart.AddNewPart<SharedStringTablePart>();
                    //sharedStringTablePart.SharedStringTable = new SharedStringTable();
                    //sharedStringTablePart.SharedStringTable.Save();

                    //// Sheets collection
                    //spreadSheet.WorkbookPart.Workbook.Sheets = new Sheets();
                    //spreadSheet.WorkbookPart.Workbook.Save();

                    //// Stylesheet
                    //workbookStylesPart = spreadSheet.WorkbookPart.AddNewPart<WorkbookStylesPart>();
                    //workbookStylesPart.Stylesheet = new Stylesheet();
                    //workbookStylesPart.Stylesheet.Save();


                    // debug:


                    SpreadsheetDocument oEx;
                    // Spreadsheet.Workbook oBook;
                    oEx = spreadSheet;


                    Pronto.ERP.BO.Presupuesto pre;


                    object oAp;
                    //ADODB.Recordset oRsPre;
                    //ADODB.Recordset oRsEmp;
                    object oRsPre;
                    object oRsEmp;
                    int i;
                    int cl;
                    int cl1;
                    int fl;
                    long mvarPresu;
                    long mvarSubNum;
                    DateTime mvarFecha;
                    string mvarConfecciono;
                    string mvarAprobo;
                    string mvarMPrevisto;
                    string mvarMCompra;
                    string mvarMoneda;
                    string mvarLibero;
                    double mvarPrecioIdeal;
                    double mvarPrecioReal;
                    object mCabecera;
                    int desplaz = 10;
                    mvarPresu = myComparativa.Numero;
                    mvarFecha = myComparativa.Fecha;
                    //if (IsNull(myComparativa.IdConfecciono)) {
                    //    mvarConfecciono = "";
                    //}
                    //else {
                    //    mvarConfecciono = EmpleadoManager.GetItem(SC, myComparativa.IdConfecciono).Nombre;
                    //}
                    //if ((iisNull(myComparativa.IdAprobo, 0) == 0)) {
                    //    mvarAprobo = "";
                    //}
                    //else {
                    //    mvarAprobo = EmpleadoManager.GetItem(SC, myComparativa.IdAprobo).Nombre;
                    //}
                    //if (IsNull(myComparativa.MontoPrevisto)) {
                    //    mvarMPrevisto = "";
                    //}
                    //else {
                    //    mvarMPrevisto = myComparativa.MontoPrevisto;
                    //}
                    //if (IsNull(myComparativa.MontoParaCompra)) {
                    //    mvarMCompra = "";
                    //}
                    //else {
                    //    mvarMCompra = myComparativa.MontoParaCompra;
                    //}


                    WorksheetPart worksheetPart = ox.GetWorksheetPartByName(spreadSheet, "Hoja1");
                    Worksheet ws = worksheetPart.Worksheet;

                    if (false)
                    {
                        for (int ii = 0; ii < gvcompara.Rows.Count; ii++)
                        {
                            CopyToLine(GetRow(10, worksheetPart), 11, ws.GetFirstChild<SheetData>());
                        }
                    }


                    var q = db.DetalleComparativas.Where(c => c.IdComparativa == a.IdComparativa).Select(c => c.IdPresupuesto).ToList();
                    var rms = db.DetallePresupuestos.Where(c => q.Contains(c.IdPresupuesto)).Select(p => p.IdDetalleRequerimiento).ToList();
                    var cabrms = db.DetalleRequerimientos.Where(r => rms.Contains(r.IdDetalleRequerimiento)).Select(p => p.IdRequerimiento).Distinct().ToList();
                    var aaaas = db.Requerimientos.Include(x => x.Obra).Where(r => cabrms.Contains(r.IdRequerimiento)).Select(p => p.Obra.Descripcion).ToList();
                    var num = db.Requerimientos.Include(x => x.Obra).Where(r => cabrms.Contains(r.IdRequerimiento)).Select(p => p.NumeroRequerimiento).ToList();
                    var ssss = string.Join(",", aaaas);
                    var eeeee = string.Join(",", num);
                    //var q2= from i in db.Requerimientos
                    //        join r in db.DetalleRequerimientos
                    //        join x in db.DetallePresupuestos
                    //        join c in db.Comparativas



                    if (true)
                    {
                        //usando posicion absoluta

                        ox.Cells(ws, "Comparativa N°" + myComparativa.Numero, 2, "E");
                        ox.Cells(worksheetPart.Worksheet, "Fecha " + myComparativa.Fecha, 3, "E");
                        ox.Cells(worksheetPart.Worksheet, "Comprador: " + db.Empleados.Where(x => x.IdEmpleado == myComparativa.IdConfecciono).FirstOrDefault().Nombre, 4, "E");




                        ox.Cells(ws, "Obra/s : " + ssss, 5, "B");
                        ox.Cells(ws, "RM / LA : " + eeeee, 6, "B");


                        cl1 = 0;
                        for (cl = 1; cl <= provs * 2 + 4; cl++)
                        {
                            cl1 = (cl1 + 1);
                            int subnumero = (cl1 - 3) / 2;
                            for (fl = 0; fl <= tab.Rows.Count + 7; fl++)
                            {
                                // 7 son los renglones adicionales del pie
                                if ((fl == 0))
                                {
                                    // ////////////////////////////////////////////
                                    // ////////////////////////////////////////////
                                    // Es la primera fila, le encajo los titulos
                                    // ////////////////////////////////////////////
                                    // ////////////////////////////////////////////
                                    // Ampliar altura de fila de cabeceras de columna
                                    if ((cl1 > 4))
                                    {
                                        if (((cl1 % 2)
                                                    == 1))
                                        {
                                            // mCabecera = Split(gvCompara.Rows(fl).Cells(cl).Controls.Text, vbCrLf)
                                            Pronto.ERP.BO.ComparativaItem p = myComparativa.Detalles.Find(x => x.SubNumero == subnumero);
                                            // uso tempi por lo del lambda en el find
                                            if ((p == null)) continue;

                                            try
                                            {
                                                pre = PresupuestoManager.GetItem(SC, p.IdPresupuesto);

                                                ox.Cells(worksheetPart.Worksheet, pre.Proveedor, fl + 7, cl1);


                                                ox.Cells(worksheetPart.Worksheet, pre.Plazo, fl + gvcompara.Rows.Count + 13, cl1);
                                                ox.Cells(worksheetPart.Worksheet, db.Condiciones_Compras.Find(pre.IdCondicionCompra).Descripcion, fl + gvcompara.Rows.Count + 14, cl1);
                                                ox.Cells(worksheetPart.Worksheet, pre.Observaciones, fl + gvcompara.Rows.Count + 15, cl1);
                                                ox.Cells(worksheetPart.Worksheet, pre.Numero.ToString() + "/" + pre.SubNumero.ToString(), fl + gvcompara.Rows.Count + 16, cl1);


                                                ox.Cells(worksheetPart.Worksheet, (pre.ImporteTotal - pre.ImporteIva1).ToString(), fl + gvcompara.Rows.Count + 10, cl1 + 1);
                                                ox.Cells(worksheetPart.Worksheet, pre.ImporteBonificacion.ToString(), fl + gvcompara.Rows.Count + 11, cl1 + 1);
                                                ox.Cells(worksheetPart.Worksheet, pre.ImporteTotal.ToString(), fl + gvcompara.Rows.Count + 12, cl1 + 1);


                                                ox.Cells(worksheetPart.Worksheet, "Unitario ", fl + 9, cl1);
                                                ox.Cells(worksheetPart.Worksheet, "Total ", fl + 9, cl1 + 1);

                                            }
                                            catch (Exception)
                                            {

                                                //  throw;
                                            }


                                        }
                                    }
                                    else
                                    {
                                        switch (cl1)
                                        {
                                            case 2:
                                                ox.Cells(worksheetPart.Worksheet, "Producto ", fl + 7, cl1);
                                                break;
                                            case 3:
                                                ox.Cells(worksheetPart.Worksheet, "Cantidad ", fl + 7, cl1);
                                                break;
                                            case 4:
                                                ox.Cells(worksheetPart.Worksheet, "Unidad ", fl + 7, cl1);
                                                break;
                                        }
                                    }
                                }
                                else if ((fl > 0) & (fl < (tab.Rows.Count + 1)))
                                {
                                    // ////////////////////////////////////////////
                                    // ////////////////////////////////////////////
                                    // NO es la primera fila, es un renglon comun 
                                    // ////////////////////////////////////////////
                                    // ////////////////////////////////////////////
                                    // If gvCompara.row = gvCompara.Rows - 2 Then
                                    // rchObservacionesItems.TextRTF = gvCompara.Text
                                    // .Cells(fl + 9, cl1) = rchObservacionesItems.Text
                                    // Else
                                    if (((cl1 > 4) && ((cl1 % 2) == 1)))
                                    {
                                        // ox.Cells(ws, "Unidad ", fl + 7, cl1);

                                        try
                                        {
                                            ox.Cells(ws, tab.Rows[(fl - 1)].Field<string>("Precio" + subnumero), fl + 9, cl1);
                                            ox.Cells(ws, tab.Rows[(fl - 1)].Field<string>("Total" + subnumero), fl + 9, cl1 + 1);

                                        }
                                        catch (Exception)
                                        {

                                            //throw;
                                        }
                                    }
                                    else
                                    {
                                        try
                                        {
                                            switch (cl1)
                                            {
                                                case 2:
                                                    ox.Cells(ws, fl.ToString(), fl + 9, "A"); // numero de item
                                                    ox.Cells(ws, tab.Rows[(fl - 1)].Field<string>("Producto"), fl + 9, cl1);
                                                    break;
                                                case 3:
                                                    ox.Cells(ws, tab.Rows[(fl - 1)].Field<string>("Cantidad"), fl + 9, cl1);
                                                    break;
                                                case 4:
                                                    ox.Cells(ws, tab.Rows[(fl - 1)].Field<string>("Unidad"), fl + 9, cl1);
                                                    break;
                                                    //}
                                                    //2.Cells[(fl + 9), cl1] = tab.Rows[(fl - 1)].Item["Producto"];
                                                    //3.Cells[(fl + 9), cl1] = tab.Rows[(fl - 1)].Item["Cantidad"];
                                                    //4.Cells[(fl + 9), cl1] = tab.Rows[(fl - 1)].Item["Unidad"];

                                            }

                                        }
                                        catch (Exception)
                                        {

                                            //  throw;
                                        }

                                    }
                                    // ////////////////////////////////////////////
                                    // ////////////////////////////////////////////
                                    // es una fila del pie
                                    // ////////////////////////////////////////////
                                    // ////////////////////////////////////////////
                                    if (((cl1 > 4)
                                                && ((cl1 % 2)
                                                == 1)))
                                    {
                                        // valor
                                        object p = myComparativa.Detalles.Find(x => x.SubNumero == subnumero);
                                        // uso tempi por lo del lambda en el find
                                        if ((p == null))
                                        {
                                            // TODO: Continue For... Warning!!! not translated
                                        }
                                        //Debug.Print(tabpie.Rows[(fl 
                                        //                - (tab.Rows.Count - 1))].Item[subnumero]).Cells[(fl + desplaz), (cl1 + 1)] = tabpie.Rows[(fl 
                                        //            - (tab.Rows.Count - 1))].Item[subnumero];
                                    }
                                    else if ((cl1 == 4))
                                    {
                                        //// titulo
                                        switch (fl)
                                        {
                                            case 1:
                                                ox.Cells(ws, "Bonificacion ", fl + (desplaz + 1), cl1);
                                                break;
                                            case 2:
                                                ox.Cells(ws, "TOTAL ", fl + (desplaz + 1), cl1);
                                                break;
                                            case 3:
                                                ox.Cells(ws, "Plazo de entrega ", fl + (desplaz + 1), cl1);
                                                break;
                                            case 4:
                                                ox.Cells(ws, "Condicion de pago ", fl + (desplaz + 1), cl1);
                                                break;
                                            case 5:
                                                ox.Cells(ws, "Observaciones ", fl + (desplaz + 1), cl1);
                                                break;
                                            case 6:
                                                ox.Cells(ws, "Solicitud de cotizacion nro. ", fl + (desplaz + 1), cl1);
                                                break;

                                        }
                                    }

                                    //((cl1 > 4) 
                                    //            & ((fl > 0) 
                                    //            & (fl <= tab.Rows.Count)));
                                    try
                                    {
                                        if (tab.Rows[(fl - 1)].Field<bool>("M2"))
                                        {

                                            // hacer esto con el ClosedXML
                                            // Cells((fl + 9), cl1).Font.Bold = true;
                                        }

                                    }
                                    catch (Exception e)
                                    {
                                        ErrHandler.WriteError(e); //throw;
                                    }

                                }

                                // ox.Cells(ws, "Unidad ", fl + 7, cl1);
                                // Cells((fl + 9), cl1).NumberFormat = "#,##0.00";
                            }




                            //Cell ce2 = worksheetPart.Worksheet.Elements<Cell>().Where(c => c.CellValue.ToString() == "#Numero#").First();
                            //Cell ce = worksheetPart.Worksheet.Elements<Cell>().Where(c => string.Compare(c.CellValue.ToString(), "#Numero#") == 0).First();
                            //ce.CellValue = new CellValue(myComparativa.Numero.ToString());



                        }


                        // //////////////////////////////////////////////
                        // Informacion en celdas sueltas
                        // //////////////////////////////////////////////


                        ox.Cells(worksheetPart.Worksheet, "Obs.Grales. : " + myComparativa.Observaciones, gvcompara.Rows.Count + 18, "A");
                        ox.Cells(ws, "Monto previsto : " + myComparativa.MontoPrevisto, gvcompara.Rows.Count + 19, "A");
                        ox.Cells(worksheetPart.Worksheet, "Monto para compra : " + myComparativa.MontoParaCompra, gvcompara.Rows.Count + 20, "A");

                        try
                        {
                            ox.Cells(ws, db.Empleados.Find(myComparativa.IdAprobo).Nombre + ' ' + a.Fecha, gvcompara.Rows.Count + 23, "B"); //"Liberada por :  : " 
                            ox.Cells(ws, db.Empleados.Find(myComparativa.IdConfecciono).Nombre + ' ' + a.FechaAprobacion, gvcompara.Rows.Count + 24, "B"); //"Jefe de sector  : " 
                        }
                        catch (Exception)
                        {

                            // throw;
                        }
                        ox.Cells(ws, "", gvcompara.Rows.Count + 25, "B"); //"Gerentes: "



                        //PRESUPUESTO TOTAL EL RUBRO
                        //PRESUPUESTO ACUMULADO
                        //GASTO ACUMULADO
                        //PRESUPUESTO DE ESTA COMPARATIVA
                        //ESTA ADJUDICACION
                        ox.Cells(ws, "0", gvcompara.Rows.Count + 31, "D");
                        ox.Cells(ws, myComparativa.MontoPrevisto.ToString(), gvcompara.Rows.Count + 32, "D");
                        ox.Cells(ws, "0", gvcompara.Rows.Count + 33, "D");
                        ox.Cells(ws, myComparativa.MontoPrevisto.ToString(), gvcompara.Rows.Count + 34, "D");
                        ox.Cells(ws, a.PresupuestoSeleccionado.ToString(), gvcompara.Rows.Count + 35, "D");
                        //DESVIO
                        ox.Cells(ws, "0", gvcompara.Rows.Count + 39, "D");


                        //      10.Cells[(gvcompara.Rows.Count + 15), 1] = ("Monto para compra : " + myComparativa.MontoParaCompra);
                        //("Monto previsto : " + myComparativa.MontoPrevisto.Cells[(gvcompara.Rows.Count + 15), 1].Select().Rows[(gvcompara.Rows.Count + 15)].RowHeight) = ("Monto para compra : " + myComparativa.MontoParaCompra);
                        //10.Cells[(gvcompara.Rows.Count + 14), 1] = ("Monto para compra : " + myComparativa.MontoParaCompra);
                        //("Obs.Grales. : " + myComparativa.Observaciones.Cells[(gvcompara.Rows.Count + 14), 1].Select().Rows[(gvcompara.Rows.Count + 14)].RowHeight) = ("Monto para compra : " + myComparativa.MontoParaCompra);
                        //25.Cells[(gvcompara.Rows.Count + 13), 1] = ("Monto para compra : " + myComparativa.MontoParaCompra);
                        //Cells((gvcompara.Rows.Count + 13), 1).Select().Rows[(gvcompara.Rows.Count + 13)].RowHeight = ("Monto para compra : " + myComparativa.MontoParaCompra);
                        //// //////////////////////////////////////////////
                        // //////////////////////////////////////////////
                        // //////////////////////////////////////////////
                        // //////////////////////////////////////////////
                        // //////////////////////////////////////////////
                        //mvarLibero = "";
                        //if ((iisNull(myComparativa.IdAprobo, 0) != 0)) {
                        //    mvarLibero = ("" + EmpleadoManager.GetItem(SC, myComparativa.IdAprobo).Nombre);
                        //    if (!IsNull(myComparativa.FechaAprobacion)) {
                        //        mvarLibero = (mvarLibero + ("  " + myComparativa.FechaAprobacion));
                        //    }
                        //}





                    }
                    else
                    {

                        // usando tags

                        string txt = "";
                        WorkbookPart bkPart = spreadSheet.WorkbookPart;
                        DocumentFormat.OpenXml.Spreadsheet.Workbook workbook = bkPart.Workbook;
                        DocumentFormat.OpenXml.Spreadsheet.Sheet s = workbook.Descendants<DocumentFormat.OpenXml.Spreadsheet.Sheet>().Where(sht => sht.Name == "Hoja1").FirstOrDefault();
                        WorksheetPart wsPart = (WorksheetPart)bkPart.GetPartById(s.Id);
                        DocumentFormat.OpenXml.Spreadsheet.SheetData sheetdata = wsPart.Worksheet.Elements<DocumentFormat.OpenXml.Spreadsheet.SheetData>().FirstOrDefault();

                        foreach (DocumentFormat.OpenXml.Spreadsheet.Row r in sheetdata.Elements<DocumentFormat.OpenXml.Spreadsheet.Row>())
                        {
                            try
                            {
                                List<string> l = r.Elements<DocumentFormat.OpenXml.Spreadsheet.Cell>().Select(c => (c.CellValue ?? new CellValue()).Text).ToList();
                                txt += string.Join(",", l);
                                //txt += c.CellValue.Text + Environment.NewLine;
                                //  Debug.Print(l.ToArray());
                                ReemplazaRow(r, "#Numero#", myComparativa.Numero.ToString());

                            }
                            catch (Exception e)
                            {
                                ErrHandler.WriteError(e); //throw;
                            }

                        }
                    }

                    worksheetPart.Worksheet.Save();
                    //IEnumerable<Sheet> sheets =            document.WorkbookPart.Workbook.GetFirstChild<Sheets>().         Elements<Sheet>()







                }
                catch (System.Exception exception)
                {
                    throw;
                    //                System.Windows.MessageBox.Show(exception.Message, "Excel OpenXML basics", System.Windows.MessageBoxButton.OK, System.Windows.MessageBoxImage.Hand);
                }



                //return spreadSheet;
            }








            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




            return null;

        }


        private string GetExcelColumnName(int columnNumber)
        {
            int dividend = columnNumber;
            string columnName = String.Empty;
            int modulo;

            while (dividend > 0)
            {
                modulo = (dividend - 1) % 26;
                columnName = Convert.ToChar(65 + modulo).ToString() + columnName;
                dividend = (int)((dividend - modulo) / 26);
            }

            return columnName;
        }


        public static void InsertRow(WorksheetPart worksheetPart)
        {
            SheetData sheetData = worksheetPart.Worksheet.GetFirstChild<SheetData>();
            //Row lastRow = sheetData.Elements<Row>(). ;

            //for(int i=0; i<5; i++) {
            //    sheetData.InsertAfter(new Row() { RowIndex = (lastRow.RowIndex + 1) }, lastRow);
            //}
        }

        void Reemplaza(Worksheet ws, string tag, string texto)
        {
            Cell ce2 = ws.Elements<Cell>().Where(c => c.CellValue.ToString() == "#Numero#").First();
            ce2.CellValue = new CellValue(texto);

        }

        void ReemplazaRow(DocumentFormat.OpenXml.Spreadsheet.Row r, string tag, string texto)
        {

            Cell ce2 = r.Elements<Cell>().Where(c => c.CellValue.ToString() == tag).FirstOrDefault();
            ce2.CellValue = new CellValue(texto);

        }

        private static Row CreateRow(Row refRow, SheetData sheetData)
        {
            uint rowIndex = refRow.RowIndex.Value;
            uint newRowIndex;
            var newRow = (Row)refRow.Clone();

            /*IEnumerable<Row> rows = sheetData.Descendants<Row>().Where(r => r.RowIndex.Value >= rowIndex);
            foreach (Row row in rows)
            {
                newRowIndex = System.Convert.ToUInt32(row.RowIndex.Value + 1);

                foreach (Cell cell in row.Elements<Cell>())
                {
                    string cellReference = cell.CellReference.Value;
                    cell.CellReference = new StringValue(cellReference.Replace(row.RowIndex.Value.ToString(), newRowIndex.ToString()));
                }

                row.RowIndex = new UInt32Value(newRowIndex);
            }*/

            sheetData.InsertBefore(newRow, refRow);
            return newRow;
        }


        //Get a row to edit
        //Two modes: 
        //1)Insert mode : select-->copy-->move-->Insert
        //2)Update mode : select
        // http://social.msdn.microsoft.com/Forums/en-US/oxmlsdk/thread/65c9ca1c-25d4-482d-8eb3-91a3512bb0ac
        public static Row GetRow(uint rowIndex, WorksheetPart wrksheetPart) // ,ref RowMode Mod)
        {
            Worksheet worksheet = wrksheetPart.Worksheet;
            SheetData sheetData = worksheet.GetFirstChild<SheetData>();
            // If the worksheet does not contain a row with the specified row index, insert one.
            Row row = null;
            if (sheetData.Elements<Row>().Where(r => rowIndex == r.RowIndex).Count() != 0)
            {
                Row refRow = sheetData.Elements<Row>().Where(r => rowIndex == r.RowIndex).First();
                if ((refRow != null)) // && (Mod == RowMode.Insert))
                {
                    //Copy row from refRow and insert it
                    row = CopyToLine(refRow, rowIndex, sheetData);
                    //Update dataValidation (copy drop down list)
                    DataValidations dvs = worksheet.GetFirstChild<DataValidations>();
                    if (dvs != null)
                    {
                        foreach (DataValidation dv in dvs.Descendants<DataValidation>())
                        {
                            foreach (StringValue sv in dv.SequenceOfReferences.Items)
                            {
                                sv.Value = sv.Value.Replace(row.RowIndex.ToString(), refRow.RowIndex.ToString());
                            }
                        }
                    }
                }
                else if ((refRow != null)) // && (Mod == RowMode.Update))
                {
                    row = refRow;
                }
                else
                {
                    row = new Row() { RowIndex = rowIndex };
                    sheetData.Append(row);
                }
            }
            else
            {
                row = new Row() { RowIndex = rowIndex };
                sheetData.Append(row);
            }
            return row;
        }


        //Copy an existing row and insert it
        //We don't need to copy styles of a refRow because a CloneNode() or Clone() methods do it for us
        public static Row CopyToLine(Row refRow, uint rowIndex, SheetData sheetData)
        {
            uint newRowIndex;
            var newRow = (Row)refRow.CloneNode(true);
            // Loop through all the rows in the worksheet with higher row 
            // index values than the one you just added. For each one,
            // increment the existing row index.
            IEnumerable<Row> rows = sheetData.Descendants<Row>().Where(r => r.RowIndex.Value >= rowIndex);
            foreach (Row row in rows)
            {
                newRowIndex = System.Convert.ToUInt32(row.RowIndex.Value + 1);

                foreach (Cell cell in row.Elements<Cell>())
                {
                    // Update the references for reserved cells.
                    string cellReference = cell.CellReference.Value;
                    cell.CellReference = new StringValue(cellReference.Replace(row.RowIndex.Value.ToString(), newRowIndex.ToString()));
                }
                // Update the row index.
                row.RowIndex = new UInt32Value(newRowIndex);
            }

            sheetData.InsertBefore(newRow, refRow);
            return newRow;
        }





        public virtual ActionResult Firmar(int IdComprobante, int OrdenAutorizacion, int IdAutorizo) //(int id)
        {

            AutorizacionesPorComprobante1 a = new AutorizacionesPorComprobante1();

            a.IdComprobante = IdComprobante;

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));


            var dt2 = EntidadManager.ExecDinamico(SC, "SELECT * FROM _TempAutorizaciones WHERE IdComprobante=" + IdComprobante);




            OrdenAutorizacion = (from x in dt2.AsEnumerable()
                                 where ((int)x["IdFormulario"] == (int)EntidadManager.EnumFormularios.Comparativa &&
                                            (int)x["IdComprobante"] == (int)IdComprobante &&
                                               (int)x["IdAutoriza"] == (int)IdAutorizo)
                                 select (int)x["OrdenAutorizacion"]).FirstOrDefault();


            ObjectParameter o = new ObjectParameter("IdAutorizacionPorComprobante", typeof(int)); // el molestísimo output....



            db.AutorizacionesPorComprobante_A(o, (int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.Comparativa, IdComprobante,
                                                        OrdenAutorizacion, IdAutorizo, DateTime.Now, "SI");




            //db.AutorizacionesPorComprobante_A((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.Comparativa,   //@IdFormulario int,  
            //                                                IdComprobante,//                                                                        @IdComprobante int,
            //                                                     OrdenAutorizacion, //       @OrdenAutorizacion int,
            //                                                       IdAutorizo, //     @IdAutorizo int,
            //                                          DateTime.Now,           //    @FechaAutorizacion datetime,
            //                                                       "SI"     // @Visto varchar(2)
            //                                                      , o
            //                                            );

            //try
            //{
            //    // EntidadManager.Tarea(SC, "AutorizacionesPorComprobante_Generar");
            //    var dt = EntidadManager.GetStoreProcedure(SC, ProntoFuncionesGenerales.enumSPs.AutorizacionesPorComprobante_A,
            //                             Pronto.ERP.Bll.EntidadManager.EnumFormularios.Comparativa,   //@IdFormulario int,  
            //                                                IdComprobante,//                                                                        @IdComprobante int,
            //                                                     OrdenAutorizacion, //       @OrdenAutorizacion int,
            //                                                       IdAutorizo, //     @IdAutorizo int,
            //                                              (Int32)     3333,           //    @FechaAutorizacion datetime,
            //                                                       "SI"     // @Visto varchar(2)
            //                                            );

            //}
            //catch (Exception)
            //{

            //    //throw;
            //}



            try
            {
                // EntidadManager.Tarea(SC, "AutorizacionesPorComprobante_Generar");
                EntidadManager.GetStoreProcedure(SC, ProntoFuncionesGenerales.enumSPs.AutorizacionesPorComprobante_Generar);
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }



            return RedirectToAction("Index");





            // hasta simplificar y unificar la lógica de autorizaciones, hagamos así: 
            // si el usuario aparece en la lista de quienes firmaron, rajo.
            // dejo entonces que firme, aumentando en 1 el ordendeautorizacion anterior.


            var firmasesquema = (from c in db.Autorizaciones
                                 join d in db.DetalleAutorizaciones on c.IdAutorizacion equals d.IdAutorizacion
                                 where c.IdFormulario == (int)EntidadManager.EnumFormularios.Comparativa
                                 select d).ToList();


            var firmashechas = (from f in db.AutorizacionesPorComprobante1
                                where (f.IdFormulario == (int)EntidadManager.EnumFormularios.Comparativa &&
                                f.IdComprobante == IdComprobante)
                                select f).ToList();

            if (firmashechas.Select(x => x.IdAutorizo).Contains(IdAutorizo))
            {
                throw new Exception("El usuario " + IdAutorizo + " ya firmó antes este comprobante");
            }

            a.OrdenAutorizacion = (firmashechas.Select(x => x.OrdenAutorizacion).Max() ?? 0) + 1;





            //no puedo // ir a ver qué orden de autorizacion tienE?
            a.IdAutorizo = IdAutorizo;


            a.IdFormulario = (int)EntidadManager.EnumFormularios.Comparativa;
            a.FechaAutorizacion = DateTime.Now;

            db.AutorizacionesPorComprobante1.Add(a);
            db.SaveChanges();





            try
            {
                // EntidadManager.Tarea(SC, "AutorizacionesPorComprobante_Generar");
                var dt = EntidadManager.GetStoreProcedure(SC, ProntoFuncionesGenerales.enumSPs.AutorizacionesPorComprobante_Generar);

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }





            return RedirectToAction("Index");
        }


    }

}




namespace oxNameSpace
{
    public class ox
    {
        public void UpdateSheet()
        {
            UpdateCell("Chart.xlsx", "20", 2, "B");
            UpdateCell("Chart.xlsx", "80", 3, "B");
            UpdateCell("Chart.xlsx", "80", 2, "C");
            UpdateCell("Chart.xlsx", "20", 3, "C");

            ProcessStartInfo startInfo = new ProcessStartInfo("Chart.xlsx");
            startInfo.WindowStyle = ProcessWindowStyle.Normal;
            Process.Start(startInfo);
        }

        public static void UpdateCell(string docName, string text,
            uint rowIndex, string columnName)
        {
            // Open the document for editing.
            using (SpreadsheetDocument spreadSheet =
                     SpreadsheetDocument.Open(docName, true))
            {
                WorksheetPart worksheetPart =
                      GetWorksheetPartByName(spreadSheet, "Sheet1");

                if (worksheetPart != null)
                {
                    Cell cell = GetCell(worksheetPart.Worksheet,
                                             columnName, rowIndex);

                    cell.CellValue = new CellValue(text);
                    cell.DataType =
                        new EnumValue<CellValues>(CellValues.Number);

                    // Save the worksheet.
                    worksheetPart.Worksheet.Save();
                }
            }

        }

        public static void Cells(Worksheet ws, string text, int rowIndex, string columnName)
        {
            Cell cell;
            try
            {
                cell = GetCell(ws, columnName, (uint)rowIndex);

                if (ProntoMVC.Data.FuncionesGenericasCSharp.IsNumeric(text))
                {
                    try
                    {
                        text = text.Replace(",", ".");
                        double retNum;
                        Double.TryParse(Convert.ToString(text), System.Globalization.NumberStyles.Float, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);

                        cell.CellValue = new CellValue(retNum.ToString("0.00", CultureInfo.InvariantCulture));
                        cell.DataType = new EnumValue<CellValues>(CellValues.Number); // CellValues.String //CellValues.Number
                    }
                    catch (Exception)
                    {

                        throw;
                    }

                }
                else
                {
                    cell.CellValue = new CellValue(text);
                    cell.DataType = new EnumValue<CellValues>(CellValues.String); // CellValues.String //CellValues.Number
                }

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }


        }

        public static void Cells(Worksheet ws, string text, int rowIndex, int column)
        {

            Cells(ws, text, rowIndex, GetExcelColumnName(column));

        }



        private static string GetExcelColumnName(int columnNumber)
        {
            int dividend = columnNumber;
            string columnName = String.Empty;
            int modulo;

            while (dividend > 0)
            {
                modulo = (dividend - 1) % 26;
                columnName = Convert.ToChar(65 + modulo).ToString() + columnName;
                dividend = (int)((dividend - modulo) / 26);
            }

            return columnName;
        }


        public static WorksheetPart
             GetWorksheetPartByName(SpreadsheetDocument document,
             string sheetName)
        {
            IEnumerable<Sheet> sheets =
               document.WorkbookPart.Workbook.GetFirstChild<Sheets>().
               Elements<Sheet>().Where(s => s.Name == sheetName);

            if (sheets.Count() == 0)
            {
                // The specified worksheet does not exist.

                return null;
            }

            string relationshipId = sheets.First().Id.Value;
            WorksheetPart worksheetPart = (WorksheetPart)
                 document.WorkbookPart.GetPartById(relationshipId);
            return worksheetPart;

        }

        // Given a worksheet, a column name, and a row index, 
        // gets the cell at the specified column and 
        private static Cell GetCell(Worksheet worksheet,
                  string columnName, uint rowIndex)
        {
            Row row = GetRow(worksheet, rowIndex);

            if (row == null)
                return null;

            Cell ce = row.Elements<Cell>().Where(c => string.Compare
                   (c.CellReference.Value, columnName +
                   rowIndex, true) == 0).FirstOrDefault();

            // if (ce == null) ce = InsertCellInWorksheet(columnName, rowIndex, worksheet);

            return ce;
        }


        // Given a worksheet and a row index, return the row.
        private static Row GetRow(Worksheet worksheet, uint rowIndex)
        {
            return worksheet.GetFirstChild<SheetData>().
              Elements<Row>().Where(r => r.RowIndex == rowIndex).First();
        }




        // Given a column name, a row index, and a WorksheetPart, inserts a cell into the worksheet. 
        // If the cell already exists, returns it. 
        private static Cell InsertCellInWorksheet(string columnName, uint rowIndex, Worksheet worksheet)
        {

            SheetData sheetData = worksheet.GetFirstChild<SheetData>();
            string cellReference = columnName + rowIndex;

            // If the worksheet does not contain a row with the specified row index, insert one.
            Row row;
            if (sheetData.Elements<Row>().Where(r => r.RowIndex == rowIndex).Count() != 0)
            {
                row = sheetData.Elements<Row>().Where(r => r.RowIndex == rowIndex).First();
            }
            else
            {
                row = new Row() { RowIndex = rowIndex };
                sheetData.Append(row);
            }

            // If there is not a cell with the specified column name, insert one.  
            if (row.Elements<Cell>().Where(c => c.CellReference.Value == columnName + rowIndex).Count() > 0)
            {
                return row.Elements<Cell>().Where(c => c.CellReference.Value == cellReference).First();
            }
            else
            {
                // Cells must be in sequential order according to CellReference. Determine where to insert the new cell.
                Cell refCell = null;
                foreach (Cell cell in row.Elements<Cell>())
                {
                    if (string.Compare(cell.CellReference.Value, cellReference, true) > 0)
                    {
                        refCell = cell;
                        break;
                    }
                }

                Cell newCell = new Cell() { CellReference = cellReference };
                row.InsertBefore(newCell, refCell);

                worksheet.Save();
                return newCell;
            }
        }


    }
}