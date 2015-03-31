using System;
using System.Collections.Generic;
using System.Linq;
using Repo;
using ProntoMVC.Data.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Text;
using System.Reflection;
using System.Data.Entity.Core.Objects;


namespace Servicio
{

    public class ComprobanteProveedorService
    {
        private Repository<Parametros> parametroRepositorio;
        private Repository<ComprobanteProveedor> comprobantesproveedorRepositorio;
        private Repository<Condiciones_Compra> condicioncomprasRepositorio;
        private Repository<DetalleComprobantesProveedore> detallecomprobantesproveedorRepositorio;
        private Repository<PlazosEntrega> plazosentregasRepositorio;
        private Repository<Moneda> monedasRepositorio;
        private Repository<Empleado> empleadosRepositorio;



        public ComprobanteProveedorService(UnitOfWork unitOfWork)
        {
            comprobantesproveedorRepositorio = unitOfWork.ComprobantesproveedorRepositorio;
            detallecomprobantesproveedorRepositorio = unitOfWork.DetalleComprobantesproveedorRepositorio;
            parametroRepositorio = unitOfWork.ParametrosRepositorio;
            condicioncomprasRepositorio = unitOfWork.CondicioncomprasRepositorio;

            plazosentregasRepositorio = unitOfWork.PlazosEntregasRepositorio;
            monedasRepositorio = unitOfWork.MonedasRepositorio;
            empleadosRepositorio = unitOfWork.EmpleadosRepositorio;

            _referenciaalUoW = unitOfWork;
            //  usuarioService = new UsuarioService(unitOfWork);
        }










        public IEnumerable<Condiciones_Compra> Condiciones_Compras_Listado()
        {
            return condicioncomprasRepositorio.ObtenerTodos().ToList();
        }


        public Parametros Parametros()
        {
            return parametroRepositorio.ObtenerTodos().FirstOrDefault();
        }


        public IEnumerable<Moneda> Monedas_Listado()
        {
            return monedasRepositorio.ObtenerTodos().ToList();
        }


        public IEnumerable<PlazosEntrega> PlazosEntregas_Listado()
        {
            return plazosentregasRepositorio.ObtenerTodos().ToList();
        }

        public IEnumerable<Empleado> Empleados_Listado()
        {
            return empleadosRepositorio.ObtenerTodos().ToList();
        }


        public Empleado EmpleadoById(int? Id)
        {
            return empleadosRepositorio.ObtenerPorId(Id ?? 0);
        }




        public virtual System.Collections.Generic.List<ComprobanteProveedor> ObtenerTodos(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString,
                                    string FechaInicial, string FechaFinal, string rendicion, string idcuenta)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //if (sidx == "Numero") sidx = "NumeroComprobanteProveedor"; // como estoy haciendo "select a" (el renglon entero) en la linq antes de llamar jqGridJson, no pude ponerle el nombre explicito
            //if (searchField == "Numero") searchField = "NumeroComprobanteProveedor"; 



            var Entidad = comprobantesproveedorRepositorio.ObtenerTodos(); // comprobantesproveedorRepositorio;




            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                Entidad = (from a in Entidad where a.FechaComprobante >= FechaDesde && a.FechaComprobante <= FechaHasta select a).AsQueryable();
            }
            if (rendicion != string.Empty)
            {
                int rend = Generales2.Val(rendicion);
                Entidad = (from a in Entidad where a.NumeroRendicionFF == rend select a).AsQueryable();
            }



            if (idcuenta != string.Empty)
            {
                int idcuentaff = Generales2.Val(idcuenta);
                Entidad = (from a in Entidad where a.IdCuenta == idcuentaff select a).AsQueryable();
            }

            var usuario = new Empleado(); // glbUsuario; 

            int ffasociado = usuario.IdCuentaFondoFijo ?? 0;

            if (ffasociado > 0)
            {
                Entidad = (from a in Entidad where a.IdCuenta == ffasociado select a).AsQueryable();
            }

