<%-- 
    Document   : jvAdminUsuario
    Created on : 2/05/2022, 07:44:13 AM
    Author     : aleja
--%>

<%@page import="modelo.clsUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>

<%
    String mensaje = "";
    String vistaError;
    
    // Validación de rsInsUsuario
    if(request.getSession().getAttribute("rsInsUsuario") != null){
        ResultSet vistaUsuario = (ResultSet)request.getSession().getAttribute("rsInsUsuario");
        
        // Validación de las banderas recibidas
        mensaje += "<script language='javascript'> ";
        
        switch( vistaUsuario.getInt(1) ){
            case 0:
                mensaje += "alert('Usuario registrado exitosamente');";
                break;
            case 1:
                mensaje += "alert('El nombre capturado ya existe, verificar');";
                break;
            case 2:
                mensaje += "alert('El nombre de usuario capturado ya existe');";
                break;
            case 3:
                mensaje += "alert('El tipo de usuario no es valido, verificar');";
                break;
            default:
                break;
        }
        mensaje += "document.location.href = 'jvAdminUsuario.jsp'";
        mensaje += "</script>";
        
        // Inicialización del atributo en la sesión
        request.getSession().setAttribute("rsInsUsuario", null);
        request.getSession().invalidate();
    }
    
    vistaError = (String)request.getSession().getAttribute("errorCode");
    if(request.getSession().getAttribute("errorCode") != null){
        int vistaErrorInt = Integer.parseInt(vistaError);

        mensaje += "<script language='javascript'> ";
        //Validación del código de error recibido
        switch (vistaErrorInt){
            case 1:
                mensaje += "alert('Campo Nombre vacio, verificar!');";
                break;
            case 2:
                mensaje += "alert('Campo Apellido paterno vacio, verificar!');";
                break;
            case 3:
                mensaje += "alert('Campo Apellido materno vacio, verificar!');";
                break;
            case 4:
                mensaje += "alert('Campo Nombre usuario vacio, verificar!');";
                break;
            case 5:
                mensaje += "alert('Campo Contraseña vacio, verificar!');";
                break;
            case 6:
                mensaje += "alert('Campo Ruta vacio, verificar!');";
                break;
            case 7:
                mensaje += "alert('Campo Tipo de usuario vacio, verificar!');";
                break;
            case 8:
                mensaje += "alert('Error, al insertar el usuario contacte al administrador');";
                break;
            case 9:
                mensaje += "alert('Error, contacte al administrador');";
                break;
            default:
                break;
        }
        mensaje += "document.location.href = 'jvAdminUsuario.jsp'";
        mensaje += "</script>";

        // Inicialización del atributo de error en la sesión 
        request.getSession().setAttribute("errorCode", null);
        request.getSession().invalidate();
    }
    
    // Llenar el select con los usuarios
    clsUsuario usuariosObj = new clsUsuario(); // Creación del objeto clsUsuario
    usuariosObj.connectDatabase(); //Ejecución del método de conexión
            
    ResultSet rs;
    rs = usuariosObj.usersList();

    // Lectura del registro recibido
    String selectElement = "[";
    while(rs.next()){
        selectElement += "{ "
                        + "\"id\": " + rs.getInt(1) + ", " 
                        + "\"nombre\": \"" + rs.getString(2) + "\", "
                        + "\"apellidoPaterno\": \"" + rs.getString(3) + "\", "
                        + "\"apellidoMaterno\": \"" + rs.getString(4) + "\", "
                        + "\"usuario\": \"" + rs.getString(5) + "\", "
                        + "\"srcFotoPerfil\": \"" + rs.getString(6) + "\", "
                        + "\"tipoUsuario\": " + rs.getString(7) + " "
                        + "},";
    }

    selectElement = selectElement.substring(0, (selectElement.length() -1));
    selectElement += "]";
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
       	<link href="./src/css/principal.css" rel="stylesheet">        
    </head>
<body style="background:#DAF6FE">
    
<form id="frmPrincipal" method="POST" action="srvInsUsuario">  
<%=mensaje%>
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

                                                        </font>													
						</td>						
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="left" width="20%" bgcolor="#14BDE9">
				<br><br>
				<a href="javascript: rptUsuarios();" target="_self" class="fontVinculo">Reporte de Usuarios</a>
				<br><br>
				<a href="" target="_self" class="fontVinculo">Nuevo Usuario</a>
				<br><br>
				<a href="http://www.amazon.com" target="_self" class="fontVinculo">opcion 3</a>
				<br><br>
				<a href="http://www.amazon.com" target="_self" class="fontVinculo">opcion 4</a>
				<br><br>
                                
			</td>
			
			<td width="80%" bgcolor="white" align="middle">

                            <font face="arial" size="4" color="navy">
                                <b>ADMINISTRACIÓN DE USUARIOS.</b>
                                <br><br>
                            </font>

                            <table width="80%" border="0">
                                <tr id="selectUsuarioContent" class="no-display">
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Usuario:
                                        </font>
                                    </td>
                                    <td>
                                        <select class="textDecoracion" name="selectUsuario" id="selectUsuario">
                                            <option value="0">Seleccione un usuario</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Nombre:
                                        </font>
                                    </td>
                                    <td>
                                        <input type="text" class="textDecoracion" value="" name="txtNombre" id="txtNombre" size="25" maxlength="20">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Apellido Paterno:
                                        </font>
                                    </td>
                                    <td>
                                        <input type="text" class="textDecoracion" value="" name="txtPaterno" id="txtPaterno" size="25" maxlength="20">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Apellido Materno:
                                        </font>
                                    </td>
                                    <td>
                                        <input type="text" class="textDecoracion" value="" name="txtMaterno" id="txtMaterno" size="25" maxlength="20">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Usuario:
                                        </font>
                                    </td>
                                    <td>
                                        <input type="text" class="textDecoracion" value="" name="txtUsuario" id="txtUsuario" size="25" maxlength="20">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Contraseña:
                                        </font>
                                    </td>
                                    <td>
                                        <input type="password" class="textDecoracion" value="" name="txtPwd" id="txtPwd" size="25" maxlength="20" autocomplete="on">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Ruta Imagen:
                                        </font>
                                    </td>
                                    <td>
                                        <input type="text" class="textDecoracion" value="" name="txtRuta" id="txtRuta" size="25" maxlength="200">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Tipo Usuario (1,2,3):
                                        </font>
                                    </td>
                                    <td>
                                        <input type="text" class="textDecoracion" value="" name="txtTipo" id="txtTipo" size="25" maxlength="1">
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td colspan="2" align="middle">
                                        <br>
                                        <input type="button" id="btnRegistrar" value="Registrar" class="botonDecoracion">
                                        &nbsp;&nbsp;
                                        <input type="button" id="btnModificar" value="Modificar" class="botonDecoracion">
                                        &nbsp;&nbsp;
                                        <input type="button"  value="Eliminar" class="botonDecoracion">

                                    </td>
                                </tr>
                            </table>                            

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

