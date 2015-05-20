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
    
    public partial class Transportista
    {
        public int IdTransportista { get; set; }
        public string RazonSocial { get; set; }
        public string Direccion { get; set; }
        public Nullable<int> IdLocalidad { get; set; }
        public string CodigoPostal { get; set; }
        public Nullable<int> IdProvincia { get; set; }
        public Nullable<int> IdPais { get; set; }
        public string Telefono { get; set; }
        public string Fax { get; set; }
        public string Email { get; set; }
        public Nullable<byte> IdCodigoIva { get; set; }
        public string Cuit { get; set; }
        public string Contacto { get; set; }
        public string Observaciones { get; set; }
        public string Horario { get; set; }
        public string Celular { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public Nullable<int> IdProveedor { get; set; }
        public Nullable<int> Codigo { get; set; }
    
        public virtual Localidad Localidade { get; set; }
    }
}
