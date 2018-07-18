package conexiones;

import java.io.Serializable;
import javax.persistence.*;


@Entity
public class mensajesChat implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private int numeroMensaje;
	private String usuario;
	private String texto;
	private String hora;
	
	public mensajesChat() {
		
	}
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public int getNumeroMensaje() {
		return numeroMensaje;
	}

	public void setNumeroMensaje(int numeroMensaje) {
		this.numeroMensaje = numeroMensaje;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String getTexto() {
		return texto;
	}

	public void setTexto(String texto) {
		this.texto = texto;
	}

	public String getHora() {
		return hora;
	}

	public void setHora(String hora) {
		this.hora = hora;
	}
   
}
