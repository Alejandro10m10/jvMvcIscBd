USE control_acceso;

-- ----------------------------------------------------------------------------------
-- CREACION DE PROCEDIMIENTOS ALMACENADOS PARA ALTA, BAJA Y MODIFICACION DE USUARIOS
-- ----------------------------------------------------------------------------------
-- (1) PROCEDIMIENTO PARA ALTA DE USUARIOS
--     1. NO SE PUEDE REGISTRAR UN USUARIO EXACTAMENTE CON EL MISMO NOMBRE, AP. PATERNO Y AP. MATERNO
--     2. NO SE PUEDE REGISTRAR UN USUARIO (USU_USUARIO) YA EXISTA
--     3. LA LLAVE FORANEA (TIP_CVE_TIPOUSUARIO) EXISTA EN SU TABLA CATALOGO
--     4. NOMBRE DEL PROCEDIMIENTO: spInsUsuario

-- DROP PROCEDURE spInsUsuario;

delimiter $$
CREATE PROCEDURE spInsUsuario
(
IN nombre		varchar(20),
IN paterno		varchar(20),
IN materno		varchar(20),
IN usuario		varchar(20),
IN contrasena	varchar(20),
IN ruta			varchar(200),
IN tipo			int
)
BEGIN
	-- 1ERA VALIDACION
	IF NOT EXISTS(SELECT USU_CVE_USUARIO FROM USUARIO WHERE USU_NOMBRE = nombre 
													  AND   USU_APELLIDO_PATERNO = paterno
													  AND   USU_APELLIDO_MATERNO = materno ) THEN
		-- 2DA VALIDACION
		IF NOT EXISTS(SELECT USU_CVE_USUARIO FROM USUARIO WHERE USU_USUARIO = usuario) THEN

			-- 3ERA VALIDACION
			IF EXISTS(SELECT TIP_CVE_TIPOUSUARIO FROM TIPO_USUARIO WHERE TIP_CVE_TIPOUSUARIO = tipo) THEN
				-- VALIDACIONES CORRECTAS, SE PROCEDE A INSERTAR REGISTRO
				INSERT INTO USUARIO VALUES(null, nombre, paterno, materno, usuario, contrasena, ruta, tipo);
				SELECT '0';
			ELSE
				-- NO EXISTE EL TIPO DE USUARIO EN TABLA TIPO_USUARIO
				SELECT '3';
			END IF;

		ELSE
			-- SI EXISTE UN USUARIO REGISTRADO CON EL PARAMETRO RECIBIDO
			SELECT '2';
		END IF;

	ELSE
        -- SI EXISTE UN USUARIO CON EL NOMBRE, APELLIDO PATERNO Y APELLIDO MATERNO REGISTRADO
		SELECT '1';
	END IF;

END $$


-- PRUEBAS ----------------------- 
SELECT * FROM USUARIO;
SELECT * FROM TIPO_USUARIO;


CALL spInsUsuario('Ana', 'Bell', 'Lopez', 'lbell', 'isc2021', './src/assets/img/fotos/14.jpg', 5);	-- 1
CALL spInsUsuario('Ana', 'Bell', 'Ruiz', 'lbell', 'isc2021', './src/assets/img/fotos/14.jpg', 5);	-- 2
CALL spInsUsuario('Ana', 'Bell', 'Ruiz', 'rbell', 'isc2021', './src/assets/img/fotos/14.jpg', 5);	-- 3
CALL spInsUsuario('Ana', 'Bell', 'Ruiz', 'rbell', 'isc2021', './src/assets/img/fotos/14.jpg', 2);	-- 0

SELECT * FROM USUARIO;

-- ----------------------------------------------------------------------------------
-- (2) PROCEDIMIENTO PARA MODIFICACIÓN DE USUARIOS
-- ----------------------------------------------------------------------------------
delimiter $$
CREATE PROCEDURE spUpdUsuario
(
clave		INT,
nombre		VARCHAR(20),
paterno		VARCHAR(20),
materno		VARCHAR(20),
usuario		VARCHAR(20),
pwd		VARCHAR(20),
ruta		VARCHAR(200),
tipo		INT
)
BEGIN
    -- 1ER VALIDACION
    IF  EXISTS (SELECT USU_CVE_USUARIO FROM USUARIO WHERE USU_CVE_USUARIO = clave) THEN

         -- 2DA VALIDACION
         IF NOT EXISTS (SELECT USU_CVE_USUARIO FROM USUARIO WHERE USU_NOMBRE = nombre
				AND  USU_APELLIDO_PATERNO = paterno
				AND  USU_APELLIDO_MATERNO = materno ) THEN
              -- 3ERA VALIDACION 
              IF NOT EXISTS (SELECT USU_CVE_USUARIO FROM USUARIO WHERE USU_USUARIO = usuario) THEN
              
                  -- 4TA VALIDACION
                  IF EXISTS (SELECT  TIP_CVE_TIPOUSUARIO FROM TIPO_USUARIO WHERE TIP_CVE_TIPOUSUARIO = tipo ) THEN
                       
                       -- SE PROCEDE A ACTUALIZAR  

                       UPDATE  USUARIO SET 
                       USU_NOMBRE              	= nombre, 
                       USU_APELLIDO_PATERNO    	= paterno, 
                       USU_APELLIDO_MATERNO    	= materno,
                       USU_USUARIO            	= usuario,
                       USU_CONTRASENA          	= pwd,
                       USU_RUTA                	= ruta, 
                       TIP_CVE_TIPOUSUARIO     	= tipo
                       WHERE USU_CVE_USUARIO	= clave;
                       SELECT '0';
                   ELSE
					   -- NO EXISTE EL TIPO DE USUARIO EN TABLA TIPO_USUARIO
                       SELECT '4';
                   END IF;
              ELSE
				   -- YA EXISTE UN USUARIO CON EL NOMBRE DE USUARIO REGISTRADO
                   SELECT '3';
              END IF;     
        ELSE
			-- YA EXISTE UN USUARIO CON EL NOMBRE, APELLIDO PATERNO Y APELLIDO MATERNO REGISTRADO
             SELECT '2';
        END IF;
    ELSE
		-- YA EXISTE UN USUARIO CON EL PARAMETRO (CLAVE) RECIBIDO
        SELECT '1'; 
    END IF;
END $$
delimiter $$



