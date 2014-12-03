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

        public void Logica_AsientoRegistroContable(ComprobanteProveedor o)
        {


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

        public void Logica_AsientoRegistroContable(ComprobanteProveedor o)
        {


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