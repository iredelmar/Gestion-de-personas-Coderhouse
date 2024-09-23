DROP schema IF exists GESTIONPERSONASLOAIZA;
CREATE SCHEMA IF NOT EXISTS GESTIONPERSONASLOAIZA;
USE GESTIONPERSONASLOAIZA;

-- DESCRIPCION DEL ESQUEMA:
-- SE CREA ESTE ESQUEMA PARA PODER OBTENER INFORMACION DE PARA LOS PROCESOS DE DESARROLLO PROFESIONAL, SE REQUIERE PODER TENER INFORMACION DEL ESTATUS DE LOS CURSOS, PODER CRUZAR DESEMPEÑO PARA REVISAR LAS POSTULACIONES A MOVILIDADEES,
-- ACTUALMENTE RESULTA MUY COMPLEJO PODER REVISAR INFORMACION DE FORMA RAPIDA, POR LO QUE SE PRETENDE REALIZAR CONSULTAS DE LA INFORMACION Y DISPONIBILIZARLA PARA LA TOMA DE DECISIONES
-- SE NECESITA INFORMACION AL DIA CON RESPECTO A LOS CURSOS CON MAYOR INTERES, ESTATUS DE REALIZACION, DEMORAS EN LOS PLAZOS DE REALIZACION, OTORGAMIENTO DE BECAS, EVALUACION DE DESEMPEÑO, ASCENSOS, ENTRE OTRAS.

-- TABLA QUE REGISTRA LA ESTRUCTURA DE LA ORGANIZACION
DROP TABLE IF exists ESTRUCTURA_ORGANIZACIONAL;
CREATE TABLE ESTRUCTURA_ORGANIZACIONAL (
id_estructura INT AUTO_INCREMENT,
id_area INT,
area VARCHAR(60),
id_subgerencia INT,
subgerencia VARCHAR(60),
id_gerencia INT,
gerencia VARCHAR (60) NOT NULL,
id_filial INT NOT NULL,
filial ENUM ('A', 'B', 'C') NOT NULL,
 CONSTRAINT PK_ESTRUCTURA_ORGANIZACIONAL PRIMARY KEY (id_estructura)
);


-- TABLA QUE REFLEJA EL LISTADO DE TODOS LOS CARGOS DE LA ORGANIZACIÓN
DROP TABLE IF exists CARGOS;
CREATE TABLE CARGOS (
codigo_cargo INT NOT NULL,
cargo VARCHAR(60) NOT NULL,
id_estructura INT NOT NULL,
rol ENUM ('GENERAL', 'PRIVADO') NOT NULL,
familia_cargo VARCHAR(60),
nivel_cargo INT(2),
personas_a_cargo ENUM ('SI', 'NO') NOT NULL,
cargo_comercial ENUM ('SI','NO'),
region_comercial VARCHAR (60),
 CONSTRAINT PK_CARGOS PRIMARY KEY (codigo_cargo),
 CONSTRAINT FK_CARGOS_ESTRUCTURA FOREIGN KEY (id_estructura) REFERENCES ESTRUCTURA_ORGANIZACIONAL(id_estructura)
);


