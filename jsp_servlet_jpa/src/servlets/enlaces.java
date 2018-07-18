package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/enlaces")
public class enlaces extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public enlaces() {
    
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		String op = (String) request.getParameter("enlace");
		request.setAttribute("enlace", op);
		RequestDispatcher rd = request.getRequestDispatcher("foroJuego.jsp");
		rd.forward(request, response);
	}

}