            int obraasociada = usuario.IdObraAsignada ?? 0;
            if (obraasociada > 0)
            {
                Entidad = (from a in Entidad where a.IdObra == obraasociada select a).AsQueryable();
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

                        campo = String.Format("Proveedor.RazonSocial.Contains(\"{0}\") OR NumeroReferencia = {1} ", searchString, Generales2.Val(searchString));
                        break;
                }
            }
            else
            {
                campo = "true";
            }

            campo = "true";

            var Entidad1 = (from a in Entidad.Where(campo) select a);

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad.Include("Proveedor")
                        select a

                ).Where(campo)
                // .OrderBy((sidx == "Numero" ? "NumeroReferencia" : sidx) + " " + sord)
                .OrderBy("IdComprobanteProveedor desc")
                .Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();


            return data;
        }






        public void Guardar(ComprobanteProveedor ComprobanteProveedor)
        {
            var db = comprobantesproveedorRepositorio;



            // comprobantesproveedorRepositorio.Insertar(ComprobanteProveedor);

            string tipomovimiento = "";



            // Logica_RecalcularTotales(ref ComprobanteProveedor);
            Logica_ActualizarCuentaCorriente(ComprobanteProveedor);
            Logica_AsientoRegistroContable(ComprobanteProveedor, db);
            Logica_Actualizaciones(ComprobanteProveedor);



            if (ComprobanteProveedor.IdComprobanteProveedor > 0)
            {

                // db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;

                comprobantesproveedorRepositorio.Actualizar(ComprobanteProveedor);
            }
            else
            {

                //var param = parametroRepositorio.ObtenerPorId(1);
                var param = comprobantesproveedorRepositorio.HACKEADOcontext.Parametros.FirstOrDefault();
                ComprobanteProveedor.NumeroReferencia = param.ProximoComprobanteProveedorReferencia;
                param.ProximoComprobanteProveedorReferencia += 1;


                comprobantesproveedorRepositorio.Insertar((ComprobanteProveedor)ComprobanteProveedor);
                parametroRepositorio.Actualizar(param);
            }




            // db.SaveChanges();


        }




        private void Actualizar(ComprobanteProveedor ComprobanteProveedor)
        {

            /*
            //como hago usar estas llamadas al db?
        http://programmers.stackexchange.com/questions/170120/how-should-i-implement-the-repository-pattern-for-complex-object-models
        http://programmers.stackexchange.com/questions/180851/why-shouldnt-i-use-the-repository-pattern-with-entity-framework
            http://stackoverflow.com/questions/7171023/repository-pattern-with-entity-framework-4-1-and-parent-child-relationships
             * http://stackoverflow.com/questions/20471927/how-to-fake-dbcontext-entry-method-in-entity-framework-with-repository-pattern
                 
             * supongamos que en este servicio no uso repositorio. Me tienen que pasar el db (que es el unitofwork)
             * 
                 
				 
             What I mean here, is that in your object model, some entities are likely contained in others in a master-detail relationship. If your entity is highly dependant on another, do not create a repository for this entity alone because it won't likely be persisted by itself. Instead, you will create a repository for each parent class, and you will make sure that the child entities and other relations are persisted at the same time
				 
             http://stackoverflow.com/questions/7171023/repository-pattern-with-entity-framework-4-1-and-parent-child-relationships
             http://stackoverflow.com/questions/6904139/fake-dbcontext-of-entity-framework-4-1-to-test/6904479#6904479
             -The primary reason why I want to use this pattern is to avoid calling EF 4.1 specific data access operations from the domain. I'd rather call generic CRUD operations from a IRepository interface. This will make testing easier
            -NO, it will not make your testing easier. You exposed IQueryable so your repository is not unit testable.

            http://stackoverflow.com/questions/718624/to-return-iqueryablet-or-not-return-iqueryablet
            The cons; non-testability:
             */




            var EntidadOriginal = ObtenerPorId(ComprobanteProveedor.IdComprobanteProveedor);




            var EntidadEntry = comprobantesproveedorRepositorio.Entry(EntidadOriginal);
            EntidadEntry.CurrentValues.SetValues(ComprobanteProveedor);

            foreach (var dr in ComprobanteProveedor.DetalleComprobantesProveedores)
            {
                var DetalleEntidadOriginal = EntidadOriginal.DetalleComprobantesProveedores.Where(c => c.IdDetalleComprobanteProveedor == dr.IdDetalleComprobanteProveedor && dr.IdDetalleComprobanteProveedor > 0).SingleOrDefault();
                if (DetalleEntidadOriginal != null)
                {
                    var DetalleEntidadEntry = detallecomprobantesproveedorRepositorio.Entry(DetalleEntidadOriginal);
                    DetalleEntidadEntry.CurrentValues.SetValues(dr);
                }
                else
                {
                    EntidadOriginal.DetalleComprobantesProveedores.Add(dr);
                }
            }

            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleComprobantesProveedores.Where(c => c.IdDetalleComprobanteProveedor != 0).ToList())
            {
                if (!ComprobanteProveedor.DetalleComprobantesProveedores.Any(c => c.IdDetalleComprobanteProveedor == DetalleEntidadOriginal.IdDetalleComprobanteProveedor))
                    EntidadOriginal.DetalleComprobantesProveedores.Remove(DetalleEntidadOriginal);
            }



            comprobantesproveedorRepositorio.SetModified(EntidadOriginal);
        }



        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///         MIGRAR TODO ESTO. DEJAR DE USAR EL CONTEXT EN EL SERVICIO
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




        private UnitOfWork _referenciaalUoW;



        // usar delegate?

        public ObjectResult<AutorizacionesPorComprobante> AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante(int idFormulario, int idComprobante)
        {

            return _referenciaalUoW.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante(idFormulario, idComprobante);
        }



        public System.Data.Entity.Core.Objects.ObjectResult<Nullable<int>> Autorizaciones_TX_CantidadAutorizaciones(Nullable<int> idFormulario, Nullable<decimal> importe, Nullable<int> idComprobante)
        {

            return _referenciaalUoW.CantidadAutorizaciones(idFormulario, importe, idComprobante);
        }




        public IEnumerable<DescripcionIva> DescripcionIvas_Listado()
        {
            return comprobantesproveedorRepositorio.HACKEADOcontext.DescripcionIvas;

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                return c.DescripcionIvas;
            }
        }

        public IEnumerable<TiposComprobante> TiposComprobantes_Listado()
        {
            return comprobantesproveedorRepositorio.HACKEADOcontext.TiposComprobantes.ToList();

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                return c.TiposComprobantes;
            }
        }

        public IEnumerable<Cotizacione> Cotizaciones_Listado()
        {
            //using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)

            ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext;
            return c.Cotizaciones.ToList();

        }

        public IEnumerable<Cuenta> Cuentas_Listado()
        {
            return comprobantesproveedorRepositorio.HACKEADOcontext.Cuentas;


            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                return c.Cuentas;
            }
        }
        public IEnumerable<Unidad> Unidades_Listado()
        {
            return comprobantesproveedorRepositorio.HACKEADOcontext.Unidades;


            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                return c.Unidades;
            }
        }
        public IEnumerable<Proveedor> Proveedores_Listado()
        {
            return comprobantesproveedorRepositorio.HACKEADOcontext.Proveedores;

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                return c.Proveedores;
            }
        }
        public IEnumerable<Subdiario> Subdiarios_Listado()
        {
            return comprobantesproveedorRepositorio.HACKEADOcontext.Subdiarios;

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                return c.Subdiarios;
            }
        }



        public int ObtenerCantidadPorUsuario(int codigoUsuario)
        {
            return comprobantesproveedorRepositorio.ObtenerTodos().Count(m => m.IdCodigoAduana == codigoUsuario);
        }


        public Obra ObrasById(int? Id)
        {

            return comprobantesproveedorRepositorio.HACKEADOcontext.Obras.Find(Id);

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                //  DbSet<Condiciones_Compra> repo = c.Cuentas;

                return c.Obras.Find(Id);

            }

        }

        public Cuenta CuentasById(int? Id)
        {

            return comprobantesproveedorRepositorio.HACKEADOcontext.Cuentas.Find(Id);

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                //  DbSet<Condiciones_Compra> repo = c.Cuentas;

                return c.Cuentas.Find(Id);

            }

        }

        public TiposComprobante TiposComprobantesById(int? Id)
        {

            return comprobantesproveedorRepositorio.HACKEADOcontext.TiposComprobantes.Find(Id);

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                //  DbSet<Condiciones_Compra> repo = c.Cuentas;

                return c.TiposComprobantes.Find(Id);

            }

        }


        public Proveedor ProveedoresById(int? Id)
        {

            return comprobantesproveedorRepositorio.HACKEADOcontext.Proveedores.Find(Id);

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                //  DbSet<Condiciones_Compra> repo = c.Cuentas;

                return c.Proveedores.Find(Id);

            }

        }


        public class comboitem
        {
            public int id;
            public string value;
            public string descripcion;
        }


        public virtual List<comboitem> GetObrasAutocomplete2(string term)
        {
            const int MAXLISTA = 100;


            ProntoMVC.Data.Models.DemoProntoEntities db = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext;

            var q = (from item in db.Obras
                     where (item.NumeroObra.ToLower() + " - " + item.Descripcion.ToLower()).Contains(term.ToLower())
                           && item.Activa != "NO"
                     //.StartsWith(term.ToLower())
                     //            where SqlFunctions.StringConvert((decimal?)item.IdArticulo).Contains(term) ||

                     orderby item.NumeroObra
                     select new comboitem
                     {
                         id = item.IdObra,
                         value = item.NumeroObra + " - " + (item.Descripcion ?? ""),
                         descripcion = (item.Descripcion ?? "")
                         // NumeroObra = y.NumeroObra + " - " + (y.Descripcion ?? "")
                         //iva = item.AlicuotaIVA,
                         //IdUnidad = item.IdUnidad,
                         //Unidad = item.Unidad.Abreviatura
                     }).Take(MAXLISTA).ToList();

            return q;
        }













        public virtual ComprobanteProveedor ObtenerPorId(int id)
        {
            // http://stackoverflow.com/questions/1230571/advantage-of-creating-a-generic-repository-vs-specific-repository-for-each-obje

            //trampa: esta es una implementacion del metodo virtual de lo que sería un repositorio específico de ComprobanteProveedor
            ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext;


            return c.ComprobantesProveedor
                .Include(x => x.DetalleComprobantesProveedores)
                .Include(x => x.Proveedor)
               .Include(x => x.Proveedore)
               .Include(x => x.Obra)
               .Include(x => x.Cuenta)
               .SingleOrDefault(x => x.IdComprobanteProveedor == id);


            // como hago para hacer includes con el comprobantesproveedorRepositorio???

            //return comprobantesproveedorRepositorio
            //                .Include(x => x.DetalleComprobantesProveedores)
            //                .Include(x => x.Proveedor)
            //               .Include(x => x.Proveedore)
            //               .Include(x => x.Obra)
            //               .Include(x => x.Cuenta)
            //               .SingleOrDefault(x => x.IdComprobanteProveedor == id);


        }





        public virtual IQueryable<ComprobanteProveedor> ObtenerTodos()
        {
            /*
                   On the other hand, now you have given your users a shotgun. They can do things which you may not have intended 
                   (over using .include(), doing heavy heavy queries and doing "in-memory" filtering in their respective 
                   implementations, etc..), which would basically side-step the layering and behavioral controls because 
                   you have given full access.
             * 
             * http://stackoverflow.com/questions/11964578/repository-iqueryable-query-object
             * http://ayende.com/blog/4784/architecting-in-the-pit-of-doom-the-evils-of-the-repository-abstraction-layer
             * 
                   */

            ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext;

            return c.ComprobantesProveedor
                     .Include(x => x.DetalleComprobantesProveedores)
                     .Include(x => x.DescripcionIva)
                     .Include(x => x.Cuenta)
                     .Include(x => x.Proveedor)
                     .Include(x => x.Proveedore)
                     .Include(x => x.Obra)
                         .Where(x => x.IdCuenta != null)
                               .AsQueryable();
        }


        public virtual IQueryable<DetalleComprobantesProveedore> ObtenerTodosDetalle()
        {
            /*
                   On the other hand, now you have given your users a shotgun. They can do things which you may not have intended 
                   (over using .include(), doing heavy heavy queries and doing "in-memory" filtering in their respective 
                   implementations, etc..), which would basically side-step the layering and behavioral controls because 
                   you have given full access.
             * 
             * http://stackoverflow.com/questions/11964578/repository-iqueryable-query-object
             * http://ayende.com/blog/4784/architecting-in-the-pit-of-doom-the-evils-of-the-repository-abstraction-layer
             * 
                   */

            ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext;

            return c.DetalleComprobantesProveedores
                     .Include(x => x.Cuenta)
                               .AsQueryable();
        }




        public void Logica_Actualizaciones(ComprobanteProveedor o)
        {
            //if (!IsNull(ComprobanteProveedor.Fields("IdDiferenciaCambio").Value))
            //{
            //    oDet.Tarea("DiferenciasCambio_MarcarComoGenerada", Array(ComprobanteProveedor.Fields("IdDiferenciaCambio").Value, ComprobanteProveedor.Fields("IdTipoComprobante").Value, ComprobanteProveedor.Fields(0).Value));
            //}

            int mvarIdOrdenPagoActual = 0, mvarIdOrdenPagoAnterior = 0;
            string SC = "";

            if (mvarIdOrdenPagoActual != 0 || mvarIdOrdenPagoAnterior != 0)
            {
                // EntidadManager.Tarea(SC, "OrdenesPago_ActualizarDiferenciaBalanceo", mvarIdOrdenPagoActual, mvarIdOrdenPagoAnterior);
            }


            // log
        }

        public void Logica_EliminarRegistroAnterior(ComprobanteProveedor o) { }

        public void Logica_ActualizarCuentaCorriente(ComprobanteProveedor o)
        {

            var mImporteAnterior = 0;
            var mTotalAnteriorDolar = 0;


            ProntoMVC.Data.Models.CuentasCorrientesDeudor a = new CuentasCorrientesDeudor();





            //if (o.IdFactura <= 0)
            //{
            //    //            mImporteAnterior = iisNull(.Item("ImporteTotal"), 0)
            //    //            mTotalAnteriorDolar = iisNull(.Item("ImporteTotalDolar"), 0)
            //}
            //a.IdCliente = o.IdCliente;
            //a.NumeroComprobante = o.NumeroFactura;
            //a.Fecha = o.FechaFactura; // mvarFecha;
            //a.IdTipoComp = 1;
            //a.FechaVencimiento = o.FechaVencimiento;
            //a.IdComprobante = o.IdFactura;
            //a.Cotizacion = o.CotizacionDolar;
            //a.IdMoneda = o.IdMoneda;
            //a.CotizacionMoneda = o.CotizacionMoneda;

            //if (o.Anulada == "SI")
            //{
            //    a.ImporteTotal = 0;
            //    a.Saldo = 0;
            //    a.ImporteTotalDolar = 0;
            //    a.SaldoDolar = 0;
            //}
            //else
            //{
            //    a.ImporteTotal = Math.Round(o.ImporteTotal * o.CotizacionMoneda ?? 0, 2);
            //    a.Saldo = Math.Round(o.ImporteTotal * o.CotizacionMoneda ?? 0, 2) - mImporteAnterior;
            //    a.ImporteTotalDolar = o.ImporteTotal * o.CotizacionMoneda / o.CotizacionDolar;
            //    a.SaldoDolar = (o.ImporteTotal * o.CotizacionMoneda / o.CotizacionDolar) - mTotalAnteriorDolar;
            //}

            //db.CuentasCorrientesDeudores.Add(a);


            // ?????  a.IdImputacion=


            //    '////////////////////////////
            //    'cambio el saldo en la entidad cliente
            ////    '////////////////////////////
            //if (o.IdCliente > 0)
            //{
            //    var c = db.Clientes.Find(o.IdCliente);

            //    if (o.Anulada == "SI")
            //    {
            //        c.Saldo += -mImporteAnterior;
            //    }
            //    else
            //    {
            //        c.Saldo += -mImporteAnterior + Math.Round((o.ImporteTotal ?? 0) * (o.CotizacionMoneda ?? 0), 2);
            //    }


            //}






        }




        /// <summary>
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="clave"></param>
        /// <returns></returns>


        public string BuscarClaveINI(string clave, string usuario)
        {

            var db = comprobantesproveedorRepositorio.HACKEADOcontext;

            // if (usuario == "") usuario = Membership.GetUser().UserName; //ViewBag.NombreUsuario;
            int IdUsuario = comprobantesproveedorRepositorio.HACKEADOcontext.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
            //string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));

            var idclav = comprobantesproveedorRepositorio.HACKEADOcontext.ProntoIniClaves.Where(x => x.Clave == clave).Select(x => x.IdProntoIniClave).FirstOrDefault();
            string idclava = comprobantesproveedorRepositorio.HACKEADOcontext.ProntoIni.Where(x => x.IdProntoIniClave == idclav && x.IdUsuario == IdUsuario).Select(x => x.Valor).FirstOrDefault();

            return idclava;
        }


        public int buscaridproveedorporcuit(string cuit)
        {
            var provs = comprobantesproveedorRepositorio.HACKEADOcontext.Proveedores.Where(p => p.Cuit.Replace("-", "") == cuit.Replace("-", ""));
            return provs.Select(p => p.IdProveedor).FirstOrDefault();

        }



        public int buscaridclienteporcuit(string cuit)
        {
            var provs = comprobantesproveedorRepositorio.HACKEADOcontext.Clientes.Where(p => p.Cuit.Replace("-", "") == cuit.Replace("-", ""));
            return provs.Select(p => p.IdCliente).FirstOrDefault();

        }



    }


    public class FondoFijoService
    {

        private Repository<Parametros> parametroRepositorio;
        private Repository<ComprobanteProveedor> comprobantesproveedorRepositorio;
        private Repository<Condiciones_Compra> condicioncomprasRepositorio;
        private Repository<DetalleComprobantesProveedore> detallecomprobantesproveedorRepositorio;
        private Repository<PlazosEntrega> plazosentregasRepositorio;
        private Repository<Moneda> monedasRepositorio;
        private Repository<Empleado> empleadosRepositorio;



        public FondoFijoService(UnitOfWork unitOfWork)
        {
            comprobantesproveedorRepositorio = unitOfWork.ComprobantesproveedorRepositorio;
            detallecomprobantesproveedorRepositorio = unitOfWork.DetalleComprobantesproveedorRepositorio;
            parametroRepositorio = unitOfWork.ParametrosRepositorio;
            condicioncomprasRepositorio = unitOfWork.CondicioncomprasRepositorio;

            plazosentregasRepositorio = unitOfWork.PlazosEntregasRepositorio;
            monedasRepositorio = unitOfWork.MonedasRepositorio;
            empleadosRepositorio = unitOfWork.EmpleadosRepositorio;

            _referenciaalUoW = unitOfWork;
            //  usuarioService = new UsuarioService(unitOfWork);
        }










        public IEnumerable<Condiciones_Compra> Condiciones_Compras_Listado()
        {
            return condicioncomprasRepositorio.ObtenerTodos().ToList();
        }


        public Parametros Parametros()
        {
            return parametroRepositorio.ObtenerTodos().FirstOrDefault();
        }


        public IEnumerable<Moneda> Monedas_Listado()
        {
            return monedasRepositorio.ObtenerTodos().ToList();
        }


        public IEnumerable<PlazosEntrega> PlazosEntregas_Listado()
        {
            return plazosentregasRepositorio.ObtenerTodos().ToList();
        }

        public IEnumerable<Empleado> Empleados_Listado()
        {
            return empleadosRepositorio.ObtenerTodos().ToList();
        }


        public Empleado EmpleadoById(int? Id)
        {
            return empleadosRepositorio.ObtenerPorId(Id ?? 0);
        }




        public virtual System.Collections.Generic.List<ComprobanteProveedor> ObtenerTodos(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString,
                                    string FechaInicial, string FechaFinal, string rendicion, string idcuenta)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //if (sidx == "Numero") sidx = "NumeroComprobanteProveedor"; // como estoy haciendo "select a" (el renglon entero) en la linq antes de llamar jqGridJson, no pude ponerle el nombre explicito
            //if (searchField == "Numero") searchField = "NumeroComprobanteProveedor"; 



            var Entidad = comprobantesproveedorRepositorio.ObtenerTodos(); // comprobantesproveedorRepositorio;




            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                Entidad = (from a in Entidad where a.FechaComprobante >= FechaDesde && a.FechaComprobante <= FechaHasta select a).AsQueryable();
            }
            if (rendicion != string.Empty)
            {
                int rend = Generales2.Val(rendicion);
                Entidad = (from a in Entidad where a.NumeroRendicionFF == rend select a).AsQueryable();
            }



            if (idcuenta != string.Empty)
            {
                int idcuentaff = Generales2.Val(idcuenta);
                Entidad = (from a in Entidad where a.IdCuenta == idcuentaff select a).AsQueryable();
            }

            var usuario = new Empleado(); // glbUsuario; 

            int ffasociado = usuario.IdCuentaFondoFijo ?? 0;

            if (ffasociado > 0)
            {
                Entidad = (from a in Entidad where a.IdCuenta == ffasociado select a).AsQueryable();
            }

            int obraasociada = usuario.IdObraAsignada ?? 0;
            if (obraasociada > 0)
            {
                Entidad = (from a in Entidad where a.IdObra == obraasociada select a).AsQueryable();
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

                        campo = String.Format("Proveedor.RazonSocial.Contains(\"{0}\") OR NumeroReferencia = {1} ", searchString, Generales2.Val(searchString));
                        break;
                }
            }
            else
            {
                campo = "true";
            }

            campo = "true";

            var Entidad1 = (from a in Entidad.Where(campo) select a);

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad.Include("Proveedor")
                        select a

                ).Where(campo)
                // .OrderBy((sidx == "Numero" ? "NumeroReferencia" : sidx) + " " + sord)
                .OrderBy("IdComprobanteProveedor desc")
                .Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();


            return data;
        }






        public void Guardar(ComprobanteProveedor ComprobanteProveedor)
        {
            var db = comprobantesproveedorRepositorio;



            // comprobantesproveedorRepositorio.Insertar(ComprobanteProveedor);

            string tipomovimiento = "";



            // Logica_RecalcularTotales(ref ComprobanteProveedor);
            Logica_ActualizarCuentaCorriente(ComprobanteProveedor);
            Logica_AsientoRegistroContable(ComprobanteProveedor);
            Logica_Actualizaciones(ComprobanteProveedor);



            if (ComprobanteProveedor.IdComprobanteProveedor > 0)
            {

                // db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;

                comprobantesproveedorRepositorio.Actualizar(ComprobanteProveedor);
            }
            else
            {

                //var param = parametroRepositorio.ObtenerPorId(1);
                var param = comprobantesproveedorRepositorio.HACKEADOcontext.Parametros.FirstOrDefault();
                ComprobanteProveedor.NumeroReferencia = param.ProximoComprobanteProveedorReferencia;
                param.ProximoComprobanteProveedorReferencia += 1;


                comprobantesproveedorRepositorio.Insertar((ComprobanteProveedor)ComprobanteProveedor);
                parametroRepositorio.Actualizar(param);
            }




            // db.SaveChanges();


        }




        private void Actualizar(ComprobanteProveedor ComprobanteProveedor)
        {

            /*
            //como hago usar estas llamadas al db?
        http://programmers.stackexchange.com/questions/170120/how-should-i-implement-the-repository-pattern-for-complex-object-models
        http://programmers.stackexchange.com/questions/180851/why-shouldnt-i-use-the-repository-pattern-with-entity-framework
            http://stackoverflow.com/questions/7171023/repository-pattern-with-entity-framework-4-1-and-parent-child-relationships
             * http://stackoverflow.com/questions/20471927/how-to-fake-dbcontext-entry-method-in-entity-framework-with-repository-pattern
                 
             * supongamos que en este servicio no uso repositorio. Me tienen que pasar el db (que es el unitofwork)
             * 
                 
				 
             What I mean here, is that in your object model, some entities are likely contained in others in a master-detail relationship. If your entity is highly dependant on another, do not create a repository for this entity alone because it won't likely be persisted by itself. Instead, you will create a repository for each parent class, and you will make sure that the child entities and other relations are persisted at the same time
				 
             http://stackoverflow.com/questions/7171023/repository-pattern-with-entity-framework-4-1-and-parent-child-relationships
             http://stackoverflow.com/questions/6904139/fake-dbcontext-of-entity-framework-4-1-to-test/6904479#6904479
             -The primary reason why I want to use this pattern is to avoid calling EF 4.1 specific data access operations from the domain. I'd rather call generic CRUD operations from a IRepository interface. This will make testing easier
            -NO, it will not make your testing easier. You exposed IQueryable so your repository is not unit testable.

            http://stackoverflow.com/questions/718624/to-return-iqueryablet-or-not-return-iqueryablet
            The cons; non-testability:
             */




            var EntidadOriginal = ObtenerPorId(ComprobanteProveedor.IdComprobanteProveedor);




            var EntidadEntry = comprobantesproveedorRepositorio.Entry(EntidadOriginal);
            EntidadEntry.CurrentValues.SetValues(ComprobanteProveedor);

            foreach (var dr in ComprobanteProveedor.DetalleComprobantesProveedores)
            {
                var DetalleEntidadOriginal = EntidadOriginal.DetalleComprobantesProveedores.Where(c => c.IdDetalleComprobanteProveedor == dr.IdDetalleComprobanteProveedor && dr.IdDetalleComprobanteProveedor > 0).SingleOrDefault();
                if (DetalleEntidadOriginal != null)
                {
                    var DetalleEntidadEntry = detallecomprobantesproveedorRepositorio.Entry(DetalleEntidadOriginal);
                    DetalleEntidadEntry.CurrentValues.SetValues(dr);
                }
                else
                {
                    EntidadOriginal.DetalleComprobantesProveedores.Add(dr);
                }
            }

            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleComprobantesProveedores.Where(c => c.IdDetalleComprobanteProveedor != 0).ToList())
            {
                if (!ComprobanteProveedor.DetalleComprobantesProveedores.Any(c => c.IdDetalleComprobanteProveedor == DetalleEntidadOriginal.IdDetalleComprobanteProveedor))
                    EntidadOriginal.DetalleComprobantesProveedores.Remove(DetalleEntidadOriginal);
            }



            comprobantesproveedorRepositorio.SetModified(EntidadOriginal);
        }



        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///         MIGRAR TODO ESTO. DEJAR DE USAR EL CONTEXT EN EL SERVICIO
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




        private UnitOfWork _referenciaalUoW;



        // usar delegate?

        public ObjectResult<AutorizacionesPorComprobante> AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante(int idFormulario, int idComprobante)
        {

            return _referenciaalUoW.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante(idFormulario, idComprobante);
        }



        public System.Data.Entity.Core.Objects.ObjectResult<Nullable<int>> Autorizaciones_TX_CantidadAutorizaciones(Nullable<int> idFormulario, Nullable<decimal> importe, Nullable<int> idComprobante)
        {

            return _referenciaalUoW.CantidadAutorizaciones(idFormulario, importe, idComprobante);
        }




        public IEnumerable<DescripcionIva> DescripcionIvas_Listado()
        {
            return comprobantesproveedorRepositorio.HACKEADOcontext.DescripcionIvas;

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                return c.DescripcionIvas;
            }
        }

        public IEnumerable<TiposComprobante> TiposComprobantes_Listado()
        {
            return comprobantesproveedorRepositorio.HACKEADOcontext.TiposComprobantes.ToList();

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                return c.TiposComprobantes;
            }
        }

        public IEnumerable<Cotizacione> Cotizaciones_Listado()
        {
            //using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)

            ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext;
            return c.Cotizaciones.ToList();

        }

        public IEnumerable<Cuenta> Cuentas_Listado()
        {
            return comprobantesproveedorRepositorio.HACKEADOcontext.Cuentas;


            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                return c.Cuentas;
            }
        }
        public IEnumerable<Unidad> Unidades_Listado()
        {
            return comprobantesproveedorRepositorio.HACKEADOcontext.Unidades;


            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                return c.Unidades;
            }
        }
        public IEnumerable<Proveedor> Proveedores_Listado()
        {
            return comprobantesproveedorRepositorio.HACKEADOcontext.Proveedores;

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                return c.Proveedores;
            }
        }
        public IEnumerable<Subdiario> Subdiarios_Listado()
        {
            return comprobantesproveedorRepositorio.HACKEADOcontext.Subdiarios;

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                return c.Subdiarios;
            }
        }



        public int ObtenerCantidadPorUsuario(int codigoUsuario)
        {
            return comprobantesproveedorRepositorio.ObtenerTodos().Count(m => m.IdCodigoAduana == codigoUsuario);
        }


        public Obra ObrasById(int? Id)
        {

            return comprobantesproveedorRepositorio.HACKEADOcontext.Obras.Find(Id);

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                //  DbSet<Condiciones_Compra> repo = c.Cuentas;

                return c.Obras.Find(Id);

            }

        }

        public Cuenta CuentasById(int? Id)
        {

            return comprobantesproveedorRepositorio.HACKEADOcontext.Cuentas.Find(Id);

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                //  DbSet<Condiciones_Compra> repo = c.Cuentas;

                return c.Cuentas.Find(Id);

            }

        }

        public TiposComprobante TiposComprobantesById(int? Id)
        {

            return comprobantesproveedorRepositorio.HACKEADOcontext.TiposComprobantes.Find(Id);

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                //  DbSet<Condiciones_Compra> repo = c.Cuentas;

                return c.TiposComprobantes.Find(Id);

            }

        }


        public Proveedor ProveedoresById(int? Id)
        {

            return comprobantesproveedorRepositorio.HACKEADOcontext.Proveedores.Find(Id);

            using (ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext)
            {
                //  DbSet<Condiciones_Compra> repo = c.Cuentas;

                return c.Proveedores.Find(Id);

            }

        }


        public class comboitem
        {
            public int id;
            public string value;
            public string descripcion;
        }


        public virtual List<comboitem> GetObrasAutocomplete2(string term)
        {
            const int MAXLISTA = 100;


            ProntoMVC.Data.Models.DemoProntoEntities db = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext;

            var q = (from item in db.Obras
                     where (item.NumeroObra.ToLower() + " - " + item.Descripcion.ToLower()).Contains(term.ToLower())
                           && item.Activa != "NO"
                     //.StartsWith(term.ToLower())
                     //            where SqlFunctions.StringConvert((decimal?)item.IdArticulo).Contains(term) ||

                     orderby item.NumeroObra
                     select new comboitem
                     {
                         id = item.IdObra,
                         value = item.NumeroObra + " - " + (item.Descripcion ?? ""),
                         descripcion = (item.Descripcion ?? "")
                         // NumeroObra = y.NumeroObra + " - " + (y.Descripcion ?? "")
                         //iva = item.AlicuotaIVA,
                         //IdUnidad = item.IdUnidad,
                         //Unidad = item.Unidad.Abreviatura
                     }).Take(MAXLISTA).ToList();

            return q;
        }













        public virtual ComprobanteProveedor ObtenerPorId(int id)
        {
            // http://stackoverflow.com/questions/1230571/advantage-of-creating-a-generic-repository-vs-specific-repository-for-each-obje

            //trampa: esta es una implementacion del metodo virtual de lo que sería un repositorio específico de ComprobanteProveedor
            ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext;


            return c.ComprobantesProveedor
                .Include(x => x.DetalleComprobantesProveedores)
                .Include(x => x.Proveedor)
               .Include(x => x.Proveedore)
               .Include(x => x.Obra)
               .Include(x => x.Cuenta)
               .SingleOrDefault(x => x.IdComprobanteProveedor == id);


            // como hago para hacer includes con el comprobantesproveedorRepositorio???

            //return comprobantesproveedorRepositorio
            //                .Include(x => x.DetalleComprobantesProveedores)
            //                .Include(x => x.Proveedor)
            //               .Include(x => x.Proveedore)
            //               .Include(x => x.Obra)
            //               .Include(x => x.Cuenta)
            //               .SingleOrDefault(x => x.IdComprobanteProveedor == id);


        }





        public virtual IQueryable<ComprobanteProveedor> ObtenerTodos()
        {
            /*
                   On the other hand, now you have given your users a shotgun. They can do things which you may not have intended 
                   (over using .include(), doing heavy heavy queries and doing "in-memory" filtering in their respective 
                   implementations, etc..), which would basically side-step the layering and behavioral controls because 
                   you have given full access.
             * 
             * http://stackoverflow.com/questions/11964578/repository-iqueryable-query-object
             * http://ayende.com/blog/4784/architecting-in-the-pit-of-doom-the-evils-of-the-repository-abstraction-layer
             * 
                   */

            ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext;

            return c.ComprobantesProveedor
                     .Include(x => x.DetalleComprobantesProveedores)
                     .Include(x => x.DescripcionIva)
                     .Include(x => x.Cuenta)
                     .Include(x => x.Proveedor)
                     .Include(x => x.Proveedore)
                     .Include(x => x.Obra)
                         .Where(x => x.IdCuenta != null)
                               .AsQueryable();
        }


        public virtual IQueryable<DetalleComprobantesProveedore> ObtenerTodosDetalle()
        {
            /*
                   On the other hand, now you have given your users a shotgun. They can do things which you may not have intended 
                   (over using .include(), doing heavy heavy queries and doing "in-memory" filtering in their respective 
                   implementations, etc..), which would basically side-step the layering and behavioral controls because 
                   you have given full access.
             * 
             * http://stackoverflow.com/questions/11964578/repository-iqueryable-query-object
             * http://ayende.com/blog/4784/architecting-in-the-pit-of-doom-the-evils-of-the-repository-abstraction-layer
             * 
                   */

            ProntoMVC.Data.Models.DemoProntoEntities c = (ProntoMVC.Data.Models.DemoProntoEntities)comprobantesproveedorRepositorio.HACKEADOcontext;

            return c.DetalleComprobantesProveedores
                     .Include(x => x.Cuenta)
                               .AsQueryable();
        }




        public void Logica_Actualizaciones(ComprobanteProveedor o)
        {
            //if (!IsNull(ComprobanteProveedor.Fields("IdDiferenciaCambio").Value))
            //{
            //    oDet.Tarea("DiferenciasCambio_MarcarComoGenerada", Array(ComprobanteProveedor.Fields("IdDiferenciaCambio").Value, ComprobanteProveedor.Fields("IdTipoComprobante").Value, ComprobanteProveedor.Fields(0).Value));
            //}

            int mvarIdOrdenPagoActual = 0, mvarIdOrdenPagoAnterior = 0;
            string SC = "";

            if (mvarIdOrdenPagoActual != 0 || mvarIdOrdenPagoAnterior != 0)
            {
                // EntidadManager.Tarea(SC, "OrdenesPago_ActualizarDiferenciaBalanceo", mvarIdOrdenPagoActual, mvarIdOrdenPagoAnterior);
            }


            // log
        }




        private Subdiario movimient(int? mvarEjercicio, int? mvarCuentaVentasTitulo, int? mvarCuentaIvaInscripto, int? d, int? NumeroFactura, DateTime? mvarFecha, int? Registr, decimal? ImporteIva2, int? IdMoneda, decimal? CotizacionMoneda)
        {
            //if (deber && haber =0) return;
            if ((ImporteIva2 ?? 0) <= 0) return null;
            var s = new Subdiario();
            s.Ejercicio = mvarEjercicio;
            s.IdCuentaSubdiario = mvarCuentaVentasTitulo;
            s.IdCuenta = mvarCuentaIvaInscripto;
            s.IdTipoComprobante = 1;
            s.NumeroComprobante = NumeroFactura;
            s.FechaComprobante = mvarFecha;
            s.IdComprobante = Registr;


            //if
            //elseif 
            s.Haber = ImporteIva2 ?? 0;
            //else
            //s.Deber= Deber;
            //else


            s.IdMoneda = IdMoneda;
            s.CotizacionMoneda = CotizacionMoneda;
            return s;
        }



        private bool ValidarAsiento(List<Subdiario> o)
        {
            decimal debe = 0;
            decimal haber = 0;

            List<Subdiario> copia = new List<Subdiario>(o);



            for (int n = o.Count - 1; n >= 0; n--)
            {
                Subdiario mov = o[n];

                if (mov == null)
                {
                    // throw new 
                    o.RemoveAt(n);
                    continue;
                }

                if (mov.FechaComprobante == null)
                {

                    throw new Exception("Falta la fecha");
                }

                debe += mov.Debe ?? 0;
                haber += mov.Haber ?? 0;
            }

            if (debe != haber)
            {
                // throw new Exception("Asiento no da cero"); ; //throw
            }

            // if distinct o[0].IdCuenta  throw new Exception("Solo puede haber un movimiento por cuenta"); ; // lo agrupo automaticamente yo???


            return true;
        }



        public void Logica_AsientoRegistroContable(ComprobanteProveedor o, DemoProntoEntities db)
        {

            try
            {

                //        Public Function RegistroContable() As ador.Recordset

                //   Dim oSrv As InterFazMTS.iCompMTS
                //   Dim oRs As ador.Recordset
                //   Dim oRsAux As ador.Recordset
                //   Dim oRsCont As ador.Recordset
                //   Dim oRsDet As ador.Recordset
                //   Dim oRsDetBD As ador.Recordset
                //   Dim oFld As ador.Field
                //   Dim mvarEjercicio As Long, mvarCuentaVentas As Long, mvarCuentaCliente As Long, mvarCuentaBonificaciones As Long
                //   Dim mvarCuentaIvaInscripto As Long, mvarCuentaIvaNoInscripto As Long, mvarCuentaIvaSinDiscriminar As Long
                //   Dim mvarCuentaRetencionIBrutosBsAs As Long, mvarCuentaRetencionIBrutosCap As Long, mvarCuentaVentasTitulo As Long
                long mvarCuentaReventas, mvarCuentaIvaInscripto1 = 0, mvarCuentaPercepcionIIBB;
                //   Dim mvarCuentaOtrasPercepciones1 As Long, mvarCuentaOtrasPercepciones2 As Long, mvarCuentaOtrasPercepciones3 As Long
                //   Dim mvarCuentaPercepcionesIVA As Long
                //   Dim mvarCuentaIvaVenta(4, 2) As Long
                //   Dim i As Integer, mvarIdMonedaPesos As Integer
                Double mvarIvaNoDiscriminado, mvarSubtotal, mvarNetoGravadoItem, mvarAjusteIva;
                //   Dim mvarNetoGravadoItemSuma As Double


                //   Dim mvarEsta As Boolean
                //   Dim mvarFecha As Date

                //   Set oSrv = CreateObject("MTSPronto.General")

                Parametros parametros = db.Parametros.Find(1);
                var mvarEjercicio = parametros.EjercicioActual ?? 0;
                var mvarCuentaVentas = parametros.IdCuentaVentas ?? 0;
                var mvarCuentaVentasTitulo = parametros.IdCuentaVentasTitulo ?? 0;
                var mvarCuentaBonificaciones = parametros.IdCuentaBonificaciones ?? 0;
                var mvarCuentaIvaInscripto = parametros.IdCuentaIvaInscripto ?? 0;
                var mvarCuentaIvaNoInscripto = parametros.IdCuentaIvaNoInscripto ?? 0;
                var mvarCuentaIvaSinDiscriminar = parametros.IdCuentaIvaSinDiscriminar ?? 0;
                var mvarCuentaRetencionIBrutosBsAs = parametros.IdCuentaRetencionIBrutosBsAs ?? 0;
                var mvarCuentaRetencionIBrutosCap = parametros.IdCuentaRetencionIBrutosCap ?? 0;
                mvarCuentaReventas = parametros.IdCuentaReventas ?? 0;
                var mvarCuentaOtrasPercepciones1 = parametros.IdCuentaOtrasPercepciones1 ?? 0;
                var mvarCuentaOtrasPercepciones2 = parametros.IdCuentaOtrasPercepciones2 ?? 0;
                var mvarCuentaOtrasPercepciones3 = parametros.IdCuentaOtrasPercepciones3 ?? 0;
                var mvarCuentaPercepcionesIVA = parametros.IdCuentaPercepcionesIVA ?? 0;
                var mvarCuentaCliente = parametros.IdCuentaDeudoresVarios ?? 0;
                var mvarIdMonedaPesos = parametros.IdMoneda ?? 1;

                //   For i = 1 To 4
                //      If Not IsNull(oRs.Fields("IdCuentaIvaVentas" & i).Value) Then
                //         mvarCuentaIvaVenta(i, 0) = oRs.Fields("IdCuentaIvaVentas" & i).Value
                //         mvarCuentaIvaVenta(i, 1) = oRs.Fields("IVAVentasPorcentaje" & i).Value
                //      Else
                //         mvarCuentaIvaVenta(i, 0) = 0
                //         mvarCuentaIvaVenta(i, 1) = -1
                //      End If
                //   Next
                //   oRs.Close

                //   If Not IsNull(o.IdCliente) Then
                //      Set oRs = oSrv.LeerUno("Clientes", o.IdCliente)
                //      mvarCuentaCliente = IIf(IsNull(oRs.Fields("IdCuenta), 0, oRs.Fields("IdCuenta)
                //      If o.IdMoneda <> mvarIdMonedaPesos And _
                //            Not IsNull(oRs.Fields("IdCuentaMonedaExt) Then
                //         mvarCuentaCliente = oRs.Fields("IdCuentaMonedaExt
                //      End If
                //      oRs.Close
                //   End If

                //   Set oRsCont = CreateObject("ADOR.Recordset")
                //   Set oRs = oSrv.TraerFiltrado("Subdiarios", "_Estructura")

                ProntoMVC.Data.Models.Subdiario oRs = new Subdiario();

                var mvarFecha = o.ContabilizarAFechaVencimiento == "SI" ? o.FechaVencimiento : o.FechaFactura;

                mvarSubtotal = (double)(o.ImporteTotal ?? 0 - o.ImporteIva1 ?? 0 -
                                   o.ImporteIva2 ?? 0 - o.RetencionIBrutos1 -
                                   o.RetencionIBrutos2 ?? 0 - o.RetencionIBrutos3 ?? 0 -
                                   o.OtrasPercepciones1 ?? 0 -
                                    o.OtrasPercepciones2 ?? 0 -
                                    o.OtrasPercepciones3 ?? 0 -
                                   o.PercepcionIVA ?? 0 -
                                   o.AjusteIva ?? 0 +
                                   o.ImporteBonificacion ?? 0);
                var mvarNetoGravadoItemSuma = 0;



                var s = new Subdiario();
                s.Ejercicio = mvarEjercicio;
                s.IdCuentaSubdiario = mvarCuentaVentasTitulo;
                s.IdCuenta = mvarCuentaCliente;
                s.IdTipoComprobante = 1;
                s.NumeroComprobante = o.NumeroFactura;
                s.FechaComprobante = mvarFecha;
                s.IdComprobante = o.IdFactura;
                s.Debe = o.ImporteTotal;
                s.IdMoneda = o.IdMoneda;
                s.CotizacionMoneda = o.CotizacionMoneda;
                if (s.Debe > 0) db.Subdiarios.Add(s);




                //     If o.ImporteBonificacion <> 0 Then
                //        With oRsCont
                s = new Subdiario();
                s.Ejercicio = mvarEjercicio;
                s.IdCuentaSubdiario = mvarCuentaVentasTitulo;
                s.IdCuenta = mvarCuentaBonificaciones;
                s.IdTipoComprobante = 1;
                s.NumeroComprobante = o.NumeroFactura;
                s.FechaComprobante = mvarFecha;
                s.IdComprobante = o.IdFactura;
                s.Debe = o.ImporteBonificacion;
                s.IdMoneda = o.IdMoneda;
                s.CotizacionMoneda = o.CotizacionMoneda;
                if (s.Debe > 0) db.Subdiarios.Add(s);
                //           .Update
                //        End With
                //     End If



                if (o.ImporteIva1 != 0)
                {
                    mvarCuentaIvaInscripto1 = mvarCuentaIvaInscripto;
                    for (int i = 1; i <= 4; i++)
                    {
                        //if (o.PorcentajeIva1 = mvarCuentaIvaVenta(i, 1))
                        //{
                        //    mvarCuentaIvaInscripto1 = mvarCuentaIvaVenta(i, 0);
                        //    break;

                        //}
                    }
                }
                s = new Subdiario();

                s.Ejercicio = mvarEjercicio;
                s.IdCuentaSubdiario = mvarCuentaVentasTitulo;
                s.IdCuenta = (int)mvarCuentaIvaInscripto1;
                s.IdTipoComprobante = 1;
                s.NumeroComprobante = o.NumeroFactura;
                s.FechaComprobante = mvarFecha;
                s.IdComprobante = o.IdFactura;
                s.Haber = o.ImporteIva1;
                s.IdMoneda = o.IdMoneda;
                s.CotizacionMoneda = o.CotizacionMoneda;
                if (s.Haber > 0) db.Subdiarios.Add(s);
                //         .Update
                //      End With
                //   End If



                //mvarIvaNoDiscriminado = 0
                //   if (o.IvaNoDiscriminado > 0) {
                //      mvarIvaNoDiscriminado = o.IvaNoDiscriminado
                s = new Subdiario();

                s.Ejercicio = mvarEjercicio;
                s.IdCuentaSubdiario = mvarCuentaVentasTitulo;
                s.IdCuenta = mvarCuentaIvaInscripto;
                s.IdTipoComprobante = 1;
                s.NumeroComprobante = o.NumeroFactura;
                s.FechaComprobante = mvarFecha;
                s.IdComprobante = o.IdFactura;
                s.Haber = (decimal)(o.IVANoDiscriminado ?? 0);
                s.IdMoneda = o.IdMoneda;
                s.CotizacionMoneda = o.CotizacionMoneda;
                if (s.Haber > 0) db.Subdiarios.Add(s);

                //mvarAjusteIva = 0
                //   if (o.AjusteIva <> 0) {
                //      mvarAjusteIva = o.AjusteIva
                s = new Subdiario();

                s.Ejercicio = mvarEjercicio;
                s.IdCuentaSubdiario = mvarCuentaVentasTitulo;
                s.IdCuenta = mvarCuentaIvaInscripto;
                s.IdTipoComprobante = 1;
                s.NumeroComprobante = o.NumeroFactura;
                s.FechaComprobante = mvarFecha;
                s.IdComprobante = o.IdFactura;
                s.Haber = (decimal?)o.AjusteIva;
                s.IdMoneda = o.IdMoneda;
                s.CotizacionMoneda = o.CotizacionMoneda;
                if (s.Haber > 0) db.Subdiarios.Add(s);
                //         .Update
                //      End With
                //   }



                s = movimient(mvarEjercicio, mvarCuentaVentasTitulo, mvarCuentaIvaInscripto, 1, o.NumeroFactura, mvarFecha, o.IdFactura, o.ImporteIva2, o.IdMoneda, o.CotizacionMoneda);
                if (s != null) db.Subdiarios.Add(s);


                //   If Not IsNull(o.RetencionIBrutos1) Then
                //      If o.RetencionIBrutos1 <> 0 Then
                //         Set oRs = oSrv.LeerUno("IBCondiciones", o.IdIBCondicion)
                //         mvarCuentaPercepcionIIBB = IIf(IsNull(oRs.Fields("IdCuentaPercepcionIIBB), 0, oRs.Fields("IdCuentaPercepcionIIBB)
                //         If Not IsNull(oRs.Fields("IdProvincia) Then
                //            Set oRsAux = oSrv.LeerUno("Provincias", oRs.Fields("IdProvincia)
                //            If oRsAux.RecordCount > 0 Then
                //               If Not IsNull(oRsAux.Fields("IdCuentaPercepcionIBrutos) Then
                //                  mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIBrutos
                //               End If
                //               If o.ConvenioMultilateral = "SI" And _
                //                     Not IsNull(oRsAux.Fields("IdCuentaPercepcionIIBBConvenio) Then
                //                  mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIIBBConvenio
                //               End If
                //            End If
                //            oRsAux.Close
                //         End If
                //         oRs.Close
                //         With oRsCont
                //            .AddNew
                //           s.Ejercicio = mvarEjercicio
                //           s.IdCuentaSubdiario = mvarCuentaVentasTitulo
                //           s.IdCuenta = mvarCuentaPercepcionIIBB
                //           s.IdTipoComprobante = 1
                //           s.NumeroComprobante = o.NumeroFactura
                //           s.FechaComprobante = mvarFecha
                //           s.IdComprobante = Registro.Fields(0).Value
                //           s.Haber = o.RetencionIBrutos1
                //           s.IdMoneda = o.IdMoneda
                //           s.CotizacionMoneda = o.CotizacionMoneda
                //            .Update
                //         End With
                //      End If
                //   End If

                s = movimient(mvarEjercicio, mvarCuentaVentasTitulo, mvarCuentaIvaInscripto, 1, o.NumeroFactura, mvarFecha, o.IdFactura, o.ImporteIva2, o.IdMoneda, o.CotizacionMoneda);
                if (s != null) db.Subdiarios.Add(s);


                //   If Not IsNull(o.RetencionIBrutos2) Then
                //      If o.RetencionIBrutos2 <> 0 Then
                //         Set oRs = oSrv.LeerUno("IBCondiciones", o.IdIBCondicion2)
                //         mvarCuentaPercepcionIIBB = IIf(IsNull(oRs.Fields("IdCuentaPercepcionIIBB), 0, oRs.Fields("IdCuentaPercepcionIIBB)
                //         If Not IsNull(oRs.Fields("IdProvincia) Then
                //            Set oRsAux = oSrv.LeerUno("Provincias", oRs.Fields("IdProvincia)
                //            If oRsAux.RecordCount > 0 Then
                //               If Not IsNull(oRsAux.Fields("IdCuentaPercepcionIBrutos) Then
                //                  mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIBrutos
                //               End If
                //               If o.ConvenioMultilateral = "SI" And _
                //                     Not IsNull(oRsAux.Fields("IdCuentaPercepcionIIBBConvenio) Then
                //                  mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIIBBConvenio
                //               End If
                //            End If
                //            oRsAux.Close
                //         End If
                //         oRs.Close
                //         With oRsCont
                //            .AddNew
                //           s.Ejercicio = mvarEjercicio
                //           s.IdCuentaSubdiario = mvarCuentaVentasTitulo
                //           s.IdCuenta = mvarCuentaPercepcionIIBB
                //           s.IdTipoComprobante = 1
                //           s.NumeroComprobante = o.NumeroFactura
                //           s.FechaComprobante = mvarFecha
                //           s.IdComprobante = Registro.Fields(0).Value
                //           s.Haber = o.RetencionIBrutos2
                //           s.IdMoneda = o.IdMoneda
                //           s.CotizacionMoneda = o.CotizacionMoneda
                //            .Update
                //         End With
                //      End If
                //   End If
                s = movimient(mvarEjercicio, mvarCuentaVentasTitulo, mvarCuentaIvaInscripto, 1, o.NumeroFactura, mvarFecha, o.IdFactura, o.ImporteIva2, o.IdMoneda, o.CotizacionMoneda);
                if (s != null) db.Subdiarios.Add(s);

                //   If Not IsNull(o.RetencionIBrutos3) Then
                //      If o.RetencionIBrutos3 <> 0 Then
                //         Set oRs = oSrv.LeerUno("IBCondiciones", o.IdIBCondicion3)
                //         mvarCuentaPercepcionIIBB = IIf(IsNull(oRs.Fields("IdCuentaPercepcionIIBB), 0, oRs.Fields("IdCuentaPercepcionIIBB)
                //         If Not IsNull(oRs.Fields("IdProvincia) Then
                //            Set oRsAux = oSrv.LeerUno("Provincias", oRs.Fields("IdProvincia)
                //            If oRsAux.RecordCount > 0 Then
                //               If Not IsNull(oRsAux.Fields("IdCuentaPercepcionIBrutos) Then
                //                  mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIBrutos
                //               End If
                //               If o.ConvenioMultilateral = "SI" And _
                //                     Not IsNull(oRsAux.Fields("IdCuentaPercepcionIIBBConvenio) Then
                //                  mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIIBBConvenio
                //               End If
                //            End If
                //            oRsAux.Close
                //         End If
                //         oRs.Close
                //         With oRsCont
                //            .AddNew
                //           s.Ejercicio = mvarEjercicio
                //           s.IdCuentaSubdiario = mvarCuentaVentasTitulo
                //           s.IdCuenta = mvarCuentaPercepcionIIBB
                //           s.IdTipoComprobante = 1
                //           s.NumeroComprobante = o.NumeroFactura
                //           s.FechaComprobante = mvarFecha
                //           s.IdComprobante = Registro.Fields(0).Value
                //           s.Haber = o.RetencionIBrutos3
                //           s.IdMoneda = o.IdMoneda
                //           s.CotizacionMoneda = o.CotizacionMoneda
                //            .Update
                //         End With
                //      End If
                //   End If

                s = movimient(mvarEjercicio, mvarCuentaVentasTitulo, mvarCuentaIvaInscripto, 1, o.NumeroFactura, mvarFecha, o.IdFactura, o.ImporteIva2, o.IdMoneda, o.CotizacionMoneda);
                if (s != null) db.Subdiarios.Add(s);

                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                //   If Not IsNull(o.OtrasPercepciones1) Then
                //      If o.OtrasPercepciones1 <> 0 Then
                //         With oRsCont
                //            .AddNew
                //           s.Ejercicio = mvarEjercicio
                //           s.IdCuentaSubdiario = mvarCuentaVentasTitulo
                //           s.IdCuenta = mvarCuentaOtrasPercepciones1
                //           s.IdTipoComprobante = 1
                //           s.NumeroComprobante = o.NumeroFactura
                //           s.FechaComprobante = mvarFecha
                //           s.IdComprobante = Registro.Fields(0).Value
                //           s.Haber = o.OtrasPercepciones1
                //           s.IdMoneda = o.IdMoneda
                //           s.CotizacionMoneda = o.CotizacionMoneda
                //            .Update
                //         End With
                //      End If
                //   End If

                //   If Not IsNull(o.OtrasPercepciones2) Then
                //      If o.OtrasPercepciones2 <> 0 Then
                //         With oRsCont
                //            .AddNew
                //           s.Ejercicio = mvarEjercicio
                //           s.IdCuentaSubdiario = mvarCuentaVentasTitulo
                //           s.IdCuenta = mvarCuentaOtrasPercepciones2
                //           s.IdTipoComprobante = 1
                //           s.NumeroComprobante = o.NumeroFactura
                //           s.FechaComprobante = mvarFecha
                //           s.IdComprobante = Registro.Fields(0).Value
                //           s.Haber = o.OtrasPercepciones2
                //           s.IdMoneda = o.IdMoneda
                //           s.CotizacionMoneda = o.CotizacionMoneda
                //            .Update
                //         End With
                //      End If
                //   End If
                s = movimient(mvarEjercicio, mvarCuentaVentasTitulo, mvarCuentaIvaInscripto, 1, o.NumeroFactura, mvarFecha, o.IdFactura, o.ImporteIva2, o.IdMoneda, o.CotizacionMoneda);
                if (s != null) db.Subdiarios.Add(s);


                //   If Not IsNull(o.OtrasPercepciones3) Then
                //      If o.OtrasPercepciones3 <> 0 Then
                //         With oRsCont
                //            .AddNew
                //           s.Ejercicio = mvarEjercicio
                //           s.IdCuentaSubdiario = mvarCuentaVentasTitulo
                //           s.IdCuenta = mvarCuentaOtrasPercepciones3
                //           s.IdTipoComprobante = 1
                //           s.NumeroComprobante = o.NumeroFactura
                //           s.FechaComprobante = mvarFecha
                //           s.IdComprobante = Registro.Fields(0).Value
                //           s.Haber = o.OtrasPercepciones3
                //           s.IdMoneda = o.IdMoneda
                //           s.CotizacionMoneda = o.CotizacionMoneda
                //            .Update
                //         End With
                //      End If
                //   End If

                //   If Not IsNull(o.PercepcionIVA) Then
                //      If o.PercepcionIVA <> 0 Then
                //         With oRsCont
                //            .AddNew
                //           s.Ejercicio = mvarEjercicio
                //           s.IdCuentaSubdiario = mvarCuentaVentasTitulo
                //           s.IdCuenta = mvarCuentaPercepcionesIVA
                //           s.IdTipoComprobante = 1
                //           s.NumeroComprobante = o.NumeroFactura
                //           s.FechaComprobante = mvarFecha
                //           s.IdComprobante = Registro.Fields(0).Value
                //           s.Haber = o.PercepcionIVA
                //           s.IdMoneda = o.IdMoneda
                //           s.CotizacionMoneda = o.CotizacionMoneda
                //            .Update
                //         End With
                //      End If
                //   End If
                movimient(mvarEjercicio, mvarCuentaVentasTitulo, mvarCuentaIvaInscripto, 1, o.NumeroFactura, mvarFecha, o.IdFactura, o.ImporteIva2, o.IdMoneda, o.CotizacionMoneda);






                foreach (DetalleFactura i in o.DetalleFacturas)
                {
                    s = new Subdiario();


                    //var a= s.  db.Articulos.Include(x=>x.Cuenta).Where(
                    //                   Set oRs = oSrv.TraerFiltrado("Articulos", "_DatosConCuenta",s.IdArticulo)
                    mvarNetoGravadoItem = (double)((i.Cantidad ?? 0) * (i.PrecioUnitario ?? 0) * (1 - (i.Bonificacion ?? 0 / 100)));
                    //                    mvarNetoGravadoItem = 0;
                    //if (mvarIvaNoDiscriminado > 0 ) {
                    //   mvarNetoGravadoItem = Round(mvarNetoGravadoItem * (mvarSubtotal - mvarIvaNoDiscriminado) / mvarSubtotal, 2)
                    //   mvarNetoGravadoItemSuma = mvarNetoGravadoItemSuma + mvarNetoGravadoItem
                    //}


                    s.Ejercicio = mvarEjercicio;
                    s.IdCuentaSubdiario = mvarCuentaVentasTitulo;

                    var q = db.Articulos.Include("Rubro").Include("Cuenta").SingleOrDefault(x => x.IdArticulo == i.IdArticulo);

                    s.IdCuenta = q.Rubro.IdCuenta; // db.Articulos_TX_DatosConCuenta(i.IdArticulo).Select(x => x.IdCuenta).FirstOrDefault();
                    s.IdTipoComprobante = 1;
                    s.NumeroComprobante = o.NumeroFactura;
                    s.FechaComprobante = mvarFecha;
                    s.IdComprobante = o.IdFactura;
                    if (mvarNetoGravadoItem >= 0)
                    { s.Haber = (decimal)mvarNetoGravadoItem; }
                    else
                    { s.Debe = (decimal)mvarNetoGravadoItem * -1; }

                    s.IdMoneda = o.IdMoneda;
                    s.CotizacionMoneda = o.CotizacionMoneda;

                    if (mvarNetoGravadoItem > 0) db.Subdiarios.Add(s);
                }





                // modifica los registros nuevos

                //   Set oRsDetBD = oSrv.TraerFiltrado("DetFacturas", "_PorIdCabecera", Registro.Fields(0).Value)
                //            If Not mvarEsta Then
                //               Set oRs = oSrv.TraerFiltrado("Articulos", "_DatosConCuenta",s.IdArticulo)
                //               mvarNetoGravadoItem = Round(oRsDetBD.Fields("Cantidad * _
                //                                       IIf(IsNull(oRsDetBD.Fields("PrecioUnitario), 0, oRsDetBD.Fields("PrecioUnitario) * _
                //                                       (1 - IIf(IsNull(oRsDetBD.Fields("Bonificacion), 0, oRsDetBD.Fields("Bonificacion) / 100), 2)
                //               If mvarIvaNoDiscriminado > 0 Then
                //                  mvarNetoGravadoItem = Round(mvarNetoGravadoItem * (mvarSubtotal - mvarIvaNoDiscriminado) / mvarSubtotal, 2)
                //                  mvarNetoGravadoItemSuma = mvarNetoGravadoItemSuma + mvarNetoGravadoItem
                //               End If
                //               With oRsCont
                //                  .AddNew
                //                 s.Ejercicio = mvarEjercicio
                //                 s.IdCuentaSubdiario = mvarCuentaVentasTitulo
                //                 s.IdCuenta = oRs.Fields("IdCuenta
                //                 s.IdTipoComprobante = 1
                //                 s.NumeroComprobante = o.NumeroFactura
                //                 s.FechaComprobante = mvarFecha
                //                 s.IdComprobante = Registro.Fields(0).Value
                //                  If mvarNetoGravadoItem >= 0 Then
                //                    s.Haber = mvarNetoGravadoItem
                //                  Else
                //                    s.Debe = mvarNetoGravadoItem * -1
                //                  End If
                //                 s.IdMoneda = o.IdMoneda
                //                 s.CotizacionMoneda = o.CotizacionMoneda
                //                  .Update
                //               End With



                //   If mvarIvaNoDiscriminado > 0 Then
                //      If Round(mvarNetoGravadoItemSuma + mvarIvaNoDiscriminado, 2) <> mvarSubtotal Then
                //         With oRsCont
                //           s.Haber =s.Haber + (mvarSubtotal - (mvarNetoGravadoItemSuma + mvarIvaNoDiscriminado))
                //            .Update
                //         End With
                //      End If
                //   End If


            }
            catch (Exception ex)
            {

                throw;
            }


            // verificar que el asiento da 0
            // http://stackoverflow.com/questions/3627801/is-it-possible-to-see-added-entities-from-an-unsaved-ef4-context
            //var addedCustomers = from se in db.ObjectContext.get db.ObjectStateManager.GetObjectStateEntries(System.Data.Entity.EntityState.Added)
            //     where se.Entity is Subdiario
            //     select se.Entity;














            //            Public Function RegistroContable() As ador.Recordset

            //   Dim oSrv As InterFazMTS.iCompMTS
            //   Dim oRs As ador.Recordset
            //   Dim oRsCont As ador.Recordset
            //   Dim oRsDet As ador.Recordset
            //   Dim oRsDetBD As ador.Recordset
            //   Dim oFld As ador.Field
            //   Dim mvarEjercicio As Long, mvarCuentaCompras As Long, mvarCuentaProveedor As Long
            //   Dim mvarCuentaBonificaciones As Long, mvarCuentaIvaInscripto As Long
            //   Dim mvarCuentaIvaNoInscripto As Long, mvarCuentaIvaSinDiscriminar As Long
            //   Dim mvarCuentaComprasTitulo As Long, mvarIdCuenta As Long
            //   Dim mvarCuentaReintegros As Long
            //   Dim mvarTotalCompra As Double, mvarImporte As Double, mvarDecimales As Double
            //   Dim mvarPorcentajeIVA As Double, mvarIVA1 As Double, mvarAjusteIVA As Double
            //   Dim mvarTotalIVANoDiscriminado As Double, mvarDebe As Double, mvarHaber As Double
            //   Dim mIdTipoComprobante As Integer, mCoef As Integer, i As Integer
            //   Dim mvarEsta As Boolean, mvarSubdiarios_ResumirRegistros As Boolean

            //   Set oSrv = CreateObject("MTSPronto.General")

            //   mIdTipoComprobante = Registro.Fields("IdTipoComprobante").Value
            //   Set oRs = oSrv.LeerUno("TiposComprobante", mIdTipoComprobante)
            //   mCoef = oRs.Fields("Coeficiente").Value
            //   oRs.Close

            //   Set oRs = oSrv.LeerUno("Parametros", 1)
            //   mvarEjercicio = oRs.Fields("EjercicioActual").Value
            //   mvarCuentaCompras = oRs.Fields("IdCuentaCompras").Value
            //   mvarCuentaComprasTitulo = oRs.Fields("IdCuentaComprasTitulo").Value
            //   mvarCuentaBonificaciones = oRs.Fields("IdCuentaBonificaciones").Value
            //   mvarCuentaIvaInscripto = oRs.Fields("IdCuentaIvaCompras").Value
            //   mvarCuentaIvaNoInscripto = oRs.Fields("IdCuentaIvaCompras").Value
            //   mvarCuentaIvaSinDiscriminar = oRs.Fields("IdCuentaIvaSinDiscriminar").Value
            //   mvarDecimales = oRs.Fields("Decimales").Value
            //   mvarCuentaProveedor = IIf(IsNull(oRs.Fields("IdCuentaAcreedoresVarios").Value), 0, oRs.Fields("IdCuentaAcreedoresVarios").Value)
            //   If IsNull(oRs.Fields("Subdiarios_ResumirRegistros").Value) Or oRs.Fields("Subdiarios_ResumirRegistros").Value = "SI" Then
            //      mvarSubdiarios_ResumirRegistros = True
            //   Else
            //      mvarSubdiarios_ResumirRegistros = False
            //   End If
            //   mvarCuentaReintegros = IIf(IsNull(oRs.Fields("IdCuentaReintegros").Value), 0, oRs.Fields("IdCuentaReintegros").Value)
            //   oRs.Close

            //   If Not IsNull(Registro.Fields("IdProveedor").Value) Then
            //      Set oRs = oSrv.LeerUno("Proveedores", Registro.Fields("IdProveedor").Value)
            //      If Not IsNull(oRs.Fields("IdCuenta").Value) Then mvarCuentaProveedor = oRs.Fields("IdCuenta").Value
            //      oRs.Close
            //   ElseIf Not IsNull(Registro.Fields("IdCuenta").Value) Then
            //      mvarCuentaProveedor = Registro.Fields("IdCuenta").Value
            //   ElseIf Not IsNull(Registro.Fields("IdCuentaOtros").Value) Then
            //      mvarCuentaProveedor = Registro.Fields("IdCuentaOtros").Value
            //   End If

            //   mvarAjusteIVA = IIf(IsNull(Registro.Fields("AjusteIVA").Value), 0, Registro.Fields("AjusteIVA").Value)

            //   Set oRsCont = CreateObject("ADOR.Recordset")
            //   Set oRs = oSrv.TraerFiltrado("Subdiarios", "_Estructura")

            //   With oRs
            //      For Each oFld In .Fields
            //         With oFld
            //            oRsCont.Fields.Append .Name, .Type, .DefinedSize, .Attributes
            //            oRsCont.Fields.Item(.Name).Precision = .Precision
            //            oRsCont.Fields.Item(.Name).NumericScale = .NumericScale
            //         End With
            //      Next
            //      oRsCont.Open
            //   End With
            //   oRs.Close

            //   If Not IsNull(Registro.Fields("Confirmado").Value) And Registro.Fields("Confirmado").Value = "NO" Then
            //      GoTo Salida
            //   End If

            //   With oRsCont
            //      .AddNew
            //      .Fields("Ejercicio").Value = mvarEjercicio
            //      .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
            //      .Fields("IdCuenta").Value = mvarCuentaProveedor
            //      .Fields("IdTipoComprobante").Value = mIdTipoComprobante
            //      .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
            //      .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
            //      .Fields("IdComprobante").Value = Registro.Fields(0).Value
            //      If mCoef = 1 Then
            //         .Fields("Haber").Value = Registro.Fields("TotalComprobante").Value
            //      Else
            //         .Fields("Debe").Value = Registro.Fields("TotalComprobante").Value
            //      End If
            //      .Update
            //   End With

            //   If Not IsNull(Registro.Fields("TotalBonificacion").Value) Then
            //      If Registro.Fields("TotalBonificacion").Value <> 0 Then
            //         With oRsCont
            //            .AddNew
            //            .Fields("Ejercicio").Value = mvarEjercicio
            //            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
            //            .Fields("IdCuenta").Value = mvarCuentaBonificaciones
            //            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
            //            .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
            //            .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
            //            .Fields("IdComprobante").Value = Registro.Fields(0).Value
            //            If mCoef = 1 Then
            //               .Fields("Haber").Value = Registro.Fields("TotalBonificacion").Value
            //            Else
            //               .Fields("Debe").Value = Registro.Fields("TotalBonificacion").Value
            //            End If
            //            .Update
            //         End With
            //      End If
            //   End If

            //   Set oRsDet = Me.DetComprobantesProveedores.Registros
            //   With oRsDet
            //      If .Fields.Count > 0 Then
            //         If .RecordCount > 0 Then
            //            .MoveFirst
            //            Do While Not .EOF
            //               If Not .Fields("Eliminado").Value Then
            //                  With oRsCont

            //                     mvarTotalIVANoDiscriminado = 0

            //                     For i = 1 To 10
            //                        If oRsDet.Fields("AplicarIVA" & i).Value = "SI" Then
            //                           mvarImporte = oRsDet.Fields("Importe").Value
            //                           mvarPorcentajeIVA = IIf(IsNull(oRsDet.Fields("IVAComprasPorcentaje" & i).Value), 0, oRsDet.Fields("IVAComprasPorcentaje" & i).Value)
            //                           If Registro.Fields("Letra").Value = "A" Or Registro.Fields("Letra").Value = "M" Then
            //                              mvarIVA1 = Round(mvarImporte * mvarPorcentajeIVA / 100, mvarDecimales)
            //                           Else
            //                              mvarIVA1 = Round((mvarImporte / (1 + (mvarPorcentajeIVA / 100))) * (mvarPorcentajeIVA / 100), mvarDecimales)
            //                              mvarTotalIVANoDiscriminado = mvarTotalIVANoDiscriminado + mvarIVA1
            //                           End If
            //                           If mvarAjusteIVA <> 0 Then
            //                              mvarIVA1 = mvarIVA1 + mvarAjusteIVA
            //                              mvarAjusteIVA = 0
            //                              Registro.Fields("PorcentajeIVAAplicacionAjuste").Value = mvarPorcentajeIVA
            //                              Registro.Update
            //                           End If
            //                           mvarDebe = 0
            //                           mvarHaber = 0
            //                           If mCoef = 1 Then
            //                              If mvarIVA1 >= 0 Then
            //                                 mvarDebe = mvarIVA1
            //                              Else
            //                                 mvarHaber = mvarIVA1 * -1
            //                              End If
            //                           Else
            //                              If mvarIVA1 >= 0 Then
            //                                 mvarHaber = mvarIVA1
            //                              Else
            //                                 mvarDebe = mvarIVA1 * -1
            //                              End If
            //                           End If
            //                           mvarEsta = False
            //                           If .RecordCount > 0 Then
            //                              .MoveFirst
            //                              Do While Not .EOF
            //                                 If .Fields("IdCuenta").Value = oRsDet.Fields("IdCuentaIvaCompras" & i).Value And _
            //                                       ((mvarDebe <> 0 And Not IsNull(.Fields("Debe").Value)) Or _
            //                                          (mvarHaber <> 0 And Not IsNull(.Fields("Haber").Value))) Then
            //                                    mvarEsta = True
            //                                    Exit Do
            //                                 End If
            //                                 .MoveNext
            //                              Loop
            //                           End If
            //                           If Not mvarEsta Or Not mvarSubdiarios_ResumirRegistros Then .AddNew
            //                           .Fields("Ejercicio").Value = mvarEjercicio
            //                           .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
            //                           .Fields("IdCuenta").Value = oRsDet.Fields("IdCuentaIvaCompras" & i).Value
            //                           .Fields("IdTipoComprobante").Value = mIdTipoComprobante
            //                           .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
            //                           .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
            //                           .Fields("IdComprobante").Value = Registro.Fields(0).Value
            //                           If mvarDebe <> 0 Then
            //                              .Fields("Debe").Value = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value) + mvarDebe
            //                           Else
            //                              .Fields("Haber").Value = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value) + mvarHaber
            //                           End If
            //                           If Not mvarSubdiarios_ResumirRegistros Then
            //                              .Fields("IdDetalleComprobante").Value = oRsDet.Fields(0).Value
            //                           End If
            //                           .Update
            //                        End If
            //                     Next

            //                     mvarDebe = 0
            //                     mvarHaber = 0
            //                     If mCoef = 1 Then
            //                        mvarDebe = oRsDet.Fields("Importe").Value - mvarTotalIVANoDiscriminado
            //                     Else
            //                        mvarHaber = oRsDet.Fields("Importe").Value - mvarTotalIVANoDiscriminado
            //                     End If
            //                     mvarIdCuenta = mvarCuentaCompras
            //                     If Not IsNull(oRsDet.Fields("IdCuenta").Value) Then
            //                        mvarIdCuenta = oRsDet.Fields("IdCuenta").Value
            //                     End If
            //                     mvarEsta = False
            //                     If .RecordCount > 0 Then
            //                        .MoveFirst
            //                        Do While Not .EOF
            //                           If .Fields("IdCuenta").Value = mvarIdCuenta And _
            //                                 ((mvarDebe <> 0 And Not IsNull(.Fields("Debe").Value)) Or _
            //                                    (mvarHaber <> 0 And Not IsNull(.Fields("Haber").Value))) Then
            //                              mvarEsta = True
            //                              Exit Do
            //                           End If
            //                           .MoveNext
            //                        Loop
            //                     End If
            //                     If Not mvarEsta Or Not mvarSubdiarios_ResumirRegistros Then .AddNew
            //                     .Fields("Ejercicio").Value = mvarEjercicio
            //                     .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
            //                     .Fields("IdCuenta").Value = mvarIdCuenta
            //                     .Fields("IdTipoComprobante").Value = mIdTipoComprobante
            //                     .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
            //                     .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
            //                     .Fields("IdComprobante").Value = Registro.Fields(0).Value
            //                     If mvarDebe <> 0 Then
            //                        If mvarDebe > 0 Then
            //                           .Fields("Debe").Value = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value) + mvarDebe
            //                        Else
            //                           .Fields("Haber").Value = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value) + (mvarDebe * -1)
            //                        End If
            //                     Else
            //                        If mvarHaber > 0 Then
            //                           .Fields("Haber").Value = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value) + mvarHaber
            //                        Else
            //                           .Fields("Debe").Value = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value) + (mvarHaber * -1)
            //                        End If
            //                     End If
            //                     If Not mvarSubdiarios_ResumirRegistros Then
            //                        .Fields("IdDetalleComprobante").Value = oRsDet.Fields(0).Value
            //                     End If
            //                     .Update

            //                  End With
            //               End If
            //               .MoveNext
            //            Loop
            //         End If
            //      End If
            //   End With

            //   Set oRsDetBD = oSrv.TraerFiltrado("DetComprobantesProveedores", "_PorIdCabecera", Registro.Fields(0).Value)
            //   With oRsDetBD
            //      If .RecordCount > 0 Then
            //         .MoveFirst
            //         Do While Not .EOF
            //            mvarEsta = False
            //            If oRsDet.Fields.Count > 0 Then
            //               If oRsDet.RecordCount > 0 Then
            //                  oRsDet.MoveFirst
            //                  Do While Not oRsDet.EOF
            //                     If .Fields(0).Value = oRsDet.Fields(0).Value Then
            //                        mvarEsta = True
            //                        Exit Do
            //                     End If
            //                     oRsDet.MoveNext
            //                  Loop
            //               End If
            //            End If
            //            If Not mvarEsta Then
            //               With oRsCont
            //                  .AddNew
            //                  .Fields("Ejercicio").Value = mvarEjercicio
            //                  .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
            //                  If Not IsNull(oRsDetBD.Fields("IdCuenta").Value) Then
            //                     .Fields("IdCuenta").Value = oRsDetBD.Fields("IdCuenta").Value
            //                  Else
            //                     .Fields("IdCuenta").Value = mvarCuentaCompras
            //                  End If
            //                  .Fields("IdTipoComprobante").Value = mIdTipoComprobante
            //                  .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
            //                  .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
            //                  .Fields("IdComprobante").Value = Registro.Fields(0).Value
            //                  If mCoef = 1 Then
            //                     .Fields("Debe").Value = oRsDetBD.Fields("Importe").Value - mvarTotalIVANoDiscriminado
            //                  Else
            //                     .Fields("Haber").Value = oRsDetBD.Fields("Importe").Value - mvarTotalIVANoDiscriminado
            //                  End If
            //                  If Not mvarSubdiarios_ResumirRegistros Then
            //                     .Fields("IdDetalleComprobante").Value = oRsDetBD.Fields(0).Value
            //                  End If
            //                  .Update

            //                  mvarTotalIVANoDiscriminado = 0

            //                  For i = 1 To 10
            //                     If oRsDetBD.Fields("AplicarIVA" & i).Value = "SI" Then
            //                        mvarImporte = oRsDetBD.Fields("Importe").Value
            //                        mvarPorcentajeIVA = IIf(IsNull(oRsDetBD.Fields("IVAComprasPorcentaje" & i).Value), 0, oRsDetBD.Fields("IVAComprasPorcentaje" & i).Value)
            //                        If Registro.Fields("Letra").Value = "A" Or Registro.Fields("Letra").Value = "M" Then
            //                           mvarIVA1 = Round(mvarImporte * mvarPorcentajeIVA / 100, mvarDecimales)
            //                        Else
            //                           mvarIVA1 = Round((mvarImporte / (1 + (mvarPorcentajeIVA / 100))) * (mvarPorcentajeIVA / 100), mvarDecimales)
            //                           mvarTotalIVANoDiscriminado = mvarTotalIVANoDiscriminado + mvarIVA1
            //                        End If
            //                        If mvarAjusteIVA <> 0 Then
            //                           mvarIVA1 = mvarIVA1 + mvarAjusteIVA
            //                           mvarAjusteIVA = 0
            //                           Registro.Fields("PorcentajeIVAAplicacionAjuste").Value = mvarPorcentajeIVA
            //                           Registro.Update
            //                        End If
            //                        .AddNew
            //                        .Fields("Ejercicio").Value = mvarEjercicio
            //                        .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
            //                        .Fields("IdCuenta").Value = oRsDetBD.Fields("IdCuentaIvaCompras" & i).Value
            //                        .Fields("IdTipoComprobante").Value = mIdTipoComprobante
            //                        .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
            //                        .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
            //                        .Fields("IdComprobante").Value = Registro.Fields(0).Value
            //                        If mCoef = 1 Then
            //                           If mvarIVA1 >= 0 Then
            //                              .Fields("Debe").Value = mvarIVA1
            //                           Else
            //                              .Fields("Haber").Value = mvarIVA1 * -1
            //                           End If
            //                        Else
            //                           If mvarIVA1 >= 0 Then
            //                              .Fields("Haber").Value = mvarIVA1
            //                           Else
            //                              .Fields("Debe").Value = mvarIVA1 * -1
            //                           End If
            //                        End If
            //                        If Not mvarSubdiarios_ResumirRegistros Then
            //                           .Fields("IdDetalleComprobante").Value = oRsDetBD.Fields(0).Value
            //                        End If
            //                        .Update
            //                     End If
            //                  Next

            //               End With
            //            End If
            //            .MoveNext
            //         Loop
            //      End If
            //      .Close
            //   End With
            //   Set oRsDetBD = Nothing

            //   If oRsDet.Fields.Count > 0 Then oRsDet.Close

            //   If Not IsNull(Registro.Fields("ReintegroIdCuenta").Value) Then
            //      If Registro.Fields("ReintegroImporte").Value <> 0 Then
            //         With oRsCont
            //            .AddNew
            //            .Fields("Ejercicio").Value = mvarEjercicio
            //            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
            //            .Fields("IdCuenta").Value = mvarCuentaReintegros
            //            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
            //            .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
            //            .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
            //            .Fields("IdComprobante").Value = Registro.Fields(0).Value
            //            If mCoef = 1 Then
            //               .Fields("Haber").Value = Registro.Fields("ReintegroImporte").Value
            //            Else
            //               .Fields("Debe").Value = Registro.Fields("ReintegroImporte").Value
            //            End If
            //            .Update
            //            .AddNew
            //            .Fields("Ejercicio").Value = mvarEjercicio
            //            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
            //            .Fields("IdCuenta").Value = Registro.Fields("ReintegroIdCuenta").Value
            //            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
            //            .Fields("NumeroComprobante").Value = Registro.Fields("NumeroReferencia").Value
            //            .Fields("FechaComprobante").Value = Registro.Fields("FechaRecepcion").Value
            //            .Fields("IdComprobante").Value = Registro.Fields(0).Value
            //            If mCoef = 1 Then
            //               .Fields("Debe").Value = Registro.Fields("ReintegroImporte").Value
            //            Else
            //               .Fields("Haber").Value = Registro.Fields("ReintegroImporte").Value
            //            End If
            //            .Update
            //         End With
            //      End If
            //   End If


        }


        public void Logica_EliminarRegistroAnterior(ComprobanteProveedor o) { }

        public void Logica_ActualizarCuentaCorriente(ComprobanteProveedor o)
        {

            var mImporteAnterior = 0;
            var mTotalAnteriorDolar = 0;


            ProntoMVC.Data.Models.CuentasCorrientesDeudor a = new CuentasCorrientesDeudor();





            //if (o.IdFactura <= 0)
            //{
            //    //            mImporteAnterior = iisNull(.Item("ImporteTotal"), 0)
            //    //            mTotalAnteriorDolar = iisNull(.Item("ImporteTotalDolar"), 0)
            //}
            //a.IdCliente = o.IdCliente;
            //a.NumeroComprobante = o.NumeroFactura;
            //a.Fecha = o.FechaFactura; // mvarFecha;
            //a.IdTipoComp = 1;
            //a.FechaVencimiento = o.FechaVencimiento;
            //a.IdComprobante = o.IdFactura;
            //a.Cotizacion = o.CotizacionDolar;
            //a.IdMoneda = o.IdMoneda;
            //a.CotizacionMoneda = o.CotizacionMoneda;

            //if (o.Anulada == "SI")
            //{
            //    a.ImporteTotal = 0;
            //    a.Saldo = 0;
            //    a.ImporteTotalDolar = 0;
            //    a.SaldoDolar = 0;
            //}
            //else
            //{
            //    a.ImporteTotal = Math.Round(o.ImporteTotal * o.CotizacionMoneda ?? 0, 2);
            //    a.Saldo = Math.Round(o.ImporteTotal * o.CotizacionMoneda ?? 0, 2) - mImporteAnterior;
            //    a.ImporteTotalDolar = o.ImporteTotal * o.CotizacionMoneda / o.CotizacionDolar;
            //    a.SaldoDolar = (o.ImporteTotal * o.CotizacionMoneda / o.CotizacionDolar) - mTotalAnteriorDolar;
            //}

            //db.CuentasCorrientesDeudores.Add(a);


            // ?????  a.IdImputacion=


            //    '////////////////////////////
            //    'cambio el saldo en la entidad cliente
            ////    '////////////////////////////
            //if (o.IdCliente > 0)
            //{
            //    var c = db.Clientes.Find(o.IdCliente);

            //    if (o.Anulada == "SI")
            //    {
            //        c.Saldo += -mImporteAnterior;
            //    }
            //    else
            //    {
            //        c.Saldo += -mImporteAnterior + Math.Round((o.ImporteTotal ?? 0) * (o.CotizacionMoneda ?? 0), 2);
            //    }


            //}






        }




        /// <summary>
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// </summary>
        /// <param name="clave"></param>
        /// <returns></returns>


        public string BuscarClaveINI(string clave, string usuario)
        {

            var db = comprobantesproveedorRepositorio.HACKEADOcontext;

            // if (usuario == "") usuario = Membership.GetUser().UserName; //ViewBag.NombreUsuario;
            int IdUsuario = comprobantesproveedorRepositorio.HACKEADOcontext.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
            //string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));

            var idclav = comprobantesproveedorRepositorio.HACKEADOcontext.ProntoIniClaves.Where(x => x.Clave == clave).Select(x => x.IdProntoIniClave).FirstOrDefault();
            string idclava = comprobantesproveedorRepositorio.HACKEADOcontext.ProntoIni.Where(x => x.IdProntoIniClave == idclav && x.IdUsuario == IdUsuario).Select(x => x.Valor).FirstOrDefault();

            return idclava;
        }


        public int buscaridproveedorporcuit(string cuit)
        {
            var provs = comprobantesproveedorRepositorio.HACKEADOcontext.Proveedores.Where(p => p.Cuit.Replace("-", "") == cuit.Replace("-", ""));
            return provs.Select(p => p.IdProveedor).FirstOrDefault();

        }



        public int buscaridclienteporcuit(string cuit)
        {
            var provs = comprobantesproveedorRepositorio.HACKEADOcontext.Clientes.Where(p => p.Cuit.Replace("-", "") == cuit.Replace("-", ""));
            return provs.Select(p => p.IdCliente).FirstOrDefault();

        }





    }
}




public static partial class Generales2
{
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