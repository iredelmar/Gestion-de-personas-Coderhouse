USE GESTIONPERSONASLOAIZA;

-- CREACION DE DOS FUNCIONES

-- FUNCION 1. CALCULA EL PROMEDIO DE HRS DE CAPACITACION POR COLABORADOR
DELIMITER //

CREATE FUNCTION get_promedio_horas (p_id_colaborador VARCHAR(12))
RETURNS DECIMAL(5,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE promedio DECIMAL(5,2);

    SELECT IFNULL(AVG(c.hrs_capacitacion), 0.00)
    INTO promedio
    FROM REGISTRO_CAPACITACIONES rc
    JOIN CAPACITACIONES c ON rc.id_capacitacion = c.id_capacitacion
    WHERE rc.id_colaborador = p_id_colaborador;

    RETURN promedio;
END //

DELIMITER ;

-- USO DE LA FUNCIÓN
SELECT get_promedio_horas('18.765.432-1') AS promedio_horas;


-- FUNCION 2 PROMEDIO DE HRS DE CAPACITACION POR SEXO EN UN RANGO DE TIEMPO
DELIMITER $$

CREATE FUNCTION promedio_horas_por_sexo(
    sexo_param ENUM('F', 'M'),
    fecha_inicio DATE,
    fecha_fin DATE
) RETURNS DECIMAL(5,1)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(5,1);

    SELECT AVG(c.hrs_capacitacion) INTO promedio
    FROM REGISTRO_CAPACITACIONES rc
    JOIN COLABORADORES col ON rc.id_colaborador = col.id_colaborador
    JOIN CAPACITACIONES c ON rc.id_capacitacion = c.id_capacitacion
    WHERE col.sexo = sexo_param
      AND rc.fecha_inicio >= fecha_inicio
      AND rc.fecha_fin <= fecha_fin;
    
    RETURN promedio;
END$$

DELIMITER ;
