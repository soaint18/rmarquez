using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ControlHoras.Models;
using ControlHoras.Infraestructuras.Filtros;

namespace ControlHoras.Controllers
{
    [UserAuthenticationFilter(Order = 1)]
    [JefeFilter(Order = 2)]
    public class JefeController : Controller
    {
        [HttpGet]
        public ActionResult Proyectos()
        {
            AccesoBD miBD = new AccesoBD();
            List<Proyecto> proyectos = miBD.DevolverProyectos();
            ViewBag.ListaProyectos = proyectos;

            return View();
        }

        [HttpPost]
        public ActionResult Proyectos(string cadena, string criterio)
        {
            AccesoBD miBD = new AccesoBD();
            List<Proyecto> proyectos = miBD.DevolverProyectos(cadena, criterio);
            ViewBag.ListaProyectos = proyectos;
            return View();
        }

        public ActionResult Tareas(string id)
        {
            AccesoBD miBD = new AccesoBD();
            List<Tarea> tareas = miBD.DevolverTareas(id);
            ViewBag.proyecto = id;
            ViewBag.ListaTareas = tareas;

            return View();
        }

        [HttpGet]
        public ActionResult NuevoProyecto()
        {
            AccesoBD miBD = new AccesoBD();
            List<String> us = miBD.DevolverUsuarios();
            List<SelectListItem> users = new List<SelectListItem>();
            foreach (string usu in us)
            {
                users.Add(new SelectListItem() { Text = usu, Value = usu });
            }
            ViewBag.ListUser = users;
            return View();
        }

        [HttpPost]
        public ActionResult NuevoProyecto(Proyecto newProyecto, string Responsable)
        {
            if (ModelState.IsValid)
            {
                newProyecto.Responsable = Responsable;
                newProyecto.Guardar();
                return RedirectToAction("Proyectos", "Jefe");
            }
            else
            {
                AccesoBD miBD = new AccesoBD();
                List<String> us = miBD.DevolverUsuarios();
                List<SelectListItem> users = new List<SelectListItem>();
                foreach (string usu in us)
                {
                    users.Add(new SelectListItem() { Text = usu, Value = usu });
                }
                ViewBag.ListUser = users;
                return View(newProyecto);
            }
        }

        public ActionResult BorrarProyecto(string id)
        {
            AccesoBD miBD = new AccesoBD();
            miBD.BorrraProyecto(id);
            return RedirectToAction("Proyectos", "Jefe");
        }

        [HttpGet]
        public ActionResult NuevaTarea(string id)
        {
            AccesoBD miBD = new AccesoBD();
            ViewBag.proyecto = id;
            List<String> us = miBD.DevolverUsuarios();
            List<SelectListItem> users = new List<SelectListItem>();
            foreach (string usu in us)
            {
                users.Add(new SelectListItem() { Text = usu, Value = usu });
            }
            ViewBag.ListUser = users;
            return View();
        }

        [HttpPost]
        public ActionResult NuevaTarea(Tarea newTarea, string Tecnico)
        {
            if (ModelState.IsValid)
            {
                newTarea.Tecnico = Tecnico;
                newTarea.Guardar();
                return RedirectToAction("Tareas", "Jefe", new { id = newTarea.Proyecto });
            }
            else
            {
                AccesoBD miBD = new AccesoBD();
                List<String> us = miBD.DevolverUsuarios();
                List<SelectListItem> users = new List<SelectListItem>();
                foreach (string usu in us)
                {
                    users.Add(new SelectListItem() { Text = usu, Value = usu });
                }
                ViewBag.ListUser = users;
                ViewBag.proyecto = newTarea.Proyecto;
                return View(newTarea);
            }
        }

        public ActionResult BorrarTarea(string id, string pro)
        {
            AccesoBD miBD = new AccesoBD();
            miBD.BorrraTarea(id);
            return RedirectToAction("Tareas", "Jefe", new { id = pro });
        }
    }
}