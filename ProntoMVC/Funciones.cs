using System;
using System.Collections.Generic;
using System.Text;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;

using System.Configuration;
using Pronto.ERP.Bll;

using System.Web.Security;

using System.Web.Mvc;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;

using System.Data.SqlClient;



public static class ObjectExtensions
{
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // la conversion de null a string
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // http://stackoverflow.com/questions/550374/checking-for-null-before-tostring?lq=1
    // http://stackoverflow.com/questions/5700015/test-for-null-return-a-string-if-needed-what-are-the-pros-cons?lq=1
    // http://stackoverflow.com/questions/3987618/how-to-do-tostring-for-a-possibly-null-object?lq=1

    public static string NullSafeToString(this object obj)
    {
        return obj != null ? obj.ToString() : String.Empty;
    }




    public static JsonResult JsonValidation(this ModelStateDictionary state)
    {
        return new JsonResult
        {
            Data = new
            {
                Tag = "ValidationError",
                State = from e in state
                        where e.Value.Errors.Count > 0
                        select new
                        {
                            Name = e.Key,
                            Errors = e.Value.Errors.Select(x => x.ErrorMessage)
                               .Concat(e.Value.Errors.Where(x => x.Exception != null).Select(x => x.Exception.Message))
                        }
            }
        };
    }
}


//http://www.stum.de/2009/02/27/a-safe-stringsubstring-extension-method/
public static class StringExtensions
{
    public static string SafeSubstring(this string input, int startIndex, int length)
    {
        // Todo: Check that startIndex + length does not cause an arithmetic overflow
        if (input.Length >= (startIndex + length))
        {
            return input.Substring(startIndex, length);
        }
        else
        {
            if (input.Length > startIndex)
            {
                return input.Substring(startIndex);
            }
            else
            {
                return string.Empty;
            }
        }
    }
}


public static class Generales
{

    public interface IStaticMembershipService
    {
        bool EsSuperAdmin();

        MembershipUser GetUser();

        void UpdateUser(MembershipUser user);

        bool UsuarioTieneElRol(string username, string role);

    }

    public class StaticMembershipService : IStaticMembershipService
    {
        public bool UsuarioTieneElRol(string username, string role)
        {
            return Roles.IsUserInRole(username, role);
        }



        public bool EsSuperAdmin()
        {
            return Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin");
        }

        public System.Web.Security.MembershipUser GetUser()
        {
            return Membership.GetUser();
        }

        public void UpdateUser(MembershipUser user)
        {
            Membership.UpdateUser(user);
        }
    }




    // http://stackoverflow.com/questions/7195846/how-can-i-make-html-checkboxfor-work-on-a-string-field
    public static MvcHtmlString CheckBoxStringFor<TModel>(this HtmlHelper<TModel> html, Expression<Func<TModel, string>> expression)
    {
        // get the name of the property
        string[] propertyNameParts = expression.Body.ToString().Split('.');
        string propertyName = propertyNameParts.Last();

        // get the value of the property
        Func<TModel, string> compiled = expression.Compile();
        string booleanStr = compiled(html.ViewData.Model);

        // convert it to a boolean
        bool isChecked = false;
        Boolean.TryParse(booleanStr, out isChecked);
        if (booleanStr == "SI") isChecked = true;
        if (booleanStr == "NO") isChecked = false;


        TagBuilder checkbox = new TagBuilder("input");
        checkbox.MergeAttribute("id", propertyName);
        checkbox.MergeAttribute("name", propertyName);
        checkbox.MergeAttribute("type", "checkbox");
        checkbox.MergeAttribute("value", "true");
        if (isChecked)
            checkbox.MergeAttribute("checked", "checked");

        TagBuilder hidden = new TagBuilder("input");
        hidden.MergeAttribute("name", propertyName);
        hidden.MergeAttribute("type", "hidden");
        hidden.MergeAttribute("value", "false");

        return MvcHtmlString.Create(checkbox.ToString(TagRenderMode.SelfClosing) + hidden.ToString(TagRenderMode.SelfClosing));
    }


    //public static MvcHtmlString IconActionLink(this AjaxHelper helper, string icon, string text, string actionName, string controllerName, object routeValues, AjaxOptions ajaxOptions, object htmlAttributes)
    //{
    //    var builder = new TagBuilder("i");
    //    builder.MergeAttribute("class", icon);
    //    var link = helper.ActionLink("[replaceme] " + text, actionName, controllerName, routeValues, ajaxOptions, htmlAttributes).ToHtmlString();
    //    return new MvcHtmlString(link.Replace("[replaceme]", builder.ToString()));
    //}

