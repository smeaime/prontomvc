using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Text;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
using System.Reflection;

namespace ProntoMVC.Controllers
{
    public partial class ProveedorController : ProntoBaseController
    {



        // GET: /Proveedor/
        public virtual ActionResult Index()
        {
            return View();
        }

        public virtual JsonResult GetProveedoresAutocomplete2(string term)
        {

            var q = (from item in db.Proveedores
                     where item.RazonSocial.StartsWith(term) && (item.Eventual ?? "NO") == "NO" && (item.Confirmado ?? "NO") == "SI"
                     orderby item.RazonSocial
                     select new
                     {
                         id = item.IdProveedor,
                         value = item.RazonSocial,
                         codigo = item.CodigoEmpresa,
                         IdCondicionCompra = item.IdCondicionCompra,
                         Contacto = item.Contacto
                     }).Take(20).ToList();

            if (q.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);


            return Json(q, JsonRequestBehavior.AllowGet);

        }




        public virtual JsonResult GetCodigosProveedorAutocomplete(string term)
        {
            if (true) // Starwith o Contains
            {
                var q = (from item in db.Proveedores.Include(c => c.IBCondicion) // .Include(c => c.IBCondicionCat2).Include(c => c.IBCondicionCat3)
                         where item.RazonSocial.ToLower().StartsWith(term) && (item.Eventual ?? "NO") == "NO" && (item.Confirmado ?? "NO") == "SI"// .StartsWith(term, StringComparison.OrdinalIgnoreCase)
                         // where SqlFunctions.StringConvert((decimal?)item.IdArticulo).Contains(term)
                         //where (SqlFunctions.StringConvert((decimal?)item.CodigoProveedor).ToLower().Contains(term.ToLower()) || item.RazonSocial.ToLower().Contains(term.ToLower()))
                         orderby item.RazonSocial
                         select new
                         {
                             id = item.IdProveedor,
                             value = item.RazonSocial,
                             // value = SqlFunctions.StringConvert(item.Codigo) + " " + item.RazonSocial,
                             // value = item.Codigo + " " + item.RazonSocial, // esto trae problemas de COLLATION para linq... lo mejor parece ser resolver esos temas con una vista en sql

                             codigo = item.CodigoProveedor,

                             /////////////////////////////
                             idCodigoIva = item.IdCodigoIva,

                             //////////////////////////////////////////
                             IdIBCondicionPorDefecto = item.IdIBCondicionPorDefecto,
                             //IdIBCondicionPorDefecto2 = item.IdIBCondicionPorDefecto2,
                             //IdIBCondicionPorDefecto3 = item.IdIBCondicionPorDefecto3,
                             //AlicuotaPercepcion1 = (item.IBCondicionCat1).AlicuotaPercepcion,
                             //AlicuotaPercepcion2 = (item.IBCondicionCat2).AlicuotaPercepcion,
                             //AlicuotaPercepcion3 = (item.IBCondicionCat3).AlicuotaPercepcion,
                             ///////////////////////////////////////


                             Email = item.Email,
                             Direccion = item.Direccion,

                             Localidad = item.Localidad.Nombre,
                             Provincia = item.Provincia.Nombre,

                             Telefono = item.Telefono1,
                             Fax = item.Fax,
                             Cuit = item.Cuit,

                             IdCondicionCompra = item.IdCondicionCompra, //.IdCondicionVenta, //por qué no?

                             IdListaPrecios = item.IdListaPrecios //,

                             ,
                             NumeroCAI = ""  // item.num
                             ,
                             VencimientoCAI = ""


                             
                             //item.EsAgenteRetencionIVA,
                             //item.BaseMinimaParaPercepcionIVA,
                             //item.PorcentajePercepcionIVA
                             // letra = EntidadManager.LetraSegunTipoIVA((long)item.IdCodigoIva)
                         }).Take(10).ToList();

                if (q.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);


                if (q.Count == 1)
                {
                    //q.First().NumeroCAI = "2222";
                    //q[0].VencimientoCAI = "adad";
                    //                                SELECT TOP 1 *  
                    //FROM ComprobantesProveedores cp  
                    //WHERE cp.IdProveedor=@IdProveedor or cp.IdProveedorEventual=@IdProveedor  
                    //ORDER BY cp.FechaComprobante DESC,cp.NumeroComprobante2 DESC  

                }


                return Json(q, JsonRequestBehavior.AllowGet);
            }
            else
            {


                var q = (from item in db.Proveedores.Include(c => c.IBCondicion) // .Include(c => c.IBCondicionCat2).Include(c => c.IBCondicionCat3)
                         // where item.RazonSocial.StartsWith(term)
                         // where SqlFunctions.StringConvert((decimal?)item.IdArticulo).Contains(term)
                         where (SqlFunctions.StringConvert((decimal?)item.CodigoProveedor).ToLower().Contains(term.ToLower()) || item.RazonSocial.ToLower().Contains(term.ToLower()))
                         orderby item.RazonSocial
                         select new
                         {
                             id = item.IdProveedor,
                             value = item.RazonSocial,
                             // value = SqlFunctions.StringConvert(item.Codigo) + " " + item.RazonSocial,
                             // value = item.Codigo + " " + item.RazonSocial, // esto trae problemas de COLLATION para linq... lo mejor parece ser resolver esos temas con una vista en sql

                             codigo = item.CodigoProveedor,

                             /////////////////////////////
                             idCodigoIva = item.IdCodigoIva,

                             //////////////////////////////////////////
                             IdIBCondicionPorDefecto = item.IdIBCondicionPorDefecto,
                             //IdIBCondicionPorDefecto2 = item.IdIBCondicionPorDefecto2,
                             //IdIBCondicionPorDefecto3 = item.IdIBCondicionPorDefecto3,
                             //AlicuotaPercepcion1 = (item.IBCondicionCat1).AlicuotaPercepcion,
                             //AlicuotaPercepcion2 = (item.IBCondicionCat2).AlicuotaPercepcion,
                             //AlicuotaPercepcion3 = (item.IBCondicionCat3).AlicuotaPercepcion,
                             ///////////////////////////////////////


                             Email = item.Email,
                             Direccion = item.Direccion,

                             Localidad = item.Localidad.Nombre,
                             Provincia = item.Provincia.Nombre,

                             Telefono = item.Telefono1,
                             Fax = item.Fax,
                             Cuit = item.Cuit,
                             // IdCondicionVenta = item.IdCondicionVenta,
                             IdListaPrecios = item.IdListaPrecios //,

                             //item.EsAgenteRetencionIVA,
                             //item.BaseMinimaParaPercepcionIVA,
                             //item.PorcentajePercepcionIVA
                             // letra = EntidadManager.LetraSegunTipoIVA((long)item.IdCodigoIva)
                         }).Take(10).ToList();
                return Json(q, JsonRequestBehavior.AllowGet);


                


            }

        }



