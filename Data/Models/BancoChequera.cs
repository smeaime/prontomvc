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
    
    public partial class BancoChequera
    {
        public int IdBancoChequera { get; set; }
        public Nullable<int> IdBanco { get; set; }
        public Nullable<int> IdCuentaBancaria { get; set; }
        public Nullable<int> NumeroChequera { get; set; }
        public Nullable<int> DesdeCheque { get; set; }
        public Nullable<int> HastaCheque { get; set; }
        public Nullable<System.DateTime> Fecha { get; set; }
        public Nullable<int> ProximoNumeroCheque { get; set; }
        public string Activa { get; set; }
        public string ChequeraPagoDiferido { get; set; }
    
        public virtual Banco Banco { get; set; }
    }
}
