using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
//using System.Web.Mvc;
using System.Web.Security;

namespace ProntoMVC.Models
{


    public class RecuperarPasswordModel
    {

        [Required]
        [Display(Name = "Nombre de usuario")]
        public string UserName { get; set; }


        [DataType(DataType.EmailAddress)]
        [Display(Name = "Dirección de correo electrónico")]
        public string Email { get; set; }


        public string PreguntaSecreta { get; set; }

        [Display(Name = "Respuesta secreta")]
        public string RespuestaSecreta { get; set; }
    }



    public class ChangePasswordModel
    {
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Contraseña actual")]
        public string OldPassword { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "El número de caracteres de {0} debe ser al menos {2}.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Nueva contraseña")]
        public string NewPassword { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirmar la nueva contraseña")]
        [Compare("NewPassword", ErrorMessage = "La nueva contraseña y la contraseña de confirmación no coinciden.")]
        public string ConfirmPassword { get; set; }
    }

    public class LogOnModel
    {
        [Required]
        [Display(Name = "Nombre de usuario")]
        public string UserName { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Contraseña")]
        public string Password { get; set; }

        [Display(Name = "Recordar mi cuenta")]
        public bool RememberMe { get; set; }
    }

    public class RegisterModel
    {
        [Required(ErrorMessage = "Falta el nombre")]
        [Display(Name = "Nombre de usuario")]
        public string UserName { get; set; }




        [Required(ErrorMessage = "Falta la dirección de correo")]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "Dirección de correo electrónico")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Falta la contraseña")]
        [StringLength(100, ErrorMessage = "El número de caracteres de {0} debe ser al menos {2}.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Contraseña")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirmar contraseña")]
        [Compare("Password", ErrorMessage = "La contraseña y la contraseña de confirmación no coinciden.")]
        public string ConfirmPassword { get; set; }




        // http://stackoverflow.com/questions/9840337/mvc-validation-for-us-phone-number-000-000-0000-or-000-000-0000
        // Grupo, usado como CUIT
        [Required]
        //[DataType(DataType.PhoneNumber)]
        [RegularExpression(@"^\(?([0-9]{2})\)?[-. ]?([0-9]{8})[-. ]?([0-9]{1})$", ErrorMessage = "CUIT inválido")]
        [Display(Name = "CUIT")]
        public string Grupo { get; set; }

    }
}
