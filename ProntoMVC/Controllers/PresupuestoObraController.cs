﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;


using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;





using System.Reflection;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
//using Trirand.Web.Mvc;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using Pronto.ERP.Bll;
using Newtonsoft.Json;
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
    public partial class PresupuestoObraController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var PresupuestoObra = db.PresupuestoObrasNodos
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Sectores.Count() / pageSize);

            return View(PresupuestoObra);
        }

        public virtual JsonResult GetPresupuestoObraEtapas(int IdObra)
        {
            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));

            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "PresupuestoObrasNodos_TX_EtapasImputablesPorObraParaCombo", IdObra, "M");
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            var data1 = (from a in Entidad
                    select new
                    {
                        id = a["IdPresupuestoObrasNodo"].ToString(),
                        value = a["Titulo"].ToString()
                    }).ToList();
            return Json(data1, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetItemsPresupuestoObras(string term)
        {

            var q = (from item in db.PresupuestoObrasNodos
                     from b in db.PresupuestoObrasNodos.Where(o => o.IdPresupuestoObrasNodo == item.IdNodoPadre).DefaultIfEmpty()
                     where item.Item.StartsWith(term)
                     orderby item.Item
                     select new
                     {
                         id = item.IdPresupuestoObrasNodo,
                         value = item.Item + (b != null ? " " + b.Descripcion : "") + " - " + item.Descripcion, // esto es lo que se ve
                         title = (b != null ? " " + b.Descripcion : "") + " - " + item.Descripcion,
                         Descripcion = item.Descripcion
                     }).Take(100).ToList();

            if (q.Count == 0 && term != "No se encontraron resultados")
            {
                q.Add(new { id = 0, value = "No se encontraron resultados", title = "", Descripcion = "" });
            }

            var a = Json(q, JsonRequestBehavior.AllowGet);

            return a;
        }

        public virtual JsonResult GetPresupuestoObraPorId(int Id)
        {
            var filtereditems = (from a in db.PresupuestoObrasNodos
                                 from b in db.PresupuestoObrasNodos.Where(o => o.IdPresupuestoObrasNodo == a.IdNodoPadre).DefaultIfEmpty()
                                 where (a.IdPresupuestoObrasNodo == Id)
                                 select new
                                 {
                                     id = a.IdPresupuestoObrasNodo,
                                     value = a.Item + (b != null ? " " + b.Descripcion : "") + " - " + a.Descripcion,
                                     a.Item,
                                     DescripcionConPadre = (b != null ? " " + b.Descripcion : "") + " - " + a.Descripcion,
                                     Descripcion = a.Descripcion
                                 }).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }



    // [Authorize(Roles = "Administrador,SuperAdmin,Compras")] //ojo que el web.config tambien te puede bochar hacia el login


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


            // var Req = db.PresupuestoObrasNodos_TX_EtapasImputablesPorObraParaCombo(null, "", null, "", "");


            int? IdObra2 = null;
            string PresupuestoObraRubro = "*"; // varchar(1) = Null,  
            int? CodigoPresupuesto = null;
            string ConHijos = null; // varchar(2)
            string Resumen = null; //varchar(30) = Null  


            DataTable dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SCsql(), "PresupuestoObrasNodos_TX_EtapasImputablesPorObraParaCombo",
                                    IdObra2, PresupuestoObraRubro, CodigoPresupuesto, ConHijos, Resumen);


            var Req = from DataRow r in dt.Rows
                      select new
                      {
                          IdPresupuestoObrasNodo = r["IdPresupuestoObrasNodo"],
                          IdCuenta = r["IdCuenta"],
                          IdNodoPadre = r["IdNodoPadre"],
                          IdObra = r["IdObra"],
                          Descripcion = r["Descripcion"],
                          IdUnidad = r["IdUnidad"],
                          CantidadAvanzada = r["CantidadAvanzada"],
                          Importe = r["Importe"],
                          Cantidad = r["Cantidad"]
                      };



            // ("_EtapasImputablesPorObraParaCombo", Array(mIdObra, "*"))




            var Req2 = db.PresupuestoObrasNodos
                // .Include(x => x.DetallePedidos.Select(y => y.Unidad))
                // .Include(x => x.DetallePedidos.Select(y => y.Moneda))
                //.Include(x => x.DetallePedidos. .moneda)
                //   .Include("DetallePedidos.Unidad") // funciona tambien
                //    .Include(x => x.Moneda)
                //.Include(x => x.Obra)
                //.Include(x => x.Tipos)
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

            //            SELECT P.IdPresupuestoObrasNodo, RTrim(LTrim(IsNull(P.Descripcion,Obras.Descripcion))), RTrim(LTrim(IsNull(R.Descripcion,'Varios')))  
            //FROM PresupuestoObrasNodos P  
            //LEFT OUTER JOIN Obras ON Obras.IdObra=P.IdObra  
            //LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro  
            //LEFT OUTER JOIN #Auxiliar10 a ON a.IdPresupuestoObrasNodo=P.IdPresupuestoObrasNodo  
            //WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(Obras.IdObraRelacionada,0)=@IdObra) and P.IdNodoPadre is not null and   
            // (@ConHijos='*' or (@ConHijos='NO' and a.Hijos='SI') or (@ConHijos='SI' and a.Hijos='NO')) and   
            // (@IdPresupuestoObraRubro1=-1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro2)  





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

                var Req1 = Req; //.Where(campo) select a.IdPresupuestoObrasNodo;

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
                           // .OrderBy(sidx + " " + sord)
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
                                a.Descripcion.ToString(), 
                                a.Cantidad.ToString(), 
                                a.CantidadAvanzada.ToString(), 
                                a.IdCuenta.ToString(), 

                                a.IdObra.ToString(), 

                                a.Importe.ToString(), 

                                
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


