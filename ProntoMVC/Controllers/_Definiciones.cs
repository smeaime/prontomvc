using System;
using System.Collections.Generic;
using System.Linq;

using System.Linq.Dynamic;
using System.Linq.Expressions;


using System.Web;
using System.Data.Entity.Core.Objects;
using System.Text;
using System.Reflection;
using System.Web.Script.Serialization;



// http://stackoverflow.com/questions/5500805/asp-net-mvc-2-0-implementation-of-searching-in-jqgrid
// esto es la modificacion de Oleg usando los filtros de EF a lo que hizo Phil Haack con los filtros del addon de Linq.Dynamic



/*
 * 
 * 
 * 
 * 
 * 
 * // -y cómo seguir usando, en el caso de los storeprocs, el filtro nativo de EF en lugar del linq.dynamic?
 * http://stackoverflow.com/questions/2772295/iqueryable-from-stored-procedure-entity-framework
 * You can't do what you're trying to do, for the same 
reason that you can't put a stored procedure in a FROM clause of a SELECT 
query - SQL isn't built to support this kind of operation.
Could you put the logic you want into a view instead of a stored procedure?
  
 -y en lugar de una vista o una tabla temporal, podemos usar una TVF

 * Support for table-valued functions has been added in .NET 4.5 and EF5. Change your 
 * stored proc into a TVF and you can use the code from this answer. –  Alex Oct 17 '13 at 13:24
 http://stackoverflow.com/questions/16769299/how-to-use-table-valued-function-in-entity-framework-code-first-approach/16811388#16811388
 https://technet.microsoft.com/en-us/library/ms191165(v=sql.105).aspx
  
 * 
 * 
 * 

*/



