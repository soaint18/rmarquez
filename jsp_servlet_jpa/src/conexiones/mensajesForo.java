package conexiones;

import java.io.Serializable;
import javax.persistence.*;

@Entity
public class mensajesForo implements Serializable {

	private static final long serialVersionUID = 1L;
	private int numeroDeComentario;
	private String tema;
	private String usuario;
	private String texto;
	private String hora;
	private String foto;
	
	public mensajesForo() {
	}
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public int getNumeroDeComentario() {
		return numeroDeComentario;
	}

	public void setNumeroDeComentario(int numeroDeComentario) {
		this.numeroDeComentario = numeroDeComentario;
	}

	public String getTema() {
		return tema;
	}

	public void setTema(String tema) {
		this.tema = tema;
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

	public String getFoto() {
		return foto;
	}

	public void setFoto(String foto) {
		this.foto = foto;
	}

}
