/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Jonathan Alejandro Sánchez Alcántara
 */
public class Conexion {
    
    private static final String DATABASE = "control_acceso";
    private static final String USER = "root";
    private static final String PASSWORD = "19992407";
    private static final String KEYSECURITY = "?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String URL = "jdbc:mysql://localhost/" + DATABASE + KEYSECURITY;
    public static Connection cn;
    
    //Conexión Local
    public static Connection conectar() throws ClassNotFoundException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            cn = (Connection) DriverManager.getConnection(Conexion.URL, Conexion.USER, Conexion.PASSWORD);
            return cn;
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error en la conexión local: " + e.getMessage());
        }
        return (null);
    }
}
