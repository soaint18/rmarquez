package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import conexiones.transacciones;
import conexiones.usuarios;
import correos.correo;


@WebServlet("/registro")
public class controlarRegistro extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		String op = request.getParameter("op");
		HttpSession session = request.getSession();
		ArrayList<String> conectados = null;
		ServletContext conectado = request.getServletContext();
		conectados = (ArrayList<String>)conectado.getAttribute("conectados");
		if(conectados == null){
			conectados = new ArrayList<String>();
		}
		
		//LOGUEAR
		if (op.equals("logueo"))
		{
			String emailUsuario = request.getParameter("email");
			String claveUsuario = request.getParameter("clave");
			boolean esta = false;		
			transacciones ope = new transacciones();
			usuarios usuario = ope.autentificar(emailUsuario);
			for(String persona: conectados) {
				if(persona.equals(emailUsuario)) {
					esta = true;
				}
			}
			if(esta) {
				RequestDispatcher rd = request.getRequestDispatcher("logueo.jsp");
				rd.forward(request, response);
			}
			if ((usuario.getClave()).equals(claveUsuario)) {
				usuario.setClave(null);
				session.setAttribute("usuario", usuario);
				request.setAttribute("session", session);
				conectados.add(emailUsuario);
				conectado.setAttribute("conectados", conectados);
				RequestDispatcher rd = request.getRequestDispatcher("inicio.jsp");
				rd.forward(request, response);
			}
			else {
				RequestDispatcher rd = request.getRequestDispatcher("logueo.jsp");
				rd.forward(request, response);
			}		
		}
		
		//REGISTRAR
		if (op.equals("registro")) {
			String nombre = request.getParameter("nombre");
			String email = request.getParameter("email");
			String clave = request.getParameter("clave");
			String avatar = request.getParameter("avatar");
			System.out.println(avatar);
			transacciones transac = new transacciones();
			transac.guardarNuevo(nombre,email,clave,avatar);
			correo corre = new correo();
			corre.enviar(nombre,email);
			usuarios usuario = new usuarios(nombre,email,clave,avatar);
			session.setAttribute("usuario", usuario);
			request.setAttribute("session", session);
			conectados.add(email);
			conectado.setAttribute("conectados", conectados);
			RequestDispatcher rd = request.getRequestDispatcher("inicio.jsp");
			rd.forward(request, response);
		}
		
	}
	
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html");
		String op = request.getParameter("op");	
		HttpSession session = request.getSession();
		ArrayList<String> conectados = null;
		ServletContext conectado = request.getServletContext();
		conectados = (ArrayList<String>)conectado.getAttribute("conectados");
		if(conectados == null) {
			conectados = new ArrayList<String>();
		}
		
		//Cerrar sesion
		if(op.equals("deslogueo")){
			String nombre = session.getAttribute("usuario").toString();
			conectados.remove(nombre);
			conectado.setAttribute("conectados", conectados);
			conectado.removeAttribute("estoy");
			session.invalidate();
			response.sendRedirect("inicio.jsp");
		}
	}
}
