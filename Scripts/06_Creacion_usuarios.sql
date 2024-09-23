-- CREACION DE USUARIOS Y PERMISOS


-- Usuario con permisos de solo lectura
CREATE USER 'usuario_3'@'localhost' IDENTIFIED BY 'contrasena3';

-- Permisos de solo lectura en todas las tablas
GRANT SELECT ON *.* TO 'usuario_3'@'localhost';

FLUSH PRIVILEGES;


-- Usuario con permisos de lectura, inserción y modificación
CREATE USER 'usuario_4'@'localhost' IDENTIFIED BY 'contrasena4';

-- Permisos de lectura, inserción y modificación en todas las tablas
GRANT SELECT, INSERT, UPDATE ON *.* TO 'usuario_4'@'localhost';

FLUSH PRIVILEGES;