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
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

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
    
    // ------------------------
    // Constructores
    // ------------------------
    public clsUsuario(){ //Constructor base
        
    }
    
    public clsUsuario(String usuario, String contrasena){
        this.usuario = usuario;
        this.contrasena = contrasena;
    }
    
    // ------------------------
    // Sección de manejo de conexión y manipulació de datos
    // ------------------------
    Connection cnn;
    ResultSet rs;
    String consultaSQL = "";
    Statement st;
    
    // Sección de métodos para conexión y ejecución de comandos
    public Connection conexion(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            cnn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/control_acceso","root","19992407");
            System.out.println("Conexion a BD exitosa!");
        }
        catch(ClassNotFoundException | SQLException ex){
            System.out.println("Error: " + ex.getMessage());
        }
        return cnn;
    }

    // CREAR EL METODO PARA MONITOREO DEL STATEMENT
    Statement createStatement(){
        throw new UnsupportedOperationException("No se soporte una conexión BD");
    }
    
    // Creación de métodos para manipulación de procedimientos
    public ResultSet validarAcceso() throws SQLException{
        consultaSQL = "call control_acceso.sp_ValidarAcceso('" + this.usuario + "', '" + this.contrasena + "');";
        
        st = (Statement)cnn.createStatement();
        rs = st.executeQuery(consultaSQL);
        
        return rs;
    }

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
