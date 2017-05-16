using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
using System.Globalization;
using System.IO;
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
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using Pronto.ERP.Bll;

using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace ProntoMVC.Controllers
{
    public partial class HomeController : ProntoBaseController
    {


        public virtual ActionResult Index()
        {


            var u = oStaticMembershipService.GetUser();
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

        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        public virtual ActionResult Menu()
        {

            return Json(TablaMenu());





        }



        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




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
        public virtual ActionResult TreeGrid_ParaGrillaNoTreeviewEnLocalStorage(FormCollection collection)
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
                q = TablaTree("01").ToList();
                //como hacer si es esxterno, o si tiene permisos a todos los nodos raiz?

                //no hay cacheados nodos expandidos ni el nodo apretado. Debe ser la primera pantalla de la sesión. entonces, debo 
                // mostrar todos los nodos raíces de los que tenga permiso...

            }
            else if (collection.AllKeys.Contains("idsOfExpandedRows"))
            {
                // recbo los nodos por postdata
                // List<string> v = collection["idsOfExpandedRows"].ToList();

                q = TablaTree(); //podrias devolver un queryable


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


                q = TablaTree(); //podrias devolver un queryable

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

                q = TablaTree();// podrias devolver un queryable

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
                            id = child.IdItem,
                            descr = (new String('_', ((child.IdItem.Replace("-", "").Length) / 2 - 2) * 5)).Replace("_", "&nbsp;")  +
                                    (((child.Link ?? "")  =="") ?    child.Descripcion :  child.Link ), // Correspond to the colmodel NAME in javascript
                            
                            // The next one correspond to the colmodel ID in javascript Id
                            // If we are are the root level the [nodeid] will be empty as i explained above
                            // So the id will be clean. Following the example, just 5
                            // If we are expanding the Agent 5 so, the [nodeid] will not be empty
                            // so we take the Agent id, 5 and concatenate the child id, so 5_25
                            // child.IdItem,
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
                            level = ((child.IdItem.Replace("-", "").Length) / 2 - 2).ToString(),  // level.ToString(),
                            
                           
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                           //PARENT ID: If we are at the root [nodeid] will be empty so the parent id is ""
                            // In case of a service writter the parent id is the nodeid, because is the node
                            // we are expanding
                            //parent = child.ParentId ?? string.Empty, //  child.ParentId,  // collection["nodeid"] ?? string.Empty,
                            parent = (child.ParentId ?? "") == "" ? "null" : child.ParentId,
                           
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                           //IS NOT EXPANDABLE: One thing that was tricky here was that I was using c# true, false
                            //and to make it work it's needed to be strings "true" or "false"
                            // The Child.Role the role name, so i know that if it's a ServiceWriter i'm the last level
                            // so it's not expandable, the optimal way is to get from the database store procedure
                            // if the leaf has children.
                            isLeaf = (child.EsPadre != "SI" ? "true" : "false").ToString(),
                           
                            
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            //IS EXPANDED: I use that is always false,
                            expanded = (v.Contains(child.IdItem) ? "true" : "false").ToString()
                            
                            //////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////
                            // LOADED: si está puesto en true, no vuelve a llamar al servidor
                           // , "false" 
                                ,
                            loaded = "true"

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

            var jsonResult = Json(filesData, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
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
                q = TablaTree("01").ToList();
                //como hacer si es esxterno, o si tiene permisos a todos los nodos raiz?

                //no hay cacheados nodos expandidos ni el nodo apretado. Debe ser la primera pantalla de la sesión. entonces, debo 
                // mostrar todos los nodos raíces de los que tenga permiso...

            }
            else if (collection.AllKeys.Contains("idsOfExpandedRows"))
            {
                // recbo los nodos por postdata
                // List<string> v = collection["idsOfExpandedRows"].ToList();

                q = TablaTree(); //podrias devolver un queryable


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


                q = TablaTree(); //podrias devolver un queryable

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

                q = TablaTree();// podrias devolver un queryable

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
                            ((child.Link ?? "")  =="") ?    child.Descripcion :  child.Link, // Correspond to the colmodel NAME in javascript
                            
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
        public virtual ActionResult TreeGridConNiveles_Todos_ParaEdicionEnAccesos(FormCollection collection)
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


            // aca tengo que filtrar los nodos desactivados por el superadmin (-y si es un 
            // superadmin el que llama? -en ese caso quizas convenga usar otra vista)




            //    var children = new List<GetTreeGridValuesResult>();
            int level = 0;
            int parentId = 0;

            List<Tablas.Tree> q;


            // q = TablaTree();
            int idusuario = Generales.Val(collection["IdEmpleado"]); // 303; //= oStaticMembershipService.GetUser();

            if (idusuario == -1)
            {
                var u = oStaticMembershipService.GetUser();
                string usuario = u.UserName;
                idusuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
            }


            q = ArbolConNiveles_Tree(idusuario, this.Session["BasePronto"].ToString(), ViewBag.NombreUsuario, db, oStaticMembershipService);

            //var l = q.Where(n => n.Descripcion == "Bloqueado!" || n.Descripcion == "NO MOSTRAR" || n.Descripcion.StartsWith("por ")).ToList();

            //foreach (Tablas.Tree n in l)
            //{
            //    eliminarNodoHijos(n, ref q);
            //}


            List<Tablas.Tree> m = MenuConNiveles_Tree(idusuario);


            q.AddRange(m);



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







        public virtual FileResult Log()
        {
            // TambienLogDelPronto()



            DirectoryInfo di = new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory + "\\Error"); // (ErrHandler.DirectorioErrores)
            FileSystemInfo[] files = di.GetFileSystemInfos(); // agarro el directorio con los logs de errores


            var orderedFiles = files.OrderByDescending(f => f.LastWriteTime).Select(f => f.FullName);

            string output = orderedFiles.First();






            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, output);

        }





        public virtual JsonResult Superbuscador(string term)
        {

            Dictionary<string, string> dic = new Dictionary<string, string> { };

            dic.Add("Comprobantes de Proveedor", "ComprobanteProveedor/");
            dic.Add("Fondo Fijo", "ComprobanteProveedor/IndexFF");
            dic.Add("CP Nuevo Comprobante de Proveedor", "ComprobanteProveedor/Edit/-1");
            dic.Add("Conceptos", "Concepto/");
            dic.Add("Tabla de ganancias", "TipoRetencionGanancia/");
            dic.Add("Categorias Ganancias", "Categoria/");
            dic.Add("Condiciones de venta", "CondicionVenta/");
            dic.Add("Puntos de venta", "PuntosVenta/");
            dic.Add("Categorias IIBB Ingresos Brutos", "IBCondicion/");
            dic.Add("Listas de Precios", "ListasPrecio/");
            dic.Add("Clientes resumido", "Cliente/");
            dic.Add("Clientes detallado", "Cliente/");
            dic.Add("Comparativas", "Comparativa/");
            dic.Add("Proveedores", "Proveedor/");
            dic.Add("Facturas", "Factura/");
            dic.Add("Remitos", "Remito/");
            dic.Add("Requerimientos", "Requerimiento/");
            dic.Add("OP Ordenes de Pago", "OrdenPago/");
            dic.Add("Notas de Pedidos", "Pedido/");
            dic.Add("Recibos", "Recibo/");
            dic.Add("Cuenta Corriente Deudores - Ctas. Ctes.", "Reporte.aspx");
            dic.Add("Solicitudes de Cotización - Presupuestos ", "Presupuesto/");


            dic.Add("Artículos", "Articulo/");

            dic.Add("Firmas - Autorizaciones", "Autorizacion/");

            dic.Add("Cuentas", "Cuenta/");
            dic.Add("Asientos", "Asiento/");
            dic.Add("Rubros contables", "RubroContable/");

            var q = db.Trees
                    .Where(x => x.Link != null && (x.Clave.Contains(term) || x.Descripcion.Contains(term) || x.Link.Contains(term))).Take(5).ToList();


            foreach (Tree o in q)
            {
                try
                {


                    var s= o.Link.Substring(o.Link.IndexOf("Pronto2") + 8);
                    s=s.Substring(0, s.IndexOf("\">"));
                     


                    dic.Add(o.Descripcion + "   [" + o.Clave + "]", s);

                }
                catch (Exception)
                {
                    
                    //throw;
                }
            }




            //var lista = EntidadManager.GetStoreProcedure("", enumSPs.wbusqueda, prefixText);
            var sc = Generales.sCadenaConexSQL(this.Session["BasePronto"].ToString(), oStaticMembershipService);
            DataTable lista2 = new DataTable();
            try
            {
                lista2 = EntidadManager.GetStoreProcedure(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(sc), "wBusquedaMVC", term);
            }
            catch (Exception ex)
            {
                ErrHandler.WriteError(ex);
            }

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

        [HttpPost]
        public void Upload()
        {
            for (int i = 0; i < Request.Files.Count; i++)
            {
                var file = Request.Files[i];

                var fileName = Path.GetFileName(file.FileName);

                var path = Path.Combine(Server.MapPath("~/Documentos/"), fileName);
                file.SaveAs(path);
            }

        }

        public FilePathResult Image()
        {
            string filename = Request.Url.AbsolutePath.Replace("/home/image", "");
            string contentType = "";
            var filePath = new FileInfo(Server.MapPath("~/App_Data") + filename);

            var index = filename.LastIndexOf(".") + 1;
            var extension = filename.Substring(index).ToUpperInvariant();

            // Fix for IE not handling jpg image types
            contentType = string.Compare(extension, "JPG") == 0 ? "image/jpeg" : string.Format("image/{0}", extension);

            return File(filePath.FullName, contentType);
        }

        [HttpPost]
        public ContentResult UploadFiles()
        {
            var r = new List<UploadFilesResult>();

            foreach (string file in Request.Files)
            {
                HttpPostedFileBase hpf = Request.Files[file] as HttpPostedFileBase;
                if (hpf.ContentLength == 0)
                    continue;

                string savedFileName = Path.Combine(Server.MapPath("~/Adjuntos"), Path.GetFileName(hpf.FileName));
                hpf.SaveAs(savedFileName);

                r.Add(new UploadFilesResult()
                {
                    Name = hpf.FileName,
                    Length = hpf.ContentLength,
                    Type = hpf.ContentType
                });
            }
            return Content("{\"name\":\"" + r[0].Name + "\",\"type\":\"" + r[0].Type + "\",\"size\":\"" + string.Format("{0} bytes", r[0].Length) + "\"}", "application/json");
        }

        public class UploadFilesResult
        {
            public string Name { get; set; }
            public int Length { get; set; }
            public string Type { get; set; }
        }

    }
}