        public virtual JsonResult GetCodigosProveedorAutocompleteEventuales2(int idproveedor)
        {


            var q = db.ComprobantesProveedor
                    .Where(x => x.IdProveedor == idproveedor || x.IdProveedorEventual == idproveedor)
                    .OrderByDescending(x => x.FechaComprobante).ThenByDescending(x => x.NumeroComprobante2).FirstOrDefault();


            if (q==null) return null;
 
            var q2 = new { q.NumeroCAI, q.FechaVencimientoCAI };

            
            //if (q.Count == 1)
            //{
            //    //q[0].NumeroCAI = "2222";
            //    // q[0].VencimientoCAI = "adad";
            //    //                                SELECT TOP 1 *  
            //    //FROM ComprobantesProveedores cp  
            //    //WHERE cp.IdProveedor=@IdProveedor or cp.IdProveedorEventual=@IdProveedor  
            //    //ORDER BY cp.FechaComprobante DESC,cp.NumeroComprobante2 DESC  

            //}



            return Json(q2, JsonRequestBehavior.AllowGet);
        }



        public virtual JsonResult GetCodigosProveedorAutocompleteEventuales(string term)
        {




            if (true) // Starwith o Contains
            {
                var q = (from item in db.Proveedores.Include(c => c.IBCondicion) // .Include(c => c.IBCondicionCat2).Include(c => c.IBCondicionCat3)
                         where item.RazonSocial.ToLower().StartsWith(term) // && (item.Eventual ?? "NO") == "NO" && (item.Confirmado ?? "NO") == "SI"// .StartsWith(term, StringComparison.OrdinalIgnoreCase)
                         // where SqlFunctions.StringConvert((decimal?)item.IdArticulo).Contains(term)
                         //where (SqlFunctions.StringConvert((decimal?)item.CodigoProveedor).ToLower().Contains(term.ToLower()) || item.RazonSocial.ToLower().Contains(term.ToLower()))
                         orderby item.RazonSocial
                         select new
                         {
                             id = item.IdProveedor,
                             value = item.RazonSocial,
                             // value = SqlFunctions.StringConvert(item.Codigo) + " " + item.RazonSocial,
                             // value = item.Codigo + " " + item.RazonSocial, // esto trae problemas de COLLATION para linq... lo mejor parece ser resolver esos temas con una vista en sql

                             codigo = item.CodigoProveedor,

                             /////////////////////////////
                             idCodigoIva = item.IdCodigoIva,

                             //////////////////////////////////////////
                             IdIBCondicionPorDefecto = item.IdIBCondicionPorDefecto,
                             //IdIBCondicionPorDefecto2 = item.IdIBCondicionPorDefecto2,
                             //IdIBCondicionPorDefecto3 = item.IdIBCondicionPorDefecto3,
                             //AlicuotaPercepcion1 = (item.IBCondicionCat1).AlicuotaPercepcion,
                             //AlicuotaPercepcion2 = (item.IBCondicionCat2).AlicuotaPercepcion,
                             //AlicuotaPercepcion3 = (item.IBCondicionCat3).AlicuotaPercepcion,
                             ///////////////////////////////////////


                             Email = item.Email,
                             Direccion = item.Direccion,

                             Localidad = item.Localidad.Nombre,
                             Provincia = item.Provincia.Nombre,

                             Telefono = item.Telefono1,
                             Fax = item.Fax,
                             Cuit = item.Cuit,

                             IdCondicionCompra = item.IdCondicionCompra, //.IdCondicionVenta, //por qué no?

                             IdListaPrecios = item.IdListaPrecios //,

                             ,
                             NumeroCAI = "" // item.num
                             ,
                             VencimientoCAI = ""

                             //item.EsAgenteRetencionIVA,
                             //item.BaseMinimaParaPercepcionIVA,
                             //item.PorcentajePercepcionIVA
                             // letra = EntidadManager.LetraSegunTipoIVA((long)item.IdCodigoIva)
                         }).Take(10).ToList();

                if (q.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);


                if (q.Count == 1)
                {
                    //q[0].NumeroCAI = "2222";
                   // q[0].VencimientoCAI = "adad";
                    //                                SELECT TOP 1 *  
                    //FROM ComprobantesProveedores cp  
                    //WHERE cp.IdProveedor=@IdProveedor or cp.IdProveedorEventual=@IdProveedor  
                    //ORDER BY cp.FechaComprobante DESC,cp.NumeroComprobante2 DESC  

                }



                return Json(q, JsonRequestBehavior.AllowGet);
            }
            else
            {


                var q = (from item in db.Proveedores.Include(c => c.IBCondicion) // .Include(c => c.IBCondicionCat2).Include(c => c.IBCondicionCat3)
                         // where item.RazonSocial.StartsWith(term)
                         // where SqlFunctions.StringConvert((decimal?)item.IdArticulo).Contains(term)
                         where (SqlFunctions.StringConvert((decimal?)item.CodigoProveedor).ToLower().Contains(term.ToLower()) || item.RazonSocial.ToLower().Contains(term.ToLower()))
                         orderby item.RazonSocial
                         select new
                         {
                             id = item.IdProveedor,
                             value = item.RazonSocial,
                             // value = SqlFunctions.StringConvert(item.Codigo) + " " + item.RazonSocial,
                             // value = item.Codigo + " " + item.RazonSocial, // esto trae problemas de COLLATION para linq... lo mejor parece ser resolver esos temas con una vista en sql

                             codigo = item.CodigoProveedor,

                             /////////////////////////////
                             idCodigoIva = item.IdCodigoIva,

                             //////////////////////////////////////////
                             IdIBCondicionPorDefecto = item.IdIBCondicionPorDefecto,
                             //IdIBCondicionPorDefecto2 = item.IdIBCondicionPorDefecto2,
                             //IdIBCondicionPorDefecto3 = item.IdIBCondicionPorDefecto3,
                             //AlicuotaPercepcion1 = (item.IBCondicionCat1).AlicuotaPercepcion,
                             //AlicuotaPercepcion2 = (item.IBCondicionCat2).AlicuotaPercepcion,
                             //AlicuotaPercepcion3 = (item.IBCondicionCat3).AlicuotaPercepcion,
                             ///////////////////////////////////////


                             Email = item.Email,
                             Direccion = item.Direccion,

                             Localidad = item.Localidad.Nombre,
                             Provincia = item.Provincia.Nombre,

                             Telefono = item.Telefono1,
                             Fax = item.Fax,
                             Cuit = item.Cuit,
                             // IdCondicionVenta = item.IdCondicionVenta,
                             IdListaPrecios = item.IdListaPrecios //,

                             //item.EsAgenteRetencionIVA,
                             //item.BaseMinimaParaPercepcionIVA,
                             //item.PorcentajePercepcionIVA
                             // letra = EntidadManager.LetraSegunTipoIVA((long)item.IdCodigoIva)
                         }).Take(10).ToList();
                return Json(q, JsonRequestBehavior.AllowGet);

            }

        }

