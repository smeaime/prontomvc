using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using DataAnnotationsExtensions;
using System.Web.Mvc;

namespace ProntoMVC.Areas.MvcMembership.Models.UserAdministration
{
    public class CreateUserViewModel
    {
        public CreateUserViewModel() { Email = "administrador" + (new System.Random()).Next(1, 1000).ToString() + "@pronto.com"; PasswordQuestion = "Pregunta"; PasswordAnswer = "Respuesta"; }



        [Display(Name = "Usuario")]
        [Required]
        public string Username { get; set; }

        [Required, DataType(DataType.Password)]
        public string Password { get; set; }

        [Display(Name = "Confirmar Password")]
        [Required, DataType(DataType.Password)]
        public string ConfirmPassword { get; set; }

        [Display(Name = "Email")]
        [Required, Email]
        public string Email { get; set; }

        [Display(Name = "Pregunta secreta")]
        public string PasswordQuestion { get; set; }

        [StringLength(100)]
        [Display(Name = "Respuesta")]
        public string PasswordAnswer { get; set; }

        [Display(Name = "Roles iniciales")]
        public IDictionary<string, bool> InitialRoles { get; set; }



        //[HiddenInput(DisplayValue = false)]
        public string EmpresaDefault { get; set; }

        //[HiddenInput(DisplayValue = false)]
        public string EmpresaNueva { get; set; }
     
    }
}
