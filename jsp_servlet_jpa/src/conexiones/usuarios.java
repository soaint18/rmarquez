package conexiones;

import java.io.Serializable;
import javax.persistence.*;


@Entity
@Table(name="usuariosForo")
public class usuarios implements Serializable {

	private String nombre;
	private String email;
	private String clave;
	private String avatar;
	private static final long serialVersionUID = 1L;

	public usuarios() {
		
	}
	
	public usuarios(String nombre, String email, String clave, String avatar) {
		this.nombre = nombre;
		this.email = email;
		this.clave = clave;
		this.avatar = avatar;
	}

	@Override
	public String toString() {
		return nombre;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	@Id
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getClave() {
		return clave;
	}

	public void setClave(String clave) {
		this.clave = clave;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
   
}
