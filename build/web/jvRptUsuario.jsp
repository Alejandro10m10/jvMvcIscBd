<%-- 
    Document   : jvRptUsuario
    Created on : 4/04/2022, 07:21:54 AM
    Author     : Jonathan Alejandro Sánchez Alcántara
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="modelo.clsUsuario"%>

<%

    String mensaje = "";
    
    // Validación de recepción del ResultSet rsRptUsuario
    if(request.getSession().getAttribute("rsRptUsuario") != null ){
        ResultSet rsVistaUsuario = (ResultSet) request.getSession().getAttribute("rsRptUsuario");
        
        // Construcción de la tabla de datos (HTML)
        mensaje += "<table style='display:grid; place-content:center;' border='1'>";
        mensaje += "<tr>";
        mensaje += "<td><b>Clave</b></td>";
        mensaje += "<td><b>Nombre</b></td>";
        mensaje += "<td><b>Usuario</b></td>";
        mensaje += "<td><b>Foto</b></td>";
        mensaje += "<td><b>Rol</b></td>";
        mensaje += "</tr>";
        
        //Lectura de todos los registros
        while(rsVistaUsuario.next()){
            mensaje += "<tr>";
            mensaje += "<td>" + rsVistaUsuario.getString(1) + "</td>";
            mensaje += "<td>" + rsVistaUsuario.getString(2) + "</td>";
            mensaje += "<td>" + rsVistaUsuario.getString(3) + "</td>";
            mensaje += "<td><img src='" + rsVistaUsuario.getString(4) + "' width='50px'></td>";
            mensaje += "<td>" + rsVistaUsuario.getString(5) + "</td>";
            mensaje += "</tr>";
        }
        mensaje += "</table>";
    } else{
        mensaje += "<script language='javascript'>";
        mensaje += "alert('Aun no hay usuarios por visualizar. ');";
        mensaje += "document.location.href = 'jvPrincipal.jsp';";
        mensaje += "</script>";
    }
    
    // srvUsuario ---------------------------------------------------------------------------------------
      clsUsuario vistaUsuario;
      String nombre = "", ruta = "", usuario = "", rol = "";
      if(request.getSession().getAttribute("srvUsuario") != null ){
          vistaUsuario = (clsUsuario)request.getSession().getAttribute("srvUsuario");

          nombre = vistaUsuario.getNombre();
          ruta = vistaUsuario.getRuta();
          usuario = vistaUsuario.getUsuario();
          rol = vistaUsuario.getTipoUsuario();

          mensaje = "<script language='javascript'>alert('Bienvenido: " + nombre + ", " + usuario + ", [" + rol + "] ');</script>";

          //Actualizar el valor del atributo errorCode
          request.getSession().setAttribute("srvUsuario", null);
      }
      // -------------------------------------------------------------------------------------------------

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./src/css/principal.css"/>
    </head>
    <body style="background:#DAF6FE">
        <form id="frmRptUsuario" method="POST" action="srvRptUsuario">  
        <center>	
            <table border="0" width="80%" cellspacing="0" cellpadding="5" class="sombreado">
                <tr>
                    <td border="0" colspan="2" bgcolor="navy">
                        <table width="100%">
                            <tr>
                                <td align="left" width="20%">
                                    <img src="./src/assets/img/computerBusiness.jpg" width="130px" height="80px"> 
                                </td>
                                <td align="middle" width="60%">
                                    <font class="fontTitulo" >
                                            <b>Computer Business</b>
                                    </font>
                                </td>
                                <td align="right" width="20%">
                                    <font class="fontEtiqueta">
                                            <img class="user-image" src="" alt="Foto de perfil del usuario" >
                                            <br>				
                                            <b> </b>
                                            <br>
                                            (  )
                                    </font>		
                                </td>						
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="left" width="20%" bgcolor="#14BDE9" style="position: relative">
                        <div style="position: absolute; top:0;">
                            <br>
                            <br>
                            <a href="srvRptUsuario" target="_self" class="fontVinculo">Reporte de Usuarios</a>
                            <!-- 
                            <br><br>
                            <a href="javascript: rptUsuario();" target="_self" class="fontVinculo">Reporte de Usuarios (POST)</a>
                            -->
                            <br><br>
                            <a href="" target="_self" class="fontVinculo">Gestion de Usuarios</a>
                            <br><br>
                            <a href="http://www.yahoo.com" target="_self" class="fontVinculo">opcion 3</a>
                            <br><br>
                            <a href="http://www.amazon.com" target="_self" class="fontVinculo">opcion 4</a>
                            <br><br>
                           
                        </div>

                    </td>

                    <td width="98.9%" bgcolor="white" style="display:grid; place-content: center;">
                            <div style="margin-top: 20px; display: grid; grid-template-columns: auto 1fr; gap: 10px;" >
                                <p style="margin: 5px 10px 5px 0">Captura un filtro de busqueda:</p>
                                <input type="text" id="txtFiltro" name="txtFiltro" placeholder="Captura un nombre de usuario">
                                <input  style="display: grid; grid-column: 1/3" type="submit" id="btnAceptar" name="btnAceptar" value="Aplicar">
                            </div>
                            &nbsp;&nbsp;
                            <%=mensaje %>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="middle" bgcolor="navy">
                        <font class="fontEtiqueta">
                                derechos reservados
                        </font>
                        &nbsp;
                        <a href="http://www.facebook.com" target="_blank"><img src="./src/assets/img/facebook.jpg" class="imgRedes"></a> 				
                        &nbsp;
                        <a href="http://www.instagram.com" target="_blank"><img src="./src/assets/img/instagram.png" class="imgRedes"></a> 				
                        &nbsp;
                        <a href="http://www.twitter.com" target="_blank"><img src="./src/assets/img/twitter.png" class="imgRedes"></a> 				
                    </td>
                </tr>	
            </table>
        </center>
        </form>
    </body>
</html>
