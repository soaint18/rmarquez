<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*" import="conexiones.*"%>
<%@ taglib prefix="mio" uri="/WEB-INF/etiqueta/etiquetas.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<mio:boostrap />
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Mensajes Actuales</title>
</head>
<body style="background-image: url('https://images5.alphacoders.com/884/thumb-1920-884371.jpg');">
	<mio:barraInicio session="<%= session %>" />

	<div class="container" style="margin-top:80px">    
		<div class="row">
			<div class="row col-10">
				<button class="btn btn-danger" onclick="window.history.back()">Volver</button>
			</div>
			<div class="row col-1">
				<%if(session.getAttribute("usuario") != null){ %>
					<button type='button' align="center" class='btn btn-success float-right' data-toggle='modal' data-target='#ForoModal'>Responder</button>
				<% } %>
			</div>
	
			<!-- Mensaje Modal -->
			<div id="ForoModal" class="modal fade" role="dialog">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-body">
							<button type='button' class='close' data-dismiss='modal'>&times;</button>
							<div class="boxlogin text-center">
								<div>
            						<div>
            							<div class="rounded bg-light my-3">
                 							<div class="p-4">
                     							<form action="comentado?op=nuevo2" method="post">
                         							<div class="form-group">
                             							<label>Texto</label>
                             							<textarea name="texto" class="form-control" style="resize:none" rows="3" required></textarea>
                         							</div>
													<% String veo =  request.getAttribute("tema").toString();%>
                         							<input type="hidden" name="titulo" value="<%= veo %>"> 
                         							<button class="pull-right" type="submit"><i class="fa fa-plus"></i> Añadir</button> 
                     							</form>
                 							</div>
            							</div>
            						</div>
      	    					</div>
							</div>
						</div>
					</div>
				</div>
			</div>


			<!-- LECTURA DE MENSAJES -->
			<%
				transacciones tran = new transacciones();
	      		String tema = request.getAttribute("tema").toString();
				List<mensajesForo> lista = tran.leerForo((String)request.getAttribute("tema"));
				for (mensajesForo ale : lista) {
			%>	
			<div class="rounded bg-light my-1 p-1 col-11"><br>
	            <div class="row">
	                <div class="row col-6">
	                    <img src="imagenes/<%=ale.getFoto()%>" class="rounded-circle ml-3" style="width:60px;height: 60px;">
	                    <h4><%= ale.getUsuario() %></h4>
	                </div>
	                <div class="col-6 text-right">
	                    <span style="opacity:0.5;"><%= ale.getHora() %></span>
	                </div>
	            </div>
	            <hr>
	            <p><%= ale.getTexto() %></p>
	        </div>
	        
			<% } %>
		</div>
	</div>
		
</body>
</html>