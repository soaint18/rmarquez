package conexiones;

import java.io.Serializable;
import javax.persistence.*;


@Entity
public class mensajesPrivados implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private int numeroMensaje;
	private String hora;
	private String destinatario;
	private String destino;
	private String asunto;
	private String texto;
	
	public mensajesPrivados() {

	}
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public int getNumeroMensaje() {
		return numeroMensaje;
	}

	public void setNumeroMensaje(int numeroMensaje) {
		this.numeroMensaje = numeroMensaje;
	}

	public String getHora() {
		return hora;
	}

	public void setHora(String hora) {
		this.hora = hora;
	}

	public String getDestinatario() {
		return destinatario;
	}

	public void setDestinatario(String destinatario) {
		this.destinatario = destinatario;
	}

	public String getDestino() {
		return destino;
	}

	public void setDestino(String destino) {
		this.destino = destino;
	}

	public String getAsunto() {
		return asunto;
	}

	public void setAsunto(String asunto) {
		this.asunto = asunto;
	}

	public String getTexto() {
		return texto;
	}

	public void setTexto(String texto) {
		this.texto = texto;
	}
   
}
