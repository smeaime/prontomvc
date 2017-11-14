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
    
    public partial class VistaCartasPorteMovimiento
    {
        public int IdCDPMovimiento { get; set; }
        public Nullable<int> NumeroCDPMovimiento { get; set; }
        public Nullable<int> IdUsuarioIngreso { get; set; }
        public Nullable<System.DateTime> FechaIngreso { get; set; }
        public string Anulada { get; set; }
        public Nullable<int> IdUsuarioAnulo { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public string Observaciones { get; set; }
        public byte[] FechaTimeStamp { get; set; }
        public Nullable<int> IdAjusteStock { get; set; }
        public Nullable<int> IdCartaDePorte { get; set; }
        public Nullable<int> Entrada_o_Salida { get; set; }
        public Nullable<int> IdExportadorOrigen { get; set; }
        public Nullable<int> IdExportadorDestino { get; set; }
        public Nullable<int> Tipo { get; set; }
        public string Contrato { get; set; }
        public Nullable<int> Puerto { get; set; }
        public string Vapor { get; set; }
        public string Numero { get; set; }
        public Nullable<int> IdArticulo { get; set; }
        public Nullable<decimal> Cantidad { get; set; }
        public Nullable<int> IdStock { get; set; }
        public string Partida { get; set; }
        public Nullable<int> IdUnidad { get; set; }
        public Nullable<int> IdUbicacion { get; set; }
        public Nullable<int> IdFacturaImputada { get; set; }
        public Nullable<int> IdDetalleFactura { get; set; }
        public Nullable<decimal> NetoPto { get; set; }
        public Nullable<decimal> Humedad { get; set; }
        public string Calidad { get; set; }
        public Nullable<decimal> Merma { get; set; }
        public Nullable<decimal> NetoFinal { get; set; }
        public Nullable<int> NRecibo { get; set; }
        public string SubtotalPorRecibo { get; set; }
        public string Patente { get; set; }
        public Nullable<long> NumeroCartadePorte { get; set; }
        public string exporta { get; set; }
        public string ExportadorOrigen { get; set; }
        public string ExportadorDestino { get; set; }
        public string MovProductoDesc { get; set; }
        public string MovDestinoDesc { get; set; }
        public string Factura { get; set; }
        public Nullable<System.DateTime> fechafactura { get; set; }
        public string ClienteFacturado { get; set; }
        public Nullable<int> idcliente { get; set; }
        public Nullable<int> idfactura { get; set; }
        public Nullable<int> c1 { get; set; }
        public Nullable<int> c2 { get; set; }
        public Nullable<int> IdWilliamsDestino { get; set; }
        public Nullable<int> a { get; set; }
    }
}
