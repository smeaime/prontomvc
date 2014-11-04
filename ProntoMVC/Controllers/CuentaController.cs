using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
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

namespace ProntoMVC.Controllers
{
    public partial class CuentaController : ProntoBaseController
    {

        public virtual JsonResult GetCuentasAutocomplete(string term)
        {

            // http://stackoverflow.com/questions/444798/case-insensitive-containsstring

            var ci = new System.Globalization.CultureInfo("en-US");

            var filtereditems = (from item in db.Cuentas
                                 // TO DO: no me funciona el  .StartsWith(term, true, ci) !!!!!!!!! 
                                 // y usarlo con el int del codigo tambien es un dolor de cabeza!!!!!
                                 // http://stackoverflow.com/questions/1066760/problem-with-converting-int-to-string-in-linq-to-entities/3292773#3292773
                                 // http://stackoverflow.com/questions/10110266/why-linq-to-entities-does-not-recognize-the-method-system-string-tostring

                                 where ((
                                 
                                 //item.Descripcion.StartsWith(term)

                                 (item.Descripcion + " " + SqlFunctions.StringConvert((double)(item.Codigo ?? 0))).StartsWith(term)

                                     //       || SqlFunctions.StringConvert((double)(item.Codigo ?? 0)).StartsWith(term)
                                         )
                                     && item.IdTipoCuenta == 2
                                     // && item.Descripcion.Trim().Length > 0
                                     )
                                 orderby item.Descripcion
                                 select new
                                 {
                                     id = item.IdCuenta,
                                     codigo = item.Codigo,
                                     value = item.Descripcion + " " + SqlFunctions.StringConvert((double)(item.Codigo ?? 0)),
                                     title = item.Descripcion + " " + SqlFunctions.StringConvert((double)(item.Codigo ?? 0))

                                                                         
                                     , NumeroRendicionFF = item.NumeroAuxiliar ?? 1


                                 }).Take(20).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }


        public virtual JsonResult GetCuentasGastoAutocomplete(string term, int obra = 0)
        {


            // http://stackoverflow.com/questions/444798/case-insensitive-containsstring

            var ci = new System.Globalization.CultureInfo("en-US");


            var filtereditems = (from item in db.CuentasGastos
                                 // TO DO: no me funciona el  .StartsWith(term, true, ci) !!!!!!!!! 
                                 // y usarlo con el int del codigo tambien es un dolor de cabeza!!!!!
                                 // http://stackoverflow.com/questions/1066760/problem-with-converting-int-to-string-in-linq-to-entities/3292773#3292773
                                 // http://stackoverflow.com/questions/10110266/why-linq-to-entities-does-not-recognize-the-method-system-string-tostring
                                 
                                 join cu in db.Cuentas on item.IdCuentaGasto  equals  cu.IdCuentaGasto
                                 
                                 where ((

                                 (item.Descripcion ).StartsWith(term)
                                 //(item.Descripcion + " " + SqlFunctions.StringConvert((double)(cu.Codigo ?? 0))).StartsWith(term)

                                     //       || SqlFunctions.StringConvert((double)(item.Codigo ?? 0)).StartsWith(term)
                                         )
                                     && (cu.IdTipoCuenta == 2 || cu.IdTipoCuenta == 4)
                                     // && item.Descripcion.Trim().Length > 0

                                     && (obra==0 || cu.IdObra==obra)
                                     )
                                 orderby item.Descripcion
                                 select new
                                 {
                                     id = cu.IdCuenta,
                                     codigo = SqlFunctions.StringConvert((double)(cu.Codigo ?? 0)).Trim(), // me estaba agregando espacios en blanco http://stackoverflow.com/questions/6158706/sqlfunctions-stringconvert-unnecessary-padding-added
                                     value = item.Descripcion // + " " + SqlFunctions.StringConvert((double)(cu.Codigo ?? 0)),
                                     , title = item.Descripcion // + " " + SqlFunctions.StringConvert((double)(cu.Codigo ?? 0))

                                     ,
                                     idcuentagasto = cu.IdCuenta

                                 }).Take(20).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCodigosCuentasAutocomplete2(string term)
        {
            int term2 = Generales.Val (term);

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
                         //id = cu.IdCuenta,
                         //value = SqlFunctions.StringConvert((double)(item.Codigo ?? 0)) + " " + item.Descripcion,
                         //codigo = item.Codigo,
                         //title = item.Descripcion

                         id = cu.IdCuenta,
                         value = cu.Codigo, // SqlFunctions.StringConvert((double)(cu.Codigo ?? 0)) + " " + item.Descripcion,
                         codigo = cu.Codigo,
                         title = item.Descripcion
                            ,
                         idcuentagasto = cu.IdCuenta

                     }).Take(10).ToList();

