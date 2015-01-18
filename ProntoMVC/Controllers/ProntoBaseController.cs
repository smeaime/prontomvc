using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using System.Web.Security;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;

using System.Data.Entity.Core.Objects; // using System.Data.Objects;

using Pronto.ERP.Bll;

using Elmah;

using System.Data.Metadata.Edm;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Core.Objects.DataClasses;
using System.Linq.Expressions;
using System.Data.Entity;


namespace ProntoMVC.Controllers
{
    public abstract partial class ProntoBaseController : Controller // , IProntoInterface<Object>
    {
        public DemoProntoEntities db; //= new DemoProntoEntities(sCadenaConex());

        public string SC;


        public string ROOT;



        public int glbIdUsuario
        {

            get
            {
                string usuario = ViewBag.NombreUsuario;
                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
                return IdUsuario;
            }

            set { return; }
        }

        public Empleado glbUsuario
        {

            get
            {
                return db.Empleados.Find(glbIdUsuario);
            }

            set { }
        }

        public const int pageSize = 10;

        public string SCsql()
        {
            var d = new dsEncrypt();
            d.KeyString = "EDS";

            string s = Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString());
            return d.Encrypt(s);


        }

        private void asignacadena(string rccadena)
        {
            string sc;
            try
            {
                sc = Generales.sCadenaConex(rccadena);
            }
            catch (Exception)
            {
                //return;
                throw new Exception("Falta la cadena de conexion a la base Pronto (nombre de base: [" + rccadena + "]");
            }

            if (sc == null)
            {

                // estás perdiendo la sesion por lo del web.config?????
                // http://stackoverflow.com/questions/10629882/asp-net-mvc-session-is-null

                ////////////////////////////////////////////////////////////////////////////////////////////////
                // MAL MAL!!!!!!!!!
                // http://stackoverflow.com/questions/7705802/httpcontext-current-session-is-null-in-mvc-3-appplication
                // Why are you using HttpContext.Current in an ASP.NET MVC application? Never use it. That's evil even 
                // in classic ASP.NET webforms applications but in ASP.NET MVC it's a disaster that takes all the fun out of this nice web framework
                ////////////////////////////////////////////////////////////////////////////////////////////////


                // FormsAuthentication.SignOut();

                if (Membership.GetUser() == null)
                {
                    FormsAuthentication.SignOut();
                    Session.Abandon();

                    //// clear authentication cookie
                    //HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
                    //cookie1.Expires = DateTime.Now.AddYears(-1);
                    //Response.Cookies.Add(cookie1);

                    //// clear session cookie 
                    //HttpCookie cookie2 = new HttpCookie("ASP.NET_SessionId", "");
                    //cookie2.Expires = DateTime.Now.AddYears(-1);
                    //Response.Cookies.Add(cookie2);

                    FormsAuthentication.RedirectToLoginPage();
                    return;
                }

                //if (false)
                //{
                // return RedirectToAction("ElegirBase", "Account");




                if (this.Session["BasePronto"] == null)
                {
                    // de alguna manera lo tengo que redirigir a la eleccion de la base, pero desde acá no puedo hacer 
                    // un redirect. 

                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // http://stackoverflow.com/questions/8225930/redirect-from-controller-initialize-not-working
                    // http://stackoverflow.com/questions/8225930/redirect-from-controller-initialize-not-working
                    // http://stackoverflow.com/questions/8225930/redirect-from-controller-initialize-not-working
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!



                    // http://stackoverflow.com/questions/4793452/mvc-redirect-inside-the-constructor

                    //return;
                    //throw new Exception("No hay base elegida");
                }


                var n = new AccountController();

                if ((n.BuscarUltimaBaseAccedida() ?? "") != "")
                {
                    this.Session["BasePronto"] = n.BuscarUltimaBaseAccedida();
                    // return Redirect(returnUrl);



                    string sss2 = this.Session["BasePronto"].ToString();
                    sc = Generales.sCadenaConex(sss2);
                    if (sc == null)
                    {
                        // throw new Exception("Falta la cadena de conexion a la base Pronto (nombre de base: [" + sss + "]");
                        this.Session["BasePronto"] = Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey);
                    }


                }
                else
                {

                    this.Session["BasePronto"] = Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey);
                }


