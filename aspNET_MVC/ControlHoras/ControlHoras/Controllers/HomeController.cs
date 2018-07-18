using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ControlHoras.Models;
using ControlHoras.Infraestructuras.Filtros;

namespace ControlHoras.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Logout()
        {
            Session["Usuario"] = null;
            return RedirectToAction("Login", "Home");
        }

        [HttpPost]
        public ActionResult Login(string Nombre, string Password)
        {
            if (ModelState.IsValid)
            {
                AccesoBD miBD = new AccesoBD();
                if (miBD.ValidarUser(Nombre,Password) != null)
                {
                    Usuario usu = miBD.ValidarUser(Nombre, Password);
                    Session["Usuario"] = usu;
                    if (usu.Cargo == "jefepro")
                    {
                        return RedirectToAction("Proyectos", "Jefe");
                    }
                    else
                    {
                        return RedirectToAction("MisProyectos", "Emple");
                    }
                }
                else
                {
                    return View();
                }
            }
            else
            {
                return View();
            }
        }

        [HttpGet]
        public ActionResult RegistroUsuario()
        {
            return View();
        }

        [HttpPost]
        public ActionResult RegistroUsuario(Usuario newUser)
        {
            if (ModelState.IsValid)
            {
                newUser.Guardar();
                return RedirectToAction("Login", "Home");
            }
            else
            {
                return View(newUser);
            }
        }

        
    }
}