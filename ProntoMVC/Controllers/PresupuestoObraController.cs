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


    public partial class PresupuestoObraController : ProntoBaseController
    {


        public virtual ActionResult PresupuestosObra(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString,
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

            var Req = db.PresupuestoObrasNodos
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

                //        .Include(r => r.DetalleRequerimientos.Select(dr => dr.DetallePedidos.Select(dt => dt.Pedido)))

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
                //DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                //DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                //Req = (from a in Req where a.fecha >= FechaDesde && a.FechaRequerimiento <= FechaHasta select a).AsQueryable();
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

                var Req1 = from a in Req.Where(campo) select a.IdPresupuestoObrasNodo;

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

            var data = from a in Req//.Where(campo)
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
                            id = a.IdPresupuestoObrasNodo.ToString(),
                            cell = new string[] { 
                                //"<a href="+ Url.Action("Edit",new {id = a.IdRequerimiento} ) + " target='' >Editar</>" ,
                                "<a href="+ Url.Action("Edit",new {id = a.IdPresupuestoObrasNodo} ) + "  >Editar</>" ,
							    "<a href="+ Url.Action("Imprimir",new {id = a.IdPresupuestoObrasNodo} )  +">Imprimir</>" ,
                                a.IdPresupuestoObrasNodo.ToString(), 
                              //  a.NumeroRequerimiento.ToString(), 
                              //  a.FechaRequerimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
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


                                //"", //recepciones
                                //"", // salidas

                                ////a.Comparativas,
                                ////string.Join(" ",  a.DetalleRequerimientos.Select(x=> x.DetallePedidos.Count ))  ,


                                //////string.Join(" ",  a.DetalleRequerimientos.Select(x=>(x.DetallePedidos   ==null) ? "" : x.DetallePedidos.Select(z=>z.Pedido.NumeroPedido.ToString()).NullSafeToString() ).Distinct()),
                                ////a.Recepciones,
                                
                                
                                
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







llenado
  ElseIf oControl.Tag = "PresupuestoObrasNodos" Then
                  Set oRs = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_EtapasImputablesPorObraParaCombo", Array(mIdObra, "*"))
                  If oRs.RecordCount = 0 And Not mTomarCuentaDePresupuesto Then
                     origen.Registro.Fields(DataCombo1(16).DataField).Value = Null
                     DataCombo1(16).Enabled = False
                     cmdPresu.Enabled = False
                  ElseIf oRs.RecordCount = 1 Then
                     DataCombo1(16).Enabled = True
                     cmdPresu.Enabled = True
                     Set DataCombo1(16).RowSource = oRs
                     origen.Registro.Fields(DataCombo1(16).DataField).Value = oRs.Fields(0).Value
                  Else
                     DataCombo1(16).Enabled = True
                     cmdPresu.Enabled = True
                     Set DataCombo1(16).RowSource = oRs
                  End If
               Else





change
         Case 16
            If IsNumeric(DataCombo1(Index).BoundText) Then
               Set oRs = Aplicacion.TablasGenerales.TraerUno("PresupuestoObrasNodos", DataCombo1(Index).BoundText)
               With origen.Registro
                  .Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
                  If oRs.RecordCount > 0 Then
                     If IIf(IsNull(oRs.Fields("IdCuenta").Value), 0, oRs.Fields("IdCuenta").Value) > 0 Then
                        If IIf(IsNull(.Fields("IdCuenta").Value), 0, .Fields("IdCuenta").Value) > 0 Then
                           If .Fields("IdCuenta").Value <> oRs.Fields("IdCuenta").Value And Not mTomarCuentaDePresupuesto Then
                              DoEvents
                              MsgBox "La cuenta contable asignada al item presupuesto de obra es distinta a la cuenta seleccionada", vbExclamation
                              .Fields(DataCombo1(Index).DataField).Value = Null
                              oRs.Close
                              Set oRs = Nothing
                              Exit Sub
                           End If
                        End If
                        .Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
                        'DataCombo1(0).BoundText = oRs.Fields("IdCuenta").Value
                     Else
                        If mTomarCuentaDePresupuesto Then
                           DoEvents
                           MsgBox "El item presupuesto de obra no tiene cuenta contable asignada", vbExclamation
                           .Fields(DataCombo1(Index).DataField).Value = Null
                           oRs.Close
                           Set oRs = Nothing
                           Exit Sub
                        End If
                     End If
                  End If
               End With
               oRs.Close
            End If






_EtapasImputablesPorObraParaCombo




