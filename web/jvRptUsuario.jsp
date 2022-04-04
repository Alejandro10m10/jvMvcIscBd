<%-- 
    Document   : jvRptUsuario
    Created on : 4/04/2022, 07:21:54 AM
    Author     : Jonathan Alejandro Sánchez Alcántara
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>

<%

    String mensaje = "";
    
    // Validación de recepción del ResultSet rsRptUsuario
    if(request.getSession().getAttribute("rsRptUsuario") != null ){
        ResultSet rsVistaUsuario = (ResultSet) request.getSession().getAttribute("rsRptUsuario");
        
        // Construcción de la tabla de datos (HTML)
        mensaje += "<table width='70px' border='1'>";
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

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <br><br>
        <%=mensaje %>
        
    </body>
</html>
