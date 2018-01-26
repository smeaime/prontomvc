using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web.Mvc;
using System.Web.Security;
using MvcMembership;
using MvcMembership.Settings;
using ProntoMVC.Areas.MvcMembership.Models.UserAdministration;

using System.Data;
using System.Configuration;
using Pronto.ERP.Bll;
using System.Data.SqlClient;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;

namespace ProntoMVC.Areas.MvcMembership.Controllers
{
    //[AuthorizeUnlessOnlyUser(Roles = "Administrator")] // allows access if you're the only user, only validates role if role provider is enabled
    [AuthorizeUnlessOnlyUser(Roles = "Administrador,SuperAdmin,AdminExterno")]

    public partial class UserAdministrationController : ProntoMVC.Controllers.ProntoBaseController // No le pongo ProntoBaseController para no obligarlo a tener base asignada
    {
        private const int PageSize = 20000;
        private const string ResetPasswordBody = "Your new password is: ";
        private const string ResetPasswordSubject = "Your New Password";
        private readonly IRolesService _rolesService;
        private readonly ISmtpClient _smtpClient;
        private readonly IMembershipSettings _membershipSettings;
        private readonly IUserService _userService;
        private readonly IPasswordService _passwordService;

        public UserAdministrationController()
            : this(new AspNetMembershipProviderWrapper(), new AspNetRoleProviderWrapper(), new SmtpClientProxy())
        {

            try
            {
                if (oStaticMembershipService != null) ViewBag.NombreUsuario = oStaticMembershipService.GetUser().UserName;
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e);
            }



        }


