using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
//using ProntoMVC.Data.Models;
using ProntoMVC.Models;

using System.Data.SqlClient;

using Pronto.ERP.Bll;
using System.Configuration;
using System.Data;



namespace ProntoMVC.Controllers
{
    public partial class AccountController : Controller // este no creo que deba heredar ProntoBaseController, no? -por qué?
    {

        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////


        public Generales.IStaticMembershipService oStaticMembershipService; // como no heredo prontobasecontroller, tengo que crearla





        protected override void Initialize(System.Web.Routing.RequestContext rc)
        {
            //MiniProfiler profiler = MiniProfiler.Current;

            base.Initialize(rc);
            oStaticMembershipService = new Generales.StaticMembershipService();
            ViewBag.BasePronto = this.Session["BasePronto"];

        }







        private const int PageSize = 200;
        private const string ResetPasswordBody = "Your new password is: ";
        private const string ResetPasswordSubject = "Your New Password";
        private readonly MvcMembership.IRolesService _rolesService;
        private readonly MvcMembership.ISmtpClient _smtpClient;
        private readonly MvcMembership.Settings.IMembershipSettings _membershipSettings;
        private readonly MvcMembership.IUserService _userService;
        private readonly MvcMembership.IPasswordService _passwordService;


        /// <summary>
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// </summary>
        /// <returns></returns>






        [AcceptVerbs(HttpVerbs.Post)]
        public virtual bool DBConnectionStatus()
        {

            // var sc=   sCadenaConexSQL(string nombreEmpresa, Guid userGuid = new Guid());
      
            var sConexBDLMaster = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;

            //var sConexSQL = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(sConexBDLMaster);

      

            try
            {
                using (SqlConnection sqlConn = new SqlConnection(sConexBDLMaster))
                {
                    sqlConn.Open();

                    return (sqlConn.State == ConnectionState.Open);
                }
            }
            catch (SqlException)
            {
                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }




        ////////////////////////////////////////////////
        ////////////////////////////////////////////////

        // set UltimaBaseElegida();
        //get UltimaBaseAccedidaa() 
        public void GrabarUltimaBaseAccedida(string usuario, string sBase, Generales.IStaticMembershipService ServicioMembership)
        {

            if (sBase == "")
            {
                throw new Exception("La base no existe");
            }


            MembershipUser membershipUser;
            membershipUser = ServicioMembership.GetUser();

            //var rol = Roles.GetRolesForUser(e.CommandArgument.ToString);

            UserDatosExtendidosManager.Update(membershipUser.ProviderUserKey.ToString(), sBase);
        }



        class c
        {
            public Guid IdFactura;
            public Guid UserId;
            public string UserName;
            public int IdEmpleado;
            public string leyenda;
        };



        public virtual ActionResult Usuarios(string sidx, string sord, int? page, int? rows, bool? _search, string searchField, string searchOper, string searchString
                                            )
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;


            ProntoMVC.Data.Models.BDLMasterEntities bdlmaster = new ProntoMVC.Data.Models.BDLMasterEntities(Generales.FormatearConexParaEntityFrameworkBDLMASTER());


            string sc = Generales.sCadenaConex((string)Session["BasePronto"]);
            if (sc == null)
            {
                return RedirectToAction("ElegirBase");
                return null;
            }
            ProntoMVC.Data.Models.DemoProntoEntities pronto = new ProntoMVC.Data.Models.DemoProntoEntities(sc);



            var emp = (from n in pronto.Empleados select new { n.UsuarioNT, n.IdEmpleado, n.Nombre }).ToList();

            var usersext = (from u in bdlmaster.aspnet_Users
                            join ur in bdlmaster.vw_aspnet_UsersInRoles on u.UserId equals ur.UserId
                            join r in bdlmaster.aspnet_Roles on ur.RoleId equals r.RoleId
                            where
                                // !emp.Select(x => x.UsuarioNT).Contains(u.UserName)  && 
                                (r.RoleName == "AdminExterno" || r.RoleName == "Externo" || r.RoleName == "ExternoOrdenesPagoListas" || r.RoleName == "ExternoCuentaCorrienteProveedor" || r.RoleName == "ExternoCuentaCorrienteCliente" || r.RoleName == "ExternoCotizaciones")
                            select new { u.UserId, u.UserName }
                ).Distinct().ToList();

            var users1 = (from u in bdlmaster.aspnet_Users
                          //join ur in bdlmaster.vw_aspnet_UsersInRoles on u.UserId equals ur.UserId
                          //join r in bdlmaster.aspnet_Roles on ur.RoleId equals r.RoleId
                          //   where !usersext.Select(x => x.UserName).Contains(u.UserName) 
                          //     && 
                          //!(r.RoleName == "AdminExterno" || r.RoleName == "Externo" || r.RoleName == "ExternoOrdenesPagoListas" || r.RoleName == "ExternoCuentaCorrienteProveedor" || r.RoleName == "ExternoCuentaCorrienteCliente" || r.RoleName == "ExternoCotizaciones")
                          select new { u.UserId, u.UserName }).Distinct().ToList();

            var users = (from u in users1
                         where !usersext.Select(x => x.UserName).Contains(u.UserName)
                         select u).ToList();


            // Verificar que No tienen Roles externos


            var Fac4 = (from u in users
                        join n in emp on u.UserName equals n.UsuarioNT
                        where !usersext.Select(x => x.UserName).Contains(u.UserName)
                        select new c
                        {
                            IdFactura = u.UserId,
                            UserId = u.UserId,
                            UserName = u.UserName,
                            IdEmpleado = n.IdEmpleado,
                            leyenda = "con empleado"
                        }
                       ).ToList();

            var Fac2 = (from u in users
                        where !emp.Select(x => x.UsuarioNT).Contains(u.UserName)
                        select new c
                        {
                            IdFactura = u.UserId,
                            UserId = u.UserId,
                            UserName = u.UserName,
                            IdEmpleado = 0,
                            leyenda = "sin empleado en la base"
                        }
                       ).ToList();



            var Fac8 = (from u in usersext
                        select new c
                        {
                            IdFactura = u.UserId,
                            UserId = u.UserId,
                            UserName = u.UserName,
                            IdEmpleado = 0,
                            leyenda = "usuario externo!"
                        }
                       ).ToList();


            var Fac3 = (from e in emp
                        where !users.Select(x => x.UserName).Contains(e.UsuarioNT) && !usersext.Select(x => x.UserName).Contains(e.UsuarioNT)
                        select new c
                        {
                            IdFactura = new Guid(),
                            UserId = new Guid(),
                            UserName = (e.UsuarioNT ?? "") == "" ? "sin usuario [" + e.Nombre + "]" : e.UsuarioNT,
                            IdEmpleado = e.IdEmpleado,
                            leyenda = "sin usuario"
                        }
                       ).ToList();


            var Fac = Fac3.Union(Fac2).Union(Fac4).Union(Fac8);






            var Req1 = (from a in Fac
                        select new
                        {
                            IdFactura = a.UserId,
                            UserId = a.UserId,
                            UserName = a.UserName,
                            IdEmpleado = a.IdEmpleado

                            //NumeroFactura = a.NumeroFactura,
                            //FechaFactura = a.FechaFactura,
                            //NumeroObra=a.Obra.NumeroObra,
                            //Libero=a.Empleados.Nombre,
                            //Aprobo = a.Empleados1.Nombre,
                            //Sector=a.Sectores.Descripcion,
                            //Detalle=a.Detalle
                        });
            //).Where(campo);


            var empleados = (from u in bdlmaster.aspnet_Users
                             //join n in bdlmaster.aspnet_Users on u.
                             select u

                       ).AsQueryable();




            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);


