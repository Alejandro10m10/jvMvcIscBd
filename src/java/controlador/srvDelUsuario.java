/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.clsUsuario;

/**
 *
 * @author aleja
 */
public class srvDelUsuario extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8"); // Obtener los valores sin importar que tengan acentos
        try {
            // Recepcion de los datos (cajas de texto)
            String idString = request.getParameter("txtID");
            
            // Validacion de variables
            if( idString == null  || idString.equals(""))  { sendErrorCode(request, response, 1); return; } // errorCode 1 = ID vacio
           
            int id;
            try {
                id = Integer.parseInt(idString);
            } catch (NumberFormatException e) {
                sendErrorCode(request, response, 2); return; // errorCode 2 = ID no es un numero
            }
            // Aplicación de los atributos recibidos para ejecutar el método de inserción
            
            clsUsuario obj = new clsUsuario(); // Creación del objeto clsUsuario
            
            obj.connectDatabase(); //Ejecución del método de conexión
            
            ResultSet rs;
            rs = obj.spDelUsuario(id);
            
            // Lectura del registro recibido
            if(rs.next()){
                //Enviar el atributo rs a la página JSP
                sendCorrectData(request, response, rs);
            } else{
                sendErrorCode(request, response, 3); return;
            }
            
        } catch (SQLException e) {
            Logger.getLogger(srvDelUsuario.class.getName() ).log(Level.SEVERE, null, e);
            sendErrorCode(request, response, 4); // errorCode 8 = Error de conectividad externo al usuario
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void sendErrorCode(HttpServletRequest request, HttpServletResponse response, int errorKeyCode) throws ServletException, IOException{
        request.getSession().setAttribute("errorCode", String.valueOf(errorKeyCode));
        request.getRequestDispatcher("jvAdminUsuario.jsp").forward(request, response);
    }
    
    private void sendCorrectData(HttpServletRequest request, HttpServletResponse response, ResultSet rs) throws ServletException, IOException{
        request.getSession().setAttribute("rsDelUsuario", rs);
        request.getRequestDispatcher("jvAdminUsuario.jsp").forward(request, response);
    }
}