-- TABLA DE REGISTRO DE TODOS LOS COLABORADORES DE LA EMPRESA Y SUS DATOS
DROP TABLE IF exists COLABORADORES;
CREATE TABLE COLABORADORES (
id_colaborador VARCHAR(12),
nombres_colaborador VARCHAR(60) NOT NULL,
apellidos_colaborador VARCHAR(60) NOT NULL,
fecha_de_nacimiento DATE NOT NULL,
sexo ENUM ('F', 'M') NOT NULL,
fecha_ingreso DATE NOT NULL,
email_colaborador VARCHAR(30) NOT NULL,
direccion_colaborador VARCHAR(60),
telefono_colaborador varchar(15),
codigo_cargo INT,
id_jefatura varchar(12),
sucursal VARCHAR(30) NOT NULL,
id_estructura INT NOT NULL,
nivel_jerarquico ENUM ('AREA', 'SUBGERENCIA', 'GERENCIA') NOT NULL,
tipo_contrato ENUM ('PLAZO_FIJO','INDEFINIDO') NOT NULL,
plazo_contrato int NOT NULL,
modalidad_jornada ENUM ('PRESENCIAL','TELETRABAJO_PARCIAL','TELETRABAJO_TOTAL'),
nivel_academico ENUM ('ENSEÑANZA_MEDIA', 'TECNICO', 'UNIVERSITARIO', 'ESTUDIOS_SUPERIORES', 'MAGISTER') NOT NULL,
cant_hijos int,
estado_civil ENUM ('SOLTERO/A', 'CASADO/A', 'VIUDO', 'CONVIVIENTE_CIVIL', 'DIVORCIADO/A', 'SEPARADO/A'),
 CONSTRAINT PK_COLABORADORES PRIMARY KEY (id_colaborador),
 CONSTRAINT FK_COLABORADOR_ESTRUCTURA_ORGANIZACIONAL FOREIGN KEY (id_estructura) REFERENCES ESTRUCTURA_ORGANIZACIONAL (id_estructura),
 CONSTRAINT FK_COLABORADOR_CARGOS FOREIGN KEY (codigo_cargo) REFERENCES CARGOS (codigo_cargo)
);


-- TABLA QUE REGISTRA EL LISTADO DE CAPACITACIONES
DROP TABLE IF exists CAPACITACIONES;
CREATE TABLE CAPACITACIONES (
id_capacitacion INT AUTO_INCREMENT,
nombre_capacitacion VARCHAR(80) NOT NULL,
dirigido_a VARCHAR(150),
hrs_capacitacion DECIMAL(3,1),
tipo_capacitacion ENUM('INTERNA','EXTERNA'),
tipo_malla ENUM('NORMATIVA','TRANSVERSAL','VENTA_Y_SERVICIO_AL_CLIENTE','DEI','TECNICA','LIDERAZGO'),
plataforma ENUM('PORTAL_FORMACION_LH','PORTAL_ACHS','TEAMS','OTRA'),
nombre_institucion VARCHAR(60),
 CONSTRAINT PK_CAPACITACIONES PRIMARY KEY (id_capacitacion)
);

-- TABLA INTERMEDIA QUE REGISTRA A QUE CARGOS VA DIRIGIDA CADA CAPACITACION
DROP TABLE IF exists CAPACITACIONES_CARGOS;
CREATE TABLE CAPACITACIONES_CARGOS (
id_capacitacion INT,
codigo_cargo INT,
 CONSTRAINT PK_CAPACITACIONES_CARGOS PRIMARY KEY (id_capacitacion, codigo_cargo),
 CONSTRAINT FK_CAPACITACIONES_CARGOS_CAPACITACIONES FOREIGN KEY (id_capacitacion) REFERENCES CAPACITACIONES (id_capacitacion),
 CONSTRAINT FK_CAPACITACIONES_CARGOS_CARGOS FOREIGN KEY (codigo_cargo) REFERENCES CARGOS (codigo_cargo)
);


-- TABLA DONDE SE REGISTRAN TODAS LAS CAPACITACIONES QUE HAN HECHO LOS COLABORADORES Y EL ESTATUS EN EL QUE SE ENCUENTRAN, ASI COMO CUANTAS OPORTUNIDADES SE INSCRIBIO DETERMINADO CURSO PARA LOGRAR SU FINALIZACION (NUMERO_LLAMADO)
DROP TABLE IF EXISTS REGISTRO_CAPACITACIONES;
CREATE TABLE REGISTRO_CAPACITACIONES (
    id_capacitacion INT NOT NULL,
    id_colaborador VARCHAR(12) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado ENUM('APROBADO', 'REPROBADO', 'NO_REALIZADO'),
    numero_llamado INT,
    observaciones VARCHAR(200),
    CONSTRAINT FK_COLABORADOR_REGISTRO_CAPACITACIONES FOREIGN KEY (id_colaborador) REFERENCES COLABORADORES (id_colaborador),
    CONSTRAINT FK_CAPACITACION_REGISTRO_CAPACITACIONES FOREIGN KEY (id_capacitacion) REFERENCES CAPACITACIONES (id_capacitacion)
);

