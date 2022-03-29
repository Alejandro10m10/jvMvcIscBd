/*
 *  Control srvAcceso para comunicación a MySQL 
 *  Para el proceso de acceso de usuarios
 */
package controlador;

import java.io.IOException;
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
public class srvAcceso extends HttpServlet {

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
        
        // Recepción de datos (jvAcceso.jsp)
        String usuario = request.getParameter("txtUsuario");
        String contrasena = request.getParameter("txtContrasena");
        
        //Validación de datos recibidos
        if(usuario.equals("") || usuario == null || contrasena.equals("") || contrasena == null) { sendErrorCode(request, response, 1); return; } //Datos vacios
        
        // Datos de usuario correctos y Creación del objeto para conexión a BD
        clsUsuario obj = new clsUsuario(usuario, contrasena);
        try {
            //Ejecución del método de conexión
            obj.connectDatabase();
            //Ejecución del método de validar acceso
            ResultSet rsSrv = obj.validarAcceso();
            //Validación del resultado de ejecuión
            int bandera = 0;
            while( rsSrv.next() ){
                bandera = Integer.parseInt(rsSrv.getString(1));
                if(bandera == 1){
                    obj.setNombre(rsSrv.getString(3));
                    obj.setUsuario(rsSrv.getString(4));
                    obj.setRuta(rsSrv.getString(5));
                    obj.setTipoUsuario(rsSrv.getString(6));
                }
            }

            // Enviar el control de ejecución a jvPrincipal.jsp
            if(bandera == 1) { // << Exito >>
                sendCorrectData(request, response, obj);
            } else { // << No Exito >>
                sendErrorCode(request, response, 2); //Usuario incorrecto
            }           
        } catch (ClassNotFoundException | SQLException e) {
            Logger.getLogger(srvAcceso.class.getName() ).log(Level.SEVERE, null, e);
            sendErrorCode(request, response, 3); //Error de conectividad externo al usuario
        } finally{
            obj.disconnectDatabase();
        }
    }
    
    private void sendErrorCode(HttpServletRequest request, HttpServletResponse response, int errorKeyCode) throws ServletException, IOException{
        request.getSession().setAttribute("errorCode", String.valueOf(errorKeyCode));
        request.getRequestDispatcher("jvPrincipal.jsp").forward(request, response);
    }
    
    private void sendCorrectData(HttpServletRequest request, HttpServletResponse response, clsUsuario persona) throws ServletException, IOException{
        request.getSession().setAttribute("srvUsuario", persona);
        request.getRequestDispatcher("jvPrincipal.jsp").forward(request, response);
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

}
