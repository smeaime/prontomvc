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

using Pronto.ERP.Bll;


// using ProntoMVC.Controllers.Logica;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;//using DocumentFormat.OpenXml.Spreadsheet;
using OpenXmlPowerTools;
using System.Diagnostics;
using ClosedXML.Excel;
using System.IO;

namespace ProntoMVC.Controllers
{

    // [Authorize(Roles = "Administrador,SuperAdmin,Compras")] //ojo que el web.config tambien te puede bochar hacia el login


    public partial class RecepcionController : ProntoBaseController
    {



        public virtual JsonResult DetRecepcionesSinFormato(int IdRecepcion)
        {
            var Det = db.DetalleRecepciones.Where(p => p.IdRecepcion == IdRecepcion).AsQueryable();

            var data = (from a in Det
                        select new
                        {
                            a.IdDetallePedido,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdDetalleRequerimiento,
                            // a.NumeroItem,
                            //a.DetalleRequerimiento.Requerimientos.Obra.NumeroObra,
                            a.Cantidad,
                            //a.Unidad.Abreviatura,
                            //a.Articulo.Codigo,
                            //a.Articulo.Descripcion,
                            //a.FechaEntrega,
                            a.Observaciones,
                            //a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            //NumeroItemRM = a.DetalleRequerimiento.NumeroItem,
                            //a.Adjunto,
                            //a.ArchivoAdjunto1,
                            //a.ArchivoAdjunto2,
                            //a.ArchivoAdjunto3,
                            //a.Precio
                        }).OrderBy(p => p.IdArticulo).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

 
        public virtual ActionResult Recepciones(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString,
                                            string FechaInicial, string FechaFinal, string IdObra, bool bAConfirmar = false, bool bALiberar = false)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            int totalRecords = 0;
            int totalPages = 0;


            if (true)
            {
                LinqToSQL_ProntoDataContext l2sqlPronto = new LinqToSQL_ProntoDataContext(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SCsql()));
                var qq = (from rm in l2sqlPronto.Requerimientos
                          select l2sqlPronto.Requerimientos_Pedidos(rm.IdRequerimiento)
                          ).Take(100).ToList();


            }

            var Req = db.Recepciones
                // .Include(x => x.DetallePedidos.Select(y => y.Unidad))
                // .Include(x => x.DetallePedidos.Select(y => y.Moneda))
                //.Include(x => x.DetallePedidos. .moneda)
                //   .Include("DetallePedidos.Unidad") // funciona tambien
                //    .Include(x => x.Moneda)
                    //.Include(x => x.Obra)

                    //.Include(x => x.SolicitoRequerimiento)
                    //.Include(x => x.AproboRequerimiento)
                    //.Include(x => x.Sectores)
                //  .Include("DetallePedidos.IdDetalleRequerimiento") // funciona tambien
                //   .Include("DetalleRequerimientos.DetallePedidos.Pedido") // funciona tambien
                //.Include(x => x.DetalleRequerimientos)

                        //.Include(x => x.DetalleRequerimientos
                //            .Select(y => y.DetallePedidos
                //                )
                //        )
                //.Include(x => x.DetalleRequerimientos
                //            .Select(y => y.DetallePresupuestos
                //                )
                //        )

                 //       .Include(r => r.DetalleRequerimientos.Select(dr => dr.DetallePedidos.Select(dt => dt.Pedido)))

           //  .Include("DetalleRequerimientos.DetallePedidos.Pedido") // funciona tambien
                //   .Include("DetalleRequerimientos.DetallePresupuestos.Presupuesto") // funciona tambien
                // .Include(x => x.Aprobo)
                          .AsQueryable();


            // Requerimiento test = Req.Where(x => x.IdRequerimiento == 4).ToList().FirstOrDefault();


            //if (bAConfirmar)
            //{

            //    Req = (from a in Req where (a.Confirmado ?? "SI") == "NO" select a).AsQueryable();
            //    //            WHERE  IsNull(Confirmado,'SI')='NO' and 
            //    //(@IdObraAsignadaUsuario=-1 or Requerimientos.IdObra=@IdObraAsignadaUsuario)

            //}
            //if (bALiberar)
            //{
            //    Req = (from a in Req where a.Aprobo == null select a).AsQueryable();
            //    //            WHERE  Requerimientos.Aprobo is null and 
            //    //(@IdObraAsignadaUsuario=-1 or Requerimientos.IdObra=@IdObraAsignadaUsuario)

            //}




            if (IdObra != string.Empty)
            {
                //int IdObra1 = Convert.ToInt32(IdObra);
                //Req = (from a in Req where a.IdObra == IdObra1 select a).AsQueryable();
            }
            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                Req = (from a in Req where a.FechaRecepcion >= FechaDesde && a.FechaRecepcion <= FechaHasta select a).AsQueryable();
            }
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numerorequerimiento":
                        campo = String.Format("Obra.NumeroObra.Contains(\"{0}\") OR NumeroRequerimiento = {1} ", searchString, Generales.Val(searchString));

                        //if (searchString != "")
                        //{
                        //    campo = String.Format("{0} = {1}", searchField, Generales.Val(searchString));
                        //}
                        //else
                        //{
                        //    campo = "true";
                        //}
                        break;
                    case "fecharequerimiento":
                        //No anda
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                    default:
                        campo = String.Format("Obra.Descripcion.Contains(\"{0}\") OR NumeroRequerimiento = {1} ", searchString, Generales.Val(searchString));

