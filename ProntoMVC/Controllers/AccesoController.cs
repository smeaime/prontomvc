using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
//using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Text;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
using System.Reflection;
using System.Configuration;
using Pronto.ERP.Bll;
using System.Data.SqlClient;
// using ProntoMVC.Controllers.Logica;

using System.Web.Security;


using ProntoMVC.Data.Models;
using ProntoMVC.Models;



using StackExchange.Profiling;


namespace ProntoMVC.Controllers
{
    public partial class AccesoController : ProntoBaseController
    {


        /// <summary>
        /// Get Json data for the grid
        /// </summary>
        /// <param name="sidx">Column to osrt on.  Do not change parameter name</param>
        /// <param name="sord">Sort direction.  Do not change parameter name</param>
        /// <param name="page">Current page.  Do not change parameter name</param>
        /// <param name="rows">Number of rows to get.  Do not change parameter name</param>
        /// <returns></returns>
        [HttpPost]
        public virtual ActionResult AccesosGridData(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            var Articulos = db.EmpleadosAccesos.AsQueryable();
            if (_search)
            {
                //if (searchField == "Descripcion") { Articulos = (from a in db.Articulos where a.Descripcion.Contains(searchString) select a).AsQueryable(); }
                //else if (searchField == "Codigo") { Articulos = (from a in db.Articulos where a.Codigo.Contains(searchString) select a).AsQueryable(); }
            }

            int pageSize = rows ?? 20;
            int totalRecords = Articulos.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;
            string sortByColumnName = sidx ?? "Descripcion";
            string sortDirection = sord ?? "desc";

            if (sortByColumnName == "Descripcion")
            {
                //if (sortDirection.Equals("desc"))
                //    Articulos = Articulos.OrderByDescending(a => a.Descripcion);
                //else
                //    Articulos = Articulos.OrderBy(a => a.Descripcion);
            }
            else
            {
                //if ("desc".Equals(sortDirection))
                //    Articulos = Articulos.OrderByDescending(a => a.FechaUltimaModificacion);
                //else


                Articulos = Articulos.OrderBy(a => a.IdEmpleadoAcceso);
            }

            


            var data = Articulos
                //.Include(x => x.empl)
                         
//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToArray();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (
                    from a in data
                    select new jqGridRowJson
                    {
                        id = a.IdEmpleadoAcceso.ToString(),
                        cell = new string[] { 
                            "<a href="+ Url.Action("Edit",new {id = a.IdEmpleadoAcceso} )  +" target='_blank' >Editar</>",
                            "",
                            a.IdEmpleadoAcceso.NullSafeToString(), 
                            //a.Descripcion.NullSafeToString(), 
                            
                            //(a.Rubro ?? new Rubro()).Descripcion.NullSafeToString()   ,
 
                                        }



                    }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }




        public virtual ViewResult Index()
        {

            if (db == null)
            {
                FormsAuthentication.SignOut();
                return View("ElegirBase", "Home");
            }

            var Articulos = db.Articulos
                //.Where(r => r.NumeroArticulo > 0)
                .OrderByDescending(r => r.IdArticulo); // .NumeroArticulo);


            string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
            DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster, "SELECT * FROM BASES");
            // List<string> baselistado = new List<string>();
            List<SelectListItem> baselistado = new List<SelectListItem>();
            foreach (DataRow r in dt.Rows)
            {
                baselistado.Add(new SelectListItem { Text = r["Descripcion"] as string, Value = "" });
            }


            ViewBag.Bases = baselistado; // baselistado; // new SelectList(dt.Rows, "IdBD", "Descripcion"); // StringConnection

            //DDLEmpresas.DataSource = EmpresaManager.GetEmpresasPorUsuario(SC, session(SESSIONPRONTO_UserId))
            //DDLEmpresas.DataTextField = "Descripcion"
            //DDLEmpresas.DataValueField = "Id"


            return View(Articulos.ToList());
        }






        public virtual ActionResult Edit(int id = -1, string nombre = "")
        {


            if (nombre != "")
            {
                id = db.Empleados.Where(x => x.Nombre == nombre || x.UsuarioNT == nombre).Select(x => x.IdEmpleado).FirstOrDefault();
            }

            EmpleadosAcceso defacc;

            string usuario = ViewBag.NombreUsuario;


            ViewBag.EmpleadoEquivalente = EmpleadoEquivalente(id);


            if (!(
                   oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") ||
                oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") ||
                oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "AdminExterno"))
                )
            {
                throw new Exception("No tenés permisos");
                // return RedirectToAction("Index", "MvcMembership/UserAdministration");
            }



            LeerArchivoSecuencial_____EncriptadoPuntoAPP();



            // los nodos se graban en el APP con el mismo nombre que llevan en el treeview? si el nodo está deshabilitado, cómo se graba en el APP?
            // -si está deshabilitado, simplemente NO se incluye en la lista separada por '|'



            Empleado o = new Empleado();

            if (id == -1)
            {
                id = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
            }


            try
            {

                var Usuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).FirstOrDefault();
                // if (Usuario.Administrador != "SI") throw new Exception("Permisos insuficientes");

