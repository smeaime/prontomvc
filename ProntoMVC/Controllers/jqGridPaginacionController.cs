// The example is a modification of the example created by Phil Haack
// see http://haacked.com/archive/2009/04/14/using-jquery-grid-with-asp.net-mvc.aspx
using System.Linq;
using System.Linq.Dynamic;
using System.Web.Mvc;
//using jqGridWeb.Models;
using ProntoMVC.Data.Models;
using ClassLibrary2;

using ProntoMVC.Models;




using System.Data.Entity.Core.Objects; // using System.Data.Entity.Core.Objects;

using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Text;
using System;
using System.Reflection;




namespace jqGridWeb.Controllers
{
    // to send exceptions as json we define [HandleJsonException] attribute
    public class ExceptionInformation
    {
        public string Message { get; set; }
        public string Source { get; set; }
        public string StackTrace { get; set; }
    }
    public class HandleJsonExceptionAttribute : ActionFilterAttribute
    {
        // next class example are from the http://www.dotnetcurry.com/ShowArticle.aspx?ID=496
        public override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            if (filterContext.HttpContext.Request.IsAjaxRequest() && filterContext.Exception != null)
            {
                filterContext.HttpContext.Response.StatusCode =
                    (int)System.Net.HttpStatusCode.InternalServerError;

                var exInfo = new List<ExceptionInformation>();
                for (Exception ex = filterContext.Exception; ex != null; ex = ex.InnerException)
                {
                    PropertyInfo propertyInfo = ex.GetType().GetProperty("ErrorCode");
                    exInfo.Add(new ExceptionInformation()
                    {
                        Message = ex.Message,
                        Source = ex.Source,
                        StackTrace = ex.StackTrace
                    });
                }
                filterContext.Result = new JsonResult() { Data = exInfo };
                filterContext.ExceptionHandled = true;
            }
        }
    }

    public class Filters
    {
        public enum GroupOp
        {
            AND,
            OR
        }
        public enum Operations
        {
            eq, // "equal"
            ne, // "not equal"
            lt, // "less"
            le, // "less or equal"
            gt, // "greater"
            ge, // "greater or equal"
            bw, // "begins with"
            bn, // "does not begin with"
            //in, // "in"
            //ni, // "not in"
            ew, // "ends with"
            en, // "does not end with"
            cn, // "contains"
            nc  // "does not contain"
        }
        public class Rule
        {
            public string field { get; set; }
            public Operations op { get; set; }
            public string data { get; set; }
        }

        public GroupOp groupOp { get; set; }
        public List<Rule> rules { get; set; }
        private static readonly string[] FormatMapping = {
            "(it.{0} = @p{1})",                 // "eq" - equal
            "(it.{0} <> @p{1})",                // "ne" - not equal
            "(it.{0} < @p{1})",                 // "lt" - less than
            "(it.{0} <= @p{1})",                // "le" - less than or equal to
            "(it.{0} > @p{1})",                 // "gt" - greater than
            "(it.{0} >= @p{1})",                // "ge" - greater than or equal to
            "(it.{0} LIKE (@p{1}+'%'))",        // "bw" - begins with
            "(it.{0} NOT LIKE (@p{1}+'%'))",    // "bn" - does not begin with
            "(it.{0} LIKE ('%'+@p{1}))",        // "ew" - ends with
            "(it.{0} NOT LIKE ('%'+@p{1}))",    // "en" - does not end with
            "(it.{0} LIKE ('%'+@p{1}+'%'))",    // "cn" - contains
            "(it.{0} NOT LIKE ('%'+@p{1}+'%'))" //" nc" - does not contain
        };


        internal ObjectQuery<T> FilterObjectSet<T>(ObjectQuery<T> inputQuery) where T : class
        {
            if (rules.Count <= 0)
                return inputQuery;

            var sb = new StringBuilder();
            var objParams = new List<ObjectParameter>(rules.Count);

            string rulefieldPunto;

            foreach (Rule rule in rules)
            {


                if (rule.field.IndexOf('.') >= 0)
                {
                    rulefieldPunto = rule.field.Substring(0, rule.field.IndexOf('.'));
                }
                else
                {
                    rulefieldPunto = rule.field;
                }


                PropertyInfo propertyInfo = typeof(T).GetProperty(rule.field);
                try
                {
                    if (propertyInfo == null)
                    {
                        System.Diagnostics.Debug.WriteLine("La propiedad " + rule.field + " (el nombre 'index' en el modelo de la jqGrid) no existe en el tipo T " + typeof(T).Name);
                        continue; // skip wrong entries
                    }

                }
                catch (Exception)
                {
                    System.Diagnostics.Debug.WriteLine("La propiedad " + rule.field + " no existe en tl tipo T " + typeof(T).Name);
                    continue; // skip wrong entries
                }

                if (sb.Length != 0)
                    sb.Append(groupOp);

                var iParam = objParams.Count;




                if (rule.field == "Obra")
                {
                    sb.AppendFormat(FormatMapping[(int)rule.op], "Obra.Descripcion", iParam);

                    // no puedo usar como nombre "Obra.Descripcion" en lugar de "Obra" en el field de la jqgrid ?



                    // necesito el NumeroObra tambien....
                    //sb.AppendFormat(FormatMapping[(int)rule.op], "Obra.NumeroObra", iParam);
                    //"(it.{0} LIKE (@p{1}+'%'))",        // "bw" - begins with

                }
                else if (rule.field == "TiposCuentaGrupos")
                    sb.AppendFormat(FormatMapping[(int)rule.op], "TiposCuentaGrupos.Descripcion", iParam);
                else if (rule.field == "CuentasGasto")
                    sb.AppendFormat(FormatMapping[(int)rule.op], "CuentasGasto.Descripcion", iParam);
                else
                    sb.AppendFormat(FormatMapping[(int)rule.op], rule.field, iParam);




                ObjectParameter param;

                string tipo;
                if (Nullable.GetUnderlyingType(propertyInfo.PropertyType) != null)
                {
                    // It's nullable
                    tipo = Nullable.GetUnderlyingType(propertyInfo.PropertyType).FullName;
                }
                else
                {
                    tipo = propertyInfo.PropertyType.FullName;
                }

                switch (tipo)
                {
                    case "System.Int32":  // int
                        param = new ObjectParameter("p" + iParam, Int32.Parse(rule.data));
                        break;
                    case "System.Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]":
                        param = new ObjectParameter("p" + iParam, Int32.Parse(rule.data));
                        break;
                    case "System.Int64":  // bigint
                        param = new ObjectParameter("p" + iParam, Int64.Parse(rule.data));
                        break;
                    case "System.Int16":  // smallint
                        param = new ObjectParameter("p" + iParam, Int16.Parse(rule.data));
                        break;
                    case "System.SByte":  // tinyint
                        param = new ObjectParameter("p" + iParam, SByte.Parse(rule.data));
                        break;
                    case "System.Single": // Edm.Single, in SQL: float
                        param = new ObjectParameter("p" + iParam, Single.Parse(rule.data));
                        break;
                    case "System.Double": // float(53), double precision
                        param = new ObjectParameter("p" + iParam, Double.Parse(rule.data));
                        break;
                    case "System.Boolean": // Edm.Boolean, in SQL: bit
                        param = new ObjectParameter("p" + iParam,
                            String.Compare(rule.data, "1", StringComparison.Ordinal) == 0 ||
                            String.Compare(rule.data, "yes", StringComparison.OrdinalIgnoreCase) == 0 ||
                            String.Compare(rule.data, "true", StringComparison.OrdinalIgnoreCase) == 0 ?
                            true :
                            false);
                        break;

                    case "ProntoMVC.Data.Models.TiposCuentaGrupos":
                        var c = new TiposCuentaGrupos();
                        c.Descripcion = rule.data;
                        param = new ObjectParameter("p" + iParam, rule.data);
                        break;
                    case "ProntoMVC.Data.Models.Obra":
                        var o = new Obra();
                        param = new ObjectParameter("p" + iParam, rule.data);
                        break;
                    case "ProntoMVC.Data.Models.CuentasGasto":
                        var cg = new CuentasGasto();
                        param = new ObjectParameter("p" + iParam, rule.data);
                        break;

                    default:
                        // TODO: Extend to other data types
                        // binary, date, datetimeoffset,
                        // decimal, numeric,
                        // money, smallmoney
                        // and so on

                        param = new ObjectParameter("p" + iParam, rule.data);
                        break;
                }
                objParams.Add(param);
            }


            // filtrar el IdObra
            //objParams.Add( new ObjectParameter("p2", 20));



            ObjectQuery<T> filteredQuery = inputQuery.Where(sb.ToString());
            foreach (var objParam in objParams)
                filteredQuery.Parameters.Add(objParam);

            return filteredQuery;
        }
    }

    //[HandleError]
    [HandleJsonException]
    public partial class jqGridPaginacionController : ProntoMVC.Controllers.ProntoBaseController
    {
      

        public virtual JsonResult DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {

            // Oleg: filtros avanzados con jqgrid y LINQ    http://stackoverflow.com/questions/5500805/asp-net-mvc-2-0-implementation-of-searching-in-jqgrid/5501644#5501644
            // usando dbcontext en lugar de objectcontext   http://stackoverflow.com/questions/9027150/jqgrid-asp-net-4-mvc-how-to-make-search-implementation-on-a-dbcontext-reposit

            //var sc = Generales.sCadenaConex("Autotrol");
            //var dbcontext = new ProntoMVC.Data.Models.DemoProntoEntities(sc);
            var context = ((System.Data.Entity.Infrastructure.IObjectContextAdapter)db).ObjectContext;
            var set = context.CreateObjectSet<ProntoMVC.Data.Models.Cuenta>().Include("Obra,CuentasGasto,TiposCuentaGrupos");



            var serializer = new JavaScriptSerializer();
            Filters f = (!_search || string.IsNullOrEmpty(filters)) ? null : serializer.Deserialize<Filters>(filters);
            ObjectQuery<ProntoMVC.Data.Models.Cuenta> filteredQuery =
                (f == null ? (ObjectQuery<ProntoMVC.Data.Models.Cuenta>)set : f.FilterObjectSet((ObjectQuery<ProntoMVC.Data.Models.Cuenta>)set));
            filteredQuery.MergeOption = MergeOption.NoTracking; // we don't want to update the data

            filteredQuery = filteredQuery.Where("it.IdCuentaGasto IS NOT NULL");

            var d = filteredQuery.Where(x => x.IdCuentaGasto != null);

            var totalRecords = filteredQuery.Count();


            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause
            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause
            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause
            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause
            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause


            var pagedQuery = filteredQuery
                                        .Skip("it." + sidx + " " + sord, "@skip",
                                                new ObjectParameter("skip", (page - 1) * rows))
                                         .Top("@limit", new ObjectParameter("limit", rows));
            // to be able to use ToString() below which is NOT exist in the LINQ to Entity


            var queryDetails = (from item in pagedQuery
                                select new
                                {
                                    item.IdCuenta,
                                    item.Descripcion,
                                    item.Codigo,
                                    item.TiposCuentaGrupos,
                                    item.CuentasGasto,
                                    item.Obra
                                })

                                .ToList(); //.Where(x => x.CuentasGasto != null );

            

            var jsonData = new ProntoMVC.Controllers.jqGridJson()
            {
                total = (totalRecords + rows - 1) / rows,
                page = page,
                records = totalRecords,
                rows = (from a in queryDetails
                        select new ProntoMVC.Controllers.jqGridRowJson
                        {
                            id = a.IdCuenta.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdCuenta} ) + " target='' >Editar</>" ,
							    "<a href="+ Url.Action("Imprimir",new {id = a.IdCuenta} )  +">Imprimir</>" ,
                                a.IdCuenta.ToString(), 
                                a.Descripcion.NullSafeToString(),
                                a.Codigo.NullSafeToString(),
                              
                                (a.TiposCuentaGrupos==null) ? "" : a.TiposCuentaGrupos.Descripcion.NullSafeToString(),
                                (a.Obra==null) ? "" : a.Obra.Descripcion.NullSafeToString(),
                                (a.CuentasGasto==null) ? "" : a.CuentasGasto.Descripcion.NullSafeToString(),
                                
                                

                                    }
                        }
                        ).ToArray()
            };


            return Json(jsonData, JsonRequestBehavior.AllowGet);

        }


        public virtual JsonResult grilladinamica_CuentasFF_OBSOLETA(string sidx, string sord, int page, int rows
                                    , bool _search, string searchField, string searchOper, string searchString
                                    , string filters)
        {

            // Oleg: filtros avanzados con jqgrid y LINQ    http://stackoverflow.com/questions/5500805/asp-net-mvc-2-0-implementation-of-searching-in-jqgrid/5501644#5501644
            // usando dbcontext en lugar de objectcontext   http://stackoverflow.com/questions/9027150/jqgrid-asp-net-4-mvc-how-to-make-search-implementation-on-a-dbcontext-reposit

            //var sc = Generales.sCadenaConex("Autotrol");
            //var dbcontext = new ProntoMVC.Data.Models.DemoProntoEntities(sc);
            var context = ((System.Data.Entity.Infrastructure.IObjectContextAdapter)db).ObjectContext;
            var set = context.CreateObjectSet<ProntoMVC.Data.Models.Cuenta>().Include("Obra,CuentasGasto,TiposCuentaGrupos")
                //             .Where(x => x.IdTipoCuentaGrupo == 9)
                       ;

            //    filteredQuery = filteredQuery.Where(x => ((x.IdObra ?? 0) == 0 || x.IdObra == IdObra));



            var serializer = new JavaScriptSerializer();
            Filters f = (!_search || string.IsNullOrEmpty(filters)) ? null : serializer.Deserialize<Filters>(filters);

            f = new Filters();
            Filters.Rule regla = new Filters.Rule();
            regla.data = "9";
            regla.op = Filters.Operations.eq;
            regla.field = "IdTipoCuentaGrupo";
            f.rules = new List<Filters.Rule>();
            f.rules.Add(regla);




            ObjectQuery<ProntoMVC.Data.Models.Cuenta> filteredQuery =
                (f == null ?
                            (ObjectQuery<ProntoMVC.Data.Models.Cuenta>)set
                            :
                            f.FilterObjectSet((ObjectQuery<ProntoMVC.Data.Models.Cuenta>)set)
                );
            filteredQuery.MergeOption = MergeOption.NoTracking; // we don't want to update the data



            string campo = String.Empty;
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







            //           WHERE IdTipoCuentaGrupo=@IdTipoCuentaGrupoFF and   
            //(IsNull(@IdCuentaFF,-1)=-1 or IsNull(@IdCuentaFF,-1)=IdCuenta) and   
            //Len(LTrim(Descripcion))>0  

            int IdTipoCuentaGrupoFF = db.Parametros.Find(1).IdTipoCuentaGrupoFF ?? 0;

            var q = db.Cuentas // filteredQuery
                            .Where(x => x.IdTipoCuentaGrupo == IdTipoCuentaGrupoFF)
                            .OrderBy(x => x.Descripcion).AsQueryable();

            q = q.Where(campo);


            var totalRecords = q.Count();

            var pagedQuery = q
                            .Skip((page - 1) * rows)
                            .Take(rows);


            // to be able to use ToString() below which is NOT exist in the LINQ to Entity
            var queryDetails = (from item in pagedQuery
                                select new
                                {
                                    item.IdCuenta,
                                    item.Descripcion,
                                    item.Codigo,
                                    item.TiposCuentaGrupos,
                                    item.CuentasGasto,
                                    item.Obra,
                                    item.NumeroAuxiliar
                                }).ToList();


            var jsonData = new ProntoMVC.Controllers.jqGridJson()
            {
                total = (totalRecords + rows - 1) / rows,
                page = page,
                records = totalRecords,
                rows = (from a in queryDetails
                        select new ProntoMVC.Controllers.jqGridRowJson
                        {
                            id = a.IdCuenta.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdCuenta} ) + " target='' >Editar</>" ,
							    //"<a href="+ Url.Action("Imprimir",new {id = a.IdCuenta} )  +">Imprimir</> | " +
                                "<a href="+ Url.Action(  "IncrementarRendicionFF","ComprobanteProveedor", new {idcuentaFF = a.IdCuenta } ) +  " target='' >Cerrar rendición</>"  ,
                                a.IdCuenta.ToString(), 
                                a.Descripcion.NullSafeToString(),
                                a.Codigo.NullSafeToString(),
                                (a.TiposCuentaGrupos==null) ? "" : a.TiposCuentaGrupos.Descripcion.NullSafeToString(),
                                (a.Obra==null) ? "" : a.Obra.NumeroObra + " - " + a.Obra.Descripcion.NullSafeToString(),
                                (a.CuentasGasto==null) ? "" : a.CuentasGasto.Descripcion.NullSafeToString(),
                                
                                a.NumeroAuxiliar.NullSafeToString(),
                                
                                
                                

                                    }
                        }
                        ).ToArray()
            };


            return Json(jsonData, JsonRequestBehavior.AllowGet);

        }

        public virtual ActionResult About()
        {
            return View();
        }
    }
}