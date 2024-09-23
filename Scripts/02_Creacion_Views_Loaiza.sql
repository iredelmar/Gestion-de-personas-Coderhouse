USE GESTIONPERSONASLOAIZA;

-- SE CREAN LAS  VISTAS PARA EL ESQUEMA GESTIONPERSONASLOAIZA

-- VISTA 1. PERMITE CONSULTAR LAS CAPACITACIONES QUE LE CORRESPONDEN A CADA CARGO, ESTO FACILITA LA INSCRIPCION DE CURSOS A LOS NUEVOS INGRESOS, INDICANDO LOS CODIGOS DE LOS CARGOS, ARROJA LAS CAPACITACIONES QUE LE CORRESPONDEN 
CREATE VIEW VW_CAPACITACIONES_POR_CARGOS AS
SELECT 
    c.codigo_cargo,
    c.cargo,
    cp.id_capacitacion,
    cp.nombre_capacitacion
FROM 
    CARGOS AS c
JOIN 
    CAPACITACIONES_CARGOS AS cc ON c.codigo_cargo = cc.codigo_cargo
JOIN 
    CAPACITACIONES AS cp ON cc.id_capacitacion = cp.id_capacitacion;
    
-- CONSULTA: 
SELECT * FROM VW_CAPACITACIONES_POR_CARGOS
WHERE codigo_cargo IN (132, 451, 124); 

-- VISTA 2 MUESTRA EL ESTATUS DEL CUMPLIMIENTO DE LAS CAPACITACIONES NORMATIVAS POR DETERMINADO GRUPO DE PERSONAS
CREATE VIEW VW_CUMPLIMIENTO_CAPACITACIONES_NORMATIVAS AS
SELECT
    c.id_colaborador,
    MAX(CASE WHEN cap.nombre_capacitacion = 'ODI' THEN rc.estado END) AS ODI_estado,
    MAX(CASE WHEN cap.nombre_capacitacion = 'RIESGO' THEN rc.estado END) AS RIESGO_estado
FROM
    COLABORADORES AS c
    JOIN REGISTRO_CAPACITACIONES AS rc ON c.id_colaborador = rc.id_colaborador
    JOIN CAPACITACIONES AS cap ON rc.id_capacitacion = cap.id_capacitacion
WHERE
    cap.tipo_malla = 'NORMATIVA'
GROUP BY
    c.id_colaborador;
    
    -- CONSULTA: 
    SELECT * FROM VW_CUMPLIMIENTO_CAPACITACIONES_NORMATIVAS
    WHERE id_colaborador IN ('13.456.789-0', '18.765.432-1');
    
-- VISTA 3 MUESTRA LAS EVALUACIONES DE DESEMPEÑO DE UNA O VARIAS PERSONAS
CREATE VIEW VW_DESEMPENO AS
SELECT
    c.id_colaborador,
    c.nombres_colaborador,
    c.apellidos_colaborador,
    e.periodo_evaluacion,
    e.calificacion_desempeno,
    e.categoria_desempeno,
    e.conformidad_colaborador,
    e.evaluacion_publicada, 
    e.plan_de_mejora,
    e.observaciones
FROM
    COLABORADORES AS c
    LEFT JOIN DESEMPENO e ON c.id_colaborador = e.id_colaborador;
    
    -- CONSULTA:
SELECT * FROM VW_DESEMPENO
WHERE id_colaborador = '19.876.543-2';

-- VISTA 4 PERMITE CONSULTAR SI UNA PERSONA HA OBTENIDO HISTORICAMENTE BECAS U OTROS BENEFICIOS EDUCATIVOS
CREATE VIEW VW_BENEFICIOS_COLABORADOR AS
SELECT
    r.id_colaborador,
    c.nombres_colaborador,
    c.apellidos_colaborador,
    c.codigo_cargo,
    ca.cargo AS nombre_cargo,
    e.gerencia AS nombre_gerencia,
    r.id_beneficio,
    r.detalle_beneficio,
    r.categoria_beneficio,
    r.fecha_otorgamiento,
    r.resultado,
    r.observaciones
