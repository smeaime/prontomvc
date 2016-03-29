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

using System.Data.Entity.Core.Objects; // using System.Data.Entity.Core.Objects;

using Pronto.ERP.Bll;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;

namespace ProntoMVC.Controllers
{
    public abstract partial class ProntoBaseController2 : Controller // , IProntoInterface<Object>
    {
        internal Repo.UnitOfWork unitOfWork;

        // public DemoProntoEntities db; //= new DemoProntoEntities(sCadenaConex());
        public Servicio.FondoFijoService ffserv;

        public string SC;

        public Generales.IStaticMembershipService oStaticMembershipService;


        public int glbIdUsuario
        {

            get
            {
                string usuario = ViewBag.NombreUsuario;
                int IdUsuario = ffserv.Empleados_Listado().Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                return IdUsuario;
            }

            set { return; }
        }



        public Empleado glbUsuario
        {

            get
            {
                return ffserv.EmpleadoById(glbIdUsuario);
            }

            set { }
        }



        public const int pageSize = 10;

        public string SCsql()
        {
            var d = new dsEncrypt();
            d.KeyString = "EDS";

            string s = Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), null);
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
                throw new Exception("Falta la cadena de conexion a la base Pronto");
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

                if ((n.BuscarUltimaBaseAccedida(oStaticMembershipService) ?? "") != "")
                {
                    this.Session["BasePronto"] = n.BuscarUltimaBaseAccedida(oStaticMembershipService);
                    // return Redirect(returnUrl);
                }
                else
                {

                    this.Session["BasePronto"] = Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey);
                }


                //}
                string sss = this.Session["BasePronto"].ToString();
                sc = Generales.sCadenaConex(sss);
                //    return RedirectToAction("Index", "Home");
                if (sc == null) throw new Exception("Falta la cadena de conexion a la base Pronto");
            }


            // esto es lo que hay que sacar
            // db = new DemoProntoEntities(sc);


            SC = sc;


            //if (db == null)
            //{
            //    if (System.Diagnostics.Debugger.IsAttached)
            //    {
            //        System.Diagnostics.Debugger.Break();
            //    }
            //    else
            //    {
            //        throw new Exception("error en creacion del context. " + sc);

            //    }
            //}

        }



        protected override void Initialize(System.Web.Routing.RequestContext rc)
        {
            base.Initialize(rc);

            // string sBasePronto = (string)rc.HttpContext.Session["BasePronto"];
            // db = new DemoProntoEntities(Funciones.Generales.sCadenaConex(sBasePronto));

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







        }



        //http://stackoverflow.com/questions/4036582/asp-net-mvc-displaying-user-name-from-a-profile
        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {



            //Guid userGuid = (Guid)oStaticMembershipService.GetUser().ProviderUserKey;
            //string us = oStaticMembershipService.GetUser().UserName;
            //string us = userGuid.ToString();



            base.OnActionExecuted(filterContext);
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

        EmpleadosAcceso acce(string Modulo)
        {
            //string usuario = ViewBag.NombreUsuario;
            //int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

            //EmpleadosAcceso acc = (from i in db.EmpleadosAccesos
            //                       where (i.IdEmpleado == IdUsuario &&

            //                           (i.Nodo == Modulo || i.Nodo == Modulo + "s" || i.Nodo == Modulo + "es")
            //                           )
            //                       select i).FirstOrDefault();

            //// falló con el nodo "PuntosVenta", porque la vista (el módulo) se llama "PuntoVenta"

            //if (acc == null) throw new Exception("Error de permisos. No se encuentra el empleado/permiso");
            //return acc;
            return null;
        }


        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////



        protected override void Dispose(bool disposing)
        {
            //if (db != null) db.Dispose();
            //base.Dispose(disposing);
        }







        /// <summary>
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="id"></param>
        /// <param name="empresa"></param>
        /// <returns></returns>



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


            string nuevaconex = Generales.sCadenaConexSQL(nombrebaseoriginal.Replace(nombrebaseoriginal, nombrebasenueva),null);

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


            var q = unitOfWork.CantidadAutorizaciones((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.RequerimientoMateriales, 0, -1).Count();

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



        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    }




    /// <summary>
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
    /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /// </summary>
    /// <typeparam name="T"></typeparam>


}
