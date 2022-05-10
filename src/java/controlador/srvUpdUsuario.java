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
public class srvUpdUsuario extends HttpServlet {

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
        try {
            // Recepcion de los datos (cajas de texto)
            String idString = request.getParameter("txtID");
            String nombre = request.getParameter("txtNombre");
            String paterno = request.getParameter("txtPaterno");
            String materno = request.getParameter("txtMaterno");
            String usuario = request.getParameter("txtUsuario");
            String pwd = request.getParameter("txtPwd");
            String ruta = request.getParameter("txtRuta");
            String tipo = request.getParameter("txtTipo");  
            
            // Validacion de variables
            if( idString == null  || idString.equals(""))  { sendErrorCode(request, response, 1); return; } // errorCode 1 = ID vacio
            if( nombre == null  || nombre.equals(""))  { sendErrorCode(request, response, 2); return; } // errorCode 2 = Nombre vacio
            if( paterno == null || paterno.equals("")) { sendErrorCode(request, response, 3); return; } // errorCode 3 = Apellido paterno vacio
            if( materno == null || materno.equals("")) { sendErrorCode(request, response, 4); return; } // errorCode 4 = Apellido materno vacio
            if( usuario == null || usuario.equals("")) { sendErrorCode(request, response, 5); return; } // errorCode 5 = Nombre usuario vacio
            if( pwd == null     || pwd.equals(""))     { sendErrorCode(request, response, 6); return; } // errorCode 6 = Password vacio
            if( ruta == null    || ruta.equals(""))    { sendErrorCode(request, response, 7); return; } // errorCode 7 = Ruta vacio
            if( tipo == null    || tipo.equals(""))    { sendErrorCode(request, response, 8); return; } // errorCode 8 = Tipo de usuario vacio
            
            int id;
            try {
                id = Integer.parseInt(idString);
            } catch (NumberFormatException e) {
                sendErrorCode(request, response, 9); return; // errorCode 9 = ID no es un numero
            }
            // Aplicación de los atributos recibidos para ejecutar el método de inserción
            
            clsUsuario obj = new clsUsuario(); // Creación del objeto clsUsuario
            
            obj.connectDatabase(); //Ejecución del método de conexión
            
            ResultSet rs;
            rs = obj.spUpdUsuario(id, nombre, paterno, materno, usuario, pwd, ruta, tipo);
            
            // Lectura del registro recibido
            if(rs.next()){
                //Enviar el atributo rs a la página JSP
                System.out.println(rs.getString(1));
                //sendCorrectData(request, response, rs);
            } else{
                //sendErrorCode(request, response, 8); return;
            }
            
        } catch (SQLException e) {
            Logger.getLogger(srvUpdUsuario.class.getName() ).log(Level.SEVERE, null, e);
            sendErrorCode(request, response, 9); // errorCode 8 = Error de conectividad externo al usuario
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
        request.getSession().setAttribute("rsUpdUsuario", rs);
        request.getRequestDispatcher("jvAdminUsuario.jsp").forward(request, response);
    }
}