-- TABLA QUE REGISTRA LAS EVALUACIONES DE DESEMPEÑO HECHAS A LOS COLABORADORES AÑO TRAS AÑO, REGISTRO HISTORICO DE EVALUACIONES DE DESEMPEÑO
DROP TABLE IF exists DESEMPENO;
CREATE TABLE DESEMPENO (
id_desempeno INT auto_increment,
id_colaborador VARCHAR(12) NOT NULL,
periodo_evaluacion DATE NOT NULL,
calificacion_desempeno decimal(5,2) NOT NULL,
categoria_desempeno ENUM('BAJO_DESEMPENO', 'NECESIDADES_DE_MEJORA', 'TRABAJO_BIEN_HECHO', 'DESEMPENO_DESTACADO'),
conformidad_colaborador ENUM('SI', 'NO'),
evaluacion_publicada ENUM('SI', 'NO'),
plan_de_mejora ENUM('SI', 'NO'),
observaciones VARCHAR(200),
 CONSTRAINT PK_DESEMPENO PRIMARY KEY (id_desempeno),
 CONSTRAINT FK_COLABORADOR_DESEMPENO FOREIGN KEY (id_colaborador) REFERENCES COLABORADORES(id_colaborador)
);

-- TABLA QUE REGISTRA LAS VACANTES O PROCESOS DE SELECCION INTERNOS (MOVILIDADES/CONCURSOS)
DROP TABLE IF EXISTS VACANTES_INTERNAS;
CREATE TABLE VACANTES_INTERNAS (
    id_proceso INT,
    codigo_cargo INT NOT NULL,
    tipo_movilidad ENUM ('MOVILIDAD_DIRIGIDA', 'CONCURSO'),
    fecha_apertura DATE,
    fecha_publicacion DATE,
    fecha_cierre DATE,
    estado ENUM('VIGENTE', 'CERRADA'),
    CONSTRAINT PK_VACANTES_INTERNAS PRIMARY KEY (id_proceso)
);



-- TABLA QUE REGISTRA LAS POSTULACIONES POR PARTE DE LOS COLABORADORES A LOS PROCESOS DE MOVILIDAD
DROP TABLE IF EXISTS POSTULACIONES_MOVILIDADES;
CREATE TABLE POSTULACIONES_MOVILIDADES (
    id_postulacion INT,
    id_proceso INT NOT NULL,
	id_colaborador VARCHAR(12) NOT NULL,
	fecha_postulacion DATE,
	direccion_movimiento ENUM ('VERTICAL', 'HORIZONTAL'),
    ultima_etapa ENUM ('FILTRO_REQUISITOS', 'EVALUACION', 'FINALISTA','SELECCIONADO/A') NOT NULL,
    CONSTRAINT PK_POSTULACIONES_MOVILIDADES PRIMARY KEY (id_postulacion),
    CONSTRAINT FK_COLABORADOR_POSTULACIONES_MOVILIDADES FOREIGN KEY (id_colaborador) REFERENCES COLABORADORES (id_colaborador),
    CONSTRAINT FK_VACANTES_INTERNAS_POSTULACIONES_MOVILIDADES FOREIGN KEY (id_proceso) REFERENCES VACANTES_INTERNAS (id_proceso)
);