                //var permisos = (from i in db.EmpleadosAccesos where i.IdEmpleado == IdUsuario select i).ToList();
                //defacc = permisos.Where(x => x.Nodo == "Definicion de accesos").FirstOrDefault();
                //if (defacc.Nivel > 5) throw new Exception("Permisos insuficientes");
            }
            catch (Exception)
            {
                CargarViewBag(o);
                // HandleErrorInfo o = new HandleErrorInfo(  "Permisos insuficientes");
                // return View("Error");
                // throw new Exception("Permisos insuficientes");
            }







            if (id <= 0)
            {

                o = new Empleado();
                // o.EmpleadosAccesos = new ICollection<EmpleadosAcceso>();

                //string connectionString = Generales.sCadenaConexSQL(this.Session["BasePronto"].ToString());
                //o.NumeroArticulo = (int)Pronto.ERP.Bll.ArticuloManager.ProximoNumeroArticuloPorIdCodigoIvaYNumeroDePuntoVenta(connectionString, 1, 6);
                //if (o.NumeroArticulo == -1) o.NumeroArticulo = null;

                inic(ref o);

            }
            else
            {
                o = db.Empleados
                    .Include(x => x.EmpleadosAccesos)
                    .SingleOrDefault(x => x.IdEmpleado == id);


                foreach(EmpleadosAcceso e in o.EmpleadosAccesos)
                {
                    if (!e.Acceso) e.Nivel = 10;
                    
                }

            }
            CargarViewBag(o);





            //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Articulo.Aprobo);
            //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", Articulo.IdSolicito);
            //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", Articulo.IdSector);
            // Session.Add("Articulo", o);
            return View(o);
        }


        // POST: /Articulo/Edit/5
        [HttpPost]
        public virtual ActionResult Edit(Empleado o)
        {

            MiniProfiler profiler = MiniProfiler.Current;

            if (!
                (
                 oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") ||
                oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") ||
                oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "AdminExterno"))
                )
            {
                throw new Exception("No tenés permisos");

            }




    

            try
            {


                if (ViewBag.SuperadminPass != null || this.Session["SuperadminPass"] != null)
                {

                    using (profiler.Step("Llamo a UpdateColecciones"))
                    {
                        UpdateColecciones(ref o, db);
                    }

                }
                else if (o.IdEmpleado <= 0)
                {
                    string usuario = ViewBag.NombreUsuario;
                    o.IdEmpleado = db.Empleados.Where(x => x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
                    // o.IdEmpleado = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
                }


                string erar = "";

                //    Articulo.FechaUltimaModificacion = DateTime.Now;


                if (!Validar(o, ref erar))
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    List<string> errors = new List<string>();
                    errors.Add(erar);
                    return Json(errors);
                }




                if (ModelState.IsValid || true)
                {
                    // Perform Update
                    if (o.IdEmpleado > 0)
                    {

                        using (profiler.Step("Llamo a UpdateColecciones"))
                        {
                            UpdateColecciones(ref o, db);
                        }



                    }
                    //Perform Save
                    else
                    {
                        // db.Empleados.Add(o);




                        //var pv = (from item in db.PuntosVentas
                        //          where item.Letra == Articulo.TipoABC && item.PuntoVenta == Articulo.PuntoVenta
                        //             && item.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Articulo
                        //          select item).SingleOrDefault();

                        //// var pv = db.PuntosVenta.Where(p => p.IdPuntoVenta == Articulo.IdPuntoVenta).SingleOrDefault();
                        //pv.ProximoNumero += 1;

                        //   ClaseMigrar.AsignarNumeroATalonario(SC, myRemito.IdPuntoVenta, myRemito.Numero + 1);

                    }


                    try
                    {
                        if (o.Administrador == "SI")
                        {
                            if (Roles.FindUsersInRole("Administrador", o.Nombre).Count() == 0)
                            {
                                Roles.AddUserToRole(o.Nombre, "Administrador");
                            }
                        }
                        else if (o.Administrador == "NO")
                        {
                            Roles.RemoveUserFromRole(o.Nombre, "Administrador");
                        }

                    }
                    catch (Exception e)
                    {

                        ErrHandler.WriteError(e); //throw;
                    }



                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    //using (Logica l = new Logica())  //shared, extension methods, sarasas
                    // http://stackoverflow.com/questions/511477/vb-net-shared-vs-c-sharp-static-accessibility-differences-why
                    // http://stackoverflow.com/questions/1188224/how-do-i-extend-a-class-with-c-sharp-extension-methods
                    // Singletons are essentially global data - they make your code hard to test (classes get coupled to the Singleton) 
                    // and (if mutable) hard to debug. Avoid them (and often static methods too) when possible. Consider using a DI/IoC Container library instead if you need to
                    //{
                    // Logica l = new Logica();
                    // si usas static, no tenes acceso al context
                    //Logica_ArticuloElectronica(Articulo);
                    //Logica_ActualizarCuentaCorriente(Articulo);
                    //Logica_RegistroContable(Articulo);
                    //Logica_RecuperoDeGastos(Articulo);
                    //Logica_Loguear(Articulo);
                    //Logica_ActualizarRemitos(Articulo);
                    //Logica_ActualizarOrdenesCompra(Articulo);
                    ////////////////////////////////////////////////////////////////////////////////

                    //esta arruinando la tabla empleados
                    db.SaveChanges();

                    using (profiler.Step("Llamo a ResetearProntoAccesos + AddToEmpresa"))
                    {
                        ResetearProntoAccesos();


                        //////////
                        bool bNoExisteComoUsuarioWeb = Membership.GetUser(o.UsuarioNT) == null;
                        if (bNoExisteComoUsuarioWeb)
                        {


                            MembershipCreateStatus createStatus;
                            var u = Membership.CreateUser(o.UsuarioNT, o.UsuarioNT + "!", o.UsuarioNT + "mscalella911@hotmail.com", "pregunta", "respuesta", true, null, out createStatus);


                            string nombrebase = (string)this.Session["BasePronto"]; //cambiar esto para buscar los datos en la base, no en la session

                            // y cómo sé quién lo habilitó?, si ahora no le pido que se loguee...
                            var cc = new Areas.MvcMembership.Controllers.UserAdministrationController();
                            cc.AddToEmpresa(new Guid(u.ProviderUserKey.ToString()), nombrebase);

                            // y qué roles va a tener ese usuario??????
                        }

                    }

                    //}
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////



                    //http://stackoverflow.com/questions/2864972/how-to-redirect-to-a-controller-action-from-a-jsonresult-method-in-asp-net-mvc
                    //return RedirectToAction(( "Index",    "Articulo");
                    //redirectUrl = Url.Action("Index", "Home"), 
                    //isRedirect = true 
                    ViewBag.AlertaEnLayout = "Grabado";
                    return Json(new { Success = 1, IdArticulo = o.IdEmpleado, ex = "" }); //, DetalleArticulos = Articulo.DetalleArticulos
                }
                else
                {
                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "La Articulo es inválida";
                    return Json(res);


                }

                using (profiler.Step("Llamo a GuardarArchivoSecuencial__EncriptadoPuntoAPP"))
                {

                    var c = new ProntoMVC.Areas.MvcMembership.Controllers.UserAdministrationController();
                    // x.VerificarClaveDeRoles
                    //   x.GrabarNuevaClaveDeRoles


                    // revisar la cuestion de la anulacion de nodos, y del exclusivo del superadmin
                    GuardarArchivoSecuencial__EncriptadoPuntoAPP();

                }


            }
            catch (System.Data.Entity.Validation.DbEntityValidationException ex)
            {
                //http://stackoverflow.com/questions/10219864/ef-code-first-how-do-i-see-entityvalidationerrors-property-from-the-nuget-pac
                StringBuilder sb = new StringBuilder();

                foreach (var failure in ex.EntityValidationErrors)
                {
                    sb.AppendFormat("{0} failed validation\n", failure.Entry.Entity.GetType());
                    foreach (var error in failure.ValidationErrors)
                    {
                        sb.AppendFormat("- {0} : {1}", error.PropertyName, error.ErrorMessage);
                        sb.AppendLine();
                    }
                }

                throw new System.Data.Entity.Validation.DbEntityValidationException(
                    "Entity Validation Failed - errors follow:\n" +
                    sb.ToString(), ex
                ); // Add the original exception as the innerException


            }
            catch (Exception ex)
            {
                // If Sucess== 0 then Unable to perform Save/Update Operation and send Exception to View as JSON
                JsonResponse res = new JsonResponse();

                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                //List<string> errors = new List<string>();
                //errors.Add(erar);
                //return Json(errors);

                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);
                res.Message = ex.Message.ToString();
                return Json(res);

                //return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }



        void UpdateColeccionesParaSuperAdmin(ref Empleado o)
        {

            foreach (var dr in o.EmpleadosAccesos)
            {
                string nodo = db.EmpleadosAccesos.Where(c => c.IdEmpleadoAcceso == dr.IdEmpleadoAcceso).Select(c => c.Nodo).SingleOrDefault();
                var accs = db.EmpleadosAccesos.Where(c => c.Nodo == nodo);

                foreach (EmpleadosAcceso acc in accs)
                {
                    acc.Nivel = dr.Nivel;
                }
            }


        }



        public void UpdateColecciones(ref Empleado o, DemoProntoEntities dbcontext)
        {




            if (ViewBag.SuperadminPass != null || this.Session["SuperadminPass"] != null)
            {
                ViewBag.SuperadminPass = null;
                this.Session["SuperadminPass"] = null;
                UpdateColeccionesParaSuperAdmin(ref o);
                return;
            }

            // http://stackoverflow.com/questions/7968598/entity-4-1-updating-an-existing-parent-entity-with-new-child-entities

            var id = o.IdEmpleado;
            var EntidadOriginal = dbcontext.Empleados.Where(p => p.IdEmpleado == id)
                                    .Include(p => p.EmpleadosAccesos)
                                    .SingleOrDefault();
            var EntidadEntry = dbcontext.Entry(EntidadOriginal);
            EntidadEntry.CurrentValues.SetValues(o);



            /////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////
            foreach (var dr in o.EmpleadosAccesos)
            {
                EmpleadosAcceso DetalleEntidadOriginal;
                try
                {
                    DetalleEntidadOriginal = EntidadOriginal.EmpleadosAccesos.Where(c => c.IdEmpleado == id &&
                                                                (
                                                                    (c.IdEmpleadoAcceso == dr.IdEmpleadoAcceso && dr.IdEmpleadoAcceso > 0)
                                                                    ||
                                                                    c.Nodo == dr.Nodo
                                                                )
                                                       ).FirstOrDefault(); // .SingleOrDefault();
                }
                catch (Exception)
                {

                    throw;
                }
                if (DetalleEntidadOriginal != null) // && dr.IdEmpleadoAcceso > 0)
                {
                    //ya existe, solo refresco el nivel
                    if ((dr.Nivel ?? 9) >= 9)
                    {
                        dr.Acceso = false; // le quito el acceso
                        dr.Nivel = 9;
                    }
                    else dr.Acceso = true;

                    var DetalleEntidadEntry = dbcontext.Entry(DetalleEntidadOriginal);
                    DetalleEntidadEntry.Entity.IdEmpleado = id;
                    DetalleEntidadEntry.Entity.Nivel = dr.Nivel;
                    DetalleEntidadEntry.Entity.Acceso = dr.Acceso;
                    // DetalleEntidadEntry.Entity.Nodo = dr.Nodo;
                    //                    DetalleEntidadEntry.CurrentValues.SetValues(dr);

                }
                else
                {
                    //no existe. verificar que no estoy mandando los subitems de agrupamiento
                    if (dr.Nodo != null)
                    {

                        if (!(dr.Nodo.Contains("Agrupad") || dr.Nodo.Contains("RequerimientosPorObra")) || dr.Nodo == "RequerimientosPorObra" || dr.Nodo == "RequerimientosAgrupados" || dr.Nodo == "PedidosAgrupados")
                        {
                            dr.IdEmpleado = o.IdEmpleado;
                            if ((dr.Nivel ?? 9) >= 9)
                            {
                                dr.Acceso = false; // le quito el acceso
                                dr.Nivel = 9;
                            }
                            else dr.Acceso = true;
                            EntidadOriginal.EmpleadosAccesos.Add(dr); // necesito traer la clave en estos casos, que
                            // han de ser los de los menus, que no tienen bien la equivalencia
                            // de su clave con el nodo de EmpleadosAccesos.
                        }
                    }
                }
            }

            foreach (var DetalleEntidadOriginal in EntidadOriginal.EmpleadosAccesos.Where(c => c.IdEmpleadoAcceso != 0).ToList())
            {
                if (!o.EmpleadosAccesos.Any(c => c.IdEmpleadoAcceso == DetalleEntidadOriginal.IdEmpleadoAcceso))
                {
                    // por ahora no borrar items de accesos
                    //    EntidadOriginal.EmpleadosAccesos.Remove(DetalleEntidadOriginal);
                }
            }

            /////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////

            dbcontext.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;



        }


        public void ResetearProntoAccesos()
        {
            string sSQL = "delete empleadosaccesos where ISNUMERIC(nodo)=1 or nodo like \'80-%\' ";


            EntidadManager.ExecDinamico(SCsql(), sSQL);
        }


        private bool Validar(ProntoMVC.Data.Models.Empleado o, ref string sErrorMsg)
        {
            // una opcion es extender el modelo autogenerado, para ensoquetar ahí las validaciones
            // si no, podemos usar una funcion como esta, y devolver los  errores de dos maneras:
            // con ModelState.AddModelError si los devolvemos en una ViewResult,
            // o con un array de strings si es una JsonResult.
            //
            // If you are returning JSON, you cannot use ModelState.
            // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json

            //if ((o.IdCliente ?? 0) <= 0)
            //{
            //    // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
            //    sErrorMsg += "\n" + "Falta el cliente";
            //    // return false;
            //}
            // if ((o.Descripcion ?? "") == "") sErrorMsg += "\n" + "Falta la descripción";
            //// if (o.IdPuntoVenta== null) sErrorMsg += "\n" + "Falta el punto de venta";
            //if (o.IdCodigoIva == null) sErrorMsg += "\n" + "Falta el codigo de IVA";
            //if (o.IdCondicionVenta == null) sErrorMsg += "\n" + "Falta la condicion venta";
            //if (o.IdListaPrecios == null) sErrorMsg += "\n" + "Falta la lista de precios";


            if (sErrorMsg != "") return false;
            return true;

        }



        void inic(ref Empleado o)
        {
            //o.PorcentajeIva1 = 21;                  //  mvarP_IVA1_Tomado
            //o.FechaArticulo = DateTime.Now;

            //Parametros parametros = db.Parametros.Find(1);
            //o.OtrasPercepciones1 = 0;
            //o.OtrasPercepciones1Desc = ((parametros.OtrasPercepciones1 ?? "NO") == "SI") ? parametros.OtrasPercepciones1Desc : "";
            //o.OtrasPercepciones2 = 0;
            //o.OtrasPercepciones2Desc = ((parametros.OtrasPercepciones2 ?? "NO") == "SI") ? parametros.OtrasPercepciones2Desc : "";
            //o.OtrasPercepciones3 = 0;
            //o.OtrasPercepciones3Desc = ((parametros.OtrasPercepciones3 ?? "NO") == "SI") ? parametros.OtrasPercepciones3Desc : "";

            //mvarP_IVA1 = .Fields("Iva1").Value
            //mvarP_IVA2 = .Fields("Iva2").Value
            //mvarPorc_IBrutos_Cap = .Fields("Porc_IBrutos_Cap").Value
            //mvarTope_IBrutos_Cap = .Fields("Tope_IBrutos_Cap").Value
            //mvarPorc_IBrutos_BsAs = .Fields("Porc_IBrutos_BsAs").Value
            //mvarTope_IBrutos_BsAs = .Fields("Tope_IBrutos_BsAs").Value
            //mvarPorc_IBrutos_BsAsM = .Fields("Porc_IBrutos_BsAsM").Value
            //mvarTope_IBrutos_BsAsM = .Fields("Tope_IBrutos_BsAsM").Value
            //mvarDecimales = .Fields("Decimales").Value
            //mvarAclaracionAlPie = .Fields("AclaracionAlPieDeArticulo").Value
            //mvarIdMonedaPesos = .Fields("IdMoneda").Value
            //mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
            //mvarPercepcionIIBB = IIf(IsNull(.Fields("PercepcionIIBB").Value), "NO", .Fields("PercepcionIIBB").Value)
            //mvarOtrasPercepciones1 = IIf(IsNull(.Fields("OtrasPercepciones1").Value), "NO", .Fields("OtrasPercepciones1").Value)
            //mvarOtrasPercepciones1Desc = IIf(IsNull(.Fields("OtrasPercepciones1Desc").Value), "", .Fields("OtrasPercepciones1Desc").Value)
            //mvarOtrasPercepciones2 = IIf(IsNull(.Fields("OtrasPercepciones2").Value), "NO", .Fields("OtrasPercepciones2").Value)
            //mvarOtrasPercepciones2Desc = IIf(IsNull(.Fields("OtrasPercepciones2Desc").Value), "", .Fields("OtrasPercepciones2Desc").Value)
            //mvarOtrasPercepciones3 = IIf(IsNull(.Fields("OtrasPercepciones3").Value), "NO", .Fields("OtrasPercepciones3").Value)
            //mvarOtrasPercepciones3Desc = IIf(IsNull(.Fields("OtrasPercepciones3Desc").Value), "", .Fields("OtrasPercepciones3Desc").Value)
            //mvarConfirmarClausulaDolar = IIf(IsNull(.Fields("ConfirmarClausulaDolar").Value), "NO", .Fields("ConfirmarClausulaDolar").Value)
            //mvarNumeracionUnica = False
            //If .Fields("NumeracionUnica").Value = "SI" Then mvarNumeracionUnica = True
            //gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)


            // db.Cotizaciones_TX_PorFechaMoneda(fecha,IdMoneda)
            //var mvarCotizacion = 4.95; //  mo  Cotizacion(Date, glbIdMonedaDolar);
            //o.CotizacionMoneda = 1;
            ////  o.CotizacionADolarFijo=
            //o.CotizacionDolar = (decimal)mvarCotizacion;


        }





        [HttpPost]
        public virtual ActionResult ArbolConNiveles(int IdUsuario)
        {

            return Json(ArbolConNiveles_Tree(IdUsuario, this.Session["BasePronto"].ToString(), ViewBag.NombreUsuario, db , oStaticMembershipService  ));
        }






        [HttpPost]
        public virtual ActionResult MenuConNiveles(int IdUsuario)
        {
            List<Tablas.Tree> TreeDest = MenuConNiveles_Tree(IdUsuario);

            return Json(TreeDest);


        }




        void CargarViewBag(Empleado o)
        {

            // verificar que pongo el cuarto parametro de SelectList que elige el item del combo 



            ViewBag.IdEmpleado = new SelectList(
                                                    db.Empleados
                                                    .Where(x => x.UsuarioNT != null).OrderBy(x => x.Nombre)
                                                    .Select(x => new { x.IdEmpleado, Nombre = x.Nombre + " - " + x.UsuarioNT })
                                        , "IdEmpleado", "Nombre", o.IdEmpleado);

            if (o.IdEmpleado <= 0) TempData["Alerta"] = "El usuario no se encuentra como empleado en la base Pronto";


            //ViewBag.IdRubro = new SelectList(db.Rubros, "IdRubro", "Descripcion", o.IdRubro);
            //ViewBag.IdSubrubro = new SelectList(db.Subrubros, "IdSubrubro", "Descripcion", o.IdSubrubro);


            //var q = (from i in db.DefinicionArticulos where (i.IdRubro == o.IdRubro && i.IdSubrubro == o.IdSubrubro) orderby i.Orden select i).ToList();
            //ViewBag.Mascara = q;

            //var SC = Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService;
            //SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC);

            //foreach (DefinicionArticulo x in q)
            //{

            //    if (x.TablaCombo == null && x.CampoSiNo != "SI") continue;

            //    DataTable dt;

            //    try
            //    {



            //        if (x.CampoSiNo == "SI" || x.TablaCombo == "SiNo")
            //        {
            //            //ViewData.Add(x.Campo, new SelectList(db.Subrubros, "IdSubrubro", "Descripcion", o.IdSubrubro));

            //            //EntidadManager.ExecDinamico(SC,"SELECT " & .campocombo "," & Titul  & "  FROM " &  .TablaCombo & "")

            //            dt = EntidadManager.GetStoreProcedure(SC, "SiNo_TL");
            //            // ViewData.Add(x.Campo, new SelectList(dt, x.Campo, "Titulo",     o.pr   ));

            //            // entitylist.Select(p => p.GetType().GetProperty("PropertyName").GetValue(p, null));
            //        }
            //        else
            //        {
            //            // ViewData.Add(x.Campo, new SelectList(db.Subrubros, "IdSubrubro", "Descripcion", o.IdSubrubro));
            //            dt = EntidadManager.GetStoreProcedure(SC, x.TablaCombo + "_TL");

            //        }

            //        IEnumerable<DataRow> rows = dt.AsEnumerable();
            //        var sq = (from r in rows select new { id = r[0], texto = r[1] }).ToList();

            //        var valor = o.GetType().GetProperty(x.Campo).GetValue(o, null);
            //        // var lista = new SelectList(rows, x.CampoCombo, "Titulo", valor);
            //        var lista = new SelectList(sq, "id", "texto", valor);
            //        //var lista = new SelectList(rows, valor);


            //        ViewData.Add(x.Campo, lista);


            //    }
            //    catch (Exception ex)
            //    {
            //        //EntidadManager.LogPronto();
            //        //throw;
            //    }


            //    //If .CampoSiNo = "SI" Then
            //    //      'cmbSubrubro.DataSource = EntidadManager.ExecDinamico(SC,"SELECT " & .campocombo "," & Titul  & "  FROM " &  .TablaCombo & "")
            //    //      dt = EntidadManager.GetStoreProcedure(SC, "SiNo_TL")
            //    //  Else
            //    //      dt = EntidadManager.GetStoreProcedure(SC, .TablaCombo & "_TL")
            //    //  End If
            //    //  comboDinamico.DataSource = dt
            //    //  'cmbSubrubro.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, .TablaCombo)
            //    //  comboDinamico.DataTextField = "Titulo"
            //    //  If .TablaCombo = "SiNo" Or .CampoSiNo = "SI" Then
            //    //      comboDinamico.DataValueField = "IdSiNo"
            //    //  Else
            //    //      comboDinamico.DataValueField = .CampoCombo
            //    //  End If
            //}






            //ViewBag.PuntoVenta = new SelectList((from i in db.PuntosVentas
            //                                     where i.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Articulo
            //                                     select new { PuntoVenta = i.PuntoVenta })
            //     http://stackoverflow.com/questions/2135666/databinding-system-string-does-not-contain-a-property-with-the-name-dbmake
            //                                     .Distinct(), "PuntoVenta", "PuntoVenta"); //traer solo el Numero de PuntoVenta, no el Id


            //ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", o.IdObra);
            //ViewBag.IdCliente = new SelectList(db.Clientes, "IdCliente", "RazonSocial", o.IdCliente);
            //ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion", o.IdCodigoIva);
            //ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", o.IdCodigoIva);
            //ViewBag.IdListaPrecios = new SelectList(db.ListasPrecios, "IdListaPrecios", "Descripcion", o.IdListaPrecios);
            //ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            //ViewBag.IdCondicionVenta = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionVenta);
            //ViewBag.IdIBCondicionPorDefecto = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);
            //ViewBag.IdIBCondicionPorDefecto2 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion2);
            //ViewBag.IdIBCondicionPorDefecto3 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion3);

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










        //    Protected Sub btnOk_Click(sender As Object, e As System.EventArgs) Handles btnOk.Click
        //Dim s As String = ViewState("UsuarioModificar")


        //If txtPass.Text <> txtPassConfirmar.Text Then
        //    MsgBoxAjax(Me, "La contraseña es diferente que la confirmación")
        //    Exit Sub
        //End If

        //If txtPass.Text.Length < 7 Then
        //    'If Not Membership.ValidateUser(s, txtPass.Text) Then
        //    ModalPopupExtender1.Show()
        //    MsgBoxAjax(Me, "La contraseña es inválida. Debe tener por lo menos 7 caracteres") ' y uno no alfanumérico")
        //    Exit Sub
        //End If


        //Dim rgx = New Regex("[a-zA-Z0-9 -]")
        //Dim str = rgx.Replace(txtPass.Text, "")
        //If str.Length = 0 Then
        //    'If Not Membership.ValidateUser(s, txtPass.Text) Then
        //    ModalPopupExtender1.Show()
        //    MsgBoxAjax(Me, "La contraseña es inválida. Debe tener por lo menos un carácter no alfanumérico") ' y uno no alfanumérico")
        //    Exit Sub
        //End If


        //    resetearContr(s)
        //End Sub

        string resetearContr(string UserName)
        {
            //Dim membershipUser As MembershipUser
            //'membershipUser = Membership.Providers("SqlMembershipProviderOther").GetUser(UserName, False)
            //membershipUser = Membership.GetUser(UserName, True)
            //If False Then

            //    Dim oldpass = membershipUser.ResetPassword()
            //    membershipUser.ChangePassword(oldpass, "myAwesomePassword") 'obligatorio requiresQuestionAndAnswer = "false" en el membership provider
            //Else
            //    'http://team.desarrollosnea.com.ar/blogs/jfernandez/archive/2009/12/10/asp-net-membership-reset-password-with-ts-sql-por-si-las-moscas-tenerlo-a-mano.aspx
            //    Try
            //        Dim dt = Pronto.ERP.Bll.EntidadManager.ExecDinamico(ConexBDLmaster, "[wResetearPass] '" & UserName & "'," & _c(txtPass.Text))

            //        Try
            //            Dim cuerpo = "Vuelva al sitio e inicie sesión utilizando la siguiente información. Nombre de usuario: " & UserName & " Contraseña: " & txtPass.Text
            //            MandaEmailSimple(membershipUser.Email, "Contraseña", cuerpo, _
            //               ConfigurationManager.AppSettings("SmtpUser"), _
            //               ConfigurationManager.AppSettings("SmtpServer"), _
            //               ConfigurationManager.AppSettings("SmtpUser"), _
            //               ConfigurationManager.AppSettings("SmtpPass"), _
            //                "", _
            //               ConfigurationManager.AppSettings("SmtpPort"), , , )
            //        Catch ex As Exception
            //            ErrHandler.WriteError(ex)
            //        End Try

            //        'MsgBoxAlert("Contraseña cambiada con éxito")
            //        MsgBoxAjax(Me, "Contraseña cambiada con éxito. Se envió un correo de notificación a " & membershipUser.Email)
            //        Rebind()

            //    Catch ex As Exception
            //        ErrHandler.WriteAndRaiseError(ex)
            //        MsgBoxAjax(Me, "La contraseña debe tener al menos 7 caracteres y debe tener un carácter no alfanumérico")
            //        ' MsgBoxAlert(ex.Message)
            //    End Try

            //End If
            return "";
        }









        //Protected Sub btnActualizarBase_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnActualizarBase.Click
        //    BackupMasActualizacionConADONET()
        //End Sub

        //Sub BackupMasActualizacionConADONET()

        //    'Dim a = "sp_configure()"
        //    'Dim a = "RECONFIGURE"
        //    'Dim a = "sp_configure (('xp_cmdshell', 1)"
        //    'Dim a = "RECONFIGURE"
        //    Try

        //        EntidadManager.ExecDinamico(SC, "EXEC sp_configure 'show advanced options', 1")
        //        EntidadManager.ExecDinamico(SC, "RECONFIGURE")
        //        EntidadManager.ExecDinamico(SC, "EXEC sp_configure 'xp_cmdshell', 1")
        //        EntidadManager.ExecDinamico(SC, "RECONFIGURE")

        //        Dim parser = New System.Data.SqlClient.SqlConnectionStringBuilder(Encriptar(HFSC.Value))
        //        Dim servidor As String = parser.DataSource
        //        Dim base As String = parser.InitialCatalog
        //        Dim filescript As String = DirApp() & "\Novedades\Nuevos_SP WEB.sql"


        //        'declare @DBServerName varchar(100)
        //        'declare @DBName  varchar(100)
        //        'declare @FilePathName varchar(100)
        //        'set @DBServerName='MARIANO-PC\SQLEXPRESS'
        //        'set @DBName='wDemoWilliams'
        //        'set @FilePathName='"E:\Backup\BDL\ProntoWeb\Proyectos\Pronto\Novedades\Nuevos_SP WEB.sql"'
        //        ' EXEC(xp_cmdshell)  'sqlcmd -S ' + @DBServerName + ' -d  ' + @DBName + ' -i ' + @FilePathName

        //        'no puedo usar el archivo que se copió en el IIS para referenciarlo desde el SQL!!!!!

        //        Dim sSql = " declare @f varchar(100) " & vbCrLf & _
        //                   " set  @f='""" & filescript & """'" & vbCrLf & _
        //                   " declare @s varchar(300) " & vbCrLf & _
        //                   " set @s='sqlcmd -S ''" & servidor & "'' -d  ''" & base & "'' -i ' + @f " & vbCrLf & _
        //                   "  EXEC xp_cmdshell @s "
        //        ErrHandler.WriteError(sSql)
        //        Dim ret = EntidadManager.ExecDinamico(SC, sSql)


        //        'http://stackoverflow.com/questions/40814/how-do-i-execute-a-large-sql-script-with-go-commands-from-c
        //        '-necesita una version 2008 de sql? no encuentro las referencias para  Microsoft.SqlServer.Management
        //        'Dim fileInfo = New FileInfo(filescript)
        //        'Dim script As String = fileInfo.OpenText().ReadToEnd()
        //        'Dim connection = New System.Data.SqlClient.SqlConnection(Encriptar(HFSC.Value))
        //        'Dim a As Microsoft.SqlServer.Management.Common.ServerConnection
        //        'Dim server = New server(New Microsoft.SqlServer.Management.Common.ServerConnection(connection))
        //        'server.ConnectionContext.ExecuteNonQuery(script)



        //        MsgBoxAjax(Me, "Actualizada con éxito")
        //    Catch ex As Exception
        //        ErrHandler.WriteError(ex)
        //        MsgBoxAjax(Me, "Se produjo un error al actualizar. " & ex.Message)
        //    End Try


        //End Sub


        //Function ExportarScriptConSMO()
        //    'http://msdn.microsoft.com/en-us/library/ms162160(v=sql.90).aspx
        //    'http://stackoverflow.com/questions/3488666/how-to-automate-script-generation-using-smo-in-sql-server

        //    Dim filescript As String = DirApp() & "\Novedades\Nuevos_SP WEB.sql"

        //    Dim filescriptdrops As String = DirApp() & "\Novedades\dev\Nuevos_SP WEB drops.sql"

        //    Try


        //        'SQL Server 2008 - Backup and Restore Databases using SMO

        //        Dim parser = New System.Data.SqlClient.SqlConnectionStringBuilder(Encriptar(HFSC.Value))
        //        Dim servidor As String = parser.DataSource
        //        Dim user As String = parser.UserID
        //        Dim pass = parser.Password

        //        Dim base As String = parser.InitialCatalog


        //        'Dim connection = New Microsoft.SqlServer.Management.Common.ServerConnection(Encriptar(HFSC.Value))
        //        Dim connection = New Microsoft.SqlServer.Management.Common.ServerConnection(servidor, user, pass)

        //        Dim srv = New Server(connection)


        //        '//Reference the AdventureWorks2008R2 database.  
        //        Dim db = srv.Databases(base)

        //        ' http://msdn.microsoft.com/en-us/library/microsoft.sqlserver.management.smo.scriptingoptions.aspx
        //        '//Define a Scripter object and set the required scripting options. 
        //        Dim scrp As Scripter



        //        scrp = New Scripter(srv)



        //        If False Then

        //            Using outfile As StreamWriter = New StreamWriter(filescript, True)



        //                'Iterate through the tables in database and script each one. Display the script.
        //                'Note that the StringCollection type needs the System.Collections.Specialized namespace to be included.
        //                Dim tb As Table
        //                Dim sp As StoredProcedure
        //                Dim smoObjects(1) As Urn
        //                Dim i, total As Long



        //                For Each sp In db.StoredProcedures
        //                    If Left(sp.Name, 1) = "w" Then
        //                        total += 1
        //                    End If
        //                Next
        //                Debug.Print(total)


        //                Dim drop = New ScriptingOptions()
        //                drop.ScriptDrops = True
        //                drop.IncludeIfNotExists = True

        //                If False Then
        //                    For Each sp In db.StoredProcedures
        //                        If Left(sp.Name, 1) = "w" Then
        //                            If sp.IsSystemObject = False Then
        //                                smoObjects = New Urn(0) {}
        //                                smoObjects(0) = sp.Urn

        //                                Dim sc As StringCollection
        //                                sc = scrp.Script(smoObjects)

        //                                'outfile.WriteLine(sc.ToString())

        //                                'Dim st As String
        //                                'For Each st In sc
        //                                '    Console.WriteLine(st)
        //                                '    outfile.WriteLine(st)
        //                                'Next

        //                            End If
        //                            i += 1
        //                            Debug.Print(i)
        //                        End If
        //                    Next

        //                End If


        //                outfile.Close()
        //            End Using

        //        End If


        //        'http://stackoverflow.com/questions/274408/using-smo-to-get-create-script-for-table-defaults

        //        Dim list = New Generic.List(Of Urn)()
        //        Dim dataTable = db.EnumObjects(DatabaseObjectTypes.StoredProcedure) '.Table)
        //        For Each row In dataTable.Rows
        //            If Left(row("Name"), 1) = "w" Then 'And row("IsSystemObject") = False Then
        //                list.Add(New Urn(row("Urn")))
        //            End If
        //        Next

        //        dataTable = db.EnumObjects(DatabaseObjectTypes.View) '.Table)
        //        For Each row In dataTable.Rows
        //            If Left(row("Name"), 1) = "w" Then 'And row("IsSystemObject") = False Then
        //                list.Add(New Urn(row("Urn")))
        //            End If
        //        Next

        //        dataTable = db.EnumObjects(DatabaseObjectTypes.UserDefinedFunction) '.Table)
        //        For Each row In dataTable.Rows
        //            If Left(row("Name"), 1) = "w" Then 'And row("IsSystemObject") = False Then
        //                list.Add(New Urn(row("Urn")))
        //            End If
        //        Next


        //        With scrp
        //            ' scrp.Options.ScriptDrops = True
        //            '    scrp.Options.WithDependencies = False
        //            scrp.Options.ScriptSchema = True
        //            .Options.ScriptData = False
        //            '    scrp.Options.IncludeIfNotExists = False
        //            scrp.Options.IncludeHeaders = True
        //            'scrp.Options.SchemaQualify = True

        //            '    '.Options.SchemaQualifyForeignKeysReferences = True
        //            '    '.Options.NoCollation = True
        //            '    .Options.DriAllConstraints = True
        //            '    scrp.Options.DriAll = True
        //            '    .Options.DriAllKeys = True
        //            '    .Options.DriIndexes = True
        //            '.Options.ClusteredIndexes = True
        //            '.Options.NonClusteredIndexes = True



        //            .Options.ToFileOnly = True
        //            .Options.FileName = filescript

        //            .Script(list.ToArray())


        //            .Options.FileName = filescriptdrops
        //            scrp.Options.ScriptDrops = True
        //            .Script(list.ToArray())
        //        End With

        //    Catch ex As Exception
        //        ErrHandler.WriteAndRaiseError(ex)
        //    End Try

        //    Dim str As String
        //    str &= File.ReadAllText(filescriptdrops)
        //    str &= File.ReadAllText(filescript)

        //    Dim objStreamWriter As StreamWriter
        //    objStreamWriter = File.CreateText(filescript)
        //    objStreamWriter.Write(str)
        //    objStreamWriter.Close()



        //    Dim MyFile1 = New FileInfo(filescript)
        //    Try
        //        Dim nombrearchivo = MyFile1.Name
        //        If Not IsNothing(filescript) Then
        //            Response.ContentType = "application/octet-stream"
        //            Response.AddHeader("Content-Disposition", "attachment; filename=" & nombrearchivo)
        //            'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
        //            'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
        //            'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnNotaCreditoXML)

        //            Response.TransmitFile(filescript)
        //            'Response.BinaryWrite()
        //            'Response.OutputStream


        //            Response.End()
        //        Else
        //            MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
        //        End If
        //    Catch ex As Exception
        //        'MsgBoxAjax(Me, ex.Message)
        //        ErrHandler.WriteError(ex)
        //    End Try
        //End Function



        //Protected Sub btnGenerarScript_Click(sender As Object, e As System.EventArgs) Handles btnGenerarScript.Click
        //    ExportarScriptConSMO()
        //    'MsgBoxAjax(Me, "Script generado")

        //End Sub

        //Protected Sub Button7_Click(sender As Object, e As System.EventArgs) Handles Button7.Click
        //    BackupMasActualizacionConSMO()
        //End Sub



        //Function BackupMasActualizacionConSMO()
        //    'http://msdn.microsoft.com/en-us/library/ms162160(v=sql.90).aspx
        //    'http://stackoverflow.com/questions/3488666/how-to-automate-script-generation-using-smo-in-sql-server


        //    'SQL Server 2008 - Backup and Restore Databases using SMO

        //    Dim parser = New System.Data.SqlClient.SqlConnectionStringBuilder(Encriptar(HFSC.Value))
        //    Dim servidor As String = parser.DataSource
        //    Dim user As String = parser.UserID
        //    Dim pass = parser.Password

        //    Dim base As String = parser.InitialCatalog


        //    'Dim connection = New Microsoft.SqlServer.Management.Common.ServerConnection(Encriptar(HFSC.Value))
        //    Dim connection = New Microsoft.SqlServer.Management.Common.ServerConnection(servidor, user, pass)

        //    Dim srv = New Server(connection)



        //    '//Reference the AdventureWorks2008R2 database.  
        //    Dim db = srv.Databases(base)

        //    Dim tableText As String

        //    Try

        //        Dim nuevtablefile As String = DirApp() & "\Novedades\dev\Nuevas_Tablas Web.sql"
        //        Using FileReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(nuevtablefile)
        //            tableText = FileReader.ReadToEnd
        //        End Using

        //        Dim altertablefile As String = DirApp() & "\Novedades\dev\ALTERTABLE 2011 Modulo WEB.sql"
        //        Using FileReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(altertablefile)
        //            tableText = FileReader.ReadToEnd
        //        End Using

        //        db.ExecuteNonQuery(tableText)
        //    Catch ex As Exception
        //        ErrHandler.WriteError(ex)
        //    End Try



        //    Dim filescript As String = DirApp() & "\Novedades\dev\Nuevos_SP WEB desarrollo.sql"
        //    Using FileReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(filescript)
        //        tableText = FileReader.ReadToEnd
        //    End Using


        //    Try
        //        db.ExecuteNonQuery(tableText)
        //    Catch ex As Exception
        //        ErrHandler.WriteError(ex)
        //        Dim inner As Exception = ex.InnerException
        //        While Not (inner Is Nothing)
        //            MsgBox(inner.Message)
        //            ErrHandler.WriteError(inner.Message)
        //            inner = inner.InnerException
        //        End While

        //        MsgBoxAjax(Me, ex.Message)

        //        Throw
        //        'ex.InnerException
        //        'ex.InnerException.InnerException
        //    End Try

        //    MsgBoxAjax(Me, "exito")

        //End Function



        //Sub EventLog()

        //    Dim el As EventLog = New EventLog()
        //    el.Source = DropDownList1.SelectedItem.Text
        //    gvEventlog.DataSource = el.Entries
        //    gvEventlog.DataBind()

        //End Sub

        //Sub bindCounters()

        //    Dim pcc As List(Of String) = New List(Of String)
        //    For Each item As PerformanceCounterCategory In _
        //    PerformanceCounterCategory.GetCategories()
        //        pcc.Add(item.CategoryName)
        //    Next
        //    pcc.Sort()
        //    pcc.Remove(".NET CLR Data")
        //    DropDownList1.DataSource = pcc
        //    DropDownList1.DataBind()
        //    Dim myPcc As PerformanceCounterCategory
        //    myPcc = New PerformanceCounterCategory(DropDownList1.SelectedItem.Text)
        //    DisplayCounters(myPcc)
        //End Sub

        //Protected Sub DisplayCounters(ByVal pcc As PerformanceCounterCategory)
        //    DisplayInstances(pcc)
        //    Dim myPcc As List(Of String) = New List(Of String)
        //    If DropDownList3.Items.Count > 0 Then
        //        For Each pc As PerformanceCounter In _
        //        pcc.GetCounters(DropDownList3.Items(0).Value)
        //            myPcc.Add(pc.CounterName)
        //        Next
        //    Else
        //        For Each pc As PerformanceCounter In pcc.GetCounters()
        //            myPcc.Add(pc.CounterName)
        //        Next
        //    End If
        //    myPcc.Sort()
        //    DropDownList2.DataSource = myPcc
        //    DropDownList2.DataBind()
        //End Sub

        //Protected Sub DisplayInstances(ByVal pcc As PerformanceCounterCategory)
        //    Dim listPcc As List(Of String) = New List(Of String)
        //    For Each item As String In pcc.GetInstanceNames()
        //        listPcc.Add(item.ToString())
        //    Next
        //    listPcc.Sort()


        //    DropDownList3.DataSource = listPcc
        //    DropDownList3.DataBind()
        //End Sub

        //Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, _
        //ByVal e As System.EventArgs)
        //    Dim pcc As PerformanceCounterCategory
        //    pcc = New PerformanceCounterCategory(DropDownList1.SelectedItem.Text)
        //    DropDownList2.Items.Clear()
        //    DropDownList3.Items.Clear()
        //    DisplayCounters(pcc)
        //End Sub

        //Protected Sub Button9_Click(ByVal sender As Object, _
        //ByVal e As System.EventArgs) Handles Button9.Click
        //    Dim pc As PerformanceCounter
        //    If DropDownList3.Items.Count > 0 Then
        //        pc = New PerformanceCounter(DropDownList1.SelectedItem.Text, _
        //        DropDownList2.SelectedItem.Text, DropDownList3.SelectedItem.Text)
        //    Else
        //        pc = New PerformanceCounter(DropDownList1.SelectedItem.Text, _
        //        DropDownList2.SelectedItem.Text)
        //    End If
        //    Label1.Text = "<b>Latest Value:</b> " & pc.NextValue().ToString()
        //End Sub



        //Sub storesporuso()
        //    '        use(Master)

        //    'SELECT TOP 100 qt.TEXT AS 'SP Name',
        //    'qs.execution_count AS 'Execution Count',
        //    'qs.total_worker_time/qs.execution_count AS 'AvgWorkerTime',
        //    'qs.total_worker_time AS 'TotalWorkerTime',
        //    'qs.total_physical_reads AS 'PhysicalReads',
        //    'qs.creation_time 'CreationTime',
        //    'qs.execution_count/DATEDIFF(Second, qs.creation_time, GETDATE()) AS 'Calls/Second'
        //    'FROM sys.dm_exec_query_stats AS qs
        //    'CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
        //    'WHERE qt.dbid = (SELECT dbid FROM sys.sysdatabases WHERE name = 'Autotrol')
        //    'ORDER BY qs.total_physical_reads DESC
        //End Sub

        //Sub FacturasContraCartaporte()
        //    '        select a.IdFactura,clientes.razonsocial,cantidad,neto,abs(neto-cantidad) as dif 
        //    'from (select idfactura, sum(detallefacturas.Cantidad) as cantidad  from detallefacturas group by idfactura)  A
        //    'join (select idfacturaimputada, sum(NetoFinal/1000)  as neto from cartasdeporte group by idfacturaimputada)  B  on A.idfactura=B.idfacturaimputada
        //    'join facturas on facturas.IdFactura=a.IdFactura
        //    'join clientes on clientes.idcliente=facturas.idcliente
        //    'order by abs(neto-cantidad)  desc

        //End Sub


        //Sub ArreglarVB6()
        //    Dim s = " Object = ""{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0""; ""Controles1013.ocx"""
        //End Sub

    }
}