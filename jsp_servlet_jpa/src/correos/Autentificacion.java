package correos;

import javax.mail.*;

public class Autentificacion extends Authenticator {
	
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication ("forojuegosdaw@gmail.com","forojuegos05");
	}

}