package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conexiones.juegosforo;
import conexiones.transacciones;

@WebServlet("/busqueda")
public class busqueda extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public busqueda() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		String op = request.getParameter("buscado");
		System.out.println(op);
		transacciones tran = new transacciones();
		List<juegosforo> lista = tran.leerjuegos();
		for (juegosforo item : lista) {	
	 			 if (item.getNombre().equals(op.toLowerCase())) {
	 				request.setAttribute("busca", op);
	 				RequestDispatcher rd = request.getRequestDispatcher("busca.jsp");
	 				rd.forward(request, response);
	 			 }
	 	}
	 	request.setAttribute("busca", ":( El juego no esta registrado en nuestra página");
	 	request.setAttribute("busca2", op);
		RequestDispatcher rd = request.getRequestDispatcher("busca.jsp");
		rd.forward(request, response);
	}

}
