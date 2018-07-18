package conexiones;

import java.io.Serializable;
import java.lang.String;
import javax.persistence.*;


@Entity
public class tema implements Serializable {
	
	private String juego;
	private String titulo;
	private String fecha;
	private static final long serialVersionUID = 1L;

	public tema(String titulo, String juego, String fecha) {
		this.titulo = titulo;
		this.juego = juego;
		this.fecha = fecha;
	}   
	
	public tema() {
		
	}
	
	public String getJuego() {
		return this.juego;
	}

	public void setJuego(String juego) {
		this.juego = juego;
	}   
	
	@Id
	public String getTitulo() {
		return this.titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}   
	public String getFecha() {
		return this.fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
   
}
