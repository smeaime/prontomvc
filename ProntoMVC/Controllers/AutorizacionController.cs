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
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Text;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;

using System.Reflection;
using System.Configuration;
using Pronto.ERP.Bll;
using System.Data.SqlClient;



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


   // [Authorize(Roles = "Administrador,SuperAdmin,Autorizaciones,Requerimientos,Comercial,Firmas")] //ojo que el web.config tambien te puede bochar hacia el login

    public partial class AutorizacionController : ProntoBaseController
    {

        //
        // GET: /Autorizacion/

        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.MnuSeg2)) throw new Exception("No tenés permisos");


            //string SC = Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService;
            string SC = Generales.sCadenaConex(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService);
            string usuario = ViewBag.NombreUsuario;
            int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
            if (!Generales.TienePermisosDeFirma(SC, IdUsuario)) throw new Exception("No tiene permisos de autorización");

            //if (db == null)
            //{
            //    FormsAuthentication.SignOut();
            //    return View("ElegirBase", "Home");
            //}

            //var Autorizaciones = db.Autorizaciones
            //    .Where(r => r.NumeroAutorizacion > 0)
            //    .OrderByDescending(r => r.IdAutorizacion); // .NumeroAutorizacion);


            //string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            //DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster, "SELECT * FROM BASES");
            //List<SelectListItem> baselistado = new List<SelectListItem>();
            //foreach (DataRow r in dt.Rows)
            //{
            //    baselistado.Add(new SelectListItem { Text = r["Descripcion"] as string, Value = "" });
            //}


            //ViewBag.Bases = baselistado; // baselistado; // new SelectList(dt.Rows, "IdBD", "Descripcion"); // StringConnection



            //return View(Autorizaciones.ToList());
            resetear();

            return View();
        }



 


        [HttpPost]
        public virtual ActionResult ArbolAutorizaciones()
        {


            // return RedirectToAction("Arbol", "Acceso");
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));


            List<Tablas.Tree> Tree = new List<Tablas.Tree>();


            DataTable dt = EntidadManager.GetStoreProcedure(SC, ProntoFuncionesGenerales.enumSPs.AutorizacionesPorComprobante_TX_Sectores);
            foreach (DataRow dr in dt.Rows)
            {
                Tablas.Tree nodo = new Tablas.Tree();
                nodo.Clave = dr[0].ToString();
                nodo.Descripcion = dr[1].ToString();
                nodo.EsPadre = "SI";
                nodo.IdItem = ProntoFuncionesGenerales.JustificadoDerecha(nodo.Clave, 2, '0');
                nodo.Link = "Autorizaciones\\DocumentosPorAutoriza?IdAutoriza=" + nodo.Clave;
                Tree.Add(nodo);


                DataTable dt2 = EntidadManager.GetStoreProcedure(SC, ProntoFuncionesGenerales.enumSPs.AutorizacionesPorComprobante_TX_AutorizaPorSector, dr[0].ToString());
                foreach (DataRow dr2 in dt2.Rows)
                {
                    Tablas.Tree nodo2 = new Tablas.Tree();
                    nodo2.ParentId = dr[0].ToString();
                    nodo2.Clave = dr2[0].ToString();
                    nodo2.IdItem = ProntoFuncionesGenerales.JustificadoDerecha(nodo.Clave, 2, '0') + '-' + ProntoFuncionesGenerales.JustificadoDerecha(nodo2.Clave, 2, '0');
                    nodo2.Descripcion = dr2[1].ToString();
                    nodo2.EsPadre = "NO";
                    nodo2.Link = "Autorizacion\\DocumentosPorAutoriza?IdAutoriza=" + nodo2.Clave;
                    Tree.Add(nodo2);

                    if (EstaElSuplente(2222)) { }
                }
            }

            return Json(Tree);


        }



        bool EstaElSuplente(int IdTitular)
        {
            //Dim oRs As ADOR.Recordset

            //Set oRs = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_SuplenteDelTitular", _
            //               Array(IdTitular, glbIdUsuario))
            //If oRs.RecordCount > 0 Then
            //   EstaElSuplente = True
            //Else
            //   EstaElSuplente = False
            //End If
            //oRs.Close

            //Set oRs = Nothing
            return false;
        }

        void resetear()
        {
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            string usuario = ViewBag.NombreUsuario;
            int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
            //var idclav = db.ProntoIniClaves.Where(x => x.Clave == "OrigenDescripcion en 3 cuando hay observaciones").Select(x => x.IdProntoIniClave).FirstOrDefault();
            //var idclava = db.ProntoIni.Where(x => x.IdProntoIniClave == idclav && x.IdUsuario == IdUsuario).Select(x => x.Valor).FirstOrDefault();

            string sRespetarPrecedencia = "NO"; // EntidadManager.BuscarClaveINI("Respetar precedencia en circuito de firmas", SC, IdUsuario) == "SI" ? "SI" : "NO";
            //sRespetarPrecedencia = "SI";


            try
            {
                //EntidadManager.GetStoreProcedure(SC, ProntoFuncionesGenerales.enumSPs.AutorizacionesPorComprobante_Generar, sRespetarPrecedencia);
                EntidadManager.Tarea(SC, "AutorizacionesPorComprobante_Generar", sRespetarPrecedencia);
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e);
                throw;
            }
        }


        void nodeclic()
        {

            //If mId(Node.Key, 1, 1) = "I" Then
            //   mKey = VBA.Split(Node.Key, "|")
            //   k_node = CLng(mKey(2))
            //   mIdAutoriza = k_node

            //   If Text2.Text <> Node.Text Then
            //      mFirmaActiva = False
            //      mPassword = ""
            //      mIdFirmante = 0
            //      Label2.Caption = ""
            //   End If

            //   Text1.Text = Node.Parent.Text
            //   Text2.Text = Node.Text

            //   Set oRs = Aplicacion.Empleados.TraerFiltrado("_PorNombre", Node.Text)
            //   If oRs.RecordCount > 0 Then
            //      mIdFirmante = oRs.Fields(0).Value
            //   Else
            //      mIdFirmante = 0
            //   End If
            //   oRs.Close

            //   Set oRs = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_DocumentosPorAutoriza", k_node)


            //ElseIf mId(Node.Key, 1, 1) = "X" Then
            //   mIdAutoriza = k_node
            //   Text1.Text = Node.Parent.Parent.Text
            //   Text2.Text = Node.Parent.Text

            //   Set oRs = Aplicacion.Empleados.TraerFiltrado("_PorNombre", Node.Parent.Text)
            //   If oRs.RecordCount > 0 Then
            //      mIdFirmante = oRs.Fields(0).Value
            //   Else
            //      mIdFirmante = 0
            //   End If
            //   oRs.Close

            //   Set oRs = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_DocumentosPorAutorizaSuplentes", k_node)

            //End If


        }


        public virtual ActionResult DocumentosPorAutoriza(int IdAutoriza)
        {
            return View("Index");
        }

        public virtual ActionResult Autorizaciones(string sidx, string sord, int? page, int? rows, bool? _search, string searchField, string searchOper, string searchString,
                                         string FechaInicial, string FechaFinal, string IdObra)
        {


            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));



            int idautoriza;
            int.TryParse(IdObra, out idautoriza);

            // var dt2 = EntidadManager.ExecDinamico(SC, "SELECT TOP 100 * FROM _TempAutorizaciones");

            SqlParameter FiltroParam = new SqlParameter("@IdAutoriza", SqlDbType.Int);
            FiltroParam.Value = idautoriza;
            var p = new SqlParameter[]
            { 
                FiltroParam
            };


            if (false)
            {
                //List<Object[]> aaaa = TablasDAL.GetStore(this.HttpContext.Session["BasePronto"].ToString(), "AutorizacionesPorComprobante_TX_DocumentosPorAutoriza", p);
                //           _DocumentosPorAutorizaSuplentes



                //var jsonData2 = new jqGridJson()
                //{
                //    total = 1,
                //    page = 1,
                //    records = 1000,
                //    rows = (from a in aaaa
                //            select new 
                //            {
                //                a[2],
                //              a[0].ToString(),
                //              a[1].ToString(),
                //              a[2].ToString(),
                //              a[3].ToString(),
                //              a[4].ToString(),
                //              a[5].ToString(),
                //              a[6].ToString(),
                //              a[7].ToString(),
                //              a[8].ToString(),
                //              a[9].ToString(),
                //              a[10].ToString(),
                //              a[11].ToString()

                //            }).ToArray()

                //};

                //    return Json(jsonData2, JsonRequestBehavior.AllowGet);

            }



            //DataTable dt2 = EntidadManager.GetStoreProcedure(SC, ProntoFuncionesGenerales.enumSPs.AutorizacionesPorComprobante_TX_DocumentosPorAutoriza, idautoriza);
            //DataTable dt2 = TablasDAL.GetStore(this.HttpContext.Session["BasePronto"].ToString(), "AutorizacionesPorComprobante_TX_DocumentosPorAutoriza", p);
            //  var dt2 = TablasDAL.GetStore(this.HttpContext.Session["BasePronto"].ToString(), "AutorizacionesPorComprobante_TX_DocumentosPorAutoriza", p);

            //if (essuplente)
            //{
            //   AutorizacionesPorComprobante_TX_DocumentosPorAutorizaSuplentes
            //}


            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.C_TempAutorizaciones.AsQueryable();
            //if (idautoriza != string.Empty)
            //{
            Fac = (from a in Fac where a.IdAutoriza == idautoriza select a).AsQueryable();
            //}

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

                ErrHandler.WriteError(e);  //throw;
            }


            if (_search ?? false)
            {
                switch (searchField.ToLower())
                {
                    case "numeroComparativa":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaComparativa":
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
                            a.IdAutorizacion,
                            a.IdAutoriza,
                            a.Numero,
                            a.Fecha,
                            a.TipoComprobante,
                            a.OrdenAutorizacion,
                            a.IdFormulario,
                            a.SectorEmisor,
                            a.IdComprobante,
                            a.IdLibero,
                            a.IdSector,


                            //NumeroObra=a.Obra.NumeroObra,
                            //Libero=a.Empleados.Nombre,
                            //Aprobo = a.Empleados1.Nombre,
                            //Sector=a.Sectores.Descripcion,
                            //Detalle=a.Detalle



                            //    //  a["IdComprobante"].ToString(),
                            //    //  a["Documento"].ToString(),
                            //    //  a["Numero"].ToString(),
                            //    //  a["Fecha"].ToString(),
                            //    //  a["Proveedor"].ToString(),
                            //    //  a["Monto p/compra"].ToString(),
                            //    //  a["Monto previsto"].ToString(),
                            //    //  a["Orden"].ToString(),
                            //    //  a[8].ToString(), //mon
                            //    //  a["Obra"].ToString(),
                            //    //  a["Sector"].ToString(),
                            //    //  a["Centro de costo"].ToString(),
                            //    //  a["Cliente"].ToString(),
                            //    //  a["IdFormulario"].ToString(),
                            //    //  a[14].ToString(), //Nro.Orden
                            //    //  a["SectorEmisor"].ToString(),
                            //    //  a["IdObra"].ToString(),
                            //    //  a["IdAux"].ToString(),
                            //    //  a["Cotizacion"].ToString(),
                            //    //  a["Liberado por"].ToString(),
                            //    //  a["Importe Iva"].ToString(),
                            //    //  a["IdAutoriza"].ToString()

                        }).Where(campo);

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);


            var data = (from a in Req1
                        //join c in db.Clientes on a.IdCliente equals c.IdCliente
                        select a)
                //.Where(campo)
                //  .OrderBy(sidx + " " + sord)
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

                            id = a.IdAutorizacion.ToString(),
                            cell = new string[] { 

                                "<a href="+ Url.Action("Imprimir","Comparativa", new {id = a.IdComprobante} )  +">Excel</>" ,
                                "<a  id='firmalink' value='"+ (int) a.IdAutorizacion +"' href='#' >Firmar</>",
                               "<a  href='/Pronto2/Autorizacion/Firmar" + "?idFormulario=" + a.IdFormulario + "&IdComprobante=" + a.IdComprobante + "&OrdenAutorizacion=" + a.IdAutorizacion + "&IdAutorizo=" + a.IdAutoriza + "'  >Firmar</>" ,
                               "<a  onclick='PedirFirma2("+ a.IdFormulario + "," + a.IdComprobante + "," + a.IdAutorizacion + "," + a.IdAutoriza + ")' href='#' >Firmar</>" ,
                               
                               //como es la cosa? el pronto usa IdFormulario=5 para un pedido, y yo acá levanto un 4!!! -no imbecil, es al reves.


                                 //"<a href="+ Url.Action("Edit",new {id = (int) a["IdComprobante"] } )  +" target='_blank' >Editar</>"

                                a.TipoComprobante,
                                a.Numero.ToString(),
                               a.Fecha.Value.ToShortDateString(),
                            
                            

                               /// proveedor
                            (a.IdFormulario == 4 && a.IdComprobante!=null) ?
                                   (db.Pedidos.Find(a.IdComprobante).Proveedor==null ? "" : db.Pedidos.Find(a.IdComprobante).Proveedor.RazonSocial)
                                   :
                            (a.IdFormulario == 31 && a.IdComprobante!=null) ?
                                   (db.ComprobantesProveedor.Find(a.IdComprobante).Proveedor==null ? "" : db.ComprobantesProveedor.Find(a.IdComprobante).Proveedor.RazonSocial)
                                : "" ,

                            // Case When Aut.IdFormulario=4 Then (Select Top 1 Proveedores.RazonSocial From Proveedores  
                            //     Where (Select Top 1 Pedidos.IdProveedor From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido)=Proveedores.IdProveedor)  
                            // When Aut.IdFormulario=31 Then (Select Top 1 Proveedores.RazonSocial From Proveedores  
                            //     Where (Select Top 1 cp.IdProveedor From ComprobantesProveedores cp Where Aut.IdComprobante=cp.IdComprobanteProveedor)=Proveedores.IdProveedor)  
                            // Else Null  
                            // End as [Proveedor],  






                            
                               // a.IdFormulario==5 ?  db.Comparativas.Find(a.IdComprobante) .ImporteComparativaCalculado.NullSafeToString() : "",
                               //a.IdFormulario==5 ?  db.Comparativas.Find(a.IdComprobante) .MontoPrevisto.NullSafeToString() : "",





                                

                            //SELECT    
                            // Aut.IdComprobante as [IdComprobante],  
                            // Aut.TipoComprobante as [Documento],  
                            // Aut.Numero as [Numero],  
                            // Aut.Fecha as [Fecha],  
                            
                            






                            (a.IdFormulario == 3 && a.IdComprobante!=null) ?
                                   (db.Requerimientos.Find(a.IdComprobante).MontoParaCompra==null ? "" : db.Requerimientos.Find(a.IdComprobante).MontoParaCompra.NullSafeToString()) :
                            (a.IdFormulario == 4 && a.IdComprobante!=null) ?
                                   (db.Pedidos.Find(a.IdComprobante).TotalPedido==null ? "" : db.Pedidos.Find(a.IdComprobante).TotalPedido.NullSafeToString()) :
                            (a.IdFormulario == 5 && a.IdComprobante!=null) ?
                                   (db.Comparativas.Find(a.IdComprobante).ImporteComparativaCalculado==null ? "" : db.Comparativas.Find(a.IdComprobante).ImporteComparativaCalculado.NullSafeToString()) :
                            (a.IdFormulario == 31 && a.IdComprobante!=null) ?
                                   (db.ComprobantesProveedor.Find(a.IdComprobante).TotalComprobante==null ? "" : db.ComprobantesProveedor.Find(a.IdComprobante).TotalComprobante.NullSafeToString()) :
                                   "" ,


                            // Case When Aut.IdFormulario=3 Then (Select Top 1 Requerimientos.MontoParaCompra From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)  
                            // When Aut.IdFormulario=4 Then (Select Top 1 Pedidos.TotalPedido From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido)  
                            // When Aut.IdFormulario=5 Then (Select Top 1 Comparativas.ImporteComparativaCalculado From Comparativas Where Aut.IdComprobante=Comparativas.IdComparativa)  
                            // When Aut.IdFormulario=31 Then (Select Top 1 cp.TotalComprobante From ComprobantesProveedores cp Where Aut.IdComprobante=cp.IdComprobanteProveedor)  
                            // Else Null  
                            // End as [Monto p/compra],  





                            (a.IdFormulario == 1 && a.IdComprobante!=null) ?
                                   (db.Acopios.Find(a.IdComprobante).MontoPrevisto==null ? "" : db.Acopios.Find(a.IdComprobante).MontoPrevisto.NullSafeToString()) :
                            (a.IdFormulario == 3 && a.IdComprobante!=null) ?
                                   (db.Requerimientos.Find(a.IdComprobante).MontoPrevisto==null ? "" : db.Requerimientos.Find(a.IdComprobante).MontoPrevisto.NullSafeToString()) :
                                   "" ,

                            // Case When Aut.IdFormulario=1 Then (Select Top 1 Acopios.MontoPrevisto From Acopios Where Aut.IdComprobante=Acopios.IdAcopio)  
                            // When Aut.IdFormulario=3 Then (Select Top 1 Requerimientos.MontoPrevisto From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)  
                            // Else Null  
                            // End as [Monto previsto], 
 




                             a.OrdenAutorizacion.ToString(),
                            // Aut.OrdenAutorizacion as [Orden],  


                            
                            // db.Empleados.Find( a.IdLibero).Nombre.NullSafeToString()
                            a.IdLibero==null ? "" :     db.Empleados.Where(x=> x.IdEmpleado== a.IdLibero).FirstOrDefault().Nombre.NullSafeToString(),
                            //a.IdLibero.NullSafeToString(),
                            // Empleados.Nombre as [Liberado por],  


                            (a.IdFormulario == 4 && a.IdComprobante!=null) ?
                                   (db.Pedidos.Find(a.IdComprobante).Moneda==null ? "" : db.Pedidos.Find(a.IdComprobante).Moneda.Abreviatura.NullSafeToString()) :
                                   "" ,

                            // Case When Aut.IdFormulario=4 Then (Select Top 1 Monedas.Abreviatura From Monedas   
                            //     Where (Select Top 1 Pedidos.IdMoneda From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido)=Monedas.IdMoneda)  
                            // Else Null  
                            // End as [Mon.],  




                            (a.IdFormulario == 1 && a.IdComprobante!=null) ?
                                   (db.Acopios.Find(a.IdComprobante).IdObra==null ? "" : db.Acopios.Find(a.IdComprobante).IdObra.NullSafeToString()) :
                            (a.IdFormulario == 2 && a.IdComprobante!=null) ?
                                   (db.LMateriales.Find(a.IdComprobante).IdObra ==null ? "" : db.LMateriales.Find(a.IdComprobante).IdObra.NullSafeToString()) :
                            (a.IdFormulario == 3 && a.IdComprobante!=null) ?
                                   (db.Requerimientos.Find(a.IdComprobante).Obra ==null ? "" : db.Requerimientos.Find(a.IdComprobante).Obra.NumeroObra.NullSafeToString()) :
                            //(a.IdFormulario == 4 && a.IdComprobante!=null) ?
                            //    (db.DetalleRequerimientos.Where(x=>x.IdRequerimiento== 
                            //            (db.DetallePedidos.Where(y=>y.IdPedido==a.IdComprobante && y.IdDetalleRequerimiento!=null).FirstOrDefault().IdDetalleRequerimiento)
                            //    )
                            //    .FirstOrDefault().Requerimientos.Obra.NumeroObra.NullSafeToString()) :                                          
                            (a.IdFormulario == 31 && a.IdComprobante!=null) ?
                                   (db.ComprobantesProveedor.Find(a.IdComprobante).Obra==null ? "" : db.ComprobantesProveedor.Find(a.IdComprobante).Obra.NumeroObra.NullSafeToString()) :
                                   "" ,
                            // Case When Aut.IdFormulario=1 Then (Select Top 1 Obras.NumeroObra From Obras Where (Select Acopios.IdObra From Acopios Where Aut.IdComprobante=Acopios.IdAcopio )=Obras.IdObra)  
                            // When Aut.IdFormulario=2 Then (Select Top 1 Obras.NumeroObra From Obras Where (Select LMateriales.IdObra From LMateriales Where Aut.IdComprobante=LMateriales.IdLMateriales )=Obras.IdObra)  
                            // When Aut.IdFormulario=3 Then (Select Top 1 Obras.NumeroObra From Obras  
                            //     Where (Select Requerimientos.IdObra From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)=Obras.IdObra)  
                            // When Aut.IdFormulario=4 Then (Select Top 1 Obras.NumeroObra From Obras  
                            //     Where (Select Top 1 Requerimientos.IdObra From Requerimientos  
                            //      Where Requerimientos.IdRequerimiento=  
                            //       (Select Top 1 DR.IdRequerimiento   
                            //        From DetalleRequerimientos DR   
                            //        Where DR.IdDetalleRequerimiento=  
                            //        (Select Top 1 DP.IdDetalleRequerimiento  
                            //         From DetallePedidos DP   
                            //         Where DP.IdPedido=Aut.IdComprobante and   
                            //         DP.IdDetalleRequerimiento is not null)))=Obras.IdObra)  
                            // When Aut.IdFormulario=31 Then (Select Top 1 Obras.NumeroObra From Obras Where (Select ComprobantesProveedores.IdObra From ComprobantesProveedores Where Aut.IdComprobante=ComprobantesProveedores.IdComprobanteProveedor)=Obras.IdObra)  
                            // Else Null  
                            // End as [Obra],  






                              (a.IdFormulario == 3 && a.IdComprobante!=null) ?
                                   (db.Requerimientos.Find(a.IdComprobante).IdSector ==null ? "" : db.Requerimientos.Find(a.IdComprobante).IdSector.NullSafeToString()) :
                                    "",

                            // Case When Aut.IdFormulario=3 Then ( Select Top 1 Sectores.Descripcion   
                            //        From Sectores   
                            //        Where Sectores.IdSector=(Select Top 1 Requerimientos.IdSector From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento))  
                            // Else Null  
                            // End as [Sector],  


                            
                            
                            

                            
                            (a.IdFormulario == 3 && a.IdComprobante!=null) ?
                                   (db.Requerimientos.Find(a.IdComprobante).IdCentroCosto==null ? "" : db.CentrosCostoes.Find(db.Requerimientos.Find(a.IdComprobante).IdCentroCosto).Descripcion.NullSafeToString()) :
                                   "" ,
                            // Case When Aut.IdFormulario=3 Then (Select Top 1 CentrosCosto.Descripcion From CentrosCosto  
                            //     Where (Select Requerimientos.IdCentroCosto From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)=CentrosCosto.IdCentroCosto)  
                            // Else Null  
                            // End as [Centro de costo],  








                            (a.IdFormulario == 1 && a.IdComprobante!=null) ?
                                   (db.Acopios.Find(a.IdComprobante).IdCliente==null ? "" : db.Acopios.Find(a.IdComprobante).IdCliente.NullSafeToString()) :
                            (a.IdFormulario == 2 && a.IdComprobante!=null) ?
                                   (db.LMateriales.Find(a.IdComprobante).IdCliente ==null ? "" : db.LMateriales.Find(a.IdComprobante).IdCliente.NullSafeToString()) :
                            (a.IdFormulario == 3 && a.IdComprobante!=null) ?
                                   (db.Requerimientos.Find(a.IdComprobante).IdObra ==null ? "" : db.Requerimientos.Find(a.IdComprobante).IdObra.NullSafeToString()) :
                                   "" ,

                            // Case When Aut.IdFormulario=1 Then (Select Top 1 Clientes.RazonSocial From Clientes   
                            //     Where (Select Acopios.IdCliente From Acopios Where Aut.IdComprobante=Acopios.IdAcopio)=Clientes.IdCliente)  
                            // When Aut.IdFormulario=2 Then (Select Top 1 Clientes.RazonSocial From Clientes  
                            //     Where (Select LMateriales.IdCliente From LMateriales Where Aut.IdComprobante=LMateriales.IdLMateriales)=Clientes.IdCliente)  
                            // When Aut.IdFormulario=3 Then (Select Top 1 Clientes.RazonSocial From Clientes  
                            //     Where (Select Top 1 Obras.IdCliente From Obras  
                            //      Where (Select Top 1 Requerimientos.IdObra From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)=Obras.IdObra) = Clientes.IdCliente)  
                            // Else Null  
                            // End as [Cliente],  






                            // Aut.IdFormulario as [IdFormulario],  

                            // Aut.OrdenAutorizacion as [Nro.Orden],  




                            (a.IdFormulario == 3 && a.IdComprobante!=null) ?
                                   (db.Requerimientos.Find(a.IdComprobante).IdSector ==null ? "" : db.Requerimientos.Find(a.IdComprobante).IdSector.NullSafeToString()) :
                            (a.IdFormulario == 4 && a.IdComprobante!=null) ?
                                   (a.IdSector.NullSafeToString() ) :
                                   "0" ,
                            // Case When Aut.IdFormulario=3 Then (Select Top 1 Requerimientos.IdSector From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)  
                            // When Aut.IdFormulario=4 Then Aut.IdSector   
                            // Else 0  
                            // End as [SectorEmisor],  
                            
                            



                            
                            (a.IdFormulario == 3 && a.IdComprobante!=null) ?
                                   (db.Requerimientos.Find(a.IdComprobante).MontoParaCompra==null ? "" : db.Requerimientos.Find(a.IdComprobante).MontoParaCompra.NullSafeToString()) :
                            (a.IdFormulario == 4 && a.IdComprobante!=null) ?
                                   (db.Pedidos.Find(a.IdComprobante).TotalPedido==null ? "" : db.Pedidos.Find(a.IdComprobante).TotalPedido.NullSafeToString()) :
                            (a.IdFormulario == 5 && a.IdComprobante!=null) ?
                                   (db.Comparativas.Find(a.IdComprobante).ImporteComparativaCalculado==null ? "" : db.Comparativas.Find(a.IdComprobante).ImporteComparativaCalculado.NullSafeToString()) :
                            (a.IdFormulario == 31 && a.IdComprobante!=null) ?
                                   (db.ComprobantesProveedor.Find(a.IdComprobante).TotalComprobante==null ? "" : db.ComprobantesProveedor.Find(a.IdComprobante).TotalComprobante.NullSafeToString()) :
                                   "" ,
                            // Case When Aut.IdFormulario=3 Then (Select Top 1 Requerimientos.IdObra From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)  
                            // When Aut.IdFormulario=4 Then (Select Top 1 Requerimientos.IdObra From Requerimientos  
                            //     Where Requerimientos.IdRequerimiento=  
                            //      (Select Top 1 DR.IdRequerimiento From DetalleRequerimientos DR   
                            //       Where DR.IdDetalleRequerimiento=(Select Top 1 DP.IdDetalleRequerimiento From DetallePedidos DP Where DP.IdPedido=Aut.IdComprobante and DP.IdDetalleRequerimiento is not null)))  
                            // When Aut.IdFormulario=31 Then (Select Top 1 ComprobantesProveedores.IdObra From ComprobantesProveedores Where Aut.IdComprobante=ComprobantesProveedores.IdComprobanteProveedor)  
                            // Else Null  
                            // End as [IdObra],  



                            // Aut.IdComprobante as [IdAux],  



                            (a.IdFormulario == 4 && a.IdComprobante!=null) ?
                                   (db.Pedidos.Find(a.IdComprobante).CotizacionMoneda==null ? "" : db.Pedidos.Find(a.IdComprobante).CotizacionMoneda.NullSafeToString()) :
                                   "" ,

                            // Case When Aut.IdFormulario=4 Then (Select Pedidos.CotizacionMoneda From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido)  
                            // Else Null  
                            // End as [Cotizacion],  


                            
                            
                            

                            (a.IdFormulario == 4 && a.IdComprobante!=null) ?
                                   (db.Pedidos.Find(a.IdComprobante).TotalIva1==null ? "" : db.Pedidos.Find(a.IdComprobante).TotalIva1.NullSafeToString()) :
                                   "" ,
                            // Case When Aut.IdFormulario=4 Then (Select Top 1 Pedidos.TotalIva1 From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido)  
                            // Else Null  
                            // End as [Importe Iva],  



                            a.IdAutoriza.NullSafeToString(),
                            // Aut.IdAutoriza as [IdAutoriza],  
                            



                            
                            //FROM _TempAutorizaciones Aut  
                            //LEFT OUTER JOIN Empleados ON Aut.IdLibero=Empleados.IdEmpleado  
                            //WHERE Aut.IdAutoriza is not null and Aut.IdAutoriza=@IdAutoriza  
                            //ORDER BY Aut.TipoComprobante,Aut.Numero,Aut.OrdenAutorizacion  







                               // a.SectorEmisor.ToString(), 
                                



                            
                            

                                     //    //  a["IdComprobante"].ToString(),
                            //    //  a["Documento"].ToString(),
                            //    //  a["Numero"].ToString(),
                            //    //  a["Fecha"].ToString(),
                            //    //  a["Proveedor"].ToString(),
                            //    //  a["Monto p/compra"].ToString(),
                            //    //  a["Monto previsto"].ToString(),
                            //    //  a["Orden"].ToString(),
                            //    //  a[8].ToString(), //mon
                            //    //  a["Obra"].ToString(),
                            //    //  a["Sector"].ToString(),
                            //    //  a["Centro de costo"].ToString(),
                            //    //  a["Cliente"].ToString(),
                            //    //  a["IdFormulario"].ToString(),
                            //    //  a[14].ToString(), //Nro.Orden
                            //    //  a["SectorEmisor"].ToString(),
                            //    //  a["IdObra"].ToString(),
                            //    //  a["IdAux"].ToString(),
                            //    //  a["Cotizacion"].ToString(),
                            //    //  a["Liberado por"].ToString(),
                            //    //  a["Importe Iva"].ToString(),
                            //    //  a["IdAutoriza"].ToString()

                                
                            }

                            //    //a.Numero.NullSafeToString(),
                            //    //a.OrdenAutorizacion.NullSafeToString(),
                            //    //a.SectorEmisor.NullSafeToString()


                            //    //id = a["IdFormulario"].ToString(),
                            //    //cell = new string[] { 
                            //    //    "<a href="+ Url.Action("Edit",new {id = (int) a["IdComprobante"] } )  +" target='_blank' >Editar</>"
                            //    //    //+
                            //    //    //"|" +
                            //    //    //"<a href=/Autorizacion/Details/" + a.IdAutorizacion + ">Detalles</a> "
                            //    //    ,
                            //    //    "<a href="+ Url.Action("Imprimir",new {id = (int) a["IdComprobante"]} )  +">Imprimir</>" ,

                            //    //    //"<a href="+ Url.Action("Firmar",new {id = a.IdAutorizacion} )  +">Firmar</>", // con action
                            //    //    "<a  id='firmalink' value='"+ (int) a["IdComprobante"] +"' href='#' >Firmar</>",                                // con jscript
                            //    //  a["IdComprobante"].ToString(),
                            //    //  a["Documento"].ToString(),
                            //    //  a["Numero"].ToString(),
                            //    //  a["Fecha"].ToString(),
                            //    //  a["Proveedor"].ToString(),
                            //    //  a["Monto p/compra"].ToString(),
                            //    //  a["Monto previsto"].ToString(),
                            //    //  a["Orden"].ToString(),
                            //    //  a[8].ToString(), //mon
                            //    //  a["Obra"].ToString(),
                            //    //  a["Sector"].ToString(),
                            //    //  a["Centro de costo"].ToString(),
                            //    //  a["Cliente"].ToString(),
                            //    //  a["IdFormulario"].ToString(),
                            //    //  a[14].ToString(), //Nro.Orden
                            //    //  a["SectorEmisor"].ToString(),
                            //    //  a["IdObra"].ToString(),
                            //    //  a["IdAux"].ToString(),
                            //    //  a["Cotizacion"].ToString(),
                            //    //  a["Liberado por"].ToString(),
                            //    //  a["Importe Iva"].ToString(),
                            //    //  a["IdAutoriza"].ToString()
                        }).ToArray()
            };








            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }





        public virtual FileResult Imprimir(int id) //(int id)
        {

            //string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            //string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.xlsx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            //string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Autorizacion.xlsx";

            ////tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            //System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            //if (MyFile1.Exists) MyFile1.Delete();

            //System.IO.File.Copy(plantilla, output); // 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 



            //Pronto.ERP.BO.Autorizacion comp = AutorizacionManager.GetItem(SC, id, true);

            ////AutorizacionManager.ImpresionDeAutorizacionPorDLLconXML
            ////OpenXML_Pronto.FacturaXML_DOCX(output, fac, SC);

            //var c = AutorizacionXML_XLSX_MVC_ConTags(output, comp, SC, id);
            //c = null;
            ////AutorizacionManager.TraerPieDLL

            //byte[] contents = System.IO.File.ReadAllBytes(output);
            //return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "Autorizacion.xlsx");
            return null;
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



        public virtual JsonResult Autorizaciones_TX_PorFormulario_Comparativa(int IdComprobante, int IdFormulario)
        {


            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            try
            {
                // EntidadManager.Tarea(SC, "AutorizacionesPorComprobante_Generar");
                //   EntidadManager.GetStoreProcedure(SC, ProntoFuncionesGenerales.enumSPs.AutorizacionesPorComprobante_Generar);
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }



            //no pude incluir _TempAutorizaciones en el edmx 
            var dt2 = EntidadManager.ExecDinamico(SC, "SELECT * FROM _TempAutorizaciones WHERE IdComprobante=" + IdComprobante);




            var q = (from x in dt2.AsEnumerable()
                     where ((int)x["IdFormulario"] == IdFormulario &&
                                (int)x["IdComprobante"] == (int)IdComprobante)
                     select new { IdEmpleado = x["IdAutoriza"], Nombre = (db.Empleados.Find(Generales.Val(x["IdAutoriza"].NullSafeToString())) ?? new Empleado()).Nombre }).ToList();

            return Json(q, JsonRequestBehavior.AllowGet);

            DataTable dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, ProntoFuncionesGenerales.enumSPs.Autorizaciones_TX_PorFormulario,
                                                                    Pronto.ERP.Bll.EntidadManager.EnumFormularios.Comparativa,   //@IdFormulario int,  
                                                                    1,  //@IdOrden int,  
                                                                    1, //@IdSectorRM int,  
                                                                    1, //@IdObra int,  
                                                                    0, //@Importe numeric(18,2),   
                                                                    null  //@IdEmpleadoSolo int = Null  
                                                                    );


            //db.Autorizaciones.Where(x=>x.IdFormulario==(int) EntidadManager.EnumFormularios.Comparativa).Select(x=>x.i







            if (dt.Rows.Count == 0) return null;


            var empleados = (from x in dt.AsEnumerable()
                             select new { IdEmpleado = x["IdEmpleado"], Nombre = x["Nombre"] }).ToList();
            return Json(empleados, JsonRequestBehavior.AllowGet);
        }




        public virtual JsonResult Autorizaciones_TX_PorFormulario_Autorizacion(int IdAutorizacion)
        {


            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            try
            {
                // EntidadManager.Tarea(SC, "AutorizacionesPorComprobante_Generar");
                //   EntidadManager.GetStoreProcedure(SC, ProntoFuncionesGenerales.enumSPs.AutorizacionesPorComprobante_Generar);
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }



            //no pude incluir _TempAutorizaciones en el edmx 
            var dt2 = EntidadManager.ExecDinamico(SC, "SELECT * FROM _TempAutorizaciones WHERE IdComprobante=" + IdAutorizacion);




            var q = (from x in dt2.AsEnumerable()
                     where ((int)x["IdFormulario"] == 2 &&
                                (int)x["IdComprobante"] == (int)IdAutorizacion)
                     select new { IdEmpleado = x["IdAutoriza"], Nombre = (db.Empleados.Find((int)x["IdAutoriza"]) ?? new Empleado()).Nombre }).ToList();

            return Json(q, JsonRequestBehavior.AllowGet);

            DataTable dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, ProntoFuncionesGenerales.enumSPs.Autorizaciones_TX_PorFormulario,
                                                                   222,   //@IdFormulario int,  
                                                                    1,  //@IdOrden int,  
                                                                    1, //@IdSectorRM int,  
                                                                    1, //@IdObra int,  
                                                                    0, //@Importe numeric(18,2),   
                                                                    null  //@IdEmpleadoSolo int = Null  
                                                                    );


            //db.Autorizaciones.Where(x=>x.IdFormulario==(int) EntidadManager.EnumFormularios.Autorizacion).Select(x=>x.i







            if (dt.Rows.Count == 0) return null;


            var empleados = (from x in dt.AsEnumerable()
                             select new { IdEmpleado = x["IdEmpleado"], Nombre = x["Nombre"] }).ToList();
            return Json(empleados, JsonRequestBehavior.AllowGet);
        }




        public virtual ActionResult Firmar(int IdFormulario, int IdComprobante, int OrdenAutorizacion, int IdAutorizo) //(int id)
        {

            AutorizacionesPorComprobante1 a = new AutorizacionesPorComprobante1();

            a.IdComprobante = IdComprobante;

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));


            // cuales son los idformulario o idcomprobante???
            // tabla formularios:
            //            2	Lista de materiales
            //3	Requerimiento de materiales
            //4	Nota de Pedido
            //5	Comparativa
            //6	Ajuste de Stock
            //7	Solicitudes de cotizacion
            //8	Solicitud de materiales
            //9	Salida de materiales
            //10	Otros ingresos a almacen
            //11	Recepcion de materiales
            //21	Ordenes de compra
            //22	Remitos
            //23	Facturas de venta
            //24	Devoluciones
            //25	Recibos
            //26	Notas de debito
            //27	Notas de credito
            //31	Comprobantes de proveedores
            //32	Ordenes de pago
            //41	Subdiarios
            //42	Asientos
            //51	Depositos bancarios
            //52	Debitos/Creditos bancarios
            //53	Resumenes de conciliacion
            //54	Plazos fijos



            var dt2 = EntidadManager.ExecDinamico(SC, "SELECT * FROM _TempAutorizaciones WHERE IdComprobante=" + IdComprobante);




            OrdenAutorizacion = (from x in dt2.AsEnumerable()
                                 where ((int)x["IdFormulario"] == IdFormulario &&
                                            (int)x["IdComprobante"] == (int)IdComprobante &&
                                              Generales.Val(x["IdAutoriza"].NullSafeToString()) == (int)IdAutorizo)
                                 select (int)x["OrdenAutorizacion"]).FirstOrDefault();

             


            ObjectParameter o = new ObjectParameter("IdAutorizacionPorComprobante", typeof(int)); // el molestísimo output....


            db.AutorizacionesPorComprobante_A( o,  IdFormulario, IdComprobante, OrdenAutorizacion, IdAutorizo, DateTime.Now, "SI");
            


            //db.AutorizacionesPorComprobante_A( IdFormulario,   //@IdFormulario int,  
            //                                                IdComprobante,//                                                                        @IdComprobante int,
            //                                                     OrdenAutorizacion, //       @OrdenAutorizacion int,
            //                                                       IdAutorizo, //     @IdAutorizo int,
            //                                          DateTime.Now,           //    @FechaAutorizacion datetime,
            //                                                       "SI"     // @Visto varchar(2)
            //                                                     , o
            //                                            );

            //try
            //{
            //    // EntidadManager.Tarea(SC, "AutorizacionesPorComprobante_Generar");
            //    var dt = EntidadManager.GetStoreProcedure(SC, ProntoFuncionesGenerales.enumSPs.AutorizacionesPorComprobante_A,
            //                             Pronto.ERP.Bll.EntidadManager.EnumFormularios.Autorizacion,   //@IdFormulario int,  
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


            resetear();
            
            db.AutorizacionesPorComprobante_CircuitoFirmasCompleto(IdFormulario, IdComprobante);

            return RedirectToAction("DocumentosPorAutoriza", new { IdAutoriza = IdAutorizo });




            // hasta simplificar y unificar la lógica de autorizaciones, hagamos así: 
            // si el usuario aparece en la lista de quienes firmaron, rajo.
            // dejo entonces que firme, aumentando en 1 el ordendeautorizacion anterior.


            //var firmasesquema = (from c in db.Autorizaciones
            //                     join d in db.DetalleAutorizaciones on c.IdAutorizacion equals d.IdAutorizacion
            //                     where c.IdFormulario == (int)EntidadManager.EnumFormularios.Autorizacion
            //                     select d).ToList();


            //var firmashechas = (from f in db.AutorizacionesPorComprobante1
            //                    where (f.IdFormulario == (int)EntidadManager.EnumFormularios.Autorizacion &&
            //                    f.IdComprobante == IdComprobante)
            //                    select f).ToList();

            //if (firmashechas.Select(x => x.IdAutorizo).Contains(IdAutorizo))
            //{
            //    throw new Exception("El usuario " + IdAutorizo + " ya firmó antes este comprobante");
            //}

            //a.OrdenAutorizacion = (firmashechas.Select(x => x.OrdenAutorizacion).Max() ?? 0) + 1;





            //no puedo // ir a ver qué orden de autorizacion tienE?
            //a.IdAutorizo = IdAutorizo;


            //a.IdFormulario = (int)EntidadManager.EnumFormularios.Autorizacion;
            //a.FechaAutorizacion = DateTime.Now;

            //db.AutorizacionesPorComprobante1.Add(a);
            //db.SaveChanges();




            resetear();



            return RedirectToAction("Index");
        }


    }

}