/*




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


CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_EtapasImputablesPorObraParaCombo]  
  
@IdObra int = Null,  
@PresupuestoObraRubro varchar(1) = Null,  
@CodigoPresupuesto int = Null,  
@ConHijos varchar(2) = Null,  
@Resumen varchar(30) = Null  
  
AS   
  
SET NOCOUNT ON  
  
SET @IdObra=IsNull(@IdObra,-1)  
SET @PresupuestoObraRubro=IsNull(@PresupuestoObraRubro,'*')  
SET @CodigoPresupuesto=IsNull(@CodigoPresupuesto,0)  
SET @ConHijos=IsNull(@ConHijos,'*')  
SET @Resumen=IsNull(@Resumen,'')  
  
DECLARE @IdPresupuestoObraRubro1 int, @IdPresupuestoObraRubro2 int, @proc_name varchar(1000), @IdPresupuestoObrasNodo int, @Etapa varchar(200), @Rubro varchar(50), @IdNodoPadre int,   
  @CantidadTeoricaTotal numeric(18,2), @CantidadTeoricaTotalPadre numeric(18,2), @ImporteTeoricaTotal numeric(18,2), @ImporteTeoricaTotalPadre numeric(18,2)  
  
SET @IdPresupuestoObraRubro1=-1  
SET @IdPresupuestoObraRubro2=-1  
  
IF @PresupuestoObraRubro='M'  
 SET @IdPresupuestoObraRubro1=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloMateriales'),0)  
 SET @IdPresupuestoObraRubro2=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloAuxiliares'),0)  
IF @PresupuestoObraRubro='E'  
 SET @IdPresupuestoObraRubro1=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloEquipos'),0)  
IF @PresupuestoObraRubro='O'  
 SET @IdPresupuestoObraRubro1=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloManoObra'),0)  
IF @PresupuestoObraRubro='S'  
 SET @IdPresupuestoObraRubro1=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloSubcontratos'),0)  
  
CREATE TABLE #Auxiliar10 (IdPresupuestoObrasNodo INTEGER, Hijos VARCHAR(2), ConHijosPadres VARCHAR(2))  
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar10 (IdPresupuestoObrasNodo) ON [PRIMARY]  
INSERT INTO #Auxiliar10   
 SELECT pon.IdPresupuestoObrasNodo,   
 --Case When Exists(Select Top 1 pon1.IdPresupuestoObrasNodo From PresupuestoObrasNodos pon1 Where Patindex('%/'+Convert(varchar,pon.IdPresupuestoObrasNodo)+'/%', pon1.Lineage)>0) Then 'SI' Else 'NO' End  
 Case When Exists(Select Top 1 pon1.IdNodoPadre From PresupuestoObrasNodos pon1 Where pon1.IdNodoPadre=pon.IdPresupuestoObrasNodo) Then 'SI' Else 'NO' End,  
 Case When IsNull((Select Top 1 (Select Top 1 pon2.IdPresupuestoObrasNodo From PresupuestoObrasNodos pon2 Where pon2.IdNodoPadre=pon1.IdPresupuestoObrasNodo)  
      From PresupuestoObrasNodos pon1   
      Where pon1.IdNodoPadre=pon.IdPresupuestoObrasNodo),0)>0 Then 'SI' Else 'NO' End  
 FROM PresupuestoObrasNodos pon  
 LEFT OUTER JOIN Obras O ON O.IdObra = pon.IdObra  
 WHERE (@IdObra=-1 or pon.IdObra=@IdObra or IsNull(O.IdObraRelacionada,0)=@IdObra) and pon.IdNodoPadre is not null  
  
SET NOCOUNT OFF  
  
IF @Resumen=''  
 SELECT P.*, pond.Importe, pond.Cantidad, pond.CantidadBase, pond.Rendimiento, pond.Incidencia, pond.Costo, U.Abreviatura as [Unidad],   
  IsNull(P.Item+' ','') + IsNull(P2.Descripcion+' - ', '') + IsNull(P.Descripcion, Obras.Descripcion) as [Titulo],   
  C.Codigo as [CCostos], pond.PrecioVentaUnitario, RTrim(LTrim(IsNull(R.Descripcion,'Varios'))) as [Rubro], a.Hijos as [Hijos], a.ConHijosPadres as [ConHijosPadres]  
 FROM PresupuestoObrasNodos P  
 LEFT OUTER JOIN PresupuestoObrasNodosDatos pond ON pond.IdPresupuestoObrasNodo=P.IdPresupuestoObrasNodo and pond.CodigoPresupuesto=@CodigoPresupuesto  
 LEFT OUTER JOIN PresupuestoObrasNodos P2 ON P2.IdPresupuestoObrasNodo=P.IdNodoPadre  
 LEFT OUTER JOIN Obras ON Obras.IdObra=P.IdObra  
 LEFT OUTER JOIN Unidades U ON P.idUnidad=U.IdUnidad  
 LEFT OUTER JOIN CuentasGastos C ON P.IdCuentaGasto=C.IdCuentaGasto  
 LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro  
 LEFT OUTER JOIN #Auxiliar10 a ON a.IdPresupuestoObrasNodo=P.IdPresupuestoObrasNodo  
 WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(Obras.IdObraRelacionada,0)=@IdObra) and P.IdNodoPadre is not null and   
   (@ConHijos='*' or (@ConHijos='NO' and a.Hijos='SI') or (@ConHijos='SI' and a.Hijos='NO')) and   
   (@IdPresupuestoObraRubro1=-1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro2)  
 ORDER BY P.Subitem1, P.Subitem2, P.Subitem3, P.Subitem4, P.Subitem5, P.Item, P.Descripcion  
  
IF @Resumen='SoloPadres'  
  SELECT P.IdPresupuestoObrasNodo, IsNull(P.Item+' ','') + IsNull(P2.Descripcion+' - ', '') + IsNull(P.Descripcion, Obras.Descripcion) as [Titulo], P.Item as [Item]  
 FROM PresupuestoObrasNodos P  
 LEFT OUTER JOIN Obras ON Obras.IdObra=P.IdObra  
 LEFT OUTER JOIN #Auxiliar10 a ON a.IdPresupuestoObrasNodo=P.IdPresupuestoObrasNodo  
 LEFT OUTER JOIN PresupuestoObrasNodos P2 ON P2.IdPresupuestoObrasNodo=P.IdNodoPadre  
 WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(Obras.IdObraRelacionada,0)=@IdObra) and P.IdNodoPadre is not null and a.Hijos='SI'  
 ORDER BY P.Subitem1, P.Subitem2, P.Subitem3, P.Subitem4, P.Subitem5, P.Item, P.Descripcion  
  
IF @Resumen='SoloHijos'  
  SELECT P.IdPresupuestoObrasNodo, IsNull(P.Item+' ','') + IsNull(P2.Descripcion+' - ', '') + IsNull(P.Descripcion, Obras.Descripcion) as [Titulo], P.Item as [Item]  
 FROM PresupuestoObrasNodos P  
 LEFT OUTER JOIN Obras ON Obras.IdObra=P.IdObra  
 LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro  
 LEFT OUTER JOIN #Auxiliar10 a ON a.IdPresupuestoObrasNodo=P.IdPresupuestoObrasNodo  
 LEFT OUTER JOIN PresupuestoObrasNodos P2 ON P2.IdPresupuestoObrasNodo=P.IdNodoPadre  
 WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(Obras.IdObraRelacionada,0)=@IdObra) and P.IdNodoPadre is not null and   
   (@ConHijos='*' or (@ConHijos='NO' and a.Hijos='SI') or (@ConHijos='SI' and a.Hijos='NO')) and   
   (@IdPresupuestoObraRubro1=-1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro2)  
 ORDER BY P.Subitem1, P.Subitem2, P.Subitem3, P.Subitem4, P.Subitem5, P.Item, P.Descripcion  
  
IF @Resumen='SoloHijosPorRubro'  
  SELECT DISTINCT RTrim(LTrim(IsNull(P.Descripcion,Obras.Descripcion))) as [Etapa], RTrim(LTrim(IsNull(R.Descripcion,'Varios'))) as [Rubro]  
 FROM PresupuestoObrasNodos P  
 LEFT OUTER JOIN Obras ON Obras.IdObra=P.IdObra  
 LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro  
 LEFT OUTER JOIN #Auxiliar10 a ON a.IdPresupuestoObrasNodo=P.IdPresupuestoObrasNodo  
 WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(Obras.IdObraRelacionada,0)=@IdObra) and P.IdNodoPadre is not null and   
   (@ConHijos='*' or (@ConHijos='NO' and a.Hijos='SI') or (@ConHijos='SI' and a.Hijos='NO')) and   
   (@IdPresupuestoObraRubro1=-1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro2)  
 ORDER BY [Rubro], [Etapa]  
  
IF @Resumen='SoloHijosPorRubroConCostos' or @Resumen='SoloHijosPorRubroConCostosRs' or @Resumen='SoloHijosPorRubroConCostosRs2' or @Resumen='SoloHijosPorRubroConCostosRs3'  
  BEGIN  
 SET NOCOUNT ON  
  
 SET @proc_name='PresupuestoObrasNodos_TX_DetallePxQ'  
  
 CREATE TABLE #Auxiliar8   
    (  
     Año INTEGER,  
     Mes INTEGER,  
     Cantidad NUMERIC(18, 2),  
     Importe NUMERIC(18, 2),  
     CantidadReal NUMERIC(18, 2),  
     ImporteReal NUMERIC(18, 2),  
     CantidadTeorica NUMERIC(18, 4),  
     Certificado NUMERIC(18, 2),  
     CantidadRealPadre NUMERIC(18, 2),  
     Redeterminaciones NUMERIC(18, 2)  
    )  
  
 CREATE TABLE #Auxiliar91   
    (  
     IdPresupuestoObrasNodo INTEGER,  
     Etapa VARCHAR(200),  
     Rubro VARCHAR(50),  
     Año INTEGER,  
     Mes INTEGER,  
     Cantidad NUMERIC(18, 2),  
     Importe NUMERIC(18, 2),  
     CantidadReal NUMERIC(18, 2),  
     ImporteReal NUMERIC(18, 2),  
     CantidadTeorica NUMERIC(18, 4),  
     Certificado NUMERIC(18, 2),  
     CantidadRealPadre NUMERIC(18, 2),  
     CantidadTeoricaTotal NUMERIC(18, 4),  
     CantidadTeoricaTotalPadre NUMERIC(18, 4),  
     CantidadProporcionalConPadre NUMERIC(18, 2),  
     PrecioUnitarioTeorico NUMERIC(18, 2),  
     PrecioUnitarioReal NUMERIC(18, 2),  
     ConPrecioUnitarioTeorico INTEGER,  
     ConPrecioUnitarioReal INTEGER,  
     PrecioUnitarioTeoricoTotal NUMERIC(18, 2)  
    )  
  
 CREATE TABLE #Auxiliar92   
    (  
     Etapa VARCHAR(200),  
     Rubro VARCHAR(50),  
     Año INTEGER,  
     Mes INTEGER,  
     CantidadTeorica NUMERIC(18, 4),  
     PrecioUnitarioTeorico NUMERIC(18, 2),  
     Importe NUMERIC(18, 2),  
     CantidadReal NUMERIC(18, 2),  
     PrecioUnitarioReal NUMERIC(18, 2),  
     ImporteReal NUMERIC(18, 2),  
     SumaPrecioUnitarioTeorico NUMERIC(18, 2),  
     SumaPrecioUnitarioReal NUMERIC(18, 2),  
     SumaConPrecioUnitarioTeorico INTEGER,  
     SumaConPrecioUnitarioReal INTEGER,  
     CantidadTeoricaTotal NUMERIC(18, 4),  
     CantidadTeoricaTotalPadre NUMERIC(18, 4),  
     CantidadRealPadre NUMERIC(18, 2),  
     CantidadTeoricaProporcionalPadre NUMERIC(18, 4)  
    )  
  
 CREATE TABLE #Auxiliar7   
    (  
     IdPresupuestoObrasNodo INTEGER,  
     Etapa VARCHAR(200),  
     Rubro VARCHAR(50)  
    )  
 CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar10 (IdPresupuestoObrasNodo) ON [PRIMARY]  
  
 INSERT INTO #Auxiliar7   
  SELECT P.IdPresupuestoObrasNodo, RTrim(LTrim(IsNull(P.Descripcion,Obras.Descripcion))), RTrim(LTrim(IsNull(R.Descripcion,'Varios')))  
  FROM PresupuestoObrasNodos P  
  LEFT OUTER JOIN Obras ON Obras.IdObra=P.IdObra  
  LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro  
  LEFT OUTER JOIN #Auxiliar10 a ON a.IdPresupuestoObrasNodo=P.IdPresupuestoObrasNodo  
  WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(Obras.IdObraRelacionada,0)=@IdObra) and P.IdNodoPadre is not null and   
   (@ConHijos='*' or (@ConHijos='NO' and a.Hijos='SI') or (@ConHijos='SI' and a.Hijos='NO')) and   
   (@IdPresupuestoObraRubro1=-1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro2)  
-- (GasOil) and P.IdPresupuestoObrasNodo in(2278,2288,2298,2308,2318,2330,2347,2361,2367,2378,2392,2405,2419,2434,2449,2457,2467,2494,2511,2531,2544,2552,2564,2576,2583,2593,2603,2611,2619,2626,2633,2641,2650,2658)  
--and P.IdPresupuestoObrasNodo in(2279,2289,2299,2309,2319,2331,2348,2362,2368,2379,2393,2406,2420,2435,2450,2458,2468,2495,2512,2532,2545,2553,2565,2577,2584,2594,2604,2612,2620,2627,2634,2642,2651,2659,2679)  
--and P.IdPresupuestoObrasNodo in(2267,2606)  
  
 DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdPresupuestoObrasNodo, Etapa, Rubro FROM #Auxiliar7 ORDER BY IdPresupuestoObrasNodo  
 OPEN Cur  
 FETCH NEXT FROM Cur INTO @IdPresupuestoObrasNodo, @Etapa, @Rubro  
 WHILE @@FETCH_STATUS = 0  
   BEGIN  
  TRUNCATE TABLE #Auxiliar8  
  INSERT INTO #Auxiliar8   
   EXECUTE @proc_name @IdPresupuestoObrasNodo, @CodigoPresupuesto  
  
  UPDATE #Auxiliar8  
  SET CantidadReal=1  
  WHERE IsNull(CantidadReal,0)=0 and IsNull(ImporteReal,0)<>0  
  
  SET @IdNodoPadre=IsNull((Select IdNodoPadre From PresupuestoObrasNodos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo),0)  
  SET @CantidadTeoricaTotal=IsNull((Select Cantidad From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto),0)  
  SET @ImporteTeoricaTotal=IsNull((Select Importe*Cantidad From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto),0)  
  SET @CantidadTeoricaTotalPadre=IsNull((Select Cantidad From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@IdNodoPadre and CodigoPresupuesto=@CodigoPresupuesto),0)  
  SET @ImporteTeoricaTotalPadre=IsNull((Select Importe*Cantidad From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@IdNodoPadre and CodigoPresupuesto=@CodigoPresupuesto),0)  
  
  INSERT INTO #Auxiliar91  
   SELECT @IdPresupuestoObrasNodo, @Etapa, @Rubro, Año, Mes, Cantidad, Importe*Cantidad, CantidadReal, ImporteReal, CantidadTeorica, Certificado,   
    CantidadRealPadre, @CantidadTeoricaTotal, @CantidadTeoricaTotalPadre,   
    Case When @CantidadTeoricaTotalPadre<>0 Then (CantidadRealPadre/@CantidadTeoricaTotalPadre)*@CantidadTeoricaTotal Else 0 End,   
    Importe, --Case When CantidadTeorica<>0 Then Importe/CantidadTeorica Else 0 End **** Ahora el Importe es el precio unitario  
    Case When CantidadReal<>0 Then ImporteReal/CantidadReal Else 0 End,   
    0, 0, @ImporteTeoricaTotal  
   FROM #Auxiliar8  
  
  FETCH NEXT FROM Cur INTO @IdPresupuestoObrasNodo, @Etapa, @Rubro  
   END  
 CLOSE Cur  
 DEALLOCATE Cur  
  
 UPDATE #Auxiliar91  
 SET ConPrecioUnitarioTeorico=1  
 WHERE IsNull(PrecioUnitarioTeorico,0)<>0  
   
 UPDATE #Auxiliar91  
 SET ConPrecioUnitarioReal=1  
 WHERE IsNull(PrecioUnitarioReal,0)<>0  
  
 INSERT INTO #Auxiliar92  
  SELECT Etapa, Rubro, Año, Mes, Sum(IsNull(CantidadTeorica,0)), 0, Sum(IsNull(Importe,0)), Sum(IsNull(CantidadReal,0)), 0, Sum(IsNull(ImporteReal,0)),   
   Sum(IsNull(PrecioUnitarioTeorico,0)), Sum(IsNull(PrecioUnitarioReal,0)), Sum(IsNull(ConPrecioUnitarioTeorico,0)), Sum(IsNull(ConPrecioUnitarioReal,0)),   
   Sum(Case When IsNull(CantidadRealPadre,0)<>0 Then IsNull(CantidadTeoricaTotal,0) Else 0 End),   
   Sum(Case When IsNull(CantidadRealPadre,0)<>0 Then IsNull(CantidadTeoricaTotalPadre,0) Else 0 End), Sum(IsNull(CantidadRealPadre,0)), Sum(IsNull(CantidadProporcionalConPadre,0))  
  FROM #Auxiliar91  
  GROUP BY Etapa, Rubro, Año, Mes  
    
   
 UPDATE #Auxiliar92  
 SET PrecioUnitarioTeorico = Case When IsNull((Select Sum(IsNull(a91.CantidadTeorica,0)) From #Auxiliar91 a91 Where a91.Etapa=#Auxiliar92.Etapa and a91.Rubro=#Auxiliar92.Rubro and a91.Año=#Auxiliar92.Año and a91.Mes=#Auxiliar92.Mes),0)<>0   
          Then IsNull((Select Sum(IsNull(a91.CantidadTeorica,0)*IsNull(a91.PrecioUnitarioTeorico,0)) From #Auxiliar91 a91 Where a91.Etapa=#Auxiliar92.Etapa and a91.Rubro=#Auxiliar92.Rubro and a91.Año=#Auxiliar92.Año and a91.Mes=#Auxiliar92.Mes),0) /   
            IsNull((Select Sum(IsNull(a91.CantidadTeorica,0)) From #Auxiliar91 a91 Where a91.Etapa=#Auxiliar92.Etapa and a91.Rubro=#Auxiliar92.Rubro and a91.Año=#Auxiliar92.Año and a91.Mes=#Auxiliar92.Mes),0)  
          Else IsNull((Select Top 1 IsNull(a91.PrecioUnitarioTeorico,0) From #Auxiliar91 a91 Where a91.Etapa=#Auxiliar92.Etapa and a91.Rubro=#Auxiliar92.Rubro and a91.Año=#Auxiliar92.Año and a91.Mes=#Auxiliar92.Mes and IsNull(a91.PrecioUnitarioTeorico,0)<
>0),0)  
        End  
  
 UPDATE #Auxiliar92  
 SET PrecioUnitarioReal=Case When IsNull(CantidadReal,0)<>0 Then ImporteReal/CantidadReal Else 0 End  
  
 SET NOCOUNT OFF  
  
 IF @Resumen='SoloHijosPorRubroConCostos'  
  SELECT #Auxiliar91.* --, pon.Item  
  FROM #Auxiliar91   
--left outer join PresupuestoObrasNodos pon on pon.IdPresupuestoObrasNodo=#Auxiliar91.IdPresupuestoObrasNodo  
--Where año=2013 --and mes=10    
  ORDER BY #Auxiliar91.Rubro, #Auxiliar91.Etapa, #Auxiliar91.IdPresupuestoObrasNodo, #Auxiliar91.Año, #Auxiliar91.Mes  
  
 IF @Resumen='SoloHijosPorRubroConCostosRs'  
  SELECT *   
  FROM #Auxiliar92  
--Where año=2013 --and mes=10   
  ORDER BY Rubro, Etapa, Año, Mes  
  
 IF @Resumen='SoloHijosPorRubroConCostosRs2'  
  SELECT Rubro, Año, Mes, Sum(IsNull(CantidadReal,0)) as [CantidadReal], Sum(IsNull(ImporteReal,0)) as [ImporteReal]  
  FROM #Auxiliar92  
  GROUP BY Rubro, Año, Mes  
  ORDER BY Rubro, Año, Mes  
  
 IF @Resumen='SoloHijosPorRubroConCostosRs3'  
  SELECT Rubro, Etapa, Año, Mes, Max(PrecioUnitarioTeorico) as [PrecioUnitario], dbo.PresupuestoObrasNodos_Items(Etapa,@IdObra)as [Items]  
  FROM #Auxiliar92  
  GROUP BY Rubro, Etapa, Año, Mes  
  ORDER BY Rubro, Etapa, Año, Mes  
  
 DROP TABLE #Auxiliar7  
 DROP TABLE #Auxiliar8  
 DROP TABLE #Auxiliar91  
 DROP TABLE #Auxiliar92  
  END  
  
DROP TABLE #Auxiliar10




*/