    //public static MvcHtmlString IconActionLink(this HtmlHelper helper, string icon, string text, string actionName, string controllerName, object routeValues, object htmlAttributes)
    //{
    //    var builder = new TagBuilder("i");
    //    builder.MergeAttribute("class", icon);
    //    var link = helper.ActionLink("[replaceme] " + text, actionName, controllerName, routeValues, htmlAttributes).ToHtmlString();
    //    return new MvcHtmlString(link.Replace("[replaceme]", builder.ToString()));
    //}


    //public static string sCadenaConex(System.Web.Routing.RequestContext rc)
    //{
    //    string sBasePronto = (string)rc.HttpContext.Session["BasePronto"];
    //    return sCadenaConex(sBasePronto,null);
    //}


    public static string sCadenaConex(string nombreEmpresa, IStaticMembershipService ServicioMembership = null)
    {
        string s;

        Guid userGuid = new Guid();

        try
        {
            s = sCadenaConexSQL(nombreEmpresa, ServicioMembership);
        }
        catch (Exception ex)
        {
            FormsAuthentication.SignOut();
            // return RedirectToAction("Index", "Home");
            // LogOff()
            return null;
        }


        if (s == null || s == "")
        {
            // FormsAuthentication.SignOut();
            return null;

        }


        string SC = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(s);

        return SC;

    }



    public static string sCadenaConexMant(DemoProntoEntities db, string nombreEmpresa)
    {
        string baseman = db.Parametros.Find(1).BasePRONTOMantenimiento;


        //por ahora usamos el mismo servidor en el que está db

        string s = sCadenaConexSQL_Mant(nombreEmpresa); // traigo la cadena de conexion de la base pronto normal (no la de mantenimiento)


        string SC = FormatearConexParaEntityFrameworkMant(s, baseman);

        return SC;

    }



    //public static string sCadenaConexMant(string nombreEmpresa)
    //{
    //    string s;

    //    try
    //    {
    //        s = sCadenaConexSQL_Mant(nombreEmpresa);
    //    }
    //    catch (Exception ex)
    //    {
    //        FormsAuthentication.SignOut();
    //        // return RedirectToAction("Index", "Home");
    //        // LogOff()
    //        return null;
    //    }


    //    if (s == null || s == "")
    //    {
    //        // FormsAuthentication.SignOut();
    //        return null;

    //    }


    //    // traer la cadena desde la tabla de parametros
    //    // traer la cadena desde la tabla de parametros
    //    // traer la cadena desde la tabla de parametros
    //    // traer la cadena desde la tabla de parametros

    //    string SC = FormatearConexParaEntityFrameworkMant(s);

    //    return SC;

    //}

    public static bool EsUsuarioControlablePorAdmin(string usuarionombre, string adminnombre)
    {
        // devuelve true si el usuario1 pertenece a una base que domine el admin en cuestion
        // -y si no tiene base asignada?

        if (usuarionombre == adminnombre) return true;

        if (Roles.IsUserInRole("SuperAdmin") || Roles.IsUserInRole("Administrador")) return true;

        if (!Roles.IsUserInRole("AdminExterno")) return false;

        // es decir, si es admin a secas...

        string sc = Generales.FormatearConexParaEntityFrameworkBDLMASTER();
        BDLMasterEntities dbMaster = new BDLMasterEntities(sc);

        var q = (from b in dbMaster.Bases
                 join ud in dbMaster.DetalleUserBD on b.IdBD equals ud.IdBD
                 join u in dbMaster.aspnet_Users on ud.UserId equals u.UserId
                 where (u.UserName == usuarionombre || u.UserName == adminnombre)
                 group ud by ud.IdBD into d
                 select new
                 {
                     bases = d.Key,
                     veces = d.Count()
                 }).ToList();


        if (q.Exists(x => x.veces >= 2)) return true;


        return false;
    }




