//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ProntoMVC.Data.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Cliente
    {
        public Cliente()
        {
            this.Facturas = new HashSet<Factura>();
            this.DetalleClientesContactos = new HashSet<DetalleCliente>();
            this.DetalleClientesLugaresEntregas = new HashSet<DetalleClientesLugaresEntrega>();
            this.CuentasCorrientesDeudores = new HashSet<CuentasCorrientesDeudor>();
            this.OrdenesCompras = new HashSet<OrdenesCompra>();
            this.Remitos = new HashSet<Remito>();
            this.Recibos = new HashSet<Recibo>();
            this.NotasCreditoes = new HashSet<NotasCredito>();
            this.NotasDebitoes = new HashSet<NotasDebito>();
            this.DetalleClientesDirecciones = new HashSet<DetalleClientesDireccione>();
            this.DetalleClientesTelefonos = new HashSet<DetalleClientesTelefono>();
            this.CartasDePorteReglasDeFacturacions = new HashSet<CartasDePorteReglasDeFacturacion>();
            this.CartasPorteAcopios = new HashSet<CartasPorteAcopio>();
            this.FertilizantesCupos = new HashSet<FertilizantesCupos>();
            this.FertilizantesCupos1 = new HashSet<FertilizantesCupos>();
            this.FertilizantesCupos2 = new HashSet<FertilizantesCupos>();
            this.FertilizantesCupos3 = new HashSet<FertilizantesCupos>();
            this.WilliamsDestinos = new HashSet<WilliamsDestino>();
            this.WilliamsDestinos1 = new HashSet<WilliamsDestino>();
            this.CartasDePortes = new HashSet<CartasDePorte>();
            this.CartasDePortes1 = new HashSet<CartasDePorte>();
        }
    
        public int IdCliente { get; set; }
        public string RazonSocial { get; set; }
        public string Direccion { get; set; }
        public Nullable<int> IdLocalidad { get; set; }
        public string CodigoPostal { get; set; }
        public Nullable<int> IdProvincia { get; set; }
        public Nullable<int> IdPais { get; set; }
        public string Telefono { get; set; }
        public string Fax { get; set; }
        public string Email { get; set; }
        public string Cuit { get; set; }
        public Nullable<int> IdCodigoIva { get; set; }
        public Nullable<System.DateTime> FechaAlta { get; set; }
        public string Contacto { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public string DireccionEntrega { get; set; }
        public Nullable<int> IdLocalidadEntrega { get; set; }
        public Nullable<int> IdProvinciaEntrega { get; set; }
        public Nullable<int> CodigoCliente { get; set; }
        public Nullable<int> IdCuenta { get; set; }
        public Nullable<decimal> Saldo { get; set; }
        public Nullable<decimal> SaldoDocumentos { get; set; }
        public Nullable<int> Vendedor1 { get; set; }
        public Nullable<decimal> CreditoMaximo { get; set; }
        public Nullable<int> IGCondicion { get; set; }
        public Nullable<int> IdCondicionVenta { get; set; }
        public Nullable<int> IdMoneda { get; set; }
        public string IBNumeroInscripcion { get; set; }
        public Nullable<int> IBCondicion { get; set; }
        public Nullable<int> TipoCliente { get; set; }
        public string Codigo { get; set; }
        public Nullable<int> IdListaPrecios { get; set; }
        public Nullable<int> IdIBCondicionPorDefecto { get; set; }
        public string Confirmado { get; set; }
        public string CodigoPresto { get; set; }
        public string Observaciones { get; set; }
        public string Importaciones_NumeroInscripcion { get; set; }
        public string Importaciones_DenominacionInscripcion { get; set; }
        public Nullable<int> IdCuentaMonedaExt { get; set; }
        public Nullable<int> Cobrador { get; set; }
        public string Auxiliar { get; set; }
        public Nullable<int> IdIBCondicionPorDefecto2 { get; set; }
        public Nullable<int> IdIBCondicionPorDefecto3 { get; set; }
        public Nullable<int> IdEstado { get; set; }
        public string NombreFantasia { get; set; }
        public string EsAgenteRetencionIVA { get; set; }
        public Nullable<decimal> BaseMinimaParaPercepcionIVA { get; set; }
        public Nullable<decimal> PorcentajePercepcionIVA { get; set; }
        public Nullable<int> IdUsuarioIngreso { get; set; }
        public Nullable<System.DateTime> FechaIngreso { get; set; }
        public Nullable<int> IdUsuarioModifico { get; set; }
        public Nullable<System.DateTime> FechaModifico { get; set; }
        public Nullable<decimal> PorcentajeIBDirecto { get; set; }
        public Nullable<System.DateTime> FechaInicioVigenciaIBDirecto { get; set; }
        public Nullable<System.DateTime> FechaFinVigenciaIBDirecto { get; set; }
        public Nullable<int> GrupoIIBB { get; set; }
        public Nullable<int> IdBancoDebito { get; set; }
        public string CBU { get; set; }
        public Nullable<decimal> PorcentajeIBDirectoCapital { get; set; }
        public Nullable<System.DateTime> FechaInicioVigenciaIBDirectoCapital { get; set; }
        public Nullable<System.DateTime> FechaFinVigenciaIBDirectoCapital { get; set; }
        public Nullable<int> GrupoIIBBCapital { get; set; }
        public Nullable<int> IdBancoGestionador { get; set; }
        public string ExpresionRegularNoAgruparFacturasConEstosVendedores_1 { get; set; }
        public string ExigeDatosCompletosEnCartaDePorteQueLoUse_1 { get; set; }
        public string DireccionDeCorreos_1 { get; set; }
        public Nullable<int> IdLocalidadDeCorreos_1 { get; set; }
        public Nullable<int> IdProvinciaDeCorreos_1 { get; set; }
        public string CodigoPostalDeCorreos_1 { get; set; }
        public string ObservacionesDeCorreos_1 { get; set; }
        public string IncluyeTarifaEnFactura_1 { get; set; }
        public string SeLeFacturaCartaPorteComoTitular_1 { get; set; }
        public string SeLeFacturaCartaPorteComoIntermediario_1 { get; set; }
        public string SeLeFacturaCartaPorteComoRemcomercial_1 { get; set; }
        public string SeLeFacturaCartaPorteComoCorredor_1 { get; set; }
        public string SeLeFacturaCartaPorteComoDestinatario_1 { get; set; }
        public string SeLeFacturaCartaPorteComoDestinatarioExportador_1 { get; set; }
        public string SeLeDerivaSuFacturaAlCorredorDeLaCarta_1 { get; set; }
        public string HabilitadoParaCartaPorte_1 { get; set; }
        public string SeLeFacturaCartaPorteComoClienteAuxiliar_1 { get; set; }
        public string EsAcondicionadoraDeCartaPorte_1 { get; set; }
        public string Contactos_1 { get; set; }
        public string TelefonosFijosOficina_1 { get; set; }
        public string TelefonosCelulares_1 { get; set; }
        public string CorreosElectronicos_1 { get; set; }
        public Nullable<int> IdTarjetaCredito { get; set; }
        public string Tarjeta_NumeroTarjeta { get; set; }
        public string EsEntregador { get; set; }
        public Nullable<int> IdTransportista { get; set; }
        public Nullable<int> IdRegion { get; set; }
        public Nullable<int> IdCategoriaCredito { get; set; }
        public string RegistrarMovimientosEnCuentaCorriente { get; set; }
        public Nullable<decimal> ComisionDiferenciada { get; set; }
        public string OperacionesMercadoInternoEntidadVinculada { get; set; }
        public Nullable<int> CartaPorteTipoDeAdjuntoDeFacturacion { get; set; }
        public Nullable<System.DateTime> FechaInicioExclusionPercepcionIVA { get; set; }
        public Nullable<System.DateTime> FechaFinExclusionPercepcionIVA { get; set; }
        public Nullable<int> CodigoNormaCapital { get; set; }
        public Nullable<System.DateTime> FechaInicioVigenciaCodigoNormaCapital { get; set; }
        public Nullable<System.DateTime> FechaFinVigenciaCodigoNormaCapital { get; set; }
    
        public virtual Cuenta Cuenta { get; set; }
        public virtual IBCondicion IBCondicione { get; set; }
        public virtual Vendedor VendedorCobrador { get; set; }
        public virtual Condiciones_Compra Condiciones_Compra { get; set; }
        public virtual IBCondicion IBCondicionCat1 { get; set; }
        public virtual Cuenta CuentaMonedaExt { get; set; }
        public virtual IGCondicion IGCondicione { get; set; }
        public virtual ListasPrecio ListasPrecio { get; set; }
        public virtual Vendedor Vendedor { get; set; }
        public virtual Localidad LocalidadEntrega { get; set; }
        public virtual Localidad Localidad { get; set; }
        public virtual Moneda Moneda { get; set; }
        public virtual Pais Pais { get; set; }
        public virtual Pais Pais1 { get; set; }
        public virtual Provincia ProvinciaEntrega { get; set; }
        public virtual Provincia Provincia { get; set; }
        public virtual ICollection<Factura> Facturas { get; set; }
        public virtual IBCondicion IBCondicionCat2 { get; set; }
        public virtual IBCondicion IBCondicionCat3 { get; set; }
        public virtual ICollection<DetalleCliente> DetalleClientesContactos { get; set; }
        public virtual ICollection<DetalleClientesLugaresEntrega> DetalleClientesLugaresEntregas { get; set; }
        public virtual Estados_Proveedore Estados_Proveedores { get; set; }
        public virtual ICollection<CuentasCorrientesDeudor> CuentasCorrientesDeudores { get; set; }
        public virtual ICollection<OrdenesCompra> OrdenesCompras { get; set; }
        public virtual ICollection<Remito> Remitos { get; set; }
        public virtual ICollection<Recibo> Recibos { get; set; }
        public virtual ICollection<NotasCredito> NotasCreditoes { get; set; }
        public virtual ICollection<NotasDebito> NotasDebitoes { get; set; }
        public virtual DescripcionIva DescripcionIva { get; set; }
        public virtual Empleado Empleado { get; set; }
        public virtual Empleado Empleado1 { get; set; }
        public virtual ICollection<DetalleClientesDireccione> DetalleClientesDirecciones { get; set; }
        public virtual ICollection<DetalleClientesTelefono> DetalleClientesTelefonos { get; set; }
        public virtual ICollection<CartasDePorteReglasDeFacturacion> CartasDePorteReglasDeFacturacions { get; set; }
        public virtual ICollection<CartasPorteAcopio> CartasPorteAcopios { get; set; }
        public virtual ICollection<FertilizantesCupos> FertilizantesCupos { get; set; }
        public virtual ICollection<FertilizantesCupos> FertilizantesCupos1 { get; set; }
        public virtual ICollection<FertilizantesCupos> FertilizantesCupos2 { get; set; }
        public virtual ICollection<FertilizantesCupos> FertilizantesCupos3 { get; set; }
        public virtual ICollection<WilliamsDestino> WilliamsDestinos { get; set; }
        public virtual ICollection<WilliamsDestino> WilliamsDestinos1 { get; set; }
        public virtual ICollection<CartasDePorte> CartasDePortes { get; set; }
        public virtual ICollection<CartasDePorte> CartasDePortes1 { get; set; }
    }
}
