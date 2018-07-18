<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*" import="conexiones.*"%>
<%@ taglib prefix="mio" uri="/WEB-INF/etiqueta/etiquetas.tld" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<mio:boostrap />
	<title>Mis mensajes</title>
</head>
<body style="background-image: url('https://images5.alphacoders.com/884/thumb-1920-884371.jpg');">
	<mio:barraInicio session="<%= session %>"/>	
	<br>

	<!-- Mensaje Modal -->
	<div id="MensajeModal" class="modal fade" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-body">
					<button type='button' class='close' data-dismiss='modal'>&times;</button>
					<div class="boxlogin text-center">
						<br>
    					<div class="container bg-light col-md-12">
   							<h2 style="color:red">ENVIAR MENSAJE</h2>
        					<div class="row">
            					<div class="col-md-12">
                					<div class="well well-lg">
                    					<form action="mensajePrivado?op=nuevo" method="post">
                        					<div class="row">
                            					<div class="col-md-5">
                                					<div class="form-group">
                                    					<label for="email">Destino</label>
                                    						<div class="input-group">
                                        						<span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
                                        						<input type="text" id="email" name="destino" class="form-control"  required="required">
					                                    	</div>

                                    						<div class="form-group">
                                        						<label for="subject">Asunto</label>
                                        						<input type="text" id="subject" name="asunto" class="form-control" placeholder="Subject" required="required">
                                    						</div>
                                 					</div>
		                            			</div>
                            					<div class="col-md-5">
                                					<div class="form-group">
                                    					<label for="name">Mensaje</label>
                                    					<textarea name="texto" id="message" class="form-control" rows="5" required="required" placeholder="Message"></textarea>
                                					</div>
                            					</div>
                            					<div class="col-md-2">
                                					<div class="control-group">
                                    					<label class="control-label" for="button1id"></label>
                                    					<div class="controls">
                                    						<br>
                                        					<button id="button1id" name="button1id" class="btn btn-success">Enviar</button>
                                						</div>
                            						</div>
                            					</div>
                        					</div>
                    					</form>
                					</div>
            					</div>
            					<div class="col-md-12">
            					</div>	
            				</div>
   		    			</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		
	<!-- CORREO ACTUAL -->	
	<div  align="center" style="background-color: white; border: solid;margin-left: 10%; width: 80%;">
		<table class="table table-condensed table-hover">
	  		<thead>
	    		<tr>
	      			<th class="span1">Usuario</th>
	      			<th class="span1">Asunto</th>
	      			<th class="span1">Mensaje</th>
	      			<th class="span1"></th>
	      			<th><button type='button' align="center" class='btn btn-success' data-toggle='modal' data-target='#MensajeModal'>Nuevo Mensaje</button></th>
	    		</tr>
	  		</thead>
    		<tbody>
			<%  
				transacciones tran = new transacciones();
				List<mensajesPrivados> lista = tran.leerMensajes(session.getAttribute("usuario").toString());
				int cont = 0;
				
				for (mensajesPrivados ale : lista) {
					//Añadir un tope de comentarios
			%>
	
    			<tr>
     				<form action="mensajePrivado?op=botones" method="post">
      					<td><strong><%out.print(ale.getDestinatario()); %></strong></td>
      					<td><input type="text" name="asunto" value="<%out.print(ale.getAsunto());%>" style="border: none ;" readonly="readonly"></td>
      					<td><span><%out.print(ale.getTexto()); %></span></td>
      					<td><span style="opacity:0.5;"><%out.print(ale.getHora()); %></span></td>
      					<td><input class="btn btn-danger" value="Borrar" name="borrar" type="submit" /></td>
					</form>
    			</tr>
	
			<% } %>
  			</tbody>
		</table>
	</div>
</body>
</html>