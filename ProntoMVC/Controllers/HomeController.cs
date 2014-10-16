using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using ProntoMVC.Models;

using Pronto.ERP.Bll;
using System.Web.Security;
using System.Configuration;
using System.Data;

namespace ProntoMVC.Controllers
{
    public partial class HomeController : ProntoBaseController
    {

        string ROOT;

        protected override void Initialize(System.Web.Routing.RequestContext rc)
        {
            base.Initialize(rc);
            ROOT = ConfigurationManager.AppSettings["Root"];
        }

        public virtual ActionResult Index()
        {


            var u = Membership.GetUser();
            string SC = (this.Session["BasePronto"] ?? "").ToString();

            // verificar conexion si es la primera vez (solo en modo desarrollo)
            //string sc = Generales.sCadenaConex(sBase);
            //var db = new DemoProntoEntities(sc);
            try
            {
                //if (sc == "" || u == null)
                //{
                //    FormsAuthentication.SignOut();
                //return RedirectToAction("Index", "Home");
                //}
                //  return View();
            }
            catch (Exception ex)
            {
                //FormsAuthentication.SignOut();
                //return RedirectToAction("Index", "Home");
            }

            ViewBag.Message = "ASP.NET MVC";


            // string SC = Generales.sCadenaConexSQL(this.Session["BasePronto"].ToString());
            string usuario = u.UserName; // ViewBag.NombreUsuario;
            try
            {
                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e);
                return RedirectToAction("Index", "UserAdministration", new { area = "MvcMembership" });
            }



            try
            {
                if (Roles.IsUserInRole(usuario, "Firmas") && Roles.GetRolesForUser(usuario).Count() == 1) // Generales.TienePermisosDeFirma(SC, IdUsuario))
                {
                    return RedirectToAction("Index", "Autorizacion", new { area = "" });
                    //return View("Autorizacion", "Index");
                }
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e);
                // throw;
            }

