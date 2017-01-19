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
    
    public partial class PuntosVenta
    {
        public PuntosVenta()
        {
            this.Remitos = new HashSet<Remito>();
            this.Facturas = new HashSet<Factura>();
        }
    
        public int IdPuntoVenta { get; set; }
        public string Letra { get; set; }
        public Nullable<int> PuntoVenta { get; set; }
        public Nullable<int> IdTipoComprobante { get; set; }
        public Nullable<int> ProximoNumero { get; set; }
        public string NumeroCAI_R_A { get; set; }
        public Nullable<System.DateTime> FechaCAI_R_A { get; set; }
        public string NumeroCAI_F_A { get; set; }
        public Nullable<System.DateTime> FechaCAI_F_A { get; set; }
        public string NumeroCAI_D_A { get; set; }
        public Nullable<System.DateTime> FechaCAI_D_A { get; set; }
        public string NumeroCAI_C_A { get; set; }
        public Nullable<System.DateTime> FechaCAI_C_A { get; set; }
        public string NumeroCAI_R_B { get; set; }
        public Nullable<System.DateTime> FechaCAI_R_B { get; set; }
        public string NumeroCAI_F_B { get; set; }
        public Nullable<System.DateTime> FechaCAI_F_B { get; set; }
        public string NumeroCAI_D_B { get; set; }
        public Nullable<System.DateTime> FechaCAI_D_B { get; set; }
        public string NumeroCAI_C_B { get; set; }
        public Nullable<System.DateTime> FechaCAI_C_B { get; set; }
        public string NumeroCAI_R_E { get; set; }
        public Nullable<System.DateTime> FechaCAI_R_E { get; set; }
        public string NumeroCAI_F_E { get; set; }
        public Nullable<System.DateTime> FechaCAI_F_E { get; set; }
        public string NumeroCAI_D_E { get; set; }
        public Nullable<System.DateTime> FechaCAI_D_E { get; set; }
        public string NumeroCAI_C_E { get; set; }
        public Nullable<System.DateTime> FechaCAI_C_E { get; set; }
        public Nullable<int> ProximoNumero1 { get; set; }
        public Nullable<int> ProximoNumero2 { get; set; }
        public Nullable<int> ProximoNumero3 { get; set; }
        public Nullable<int> ProximoNumero4 { get; set; }
        public Nullable<int> ProximoNumero5 { get; set; }
        public string Descripcion { get; set; }
        public string WebService { get; set; }
        public string WebServiceModoTest { get; set; }
        public string CAEManual { get; set; }
        public string Activo { get; set; }
        public string AgentePercepcionIIBB { get; set; }
        public Nullable<int> CodigoAuxiliar { get; set; }
        public Nullable<int> IdDeposito { get; set; }
    
        public virtual TiposComprobante TiposComprobante { get; set; }
        public virtual ICollection<Remito> Remitos { get; set; }
        public virtual ICollection<Factura> Facturas { get; set; }
    }
}
