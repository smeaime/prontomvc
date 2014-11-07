using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Text;
using System.Reflection;
using ProntoMVC.Data.Models; using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Web.Security;

namespace ProntoMVC.Controllers
{
    public partial class CuentaCorrienteController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin") &&
                !Roles.IsUserInRole(Membership.GetUser().UserName, "Administrador")
                ) throw new Exception("No tenés permisos");

            //var presupuestos = db.Presupuestos.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }
        public virtual ViewResult IndexExterno()
        {
            //var presupuestos = db.Presupuestos.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }
        public virtual ViewResult Details(int id)
        {
            Presupuesto presupuesto = db.Presupuestos.Find(id);
            return View(presupuesto);
        }

        public virtual ActionResult Create()
        {
            ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion");
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre");
            ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion");
            ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.Proveedor = "";
            return View();
        }


        void enviarmailAlComprador()
        {

        }


        public virtual ActionResult Edit(int id)
        {

            if (!Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin") &&
               !Roles.IsUserInRole(Membership.GetUser().UserName, "Administrador")
               ) throw new Exception("No tenés permisos");

            if (id == -1)
            {
                Presupuesto presupuesto = new Presupuesto();
                Parametros parametros = db.Parametros.Find(1);
                presupuesto.Numero = parametros.ProximoPresupuesto;
                presupuesto.SubNumero = 1;
                presupuesto.FechaIngreso = DateTime.Today;
                presupuesto.IdMoneda = 1;
                presupuesto.CotizacionMoneda = 1;
                ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion");
                ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", presupuesto.IdMoneda);
                ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion");
                ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                ViewBag.Proveedor = "";
                return View(presupuesto);
            }
            else
            {

                Presupuesto presupuesto = db.Presupuestos.Find(id);
                ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", presupuesto.IdCondicionCompra);
                ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", presupuesto.IdMoneda);
                ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion", presupuesto.IdPlazoEntrega);
                ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre", presupuesto.IdComprador);
                ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", presupuesto.Aprobo);
                ViewBag.Proveedor = db.Proveedores.Find(presupuesto.IdProveedor).RazonSocial;
                Session.Add("Presupuesto", presupuesto);
                return View(presupuesto);
            }
        }


        public virtual ActionResult EditExterno(int id)
        {




            if (id == -1)
            {
                Presupuesto presupuesto = new Presupuesto();
                Parametros parametros = db.Parametros.Find(1);
                presupuesto.Numero = parametros.ProximoPresupuesto;
                presupuesto.SubNumero = 1;
                presupuesto.FechaIngreso = DateTime.Today;
                presupuesto.IdMoneda = 1;
                presupuesto.CotizacionMoneda = 1;
                ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion");
                ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", presupuesto.IdMoneda);
                ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion");
                ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                ViewBag.Proveedor = "";
                return View(presupuesto);
            }
            else
            {
                Presupuesto presupuesto = db.Presupuestos.Find(id);


                int idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)Membership.GetUser().ProviderUserKey));
                if (presupuesto.IdProveedor != idproveedor) throw new Exception("Sólo podes acceder a presupuestos tuyos");


                ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", presupuesto.IdCondicionCompra);
                ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", presupuesto.IdMoneda);
                ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion", presupuesto.IdPlazoEntrega);
                ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre", presupuesto.IdComprador);
                ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", presupuesto.Aprobo);
                ViewBag.Proveedor = db.Proveedores.Find(presupuesto.IdProveedor).RazonSocial;
                Session.Add("Presupuesto", presupuesto);
                return View(presupuesto);
            }
        }
        [HttpPost]
        public virtual ActionResult Edit(Presupuesto presupuesto)
        {

            if (!Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin") &&
               !Roles.IsUserInRole(Membership.GetUser().UserName, "Administrador")
               ) throw new Exception("No tenés permisos");

            if (ModelState.IsValid)
            {
                db.Entry(presupuesto).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", presupuesto.IdCondicionCompra);
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", presupuesto.IdMoneda);
            ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion", presupuesto.IdPlazoEntrega);
            ViewBag.RazonSocial = presupuesto.Proveedor.RazonSocial;
            ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre", presupuesto.IdComprador);
            ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", presupuesto.Aprobo);
            ViewBag.Proveedor = db.Proveedores.Find(presupuesto.IdProveedor).RazonSocial;
            return View(presupuesto);
        }

        public virtual ActionResult Delete(int id)
        {
            Presupuesto presupuesto = db.Presupuestos.Find(id);
            return View(presupuesto);
        }

        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Presupuesto presupuesto = db.Presupuestos.Find(id);
            db.Presupuestos.Remove(presupuesto);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult Presupuestos(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Presupuestos.AsQueryable();
            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                Entidad = (from a in Entidad where a.FechaIngreso >= FechaDesde && a.FechaIngreso <= FechaHasta select a).AsQueryable();
            }
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numero":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaingreso":
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

            var Entidad1 = (from a in Entidad select new { IdPresupuesto = a.IdPresupuesto }).Where(campo);

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdPresupuesto = a.IdPresupuesto,
                            Numero = a.Numero,
                            Orden = a.SubNumero,
                            FechaIngreso = a.FechaIngreso,
                            Proveedor = a.Proveedor.RazonSocial,
                            Validez = a.Validez,
                            Bonificacion = a.Bonificacion,
                            PorcentajeIva1 = a.PorcentajeIva1,
                            Moneda = a.Moneda.Abreviatura,
                            Subtotal = (a.ImporteTotal - a.ImporteIva1 + a.ImporteBonificacion),
                            ImporteBonificacion = a.ImporteBonificacion,
                            ImporteIva1 = a.ImporteIva1,
                            ImporteTotal = a.ImporteTotal,
                            PlazoEntrega = a.PlazosEntrega.Descripcion,
                            CondicionCompra = a.Condiciones_Compra.Descripcion,
                            Garantia = a.Garantia,
                            LugarEntrega = a.LugarEntrega,
                            Comprador = a.Comprador.Nombre,
                            Aprobo = a.AproboPresupuesto.Nombre,
                            Referencia = a.Referencia,
                            Detalle = a.Detalle,
                            Contacto = a.Contacto,
                            Observaciones = a.Observaciones,
                            a.IdProveedor
                        }).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdPresupuesto.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdPresupuesto} ) + " target='' >Editar</>" 
								 +"|"+"<a href=../Presupuesto/Edit/" + a.IdPresupuesto + "?code=1" + ">Detalles</a> ",
                                a.IdPresupuesto.ToString(), 
                                a.Numero.ToString(), 
                                a.Orden.ToString(), 
                                a.FechaIngreso.ToString(),
                                a.Proveedor,
                                a.Validez,
                                a.Bonificacion.ToString(),
                                a.PorcentajeIva1.ToString(),
                                a.Moneda,
                                a.Subtotal.ToString(),
                                a.ImporteBonificacion.ToString(),
                                a.ImporteIva1.ToString(),
                                a.ImporteTotal.ToString(),
                                a.PlazoEntrega,
                                a.CondicionCompra,
                                a.Garantia,
                                a.LugarEntrega,
                                a.Comprador,
                                a.Aprobo,
                                a.Referencia,
                                a.Detalle,
                                a.Contacto,
                                a.Observaciones,
                                a.IdProveedor.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }




        public virtual ActionResult CuentaCorrienteAcreedorPendiente(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 50;
            int currentPage = page ?? 1;

            int idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)Membership.GetUser().ProviderUserKey));




            //var Entidad = db.CuentasCorrientesAcreedores.AsQueryable();
            //Entidad = Entidad.Where(p => p.IdProveedor == idproveedor).AsQueryable();

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var pendiente = "S"; //hay que usar S para traer solo lo pendiente
            if (true)
            {
                idproveedor = 2;
                pendiente = "N"; // "N"
            }
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC,
                                                    "CtasCtesA_TXPorTrs", idproveedor, -1, DateTime.Now, null, null, pendiente);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();




            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                // Entidad = (from a in Entidad where a.FechaIngreso >= FechaDesde && a.FechaIngreso <= FechaHasta select a).AsQueryable();
            }
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numero":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaingreso":
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

            // var Entidad1 = (from a in Entidad select new { IdPresupuesto = a.IdCtaCte }).Where(campo);

            int totalRecords = Entidad.Count();  // Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);



            var data = (from a in Entidad
                        select new
                        {
                            //                          a.IdCtaCte,  
                            //Numero=a.IdImputacion,

                            IdCtaCte = a[0],
                            IdImputacion = (a[1].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[1].NullSafeToString()),
                            a2 = a[2],
                            a3 = a[3],
                            a4 = a[4],
                            Numero = a[5],
                            a6 = a[6],
                            fecha = a[7],
                            a8 = a[8],
                            a9 = a[9],
                            a10 = a[10],
                            a11 = a[11],
                            a12 = a[12],
                            a13 = a[13],
                            a14 = a[14],
                            Cabeza = a[15],
                            a16 = a[16],
                            a17 = a[17]

                            //Null as [Comp.],  
                            //Null as [IdTipoComp],  
                            //Null as [IdComprobante],  
                            //Null as [Numero],  
                            //Null as [Ref.],  
                            //Null as [Fecha],  
                            //Null as [Fecha vto.],  
                            //Null as [Imp.orig.],  
                            //Null as [Saldo Comp.],  
                            //#Auxiliar2.Saldo as [SaldoTrs],  
                            //Null as [Fecha cmp.],  
                            //Null as [IdImpu],  
                            //Null as [Saldo],  
                            //'9' as [Cabeza],  
                            //Null as [Mon.origen],  
                            //Null as [Observaciones],  
                            //Null as [IdProveedor],  
                            //0 as [IdAux1],  
                            //Null as [Pedidos],  

                        })
                //.Where(campo)
                //.OrderBy(sidx + " " + sord)
                             .OrderBy(s => s.IdImputacion).ThenBy(s => s.Cabeza).ThenBy(s => s.fecha).ThenBy(s => s.Numero)  //ORDER by [IdImputacion], [Cabeza], [Fecha], [Numero]  
                        .Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdCtaCte.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("EditExterno",new {id = a.IdCtaCte} ) + " target='' >Editar</>" 
                                 +"|"+"<a href=../Presupuesto/EditExterno/" + a.IdCtaCte + "?code=1" + ">Detalles</a> ",

                                      
                                 a.IdCtaCte.ToString(),
                                 a.IdImputacion.ToString(),
                                 a.a2.ToString(),
                                 a.a3.ToString(),
                                 a.a4.ToString(),
                                 a.Numero.ToString(),
                                 a.a6.ToString(),
                                 a.fecha.ToString(),
                                 a.a8.ToString(),
                                 a.a9.ToString(),
                                 a.a10.ToString(),
                                 a.a11.ToString(),
                                 a.a12.ToString(),
                                 a.a13.ToString(),
                                 a.a14.ToString(),
                                 a.Cabeza.ToString(),
                                 a.a16.ToString(),
                                 a.a17.ToString()
                              //a.IdPresupuesto.ToString(), 
                                //a.Numero.ToString(), 
                                //a.Orden.ToString(), 
                                //a.FechaIngreso.ToString(),
                                //a.Proveedor,
                                //a.Validez,
                                //a.Bonificacion.ToString(),
                                //a.PorcentajeIva1.ToString(),
                                //a.Moneda,
                                //a.Subtotal.ToString(),
                                //a.ImporteBonificacion.ToString(),
                                //a.ImporteIva1.ToString(),
                                //a.ImporteTotal.ToString(),
                                //a.PlazoEntrega,
                                //a.CondicionCompra,
                                //a.Garantia,
                                //a.LugarEntrega,
                                //a.Comprador,
                                //a.Aprobo,
                                //a.Referencia,
                                //a.Detalle,
                                //a.Contacto,
                                //a.Observaciones
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        public virtual ActionResult DetPresupuestos(string sidx, string sord, int? page, int? rows, int? IdPresupuesto)
        {
            int IdPresupuesto1 = IdPresupuesto ?? 0;
            var DetEntidad = db.DetallePresupuestos.Where(p => p.IdPresupuesto == IdPresupuesto1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select new
                        {
                            a.IdDetallePresupuesto,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.NumeroItem,
                            a.DetalleRequerimiento.Requerimientos.Obra.NumeroObra,
                            a.Cantidad,
                            a.Unidad.Abreviatura,
                            a.Articulo.Codigo,
                            a.Articulo.Descripcion,
                            a.Precio,
                            a.PorcentajeBonificacion,
                            a.ImporteBonificacion,
                            a.PorcentajeIva,
                            a.ImporteIva,
                            a.ImporteTotalItem,
                            a.FechaEntrega,
                            a.Observaciones,
                            a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            NumeroItemRM = a.DetalleRequerimiento.NumeroItem,
                            a.Adjunto,
                            a.ArchivoAdjunto1,
                            a.ArchivoAdjunto2,
                            a.ArchivoAdjunto3
                        }).OrderBy(p => p.NumeroItem).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetallePresupuesto.ToString(),
                            cell = new string[] { 
                                string.Empty, 
                                a.IdDetallePresupuesto.ToString(), 
                                a.IdArticulo.ToString(), 
                                a.IdUnidad.ToString(),
                                a.NumeroItem.ToString(), 
                                a.NumeroObra,
                                a.Cantidad.ToString(),
                                a.Abreviatura,
                                a.Codigo,
                                a.Descripcion,
                                a.Precio.ToString(), 
                                a.PorcentajeBonificacion.ToString(), 
                                a.ImporteBonificacion.ToString(), 
                                a.PorcentajeIva.ToString(), 
                                a.ImporteIva.ToString(), 
                                a.ImporteTotalItem.ToString(), 
                                a.FechaEntrega.ToString(),
                                a.Observaciones,
                                a.NumeroRequerimiento.ToString(),
                                a.NumeroItemRM.ToString(),
                                a.ArchivoAdjunto1}
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult DetPresupuestosSinFormato(int IdPresupuesto)
        {
            var Det = db.DetallePresupuestos.Where(p => p.IdPresupuesto == IdPresupuesto).AsQueryable();

            var data = (from a in Det
                        select new
                        {
                            a.IdDetallePresupuesto,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdDetalleRequerimiento,
                            a.NumeroItem,
                            a.DetalleRequerimiento.Requerimientos.Obra.NumeroObra,
                            a.Cantidad,
                            a.Unidad.Abreviatura,
                            a.Articulo.Codigo,
                            a.Articulo.Descripcion,
                            a.FechaEntrega,
                            a.Observaciones,
                            a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            NumeroItemRM = a.DetalleRequerimiento.NumeroItem,
                            a.Adjunto,
                            a.ArchivoAdjunto1,
                            a.ArchivoAdjunto2,
                            a.ArchivoAdjunto3
                        }).OrderBy(p => p.NumeroItem).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdRequerimiento, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
        {
            switch (oper)
            {
                case "add": //Validate Input ; Add Method
                    break;
                case "edit":  //Validate Input ; Edit Method
                    break;
                case "del": //Validate Input ; Delete Method
                    break;
                default: break;
            }

        }


        /*
                public ViewResult ActivarUsuarioYContacto(int idpresupuesto)
                {

                    var Presupuesto = db.Presupuestos.Where(x => x.IdPresupuesto == idpresupuesto).FirstOrDefault();
                    var Proveedor = db.Proveedores.Where(x => x.IdProveedor == Presupuesto.IdProveedor).FirstOrDefault();

                    var cAcc = new ProntoMVC.Controllers.AccountController();

                    var usuarioNuevo = new RegisterModel();
                    usuarioNuevo.UserName = Proveedor.Cuit;
                    usuarioNuevo.Password = Proveedor.Cuit + "!";
                    usuarioNuevo.ConfirmPassword = Proveedor.Cuit + "!";
                    usuarioNuevo.Email = Proveedor.Email ?? "mscalella911@gmail.com";
                    usuarioNuevo.Grupo = Proveedor.Cuit;
                    try
                    {
                        cAcc.Register(usuarioNuevo);
                    }
                    catch (Exception)
                    {

                        //throw;
                    }

                    try
                    {
                        Roles.AddUserToRole(usuarioNuevo.UserName, "AdminExterno");
                    }
                    catch (Exception)
                    {

                        //throw;
                    }
                    try
                    {
                        Roles.AddUserToRole(usuarioNuevo.UserName, "Externo");
                    }
                    catch (Exception)
                    {

                        //throw;
                    }
                    try
                    {
                        Roles.AddUserToRole(usuarioNuevo.UserName, "ExternoCuentaCorrienteProveedor");
                    }
                    catch (Exception)
                    {

                        //throw;
                    }

                    try
                    {
                        Roles.AddUserToRole(usuarioNuevo.UserName, "ExternoOrdenesPagoListas");
                    }
                    catch (Exception)
                    {

                        //throw;
                    }





                    cAcc.Verificar(Membership.GetUser(usuarioNuevo.UserName).ProviderUserKey.ToString());

                    Generales.MailAlUsuarioConLaPasswordYElDominio(usuarioNuevo.UserName, usuarioNuevo.Password, usuarioNuevo.Email);

                    // tendria que usar createuser y ahi tendria que mandar en el mail la contraseña...



                    var usuarioNuevo2 = new RegisterModel();
                    if ((Presupuesto.Contacto ?? "") != "")
                    {

                        usuarioNuevo2.UserName = Presupuesto.Contacto.Replace("Sr.", "").Replace("Sra.", "").Replace(".", "").Replace(" ", "");
                        System.Text.RegularExpressions.Regex rgx = new System.Text.RegularExpressions.Regex("[^a-zA-Z0-9 -]");
                        usuarioNuevo2.UserName = rgx.Replace(usuarioNuevo2.UserName, "");
                        usuarioNuevo2.Password = usuarioNuevo2.UserName + "!";
                        usuarioNuevo2.ConfirmPassword = usuarioNuevo2.UserName + "!";
                        usuarioNuevo2.Email = usuarioNuevo2.UserName + Proveedor.Email ?? "mscalella911@hotmail.com";
                        usuarioNuevo2.Grupo = Proveedor.Cuit;
                        cAcc.Register(usuarioNuevo2);

                        cAcc.Verificar(Membership.GetUser(usuarioNuevo2.UserName).ProviderUserKey.ToString());

                        Generales.MailAlUsuarioConLaPasswordYElDominio(usuarioNuevo2.UserName, usuarioNuevo2.Password, usuarioNuevo2.Email);
                    }



                    TempData["Alerta"] = "Alta automática de usuarios: " + usuarioNuevo.UserName + " " + usuarioNuevo2.UserName;
                    return View("Index");
                }
                */
        public string BuscarOrden(int Numero)
        {
            var Presupuestos = db.Presupuestos.Where(x => x.Numero == Numero).AsQueryable();
            var data = (from x in Presupuestos select new { x.SubNumero }).OrderByDescending(p => p.SubNumero).FirstOrDefault();
            if (data != null)
                return data.SubNumero.ToString();
            else
                return "1";

        }

        protected override void Dispose(bool disposing)
        {
            if (db != null) db.Dispose();
            base.Dispose(disposing);
        }
    }
}