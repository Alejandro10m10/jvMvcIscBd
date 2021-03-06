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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

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
    Connection cn;
    ResultSet rs;
    String consultaSQL = "";
    Statement st;
    
    public void connectDatabase(){
        try { 
            this.cn = Conexion.conectar();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(clsUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void disconnectDatabase(){
        try {
            this.cn.close();
        } catch (SQLException ex) {
            Logger.getLogger(clsUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // CREAR EL METODO PARA MONITOREO DEL STATEMENT
    Statement createStatement(){
        throw new UnsupportedOperationException("No se soporta una conexión BD");
    }
    
    // Creación de métodos para manipulación de procedimientos
    public ResultSet validarAcceso() throws SQLException, ClassNotFoundException{
        consultaSQL = "call control_acceso.sp_ValidarAcceso('" + this.usuario + "', '" + this.contrasena + "');";
        st = (Statement)this.cn.createStatement();
        rs = st.executeQuery(consultaSQL);
        return rs;
    }
    
    // Creación del método para ver el Reporte de Usuarios (vwRptUsuario)
    public ResultSet viewRptUsuario(String busqueda) throws SQLException{
        consultaSQL = "SELECT * FROM vwRptUsuario WHERE vwrptusuario.Usuario LIKE '%" + busqueda + "%'" ;
        st = (Statement)this.cn.createStatement();
        rs = st.executeQuery(consultaSQL);
        return rs;
    }
    
    public ResultSet usersList() throws SQLException{
        consultaSQL = "SELECT usuario.USU_CVE_USUARIO, usuario.USU_NOMBRE, usuario.USU_APELLIDO_PATERNO, \n" +
                        " usuario.USU_APELLIDO_MATERNO, usuario.USU_USUARIO, usuario.USU_RUTA, usuario.TIP_CVE_TIPOUSUARIO FROM usuario;";
        st = (Statement)this.cn.createStatement();
        rs = st.executeQuery(consultaSQL);
        return rs;
    }
    
    // Creación del método para Insertar Usuarios
    public ResultSet spInsUsuario(String nombre, String paterno, String materno, String usuario, String contrasena, String ruta, String tipo) throws SQLException{
        consultaSQL = "CALL spInsUsuario('" + nombre + "', '" + paterno + "', '" + materno + "', '" 
                                            + usuario + "', '" + contrasena + "', '" + ruta + "', '" + tipo + "')" ;
        st = (Statement)this.cn.createStatement();
        rs = st.executeQuery(consultaSQL);
        return rs;
    }
    
    // Creación del método para Modificar Usuarios
    public ResultSet spUpdUsuario(int id, String nombre, String paterno, String materno, String usuario, String contrasena, String ruta, String tipo) throws SQLException{
        consultaSQL = "CALL spUpdUsuario(" + id + ", '" + nombre + "', '" + paterno + "', '" + materno + "', '" 
                                            + usuario + "', '" + contrasena + "', '" + ruta + "', '" + tipo + "')" ;
        st = (Statement)this.cn.createStatement();
        rs = st.executeQuery(consultaSQL);
        return rs;
    }
    
    // Creación del método para Eliminar Usuarios
    public ResultSet spDelUsuario(int id) throws SQLException{
        consultaSQL = "CALL spDelUsuario(" + id + ")" ;
        st = (Statement)this.cn.createStatement();
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