            return View();



        }

        public virtual ActionResult About()
        {
            return View();
        }



        List<Tablas.Tree> TablaTree()
        {
            // return RedirectToAction("Arbol", "Acceso");

            List<Tablas.Tree> Tree = TablasDAL.Arbol(this.Session["BasePronto"].ToString()); //esta llamada tarda
            List<Tablas.Tree> TreeDest = new List<Tablas.Tree>();
            List<Tablas.Tree> TreeDest2 = new List<Tablas.Tree>();

            string usuario = ViewBag.NombreUsuario;
            int IdUsuario;
            try
            {
                IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
            }
            catch (Exception)
            {
                throw; // Exception("No se encuentra el usuario");
            }

            var permisos = (from i in db.EmpleadosAccesos where i.IdEmpleado == IdUsuario select i).ToList();
            var z = from n in Tree
                    join p in permisos on n.Clave equals p.Nodo
                    select new { n, p };

            TreeDest = new List<Tablas.Tree>(Tree); //la duplico



            bool essuperadmin = Roles.IsUserInRole(usuario, "SuperAdmin");
            bool esadmin = Roles.IsUserInRole(usuario, "Administrador");
            bool escomercial = Roles.IsUserInRole(usuario, "Comercial");
            bool esfactura = Roles.IsUserInRole(usuario, "FacturaElectronica");
            bool esreq = Roles.IsUserInRole(usuario, "Requerimientos");
            bool esExterno = Roles.IsUserInRole(usuario, "Externo");
            bool escompras = Roles.IsUserInRole(usuario, "Compras");
            bool esFondoFijo = Roles.IsUserInRole(usuario, "FondosFijos");

            foreach (Tablas.Tree o in Tree)
            {
                int? nivel;


                nivel = 9;


                if (essuperadmin)
                {
                    nivel = 1;
                }
                else if (escomercial &&
                    (o.Clave.Contains("Comercial")
                    || o.Clave.Contains("IBCondici")
                    || o.Clave.Contains("Ganancia")
                    || o.Clave.Contains("IGCondici")
                    || o.Clave.Contains("Cliente")
                    || o.Clave.Contains("ListasPrecio")
                    || o.Clave.Contains("PuntosVenta")
                    || o.Clave.Contains("Concepto")
                    || o.Clave.Contains("OrdenesCom")
                    || o.Clave.Contains("Remito")
                    || o.Clave.Contains("OPago")
                    || o.Clave.Contains("Recibo")
                    || o.Clave.Contains("NotasCredito")
                    || o.Clave.Contains("NotasDebito")
                    || o.Clave.Contains("CondicionesCompra")
                    || o.Clave.Contains("Factura")
                    || o.Clave.Contains("CtasCtesD")
                    || o.Clave.Contains("Compras")
                    || o.Clave.Contains("Comparativa")
                    ))
                {
                    nivel = 1;
                }
                else if (esfactura &&
                    (o.Clave.Contains("Comercial")
                    || o.Clave.Contains("IBCondici")
                    || o.Clave.Contains("Ganancia")
                    || o.Clave.Contains("IGCondici")
                    || o.Clave.Contains("Cliente")
                    || o.Clave.Contains("ListasPrecio")
                    || o.Clave.Contains("PuntosVenta")
                    || o.Clave.Contains("Concepto")
                    || o.Clave.Contains("CondicionesCompra")
                    || o.Clave.Contains("Factura")
                    || o.Clave.Contains("CtasCtesD")
                    ))
                {
                    nivel = 1;
                }
                else if ((escomercial || esfactura) && (o.Clave.Contains("Factura") || o.Clave.Contains("Articulo") || o.Clave.Contains("Comercial") || o.Clave.Contains("CtasCtesD")))
                {
                    nivel = 1;
                }
                else if ((esreq) && (o.Clave.Contains("Requerimiento") || o.Clave.Contains("Articulo")))
                {
                    nivel = 1;
                }

                else if ((escompras) && (o.Clave.Contains("Comparativa") || o.Clave.Contains("Compras") || o.Clave.Contains("Presupuesto") || o.Clave.Contains("Pedido") || o.Clave.Contains("Cotizaci") || o.Clave.Contains("CtasCtesA") || o.Clave.Contains("ComprobantesPrv") || o.Clave.Contains("ComprobanteProveedor")))
                {
                    nivel = 1;
                }
                else if (esExterno && o.Clave.Contains("Presupuesto"))
                {
                    nivel = 1;
                }
                else if (esFondoFijo && (o.Clave.Contains("FondoFijo") || o.Clave.Contains("FondosFijos") || o.Clave.Contains("Compras") || o.Clave.Contains("ComprobantesPrv") || o.Clave.Contains("ComprobanteProveedor")))
                {
                    nivel = 1;
                }

                else if (o.Clave.Contains("Ppal"))
                {
                    nivel = 1;
                }
                else
                {
                    nivel = 9;
                }



                int? nivelpronto = permisos.Where(x => x.Nodo == o.Clave).Select(x => x.Nivel).FirstOrDefault();
                if (nivelpronto != null)
                {
                    if (nivelpronto > nivel || true)
                    {
                        nivel = nivelpronto; // si el nivel del pronto es mas bajo (mayor) que el de web, tiene prioridad el nivel pronto 
                    }
                }
                else
                {

                }


                o.nivel = nivel ?? 9;


                if (nivel >= 9)
                {
                    o.Descripcion = "Bloqueado!";
                    eliminarNodoySusHijos(o, ref TreeDest);
                }
                else
                {
                    // TreeDest.Add(o);
                }
            }

            if (esExterno)
            {
                var n = new Tablas.Tree();
                if (Roles.IsUserInRole(usuario, "Externo"))
                {
                    string nombreproveedor="";
                    try
                    {
                        Guid oGuid = (Guid)Membership.GetUser().ProviderUserKey;
                        string cuit = DatosExtendidosDelUsuario_GrupoUsuarios(oGuid);
                        int idproveedor = buscaridproveedorporcuit(cuit);
                        if (idproveedor <= 0)
                        {
                            idproveedor = buscaridclienteporcuit(cuit);
                            if (idproveedor > 0) nombreproveedor = db.Clientes.Find(idproveedor).RazonSocial;
                        }
                        else
                        {
                            nombreproveedor = db.Proveedores.Find(idproveedor).RazonSocial;
                        }

                    }
                    catch (Exception)
                    {

                        nombreproveedor = "Sin CUIT";
                    }

                    n.Link = nombreproveedor; // "<a href=\"#\">" + nombreproveedor + "</a>";
                    n.Descripcion = "CUIT";
                    n.Clave = "CUIT";
                    n.EsPadre = "NO"; // "SI";
                    n.IdItem = "1";
                    n.ParentId = "01";
                    n.Orden = 1;
                    TreeDest.Add(n);
                }


                string urldominio = ConfigurationManager.AppSettings["UrlDominio"];

                n = new Tablas.Tree();
                if (Roles.IsUserInRole(usuario, "ExternoPresupuestos"))
                {
                    n.Link = "<a href='" + urldominio + "Presupuesto/IndexExterno'>Mis Presupuestos</a>";
                    n.Descripcion = "Presupuesto";
                    n.Clave = "Presupuesto";
                    n.EsPadre = "NO";
                    n.IdItem = "1";
                    n.ParentId = "01";
                    n.Orden = 1;
                    TreeDest.Add(n);
                }

                if (Roles.IsUserInRole(usuario, "ExternoCuentaCorrienteProveedor"))
                {

                    //n = new Tablas.Tree();
                    //n.Link = "<a href=\"/Pronto2/CuentaCorriente/IndexExterno\">Mi Cuenta Corriente</a>";
                    //n.Descripcion = "CuentasDeudor";
                    //n.Clave = "CuentasDeudor";
                    //n.EsPadre = "NO";
                    //n.IdItem = "1";
                    //n.ParentId = "";
                    //n.Orden = 1;
                    //TreeDest.Add(n);


                    n = new Tablas.Tree();
                    n.Link = "<a href='" + urldominio + "Reporte.aspx?ReportName=Resumen Cuenta Corriente Acreedores'>Mi Cuenta Corriente</a>";
                    n.Descripcion = "CuentasAcreedor";
                    n.Clave = "CuentasAcreedor";
                    n.EsPadre = "NO";
                    n.IdItem = "1";
                    n.ParentId = "01";
                    n.Orden = 1;
                    TreeDest.Add(n);
                }

                if (Roles.IsUserInRole(usuario, "ExternoCuentaCorrienteCliente"))
                {

                    //n = new Tablas.Tree();
                    //n.Link = "<a href=\"/Pronto2/CuentaCorriente/IndexExterno\">Mi Cuenta Corriente</a>";
                    //n.Descripcion = "CuentasDeudor";
                    //n.Clave = "CuentasDeudor";
                    //n.EsPadre = "NO";
                    //n.IdItem = "1";
                    //n.ParentId = "";
                    //n.Orden = 1;
                    //TreeDest.Add(n);


                    n = new Tablas.Tree();
                    n.Link = "<a href='" + urldominio + "Reporte.aspx?ReportName=Resumen Cuenta Corriente Deudores'>Mi Cuenta Corriente</a>";
                    n.Descripcion = "CuentasDeudor";
                    n.Clave = "CuentasDeudor";
                    n.EsPadre = "NO";
                    n.IdItem = "1";
                    n.ParentId = "01";
                    n.Orden = 1;
                    TreeDest.Add(n);
                }
                if (Roles.IsUserInRole(usuario, "ExternoOrdenesPagoListas"))
                {

                    n = new Tablas.Tree();
                    n.Link = "<a href='" + urldominio + "OrdenPago/IndexExterno'>Mis Pagos en Caja</a>";
                    n.Descripcion = "OrdenesPago";
                    n.Clave = "OrdenesPago";
                    n.EsPadre = "NO";
                    n.IdItem = "1";
                    n.ParentId = "01";
                    n.Orden = 1;
                    TreeDest.Add(n);


                }



            }
            //return Json(Tree);

            //foreach (Tablas.Tree o in TreeDest)
            //{
            //    var padre = TreeDest.Where(x => x.IdItem == o.ParentId).SingleOrDefault();
            //    if (padre == null) continue;

            //    TreeDest2.Add(o);
            //}


            //////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////

            //hay que volar los nodos de fondo fijo

            if ((glbUsuario.IdCuentaFondoFijo ?? 0) > 0)
            {
                string nombrecuentaff = db.Cuentas.Find(glbUsuario.IdCuentaFondoFijo ?? 0).Descripcion;
                nombrecuentaff = nombrecuentaff.Substring(0, (nombrecuentaff.Length > 30) ? 30 : nombrecuentaff.Length);
                var l = TreeDest.Where(n => n.ParentId == "01-11-16-07" && n.Descripcion != nombrecuentaff).ToList();
                foreach (Tablas.Tree n in l)
                {
                    eliminarNodoySusHijos(n, ref TreeDest);
                }
            }

            //////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////




            //reemplazo el directorio falso de sql por el parametro ROOT
            foreach (Tablas.Tree n in TreeDest)
            {
                n.Link = n.Link.Replace("Pronto2", ROOT);
            }




            return TreeDest;

        }






        [HttpPost]
        public virtual ActionResult Arbol()
        {


            return Json(TablaTree());


        }


        public virtual JsonResult ArbolJqgridTree()
        {
            var q = TablaTree();


            var jsonData = new jqGridJson()
            {
                total = 2,
                page = 1,
                records = 100,
                rows = (from a in q
                        select new jqGridRowJson
                        {
                            id = a.IdItem.ToString(),
                            cell = new string[] {
                                 a.IdItem.ToString(),
                                a.Clave.ToString(),
                                a.Descripcion.ToString()

                                 //ID = product.ID,
                                 // Name = product.Name,
                                 // Price = product.Price,
                                 // Color = product.Color,
                                 // Quantity = product.Quantity,
                                 // tree_level = level,
                                 // tree_leaf = IsLeafRow(product.ID),
                                 // tree_expanded = false,
                                 // tree_parent = parentID
                            
                            }

                        }).ToArray()
            };

            //http://stackoverflow.com/questions/3672041/how-to-use-jqgrid-treegrid-in-mvc-net-2
            // http://stackoverflow.com/questions/9715697/jqgrid-treegrid-setup-to-load-child-on-demandon-expansion-for-json-data
            // http://www.trirand.com/jqgridwiki/doku.php?id=wiki%3aadjacency_model#what_we_post

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }




        [HttpPost]
        public virtual ActionResult TreeGrid(FormCollection collection)
        {
            //http://stackoverflow.com/questions/3672041/how-to-use-jqgrid-treegrid-in-mvc-net-2
            // http://stackoverflow.com/questions/9715697/jqgrid-treegrid-setup-to-load-child-on-demandon-expansion-for-json-data
            // http://www.trirand.com/jqgridwiki/doku.php?id=wiki%3aadjacency_model#what_we_post
            // http://stackoverflow.com/questions/16651620/jqgrid-treegrid-cant-collapsing-and-expanding

            int role = -1;
            //Here we get the Roles names this user
            //In my case IsAgent, IsDealer, IsServiceWritter
            //One user can have all roles or any role
            //So the first important thing is get the
            //highest hierarchy role, in this case "IsAgent"
            //And asign to this role a code.
            //So IsAgent = 2, IsDealer = 1, IsServiceWritter = 0

            //var rolesArray = (string[])Session["Roles"];
            //// We search for the highest hiearchy level and 
            //// end up the loop
            //foreach (var s in rolesArray)
            //{
            //    if (s ==  ROLE_NAME_AGENT)
            //    {
            //        role = (int)RolesEnum.Agent;
            //        break;
            //    }
            //    else
            //    {
            //        if (s == ROLE_NAME_DEALER)
            //        {
            //            role = (int)RolesEnum.Dealer;
            //            break;
            //        }
            //        else
            //        {

            //            if (s == ROLE_NAME_SW)
            //            {
            //                role = (int)RolesEnum.SW;
            //                break;
            //            }
            //        }
            //    }
            //}




            //    var children = new List<GetTreeGridValuesResult>();
            int level = 0;
            int parentId = 0;

            List<Tablas.Tree> q;
            List<string> v = new List<string>();

            q = TablaTree();

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
                q = q.Where(x => x.ParentId == "01").ToList();
            }
            else if (collection.AllKeys.Contains("idsOfExpandedRows"))
            {
                // recbo los nodos por postdata
                // List<string> v = collection["idsOfExpandedRows"].ToList();



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
                page = 1,
                total = 1,
                records = q.Count(),   // children.Count(),
                rows = (from child in q
                        select new
                        {
                            id = child.IdItem.ToString(),

                            // http://stackoverflow.com/questions/16651620/jqgrid-treegrid-cant-collapsing-and-expanding
                            // El problema de que no se contrae (collapse) el nodo
                            // Oleg- You use wrong data for "parent" column. It should contains the id of parent node, but 
                            // you use szAccCode. You use values like "300-0-000" and 310-0-000" instead of "6" and "7".

                            //table of cells values
                            cell = new[] {
                            (child.Link=="") ?    child.Descripcion :  child.Link, // Correspond to the colmodel NAME in javascript
                            
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
                           ((child.IdItem.Replace("-","").Length) / 2-2).ToString()  ,  // level.ToString(),
                            
                           
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                           //PARENT ID: If we are at the root [nodeid] will be empty so the parent id is ""
                            // In case of a service writter the parent id is the nodeid, because is the node
                            // we are expanding
                            child.ParentId ?? string.Empty, //  child.ParentId,  // collection["nodeid"] ?? string.Empty,
                            
                           
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                           //IS NOT EXPANDABLE: One thing that was tricky here was that I was using c# true, false
                            //and to make it work it's needed to be strings "true" or "false"
                            // The Child.Role the role name, so i know that if it's a ServiceWriter i'm the last level
                            // so it's not expandable, the optimal way is to get from the database store procedure
                            // if the leaf has children.
                            (child.EsPadre!="SI" ? "true" : "false" ).ToString(),
                           
                            
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            //IS EXPANDED: I use that is always false,
                            (v.Contains(child.IdItem)  ? "true" : "false" ).ToString()
                            
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            // LOADED: si está puesto en true, no vuelve a llamar al servidor
                            , "false" 

                            // http://stackoverflow.com/questions/6508838/in-jqgrid-treegrid-how-can-i-specify-that-i-want-to-load-the-entire-tree-up-fro
                   //                If I understand your question correct, the most important lines of the Tree Grid code to answer on 
                    //                your question you will find here and here. I can describe the code fragment so: 
                    //if the user try to expand a node it will be examined the contain of the hidden column 'loaded' of the node. 
                    //    You can post the contain of 'loaded' column together with the JSON/XML row data. 
                    //    If the 'loaded' column contains false (or the 'loaded' is not set by the server) 
                    //    the parameters nodeid, parentid and n_level will be set and the tree grid will be reloaded.

                          }
                        }
                       ).ToArray()
            };

            //Returning json data
            return Json(filesData);

        }

        [HttpPost]
        public virtual ActionResult TreeGridConNiveles_Todos(FormCollection collection)
        {
            //http://stackoverflow.com/questions/3672041/how-to-use-jqgrid-treegrid-in-mvc-net-2
            // http://stackoverflow.com/questions/9715697/jqgrid-treegrid-setup-to-load-child-on-demandon-expansion-for-json-data
            // http://www.trirand.com/jqgridwiki/doku.php?id=wiki%3aadjacency_model#what_we_post
            // http://stackoverflow.com/questions/16651620/jqgrid-treegrid-cant-collapsing-and-expanding

            int role = -1;
            //Here we get the Roles names this user
            //In my case IsAgent, IsDealer, IsServiceWritter
            //One user can have all roles or any role
            //So the first important thing is get the
            //highest hierarchy role, in this case "IsAgent"
            //And asign to this role a code.
            //So IsAgent = 2, IsDealer = 1, IsServiceWritter = 0

            //var rolesArray = (string[])Session["Roles"];
            //// We search for the highest hiearchy level and 
            //// end up the loop
            //foreach (var s in rolesArray)
            //{
            //    if (s ==  ROLE_NAME_AGENT)
            //    {
            //        role = (int)RolesEnum.Agent;
            //        break;
            //    }
            //    else
            //    {
            //        if (s == ROLE_NAME_DEALER)
            //        {
            //            role = (int)RolesEnum.Dealer;
            //            break;
            //        }
            //        else
            //        {

            //            if (s == ROLE_NAME_SW)
            //            {
            //                role = (int)RolesEnum.SW;
            //                break;
            //            }
            //        }
            //    }
            //}




            //    var children = new List<GetTreeGridValuesResult>();
            int level = 0;
            int parentId = 0;

            List<Tablas.Tree> q;


            // q = TablaTree();
            int idusuario = Generales.Val(collection["IdEmpleado"]); // 303; //= Membership.GetUser();

            if (idusuario == -1)
            {
                var u = Membership.GetUser();
                string usuario = u.UserName;
                idusuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
            }


            q = TreeConNiveles(idusuario, this.Session["BasePronto"].ToString(), ViewBag.NombreUsuario);

            //var l = q.Where(n => n.Descripcion == "Bloqueado!" || n.Descripcion == "NO MOSTRAR" || n.Descripcion.StartsWith("por ")).ToList();

            //foreach (Tablas.Tree n in l)
            //{
            //    eliminarNodoHijos(n, ref q);
            //}





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
            if (true)
            {
                // devuelvo todo
            }
            else if (collection["idsOfExpandedRows"].NullSafeToString() == "" && collection["nodeid"].NullSafeToString() == "")
            {
                q = q.Where(x => x.ParentId == "01").ToList();
            }
            else if (collection.AllKeys.Contains("idsOfExpandedRows"))
            {
                // recbo los nodos por postdata
                // List<string> v = collection["idsOfExpandedRows"].ToList();

                List<string> v = new List<string>();
                if (collection["idsOfExpandedRows"] != "") v = collection["idsOfExpandedRows"].ToString().Split(',').ToList();

                if (collection["nodeid"].NullSafeToString() == "")
                {
                    // es la primera llamada, debo incluir las raices
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
                page = 1,
                total = 1,
                records = q.Count(),   // children.Count(),
                rows = (from child in q
                        select new
                        {
                            id = child.IdItem.ToString(),

                            // http://stackoverflow.com/questions/16651620/jqgrid-treegrid-cant-collapsing-and-expanding
                            // El problema de que no se contrae (collapse) el nodo
                            // Oleg- You use wrong data for "parent" column. It should contains the id of parent node, but 
                            // you use szAccCode. You use values like "300-0-000" and 310-0-000" instead of "6" and "7".

                            //table of cells values
                            cell = new[] {
                            child.Descripcion, // Correspond to the colmodel NAME in javascript
                            
                            // The next one correspond to the colmodel ID in javascript Id
                            // If we are are the root level the [nodeid] will be empty as i explained above
                            // So the id will be clean. Following the example, just 5
                            // If we are expanding the Agent 5 so, the [nodeid] will not be empty
                            // so we take the Agent id, 5 and concatenate the child id, so 5_25
                             child.IdItem,
                            child.Link, //Correspond to the colmodel ROLE in javascript 
                            child.nivel.ToString(), //Correspond to the colmodel ROLE in javascript 
                            
                            child.Clave.ToString(),

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
                           ((child.IdItem.Replace("-","").Length) / 2-2).ToString()  ,  // level.ToString(),
                            
                           
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                           //PARENT ID: If we are at the root [nodeid] will be empty so the parent id is ""
                            // In case of a service writter the parent id is the nodeid, because is the node
                            // we are expanding
                            child.ParentId ?? string.Empty, //  child.ParentId,  // collection["nodeid"] ?? string.Empty,
                            
                           
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                           //IS NOT EXPANDABLE: One thing that was tricky here was that I was using c# true, false
                            //and to make it work it's needed to be strings "true" or "false"
                            // The Child.Role the role name, so i know that if it's a ServiceWriter i'm the last level
                            // so it's not expandable, the optimal way is to get from the database store procedure
                            // if the leaf has children.
                            (child.EsPadre!="SI" ? "true" : "false" ).ToString(),
                           
                            
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            //IS EXPANDED: I use that is always false,
                            "false"
                            
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            // LOADED: si está puesto en true, no vuelve a llamar al servidor
                            , "true" 

                            // http://stackoverflow.com/questions/6508838/in-jqgrid-treegrid-how-can-i-specify-that-i-want-to-load-the-entire-tree-up-fro
                   //                If I understand your question correct, the most important lines of the Tree Grid code to answer on 
                    //                your question you will find here and here. I can describe the code fragment so: 
                    //if the user try to expand a node it will be examined the contain of the hidden column 'loaded' of the node. 
                    //    You can post the contain of 'loaded' column together with the JSON/XML row data. 
                    //    If the 'loaded' column contains false (or the 'loaded' is not set by the server) 
                    //    the parameters nodeid, parentid and n_level will be set and the tree grid will be reloaded.

                          }
                        }
                       ).ToArray()
            };

            //Returning json data
            return Json(filesData);

        }



        public virtual JsonResult Superbuscador(string term)
        {

            Dictionary<string, string> dic = new Dictionary<string, string> { };

            dic.Add("Comprobantes de Proveedor", "/ProntoWeb/ComprobantesPrv.aspx");
            dic.Add("CP Nuevo Comprobante de Proveedor", "/ProntoWeb/ComprobantePrv.aspx?Id=-1");
            dic.Add("Conceptos", "Concepto/");
            dic.Add("Tabla de ganancias", "Ganancia/");
            dic.Add("Categorias Ganancias", "Categoria/");
            dic.Add("Condiciones de venta", "CondicionesVenta/");
            dic.Add("Puntos de venta", "PuntosVenta/");
            dic.Add("Categorias IIBB", "IngresosBruto/");
            dic.Add("Listas de Precios", "ListasPrecio/");
            dic.Add("Clientes resumido", "Cliente/");
            dic.Add("Clientes detallado", "Cliente/");
            dic.Add("Comparativas", "Comparativa/");
            dic.Add("Proveedores", "Proveedor/");
            dic.Add("Facturas", "Factura/");
            dic.Add("Requerimientos", "Requerimiento/");
            dic.Add("Notas de Pedidos", "Pedido/");
            dic.Add("Cuenta Corriente Deudores - Ctas. Ctes.", "Reporte.aspx");
            dic.Add("Solicitudes de Cotización - Presupuestos ", "Presupuesto/");


            //var lista = EntidadManager.GetStoreProcedure("", enumSPs.wbusqueda, prefixText);
            var sc = Generales.sCadenaConexSQL(this.Session["BasePronto"].ToString());
            DataTable lista2 = EntidadManager.GetStoreProcedure(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(sc), "wbusqueda", term);

            foreach (DataRow dr in lista2.Rows)
            {
                // dt.Add(dr[0].ToString(), dr[1].ToString());

                try
                {
                    dic.Add(dr[2].ToString() + " " + dr[1].ToString(), dr[2].ToString() + "/Edit/" + dr[0].ToString());

                }
                catch (Exception)
                {

                    // throw;
                }

            }







            var ci = new System.Globalization.CultureInfo("en-US");



            var lista = (from item in dic
                         where item.Key.ToString().ToLower().Contains(term.ToLower())
                         orderby item.Value
                         select new
                         {
                             id = item.Value,
                             value = item.Key,
                             codigo = item.Key
                         }).ToList();



            //////////////////////////////////////////////////////////////
            int cantarti = lista.Where(x => x.value.Contains("Artículo")).Count();

            if (cantarti > 0)
            {

                lista.Add(new { id = "Artículos", value = "Artículos", codigo = "" }); // agrego un título de agrupamiento
            }
            if (cantarti == 10)
            {

                lista.Add(new { id = "Artículo", value = "Ver más resultados", codigo = "" });// aviso que no muestro todos

            }


            /////////////////////////////////////////////////////////////////////


            if (lista.Count == 0)
            {
                lista.Add(new { id = "", value = "No se encontraron resultados", codigo = "" });
            }
            else
            {
                //  lista.Add(new { id = "Busqueda?Id=" + term, value = " Ver más resultados ", codigo = "" });
            }


            return Json(lista, JsonRequestBehavior.AllowGet);
        }





        public virtual ActionResult Menu()
        {

            string usuario = ViewBag.NombreUsuario;
            if (Roles.IsUserInRole(usuario, "Firmas") && Roles.GetRolesForUser(usuario).Count() == 1) // Generales.TienePermisosDeFirma(SC, IdUsuario))
            {
                return null;
            }

            if ((Roles.IsUserInRole(usuario, "Externo") || Roles.IsUserInRole(usuario, "AdminExterno")) && !Roles.IsUserInRole(usuario, "Administrador") && !Roles.IsUserInRole(usuario, "SuperAdmin")) // Generales.TienePermisosDeFirma(SC, IdUsuario))
            {
                return null;
            }


            List<Tablas.Tree> Tree;
            List<Tablas.Tree> TreeDest;
            try
            {
                Tree = TablasDAL.Menu(this.Session["BasePronto"].ToString());
                TreeDest = new List<Tablas.Tree>();
            }
            catch (Exception)
            {
                return Json("");
            }


            int IdUsuario = 0;
            Empleado empleado = new Empleado();


            try
            {
                empleado = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).FirstOrDefault();
                IdUsuario = empleado.IdEmpleado;
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e);
                // throw; // Exception("No se encuentra el usuario");
            }

            var permisos = (from i in db.EmpleadosAccesos where i.IdEmpleado == IdUsuario select i).ToList();


            TreeDest = new List<Tablas.Tree>(Tree); //la duplico


            bool essuperadmin = Roles.IsUserInRole(usuario, "SuperAdmin");
            bool esadmin = Roles.IsUserInRole(usuario, "Administrador"); // || (empleado ?? new Empleado()).Administrador == "SI";
            bool escomercial = Roles.IsUserInRole(usuario, "Comercial");
            bool esfactura = Roles.IsUserInRole(usuario, "FacturaElectronica");
            bool esreq = Roles.IsUserInRole(usuario, "Requerimientos");

            string SC = Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString());
            SC = Generales.sCadenaConex(this.HttpContext.Session["BasePronto"].ToString());
            bool esfirma = Generales.TienePermisosDeFirma(SC, IdUsuario);

            foreach (Tablas.Tree o in Tree)
            {
                int? nivel = permisos.Where(x => x.Nodo == o.Clave).Select(x => x.Nivel).FirstOrDefault();


                nivel = 9;

                if (nivel == null)
                {
                    if (!essuperadmin) nivel = 9; //por ahora desactivo los menuses 
                    else nivel = 1;
                }


                if (essuperadmin) nivel = 1;

                if ((esfirma || esadmin) && (o.Descripcion.Contains("Autorizaci") || o.Descripcion.Contains("Seguridad"))) nivel = 1;

                if (o.Descripcion.Contains("ccesos"))
                {
                    if (esadmin || essuperadmin) nivel = 1;
                    else nivel = 9;
                }

                if ((escomercial || esadmin) && (o.Descripcion.Contains("Contabilidad") || o.Descripcion == "Consultas"))
                    nivel = 1;
                if ((escomercial || esadmin) && (o.Descripcion.Contains("Mayor") || o.Descripcion == "Consultas")) nivel = 1;
                if ((escomercial || esadmin) && (o.Descripcion.Contains("Balance") || o.Descripcion == "Consultas")) nivel = 1;



                if ((esreq || esadmin) && (o.Descripcion.Contains("Requerimiento") || o.Descripcion.Contains("Articulo")))
                {
                    nivel = 1;
                }


                if (nivel >= 9)
                {
                    o.Descripcion = "Bloqueado!";

                    eliminarNodoySusHijos(o, ref TreeDest);
                }
                else
                {
                    //estoy un duplicado y voy eliminando nodos, no uso el .add
                    //TreeDest.Add(o);
                }
            }

            foreach (Tablas.Tree n in TreeDest)
            {
                n.Link = n.Link.Replace("Pronto2", ROOT);
            }


            return Json(TreeDest);

        }

        public virtual ActionResult Reporte1()
        {
            return Redirect("../Reportes/Reporte.aspx");
        }




        public virtual ActionResult Directorio()
        {
            int IdPedido1 = 0;
            var DetEntidad = db.DetallePedidos.Where(p => p.IdPedido == IdPedido1).AsQueryable();

            int pageSize = 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = 1;

            var q = new string[] { "Requerimientos", "Pedidos" };

            var data = (from a in q
                        select new
                        {
                            titulo = a
                        });

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.titulo.ToString(),
                            cell = new string[] { 
                                    a.titulo.ToString()
                            
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
    }
}
