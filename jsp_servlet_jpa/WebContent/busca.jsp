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
<body style="background-image: url('https://images5.alphacoders.com/884/thumb-1920-884371.jpg');">
	<mio:barraInicio session="<%= session %>"/>
	
	<div style="margin-left:2%;" class="p-3 mb-2 bg-light text-dark">
	<%
		if (!request.getAttribute("busca").equals(":( El juego no esta registrado en nuestra página")) {
	%>
	<form action="enlaces" method="post">
			<button  style="background-color:transparent; border:none;color:blue;" id="close" class="closing" name="enlace" value="<%out.print(request.getAttribute("busca").toString());%>"><%out.print(request.getAttribute("busca").toString());%></button>

	</form>
	<%
		} else {
			String palabra = (String) request.getAttribute("busca2");
	%>
	<h5>QUIZAS QUISO DECIR:</h5>
	<%
			transacciones tran = new transacciones();
			List<juegosforo> lista = tran.leerjuegos();
			for (juegosforo item : lista) {
				System.out.print(item.getNombre());
				if (item.getNombre().contains(palabra.toUpperCase())) {
	%>
	<form action="enlaces" method="post">
	<button  style="background-color:transparent; border:none;color:blue;" id="close" class="closing" name="enlace" value="<%out.print(item.getNombre());%>"><%out.print(item.getNombre());%></button>
	<br>
	<%
			}
				}
	%>
	</form>
	<%
		}
	%>
	</div>

</body>
</html>