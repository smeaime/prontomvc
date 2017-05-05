using System;
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



using System.Linq;
using System.Data.Entity;


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


        public virtual ActionResult Index()
        {
            return View();
        }



        //[HttpGet]
        //public virtual ActionResult Index(int page = 1)
        //{
        //    var PresupuestoObra = db.PresupuestoObrasNodos
        //        .OrderBy(s => s.Descripcion)
        //        .Skip((page - 1) * pageSize)
        //        .Take(pageSize)
        //        .ToList();

        //    ViewBag.CurrentPage = page;
        //    ViewBag.pageSize = pageSize;
        //    ViewBag.TotalPages = Math.Ceiling((double)db.Sectores.Count() / pageSize);

        //    return View(PresupuestoObra);
        //}


        [HttpGet]
        public virtual ActionResult Edit(int id)
        {
            //var PresupuestoObra = db.PresupuestoObrasNodos
            //    .OrderBy(s => s.Descripcion)
            //    .Skip((page - 1) * pageSize)
            //    .Take(pageSize)
            //    .ToList();

            //ViewBag.CurrentPage = page;
            //ViewBag.pageSize = pageSize;
            //ViewBag.TotalPages = Math.Ceiling((double)db.Sectores.Count() / pageSize);

            //return View(PresupuestoObra);

            return View();
        }


        public virtual JsonResult GetPresupuestoObraEtapas(int IdObra)
        {
            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

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




        // Migrar LlenarGrilla de frmPresupuestoObrasArbol del Pronto VB6
        public virtual ActionResult LlenarGrilla(string sidx, string sord, int page, int rows, bool _search, string filters,
                                                int Nodo)
        {



            // Migrar LlenarGrilla de frmPresupuestoObrasArbol del Pronto VB6


            //de donde salen estas?
            int Cant_Columnas = 90;
            int IdObra = 0;
            bool mvarComparativaActiva = false;
            DateTime FechaInicialObra = DateTime.Today;
            long mvarCodigoPresupuesto = 0;
            int mvarCompara1 = 0, mvarCompara2 = 0;



            //////////////


            const int COL_NODO = 0;
            const int COL_NODOPADRE = 1;
            const int COL_DESCRIPCION = 2;
            const int COL_ITEM = 3;
            const int COL_TIPO = 4;
            const int COL_CANTIDADAVAN = 14;
            const int COL_CANTIDAD = 6;
            const int COL_UNIMEDIDA = 7;
            const int COL_IMPORTE = 8;
            const int COL_ANO = 9;
            const int COL_DEPTH = 10;
            const int COL_LINEAGE = 11;
            const int COL_TOTAL = 12;
            const int COL_OBRA = 13;
            const int COL_IDARTICULO = 5;

            const int ANCHO_COL_ID = 0;

            const int TIPO_OBRA = 1;
            const int TIPO_PRESUPUESTO = 2; ;
            const int TIPO_ETAPA = 3;
            const int TIPO_ARTICULO = 4;
            const int TIPO_RUBRO = 5;



            int i, j, mCol, mIconoRubro;
            long tempc, tempr, PosI_R, PosI_C, mPos;
            double mCant, mCantidad1, mCantidad2, mImporte1, mImporte2;
            double mDiferencia, mDesvio;
            bool EsRaiz;
            string mIcono;


            DataTable oRs = EntidadManager.ExecDinamico(SCsql(), "PresupuestoObrasNodos_tx_PorNodo " + Nodo);


            // http://stackoverflow.com/questions/597720/what-are-the-differences-between-a-multidimensional-array-and-an-array-of-arrays
            //string[,] TextMatrix = new string[100, 1000];
            string[][] TextMatrix = new string[1000][];

            i = 0;

            // http://stackoverflow.com/questions/597720/what-are-the-differences-between-a-multidimensional-array-and-an-array-of-arrays

            foreach (DataRow r in oRs.Rows)
            {
                TextMatrix[i] = new string[100];

                TextMatrix[i][COL_NODO] = r["IdPresupuestoObrasNodo"].NullSafeToString();
                TextMatrix[i][COL_NODOPADRE] = (r["IdNodoPadre"] ?? 0).NullSafeToString();
                TextMatrix[i][COL_DEPTH] = r["Depth"].NullSafeToString();
                TextMatrix[i][COL_LINEAGE] = r["Lineage"].NullSafeToString();
                TextMatrix[i][COL_OBRA] = r["IdObra"].NullSafeToString();
                TextMatrix[i][COL_ITEM] = (r["Item"] ?? "").NullSafeToString();
                TextMatrix[i][COL_CANTIDAD] = (r["Cantidad"] ?? 0).NullSafeToString();
                TextMatrix[i][COL_UNIMEDIDA] = (r["Unidad"] ?? "").NullSafeToString();
                TextMatrix[i][COL_IMPORTE] = (r["Importe"] ?? 0).NullSafeToString();
                TextMatrix[i][COL_TOTAL] = (Convert.ToInt32(r["Cantidad"] == DBNull.Value ? 0 : r["Cantidad"]) * Convert.ToInt32(r["Importe"] == DBNull.Value ? 0 : r["Importe"])).NullSafeToString();

                //                const int TIPO_OBRA = 1;
                //const int TIPO_PRESUPUESTO = 2;
                //Const TIPO_ETAPA = 3
                //Const TIPO_ARTICULO = 4
                //Const TIPO_RUBRO = 5
                switch (Convert.ToInt16(r["TipoNodo"] ?? 0))
                {
                    case TIPO_OBRA:
                        TextMatrix[i][COL_DESCRIPCION] = r["DescripcionObra"].NullSafeToString();
                        TextMatrix[i][COL_TIPO] = "";
                        break;
                    default:
                        TextMatrix[i][COL_DESCRIPCION] = r["Descripcion"].NullSafeToString();
                        TextMatrix[i][COL_TIPO] = "<DIR>";
                        break;
                }

                TextMatrix[i][COL_CANTIDADAVAN] = r["UnidadAvance1"].NullSafeToString();

                //If Len(IIf(IsNull(r["Rubro"]), "", r["Rubro"])) > 0 Then
                //   On Error Resume Next
                //   mIcono = glbPathPlantillas & "\..\Imagenes\" & r["Rubro"] & ".ico"
                //   If Len(Trim(Dir(mIcono))) <> 0 Then
                //      .row = i
                //      .col = COL_IDARTICULO
                //      Picture1.Width = .CellWidth
                //      Picture1.Height = .CellHeight
                //      Image1.Width = .CellWidth
                //      Image1.Height = .CellHeight
                //      Image1.Stretch = True
                //      'Image1.Picture = img16.ListImages(mIconoRubro).Picture
                //      Image1.Picture = LoadPicture(mIcono)
                //      Picture1.AutoRedraw = True
                //      Picture1.Cls
                //      Picture1.PaintPicture Image1.Picture, 0, 0, Picture1.Width, Picture1.Height
                //      Image1.Picture = LoadPicture("")
                //      Picture1.AutoRedraw = False
                //      Set .CellPicture = Picture1.Image
                //      Picture1.Picture = LoadPicture("")
                //   End If
                //   On Error GoTo ErrorHandler
                //End If

                if (IdObra > 0)
                {
                    DataTable oRs1;

                    mCant = 0;


                    if (mvarComparativaActiva)
                        oRs1 = EntidadManager.GetStoreProcedure(SC, "PresupuestoObrasNodos_tx_DetallePxQ ", r[0], mvarCodigoPresupuesto, mvarCompara1, mvarCompara2);
                    else
                        oRs1 = EntidadManager.GetStoreProcedure(SC, "PresupuestoObrasNodos_tx_DetallePxQ ", r[0], mvarCodigoPresupuesto);



                    foreach (DataRow s in oRs1.Rows)
                    {
                        j = (int)(FechaInicialObra - new DateTime(Convert.ToInt16(s["Año"]), (int)s["Mes"], 1)).TotalDays / 30;
                        mCol = Cant_Columnas + (j * 4);

                        //if (mCol > .Cols)
                        //{          
                        //    //MsgBox "La obra tiene como fecha de inicio " & Me.FechaInicialObra & ", " & vbCrLf & _
                        //    //         "y datos de presupuesto/consumo del mes " & oRs1.Fields("Mes"] & "/" & oRs1.Fields("Año"] & vbCrLf & _
                        //    //         "que genera mas columnas de las soportadas por el sistema, revise los datos", vbExclamation
                        //    break ; //Exit Do
                        //}


                        if (mCol >= 0)
                        {
                            mCant = mCant + (double)s["Cantidad"];
                            mCantidad1 = (double)s["Cantidad"];
                            mCantidad2 = (double)s["CantidadReal"];
                            mImporte1 = (double)s["Importe"];
                            mImporte2 = (double)s["ImporteReal"];
                            mDiferencia = mImporte1 - mImporte2;
                            mDesvio = 0;

                            if (mImporte1 != 0) mDesvio = Math.Round(mDiferencia / mImporte1 * 100, 2);

                            if (mvarComparativaActiva)
                            {
                                TextMatrix[i][mCol + 1] = ((mImporte1 == 0) ? "" : mImporte1.ToString());
                                TextMatrix[i][mCol + 2] = ((mImporte2 == 0) ? "" : mImporte2.ToString());
                                TextMatrix[i][mCol + 3] = ((mDiferencia == 0) ? "" : mDiferencia.ToString());
                                TextMatrix[i][mCol + 4] = ((mDesvio == 0) ? "" : mDesvio.ToString());
                            }
                            else
                            {
                                TextMatrix[i][mCol + 1] = ((mCantidad1 == 0) ? "" : mCantidad1.ToString());
                                TextMatrix[i][mCol + 2] = ((mImporte1 == 0) ? "" : mImporte1.ToString());
                                TextMatrix[i][mCol + 3] = ((mCantidad2 == 0) ? "" : mCantidad2.ToString());
                                TextMatrix[i][mCol + 4] = ((mImporte2 == 0) ? "" : mImporte2.ToString());
                            }

                        }

                    }


                }

                i = i + 1;

            }


            //int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            //var data = (from a in Entidad
            //            select a
            //            )//.Where(campo).OrderBy(sidx + " " + sord)
            //            .ToList();


            var jsonData = new jqGridJson()
            {
                total = 1, //totalPages,
                page = 0, //currentPage,
                records = TextMatrix.ToList().Count, //totalRecords,
                rows = (from a in TextMatrix.ToList()
                        where a != null
                        select new jqGridRowJson
                        {
                            id = a[0], // a.IdCartaDePorte.ToString(),
                            cell = new string[] {
                                "", //"<a href="+ Url.Action("Edit",new {id = a.IdPedido} ) + "  >Editar</>" ,
                                

                                // CP	TURNO	SITUACION	MERC	TITULAR_CP	INTERMEDIARIO	RTE CIAL	CORREDOR	DESTINATARIO	DESTINO	ENTREGADOR	PROC	KILOS	OBSERVACION

                                a[0], // a.IdCartaDePorte.ToString(),

                               "<a href=\"CartaDePorte.aspx?Id=" +  a[0] + "\"  target=\"_blank\" >" +  a[0] + "</>" ,  // "<a href=\"CartaDePorte.aspx?Id=" +  a.IdCartaDePorte + "\"  target=\"_blank\" >" +  a.NumeroCartaEnTextoParaBusqueda.NullSafeToString() + "</>" ,

                a[COL_NODO] ,
                a[COL_NODOPADRE] ,
                a[COL_DEPTH] ,
                a[COL_LINEAGE] ,
                a[COL_OBRA] ,
                a[COL_ITEM] ,
                a[COL_CANTIDAD] ,
                a[COL_UNIMEDIDA] ,
                a[COL_IMPORTE] ,
                a[COL_TOTAL] 

                                //a.Turno, //turno

                                //(a.Situacion ?? 0).NullSafeToString(),
                                ////((a.Situacion ?? 0) >= 0)  ?  ExcelImportadorManager.Situaciones[a.Situacion ?? 0] : "",

                               
                            }
                        }).ToArray()
            };


            return Json(jsonData, JsonRequestBehavior.AllowGet);

            //var jsonData="";
            //System.Web.Script.Serialization.JavaScriptSerializer jsonSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            //return jsonSerializer.Serialize(jsonData);


        }




        [HttpPost]
        public virtual ActionResult CargarArbol_PresupuestoObra_ParaGrillaNoTreeviewEnLocalStorage(FormCollection collection)
        {


            /*   
      Dim oRs As ADOR.Recordset
      Dim mvarIdObra As Long, mIdEtapa As Long
      Dim Imagen As String, mver As String
      Dim mTipoConsumo As Integer, mpresu As Integer
      Dim oNode As Node
   
      mver = ultimaopcion
   
      On Error Resume Next
   
      Set oRs = Aplicacion.PresupuestoObrasNodos.TraerFiltrado("_ParaArbol")
   
      Arbol.Nodes.Clear
      If Lista.ColumnHeaders.Count > 0 Then
         Lista.ListItems.Clear
         Lista.ColumnHeaders.Clear
      End If
   
      With Arbol.Nodes
         .Add , , "O/", "OBRAS", "Obras", "Obras"
         mvarIdObra = 0
         If oRs.RecordCount > 0 Then
            oRs.MoveFirst
            Do While Not oRs.EOF
               If oRs!TipoNodo <> TIPO_ARTICULO And oRs!TipoNodo <> TIPO_RUBRO Then ' And ors!TipoNodo <> TIPO_PRESUPUESTO Then
                  Select Case oRs!TipoNodo
                     Case TIPO_OBRA
                         Imagen = "Obras"
                     Case Else
                         Imagen = "Etapas"
                  End Select
                  .Add "O" & oRs!Lineage, tvwChild, "O" & oRs!Lineage & oRs!IdPresupuestoObrasNodo & "/", iisnull(oRs.Fields("Descripcion").Value, ""), Imagen
               End If
               oRs.MoveNext
            Loop
         End If
         .Item("O/").Expanded = True
      End With
   
      oRs.Close
      Set oRs = Nothing

          */

            // PresupuestoObrasNodos_Inicializar
            int IdObra = -1;
            DataTable oRs = EntidadManager.ExecDinamico(SCsql(), "PresupuestoObrasNodos_tx_ParaArbol " + IdObra);




            //    var children = new List<GetTreeGridValuesResult>();
            int level = 0;
            int parentId = 0;

            List<Tablas.Tree> q;
            List<string> v = new List<string>();






            // If we found out a level, we enter the if
            //if (role != -1)
            //{
            //    // A very important thing to consider is that there
            //    // are two keys being send from the treegrid component:
            //    // 1. [nodeid] that is the id of the node we are expanding
            //    // 2. [n_level] the root is 0, so, if we expand the first child
            //    // of the root element the level will be 1... also if we expand the second
            //    // child of the root, level is 1. And so... 
            //    // If [nodeid] is not found it means that we are not expanding anything,
            //    // so we are at root level.
            if (collection["idsOfExpandedRows"].NullSafeToString() == "" && collection["nodeid"].NullSafeToString() == "")
            {
                // q = TablaTree("01").Where(x => x.ParentId == "01").ToList(); ; // podrias devolver un queryable
                //q = q.Where(x => x.ParentId == "01").ToList();
                q = TablaTree_PresupuestoObra("01").ToList();
                //como hacer si es esxterno, o si tiene permisos a todos los nodos raiz?

                //no hay cacheados nodos expandidos ni el nodo apretado. Debe ser la primera pantalla de la sesión. entonces, debo 
                // mostrar todos los nodos raíces de los que tenga permiso...

            }
            else if (collection.AllKeys.Contains("idsOfExpandedRows"))
            {
                // recbo los nodos por postdata
                // List<string> v = collection["idsOfExpandedRows"].ToList();

                q = TablaTree_PresupuestoObra(); //podrias devolver un queryable


                if (collection["nodeid"].NullSafeToString() == "")
                {
                    // es la primera llamada, debo incluir las raices

                    if (collection["idsOfExpandedRows"] != "") v = collection["idsOfExpandedRows"].ToString().Split(',').ToList();
                    v.Add("01");
                }
                else
                {
                    // apretaron el nodo
                    v.Add(collection["nodeid"].NullSafeToString());
                }

                q = q.Where(x => v.Contains(x.ParentId)).ToList();
            }
            else if (collection.AllKeys.Contains("nodeid"))
            {


                q = TablaTree_PresupuestoObra(); //podrias devolver un queryable

                //In case we are expanding a level, we retrieve the level we are right now
                //In this example i'll explain the 
                //Tree with id's so you can imagine the way i'm concatenating the id's:
                // In this case we are at Agent level that have 2 dealers and each dealer 3 service writters
                // Agent: 5
                //  |_Dealer1: 5_25
                //      |_SW1: 5_25_1
                //      |_SW2: 5_25_2
                //      |_SW3: 5_25_3
                //  |_Dealer2: 5_26
                //      |_SW4: 5_26_4
                //      |_SW5: 5_26_5
                //      |_SW6: 5_26_6
                // So, if we clic over the SW6: the id will be 5_26_6, his parent will be 5_26
                // Dealer2 Id is 5_26 and his parent will be 5.
                level = Generales.Val(collection["n_level"] ?? "0") + 1;
                //First we split the nodeid with '_' that is our split character.
                var stringSplitted = collection["nodeid"].Split('-');
                //the parent id will be located at the last position of the splitted array.
                parentId = int.Parse(stringSplitted[stringSplitted.Length - 1]);
            }
            else
            {

                q = TablaTree_PresupuestoObra();// podrias devolver un queryable

            }

            //Getting childrens
            //var userId = new Guid(Session["UserId"].ToString());
            // children = GetTreeGridValues(role, userId, parentId, level);
            //if (!collection.AllKeys.Contains("idsOfExpandedRows"))
            //{
            //    if (collection["nodeid"].NullSafeToString() != "")
            //    {
            //        q = q.Where(x => x.ParentId == collection["nodeid"].ToString()).ToList();
            //    }
            //    else
            //    {
            //        q = q.Where(x => x.ParentId == "01").ToList();
            //    }
            //}
            //Each children have a name, an id, and a rolename (rolename is just for control)
            //So if we are are root level we send the parameters and we have in return all the children of the root.



            // http://stackoverflow.com/questions/3672041/how-to-use-jqgrid-treegrid-in-mvc-net-2
            // http://stackoverflow.com/questions/16651620/jqgrid-treegrid-cant-collapsing-and-expanding
            //Preparing result
            var filesData = new
            {
                rows = (from child in q
                        select new
                        {
                            descr = (new String('_', ((child.IdItem.Replace("-", "").Length) / 2) * 5)).Replace("_", "&nbsp;") +
                                    (((child.Link ?? "") == "") ? child.Descripcion : child.Link), // Correspond to the colmodel NAME in javascript

                            // The next one correspond to the colmodel ID in javascript Id
                            // If we are are the root level the [nodeid] will be empty as i explained above
                            // So the id will be clean. Following the example, just 5
                            // If we are expanding the Agent 5 so, the [nodeid] will not be empty
                            // so we take the Agent id, 5 and concatenate the child id, so 5_25
                            child.IdItem,
                            child.Link, //Correspond to the colmodel ROLE in javascript 


                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            //The next attributes are obligatory and defines the behavior of the TreeGrid 

                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            //LEVEL: This is the actual level of the child so, root will be 0, that's why i'm adding
                            // one to the level above.
                            l = ((child.IdItem.Replace("-", "").Length) / 2 - 2).ToString(),  // level.ToString(),


                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            //PARENT ID: If we are at the root [nodeid] will be empty so the parent id is ""
                            // In case of a service writter the parent id is the nodeid, because is the node
                            // we are expanding
                            parentid = child.ParentId ?? string.Empty, //  child.ParentId,  // collection["nodeid"] ?? string.Empty,


                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            //IS NOT EXPANDABLE: One thing that was tricky here was that I was using c# true, false
                            //and to make it work it's needed to be strings "true" or "false"
                            // The Child.Role the role name, so i know that if it's a ServiceWriter i'm the last level
                            // so it's not expandable, the optimal way is to get from the database store procedure
                            // if the leaf has children.
                            espadre = (child.EsPadre != "SI" ? "true" : "false").ToString(),


                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            //IS EXPANDED: I use that is always false,
                            iditem = (v.Contains(child.IdItem) ? "true" : "false").ToString()

                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            // LOADED: si está puesto en true, no vuelve a llamar al servidor
                            // , "false" 

                            // http://stackoverflow.com/questions/6508838/in-jqgrid-treegrid-how-can-i-specify-that-i-want-to-load-the-entire-tree-up-fro
                            //                If I understand your question correct, the most important lines of the Tree Grid code to answer on 
                            //                your question you will find here and here. I can describe the code fragment so: 
                            //if the user try to expand a node it will be examined the contain of the hidden column 'loaded' of the node. 
                            //    You can post the contain of 'loaded' column together with the JSON/XML row data. 
                            //    If the 'loaded' column contains false (or the 'loaded' is not set by the server) 
                            //    the parameters nodeid, parentid and n_level will be set and the tree grid will be reloaded.

                        }
                       ).ToArray()
            };

            //Returning json data
            //return Json(filesData);
            //return Json(filesData, JsonRequestBehavior.AllowGet);

            var jsonResult = Json(filesData, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;

        }



        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string activas)
        {
            if (activas == "") { activas = "SI"; }
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numeroProveedor":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaProveedor":
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



            DataTable oRs = EntidadManager.GetStoreProcedure(SCsql(), "obras_tx_activas ", "SI", "SI");




            //int totalRecords = data.Count();
            //int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            //var data1 = (from a in data select a)
            //            .OrderBy(x => x.Descripcion)

//.Skip((currentPage - 1) * pageSize).Take(pageSize)
//.ToList();

            var jsonData = new jqGridJson()
            {
                total = 1,
                page = 0,
                records = oRs.Rows.Count,
                rows = (from DataRow a in oRs.Rows
                        select new jqGridRowJson
                        {
                            id = a[0].NullSafeToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a[0]} ) +" >Editar</>",
                                a[0].NullSafeToString(),
                                a[1].NullSafeToString(),
                                a[2].NullSafeToString(),
                                a[3].NullSafeToString(),
                                a[4].NullSafeToString(),
                                a[5].NullSafeToString(),
                                a[6].NullSafeToString(),
                                a[7].NullSafeToString(),
                                a[8].NullSafeToString(),
                                a[9].NullSafeToString(),
                                a[10].NullSafeToString(),
                   
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


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

//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList()
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
