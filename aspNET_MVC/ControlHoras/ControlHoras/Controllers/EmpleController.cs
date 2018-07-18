using ControlHoras.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ControlHoras.Infraestructuras.Filtros;

namespace ControlHoras.Controllers
{
    [UserAuthenticationFilter]
    public class EmpleController : Controller
    {
        public ActionResult MisProyectos()
        {
            Usuario usu = (Usuario)Session["Usuario"];
            AccesoBD miBD = new AccesoBD();
            List<Proyecto> proyectos = miBD.DevolverProyectosUsuario(usu.Nombre);
            ViewBag.ListaProyectos = proyectos;
            return View();
        }

        public ActionResult MisTareas(string id)
        {
            Usuario usu = (Usuario)Session["Usuario"];
            AccesoBD miBD = new AccesoBD();
            List<Tarea> tareas = miBD.DevolverTareasUsuario(usu.Nombre, id);
            ViewBag.ListaTareas = tareas;
            return View();
        }

        public ActionResult MisHoras(int mes, string tarea, string proyecto, string empleado)
        {
            AccesoBD miBD = new AccesoBD();
            Horas horas = miBD.DevolverHoras(empleado, proyecto, tarea, mes);
            horas = miBD.DevolverHoras(empleado, proyecto, tarea, mes);
            ViewBag.Horas = horas;
            return View();
        }

        public ActionResult ActualizarHoras(string empleado, string proyecto, string tarea, string mes, string dia, string horas, string comentario, string observacion)
        {
            Usuario usu = (Usuario)Session["Usuario"];
            AccesoBD miBD = new AccesoBD();
            miBD.ActualizarHoras(empleado, proyecto, tarea, mes, dia, horas, comentario, observacion);
            return RedirectToAction("MisTareas", "Emple", new { id = proyecto });
        }
    }
}