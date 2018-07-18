package servlets;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conexiones.mensajesPrivados;
import conexiones.transacciones;

@WebServlet("/mensajePrivado")
public class mensajePrivado extends HttpServlet {

	private static final long serialVersionUID = 1L;
	public List<mensajesPrivados> listaconcuerda = new ArrayList<mensajesPrivados>();

    public mensajePrivado() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		HttpSession session = request.getSession();
		String op = request.getParameter("op");
		transacciones transac = new transacciones();
		String destinatario = session.getAttribute("usuario").toString();

		//buscar mensajes
		if (op.equals("buscar")) {
			String buscado = request.getParameter("buscado");
			transacciones tran = new transacciones();
			List<mensajesPrivados> lista = tran.leerMensajes(session.getAttribute("usuario").toString());
			for (mensajesPrivados ale : lista) {
				if(ale.getAsunto().toUpperCase().contains(buscado.toUpperCase())) {
					listaconcuerda.add(ale);
				}
				else if(ale.getDestinatario().toUpperCase().contains(buscado.toUpperCase())) {
					listaconcuerda.add(ale);
				}
				else if(ale.getDestino().toUpperCase().contains(buscado.toUpperCase())) {
					listaconcuerda.add(ale);
				}
				else if(ale.getTexto().toUpperCase().contains(buscado.toUpperCase())) {
					listaconcuerda.add(ale);
				}
			}
			if (listaconcuerda == null)	{
				request.setAttribute("mensaje", "No se ha encontrado nada");
				RequestDispatcher rd = request.getRequestDispatcher("busquedamensajes.jsp");
				rd.forward(request, response);
			}
			else {
				RequestDispatcher rd = request.getRequestDispatcher("busquedamensajes.jsp");
				rd.forward(request, response);
			}
			
		}
		
		//Añadir mensaje nuevo
		if (op.equals("nuevo"))	{
			String asunto = request.getParameter("asunto");
			String comentario = request.getParameter("texto");
			Date date = new Date();
			DateFormat hourdateFormat = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy");
			String fecha = hourdateFormat.format(date);
			String destino = request.getParameter("destino");
			transac.mensajePrivado(fecha, destinatario, destino, asunto, comentario);
			RequestDispatcher rd = request.getRequestDispatcher("mensajes.jsp");
			rd.forward(request, response);
		}
		
		//Botones
		if (op.equals("botones")) {
			if(("Borrar".equals(request.getParameter("borrar")))) {
				transac.BorrarMensajePrivado(request.getParameter("asunto"),destinatario);
				System.out.println("Borrado con exito");
				RequestDispatcher rd = request.getRequestDispatcher("mensajes.jsp");
				rd.forward(request, response);
			}
			if(("Responder".equals(request.getParameter("responder"))))	{
					request.setAttribute("destino", request.getParameter("anterior"));
					RequestDispatcher rd = request.getRequestDispatcher("nuevomensaje.jsp");
					rd.forward(request, response);
			}
		}
	}

}
