using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity.Core.Metadata.Edm; // using System.Data.Metadata.Edm;
using System.Data.Entity;
using System.Data.Entity.Core.Objects; // using System.Data.Entity.Core.Objects;
using System.Data.Entity.Core.Objects.DataClasses;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using Pronto.ERP.Bll;

using Elmah;

using StackExchange.Profiling;

namespace ProntoMVC.Controllers
{


    public enum Tree_TX_ActualizarParam
    {
        RequerimientosAgrupados,
        SolicitudesCompraAgrupadas,
        AjustesStockAgrupados,
        RecepcionesAgrupadas,
        ValesSalidaAgrupados,
        SalidaMaterialesAgrupadas,
        OtrosIngresosAlmacenAgrupados,
        OrdenesCompraAgrupadas,
        RemitosAgrupados,
        FacturasAgrupadas,
        DevolucionesAgrupadas,
        RecibosAgrupados,
        NotasDebitoAgrupadas,
        NotasCreditoAgrupadas,
        PresupuestosAgrupados,
        ComparativasAgrupadas,
        PedidosAgrupados,
        AutorizacionesCompraAgrupadas,
        ComprobantesPrvPorMes,
        OPagoPorMes,
        DepositosBancariosAgrupados,
        GastosBancariosAgrupados
    }



    public abstract partial class ProntoBaseController : Controller // , IProntoInterface<Object>
    {
        public DemoProntoEntities db; //= new DemoProntoEntities(sCadenaConex());
        public ProntoMVC.Data.Models.Mantenimiento.ProntoMantenimientoEntities dbmant;


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

