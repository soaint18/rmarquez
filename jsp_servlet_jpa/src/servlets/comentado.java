package servlets;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexiones.transacciones;
import conexiones.usuarios;

@WebServlet("/comentado")
public class comentado extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public comentado() {

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		HttpSession session = request.getSession();
		String op = request.getParameter("op");
		if(op.equals("nuevo")) {
			String titulo = request.getParameter("titulo");
			String texto = request.getParameter("texto");
			String juego = request.getParameter("juego");
			Date date = new Date();
			DateFormat hourdateFormat = new SimpleDateFormat("dd/MM/yyyy");
			String fecha = hourdateFormat.format(date);
			usuarios usu = (usuarios) session.getAttribute("usuario");
			transacciones transac = new transacciones();
			transac.guardarTema(titulo,juego,fecha,usu.getNombre(),texto,usu.getAvatar());
			request.setAttribute("enlace", juego);
			RequestDispatcher rd = request.getRequestDispatcher("foroJuego.jsp");
			rd.forward(request, response);
		}
		if(op.equals("nuevo2"))	{
			String titulo = request.getParameter("titulo");
			String texto = request.getParameter("texto");
			Date date = new Date();
			DateFormat hourdateFormat = new SimpleDateFormat("dd/MM/yyyy");
			String fecha = hourdateFormat.format(date);
			usuarios usu = (usuarios) session.getAttribute("usuario");
			transacciones transac = new transacciones();
			transac.nuevoMensajeForo(usu.getNombre(), titulo, texto, fecha, usu.getAvatar());
			request.setAttribute("tema", titulo);
			RequestDispatcher rd = request.getRequestDispatcher("mensajesForo.jsp");
			rd.forward(request, response);
		}
		if(op.equals("dirigir")) {
			String tema = request.getParameter("tema");
			request.setAttribute("tema", tema);
			RequestDispatcher rd = request.getRequestDispatcher("mensajesForo.jsp");
			rd.forward(request, response);
		}
	}
}