-- TABLA QUE REGISTRA LOS MOVIMIENTOS DE CARGOS DE LOS COLABORADORES
DROP TABLE IF EXISTS DESARROLLO_PROFESIONAL;
CREATE TABLE DESARROLLO_PROFESIONAL (
    id_desarrollo INT AUTO_INCREMENT,
    id_proceso INT,
    id_colaborador VARCHAR(12),
    codigo_cargo_anterior INT NOT NULL,
    codigo_nuevo_cargo INT NOT NULL,
    fecha_movilidad DATE NOT NULL,
    id_postulacion INT,
    CONSTRAINT PK_DESARROLLO PRIMARY KEY (id_desarrollo),
    CONSTRAINT FK_COLABORADOR_DESARROLLO FOREIGN KEY (id_colaborador) REFERENCES COLABORADORES (id_colaborador),
    CONSTRAINT FK_COLABORADOR_POSTULACIONES FOREIGN KEY (id_postulacion) REFERENCES POSTULACIONES_MOVILIDADES (id_postulacion)
);


-- TABLA QUE REGISTRA LOS BENEFICIOS QUE HAN UTILIZADO LOS COLABORADORES QUE TIENEN QUE VER CON SU DESARROLLO PRROFESIONAL
DROP TABLE IF EXISTS REGISTRO_BENEFICIOS;
CREATE TABLE REGISTRO_BENEFICIOS (
    id_beneficio INT AUTO_INCREMENT,
    detalle_beneficio VARCHAR(100) NOT NULL,
    categoria_beneficio ENUM ('BECA', 'CURSOS_PLAN_GERENCIA'),
    id_colaborador VARCHAR(12) NOT NULL,
    fecha_otorgamiento DATE,
    fecha_inicio DATE,
	fecha_fin DATE,
    resultado  ENUM ('EN CURSO', 'APROBADO','REPROBADO', 'DESISTE'),
    observaciones VARCHAR(200),
    CONSTRAINT PK_REGISTRO_BENEFICIOS PRIMARY KEY (id_beneficio),
    CONSTRAINT FK_REGISTRO_BENEFICIOS_COLABORADORES FOREIGN KEY (id_colaborador) REFERENCES COLABORADORES (id_colaborador)
);


INSERT INTO  ESTRUCTURA_ORGANIZACIONAL (id_estructura, id_area, area, id_subgerencia, subgerencia, id_gerencia, gerencia, id_filial, filial)
VALUES
(1, 5,  'Marketing', 4, 'Subgerencia de Marketing', 3, 'Recursos Humanos', 1, 'A'),
(2, 8, 'Afiliaciones', 14, 'Subgerencia Afiliacion Trabajadores', 1, 'Red Comercial', 2, 'A'),
(3, 16, 'Compras', 23, 'Subgerencia de Compras', 2, 'Administracion', 2, 'C'),
(4, 10, 'Remuneraciones', 9, 'Subgerencia de Compensaciones', 3, 'Recursos Humanos', 1, 'A'),
(5, 4, 'Calidad de Vida', 8, 'Subgerencia de Compensaciones', 3, 'Recursos Humanos', 1, 'A'),
(6, 13, 'Pagos', 20, 'Subgerencia de Finanzas', 2, 'Administracion', 2, 'C'),
(7, 2, 'General', 2, 'Gerencia', 3, 'Gerencia General', 3, 'C'),
(8, 15, 'Mantenimiento', 22, 'Subgerencia de Infraestructura', 2, 'Administracion', 2, 'C')
;


INSERT INTO CARGOS (codigo_cargo, cargo, id_estructura, rol, familia_cargo, nivel_cargo, personas_a_cargo, cargo_comercial, region_comercial )
VALUES 
                    ( 132, 'Analista de Marketing', 1, 'PRIVADO', 'PROFESIONALES', 11, 'NO', 'NO', NULL),   
					( 451, 'Gerente Comercial', 7, 'PRIVADO', 'GERENCIA', 16, 'SI', 'SI', 'RM_NORTE'),
					( 124, 'Asistente Administrativo', 3, 'GENERAL', 'ADMINISTRATIVO', 9, 'NO', 'NO', NULL),
                    ( 527, 'Especialista en RRHH', 5, 'PRIVADO', 'PROFESIONALES', 13, 'NO', 'NO', NULL),
					( 435, 'Analista de Finanzas', 6, 'PRIVADO', 'PROFESIONALES', 12, 'NO', 'NO', NULL),
                    ( 826, 'Secretaria',  8, 'GENERAL', 'ADMINISTRATIVO', 9, 'NO', 'NO', NULL),
                    ( 345, 'Analista de Remuneraciones', 4, 'PRIVADO', 'PROFESIONALES', 14, 'NO', 'NO', 'AUSTRAL'),
                    ( 257, 'Analista de Compras', 6, 'PRIVADO', 'PROFESIONALES', 14, 'NO', 'NO', 'AUSTRAL')
