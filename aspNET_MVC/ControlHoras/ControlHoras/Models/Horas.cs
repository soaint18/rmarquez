using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ControlHoras.Models
{
    public class Horas
    {
        #region --------- Propiedades --------------

        public string Empleado { get; set; }

        public string Proyecto { get; set; }

        public string Tarea { get; set; }

        public string Mes { get; set; }

        public List<Dias> Dias { get; set; }

        public string Total { get; set; }

        #endregion

        #region --------- Metodos --------------
        public Horas()
        {
            this.Dias = new List<Dias>();
        }
        #endregion
    }
}