namespace ProntoMVC.Controllers
{
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
            "( CAST (it.{0} AS System.String )  LIKE ('%'+@p{1}+'%'))",    // "cn" - contains
            "(it.{0} NOT LIKE ('%'+@p{1}+'%'))" //" nc" - does not contain
        };



        // http://stackoverflow.com/questions/18387153/linq-query-fails-only-on-contains-object-reference-not-set-to-an-instance-of-an
        private static readonly string[] FormatMapping_ParaLinqDynamic = {
            "({0} = @{1})",                 // "eq" - equal
            "({0} <> @{1})",                // "ne" - not equal
            "({0} < @{1})",                 // "lt" - less than
            "({0} <= @{1})",                // "le" - less than or equal to
            "({0} > @{1})",                 // "gt" - greater than
            "({0} >= @{1})",                // "ge" - greater than or equal to
            "({0}!= NULL  AND  {0}.StartsWith(@{1}))",        // "bw" - begins with
            "({0}!= NULL  AND !{0}.StartsWith(@{1}))",    // "bn" - does not begin with
            "({0}!= NULL  AND {0}.EndsWith(@{1}))",        // "ew" - ends with
            "({0}!= NULL  AND !{0}.EndsWith(@{1}))",    // "en" - does not end with
            "({0}!= NULL  AND {0}.ToString().Contains(@{1}))",    // "cn" - contains
            "({0}!= NULL  AND !{0}.Contains(@{1}))" //" nc" - does not contain
        };


        private static System.Reflection.PropertyInfo GetProperty(object t, string PropertName)
        {
            if (t.GetType().GetProperties().Count(p => p.Name == PropertName.Split('.')[0]) == 0)
                throw new ArgumentNullException(string.Format("Property {0}, is not exists in object {1}", PropertName, t.ToString()));
            if (PropertName.Split('.').Length == 1)
                return t.GetType().GetProperty(PropertName);
            else
                return GetProperty(t.GetType().GetProperty(PropertName.Split('.')[0]).GetValue(t, null), PropertName.Split('.')[1]);
        }




        static public ObjectQuery<T> FiltroGenerico_PasandoQueryEntera<T>(
                             ObjectQuery<T> set,

                             string sidx, string sord, int page, int rows, bool _search, string filters,
                             ref int totalRecords
                         )
                           where T : class
        {





            var serializer = new JavaScriptSerializer();
            Filters f = (!_search || string.IsNullOrEmpty(filters)) ? null : serializer.Deserialize<Filters>(filters);
            ObjectQuery<T> filteredQuery =
                (f == null ? (ObjectQuery<T>)set :
                f.FilterObjectSet((ObjectQuery<T>)set));

            filteredQuery.MergeOption = MergeOption.NoTracking; // we don't want to update the data

            //filteredQuery = filteredQuery.Where("it.IdCuentaGasto IS NOT NULL");

            // var d = filteredQuery.Where(x => x.IdCuentaGasto != null);

            try
            {
                totalRecords = filteredQuery.Count();
            }
            catch (Exception)
            {

                // ¿estas tratando de usar un LIKE sobre una columna que es numerica?
                // ¿pusiste bien el nombre del campo en el modelo de la jqgrid?? (ejemplo: pusiste "Subrubro" en lugar de "Subrubro.Descripcion"?)
                throw;
            }







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


            return pagedQuery;

            ////////////////////////////////////////////   FIN DE LO QUE HAY QUE COPIAR       ////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }

        static public ObjectQuery<T> FiltroGenerico<T>(
                                 string includes,
                                 string sidx, string sord, int page, int rows, bool _search, string filters,
                                 ProntoMVC.Data.Models.DemoProntoEntities db,
                                 ref int totalRecords, string includes2 = ""
                             )
                               where T : class
        {

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            // Oleg: filtros avanzados con jqgrid y LINQ    http://stackoverflow.com/questions/5500805/asp-net-mvc-2-0-implementation-of-searching-in-jqgrid/5501644#5501644
            // usando dbcontext en lugar de objectcontext   http://stackoverflow.com/questions/9027150/jqgrid-asp-net-4-mvc-how-to-make-search-implementation-on-a-dbcontext-reposit

            //var sc = Generales.sCadenaConex("Autotrol");
            //var dbcontext = new ProntoMVC.Data.Models.DemoProntoEntities(sc);
            var context = ((System.Data.Entity.Infrastructure.IObjectContextAdapter)db).ObjectContext;
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ObjectQuery<T> set;

            if (includes2 == "" && includes == "")
                set = context.CreateObjectSet<T>();
            else if (includes2 == "")
                set = context.CreateObjectSet<T>().Include(includes);
            else
                set = context.CreateObjectSet<T>().Include(includes).Include(includes2);


            // estoy usando un include adicional porque no anduvo bien pasar en uno solo una lista doble de subcolecciones (por ejemplo
            //                   el caso del maestro de requerimientos:
            //                  db.Requerimientos.Include("DetalleRequerimientos.DetallePresupuestos,DetalleRequerimientos.DetallePedidos")  no funciona
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////

            var serializer = new JavaScriptSerializer();
            Filters f = (!_search || string.IsNullOrEmpty(filters)) ? null : serializer.Deserialize<Filters>(filters);
            ObjectQuery<T> filteredQuery =
                (f == null ? (ObjectQuery<T>)set :
                f.FilterObjectSet((ObjectQuery<T>)set));

            filteredQuery.MergeOption = MergeOption.NoTracking; // we don't want to update the data

            //filteredQuery = filteredQuery.Where("it.IdCuentaGasto IS NOT NULL");

            // var d = filteredQuery.Where(x => x.IdCuentaGasto != null);

            try
            {
                totalRecords = filteredQuery.Count();
            }
            catch (Exception)
            {

                // ¿estas tratando de usar un LIKE sobre una columna que es numerica?
                // ¿pusiste bien el nombre del campo en el modelo de la jqgrid?? (ejemplo: pusiste "Subrubro" en lugar de "Subrubro.Descripcion"?)
                throw;
            }

            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause

            var pagedQuery = filteredQuery
                                        .Skip("it." + sidx + " " + sord, "@skip",
                                                new ObjectParameter("skip", (page - 1) * rows))
                                         .Top("@limit", new ObjectParameter("limit", rows));
            // to be able to use ToString() below which is NOT exist in the LINQ to Entity

            return pagedQuery;

            ////////////////////////////////////////////   FIN DE LO QUE HAY QUE COPIAR       ////////////////////////////////////////////
        }




        static public List<T> FiltroGenerico_UsandoIQueryable<T>(
                         string sidx, string sord, int page, int rows, bool _search, string filters,
                         ProntoMVC.Data.Models.DemoProntoEntities db,
                         ref int totalRecords,
                        IQueryable<T> q
                     )
                       where T : class
        {




            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            // Oleg: filtros avanzados con jqgrid y LINQ    http://stackoverflow.com/questions/5500805/asp-net-mvc-2-0-implementation-of-searching-in-jqgrid/5501644#5501644
            // usando dbcontext en lugar de objectcontext   http://stackoverflow.com/questions/9027150/jqgrid-asp-net-4-mvc-how-to-make-search-implementation-on-a-dbcontext-reposit

            //var sc = Generales.sCadenaConex("Autotrol");
            //var dbcontext = new ProntoMVC.Data.Models.DemoProntoEntities(sc);
            var context = ((System.Data.Entity.Infrastructure.IObjectContextAdapter)db).ObjectContext;







            var serializer = new JavaScriptSerializer();
            Filters f = (!_search || string.IsNullOrEmpty(filters)) ? null : serializer.Deserialize<Filters>(filters);

            string s = "true";

            var sb = new StringBuilder();
            var objParams = new List<ObjectParameter>();

            IQueryable<T> filteredQuery;



            // hay que poner lo del FM y sacar los espacios en los nombres de las columnas
            if (f != null)
            {
                f.CrearFiltro<T>(sb, objParams, true);
                s = sb.ToString();
                // s = "(Detalle.ToString().Contains(\"aaa\"))";
                var parm = objParams.Select(x => x.Value).ToArray();
                //s = s.Replace("it.", "");
                //s = s.Replace("@p0", "\"" +  objParams[0].Value.ToString() + "\"");
                try
                {
                    filteredQuery = q.Where(s, parm);  // este where es de dynamic, no de EF

                }
                catch (Exception)
                {
                    s = s.Replace(".ToString()", ".Value.ToString()");       //   http://stackoverflow.com/questions/9273991/dynamic-linq-to-entities-where-with-nullable-datetime-column
                    filteredQuery = q.Where(s, parm);

                }




            }
            else
            {

                filteredQuery = q;
            }



            try
            {
                totalRecords = filteredQuery.Count();
            }
            catch (Exception)
            {

                // ¿estas tratando de usar un LIKE sobre una columna que es numerica?
                // ¿pusiste bien el nombre del campo en el modelo de la jqgrid?? (ejemplo: pusiste "Subrubro" en lugar de "Subrubro.Descripcion"?)
                throw;
            }







            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause
            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause
            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause
            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause
            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause


            //var pagedQuery = filteredQuery
            //                            .Skip("it." + sidx + " " + sord, "@skip",
            //                                    new ObjectParameter("skip", (page - 1) * rows))
            //                             .Top("@limit", new ObjectParameter("limit", rows));
            // to be able to use ToString() below which is NOT exist in the LINQ to Entity

            List<T> pagedQuery;

            //IOrderedQueryable<T> qq;

            //if (sord == "desc")
            //    //qq = filteredQuery.OrderByDescending(sidx);
            //    pagedQuery = filteredQuery.OrderByDescending(sidx).Skip((page - 1) * rows).Take(rows).ToList();
            //else
            //    //qq = filteredQuery.OrderBy(sidx);
            pagedQuery = filteredQuery.OrderBy(sidx + " " + sord).Skip((page - 1) * rows).Take(rows).ToList();



            return pagedQuery;

            ////////////////////////////////////////////   FIN DE LO QUE HAY QUE COPIAR       ////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





        }










        static public List<T> FiltroGenerico_UsandoStoreOLista<T>(
                                 string sidx, string sord, int page, int rows, bool _search, string filters,
                                 ProntoMVC.Data.Models.DemoProntoEntities db,
                                 ref int totalRecords,
                                IEnumerable<T> set
                             )
                               where T : class
        {







            var serializer = new JavaScriptSerializer();
            Filters f = (!_search || string.IsNullOrEmpty(filters)) ? null : serializer.Deserialize<Filters>(filters);

            string s = "true";

            var sb = new StringBuilder();
            var objParams = new List<ObjectParameter>();

            // hay que poner lo del FM y sacar los espacios en los nombres de las columnas
            if (f != null)
            {
                f.CrearFiltro<T>(sb, objParams, true);
                s = sb.ToString();

                //s = s.Replace("it.", "");
                //s = s.Replace("@p0", "\"" +  objParams[0].Value.ToString() + "\"");
                //set.AsQueryable().Where(s, objParams[0].Value.ToString()).ToList();  // este where es de dynamic, no de EF
            }



            // var filteredQuery = set.Where(x=>x.IdImputacion==1);
            // String.Format("{1
            //s = s.Replace("@0", "\"" + objParams[0].Value.ToString() + "\"");
            //s = "true";
            //s = "(Comp=\"ND\")";
            // s = "(Comp != NULL AND Comp.Contains(\"ND\"))";
            // http://stackoverflow.com/questions/18387153/linq-query-fails-only-on-contains-object-reference-not-set-to-an-instance-of-an

            IQueryable<T> filteredQuery;
            try
            {
                filteredQuery = set.AsQueryable().Where(s, objParams.Select(x => x.Value).ToArray());
            }
            catch (Exception)
            {
                s = s.Replace(".ToString()", ".Value.ToString()");       //   http://stackoverflow.com/questions/9273991/dynamic-linq-to-entities-where-with-nullable-datetime-column
                filteredQuery = set.AsQueryable().Where(s, objParams.Select(x => x.Value).ToArray());
            }

            //var qqqq = filteredQuery.ToList();
            //   var  q = set.AsQueryable().Where(s, objParams[0].Value).ToList();  // este where es de dynamic, no de EF



            // var sasdasd= f .FilterObjectSet( set);


            //ObjectQuery<CtasCtesD_TXPorTrs_AuxiliarEntityFramework_Result> filteredQuery =
            //    (f == null ? (ObjectQuery<CtasCtesD_TXPorTrs_AuxiliarEntityFramework_Result>)set :
            //    f.FilterObjectSet((ObjectQuery<CtasCtesD_TXPorTrs_AuxiliarEntityFramework_Result>)set));

            //filteredQuery.MergeOption = MergeOption.NoTracking; // we don't want to update the data

            //filteredQuery = filteredQuery.Where("it.IdCuentaGasto IS NOT NULL");

            // var d = filteredQuery.Where(x => x.IdCuentaGasto != null);

            try
            {
                totalRecords = filteredQuery.Count();
            }
            catch (Exception)
            {

                // ¿estas tratando de usar un LIKE sobre una columna que es numerica?
                // ¿pusiste bien el nombre del campo en el modelo de la jqgrid?? (ejemplo: pusiste "Subrubro" en lugar de "Subrubro.Descripcion"?)
                throw;
            }







            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause
            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause
            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause
            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause
            // http://stackoverflow.com/questions/3791060/how-to-use-objectquery-with-where-filter-separated-by-or-clause


            List<T> pagedQuery = filteredQuery.OrderBy(sidx + " " + sord).Skip((page - 1) * rows).Take(rows).ToList();
            //.Skip( sidx + " " + sord, "@skip",
            //       new ObjectParameter("skip", (page - 1) * rows))
            //.Top("@limit", new ObjectParameter("limit", rows));
            // to be able to use ToString() below which is NOT exist in the LINQ to Entity


            return pagedQuery;

        }


        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        public void CrearFiltro<T>(StringBuilder sb, List<ObjectParameter> objParams, bool EsParaLinqDynamic = false)
        {


            foreach (Rule rule in rules)
            {

                PropertyInfo propertyInfo = null;

                if (rule.field.Split('.').Length == 2) // si usamos más niveles, hay que modificar esto
                {

                    // Si pasan Empleado1.Nombre, Empleado1 no es un type, sino el nombre del objeto, que en este
                    //      caso especial no tiene el mismo nombre que su tipo ... Cómo hacés ahí?
                    // Tengo que obtener de qué tipo es esa variable


                    PropertyInfo padrepropertyInfo = null;
                    string coleccion = rule.field.Split('.')[0];
                    padrepropertyInfo = typeof(T).GetProperty(coleccion);



                    //propertyInfo = Type.GetType("ProntoMVC.Data.Models." + rule.field.Split('.')[0] + ", ProntoMVC.Data").GetProperty(rule.field.Split('.')[1]); ; 
                    string propiedad = rule.field.Split('.')[1];
                    propertyInfo = padrepropertyInfo.PropertyType.GetProperty(propiedad); ; //target type

                }
                else if (rule.field.Split('.').Length == 1)
                {

                    propertyInfo = typeof(T).GetProperty(rule.field);

                }
                else
                {

                    throw new Exception("si usamos más niveles, hay que modificar esto");
                }


                //PropertyInfo propertyInfo = typeof( Data.Models.Rubro ).GetProperty("Descripcion");
                //                PropertyInfo propertyInfo = typeof(T).GetProperty(rule.field);


                if (propertyInfo == null)
                {
                    // "ojo los nombres de las columnas de la jqgrid deben ser iguales (case sensitive) a los nombres de las propiedades del entitymodel"
                    continue; // skip wrong entries
                }


                if (sb.Length != 0)
                    sb.Append(groupOp);

                var iParam = objParams.Count;

                if (EsParaLinqDynamic)
                    sb.AppendFormat(FormatMapping_ParaLinqDynamic[(int)rule.op], rule.field, iParam);
                else
                    sb.AppendFormat(FormatMapping[(int)rule.op], rule.field, iParam);




                ObjectParameter param;





                // si usás "contains" tenés que usar sí o sí el tipo string
                if (rule.op == Operations.cn) param = new ObjectParameter("p" + iParam, rule.data);

                else
                {


                    switch (propertyInfo.PropertyType.FullName)
                    {
                        case "System.Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]":
                        case "System.Int32":  // int
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

                        case "System.Nullable`1[[System.DateTime, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]":
                        case "System.DateTime": // Edm.Single, in SQL: float
                            param = new ObjectParameter("p" + iParam, DateTime.ParseExact(rule.data, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture));
                            break;

                        default:
                            // el default es string

                            // TODO: Extend to other data types
                            // binary, date, datetimeoffset,
                            // decimal, numeric,
                            // money, smallmoney
                            // and so on


                            if (propertyInfo.PropertyType.FullName.Contains("Nullable"))
                            {
                                // si es nullable, no uses string!!!
                                throw new Exception("Incluir el tipo " + propertyInfo.PropertyType.FullName + " en el selectcase");
                            }

                            param = new ObjectParameter("p" + iParam, rule.data);


                            break;
                    }

                }



                objParams.Add(param);
            }


            // return sb.ToString();

        }


        /// <summary>
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="inputQuery"></param>
        /// <returns></returns>

        internal ObjectQuery<T> FilterObjectSet<T>(ObjectQuery<T> inputQuery) where T : class
        {
            if (rules.Count <= 0)
                return inputQuery;


            var sb = new StringBuilder();
            var objParams = new List<ObjectParameter>(rules.Count);
            CrearFiltro<T>(sb, objParams);


            try
            {
                ObjectQuery<T> filteredQuery = inputQuery.Where(sb.ToString());

                foreach (var objParam in objParams)
                    filteredQuery.Parameters.Add(objParam);

                return filteredQuery;

            }
            catch (Exception x)
            {
                // algun problema en los nombres de columna en el modelo de la jqgrid???               
                throw;
            }



        }
    }
}