            return Json(q, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetCuentasFFAutocomplete(string term)
        {

            
           Parametros parametros = db.Parametros.Find(1);
            int? i = parametros.IdTipoCuentaGrupoFF;




            // http://stackoverflow.com/questions/444798/case-insensitive-containsstring

            var ci = new System.Globalization.CultureInfo("en-US");

            var filtereditems = (from item in db.Cuentas
                                 // TO DO: no me funciona el  .StartsWith(term, true, ci) !!!!!!!!! 
                                 // y usarlo con el int del codigo tambien es un dolor de cabeza!!!!!
                                 // http://stackoverflow.com/questions/1066760/problem-with-converting-int-to-string-in-linq-to-entities/3292773#3292773
                                 // http://stackoverflow.com/questions/10110266/why-linq-to-entities-does-not-recognize-the-method-system-string-tostring

                                 where ((

                                 //item.Descripcion.StartsWith(term)

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
                        "WHERE Descripcion + ' ' + Convert(varchar,Codigo) LIKE '" + term +
                               "%' AND IdTipoCuentaGrupo=" + idCuentaGrupo;

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

                //                throw;
            }

            //switch (sidx.ToLower())
            //{
            //    case "numerorequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //    case "fecharequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.FechaRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.FechaRequerimiento);
            //        break;
            //    case "numeroobra":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Obra.NumeroObra);
            //        else
            //            Req = Req.OrderBy(a => a.Obra.NumeroObra);
            //        break;
            //    case "libero":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados.Nombre);
            //        break;
            //    case "aprobo":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados1.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados1.Nombre);
            //        break;
            //    case "sector":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Sectores.Descripcion);
            //        else
            //            Req = Req.OrderBy(a => a.Sectores.Descripcion);
            //        break;
            //    case "detalle":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Detalle);
            //        else
            //            Req = Req.OrderBy(a => a.Detalle);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //}

            var data = (from a in Req

                        select a
                //new
                //        {
                //            IdRequerimiento = a.IdCuenta,
                //            NumeroRequerimiento = a.Codigo,
                //            //FechaRequerimiento = a.FechaRequerimiento,
                //            //Cumplido = a.Cumplido,
                //            //Recepcionado = a.Recepcionado,
                //            //Entregado = a.Entregado,
                //            //Impresa = a.Impresa,
                //            //Detalle = a.Detalle,
                //            //NumeroObra = a.Obra.NumeroObra,
                //            //Presupuestos = a.Presupuestos,
                //            //Comparativas = a.Comparativas,
                //            //Pedidos = a.Pedidos,
                //            //Recepciones = a.Recepciones,
                //            //Salidas = a.SalidasMateriales,
                //            //Libero = a.Empleados.Nombre,
                //            //Solicito = a.Empleados1.Nombre,
                //            //Sector = a.Sectores.Descripcion,
                //            //Usuario_anulo = a.UsuarioAnulacion,
                //            //Fecha_anulacion = a.FechaAnulacion,
                //            //Motivo_anulacion = a.MotivoAnulacion,
                //            //Fechas_liberacion = a.FechasLiberacion,
                //            //Observaciones = a.Observaciones,
                //            //LugarEntrega = a.LugarEntrega,
                //            //IdObra = a.IdObra,
                //            //IdSector = a.IdSector,
                //            //a.ConfirmadoPorWeb

                //        }

            ).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();








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
                                
                                //a.NumeroRequerimiento.ToString(), 
                                //a.FechaRequerimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                //a.Cumplido,
                                //a.Recepcionado,
                                //a.Entregado,
                                //a.Impresa,
                                //a.Detalle,
                                //a.NumeroObra, 
                                //a.Presupuestos,
                                //a.Comparativas,
                                //a.Pedidos,
                                //a.Recepciones,
                                //a.Salidas,
                                //a.Libero,
                                //a.Solicito,
                                //a.Sector,
                                //a.Usuario_anulo,
                                //a.Fecha_anulacion.ToString(),
                                //a.Motivo_anulacion,
                                //a.Fechas_liberacion,
                                //a.Observaciones,
                                //a.LugarEntrega,
                                //a.IdObra.ToString(),
                                //a.IdSector.ToString(),
                                //a.ConfirmadoPorWeb.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }




        public virtual ViewResult Index()
        {

            if (!Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin") &&
                !Roles.IsUserInRole(Membership.GetUser().UserName, "Administrador") &&
                     !Roles.IsUserInRole(Membership.GetUser().UserName, "FondosFijos")
                ) throw new Exception("No tenés permisos");

            //var ComprobantesProveedores = db.ComprobantesProveedor.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }

        public virtual ViewResult IndexFF()
        {

            if (!Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin") &&
                !Roles.IsUserInRole(Membership.GetUser().UserName, "Administrador") &&
                     !Roles.IsUserInRole(Membership.GetUser().UserName, "FondosFijos")
                ) throw new Exception("No tenés permisos");

            //var ComprobantesProveedores = db.ComprobantesProveedor.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }
    }
}