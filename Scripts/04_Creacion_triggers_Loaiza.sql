USE GESTIONPERSONASLOAIZA;

-- CREACION DE TRIGGERS

-- TRIGGER 1 INSERTAR EN LA TABLA REGISTRO_CAPACITACIONES A LOS NUEVOS INGRESOS ASIGNADOLE UN ESTADO DE 'PENDIENTE POR INSCRIBIR',  CON LOS CURSOS QUE LE CORRESPONDAN SEGUN SU CARGO
DELIMITER //

CREATE TRIGGER trg_insertar_en_registro_capacitaciones
AFTER INSERT ON COLABORADORES
FOR EACH ROW
BEGIN
    -- Insertar en REGISTRO_CAPACITACIONES todos los cursos correspondientes al cargo del nuevo colaborador
    INSERT INTO REGISTRO_CAPACITACIONES (id_capacitacion, id_colaborador, fecha_inicio, fecha_fin, estado)
    SELECT c.id_capacitacion, NEW.id_colaborador, NULL, NULL, 'PENDIENTE INSCRIBIR'
    FROM CAPACITACIONES_CARGOS cc
    JOIN CAPACITACIONES c ON cc.id_capacitacion = c.id_capacitacion
    WHERE cc.codigo_cargo = NEW.codigo_cargo;
END //

DELIMITER ;



-- TRIGGER 2 ELIMINAR REGISTROS QUE TENGAN ESTADO 'PENDIENTE POR INSCIBIR' CUANDO SE ACTUALIZA LA INSCRIPCION REAL DEL COLABORADOR EN EL REGISTRO CAPACITACIONES

DELIMITER //

CREATE TRIGGER trg_eliminar_pendiente_inscribir
AFTER  UPDATE ON REGISTRO_CAPACITACIONES
FOR EACH ROW
BEGIN
    -- Elimina registros de estado 'PENDIENTE INSCRIBIR' cuando se actualiza con una fecha de inicio
    IF NEW.fecha_inicio IS NOT NULL AND OLD.estado = 'PENDIENTE INSCRIBIR' THEN
        DELETE FROM REGISTRO_CAPACITACIONES
        WHERE id_colaborador = OLD.id_colaborador
        AND id_capacitacion = OLD.id_capacitacion
        AND estado = 'PENDIENTE INSCRIBIR';
    END IF;
END //

DELIMITER ;

-- PRUEBA DE LOS TRIGGERS

INSERT INTO COLABORADORES (id_colaborador, nombres_colaborador, apellidos_colaborador, fecha_de_nacimiento, sexo, fecha_ingreso, email_colaborador, direccion_colaborador, telefono_colaborador, codigo_cargo, id_jefatura, sucursal, id_estructura, nivel_jerarquico, tipo_contrato, plazo_contrato, modalidad_jornada, nivel_academico, cant_hijos, estado_civil)
VALUES
 ('25.451.854-4', 'Elias Andres', 'Hernandez Loaiza', '1985-05-31', 'M', '2022-09-16', 'elias.hernandez@email.com', 'Blanco Viel 1111', '258757896', 435, '19.215.125-6','Sucursal B', 2, 'AREA','INDEFINIDO', 0, 'TELETRABAJO_TOTAL', 'UNIVERSITARIO', 0, 'SOLTERO/A');

SELECT * FROM registro_capacitaciones;




