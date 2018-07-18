<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*" import="conexiones.*"%>
<%@ taglib prefix="mio" uri="/WEB-INF/etiqueta/etiquetas.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<mio:boostrap />
	<title>Insert title here</title>
</head>
<body>
	<%
		List<String> mensajes = new ArrayList<String>();
		List<String> personas = new ArrayList<String>();
		boolean estaEscrita = false;
		boolean estaEscrita2 = false;
		transacciones tran = new transacciones();
		List<mensajesChat> lista = tran.leerChat();
	%>
	<br>
	<div class="wrapper">
		<div class="type-board">
			<p></p>
	    	<div class="content">
	            <form>
		            <div class="bg-danger col-md-12 rounded">
						<span class="time-right"><strong>MENSAJES CHAT:</strong></span>
					</div>
	            </form>
	        </div>
	    </div>
	</div>
	<div  style="overflow-y: scroll; height: 90%">
	<%		
		for (mensajesChat ale : lista) {
							
			for(String esta2: mensajes){
				if(esta2.equals(ale.toString())){
					estaEscrita2 = true;
				}
			}
							
			if(!estaEscrita2){
				mensajes.add(ale.toString());
	%>
				<div class="wrapper">
					<div class="type-board">
						<p></p>
				    	<div class="content">
				            <form>
				        	    <div class="bg-primary col-md-12 rounded">
									<span class="time-right"><strong><%out.print(ale.getHora());%></strong></span>
								</div>
				            </form>
				        </div>
				    </div>
					<div class="container bg-light rounded">
						<p><strong><%out.print(ale.getUsuario());%></strong>:<%out.print(ale.getTexto());%></p>
					</div>
				</div>
	<%
			}
		}
					
	%>
	</div>
</body>
</html>