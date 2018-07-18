using ControlHoras.Models;
using System;
using System.Collections.Generic;
using Rotativa;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Runtime.InteropServices;
using ControlHoras.Infraestructuras.Filtros;

namespace ControlHoras.Controllers
{
    [UserAuthenticationFilter]
    public class ListaController : Controller
    {
        public ActionResult Listar()
        {
            AccesoBD miBD = new AccesoBD();
            List<Proyecto> proyectos = miBD.DevolverProyectos();
            List<SelectListItem> proyec = new List<SelectListItem>();
            foreach (Proyecto proy in proyectos)
            {
                proyec.Add(new SelectListItem() { Text = proy.Nombre, Value = proy.Nombre });
            }
            ViewBag.ListProyec = proyec;
            return View();
        }

        public ActionResult MostrarLista(string proyecto, string criterio, string cadena)
        {
            AccesoBD miBD = new AccesoBD();
            List<Tarea> tareas = miBD.DevolverTareasLista(proyecto, criterio, cadena);
            ViewBag.ListaTareas = tareas;
            Session["proyecto"] = proyecto;
            Session["criterio"] = criterio;
            Session["cadena"] = cadena;
            return View();
        }

        public ActionResult ExportarPDF()
        {
            return new ActionAsPdf("MostrarLista", new { @proyecto= Session["proyecto"], @criterio= Session["criterio"], @cadena = Session["cadena"] })
            {
                FileName = "ListadoTareas.pdf",
            };
        }

        public ActionResult ExportarExcel()
        {
            Microsoft.Office.Interop.Excel.Application application = new Microsoft.Office.Interop.Excel.Application();
            Microsoft.Office.Interop.Excel.Workbook workbook = application.Workbooks.Add(System.Reflection.Missing.Value);
            Microsoft.Office.Interop.Excel.Worksheet worksheet = workbook.ActiveSheet;

            worksheet.Cells[1, 1] = "Tecnico";
            worksheet.Cells[1, 2] = "Fecha Inicio";
            worksheet.Cells[1, 3] = "Fecha Fin";
            worksheet.Cells[1, 4] = "Tarea";
            worksheet.Cells[1, 5] = "Horas Totales";
            AccesoBD miBD = new AccesoBD();
            List<Tarea> ListaTareas = miBD.DevolverTareasLista((string)Session["proyecto"], (string)Session["criterio"], (string)Session["cadena"]);
            int fila = 2;
            foreach (Tarea tarea in ListaTareas )
            {
                worksheet.Cells[fila, 1] = tarea.Tecnico;
                worksheet.Cells[fila, 2] = tarea.FechaInicio;
                worksheet.Cells[fila, 3] = tarea.FechaFin;
                worksheet.Cells[fila, 4] = tarea.Nombre;
                worksheet.Cells[fila, 5] = tarea.HorasReales;
            }
            workbook.SaveAs(ControllerContext.HttpContext.Server.MapPath("~/Exportados/example.xls"));
            workbook.Close();
            Marshal.ReleaseComObject(workbook);
            application.Quit();
            Marshal.FinalReleaseComObject(application);

            return RedirectToAction("Tareas", "Jefe", new { @proyecto = Session["proyecto"], @criterio = Session["criterio"], @cadena = Session["cadena"] });
        }
    }
}