    public static string FormatearConexParaEntityFrameworkMant(string conexSQLBaseNormal, string nombreBaseMantenimiento)
    {


        var parser = new System.Data.SqlClient.SqlConnectionStringBuilder(conexSQLBaseNormal);
        string servidorSQL = parser.DataSource; // "MARIANO-PC\\SQLEXPRESS";
        string basePronto = parser.InitialCatalog;  // "Autotrol";
        string user = parser.UserID;
        string pass = parser.Password;


        string SC =
               "metadata=res://*/Models.Mantenimiento.ProntoMantenimiento.csdl|res://*/Models.Mantenimiento.ProntoMantenimiento.ssdl|res://*/Models.Mantenimiento.ProntoMantenimiento.msl;" +
               "provider=System.Data.SqlClient;provider connection string=\"" +
               "data source=" + servidorSQL + ";" +
               "initial catalog=" + nombreBaseMantenimiento + ";" +
               "persist security info=True;user id=" + user + ";" +
               "password=" + pass + ";" +
                "multipleactiveresultsets=True;App=EntityFramework\"";

        return SC;
    }


    public static string ConexEFMaster()
    {
        return FormatearConexParaEntityFrameworkBDLMASTER();
    }

    public static string FormatearConexParaEntityFrameworkBDLMASTER()
    {

        string s = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;

        var parser = new System.Data.SqlClient.SqlConnectionStringBuilder(s);
        string servidorSQL = parser.DataSource; // "MARIANO-PC\\SQLEXPRESS";
        string basePronto = parser.InitialCatalog;  // "Autotrol";
        string user = parser.UserID;
        string pass = parser.Password;


        string SC =
               "metadata=res://*/Models.bdlmaster.csdl|res://*/Models.bdlmaster.ssdl|res://*/Models.bdlmaster.msl;" +
               "provider=System.Data.SqlClient;provider connection string=\"" +
               "data source=" + servidorSQL + ";" +
               "initial catalog=" + basePronto + ";" +
               "persist security info=True;user id=" + user + ";" +
               "password=" + pass + ";" +
                "multipleactiveresultsets=True;App=EntityFramework\"";

        return SC;
    }




    public static string sCadenaConexSQLbdlmaster()
    {
        return ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
    }

    public static string sCadenaConexSQL_Mant(string nombreEmpresa, Guid userGuid = new Guid())
    {
        // string datos = HttpContext.Current.Request.Session["data"] as string;
        //var ss=ControllerContext.HttpContext.Session["{name}"];
        nombreEmpresa = nombreEmpresa ?? "";
        if (nombreEmpresa == "") return null;

        //if (userGuid == Guid.Empty) userGuid = (Guid)oStaticMembershipService.GetUser().ProviderUserKey;
        //string us = oStaticMembershipService.GetUser().UserName;
        string us = userGuid.ToString();

        //var UsuarioExiste = Pronto.ERP.Bll.BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(lista.Item(0).Id, Session, SC, Me);
        //usuario.Empresa = IdEmpresa

        string sConexBDLMaster;
        bool esSuperadmin;

        if (System.Diagnostics.Debugger.IsAttached && false)
        {
            sConexBDLMaster = @"Data Source=SERVERSQL3\TESTING;Initial catalog=BDLMaster;User ID=sa; Password=.SistemaPronto.;Connect Timeout=8";
            esSuperadmin = true;
        }
        else
        {
            sConexBDLMaster = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
            esSuperadmin = Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin");

        }
        sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(sConexBDLMaster);



        string s;

        try
        {
            if (false)
            {
                s = BDLMasterEmpresasManager.GetConnectionStringEmpresa(us, "0", sConexBDLMaster, nombreEmpresa); //, IdEmpresa);
            }
            else
            {


                var sSQL = "SELECT * FROM BASES " +
                                                          "left join DetalleUserBD on bases.IdBD=DetalleUserBD.IdBD " +
                                                          "where " +
                                                          ((!esSuperadmin) ? "UserId='" + us + "' AND" : "") +
                                                          " Descripcion='" + nombreEmpresa + "'   ";

                System.Data.DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster,
                                                       sSQL);

                //TODO explota  porque superadmin no tiene acceso a capen en DetalleUserDB
                // -por qué entonces el combito de "base" al lado del boton "actualizar" incluía esa base? -porque usa la viewbag, que llenas con
                // -sí!,BasesPorUsuarioColeccion2 , que revisa si es superadmin, y entonces incluye la base



                // si la base es nueva, cuando haces el join... todavia no tiene usuarios creados. tiene que ser "left join DetalleUserBD"


                if (dt.Rows.Count == 1)
                {
                    s = dt.Rows[0]["StringConection"] as string;
                }
                else if (dt.Rows.Count > 1)
                {
                    // no debería pasar...
                    s = dt.Rows[0]["StringConection"] as string;
                }
                else
                {
                    // está haciendo circularidades cuando creo el usuario por acá
                    //  ProntoMVC.Areas.MvcMembership.Controllers.UserAdministrationController a = new ProntoMVC.Areas.MvcMembership.Controllers.UserAdministrationController();
                    //  a.CrearUsuarioProntoEnDichaBase(nombreEmpresa, oStaticMembershipService.GetUser().UserName);


                    throw new Exception("Usuario logueado pero sin empresa elegida");

                    using (BDLMasterEntities bdlmaster = new BDLMasterEntities(Generales.FormatearConexParaEntityFrameworkBDLMASTER()))
                    {
                        var q = bdlmaster.Bases.Where(x => x.Descripcion == nombreEmpresa).FirstOrDefault();
                        return q.StringConection;
                    }



                }

            }



        }
        catch (Exception ex)
        {
            // FormsAuthentication.SignOut();
            // return RedirectToAction("Index", "Home");
            // LogOff()
            return null;
        }

