package etiquetas;


import java.io.IOException;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import conexiones.usuarios;


public class inicio extends SimpleTagSupport {
	
	private HttpSession session;
	
	@Override
	public void doTag() throws JspException, IOException {
		
		JspWriter out = this.getJspContext().getOut();
		out.println("<nav class='navbar navbar-expand-md navbar-dark bg-dark'>"
				+ "<a class='navbar-brand' href=inicio.jsp style='color:#00FF00; font-weight:bold;'>FOROJUEGOS</a>"
				+ "<button class='navbar-toggler' type='button' data-toggle='collapse' data-target='#navbar' aria-controls='navbar' aria-expanded='false' aria-label='Toggle navigation'>"
				+ "<span class='navbar-toggler-icon'></span>"
				+ "</button>"
				+ "<div class='collapse navbar-collapse' id='navbar'>"
				+ "<form class='form-inline my-2 my-md-0' action='busqueda' method='post'>"
				+ "<input type='text' class='form-control' name='buscado' placeholder='Search'>"
				+ "<div class='input-group-btn'>"
				+ "<input class='btn btn-default' type='submit' value='Buscar'/>"
				+ "</div>"
				+ "</form>"
				+ " <ul class='navbar-nav m-auto'>");
					
		if (session.getAttribute("usuario") != null){
			out.println("<li class='nav-item active'><button type='button' class='btn btn-success' data-toggle='modal' data-target='#ChatModal' data-backdrop='static'>Chat Online</button></li>&emsp;");
			out.println("<li class='nav-item active'><a href='mensajes.jsp' class='btn btn-success'>Mensajes</a></li>;");
		}
		out.println("</ul><ul class='navbar-nav ml-auto'>");
		if (session.getAttribute("usuario") == null){
			out.println("<li class='nav-item active'><button type='button' class='btn btn-info' data-toggle='modal' data-target='#loginModal'>Iniciar Sesion</button></li>&emsp;");
		}		
		if (session.getAttribute("usuario") != null){
			out.println("<li class='nav-item active'><img src='imagenes/"+ ((usuarios) session.getAttribute("usuario")).getAvatar() +"' class='rounded-circle' style='width:40px;'></li>&emsp;");
			out.println("<li class='nav-item active'><strong style='color:white';>Hola: "+session.getAttribute("usuario").toString()+"</strong></li>&emsp;<br>");
			out.println("<li class='nav-item active'><a href='registro?op=deslogueo' method='get' class='text-danger font-weight-bold small'>Cerrar sesion</a></li>");
		}else{
			out.println("<li class='nav-item active'><button type='button' class='btn btn-info' data-toggle='modal' data-target='#registroModal'>Registro</button></li>");
		}
		out.println("</ul></div></nav>");
		
		//Chat Modal	
		out.println("<div id='ChatModal' class='modal show' role='dialog'>"
				+ "<div class='modal-dialog' style='height: 90vh'>"
				+ "<div class='modal-content bg-dark'>"
				+ "<div class='modal-body'>"
				+ "<button type='button' class='close' data-dismiss='modal'>&times;</button>"
				+ "<div class='boxlogin text-center'>"
				+ "<div id='ventanachat' name='ventanachat'>"
				+ "</div>"
				+ "<form name='myform' action='chateo' method='post'>"
				+ "<table>"
				+ "<tr><td><strong style='color:white'>Nuevo Mensaje: </strong>"
				+ "<input type='text' name='texto'>"
				+ "<input class='btn btn-danger' type='submit' value='Enviar' id='enviarbt' onclick=\"$(\'#ChatModal\').modal(\'show\')\"></td></tr>"
				+ "</table></form></div></div></div></div></div>");
		
		//Login Modal
		out.println("<div id='loginModal' class='modal fade' role='dialog'>"
				+ "<div class='modal-dialog'>"
				+ "<div class='modal-content'>"
				+ "<div class='modal-body'>"
				+ "<button type='button' class='close' data-dismiss='modal'>&times;</button>"
				+ "<div class='boxlogin text-center'>"
				+ "<form id='flogin' action='registro?op=logueo' method='post'>"
				+ "<h2 class='display-4 text-center' style='font-weight: bolder; color: purple;'>Login</h2>"
				+ "<div class='form-group'>"
				+ "<label class='col-md-4 control-label'>Email</label>"
				+ "<input id='email' name='email' type='text' placeholder='email' class='form-control' required>"
				+ "</div><div class='form-group'>"
				+ "<label class='col-md-4 control-label'>Password</label>"
				+ "<input id='clave' name='clave' type='password' placeholder='password' class='form-control' required>"
				+ "</div><br><br><button class='btn btn-success'>Entrar</button>"
				+ "</form>"
				+ "</div></div></div></div></div>");
		
		//Registro Modal
		out.println("<div id='registroModal' class='modal fade' role='dialog'>"
				+ "<div class='modal-dialog'>"
				+ "<div class='modal-content'>"
				+ "<div class='modal-body'>"
				+ "<button type='button' class='close' data-dismiss='modal'>&times;</button>"
				+ "<div class='boxlogin text-center'>"
				+ "<form action='registro?op=registro' method='post'>"
				+ "<h2 class='display-4 text-center' style='font-weight: bolder; color: purple;'>Registro</h2>"
				+ "<div class='row'><div class='form-group col-md-6'>"
				+ "<label>Nombre</label><input type='text' class='form-control' name='nombre' placeholder='nombre' required>"
				+ "</div><div class='form-group col-md-6'>"
				+ "<label>Password</label><input type='text' class='form-control' name='clave' placeholder='clave' required>"
				+ "</div><div class='form-group col-md-12'><label>Email</label><div class='input-group'>"
				+ "<div class='input-group-prepend'>"
				+ "<span class='input-group-text' id='inputGroupPrepend'>@</span></div>"
				+ "<input type='text' class='form-control' name='email' placeholder='email' required></div></div>"
				+ "<div class='form-group col-md-3'></div>"
				+ "<div class='form-group col-md-6 text-center'>"
				+ "<label class='text-right'>Avatar</label>"
				+ "<select name='avatar' class='form-control' onchange=\"document.images[\'avatar2\'].src=\'imagenes/\'+this.options[this.selectedIndex].value;\">"
				+ "<option value='tio.png'>Jugador</option><option value='gafas.png'>Jugadora</option><option value='militar.png'>Militar</option><option value='zombie.png'>Zombie</option>"
				+ "</select><img src='imagenes/tio.png' name='avatar2'></div></div><div class='row'>"
				+ "<div class='col-md-12 text-center'><br>"
				+ "<button class='btn btn-danger' style='aling: center'>Registrarse</button>"
				+ "</div></div></form></div></div></div></div></div>");
		
		out.println("<script src='//code.jquery.com/jquery-1.10.2.js' type='text/javascript'></script>"
				+ "<script>"
				+ "window.onload = function() {"
				+ "var intervalID = window.setInterval(carga1, 1000);"
				+ "function carga1() {"
				+ "$('#ventanachat').load('chat.jsp');"
				+ "};};"
				+ "</script>");
	}
	
	public void setSession(HttpSession session){
		this.session = session;
	}
	
}
