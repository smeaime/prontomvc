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
    
    public partial class TarjetasCredito
    {
        public int IdTarjetaCredito { get; set; }
        public string Nombre { get; set; }
        public Nullable<int> IdCuenta { get; set; }
        public Nullable<int> IdMoneda { get; set; }
        public string TipoTarjeta { get; set; }
        public Nullable<int> DiseñoRegistro { get; set; }
        public string NumeroEstablecimiento { get; set; }
        public string CodigoServicio { get; set; }
        public string NumeroServicio { get; set; }
        public Nullable<int> Codigo { get; set; }
        public Nullable<int> IdBanco { get; set; }
        public string Pesquisa { get; set; }
    }
}
