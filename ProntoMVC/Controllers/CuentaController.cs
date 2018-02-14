using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;
using Pronto.ERP.Bll;
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Collections;

namespace ProntoMVC.Controllers
{
    public partial class CuentaController : ProntoBaseController
    {

        public virtual ViewResult Index()
        {

            if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
                     !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "FondosFijos")
                ) throw new Exception("No tenés permisos");

            //var ComprobantesProveedores = db.ComprobantesProveedor.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }

        public virtual ViewResult IndexFF()
        {

            if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
                     !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "FondosFijos")
                ) throw new Exception("No tenés permisos");

            //var ComprobantesProveedores = db.ComprobantesProveedor.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }

        public virtual JsonResult GetCuentasAutocomplete(string term)
        {
            // http://stackoverflow.com/questions/444798/case-insensitive-containsstring

            var ci = new System.Globalization.CultureInfo("en-US");

            var filtereditems = (from item in db.Cuentas
                                 where ((
                                 (item.Descripcion + " " + SqlFunctions.StringConvert((double)(item.Codigo ?? 0))).StartsWith(term))
                                     && item.IdTipoCuenta == 2  // las idtipocuenta 2 son las imputables, las otras son las madre o titulos
                                     && (item.IdObra ?? 0) == 0 
                                     // && item.Descripcion.Trim().Length > 0
                                     )
                                 orderby item.Descripcion
                                 select new
                                 {
                                     id = item.IdCuenta,
                                     codigo = item.Codigo,
                                     value = item.Descripcion + " " + SqlFunctions.StringConvert((double)(item.Codigo ?? 0)),
                                     title = item.Descripcion + " " + SqlFunctions.StringConvert((double)(item.Codigo ?? 0)),
                                     Descripcion = item.Descripcion,
                                     NumeroRendicionFF = item.NumeroAuxiliar ?? 1,
                                     IdObra = item.IdObra ?? 0,
                                     IdCuentaGasto = item.IdCuentaGasto ?? 0,
                                     IdTipoCuentaGrupo = item.IdTipoCuentaGrupo ?? 0
                                 }).Take(20).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCuentasGastoAutocomplete(string term, int obra = 0)
        {
            // http://stackoverflow.com/questions/444798/case-insensitive-containsstring

            var ci = new System.Globalization.CultureInfo("en-US");


            var filtereditems = (from item in db.CuentasGastos
                                 join cu in db.Cuentas on item.IdCuentaGasto equals cu.IdCuentaGasto
                                 where ((

                                 (item.Descripcion).StartsWith(term)
                                     //(item.Descripcion + " " + SqlFunctions.StringConvert((double)(cu.Codigo ?? 0))).StartsWith(term)

                                     //       || SqlFunctions.StringConvert((double)(item.Codigo ?? 0)).StartsWith(term)
                                         )
                                     && (cu.IdTipoCuenta == 2 || cu.IdTipoCuenta == 4)
                                     // && item.Descripcion.Trim().Length > 0

                                     && (obra == 0 || cu.IdObra == obra)
                                     )
                                 orderby item.Descripcion
                                 select new
                                 {
                                     id = cu.IdCuenta,
                                     codigo = SqlFunctions.StringConvert((double)(cu.Codigo ?? 0)).Trim(), // me estaba agregando espacios en blanco http://stackoverflow.com/questions/6158706/sqlfunctions-stringconvert-unnecessary-padding-added
                                     value = item.Descripcion // + " " + SqlFunctions.StringConvert((double)(cu.Codigo ?? 0)),
                                     ,
                                     title = item.Descripcion // + " " + SqlFunctions.StringConvert((double)(cu.Codigo ?? 0))

                                     ,
                                     idcuentagasto = cu.IdCuenta

                                 }).Take(20).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCodigosCuentasAutocomplete(string term)
        {
            int term2 = Generales.Val(term);

            var q = (from item in db.Cuentas
                     where (item.Codigo == term2)
                     orderby item.Codigo
                     select new
                     {
                         id = item.IdCuenta,
                         value = item.Descripcion + " " + item.Codigo.ToString(),
                         codigo = item.Codigo,
                         title = item.Descripcion
                     }).Take(10).ToList();

            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCodigosCuentasAutocomplete2(string term)
        {
            int term2 = Generales.Val(term);

            var q = (from item in db.Cuentas
                     where (item.Codigo == term2)
                     orderby item.Codigo
                     select new
                     {
                         id = item.IdCuenta,
                         value = SqlFunctions.StringConvert((double)(item.Codigo ?? 0)) + " " + item.Descripcion,
                         codigo = item.Codigo,
                         title = item.Descripcion
                     }).Take(10).ToList();

            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCodigosCuentasGastoAutocomplete2(string term, int obra = 0)
        {
            int term2 = Generales.Val(term);


            var q = (from item in db.CuentasGastos
                     join cu in db.Cuentas on item.IdCuentaGasto equals cu.IdCuentaGasto
                     where (cu.Codigo == term2)
                        && (cu.IdTipoCuenta == 2 || cu.IdTipoCuenta == 4)
                        && (obra == 0 || cu.IdObra == obra)
                     orderby item.Codigo
                     select new
                     {
                         id = cu.IdCuenta,
                         value = cu.Codigo, // SqlFunctions.StringConvert((double)(cu.Codigo ?? 0)) + " " + item.Descripcion,
                         codigo = cu.Codigo,
                         title = item.Descripcion,
                         idcuentagasto = cu.IdCuenta
                     }).Take(10).ToList();

            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCuentasFFAutocomplete(string term)
        {
            Parametros parametros = db.Parametros.Find(1);
            int? i = parametros.IdTipoCuentaGrupoFF;

            var ci = new System.Globalization.CultureInfo("en-US");

            var filtereditems = (from item in db.Cuentas
                                 where ((
                                 (item.Descripcion + " " + SqlFunctions.StringConvert((double)(item.Codigo ?? 0))).StartsWith(term)

                                     //       || SqlFunctions.StringConvert((double)(item.Codigo ?? 0)).StartsWith(term)
                                         )
                                     && item.IdTipoCuentaGrupo == i
                                     // && item.Descripcion.Trim().Length > 0
                                     )
                                 orderby item.Descripcion
                                 select new
                                 {
                                     id = item.IdCuenta,
                                     codigo = item.Codigo,
                                     value = item.Descripcion + " " + SqlFunctions.StringConvert((double)(item.Codigo ?? 0)),
                                     title = item.Descripcion + " " + SqlFunctions.StringConvert((double)(item.Codigo ?? 0))


                                     ,
                                     NumeroRendicionFF = item.NumeroAuxiliar ?? 1


                                 }).Take(20).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCuentasAutocomplete2(string term)
        {
            var idCuentaGrupo = 2;

            var s = "SELECT  TOP 100  IdCuenta,Descripcion,Codigo " +
                    "FROM Cuentas " +
                    "WHERE Descripcion + ' ' + Convert(varchar,Codigo) LIKE '" + term + "%' AND IdTipoCuentaGrupo=" + idCuentaGrupo;

            string sc = "";
            var lista = EntidadManager.ExecDinamico(sc, s);

            foreach (DataRow cuenta in lista.Rows)
            {
                //var cod = cuenta.Item("IdCuenta") // & "^" & proveedor.Item("Cuit");
                //var texto = cuenta.Item("Descripcion") + " " + cuenta.Item("Codigo");
                //items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(texto, cod));
            }

            return null;
        }

        public virtual JsonResult GetCuentasAutocomplete3(string term)
        {
            // 'podria llamar directamente un storeproc....
            var sTabla = "Articulos";
            var sColumnaDescripcion = "Descripcion";
            var sColumnaCodigo = "NumeroInventario";

            //   'TODO:
            //  'Articulos_TX_ParaMantenimiento_ParaCombo es el store

            var s = "SELECT TOP 500 IdArticulo,  " +
                    "           isnull(" + sColumnaCodigo + ",'') COLLATE Modern_Spanish_ci_as + ' ' + " +
                    "           isnull(" + sColumnaDescripcion + ",'') + '' COLLATE Modern_Spanish_ci_as as Descripcion   " +
                    " FROM Articulos " +
                    " WHERE " +
                    "			" + sColumnaDescripcion + " like '%[^A-z^0-9]' + '" + term + "' + '%' " +
                    "        OR " + sColumnaDescripcion + " like  '" + term + "' + '%'  " +
                    "        OR " + sColumnaCodigo + " like  '" + term + "' + '%'  ";

            string sc = "";
            var articulolist = EntidadManager.ExecDinamico(sc, s);

            return null;
        }

        public virtual JsonResult TraerUna(int IdCuenta)
        {
            var q = (from a in db.Cuentas
                     from b in db.TiposCuentaGrupos.Where(o => o.IdTipoCuentaGrupo == a.IdTipoCuentaGrupo).DefaultIfEmpty()
                     where (a.IdCuenta == IdCuenta)
                     select new
                     {
                         IdCuenta = a.IdCuenta,
                         codigo = a.Codigo,
                         Descripcion = a.Descripcion + " " + a.Codigo.ToString(),
                         EsCajaBanco = b != null ? b.EsCajaBanco : "",
                         IdObra = a.IdObra ?? 0,
                         IdCuentaGasto = a.IdCuentaGasto ?? 0,
                         IdTipoCuentaGrupo = a.IdTipoCuentaGrupo ?? 0,
                         NumeroAuxiliar = a.NumeroAuxiliar ?? 0
                     }).ToList();

            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Cuentas(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString,
                                           string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            int totalRecords = 0;
            int totalPages = 0;


            var Req = db.Cuentas.AsQueryable();
            //  Req = Req.Where(r => r.Cumplido == null || (r.Cumplido != "AN" && r.Cumplido != "SI")).AsQueryable();

            if (IdObra != string.Empty)
            {
                int IdObra1 = Convert.ToInt32(IdObra);
                Req = (from a in Req where a.IdObra == IdObra1 select a).AsQueryable();
            }
            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                //        Req = (from a in Req where a.FechaRequerimiento >= FechaDesde && a.FechaRequerimiento <= FechaHasta select a).AsQueryable();
            }
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numerorequerimiento":
                        if (searchString != "")
                        {
                            campo = String.Format("{0} = {1}", searchField, Generales.Val(searchString));
                        }
                        else
                        {
                            campo = "true";
                        }
                        break;
                    case "fecharequerimiento":
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

            try
            {

                var Req1 = from a in Req.Where(campo) select a.IdCuenta;

                totalRecords = Req1.Count();
                totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            }
            catch (Exception)
            {

            }

            var data = (from a in Req
                        select a).Where(campo).OrderBy(sidx + " " + sord)
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
                            id = a.IdCuenta.ToString(),
                            cell = new string[] { 
                            "<a href="+ Url.Action("Edit",new {id = a.IdCuenta} ) + " target='' >Editar</>" ,
							"<a href="+ Url.Action("Imprimir",new {id = a.IdCuenta} )  +">Imprimir</>" ,
                            a.IdCuenta.ToString(), 
                            a.Descripcion.NullSafeToString(),
                            a.Codigo.NullSafeToString(),
                            a.IdTipoCuenta==null ? "" :  db.TiposCuentas.Find(a.IdTipoCuenta).Descripcion,  
                            a.Jerarquia.NullSafeToString(),  
                            a.IdRubroContable==null  ? "" :  db.RubrosContables.Find(a.IdRubroContable).Descripcion,  
                            a.IdTipoCuentaGrupo==null  ? "" :  db.TiposCuentaGrupos.Find(a.IdTipoCuentaGrupo).Descripcion,  
                            a.IdObra==null ? "" :  db.Obras.Find(a.IdObra).Descripcion,  
                            a.AjustaPorInflacion .NullSafeToString(),
                            a.CodigoSecundario   .NullSafeToString(),
                            a.IdCuentaGasto.NullSafeToString(),
                            a.IdObra.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Cuentas_DynamicGridData (string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            string campo = String.Empty;
            int pageSize = rows; // ?? 20;
            int currentPage = page; // ?? 1;

            int totalPages = 0;


            var Req = db.Cuentas.AsQueryable();
            //  Req = Req.Where(r => r.Cumplido == null || (r.Cumplido != "AN" && r.Cumplido != "SI")).AsQueryable();


            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.Cuenta>
                                ("",
                                sidx, sord, page, rows, _search, filters, db, ref totalRecords
                                 );
            //DetalleRequerimientos.DetallePedidos, DetalleRequerimientos.DetallePresupuestos
            //"Obra,DetalleRequerimientos.DetallePedidos.Pedido,DetalleRequerimientos.DetallePresupuestos.Presupuesto"
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            try
            {
                //var Req1 = from a in Req.Where(campo) select a.IdCuenta;
                // totalRecords = Req1.Count();
                totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            }
            catch (Exception)
            {

            }

            var data = (
                        from a in pagedQuery
                        from b in db.RubrosContables.Where(o => o.IdRubroContable == a.IdRubroContable).DefaultIfEmpty()
                        from c in db.RubrosContables.Where(o => o.IdRubroContable == a.IdRubroFinanciero).DefaultIfEmpty()
                        from d in db.TiposCuentaGrupos.Where(o => o.IdTipoCuentaGrupo == a.IdTipoCuentaGrupo).DefaultIfEmpty()
                        select new
                        {
                            a.IdCuenta,
                            a.IdCuentaGasto,
                            a.IdObra,
                            a.Descripcion,
                            a.Codigo,
                            TipoCuenta = a.TiposCuenta.Descripcion,
                            a.Jerarquia,
                            RubroContable = b.Descripcion != null ? b.Descripcion : "",
                            RubroFinanciero = c.Descripcion != null ? c.Descripcion : "",
                            TipoCuentaGrupo = d.Descripcion != null ? d.Descripcion : "",
                            CuentaGasto = a.CuentasGasto.Descripcion,
                            Obra = a.Obra.Descripcion,
                            a.AjustaPorInflacion,
                            a.CodigoSecundario
                        }).AsQueryable();

            var data1 = (from a in data select a).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data1
                        select new jqGridRowJson
                        {
                            id = a.IdCuenta.ToString(),
                            cell = new string[] { 
                            "<a href="+ Url.Action("Edit",new {id = a.IdCuenta} ) + " target='' >Editar</>" ,
							"<a href="+ Url.Action("Imprimir",new {id = a.IdCuenta} )  +">Imprimir</>" ,
                            a.IdCuenta.ToString(), 
                            a.IdCuentaGasto.ToString(), 
                            a.IdObra.ToString(), 
                            new String('.',  (a.Jerarquia==null ? 0 : a.Jerarquia.NullSafeToString().Split('.').ToArray().Where(x=> Generales.Val(x) >0).Count() -1) *5 )  +  a.Descripcion.NullSafeToString(),
                            a.Codigo.NullSafeToString(),
                            a.TipoCuenta.NullSafeToString(),
                            a.Jerarquia.NullSafeToString(),  
                            a.RubroContable.NullSafeToString(),  
                            a.RubroFinanciero.NullSafeToString(),  
                            a.TipoCuentaGrupo.NullSafeToString(),  
                            a.CuentaGasto.NullSafeToString(),  
                            a.Obra.NullSafeToString(),  
                            a.AjustaPorInflacion.NullSafeToString(),
                            a.CodigoSecundario.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetCambios(string sidx, string sord, int? page, int? rows, int? Id)
        {
            int IdCuenta1 = Id ?? 0;
            var DetEntidad = db.DetalleCuentas.Where(p => p.IdCuenta == IdCuenta1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select new
                        {
                            a.IdDetalleCuenta,
                            a.CodigoAnterior,
                            a.NombreAnterior,
                            a.FechaCambio,
                        }).OrderBy(p => p.IdDetalleCuenta)
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
                            id = a.IdDetalleCuenta.ToString(),
                            cell = new string[] { 
                                string.Empty, // guarda con este espacio vacio
                                a.IdDetalleCuenta.ToString(),
                                a.CodigoAnterior.NullSafeToString(),
                                a.NombreAnterior.NullSafeToString(),
                                a.FechaCambio.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdArticulo, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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

        public virtual ActionResult GetCuentas(int? Texto)
        {
            int Texto1 = Texto ?? 0;
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            if (Texto1 == 0)
            {
                foreach (Cuenta u in db.Cuentas.Where(x => x.IdTipoCuenta == 2).OrderBy(x => x.Descripcion).ToList())
                    Datacombo.Add(u.IdCuenta, u.Descripcion + " " + u.Codigo.ToString());
            }
            if (Texto1 == 1)
            {
                foreach (Cuenta u in db.Cuentas.Where(x => x.IdTipoCuenta == 2).OrderBy(x => x.Descripcion).ToList())
                    Datacombo.Add(u.IdCuenta, u.Descripcion.ToString());
            }

            return PartialView("Select", Datacombo);
        }

        public virtual ActionResult GetCuentasConMadres()
        {
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            foreach (Cuenta u in db.Cuentas.Where(x => x.IdTipoCuenta == 2 || x.IdTipoCuenta == 4).OrderBy(x => x.Codigo).ToList())
                Datacombo.Add(u.IdCuenta, u.Codigo + " " + u.Descripcion.ToString());

            return PartialView("Select", Datacombo);
        }

        public virtual ActionResult GetCuentasSinCuentasGastosObras(int? Texto)
        {
            int Texto1 = Texto ?? 0;

            Dictionary<int, string> Datacombo = new Dictionary<int, string>();
            string JerarquiasValidas = "1 2 3 4 5";  //JerarquiasValidas.Contains(x.Jerarquia.Substring(1, 1))==true

            if (Texto1 == 0)
            {
                foreach (Cuenta u in db.Cuentas.Where(x => (x.IdTipoCuenta == 2 || x.IdTipoCuenta == 4) && JerarquiasValidas.Contains(x.Jerarquia.Substring(0, 1)) == true).OrderBy(x => x.Codigo).ToList())
                    Datacombo.Add(u.IdCuenta, u.Codigo + " " + u.Descripcion.ToString());
            }
            if (Texto1 == 1)
            {
                foreach (Cuenta u in db.Cuentas.Where(x => (x.IdTipoCuenta == 2 || x.IdTipoCuenta == 4) && JerarquiasValidas.Contains(x.Jerarquia.Substring(0, 1)) == true).OrderBy(x => x.Codigo).ToList())
                    Datacombo.Add(u.IdCuenta, u.Descripcion.ToString());
            }

            return PartialView("Select", Datacombo);
        }

        public virtual ActionResult GetCuentasFF()
        {
            Parametros parametros = db.Parametros.Find(1);
            int? i = parametros.IdTipoCuentaGrupoFF;

            Dictionary<int, string> Datacombo = new Dictionary<int, string>();

            foreach (Cuenta u in db.Cuentas.Where(x => (x.IdTipoCuenta == 2 || x.IdTipoCuenta == 4) && x.IdTipoCuentaGrupo == i).OrderBy(x => x.Codigo).ToList())
                Datacombo.Add(u.IdCuenta, u.Codigo + " " + u.Descripcion.ToString());

            return PartialView("Select", Datacombo);
        }

        public virtual JsonResult GetCuentasPorIdObraIdCuentaGasto(int IdObra = 0, int IdCuentaGasto = 0)
        {
            var filtereditems = (from a in db.Cuentas
                                 where (a.IdTipoCuenta == 2)
                                 orderby a.Descripcion
                                 select new
                                 {
                                     id = a.IdCuenta,
                                     Cuenta = a.Descripcion.Trim(),
                                     value = a.Descripcion + " " + a.Codigo.ToString(),
                                     IdObra = a.IdObra ?? 0,
                                     a.IdCuentaGasto
                                 }).ToList();

            if (IdObra != 0 && IdCuentaGasto != 0)
            {
                filtereditems = (from a in filtereditems
                                 where (a.IdObra == IdObra && a.IdCuentaGasto == IdCuentaGasto)
                                 orderby a.Cuenta
                                 select a).ToList();
            }
            if (IdObra != 0 && IdCuentaGasto == 0)
            {
                filtereditems = (from a in filtereditems
                                 where (a.IdObra == IdObra || a.IdObra == 0)
                                 orderby a.Cuenta
                                 select a).ToList();
            }
            if (IdObra == 0 && IdCuentaGasto != 0)
            {
                filtereditems = (from a in filtereditems
                                 where (a.IdCuentaGasto == IdCuentaGasto)
                                 orderby a.Cuenta
                                 select a).ToList();
            }

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCuentasPorIdTipoCuentaGrupo(int IdTipoCuentaGrupo = 0)
        {
            var filtereditems = (from a in db.Cuentas
                                 where ((a.IdTipoCuentaGrupo == IdTipoCuentaGrupo || IdTipoCuentaGrupo == 0))
                                 orderby a.Descripcion
                                 select new
                                 {
                                     id = a.IdCuenta,
                                     Cuenta = a.Descripcion.Trim(),
                                     value = a.Descripcion + " " + a.Codigo.ToString()
                                 }).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCuentaPorCodigo(int CodigoCuenta = 0)
        {
            var filtereditems = (from a in db.Cuentas
                                 where (a.Codigo == CodigoCuenta)
                                 orderby a.Descripcion
                                 select new
                                 {
                                     id = a.IdCuenta,
                                     value = a.Descripcion + " " + a.Codigo.ToString()
                                 }).ToList();

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Edit(int id)
        {
            Cuenta o;
            if (id <= 0)
            {
                o = new Cuenta();
            }
            else
            {
                o = db.Cuentas.SingleOrDefault(x => x.IdCuenta == id);
                try
                {
                    ViewBag.Jerarquia1 = o.Jerarquia.Split('.')[0];
                    ViewBag.Jerarquia2 = o.Jerarquia.Split('.')[1];
                    ViewBag.Jerarquia3 = o.Jerarquia.Split('.')[2];
                    ViewBag.Jerarquia4 = o.Jerarquia.Split('.')[3];
                    ViewBag.Jerarquia5 = o.Jerarquia.Split('.')[4];
                }
                catch (Exception)
                {
                    
                    //throw;
                }
            }
            CargarViewBag(o);
            return View(o);
        }

        void CargarViewBag(Cuenta o)
        {
            Parametros parametros = db.Parametros.Find(1);
            int? i = parametros.IdTipoCuentaGrupoFF;

            ViewBag.IdTipoCuenta = new SelectList(db.TiposCuentas, "IdTipoCuenta", "Descripcion", o.IdTipoCuenta);
            ViewBag.IdTipoCuentaGrupo = new SelectList(db.TiposCuentaGrupos, "IdTipoCuentaGrupo", "Descripcion", o.IdTipoCuentaGrupo);
            ViewBag.IdRubroContable = new SelectList(db.RubrosContables, "IdRubroContable", "Descripcion", o.IdRubroContable);
            ViewBag.IdCuentaConsolidacion = new SelectList(db.Cuentas.Where(x => x.IdTipoCuenta == 2 || x.IdTipoCuenta == 4), "IdCuenta", "Descripcion", o.IdCuentaConsolidacion);
            ViewBag.IdCuentaConsolidacion2 = new SelectList(db.Cuentas.Where(x => x.IdTipoCuenta == 2 || x.IdTipoCuenta == 4), "IdCuenta", "Descripcion", o.IdCuentaConsolidacion2);
            ViewBag.IdCuentaConsolidacion3 = new SelectList(db.Cuentas.Where(x => x.IdTipoCuenta == 2 || x.IdTipoCuenta == 4), "IdCuenta", "Descripcion", o.IdCuentaConsolidacion3);
            //Set oControl.RowSource = oAp.Cuentas.TraerFiltrado("_CuentasConsolidacionParaCombo", 1)
            ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "Descripcion", o.IdObra);
            ViewBag.IdCuentaGasto = new SelectList(db.CuentasGastos, "IdCuentaGasto", "Descripcion", o.IdCuentaGasto);
            ViewBag.IdProvincia = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvincia);

            IEnumerable<DataRow> Entidad  = EntidadManager.GetStoreProcedure(SCsql(), ProntoFuncionesGenerales.enumSPs.RubrosContables_TX_ParaComboFinancierosTodos).AsEnumerable();
            var data = (from a in Entidad
                        select new
                        {
                            IdRubroContable = a["IdRubroContable"].ToString(),
                            Titulo = a["Titulo"].ToString()
                        }).ToList();
            ViewBag.IdRubroFinanciero = new SelectList(data
                        , "IdRubroContable", "Titulo", o.IdRubroFinanciero);

            //Set oRs = oAp.Conceptos.TraerFiltrado("_PorGrupoParaCombo", 3)
            //Set DataCombo2(0).RowSource = oRs
            //Set oRs = oAp.Conceptos.TraerFiltrado("_PorGrupoParaCombo", 4)
            //Set DataCombo2(1).RowSource = oRs
            //Set oRs = oAp.Conceptos.TraerFiltrado("_PorGrupoParaCombo", 5)
            //Set DataCombo2(2).RowSource = oRs
            //ViewBag.IdCliente = new SelectList(db.Clientes, "IdCliente", "RazonSocial", o.IdCliente);
            //ViewBag.IdUnidadOperativa = new SelectList(db.UnidadesOperativas, "IdUnidadOperativa", "Descripcion", o.IdUnidadOperativa);
            //ViewBag.IdGrupoObra = new SelectList(db.GruposObras, "IdGrupoObra", "Descripcion", o.IdGrupoObra);
            //ViewBag.IdMonedaValorObra = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMonedaValorObra);
            //ViewBag.IdCuentaContableFF = new SelectList(db.Cuentas.Where(x => (x.IdTipoCuenta == 2 || x.IdTipoCuenta == 4) && x.IdTipoCuentaGrupo == i).OrderBy(x => x.Codigo), "IdCuenta", "Descripcion", o.IdCuentaContableFF);
            //ViewBag.IdProvincia = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvincia);
            //ViewBag.IdPais = new SelectList(db.Paises, "IdPais", "Descripcion", o.IdPais);
            //ViewBag.IdJefeRegional = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdJefeRegional);
            //ViewBag.IdJefe = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdJefe);
            //ViewBag.IdSubjefe = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdSubjefe);
        }

        private bool Validar(ProntoMVC.Data.Models.Cuenta o, ref string sErrorMsg)
        {
            if ((o.Descripcion ?? "") == "") sErrorMsg += "\n" + "Falta la descripción";
            if (sErrorMsg != "") return false;
            return true;
        }

        private void GuardarHistoricoDeCambio(Cuenta Cuenta) {

        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(Cuenta Cuenta) // el Exclude es para las altas, donde el Id viene en 0
        {
            if (!PuedeEditar(enumNodos.Cuentas)) throw new Exception("No tenés permisos");

            try
            {
                string erar = "";

                if (!Validar(Cuenta, ref erar))
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    List<string> errors = new List<string>();
                    errors.Add(erar);
                    return Json(errors);
                }

                if (ModelState.IsValid || true)
                {
                    if (Cuenta.IdCuenta > 0)
                    {
                        //if (SeCambioLaCuenta())
                        //{
                        //    GuardarHistoricoDeCambio();
                        //}
                        
                        var EntidadOriginal = db.Cuentas.Where(p => p.IdCuenta == Cuenta.IdCuenta).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Cuenta);
                        
                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Cuentas.Add(Cuenta);
                    }

                    db.SaveChanges();

                    return Json(new { Success = 1, IdCuenta = Cuenta.IdCuenta, ex = "" }); //, DetalleArticulos = Articulo.DetalleArticulos
                }
                else
                {
                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "La Cuenta es inválida";
                    return Json(res);
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
                JsonResponse res = new JsonResponse();

                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                res.Status = Status.Error;
                res.Errors = GetModelStateErrorsAsString(this.ModelState);
                res.Message = ex.Message.ToString();
                return Json(res);
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }

        public virtual JsonResult SaldoContablePorIdCuentaBancaria(int IdCuentaBancaria = 0, string Fecha = "")
        {
            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Cuentas_TX_MayorPorIdCuentaBancaria", IdCuentaBancaria, Fecha);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            Saldo = (a[0].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[0].NullSafeToString()),
                            OrdenesPagoAnuladas = (a[1].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[1].NullSafeToString()),
                        })
                        .ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = 1,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = "1",
                            cell = new string[] { 
                            string.Empty, 
                            a.Saldo.ToString(), 
                            a.OrdenesPagoAnuladas.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

    }

}