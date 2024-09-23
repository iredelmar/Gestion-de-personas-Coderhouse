# Gestion-de-personas-Coderhouse
Proyecto Final Curso SQL Coderhouse

![Portada](/Portada_Proyecto_coder.png)

## Descripción
El objetivo de este proyecto es desarrollar un conjunto de consultas SQL que permitan a los
 gestores de recursos humanos acceder de manera eficiente a información crítica relacionada
 con la formación, promociones, beneficios educativos y evaluaciones de desempeño de los
 colaboradores. A través de estas consultas, se busca mejorar la capacidad de análisis y toma de
 decisiones estratégicas, apoyando el desarrollo profesional y el crecimiento continuo dentro de
 la organización.

 ## Contenido del Proyecto

Vistas: 
Nombre vw_capacitaciones_por_cargos
 Descripción Permite consultar las capacitaciones que le corresponden a cada cargo
 Objetivo Facilitar la inscripción de cursos a los nuevos ingresos, indicando los códigos de los
 cargos, arroja las capacitaciones que le corresponden

Nombre vw_cumplimiento_capacitaciones_normativas
 Descripción Muestra el estatus del cumplimiento de las capacitaciones normativas por
 determinado grupo de personas 
Objetivo Facilita verificar rápidamente el estatus de estas capacitaciones

 Nombre vw_desempeno
 Descripción Muestra las evaluaciones de desempeño de una o varias personas
 Objetivo Permite tener información a mano en caso de necesitar evaluar promociones o
 desvinculaciones

  Nombre vw_beneficios_colaborador
 Descripción Permite consultar si una persona ha obtenido históricamente becas u otros beneficios
 educativos
 Objetivo Facilita el acceso a un indicador fundamental para el desarrollo de carrera de los
 colaboradores

 Nombre vw_postulaciones
 Descripción Permite ver si un colaborador ha postulado a procesos de movilidades 
Objetivo
 Otorga la oportunidad de conocer intereses de carrera, adicionalmente es un
 indicador fundamental en el cumplimiento de la norma de equidad de género, que
 permite saber si hombres y mujeres tienen iguales oportunidades en procesos de
 promoción

  Nombre vw_prom_hrs_gcia_por_sex
 Descripción Consulta promedio de horas de capacitacion por sexo y por gerencia 
Objetivo Permite identificar si el acceso a las capacitaciones es equitativo para hombres y
 mujeres

  Nombre vw_pendientes_por_inscribir
 Descripción Muestra los colaboradores que tienen capacitaciones pendientes por inscribir 
Objetivo Permite identificar si existen colaboradores que hayan ingresado y no tengan
 asignada una o varias capacitaciones que le correspondan según su cargo

 Funciones:
 Nombre Promedio Horas
 Descripción: Calcula el promedio de horas de capacitación por gerencia
 Permite conocer la cantidad de horas de capacitación efectivamente cursadas por
 cada colaborador, lo que facilita la medición de sus kpis asociados a capacitación

 Nombre Promedio Horas por Sexo
  Descripción: Promedio de horas de capacitación por sexo en un rango de tiempo
  Permite identificar la cantidad de horas de capacitación dictadas en un rango de
 tiempo que permitirá medir los indicadores de equidad en capacitación, mensual,
 trimestral, semestral, etc

Procedimientos:
 Nombre: Calificación Máxima
 Descripción: Extrae la calificación máxima por capacitación
 Dentro de un listado de calificaciones del mismo curso, extrae los registros de
 capacitaciones con mayor puntuación o más favorable utilizando el criterio de más
 favorable en este orden: aprobado, luego reprobado y por último no realizado

 Nombre: Porcentaje de Cumplimiento
 Descripción:  Obtiene el numero de capacitaciones dictadas en un rango de tiempo y su estado
 Permite saber en un rango de tiempo como esta el avance de las capacitaciones
 planificadas a nivel empresa

Triggers:
 Nombre:  trg_insertar_en_registro_capacitaciones
 Descripción: Insertar en la tabla registro_capacitaciones a los nuevos ingresos y les asigna un
 estado de 'pendiente por inscribir', con los cursos que le correspondan según su cargo.
 Permite revisar que todos los colaboradores que ingresan a la empresa  tengan
 inscritos los cursos que le corresponden

Nombre:  trg_eliminar_pendiente_inscribir
Descripción Elimina del listado a los colaboradores que tengan estado 'pendiente por inscibir'
 Cuando se actualiza la inscripción real del colaborador en el registro capacitaciones,
 (que se detecta al ingresar la fecha de inicio del curso) 
 se eliminan los registros con estado   'pendiente por inscribir’