            string s = Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService);
            return d.Encrypt(s);


        }

        private void asignacadena(string nombreEmpresa)
        {
            string sc;

            Guid uguid = (Guid)new Guid();


            try
            {


                //if (!System.Diagnostics.Debugger.IsAttached) //si uso esto, anda hacer "Debug test", pero no "Run test".

                if (this.Session["Usuario"].NullSafeToString() == "")
                    uguid = (Guid)oStaticMembershipService.GetUser().ProviderUserKey;
                else
                    uguid = new Guid("1804B573-0439-4EA0-B631-712684B54473");
                // administrador    1BC7CE95-2FC3-4A27-89A0-5C31D59E14E9
                // supervisor       1804B573-0439-4EA0-B631-712684B54473

            }
            catch (Exception)
            {
                // ofrecer un logoff!!!!!!!!!!
                // ofrecer un logoff!!!!!!!!!!
                // ofrecer un logoff!!!!!!!!!!
                // ofrecer un logoff!!!!!!!!!!
                // ofrecer un logoff!!!!!!!!!!
                // ofrecer un logoff!!!!!!!!!!


                if (false)
                {
                    throw new Exception("Falla la conexion a la bdlmaster para verficar el membership .net");
                }
                else
                {
                    // es porque está mal logeado o porque no se conecta a la bdlmaster?

                    FormsAuthentication.SignOut();
                    Session.Abandon();
                    FormsAuthentication.RedirectToLoginPage();
                    return;
                }
            }




            try
            {
                sc = Generales.sCadenaConex(nombreEmpresa, oStaticMembershipService);
            }
            catch (Exception)
            {
                //return;
                throw new Exception("Falta la cadena de conexion a la base Pronto (nombre de base: [" + nombreEmpresa + "]");
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

                try
                {
                    if (oStaticMembershipService.GetUser() == null)
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
                }
                catch (System.Data.SqlClient.SqlException x)
                {
                    throw;
                }
                catch (Exception)
                {

                    throw;
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

                if ((n.BuscarUltimaBaseAccedida(oStaticMembershipService) ?? "") != "")
                {
                    this.Session["BasePronto"] = n.BuscarUltimaBaseAccedida(oStaticMembershipService);
                    // return Redirect(returnUrl);

                    string sss2 = this.Session["BasePronto"].ToString();
                    sc = Generales.sCadenaConex(sss2, oStaticMembershipService);
                    if (sc == null)
                    {
                        // throw new Exception("Falta la cadena de conexion a la base Pronto (nombre de base: [" + sss + "]");
                        this.Session["BasePronto"] = Generales.BaseDefault((Guid)oStaticMembershipService.GetUser().ProviderUserKey);
                    }
                }
                else
                {

                    this.Session["BasePronto"] = Generales.BaseDefault((Guid)oStaticMembershipService.GetUser().ProviderUserKey);
                }

                string sss = this.Session["BasePronto"].ToString();
                sc = Generales.sCadenaConex(sss, oStaticMembershipService);
                //    return RedirectToAction("Index", "Home");
                if (sc == null) throw new Exception("Falta la cadena de conexion a la base Pronto (nombre de base: [" + sss + "]");
            }


            db = new DemoProntoEntities(sc);



            if (false) // desactivé la creacion de dbmant porque desde el studio me está poniendo lenta la cosa creo
            {


                try
                {
                    dbmant = new ProntoMVC.Data.Models.Mantenimiento.ProntoMantenimientoEntities(Generales.sCadenaConexMant(db, this.Session["BasePronto"].ToString()));
                    //dbmant = new  ProntoMantenimientoEntities(Generales.sCadenaConexMant(this.Session["BasePronto"].ToString()));

                }
                catch (Exception e)
                {

                    ErrHandler.WriteError(e);
                }
            }



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


        public void FakeInitialize(string nombreempresa)
        {

            asignacadena(nombreempresa);

        }


        protected override void Initialize(System.Web.Routing.RequestContext rc)
        {
            MiniProfiler profiler = MiniProfiler.Current;


            using (profiler.Step("En el Initialize"))
            {
                base.Initialize(rc);

                oStaticMembershipService = new Generales.StaticMembershipService();


                if (oStaticMembershipService.GetUser() == null)
                {
                    FormsAuthentication.SignOut();
                    Session.Abandon();
                    FormsAuthentication.RedirectToLoginPage();
                    return;
                }



                // string sBasePronto = (string)rc.HttpContext.Session["BasePronto"];
                // db = new DemoProntoEntities(Funciones.Generales.sCadenaConex(sBasePronto));
                ROOT = ConfigurationManager.AppSettings["UrlDominio"]; // ConfigurationManager.AppSettings["Root"] ["UrlDominio"];
                asignacadena((string)rc.HttpContext.Session["BasePronto"]);

                string us = oStaticMembershipService.GetUser().ProviderUserKey.ToString();

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
        }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            // http://stackoverflow.com/questions/3214774/how-to-redirect-from-onactionexecuting-in-base-controller
            //http://stackoverflow.com/questions/8225930/redirect-from-controller-initialize-not-working
            //http://stackoverflow.com/questions/8225930/redirect-from-controller-initialize-not-working

            MiniProfiler profiler = MiniProfiler.Current;

            using (profiler.Step("En el OnActionExecuting"))
            {

                base.OnActionExecuting(filterContext);

                if (this.Session["BasePronto"] == null)
                {
                    // se perdio la base elegida. Esto parece pasarte seguido en las Views que devolves sin haber recargado la session 
                    // -Eh? no tengo necesidad de recargar la session, solo la ViewBag, y ahí no tengo la base elegida
                    // -ok, pero pasá la información de en qué página estaba antes!!!!

                    AccountController a = new AccountController();
                    if (a.BuscarUltimaBaseAccedida(oStaticMembershipService) != "")
                    {
                        this.Session["BasePronto"] = a.BuscarUltimaBaseAccedida(oStaticMembershipService);

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
                // http://stackoverflow.com/questions/8225930/redirect-from-controller-initialize-not-working

                if (filterContext.RouteData.Values["controller"].NullSafeToString() == "Home") return;
                if (filterContext.RouteData.Values["controller"].NullSafeToString() == "Acceso") return;
                if (filterContext.RouteData.Values["controller"].NullSafeToString() == "Empleado") return;

                bool ok;

                try
                {
                    //ok = PuedeLeer(filterContext.RouteData.Values["controller"].ToString());
                    ok = true;
                }
                catch (Exception)
                {
                    ok = true;
                    //  throw;
                }


                if (!ok)
                {
                    db = null;
                    //throw new Exception("Permisos insuficientes de lectura para el modulo " + filterContext.RouteData.Values["controller"].ToString() );
                }

                try
                {
                    if ((filterContext.RouteData.Values["action"].NullSafeToString() == "Edit" &&
                         filterContext.HttpContext.Request.HttpMethod == "POST") ||
                        filterContext.RouteData.Values["id"].NullSafeToString() == "-1")

                        ok = true;
                    // ok = (PuedeEditar(filterContext.RouteData.Values["controller"].ToString()));
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
                    //throw new Exception("Permisos insuficientes de edición para el modulo " + filterContext.RouteData.Values["controller"].ToString());
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
                    //throw new Exception("Permisos insuficientes de borrado para el modulo " + filterContext.RouteData.Values["controller"].ToString());
                }

            }
        }



        //http://stackoverflow.com/questions/4036582/asp-net-mvc-displaying-user-name-from-a-profile
        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {



            //Guid userGuid = (Guid)oStaticMembershipService.GetUser().ProviderUserKey;
            //string us = oStaticMembershipService.GetUser().UserName;
            //string us = userGuid.ToString();



            base.OnActionExecuted(filterContext);
        }




        public Generales.IStaticMembershipService oStaticMembershipService;




        public string BuscarClaveINI(string clave, Int32 IdUsuario2 = 0)
        {
            int IdUsuario = 0;
            if (IdUsuario2 == 0)
            {
                string usuario = ViewBag.NombreUsuario;
                IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
                string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
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
                ViewBag.NombreUsuario = oStaticMembershipService.GetUser().UserName;
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

        public enum enumNodos
        {
            Ppal,
            Tablas_Generales,
            Rubros,
            Subrubros,
            Familias,
            Acabados,
            AlimentacionesElectricas,
            AniosNorma,
            Biselados,
            Calidades,
            CalidadesClad,
            Cargos,
            CentrosCosto,
            Codigos,
            CodigosUniversales,
            Colores,
            IBCondiciones,
            IGCondiciones,
            ControlesCalidad,
            Cuentas,
            DefinicionesArt,
            Densidades,
            Depositos,
            Formas,
            Grados,
            ItemsPopUpMateriales,
            Localidades,
            Marcas,
            Materiales,
            Modelos,
            Monedas,
            Normas,
            Paises,
            Provincias,
            Rangos,
            Relaciones,
            Schedulers,
            Sectores,
            Series,
            Tipos,
            TiposRosca,
            Transportistas,
            TTermicos,
            Unidades,
            AcotarTablas,
            AcoAcabados,
            AcoBiselados,
            AcoCalidades,
            AcoCodigos,
            AcoColores,
            AcoFormas,
            AcoGrados,
            AcoMarcas,
            AcoMateriales,
            AcoModelos,
            AcoNormas,
            AcoSchedulers,
            AcoSeries,
            AcoTipos,
            AcoTiposRosca,
            AcoTratamientos,
            Articulos,
            Empleados,
            ArchivosATransmitirDestinos,
            Obras,
            Obras1,
            Obras2,
            Clientes,
            Planos,
            Equipos,
            AnexosEquipos,
            LAcopio,
            LMateriales,
            LMaterialesPorObras,
            Requerimientos,
            RequerimientosTodos,
            RequerimientosObras,
            RequerimientosCC,
            Compras,
            Proveedores,
            EstadosP,
            CondicionesCompra,
            ActividadesP,
            ProveedoresRubros,
            Presupuestos,
            PresupuestosAgrupados,
            PresupuestosTodos,
            Comparativas,
            Pedidos,
            PedidosAgrupados,
            PedidosTodos,
            PedidosPorObra,
            InformesC,
            MovStock,
            Reservas,
            AjustesStock,
            Recepciones,
            RecepcionesTodas,
            RecepcionesUltimos3Meses,
            CCalidades,
            CCalidadesPendientes,
            CCalidadesUltimos3Meses,
            CCalidadesTodos,
            ValesSalida,
            SalidaMateriales,
            Historicos,
            HistObras,
            HistObras1,
            HistObras2,
            HLAcopios,
            HLMateriales,
            HRequerimientos,
            HPedidos,
            Comercial,
            Conceptos,
            PresupuestoVentas,
            Facturas,
            Devoluciones,
            Recibos,
            NotasDebito,
            NotasCredito,
            CtaCteD,
            Valores,
            DepositosBancarios,
            Contabilidad,
            RubrosContables,
            Subdiarios,
            Asientos,
            OPago,
            CtaCteA,
            Cotizaciones,
            CtasCtesD,
            CtasCtesA,
            Vendedores,
            Bancos,
            CuentasGastos,
            UnidadesOperativas,
            OPagoTodas,
            OPagoPorMes,
            OPagoALaFirma,
            OPagoEnCaja,
            CuentasBancarias,
            Conciliaciones,
            Ganancias,
            DiferenciasCambio,
            DiferenciasCambio_PP,
            DiferenciasCambio_PG,
            ProveedoresResumen,
            ProveedoresDetalle,
            OrdenesCompra,
            Remitos,
            Conjuntos,
            TiposCuentaGrupos,
            ComprobantesPrvTodos,
            ComprobantesPrvPorMes,
            MovimientoBancos,
            BancoChequeras,
            ListasPrecios,
            ListasPreciosDefinicion,
            Ubicaciones,
            SubdiariosTodos,
            SubdiariosAgrupados,
            AsientosTodos,
            AsientosAgrupados,
            mnuMaster0,
            mnuFileA0,
            mnuFileA1,
            mnuFileA2,
            mnuFileA3,
            mnuFileA4,
            mnuFileA5,
            mnuMaster1,
            mnuViewA0,
            mnuViewA1,
            mnuViewA2,
            mnuViewA3,
            mnuMaster2,
            MnuSub0,
            MnuSubA0,
            MnuSubA1,
            MnuSubA2,
            MnuSubA3,
            MnuSubA4,
            MnuSubA5,
            MnuSubA6,
            MnuSub1,
            MnuSubCompras0,
            MnuSubC0,
            MnuSubC2,
            MnuSubC1,
            MnuSubC3,
            MnuSubC4,
            MnuSubCompras1,
            MnuSub2,
            MnuSubF0,
            MnuSubF1,
            MnuSub3,
            MnuSubO0,
            MnuSub4,
            MnuSubP0,
            MnuSubP1,
            MnuSubP2,
            MnuSubP3,
            MnuSubP4,
            MnuSubP5,
            MnuSubP6,
            MnuSub5,
            MnuSubS0,
            MnuSubS1,
            MnuSubS2,
            MnuSub6,
            MnuSubCo0,
            MnuSubCo1,
            MnuSubCo2,
            MnuSubCo3,
            MnuSubCo4,
            MnuSubCo5,
            MnuSubCo6,
            MnuSubCo7,
            MnuSubCo8,
            MnuSubCo9,
            MnuSubCo10,
            MnuSubCo11,
            MnuSubCom0,
            MnuSub7,
            MnuSubCom1,
            mnuMaster3,
            MnuInf0,
            MnuInfA0,
            MnuInfA1,
            MnuInfA2,
            MnuInfCC0,
            MnuInfCC1,
            MnuInfCC2,
            MnuInf1,
            MnuInfC1,
            MnuInfC0,
            MnuInf2,
            MnuSeg7,
            MnuSeg6,
            MnuSeg5,
            MnuSeg4,
            MnuSeg3,
            MnuSeg2,
            MnuSeg1,
            MnuSeg0,
            mnuMaster4,
            MnuAyuda0,
            MnuAyuda1,
            mnuMaster5,
            Cajas,
            ConciliacionesCajas,
            Menus,
            MnuSubCo12,
            MnuSubCom2,
            DiferenciasCambio_C,
            DiferenciasCambio_CP,
            DiferenciasCambio_CG,
            OtrosIngresosAlmacen,
            ArticulosTodos,
            ArticulosRubros,
            mnuMaster6,
            MnuUti0,
            AnticiposAlPersonal,
            ComprobantesAConfirmar,
            MnuSub8,
            MnuSubPer0,
            Personal,
            Tablas_relacionadas,
            MnuSub9,
            MnuSubCo13,
            MnuSubCo14,
            MnuSubCo15,
            MnuSubCli0,
            MnuSubCli1,
            MnuSubCli2,
            MnuSubCli3,
            MnuSubCli4,
            MnuSubCli5,
            PlazosFijos,
            PlazosFijosTodos,
            PlazosFijosAVencer,
            PlazosFijosVencidos,
            MnuSub10,
            MnuSubBco0,
            MnuSub11,
            MnuSubPrv0,
            MnuSubPrv1,
            MnuSubPrv2,
            MnuSubPrv3,
            MnuSubPrv4,
            MnuSubPrv5,
            MnuSubPrv6,
            MnuSubPrv7,
            MnuSubPrv8,
            MnuSubPrv9,
            MnuSubCli6,
            MnuSubCom3,
            MnuSubCom4,
            MnuSubS3,
            DefinicionesArtTodos,
            DefinicionesArtRubros,
            IBCondiciones2,
            CondicionesCompra2,
            IBCondiciones1,
            CondicionesCompra1,
            ProveedoresAConfirmar,
            MnuUti1,
            PuntosVenta,
            MnuSubC5,
            ClientesResumen,
            ClientesDetalle,
            RequerimientosAgrupados,
            MnuSubPrvRet0,
            MnuSubPrvRet1,
            MnuSubPrvRet2,
            MnuSubPrvRet3,
            MnuSubPrvRet4,
            MnuSubPrvRet5,
            MnuSubCliRet0,
            MnuSubCliRet1,
            MnuSubPrvRet6,
            ResumenesParaConciliacion,
            MnuSubCliRet2,
            MnuSubCliRet3,
            RequerimientosAConfirmar,
            EmisionCheques,
            EmisionChequesTodosEmitidos,
            EmisionChequesTodosNoEmitidos,
            EmisionChequesTodosNoEmitidosPorCuenta,
            ClientesAConfirmar,
            MnuSubCom5,
            VentasCuotas,
            VentasCuotasOperacion,
            VentasCuotasCobranzas,
            ActivoFijo,
            CoeficientesImpositivos,
            CoeficientesContables,
            GruposActivosFijos,
            ModificacionActivoFijo,
            MnuSubCliRet4,
            MnuUti2,
            MnuSubCom6,
            MnuSubF4,
            MnuSubF2,
            MnuSubF3,
            MnuSubC7,
            MnuSubC6,
            MnuSubA9,
            MnuSubA8,
            MnuSubA7,
            Revaluos,
            IGCondiciones2,
            VentasCuotasGeneracion,
            NotasCreditoAgrupadas,
            NotasCreditoTodas,
            NotasDebitoAgrupadas,
            NotasDebitoTodas,
            RecibosAgrupados,
            RecibosTodos,
            DevolucionesAgrupadas,
            DevolucionesTodas,
            FacturasAgrupadas,
            FacturasTodas,
            RemitosAgrupados,
            RemitosTodos,
            OrdenesCompraAgrupadas,
            OrdenesCompraTodas,
            IGCondiciones1,
            EjerciciosContables,
            PresupuestoFinanciero,
            PresupuestoEconomico,
            GastosBancarios,
            GastosBancariosTodos,
            GastosBancariosAgrupados,
            RubrosContablesGastosPorObra,
            RubrosContablesFinancieros,
            OPagoAConfirmar,
            ImpuestosDirectos,
            Ganancias2,
            ProveedoresEventuales,
            Ganancias1,
            MnuUtiImp7,
            MnuUtiImp6,
            MnuUtiImp5,
            MnuUtiImp4,
            MnuUtiImp3,
            MnuUtiImp2,
            MnuUtiImp1,
            MnuUtiImp0,
            MnuSubBco1,
            MnuSubCom9,
            MnuSubCom7,
            MnuSubCom8,
            MnuSubP7,
            MnuSubO1,
            MnuSubPrv10,
            GruposObras,
            PosicionesImportacion,
            CostosImportacion,
            PedidosPendientes,
            PedidosSubcontratos,
            PedidosSubcontratosAgrupados,
            PedidosSubcontratosTodos,
            LugaresEntrega,
            PlazosEntrega,
            MnuUti3,
            MnuUti4,
            MnuSubCli7,
            ArticulosTodosDetallados,
            ArticulosTodosResumidos,
            ConjuntosTodos,
            ConjuntosFinales,
            ConjuntosDependientes,
            MnuSubCom18,
            PedidosAbiertos,
            ComparativasAgrupadas,
            ComparativasTodas,
            GruposTareasHH,
            ItemsDocumentacion,
            TareasMantenimiento,
            Tareas,
            ItemsProduccion,
            AcoHHTareas,
            AcoHHItemsDocumentacion,
            OrdenesTrabajo,
            HorasHombre,
            PresupuestosHH,
            ProgramacionObraSectorMes,
            TareasFijas,
            Feriados,
            HorasHombreH,
            MnuConA7,
            MnuConA6,
            MnuConA5,
            MnuConA4,
            MnuConA3,
            MnuConA2,
            MnuConA1,
            MnuConA0,
            MnuUtiImp8,
            MnuUtiImp9,
            MnuUtiImp10,
            MnuUtiImp11,
            MnuUtiImp12,
            MnuUti5,
            MnuSubCom10,
            MnuSubCom11,
            MnuSubCom12,
            MnuSubCom13,
            MnuSubCom14,
            MnuSubCom15,
            MnuSubCom16,
            MnuSubCom17,
            MnuSubCoA0,
            MnuSubCoA1,
            MnuSubS5,
            MnuSubS4,
            MnuSubPrv11,
            MnuSubC9,
            MnuSubC8,
            MnuUtiPRONTO3,
            MnuUtiPRONTO2,
            MnuUtiPRONTO1,
            MnuUtiPRONTO0,
            ArticulosInactivos,
            MnuSubC10,
            SolicitudesCompra,
            SolicitudesCompraTodas,
            SolicitudesCompraAgrupadas,
            MnuSubCom19,
            DistribucionesObras,
            MnuUti6,
            AjustesStockTodos,
            AjustesStockAgrupados,
            RecepcionesAgrupadas,
            ValesSalidaTodos,
            ValesSalidaAgrupados,
            SalidaMaterialesTodas,
            SalidaMaterialesAgrupadas,
            OtrosIngresosAlmacenTodos,
            OtrosIngresosAlmacenAgrupados,
            MnuUtiPRONTO4,
            ArticulosProntoMantenimiento,
            MnuSubCom20,
            MnuSubCom21,
            ComprobantesPrv,
            MnuSubCoB0,
            MnuSubCoB1,
            CashFlow,
            MnuUti7,
            MnuSubPrvRet7,
            Botones,
            btn_New,
            btn_Save,
            btn_Print,
            btn_Copy,
            btn_Paste,
            btn_Find,
            btn_Help,
            btn_CopiarCampo,
            btn_Refrescar,
            btn_Parametros,
            btn_Empresa,
            btn_EnviarMensaje,
            btn_MenuPopUp,
            btn_AccesoPorUsuarios,
            btn_Calculadora,
            MnuSubP8,
            MnuSubP9,
            MnuSubCoB2,
            MnuSubCoB3,
            MnuSubCoB4,
            MnuSubCoB5,
            MnuSubCoB6,
            MnuSubCoB7,
            MnuSubCoB8,
            MnuSubCoB9,
            MnuSubCoB10,
            MnuSubCom22,
            MnuUtiImp13,
            AnticiposAlPersonalSyJ,
            CuentasTodas,
            HChequeras,
            MnuSubO2,
            MnuUtiImp14,
            MnuUti8,
            MnuSubA10,
            MnuUti9,
            FacturasContado,
            FacturasContadoTodas,
            FacturasContadoAgrupadas,
            MnuSubA11,
            TarjetasCredito,
            MnuUtiPRONTO5,
            MnuUtiPRONTO6,
            OrdenesTrabajoTodos,
            OrdenesTrabajoAgrupados,
            OrdenesTrabajoTodas,
            OrdenesTrabajoAgrupadas,
            ChequesPendientes,
            MnuUti10,
            MnuSubP10,
            MnuUtiPRONTO7,
            MnuSubA12,
            RequerimientosPorObra,
            MnuSubBco2,
            MnuSubC11,
            MnuSubPrv12,
            CCalidadesControlados,
            MnuSubF5,
            MnuSubS6,
            MnuSubP11,
            MnuUti11,
            MnuSubA13,
            MnuSubCo16,
            MnuSubCoC0,
            MnuSubCoC1,
            MnuSubCoC2,
            MnuSubCoC3,
            MnuSubCoC4,
            MnuSubCoC5,
            MnuSubCoC6,
            FondosFijos,
            ArticulosEquiposTerceros,
            Empleados1,
            Empleados2,
            Empleados3,
            RequerimientosALiberar,
            MnuSeg8,
            TiposComprobante,
            MovStockSAT,
            AjustesStockSAT,
            AjustesStockAgrupadosSAT,
            AjustesStockTodosSAT,
            RecepcionesSAT,
            RecepcionesAgrupadasSAT,
            RecepcionesTodasSAT,
            SalidaMaterialesSAT,
            SalidaMaterialesAgrupadasSAT,
            SalidaMaterialesTodasSAT,
            OtrosIngresosAlmacenSAT,
            OtrosIngresosAlmacenAgrupadosSAT,
            OtrosIngresosAlmacenTodosSAT,
            PpalSAT,
            PedidosSAT,
            PedidosAgrupadosSAT,
            PedidosPorObraSAT,
            PedidosTodosSAT,
            MnuSubBco3,
            MnuSubCom23,
            PresupuestoObras,
            MnuSubF6,
            MnuSubF7,
            PresupuestoObrasRubros,
            ConceptosOP,
            TiposArticulos,
            MnuSubPrv13,
            MnuSubBco4,
            btn_Sumar,
            MnuSubC12,
            MnuSub12,
            MnuSeg9,
            MnuUtiImp15,
            Traducciones,
            CertificacionesObra,
            Subcontratos,
            Ingenieria,
            FichaTecnica,
            MateriaPrima,
            Semielaborado,
            Terminado,
            ControlCalidad,
            OrdendeProduccion,
            OrdendeProduccionAgrupadas,
            OrdendeProduccionPorProceso,
            OrdendeProduccionTodas,
            PartedeProduccion,
            PartesAgrupadas,
            PartedeProduccionPorProceso,
            PartesTodas,
            PlanificaciondeMateriales,
            ProgramaciondeRecursos,
            ValoresRecibidos,
            UnidadesEmpaque,
            Clausulas,
            ValoresEmitidos,
            ValoresTodos,
            DepositosBancariosAgrupados,
            DepositosBancariosTodos,
            MnuSubA14,
            MnuSubA15,
            MnuSubC13,
            MnuSubC14,
            MnuSubPrv14,
            MnuSubCli8,
            MnuSubCli9,
            MnuSubCli10,
            MnuSubCli11,
            MnuSubCli12,
            MnuSubCli13,
            MnuUtiImp16,
            MnuUti12,
            MnuUti13,
            ConciliacionesTarjetas,
            MnuSubCli14,
            MnuUtiImp17,
            Propietarios,
            Choferes,
            Fletes,
            PatronesGPS,
            Movimientos,
            MovimientosAgrupados,
            MovimientosTodos,
            ResumenesParaConciliacionAgrupados,
            ResumenesParaConciliacionTodos,
            MnuSubP12,
            MnuSubCo17,
            MnuSubBco5,
            Recepciones1,
            Recepciones1Agrupadas,
            Recepciones1Todas,
            MnuSubC15,
            MnuSubPrv15,
            MnuSubCli15,
            MnuSubCli16,
            MnuUtiImp18,
            MnuUti14,
            SalidaMateriales1,
            SalidaMaterialesAgrupadas1,
            SalidaMaterialesTodas1,
            MnuUti15,
            MnuSubC16,
            MnuSubP13,
            MnuSubCli17,
            MnuUtiImp19,
            MnuSubC17,
            PresupuestoObrasGruposMateriales,
            MnuSubP14,
            LecturasGPS,
            GastosFletes,
            DispositivosGPS,
            GastosFletesAgrupados,
            GastosFletesTodos,
            LecturasGPSAgrupadas,
            LecturasGPSTodas,
            btn_CalcularDistancias,
            btn_Mapa,
            FletesPartesDiarios,
            FletesPartesDiariosAgrupados,
            FletesPartesDiariosTodos,
            TarifasFletes,
            CtrlTransp,
            Transportistas1,
            Tarifador,
            MnuUtiPRONTO8,
            MnuUtiPRONTO9,
            MnuSubP15,
            MnuSubP16,
            MnuSubP17,
            MnuSubCom24,
            LiquidacionesFletes,
            LiquidacionesFletesAgrupadas,
            LiquidacionesFletesTodos,
            LiquidacionesFletesTodas,
            AutorizacionesCompra,
            AutorizacionesCompraAgrupadas,
            AutorizacionesCompraTodas,
            MnuSubCli18,
            MnuSubC18,
            MnuSubP18,
            MnuSubC19,
            MnuSubC20,
            UnidadesEmpaqueAgrupados,
            UnidadesEmpaqueTodos,
            MnuSubP19,
            PartesProduccion,
            MnuUtiImp20,
            MnuUtiImp21,
            MnuSeg10,
            ModulosAdicionales,
            PolizasObras,
            PolizasObrasActivas,
            PolizasObrasInactivas,
            PolizasEquipos,
            PolizasEquiposActivas,
            PolizasEquiposInactivas,
            Patentes,
            PatentesActivas,
            PatentesInactivas,
            PlanesFacilidades,
            PlanesFacilidadesActivos,
            PlanesFacilidadesInactivos,
            MnuSubC21,
            MnuSub13,
            MnuSubT0,
            MnuSubT1,
            MnuSubT2,
            MnuSubC22,
            MnuSubC23,
            PolizasObrasCalendarioPendiente,
            PolizasObrasCalendarioTodas,
            PolizasEquiposCalendarioPendiente,
            PolizasEquiposCalendarioTodas,
            MnuSubF8,
            PatentesCalendarioPendiente,
            PatentesCalendarioTodas,
            PlanesFacilidadesCalendarioPendiente,
            PlanesFacilidadesCalendarioTodos,
            AsientosSyJ,
            MovimientosBalanza,
            RecepcionesBalanza,
            SalidasBalanza,
            ChequesNoUsados,
            MnuUti16,
            MnuSubO3,
            Pesadas,
            ChequesNoUsadosNoVistos,
            ChequesNoUsadosVistos,
            IngresosProduccion,
            IngresosProduccionAgrupados,
            IngresosProduccionTodos,
            MnuSub14,
            MnuSubMod0,
            MnuSubMod1,
            MnuSubMod2,
            MnuSubMod3,
            CurvasTalles,
            PresupuestosVentas,
            PresupuestosVentasAgrupados,
            PresupuestosVentasTodos,
            PresupuestosVentasPendientes,
            TiposCompra,
            PresupuestosVentasDevolucionesPendientes,
            MnuSubPrv16,
            MnuSubCom25,
            CategoriasCredito,
            Presentaciones,
            btn_PresupuestoObrasCargaDiaria,
            FletesValoresPromedio,
            PresentacionesCupones,
            MnuSubCli19,
            MnuSubCli20,
            MnuSubCom26,
            MnuSubCli21,
            Obras11,
            Obras111,
            MnuSubCli22,
            MnuSubCom27,
            MnuUtiImp22,
            PlazosFijosVencenHoy,
            MnuUtiPRONTO10,
            MnuSubF9,
            MnuUti17,
            Calles,
            MnuUtiImp23,
            TiposRubrosFinancierosGrupos,
            Previsiones,
            MnuSubCo18,
            CuentasBancariasSaldos,
            MnuSubC24,
            MnuSubBco6,
            PresupuestoObrasRedeterminaciones,
            MnuSubC25,
            MnuSubCliRet5,
            TiposNegociosVentas,
            TiposOperacionesGrupos,
            TiposOperaciones,
            GastosTarjetas,
            GastosTarjetasAgrupados,
            GastosTarjetasTodos,
            MnuSubC26,
            MnuUtiImp24,
            Acciones,
            MnuSeg11,
            MnuSubPrv17
        }

        public bool PuedeLeer(enumNodos Modulo)
        {

            return true;// desactivados desde el uso de los roles de asp.net


            try
            {

                var acc = acce(Modulo.ToString());
                if (acc.Nivel < 9) return true;

            }
            catch (Exception)
            {

                throw;
            }


            return false;
        }

        public bool PuedeEditar(enumNodos Modulo)
        {
            return true;// desactivados desde el uso de los roles de asp.net

            try
            {
                var acc = acce(Modulo.ToString());
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


                dest = Generales.sCadenaConex(nombrebasepronto, oStaticMembershipService);
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


            string nuevaconex = Generales.sCadenaConexSQL(nombrebaseoriginal, oStaticMembershipService).Replace(nombrebaseoriginal, nombrebasenueva);

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


        public int UsuarioEquivalente(Guid id)
        {
            return -1;
        }

        public Guid EmpleadoEquivalente(int id)
        {

            if (id <= 0) return new Guid();

            string usuario = db.Empleados.Find(id).UsuarioNT.ToLower();


            string sc = Generales.FormatearConexParaEntityFrameworkBDLMASTER();

            ProntoMVC.Data.Models.BDLMasterEntities dbMaster = new ProntoMVC.Data.Models.BDLMasterEntities(sc);


            var u = dbMaster.aspnet_Users.Where(x => x.LoweredUserName == usuario).FirstOrDefault();
            if (u == null) return new Guid();

            var guid = u.UserId;


            return guid;
        }


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
            Guid guiduser = (Guid)oStaticMembershipService.GetUser().ProviderUserKey;


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
            //string glbArchivoAyuda = dbcontext.Parametros.Find(1).ArchivoAyuda;
            string glbArchivoAyuda = dbcontext.Parametros.Select(x => x.ArchivoAyuda).FirstOrDefault();
            string glbPathPlantillas = "";
            //string s = dbcontext.Parametros.Find(1).PathPlantillas;
            string s = dbcontext.Parametros.Select(x => x.PathPlantillas).FirstOrDefault();
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

                try
                {
                    glbPathArchivoAPP = AppDomain.CurrentDomain.BaseDirectory + @"Documentos\Pronto.app";
                    contents = System.IO.File.ReadAllText(glbPathArchivoAPP);
                }
                catch (Exception)
                {

                    throw;
                }

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


        public virtual decimal? funcMoneda_Cotizacion(DateTime? fecha, int IdMoneda)
        {
            if (db == null) return null;
            if (fecha == null) fecha = DateTime.Now;

            decimal cotizacion;

            DateTime desde = fecha.Value.Date;
            DateTime hasta = desde.AddDays(1);

            var mvarCotizacion = db.Cotizaciones.Where(x => x.Fecha >= desde && x.Fecha <= hasta && x.IdMoneda == IdMoneda).FirstOrDefault();
            if (mvarCotizacion == null) cotizacion = -1; else cotizacion = (mvarCotizacion.CotizacionLibre ?? mvarCotizacion.Cotizacion) ?? -1;

            return cotizacion;
        }

        public virtual decimal? funcMoneda_Cotizacion2(DateTime? fecha, int IdMoneda)
        {
            if (db == null) return null;
            if (fecha == null) fecha = DateTime.Now;

            decimal cotizacion;

            DateTime desde = fecha.Value.Date;

            var mvarCotizacion = db.Cotizaciones.Where(x => x.Fecha == desde && x.IdMoneda == IdMoneda).FirstOrDefault();
            if (mvarCotizacion == null) cotizacion = -1; else cotizacion = (mvarCotizacion.CotizacionLibre ?? mvarCotizacion.Cotizacion) ?? -1;

            return cotizacion;
        }


        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        public class TreeNode
        {
            public Guid id { get; set; }
            public string name { get; set; }
            public int level { get; set; }
            public Guid? parent { get; set; }
            public bool isLeaf { get; set; }
        }

        // http://stackoverflow.com/questions/17404603/c-sharp-sorting-data-from-an-adjacency-tree
        // http://stackoverflow.com/questions/17404603/c-sharp-sorting-data-from-an-adjacency-tree

        IEnumerable<Tablas.Tree> TreeOrder(
            IEnumerable<Tablas.Tree> nodes)
        {
            //Find the root node
            var root = nodes.Single(node => node.ParentId == "");

            //Build an inverse lookup from parent id to children ids
            var childrenLookup = nodes
                .Where(node => node.ParentId != "")
                .ToLookup(node => node.ParentId);

            return TreeOrder(root, childrenLookup);
        }

        IEnumerable<Tablas.Tree> TreeOrder(
            Tablas.Tree root,
            ILookup<string, Tablas.Tree> childrenLookup)
        {
            yield return root;

            if (!childrenLookup.Contains(root.IdItem))
                yield break;

            foreach (var child in childrenLookup[root.IdItem])
                foreach (var node in TreeOrder(child, childrenLookup))
                    yield return node;
        }



        public List<Tablas.Tree> TablaTree_PresupuestoObra(int obra )
        {





            //obra= parentId;

            DataTable dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SCsql(), "PresupuestoObrasNodos_tx_ParaArbol", obra);

            var idsPadres = (from DataRow r in dt.Rows where r["IdNodoPadre"].NullSafeToString() != "" select Convert.ToInt32((r["IdNodoPadre"].NullSafeToString() == "") ? "0" : r["IdNodoPadre"].NullSafeToString())).Distinct();

            var q = from DataRow n in dt.Rows
                    //where (n["IdNodoPadre"] == parentId)
                    select new Tablas.Tree()
                    {
                        IdItem = n["IdPresupuestoObrasNodo"].NullSafeToString(),
                        Clave = n["IdPresupuestoObrasNodo"].NullSafeToString(),
                        Descripcion = n["Descripcion"].NullSafeToString(),
                        ParentId = n["IdNodoPadre"].NullSafeToString(),
                        Orden = 0, //n.Orden ?? 0,
                        Parametros = "", //n.Parametros,
                        Link = n["Lineage"].NullSafeToString(), //n.Link.Replace("Pronto2", ROOT),
                        Imagen = "", // n.Imagen,
                        EsPadre = idsPadres.Contains(Convert.ToInt32(n["IdPresupuestoObrasNodo"].NullSafeToString())) ? "SI" : "NO", // n.EsPadre,
                        nivel = 9 // p.Nivel ?? 9

                        // , Orden = n.Orden
                    };


            return TreeOrder(q).ToList();
            //return q.ToList();
        }



        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





        public IQueryable<Tablas.Tree> TablaTree(string parentId)
        {

            // cómo filtrar esto?, en especial en el nodo raíz (parentId="01")
            //    y si es externo?

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

            bool essuperadmin = oStaticMembershipService.UsuarioTieneElRol(usuario, "SuperAdmin");
            bool esadmin = oStaticMembershipService.UsuarioTieneElRol(usuario, "Administrador");
            bool escomercial = oStaticMembershipService.UsuarioTieneElRol(usuario, "Comercial");
            bool esfactura = oStaticMembershipService.UsuarioTieneElRol(usuario, "FacturaElectronica");
            bool esreq = oStaticMembershipService.UsuarioTieneElRol(usuario, "Requerimientos");
            bool esExterno = oStaticMembershipService.UsuarioTieneElRol(usuario, "AdminExterno") ||
                           oStaticMembershipService.UsuarioTieneElRol(usuario, "Externo") ||
                           oStaticMembershipService.UsuarioTieneElRol(usuario, "ExternoPresupuestos") ||
                           oStaticMembershipService.UsuarioTieneElRol(usuario, "ExternoCuentaCorrienteProveedor") ||
                           oStaticMembershipService.UsuarioTieneElRol(usuario, "ExternoCuentaCorrienteCliente") ||
                           oStaticMembershipService.UsuarioTieneElRol(usuario, "ExternoOrdenesPagoListas");
            bool escompras = oStaticMembershipService.UsuarioTieneElRol(usuario, "Compras");
            bool esFondoFijo = oStaticMembershipService.UsuarioTieneElRol(usuario, "FondosFijos");


            if (esExterno || true)
            {

                // agregarExterno() // hasta que metas el agregar externa, deberás usar TablaTree
                return TablaTree().AsQueryable();

            }


            var permisos = (from i in db.EmpleadosAccesos where i.IdEmpleado == IdUsuario select i); //.ToList();



            var q = from n in db.Trees
                    join p in permisos on n.Clave equals p.Nodo
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
                        nivel = p.Nivel ?? 9

                        // , Orden = n.Orden
                    };




            return q;
        }



        void agregarExterno(string usuario, List<Tablas.Tree> TreeDest)
        {


            var n = new Tablas.Tree();
            if (Roles.IsUserInRole(usuario, "Externo"))
            {
                string nombreproveedor = "";
                try
                {
                    Guid oGuid = (Guid)oStaticMembershipService.GetUser().ProviderUserKey;
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



        public List<Tablas.Tree> TablaTree()
        {
            // return RedirectToAction("Arbol", "Acceso");

            //esta llamada tarda // y no se puede usar linqtosql acá??????
            List<Tablas.Tree> Tree = TablasDAL.Arbol(this.Session["BasePronto"].ToString(), oStaticMembershipService);

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

            var archivoapp = LeerArchivoAPP(IdUsuario, this.Session["BasePronto"].ToString(), usuario, db, new Guid(oStaticMembershipService.GetUser().ProviderUserKey.ToString()));


            bool essuperadmin = Roles.IsUserInRole(usuario, "SuperAdmin");
            bool esadmin = Roles.IsUserInRole(usuario, "Administrador");
            bool escomercial = Roles.IsUserInRole(usuario, "Comercial");
            bool esfactura = Roles.IsUserInRole(usuario, "FacturaElectronica");
            bool esreq = Roles.IsUserInRole(usuario, "Requerimientos");
            bool esExterno = Roles.IsUserInRole(usuario, "AdminExterno") ||
                        Roles.IsUserInRole(usuario, "Externo") ||
                        Roles.IsUserInRole(usuario, "ExternoPresupuestos") ||
                        Roles.IsUserInRole(usuario, "ExternoCuentaCorrienteProveedor") ||
                        Roles.IsUserInRole(usuario, "ExternoCuentaCorrienteCliente") ||
                        Roles.IsUserInRole(usuario, "ExternoOrdenesPagoListas");
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


                if (!(!(o.Clave.Contains("Agrupad") || o.Clave.Contains("RequerimientosPorObra")) || o.Clave == "RequerimientosPorObra" || o.Clave == "RequerimientosAgrupados" || o.Clave == "PedidosAgrupados"))
                {
                    //  los nodos hijos de agrupados, como no estan en la coleccion del APP, hay que incluirlos de prepo
                    nivel = 1;

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
                string nombreproveedor = "";
                var n = new Tablas.Tree();

                if (esExterno)
                {
                    try
                    {
                        Guid oGuid = (Guid)oStaticMembershipService.GetUser().ProviderUserKey;
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

                    if (nombreproveedor == "") nombreproveedor = "Sin CUIT";

                    n.Link = nombreproveedor; // "<a href=\"#\">" + nombreproveedor + "</a>";
                    n.Descripcion = "CUIT";
                    n.Clave = "CUIT";
                    n.EsPadre = "NO"; // "SI";
                    n.IdItem = "1";
                    n.ParentId = "01";
                    n.Orden = 1;
                    TreeDest.Add(n);
                }


                if (nombreproveedor != "Sin CUIT")
                {


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
                        n.Link = "<a href='" + urldominio + "Reporte.aspx?ReportName=Resumen Cuenta Corriente Acreedores Por Mayor'>Mi Cuenta Corriente</a>";
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
                n.Link = n.Link.Replace(@"/Pronto2", ROOT);
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




            Tree = TablasDAL.Menu(this.Session["BasePronto"].ToString(), oStaticMembershipService);
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

            string SC = Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService);
            SC = Generales.sCadenaConex(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService);
            bool esfirma = Generales.TienePermisosDeFirma(SC, IdUsuario);

            foreach (Tablas.Tree o in Tree)
            {
                EmpleadosAcceso acc = permisos.Where(x => x.Nodo == o.Clave).FirstOrDefault();

                if (acc == null) continue;

                int? nivel = acc.Nivel;


                if (nivel == null || !acc.Acceso || nivel == 0)
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
                //n.Link = n.Link.Replace("Pronto2", ROOT);
                n.Link = n.Link.Replace(@"/Pronto2", ROOT);

            }


            return TreeDest;





        }




        public List<Tablas.Tree> MenuConNiveles_Tree(int IdUsuario)
        {

            List<Tablas.Tree> Tree = TablasDAL.Menu(this.Session["BasePronto"].ToString(), oStaticMembershipService);
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


        public List<Tablas.Tree> ArbolConNiveles_Tree(int IdUsuario, string sBase, string usuario, DemoProntoEntities dbcontext, Generales.IStaticMembershipService ServicioMembership)
        {

            List<Tablas.Tree> Tree = TablasDAL.Arbol(sBase, ServicioMembership);
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


            var archivoapp = LeerArchivoAPP(IdUsuario, sBase, usuario, dbcontext, (Guid)ServicioMembership.GetUser().ProviderUserKey);


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













        public string GuardarNovedadUsuario(int IdNovedadUsuario, int IdEmpleado, string Detalle) // As MisEstados
        {

            return GuardarNovedades(IdNovedadUsuario, IdEmpleado, Detalle);
        }

        private string GuardarNovedades(int IdEventoDelSistema, int IdEmpleado, string Detalle)
        {




            //       agregar fk


            if (IdEmpleado > 0)
            {
                var nov = new NovedadesUsuario();

                nov.IdEmpleado = IdEmpleado;
                nov.IdEventoDelSistema = IdEventoDelSistema;
                nov.FechaEvento = DateTime.Now;
                nov.Detalle = Detalle;
                nov.Confirmado = "NO";

                db.NovedadesUsuarios.Add(nov);

            }

            var q = from det in db.DetalleEventosDelSistemas where det.IdEventoDelSistema == IdEventoDelSistema select det;


            // si un evento esta asociado a mas de un usuario, le informa al resto que este usuario hizo algo

            foreach (DetalleEventosDelSistema d in q)
            {
                var nov = new NovedadesUsuario();

                nov.IdEmpleado = d.IdEmpleado ?? 0;
                nov.IdEventoDelSistema = IdEventoDelSistema;
                nov.FechaEvento = DateTime.Now;
                nov.Detalle = Detalle;
                nov.Confirmado = "NO";

                db.NovedadesUsuarios.Add(nov);

            }




            return "";
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