        void CargarViewBag(Proveedor o)
        {
            ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion", o.IdCodigoIva);
            ViewBag.IdEstado = new SelectList(db.Estados_Proveedores, "IdEstado", "Descripcion", o.IdEstado);
            ViewBag.IdProvincia = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvincia);
            ViewBag.IdLocalidad = new SelectList(db.Localidades, "IdLocalidad", "Nombre", o.IdLocalidad);
            ViewBag.IdPais = new SelectList(db.Paises, "IdPais", "Descripcion", o.IdPais);
            //ViewBag.Vendedor1 = new SelectList(db.Vendedores, "IdVendedor", "Nombre", o.Vendedor1);
            //ViewBag.Cobrador = new SelectList(db.Vendedores, "IdVendedor", "Nombre", o.Cobrador);
            //ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", o.IdCodigoIva);
            //ViewBag.IdListaPrecios = new SelectList(db.ListasPrecios, "IdListaPrecios", "Descripcion", o.IdListaPrecios);
            //ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            //ViewBag.IdCondicionVenta = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionVenta);
            //ViewBag.IdBancoDebito = new SelectList(db.Bancos, "IdBanco", "Nombre", o.IdBancoDebito);
            //ViewBag.IdBancoGestionador = new SelectList(db.Bancos, "IdBanco", "Nombre", o.IdBancoGestionador);
            //ViewBag.IGCondicion = new SelectList(db.IGCondiciones, "IdIGCondicion", "Descripcion", o.IGCondicion);
            //ViewBag.IdIBCondicionPorDefecto = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicionPorDefecto);
            //ViewBag.IdIBCondicionPorDefecto2 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicionPorDefecto2);
            //ViewBag.IdIBCondicionPorDefecto3 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicionPorDefecto3);
            //ViewBag.IdProvinciaEntrega = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvinciaEntrega);
            //ViewBag.IdLocalidadEntrega = new SelectList(db.Localidades, "IdLocalidad", "Nombre", o.IdLocalidadEntrega);
        }

