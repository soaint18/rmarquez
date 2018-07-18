package conexiones;

import java.io.Serializable;
import java.lang.String;
import javax.persistence.*;

@Entity
public class juegosforo implements Serializable {
	   
	@Id
	private String nombre;
	private String foto;
	private static final long serialVersionUID = 1L;

	public juegosforo() {
	
	}   
	
	public String getNombre() {
		return this.nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getFoto() {
		return foto;
	}

	public void setFoto(String foto) {
		this.foto = foto;
	}
   
}
