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
    
    public partial class FertilizantesCupos
    {
        public int IdFertilizanteCupo { get; set; }
        public Nullable<long> Numero { get; set; }
        public Nullable<int> IdUsuarioIngreso { get; set; }
        public Nullable<System.DateTime> FechaIngreso { get; set; }
        public string Anulada { get; set; }
        public Nullable<int> IdUsuarioAnulo { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public byte[] FechaTimeStamp { get; set; }
        public Nullable<System.DateTime> FechaCupo { get; set; }
        public string TipoEgresoIngreso { get; set; }
        public Nullable<int> Cliente { get; set; }
        public Nullable<int> CuentaOrden { get; set; }
        public Nullable<int> IdChofer { get; set; }
        public string Chasis { get; set; }
        public string Acoplado { get; set; }
        public Nullable<int> IdTransportista { get; set; }
        public Nullable<int> IdLocalidadTransportista { get; set; }
        public Nullable<int> Recorrido { get; set; }
        public Nullable<int> Destino { get; set; }
        public string Contrato { get; set; }
        public Nullable<int> IdArticulo { get; set; }
        public string Puro { get; set; }
        public string Mezcla { get; set; }
        public Nullable<int> IdArticuloComponente1 { get; set; }
        public Nullable<decimal> Porcentaje1 { get; set; }
        public Nullable<int> IdArticuloComponente2 { get; set; }
        public Nullable<decimal> Porcentaje2 { get; set; }
        public Nullable<int> IdArticuloComponente3 { get; set; }
        public Nullable<decimal> Porcentaje3 { get; set; }
        public Nullable<int> IdArticuloComponente4 { get; set; }
        public Nullable<decimal> Porcentaje4 { get; set; }
        public Nullable<int> IdArticuloComponente5 { get; set; }
        public Nullable<decimal> Porcentaje5 { get; set; }
        public Nullable<int> FormaDespacho { get; set; }
        public Nullable<decimal> Cantidad { get; set; }
        public string Observaciones { get; set; }
        public string PathImagen { get; set; }
        public string PathImagen2 { get; set; }
        public Nullable<int> AgrupadorDeTandaPeriodos { get; set; }
        public string ClaveEncriptada { get; set; }
        public string NumeroCartaEnTextoParaBusqueda { get; set; }
        public string SubnumeroVagonEnTextoParaBusqueda { get; set; }
        public Nullable<int> IdUsuarioModifico { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public Nullable<int> IdFacturaImputada { get; set; }
        public string NumeradorTexto { get; set; }
    
        public virtual Articulo Articulo { get; set; }
        public virtual Articulo Articulo1 { get; set; }
        public virtual Articulo Articulo2 { get; set; }
        public virtual Articulo Articulo3 { get; set; }
        public virtual Articulo Articulo4 { get; set; }
        public virtual Articulo Articulo5 { get; set; }
        public virtual Articulo Articulo6 { get; set; }
        public virtual Articulo Articulo7 { get; set; }
        public virtual Articulo Articulo8 { get; set; }
        public virtual Articulo Articulo9 { get; set; }
        public virtual Articulo Articulo10 { get; set; }
        public virtual Articulo Articulo11 { get; set; }
        public virtual Chofere Chofere { get; set; }
        public virtual Chofere Chofere1 { get; set; }
        public virtual Cliente Cliente1 { get; set; }
        public virtual Cliente Cliente2 { get; set; }
        public virtual Cliente Cliente3 { get; set; }
        public virtual Cliente Cliente4 { get; set; }
        public virtual Empleado Empleado { get; set; }
        public virtual Empleado Empleado1 { get; set; }
        public virtual Empleado Empleado2 { get; set; }
        public virtual Empleado Empleado3 { get; set; }
        public virtual Localidad Localidade { get; set; }
        public virtual Localidad Localidade1 { get; set; }
        public virtual Transportista Transportista { get; set; }
        public virtual Transportista Transportista1 { get; set; }
    }
}