                        //campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                }
            }
            else
            {
                campo = "true";
            }


            try
            {

                var Req1 = from a in Req.Where(campo) select a.IdRequerimiento;

                totalRecords = Req1.Count();
                totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            }
            catch (Exception)
            {

                //                throw;
            }

            //switch (sidx.ToLower())
            //{
            //    case "numerorequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //    case "fecharequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.FechaRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.FechaRequerimiento);
            //        break;
            //    case "numeroobra":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Obra.NumeroObra);
            //        else
            //            Req = Req.OrderBy(a => a.Obra.NumeroObra);
            //        break;
            //    case "libero":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados.Nombre);
            //        break;
            //    case "aprobo":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados1.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados1.Nombre);
            //        break;
            //    case "sector":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Sectores.Descripcion);
            //        else
            //            Req = Req.OrderBy(a => a.Sectores.Descripcion);
            //        break;
            //    case "detalle":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Detalle);
            //        else
            //            Req = Req.OrderBy(a => a.Detalle);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //}

            var data = from a in Req  // .Where(campo)
                           .OrderBy(sidx + " " + sord)
                           .Skip((currentPage - 1) * pageSize).Take(pageSize).ToList()
                       select a; //supongo que tengo que hacer la paginacion antes de hacer un select, para que me llene las colecciones anidadas


            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdRecepcion.ToString(),
                            cell = new string[] { 
                                //"<a href="+ Url.Action("Edit",new {id = a.IdRequerimiento} ) + " target='' >Editar</>" ,
                                "<a href="+ Url.Action("Edit",new {id = a.IdRecepcion} ) + "  >Editar</>" ,
							    "<a href="+ Url.Action("Imprimir",new {id = a.IdRecepcion} )  +">Imprimir</>" ,
                                a.IdRecepcion.ToString(), 
                                a.NumeroRecepcion1.ToString(), 
                                a.FechaRecepcion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                              //  a.Cumplido,
                              //  a.Recepcionado,
                              //  a.Entregado,
                              //  a.Impresa,
                              //  a.Detalle,
                              //  //a.Obra.Descripcion, 
                              //(a.Obra==null) ?  "" :  a.Obra.NumeroObra,

                                //  string.Join(" ",  a.DetalleRequerimientos.Select(x=> (x.DetallePresupuestos.Select(y=> y.IdPresupuesto))  )),
                                // string.Join(" ",  a.DetalleRequerimientos.Select(x=>(x.DetallePresupuestos   ==null) ? "" : x.DetallePresupuestos.Select(z=>z.Presupuesto.Numero.ToString()).NullSafeToString() ).Distinct()),


                                // Req ya viene con todos los datos para las colecciones hijas. lo paginé y ahí hice el select (arriba)
                                // Req ya viene con todos los datos para las colecciones hijas. lo paginé y ahí hice el select (arriba)
                                // Req ya viene con todos los datos para las colecciones hijas. lo paginé y ahí hice el select (arriba)
                                // Req ya viene con todos los datos para las colecciones hijas. lo paginé y ahí hice el select (arriba)

                                //string.Join(",",  a.DetalleRequerimientos
                                //    .SelectMany(x =>
                                //        (x.DetallePresupuestos == null) ?
                                //        null :
                                //        x.DetallePresupuestos.Select(y =>
                                //                    (y.Presupuesto == null) ?
                                //                    null :
                                //                    y.Presupuesto.Numero.NullSafeToString()
                                //            )
                                //    ).Distinct()
                                //),


                                //"",

                                 

                                //string.Join(",",  a.DetalleRequerimientos
                                //    .SelectMany(x =>
                                //        (x.DetallePedidos == null) ?
                                //        null :
                                //        x.DetallePedidos.Select(y =>
                                //                    (y.Pedido == null) ?
                                //                    null :
                                //                    "<a href="+ Url.Action("Edit", "Pedido",new {id = y.Pedido.IdPedido} ) + "  >" + y.Pedido.NumeroPedido.NullSafeToString() + "</>"
                                                    
                                //            )
                                //    ).Distinct()
                                //),


                                "", //recepciones
                                "", // salidas

                                //a.Comparativas,
                                //string.Join(" ",  a.DetalleRequerimientos.Select(x=> x.DetallePedidos.Count ))  ,


                                ////string.Join(" ",  a.DetalleRequerimientos.Select(x=>(x.DetallePedidos   ==null) ? "" : x.DetallePedidos.Select(z=>z.Pedido.NumeroPedido.ToString()).NullSafeToString() ).Distinct()),
                                //a.Recepciones,
                                
                                
                                
                                //(a.SolicitoRequerimiento==null) ?  "" :   a.SolicitoRequerimiento.Nombre,
                                //(a.AproboRequerimiento==null) ?  "" :  a.AproboRequerimiento.Nombre,
                                //(a.Sectores==null) ?  "" : a.Sectores.Descripcion,

                                //a.UsuarioAnulacion,
                                //a.FechaAnulacion.NullSafeToString(),
                                //a.MotivoAnulacion,
                                //a.FechasLiberacion,
                             
                                //a.Observaciones,
                                //a.LugarEntrega,
                                //a.IdObra.ToString(),
                                //a.IdSector.ToString(),
                                //a.ConfirmadoPorWeb.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


    }


}