        public virtual ActionResult Edit(int id)
        {


            Proveedor o;
            if (id <= 0)
            {
                o = new Proveedor();
            }
            else
            {
                o = db.Proveedores
                    //.Include(x => x.cu).Include(x => x.CuentaMonedaExt)
                    //.Include(x => x.Localidad).Include(x => x.LocalidadEntrega)
                        .SingleOrDefault(x => x.IdProveedor == id);

            }
            CargarViewBag(o);

            // o.grilla = new DetalleProveedorsJqGridModel();


            return View(o);
        }


        //////////////////////////////////////////////////////////////////////////////////////////////////////////

        public bool Validar(ProntoMVC.Data.Models.Proveedor o, ref string sErrorMsg)
        {
            // una opcion es extender el modelo autogenerado, para ensoquetar ahí las validaciones
            // si no, podemos usar una funcion como esta, y devolver los  errores de dos maneras:
            // con ModelState.AddModelError si los devolvemos en una ViewResult,
            // o con un array de strings si es una JsonResult.
            //
            // If you are returning JSON, you cannot use ModelState.
            // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json

            if (o.IdEstado == null) sErrorMsg += "\n" + "Falta el estado";

            if (o.RazonSocial == "")
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta la razón social del proveedor";
                // return false;
            }


            if ((o.Cuit ?? "") == "")
            {
                // ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                sErrorMsg += "\n" + "Falta el CUIT del proveedor";
                // return false;
            }