            var data = (from a in Fac
                        //join c in db.Clientes on a.IdCliente equals c.IdCliente
                        select a)
                //        .Include(x => x.Cliente)
                //        .Include(x => x.Moneda)
                //        .Include(x => x.Obra)
                //        .Include(x => x.Cliente.DescripcionIva)
                //        .Include(x => x.Vendedore)
                //        .Include(x => x.Provincia)
                //        .Include(x => x.DetalleFacturas)
                ////.Include(x => x.i)
                //        .Where(campo)
                //.OrderBy(sidx + " " + sord)
                        .OrderBy(x => x.UserName).ThenByDescending(x => x.UserId)

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
                            id = a.UserId.ToString(),
                            cell = new string[] { 
                                a.UserName,

                                // "<a href="+ Url.Action("Edit",new {id = a.UserId} )  +" target='_blank' >Editar</>"
                                //+
                                //"|" +
                                //"<a href=/Factura/Details/" + a.IdFactura + ">Detalles</a> "
                                
                            a.leyenda!="sin usuario"  ? 
                            
                            "<a href="+ Url.Action("Details",  "UserAdministration",new {id = a.UserId, area="MvcMembership" } )  +">Web" +   (a.leyenda=="usuario externo!"  ? " externo"  : ""  ) +  "</>" :         
                            
                            "<a href="+ Url.Action("CreateUser",  "UserAdministration",new {id = -1, area="MvcMembership" } )  +">CREAR USUARIO</>",



                            a.IdEmpleado>0   ?  "<a href="+ Url.Action("Edit", "Empleado",new {id = a.IdEmpleado, area = ""} )  +">Empleado</>"  
                                                +" - <a href="+ Url.Action("Edit", "Acceso",new {id = a.IdEmpleado, area = ""} )  +">Accesos</>" 
                                                :       
                                a.leyenda!="usuario externo!"  ? 
                                        "<a href="+ Url.Action("Edit",  "Empleado",new {id = -1, area="" } )  +">CREAR EMPLEADO</>" : "",

                                            
                            "mostrar si el usuario web no tiene empleado, o viceversa", a.leyenda
                                // create una vista y chau
 



                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        public string BuscarUltimaBaseAccedida(Generales.IStaticMembershipService ServicioMembership)
        {
            MembershipUser membershipUser;
            //if (usuario == "")
            //{
            membershipUser = ServicioMembership.GetUser();
            //}
            //else
            //{
            //membershipUser = ServicioMembership.GetUser(usuario);
            //}

            if (membershipUser == null)
            {
                // por qué pasa esto? el tipo recien se está logueando?
                return null;
            }

            var a = UserDatosExtendidosManager.Traer(membershipUser.ProviderUserKey.ToString());

            if (a == null) return null;
            return a.UltimaBaseAccedida;
        }


        public class UserDatosExtendidosManager
        {
            public static object Update(string userid, string UltimaBaseAccedida, string cuit = "")
            {

                ProntoMVC.Data.Models.BDLMasterEntities bdlmaster = new ProntoMVC.Data.Models.BDLMasterEntities(Generales.FormatearConexParaEntityFrameworkBDLMASTER());


                ProntoMVC.Data.Models.UserDatosExtendidos us = bdlmaster.UserDatosExtendidos.Where(x => x.UserId == new Guid(userid)).FirstOrDefault();
                if (us == null)
                {
                    us = new ProntoMVC.Data.Models.UserDatosExtendidos();
                    us.UserId = new Guid(userid); // (Guid)u.ProviderUserKey;

                    us.UltimaBaseAccedida = UltimaBaseAccedida;
                    bdlmaster.UserDatosExtendidos.Add(us);
                }
                else
                {
                    us.UltimaBaseAccedida = UltimaBaseAccedida;
                    bdlmaster.UserDatosExtendidos.Attach(us);

                    bdlmaster.Entry(us).State = System.Data.Entity.EntityState.Modified;


                }

                bdlmaster.SaveChanges();

                return null;

            }

            public static ProntoMVC.Data.Models.UserDatosExtendidos Traer(string UserId)
            {


                ProntoMVC.Data.Models.BDLMasterEntities db = new ProntoMVC.Data.Models.BDLMasterEntities(Generales.FormatearConexParaEntityFrameworkBDLMASTER());


                ProntoMVC.Data.Models.UserDatosExtendidos uext = (from p in db.UserDatosExtendidos where p.UserId == new Guid(UserId) select p).SingleOrDefault();

                return uext;
            }

        }


        ////////////////////////////////////////////////
        ////////////////////////////////////////////////
        ////////////////////////////////////////////////
        ////////////////////////////////////////////////
        ////////////////////////////////////////////////
        ////////////////////////////////////////////////


        //
        // GET: /Account/LogOn

        public virtual ActionResult LogOn()
        {
            /* http://stackoverflow.com/questions/3180291/mvc2-logonmodel-not-found */

            if (false)
            {

                if (System.Diagnostics.Debugger.IsAttached && Session["NoReloguear"] != "true")
                //if (ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString.Contains("MARIANO") 
                {
                    // this.Session["BasePronto"] = "Autotrol";
                    if (Membership.ValidateUser("Mariano", "pirulo!"))
                    {
                        FormsAuthentication.SetAuthCookie("Mariano", true);

                        //ver qué base tiene

                        if (ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString.Contains("MARIANO"))
                        {
                            this.Session["BasePronto"] = "wDemoWilliams"; // "wDemoWilliams" ; //"Esuco"; // "Capen";
                        }
                        else
                        {
                            this.Session["BasePronto"] = "Esuco"; //"Esuco"; // "Capen";
                        }
                        return RedirectToAction("Index", "Home");
                    }
                }
            }

            /* http://stackoverflow.com/questions/3180291/mvc2-logonmodel-not-found */
            return View();
        }

        //
        // POST: /Account/LogOn

        [HttpPost]
        public virtual ActionResult LogOn(LogOnModel model, string returnUrl, string empresa)
        {

            if (ModelState.IsValid)
            {

                if (Membership.ValidateUser(model.UserName, model.Password))
                {

                    ////////////////////////////////////////////////////////////////////////////
                    // this.Session["BasePronto"] = "Autotrol"; // TODO: acá hay que usar lo elegido en el combo de empresa
                    ////////////////////////////////////////////////////////////////////////////

                    FormsAuthentication.Initialize();

                    FormsAuthentication.SetAuthCookie(model.UserName, model.RememberMe);


                    // http://stackoverflow.com/questions/13276368/asp-net-mvc-4-custom-authorization-ticket-redirect-issue
                    FormsAuthenticationTicket authTicket = new
                            FormsAuthenticationTicket(1, //version
                            model.UserName, // user name
                            DateTime.Now,             //creation
                            DateTime.Now.AddDays(15), //Expiration (you can set it to 1 month
                            true,  //Persistent
                              ""); // additional informations


                    HttpCookie ck = new HttpCookie(FormsAuthentication.FormsCookieName,
                        FormsAuthentication.Encrypt(authTicket));
                    ck.Path = FormsAuthentication.FormsCookiePath;
                    Response.Cookies.Add(ck);



                    int b = Generales.BasesDelUsuario((Guid)Membership.GetUser(model.UserName).ProviderUserKey);

                    if (true)
                    {
                        if (b == 0)
                        {

                            try
                            {
                                //Roles.GetRolesForUser(oStaticMembershipService.GetUser().UserName)
                                if (Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin"))
                                {
                                    //    return RedirectToAction("Index", "Autorizacion", new { area = "" });
                                    return RedirectToAction("Details", "UserAdministration", new { area = "MvcMembership", id = Membership.GetUser().ProviderUserKey.ToString() });


                                }

                            }
                            catch (Exception ex)
                            {

                                ErrHandler2.WriteError(ex);
                            }


                            ModelState.AddModelError("", "El administrador habilitó tu cuenta, pero todavía no tenés base asignada. Por favor consultalo con el administrador");
                            return View(model);



                        }


                    }

                    //metodo con base default


                    if (Url.IsLocalUrl(returnUrl) && returnUrl.Length > 1 && returnUrl.StartsWith("/")
                        && !returnUrl.StartsWith("//") && !returnUrl.StartsWith("/\\") && !returnUrl.Contains("LogOn"))
                    {


                        // faltaría loguearse en la base default, y recien ahí hacer el redirect al returnurl. Pero
                        // lo que pasa es que es ElegirBase la que estaba haciendo el trabajito de buscar la base default

                        if (false)
                        {
                            this.Session["BasePronto"] = Generales.BaseDefault((Guid)Membership.GetUser(model.UserName).ProviderUserKey);
                            GrabarUltimaBaseAccedida(model.UserName, this.Session["BasePronto"].ToString(), oStaticMembershipService);
                        }
                        else
                        {
                            if (empresa != "" && empresa != "/")
                            {
                                this.Session["BasePronto"] = empresa;
                            }

                            else if (BuscarUltimaBaseAccedida(oStaticMembershipService) != "")
                            {
                                this.Session["BasePronto"] = BuscarUltimaBaseAccedida(oStaticMembershipService);

                            }

                        }

                        //return RedirectToAction("ElegirBase", "Account");
                        //return RedirectToAction("Index", "Home");



                        // si no tiene permisos para ir a la returnurl, que lo redirija a la home
                        // http://stackoverflow.com/questions/1807604/check-if-user-has-permission-to-access-a-url-for-use-with-logon-return-url
                        // http://stackoverflow.com/questions/2909706/how-to-avoid-open-redirect-vulnerability-and-safely-redirect-on-successful-login?rq=1
                        // TODO: por ahora no le encuentro la vuelta
                        if (false)
                        {
                            return Redirect(returnUrl);
                        }
                        else
                        {

                            return RedirectToAction("Index", "Home");
                        }

                    }
                    else
                    {
                        if (empresa != "" && empresa != "/")
                        {
                            this.Session["BasePronto"] = empresa;
                            return RedirectToAction("Index", "Home");
                        }

                        if (BuscarUltimaBaseAccedida(oStaticMembershipService) != "")
                        {
                            this.Session["BasePronto"] = BuscarUltimaBaseAccedida(oStaticMembershipService);
                            return RedirectToAction("Index", "Home");
                        };



                        // por ahora, forzar la eleccion
                        if (b == 1)
                        {
                            //this.Session["BasePronto"] = Generales.BaseDefault((Guid)Membership.GetUser(model.UserName).ProviderUserKey);
                            //return Redirect(returnUrl);

                            return RedirectToAction("ElegirBase", "Account"); // el elegirbase se da cuenta solito si tiene una sola base asignada
                        }
                        else
                        {

                            return RedirectToAction("ElegirBase", "Account");

                        }


                    }
                }
                else
                {



                    MembershipUser user = Membership.GetUser(model.UserName);
                    if (user != null)
                    {

                        if (user.IsLockedOut)
                        {
                            ModelState.AddModelError("", "El usuario está bloqueado");
                            return View(model);
                        }
                        if (!user.IsApproved)
                        {
                            ModelState.AddModelError("", "El usuario no está aprobado");
                            return View(model);
                        }

                    }



                    ModelState.AddModelError("", "El nombre de usuario o la contraseña especificados son incorrectos.");
                }
            }

            // Si llegamos a este punto, es que se ha producido un error y volvemos a mostrar el formulario
            return View(model);
        }

        //
        // GET: /Account/LogOff

        public virtual ActionResult LogOff()
        {
            FormsAuthentication.SignOut();

            this.Session["NoReloguear"] = "true"; //debug

            return RedirectToAction("Index", "Home");
        }


        //
        // GET: /Account/Register

        public virtual ActionResult RecuperarPassword()
        {
            return View();
        }















        public virtual ViewResult CambiarPassword()
        {
            //return View(new ProntoMVC.Areas.MvcMembership.Models.UserAdministration.DetailsViewModel());
            //  string temp = id;


            //id = Generales.descifrar(id);

            var user = Membership.GetUser();
            ViewBag.NombreUsuario = user.UserName;

            return View(new ProntoMVC.Areas.MvcMembership.Models.UserAdministration.DetailsViewModel
            {
                DisplayName = user.UserName,
                User = user,

            });
        }



        [AcceptVerbs(HttpVerbs.Post)]
        public virtual JsonResult SetMiPassword(string password, string nuevapass)
        {
            if (password=="" || nuevapass=="")
            {
                return Json("La contraseña está en blanco");
            }

            var u = Membership.GetUser();
            if (u.ChangePassword(password, nuevapass))
            {
                return Json("Cambiada");
            }
            else
            {
                return Json("No se pudo cambiar la contraseña");
            }






            /////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////
            //var user = _userService.Get(id);
            //_passwordService.ChangePassword(user, password);

            //var body = ResetPasswordBody + password;
            //var msg = new MailMessage();
            //msg.To.Add(user.Email);
            //msg.Subject = ResetPasswordSubject;
            //msg.Body = body;
            //_smtpClient.Send(msg);

            //return RedirectToAction("Password", new { id });
        }



        [HttpPost]
        public virtual ActionResult RecuperarPassword(RecuperarPasswordModel model)
        {


            var u = Membership.GetUser(model.UserName);
            if (u == null)
            {
                TempData["Alerta"] = "Se envió un correo al usuario";
                return View();
            }

            if (false)
            {

                var cc = new Areas.MvcMembership.Controllers.UserAdministrationController();

                TempData["Alerta"] = cc.ResetearPass((Guid)u.ProviderUserKey, model.RespuestaSecreta);
                return View();
            }

            // http://stackoverflow.com/questions/1316826/how-should-i-implement-forgot-your-password-in-asp-net-mvc/1316860#1316860

            model.RespuestaSecreta = "Respuesta";
            string password = Membership.Provider.GetPassword(model.UserName, model.RespuestaSecreta);



            if (true) //(createStatus == MembershipCreateStatus.Success)
            {
                //FormsAuthentication.SetAuthCookie(model.UserName, false /* createPersistentCookie */);
                //return RedirectToAction("Index", "Home");

                //enviarmail

                //////////////////////////////////////////////////////////////////////////////////////


                var body = "Tu contraseña es:"
                    // + u.UserName + " diríjase a la direccion " +
                    // "http://localhost:40053" + "/Pronto2/Account/Verificar/" + u.ProviderUserKey
                        ;

                var direccion = u.Email;

                ProntoFuncionesGenerales.MandaEmailSimple(direccion,
                                    "Recuperar contraseña",
                               body,
                                ConfigurationManager.AppSettings["SmtpUser"],
                                ConfigurationManager.AppSettings["SmtpServer"],
                                ConfigurationManager.AppSettings["SmtpUser"],
                                ConfigurationManager.AppSettings["SmtpPass"],
                                  "",
                               Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));
            }
            else
            {
                // ModelState.AddModelError("", ErrorCodeToString(createStatus));
            }

            TempData["UserName"] = u.UserName;
            TempData["ProviderUserKey"] = u.ProviderUserKey;

            TempData["Alerta"] = "Enviado";
            return View();
        }

        //
        // GET: /Account/Register

        public virtual ActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register

        [HttpPost]
        public virtual ActionResult Register(RegisterModel model)
        {




            if (ModelState.IsValid)
            {


                if (!ProntoMVC.Data.FuncionesGenericasCSharp.CUITValido(model.Grupo.NullSafeToString()) && model.Grupo.NullSafeToString() != "") // (si no se informa, solo se podrá autorizar por un Administrador)
                {

                    //  como devuelvo los errores del ModelState si uso un JsonResult en lugar de una View(ViewResult)???
                    // con View puedo devolver el objeto joya... con Json qué serializo? 
                    // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json


                    ModelState.AddModelError("Cuit", "El CUIT es incorrecto"); //http://msdn.microsoft.com/en-us/library/dd410404(v=vs.90).aspx

                    if (false)
                    {
                        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                        List<string> errors = new List<string>();
                        errors.Add("El CUIT es incorrecto");
                        // return Json(errors);

                    }
                    else
                    {
                        TempData["Alerta"] = "El CUIT es incorrecto";
                        return View("Register", model);
                    }
                }



                if (Generales.AdministradoresDeEsteGrupo(model.Grupo).Count == 0)
                {

                    //TempData["Alerta"] = "El grupo no existe";
                    //return View("Register", model);

                }





                // Intento de registrar al usuario
                MembershipCreateStatus createStatus;
                var u = Membership.CreateUser(model.UserName, model.Password, model.Email, "pregunta", "respuesta", false, null, out createStatus);






                if (createStatus == MembershipCreateStatus.Success)
                {  //agregar rol externo
                    try
                    {
                        Roles.AddUserToRole(u.UserName, "Externo");
                    }
                    catch (Exception)
                    {

                        throw;
                    }

                    // agregar base default
                    try
                    {
                        if (Membership.GetUser() != null)
                        {
                            string ds = Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey);
                            string baseprontodefault = "";
                            try
                            {
                                baseprontodefault = this.Session["BasePronto"].ToString();
                            }
                            catch (Exception)
                            {


                            }

                            if (baseprontodefault == "") baseprontodefault = ds;

                            var c = new Areas.MvcMembership.Controllers.UserAdministrationController();
                            c.AddToEmpresa((Guid)u.ProviderUserKey, baseprontodefault);

                        }

                        else
                        {

                            // se está registrando un nuevo usuario

                        }

                    }
                    catch (Exception e)
                    {

                        ErrHandler.WriteError(e); //throw;
                    }
                    if (false)
                    {

                        FormsAuthentication.SetAuthCookie(model.UserName, false /* createPersistentCookie */);
                        return RedirectToAction("Index", "Home");

                        //enviarmail
                    }
                    else
                    {

                        //falta guardar else cuit en userextendidos
                        using (ProntoMVC.Data.Models.BDLMasterEntities bdlmaster = new ProntoMVC.Data.Models.BDLMasterEntities(Generales.FormatearConexParaEntityFrameworkBDLMASTER()))
                        {
                            ProntoMVC.Data.Models.UserDatosExtendidos us = bdlmaster.UserDatosExtendidos.Where(x => x.UserId == (Guid)u.ProviderUserKey).FirstOrDefault();
                            if (us == null)
                            {
                                us = new ProntoMVC.Data.Models.UserDatosExtendidos();
                                us.UserId = (Guid)u.ProviderUserKey;

                                us.RazonSocial = model.Grupo;
                                bdlmaster.UserDatosExtendidos.Add(us);
                            }
                            else
                            {
                                us.RazonSocial = model.Grupo;
                                bdlmaster.UserDatosExtendidos.Attach(us);
                            }

                            bdlmaster.SaveChanges();
                        }




                        string url;
                        try
                        {
                            UrlHelper uh = new UrlHelper(this.ControllerContext.RequestContext);
                            url = uh.Action("Verificar", "Account", null);      // mandarle un Mail al admin de este usuario
                        }
                        catch (Exception)
                        {
                            // string url = this.Session["DomainUrl"];
                        }
                        url = ConfigurationManager.AppSettings["UrlDominio"] + "Account/Verificar";

                        //url = "http://192.168.66.141/Pronto2/Account/Verificar";
                        Generales.MailAlUsuario(u, url);
                        Generales.MailAlUsuarioAvisoRegistracionPendienteDeHabilitar(u);

                        //avisar al usuario que le va a llegar un mail cuando lo autoricen
                        return View("RegisterEsperarAutorizacion", model);
                    }

                }
                else
                {
                    ModelState.AddModelError("", ErrorCodeToString(createStatus));
                }
            }

            // Si llegamos a este punto, es que se ha producido un error y volvemos a mostrar el formulario
            return View("Register", model);
        }





