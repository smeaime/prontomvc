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
    }
}