<script language="javascript">
    const btnRegistrar = document.querySelector('#btnRegistrar'),
          btnModificar = document.querySelector('#btnModificar'),
          selectUsuarioContent = document.querySelector('#selectUsuarioContent');
          selectUsuarioTag = document.querySelector('#selectUsuario');
    let usersOBJ =  JSON.parse(`<%=selectElement%>`);
    
    document.addEventListener('DOMContentLoaded', init);

    function init(){
        eventListeners();
        fillUsersSelect(usersOBJ);
    }
    
    function fillUsersSelect(usersOBJ){
        usersOBJ.forEach( (user)=> {
            const {id, nombre, apellidoPaterno, apellidoMaterno} = user;
            let option = document.createElement('option');
            option.textContent = id + ' - ' + nombre + ' ' + apellidoPaterno + ' ' + apellidoMaterno ;
            selectUsuarioTag.appendChild(option);
        })
    }
  
    function eventListeners(){
        btnRegistrar.addEventListener('click', insUsuario);
        btnModificar.addEventListener('click', updUsuario);
    }
    
    let enabledUpdateButton = true,
        enabledInsertButton = true;
    
    // Ejecucion de validacion y submit al controlador
    function insUsuario(){
        
        if(!enabledInsertButton){
            showListaUsuarios(false);
            enabledInsertButton = !enabledInsertButton;
            enabledUpdateButton = true;
            return;
        } 
        
        // Proceso de validacion de lado del cliente
        if(!validarCampos()) return;
        
        if(confirm('¿Estas seguro que deseas añadir al usuario?')) sendControlador('srvInsUsuario');
    }
   
    function updUsuario(){
        
        if(enabledUpdateButton){
            showListaUsuarios(true);
            enabledUpdateButton = !enabledUpdateButton;
            enabledInsertButton = false;
            return;
        }
        
        if(!validarCampos('update')) return;

    }
    
    function sendControlador(controladorName){
        document.forms[0].action = controladorName;
        document.forms[0].submit();    
    }
    
    function rptUsuarios(){
        sendControlador('srvRptUsuario');
    }
    
    function showListaUsuarios(value){
        if(value && selectUsuarioContent.classList.contains('no-display')){
            selectUsuarioContent.classList.remove('no-display');
        } else {
            selectUsuarioContent.classList.add('no-display');
        }
    }
    
    // Proceso de validacion de lado del cliente
    function validarCampos(validation){
        // Obtener los valores de cada caja de texto
        let nombre = document.querySelector("#txtNombre").value,
            paterno = document.querySelector("#txtPaterno").value,
            materno = document.querySelector("#txtMaterno").value,
            usuario = document.querySelector("#txtUsuario").value,
            pwd = document.querySelector("#txtPwd").value,
            ruta = document.querySelector("#txtRuta").value,
            tipo = document.querySelector("#txtTipo").value;
    
        if( nombre === null || nombre === ''){ alert('El nombre no puede quedar vacio'); return false; }
        if( paterno === null || paterno === ''){ alert('El apellido paterno no puede quedar vacio'); return false;}
        if( materno === null || materno === ''){ alert('El apellido materno no puede quedar vacio'); return false;}
        if( usuario === null || usuario === ''){ alert('El nombre de usuario no puede quedar vacio'); return false;}
        if( pwd === null || pwd === ''){ alert('La contraseña no puede quedar vacio'); return false;}
        if( ruta === null || ruta === ''){ alert('La ruta para la foto de perfil del usuario no puede quedar vacio'); return false;}
        if( tipo === null || tipo === ''){ alert('El tipo de usuario no puede quedar vacio'); return false;}
        
        // Validación extra para el tipo de usuario
        tipo = Number(tipo);
        if( isNaN(tipo) ){ alert('El tipo de usuario tiene que ser de tipo numérico'); return false;}
        if( tipo > 3 || tipo < 1 ){ alert('El valor para el tipo de usuario tiene que ser 1, 2 ó 3'); return false;}
        
        if(validation === 'update'){
            let idUsuario = document.querySelector("#selectUsuario").value;
        }
        
        return true;
    }
    
</script>