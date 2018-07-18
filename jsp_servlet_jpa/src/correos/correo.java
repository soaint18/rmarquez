package correos;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class correo {
	
	private String emisor="forojuegos@gmail.com";
	private String asunto="Bienvenido a forojuegos";
	private Session sesion = null;
	
	public correo() {
		Properties propiedades = new Properties();
		propiedades.put("mail.smtp.host", "smtp.gmail.com");
		propiedades.put("mail.smtp.starttls.enable", "true");
		propiedades.put("mail.smtp.user", emisor);
		propiedades.put("mail.smtp.port", "587");
		propiedades.put("mail.smtp.auth", "true");
		Autentificacion visar = new Autentificacion();
		sesion = Session.getInstance(propiedades,visar);
		sesion.setDebug(true); 
	}
	
	public void enviar(String nombre, String email)	{
		MimeMessage mensage = new MimeMessage(sesion);
		try {
			mensage.setFrom(new InternetAddress(emisor));
			mensage.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
			mensage.setSubject(asunto);
			String texto = "Le damos la bienvenida desde ForoJuegos señor/a " + nombre;
			mensage.setText(texto);
			Transport.send(mensage);
		} catch (Exception e) {
			System.out.println("El correo a  "+email+ " no se ha mandado.");
		} 
	}	

}
