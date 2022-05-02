<%-- 
    Document   : jvAdminUsuario
    Created on : 2/05/2022, 07:44:13 AM
    Author     : aleja
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
       	<link href="./src/css/principal.css" rel="stylesheet">        
    </head>
<body style="background:#DAF6FE">
    
<form id="frmPrincipal" method="POST" action="srvInsUsuario">  

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
                                <tr>
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Nombre:
                                        </font>
                                    </td>
                                    <td>
                                      <input type="text" class="textDecoracion" value="" name="txtNombre" id="txtNombre" size="25">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Apellido Paterno:
                                        </font>
                                    </td>
                                    <td>
                                        <input type="text" class="textDecoracion" value="" name="txtPaterno" size="25">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Apellido Materno:
                                        </font>
                                    </td>
                                    <td>
                                        <input type="text" class="textDecoracion" value="" name="txtMaterno" size="25">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Usuario:
                                        </font>
                                    </td>
                                    <td>
                                        <input type="text" class="textDecoracion" value="" name="txtUsuario" size="25">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Contraseña:
                                        </font>
                                    </td>
                                    <td>
                                        <input type="password" class="textDecoracion" value="" name="txtPwd" size="25">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Ruta Imagen:
                                        </font>
                                    </td>
                                    <td>
                                        <input type="text" class="textDecoracion" value="" name="txtRuta" size="25">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font class="fontTrabajoEtiquetas">
                                        Tipo Usuario (1,2,3):
                                        </font>
                                    </td>
                                    <td>
                                        <input type="text" class="textDecoracion" value="" name="txtTipo" id="txtTipo" size="25">
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td colspan="2" align="middle">
                                        <br>
                                        <input type="button" id="btnRegistrar" value="Registrar" class="botonDecoracion">
                                        &nbsp;&nbsp;
                                        <input type="button"  value="Modificar" class="botonDecoracion">
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
    
    const btnRegistrar = document.querySelector('#btnRegistrar');
    btnRegistrar.addEventListener('click', insUsuario);
    
    function sendControlador(controladorName){
        document.forms[0].action = controladorName;
        document.forms[0].submit();    
    }
    
    function rptUsuarios(){
        sendControlador('srvRptUsuario');
    }
    
    // Ejecucion de validacion y submit al controlador
    function insUsuario(){
        // Proceso de validacion de lado del cliente
        sendControlador('srvInsUsuario');
    }
</script>