        // [TestMethod]
        public virtual ActionResult Test_CircuitoDeComprasConFirmas_Asserts()
        {
            //// Arrange
            //var contact = new Contact();
            //_service.Expect(s => s.CreateContact(contact)).Returns(false);
            //var controller = new ContactController(_service.Object);

            //// Act
            //var result = (ViewResult)controller.Create(contact);

            //// Assert
            //Assert.AreEqual("Create", result.ViewName);



            var cPresup = new ProntoMVC.Controllers.CuentaCorrienteController();
            var cAcc = new ProntoMVC.Controllers.AccountController();
            var cUserAdmin = new ProntoMVC.Areas.MvcMembership.Controllers.UserAdministrationController();
            var idPresupuesto = 22;

            // agrega el proveedor y el contacto del presupuesto en el mismo grupo de usuarios externos
            try
            {
                // cPresup.ActivarUsuarioYContacto(idPresupuesto);
            }
            catch (Exception e)
            {

                ErrHandler.WriteError(e); //throw;
            }
            return null;

        }


        // [TestMethod]
        public virtual ActionResult Test_CircuitoDeVentasConFirmas_Asserts()
        {
            //// Arrange
            //var contact = new Contact();
            //_service.Expect(s => s.CreateContact(contact)).Returns(false);
            //var controller = new ContactController(_service.Object);

            //// Act
            //var result = (ViewResult)controller.Create(contact);

            //// Assert
            //Assert.AreEqual("Create", result.ViewName);



            var cPresup = new ProntoMVC.Controllers.CuentaCorrienteController();
            var cAcc = new ProntoMVC.Controllers.AccountController();
            var cUserAdmin = new ProntoMVC.Areas.MvcMembership.Controllers.UserAdministrationController();
            var idPresupuesto = 22;

            // agrega el proveedor y el contacto del presupuesto en el mismo grupo de usuarios externos
            try
            {
                // cPresup.ActivarUsuarioYContacto(idPresupuesto);
            }
            catch (Exception e)
            {

                ErrHandler.WriteError(e); //throw;
            }

            return null;

        }