            string s="asdasd";
            try
            {
                s = o.Cuit.NullSafeToString().Replace("-", "").PadLeft(11);
                o.Cuit = s.Substring(0, 2) + "-" + s.Substring(2, 8) + "-" + s.Substring(10, 1);
            }
            catch (Exception)
            {
                //throw;
            }

            if (!Generales.mkf_validacuit(o.Cuit.NullSafeToString()))
            {
                sErrorMsg += "\n" + "El CUIT es incorrecto";
            }






            // si los datos no estan confirmados, se consideran FRUTA, y por eso no pueden generar asiento contable en el fondo fijo


            if (db.Proveedores.Any(x => x.Cuit == s && x.Confirmado=="SI"))
            {
                sErrorMsg += "\n" + "El CUIT ya existe";
            }

            if (db.Proveedores.Any(x => x.RazonSocial == s && x.Confirmado=="SI"))
            {
                sErrorMsg += "\n" + "La razon social y CUIT ya existen";
            }



            if (sErrorMsg != "") return false;
            else return true;

        }



        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////


        [HttpPost]
        public virtual JsonResult BatchUpdate([Bind(Exclude = "IdDetalleProveedor,IdDetalleProveedorLugarEntrega")] Proveedor Proveedor)// el Exclude es para las altas, donde el Id viene en 0
        {

            // http://stackoverflow.com/questions/9436300/jsonresult-actionresult-json-datacontractjson-serializer-purpose-differenc
            // http://stackoverflow.com/questions/4743741/difference-between-viewresult-and-actionresult


            try
            {
                try
                {
                    var s = Proveedor.Cuit.Replace("-", "");
                    Proveedor.Cuit = s.Substring(0, 2) + "-" + s.Substring(2, 8) + "-" + s.Substring(10, 1);

                }
                catch (Exception)
                {

                    // throw;
                }

                string erar = "";

                if (!Validar(Proveedor, ref erar))
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    List<string> errors = new List<string>();
                    errors.Add(erar);
                    return Json(errors);
                }

                //Proveedor.CodigoProveedor = Proveedor.TipoProveedor.ToString() + Proveedor.CodigoProveedor.ToString();
                if (!Generales.mkf_validacuit(Proveedor.Cuit.NullSafeToString()))
                {

                    //  como devuelvo los errores del ModelState si uso un JsonResult en lugar de una View(ViewResult)???
                    // con View puedo devolver el objeto joya... con Json qué serializo? 
                    // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json

                    ModelState.AddModelError("Cuit", "El CUIT es incorrecto"); //http://msdn.microsoft.com/en-us/library/dd410404(v=vs.90).aspx
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    List<string> errors = new List<string>();
                    errors.Add("El CUIT es incorrecto");
                    //  errors.Add("Error 2");
                    return Json(errors);
                    // return Json(new { Success = 1, ex = "El CUIT es incorrecto" });
                    // CargarViewBag(Proveedor);
                    // return View(Proveedor);
                }


                // ModelState.Remove("IdDetalleProveedor");
                if (ModelState.IsValid || true) //no le encontré la vuelta a no validar el Id de las colecciones
                {
                    string tipomovimiento = "";
                    if (Proveedor.IdProveedor > 0)
                    {
                        // http://stackoverflow.com/questions/7968598/entity-4-1-updating-an-existing-parent-entity-with-new-child-entities

                        var EntidadOriginal = db.Proveedores.Where(p => p.IdProveedor == Proveedor.IdProveedor)
                                                .Include(p => p.DetalleProveedores)
                                                .SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Proveedor);



                        /////////////////////////////////////////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////////////////////////////////////////
                        foreach (var dr in Proveedor.DetalleProveedores)
                        {
                            var DetalleEntidadOriginal = EntidadOriginal.DetalleProveedores.Where(c => c.IdDetalleProveedor == dr.IdDetalleProveedor && dr.IdDetalleProveedor > 0).SingleOrDefault();
                            if (DetalleEntidadOriginal != null)
                            {
                                var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                DetalleEntidadEntry.CurrentValues.SetValues(dr);
                            }
                            else
                            {
                                EntidadOriginal.DetalleProveedores.Add(dr);
                            }
                        }

                        foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleProveedores.Where(c => c.IdDetalleProveedor != 0).ToList())
                        {
                            if (!Proveedor.DetalleProveedores.Any(c => c.IdDetalleProveedor == DetalleEntidadOriginal.IdDetalleProveedor))
                                EntidadOriginal.DetalleProveedores.Remove(DetalleEntidadOriginal);
                        }

                        /////////////////////////////////////////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////////////////////////////////////////

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        //if (Proveedor.SubNumero == 1)
                        //{
                        //    tipomovimiento = "N";
                        //    Parametros parametros = db.Parametros.Find(1);
                        //    Proveedor.Numero = parametros.ProximoProveedor;
                        //}
                        db.Proveedores.Add(Proveedor);
                    }
                    db.SaveChanges();

                    return Json(new { Success = 1, IdProveedor = Proveedor.IdProveedor, ex = "" });
                }
                else
                {
                    // el IsValid se quejaba en las altas     
                    // http://stackoverflow.com/questions/2397563/asp-net-mvc-modelstate-isvalid-is-false-how-to-bypass
                    // Try:
                    //public ActionResult CreateCustomer([Bind(Exclude = "Id")]GWCustomer customer)
                    //This will exclude Id from binding and validation.

                    var allErrors = ModelState.Values.SelectMany(v => v.Errors);
                    var mensajes = string.Join("; ", from i in allErrors select (i.ErrorMessage + (i.Exception == null ? "" : i.Exception.Message)));

                    ViewBag.Errores = mensajes;

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

                // me saltaba "[...] because it has a DefiningQuery and no element exists in the element to support the current operation."
                // porque faltaba la PK en la tabla DetalleProveedorsLugaresEntrega
                // http://stackoverflow.com/questions/7583770/unable-to-update-the-entityset-because-it-has-a-definingquery-and-no-updatefu

                return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }




        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////

        public virtual ActionResult Listado_jqGrid(string sidx, string sord, int? page, int? rows,
                                       bool _search, string searchField, string searchOper, string searchString,
                                       string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.Proveedores.AsQueryable();
            //if (IdObra != string.Empty)
            //{
            //    int IdObra1 = Convert.ToInt32(IdObra);
            //    Fac = (from a in Fac where a.IdObra == IdObra1 select a).AsQueryable();
            //}
            //if (FechaInicial != string.Empty)
            //{
            //    DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            //    DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            //    Fac = (from a in Fac where a.FechaProveedor >= FechaDesde && a.FechaProveedor <= FechaHasta select a).AsQueryable();
            //}
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numeroProveedor":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaProveedor":
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

            var Req1 = (from a in Fac
                        select new
                        {
                            IdIBCondicion = a.IdProveedor,
                            //FechaProveedor = ,
                            //NumeroObra=a.Obra.NumeroObra,
                            //Libero=a.Empleados.Nombre,
                            //Aprobo = a.Empleados1.Nombre,
                            //Sector=a.Sectores.Descripcion,
                            //Detalle=a.Detalle
                        }).Where(campo).ToList();

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            //switch (sidx.ToLower())
            //{
            //    case "numeroProveedor":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroProveedor);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroProveedor);
            //        break;
            //    case "fechaProveedor":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.FechaProveedor);
            //        else
            //            Fac = Fac.OrderBy(a => a.FechaProveedor);
            //        break;
            //    case "numeroobra":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Obra.NumeroObra);
            //        else
            //            Fac = Fac.OrderBy(a => a.Obra.NumeroObra);
            //        break;
            //    case "libero":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Empleados.Nombre);
            //        else
            //            Fac = Fac.OrderBy(a => a.Empleados.Nombre);
            //        break;
            //    case "aprobo":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Empleados1.Nombre);
            //        else
            //            Fac = Fac.OrderBy(a => a.Empleados1.Nombre);
            //        break;
            //    case "sector":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Sectores.Descripcion);
            //        else
            //            Fac = Fac.OrderBy(a => a.Sectores.Descripcion);
            //        break;
            //    case "detalle":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Detalle);
            //        else
            //            Fac = Fac.OrderBy(a => a.Detalle);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroProveedor);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroProveedor);
            //        break;
            //}

            var data = (from a in Fac
                        //join c in db.IngresoBrutos on a.IdIBCondicion equals c.IdIBCondicion
                        select a).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdProveedor.ToString(),
                            cell = new string[] { 
                                
                                "<a href="+ Url.Action("Edit",new {id = a.IdProveedor} )  +" target='_blank' >Editar</>" 
                                ,
                                a.IdProveedor.NullSafeToString(),

                                a.RazonSocial.NullSafeToString(),
                                //a.Codigo.NullSafeToString(),
                                //a.Direccion.NullSafeToString(),                                
                                //(a.Localidad==null ? string.Empty : a.Localidad.Nombre ).ToString(),
                                //a.CodigoPostal.NullSafeToString(),
                                // (a.Provincia==null ? string.Empty : a.Provincia.Nombre ).ToString(),
                                // (a.Pais==null ? string.Empty : a.Pais.Descripcion ).ToString(),
                                //a.Telefono.NullSafeToString(),
                                
                                //a.Fax.NullSafeToString(),
                                //a.Email,a.Cuit,
                                //(a.DescripcionIva==null ? string.Empty : a.DescripcionIva.Descripcion ).ToString(), //espantoso
                                //a.FechaAlta.NullSafeToString(),a.Contacto,a.DireccionEntrega
                                //,(a.LocalidadEntrega==null ? string.Empty : a.LocalidadEntrega.Nombre ).ToString(), //espantoso
                                //(a.ProvinciaEntrega==null ? string.Empty : a.ProvinciaEntrega.Nombre ).ToString(), //espantoso
                                a.CodigoPresto,

                                //(a.Vendedor==null ? string.Empty : a.Vendedor.Nombre ).ToString(), //espantoso
                                //(a.VendedorCobrador==null ? string.Empty : a.VendedorCobrador.Nombre ).ToString(), //espantoso
                                //(a.Estados_Proveedores==null ? string.Empty : a.Estados_Proveedores.Descripcion ).ToString(), //espantoso
                                //a.NombreFantasia.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.IdUsuarioIngreso.NullSafeToString(),
                                a.FechaIngreso.NullSafeToString(),
                                a.IdUsuarioModifico.NullSafeToString(),
                                a.FechaModifico.NullSafeToString(),
                                // CondIIBB harcodea usando  IBCondicion
                            // IBCondiciones.Descripcion as [Cat.IIBB],  este usa la descricion el IdIBcondicionpordefecto
                                "",
                                
                                
                                
                                  //(a.IBCondicione==null ? string.Empty : a.IBCondicione.Descripcion ).ToString(), //espantoso
                                  //a.IBNumeroInscripcion,
                                  //(a.Cuenta==null ? string.Empty : a.Cuenta.Descripcion ).ToString(), //espantoso
                                  //(a.CuentaMonedaExt==null ? string.Empty : a.CuentaMonedaExt.Descripcion ).ToString(), //espantoso
                              
 
                                
                            
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

    }
}
