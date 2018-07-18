package conexiones;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.Query;


public class transacciones {
	
	EntityManagerFactory emf;
	EntityManager em;
	EntityTransaction tx;
	
	public transacciones() {
		emf = Persistence.createEntityManagerFactory("juegos");
		em = emf.createEntityManager();
		tx = em.getTransaction();   
	}
	
	public void guardarNuevo(String nombre,String email,String clave,String avatar) 
	{
		try{
			usuarios usu = new usuarios();
			usu.setNombre(nombre);
			usu.setEmail(email);
			usu.setClave(clave);
			usu.setAvatar(avatar);		
			tx.begin();
		    em.persist(usu);
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			e.getMessage();
			em.close();
		}	
	}

	public usuarios autentificar(String usuario) {
		usuarios usu = new usuarios();
		Query consulta = em.createQuery("select distinct al from usuarios al where al.email='"+usuario+"'");
		@SuppressWarnings("unchecked")
		List <usuarios> rpta = consulta.getResultList();
		for (usuarios ale : rpta) {
			if (ale.getClave().equals(null)) {
				usu.setNombre("no existe");
			}
			else{
				return(ale);
			}
		}
		return(usu); 
	}
	
	public void nuevoMensajeForo(String nombre, String titulo, String texto, String hora,String foto)
	{	
		try{
			mensajesForo men = new mensajesForo();
			men.setUsuario(nombre);
			men.setTema(titulo);
			men.setTexto(texto);
			men.setHora(hora);
			men.setFoto(foto);			
			tx.begin();
		    em.persist(men);
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			e.getMessage();
			em.close();
		}		
	}
	
	public List<tema> leerTitulos(String juego){
		Query consulta = em.createQuery("Select te from tema te where te.juego ='"+juego+"'"); 
		@SuppressWarnings("unchecked")
		List <tema> rpta = consulta.getResultList();		
		return rpta;
	}
	
	public void mensajePrivado(String hora,String destinatario, String destino, String asunto, String texto)
	{
		try{
			mensajesPrivados men = new mensajesPrivados();
			men.setHora(hora);
			men.setDestinatario(destinatario);
			men.setDestino(destino);
			men.setAsunto(asunto);
			men.setTexto(texto);		
			tx.begin();
		    em.persist(men);
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			e.getMessage();
			em.close();
		}	
		
	}
	
	public List<mensajesPrivados> leerMensajes(String usuario){
		Query consulta = em.createQuery("Select privados from mensajesPrivados privados where privados.destino ='" + usuario + "' order by privados.numeroMensaje desc"); 
		@SuppressWarnings("unchecked")
		List <mensajesPrivados> rpta = consulta.getResultList();		
		return rpta;
	}
	
	public void BorrarMensajePrivado(String asunto, String destinatario){
		tx.begin();
		Query consulta = em.createQuery("delete from mensajesPrivados men where men.asunto = :DATO and men.destinatario = :DATO2");  			
		consulta.setParameter("DATO", asunto);
		consulta.setParameter("DATO2", destinatario);
		consulta.executeUpdate();	
        tx.commit();
	}
	
	public void mensajeChat(String hora,String destinatario, String texto)
	{
		try{
			mensajesChat men = new mensajesChat();
			men.setHora(hora);
			men.setUsuario(destinatario);
			men.setTexto(texto);
			tx.begin();
		    em.persist(men);
			tx.commit();
			} catch (Exception e) {
				tx.rollback();
				e.getMessage();
				em.close();
			}		
	}
	
	public List<mensajesChat> leerChat(){
		Query consulta = em.createQuery("Select chat from mensajesChat chat"); 
		@SuppressWarnings("unchecked")
		List <mensajesChat> rpta = consulta.getResultList();		
		return rpta;
	}
	
	public List<juegosforo> leerjuegos(){
		Query consulta = em.createQuery("Select fo from juegosforo fo"); 
		@SuppressWarnings("unchecked")
		List <juegosforo> rpta = consulta.getResultList();		
		return rpta;
	}

	public void guardarTema(String titulo, String juego, String fecha, String nombre,String texto, String foto) {
		tx.begin();
		tema te = new tema(titulo,juego,fecha);
		em.persist(te);
		tx.commit();
		nuevoMensajeForo(nombre, titulo, texto, fecha, foto);
	}
	
	public List<mensajesForo> leerForo(String tema){
		Query consulta = em.createQuery("Select te from mensajesForo te where te.tema ='"+tema+"'"); 
		@SuppressWarnings("unchecked")
		List <mensajesForo> rpta = consulta.getResultList();		
		return rpta;
	}
	
}