;


-- SE INSERTAN LOS DATOS EN CADA UNA DE LAS TABLAS
INSERT INTO COLABORADORES (id_colaborador, nombres_colaborador, apellidos_colaborador, fecha_de_nacimiento, sexo, fecha_ingreso, email_colaborador, direccion_colaborador, telefono_colaborador, codigo_cargo, id_jefatura, sucursal, id_estructura, nivel_jerarquico, tipo_contrato, plazo_contrato, modalidad_jornada, nivel_academico, cant_hijos, estado_civil)
VALUES 
('05.752.658-5', 'Juan Eduardo', 'Perez Lopez', '1975-05-15', 'M', '2020-06-20', 'juan.perez@email.com', 'Calle 123', '123456789', 451, '13.568.125-5', 'Sucursal A', 1, 'GERENCIA', 'INDEFINIDO', 0, 'PRESENCIAL', 'UNIVERSITARIO', 2, 'CASADO/A'),
('12.345.678-9', 'Maria Soledad', 'Gomez Figueroa', '1980-09-20', 'F', '2018-03-10', 'maria.gomez@email.com', 'Avenida 456', '987654321', 132, '23.456.784-4', 'Sucursal B', 2, 'AREA', 'INDEFINIDO', 0, 'PRESENCIAL', 'TECNICO', 0, 'SOLTERO/A'),
('18.765.432-1', 'Pedro Luis', 'Martinez Suarez', '1975-12-12', 'M', '2017-01-05', 'pedro.martinez@email.com', 'Carrera 789', '456789123', 124, '06.785.975-5','Sucursal C', 3, 'AREA', 'PLAZO_FIJO', 1, 'PRESENCIAL', 'TECNICO', 1, 'CASADO/A'),
('10.987.654-3', 'Ana Maria', 'Lopez Acevedo', '1977-08-25', 'F', '2016-09-18', 'ana.lopez@email.com', 'Pasaje 234', '789123456', 527, '16.745.842-6','Sucursal A', 3, 'AREA','INDEFINIDO', 4,  'PRESENCIAL', 'UNIVERSITARIO', 2, 'CASADO/A'),
('11.234.567-7', 'Carlos Raul', 'Sanchez Olivares', '1975-03-10', 'M', '2019-11-30', 'carlos.sanchez@email.com', 'Plaza 567', '987654321', 435, '19.215.125-6','Sucursal B', 2, 'AREA','PLAZO_FIJO', 5, 'PRESENCIAL', 'UNIVERSITARIO', 0, 'SOLTERO/A'),
('13.456.789-0', 'Laura Elena', 'Rodriguez Linares', '1973-07-02', 'F', '2020-02-15', 'laura.rodriguez@email.com', 'Callejon 890', '654987321', 826, '08.785.451-1','Sucursal C', 2, 'AREA', 'PLAZO_FIJO', 6,  'TELETRABAJO_PARCIAL', 'UNIVERSITARIO', 0, 'SOLTERO/A'),
('19.876.543-2', 'Roberto Carlos', 'Hernandez Jimenez', '1978-01-30', 'M', '2017-05-12', 'roberto.hernandez@email.com', 'Calle Mayor 123', '159357486', 257, '05.547.652-5', 'Sucursal A', 1,  'AREA','INDEFINIDO', 7,  'PRESENCIAL', 'TECNICO', 2, 'CASADO/A'),
('20.123.456-4', 'Luisa Cristina', 'Garcia Ramirez', '1972-11-18', 'F', '2018-08-03', 'luisa.garcia@email.com', 'Avenida Central 456', '258741369', 345, '14.547.120-8', 'Sucursal B', 3, 'AREA','PLAZO_FIJO', 8,  'TELETRABAJO_TOTAL', 'TECNICO', 1, 'CASADO/A')
;

