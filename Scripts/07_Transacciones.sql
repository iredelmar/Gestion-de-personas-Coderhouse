-- TCL LOAIZA

-- TCL SOBRE PRIMERA TABLA:
START TRANSACTION;

DELETE FROM postulaciones_movilidades
WHERE id_postulacion IN (1, 2);

-- ROLLBACK;
-- COMMIT;

DESCRIBE estructura_organizacional;

-- TCL SOBRE SEGUNDA TABLA:
START TRANSACTION;

INSERT INTO estructura_organizacional (id_estructura, id_area, area, id_subgerencia, subgerencia, id_gerencia, gerencia, id_filial, filial)
VALUES
(16, 31, 'Recursos Humanos', 201, 'Subgerencia de Reclutamiento', 1, 'Gerencia de Desarrollo Organizacional', 1, 'A'),
(17, 52, 'Finanzas', 202, 'Subgerencia de Contabilidad', 2, 'Gerencia de Finanzas Corporativas', 2, 'B'),
(18, 63, 'Marketing', 203, 'Subgerencia de Publicidad', 3, 'Gerencia de Estrategia Comercial', 3, 'C'),
(19, 74, 'Operaciones', 204, 'Subgerencia de Logística', 4, 'Gerencia de Operaciones', 4, 'A');

SAVEPOINT primer_savepoint;


INSERT INTO estructura_organizacional (id_estructura, id_area, area, id_subgerencia, subgerencia, id_gerencia, gerencia, id_filial, filial)
VALUES 
(20, 85, 'Tecnología de la Información', 5, 'Subgerencia de Infraestructura TI', 5, 'Gerencia de Tecnología y Sistemas', 5, 'A'),
(21, 96, 'Ventas', 6, 'Subgerencia de Ventas Regionales', 6, 'Gerencia de Ventas y Distribución', 6, 'B'),
(22, 107, 'Legal', 7, 'Subgerencia de Asesoría Jurídica', 7, 'Gerencia de Cumplimiento Legal', 7, 'C'),
(23, 208, 'Atención al Cliente', 8, 'Subgerencia de Soporte y Servicio', 8, 'Gerencia de Experiencia del Cliente', 8, 'A');

SAVEPOINT segundo_savepoint;

-- ROLLBACK TO SAVEPOINT primer_savepoint;
-- RELEASE SAVEPOINT primer_savepoint;
-- RELEASE SAVEPOINT segundo_savepoint;
-- COMMIT;