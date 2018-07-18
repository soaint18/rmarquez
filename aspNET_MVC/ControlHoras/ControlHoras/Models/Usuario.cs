using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ControlHoras.Models
{
    public class Usuario : IValidatableObject
    {
        #region --------- Propiedades --------------

        public string Nombre { get; set; }

        public string Cargo { get; set; }

        public string Password { get; set; }


        #endregion


        #region --------- Metodos --------------

        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            List<ValidationResult> erroresValidacion = new List<ValidationResult>();

            //Validamos Nombre
            if (String.IsNullOrEmpty(this.Nombre))
            {
                erroresValidacion.Add(new ValidationResult("Nombre obligatorio"));
            }

            //Validamos Cargo
            if (String.IsNullOrEmpty(this.Cargo))
            {
                erroresValidacion.Add(new ValidationResult("Cargo obligatorio"));
            }

            //Validamos Password
            if (String.IsNullOrEmpty(this.Password) || this.Password.Length < 5)
            {
                erroresValidacion.Add(new ValidationResult("Obligatorio password. Minimo 5 caracteres."));
            }


            return erroresValidacion;
        }

        public void Guardar()
        {
            AccesoBD miBD = new AccesoBD();
            miBD.GuardarUser(this);
        }

        #endregion
    }
}