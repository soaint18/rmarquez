<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*" import="conexiones.*"%>
<%@ taglib prefix="mio" uri="/WEB-INF/etiqueta/etiquetas.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<mio:boostrap/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ese nombre esta cogido pruebe otro!</title>
</head>
<body>
<body style="background-image: url('https://images5.alphacoders.com/884/thumb-1920-884371.jpg');">
<mio:barraInicio session="<%= session %>"/>
	
	<div style="margin-left:2%;" class="p-3 mb-2 bg-light text-dark">
	<h2>El nombre seleccionado esta cogido, pruebe otro, gracias</h2>
	<a href="inicio.jsp">Volver a inicio</a>
	</div>
</body>
</html>