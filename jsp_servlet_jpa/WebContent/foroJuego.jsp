<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*" import="conexiones.*"%>
<%@ taglib prefix="mio" uri="/WEB-INF/etiqueta/etiquetas.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<mio:boostrap />
	<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<title>Foro</title>
</head>
<style>
    html,body,h1,h2,h3,h4,h5 {font-family: "Open Sans", sans-serif}
</style>
<body style="background-image:url('https://i.pinimg.com/originals/e3/b5/23/e3b523ef1d88a3e3f400658271776688.jpg'); ">
	<mio:barraInicio session="<%= session %>" />

	<div class="container" style="margin-top:80px">    
		<h2 align="center" style="color:white;">FORO DEL JUEGO:<%out.print(request.getAttribute("enlace"));%></h2>
		<div class="row" style="border-top:solid;">
       
    	   	<div class="col-md-11 mx-auto m7">
      	
	      		<!-- Nuevo Tema -->
	      		<%if(session.getAttribute("usuario") != null){ %>
	      			<button type='button' align="center" class='btn btn-success' data-toggle='modal' data-target='#TemaModal'>Añadir nuevo tema</button>
	      		<% } %>
	      		
	      		<!-- Tema Modal -->
				<div id="TemaModal" class="modal fade" role="dialog" style="margin: solid red 80px">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-body">
								<button type='button' class='close' data-dismiss='modal'>&times;</button>
								<div class="boxlogin text-center">
									<%if(session.getAttribute("usuario") != null){ %>
										<div>
	             							<div>
	             								<div class="rounded bg-light my-3">
	                 								<div class="p-4">
	                     								<form action="comentado?op=nuevo" method="post">
	                         								<div class="form-group">
	                             								<label>Titulo</label>
	                             								<input name="titulo" type="text" class="form-control btn btn-block" required>
	                         								</div>
	                         								<div class="form-group">
	                             								<label>Texto</label>
	                             								<textarea name="texto" class="form-control" style="resize:none" rows="3" required></textarea>
	                         								</div>
	                         								<input type="hidden" name="juego" value="<%out.print(request.getAttribute("enlace"));%>"> 
	                         								<button class="pull-right" type="submit"><i class="fa fa-plus"></i> Añadir</button> 
	                     								</form>
	                 								</div>
	             								</div>
	             							</div>
	         							</div>
									<% } %>
								</div>
							</div>
						</div>
					</div>
				</div>
			
				<!-- Lista Temas -->
				<form action="comentado?op=dirigir" method="post">
					<%
					transacciones tran = new transacciones();
					List<tema> lista = tran.leerTitulos((String)request.getAttribute("enlace"));
					for (tema ale : lista) {
					%>		
        
					<div class='rounded bg-light my-1 p-3'><br>
						<div class='row'>
							<div class='row col-6'>
								<input name="tema" type="submit" value="<%=ale.getTitulo()%>" style="background-color:transparent; border:none;""/>
							</div>
							<div class='col-6 text-right'>
								<span style="opacity:0.5;"><%=ale.getFecha()%></span>
							</div>
						</div>
					</div>	
					<% } %>	
				</form>
			</div>
		</div>
	</div>
	
</body>
</html>