        // [TestMethod]
        public virtual ActionResult Test_CreateInvalidContact()
        {
            //// Arrange
            //var contact = new Contact();
            //_service.Expect(s => s.CreateContact(contact)).Returns(false);
            //var controller = new ContactController(_service.Object);

            //// Act
            //var result = (ViewResult)controller.Create(contact);

            //// Assert
            //Assert.AreEqual("Create", result.ViewName);



            var cPresup = new ProntoMVC.Controllers.CuentaCorrienteController();
            var cAcc = new ProntoMVC.Controllers.AccountController();
            var cUserAdmin = new ProntoMVC.Areas.MvcMembership.Controllers.UserAdministrationController();
            var idPresupuesto = 22;

            // agrega el proveedor y el contacto del presupuesto en el mismo grupo de usuarios externos
            try
            {
                // cPresup.ActivarUsuarioYContacto(idPresupuesto);
            }
            catch (Exception e)
            {

                ErrHandler.WriteError(e); //throw;
            }



            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            // un tercer usuario (empleado del proveedor) se da de alta. se agrega el solito al grupo, y espera la autorizacion del proveedor
            var usuarioNuevo = new RegisterModel();
            var r = new Random();
            usuarioNuevo.UserName = "usuario" + r.Next(99999).ToString();
            usuarioNuevo.Password = usuarioNuevo.UserName + "!";
            usuarioNuevo.ConfirmPassword = usuarioNuevo.UserName + "!";
            usuarioNuevo.Email = usuarioNuevo.UserName + "mscalella911@hotmail.com";
            usuarioNuevo.Grupo = "30-65663161-6";

            //return RedirectToAction("Register", );
            // return View("Register", usuarioNuevo);
            // ViewResult result = (ViewResult)cAcc.Register(usuarioNuevo);
            // return result;
            return cAcc.Register(usuarioNuevo);
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            var uCreate = new Areas.MvcMembership.Models.UserAdministration.CreateUserViewModel();
            return cUserAdmin.CreateUser();
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
            //////////////////////////////////////////////////////////////////////////////////////////////////////////

            // el admin habilita el tercer usuario
            cAcc.Verificar("44");




            /*
          Un usuario de Esuco (jmontagut) hace un presupuesto para el proveedor mas importante: SarasaHnos
          Esto dispara un alta de usuario para la empresa Sarasa Hnos y para el contacto que se ponga en el presupuesto, en este caso Carlitos Landa
          Carlitos Landa recibe un mail: "Logueate para modificar los datos de este presupuesto!"
             * 
             * Por otra parte, SarasaHnos dice un día: vamos a echar a Carlitos. Y lo echan
             * Así que le dicen al contador Perez: -eh, sacalo a Carlitos del Pronto.
             * Se meten, pues, con el usuario (sarasahnos) y... aparecen un monton de usuarios!
             * Eso está mal... solo deben aparecer los usuarios de sarasahnos... cómo sé cuales son? son los que... ay! en qué tabla guardo esos datos?
             * en la tabla Empleados de Pronto, o en la bdlmaster?
    
    
        
        
      
             * 
             * 
             * Modelo de manejo de usuarios para usuarios visitantes auto gestionados
 
        La idea es que se va a dar de alta un usuario que representa a la empresa (Usuario = CUIT)
        Entre los datos de la empresa se va a tener que solicitar una dirección de mail que es la que va a estar autorizada
        A gestionar futuros usuarios dentro de la misma empresa con diferentes roles (Cada empresa puede tener mas de un usuario)
 
        Para poder hacer esto deben existir diferentes tipos de pantallas de roles
        Roles internos y reoles externos, asi de esta manera nos aseguramos que por ejemplo un usuario que esta dentro de una gama de
        Roles externos JAMAS podría hacer una Orden de pago en un futuro (Tomar esto como ejemplo)
 
        Por el momento los usuarios dentro de los roles externos solamente podrán ver información, de momento no van a estar escribiendo en
        La base de datos
 
        Autogestion:
        Cuando un usuario de una empresa se quiera dar de alta, ingresara al sitio y pondrá el cuit de la empresa y sus datos de alta al momento de registrarse
        El sistema le debe enviar un mail a la casilla de mail en la cual esta registrada la empresa (Mail autorizante) asi de esta manera nos aseguramos que el usuario nuevo pertenece a esa empresa
        En dicho mail se le enviara un link para poder activar la cuenta, una vez activada el usuario nuevo podrá comenzar a hacer consultas sobre el sistema
        En principio las cuentas corrientes de proveedores
 
        El usuario de la empresa (El que tiene el mail autorizante) podrá inactivar usuarios (En el caso que el empleado no pertenezca mas a la empresa)
        Y también le podrá asignar los roles (Los que nosotros definimos como roles externos)
       
             */
        }



