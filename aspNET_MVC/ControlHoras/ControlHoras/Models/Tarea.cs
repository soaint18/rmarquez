using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace ControlHoras.Models
{
    public class Tarea : IValidatableObject
    {
        #region --------- Propiedades --------------

        public string Nombre { get; set; }

        public string Proyecto { get; set; }

        public string FechaInicio { get; set; }

        public string FechaFin { get; set; }

        public int HorasEstimadas { get; set; }

        public int HorasReales { get; set; }

        public string Tecnico { get; set; }

        public int Coste { get; set; }

        #endregion

        #region --------- Metodos --------------

        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            List<ValidationResult> erroresValidacion = new List<ValidationResult>();

            //Validamos Nombre
            if (String.IsNullOrEmpty(this.Nombre))
            {
                erroresValidacion.Add(new ValidationResult("Nombre de tarea obligatorio"));
            }

            //Validamos Fecha de Inicio
            if (!String.IsNullOrEmpty(this.FechaInicio) &&
                 !new Regex("^(0[1-9]|[12][0-9]|3[01])[/]" + "(0[1-9]|1[012])[/]((175[7-9])|(17[6-9][0-9])|(1[8-9][0-9][0-9])|" + "([2-9][0-9][0-9][0-9]))$").IsMatch(this.FechaInicio))
            {
                erroresValidacion.Add(new ValidationResult("Ingresa una fecha de inicio valida con formato: dd/mm/yyyy"));
            }

            return erroresValidacion;
        }

        public void Guardar()
        {
            AccesoBD miBD = new AccesoBD();
            miBD.GuardarTarea(this);
        }

        #endregion
    }
}