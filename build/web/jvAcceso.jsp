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
        <link rel="stylesheet" href="./src/css/log-in.css"/>
    </head>
    <body>
        <main class="user-control">
            <section class="user_control__sign-up">
                <h1 class="user-control__header">Acceso Principal</h1>
                <h2 class="user-control__subtitle">Inicia sesión para ver el panel <br> de control de usuarios</h2>
                <span class="line"></span>
                <form class="user-control__form" id="frmLogin" method="post" action="srvAcceso">
                    <label for="txtUsuario">Usuario:</label>
                    <input type="text" id="txtUsuario" name="txtUsuario" placeholder="Captura tu usuario...">

                    <label for="txtContrasena">Contraseña:</label>
                    <input type="number" id="txtContrasena" name="txtContrasena" placeholder="Captura tu contraseña...">

                    <input type="submit" id="btnAceptar" name="btnAceptar" value="Aceptar">

                    <p class="user-control__form__policies">Al iniciar sesión, acepta nuestros <a href="#">Términos</a>, <a href="#">Política de datos</a> y <a href="#">Política de cookies</a>.</p>
                </form>
            </section>
            <section class="user_control__log-in">
                <p class="user-control__log-in__title">No tienes una cuenta? <a href="#">Regístrate</a></p>
            </section>
            <section class="user-control__downloads">
                <p class="user-control__downloads__title">Obten la app.</p>
                <div class="user-control__downloads__store">
                    <a href="#" class="user-control__downloads__anchor">
                        <img class="user-control__downloads__anchor__img" src="./src/assets/icon/downloadOnAppStore.png" alt="Download on the App Store">
                    </a>
                    <a href="#" class="user-control__downloads__anchor">
                        <img class="user-control__downloads__anchor__img" src="./src/assets/icon/downloadOnGooglePlay.png" alt="Get it on Google Play">
                    </a>
                </div>
            </section>
        </main>
    </body>
</html>
