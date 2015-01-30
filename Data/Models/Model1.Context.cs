﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ProntoMVC.Data.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class DemoProntoEntities : DbContext
    {
        public DemoProntoEntities()
            : base("name=DemoProntoEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Articulo> Articulos { get; set; }
        public virtual DbSet<ControlCalidad> ControlesCalidads { get; set; }
        public virtual DbSet<DetalleRequerimiento> DetalleRequerimientos { get; set; }
        public virtual DbSet<Obra> Obras { get; set; }
        public virtual DbSet<Requerimiento> Requerimientos { get; set; }
        public virtual DbSet<Sector> Sectores { get; set; }
        public virtual DbSet<Unidad> Unidades { get; set; }
        public virtual DbSet<Parametros> Parametros { get; set; }
        public virtual DbSet<Parametros2> Parametros2 { get; set; }
        public virtual DbSet<Vendedor> Vendedores { get; set; }
        public virtual DbSet<Cliente> Clientes { get; set; }
        public virtual DbSet<PuntosVenta> PuntosVentas { get; set; }
        public virtual DbSet<Condiciones_Compra> Condiciones_Compras { get; set; }
        public virtual DbSet<Ganancia> Ganancias { get; set; }
        public virtual DbSet<IGCondicion> IGCondiciones { get; set; }
        public virtual DbSet<ListasPrecio> ListasPrecios { get; set; }
        public virtual DbSet<TiposRetencionGanancia> TiposRetencionGanancias { get; set; }
        public virtual DbSet<Concepto> Conceptos { get; set; }
        public virtual DbSet<Cuenta> Cuentas { get; set; }
        public virtual DbSet<DetallePedido> DetallePedidos { get; set; }
        public virtual DbSet<DetallePresupuesto> DetallePresupuestos { get; set; }
        public virtual DbSet<Pedido> Pedidos { get; set; }
        public virtual DbSet<Presupuesto> Presupuestos { get; set; }
        public virtual DbSet<IBCondicion> IBCondiciones { get; set; }
        public virtual DbSet<Localidad> Localidades { get; set; }
        public virtual DbSet<Moneda> Monedas { get; set; }
        public virtual DbSet<Pais> Paises { get; set; }
        public virtual DbSet<Provincia> Provincias { get; set; }
        public virtual DbSet<TiposComprobante> TiposComprobantes { get; set; }
        public virtual DbSet<DetalleFactura> DetalleFacturas { get; set; }
        public virtual DbSet<Factura> Facturas { get; set; }
        public virtual DbSet<DetalleProveedor> DetalleProveedoresContactos { get; set; }
        public virtual DbSet<DetalleProveedoresIB> DetalleProveedoresIBs { get; set; }
        public virtual DbSet<DetalleProveedoresRubro> DetalleProveedoresRubros { get; set; }
        public virtual DbSet<PlazosEntrega> PlazosEntregas { get; set; }
        public virtual DbSet<Proveedor> Proveedores { get; set; }
        public virtual DbSet<Rubro> Rubros { get; set; }
        public virtual DbSet<DetalleCliente> DetalleClientesContactos { get; set; }
        public virtual DbSet<DetalleClientesLugaresEntrega> DetalleClientesLugaresEntregas { get; set; }
        public virtual DbSet<BancoChequera> BancoChequeras { get; set; }
        public virtual DbSet<Banco> Bancos { get; set; }
        public virtual DbSet<TarjetasCredito> TarjetasCreditoes { get; set; }
        public virtual DbSet<Estados_Proveedore> Estados_Proveedores { get; set; }
        public virtual DbSet<Cotizacione> Cotizaciones { get; set; }
        public virtual DbSet<CuentasCorrientesAcreedor> CuentasCorrientesAcreedores { get; set; }
        public virtual DbSet<CuentasCorrientesDeudor> CuentasCorrientesDeudores { get; set; }
        public virtual DbSet<CuentasEjerciciosContable> CuentasEjerciciosContables { get; set; }
        public virtual DbSet<CuentasGasto> CuentasGastos { get; set; }
        public virtual DbSet<DetalleCuenta> DetalleCuentas { get; set; }
        public virtual DbSet<DetalleOrdenesCompra> DetalleOrdenesCompras { get; set; }
        public virtual DbSet<DetalleRemito> DetalleRemitos { get; set; }
        public virtual DbSet<OrdenesCompra> OrdenesCompras { get; set; }
        public virtual DbSet<Remito> Remitos { get; set; }
        public virtual DbSet<DetalleFacturasClientesPRESTO> DetalleFacturasClientesPRESTOes { get; set; }
        public virtual DbSet<DetalleFacturasOrdenesCompra> DetalleFacturasOrdenesCompras { get; set; }
        public virtual DbSet<DetalleFacturasProvincia> DetalleFacturasProvincias { get; set; }
        public virtual DbSet<DetalleFacturasRemito> DetalleFacturasRemitos { get; set; }
        public virtual DbSet<DetalleArticulosActivosFijo> DetalleArticulosActivosFijos { get; set; }
        public virtual DbSet<DetalleArticulosDocumento> DetalleArticulosDocumentos { get; set; }
        public virtual DbSet<DetalleArticulosImagene> DetalleArticulosImagenes { get; set; }
        public virtual DbSet<DetalleArticulosUnidade> DetalleArticulosUnidades { get; set; }
        public virtual DbSet<DefinicionArticulo> DefinicionArticulos { get; set; }
        public virtual DbSet<Deposito> Depositos { get; set; }
        public virtual DbSet<Stock> Stocks { get; set; }
        public virtual DbSet<Ubicacion> Ubicaciones { get; set; }
        public virtual DbSet<EmpleadosAcceso> EmpleadosAccesos { get; set; }
        public virtual DbSet<DetalleRecibo> DetalleRecibos { get; set; }
        public virtual DbSet<DetalleRecibosCuenta> DetalleRecibosCuentas { get; set; }
        public virtual DbSet<DetalleRecibosRubrosContable> DetalleRecibosRubrosContables { get; set; }
        public virtual DbSet<DetalleRecibosValore> DetalleRecibosValores { get; set; }
        public virtual DbSet<Recibo> Recibos { get; set; }
        public virtual DbSet<RubrosContable> RubrosContables { get; set; }
        public virtual DbSet<RubrosValore> RubrosValores { get; set; }
        public virtual DbSet<Comparativa> Comparativas { get; set; }
        public virtual DbSet<DetalleComparativa> DetalleComparativas { get; set; }
        public virtual DbSet<Autorizacione> Autorizaciones { get; set; }
        public virtual DbSet<AutorizacionesCompra> AutorizacionesCompras { get; set; }
        public virtual DbSet<AutorizacionesPorComprobante1> AutorizacionesPorComprobante1 { get; set; }
        public virtual DbSet<AutorizacionesPorComprobanteADesignar> AutorizacionesPorComprobanteADesignars { get; set; }
        public virtual DbSet<DetalleAutorizacione> DetalleAutorizaciones { get; set; }
        public virtual DbSet<DetalleAutorizacionesCompra> DetalleAutorizacionesCompras { get; set; }
        public virtual DbSet<DetalleAutorizacionesFirmante> DetalleAutorizacionesFirmantes { get; set; }
        public virtual DbSet<ProntoIni> ProntoIni { get; set; }
        public virtual DbSet<ProntoIniClaves> ProntoIniClaves { get; set; }
        public virtual DbSet<DetalleOrdenesPago> DetalleOrdenesPagoes { get; set; }
        public virtual DbSet<DetalleOrdenesPagoCuenta> DetalleOrdenesPagoCuentas { get; set; }
        public virtual DbSet<DetalleOrdenesPagoRendicionesFF> DetalleOrdenesPagoRendicionesFFs { get; set; }
        public virtual DbSet<DetalleOrdenesPagoRubrosContable> DetalleOrdenesPagoRubrosContables { get; set; }
        public virtual DbSet<DetalleOrdenesPagoValore> DetalleOrdenesPagoValores { get; set; }
        public virtual DbSet<OrdenPago> OrdenesPago { get; set; }
        public virtual DbSet<ComprobanteProveedor> ComprobantesProveedor { get; set; }
        public virtual DbSet<DetalleComprobantesProveedore> DetalleComprobantesProveedores { get; set; }
        public virtual DbSet<DetalleComprobantesProveedoresPresupuestosObra> DetalleComprobantesProveedoresPresupuestosObras { get; set; }
        public virtual DbSet<DetalleComprobantesProveedoresProvincia> DetalleComprobantesProveedoresProvincias { get; set; }
        public virtual DbSet<Caja> Cajas { get; set; }
        public virtual DbSet<DetalleEmpleadosCuentasBancaria> DetalleEmpleadosCuentasBancarias { get; set; }
        public virtual DbSet<DetalleEmpleadosJornada> DetalleEmpleadosJornadas { get; set; }
        public virtual DbSet<DetalleEmpleadosSectore> DetalleEmpleadosSectores { get; set; }
        public virtual DbSet<DetalleNotasCredito> DetalleNotasCreditoes { get; set; }
        public virtual DbSet<DetalleNotasCreditoImputacione> DetalleNotasCreditoImputaciones { get; set; }
        public virtual DbSet<DetalleNotasCreditoOrdenesCompra> DetalleNotasCreditoOrdenesCompras { get; set; }
        public virtual DbSet<DetalleNotasCreditoProvincia> DetalleNotasCreditoProvincias { get; set; }
        public virtual DbSet<DetalleNotasDebito> DetalleNotasDebitoes { get; set; }
        public virtual DbSet<DetalleNotasDebitoProvincia> DetalleNotasDebitoProvincias { get; set; }
        public virtual DbSet<Ejercicio> Ejercicios { get; set; }
        public virtual DbSet<EjerciciosContable> EjerciciosContables { get; set; }
        public virtual DbSet<EjerciciosPeriodo> EjerciciosPeriodos { get; set; }
        public virtual DbSet<Empresa> Empresas { get; set; }
        public virtual DbSet<Formulario> Formularios { get; set; }
        public virtual DbSet<NotasCredito> NotasCreditoes { get; set; }
        public virtual DbSet<NotasDebito> NotasDebitoes { get; set; }
        public virtual DbSet<TiposValore> TiposValores { get; set; }
        public virtual DbSet<TiposCuenta> TiposCuentas { get; set; }
        public virtual DbSet<TiposCuentaGrupos> TiposCuentaGrupos { get; set; }
        public virtual DbSet<Titulo> Titulos { get; set; }
        public virtual DbSet<DescripcionIva> DescripcionIvas { get; set; }
        public virtual DbSet<Conjunto> Conjuntos { get; set; }
        public virtual DbSet<Subrubro> Subrubros { get; set; }
        public virtual DbSet<DetalleOrdenesPagoImpuesto> DetalleOrdenesPagoImpuestos { get; set; }
        public virtual DbSet<Subdiario> Subdiarios { get; set; }
        public virtual DbSet<ListasPreciosDetalle> ListasPreciosDetalles { get; set; }
        public virtual DbSet<C_TempAutorizaciones> C_TempAutorizaciones { get; set; }
        public virtual DbSet<Transportista> Transportistas { get; set; }
        public virtual DbSet<DetalleEmpleadosObra> DetalleEmpleadosObras { get; set; }
        public virtual DbSet<DetalleEmpleadosUbicacione> DetalleEmpleadosUbicaciones { get; set; }
        public virtual DbSet<Cargo> Cargos { get; set; }
        public virtual DbSet<CuentasBancaria> CuentasBancarias { get; set; }
        public virtual DbSet<DetalleEmpleado> DetalleEmpleadosIngresosEgresos { get; set; }
        public virtual DbSet<Empleado> Empleados { get; set; }
        public virtual DbSet<Valore> Valores { get; set; }
        public virtual DbSet<CurvasTalle> CurvasTalles { get; set; }
        public virtual DbSet<ImpuestosDirecto> ImpuestosDirectos { get; set; }
        public virtual DbSet<Marca> Marcas { get; set; }
        public virtual DbSet<Materiale> Materiales { get; set; }
        public virtual DbSet<Modelo> Modelos { get; set; }
        public virtual DbSet<Actividades_Proveedore> Actividades_Proveedores { get; set; }
        public virtual DbSet<DiferenciasCambio> DiferenciasCambios { get; set; }
        public virtual DbSet<Asiento> Asientos { get; set; }
        public virtual DbSet<DetalleAsiento> DetalleAsientos { get; set; }
        public virtual DbSet<Conciliacione> Conciliaciones { get; set; }
        public virtual DbSet<DetalleConciliacione> DetalleConciliaciones { get; set; }
        public virtual DbSet<DetalleConciliacionesNoContable> DetalleConciliacionesNoContables { get; set; }
        public virtual DbSet<Tree> Trees { get; set; }
        public virtual DbSet<TiposImpuesto> TiposImpuestoes { get; set; }
        public virtual DbSet<Regione> Regiones { get; set; }
        public virtual DbSet<DetalleClientesDireccione> DetalleClientesDirecciones { get; set; }
        public virtual DbSet<DetalleClientesTelefono> DetalleClientesTelefonos { get; set; }
        public virtual DbSet<Calle> Calles { get; set; }
        public virtual DbSet<Feriado> Feriados { get; set; }
        public virtual DbSet<TiposCompra> TiposCompras { get; set; }
        public virtual DbSet<TiposNegociosVenta> TiposNegociosVentas { get; set; }
        public virtual DbSet<TiposOperacione> TiposOperaciones { get; set; }
        public virtual DbSet<TiposOperacionesGrupos> TiposOperacionesGrupos { get; set; }
        public virtual DbSet<GruposObra> GruposObras { get; set; }
        public virtual DbSet<UnidadesOperativa> UnidadesOperativas { get; set; }
        public virtual DbSet<Colore> Colores { get; set; }
        public virtual DbSet<DetalleObrasEquiposInstalado> DetalleObrasEquiposInstalados { get; set; }
        public virtual DbSet<DetalleObrasEquiposInstalados2> DetalleObrasEquiposInstalados2 { get; set; }
        public virtual DbSet<DetalleObrasPoliza> DetalleObrasPolizas { get; set; }
        public virtual DbSet<TiposPoliza> TiposPolizas { get; set; }
        public virtual DbSet<Devolucione> Devoluciones { get; set; }
    
        public virtual int Requerimientos_ActualizarEstado(Nullable<int> idRequerimiento, Nullable<int> idDetalleRequerimiento)
        {
            var idRequerimientoParameter = idRequerimiento.HasValue ?
                new ObjectParameter("IdRequerimiento", idRequerimiento) :
                new ObjectParameter("IdRequerimiento", typeof(int));
    
            var idDetalleRequerimientoParameter = idDetalleRequerimiento.HasValue ?
                new ObjectParameter("IdDetalleRequerimiento", idDetalleRequerimiento) :
                new ObjectParameter("IdDetalleRequerimiento", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Requerimientos_ActualizarEstado", idRequerimientoParameter, idDetalleRequerimientoParameter);
        }
    
        public virtual ObjectResult<AutorizacionesPorComprobante> AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante(Nullable<int> idFormulario, Nullable<int> idComprobante)
        {
            var idFormularioParameter = idFormulario.HasValue ?
                new ObjectParameter("IdFormulario", idFormulario) :
                new ObjectParameter("IdFormulario", typeof(int));
    
            var idComprobanteParameter = idComprobante.HasValue ?
                new ObjectParameter("IdComprobante", idComprobante) :
                new ObjectParameter("IdComprobante", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<AutorizacionesPorComprobante>("AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante", idFormularioParameter, idComprobanteParameter);
        }
    
        public virtual int Cotizaciones_TX_PorFechaMoneda(Nullable<System.DateTime> fecha, Nullable<int> idMoneda)
        {
            var fechaParameter = fecha.HasValue ?
                new ObjectParameter("Fecha", fecha) :
                new ObjectParameter("Fecha", typeof(System.DateTime));
    
            var idMonedaParameter = idMoneda.HasValue ?
                new ObjectParameter("IdMoneda", idMoneda) :
                new ObjectParameter("IdMoneda", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Cotizaciones_TX_PorFechaMoneda", fechaParameter, idMonedaParameter);
        }
    
        public virtual int OrdenesCompra_TX_ItemsPendientesDeFacturar()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("OrdenesCompra_TX_ItemsPendientesDeFacturar");
        }
    
        public virtual int Remitos_TX_ItemsPendientesDeFacturar()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Remitos_TX_ItemsPendientesDeFacturar");
        }
    
        public virtual ObjectResult<Articulos_TX_DatosConCuenta_Result> Articulos_TX_DatosConCuenta(Nullable<int> idArticulo)
        {
            var idArticuloParameter = idArticulo.HasValue ?
                new ObjectParameter("IdArticulo", idArticulo) :
                new ObjectParameter("IdArticulo", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Articulos_TX_DatosConCuenta_Result>("Articulos_TX_DatosConCuenta", idArticuloParameter);
        }
    
        public virtual int CtasCtesA_TXPorTrs(string pendiente, Nullable<int> idProveedor, Nullable<int> todo, Nullable<System.DateTime> fechaLimite, Nullable<System.DateTime> fechaDesde, Nullable<int> consolidar)
        {
            var pendienteParameter = pendiente != null ?
                new ObjectParameter("Pendiente", pendiente) :
                new ObjectParameter("Pendiente", typeof(string));
    
            var idProveedorParameter = idProveedor.HasValue ?
                new ObjectParameter("IdProveedor", idProveedor) :
                new ObjectParameter("IdProveedor", typeof(int));
    
            var todoParameter = todo.HasValue ?
                new ObjectParameter("Todo", todo) :
                new ObjectParameter("Todo", typeof(int));
    
            var fechaLimiteParameter = fechaLimite.HasValue ?
                new ObjectParameter("FechaLimite", fechaLimite) :
                new ObjectParameter("FechaLimite", typeof(System.DateTime));
    
            var fechaDesdeParameter = fechaDesde.HasValue ?
                new ObjectParameter("FechaDesde", fechaDesde) :
                new ObjectParameter("FechaDesde", typeof(System.DateTime));
    
            var consolidarParameter = consolidar.HasValue ?
                new ObjectParameter("Consolidar", consolidar) :
                new ObjectParameter("Consolidar", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("CtasCtesA_TXPorTrs", pendienteParameter, idProveedorParameter, todoParameter, fechaLimiteParameter, fechaDesdeParameter, consolidarParameter);
        }
    
        public virtual ObjectResult<OrdenesPago_TX_EnCaja_Result> OrdenesPago_TX_EnCaja(string estado, Nullable<int> idUsuario)
        {
            var estadoParameter = estado != null ?
                new ObjectParameter("Estado", estado) :
                new ObjectParameter("Estado", typeof(string));
    
            var idUsuarioParameter = idUsuario.HasValue ?
                new ObjectParameter("IdUsuario", idUsuario) :
                new ObjectParameter("IdUsuario", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<OrdenesPago_TX_EnCaja_Result>("OrdenesPago_TX_EnCaja", estadoParameter, idUsuarioParameter);
        }
    
        public virtual ObjectResult<Nullable<int>> Autorizaciones_TX_CantidadAutorizaciones(Nullable<int> idFormulario, Nullable<decimal> importe, Nullable<int> idComprobante)
        {
            var idFormularioParameter = idFormulario.HasValue ?
                new ObjectParameter("IdFormulario", idFormulario) :
                new ObjectParameter("IdFormulario", typeof(int));
    
            var importeParameter = importe.HasValue ?
                new ObjectParameter("Importe", importe) :
                new ObjectParameter("Importe", typeof(decimal));
    
            var idComprobanteParameter = idComprobante.HasValue ?
                new ObjectParameter("IdComprobante", idComprobante) :
                new ObjectParameter("IdComprobante", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<int>>("Autorizaciones_TX_CantidadAutorizaciones", idFormularioParameter, importeParameter, idComprobanteParameter);
        }
    
        public virtual int AutorizacionesPorComprobante_A(Nullable<int> ordenAutorizacion, Nullable<int> idAutorizo, Nullable<System.DateTime> fechaAutorizacion, string visto, Nullable<int> idFormulario, Nullable<int> idComprobante, ObjectParameter idAutorizacionPorComprobante)
        {
            var ordenAutorizacionParameter = ordenAutorizacion.HasValue ?
                new ObjectParameter("OrdenAutorizacion", ordenAutorizacion) :
                new ObjectParameter("OrdenAutorizacion", typeof(int));
    
            var idAutorizoParameter = idAutorizo.HasValue ?
                new ObjectParameter("IdAutorizo", idAutorizo) :
                new ObjectParameter("IdAutorizo", typeof(int));
    
            var fechaAutorizacionParameter = fechaAutorizacion.HasValue ?
                new ObjectParameter("FechaAutorizacion", fechaAutorizacion) :
                new ObjectParameter("FechaAutorizacion", typeof(System.DateTime));
    
            var vistoParameter = visto != null ?
                new ObjectParameter("Visto", visto) :
                new ObjectParameter("Visto", typeof(string));
    
            var idFormularioParameter = idFormulario.HasValue ?
                new ObjectParameter("IdFormulario", idFormulario) :
                new ObjectParameter("IdFormulario", typeof(int));
    
            var idComprobanteParameter = idComprobante.HasValue ?
                new ObjectParameter("IdComprobante", idComprobante) :
                new ObjectParameter("IdComprobante", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("AutorizacionesPorComprobante_A", ordenAutorizacionParameter, idAutorizoParameter, fechaAutorizacionParameter, vistoParameter, idFormularioParameter, idComprobanteParameter, idAutorizacionPorComprobante);
        }
    
        public virtual int wActualizacionesVariasPorComprobante(Nullable<int> idTipoCOmprobante, Nullable<int> idComprobante, string tipoMovimiento)
        {
            var idTipoCOmprobanteParameter = idTipoCOmprobante.HasValue ?
                new ObjectParameter("IdTipoCOmprobante", idTipoCOmprobante) :
                new ObjectParameter("IdTipoCOmprobante", typeof(int));
    
            var idComprobanteParameter = idComprobante.HasValue ?
                new ObjectParameter("IdComprobante", idComprobante) :
                new ObjectParameter("IdComprobante", typeof(int));
    
            var tipoMovimientoParameter = tipoMovimiento != null ?
                new ObjectParameter("TipoMovimiento", tipoMovimiento) :
                new ObjectParameter("TipoMovimiento", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("wActualizacionesVariasPorComprobante", idTipoCOmprobanteParameter, idComprobanteParameter, tipoMovimientoParameter);
        }
    
        public virtual int Valores_BorrarPorIdDetalleOrdenPagoValores(Nullable<int> idDetalleOrdenPagoValores)
        {
            var idDetalleOrdenPagoValoresParameter = idDetalleOrdenPagoValores.HasValue ?
                new ObjectParameter("IdDetalleOrdenPagoValores", idDetalleOrdenPagoValores) :
                new ObjectParameter("IdDetalleOrdenPagoValores", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Valores_BorrarPorIdDetalleOrdenPagoValores", idDetalleOrdenPagoValoresParameter);
        }
    
        public virtual int Valores_BorrarPorIdDetalleOrdenPagoCuentas(Nullable<int> idDetalleOrdenPagoCuentas)
        {
            var idDetalleOrdenPagoCuentasParameter = idDetalleOrdenPagoCuentas.HasValue ?
                new ObjectParameter("IdDetalleOrdenPagoCuentas", idDetalleOrdenPagoCuentas) :
                new ObjectParameter("IdDetalleOrdenPagoCuentas", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Valores_BorrarPorIdDetalleOrdenPagoCuentas", idDetalleOrdenPagoCuentasParameter);
        }
    
        public virtual int Obras_EliminarCuentasNoUsadasPorIdObra(Nullable<int> idObra)
        {
            var idObraParameter = idObra.HasValue ?
                new ObjectParameter("IdObra", idObra) :
                new ObjectParameter("IdObra", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Obras_EliminarCuentasNoUsadasPorIdObra", idObraParameter);
        }
    }
}
