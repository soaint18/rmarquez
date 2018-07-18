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

@WebServlet("/chateo")
public class chateo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public chateo() {

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		HttpSession session = request.getSession();
		String texto = request.getParameter("texto");
		Date date = new Date();
		DateFormat hourdateFormat = new SimpleDateFormat("HH:mm:ss");
		String fecha = hourdateFormat.format(date);
		String destinatario = session.getAttribute("usuario").toString();
		transacciones tran = new transacciones();
		tran.mensajeChat(fecha, destinatario, texto);
		RequestDispatcher rd = request.getRequestDispatcher("inicio.jsp");
		rd.forward(request, response);
	}

}
