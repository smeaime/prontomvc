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
    
    public partial class CartasDePorte
    {
        public CartasDePorte()
        {
            this.CartasDePorteLogDeOCRs = new HashSet<CartasDePorteLogDeOCR>();
            this.CartasDePorteDetalles = new HashSet<CartasDePorteDetalle_EF>();
        }
    
        public int IdCartaDePorte { get; set; }
        public Nullable<long> NumeroCartaDePorte { get; set; }
        public Nullable<int> IdUsuarioIngreso { get; set; }
        public Nullable<System.DateTime> FechaIngreso { get; set; }
        public string Anulada { get; set; }
        public Nullable<int> IdUsuarioAnulo { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public string Observaciones { get; set; }
        public byte[] FechaTimeStamp { get; set; }
        public Nullable<int> Vendedor { get; set; }
        public Nullable<int> CuentaOrden1 { get; set; }
        public Nullable<int> CuentaOrden2 { get; set; }
        public Nullable<int> Corredor { get; set; }
        public Nullable<int> Entregador { get; set; }
        public string Procedencia { get; set; }
        public string Patente { get; set; }
        public Nullable<int> IdArticulo { get; set; }
        public Nullable<int> IdStock { get; set; }
        public string Partida { get; set; }
        public Nullable<int> IdUnidad { get; set; }
        public Nullable<int> IdUbicacion { get; set; }
        public Nullable<decimal> Cantidad { get; set; }
        public string Cupo { get; set; }
        public Nullable<decimal> NetoProc { get; set; }
        public string Calidad { get; set; }
        public Nullable<decimal> BrutoPto { get; set; }
        public Nullable<decimal> TaraPto { get; set; }
        public Nullable<decimal> NetoPto { get; set; }
        public string Acoplado { get; set; }
        public Nullable<decimal> Humedad { get; set; }
        public Nullable<decimal> Merma { get; set; }
        public Nullable<decimal> NetoFinal { get; set; }
        public Nullable<System.DateTime> FechaDeCarga { get; set; }
        public Nullable<System.DateTime> FechaVencimiento { get; set; }
        public string CEE { get; set; }
        public Nullable<int> IdTransportista { get; set; }
        public string TransportistaCUITdesnormalizado { get; set; }
        public Nullable<int> IdChofer { get; set; }
        public string ChoferCUITdesnormalizado { get; set; }
        public Nullable<int> CTG { get; set; }
        public string Contrato { get; set; }
        public Nullable<int> Destino { get; set; }
        public Nullable<int> Subcontr1 { get; set; }
        public Nullable<int> Subcontr2 { get; set; }
        public Nullable<int> Contrato1 { get; set; }
        public Nullable<int> contrato2 { get; set; }
        public Nullable<decimal> KmARecorrer { get; set; }
        public Nullable<decimal> Tarifa { get; set; }
        public Nullable<System.DateTime> FechaDescarga { get; set; }
        public Nullable<System.DateTime> Hora { get; set; }
        public Nullable<int> NRecibo { get; set; }
        public Nullable<int> CalidadDe { get; set; }
        public Nullable<decimal> TaraFinal { get; set; }
        public Nullable<decimal> BrutoFinal { get; set; }
        public Nullable<decimal> Fumigada { get; set; }
        public Nullable<decimal> Secada { get; set; }
        public string Exporta { get; set; }
        public Nullable<decimal> NobleExtranos { get; set; }
        public Nullable<decimal> NobleNegros { get; set; }
        public Nullable<decimal> NobleQuebrados { get; set; }
        public Nullable<decimal> NobleDaniados { get; set; }
        public Nullable<decimal> NobleChamico { get; set; }
        public Nullable<decimal> NobleChamico2 { get; set; }
        public Nullable<decimal> NobleRevolcado { get; set; }
        public Nullable<decimal> NobleObjetables { get; set; }
        public Nullable<decimal> NobleAmohosados { get; set; }
        public Nullable<decimal> NobleHectolitrico { get; set; }
        public Nullable<decimal> NobleCarbon { get; set; }
        public Nullable<decimal> NoblePanzaBlanca { get; set; }
        public Nullable<decimal> NoblePicados { get; set; }
        public Nullable<decimal> NobleMGrasa { get; set; }
        public Nullable<decimal> NobleAcidezGrasa { get; set; }
        public Nullable<decimal> NobleVerdes { get; set; }
        public Nullable<int> NobleGrado { get; set; }
        public string NobleConforme { get; set; }
        public string NobleACamara { get; set; }
        public string Cosecha { get; set; }
        public Nullable<decimal> HumedadDesnormalizada { get; set; }
        public Nullable<decimal> Factor { get; set; }
        public Nullable<int> IdFacturaImputada { get; set; }
        public Nullable<int> PuntoVenta { get; set; }
        public Nullable<int> SubnumeroVagon { get; set; }
        public Nullable<decimal> TarifaFacturada { get; set; }
        public Nullable<decimal> TarifaSubcontratista1 { get; set; }
        public Nullable<decimal> TarifaSubcontratista2 { get; set; }
        public Nullable<System.DateTime> FechaArribo { get; set; }
        public Nullable<int> Version { get; set; }
        public string MotivoAnulacion { get; set; }
        public Nullable<int> NumeroSubfijo { get; set; }
        public Nullable<int> IdEstablecimiento { get; set; }
        public string EnumSyngentaDivision { get; set; }
        public Nullable<int> Corredor2 { get; set; }
        public Nullable<int> IdUsuarioModifico { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<System.DateTime> FechaEmision { get; set; }
        public string EstaArchivada { get; set; }
        public string ExcluirDeSubcontratistas { get; set; }
        public Nullable<int> IdTipoMovimiento { get; set; }
        public Nullable<int> IdClienteAFacturarle { get; set; }
        public Nullable<int> SubnumeroDeFacturacion { get; set; }
        public string AgregaItemDeGastosAdministrativos { get; set; }
        public Nullable<decimal> CalidadGranosQuemados { get; set; }
        public string CalidadGranosQuemadosBonifica_o_Rebaja { get; set; }
        public Nullable<decimal> CalidadTierra { get; set; }
        public string CalidadTierraBonifica_o_Rebaja { get; set; }
        public Nullable<decimal> CalidadMermaChamico { get; set; }
        public string CalidadMermaChamicoBonifica_o_Rebaja { get; set; }
        public Nullable<decimal> CalidadMermaZarandeo { get; set; }
        public string CalidadMermaZarandeoBonifica_o_Rebaja { get; set; }
        public string FueraDeEstandar { get; set; }
        public Nullable<decimal> CalidadPuntaSombreada { get; set; }
        public string CobraAcarreo { get; set; }
        public string LiquidaViaje { get; set; }
        public Nullable<int> IdClienteAuxiliar { get; set; }
        public Nullable<decimal> CalidadDescuentoFinal { get; set; }
        public string PathImagen { get; set; }
        public string PathImagen2 { get; set; }
        public Nullable<int> AgrupadorDeTandaPeriodos { get; set; }
        public string ClaveEncriptada { get; set; }
        public string NumeroCartaEnTextoParaBusqueda { get; set; }
        public Nullable<int> IdClienteEntregador { get; set; }
        public Nullable<int> IdDetalleFactura { get; set; }
        public string SojaSustentableCodCondicion { get; set; }
        public string SojaSustentableCondicion { get; set; }
        public string SojaSustentableNroEstablecimientoDeProduccion { get; set; }
        public Nullable<int> IdClientePagadorFlete { get; set; }
        public Nullable<int> IdCorredor2 { get; set; }
        public Nullable<int> Acopio1 { get; set; }
        public Nullable<int> Acopio2 { get; set; }
        public Nullable<int> Acopio3 { get; set; }
        public Nullable<int> Acopio4 { get; set; }
        public Nullable<int> Acopio5 { get; set; }
        public string SubnumeroVagonEnTextoParaBusqueda { get; set; }
        public Nullable<int> AcopioFacturarleA { get; set; }
        public Nullable<decimal> CalidadGranosDanadosRebaja { get; set; }
        public Nullable<decimal> CalidadGranosExtranosRebaja { get; set; }
        public Nullable<decimal> CalidadGranosExtranosMerma { get; set; }
        public Nullable<decimal> CalidadQuebradosMerma { get; set; }
        public Nullable<decimal> CalidadDanadosMerma { get; set; }
        public Nullable<decimal> CalidadChamicoMerma { get; set; }
        public Nullable<decimal> CalidadRevolcadosMerma { get; set; }
        public Nullable<decimal> CalidadObjetablesMerma { get; set; }
        public Nullable<decimal> CalidadAmohosadosMerma { get; set; }
        public Nullable<decimal> CalidadPuntaSombreadaMerma { get; set; }
        public Nullable<decimal> CalidadHectolitricoMerma { get; set; }
        public Nullable<decimal> CalidadCarbonMerma { get; set; }
        public Nullable<decimal> CalidadPanzaBlancaMerma { get; set; }
        public Nullable<decimal> CalidadPicadosMerma { get; set; }
        public Nullable<decimal> CalidadVerdesMerma { get; set; }
        public Nullable<decimal> CalidadQuemadosMerma { get; set; }
        public Nullable<decimal> CalidadTierraMerma { get; set; }
        public Nullable<decimal> CalidadZarandeoMerma { get; set; }
        public Nullable<decimal> CalidadDescuentoFinalMerma { get; set; }
        public Nullable<decimal> CalidadHumedadMerma { get; set; }
        public Nullable<decimal> CalidadGastosFumigacionMerma { get; set; }
        public Nullable<decimal> CalidadQuebradosRebaja { get; set; }
        public Nullable<decimal> CalidadChamicoRebaja { get; set; }
        public Nullable<decimal> CalidadRevolcadosRebaja { get; set; }
        public Nullable<decimal> CalidadObjetablesRebaja { get; set; }
        public Nullable<decimal> CalidadAmohosadosRebaja { get; set; }
        public Nullable<decimal> CalidadPuntaSombreadaRebaja { get; set; }
        public Nullable<decimal> CalidadHectolitricoRebaja { get; set; }
        public Nullable<decimal> CalidadCarbonRebaja { get; set; }
        public Nullable<decimal> CalidadPanzaBlancaRebaja { get; set; }
        public Nullable<decimal> CalidadPicadosRebaja { get; set; }
        public Nullable<decimal> CalidadVerdesRebaja { get; set; }
        public Nullable<decimal> CalidadQuemadosRebaja { get; set; }
        public Nullable<decimal> CalidadTierraRebaja { get; set; }
        public Nullable<decimal> CalidadZarandeoRebaja { get; set; }
        public Nullable<decimal> CalidadDescuentoFinalRebaja { get; set; }
        public Nullable<decimal> CalidadHumedadRebaja { get; set; }
        public Nullable<decimal> CalidadGastosFumigacionRebaja { get; set; }
        public Nullable<decimal> CalidadHumedadResultado { get; set; }
        public Nullable<decimal> CalidadGastosFumigacionResultado { get; set; }
        public Nullable<int> Acopio6 { get; set; }
        public Nullable<int> ConDuplicados { get; set; }
        public string TieneRecibidorOficial { get; set; }
        public Nullable<int> EstadoRecibidor { get; set; }
        public Nullable<int> ClienteAcondicionador { get; set; }
        public Nullable<int> MotivoRechazo { get; set; }
        public bool FacturarA_Manual { get; set; }
        public string EntregaSAP { get; set; }
        public Nullable<int> Situacion { get; set; }
        public Nullable<int> SituacionAntesDeEditarManualmente { get; set; }
        public Nullable<System.DateTime> FechaActualizacionAutomatica { get; set; }
        public Nullable<System.DateTime> FechaAutorizacion { get; set; }
        public string ObservacionesSituacion { get; set; }
    
        public virtual CartasPorteAcopio CartasPorteAcopio { get; set; }
        public virtual Cliente Cliente { get; set; }
        public virtual ICollection<CartasDePorteLogDeOCR> CartasDePorteLogDeOCRs { get; set; }
        public virtual ICollection<CartasDePorteDetalle_EF> CartasDePorteDetalles { get; set; }
        public virtual Vendedor Vendedore { get; set; }
        public virtual DetalleFactura DetalleFactura { get; set; }
    }
}