        public virtual ActionResult Test_CrearUsuario()
        {

            var cPresup = new ProntoMVC.Controllers.CuentaCorrienteController();
            var cAcc = new ProntoMVC.Controllers.AccountController();
            var cUserAdmin = new ProntoMVC.Areas.MvcMembership.Controllers.UserAdministrationController();

            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            // un tercer usuario (empleado del proveedor) se da de alta. se agrega el solito al grupo, y espera la autorizacion del proveedor
            var usuarioNuevo = new RegisterModel();
            var r = new Random();
            //usuarioNuevo.UserName = "usuario" + r.Next(99999).ToString();
            //usuarioNuevo.Password = usuarioNuevo.UserName + "!";
            //usuarioNuevo.ConfirmPassword = usuarioNuevo.UserName + "!";
            //usuarioNuevo.Email = usuarioNuevo.UserName + "mscalella911@hotmail.com";
            //usuarioNuevo.Grupo = "30-65663161-6";

            usuarioNuevo.UserName = "robertito";
            usuarioNuevo.Password = "robertito!";
            usuarioNuevo.ConfirmPassword = "robertito!";
            usuarioNuevo.Email = "mscalella@yahoo.com.ar";
            usuarioNuevo.Grupo = "30-70789434-9";


            //return RedirectToAction("Register", );
            // return View("Register", usuarioNuevo);
            // ViewResult result = (ViewResult)cAcc.Register(usuarioNuevo);
            // return result;
            return cAcc.Register(usuarioNuevo);
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////


        }



