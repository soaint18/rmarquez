using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace ControlHoras.Models
{
    public class Proyecto : IValidatableObject
    {

        #region --------- Propiedades --------------

        public string Nombre { get; set; }

        [Display(Name = "Tipo de Proyecto")]
        public string Tipo { get; set; }

        public string Cliente { get; set; }

        public string Responsable { get; set; }

        [Display(Name = "Fecha de Inicio")]
        public string FechaInicio { get; set; }
        
        [Display(Name = "Fecha Estimada de Cierre")]
        public string FechaCierrePrevista { get; set; }

        [Display(Name = "Nº Horas Previstas")]
        public int HorasPrevistas { get; set; }

        public string FechaCierreReal { get; set; }

        public int HorasReales { get; set; }

        public int Coste { get; set; }

        public string Observaciones { get; set; }


        public List<Tarea> ListaTareas { get; set; }


        #endregion


        #region --------- Metodos --------------

        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            List<ValidationResult> erroresValidacion = new List<ValidationResult>();

            //Validamos nombre
            if (String.IsNullOrEmpty(this.Nombre))
            {
                erroresValidacion.Add(new ValidationResult("Nombre de Proyecto obligatorio"));
            }

            //Validamos tipo
            if (String.IsNullOrEmpty(this.Tipo))
            {
                erroresValidacion.Add(new ValidationResult("Tipo de proyecto obligatorio"));
            }

            //Validamos Cliente
            if (String.IsNullOrEmpty(this.Cliente))
            {
                erroresValidacion.Add(new ValidationResult("Cliente obligatorio"));
            }

            //Validamos Fecha de Inicio
            if (!String.IsNullOrEmpty(this.FechaInicio) &&
                 !new Regex("^(0[1-9]|[12][0-9]|3[01])[/]" + "(0[1-9]|1[012])[/]((175[7-9])|(17[6-9][0-9])|(1[8-9][0-9][0-9])|" + "([2-9][0-9][0-9][0-9]))$").IsMatch(this.FechaInicio))
            {
                erroresValidacion.Add(new ValidationResult("Ingresa una fecha de inicio valida con formato: dd/mm/yyyy"));
            }

            //Validamos Fecha Estimada Cierre
            if (!String.IsNullOrEmpty(this.FechaCierrePrevista) &&
                 !new Regex("^(0[1-9]|[12][0-9]|3[01])[/]" + "(0[1-9]|1[012])[/]((175[7-9])|(17[6-9][0-9])|(1[8-9][0-9][0-9])|" + "([2-9][0-9][0-9][0-9]))$").IsMatch(this.FechaCierrePrevista))
            {
                erroresValidacion.Add(new ValidationResult("Ingresa una fecha de cierre valida con formato: dd/mm/yyyy"));
            }

            return erroresValidacion;
        }

        public void Guardar()
        {
            AccesoBD miBD = new AccesoBD();
            miBD.GuardarProyecto(this);
        }

        #endregion

    }
}