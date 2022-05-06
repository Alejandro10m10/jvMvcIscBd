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
        mensaje += "<table class='reporte' style='display:grid; place-content:center;' border='1'>";
        mensaje += "<tr style='height: 35px;'>";
        mensaje += "<td style='width: 9%'><b>Clave</b></td>";
        mensaje += "<td style='width: 550px'><b>Nombre</b></td>";
        mensaje += "<td style='width: 17%'><b>Usuario</b></td>";
        mensaje += "<td style='width: 10%'><b>Foto</b></td>";
        mensaje += "<td style='width: 25%'><b>Cargo</b></td>";
        mensaje += "</tr>";
        
        //Lectura de todos los registros
        while(rsVistaUsuario.next()){
            
            String cargo = rsVistaUsuario.getString(5);
            String clase = "";
            String userName = rsVistaUsuario.getString(2);
            
            if(cargo.equals("1 - ADMINISTRADOR")){
                clase = "administrador";
            } else if(cargo.equals("2 - SUPERVISOR")){
                clase = "supervisor";
            } else if(cargo.equals("3 - OPERATIVO")){
                clase = "operativo";
            }
            
            mensaje += "<tr>";
            mensaje += "<td>" + rsVistaUsuario.getString(1) + "</td>";
            mensaje += "<td style='text-align: start; padding-left: 10px;'>" + userName + "</td>";
            mensaje += "<td style='text-align: start; padding-left: 10px;'>" + rsVistaUsuario.getString(3) + "</td>";
            mensaje += "<td><img class='userProfilePicture' src='" + rsVistaUsuario.getString(4) + "' title='Haz click aquí para ver la foto de " + userName + "...'></td>";
            mensaje += "<td style='text-align: start; padding-left: 10px;' class='" + clase + "'>" + rsVistaUsuario.getString(5) + "</td>";
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
        <link rel="stylesheet" href="./src/css/reporte.css"/>
    </head>
    <body style="background:#DAF6FE">
        
        <div class="user-pictrue no-display">
            <div class="user-pictrue__content">
                <svg id="btnCloseImage" xmlns="http://www.w3.org/2000/svg" width="44" height="44" viewBox="0 0 24 24" stroke-width="2" stroke="#597e8d" fill="none" stroke-linecap="round" stroke-linejoin="round">
                    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                    <line x1="18" y1="6" x2="6" y2="18" />
                    <line x1="6" y1="6" x2="18" y2="18" />
                  </svg>
                <div class="picture">
                    
                </div>
                <!-- <img class="user-pictrue__picture" src="" alt="Foto de perfil de usuario"> -->
            </div>
            <div class="user-pictrue__background"></div>
        </div>
        
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
                            <a href="jvAdminUsuario.jsp" target="_self" class="fontVinculo">Gestion de Usuarios</a>
                            <br><br>
                            <a href="http://www.yahoo.com" target="_self" class="fontVinculo">opcion 3</a>
                            <br><br>
                            <a href="http://www.amazon.com" target="_self" class="fontVinculo">opcion 4</a>
                            <br><br>
                           
                        </div>

                    </td>

                    <td width="98.9%" bgcolor="white" style="display:grid; place-content: center;">
                            <div style="margin-top: 20px; display: grid; grid-template-columns: repeat(2, auto); grid-template-rows: repeat(2, auto); gap: 10px; place-content:center; place-items:center;" >
                                <p class="title-report" style="margin: 5px 0 5px 0; display: grid; grid-column: 1/3">Reporte de usuarios</p>
                                <input style="display: grid; grid-row: 2/3" type="text" id="txtFiltro" name="txtFiltro" placeholder="Captura un nombre...">
                                <input  style="display: grid; grid-row: 2/3" type="submit" id="btnAceptar" name="btnAceptar" value="Buscar">
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
                    
        <script src="./src/js/reporte.js"></script>
    </body>
</html>