        return s;

    }

    public static string sCadenaConexSQL(string nombreEmpresa
                        , IStaticMembershipService ServicioMembership )
    {
        // string datos = HttpContext.Current.Request.Session["data"] as string;
        //var ss=ControllerContext.HttpContext.Session["{name}"];
        nombreEmpresa = nombreEmpresa ?? "";
        if (nombreEmpresa == "") return null;

        Guid userGuid = new Guid();

        //var UsuarioExiste = Pronto.ERP.Bll.BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(lista.Item(0).Id, Session, SC, Me);
        //usuario.Empresa = IdEmpresa

        string sConexBDLMaster = "";
        bool esSuperadmin = false;



        if (ServicioMembership != null)
        {
            try
            {
                //if (!System.Diagnostics.Debugger.IsAttached)
                //{
                // cómo llamo desde esta funcion al servicio ?
                userGuid = (Guid)ServicioMembership.GetUser().ProviderUserKey;
                esSuperadmin = ServicioMembership.EsSuperAdmin();
                //  oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin");
                ///}
                //else esSuperadmin = true;

                sConexBDLMaster = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;

            }
            catch (Exception)
            {

                //if (System.Diagnostics.Debugger.IsAttached)
                //{
                //    // por ahora no le encontré la vuelta a mockear el membership
                //    userGuid = new Guid("1BC7CE95-2FC3-4A27-89A0-5C31D59E14E9");
                //    esSuperadmin = true;
                //    // administrador    1BC7CE95-2FC3-4A27-89A0-5C31D59E14E9
                //    // supervisor       1804B573-0439-4EA0-B631-712684B54473
                //    sConexBDLMaster = @"Data Source=SERVERSQL3\TESTING;Initial catalog=BDLMaster;User ID=sa; Password=.SistemaPronto.;Connect Timeout=8";
                //}
                //else
                //{

                    throw;
                //}


            }
        }
        else
        {
            // debería ir poniendo ServicioMembership como parametro obligatorio....

            sConexBDLMaster = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
            esSuperadmin = Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin");
        }
        //string us = oStaticMembershipService.GetUser().UserName;



        sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(sConexBDLMaster);






        string us = "";

      //  if (!System.Diagnostics.Debugger.IsAttached) 
            us = userGuid.ToString();


        string s;

        try
        {
            if (false)
            {
                s = BDLMasterEmpresasManager.GetConnectionStringEmpresa(us, "0", sConexBDLMaster, nombreEmpresa); //, IdEmpresa);
            }
            else
            {



                return conexPorEmpresa(nombreEmpresa, sConexBDLMaster, us, esSuperadmin);


            }



        }
        catch (Exception ex)
        {
            // FormsAuthentication.SignOut();
            // return RedirectToAction("Index", "Home");
            // LogOff()
            return null;
        }

        return s;

    }




    public static string conexPorEmpresa(string nombreEmpresa, string sConexBDLMaster, string usuario, bool esSuperadmin)
    {

        string s;

        var sSQL = "SELECT * FROM BASES " +
                                                  "left join DetalleUserBD on bases.IdBD=DetalleUserBD.IdBD " +
                                                  "where " +
                                                  ((!esSuperadmin) ? "UserId='" + usuario + "' AND" : "") +
                                                  " Descripcion='" + nombreEmpresa + "'   ";

        System.Data.DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster,
                                               sSQL);

        //TODO explota  porque superadmin no tiene acceso a capen en DetalleUserDB
        // -por qué entonces el combito de "base" al lado del boton "actualizar" incluía esa base? -porque usa la viewbag, que llenas con
        // -sí!,BasesPorUsuarioColeccion2 , que revisa si es superadmin, y entonces incluye la base



        // si la base es nueva, cuando haces el join... todavia no tiene usuarios creados. tiene que ser "left join DetalleUserBD"


        if (dt.Rows.Count == 1)
        {
            s = dt.Rows[0]["StringConection"] as string;
        }
        else if (dt.Rows.Count > 1)
        {
            // no debería pasar...
            s = dt.Rows[0]["StringConection"] as string;
        }
        else
        {
            // está haciendo circularidades cuando creo el usuario por acá
            //  ProntoMVC.Areas.MvcMembership.Controllers.UserAdministrationController a = new ProntoMVC.Areas.MvcMembership.Controllers.UserAdministrationController();
            //  a.CrearUsuarioProntoEnDichaBase(nombreEmpresa, oStaticMembershipService.GetUser().UserName);


            throw new Exception("Usuario logueado pero sin empresa elegida");

            using (BDLMasterEntities bdlmaster = new BDLMasterEntities(Generales.FormatearConexParaEntityFrameworkBDLMASTER()))
            {
                var q = bdlmaster.Bases.Where(x => x.Descripcion == nombreEmpresa).FirstOrDefault();
                return q.StringConection;
            }

        }

        return s;
    }



    public static string sCadenaConexSQL2(string nombreEmpresa, Guid userGuid)
    {
        // string datos = HttpContext.Current.Request.Session["data"] as string;
        //var ss=ControllerContext.HttpContext.Session["{name}"];

        //Guid userGuid = (Guid)Membership.FindUsersByName(nombreusuario)
        //    .GetUser().ProviderUserKey;
        //string us = oStaticMembershipService.GetUser().UserName;
        string us = userGuid.ToString();

        //var UsuarioExiste = Pronto.ERP.Bll.BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(lista.Item(0).Id, Session, SC, Me);
        //usuario.Empresa = IdEmpresa

        string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);

        string s;

        try
        {
            s = BDLMasterEmpresasManager.GetConnectionStringEmpresa(us, "0", sConexBDLMaster, nombreEmpresa); //, IdEmpresa);
        }
        catch (Exception ex)
        {
            FormsAuthentication.SignOut();
            // return RedirectToAction("Index", "Home");
            // LogOff()
            return null;
        }

        return s;

    }




    public static bool TienePermisosDeFirma(string sc, int idUsuario)
    {
        // return true;

        DemoProntoEntities db = new DemoProntoEntities(sc);

        int? nivel = db.EmpleadosAccesos.Where(e => e.IdEmpleado == idUsuario && e.Nodo == "MnuSeg2").Select(e => e.Nivel).FirstOrDefault();


        if ((nivel ?? 9) <= 5 || Roles.IsUserInRole("Firmas")) //  || Roles.IsUserInRole("Requerimiento"))
        {
            return true;
        }
        else
        {
            return false;
        }



    }



    public static int BasesDelUsuario(Guid userGuid)
    {


        string us = userGuid.ToString();



        string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
        System.Data.DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster,
                                                 "SELECT * FROM BASES " +
                                                 "join DetalleUserBD on bases.IdBD=DetalleUserBD.IdBD " +
                                                 "where UserId='" + us + "'");


        return dt.Rows.Count;




    }

    public static string BaseDefault(Guid userGuid)
    {


        //= (Guid)oStaticMembershipService.GetUser().ProviderUserKey;
        //string us = oStaticMembershipService.GetUser().UserName;
        string us = userGuid.ToString();



        string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
        System.Data.DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster,
                                                 "SELECT * FROM BASES " +
                                                 "join DetalleUserBD on bases.IdBD=DetalleUserBD.IdBD " +
                                                 "where UserId='" + us + "'");


        if (dt.Rows.Count >= 1)
        {

            string s = dt.Rows[0]["Descripcion"] as string;
            return s;

        }



        using (BDLMasterEntities bdlmaster = new BDLMasterEntities(Generales.FormatearConexParaEntityFrameworkBDLMASTER()))
        {
            var q = bdlmaster.Bases.FirstOrDefault();
            return q.Descripcion;
        }



    }



    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////

    public static string grupoDeEsteUsuario(MembershipUser u)
    {

        string grupo = "";
        using (BDLMasterEntities bdlmaster = new BDLMasterEntities(Generales.FormatearConexParaEntityFrameworkBDLMASTER()))
        {
            UserDatosExtendidos uext = bdlmaster.UserDatosExtendidos.Where(x => x.UserId == (Guid)u.ProviderUserKey).FirstOrDefault();
            grupo = uext.RazonSocial;
        }

        return grupo;
    }


    public static List<MembershipUser> AdministradoresDeEsteGrupo(string grupo)
    {
        List<Guid> q;
        List<MembershipUser> u;
        using (BDLMasterEntities bdlmaster = new BDLMasterEntities(Generales.FormatearConexParaEntityFrameworkBDLMASTER())) // para que el constructor se banque un parametro con la cadena de conexion dinamica, creo que el edmx tiene que tener en TRUE la opcion "Carga diferida habilitada" (LazyLoadingEnabled)
        {
            q = bdlmaster.UserDatosExtendidos.Where(x => x.RazonSocial == grupo).Select(x => x.UserId).ToList();
            u = Membership.GetAllUsers().Cast<MembershipUser>().Where(x => q.Contains((Guid)x.ProviderUserKey) &&
                        Roles.GetRolesForUser(x.UserName).Contains("AdminExterno")).ToList();
        }

        return u;
    }


    public static void MailAlUsuarioConLaPasswordYElDominio(string usuario, string pass, string mail)
    {
        string urldominio = ConfigurationManager.AppSettings["UrlDominio"]; // +"Account/Verificar";

        var body = "Hola " + usuario + "<br/>" +
                "Ya podés usar tu cuenta en " + urldominio + "<br/>" +
                " Contraseña: " + pass;


        ProntoFuncionesGenerales.MandaEmailSimple(mail,
                            "Cuenta habilitada",
                       body,
                        ConfigurationManager.AppSettings["SmtpUser"],
                        ConfigurationManager.AppSettings["SmtpServer"],
                        ConfigurationManager.AppSettings["SmtpUser"],
                        ConfigurationManager.AppSettings["SmtpPass"],
                          "",
                       Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));

    }


    public static void MailDeHabilitacionSinContrasena(MembershipUser u)
    {
        string urldominio = ConfigurationManager.AppSettings["UrlDominio"]; // +"Account/Verificar";

        var body = "Hola " + u.UserName + "<br/>" +
                "Ya podés usar tu cuenta en " + urldominio + "<br/>" +
               ""; // " Contraseña: " + pass;


        ProntoFuncionesGenerales.MandaEmailSimple(u.Email,
                            "Cuenta habilitada",
                       body,
                        ConfigurationManager.AppSettings["SmtpUser"],
                        ConfigurationManager.AppSettings["SmtpServer"],
                        ConfigurationManager.AppSettings["SmtpUser"],
                        ConfigurationManager.AppSettings["SmtpPass"],
                          "",
                       Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));

    }


    public static void MailAlUsuarioAvisoRegistracionPendienteDeHabilitar(MembershipUser us)
    {
        string urldominio = ConfigurationManager.AppSettings["UrlDominio"]; // +"Account/Verificar";

        var body = "Hola " + us.UserName + "<br/>" +
                "Ya estás registrado. Cuando el admiistrador te habilite, te llegará un nuevo correo";


        ProntoFuncionesGenerales.MandaEmailSimple(us.Email,
                            "Registrado",
                       body,
                        ConfigurationManager.AppSettings["SmtpUser"],
                        ConfigurationManager.AppSettings["SmtpServer"],
                        ConfigurationManager.AppSettings["SmtpUser"],
                        ConfigurationManager.AppSettings["SmtpPass"],
                          "",
                       Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));

    }


    public static void enviarmailAlComprador(string mail, int idpresupuesto)
    {

        string urldominio = ConfigurationManager.AppSettings["UrlDominio"]; // +"Account/Verificar";

        var body = " " + "<br/>" +
                "El presupuesto fue modificado " + urldominio + "Presupuesto/Edit/" + idpresupuesto.ToString() + "<br/>";



        ProntoFuncionesGenerales.MandaEmailSimple(mail,
                            "Presupuesto Actualizado",
                       body,
                        ConfigurationManager.AppSettings["SmtpUser"],
                        ConfigurationManager.AppSettings["SmtpServer"],
                        ConfigurationManager.AppSettings["SmtpUser"],
                        ConfigurationManager.AppSettings["SmtpPass"],
                          "",
                       Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));
    }


    public static void MailAlUsuario(MembershipUser us, string urldominio)
    {

        string grupo = grupoDeEsteUsuario(us);

        if (AdministradoresDeEsteGrupo(grupo).Count == 0)
        {

            var body = "<br/>El grupo " + grupo + " no existe. El usuario " + us.UserName + "(" + us.Email + ") ha creado una cuenta con ese grupo.<br/>" +
                   "Hacé clic en "
                // +  urldominio + "/" + cifrar(((Guid)(us.ProviderUserKey)).ToString()) 
               + urldominio + "/" + ((Guid)(us.ProviderUserKey)).ToString()
               + " para habilitarlo";


            ProntoFuncionesGenerales.MandaEmailSimple(ConfigurationManager.AppSettings["ErrorMail"],
                              "Validación de Cuenta",
                         body,
                          ConfigurationManager.AppSettings["SmtpUser"],
                          ConfigurationManager.AppSettings["SmtpServer"],
                          ConfigurationManager.AppSettings["SmtpUser"],
                          ConfigurationManager.AppSettings["SmtpPass"],
                            "",
                         Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));
        }


        foreach (MembershipUser u in AdministradoresDeEsteGrupo(grupo))
        {
            //puedo  usar dos metodos: que use la returnurl despues de autenticarse, o 
            // que en el link haya una encriptacion que lo identifique 

            //var mailDelAdmin = "mscalella911@gmail.com";
            var mailDelAdmin = u.Email + ";" + ConfigurationManager.AppSettings["ErrorMail"];




            var body = "Hola " + u.UserName + "<br/><br/>El usuario " + us.UserName + "(" + us.Email + ") ha creado una cuenta.<br/>" +
                    "Hacé clic en "
                // +  urldominio + "/" + cifrar(((Guid)(us.ProviderUserKey)).ToString()) 
                + urldominio + "/" + ((Guid)(us.ProviderUserKey)).ToString()
                + " para habilitarlo";


            ProntoFuncionesGenerales.MandaEmailSimple(mailDelAdmin,
                                "Validación de Cuenta",
                           body,
                            ConfigurationManager.AppSettings["SmtpUser"],
                            ConfigurationManager.AppSettings["SmtpServer"],
                            ConfigurationManager.AppSettings["SmtpUser"],
                            ConfigurationManager.AppSettings["SmtpPass"],
                              "",
                           Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));
        }

        //   Pronto.ERP.Bll.CartaPorteManagerAux.
    }


    public static string cifrar(string s)
    {

        // return s; //está devolviendo la cadena con caracteres que no se banca la url

        //var d = new dsEncrypt();
        //d.KeyString = "EDS";
        //return d.Encrypt(s) ;


        return System.Web.HttpUtility.UrlEncode(EntidadManager.encryptQueryString(s));
    }

    public static string descifrar(string s)
    {
        return EntidadManager.decryptQueryString(System.Web.HttpUtility.UrlDecode(s)); //.Replace(" ", "+")
    }













    public static int Val(string p_Val)
    {
        if (p_Val == null) return 0;
        if (p_Val.Trim() == "") return 0;

        char[] cRec = p_Val.ToCharArray();
        string sNum = string.Empty;
        for (int i = 0; i < cRec.Length; i++)
        {
            if (char.IsNumber(cRec[i]))
                sNum += cRec[i];
            else
            {
                if (sNum != "")
                {
                    try
                    {
                        return Convert.ToInt32(sNum);
                    }
                    catch
                    {
                        return 0;
                    }
                }
                return 0;
            }
        }
        try
        {
            return Convert.ToInt32(sNum);
        }
        catch
        {
            return 0;
        }
    }
}


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

//private List<string> GetModelStateErrorsAsString(ModelStateDictionary state)
//   {
//       List<string> errors = new List<string>();

//       foreach (var key in ModelState..Keys)
//       {
//           var error = ModelState[key].Errors.FirstOrDefault();
//           if (error != null)
//           {
//               errors.Add(error.ErrorMessage);
//           }
//       }

//       return errors;
//   }



