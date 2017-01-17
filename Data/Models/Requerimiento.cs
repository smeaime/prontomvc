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
    
    public partial class Requerimiento
    {
        public Requerimiento()
        {
            this.DetalleRequerimientos = new HashSet<DetalleRequerimiento>();
        }
    
        public int IdRequerimiento { get; set; }
        public Nullable<int> NumeroRequerimiento { get; set; }
        public Nullable<System.DateTime> FechaRequerimiento { get; set; }
        public string LugarEntrega { get; set; }
        public string Observaciones { get; set; }
        public Nullable<int> IdObra { get; set; }
        public Nullable<int> IdCentroCosto { get; set; }
        public Nullable<int> IdSolicito { get; set; }
        public Nullable<int> IdSector { get; set; }
        public Nullable<decimal> MontoPrevisto { get; set; }
        public Nullable<int> IdComprador { get; set; }
        public Nullable<int> Aprobo { get; set; }
        public Nullable<System.DateTime> FechaAprobacion { get; set; }
        public Nullable<decimal> MontoParaCompra { get; set; }
        public string Cumplido { get; set; }
        public string Consorcial { get; set; }
        public string UsuarioAnulacion { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public string MotivoAnulacion { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public Nullable<int> IdRequerimientoOriginal { get; set; }
        public Nullable<int> IdOrigenTransmision { get; set; }
        public Nullable<int> IdAutorizoCumplido { get; set; }
        public Nullable<int> IdDioPorCumplido { get; set; }
        public Nullable<System.DateTime> FechaDadoPorCumplido { get; set; }
        public string ObservacionesCumplido { get; set; }
        public Nullable<int> IdMoneda { get; set; }
        public string Detalle { get; set; }
        public string DirectoACompras { get; set; }
        public Nullable<int> IdAutorizoDirectoACompras { get; set; }
        public string PRESTOContrato { get; set; }
        public string Confirmado { get; set; }
        public Nullable<System.DateTime> FechaImportacionTransmision { get; set; }
        public Nullable<int> IdEquipoDestino { get; set; }
        public string Impresa { get; set; }
        public string Recepcionado { get; set; }
        public string Entregado { get; set; }
        public string TipoRequerimiento { get; set; }
        public Nullable<int> IdOrdenTrabajo { get; set; }
        public Nullable<int> Aprobo2 { get; set; }
        public Nullable<System.DateTime> FechaAprobacion2 { get; set; }
        public Nullable<int> IdTipoCompra { get; set; }
        public Nullable<int> IdImporto { get; set; }
        public Nullable<System.DateTime> FechaLlegadaImportacion { get; set; }
        public string CircuitoFirmasCompleto { get; set; }
        public Nullable<int> IdCuentaPresupuesto { get; set; }
        public Nullable<int> MesPresupuesto { get; set; }
        public string RequisitosSeguridad { get; set; }
        public string Adjuntos { get; set; }
        public string ConfirmadoPorWeb { get; set; }
        public string DetalleImputacion { get; set; }
        public Nullable<int> IdUsuarioDeslibero { get; set; }
        public Nullable<System.DateTime> FechaDesliberacion { get; set; }
        public Nullable<int> NumeradorDesliberaciones { get; set; }
        public Nullable<int> IdUsuarioEliminoFirmas { get; set; }
        public Nullable<System.DateTime> FechaEliminacionFirmas { get; set; }
        public Nullable<int> NumeradorEliminacionesFirmas { get; set; }
        public Nullable<int> NumeradorModificaciones { get; set; }
        public string ParaTaller { get; set; }
        public string FechasLiberacion { get; set; }
        public string Presupuestos { get; set; }
        public string Comparativas { get; set; }
        public string Pedidos { get; set; }
        public string Recepciones { get; set; }
        public string SalidasMateriales { get; set; }
        public string Detalle2 { get; set; }
    
        public virtual Obra Obra { get; set; }
        public virtual Sector Sectores { get; set; }
        public virtual ICollection<DetalleRequerimiento> DetalleRequerimientos { get; set; }
        public virtual Empleado AproboRequerimiento { get; set; }
        public virtual Empleado AutorizoCumplidoRequerimiento { get; set; }
        public virtual Empleado CompradorRequerimiento { get; set; }
        public virtual Empleado DioPorCumplidoRequerimiento { get; set; }
        public virtual Empleado SolicitoRequerimiento { get; set; }
    }
}
