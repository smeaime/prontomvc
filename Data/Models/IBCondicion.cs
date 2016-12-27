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
    
    public partial class IBCondicion
    {
        public IBCondicion()
        {
            this.Clientes = new HashSet<Cliente>();
            this.Clientes1 = new HashSet<Cliente>();
            this.Clientes1_1 = new HashSet<Cliente>();
            this.Clientes2 = new HashSet<Cliente>();
            this.DetalleProveedoresIBs = new HashSet<DetalleProveedoresIB>();
            this.NotasCreditoes = new HashSet<NotasCredito>();
        }
    
        public int IdIBCondicion { get; set; }
        public string Descripcion { get; set; }
        public Nullable<decimal> ImporteTopeMinimo { get; set; }
        public Nullable<decimal> Alicuota { get; set; }
        public Nullable<System.DateTime> FechaVigencia { get; set; }
        public string AcumulaMensualmente { get; set; }
        public string BaseCalculo { get; set; }
        public Nullable<decimal> AlicuotaPercepcion { get; set; }
        public Nullable<int> IdProvincia { get; set; }
        public Nullable<decimal> ImporteTopeMinimoPercepcion { get; set; }
        public Nullable<decimal> AlicuotaPercepcionConvenio { get; set; }
        public Nullable<int> IdCuentaPercepcionIIBB { get; set; }
        public Nullable<int> IdCuentaPercepcionIIBBConvenio { get; set; }
        public Nullable<decimal> PorcentajeATomarSobreBase { get; set; }
        public Nullable<decimal> PorcentajeAdicional { get; set; }
        public string LeyendaPorcentajeAdicional { get; set; }
        public Nullable<int> Codigo { get; set; }
        public Nullable<int> CodigoAFIP { get; set; }
        public string InformacionAuxiliar { get; set; }
        public Nullable<int> IdCuentaPercepcionIIBBCompras { get; set; }
        public Nullable<int> IdProvinciaReal { get; set; }
        public Nullable<int> CodigoNormaRetencion { get; set; }
        public Nullable<int> CodigoNormaPercepcion { get; set; }
        public Nullable<int> CodigoActividad { get; set; }
        public string CodigoArticuloInciso { get; set; }
        public Nullable<int> CodigoRegimen { get; set; }
    
        public virtual ICollection<Cliente> Clientes { get; set; }
        public virtual ICollection<Cliente> Clientes1 { get; set; }
        public virtual Cuenta CuentaIIBBnormal { get; set; }
        public virtual Provincia Provincia { get; set; }
        public virtual Provincia ProvinciaReal { get; set; }
        public virtual ICollection<Cliente> Clientes1_1 { get; set; }
        public virtual ICollection<Cliente> Clientes2 { get; set; }
        public virtual Cuenta CuentaIIBBcompras { get; set; }
        public virtual Cuenta CuentaIIBBconvenio { get; set; }
        public virtual ICollection<DetalleProveedoresIB> DetalleProveedoresIBs { get; set; }
        public virtual ICollection<NotasCredito> NotasCreditoes { get; set; }
    }
}