                //}
                string sss = this.Session["BasePronto"].ToString();
                sc = Generales.sCadenaConex(sss);
                //    return RedirectToAction("Index", "Home");
                if (sc == null) throw new Exception("Falta la cadena de conexion a la base Pronto (nombre de base: [" + sss + "]");
            }
            db = new DemoProntoEntities(sc);
            SC = sc;


            if (db == null)
            {
                if (System.Diagnostics.Debugger.IsAttached)
                {
                    System.Diagnostics.Debugger.Break();
                }
                else
                {
                    throw new Exception("error en creacion del context. " + sc);

                }
            }

        }



        protected override void Initialize(System.Web.Routing.RequestContext rc)
        {
            base.Initialize(rc);

            // string sBasePronto = (string)rc.HttpContext.Session["BasePronto"];
            // db = new DemoProntoEntities(Funciones.Generales.sCadenaConex(sBasePronto));
            ROOT = ConfigurationManager.AppSettings["Root"];
            asignacadena((string)rc.HttpContext.Session["BasePronto"]);



            string us = Membership.GetUser().ProviderUserKey.ToString();

            string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            System.Data.DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster,
                                                     "SELECT * FROM BASES " +
                                                     "join DetalleUserBD on bases.IdBD=DetalleUserBD.IdBD " +
                                                     "where UserId='" + us + "'");
            //DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster, "SELECT * FROM BASES");
            // List<string> baselistado = new List<string>();
            List<SelectListItem> baselistado = new List<SelectListItem>();
            foreach (DataRow r in dt.Rows)
            {
                baselistado.Add(new SelectListItem { Text = r["Descripcion"] as string, Value = "" });
            }


            ViewBag.Bases = baselistado;


            //try
            //{
            //    if (!PuedeLeer(rc.RouteData.Values["controller"].ToString())) db = null;

            //}
            //catch (Exception)
            //{

            //  //  throw;
            //}

            //PuedeLeer(rc.RouteData.Values["action"])

        }



        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            // http://stackoverflow.com/questions/3214774/how-to-redirect-from-onactionexecuting-in-base-controller
            //http://stackoverflow.com/questions/8225930/redirect-from-controller-initialize-not-working
            //http://stackoverflow.com/questions/8225930/redirect-from-controller-initialize-not-working

            base.OnActionExecuting(filterContext);






            if (this.Session["BasePronto"] == null)
            {

                // se perdio la base elegida. Esto parece pasarte seguido en las Views que devolves sin haber recargado la session 
                // -Eh? no tengo necesidad de recargar la session, solo la ViewBag, y ahí no tengo la base elegida

                // -ok, pero pasá la información de en qué página estaba antes!!!!

                AccountController a = new AccountController();
                if (a.BuscarUltimaBaseAccedida() != "")
                {
                    this.Session["BasePronto"] = a.BuscarUltimaBaseAccedida();

                }

                else
                {
                    filterContext.Result = new RedirectToRouteResult(
                              new System.Web.Routing.RouteValueDictionary { { "controller", "Account" }, { "action", "ElegirBase" }, { "area", "" }
                              , { "returnUrl",    filterContext.HttpContext.Request.RawUrl }
                          });
                    return;
                }
            }

            if (!VerificarPassBase(filterContext))
            {
                //filterContext.Result = new RedirectResult(  AppDom  );
                filterContext.Result = new RedirectToRouteResult(
                        new System.Web.Routing.RouteValueDictionary { { "controller", "Home" }, { "action", "Index" } 
                                , { "returnUrl",    filterContext.HttpContext.Request.RawUrl }
                        });

                return;
            }



            // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
            // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
            // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
            // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
            // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
            // http://stackoverflow.com/questions/8225930/redirect-from-controller-initialize-not-working
            // http://stackoverflow.com/questions/8225930/redirect-from-controller-initialize-not-working
            // http://stackoverflow.com/questions/8225930/redirect-from-controller-initialize-not-working
            // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
            // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
            // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
            // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
            // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!





            if (filterContext.RouteData.Values["controller"].NullSafeToString() == "Home") return;
            if (filterContext.RouteData.Values["controller"].NullSafeToString() == "Acceso") return;
            if (filterContext.RouteData.Values["controller"].NullSafeToString() == "Empleado") return;


            bool ok;

            try
            {

                ok = PuedeLeer(filterContext.RouteData.Values["controller"].ToString());

            }
            catch (Exception)
            {
                ok = true;
                //  throw;
            }


            if (!ok)
            {
                db = null;
                throw new Exception("Permisos insuficientes de lectura");
            }



            try
            {
                if ((filterContext.RouteData.Values["action"].NullSafeToString() == "Edit" &&
                     filterContext.HttpContext.Request.HttpMethod == "POST") ||
                    filterContext.RouteData.Values["id"].NullSafeToString() == "-1")

                    ok = (PuedeEditar(filterContext.RouteData.Values["controller"].ToString()));
                else ok = true;

            }
            catch (Exception)
            {
                ok = true;
                //  throw;
            }


            if (!ok)
            {
                db = null;
                throw new Exception("Permisos insuficientes de edición");
            }




            try
            {
                if (filterContext.RouteData.Values["action"].ToString().Contains("Delete"))
                    ok = (PuedeBorrar(filterContext.RouteData.Values["controller"].ToString()));
                else ok = true;

            }
            catch (Exception)
            {
                ok = true;
                //  throw;
            }


            if (!ok)
            {
                db = null;
                throw new Exception("Permisos insuficientes de borrado");
            }

        }



        //http://stackoverflow.com/questions/4036582/asp-net-mvc-displaying-user-name-from-a-profile
        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {



            //Guid userGuid = (Guid)Membership.GetUser().ProviderUserKey;
            //string us = Membership.GetUser().UserName;
            //string us = userGuid.ToString();



            base.OnActionExecuted(filterContext);
        }





        public string BuscarClaveINI(string clave, Int32 IdUsuario2 = 0)
        {
            int IdUsuario = 0;
            if (IdUsuario2 == 0)
            {
                string usuario = ViewBag.NombreUsuario;
                IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
                string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            }
            else
            {
                IdUsuario = IdUsuario2;
            }

            var idclav = db.ProntoIniClaves.Where(x => x.Clave == clave).Select(x => x.IdProntoIniClave).FirstOrDefault();
            string idclava = db.ProntoIni.Where(x => x.IdProntoIniClave == idclav && (IdUsuario == -1 || x.IdUsuario == IdUsuario)).Select(x => x.Valor).FirstOrDefault();

            return idclava;
        }




        bool VerificarPassBase(ActionExecutingContext filterContext)
        {
            string sBasePronto = (string)filterContext.HttpContext.Session["BasePronto"];
            ViewData["BasePronto"] = sBasePronto;
            ViewBag.BasePronto = sBasePronto;

            if (sBasePronto == null)
            {
                //  FormsAuthentication.SignOut();
                return false;
                // return RedirectToAction("Index", "Home");
            }


            try
            {
                ViewBag.NombreUsuario = Membership.GetUser().UserName;
            }
            catch (Exception ex)
            {
                return false;
            }

            return true;
        }





        //[HttpPost]
        //public ActionResult Edit()
        //{
        //    if (id==0) // no se declaró el hidden en Razor para que no salte el error de Store update, insert, or delete statement affected an unexpected number of rows (0)
        //}

        // if (ModelState.IsValid)
        //{
        //    if (PuntosVenta.IdPuntoVenta == -1)
        //    {
        //        db.PuntosVentas.Add(PuntosVenta);
        //        db.SaveChanges();
        //    }
        //    else
        //    {
        //        // verificar que esté el ID --->>>>>       @Html.HiddenFor(model => model.productID)

        //        // ERROR: Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. Refresh ObjectStateManager entries
        //        // I ran into this and it was caused by the entity's ID (key) field not being set. 
        //        // Thus when the context went to save the data, it could not find an ID = 0. 
        //        // Be sure to place a break point in your update statement and verify that the entity's ID has been set.
        //        //+1 Thanks for adding this answer - I had this exact issue, caused by forgetting to include the hidden ID input in the .cshtml edit page. – Paul Bellora Dec 22 '11 at 19:26
        //        //+1 I was having same problem and this helped find the solution. 
        //          Turns out I had [Bind(Exclude = "OrderID")] in my Order model which was causing the value of
        //         the entity's ID to be zero on HttpPost. – David HAust Jan 23 '12 at 2:07
        //        //That's exactly what I was missing. My object's ID was 0. – Azhar Khorasany Aug 16 '12 at 21:18
        //        //@Html.HiddenFor(model => model.productID) -- worked perfect. I was missing the productID on the EDIT PAGE (MVC RAZOR) – David K Egghead Aug 28 '12 at 5:02


        //        // http://stackoverflow.com/a/6337741/1054200

        //        db.Entry(PuntosVenta).State = System.Data.Entity.EntityState.Modified;
        //        db.SaveChanges();
        //        //try
        //        //{
        //        //    db.SaveChanges();
        //        //}
        //        //catch (OptimisticConcurrencyException)
        //        //{
        //        //    db.Refresh(RefreshMode.ClientWins, db.Articles);

        //        //}

        //    }
        //}




        //public ActionResult Edit(int id)
        //{
        //    Models.ListasPrecio o;
        //    if (id == -1)
        //    {
        //        o = new Models.ListasPrecio();

        //    }
        //    else
        //    {
        //        o = db.ListasPrecios.Find(id);
        //    }

        //    // ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion", Ganancias.IdTipoRetencionGanancia);
        //    return View(o);
        //}

        ////
        //// POST: /PuntosVenta/Edit/5

        //[HttpPost]
        //public ActionResult Edit(Models.ListasPrecio o)
        //{

        //    if (ModelState.IsValid)
        //    {
        //        if (o.IdListaPrecios <= 0)
        //        {
        //            db.ListasPrecios.Add(o);
        //            db.SaveChanges();
        //            return RedirectToAction("Index");
        //        }
        //        else
        //        {
        //            db.Entry(o).State = System.Data.Entity.EntityState.Modified;
        //            db.SaveChanges();
        //            return RedirectToAction("Index");
        //        }
        //    }
        //    return View(o);

        //}




        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //cuales son las funciones basicas que deben definirse en cada clase que me herede?
        // abstract protected void Edit();    // para objetos normales
        // abstract protected void BatchUpdate();    // para objetos complejos (que usan jqGrid)
        // abstract protected void Index();  
        //abstract protected void CargarViewBag(Object o); //como hacer para que, en lugar de Object, use la clase hija?
        // void UpdateColecciones(ref Models.Articulo o)
        // private bool Validar(ProntoMVC.Data.Models.Articulo o, ref string sErrorMsg)


        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////



        protected override void Dispose(bool disposing)
        {
            if (db != null) db.Dispose();
            base.Dispose(disposing);
        }




        EmpleadosAcceso acce(string Modulo)
        {
            string usuario = ViewBag.NombreUsuario;
            int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

            EmpleadosAcceso acc = (from i in db.EmpleadosAccesos
                                   where (i.IdEmpleado == IdUsuario &&

                                       (i.Nodo == Modulo || i.Nodo == Modulo + "s" || i.Nodo == Modulo + "es")
                                       )
                                   select i).FirstOrDefault();

            // falló con el nodo "PuntosVenta", porque la vista (el módulo) se llama "PuntoVenta"

            if (acc == null) throw new Exception("Error de permisos. No se encuentra el empleado/permiso");
            return acc;
        }


        public bool PuedeLeer(string Modulo)
        {

            return true;// desactivados desde el uso de los roles de asp.net


            try
            {

                var acc = acce(Modulo);
                if (acc.Nivel < 9) return true;

            }
            catch (Exception)
            {

                throw;
            }


            return false;
        }



        public bool PuedeEditar(string Modulo)
        {
            return true;// desactivados desde el uso de los roles de asp.net

            try
            {
                var acc = acce(Modulo);
                if (acc.Nivel <= 5) return true;
            }
            catch (Exception)
            {

                throw;
            }

            return false;
        }

        public bool PuedeBorrar(string Modulo)
        {
            return true;// desactivados desde el uso de los roles de asp.net

            try
            {
                var acc = acce(Modulo);

                if (acc.Nivel == 1) return true;
            }
            catch (Exception)
            {

                throw;
            }

            return false;
        }



        [AcceptVerbs(HttpVerbs.Post)]
        public virtual RedirectToRouteResult AddToEmpresa(Guid id, string empresa)
        {



            BDLMasterEntities dbMaster = new BDLMasterEntities(Generales.ConexEFMaster());

            //si tengo cuidado aca

            try
            {
                CrearUsuarioProntoEnDichaBase(empresa, Membership.GetUser(id).UserName);

            }
            catch (Exception)
            {

                throw;
            }




            ProntoMVC.Data.Models.DetalleUserBD i = (from u in dbMaster.DetalleUserBD
                                                     join b in dbMaster.Bases on u.IdBD equals b.IdBD
                                                     where (b.Descripcion == empresa && u.UserId == id)
                                                     select u).FirstOrDefault();

            if (i != null) return RedirectToAction("UsersEmpresas", new { id }); // ya existe
            i = new ProntoMVC.Data.Models.DetalleUserBD();


            Bases basedb = (from x in dbMaster.Bases where (x.Descripcion == empresa) select x).FirstOrDefault();
            if (i == null) return RedirectToAction("UsersEmpresas", new { id });
            i.IdBD = basedb.IdBD;
            i.UserId = id;



            dbMaster.DetalleUserBD.Add(i);
            dbMaster.SaveChanges();


            //return null;
            return RedirectToAction("UsersEmpresas", new { id });
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public virtual RedirectToRouteResult RemoveFromEmpresa(Guid id, string empresa)
        {

            string sc = Generales.FormatearConexParaEntityFrameworkBDLMASTER();
            ProntoMVC.Data.Models.BDLMasterEntities dbMaster = new ProntoMVC.Data.Models.BDLMasterEntities(sc);

            ProntoMVC.Data.Models.DetalleUserBD i = (from u in dbMaster.DetalleUserBD
                                                     join b in dbMaster.Bases on u.IdBD equals b.IdBD
                                                     where (b.Descripcion == empresa && u.UserId == id)
                                                     select u).FirstOrDefault();



            dbMaster.DetalleUserBD.Remove(i);
            dbMaster.SaveChanges();


            return RedirectToAction("UsersEmpresas", new { id });
        }





        public void CrearUsuarioProntoEnDichaBase(string nombrebasepronto, string nombreusuariopronto, string pass = "ldb", int? IdSector = null, int? IdObra = null)
        {
            string dest;
            ProntoMVC.Data.Models.DemoProntoEntities dbDest;
            //si tengo cuidado aca

            if (nombrebasepronto == "") throw new Exception("Falta el nombre de la base");

            try
            {
                dest = Generales.sCadenaConex(nombrebasepronto);
                dbDest = new ProntoMVC.Data.Models.DemoProntoEntities(dest);


            }
            catch (Exception ex)
            {

                throw new Exception("No existe la base", ex);
            }

            ProntoMVC.Data.Models.Empleado emp;
            //ojo, acá quizas la base pronto no encastra bien con el modelito mvc
            try
            {
                emp = dbDest.Empleados.Where(e => e.UsuarioNT == nombreusuariopronto).FirstOrDefault();

            }
            catch (Exception ex)
            {
                ex.Data.Add("", "La base " + dest + " no encastra bien con el modelo");
                // la base "dest" no encastra bien con el modelo
                throw;
            }


            if (emp != null) return;

            emp = new ProntoMVC.Data.Models.Empleado();

            emp.UsuarioNT = nombreusuariopronto;
            emp.Nombre = nombreusuariopronto;
            emp.Password = pass;
            emp.IdObraAsignada = IdObra;
            emp.IdSector = IdSector;
            emp.Administrador = "NO";

            dbDest.Empleados.Add(emp);
            dbDest.SaveChanges();

        }


        public static int? GetMaxLength<T>(Expression<Func<T, string>> column)
        {
            int? result = null;
            //using (var context = new EfContext())
            using (DbContext context = new DemoProntoEntities())
            {
                var entType = typeof(T);
                var columnName = ((MemberExpression)column.Body).Member.Name;

                var objectContext = ((IObjectContextAdapter)context).ObjectContext;
                //var test = objectContext.MetadataWorkspace.GetItems(DataSpace.CSpace);
                var test = objectContext.MetadataWorkspace.GetItems(System.Data.Entity.Core.Metadata.Edm.DataSpace.CSpace); //.GetItems(DataSpace.CSpace);


                if (test == null)
                    return null;

                var q = test
                    .Where(m => m.BuiltInTypeKind == System.Data.Entity.Core.Metadata.Edm.BuiltInTypeKind.EntityType)
                    .SelectMany(meta => ((System.Data.Entity.Core.Metadata.Edm.EntityType)meta).Properties
                    .Where(p => p.Name == columnName && p.TypeUsage.EdmType.Name == "String"));

                var queryResult = q.Where(p =>
                {
                    var match = p.DeclaringType.Name == entType.Name;
                    if (!match)
                        match = entType.Name == p.DeclaringType.Name;

                    return match;

                })
                    .Select(sel => sel.TypeUsage.Facets["MaxLength"].Value)
                    .ToList();

                if (queryResult.Any())
                    result = Convert.ToInt32(queryResult.First());

                return result;
            }
        }

        void CrearConexionlaEnLaTablaBases(string nombrebasenueva, string connectionString)
        {



            string sc = Generales.FormatearConexParaEntityFrameworkBDLMASTER();
            ProntoMVC.Data.Models.BDLMasterEntities dbMaster = new ProntoMVC.Data.Models.BDLMasterEntities(sc);

            ProntoMVC.Data.Models.Bases b = new Bases();

            b.Descripcion = nombrebasenueva;
            b.StringConection = connectionString;

            dbMaster.Bases.Add(b);
            dbMaster.SaveChanges();

        }

        public void CrearBaseyAsignarEmpleado(string guid, string nombrebaseoriginal, string nombrebasenueva, string nombreusuariopronto)
        {



            string directorio = ConfigurationManager.AppSettings["DirSQL"]; //acá iria a parar no solo el .bak, sino tambien el mdf y el ldf
            //string directorio = "C:\\";




            const string spName = "wDuplicarBase";



            // solucionado por sql, usando WITH INIT
            //string archivotemp = directorio + "BackupFile.Bak";  // esto no sirve... acá estas borrando en el servidor web, no en el sql.

            ////borrar bak original

            //if (System.IO.File.Exists(archivotemp))
            //{
            //    System.IO.File.Delete(archivotemp);
            //}



            string connectionString = Generales.sCadenaConexSQLbdlmaster();

            if (string.IsNullOrEmpty(connectionString)) return;


            string nuevaconex = Generales.sCadenaConexSQL(nombrebaseoriginal).Replace(nombrebaseoriginal, nombrebasenueva);

            CrearConexionlaEnLaTablaBases(nombrebasenueva, nuevaconex); // corregir. estoy pasando la conexion de la bdlmaster


            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlCommand sqlCommand = new SqlCommand(spName, sqlConnection);
                sqlCommand.CommandTimeout = 600; // ok pero en cuanto está el timeout de la pagina???

                sqlCommand.CommandType = CommandType.StoredProcedure;
                SqlParameter[] sqlParameterCollection = SetParameterSP(nombrebaseoriginal, nombrebasenueva, directorio);
                sqlCommand.Parameters.AddRange(sqlParameterCollection);

                sqlConnection.Open();
                SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();
                //TreeCollection = FillTreeEntity(sqlCommand);
            }



            try
            {
                AddToEmpresa(new Guid(guid), nombrebasenueva);
                CrearUsuarioProntoEnDichaBase(nombrebasenueva, nombreusuariopronto);

            }
            catch (Exception)
            {

                // throw;
            }


            // return TreeCollection;

            //return RedirectToAction("Index");
        }



        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////


        public int buscaridproveedorporcuit(string cuit)
        {
            if (cuit == null) return -1;
            var provs = db.Proveedores.Where(p => p.Cuit.Replace("-", "") == cuit.Replace("-", ""));
            return provs.Select(p => p.IdProveedor).FirstOrDefault();

        }



        public int buscaridclienteporcuit(string cuit)
        {
            if (cuit == null) return -1;
            var provs = db.Clientes.Where(p => p.Cuit.Replace("-", "") == cuit.Replace("-", ""));
            return provs.Select(p => p.IdCliente).FirstOrDefault();

        }

        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////




        public string DatosExtendidosDelUsuario_GrupoUsuarios(Guid guidUsuario)
        {

            var user = Membership.GetUser(guidUsuario);
            string grupo = "";

            using (BDLMasterEntities bdlmaster = new BDLMasterEntities(Generales.FormatearConexParaEntityFrameworkBDLMASTER()))
            {
                UserDatosExtendidos u = bdlmaster.UserDatosExtendidos.Where(x => x.UserId == guidUsuario).FirstOrDefault();
                if (u != null) grupo = u.RazonSocial;
            }


            // if (Roles.IsUserInRole(user.UserName, "Externo") || Roles.IsUserInRole(user.UserName, "AdminExterno")) 
            if (grupo != "") return grupo;

            return null;
        }








        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////



        /////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////
        // http://stackoverflow.com/questions/4690967/asp-net-mvc-3-json-model-binding-and-server-side-model-validation-mixed-with-cli

        public enum Status
        {
            Ok,
            Error
        }

        public class JsonResponse
        {
            public Status Status { get; set; }
            public string Message { get; set; }
            public List<string> Errors { get; set; }
        }

        public List<string> GetModelStateErrorsAsString(ModelStateDictionary state)
        {
            List<string> errors = new List<string>();

            foreach (var key in ModelState.Keys)
            {
                var error = ModelState[key].Errors.FirstOrDefault();
                if (error != null)
                {
                    errors.Add(error.ErrorMessage);
                }
            }

            return errors;
        }

        /////////////////////////////////////////////////////////////////////////////////////////////////

        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////

        /// <summary>
        /// Fill SQL paramter for Stored Procedure
        /// <returns>Collection of SQL paramters object</returns>
        private static SqlParameter[] SetParameterSP(string par1, string par2, string par3)
        {
            SqlParameter FiltroParam = new SqlParameter("@YourDatabaseName", SqlDbType.VarChar, 60);
            SqlParameter FiltroParam2 = new SqlParameter("@YourNewDatabaseName", SqlDbType.VarChar, 60);
            SqlParameter FiltroParam3 = new SqlParameter("@dir", SqlDbType.VarChar, 200);

            FiltroParam.Value = par1;
            FiltroParam2.Value = par2;
            FiltroParam3.Value = par3;
            return new SqlParameter[]
            { 
                FiltroParam,FiltroParam2,FiltroParam3
            };
        }


        public IDictionary<string, bool> BasesPorUsuarioColeccion2(Guid id, Guid idAdmin)
        {
            string sc = Generales.FormatearConexParaEntityFrameworkBDLMASTER();
            ProntoMVC.Data.Models.BDLMasterEntities dbMaster = new ProntoMVC.Data.Models.BDLMasterEntities(sc);

            Dictionary<string, bool> baselistado = new Dictionary<string, bool>();

            // tengo que traer tambien las bases que no tienen el usuario asociado
            //  http://stackoverflow.com/questions/9171063/convert-sql-to-linq-left-join-with-null



            /*
                 
        var basesDelUsuario = (from b in dbMaster.Bases
                               // join u in dbMaster.aspnet_Users 
                               // join u in dbMaster.UserDatosExtendidos
                               // join r in dbMaster.aspnet_Roles
                               join ub in dbMaster.DetalleUserBD
                                    on b.IdBD equals ub.IdBD into ub2
                               from ub in ub2.DefaultIfEmpty()
                               where (ub == null || (ub ?? new ProntoMVC.Data.Models.DetalleUserBD()).UserId == id)
                               select new { nombrebase = b.Descripcion, Esta = (ub == null) });

            */


            // var basesDelUsuario=  (from b in dbMaster.Bases select b).ToList();   

            string usuario = ViewBag.NombreUsuario;
            //Guid guiduser = (Guid)Membership.GetUser(usuario).ProviderUserKey; // si no lo encontró en la base pronto, el usuario está en null
            Guid guiduser = (Guid)Membership.GetUser().ProviderUserKey;


            bool EsSuperadmin = Roles.IsUserInRole(usuario, "SuperAdmin");

            foreach (ProntoMVC.Data.Models.Bases b in dbMaster.Bases)
            {
                var basesDelUsuario = (from ub in dbMaster.DetalleUserBD where (ub.UserId == id && ub.IdBD == b.IdBD) select ub).FirstOrDefault();

                var basesDelUsuarioQuepidioLosDatos = (from ub in dbMaster.DetalleUserBD where (ub.UserId == idAdmin && ub.IdBD == b.IdBD) select ub).FirstOrDefault();

                if (!EsSuperadmin && basesDelUsuarioQuepidioLosDatos == null) continue; // si el usuario que pidió los datos no es superadmin, solo le paso aquellas bases a las 

                try
                {
                    baselistado.Add(b.Descripcion, (basesDelUsuario != null));
                }
                catch (Exception ex)
                {
                    ErrHandler.WriteError(ex);

                }

            }






            //baselistado = basesDelUsuario.ToDictionary(x => x.nombrebase.ToString(),
            //                                            x => x.Esta,
            //                                            StringComparer.OrdinalIgnoreCase);


            // filtrar las bases a las que tiene acceso el que va a administrar






            return baselistado;
        }







        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        public List<string> LeerArchivoAPP(int IdUsuario, string sBase, string usuario, DemoProntoEntities dbcontext, Guid userGuid)
        {
            string glbArchivoAyuda = dbcontext.Parametros.Find(1).ArchivoAyuda;
            string glbPathPlantillas = "";
            string s = dbcontext.Parametros.Find(1).PathPlantillas;
            if (s.Length == 0)
            {
                //glbPathPlantillas= App.Path & "\Plantillas"
            }

            else
            {
                glbPathPlantillas = s;
            }




            string glbPathArchivoAPP;


            //if (true)
            //{
            //    // agregamos un sufijo para tener por ahora 2 app hasta que migremos todo;
            //    glbPathArchivoAPP = glbPathPlantillas + @"\..\app\" + sBase + "_web.app";
            //}
            //else
            //{

            glbPathArchivoAPP = glbPathPlantillas + @"\..\app\" + sBase + ".app";

            //}




            //if (System.Diagnostics.Debugger.IsAttached)
            //{
            //    glbPathArchivoAPP = @"C:\Backup\BDL\Actualizacion Final Pronto\Instalacion de CERO\SistemaPronto\DocumentosPronto\APP\Pronto.app";

            if (System.Diagnostics.Debugger.IsAttached)
            {
                // Que sea local
                //glbPathArchivoAPP = @"C:\Backup\BDL\Actualizacion Final Pronto\Instalacion de CERO\SistemaPronto\DocumentosPronto\APP\Pronto.app";
                glbPathArchivoAPP = AppDomain.CurrentDomain.BaseDirectory + @"Documentos\Pronto.app";

            }



            //if  Dir(glbPathPlantillas & "\..\app\*.app", vbArchive) <> "" Then
            //   GuardarArchivoSecuencial glbPathPlantillas & "\..\app\" & glbEmpresaSegunString & ".app", mString
            //Else
            //   GuardarArchivoSecuencial App.Path & "\" & glbEmpresaSegunString & ".app", mString
            //End If

            string contents;
            try
            {
                contents = System.IO.File.ReadAllText(glbPathArchivoAPP);

            }
            catch (Exception ex)
            {
                ErrHandler.WriteError("archivo " + glbPathArchivoAPP);
                ErrorLog2.LogError(ex, "archivo " + glbPathArchivoAPP);
                throw;
            }


            //                    If Len(mString) > 0 Then
            //   mString = mId(mString, 1, Len(mString) - 2)
            //End If
            //mString = MydsEncrypt.Encrypt(mString)
            string salida = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(contents);




            List<string> mVectorAccesos = salida.Split('|').ToList();

            // sacado de frmAccesos.DefinirOrigen()


            //class sss {
            //    idempleado
            //}

            // List<EmpleadosAcceso> mVectorAccesos = new List<EmpleadosAcceso>();
            //var c = new AccesoController();
            //var Arbol = TreeConNiveles(IdUsuario, sBase, usuario, dbcontext, userGuid);

            return mVectorAccesos;

        }


        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





        public IQueryable<Tablas.Tree> TablaTree(string parentId)
        {
            var q = from n in db.Trees
                    where (n.ParentId == parentId)
                    select new Tablas.Tree()
                    {
                        IdItem = n.IdItem,
                        Clave = n.Clave,
                        Descripcion = n.Descripcion,
                        ParentId = n.ParentId,
                        Orden = n.Orden ?? 0,
                        Parametros = n.Parametros,
                        Link = n.Link.Replace("Pronto2", ROOT),
                        Imagen = n.Imagen,
                        EsPadre = n.EsPadre,
                        nivel = 1

                        // , Orden = n.Orden
                    };




            return q;
        }



        public List<Tablas.Tree> TablaTree()
        {
            // return RedirectToAction("Arbol", "Acceso");

            //esta llamada tarda // y no se puede usar linqtosql acá??????
            List<Tablas.Tree> Tree = TablasDAL.Arbol(this.Session["BasePronto"].ToString());

            List<Tablas.Tree> TreeDest = new List<Tablas.Tree>();
            List<Tablas.Tree> TreeDest2 = new List<Tablas.Tree>();


            // if (System.Diagnostics.Debugger.IsAttached) return Tree;



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
            var z = from n in db.Trees
                    join p in permisos on n.Clave equals p.Nodo
                    select new { n, p };

            TreeDest = new List<Tablas.Tree>(Tree); //la duplico

            var archivoapp = LeerArchivoAPP(IdUsuario, this.Session["BasePronto"].ToString(), usuario, db, new Guid(Membership.GetUser().ProviderUserKey.ToString()));


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


                /*

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

            */




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


                if (!essuperadmin && !archivoapp.Contains(o.Clave))
                {
                    nivel = 9;
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
                    string nombreproveedor = "";
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
            if (glbUsuario != null) // puede ser que el usuarioweb no esté definido en esta base como empleado
            {
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



        public List<Tablas.Tree> TablaMenu()
        {




            string usuario = ViewBag.NombreUsuario;






            if (false)
            {
                if (Roles.IsUserInRole(usuario, "Firmas") && Roles.GetRolesForUser(usuario).Count() == 1) // Generales.TienePermisosDeFirma(SC, IdUsuario))
                {
                    return null;
                }

            }


            if ((Roles.IsUserInRole(usuario, "Externo") || Roles.IsUserInRole(usuario, "AdminExterno")) && !Roles.IsUserInRole(usuario, "Administrador") && !Roles.IsUserInRole(usuario, "SuperAdmin")) // Generales.TienePermisosDeFirma(SC, IdUsuario))
            {
                return null;
            }


            List<Tablas.Tree> Tree;
            List<Tablas.Tree> TreeDest;




            Tree = TablasDAL.Menu(this.Session["BasePronto"].ToString());
            TreeDest = new List<Tablas.Tree>();


            //if (System.Diagnostics.Debugger.IsAttached) return Json(TreeDest);


            int IdUsuario = 0;
            Empleado empleado = new Empleado();


            try
            {
                empleado = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).FirstOrDefault();
                if (empleado != null) IdUsuario = empleado.IdEmpleado;
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
                EmpleadosAcceso acc = permisos.Where(x => x.Nodo == o.Clave).FirstOrDefault();

                if (acc==null) continue;

                int? nivel = acc.Nivel;
                
                
                if (nivel == null || !acc.Acceso || nivel==0)
                {
                    nivel = 9;
                }


                // if (essuperadmin) nivel = 1;


                if (o.Descripcion.Contains("ccesos"))
                {
                    if (esadmin || essuperadmin) nivel = 1;
                    else nivel = 9;
                }



                if (false)
                {
                    if ((esfirma || esadmin) && (o.Descripcion.Contains("Autorizaci") || o.Descripcion.Contains("Seguridad"))) nivel = 1;

                    if ((escomercial || esadmin) && (o.Descripcion.Contains("Contabilidad") || o.Descripcion == "Consultas"))
                        nivel = 1;
                    if ((escomercial || esadmin) && (o.Descripcion.Contains("Mayor") || o.Descripcion == "Consultas")) nivel = 1;
                    if ((escomercial || esadmin) && (o.Descripcion.Contains("Balance") || o.Descripcion == "Consultas")) nivel = 1;



                    if ((esreq || esadmin) && (o.Descripcion.Contains("Requerimiento") || o.Descripcion.Contains("Articulo")))
                    {
                        nivel = 1;
                    }

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


            return TreeDest;





        }




        public List<Tablas.Tree> MenuConNiveles_Tree(int IdUsuario)
        {

            List<Tablas.Tree> Tree = TablasDAL.Menu(this.Session["BasePronto"].ToString());
            List<Tablas.Tree> TreeDest = new List<Tablas.Tree>();

            //string usuario = ViewBag.NombreUsuario;
            //int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

            var permisos = (from i in db.EmpleadosAccesos where i.IdEmpleado == IdUsuario select i).ToList();

            foreach (Tablas.Tree o in Tree)
            {
                EmpleadosAcceso acc = permisos.Where(x => x.Nodo == o.Clave).FirstOrDefault();

                //               if (acc == null) continue;
                //if (o.Descripcion.Contains("(")) continue;
                //     if (o.Descripcion.Contains("2") || o.Descripcion.Contains("1")) continue;

                //if (acc.Nivel > 5) o.Descripcion = "Bloqueado! " + o.Descripcion;

                if (acc != null)
                {
                    o.Link = acc.Nodo.NullSafeToString();
                    o.Orden = acc.Nivel ?? -1;
                    o.nivel = o.Orden;
                                }
                else
                {


                }

                if (acc == null ? false : !acc.Acceso)
                {
                    // si el Acceso está en 0, el nodo está invisible para el usuario
                    o.Link = acc.Nodo.NullSafeToString();
                    o.Orden = 9;
                    o.nivel = o.Orden;
                }



                TreeDest.Add(o);

            }

            return TreeDest;

        }


        public List<Tablas.Tree> ArbolConNiveles_Tree(int IdUsuario, string sBase, string usuario, DemoProntoEntities dbcontext, Guid userGuid = new Guid())
        {

            List<Tablas.Tree> Tree = TablasDAL.Arbol(sBase, userGuid);
            List<Tablas.Tree> TreeDest = new List<Tablas.Tree>();

            //string usuario = ViewBag.NombreUsuario;
            //int IdUsuario = dbcontext.Empleados.Where(x => x.Nombre == usuario).Select(x => x.IdEmpleado).FirstOrDefault();




            bool esSuperAdmin;
            bool esAdmin;


            if (System.Diagnostics.Debugger.IsAttached)
            {
                esSuperAdmin = true;
                esAdmin = true;
            }
            else
            {
                esSuperAdmin = Roles.GetRolesForUser(usuario).Contains("SuperAdmin");
                esAdmin = Roles.GetRolesForUser(usuario).Contains("Administrador");

            }


            var archivoapp = LeerArchivoAPP(IdUsuario, sBase, usuario, dbcontext, userGuid);


            var permisos = (from i in dbcontext.EmpleadosAccesos where i.IdEmpleado == IdUsuario select i).ToList();

            var z = from n in Tree
                    join p in permisos on n.Clave equals p.Nodo
                    select new { n, p };

            // la cuestion es: si no lo ves (el superadmin te puso nivel mínimo) , tampoco lo debés poder administrar (aunque seas administrador)
            // Con esto bastaría... si no fuese porque alguien puede meterse y editar las tablas. Ahí usar el .app

            //var q = from p in permisos 
            //        join n in Tree on p.Nodo equals n.Clave
            //        select n;


            foreach (Tablas.Tree o in Tree)
            {


                EmpleadosAcceso acc = permisos.Where(x => x.Nodo == o.Clave).FirstOrDefault();

                //               if (acc == null) continue;
                //if (o.Descripcion.Contains("(")) continue;

                o.nivel = 9;


                if (!archivoapp.Contains(o.Clave))
                {

                    o.Descripcion = "NO MOSTRAR";
                    o.Orden = -999;
                }

                else if (o.Descripcion.Contains("2") || o.Descripcion.Contains("1")) // || o.Descripcion.Contains("por ")) no, esto lo debo hacer con eliminarNodoHijos, porque el nodo padre debe verse
                {
                    //no los puedo saltar porque los cierres <ul> hechos manualmente en jscript dependiendo del nivel del item, te descajetan el arbol

                    //continue;
                    o.Descripcion = "NO MOSTRAR";
                    o.Orden = -999;

                }

                else if (acc == null ? false : !acc.Acceso)
                {
                    // si el Acceso está en 0, el nodo está invisible para el usuario
                    o.Clave = acc.Nodo;
                    o.Orden = acc.IdEmpleadoAcceso;//  acc.IdEmpleadoAcceso;
                    o.Link = "9";
                }


                else if ((acc == null || (acc ?? new EmpleadosAcceso()).Nivel == 9) && !esSuperAdmin && !esAdmin)
                {
                    // la cuestion es: si no lo ves (el superadmin te puso nivel mínimo) , tampoco lo debés 
                    // poder administrar (aunque seas administrador -ok, pero ahí tenes que revisar el nivel del administrador, no del acc.nivel que es el usuario editado)
                    // Con esto bastaría... si no fuese porque alguien puede meterse y editar las tablas. Ahí usar el .app

                    o.Descripcion = "NO MOSTRAR";
                    o.Orden = -999;
                }

                else if (acc != null)
                {
                    o.Clave = acc.Nodo;
                    o.Orden = acc.IdEmpleadoAcceso;
                    o.Link = acc.Nivel.NullSafeToString();

                    o.nivel = acc.Nivel ?? 9;

                }
                else
                {
                    if (esSuperAdmin)
                    {

                        o.nivel = 9;
                    }
                    else
                    {

                        o.Orden = 0;
                    }
                }





                TreeDest.Add(o);

            }

            var l = TreeDest.Where(n => n.Descripcion == "Bloqueado!" || n.Descripcion == "NO MOSTRAR").ToList();
            foreach (Tablas.Tree n in l)
            {
                eliminarNodoySusHijos(n, ref TreeDest);
            }

            var g = TreeDest.Where(n => n.Descripcion.StartsWith("por ") || n.Descripcion.StartsWith("PorRendi")).ToList();
            foreach (Tablas.Tree n in g)
            {
                eliminarSoloHijos(n, ref TreeDest);
            }


            if (TreeDest.Count > 900) throw new Exception("La cantidad de EmpleadosAccesos es mayor que 900");


            return TreeDest;
        }



        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        public void eliminarSoloHijos(Tablas.Tree o, ref List<Tablas.Tree> TreeDest)
        {
            List<Tablas.Tree> hijos = TreeDest.Where(x => x.ParentId == o.IdItem).ToList();
            foreach (Tablas.Tree h in hijos)
            {
                eliminarSoloHijos(h, ref TreeDest);
                TreeDest.Remove(h);
            }
            //TreeDest.Remove(o); // si esta afuera del foreach, elimina tambien al padre
        }

        public void eliminarNodoySusHijos(Tablas.Tree o, ref List<Tablas.Tree> TreeDest)
        {
            List<Tablas.Tree> hijos = TreeDest.Where(x => x.ParentId == o.IdItem).ToList();
            foreach (Tablas.Tree h in hijos)
            {
                eliminarNodoySusHijos(h, ref TreeDest);
                //TreeDest.Remove(h);
            }
            TreeDest.Remove(o); // si esta afuera del foreach, elimina tambien al padre
        }

        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////ENCRIPTACIONES //////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////

        /// <summary>
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// </summary>
        /// <returns></returns>

        public bool VerificarClaveDeRoles()
        {
            return true; //TO DO: volver a habilitar

            string sc = Generales.FormatearConexParaEntityFrameworkBDLMASTER();
            ProntoMVC.Data.Models.BDLMasterEntities dbMaster = new ProntoMVC.Data.Models.BDLMasterEntities(sc);

            string checksumguardado = dbMaster.Bases.Where(x => x.Descripcion == "Checksum").Select(x => x.StringConection).FirstOrDefault();

            string checksumactual = CalcularActualClaveDeRoles();



            return (checksumguardado == checksumactual || checksumguardado == "Inicio de Base");
        }

        public void GrabarNuevaClaveDeRoles()
        {
            string sc = Generales.FormatearConexParaEntityFrameworkBDLMASTER();
            ProntoMVC.Data.Models.BDLMasterEntities dbMaster = new ProntoMVC.Data.Models.BDLMasterEntities(sc);

            ProntoMVC.Data.Models.Bases b = dbMaster.Bases.Where(x => x.Descripcion == "Checksum").FirstOrDefault();

            if (b == null)
            {
                b = new ProntoMVC.Data.Models.Bases();
                b.Descripcion = "Checksum";
                b.StringConection = CalcularActualClaveDeRoles();
                dbMaster.Bases.Add(b);
            }
            else
            {
                b.StringConection = CalcularActualClaveDeRoles();
            }

            //   dbMaster.SaveChanges();
        }


        public string CalcularActualClaveDeRoles()
        {
            string sc = Generales.FormatearConexParaEntityFrameworkBDLMASTER();
            ProntoMVC.Data.Models.BDLMasterEntities dbMaster = new ProntoMVC.Data.Models.BDLMasterEntities(sc);


            long checksum = dbMaster.vw_aspnet_UsersInRoles.Sum(x => 4); // (long) x.RoleId. );

            return (checksum % 1234567).ToString();

        }
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        // Edu hace así:
        // Case 0, 9
        //If mvarSuperAdministrador Then
        // es decir, solo reacciona ante los niveles extremos Y ADEMAS tiene que estar puesto el superadministrador


        public void GuardarArchivoSecuencial__EncriptadoPuntoAPP()
        {


            // Edu hace así en frmAccesos:
            // Case 0, 9
            //If mvarSuperAdministrador Then
            // es decir, solo reacciona ante los niveles extremos Y ADEMAS tiene que estar puesto el superadministrador


        }


        public void LeerArchivoSecuencial_____EncriptadoPuntoAPP()
        {

            // Edu hace así frmAccesos:
            // Case 0, 9
            //If mvarSuperAdministrador Then
            // es decir, solo reacciona ante los niveles extremos Y ADEMAS tiene que estar puesto el superadministrador



            //           mString = LeerArchivoSecuencial(mArchivoDefinicionAccesos)
            //If Len(mString) > 0 Then
            //   mString = mId(mString, 1, Len(mString) - 2)
            //End If
            //mString = MydsEncrypt.Encrypt(mString)
            //mVectorAccesos = VBA.Split(mString, "|")
        }

        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        public int CantidadFirmasConfirmadas(Pronto.ERP.Bll.EntidadManager.EnumFormularios Comprobante,
                                         long IdComprobante,
                                           double? Importe = null)
        {
            //Dim oRsAut1 As ADOR.Recordset
            //Dim oRsAut2 As ADOR.Recordset
            //Dim mCantidadFirmas As Integer, i As Integer, mFirmasConfirmadas As Integer
            //Dim mFirmas() As Boolean

            //mFirmasConfirmadas = 0

            //Set oRsAut1 = Aplicacion.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(Comprobante, Importe, IdComprobante))

            var q = db.Autorizaciones_TX_CantidadAutorizaciones((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.RequerimientoMateriales, 0, -1).Count();

            //If oRsAut1.RecordCount > 0 Then
            //   mCantidadFirmas = oRsAut1.RecordCount
            //   ReDim mFirmas(mCantidadFirmas)
            //   For i = 1 To mCantidadFirmas
            //      mFirmas(i) = False
            //   Next

            //   Set oRsAut2 = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(Comprobante, IdComprobante))
            //   With oRsAut2
            //      If .RecordCount > 0 Then
            //         .MoveFirst
            //         Do While Not .EOF
            //            oRsAut1.MoveFirst
            //            Do While Not oRsAut1.EOF
            //               If oRsAut1.Fields(0).Value = .Fields("OrdenAutorizacion").Value Then
            //                  mFirmas(oRsAut1.AbsolutePosition) = True
            //                  Exit Do
            //               End If
            //               oRsAut1.MoveNext
            //            Loop
            //            .MoveNext
            //         Loop
            //      End If
            //      oRsAut2.Close
            //   End With

            //   For i = 1 To mCantidadFirmas
            //      If mFirmas(i) Then mFirmasConfirmadas = mFirmasConfirmadas + 1
            //   Next
            //Else
            //   Set oRsAut2 = Aplicacion.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(Comprobante, IdComprobante))
            //   mFirmasConfirmadas = oRsAut2.RecordCount
            //   oRsAut2.Close
            //End If
            //oRsAut1.Close

            //Set oRsAut1 = Nothing
            //Set oRsAut2 = Nothing

            //CantidadFirmasConfirmadas = mFirmasConfirmadas

            return 0;
        }
    }

    public interface IProntoInterface<T>
    {
        // string Word { get; set; }
        // void DoIt();
        void CargarViewBag(T obj);
    }

}


public static class ErrorLog2
{
    /// <summary>
    /// Log error to Elmah
    /// </summary>
    public static void LogError(Exception ex, string contextualMessage = null)
    {
        try
        {
            // log error to Elmah
            if (contextualMessage != null)
            {
                // log exception with contextual information that's visible when 
                // clicking on the error in the Elmah log
                var annotatedException = new Exception(contextualMessage, ex);
                ErrorSignal.FromCurrentContext().Raise(annotatedException, HttpContext.Current);
            }
            else
            {
                ErrorSignal.FromCurrentContext().Raise(ex, HttpContext.Current);
            }

            // send errors to ErrorWS (my own legacy service)
            // using (ErrorWSSoapClient client = new ErrorWSSoapClient())
            // {
            //    client.LogErrors(...);
            // }
        }
        catch (Exception)
        {
            // uh oh! just keep going
        }
    }
};
