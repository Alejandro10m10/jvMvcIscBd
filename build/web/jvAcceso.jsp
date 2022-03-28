<%-- 
    Document   : jvAcceso
    Created on : 25/03/2022, 08:24:39 AM
    Author     : aleja
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form id="frmLogin" name="frmLogin" method="post" action="srvAcceso">
            <center>
                <table width="30%" border="1">
                    <tr>
                        <td colspan="2" bgcolor="Navy" align="middle">
                            <font face="arial" color="white" size="3"
                                  <b>Acceso Principal</b>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%" bgcolor="Lightblue">
                            <font face="arial" color="blue" size="2">
                                  Usuario:
                            </font>                        
                        </td>
                        <td width="75%">
                            <input type="text" id="txtUsuario" name="txtUsuario" 
                                   placeholder="Captura tu usuario">
                        </td>
                    </tr>
                    <tr>
                        <td width="25%" bgcolor="Lightblue">
                            <font face="arial" color="blue" size="2">
                                  Contraseña:
                            </font>                        
                        </td>
                        <td width="75%">
                            <input type="text" id="txtContrasena" name="txtContrasena" 
                                   placeholder="Captura tu contraseña">
                        </td>
                    </tr>                
                    <tr>
                        <td colspan="2" bgcolor="Navy" align="middle">
                            <input type="submit" id="btnAceptar" 
                                   name="btnAceptar" value="Aceptar">
                        </td>
                    </tr>                
                </table>
            </center>
        </form>
    </body>
</html>
