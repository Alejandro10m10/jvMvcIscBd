<%-- 
    Document   : jvPrincipal
    Created on : 25/03/2022, 08:24:51 AM
    Author     : aleja
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.clsUsuario"%>

<%
  String mensaje = "";
  
  // ErrorCode ---------------------------------------------------------------------------------------
  
  String message = "";
  int vistaError = Integer.parseInt((String)request.getSession().getAttribute("errorCode"));
  
  //Validación de recepción del atributo
  if(request.getSession().getAttribute("errorCode") != null || request.getSession().getAttribute("errorCode") != "0") { //Validamos que el controlador mande datos
      //Validación del código recibido
        switch (vistaError){
            case 1:
                mensaje = "<script language='javascript'>alert('Campos del formulario vacios, Verifica!');</script>";
                break;
            case 2:
                mensaje = "<script language='javascript'>alert('Nombre de usuario o contraseña incorrecto, Verifica!');</script>";
                break;
            case 3:
                mensaje = "<script language='javascript'>alert('Ha sucedido un error inesperado, reintenta nuevamente.');</script>";
                break;
            default:
                break;
        }

        mensaje += "<script language='javascript'>document.location.href='jvAcceso.jsp';</script>";
      //Actualizar el valor del atributo errorCode
      request.getSession().setAttribute("errorCode", "0");
  }
  

  // -------------------------------------------------------------------------------------------------
  
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

<%=mensaje%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./src/css/principal.css"/>
    </head>
    <body style="background:#DAF6FE">
        <form id="frmPrincipal" method="POST">  
        <center>	
            <table border="0" width="80%" cellspacing="0" cellpadding="5" class="sombreado">
                <tr>
                    <td colspan="2" bgcolor="navy">
                        <table width="100%" border="0">
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
                                            <img class="user-image" src="<%=ruta%>" alt="Foto de perfil del usuario" >
                                            <br>				
                                            <b> <%=nombre%> - <%=usuario%> </b>
                                            <br>
                                            ( <%=rol%> )
                                    </font>		
                                </td>						
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="left" width="20%" bgcolor="#14BDE9">
                        <br><br>
                        <a href="" target="_self" class="fontVinculo">Reporte de Usuarios</a>
                        <br><br>
                        <a href="" target="_self" class="fontVinculo">Gestion de Usuarios</a>
                        <br><br>
                        <a href="http://www.yahoo.com" target="_self" class="fontVinculo">opcion 3</a>
                        <br><br>
                        <a href="http://www.amazon.com" target="_self" class="fontVinculo">opcion 4</a>
                        <br><br>

                    </td>

                    <td width="80%" bgcolor="white">


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