        protected override void Initialize(System.Web.Routing.RequestContext rc)
        {

            base.Initialize(rc);

            try
            {
                ViewBag.NombreUsuario = oStaticMembershipService.GetUser().UserName;
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e);
            }
        }





        public UserAdministrationController(AspNetMembershipProviderWrapper membership, IRolesService roles, ISmtpClient smtp)
            : this(membership.Settings, membership, membership, roles, smtp)
        {
        }

        public UserAdministrationController(
            IMembershipSettings membershipSettings,
            IUserService userService,
            IPasswordService passwordService,
            IRolesService rolesService,
            ISmtpClient smtpClient)
        {
            _membershipSettings = membershipSettings;
            _userService = userService;
            _passwordService = passwordService;
            _rolesService = rolesService;
            _smtpClient = smtpClient;
        }





        void VerificarExistenciaDeRoles()
        {
            var s = Roles.GetAllRoles();
            if (!s.Contains("Requerimientos")) Roles.CreateRole("Requerimientos");
            if (!s.Contains("SuperAdmin")) Roles.CreateRole("SuperAdmin");
            if (!s.Contains("Administrador")) Roles.CreateRole("Administrador");
            if (!s.Contains("Comercial")) Roles.CreateRole("Comercial");
            if (!s.Contains("FacturaElectronica")) Roles.CreateRole("FacturaElectronica");
            if (!s.Contains("Firmas")) Roles.CreateRole("Firmas");
            if (!s.Contains("Externo")) Roles.CreateRole("Externo");

            c("Compras");

            c("ExternoOrdenesPagoListas");
            c("ExternoCuentaCorrienteProveedor");
            c("ExternoPresupuestos");



        }

        void c(string sRol)
        {
            var s = Roles.GetAllRoles();
            if (!s.Contains(sRol)) Roles.CreateRole(sRol);
        }


        public virtual ActionResult Index(int? page, string search, string mensaje = "")
        {
            if (!VerificarClaveDeRoles()) throw new Exception("Tabla de roles corrupta");

            VerificarExistenciaDeRoles();




            string usuario = ViewBag.NombreUsuario;
            Guid guiduser;
            try
            {
                //Guid guiduser = (Guid)Membership.GetUser(usuario).ProviderUserKey; // si no lo encontró en la base pronto, el usuario está en null
                guiduser = (Guid)oStaticMembershipService.GetUser().ProviderUserKey;
            }
            catch (Exception ex)
            {
                ErrHandler.WriteError(ex);
                return View(new IndexViewModel());
                throw;
            }



            // PagedList.IPagedList<MembershipUser> users;
            List<MembershipUser> users;


            var aa = (string.IsNullOrWhiteSpace(search)
               ? _userService.FindAll(page ?? 1, PageSize)
               : search.Contains("@")
                   ? _userService.FindByEmail(search, page ?? 1, PageSize)
                   : _userService.FindByUserName(search, page ?? 1, PageSize)); //.Where(x => EsUsuarioControlablePorAdmin(x.UserName, usuario));

            users = aa.ToList();




            if (!string.IsNullOrWhiteSpace(search) && users.Count == 1)
                return RedirectToAction("Details", new { id = users[0].ProviderUserKey.ToString() });





            RecargarViewbag();







            IndexViewModel m = new IndexViewModel
            {
                Search = search,
                Users = users,
                UsuariosPronto = null,
                Roles = _rolesService.Enabled
                                    ? _rolesService.FindAll()
                                    : Enumerable.Empty<string>(),
                IsRolesEnabled = _rolesService.Enabled
            };


            //  foreach  ( MembershipUser i in m.Users)
            //{
            //    IndexViewModel.UsuarioPronto

            //}



            m.UsuariosPronto = UsuariosProntoColeccion(); // BasesPorUsuarioColeccion(i.ProviderUserKey);

            /////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////
            List<Guid> l = new List<Guid>();
            if (Roles.IsUserInRole(ViewBag.NombreUsuario, "AdminExterno"))
            {



                foreach (MembershipUser u in users)
                {
                    if (DatosExtendidosDelUsuario_GrupoUsuarios((Guid)u.ProviderUserKey) == DatosExtendidosDelUsuario_GrupoUsuarios(guiduser)
                             || (DatosExtendidosDelUsuario_GrupoUsuarios(guiduser) ?? "") == "")
                    {

                        if ((DatosExtendidosDelUsuario_GrupoUsuarios(guiduser) ?? "") == "")
                        {
                            if (!(
                                 Roles.IsUserInRole(u.UserName, "AdminExterno") ||
                                 Roles.IsUserInRole(u.UserName, "ExternoOrdenesPagoListas") ||
                                 Roles.IsUserInRole(u.UserName, "ExternoCuentaCorrienteProveedor") ||
                                 Roles.IsUserInRole(u.UserName, "ExternoPresupuestos") ||
                                 Roles.IsUserInRole(u.UserName, "Externo")
                                ))

                                continue; // para que el adminexterno general (que no tiene cuit/grupo) no vea a usuarios supervisores 
                        }


                        l.Add((Guid)u.ProviderUserKey);
                    }
                }



                users = aa.Where(x => l.Contains((Guid)x.ProviderUserKey)).ToList();


                //   users = (string.IsNullOrWhiteSpace(search)
                //? _userService.FindAll(page ?? 1, PageSize)
                //: search.Contains("@")
                //    ? _userService.FindByEmail(search, page ?? 1, PageSize)
                //    : _userService.FindByUserName(search, page ?? 1, PageSize));

                m.UsuariosPronto = UsuariosProntoColeccion().Where(x => l.Contains((Guid)x.user.ProviderUserKey)).ToList();

                return View("IndexAdminExterno", m);
            }


            /////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////


            string sc = Generales.FormatearConexParaEntityFrameworkBDLMASTER();
            ProntoMVC.Data.Models.BDLMasterEntities dbMaster = new ProntoMVC.Data.Models.BDLMasterEntities(sc);
            m.BasesPronto = (from i in dbMaster.Bases select i).ToList();





            /////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////

            //ViewBag.Alerta = TempData["message"];
            ViewBag.Alerta = mensaje;
            ViewBag.Otro = mensaje;
            TempData["message"] = mensaje;


            return View(m);
        }





        public virtual ActionResult IndexAdminExterno(int? page, string search, string mensaje = "")
        {
            if (!VerificarClaveDeRoles()) throw new Exception("Tabla de roles corrupta");

            VerificarExistenciaDeRoles();




            string usuario = ViewBag.NombreUsuario;
            Guid guiduser;
            try
            {
                //Guid guiduser = (Guid)Membership.GetUser(usuario).ProviderUserKey; // si no lo encontró en la base pronto, el usuario está en null
                guiduser = (Guid)oStaticMembershipService.GetUser().ProviderUserKey;
            }
            catch (Exception ex)
            {
                ErrHandler.WriteError(ex);
                return View(new IndexViewModel());
                throw;
            }



            // PagedList.IPagedList<MembershipUser> users;
            List<MembershipUser> users;


            var aa = (string.IsNullOrWhiteSpace(search)
               ? _userService.FindAll(page ?? 1, PageSize)
               : search.Contains("@")
                   ? _userService.FindByEmail(search, page ?? 1, PageSize)
                   : _userService.FindByUserName(search, page ?? 1, PageSize)); //.Where(x => EsUsuarioControlablePorAdmin(x.UserName, usuario));

            users = aa.ToList();




            if (!string.IsNullOrWhiteSpace(search) && users.Count == 1)
                return RedirectToAction("Details", new { id = users[0].ProviderUserKey.ToString() });





            RecargarViewbag();







            IndexViewModel m = new IndexViewModel
            {
                Search = search,
                Users = users,
                UsuariosPronto = null,
                Roles = _rolesService.Enabled
                    ? _rolesService.FindAll()
                    : Enumerable.Empty<string>(),
                IsRolesEnabled = _rolesService.Enabled
            };


            //  foreach  ( MembershipUser i in m.Users)
            //{
            //    IndexViewModel.UsuarioPronto

            //}



            m.UsuariosPronto = UsuariosProntoColeccion(); // BasesPorUsuarioColeccion(i.ProviderUserKey);

            /////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////
            List<Guid> l = new List<Guid>();



            string[] rolesexternos = new string[] {"ExternoCuentaCorrienteCliente",
                                                    "ExternoCuentaCorrienteProveedor",
                                                    "ExternoOrdenesPagoListas",
                                                    "ExternoPresupuestos", "AdminExterno", "Externo"};



            bool guiduserEsSuperadmin = Roles.IsUserInRole(oStaticMembershipService.GetUser().UserName, "SuperAdmin");


            foreach (MembershipUser u in users)
            {

                if (DatosExtendidosDelUsuario_GrupoUsuarios((Guid)u.ProviderUserKey) == DatosExtendidosDelUsuario_GrupoUsuarios(guiduser)
                         || (DatosExtendidosDelUsuario_GrupoUsuarios(guiduser) ?? "") == "" || guiduserEsSuperadmin)
                {


                    if ((DatosExtendidosDelUsuario_GrupoUsuarios(guiduser) ?? "") == "" && !guiduserEsSuperadmin)
                    {
                        if (!(
                             Roles.IsUserInRole(u.UserName, "AdminExterno") ||
                             Roles.IsUserInRole(u.UserName, "ExternoOrdenesPagoListas") ||
                             Roles.IsUserInRole(u.UserName, "ExternoCuentaCorrienteProveedor") ||
                             Roles.IsUserInRole(u.UserName, "ExternoPresupuestos") ||
                             Roles.IsUserInRole(u.UserName, "Externo")
                            ))

                            continue; // para que el adminexterno general (que no tiene cuit/grupo) no vea a usuarios supervisores 
                    }



                    l.Add((Guid)u.ProviderUserKey);
                }
            }



            users = aa.Where(x => l.Contains((Guid)x.ProviderUserKey)).ToList();


            //   users = (string.IsNullOrWhiteSpace(search)
            //? _userService.FindAll(page ?? 1, PageSize)
            //: search.Contains("@")
            //    ? _userService.FindByEmail(search, page ?? 1, PageSize)
            //    : _userService.FindByUserName(search, page ?? 1, PageSize));

            m.UsuariosPronto = UsuariosProntoColeccion().Where(x => l.Contains((Guid)x.user.ProviderUserKey)).ToList();

            return View("IndexAdminExterno", m);


        }


        //        [AcceptVerbs(HttpVerbs.Post)]
        public void CambiarBDLmaster(string sc)
        {


            // sCadenaConexSQLbdlmaster()


            // http://stackoverflow.com/questions/4216809/configurationmanager-doesnt-save-settings
            //Create the object
            //Configuration config = WebConfigurationManager.OpenWebConfiguration("~");  //ConfigurationManager.OpenWebConfiguration(ConfigurationUserLevel.None);

            Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~"); //http://stackoverflow.com/a/1312739/1054200
            ConnectionStringsSection section = config.GetSection("connectionStrings") as ConnectionStringsSection;
            if (section != null)
            {
                section.ConnectionStrings["ApplicationServices"].ConnectionString = sc;
                config.Save();
            }


            //make changes

            // config.ConnectionStrings["ApplicationServices"].ConnectionString = sc;

            //save to apply changes
            //config.Save(ConfigurationSaveMode.Modified);
            //ConfigurationManager.RefreshSection("connectionStrings");
        }


        void RecargarViewbag(Guid id = new Guid())
        {

            string usuario = ViewBag.NombreUsuario;
            //Guid guiduser = (Guid)oStaticMembershipService.GetUser().ProviderUserKey; // si no lo encontró en la base pronto, el usuario está en null
            Guid guiduser = (Guid)oStaticMembershipService.GetUser().ProviderUserKey;

            IDictionary<string, bool> s = BasesPorUsuarioColeccion2(guiduser, guiduser);

            //List<SelectListItem> baselistado = new List<SelectListItem>();
            var baselistado = from i in s select new SelectListItem { Text = i.Key.ToString(), Value = i.Key.ToString() };


            ViewBag.Bases = baselistado;


            if (id == Guid.Empty) id = guiduser;
            MembershipUser u = Membership.GetUser(id);
            var c = new ProntoMVC.Controllers.AccountController();
            string nombrebase = (Session["BasePronto"].NullSafeToString() == "") ? c.BuscarUltimaBaseAccedida(oStaticMembershipService) : Session["BasePronto"].NullSafeToString();
            ViewBag.EmpresaDefault = new SelectList(baselistado.ToList(), "Value", "Text", nombrebase);

            try
            {
                if (nombrebase.NullSafeToString() != "")
                {
                    //si no hay con qué llenar .Empleados, llora la vista
                    using (var tempdb = new DemoProntoEntities(Generales.sCadenaConex(nombrebase, oStaticMembershipService)))
                    {
                        // no mostrar los que ya estan en la bdlmaster
                        ViewBag.Empleados = new SelectList(tempdb.Empleados.ToList(), "IdEmpleado", "UsuarioNT");
                    };
                }
            }
            catch (Exception ex)
            {

                //ViewBag.Empleados = new SelectList(db.Empleados.ToList(), "IdEmpleado", "UsuarioNT" );
                ErrHandler.WriteError(ex);
                // throw;
            }





            // Generales.sCadenaConexSQLbdlmaster();
            var l = new List<string> { "Data Source=192.168.66.6;Initial Catalog=BDLMaster;Uid=sa; PWD=3D1consultore5;",
                                       "Data Source=Mariano-PC;Initial Catalog=BDLMaster;Uid=sa; PWD=3D1consultore5;" };
            l.Add(Generales.sCadenaConexSQLbdlmaster());
            ViewBag.BDLMaster = new SelectList(l, Generales.sCadenaConexSQLbdlmaster());
        }


        [AcceptVerbs(HttpVerbs.Post)]
        public virtual RedirectToRouteResult CreateRole(string id)
        {
            if (_rolesService.Enabled)
                _rolesService.Create(id);
            return RedirectToAction("Index");
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public virtual RedirectToRouteResult DeleteRole(string id)
        {
            _rolesService.Delete(id);
            return RedirectToAction("Index");
        }

        public virtual ViewResult Role(string id)
        {
            return View(new RoleViewModel
            {
                Role = id,
                Users = _rolesService.FindUserNamesByRole(id)
                                                     .ToDictionary(
                                                        k => k,
                                                        v => _userService.Get(v)
                                                     )
            });

        }


        public virtual ViewResult DetailsExterno(Guid id)
        {
            return Details(id);
        }

        public virtual ViewResult Details(Guid id)
        {

            var user = _userService.Get(id);
            if (user == null)
            {

                throw new Exception("No se encontró el usuario en la BDLmaster");
            }



            var userRoles = _rolesService.Enabled
                ? _rolesService.FindByUser(user)
                : Enumerable.Empty<string>();


            //List<string> emp = new List<string>();
            IDictionary<string, bool> emp = new Dictionary<string, bool>()
                                            {
                                                {  "Williams" ,true},
                                                {  "Autotrol",false },
                                            };



            string grupo = "";
            using (BDLMasterEntities bdlmaster = new BDLMasterEntities(Generales.FormatearConexParaEntityFrameworkBDLMASTER()))
            {
                UserDatosExtendidos u = bdlmaster.UserDatosExtendidos.Where(x => x.UserId == id).FirstOrDefault();
                if (u != null) grupo = u.RazonSocial;
            }

            RecargarViewbag(id);
            ViewBag.UsuarioEquivalente = UsuarioEquivalente(id);




            string nombreproveedor = "";
            try
            {
                int idproveedor = buscaridproveedorporcuit(grupo);
                if (idproveedor <= 0)
                {
                    idproveedor = buscaridclienteporcuit(grupo);
                    if (idproveedor > 0) nombreproveedor = db.Clientes.Find(idproveedor).RazonSocial;
                }
                else
                {

                    nombreproveedor = db.Proveedores.Find(idproveedor).RazonSocial;
                }
            }
            catch (Exception x)
            {

                ProntoFuncionesGenerales.MandaEmailSimple(ConfigurationManager.AppSettings["ErrorMail"],
                                "Error de proveedor",
                                x.ToString(),
                                ConfigurationManager.AppSettings["SmtpUser"],
                                ConfigurationManager.AppSettings["SmtpServer"],
                                ConfigurationManager.AppSettings["SmtpUser"],
                                ConfigurationManager.AppSettings["SmtpPass"],
                                "",
                               Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));

                //throw;
            }
            if (grupo != "")
            {
                if (nombreproveedor == "") TempData["Alerta"] = "El CUIT no existe!";
                else TempData["Alerta"] = "CUIT de " + nombreproveedor;
            }



            return View(new DetailsViewModel
            {
                CanResetPassword = _membershipSettings.Password.ResetOrRetrieval.CanReset,
                RequirePasswordQuestionAnswerToResetPassword = _membershipSettings.Password.ResetOrRetrieval.RequiresQuestionAndAnswer,
                DisplayName = user.UserName,
                Grupo = grupo,
                User = user,
                Roles = _rolesService.Enabled
                                    ? _rolesService.FindAll().ToDictionary(role => role, role => userRoles.Contains(role))
                                    : new Dictionary<string, bool>(0),
                Empresas = emp,
                IsRolesEnabled = _rolesService.Enabled,
                Status = user.IsOnline
                                            ? DetailsViewModel.StatusEnum.Online
                                            : !user.IsApproved
                                                ? DetailsViewModel.StatusEnum.Unapproved
                                                : user.IsLockedOut
                                                    ? DetailsViewModel.StatusEnum.LockedOut
                                                    : DetailsViewModel.StatusEnum.Offline
            });



        }







        public virtual ViewResult Password(Guid id)
        {


            var user = _userService.Get(id);
            var userRoles = _rolesService.Enabled
                ? _rolesService.FindByUser(user)
                : Enumerable.Empty<string>();
            return View(new DetailsViewModel
            {
                CanResetPassword = _membershipSettings.Password.ResetOrRetrieval.CanReset,
                RequirePasswordQuestionAnswerToResetPassword = _membershipSettings.Password.ResetOrRetrieval.RequiresQuestionAndAnswer,
                DisplayName = user.UserName,
                User = user,
                Roles = _rolesService.Enabled
                    ? _rolesService.FindAll().ToDictionary(role => role, role => userRoles.Contains(role))
                    : new Dictionary<string, bool>(0),
                IsRolesEnabled = _rolesService.Enabled,
                Status = user.IsOnline
                            ? DetailsViewModel.StatusEnum.Online
                            : !user.IsApproved
                                ? DetailsViewModel.StatusEnum.Unapproved
                                : user.IsLockedOut
                                    ? DetailsViewModel.StatusEnum.LockedOut
                                    : DetailsViewModel.StatusEnum.Offline
            });
        }


        //[AcceptVerbs(HttpVerbs.Post)]
        //public RedirectToRouteResult CambiarContraseña(DetailsViewModel m)
        //{

        //}

        //public RedirectToRouteResult CambiarContraseña(Guid id, string pass)
        //{

        //    return RedirectToAction("Index");
        //}




        public virtual ViewResult UsersRoles(Guid id)
        {
            var user = _userService.Get(id);
            var userRoles = _rolesService.FindByUser(user);
            return View(new DetailsViewModel
            {
                CanResetPassword = _membershipSettings.Password.ResetOrRetrieval.CanReset,
                RequirePasswordQuestionAnswerToResetPassword = _membershipSettings.Password.ResetOrRetrieval.RequiresQuestionAndAnswer,
                DisplayName = user.UserName,
                User = user,
                Roles = _rolesService.FindAll().ToDictionary(role => role, role => userRoles.Contains(role)),
                IsRolesEnabled = true,
                Status = user.IsOnline
                            ? DetailsViewModel.StatusEnum.Online
                            : !user.IsApproved
                                ? DetailsViewModel.StatusEnum.Unapproved
                                : user.IsLockedOut
                                    ? DetailsViewModel.StatusEnum.LockedOut
                                    : DetailsViewModel.StatusEnum.Offline
            });
        }






        public virtual ViewResult CreateUser()
        {
            var model = new CreateUserViewModel
            {
                InitialRoles = _rolesService.FindAll().ToDictionary(k => k, v => false)
            };



            string usuario = ViewBag.NombreUsuario;
            Guid guiduser = (Guid)Membership.GetUser(usuario).ProviderUserKey;

            RecargarViewbag();


            return View(model);
        }


        public virtual ViewResult CreateUserExterno()
        {
            string[] rolesexternos = new string[] {"ExternoCuentaCorrienteCliente",
                                                    "ExternoCuentaCorrienteProveedor",
                                                    "ExternoOrdenesPagoListas",
                                                    "ExternoPresupuestos", "AdminExterno", "Externo"};


            var model = new CreateUserViewModel
            {
                // InitialRoles = _rolesService.FindAll().ToDictionary(k => k, v => false)
                InitialRoles = Roles.GetAllRoles().Where(x => rolesexternos.Contains(x)).ToDictionary(k => k, v => false)
            };



            string usuario = ViewBag.NombreUsuario;
            Guid guiduser = (Guid)Membership.GetUser(usuario).ProviderUserKey;

            RecargarViewbag();


            return View(model);
        }



        public virtual JsonResult EmpleadosPorBase(string sBase)
        {
            List<string> usuarioswebdelabase;

            using (var dbMaster = new BDLMasterEntities(Generales.FormatearConexParaEntityFrameworkBDLMASTER()))
            {

                usuarioswebdelabase = (from u in dbMaster.DetalleUserBD
                                       join b in dbMaster.Bases on u.IdBD equals b.IdBD
                                       join x in dbMaster.aspnet_Users on u.UserId equals x.UserId
                                       // where (b.Descripcion == sBase)
                                       select x.UserName).Distinct().ToList();
            }

            using (var tempdb = new DemoProntoEntities(Generales.sCadenaConex(sBase)))
            {

                //var empleados = (from x in tempdb.Empleados
                //                     .OrderBy(x => x.Nombre)
                //                 select new { x.IdEmpleado, Nombre = x.Nombre + "\t\t" + x.UsuarioNT + "\t\t" + usuarioswebdelabase.Contains(x.UsuarioNT).ToString() }).ToList();

                var empleados = (from x in tempdb.Empleados
                                 where (!usuarioswebdelabase.Contains(x.UsuarioNT) && x.UsuarioNT.Trim() != "")
                                 orderby (x.UsuarioNT)
                                 select new { x.IdEmpleado, Nombre = x.UsuarioNT }
                                ).ToList();

                // filtrar los que ya tienen usuario web

                return Json(empleados, JsonRequestBehavior.AllowGet);
            }
        }




        [AcceptVerbs(HttpVerbs.Post)]
        public virtual ActionResult CreateUserExterno(CreateUserViewModel createUserViewModel)
        {

            return CreateUser(createUserViewModel);
        }


        [AcceptVerbs(HttpVerbs.Post)]
        public virtual ActionResult CreateUser(CreateUserViewModel createUserViewModel)
        {
            if (!ModelState.IsValid)
            {

                //JsonResponse res = new JsonResponse();
                //res.Status = Status.Error;
                //res.Errors = GetModelStateErrorsAsString(this.ModelState);
                //res.Message = "La factura es inválida";
                ////                return Json(res);
                RecargarViewbag();

                //ModelState.AddModelError("Email", "La factura es inválida"); 


                return View(createUserViewModel);
            }

            try
            {
                if (createUserViewModel.Password != createUserViewModel.ConfirmPassword)
                    throw new MembershipCreateUserException("Passwords do not match.");

                var user = _userService.Create(
                    createUserViewModel.Username,
                    createUserViewModel.Password,
                    createUserViewModel.Email,
                    createUserViewModel.PasswordQuestion,
                    createUserViewModel.PasswordAnswer,
                    true);




                Generales.MailAlUsuarioConLaPasswordYElDominio(createUserViewModel.Username, createUserViewModel.Password, createUserViewModel.Email);




                if (createUserViewModel.InitialRoles != null)
                {
                    var rolesToAddUserTo = createUserViewModel.InitialRoles.Where(x => x.Value).Select(x => x.Key);
                    foreach (var role in rolesToAddUserTo)
                        _rolesService.AddToRole(user, role);
                }
                else
                {
                    // Roles.AddUserToRole(user.UserName, "Externo");
                }


                if ((createUserViewModel.EmpresaNueva ?? "") != "") // (baseEsNueva)
                {
                    try
                    {
                        // que el empleado tenga el administrador=NO
                        CrearBaseyAsignarEmpleado(user.ProviderUserKey.ToString(), createUserViewModel.EmpresaDefault, createUserViewModel.EmpresaNueva, createUserViewModel.Username);

                    }
                    catch (Exception e)
                    {

                        ErrHandler.WriteError(e);
                    }

                    AddToEmpresa((Guid)user.ProviderUserKey, createUserViewModel.EmpresaNueva);
                }

                else
                {
                    try
                    {

                        // si el admin que modifica es externo, lo pongo en su grupo. Si no, le creo un grupo 
                        string grupo = oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "AdminExterno") ?
                                        DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey) :
                                        user.UserName;

                        using (BDLMasterEntities bdlmaster = new BDLMasterEntities(Generales.FormatearConexParaEntityFrameworkBDLMASTER()))
                        {
                            UserDatosExtendidos u = bdlmaster.UserDatosExtendidos.Where(x => x.UserId == (Guid)user.ProviderUserKey).FirstOrDefault();
                            if (u == null)
                            {
                                u = new UserDatosExtendidos();
                                u.UserId = (Guid)user.ProviderUserKey;

                                u.RazonSocial = grupo;
                                bdlmaster.UserDatosExtendidos.Add(u);
                            }
                            else
                            {
                                u.RazonSocial = grupo;
                                bdlmaster.UserDatosExtendidos.Attach(u);
                            }

                            bdlmaster.SaveChanges();
                        }

                        AddToEmpresa((Guid)user.ProviderUserKey, createUserViewModel.EmpresaDefault);

                        CrearUsuarioProntoEnDichaBase(createUserViewModel.EmpresaDefault, user.UserName); // user.ProviderUserKey.ToString());



                    }
                    catch (Exception)
                    {

                        //                    throw;
                    }

                }

                return RedirectToAction("Details", new { id = user.ProviderUserKey });
            }
            catch (MembershipCreateUserException e)
            {

                RecargarViewbag();

                //string usuario = ViewBag.NombreUsuario;
                //Guid guiduser = (Guid)Membership.GetUser(usuario).ProviderUserKey;
                //ViewBag.Bases = BasesPorUsuarioColeccion(guiduser);


                ModelState.AddModelError(string.Empty, e.Message);
                return View(createUserViewModel);
            }

            catch (Exception e)
            {

                RecargarViewbag();

                //string usuario = ViewBag.NombreUsuario;
                //Guid guiduser = (Guid)Membership.GetUser(usuario).ProviderUserKey;
                //ViewBag.Bases = BasesPorUsuarioColeccion(guiduser);


                ModelState.AddModelError(string.Empty, e.Message);
                return View(createUserViewModel);
            }



        }





        //[HttpPost]
        //        [AcceptVerbs(HttpVerbs.Post)]
        [HttpPost]
        public virtual JsonResult CrearBasePronto(Guid guid, string basenueva, string EmpresaDefault)
        {

            if (basenueva == "")
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;

                JsonResponse res = new JsonResponse();
                res.Status = Status.Error;
                //res.Errors = "sdfsdf"; // GetModelStateErrorsAsString(this.ModelState);
                res.Message = "Falta el nombre de la base";
                return Json(res);
            }


            var u = Membership.GetUser(guid);
            // para qué me pide el nombre de usuario?


            if (!ModelState.IsValid)
            {

                RecargarViewbag();
                return Json("");
            }





            CrearBaseyAsignarEmpleado(guid.ToString(), EmpresaDefault, basenueva, u.UserName);
            AddToEmpresa(guid, basenueva);

            //    return RedirectToAction("Details", new { id = user.ProviderUserKey });
            return Json("");



        }



        private List<string> GetModelStateErrorsAsString(ModelStateDictionary state)
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

        public string GetErrorMessage(MembershipCreateStatus status)
        {
            switch (status)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "Username already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    //return "A username for that e-mail address already exists. Please enter a different e-mail address.";
                    return "El mail ya está siendo usado";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The e-mail address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "La respuesta secreta es incorrecta.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }


        [AcceptVerbs(HttpVerbs.Post)]
        public virtual RedirectToRouteResult Details(Guid id, string email, string comments, string grupo, string EmpresaDefault)
        {
            var user = _userService.Get(id);
            user.Email = email;
            user.Comment = comments;





            // if (id == Guid.Empty) id = guiduser;
            //MembershipUser u = Membership.GetUser(id);
            var c = new ProntoMVC.Controllers.AccountController();
            c.GrabarUltimaBaseAccedida(user.UserName, EmpresaDefault, oStaticMembershipService);
            //ViewBag.EmpresaDefault = new SelectList(baselistado.ToList(), "Value", "Text", nombrebase);





            try
            {
                _userService.Update(user);
            }

            catch (MembershipCreateUserException e)
            {

                TempData["Alerta"] = GetErrorMessage(e.StatusCode);
                return RedirectToAction("Password", new { id });

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e);
                TempData["Alerta"] = e.Message;
                if (e.Message == "The E-mail supplied is invalid.") TempData["Alerta"] = "El Email es invalido o ya está siendo usado";
                return RedirectToAction("Details", new { id });
                //return View();
                //throw;
            }



            using (BDLMasterEntities bdlmaster = new BDLMasterEntities(Generales.FormatearConexParaEntityFrameworkBDLMASTER()))
            {
                UserDatosExtendidos u = bdlmaster.UserDatosExtendidos.Where(x => x.UserId == id).FirstOrDefault();
                if (u == null)
                {
                    u = new UserDatosExtendidos();
                    u.UserId = id;

                    u.RazonSocial = grupo;
                    bdlmaster.UserDatosExtendidos.Add(u);
                }
                else
                {
                    u.RazonSocial = grupo;
                    bdlmaster.UserDatosExtendidos.Attach(u);

                    //todo
                    bdlmaster.Entry(u).State = System.Data.Entity.EntityState.Modified;

                }

                bdlmaster.SaveChanges();
            }



            //UrlHelper uh = new UrlHelper(this.ControllerContext.RequestContext);
            //string url = uh.Action("Verificar", "Account", null);
            //Generales.MailAlUsuario(user, url);


            return RedirectToAction("Details", new { id });
        }







        //[AcceptVerbs(HttpVerbs.Post)]
        public virtual RedirectToRouteResult DeleteUser(Guid id)
        {

            try
            {

                Membership.DeleteUser(Membership.GetUser(id).UserName);
            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e);
                //throw;
            }


            try
            {

                var user = _userService.Get(id);

                if (_rolesService.Enabled)
                    _rolesService.RemoveFromAllRoles(user);
                _userService.Delete(user);

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e);
                //throw;
            }

            ViewBag.Alerta = "Usuario borrado";
            TempData["Alerta"] = "Usuario borrado";
            return RedirectToAction("Index");
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public virtual RedirectToRouteResult ChangeApproval(Guid id, bool isApproved)
        {
            var user = _userService.Get(id);
            user.IsApproved = isApproved;
            _userService.Update(user);
            return RedirectToAction("Details", new { id });
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public virtual RedirectToRouteResult Unlock(Guid id)
        {
            _passwordService.Unlock(_userService.Get(id));
            return RedirectToAction("Details", new { id });
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public virtual RedirectToRouteResult ResetPassword(Guid id)
        {
            var user = _userService.Get(id);
            var newPassword = _passwordService.ResetPassword(user);

            var body = ResetPasswordBody + newPassword;
            var msg = new MailMessage();
            msg.To.Add(user.Email);
            msg.Subject = ResetPasswordSubject;
            msg.Body = body;
            _smtpClient.Send(msg);

            return RedirectToAction("Password", new { id });
        }


        string GenerarPass()
        {
            //http://stackoverflow.com/questions/54991/generating-random-passwords?rq=1
            //http://stackoverflow.com/questions/2625150/membership-generate-password-alphanumeric-only-password

            string newPassword = Membership.GeneratePassword(50, 0);
            newPassword = System.Text.RegularExpressions.Regex.Replace(newPassword, @"[^a-zA-Z0-9]", m => "");
            newPassword = newPassword.Substring(0, 7);
            newPassword = newPassword.ToUpper() + "!";
            return newPassword;
        }




        public string ResetearPass(Guid id, string answer)
        {
            var user = _userService.Get(id);
            string newPassword;

            try
            {
                // newPassword = _passwordService.ResetPassword(user, answer);
                var u = Membership.GetUser(id);
                string temppass = u.ResetPassword(answer);
                newPassword = GenerarPass();
                u.ChangePassword(temppass, newPassword);


            }
            catch (MembershipCreateUserException e)
            {

                TempData["Alerta"] = GetErrorMessage(e.StatusCode);
                return GetErrorMessage(e.StatusCode);

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e);
                TempData["Alerta"] = e.Message;
                if (e.Message == "The parameter 'passwordAnswer' must not be empty.\r\nParameter name: passwordAnswer") TempData["Alerta"] = "La respuesta secreta es incorrecta";

                return TempData["Alerta"].ToString();
                //return View();
                //throw;
            }




            var body = ResetPasswordBody + newPassword;
            try
            {

                var msg = new MailMessage();
                msg.To.Add(user.Email);
                msg.Subject = ResetPasswordSubject;
                msg.Body = body;
                _smtpClient.Send(msg);
            }
            catch (Exception e)
            {

                ErrHandler.WriteError(e);

            }

            try
            {


                string usuario = ViewBag.NombreUsuario;

                ProntoFuncionesGenerales.MandaEmailSimple(
                            user.Email + (oStaticMembershipService.GetUser() == null ? "" : "," + oStaticMembershipService.GetUser().Email) + "," + ConfigurationManager.AppSettings["ErrorMail"],
                                          ResetPasswordSubject,
                                     body,
                                      ConfigurationManager.AppSettings["SmtpUser"],
                                      ConfigurationManager.AppSettings["SmtpServer"],
                                      ConfigurationManager.AppSettings["SmtpUser"],
                                      ConfigurationManager.AppSettings["SmtpPass"],
                                        "",
                                     Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));

            }
            catch (Exception)
            {

                ProntoFuncionesGenerales.MandaEmailSimple(ConfigurationManager.AppSettings["ErrorMail"],
                            "Error de mail en ResetPasswordWithAnswer",
                            user.Email + (oStaticMembershipService.GetUser() == null ? "" : "," + oStaticMembershipService.GetUser().Email) + "," + ConfigurationManager.AppSettings["ErrorMail"],
                                ConfigurationManager.AppSettings["SmtpUser"],
                                ConfigurationManager.AppSettings["SmtpServer"],
                                ConfigurationManager.AppSettings["SmtpUser"],
                                ConfigurationManager.AppSettings["SmtpPass"],
                                "",
                               Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));

                throw;
            }




            return "";



        }








        [AcceptVerbs(HttpVerbs.Post)]
        public virtual RedirectToRouteResult ResetPasswordWithAnswer(Guid id, string answer)
        {

            // al final lo hacemos sin respuesta, como con williams

            if (true)
            {
                resetearContr(id);
            }
            else
            {
                ResetearPass(id, answer);
            }

            return RedirectToAction("Password", new { id });
        }



        [AcceptVerbs(HttpVerbs.Post)]
        public virtual RedirectToRouteResult ResetPasswordConTexto(Guid id, string nuevapass)
        {

            resetearContrConTexto(id, nuevapass);

            return RedirectToAction("Password", new { id });
        }



        /// <summary>
        /// Checks password complexity requirements for the actual membership provider
        /// </summary>
        /// <param name="password">password to check</param>
        /// <returns>true if the password meets the req. complexity</returns>
        static public bool CheckPasswordComplexity(string password)
        {
            return CheckPasswordComplexity(Membership.Provider, password);
        }


        /// <summary>
        /// Checks password complexity requirements for the given membership provider
        /// </summary>
        /// <param name="membershipProvider">membership provider</param>
        /// <param name="password">password to check</param>
        /// <returns>true if the password meets the req. complexity</returns>
        static public bool CheckPasswordComplexity(MembershipProvider membershipProvider, string password)
        {
            if (string.IsNullOrEmpty(password)) return false;
            if (password.Length < membershipProvider.MinRequiredPasswordLength) return false;
            int nonAlnumCount = 0;
            for (int i = 0; i < password.Length; i++)
            {
                if (!char.IsLetterOrDigit(password, i)) nonAlnumCount++;
            }
            if (nonAlnumCount < membershipProvider.MinRequiredNonAlphanumericCharacters) return false;
            if (!string.IsNullOrEmpty(membershipProvider.PasswordStrengthRegularExpression) &&
                !System.Text.RegularExpressions.Regex.IsMatch(password, membershipProvider.PasswordStrengthRegularExpression))
            {
                return false;
            }
            return true;
        }


        public void resetearContrConTexto(Guid id, string txtPass)
        {

            if (!CheckPasswordComplexity(txtPass))
            {
                TempData["Alerta"] = "La contraseña debe tener al menos 7 caracteres y debe tener un carácter no alfanumérico";
                return; //throw new Exception("La contraseña es inválida");
            }

            MembershipUser membershipUser = default(MembershipUser);
            //membershipUser = Membership.Providers("SqlMembershipProviderOther").GetUser(UserName, False)
            membershipUser = Membership.GetUser(id);
            string UserName = membershipUser.UserName;

            //http://team.desarrollosnea.com.ar/blogs/jfernandez/archive/2009/12/10/asp-net-membership-reset-password-with-ts-sql-por-si-las-moscas-tenerlo-a-mano.aspx
            try
            {


                string sinencript = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
                string sc = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(sinencript).Replace(".Pronto", ".bdlmaster");
                string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(sinencript);

                var dt = Pronto.ERP.Bll.EntidadManager.ExecDinamico(sConexBDLMaster, "[wResetearPass] '" + UserName + "'," + "'" + txtPass + "'");

                string cuerpo = "Vuelva al sitio e inicie sesión utilizando la siguiente información. Nombre de usuario: " + UserName + " Contraseña: " + txtPass;

                try
                {

                    ProntoFuncionesGenerales.MandaEmailSimple(
                             ConfigurationManager.AppSettings["ErrorMail"] + "," + membershipUser.Email + (oStaticMembershipService.GetUser() == null ? "" : "," + oStaticMembershipService.GetUser().Email)
                             ,
                            "Reinicio de contraseña",
                            cuerpo,
                            ConfigurationManager.AppSettings["ErrorMail"],
                            ConfigurationManager.AppSettings["SmtpServer"],
                            ConfigurationManager.AppSettings["SmtpUser"],
                            ConfigurationManager.AppSettings["SmtpPass"],
                            "",
                            Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));
                }
                catch (Exception)
                {


                    ProntoFuncionesGenerales.MandaEmailSimple(
                             ConfigurationManager.AppSettings["ErrorMail"]
                             ,
                            "Reinicio de contraseña",
                            cuerpo,
                            ConfigurationManager.AppSettings["ErrorMail"],
                            ConfigurationManager.AppSettings["SmtpServer"],
                            ConfigurationManager.AppSettings["SmtpUser"],
                            ConfigurationManager.AppSettings["SmtpPass"],
                            "",
                            Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));
                }




                //MsgBoxAlert("Contraseña cambiada con éxito")
                TempData["Alerta"] = "Contraseña cambiada con éxito. Se envió un correo de notificación a " + membershipUser.Email;



            }
            catch (Exception ex)
            {
                ErrHandler.WriteAndRaiseError(ex);
                TempData["Alerta"] = "La contraseña debe tener al menos 7 caracteres y debe tener un carácter no alfanumérico";

            }

        }




        public void resetearContr(Guid id)
        {

            string txtPass = GenerarPass();
            resetearContrConTexto(id, txtPass);

        }



        //[AcceptVerbs(HttpVerbs.Post)]
        //public JsonResult SetPassword(Guid id, string password, string nuevapass)
        //{

        //    var u = Membership.GetUser(id);
        //    if (u.ChangePassword(password, nuevapass))
        //    {
        //        return Json("Cambiada");
        //    }
        //    else
        //    {
        //        return Json("No se pudo cambiar la contraseña");
        //    }






        //    /////////////////////////////////////////////////////////////////////////
        //    /////////////////////////////////////////////////////////////////////////
        //    /////////////////////////////////////////////////////////////////////////
        //    /////////////////////////////////////////////////////////////////////////
        //    /////////////////////////////////////////////////////////////////////////
        //    //var user = _userService.Get(id);
        //    //_passwordService.ChangePassword(user, password);

        //    //var body = ResetPasswordBody + password;
        //    //var msg = new MailMessage();
        //    //msg.To.Add(user.Email);
        //    //msg.Subject = ResetPasswordSubject;
        //    //msg.Body = body;
        //    //_smtpClient.Send(msg);

        //    //return RedirectToAction("Password", new { id });
        //}

        [AcceptVerbs(HttpVerbs.Post)]
        public virtual RedirectToRouteResult AddToRole(Guid id, string role)
        {
            _rolesService.AddToRole(_userService.Get(id), role);
            GrabarNuevaClaveDeRoles();

            return RedirectToAction("UsersRoles", new { id });
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public virtual RedirectToRouteResult RemoveFromRole(Guid id, string role)
        {
            _rolesService.RemoveFromRole(_userService.Get(id), role);
            GrabarNuevaClaveDeRoles();
            return RedirectToAction("UsersRoles", new { id });
        }


        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        /// <summary>
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        [HttpPost]
        public virtual JsonResult EditarConexion(string conexSql, string nombreBase)
        {

            string sc = Generales.FormatearConexParaEntityFrameworkBDLMASTER();
            ProntoMVC.Data.Models.BDLMasterEntities dbMaster = new ProntoMVC.Data.Models.BDLMasterEntities(sc);


            Bases b = (from i in dbMaster.Bases
                       where (i.Descripcion == nombreBase)
                       select i).FirstOrDefault();


            if (b == null)
            {
                b = new Bases();

                b.Descripcion = nombreBase;
                b.StringConection = conexSql;

                dbMaster.Bases.Add(b);
            }
            else
            {
                b.StringConection = conexSql;
                dbMaster.Bases.Attach(b);

                //todo
                dbMaster.Entry(b).State = System.Data.Entity.EntityState.Modified;
            }


            dbMaster.SaveChanges();


            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });

        }




        /////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>




        public virtual ViewResult UsersEmpresas(Guid id)
        {

            //List<string> emp = new List<string>();
            IDictionary<string, bool> emp = new Dictionary<string, bool>()
                                            {
                                                {  "Williams" ,true},
                                                {  "Autotrol",false },
                                            };

            string usuario = ViewBag.NombreUsuario;
            Guid guiduser = (Guid)Membership.GetUser(usuario).ProviderUserKey;


            emp = BasesPorUsuarioColeccion2(id, guiduser);



            var user = _userService.Get(id);
            Guid userguid;
            var userRoles = _rolesService.FindByUser(user);
            return View(new DetailsViewModel
            {
                CanResetPassword = _membershipSettings.Password.ResetOrRetrieval.CanReset,
                RequirePasswordQuestionAnswerToResetPassword = _membershipSettings.Password.ResetOrRetrieval.RequiresQuestionAndAnswer,
                DisplayName = user.UserName,
                User = user,
                Roles = _rolesService.FindAll().ToDictionary(role => role, role => userRoles.Contains(role)),
                Empresas = emp, //BasesPorUsuarioColeccion(userguid).ToDictionary(role => role,true  ),
                IsRolesEnabled = true,
                Status = user.IsOnline
                            ? DetailsViewModel.StatusEnum.Online
                            : !user.IsApproved
                                ? DetailsViewModel.StatusEnum.Unapproved
                                : user.IsLockedOut
                                    ? DetailsViewModel.StatusEnum.LockedOut
                                    : DetailsViewModel.StatusEnum.Offline
            });
        }






        public List<UsuarioPronto> UsuariosProntoColeccion()
        {


            string sinencript = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
            string sc = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(sinencript).Replace(".Pronto", ".bdlmaster");
            string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(sinencript);

            DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster, "SELECT * FROM BASES");
            // List<string> baselistado = new List<string>();
            List<UsuarioPronto> baselistado = new List<UsuarioPronto>();




            ProntoMVC.Data.Models.BDLMasterEntities dbMaster = new ProntoMVC.Data.Models.BDLMasterEntities(sc);

            var q = from i in dbMaster.DetalleUserBD select i.IdDetalleUserBD;

            string usuario = ViewBag.NombreUsuario;
            Guid guiduser = (Guid)Membership.GetUser(usuario).ProviderUserKey;

            foreach (MembershipUser u in Membership.GetAllUsers())
            {
                UsuarioPronto x = new UsuarioPronto();

                //  x.EmpresaDefault = BasesPorUsuarioColeccion2((Guid)u.ProviderUserKey, guiduser).Where(y => y.Value == true).Select(y => y.Key).FirstOrDefault();
                x.user = u;
                //foreach (DataRow r in dt.Rows)
                //{



                //    //baselistado.Add(new SelectListItem { Text = r["Descripcion"] as string, Value = "" });



                //}
                baselistado.Add(x);
            }

            return baselistado;
        }



        //public JsonResult BasesPorUsuario(Guid id)
        //{

        //    return Json(BasesPorUsuarioColeccion(id), JsonRequestBehavior.AllowGet);

        //}

        public virtual JsonResult ActualizarRenglonExterno(Guid id, bool EsAdminExterno, bool EsExterno, bool EsExternoOrdenesPagoListas, bool EsExternoCuentaCorrienteProveedor)
        {
            try
            {
                if (EsAdminExterno) AddToRole(id, "AdminExterno");
                else RemoveFromRole(id, "AdminExterno");


            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e);
                //throw;
            }

            try
            {
                if (EsExterno) AddToRole(id, "Externo");
                else RemoveFromRole(id, "Externo");

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e);
                //throw;
            }

            try
            {
                if (EsExternoCuentaCorrienteProveedor) AddToRole(id, "ExternoCuentaCorrienteProveedor");
                else RemoveFromRole(id, "ExternoCuentaCorrienteProveedor");

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e);//throw;
            }
            try
            {
                if (EsExternoOrdenesPagoListas) AddToRole(id, "ExternoOrdenesPagoListas");
                else RemoveFromRole(id, "ExternoOrdenesPagoListas");

            }
            catch (Exception e)
            {

                ErrHandler.WriteError(e);
                //throw;
            }
            TempData["message"] = "Grabado";
            //  return RedirectToAction("Index",  new { mensaje="Grabado" } );

            JsonResponse res = new JsonResponse();
            res.Status = Status.Error;
            //  res.Errors = GetModelStateErrorsAsString(this.ModelState);
            res.Message = "Grabado";
            return Json(res);

        }

        //[HttpPost]
        public virtual JsonResult ActualizarRenglon(Guid id, bool EsSuperAdmin, bool EsAdmin, bool EsComercial, bool EsFacturaElec, bool EsRequerimientos, string BaseDefault)
        {
            try
            {
                if (EsSuperAdmin) AddToRole(id, "SuperAdmin");
                else RemoveFromRole(id, "SuperAdmin");

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }


            try
            {

                MembershipUser user = Membership.GetUser(id.ToString());
                var o = db.Empleados.Where(x => x.Nombre == user.UserName || x.UsuarioNT == user.UserName).FirstOrDefault();

                if (EsAdmin)
                {
                    AddToRole(id, "Administrador");

                    o.Administrador = "SI";
                }
                else
                {
                    RemoveFromRole(id, "Administrador");
                    o.Administrador = "NO";
                }

                db.SaveChanges();



            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }


            try
            {

                if (EsComercial) AddToRole(id, "Comercial");
                else RemoveFromRole(id, "Comercial");




                //    string nombreusu=  dbma

                //                    string sc = Generales.FormatearConexParaEntityFrameworkBDLMASTER();
                //ProntoMVC.Data.Models.BDLMasterEntities dbMaster = new ProntoMVC.Data.Models.BDLMasterEntities(sc);


                //        ProntoMVC.Data.Models.Empleado  e=TraerEmpleadoProntoAsociado(nombreusu);
                //    CopioLosAccesosDeOtroEmpleado( nombreusu,e);
                //    ProntoMVC.Controllers.AccesoController.UpdateColecciones(e);

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }

            try
            {

                if (EsFacturaElec) AddToRole(id, "FacturaElectronica");
                else RemoveFromRole(id, "FacturaElectronica");

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }

            try
            {

                if (EsRequerimientos) AddToRole(id, "Requerimientos");
                else RemoveFromRole(id, "Requerimientos");

            }
            catch (Exception e)
            {
                ErrHandler.WriteError(e); //throw;
            }


            try
            {

                AddToEmpresa(id, BaseDefault);
                //CrearRelacionEnUsuariosDBMaster( nombresusuario , BaseDefault)

            }
            catch (Exception)
            {
                JsonResponse resa = new JsonResponse();
                resa.Status = Status.Error;
                resa.Message = "Error al asignar la base";
                return Json(resa);

            }




            // ViewBag.Alerta = "Grabado";
            TempData["message"] = "Grabado";
            //  return RedirectToAction("Index",  new { mensaje="Grabado" } );

            JsonResponse res = new JsonResponse();
            res.Status = Status.Error;
            //  res.Errors = GetModelStateErrorsAsString(this.ModelState);
            res.Message = "Grabado";
            return Json(res);


        }



        void CopioLosAccesosDeOtroEmpleado(ref ProntoMVC.Data.Models.Empleado e, long idEmpleado)
        {
            string sc = Generales.sCadenaConex((string)Session["BasePronto"]);
            DemoProntoEntities db = new DemoProntoEntities(sc);

            var permisos = (from i in db.EmpleadosAccesos where i.IdEmpleado == idEmpleado select i).ToList();


            ProntoMVC.Data.Models.EmpleadosAcceso acc = new ProntoMVC.Data.Models.EmpleadosAcceso();
            acc.Nodo = "Facturas";
            acc.Nivel = 1;
            e.EmpleadosAccesos.Add(acc);

        }







        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////





        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////


        public virtual ActionResult Configuracion()
        {

            var m = new ConfiguracionViewModel();

            // http://stackoverflow.com/questions/4216809/configurationmanager-doesnt-save-settings
            //Create the object
            //Configuration config = WebConfigurationManager.OpenWebConfiguration("~");  //ConfigurationManager.OpenWebConfiguration(ConfigurationUserLevel.None);

            //Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~"); //http://stackoverflow.com/a/1312739/1054200

            m.CartelAviso = ConfigurationManager.AppSettings["CartelAviso"];


            Parametros parametros = db.Parametros.Find(1);
            m.ProximoComprobanteProveedorReferencia = parametros.ProximoComprobanteProveedorReferencia ?? 1;
            m.ArchivoAyuda = parametros.ArchivoAyuda;
            m.PathPlantillas = parametros.PathPlantillas;

            m.BasePRONTOMantenimiento = parametros.BasePRONTOMantenimiento;


            return View(m);
        }


        [AcceptVerbs(HttpVerbs.Post)]
        public virtual ActionResult Configuracion(ConfiguracionViewModel configuracionViewModel)
        {



            // sCadenaConexSQLbdlmaster()


            // http://stackoverflow.com/questions/4216809/configurationmanager-doesnt-save-settings
            //Create the object
            //Configuration config = WebConfigurationManager.OpenWebConfiguration("~");  //ConfigurationManager.OpenWebConfiguration(ConfigurationUserLevel.None);


            if (configuracionViewModel.CartelAviso.NullSafeToString() != ConfigurationManager.AppSettings["CartelAviso"].ToString())
            {

                Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~"); //http://stackoverflow.com/a/1312739/1054200
                config.AppSettings.Settings.Remove("CartelAviso");
                config.AppSettings.Settings.Add("CartelAviso", configuracionViewModel.CartelAviso);



                config.Save();

                //perdes los valores de sesion!!!!
            }

            Parametros parametros = db.Parametros.Find(1);
            parametros.ProximoComprobanteProveedorReferencia = configuracionViewModel.ProximoComprobanteProveedorReferencia;
            parametros.ArchivoAyuda = configuracionViewModel.ArchivoAyuda;
            parametros.ArchivoAyuda = configuracionViewModel.ArchivoAyuda;
            parametros.PathPlantillas = configuracionViewModel.PathPlantillas;


            parametros.BasePRONTOMantenimiento = configuracionViewModel.BasePRONTOMantenimiento;



            db.SaveChanges();





            return View(configuracionViewModel);
        }

        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////


        // This action handles the form POST and the upload
        [HttpPost]
        public virtual ActionResult SubirPlantilla(System.Web.HttpPostedFileBase file)
        {
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            // Verify that the user selected a file
            if (file != null && file.ContentLength > 0)
            {
                // extract only the fielname
                var fileName = System.IO.Path.GetFileName(file.FileName);
                // store the file inside ~/App_Data/uploads folder
                var path = System.IO.Path.Combine(Server.MapPath("~/App_Data"), fileName); // "~/App_Data/uploads"
                file.SaveAs(path);

                OpenXML_Pronto.GuardarEnSQL(SC, OpenXML_Pronto.enumPlantilla.FacturaA, fileName, "Requerimiento", path);
            }





            using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
            {
                file.InputStream.CopyTo(ms);
                byte[] array = ms.GetBuffer();
            }



            // redirect back to the index action to show the form once again
            //return RedirectToAction("Index");

            return View();

        }

        public virtual FileResult BajarPlantilla()
        {
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));




            string output = OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.FacturaA, SC);



            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "requerimiento.docx");
        }



        public virtual ActionResult actualizarSql()
        {
            return View();
        }



        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////


    }





}
