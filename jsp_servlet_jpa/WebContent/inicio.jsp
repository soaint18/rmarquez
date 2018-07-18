<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*" import="conexiones.*"%>
<%@ taglib prefix="mio" uri="/WEB-INF/etiqueta/etiquetas.tld"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<mio:boostrap/>
			<link rel="stylesheet" type="text/css" href="css/login.css">
			<title>Bienvenido a ForoJuegos</title>
		</head>
		<body style="background-image: url('https://images5.alphacoders.com/884/thumb-1920-884371.jpg');">
			<mio:barraInicio session="<%=session%>" />
			<div class="container-fluid">
			<div class="row">	
				<div class="col-md-11 mx-auto">
					<form action="enlaces" method="post">
						
						<%
							int cont= 0;
							transacciones tran = new transacciones();
							List<juegosforo> lista = tran.leerjuegos();
							for (juegosforo ale : lista) {
								cont++;
						%>
							<div class="float-left">
								<button style="background-color:transparent; border:none;" id="close" class="closing" name="enlace" value="<%out.print(ale.getNombre());%>"><img width="150" height="150" src="imagenes/<%out.println(ale.getFoto());%>" /></button>
						 	</div>	
						
						<% } %>
						
					</form>
				</div>
				
				<!--
				<div class="col-md-3">
					<div id='ventanachat' name='ventanachat' style="height: 90vh">
					</div>
				</div>
				
				
				 
				<div class="col-md-3">
					<div class='bg-dark text-center'>
						<div id='ventanachat' name='ventanachat'>
						</div>
						<form action='chateo' method='post'>
							<table>
								<tr>
									<td>
										<strong style='color:white'>Nuevo Mensaje: </strong>
										<input type='text' name='texto'>
										<input class='btn btn-danger' type='submit' value='Enviar' id='enviarbt'>
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			-->
			</div>
			</div>
				
				
</body>
	</html>