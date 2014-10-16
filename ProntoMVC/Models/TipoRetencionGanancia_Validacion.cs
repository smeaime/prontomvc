﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Web.Mvc;
using System.Web.Security;


using System.Linq;

// Para poder usar atributos sin que me los destroce la generación automática


// http://weblogs.asp.net/scottgu/archive/2010/01/15/asp-net-mvc-2-model-validation.aspx
//One way you can apply additional attribute-based meta-data (like validation attributes) to a class that is 
// auto-generated/maintained by a VS designer is to employ a technique we call “buddy classes”.  
// Basically you create a separate class that contains your validation attributes and meta-data, 
// and then link it to the class generated by the designer by applying a “MetadataType” attribute to 
// a partial class that is compiled with the tool-generated class.  For example, if we wanted to apply 
// the validation rules we used earlier to a Person class maintained by a LINQ to SQL or ADO.NET EF designer we could update our validation code to instead live in a separate “Person_Validation” class that is linked to the “Person” class created by VS using the code below:


namespace ClassLibrary2
{



    [MetadataType(typeof(TipoRetencionGanancia_Validacion))]
    public partial class TipoRetencionGanancia // : IValidatableObject
    {

    }

    // http://stackoverflow.com/a/6337741/1054200
    //        //+1 I was having same problem and this helped find the solution. 
    //          Turns out I had [Bind(Exclude = "OrderID")] in my Order model which was causing the value of
    //         the entity's ID to be zero on HttpPost. – David HAust Jan 23 '12 at 2:07
    //        //That's exactly what I was missing. My object's ID was 0. – Azhar Khorasany Aug 16 '12 at 21:18
    //        //@Html.HiddenFor(model => model.productID) -- worked perfect. 
    //   I was missing the productID on the EDIT PAGE (MVC RAZOR) – David K Egghead Aug 28 '12 at 5:02

    //http://stackoverflow.com/questions/2142990/asp-mvc-the-id-field-is-required-validation-message-on-create-id-not-set-to


    //[Bind(Exclude = "IdConcepto")]  // -Ojito! perdés el ID en el HttpPost! TO DO: lo tuve que comentar... qué consecuencias tiene???
    public class TipoRetencionGanancia_Validacion // : IValidatableObject
    {
        [Required(ErrorMessage = "Debe ingresar una descripción")]
        [StringLength(50, ErrorMessage = "Debe tener menos de 50 caracteres")]
        public string Descripcion { get; set; }


        [Required(ErrorMessage = "Debe ingresar si es Bien o Servicio")]
        public string BienesOServicios { get; set; }


        
        public Nullable<int> CodigoImpuestoAFIP { get; set; }
        
        public Nullable<int> CodigoRegimenAFIP { get; set; }

        public string InformacionAuxiliar { get; set; }
        
        public Nullable<int> ProximoNumeroCertificadoRetencionGanancias { get; set; }
        

        // http://www.esenciadev.com/2011/02/model-validation-in-asp-net-mvc3-2/
        //We’re implementing the IValidatableObject interface and fulfilling the sole method in that 
        // interface, Validate(). Within the Validate() method, you can return a list of
        // ValidationResult instances, each of which has an error message and a sub-list of property names to 
        // which the error applies. In our case, we’re only checking for one error, and we’re applying it to a 
        // single property (Explanation). Note that the string value provided to the ValidationResult must match 
        // the property name. This is how MVC matches up the ValidationResult to a ModelState entry.

        //public System.Collections.Generic.IEnumerable Validate(ValidationContext validationContext)
        //{
        //    if (string.IsNullOrEmpty(Descripcion))
        //    {
        //        yield return new ValidationResult("Please explain why.", new[] { "Explanation" });
        //    }
        //}


    }



    // Custom Validation
    

    //public class PriceAttribute : ValidationAttribute
    //{
    //    public double MinPrice { get; set; }

    //    public override bool IsValid(object value)
    //    {
    //        if (value == null)
    //        {
    //            return true;
    //        }
    //        var price = (double)value;
    //        if (price < MinPrice)
    //        {
    //            return false;
    //        }
    //        double cents = price - Math.Truncate(price);
    //        if (cents < 0.99 || cents >= 0.995)
    //        {
    //            return false;
    //        }

    //        return true;
    //    }
    //}




    //public class EmailAttribute : ValidationAttribute
    //{
    //    public override bool IsValid(object value)
    //    {
    //        return true;
    //    }


    //    protected override bool IsValid(object value, ValidationContext validationContext, out ValidationResult validationResult)
    //    {
    //        return base.IsValid( value, validationContext, out validationResult);
    //    }
    //}

}