        //
        // GET: /Account/Register

        public virtual ActionResult Verificar(string id)
        {
            string temp = id;
            try
            {

                id = Generales.descifrar(id);
                Membership.GetUser(new Guid(id));
            }
            catch (Exception e)
            {
                id = temp;
                ErrHandler.WriteError(e); //throw;
            }


            var u = Membership.GetUser(new Guid(id));
            u.IsApproved = true;
            //var mailDelAdmin = "mscalella911@gmail.com";
            //var mailDelAdmin = u.Email;

            try
            {




                string nombrebase;

                if (true)
                {
                    //por ahora voy a hacer obligatorio loguearse cuando verifique, porque si no no tengo acceso al UserAdministrationController
                    nombrebase = (string)this.Session["BasePronto"]; //cambiar esto para buscar los datos en la base, no en la session

                    // y cómo sé quién lo habilitó?, si ahora no le pido que se loguee...
                    var c = new Areas.MvcMembership.Controllers.UserAdministrationController();

                    if (false) // no asignar por ahora automaticamente un usuario nuevo a una base
                    {
                        c.AddToEmpresa(new Guid(id), nombrebase);
                        c.CrearUsuarioProntoEnDichaBase(nombrebase, u.UserName);
                    }
                }
                else
                {
                    var c = new Areas.MvcMembership.Controllers.UserAdministrationController();
                    var q = Generales.AdministradoresDeEsteGrupo(c.DatosExtendidosDelUsuario_GrupoUsuarios(new Guid(id)));
                    nombrebase = Generales.BaseDefault((Guid)q[0].ProviderUserKey);
                }




            }
            catch (Exception ex)
            {
                // ErrHandler.WriteError(ex);
                //  throw;
            }


            // Intento de registrar al usuario
            //MembershipCreateStatus createStatus;
            //.CreateUser(model.UserName, model.Password, model.Email, "pregunta", "respuesta", false, null, out createStatus);
            Membership.UpdateUser(u);

            if (true) //(createStatus == MembershipCreateStatus.Success)
            {
                //FormsAuthentication.SetAuthCookie(model.UserName, false /* createPersistentCookie */);
                //return RedirectToAction("Index", "Home");

                //enviarmail

                //////////////////////////////////////////////////////////////////////////////////////
                Generales.MailDeHabilitacionSinContrasena(u);


            }
            else
            {
                // ModelState.AddModelError("", ErrorCodeToString(createStatus));
            }

            TempData["UserName"] = u.UserName;
            TempData["ProviderUserKey"] = u.ProviderUserKey;
            return View();
        }