SELECT codigo_cargo FROM CARGOS;
SELECT id_estructura FROM ESTRUCTURA_ORGANIZACIONAL;
SELECT * FROM COLABORADORES; 


INSERT INTO CAPACITACIONES (id_capacitacion, nombre_capacitacion, dirigido_a, hrs_capacitacion, tipo_capacitacion, tipo_malla,  plataforma, nombre_institucion)
VALUES 
                    ( 1, 'INDUCCION CORPORATIVA', NULL, 1.5, 'INTERNA', 'TRANSVERSAL', 'PORTAL_FORMACION_LH', 'LH'),   
					( 2, 'ATENCION AL CLIENTE', NULL, 2, 'INTERNA', 'VENTA_Y_SERVICIO_AL_CLIENTE', 'PORTAL_FORMACION_LH', 'LH'),
					( 3, 'ODI', NULL, 1, 'INTERNA',   'NORMATIVA', 'PORTAL_ACHS', 'LH'),
					( 4, 'RIESGO', NULL,  1, 'INTERNA', 'NORMATIVA', 'PORTAL_FORMACION_LH', 'LH'), 
					( 5, 'EXCEL', NULL, 8.5, 'INTERNA',   'TECNICA', 'PORTAL_FORMACION_LH', 'LH'),
					( 6, 'EQUIDAD', NULL, 2.5, 'INTERNA',  'DEI', 'PORTAL_FORMACION_LH', 'LH'),
					( 7, 'SEGUROS', NULL,  2, 'INTERNA',  'VENTA_Y_SERVICIO_AL_CLIENTE', 'PORTAL_FORMACION_LH', 'LH'),
					( 8, 'CREDITOS', NULL, 2, 'INTERNA',  'VENTA_Y_SERVICIO_AL_CLIENTE', 'PORTAL_FORMACION_LH', 'LH')					
;

SELECT id_capacitacion FROM CAPACITACIONES WHERE id_capacitacion IN (1, 3, 5, 6, 7);
SELECT id_colaborador FROM COLABORADORES WHERE id_colaborador IN ('05.752.658-5', '13.456.789-0', '18.765.432-1', '12.345.678-9', '20.123.456-4', '10.987.654-3', '19.876.543-2');

INSERT INTO CAPACITACIONES_CARGOS ( id_capacitacion, codigo_cargo)
VALUES
(1, 132),
(1, 451),
(1, 124),
(1, 527),
(1, 826),
(1, 345),
(2 , 826),
(2 , 451),
(3 , 257),
(3 , 345),
(3 , 826),
(3 , 435),
(3 , 124),
(3 , 451),
(3 , 132),
(4 , 451),
(5 , 132),
(5 , 435),
(5 , 257),
(6 , 451),
(6 , 527),
(7, 132),
(7 , 451),
(8 , 132),
(8 , 451)
;

SELECT * FROM CAPACITACIONES_CARGOS;

INSERT INTO REGISTRO_CAPACITACIONES ( id_capacitacion, id_colaborador, fecha_inicio, fecha_fin, estado, numero_llamado, observaciones)
VALUES 
                    ( 1, '05.752.658-5', '2024-01-01', '2024-02-01', 'NO_REALIZADO', 1, NULL),   
					( 1, '13.456.789-0', '2024-03-01', '2024-03-27', 'APROBADO', 2, NULL),
					( 3, '18.765.432-1', '2024-02-15', '2024-03-03', 'APROBADO', 1, NULL),
					( 5, '12.345.678-9', '2024-03-24', '2024-04-15', 'REPROBADO', 3, NULL), 
					( 5, '20.123.456-4', '2024-04-16', '2024-04-30', 'APROBADO', 1, NULL),
					( 6, '10.987.654-3', '2024-05-08', '2024-05-28', 'APROBADO', 2, NULL),
					( 7, '05.752.658-5', '2024-06-01', '2024-06-16', 'NO_REALIZADO', 3, NULL),
					(7, '19.876.543-2', '2024-06-10', '2024-06-27', 'REPROBADO', 3, NULL)	
