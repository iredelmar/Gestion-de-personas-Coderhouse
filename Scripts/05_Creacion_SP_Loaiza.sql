USE GESTIONPERSONASLOAIZA;
-- CREACION DE DOS PROCEDIMIENTOS

-- PROCEDIMIENTO 1. OBTIENE EL NUMERO DE CAPACITACIONES DICTADAS EN UN RANGO DE TIEMPO Y SU ESTADO

DELIMITER //

CREATE PROCEDURE obtener_porcentaje_cumplimiento(
    IN fecha_inicio_param DATE,
    IN fecha_fin_param DATE
)
BEGIN
    -- Se calcula el porcentaje de cumplimiento de las capacitaciones
    SELECT
        c.id_capacitacion,
        c.nombre_capacitacion,
        COUNT(DISTINCT rc.id_colaborador) AS total_inscritos,
        SUM(CASE WHEN rc.estado = 'APROBADO' THEN 1 ELSE 0 END) AS total_aprobados,
        ROUND(
            (SUM(CASE WHEN rc.estado = 'APROBADO' THEN 1 ELSE 0 END) / 
            COUNT(DISTINCT rc.id_colaborador)) * 100, 
            2
        ) AS porcentaje_cumplimiento
    FROM
        CAPACITACIONES c
    LEFT JOIN
        REGISTRO_CAPACITACIONES rc ON c.id_capacitacion = rc.id_capacitacion
    WHERE
        (rc.fecha_inicio BETWEEN fecha_inicio_param AND fecha_fin_param
        OR rc.fecha_fin BETWEEN fecha_inicio_param AND fecha_fin_param)
    GROUP BY
        c.id_capacitacion, c.nombre_capacitacion;
END //

DELIMITER ;

CALL obtener_porcentaje_cumplimiento('2024-01-01', '2024-06-30');



-- PROCEDIMIENTO 2 EXTRAE LOS REGISTROS DE CAPACITACIONES CON MAYOR PUNTUACION O MAS FAVORABLE UTILIZANDO EL CRITERIO DE MAS FAVORABLE APROBADO, LUEGO REPROBADO Y POR ULTIMO NO REALIZADO
DELIMITER //

CREATE PROCEDURE ExtraerCapacitacionesMaxCalificacion()
BEGIN
    -- Limpia la tabla de registros con la máxima calificación antes de insertar nuevos registros
    TRUNCATE TABLE REGISTRO_CAPACITACIONES_MAX_CALIFICACION;

    -- Se insertan los registros con la máxima calificación para cada capacitación y colaborador
    INSERT INTO REGISTRO_CAPACITACIONES_MAX_CALIFICACION (id_capacitacion, id_colaborador, fecha_inicio, fecha_fin, estado, numero_llamado, observaciones)
    SELECT 
        r.id_capacitacion, 
        r.id_colaborador, 
        r.fecha_inicio, 
        r.fecha_fin, 
        r.estado, 
        r.numero_llamado, 
        r.observaciones
    FROM 
        REGISTRO_CAPACITACIONES AS r
    INNER JOIN (
        SELECT 
            id_capacitacion, 
            id_colaborador,
            MAX(CASE 
                WHEN estado = 'APROBADO' THEN 3 
                WHEN estado = 'REPROBADO' THEN 2 
                ELSE 1 
            END) AS max_estado
        FROM 
            REGISTRO_CAPACITACIONES
        GROUP BY 
            id_capacitacion, 
            id_colaborador
    ) AS subquery
    ON r.id_capacitacion = subquery.id_capacitacion
    AND r.id_colaborador = subquery.id_colaborador
    AND (CASE 
            WHEN r.estado = 'APROBADO' THEN 3 
            WHEN r.estado = 'REPROBADO' THEN 2 
            ELSE 1 
        END) = subquery.max_estado;
END //

DELIMITER ;

-- ejecutar el procedimiento para actualizar la tabla REGISTRO_CAPACITACIONES_MAX_CALIFICACION
CALL ExtraerCapacitacionesMaxCalificacion();