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
    
    public partial class DetalleLMateriale
    {
        public int IdDetalleLMateriales { get; set; }
        public Nullable<int> IdLMateriales { get; set; }
        public Nullable<int> NumeroItem { get; set; }
        public Nullable<int> NumeroOrden { get; set; }
        public string Revision { get; set; }
        public Nullable<decimal> Cantidad { get; set; }
        public Nullable<int> IdUnidad { get; set; }
        public Nullable<int> IdArticulo { get; set; }
        public Nullable<decimal> Peso { get; set; }
        public Nullable<int> IdUnidadPeso { get; set; }
        public Nullable<int> IdControlCalidad { get; set; }
        public Nullable<decimal> Cantidad1 { get; set; }
        public Nullable<decimal> Cantidad2 { get; set; }
        public string Detalle { get; set; }
        public Nullable<int> IdPlano { get; set; }
        public Nullable<int> IdDetalleAcopios { get; set; }
        public string Adjunto { get; set; }
        public string ArchivoAdjunto { get; set; }
        public string Observaciones { get; set; }
        public string Despacha { get; set; }
        public string ArchivoAdjunto1 { get; set; }
        public string ArchivoAdjunto2 { get; set; }
        public string ArchivoAdjunto3 { get; set; }
        public string ArchivoAdjunto4 { get; set; }
        public string ArchivoAdjunto5 { get; set; }
        public string ArchivoAdjunto6 { get; set; }
        public string ArchivoAdjunto7 { get; set; }
        public string ArchivoAdjunto8 { get; set; }
        public string ArchivoAdjunto9 { get; set; }
        public string ArchivoAdjunto10 { get; set; }
        public string DescripcionManual { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public Nullable<int> IdLMaterialesOriginal { get; set; }
        public Nullable<int> IdDetalleLMaterialesOriginal { get; set; }
        public Nullable<int> IdOrigenTransmision { get; set; }
        public Nullable<int> IdDetalleObraDestino { get; set; }
    }
}
