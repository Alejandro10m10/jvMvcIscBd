/*
 * Estructura de la entidad USUARIO que se utilizará
 *   -nombre        (String)
 *   -usuario       (String)
 *   -contraseña    (String)
 *   -ruta          (String)
 *   -tipo_usuario  (String)
 */
package modelo;

import java.sql.Connection;

/**
 *
 * @author Jonathan Alejandro Sánchez Alcántara
 */
public class clsUsuario {
    
    private String nombre;
    private String usuario;
    private String contrasena;
    private String ruta;
    private String tipoUsuario;
    
    public clsUsuario(){ //Constructor base
        
    }
    
    public clsUsuario(String usuario, String contrasena){
        this.usuario = usuario;
        this.contrasena = contrasena;
    }
    
    // ------------------------
    // Sección de manejo de conexión y manipulació de datos
    // ------------------------
    Connection cn;

    // ------------------------
    // Setters and Getters
    // ------------------------
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getRuta() {
        return ruta;
    }

    public void setRuta(String ruta) {
        this.ruta = ruta;
    }

    public String getTipoUsuario() {
        return tipoUsuario;
    }

    public void setTipoUsuario(String tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }   
}