        //void MailAlUsuario()
        //{
        //    var direccion = "mscalella911@gmail.com";

        //    ProntoFuncionesGenerales.MandaEmailSimple(direccion,
        //                        "sssssss",
        //                   "sdfsdfs sdf sdf sdf sdf ",
        //                    ConfigurationManager.AppSettings["SmtpUser"],
        //                    ConfigurationManager.AppSettings["SmtpServer"],
        //                    ConfigurationManager.AppSettings["SmtpUser"],
        //                    ConfigurationManager.AppSettings["SmtpPass"],
        //                      "",
        //                   Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));
        //}







        //
        // GET: /Account/ChangePassword

        [Authorize]
        public virtual ActionResult ChangePassword()
        {
            return View();
        }

        //
        // POST: /Account/ChangePassword

        [Authorize]
        [HttpPost]
        public virtual ActionResult ChangePassword(ChangePasswordModel model)
        {
            if (ModelState.IsValid)
            {

                // ChangePassword iniciará una excepción en lugar de
                // devolver false en determinados escenarios de error.
                bool changePasswordSucceeded;
                try
                {
                    MembershipUser currentUser = Membership.GetUser(User.Identity.Name, true /* userIsOnline */);
                    changePasswordSucceeded = currentUser.ChangePassword(model.OldPassword, model.NewPassword);
                }
                catch (Exception)
                {
                    changePasswordSucceeded = false;
                }

                if (changePasswordSucceeded)
                {
                    return RedirectToAction("ChangePasswordSuccess");
                }
                else
                {
                    ModelState.AddModelError("", "La contraseña actual es incorrecta o la nueva contraseña no es válida.");
                }
            }

            // Si llegamos a este punto, es que se ha producido un error y volvemos a mostrar el formulario
            return View(model);
        }

        //
        // GET: /Account/ChangePasswordSuccess

        public virtual ActionResult ChangePasswordSuccess()
        {
            return View();
        }





        public virtual ActionResult ElegirBase()
        {

            string sNombreDelEnsamblado = "";
            try
            {
                // http://connect.microsoft.com/VisualStudio/feedback/details/541962/unable-to-load-one-or-more-of-the-requested-types-connected-with-entitydatasource
                //                The original cause is likely external to the EntityDataSource, but the EntityDataSource reveals the problem because it eagerly tries to load all types. You might be able to repro the issue by running code like this in your application:

                //foreach (var asm in AppDomain.CurrentDomain.GetAssemblies())
                //{
                //    asm.GetTypes();
                //}
                foreach (var asm in AppDomain.CurrentDomain.GetAssemblies())
                {
                    sNombreDelEnsamblado = asm.FullName;
                    asm.GetTypes();
                }

            }
            catch (System.Reflection.ReflectionTypeLoadException ex)
            {


                // http://stackoverflow.com/questions/1091853/unable-to-load-one-or-more-of-the-requested-types-retrieve-the-loaderexceptions
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                foreach (Exception exSub in ex.LoaderExceptions)
                {
                    sb.AppendLine(exSub.Message);
                    if (exSub is System.IO.FileNotFoundException)
                    {
                        System.IO.FileNotFoundException exFileNotFound = exSub as System.IO.FileNotFoundException;
                        if (!string.IsNullOrEmpty(exFileNotFound.FusionLog))
                        {
                            sb.AppendLine("Fusion Log:");
                            sb.AppendLine(exFileNotFound.FusionLog);
                        }
                    }
                    sb.AppendLine();
                }
                string errorMessage = sb.ToString();


                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;
                res.Message = sNombreDelEnsamblado + " " + ex.Message + " **** " + errorMessage;
                return Json(res, JsonRequestBehavior.AllowGet);

                throw;
            }

            catch (Exception ex)
            {

                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;
                res.Message = sNombreDelEnsamblado + " " + ex.Message;
                return Json(res, JsonRequestBehavior.AllowGet);

                throw;

            }


            Guid userGuid = (Guid)Membership.GetUser().ProviderUserKey;
            //string us = oStaticMembershipService.GetUser().UserName;
            string us = userGuid.ToString();



            string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster,
                                                    "SELECT * FROM BASES " +
                                                    "join DetalleUserBD on bases.IdBD=DetalleUserBD.IdBD " +
                                                    "where UserId='" + us + "'");


            if (dt.Rows.Count == 1)
            {

                string s = dt.Rows[0]["Descripcion"] as string;
                this.Session["BasePronto"] = s;
                return RedirectToAction("Index", "Home");  // para devolver un action en lugar de un view, cambiar ViewResult
                // a ActionResult (ActionResult tambien se banca una View)

            }