;

INSERT INTO DESEMPENO (id_desempeno, id_colaborador, periodo_evaluacion, calificacion_desempeno, categoria_desempeno, conformidad_colaborador, evaluacion_publicada, plan_de_mejora, observaciones)
VALUES 
                    ( 1, '05.752.658-5', '2023-01-01', 4, 'DESEMPENO_DESTACADO', 'SI', 'NO', 'NO', NULL),   
					( 2, '13.456.789-0', '2021-01-01', 3.17,'TRABAJO_BIEN_HECHO', 'SI', 'SI', 'SI', 'Se sugiere curso de excel avanzado para agilizar algunas de sus labores'),
					( 3, '18.765.432-1', '2023-01-01', 2.6, 'NECESIDADES_DE_MEJORA', 'NO','SI', 'SI', 'Se recomienda ajustarse a los plazos de entrega establecidos, se propone agenda automatizada como apoyo'),
					( 4, '12.345.678-9', '2022-01-01', 1.5, 'BAJO_DESEMPENO', 'NO', 'SI', 'SI', null ), 
					( 5, '20.123.456-4', '2023-01-01', 3.88, 'DESEMPENO_DESTACADO', 'SI', 'SI', 'NO', NULL),
					( 6, '10.987.654-3', '2022-01-01', 2.9, 'TRABAJO_BIEN_HECHO', 'NO', 'SI', 'NO', NULL),
					( 7, '05.752.658-5', '2023-01-01', 3.1, 'TRABAJO_BIEN_HECHO', 'SI', 'SI', 'NO', NULL),
					( 8, '19.876.543-2', '2022-01-01', 2.2, 'BAJO_DESEMPENO', 'NO', 'SI', 'SI', NULL)					
;


INSERT INTO VACANTES_INTERNAS (id_proceso, codigo_cargo, tipo_movilidad, fecha_apertura, fecha_publicacion, fecha_cierre, estado)
VALUES 
                    ( 2156,  132, 'CONCURSO', '2023-01-01', '2023-02-01', '2023-01-03', 'CERRADA' ),   
					( 2172,  451, 'MOVILIDAD_DIRIGIDA', '2023-03-01', '2023-03-05', NULL,  'CERRADA'),
					( 2245,  124, 'MOVILIDAD_DIRIGIDA', '2023-04-10', '2023-04-15', NULL, 'CERRADA'),
                    ( 2250,  527, 'CONCURSO', '2023-01-01', NULL, '2023-01-06', 'VIGENTE'),
					( 2196,  435, 'CONCURSO', '2023-01-01', '2023-05-05', '2023-05-29', 'CERRADA'),
                    ( 2206,  345, 'CONCURSO', '2024-05-03', '2024-05-10', NULL, 'VIGENTE' ),
                    ( 2210,  517, 'MOVILIDAD_DIRIGIDA', '2024-06-01', NULL, '2024-06-10', 'CERRADA'),
                    ( 2211,  257, 'CONCURSO', '2024-07-01', '2024-07-10', NULL, 'VIGENTE')
                   ;


