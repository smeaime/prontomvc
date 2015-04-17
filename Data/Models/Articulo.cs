//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Articulo
    {
        public Articulo()
        {
            this.DetalleRequerimientos = new HashSet<DetalleRequerimiento>();
            this.DetallePedidos = new HashSet<DetallePedido>();
            this.DetallePresupuestos = new HashSet<DetallePresupuesto>();
            this.DetalleFacturas = new HashSet<DetalleFactura>();
            this.DetalleOrdenesCompras = new HashSet<DetalleOrdenesCompra>();
            this.DetalleRemitos = new HashSet<DetalleRemito>();
            this.DetalleArticulosDocumentos = new HashSet<DetalleArticulosDocumento>();
            this.DetalleArticulosImagenes = new HashSet<DetalleArticulosImagene>();
            this.DetalleArticulosUnidades = new HashSet<DetalleArticulosUnidade>();
            this.DetalleComparativas = new HashSet<DetalleComparativa>();
            this.ListasPreciosDetalles = new HashSet<ListasPreciosDetalle>();
            this.DetalleRecepciones = new HashSet<DetalleRecepcione>();
        }
    
        public int IdArticulo { get; set; }
        public Nullable<int> IdRubro { get; set; }
        public Nullable<int> IdSubrubro { get; set; }
        public Nullable<int> IdFamilia { get; set; }
        public string Descripcion { get; set; }
        public string Productivo { get; set; }
        public Nullable<decimal> Ancho { get; set; }
        public Nullable<int> IdCalidad { get; set; }
        public string Diametro { get; set; }
        public Nullable<decimal> Espesor { get; set; }
        public Nullable<int> IdGrado { get; set; }
        public Nullable<decimal> Largo { get; set; }
        public Nullable<int> IdMaterial { get; set; }
        public Nullable<int> IdAcabado { get; set; }
        public Nullable<int> IdTipo { get; set; }
        public string Serie { get; set; }
        public Nullable<int> IdTratamiento { get; set; }
        public Nullable<int> IdUnidad { get; set; }
        public string Autorizacion { get; set; }
        public Nullable<byte> IdInventario { get; set; }
        public Nullable<int> IdCuenta { get; set; }
        public Nullable<int> IdScheduler { get; set; }
        public Nullable<int> Unidad1 { get; set; }
        public Nullable<int> Unidad2 { get; set; }
        public Nullable<int> Unidad3 { get; set; }
        public Nullable<int> Unidad4 { get; set; }
        public Nullable<int> Unidad5 { get; set; }
        public Nullable<int> Unidad6 { get; set; }
        public Nullable<int> Unidad7 { get; set; }
        public Nullable<int> Unidad8 { get; set; }
        public Nullable<int> Unidad9 { get; set; }
        public Nullable<int> Unidad10 { get; set; }
        public Nullable<decimal> Peso { get; set; }
        public Nullable<decimal> DiametroInterno { get; set; }
        public Nullable<int> IdCodigoUniversal { get; set; }
        public Nullable<int> IdRelacion { get; set; }
        public Nullable<int> IdForma { get; set; }
        public Nullable<int> IdSerie { get; set; }
        public Nullable<decimal> Altura { get; set; }
        public Nullable<decimal> Diametro2 { get; set; }
        public Nullable<int> IdColor { get; set; }
        public Nullable<int> IdNorma { get; set; }
        public Nullable<decimal> Capacidad { get; set; }
        public Nullable<decimal> Potencia { get; set; }
        public Nullable<int> IdRango { get; set; }
        public Nullable<int> IdAlimentacionElectrica { get; set; }
        public Nullable<int> IdModelo { get; set; }
        public Nullable<int> IdMarca { get; set; }
        public Nullable<int> IdAnioNorma { get; set; }
        public Nullable<int> Unidad11 { get; set; }
        public Nullable<int> Unidad12 { get; set; }
        public Nullable<int> Unidad13 { get; set; }
        public Nullable<int> Unidad14 { get; set; }
        public Nullable<int> Unidad15 { get; set; }
        public Nullable<int> IdCuantificacion { get; set; }
        public Nullable<int> IdControlCalidad { get; set; }
        public Nullable<int> IdCodigo { get; set; }
        public string Charpy { get; set; }
        public Nullable<int> IdCentroCosto { get; set; }
        public string UsuarioAlta { get; set; }
        public Nullable<System.DateTime> FechaAlta { get; set; }
        public Nullable<System.DateTime> FechaUltimaModificacion { get; set; }
        public Nullable<decimal> EspesorBase { get; set; }
        public Nullable<decimal> EspesorRevestimiento { get; set; }
        public Nullable<int> IdCalidadBase { get; set; }
        public Nullable<int> IdCalidadRevestimiento { get; set; }
        public Nullable<int> IdGradoBase { get; set; }
        public Nullable<int> IdGradoRevestimiento { get; set; }
        public Nullable<int> IdBiselado { get; set; }
        public Nullable<int> IdCalidadClad { get; set; }
        public Nullable<int> IdTipoRosca { get; set; }
        public Nullable<int> IdDensidad { get; set; }
        public Nullable<int> Rpm { get; set; }
        public Nullable<decimal> Datos1 { get; set; }
        public Nullable<decimal> Datos2 { get; set; }
        public Nullable<decimal> Datos3 { get; set; }
        public Nullable<decimal> Datos4 { get; set; }
        public Nullable<decimal> Datos5 { get; set; }
        public Nullable<decimal> Datos6 { get; set; }
        public Nullable<decimal> Datos7 { get; set; }
        public Nullable<decimal> Datos8 { get; set; }
        public Nullable<decimal> Datos9 { get; set; }
        public Nullable<decimal> Datos10 { get; set; }
        public Nullable<int> Unidad16 { get; set; }
        public Nullable<int> Unidad17 { get; set; }
        public Nullable<int> Unidad18 { get; set; }
        public Nullable<int> Unidad19 { get; set; }
        public Nullable<int> Unidad20 { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public string Codigo { get; set; }
        public string RegistrarStock { get; set; }
        public Nullable<decimal> StockMinimo { get; set; }
        public string DefineKit { get; set; }
        public Nullable<decimal> CostoPPP { get; set; }
        public Nullable<decimal> AlicuotaIVA { get; set; }
        public Nullable<decimal> CostoPPPDolar { get; set; }
        public Nullable<int> IdUbicacionStandar { get; set; }
        public Nullable<decimal> CostoReposicion { get; set; }
        public Nullable<decimal> CostoReposicionDolar { get; set; }
        public string Direccion { get; set; }
        public Nullable<int> IdLocalidad { get; set; }
        public Nullable<int> IdProvincia { get; set; }
        public Nullable<int> IdPais { get; set; }
        public string CodigoPostal { get; set; }
        public string NumeroManzana { get; set; }
        public Nullable<int> NumeroLote { get; set; }
        public string ActivoFijo { get; set; }
        public string EstadoActivoFijo { get; set; }
        public Nullable<int> NumeroActivoFijo { get; set; }
        public Nullable<int> IdGrupoActivoFijo { get; set; }
        public string BienImpositivo { get; set; }
        public string BienContable { get; set; }
        public string Amortiza { get; set; }
        public Nullable<System.DateTime> FechaCompra { get; set; }
        public Nullable<int> IdCuentaAmortizacion { get; set; }
        public Nullable<int> VidaUtilImpositiva { get; set; }
        public Nullable<int> VidaUtilContable { get; set; }
        public Nullable<decimal> ValorOrigenContable { get; set; }
        public Nullable<decimal> ValorOrigenImpositivo { get; set; }
        public Nullable<decimal> ValorActualizado { get; set; }
        public Nullable<decimal> ValorResidual { get; set; }
        public Nullable<decimal> ValorResidualActualizado { get; set; }
        public Nullable<decimal> AmortizacionEjercicio { get; set; }
        public Nullable<decimal> AmortizacionEjercicioActualizada { get; set; }
        public Nullable<decimal> AmortizacionesAcumuladas { get; set; }
        public Nullable<decimal> AmortizacionesAcumuladasActualizada { get; set; }
        public Nullable<int> VidaUtilImpositivaRestante { get; set; }
        public Nullable<int> VidaUtilContableRestante { get; set; }
        public Nullable<System.DateTime> FechaPrimeraAmortizacionImpositiva { get; set; }
        public Nullable<System.DateTime> FechaPrimeraAmortizacionContable { get; set; }
        public Nullable<int> IdUbicacionActivoFijo { get; set; }
        public Nullable<int> IdSector { get; set; }
        public Nullable<System.DateTime> FechaBajaAmortizacion { get; set; }
        public string ParaMantenimiento { get; set; }
        public Nullable<int> IdUnidadLecturaMantenimiento { get; set; }
        public Nullable<decimal> LecturaAcumulada { get; set; }
        public Nullable<decimal> LecturaBase { get; set; }
        public Nullable<decimal> UltimaLectura { get; set; }
        public Nullable<System.DateTime> FechaUltimaLectura { get; set; }
        public Nullable<decimal> EstimadoAnual { get; set; }
        public string NumeroInventario { get; set; }
        public string ModeloMotor { get; set; }
        public string EquipoEnObra { get; set; }
        public string EstadoEquipo { get; set; }
        public string EsConsumible { get; set; }
        public Nullable<System.DateTime> FechaUltimaModificacionArticulo { get; set; }
        public string EntidadOrigen { get; set; }
        public string ComprobanteCompra { get; set; }
        public string ModeloEspecifico { get; set; }
        public string NumeroPatente { get; set; }
        public string NumeroMotor { get; set; }
        public string NumeroChasis { get; set; }
        public Nullable<int> AñoFabricacion { get; set; }
        public Nullable<int> AñosAmortizacion { get; set; }
        public Nullable<int> AñoAlta { get; set; }
        public string Caracteristicas { get; set; }
        public string NumeroGarantia { get; set; }
        public Nullable<System.DateTime> FechaCaducidadGarantia { get; set; }
        public string TipoCoberturaSeguro { get; set; }
        public Nullable<decimal> NumeroPolizaSeguro { get; set; }
        public string CompañiaSeguro { get; set; }
        public Nullable<System.DateTime> FechaVigenciaSeguro { get; set; }
        public Nullable<System.DateTime> FechaVencimientoVerificacionTecnica { get; set; }
        public string CalculaAmortizacion { get; set; }
        public Nullable<decimal> UltimoRevaluoContable { get; set; }
        public Nullable<System.DateTime> FechaUltimoRevaluo { get; set; }
        public string CodigoLoteo { get; set; }
        public string Adrema { get; set; }
        public string Observaciones { get; set; }
        public Nullable<decimal> ConsumoStandarCombustible { get; set; }
        public string UbicacionActivoFijo { get; set; }
        public string CalculaValorActualizado { get; set; }
        public string ParaPRONTO_MANTENIMIENTO { get; set; }
        public string PosicionAduana { get; set; }
        public string Alquilado { get; set; }
        public Nullable<int> IdMarcaMotor { get; set; }
        public string NumeroSerieMotor { get; set; }
        public Nullable<int> VidaUtilTecnica { get; set; }
        public Nullable<decimal> ValorCompra { get; set; }
        public Nullable<int> IdMonedaCompra { get; set; }
        public Nullable<System.DateTime> FechaBaja { get; set; }
        public string DocumentoAlta { get; set; }
        public string DocumentoBaja { get; set; }
        public Nullable<int> IdArticuloAsociado { get; set; }
        public Nullable<decimal> RegistroUnicoTransporteAutomotor { get; set; }
        public string TieneGPS { get; set; }
        public string CondicionActual { get; set; }
        public string SituacionActual { get; set; }
        public string Activo { get; set; }
        public Nullable<int> Auxiliar1 { get; set; }
        public Nullable<int> Auxiliar2 { get; set; }
        public Nullable<int> Auxiliar3 { get; set; }
        public Nullable<int> Auxiliar4 { get; set; }
        public Nullable<int> Auxiliar5 { get; set; }
        public Nullable<int> Auxiliar6 { get; set; }
        public Nullable<int> Auxiliar7 { get; set; }
        public Nullable<int> Auxiliar8 { get; set; }
        public Nullable<int> Auxiliar9 { get; set; }
        public Nullable<int> Auxiliar10 { get; set; }
        public Nullable<int> Auxiliar11 { get; set; }
        public Nullable<int> Auxiliar12 { get; set; }
        public Nullable<int> Auxiliar13 { get; set; }
        public Nullable<int> Auxiliar14 { get; set; }
        public Nullable<int> Auxiliar15 { get; set; }
        public Nullable<int> Auxiliar16 { get; set; }
        public Nullable<int> Auxiliar17 { get; set; }
        public Nullable<int> Auxiliar18 { get; set; }
        public Nullable<int> Auxiliar19 { get; set; }
        public Nullable<int> Auxiliar20 { get; set; }
        public Nullable<int> Auxiliar21 { get; set; }
        public Nullable<int> Auxiliar22 { get; set; }
        public Nullable<int> Auxiliar23 { get; set; }
        public Nullable<int> Auxiliar24 { get; set; }
        public Nullable<int> Auxiliar25 { get; set; }
        public string AuxiliarString1 { get; set; }
        public string AuxiliarString2 { get; set; }
        public string AuxiliarString3 { get; set; }
        public string AuxiliarString4 { get; set; }
        public string AuxiliarString5 { get; set; }
        public string AuxiliarString6 { get; set; }
        public string AuxiliarString7 { get; set; }
        public string AuxiliarString8 { get; set; }
        public string AuxiliarString9 { get; set; }
        public string AuxiliarString10 { get; set; }
        public string CodigoAlternativo { get; set; }
        public Nullable<int> IdCuentaCompras { get; set; }
        public Nullable<decimal> StockReposicion { get; set; }
        public string MarcaStock { get; set; }
        public Nullable<decimal> CostoInicial { get; set; }
        public string ConsumirPorOT { get; set; }
        public Nullable<int> IdTransportista { get; set; }
        public Nullable<int> IdTipoEquipo { get; set; }
        public string Replica { get; set; }
        public Nullable<int> IdPresupuestoObraRubro { get; set; }
        public Nullable<int> IdTipoArticulo { get; set; }
        public Nullable<System.DateTime> FechaUltimoCostoReposicion { get; set; }
        public string ADistribuirEnPresupuestoDeObra { get; set; }
        public Nullable<int> IdCurvaTalle { get; set; }
        public string Curva { get; set; }
        public string GenerarConsumosAutomaticamente { get; set; }
        public string TalleCambioPrecio { get; set; }
        public string TalleCambioPrecio2 { get; set; }
    
        public virtual Unidad Unidad { get; set; }
        public virtual ICollection<DetalleRequerimiento> DetalleRequerimientos { get; set; }
        public virtual Cuenta Cuenta { get; set; }
        public virtual Cuenta Cuenta1 { get; set; }
        public virtual Cuenta Cuenta2 { get; set; }
        public virtual ICollection<DetallePedido> DetallePedidos { get; set; }
        public virtual ICollection<DetallePresupuesto> DetallePresupuestos { get; set; }
        public virtual ICollection<DetalleFactura> DetalleFacturas { get; set; }
        public virtual Rubro Rubro { get; set; }
        public virtual ICollection<DetalleOrdenesCompra> DetalleOrdenesCompras { get; set; }
        public virtual ICollection<DetalleRemito> DetalleRemitos { get; set; }
        public virtual Ubicacion Ubicacione { get; set; }
        public virtual ICollection<DetalleArticulosDocumento> DetalleArticulosDocumentos { get; set; }
        public virtual ICollection<DetalleArticulosImagene> DetalleArticulosImagenes { get; set; }
        public virtual ICollection<DetalleArticulosUnidade> DetalleArticulosUnidades { get; set; }
        public virtual ICollection<DetalleComparativa> DetalleComparativas { get; set; }
        public virtual Subrubro Subrubro { get; set; }
        public virtual ICollection<ListasPreciosDetalle> ListasPreciosDetalles { get; set; }
        public virtual ICollection<DetalleRecepcione> DetalleRecepciones { get; set; }
    }
}