FROM
  REGISTRO_BENEFICIOS r
    JOIN COLABORADORES AS c ON r.id_colaborador = c.id_colaborador
    JOIN CARGOS AS ca ON c.codigo_cargo = ca.codigo_cargo
    JOIN ESTRUCTURA_ORGANIZACIONAL AS e ON ca.id_estructura = e.id_estructura;
    
 -- CONSULTA: 
SELECT * FROM VW_BENEFICIOS_COLABORADOR
WHERE id_colaborador = '05.752.658-5';

-- VISTA 5 PERMITE VER SI UN COLABORADOR HA POSTULADO A PROCESOS DE MOVILIDADES
CREATE VIEW VW_POSTULACIONES AS
SELECT
    p.id_colaborador,
    c.nombres_colaborador,
    c.apellidos_colaborador,
    car.cargo AS nombre_cargo,
    e.subgerencia AS nombre_subgerencia,
    e.gerencia AS nombre_gerencia,
    v.id_proceso,
    v.codigo_cargo,
    v.fecha_cierre,
    v.estado AS estado_proceso,
    p.fecha_postulacion,
    p.ultima_etapa
FROM
    POSTULACIONES_MOVILIDADES AS p
    JOIN VACANTES_INTERNAS AS v ON p.id_proceso = v.id_proceso
    JOIN COLABORADORES AS c ON p.id_colaborador = c.id_colaborador
    JOIN CARGOS AS car ON c.codigo_cargo = car.codigo_cargo
    JOIN ESTRUCTURA_ORGANIZACIONAL AS e ON car.id_estructura = e.id_estructura;
    
    -- CONSULTA
SELECT * FROM VW_POSTULACIONES
WHERE id_colaborador = '12.345.678-9';

-- VISTA 6 CONSULTA PROMEDIO DE HORAS DE CAPACITACION POR SEXO Y POR GERENCIA
DROP VIEW IF EXISTS VW_PROM_HRS_GCIA_POR_SEXO;
CREATE VIEW VW_PROM_HRS_GCIA_POR_SEX AS
SELECT
    e.gerencia,
    c.sexo,
    ROUND(AVG(cp.hrs_capacitacion), 1) AS promedio_horas
FROM
    COLABORADORES AS c
JOIN
    REGISTRO_CAPACITACIONES rc ON c.id_colaborador = rc.id_colaborador
JOIN
    CAPACITACIONES AS cp ON rc.id_capacitacion = cp.id_capacitacion
JOIN
    CARGOS AS ca ON c.codigo_cargo = ca.codigo_cargo
JOIN
    ESTRUCTURA_ORGANIZACIONAL AS e ON ca.id_estructura = e.id_estructura
WHERE
    cp.tipo_malla = 'NORMATIVA'
GROUP BY
    e.gerencia,
    c.sexo;
    
    -- CONSULTA
    SELECT * FROM VW_PROM_HRS_GCIA_POR_SEX;
    
    
    -- VISTA 7   MUESTRA LOS COLABORADORES QUE TIENEN CAPACITACIONES PENDIENTES POR INSCRIBIR 
CREATE VIEW VW_PENDIENTES_POR_INSCRIBIR AS
SELECT
    rc.id_colaborador,
	col.nombres_colaborador,
    col.apellidos_colaborador,
	c.id_capacitacion,
    c.nombre_capacitacion,  
    rc.estado
FROM
    REGISTRO_CAPACITACIONES AS rc
JOIN
    CAPACITACIONES AS c ON rc.id_capacitacion = c.id_capacitacion
    
WHERE
    rc.estado = 'PENDIENTE INSCRIBIR';
    
SELECT * FROM VW_PENDIENTES_POR_INSCRIBIR;