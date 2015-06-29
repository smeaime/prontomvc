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
    
    public partial class SalidasMateriale
    {
        public SalidasMateriale()
        {
            this.DetalleSalidasMateriales = new HashSet<DetalleSalidasMateriale>();
        }
    
        public int IdSalidaMateriales { get; set; }
        public Nullable<int> NumeroSalidaMateriales { get; set; }
        public Nullable<System.DateTime> FechaSalidaMateriales { get; set; }
        public Nullable<int> IdObra { get; set; }
        public string Observaciones { get; set; }
        public Nullable<int> Aprobo { get; set; }
        public Nullable<int> TipoSalida { get; set; }
        public Nullable<int> IdTransportista1 { get; set; }
        public Nullable<int> IdTransportista2 { get; set; }
        public string Cliente { get; set; }
        public string Direccion { get; set; }
        public string Localidad { get; set; }
        public string CodigoPostal { get; set; }
        public string CondicionIva { get; set; }
        public string Cuit { get; set; }
        public Nullable<int> NumeroSalidaMateriales2 { get; set; }
        public string Acargo { get; set; }
        public Nullable<int> Emitio { get; set; }
        public Nullable<int> ValePreimpreso { get; set; }
        public string Referencia { get; set; }
        public string NumeroDocumento { get; set; }
        public string Patente1 { get; set; }
        public string Patente2 { get; set; }
        public string Patente3 { get; set; }
        public string Patente4 { get; set; }
        public Nullable<int> IdProveedor { get; set; }
        public string Chofer { get; set; }
        public Nullable<int> IdCentroCosto { get; set; }
        public Nullable<System.DateTime> FechaRegistracion { get; set; }
        public string Anulada { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public Nullable<int> IdUsuarioAnulo { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public Nullable<int> IdSalidaMaterialesOriginal { get; set; }
        public Nullable<int> IdOrigenTransmision { get; set; }
        public Nullable<System.DateTime> FechaImportacionTransmision { get; set; }
        public string MotivoAnulacion { get; set; }
        public Nullable<int> NumeroOrdenProduccion { get; set; }
        public Nullable<int> IdDepositoOrigen { get; set; }
        public Nullable<int> IdUsuarioIngreso { get; set; }
        public Nullable<System.DateTime> FechaIngreso { get; set; }
        public Nullable<int> IdUsuarioModifico { get; set; }
        public Nullable<System.DateTime> FechaModifico { get; set; }
        public Nullable<int> IdRecepcionSAT { get; set; }
        public string ClaveTipoSalida { get; set; }
        public string SalidaADepositoEnTransito { get; set; }
        public Nullable<decimal> ValorDeclarado { get; set; }
        public Nullable<int> Bultos { get; set; }
        public Nullable<int> IdColor { get; set; }
        public string Embalo { get; set; }
        public string CircuitoFirmasCompleto { get; set; }
        public Nullable<int> IdPuntoVenta { get; set; }
        public string NumeroRemitoTransporte { get; set; }
        public Nullable<int> IdEquipo { get; set; }
        public Nullable<int> IdSalidaMaterialesSAT { get; set; }
        public Nullable<int> IdObraOrigen { get; set; }
        public Nullable<int> NumeroRemitoPreimpreso1 { get; set; }
        public Nullable<int> NumeroRemitoPreimpreso2 { get; set; }
        public Nullable<int> IdFlete { get; set; }
        public Nullable<int> IdChofer { get; set; }
        public string DestinoDeObra { get; set; }
        public Nullable<decimal> PesoBruto { get; set; }
        public Nullable<decimal> PesoNeto { get; set; }
        public Nullable<decimal> Tara { get; set; }
        public Nullable<decimal> CantidadEnOrigen { get; set; }
        public Nullable<decimal> DistanciaRecorrida { get; set; }
        public string CodigoTarifador { get; set; }
        public Nullable<int> IdPesada { get; set; }
        public Nullable<int> IdTarifaFlete { get; set; }
        public Nullable<decimal> TarifaFlete { get; set; }
        public string Detalle { get; set; }
        public Nullable<int> IdProduccionOrden { get; set; }
        public Nullable<int> IdDepositoIntermedio { get; set; }
        public Nullable<int> NumeroPesada { get; set; }
        public Nullable<decimal> Progresiva1 { get; set; }
        public Nullable<decimal> Progresiva2 { get; set; }
        public Nullable<System.DateTime> FechaPesada { get; set; }
        public string ObservacionesPesada { get; set; }
        public Nullable<int> NumeroRemitoTransporte1 { get; set; }
        public Nullable<int> NumeroRemitoTransporte2 { get; set; }
        public string RecibidosEnDestino { get; set; }
        public Nullable<System.DateTime> RecibidosEnDestinoFecha { get; set; }
        public Nullable<int> RecibidosEnDestinoIdUsuario { get; set; }
        public Nullable<int> IdCalle1 { get; set; }
        public Nullable<int> IdCalle2 { get; set; }
        public Nullable<int> IdCalle3 { get; set; }
    
        public virtual ICollection<DetalleSalidasMateriale> DetalleSalidasMateriales { get; set; }
    }
}
