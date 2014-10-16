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
using ProntoMVC.Data.Models; using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Text;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
using System.Reflection;
using System.Configuration;
using Pronto.ERP.Bll;
using Trirand.Web.Mvc;
using jqGrid.Models;



namespace ProntoMVC.Controllers
{
    public partial class ClienteController : ProntoBaseController
    {


        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////
        //este es el indice que se usa para la grilla html como se ve en el Index de Sectores
        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var clientes = db.Clientes
                .OrderBy(s => s.RazonSocial)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Clientes.Count() / pageSize);

            return View(clientes);
        }

        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////
        //este es el indice que se usa para la grilla de Jquery como se ve en el Index de Clientes
        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////

        public virtual ActionResult Clientes(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString,
                                         string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.Clientes.AsQueryable();
            //if (IdObra != string.Empty)
            //{
            //    int IdObra1 = Convert.ToInt32(IdObra);
            //    Fac = (from a in Fac where a.IdObra == IdObra1 select a).AsQueryable();
            //}
            //if (FechaInicial != string.Empty)
            //{
            //    DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            //    DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            //    Fac = (from a in Fac where a.FechaCliente >= FechaDesde && a.FechaCliente <= FechaHasta select a).AsQueryable();
            //}
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numeroCliente":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaCliente":
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

            var Req1 = (from a in Fac
                        select new
                        {
                            IdCliente = a.IdCliente,
                            NumeroCliente = a.RazonSocial,
                            FechaCliente = a.FechaModifico,
                            //NumeroObra=a.Obra.NumeroObra,
                            //Libero=a.Empleados.Nombre,
                            //Aprobo = a.Empleados1.Nombre,
                            //Sector=a.Sectores.Descripcion,
                            //Detalle=a.Detalle
                        }).Where(campo).ToList();

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            //switch (sidx.ToLower())
            //{
            //    case "numeroCliente":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroCliente);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroCliente);
            //        break;
            //    case "fechaCliente":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.FechaCliente);
            //        else
            //            Fac = Fac.OrderBy(a => a.FechaCliente);
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
            //            Fac = Fac.OrderByDescending(a => a.NumeroCliente);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroCliente);
            //        break;
            //}

            var data = (from a in Fac
                        //join c in db.Clientes on a.IdCliente equals c.IdCliente
                        select a).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdCliente.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdCliente} )  +" target='_blank' >Editar</>" +
                                "|" +
                                "<a href=/Cliente/Details/" + a.IdCliente + ">Detalles</a> ",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdCliente} )  +">Imprimir</>" ,
                                a.IdCliente.ToString(),
                                //(a.TipoABC ?? string.Empty).ToString(),
                                //(a.PuntoVenta ?? 0).ToString(),
                                a.RazonSocial,
                                //(a.FechaCliente ?? DateTime.MinValue).ToString(),
                                ////a.FechaCliente.ToString(),
                                //(a.Clientes==null ? string.Empty : a.Clientes.RazonSocial ).ToString(),
                                //(a.IdCliente ?? 0).ToString(),
                                //(a.ImporteTotal ?? 0).ToString(),
                                //a.ImporteTotal.ToString()
                                //a.NumeroObra, 
                                //a.Libero,
                                //a.Aprobo,
                                //a.Sector,
                                //a.Detalle
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }








        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////
        //este es el indice que se usa para la grilla de Jquery como se ve en el Index de IngresoBrutos
        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////

        public virtual ActionResult Listado_jqGrid(string sidx, string sord, int? page, int? rows,
                                         bool _search, string searchField, string searchOper, string searchString,
                                         string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.Clientes.AsQueryable();
            //if (IdObra != string.Empty)
            //{
            //    int IdObra1 = Convert.ToInt32(IdObra);
            //    Fac = (from a in Fac where a.IdObra == IdObra1 select a).AsQueryable();
            //}
            //if (FechaInicial != string.Empty)
            //{
            //    DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            //    DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            //    Fac = (from a in Fac where a.FechaCliente >= FechaDesde && a.FechaCliente <= FechaHasta select a).AsQueryable();
            //}
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numeroCliente":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaCliente":
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

            var Req1 = (from a in Fac
                        select new
                        {
                            IdIBCondicion = a.IdCliente,
                            //FechaCliente = ,
                            //NumeroObra=a.Obra.NumeroObra,
                            //Libero=a.Empleados.Nombre,
                            //Aprobo = a.Empleados1.Nombre,
                            //Sector=a.Sectores.Descripcion,
                            //Detalle=a.Detalle
                        }).Where(campo).ToList();

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            //switch (sidx.ToLower())
            //{
            //    case "numeroCliente":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroCliente);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroCliente);
            //        break;
            //    case "fechaCliente":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.FechaCliente);
            //        else
            //            Fac = Fac.OrderBy(a => a.FechaCliente);
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
            //            Fac = Fac.OrderByDescending(a => a.NumeroCliente);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroCliente);
            //        break;
            //}

            var data = (from a in Fac
                        //join c in db.IngresoBrutos on a.IdIBCondicion equals c.IdIBCondicion
                        select a).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdCliente.ToString(),
                            cell = new string[] { 
                                
                                "<a href="+ Url.Action("Edit",new {id = a.IdCliente} )  +" target='_blank' >Editar</>" 
                                ,
                                a.IdCliente.NullSafeToString(),

                                a.RazonSocial.NullSafeToString(),
                                a.Codigo.NullSafeToString(),
                                a.Direccion.NullSafeToString(),                                
                                (a.Localidad==null ? string.Empty : a.Localidad.Nombre ).ToString(),
                                a.CodigoPostal.NullSafeToString(),
                                 (a.Provincia==null ? string.Empty : a.Provincia.Nombre ).ToString(),
                                 (a.Pais==null ? string.Empty : a.Pais.Descripcion ).ToString(),
                                a.Telefono.NullSafeToString(),
                                
                                a.Fax.NullSafeToString(),
                                a.Email,a.Cuit,
                                (a.DescripcionIva==null ? string.Empty : a.DescripcionIva.Descripcion ).ToString(), //espantoso
                                a.FechaAlta.NullSafeToString(),a.Contacto,a.DireccionEntrega
                                ,(a.LocalidadEntrega==null ? string.Empty : a.LocalidadEntrega.Nombre ).ToString(), //espantoso
                                (a.ProvinciaEntrega==null ? string.Empty : a.ProvinciaEntrega.Nombre ).ToString(), //espantoso
                                a.CodigoPresto,

                                (a.Vendedor==null ? string.Empty : a.Vendedor.Nombre ).ToString(), //espantoso
                                (a.VendedorCobrador==null ? string.Empty : a.VendedorCobrador.Nombre ).ToString(), //espantoso
                                (a.Estados_Proveedores==null ? string.Empty : a.Estados_Proveedores.Descripcion ).ToString(), //espantoso
                                a.NombreFantasia.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.IdUsuarioIngreso.NullSafeToString(),
                                a.FechaIngreso.NullSafeToString(),
                                a.IdUsuarioModifico.NullSafeToString(),
                                a.FechaModifico.NullSafeToString(),
                                // CondIIBB harcodea usando  IBCondicion
                            // IBCondiciones.Descripcion as [Cat.IIBB],  este usa la descricion el IdIBcondicionpordefecto
                                DescripcionIIBB(a.IBCondicion),
                                
                                
                                
                                  (a.IBCondicione==null ? string.Empty : a.IBCondicione.Descripcion ).ToString(), //espantoso
                                  a.IBNumeroInscripcion,
                                  (a.Cuenta==null ? string.Empty : a.Cuenta.Descripcion ).ToString(), //espantoso
                                  (a.CuentaMonedaExt==null ? string.Empty : a.CuentaMonedaExt.Descripcion ).ToString(), //espantoso
                              
 
                                
                            
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////



        //public string iisNull()
        //{

        //}




        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////
        //este es el indice que se usa para la grilla de Jquery como se ve en el Index de IngresoBrutos
        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////

        public virtual ActionResult Listado_jqGrid_Resumido(string sidx, string sord, int? page, int? rows,
                                         bool _search, string searchField, string searchOper, string searchString,
                                         string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.Clientes.AsQueryable();
            //if (IdObra != string.Empty)
            //{
            //    int IdObra1 = Convert.ToInt32(IdObra);
            //    Fac = (from a in Fac where a.IdObra == IdObra1 select a).AsQueryable();
            //}
            //if (FechaInicial != string.Empty)
            //{
            //    DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            //    DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            //    Fac = (from a in Fac where a.FechaCliente >= FechaDesde && a.FechaCliente <= FechaHasta select a).AsQueryable();
            //}
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numeroCliente":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaCliente":
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

            var Req1 = (from a in Fac
                        select new
                        {
                            IdIBCondicion = a.IdCliente,
                            //FechaCliente = ,
                            //NumeroObra=a.Obra.NumeroObra,
                            //Libero=a.Empleados.Nombre,
                            //Aprobo = a.Empleados1.Nombre,
                            //Sector=a.Sectores.Descripcion,
                            //Detalle=a.Detalle
                        }).Where(campo).ToList();

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            //switch (sidx.ToLower())
            //{
            //    case "numeroCliente":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroCliente);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroCliente);
            //        break;
            //    case "fechaCliente":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.FechaCliente);
            //        else
            //            Fac = Fac.OrderBy(a => a.FechaCliente);
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
            //            Fac = Fac.OrderByDescending(a => a.NumeroCliente);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroCliente);
            //        break;
            //}

            var data = (from a in Fac
                        //join c in db.IngresoBrutos on a.IdIBCondicion equals c.IdIBCondicion
                        select a).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdCliente.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdCliente} )  +" target='_blank' >Editar</>" 
                        /*        a.IdCliente.ToString(),


                                'Acciones', 'IdCliente', 
                        'Razon Social', 
                        'Codigo', 
                        'Direccion', 
                        'CodigoPostal', 
                        'Telefono', 
                        'Email', 
                        'Cuit',
                        'Codigo PRESTO'

                        */

                          
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }




        public virtual JsonResult GetCodigosClienteAutocomplete(string term)
        {
            return Json((from item in db.Clientes.Include(c => c.IBCondicionCat1).Include(c => c.IBCondicionCat2).Include(c => c.IBCondicionCat3)
                         where item.RazonSocial.StartsWith(term) || item.Codigo.StartsWith(term)
                         orderby item.RazonSocial
                         select new
                         {
                             id = item.IdCliente,
                             value = item.RazonSocial,
                             codigo = item.Codigo,

                             /////////////////////////////
                             idCodigoIva = item.IdCodigoIva,

                             //////////////////////////////////////////
                             IdIBCondicionPorDefecto = item.IdIBCondicionPorDefecto,
                             IdIBCondicionPorDefecto2 = item.IdIBCondicionPorDefecto2,
                             IdIBCondicionPorDefecto3 = item.IdIBCondicionPorDefecto3,
                             AlicuotaPercepcion1 = (item.IBCondicionCat1).AlicuotaPercepcion,
                             AlicuotaPercepcion2 = (item.IBCondicionCat2 ).AlicuotaPercepcion,
                             AlicuotaPercepcion3 = (item.IBCondicionCat3 ).AlicuotaPercepcion,
                             ///////////////////////////////////////


                             Email = item.Email,
                             Direccion = item.Direccion,

                             Localidad = item.Localidad.Nombre,
                             Provincia = item.Provincia.Nombre,

                             Telefono = item.Telefono,
                             Fax = item.Fax,
                             Cuit = item.Cuit,
                             IdCondicionVenta = item.IdCondicionVenta,
                             IdListaPrecios = item.IdListaPrecios,

                             item.EsAgenteRetencionIVA,
                             item.BaseMinimaParaPercepcionIVA,
                             item.PorcentajePercepcionIVA
                             // letra = EntidadManager.LetraSegunTipoIVA((long)item.IdCodigoIva)
                         }).Take(10).ToList(), JsonRequestBehavior.AllowGet);
        }


        //public JsonResult GetPuntosVenta(string letra)
        //{
        //    return Json((from item in db.PuntosVentas
        //                 //where item.RazonSocial.StartsWith(term)
        //                 //orderby item.RazonSocial
        //                 select new
        //                 {
        //                     id = item.IdPuntoVenta,
        //                     value = item.PuntoVenta,
        //                     proxnumero = item.ProximoNumero
        //                     // letra = EntidadManager.LetraSegunTipoIVA((long)item.IdCodigoIva)
        //                 }).Take(10).ToList(), JsonRequestBehavior.AllowGet);
        //}


        public virtual JsonResult GetPuntosVenta(long IdCodigoIva)
        {
            string letra = EntidadManager.LetraSegunTipoIVA((long)IdCodigoIva);

            return Json((from item in db.PuntosVentas
                         where (item.Letra == letra) // item.RazonSocial.StartsWith(term)
                            && item.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Factura
                         //orderby item.RazonSocial
                         select new
                         {
                             id = item.IdPuntoVenta,
                             value = item.PuntoVenta,
                             proxnumero = item.ProximoNumero
                             // letra = EntidadManager.LetraSegunTipoIVA((long)item.IdCodigoIva)
                         }).Take(10).ToList(), JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult PuntosVenta(int IdCodigoIva, int PuntoVenta)
        {
            string letra = EntidadManager.LetraSegunTipoIVA((long)IdCodigoIva);

            var q = (from item in db.PuntosVentas
                     where item.Letra == letra && item.PuntoVenta == PuntoVenta
                            && item.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Factura
                     //orderby item.RazonSocial
                     select new
                     {
                         id = item.IdPuntoVenta,
                         value = item.PuntoVenta,
                         proxnumero = item.ProximoNumero,
                         letra = item.Letra
                         // letra = EntidadsManager.LetraSegunTipoIVA((long)item.IdCodigoIva)
                     }).ToList();

            return Json(q, JsonRequestBehavior.AllowGet);


        }







        //
        // GET: /Cliente/Details/5

        public virtual ViewResult Details(int id)
        {
            Cliente Cliente = db.Clientes.Find(id);
            return View(Cliente);
        }



        //
        // GET: /Cliente/Edit/5

        public virtual ActionResult Edit(int id)
        {


            Cliente o;
            if (id <= 0)
            {
                o = new Cliente();
            }
            else
            {
                o = db.Clientes
                        .Include(x => x.Cuenta).Include(x => x.CuentaMonedaExt)
                        .Include(x => x.Localidad).Include(x => x.LocalidadEntrega)
                        .SingleOrDefault(x => x.IdCliente == id);

            }
            CargarViewBag(o);

            // o.grilla = new DetalleClientesJqGridModel();


            return View(o);
        }


        void CargarViewBag(Cliente o)
        {
            ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion", o.IdCodigoIva);
            ViewBag.IdEstado = new SelectList(db.Estados_Proveedores, "IdEstado", "Descripcion", o.IdEstado);
            ViewBag.IdProvincia = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvincia);
            ViewBag.IdLocalidad = new SelectList(db.Localidades, "IdLocalidad", "Nombre", o.IdLocalidad);
            ViewBag.IdPais = new SelectList(db.Paises, "IdPais", "Descripcion", o.IdPais);
            ViewBag.Vendedor1 = new SelectList(db.Vendedores, "IdVendedor", "Nombre", o.Vendedor1);
            ViewBag.Cobrador = new SelectList(db.Vendedores, "IdVendedor", "Nombre", o.Cobrador);
            ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", o.IdCodigoIva);
            ViewBag.IdListaPrecios = new SelectList(db.ListasPrecios, "IdListaPrecios", "Descripcion", o.IdListaPrecios);
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdCondicionVenta = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionVenta);
            ViewBag.IdBancoDebito = new SelectList(db.Bancos, "IdBanco", "Nombre", o.IdBancoDebito);
            ViewBag.IdBancoGestionador = new SelectList(db.Bancos, "IdBanco", "Nombre", o.IdBancoGestionador);
            ViewBag.IGCondicion = new SelectList(db.IGCondiciones, "IdIGCondicion", "Descripcion", o.IGCondicion);
            ViewBag.IdIBCondicionPorDefecto = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicionPorDefecto);
            ViewBag.IdIBCondicionPorDefecto2 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicionPorDefecto2);
            ViewBag.IdIBCondicionPorDefecto3 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicionPorDefecto3);
            ViewBag.IdProvinciaEntrega = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvinciaEntrega);
            ViewBag.IdLocalidadEntrega = new SelectList(db.Localidades, "IdLocalidad", "Nombre", o.IdLocalidadEntrega);
        }


        //
        // POST: /Cliente/Edit/5

        //[HttpPost]
        //public ActionResult Edit(Cliente o)
        //{

        //    if (ModelState.IsValid)
        //    {

        //        //    if (o.IdCliente <= 0)
        //        //    {
        //        //        db.Clientes.Add(o);
        //        //        db.SaveChanges();
        //        //        return RedirectToAction("Index");
        //        //    }
        //        //    else
        //        //    {
        //        //        db.Entry(o).State = System.Data.Entity.EntityState.Modified;
        //        //        db.SaveChanges();
        //        // return RedirectToAction("Index");
        //        //    }
        //    }
        //    else
        //    {
        //        // el IsValid se quejaba en las altas     
        //        // http://stackoverflow.com/questions/2397563/asp-net-mvc-modelstate-isvalid-is-false-how-to-bypass
        //        // Try:
        //        //public ActionResult CreateCustomer([Bind(Exclude = "Id")]GWCustomer customer)
        //        //This will exclude Id from binding and validation.

        //        var allErrors = ModelState.Values.SelectMany(v => v.Errors);
        //        var mensajes = string.Join("; ", from i in allErrors select (i.ErrorMessage + (i.Exception == null ? "" : i.Exception.Message)));

        //        ViewBag.Errores = mensajes;

        //    }

        //    CargarViewBag(o);
        //    return View(o);
        //}

        //


        public string DescripcionIIBB(int? IdIBCondicion)
        {

            // no tiene mas sentido que ponga esto en una tabla aparte? estas son las modalidades.

            //           Case When IsNull(Clientes.IBCondicion,0)=1 Then 'Exento'  
            //When IsNull(Clientes.IBCondicion,0)=2 Then 'Inscr.Multi'  
            //When IsNull(Clientes.IBCondicion,0)=3 Then 'Inscr.local'  
            //When IsNull(Clientes.IBCondicion,0)=4 Then 'No alcanzado'  
            //Else ''  

            return "Exento";
        }


        // GET: /Cliente/Delete/5
        public virtual ActionResult Delete(int id)
        {
            Cliente Cliente = db.Clientes.Find(id);
            return View(Cliente);
        }

        //
        // POST: /Cliente/Delete/5

        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Cliente Cliente = db.Clientes.Find(id);
            db.Clientes.Remove(Cliente);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);

        }











        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////





        public virtual ActionResult _GrillaContactos(int id)
        {
            // Get the model (setup) of the grid defined in the /Models folder.
            var gridModel = new Models.DetalleClientesJqGridModel();
            var DetalleClientesGrid = gridModel.DetalleClientesGrid;

            // customize the default DetalleClientes grid model with custom settings
            // NOTE: you need to call this method in the action that fetches the data as well,
            // so that the models match
            SetUpGrid(DetalleClientesGrid);

            // Pass the custmomized grid model to the View
            return PartialView(gridModel);
        }




        // This method is called when the grid requests data
        public virtual JsonResult SearchGridDataRequested()
        {
            // Get both the grid Model and the data Model
            // The data model in our case is an autogenerated linq2sql database based on Northwind.
            var gridModel = new ProntoMVC.Models.DetalleClientesJqGridModel();
            // var northWindModel = new NorthwindDataContext();

            // customize the default DetalleClientes grid model with our custom settings
            SetUpGrid(gridModel.DetalleClientesGrid);


            // return the result of the DataBind method, passing the datasource as a parameter
            // jqGrid for ASP.NET MVC automatically takes care of paging, sorting, filtering/searching, etc
            int id = 1;  // ViewBag.IdCliente;
            return gridModel.DetalleClientesGrid.DataBind(db.DetalleClientes.Where(x => x.IdCliente == id));
        }


        void LlenarModeloGrillaConDetalle()
        {




        }






        public virtual ActionResult EditRows(ProntoMVC.Data.Models.DetalleCliente editedOrder)
        {
            // Get the grid and database (northwind) models
            var gridModel = new Models.DetalleClientesJqGridModel();
            // var northWindModel = new NorthwindDataContext();

            // If we are in "Edit" mode
            if (gridModel.DetalleClientesGrid.AjaxCallBackMode == AjaxCallBackMode.EditRow)
            {
                // Get the data from and find the Order corresponding to the edited row
                ProntoMVC.Data.Models.DetalleCliente order = (from o in db.DetalleClientes
                                               where o.IdDetalleCliente == editedOrder.IdDetalleCliente
                                               select o).First<ProntoMVC.Data.Models.DetalleCliente>();

                // update the Order information
                order.Contacto = editedOrder.Contacto;
                order.IdCliente = 1; // editedOrder.IdCliente;
                order.Email = editedOrder.Email;
                order.Puesto = editedOrder.Puesto;

                db.SaveChanges();


            }
            // add
            if (gridModel.DetalleClientesGrid.AjaxCallBackMode == AjaxCallBackMode.AddRow)
            {
                // since we are adding a new Order, create a new istance
                ProntoMVC.Data.Models.DetalleCliente order = new ProntoMVC.Data.Models.DetalleCliente();
                // set the new Order information
                order.IdDetalleCliente = (from o in db.DetalleClientes
                                          select o)
                                .Max<ProntoMVC.Data.Models.DetalleCliente>(o => o.IdDetalleCliente) + 1;

                order.Contacto = editedOrder.Contacto;
                order.IdCliente = 1;  // editedOrder.IdCliente;
                order.Email = editedOrder.Email;
                order.Puesto = editedOrder.Puesto;

                db.DetalleClientes.Add(order);
                db.SaveChanges();

                List<ProntoMVC.Data.Models.DetalleCliente> lista = ViewBag.GrillaBag;
                if (lista == null) lista = new List<ProntoMVC.Data.Models.DetalleCliente>();
                lista.Add(order);
                ViewBag.GrillaBag = lista;
            }
            //borrar
            if (gridModel.DetalleClientesGrid.AjaxCallBackMode == AjaxCallBackMode.DeleteRow)
            {
                ProntoMVC.Data.Models.DetalleCliente order = (from o in db.DetalleClientes
                                               where o.IdDetalleCliente == editedOrder.IdDetalleCliente
                                               select o)
                               .First<ProntoMVC.Data.Models.DetalleCliente>();

                // delete the record                
                db.DetalleClientes.Remove(order);
                db.SaveChanges();
            }

            return RedirectToAction("_GrillaContactos", new { id = 1 }); // ViewBag.IdCliente });
        }

        private void SetUpGrid(JQGrid DetalleClientesGrid)
        {
            // al principio se la llama dos veces seguidas, desde _GrillaContactos() y SearchGridDataRequested()
            // NOTE: you need to call this method in the action that fetches the data as well,
            // so that the models match

            // Customize/change some of the default settings for this model
            // ID is a mandatory field. Must by unique if you have several grids on one page.
            DetalleClientesGrid.ID = "DetalleClientesGrid";
            // Setting the DataUrl to an action (method) in the controller is required.
            // This action will return the data needed by the grid
            DetalleClientesGrid.DataUrl = Url.Action("SearchGridDataRequested");
            DetalleClientesGrid.EditUrl = Url.Action("EditRows");
            // show the search toolbar
            DetalleClientesGrid.ToolBarSettings.ShowSearchToolBar = true;
            DetalleClientesGrid.Columns.Find(c => c.DataField == "IdDetalleCliente").Searchable = false;
            // DetalleClientesGrid.Columns.Find(c => c.DataField == "FechaVigencia").Searchable = false;

            SetUpCustomerIDSearchDropDown(DetalleClientesGrid);
            SetUpFreightSearchDropDown(DetalleClientesGrid);
            SetShipNameSearchDropDown(DetalleClientesGrid);

            DetalleClientesGrid.ToolBarSettings.ShowEditButton = true;
            DetalleClientesGrid.ToolBarSettings.ShowAddButton = true;
            DetalleClientesGrid.ToolBarSettings.ShowDeleteButton = true;
            DetalleClientesGrid.EditDialogSettings.CloseAfterEditing = true;
            DetalleClientesGrid.AddDialogSettings.CloseAfterAdding = true;

            // setup the dropdown values for the CustomerID editing dropdown
            SetUpCustomerIDEditDropDown(DetalleClientesGrid);
        }

        private void SetUpCustomerIDSearchDropDown(JQGrid DetalleClientesGrid)
        {
            // setup the grid search criteria for the columns
            JQGridColumn customersColumn = DetalleClientesGrid.Columns.Find(c => c.DataField == "IdDetalleCliente");
            customersColumn.Searchable = true;

            // DataType must be set in order to use searching
            customersColumn.DataType = typeof(string);
            customersColumn.SearchToolBarOperation = SearchOperation.IsEqualTo;
            customersColumn.SearchType = SearchType.DropDown;

            // Populate the search dropdown only on initial request, in order to optimize performance
            if (DetalleClientesGrid.AjaxCallBackMode == AjaxCallBackMode.RequestData)
            {
                // var northWindModel = new NorthwindDataContext();
                // http://stackoverflow.com/questions/10110266/why-linq-to-entities-does-not-recognize-the-method-system-string-tostring

                var searchList = (from customers in db.DetalleClientes
                                  select customers.IdDetalleCliente)
                                  .AsEnumerable()
                                  .Select(x => new SelectListItem { Text = x.ToString(), Value = x.ToString() });





                customersColumn.SearchList = searchList.ToList<SelectListItem>();
                customersColumn.SearchList.Insert(0, new SelectListItem { Text = "All", Value = "" });
            }
        }

        private void SetUpFreightSearchDropDown(JQGrid DetalleClientesGrid)
        {
            // setup the grid search criteria for the columns
            JQGridColumn freightColumn = DetalleClientesGrid.Columns.Find(c => c.DataField == "Contacto");
            freightColumn.Searchable = true;

            // DataType must be set in order to use searching
            freightColumn.DataType = typeof(decimal);
            freightColumn.SearchToolBarOperation = SearchOperation.IsGreaterOrEqualTo;
            freightColumn.SearchType = SearchType.DropDown;

            // Populate the search dropdown only on initial request, in order to optimize performance
            if (DetalleClientesGrid.AjaxCallBackMode == AjaxCallBackMode.RequestData)
            {
                List<SelectListItem> searchList = new List<SelectListItem>();
                searchList.Add(new SelectListItem { Text = "> 10", Value = "10" });
                searchList.Add(new SelectListItem { Text = "> 30", Value = "30" });
                searchList.Add(new SelectListItem { Text = "> 50", Value = "50" });
                searchList.Add(new SelectListItem { Text = "> 100", Value = "100" });

                freightColumn.SearchList = searchList.ToList<SelectListItem>();
                freightColumn.SearchList.Insert(0, new SelectListItem { Text = "All", Value = "" });
            }
        }

        private void SetShipNameSearchDropDown(JQGrid DetalleClientesGrid)
        {
            JQGridColumn freightColumn = DetalleClientesGrid.Columns.Find(c => c.DataField == "Contacto");
            freightColumn.Searchable = true;
            freightColumn.DataType = typeof(string);
            freightColumn.SearchToolBarOperation = SearchOperation.Contains;
            freightColumn.SearchType = SearchType.TextBox;
        }

        private void SetUpCustomerIDEditDropDown(JQGrid DetalleClientesGrid)
        {
            // setup the grid search criteria for the columns
            JQGridColumn customersColumn = DetalleClientesGrid.Columns.Find(c => c.DataField == "Contacto");
            customersColumn.Editable = true;
            customersColumn.EditType = EditType.DropDown;

            // Populate the search dropdown only on initial request, in order to optimize performance
            if (DetalleClientesGrid.AjaxCallBackMode == AjaxCallBackMode.RequestData)
            {

                // var northWindModel = new NorthwindDataContext();

                var editList = (from customers in db.DetalleClientes
                                select customers.IdDetalleCliente)
                               .AsEnumerable()
                               .Select(x => new SelectListItem { Text = x.ToString(), Value = x.ToString() });


                customersColumn.EditList = editList.ToList<SelectListItem>();
            }
        }








        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////

        [AcceptVerbs(HttpVerbs.Post)]
        public virtual ActionResult OrderDetailsSubgrid(int id)
        {
            JqGridResponse response = new JqGridResponse(true);
            response.Records.AddRange(from orderDetails in db.DetalleClientes.Where(x => x.IdCliente == id)
                                      select new JqGridRecord<OrderDetailViewModel>(null, new OrderDetailViewModel(orderDetails)));

            return new JqGridJsonResult() { Data = response };
        }







        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////             JQGRID            ///////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////



        public virtual ActionResult DetLugaresEntrega(string sidx, string sord, int? page, int? rows, int? IdPresupuesto)
        {
            int IdPresupuesto1 = IdPresupuesto ?? 0;
            var DetEntidad = db.DetalleClientesLugaresEntregas.Where(p => p.IdCliente == IdPresupuesto1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select new
                        {
                            a.IdDetalleClienteLugarEntrega,
                            a.DireccionEntrega,
                            a.IdLocalidadEntrega,  // ojooooooooo, no uses a.Localidad.IdLocalidad, usá a.IdLocalidadEntrega (porque en el post no se va a hacer bien el bind!!!)
                            Localidad = a.Localidad.Nombre,
                            a.IdProvinciaEntrega,
                            Provincia = a.Provincia.Nombre
                        }).OrderBy(p => p.IdDetalleClienteLugarEntrega).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleClienteLugarEntrega.ToString(),
                            cell = new string[] { 
                                string.Empty,  // guarda con este espacio vacio
                                a.IdDetalleClienteLugarEntrega.ToString(), 
                                a.DireccionEntrega.NullSafeToString(), 
                                a.IdLocalidadEntrega.NullSafeToString(),
                                a.Localidad.ToString(),
                                a.IdProvinciaEntrega.NullSafeToString(),
                                a.Provincia.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
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




        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////

        public virtual ActionResult DetContactos(string sidx, string sord, int? page, int? rows, int? IdPresupuesto)
        {
            int IdPresupuesto1 = IdPresupuesto ?? 0;
            var DetEntidad = db.DetalleClientes.Where(p => p.IdCliente == IdPresupuesto1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select new
                        {
                            a.IdDetalleCliente,
                            a.Contacto,
                            a.Email,
                            a.Puesto,
                            a.Telefono
                        }).OrderBy(p => p.IdDetalleCliente).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleCliente.ToString(),
                            cell = new string[] { 
                                string.Empty, // guarda con este espacio vacio
                                a.IdDetalleCliente.ToString(), 
                                a.Contacto.NullSafeToString(),
                                a.Puesto.NullSafeToString(),
                                a.Telefono.NullSafeToString(),
                                a.Email.NullSafeToString() 
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }



        [HttpPost]
        public void EditGridDataContactos(int? IdRequerimiento, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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



        private bool Validar(ProntoMVC.Data.Models.Cliente o, ref string sErrorMsg)
        {
            // una opcion es extender el modelo autogenerado, para ensoquetar ahí las validaciones
            // si no, podemos usar una funcion como esta, y devolver los  errores de dos maneras:
            // con ModelState.AddModelError si los devolvemos en una ViewResult,
            // o con un array de strings si es una JsonResult.
            //
            // If you are returning JSON, you cannot use ModelState.
            // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json

            if (o.CodigoCliente.NullSafeToString() == "")
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta el codigo de cliente";
                // return false;
            }
            if (o.RazonSocial.NullSafeToString() == "") sErrorMsg += "\n" + "Falta la razon social";
            if (o.TipoCliente.NullSafeToString() == "") sErrorMsg += "\n" + "Falta el tipo de cliente";
            if (o.Direccion.NullSafeToString() == "") sErrorMsg += "\n" + "Falta la dirección";
            if (o.IdCodigoIva == null) sErrorMsg += "\n" + "Falta el codigo de IVA";
            if (o.IdProvincia == null) sErrorMsg += "\n" + "Falta la provincia";
            if (o.IdPais == null) sErrorMsg += "\n" + "Falta el país";
            if (o.IdCondicionVenta == null) sErrorMsg += "\n" + "Falta la condicion venta";
            if (o.IGCondicion == null) sErrorMsg += "\n" + "Falta la condicion ganacias";
            if (o.IdListaPrecios == null) sErrorMsg += "\n" + "Falta la lista de precios";
            if (o.IdCuentaMonedaExt == null) sErrorMsg += "\n" + "Falta la cuenta contable en moneda extranjera";
            if (o.IdCuenta == null) sErrorMsg += "\n" + "Falta la cuenta contable";
            if (o.Vendedor1 == null) sErrorMsg += "\n" + "Falta el vendedor";
            if (o.IdEstado == null) sErrorMsg += "\n" + "Falta el estado";
            if (sErrorMsg != "") return false;


            return true;

        }



        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////


        [HttpPost]
        public virtual JsonResult BatchUpdate([Bind(Exclude = "IdDetalleCliente,IdDetalleClienteLugarEntrega")] Cliente Cliente)// el Exclude es para las altas, donde el Id viene en 0
        {

            // http://stackoverflow.com/questions/9436300/jsonresult-actionresult-json-datacontractjson-serializer-purpose-differenc
            // http://stackoverflow.com/questions/4743741/difference-between-viewresult-and-actionresult


            try
            {
                try
                {
                    var s = Cliente.Cuit.Replace("-", "");
                    Cliente.Cuit = s.Substring(0, 2) + "-" + s.Substring(2, 8) + "-" + s.Substring(10, 1);

                }
                catch (Exception)
                {

                    // throw;
                }

                string erar = "";

                if (!Validar(Cliente, ref erar))
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    List<string> errors = new List<string>();
                    errors.Add(erar);
                    return Json(errors);
                }

                Cliente.Codigo = Cliente.TipoCliente.ToString() + Cliente.CodigoCliente.ToString();
                if (!Generales.mkf_validacuit(Cliente.Cuit.NullSafeToString()))
                {

                    //  como devuelvo los errores del ModelState si uso un JsonResult en lugar de una View(ViewResult)???
                    // con View puedo devolver el objeto joya... con Json qué serializo? 
                    // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json

                    ModelState.AddModelError("Cuit", "El CUIT es incorrecto"); //http://msdn.microsoft.com/en-us/library/dd410404(v=vs.90).aspx
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    List<string> errors = new List<string>();
                    errors.Add("El CUIT es incorrecto");
                    //  errors.Add("Error 2");
                    return Json(errors);
                    // return Json(new { Success = 1, ex = "El CUIT es incorrecto" });
                    // CargarViewBag(Cliente);
                    // return View(Cliente);
                }


                // ModelState.Remove("IdDetalleCliente");
                if (ModelState.IsValid || true) //no le encontré la vuelta a no validar el Id de las colecciones
                {
                    string tipomovimiento = "";
                    if (Cliente.IdCliente > 0)
                    {
                        // http://stackoverflow.com/questions/7968598/entity-4-1-updating-an-existing-parent-entity-with-new-child-entities

                        var EntidadOriginal = db.Clientes.Where(p => p.IdCliente == Cliente.IdCliente)
                                                .Include(p => p.DetalleClientes)
                                                .Include(p => p.DetalleClientesLugaresEntregas)
                                                .SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Cliente);



                        /////////////////////////////////////////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////////////////////////////////////////
                        foreach (var dr in Cliente.DetalleClientes)
                        {
                            var DetalleEntidadOriginal = EntidadOriginal.DetalleClientes.Where(c => c.IdDetalleCliente == dr.IdDetalleCliente && dr.IdDetalleCliente > 0).SingleOrDefault();
                            if (DetalleEntidadOriginal != null)
                            {
                                var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                DetalleEntidadEntry.CurrentValues.SetValues(dr);
                            }
                            else
                            {
                                EntidadOriginal.DetalleClientes.Add(dr);
                            }
                        }

                        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleClientes.Where(c => c.IdDetalleCliente != 0).ToList())
                        {
                            if (!Cliente.DetalleClientes.Any(c => c.IdDetalleCliente == DetalleEntidadOriginal.IdDetalleCliente))
                                EntidadOriginal.DetalleClientes.Remove(DetalleEntidadOriginal);
                        }

                        /////////////////////////////////////////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////////////////////////////////////////

                        foreach (var dr in Cliente.DetalleClientesLugaresEntregas)
                        {
                            var DetalleEntidadOriginal = EntidadOriginal.DetalleClientesLugaresEntregas.Where(c => c.IdDetalleClienteLugarEntrega == dr.IdDetalleClienteLugarEntrega && dr.IdDetalleClienteLugarEntrega > 0).SingleOrDefault();
                            if (DetalleEntidadOriginal != null)
                            {
                                var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                DetalleEntidadEntry.CurrentValues.SetValues(dr);
                            }
                            else
                            {
                                EntidadOriginal.DetalleClientesLugaresEntregas.Add(dr);
                            }
                        }

                        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleClientesLugaresEntregas.Where(c => c.IdDetalleClienteLugarEntrega != 0).ToList())
                        {
                            if (!Cliente.DetalleClientesLugaresEntregas.Any(c => c.IdDetalleClienteLugarEntrega == DetalleEntidadOriginal.IdDetalleClienteLugarEntrega))
                                EntidadOriginal.DetalleClientesLugaresEntregas.Remove(DetalleEntidadOriginal);
                        }
                        /////////////////////////////////////////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////////////////////////////////////////

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        //if (Cliente.SubNumero == 1)
                        //{
                        //    tipomovimiento = "N";
                        //    Parametros parametros = db.Parametros.Find(1);
                        //    Cliente.Numero = parametros.ProximoCliente;
                        //}
                        db.Clientes.Add(Cliente);
                    }
                    db.SaveChanges();

                    return Json(new { Success = 1, IdCliente = Cliente.IdCliente, ex = "" });
                }
                else
                {
                    // el IsValid se quejaba en las altas     
                    // http://stackoverflow.com/questions/2397563/asp-net-mvc-modelstate-isvalid-is-false-how-to-bypass
                    // Try:
                    //public ActionResult CreateCustomer([Bind(Exclude = "Id")]GWCustomer customer)
                    //This will exclude Id from binding and validation.

                    var allErrors = ModelState.Values.SelectMany(v => v.Errors);
                    var mensajes = string.Join("; ", from i in allErrors select (i.ErrorMessage + (i.Exception == null ? "" : i.Exception.Message)));

                    ViewBag.Errores = mensajes;

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

                throw new System.Data.Entity.Validation.DbEntityValidationException(
                    "Entity Validation Failed - errors follow:\n" +
                    sb.ToString(), ex
                ); // Add the original exception as the innerException


            }

            catch (Exception ex)
            {

                // me saltaba "[...] because it has a DefiningQuery and no element exists in the element to support the current operation."
                // porque faltaba la PK en la tabla DetalleClientesLugaresEntrega
                // http://stackoverflow.com/questions/7583770/unable-to-update-the-entityset-because-it-has-a-definingquery-and-no-updatefu

                return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }




        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////

        [HttpPost]
        public virtual JsonResult UpdateAwesomeGridData(string dataToSend) // (IEnumerable<GridBoundViewModel> gridData)
        {
            // How to send jqGrid row data to server with form data
            // http://forums.asp.net/t/1702990.aspx/1

            //     http://stackoverflow.com/questions/10744694/submitting-jqgrid-row-data-from-view-to-controller-what-method
            //     http://stackoverflow.com/questions/11084066/jqgrid-get-json-data
            //            EDIT - Solution
            //For any other people that are as dumb as I am, here's how I got it to work:
            //First, on Oleg's suggestion, I added loadonce: true to the jqGrid definition. 
            // Then, changed my submit button function as follows:
            //
            // $("#submitButton").click(function () {
            //    var griddata = $("#awesomeGrid").jqGrid('getGridParam', 'data');
            //    var dataToSend = JSON.stringify(griddata);
            //    $.ajax({
            //        url: '@Url.Action("UpdateAwesomeGridData")',
            //        type: 'POST',
            //        contentType: 'application/json; charset=utf-8',
            //        data: dataToSend,
            //        dataType: 'json',
            //        success: function (result) {
            //            alert('success: ' + result.result);
            //        }
            //    });
            //    return true;
            //});
            //Then, changed my controller method signature:
            //public ActionResult UpdateAwesomeGridData(IEnumerable<GridBoundViewModel> gridData)
            //Hope this helps someone in the future.




            JavaScriptSerializer serializer = new JavaScriptSerializer();
            var myListOfData = serializer.Deserialize<List<List<string>>>(dataToSend);

            if (ModelState.IsValid)
            {
                string tipomovimiento = "";
                //if (Cliente.IdCliente > 0)
                //{


                //}


                // return RedirectToAction("Index");
            }

            //return View(); // View(Cliente);

            return Json(new { Success = 0, ex = "" });
        }


        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////




        public virtual JsonResult GetLocalidadesAutocomplete(string term)
        {

            // http://stackoverflow.com/questions/444798/case-insensitive-containsstring

            var ci = new System.Globalization.CultureInfo("en-US");

            var filtereditems = (from item in db.Localidades
                                 // TO DO: no me funciona el  .StartsWith(term, true, ci) !!!!!!!!! 
                                 // y usarlo con el int del codigo tambien es un dolor de cabeza!!!!!
                                 // http://stackoverflow.com/questions/1066760/problem-with-converting-int-to-string-in-linq-to-entities/3292773#3292773
                                 // http://stackoverflow.com/questions/10110266/why-linq-to-entities-does-not-recognize-the-method-system-string-tostring

                                 where ((item.Nombre.StartsWith(term)
                                     //       || SqlFunctions.StringConvert((double)(item.Codigo ?? 0)).StartsWith(term)
                                         )
                                     // && item.Descripcion.Trim().Length > 0
                                     )
                                 orderby item.Nombre
                                 select new
                                 {
                                     id = item.IdLocalidad,
                                     value = item.Nombre,  // item.CodigoPostal,
                                     title = item.Nombre + " " + item.CodigoPostal, //  SqlFunctions.StringConvert((double)(item.CodigoPostal ?? 0))
                                     idprovincia = item.IdProvincia
                                 }).Take(20).ToList();

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }



        public virtual ActionResult Provincias()
        {
            Dictionary<int, string> unidades = new Dictionary<int, string>();
            foreach (Provincia u in db.Provincias.ToList())
                unidades.Add(u.IdProvincia, u.Nombre);
            return PartialView("Select", unidades);
        }

        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //FIN
    }
}

