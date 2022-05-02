-- *****************************************************
-- ALUMNO: Jonathan Alejandro Sánchez Alcántara
-- MATERIA: DESARROLLO AVANZADO DE SISTEMAS (I.S.C.)
-- FECHA: 23 / Marzo / 2022
-- ******************************************************

CREATE DATABASE CONTROL_ACCESO;

USE CONTROL_ACCESO;

CREATE TABLE TIPO_USUARIO
(
	TIP_CVE_TIPOUSUARIO		INT 			NOT NULL	PRIMARY KEY AUTO_INCREMENT,
	TIP_DESCRIPCION			VARCHAR(20) 	NOT NULL
);

CREATE TABLE USUARIO
(
	USU_CVE_USUARIO			INT 			NOT NULL	PRIMARY KEY AUTO_INCREMENT,
	USU_NOMBRE				VARCHAR(20) 	NOT NULL,
	USU_APELLIDO_PATERNO	VARCHAR(20) 	NOT NULL,
	USU_APELLIDO_MATERNO	VARCHAR(20) 	NOT NULL,
	USU_USUARIO				VARCHAR(20) 	NOT NULL,
	USU_CONTRASENA			VARCHAR(20) 	NOT NULL,
	USU_RUTA				VARCHAR(200) 	NOT NULL,
	TIP_CVE_TIPOUSUARIO		INT 			NOT NULL,
	FOREIGN KEY (TIP_CVE_TIPOUSUARIO) REFERENCES TIPO_USUARIO(TIP_CVE_TIPOUSUARIO) 
);


-- (1) CREAR LA BASE DE DATOS Y LAS TABLAS
-- (2) INSERTAR 3 TIPOS DE USUARIO (ADMINISTRADOR, SUPERVISOR, OPERATIVO)
-- (3) INSERTAR UN USUARIO POR CADA TIPO DE USUARIO

-- ####################################################################################
-- (4) GENERAR UNA PROPUESTA CON LO SIGUIENTE:
--     DISEÑAR UNA CONSULTA (SELECT) PARA VALIDAR UN CONTROL DE ACCESO (USUARIO Y CONTRASEÑA) CON LAS
--     DOS TABLAS QUE TENEMOS


-- (2) INSERTAR 3 TIPOS DE USUARIO (ADMINISTRADOR, SUPERVISOR, OPERATIVO)
INSERT INTO control_acceso.tipo_usuario (TIP_CVE_TIPOUSUARIO, TIP_DESCRIPCION)
	VALUES (NULL, 'ADMINISTRADOR'),
		   (NULL, 'SUPERVISOR'),
           (NULL, 'OPERATIVO');
           
SELECT * FROM control_acceso.tipo_usuario;


-- (3) INSERTAR UN USUARIO POR CADA TIPO DE USUARIO
INSERT INTO control_acceso.usuario (USU_CVE_USUARIO, USU_NOMBRE, USU_APELLIDO_PATERNO, USU_APELLIDO_MATERNO, USU_USUARIO, USU_CONTRASENA, 
									USU_RUTA, TIP_CVE_TIPOUSUARIO)
	VALUES (NULL, 'Jonathan Alejandro', 'Sánchez', 'Alcántara', 'admin', '12345', './src/assets/img/fotos/1.jpg', 1),
		   (NULL, 'Yessica', 'Vicencio', 'Delgado', 'yessi', '12345', './src/assets/img/fotos/2.jpg', 2),
           (NULL, 'Axel Santiago', 'Ángeles', 'Sánchez', 'axel', '12345', './src/assets/img/fotos/3.jpg', 3);
           
SELECT * FROM control_acceso.usuario;


-- (4) GENERAR UNA PROPUESTA CON LO SIGUIENTE:
--     DISEÑAR UNA CONSULTA (SELECT) PARA VALIDAR UN CONTROL DE ACCESO (USUARIO Y CONTRASEÑA) CON LAS
--     DOS TABLAS QUE TENEMOS
SELECT u.USU_CVE_USUARIO, concat(u.USU_NOMBRE, ' ', u.USU_APELLIDO_PATERNO, ' ', u.USU_APELLIDO_MATERNO) AS USU_NOMBRE_COMPLETO, 
		u.USU_USUARIO, u.USU_RUTA AS USU_RUTA_FOTO_PERFIL, t.TIP_DESCRIPCION FROM usuario AS u
INNER JOIN tipo_usuario AS t ON u.TIP_CVE_TIPOUSUARIO = t.TIP_CVE_TIPOUSUARIO
	WHERE u.USU_USUARIO = 'admin' AND u.USU_CONTRASENA = '12345';
    
SELECT u.USU_CVE_USUARIO FROM usuario AS u
INNER JOIN tipo_usuario AS t ON u.TIP_CVE_TIPOUSUARIO = t.TIP_CVE_TIPOUSUARIO
	WHERE u.USU_USUARIO = 'admin' AND u.USU_CONTRASENA = '12345';