INSERT INTO POSTULACIONES_MOVILIDADES (id_postulacion, id_proceso, id_colaborador, fecha_postulacion, direccion_movimiento, ultima_etapa)
VALUES 
                    ( 1, 2156, '18.765.432-1', '2023-01-18', 'VERTICAL', 'FILTRO_REQUISITOS'),   
					( 2, 2156,  '13.456.789-0', '2023-01-13', 'VERTICAL', 'EVALUACION' ),   
					( 3, 2156, '12.345.678-9', '2023-01-10', 'VERTICAL', 'SELECCIONADO/A'),   
					( 4, 2250,'18.765.432-1',  '2023-01-20', 'VERTICAL', 'FILTRO_REQUISITOS'),
                    ( 5, 2250, '12.345.678-9',  '2023-01-26', 'VERTICAL', 'EVALUACION' ),
					( 6, 2211, '05.752.658-5',  '2024-07-12', 'VERTICAL', 'FILTRO_REQUISITOS'),
					( 7, 2211, '18.765.432-1',  '2024-07-11', 'VERTICAL', 'FILTRO_REQUISITOS'),
					( 8, 2211, '12.345.678-9',  '2024-07-10', 'VERTICAL', 'EVALUACION' )
;


INSERT INTO REGISTRO_BENEFICIOS (id_beneficio, detalle_beneficio, categoria_beneficio, id_colaborador, fecha_otorgamiento, fecha_inicio, fecha_fin, resultado, observaciones )
VALUES 
                    ( 1, 'Diplomado en Compensaciones', 'BECA', '18.765.432-1', '2023-01-01', '2023-01-18', '2023-06-30', 'REPROBADO', NULL ),   
					( 2, 'Curso Ingles',  'CURSOS_PLAN_GERENCIA', '05.752.658-5','2022-06-01', '2022-07-01', '2022-12-31', 'DESISTE', 'No puede culminar por enfermedad'),   
					( 3, 'Curso Data Science', 'CURSOS_PLAN_GERENCIA', '12.345.678-9', '2023-08-01', '2023-10-01', '2023-10-25', 'APROBADO', null),   
					( 4, 'Diplomado en Remuneraciones', 'BECA', '20.123.456-4', '2024-02-01', '2024-04-01', '2024-10-29', 'APROBADO', null),
                    ( 5, 'Ingenieria Comercial', 'BECA', '11.234.567-7', '2024-02-01', '2024-04-01', '2024-10-29', 'APROBADO', null),
                    ( 6, 'Ingenieria en Recursos Humanos', 'BECA', '05.752.658-5', '2024-02-01', '2024-04-01', '2024-10-29', 'APROBADO', null),
                    ( 7, 'Power_BI', 'CURSOS_PLAN_GERENCIA', '10.987.654-3', '2024-05-01', '2024-06-01', '2024-07-01', 'APROBADO', null),
                    ( 8, 'Diplomado en Analisis de Datos', 'BECA', '13.456.789-0', '2024-05-06', '2024-06-05', '2024-10-29', 'EN CURSO', null)
;

  -- SE CREA TABLA PARA EXTRAER UN SOLO REGISTRO POR COLABORADOR CON LA MAYOR CALIFICACION OBTENIDA (GENERADA EN EL PROCEDIMIENTO 2)
DROP TABLE IF EXISTS REGISTRO_CAPACITACIONES_MAX_CALIFICACION;
CREATE TABLE REGISTRO_CAPACITACIONES_MAX_CALIFICACION (
    id_capacitacion INT NOT NULL,
    id_colaborador VARCHAR(12) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado ENUM('APROBADO', 'REPROBADO', 'NO_REALIZADO'),
    numero_llamado INT,
    observaciones VARCHAR(200),
    CONSTRAINT PK_REGISTRO_CAPACITACIONES_MAX_CALIFICACION PRIMARY KEY (id_capacitacion, id_colaborador)
);


ALTER TABLE REGISTRO_CAPACITACIONES
MODIFY COLUMN fecha_inicio DATE NULL,
MODIFY COLUMN fecha_fin DATE NULL;

ALTER TABLE REGISTRO_CAPACITACIONES
MODIFY COLUMN estado ENUM('APROBADO', 'REPROBADO', 'NO_REALIZADO', 'PENDIENTE INSCRIBIR');