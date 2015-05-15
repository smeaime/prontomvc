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
    
    public partial class ValesSalida
    {
        public ValesSalida()
        {
            this.DetalleValesSalidas = new HashSet<DetalleValesSalida>();
        }
    
        public int IdValeSalida { get; set; }
        public Nullable<int> NumeroValeSalida { get; set; }
        public Nullable<System.DateTime> FechaValeSalida { get; set; }
        public Nullable<int> IdObra { get; set; }
        public string Observaciones { get; set; }
        public Nullable<int> IdCentroCosto { get; set; }
        public Nullable<int> Aprobo { get; set; }
        public Nullable<int> NumeroValePreimpreso { get; set; }
        public string Cumplido { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public Nullable<int> IdValeSalidaOriginal { get; set; }
        public Nullable<int> IdOrigenTransmision { get; set; }
        public Nullable<System.DateTime> FechaImportacionTransmision { get; set; }
        public Nullable<int> IdUsuarioAnulo { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public string MotivoAnulacion { get; set; }
        public string CircuitoFirmasCompleto { get; set; }
        public Nullable<int> IdUsuarioDioPorCumplido { get; set; }
        public Nullable<System.DateTime> FechaDioPorCumplido { get; set; }
        public string MotivoDioPorCumplido { get; set; }
    
        public virtual ICollection<DetalleValesSalida> DetalleValesSalidas { get; set; }
    }
}
