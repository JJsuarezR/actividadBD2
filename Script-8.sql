-- USE proyectos para trabajar en la base de datos correcta
USE proyectos;

-- Se usa Select para consultar en la tabla de docentes quienes tienen más experiencia y se limita a 3 resultados con el LIMIT 
SELECT docente_id AS id, nombres AS docente, anios_experiencia AS exp
FROM docente
ORDER BY exp DESC
LIMIT 3 OFFSET 0;

-- Se seleccionan los proyectos que están activos al especificar que la fecha_final es NULL
SELECT nombre FROM proyecto WHERE fecha_final IS NULL;
-- Se seleccionan los proyectos que tienen un presupuesto entre 30000 y 100000
SELECT nombre FROM proyecto WHERE presupuesto BETWEEN 30000 AND 100000;
-- Se seleccionan los docentes que tienen 2, 5 o 12 años de experiencia usando IN
SELECT nombres FROM docente WHERE anios_experiencia IN (2,5,12);
-- Trae la información de los proyectos junto con el nombre del docente que es jefe del proyecto usando INNER JOIN
SELECT p.proyecto_id, p.nombre AS proyecto, d.nombres AS jefe
FROM proyecto p
INNER JOIN docente d ON p.docente_id_jefe = d.docente_id;

-- selecciona los docentes y verifica la cantidad de proyectos que tienen asignados, en este caso los que tienen menos de 1 proyecto (0 proyectos)
SELECT d.nombres, COUNT(p.proyecto_id) AS proyectos
FROM docente d
LEFT JOIN proyecto p ON p.docente_id_jefe = d.docente_id
GROUP BY d.nombres
HAVING COUNT(p.proyecto_id) < 1;

-- Usa AVG para calcular el promedio de presupuesto de los proyectos y luego selecciona los proyectos que tienen un presupuesto mayor al promedio

SELECT p.proyecto_id, p.nombre, p.presupuesto
FROM proyecto p
WHERE p.presupuesto > (SELECT AVG(p2.presupuesto) FROM proyecto p2);

-- Se usa una subconsulta para obtener el presupuesto máximo de los proyectos junto a su docente, luego los ordena de mayor a menor con el ORDER BY
SELECT sub.nombres, sub.max_presupuesto
FROM (
  SELECT d.nombres, MAX(p.presupuesto) AS max_presupuesto
  FROM docente d LEFT JOIN proyecto p ON p.docente_id_jefe = d.docente_id
  GROUP BY d.nombres
) sub
ORDER BY sub.max_presupuesto DESC;
-- Consulta, usando el WHERE EXISTS, los docentes que tienen un proyecto activo, donde fecha_final es Null
SELECT d.nombres
FROM docente d
WHERE EXISTS (
  SELECT 1 FROM proyecto p
  WHERE p.docente_id_jefe = d.docente_id AND p.fecha_final IS NULL
);

-- Consulta los proyectos activos (fecha_final es NULL) cuenta los proyectos activos de cada docente y suma las horas activas, los agrupa y los ordena de mayor a menor
WITH activos AS (
  SELECT * FROM proyecto WHERE fecha_final IS NULL
)
SELECT d.nombres, COUNT(a.proyecto_id) AS activos_count, SUM(a.horas) AS horas_activas
FROM docente d LEFT JOIN activos a ON a.docente_id_jefe = d.docente_id
GROUP BY d.nombres
ORDER BY activos_count DESC;

-- Rankea los proyectos de cada docente basado en el presupuesto de mayor a menor
SELECT d.nombres AS jefe, p.nombre, p.presupuesto,
       RANK() OVER (PARTITION BY d.docente_id ORDER BY p.presupuesto DESC) AS rk
FROM proyecto p JOIN docente d ON d.docente_id = p.docente_id_jefe
ORDER BY d.nombres, rk;

-- Inserta un nuevo docente en la tabla docente y le asigna sus valores

INSERT INTO docente (numero_documento,nombres,titulo,anios_experiencia,direccion,tipo_docente)
VALUES ('CC2001','Marta López','MSc. Software',7,'Calle 1 #2-3','Planta');

-- Se actualizan las horas del proyecto 'Aula STEM' adicionando 20 horas
UPDATE proyecto SET horas = horas + 20 WHERE nombre = 'Aula STEM';

-- Inicia una transacción para actualizar el presupuesto y las horas de los proyectos activos, en caso de que se generen o no errores se hace uso de ROLLBACK o COMMIT
BEGIN;
  UPDATE proyecto SET presupuesto = presupuesto * 1.05 WHERE fecha_final IS NULL;
  UPDATE proyecto SET horas = horas + 10 WHERE fecha_final IS NULL;
ROLLBACK; -- o COMMIT

-- Se crean cuatro índices para optimizar las consultas más comunes con el CREATE INDEX ON
CREATE INDEX idx_proy_docente   ON proyecto(docente_id_jefe);
CREATE INDEX idx_proy_fecha_ini ON proyecto(fecha_inicial);
CREATE INDEX idx_proy_fecha_fin ON proyecto(fecha_final);
CREATE INDEX idx_doc_tipo       ON docente(tipo_docente);