-- Procedimiento almacenado
delimiter $$
-- DROP PROCEDURE sp_Acceso;
CREATE PROCEDURE sp_ValidarAcceso(
	IN usuario VARCHAR(20),
	IN contrasenia VARCHAR(20)
)
BEGIN
	-- Validacion de condicion de usuario / password
    IF EXISTS( SELECT u.USU_CVE_USUARIO FROM usuario AS u
				INNER JOIN tipo_usuario AS t ON u.TIP_CVE_TIPOUSUARIO = t.TIP_CVE_TIPOUSUARIO
					WHERE u.USU_USUARIO = usuario
						AND u.USU_CONTRASENA = contrasenia) THEN
        
        SELECT '1', @usu_cve_usuario:= u.USU_CVE_USUARIO AS usu_cve_usuario, 
				   @usu_nombre_completo:= concat(u.USU_NOMBRE, ' ', u.USU_APELLIDO_PATERNO, ' ', u.USU_APELLIDO_MATERNO) AS usu_nombre_completo, 
				   @usu_usuario:= u.USU_USUARIO  AS usu_usuario, 
				   @usu_ruta_foto_perfil:= u.USU_RUTA AS usu_ruta_foto_perfil, 
				   @usu_tipo_usuario:= t.TIP_DESCRIPCION  AS usu_tipo_usuario
		FROM usuario AS u
		INNER JOIN tipo_usuario AS t ON u.TIP_CVE_TIPOUSUARIO = t.TIP_CVE_TIPOUSUARIO
			WHERE u.USU_USUARIO = usuario AND u.USU_CONTRASENA = contrasenia;
            
	ELSE 
		-- No existe un usuario con ese nombre de usuario o con esa contraseña
		SELECT '0';
	END IF;
    
    -- Limpiamos nuestras variables
    SET @usu_cve_usuario := null;
	SET @usu_nombre_completo := null;
	SET @usu_usuario := null;
	SET @usu_ruta_foto_perfil:= null;
    SET @usu_tipo_usuario:= null;
END$$
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Creación de la VISTA vwRptUsuario para construir el reporte de usuarios

CREATE VIEW vwRptUsuario
AS 
	SELECT u.USU_CVE_USUARIO AS Clave, concat(u.USU_NOMBRE, ' ', u.USU_APELLIDO_PATERNO, ' ', u.USU_APELLIDO_MATERNO) AS Nombre,
		u.USU_USUARIO AS Usuario, u.USU_RUTA AS Foto, concat(t.TIP_CVE_TIPOUSUARIO, ' - ', t.TIP_DESCRIPCION) AS Rol FROM usuario AS u
	INNER JOIN tipo_usuario AS t
		ON u.TIP_CVE_TIPOUSUARIO = t.TIP_CVE_TIPOUSUARIO;

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Ejecución de la vista para pruebas

SELECT * FROM vwRptUsuario;

-- Actividad: Insersión de 10 usuarios
INSERT INTO control_acceso.usuario (USU_CVE_USUARIO, USU_NOMBRE, USU_APELLIDO_PATERNO, USU_APELLIDO_MATERNO, USU_USUARIO, USU_CONTRASENA, 
									USU_RUTA, TIP_CVE_TIPOUSUARIO)
	VALUES (NULL, 'Natalia', 'Alvarez', 'Castillo', 'natalia', '12345', './src/assets/img/fotos/3.jpg', 2),
		   (NULL, 'Anginnell', 'Tapia', 'Delgado', 'angi', '12345', './src/assets/img/fotos/1.jpg', 1),
           (NULL, 'Ricardo', 'Vega', 'Zambrano', 'ricardo', '12345', './src/assets/img/fotos/2.jpg', 3),
           (NULL, 'Selene', 'Garces', 'Espada', 'selene', '12345', './src/assets/img/fotos/7.jpg', 1),
           (NULL, 'Paola Adrea', 'Correa', 'Rojas', 'paola', '12345', './src/assets/img/fotos/12.jpg', 2),
           (NULL, 'Sebastian', 'Uribe', 'Solano', 'sebas', '12345', './src/assets/img/fotos/13.jpg', 2),
           (NULL, 'Rafael', 'Moreno', 'Espinoza', 'rafa', '12345', './src/assets/img/fotos/6.jpg', 3),
           (NULL, 'Maria Jóse', 'García', 'Mora', 'maria', '12345', './src/assets/img/fotos/11.jpg', 3),
           (NULL, 'Laura', 'Zuñiga', 'Ramírez', 'laura', '12345', './src/assets/img/fotos/9.jpg', 2),
           (NULL, 'Juliana', 'Gonzales', 'Suarez', 'ricardo', '12345', './src/assets/img/fotos/14.jpg', 3);