            //DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster, "SELECT * FROM BASES");
            // List<string> baselistado = new List<string>();
            List<SelectListItem> baselistado = new List<SelectListItem>();
            foreach (DataRow r in dt.Rows)
            {
                baselistado.Add(new SelectListItem { Text = r["Descripcion"] as string, Value = "" });
            }


            ViewBag.Bases = baselistado; // baselistado; // new SelectList(dt.Rows, "IdBD", "Descripcion"); // StringConnection

            return View("ElegirBase");
            //return View("ElegirBase", "../Views/Shared/_LayoutVacio.cshtml");
            //return View("ElegirBase", "~/Views/Shared/_LayoutVacio.cshtml");
            //return View("ElegirBase", "_LayoutVacio.cshtml");

        }

        //[HttpPost]
        public virtual ActionResult BaseElegida(string sBase, string returnUrl)
        {
            //probar que conecta


            // tendría que haber un initialize que creara:
            // oStaticMembershipService = new Generales.StaticMembershipService();


            string sc = Generales.sCadenaConex(sBase, oStaticMembershipService);



            if (sc == null)
            {
                return RedirectToAction("ElegirBase");
                return null;
            }
            var db = new ProntoMVC.Data.Models.DemoProntoEntities(sc);

            if (db == null)
            {
                //FormsAuthentication.SignOut();
                //    return RedirectToAction("Index", "Home");
                return RedirectToAction("ElegirBase");
                return null;
            }
            //db = new DemoProntoEntities(sc);


            //probar con poco tiempo de timeout
            try
            {
                ProntoMVC.Data.Models.Factura cc = db.Facturas.FirstOrDefault();
            }
            catch (Exception ex)
            {
                //throw; // probablemente no encastra el modelo....
                //return RedirectToAction("ElegirBase");

                //permitir entrar igual -avisar de alguna manera
                ErrHandler.WriteError(ex);
                this.Session["BasePronto"] = sBase;


                return RedirectToAction("Index", "Home");
                // return PaginaInicialDelUsuario();
                // return RedirectToAction("Index", "MvcMembership/UserAdministration");
            }


            // string returnUrl = Request.QueryString["returnUrl"];
            if (Url.IsLocalUrl(returnUrl)) return Redirect(returnUrl);


            try
            {



                //JsonResponse res3 = new JsonResponse();
                //res3.Status = Status.Error;
                //res3.Message = "ok";
                //return Json(res3, JsonRequestBehavior.AllowGet);




                GrabarUltimaBaseAccedida(oStaticMembershipService.GetUser().UserName, sBase, oStaticMembershipService);

                this.Session["BasePronto"] = sBase;
                return RedirectToAction("Index", "Home");


            }

            catch (System.Reflection.ReflectionTypeLoadException ex)
            {

                // http://connect.microsoft.com/VisualStudio/feedback/details/541962/unable-to-load-one-or-more-of-the-requested-types-connected-with-entitydatasource
                // I was using EntityDataSource and this problem was not there initially, The Problem started after 
                // i used Microsoft Report Viewer in the project. 
                // Then Compiling and Deploying Project into "Release" mode Solved my issue. at this point 
                // i do have all required Microsoft Report Viewer DLLs and DLLs recommended by Sam.P.C in the bin folder.



                // http://stackoverflow.com/questions/1091853/unable-to-load-one-or-more-of-the-requested-types-retrieve-the-loaderexceptions
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                foreach (Exception exSub in ex.LoaderExceptions)
                {
                    sb.AppendLine(exSub.Message);
                    if (exSub is System.IO.FileNotFoundException)
                    {
                        System.IO.FileNotFoundException exFileNotFound = exSub as System.IO.FileNotFoundException;
                        if (!string.IsNullOrEmpty(exFileNotFound.FusionLog))
                        {
                            sb.AppendLine("Fusion Log:");
                            sb.AppendLine(exFileNotFound.FusionLog);
                        }
                    }
                    sb.AppendLine();
                }
                string errorMessage = sb.ToString();

                //Display or log the error based on your application.


                JsonResponse res2 = new JsonResponse();
                res2.Status = Status.Error;
                //res.Errors = GetModelStateErrorsAsString(this.ModelState);
                //res.Errors = errorMessage;
                res2.Message = errorMessage;
                //return Json(res);
                return Json(res2, JsonRequestBehavior.AllowGet);

            }

        }

        #region Status Codes
        private static string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            // Vaya a http://go.microsoft.com/fwlink/?LinkID=177550 para
            // obtener una lista completa de códigos de estado.
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "El nombre de usuario ya existe. Escriba un nombre de usuario diferente.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "Ya existe un nombre de usuario para esa dirección de correo electrónico. Escriba una dirección de correo electrónico diferente.";

                case MembershipCreateStatus.InvalidPassword:
                    return "La contraseña especificada no es válida. Escriba un valor de contraseña válido.";

                case MembershipCreateStatus.InvalidEmail:
                    return "La dirección de correo electrónico especificada no es válida. Compruebe el valor e inténtelo de nuevo.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "La respuesta de recuperación de la contraseña especificada no es válida. Compruebe el valor e inténtelo de nuevo.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "La pregunta de recuperación de la contraseña especificada no es válida. Compruebe el valor e inténtelo de nuevo.";

                case MembershipCreateStatus.InvalidUserName:
                    return "El nombre de usuario especificado no es válido. Compruebe el valor e inténtelo de nuevo.";

                case MembershipCreateStatus.ProviderError:
                    return "El proveedor de autenticación devolvió un error. Compruebe los datos especificados e inténtelo de nuevo. Si el problema continúa, póngase en contacto con el administrador del sistema.";

                case MembershipCreateStatus.UserRejected:
                    return "La solicitud de creación de usuario se ha cancelado. Compruebe los datos especificados e inténtelo de nuevo. Si el problema continúa, póngase en contacto con el administrador del sistema.";

                default:
                    return "Error desconocido. Compruebe los datos especificados e inténtelo de nuevo. Si el problema continúa, póngase en contacto con el administrador del sistema.";
            }
        }
        #endregion





    }
}
