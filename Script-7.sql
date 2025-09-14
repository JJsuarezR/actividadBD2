-- USE proyectos para seleccionar la base de datos
USE proyectos;
/* ============================
   seed.sql  (MySQL 8.0+)
   ============================ */

-- Se crean dos docentes usando CALL para llamar el procedimiento almacenado sp_docente_crear
CALL sp_docente_crear('CC1001', 'Ana Gómez', 'MSc. Ing. Sistemas', 6, 'Cra 10 # 5-55', 'Tiempo completo');
CALL sp_docente_crear('CC1002', 'Carlos Ruiz', 'Ing. Informático', 3, 'Cll 20 # 4-10', 'Cátedra');

-- Obtener IDs de los docentes para usar en proyectos
SET @id_ana    := (SELECT docente_id FROM docente WHERE numero_documento='CC1001');
SET @id_carlos := (SELECT docente_id FROM docente WHERE numero_documento='CC1002');

-- Se crean dos proyectos usando CALL para llamar el procedimiento almacenado sp_proyecto_crear y se le asignan a los docentes creados
CALL sp_proyecto_crear('Plataforma Académica', 'Módulos de matrícula', '2025-01-01', NULL, 25000000, 800, @id_ana);
CALL sp_proyecto_crear('Chat Soporte TI', 'Chat universitario', '2025-02-01', '2025-06-30', 12000000, 450, @id_carlos);

-- Se usa el call para actualizar el docente Carlos Ruiz y disparar el trigger de auditoría de actualización
CALL sp_docente_actualizar(@id_carlos, 'CC1002', 'Carlos A. Ruiz', 'Esp. Base de Datos', 4, 'Cll 20 # 4-10', 'Cátedra');

-- Se usa el call para eliminar el docente Ana Gómez y disparar el trigger de auditoría de eliminación
DELETE FROM proyecto WHERE docente_id_jefe = @id_ana;
CALL sp_docente_eliminar(@id_ana);

-- Se insertan más docentes usando el INSERT INTO y VALUES en lugar del CALL a los procedimientos almacenados

INSERT INTO docente (numero_documento, nombres, titulo, anios_experiencia, direccion, tipo_docente) VALUES
('CC3001','Ana Pérez','MSc. Sistemas',1,'Calle 10 #1-10','Planta'),
('CC3002','Luis Gómez','Ing. Sistemas',4,'Cra 11 #2-11','Catedra'),
('CC3003','Carla Ríos','PhD. Computación',7,'Calle 12 #3-12','Planta'),
('CC3004','Juan Toro','MSc. Datos',10,'Cra 13 #4-13','Catedra'),
('CC3005','Marta López','Lic. Matemáticas',13,'Calle 14 #5-14','Planta'),
('CC3006','Pedro Ramírez','MSc. Software',16,'Cra 15 #6-15','Catedra'),
('CC3007','Lucía Hernández','PhD. Educación',19,'Calle 16 #7-16','Planta'),
('CC3008','Sergio Martínez','Esp. Analítica',22,'Cra 17 #8-17','Catedra'),
('CC3009','Elena Vargas','MSc. Estadística',25,'Calle 18 #9-18','Planta'),
('CC3010','Andrés Castro','Ing. Electrónica',3,'Cra 19 #10-19','Catedra'),
('CC3011','Paula Suárez','MSc. Sistemas',6,'Calle 20 #1-20','Planta'),
('CC3012','Diego Moreno','Ing. Sistemas',9,'Cra 21 #2-21','Catedra'),
('CC3013','Sofía Santos','PhD. Computación',12,'Calle 22 #3-22','Planta'),
('CC3014','Javier León','MSc. Datos',15,'Cra 23 #4-23','Catedra'),
('CC3015','Valeria Rodríguez','Lic. Matemáticas',18,'Calle 24 #5-24','Planta'),
('CC3016','Camilo Salazar','MSc. Software',21,'Cra 25 #6-25','Catedra'),
('CC3017','Daniela Acosta','PhD. Educación',24,'Calle 26 #7-26','Planta'),
('CC3018','Héctor Rojas','Esp. Analítica',2,'Cra 27 #8-27','Catedra'),
('CC3019','Nadia Navarro','MSc. Estadística',5,'Calle 28 #9-28','Planta'),
('CC3020','Felipe Campos','Ing. Electrónica',8,'Cra 29 #10-29','Catedra'),
('CC3021','Laura Méndez','MSc. Sistemas',11,'Calle 30 #1-30','Planta'),
('CC3022','Miguel Guerrero','Ing. Sistemas',14,'Cra 31 #2-31','Catedra'),
('CC3023','Carolina Vega','PhD. Computación',17,'Calle 32 #3-32','Planta'),
('CC3024','Tomás Lara','MSc. Datos',20,'Cra 33 #4-33','Catedra'),
('CC3025','Gabriela Romero','Lic. Matemáticas',23,'Calle 34 #5-34','Planta'),
('CC3026','Ricardo Ibarra','MSc. Software',1,'Cra 35 #6-35','Catedra'),
('CC3027','Sara Patiño','PhD. Educación',4,'Calle 36 #7-36','Planta'),
('CC3028','Mauricio Nieto','Esp. Analítica',7,'Cra 37 #8-37','Catedra'),
('CC3029','Isabel Cano','MSc. Estadística',10,'Calle 38 #9-38','Planta'),
('CC3030','Oscar Fuentes','Ing. Electrónica',13,'Cra 39 #10-39','Catedra'),
('CC3031','Verónica Pineda','MSc. Sistemas',16,'Calle 40 #1-40','Planta'),
('CC3032','Esteban Quintero','Ing. Sistemas',19,'Cra 41 #2-41','Catedra'),
('CC3033','Patricia Mejía','PhD. Computación',22,'Calle 42 #3-42','Planta'),
('CC3034','Gustavo Gutiérrez','MSc. Datos',25,'Cra 43 #4-43','Catedra'),
('CC3035','Mariana Serrano','Lic. Matemáticas',3,'Calle 44 #5-44','Planta'),
('CC3036','Roberto Ortega','MSc. Software',6,'Cra 45 #6-45','Catedra'),
('CC3037','Natalia Paz','PhD. Educación',9,'Calle 46 #7-46','Planta'),
('CC3038','Iván Barrios','Esp. Analítica',12,'Cra 47 #8-47','Catedra'),
('CC3039','Claudia Miranda','MSc. Estadística',15,'Calle 48 #9-48','Planta'),
('CC3040','Edgar Valdez','Ing. Electrónica',18,'Cra 49 #10-49','Catedra'),
('CC3041','Gloria Delgado','MSc. Sistemas',21,'Calle 50 #1-50','Planta'),
('CC3042','Víctor Aguilar','Ing. Sistemas',24,'Cra 51 #2-51','Catedra'),
('CC3043','Diana Córdoba','PhD. Computación',2,'Calle 52 #3-52','Planta'),
('CC3044','César Fajardo','MSc. Datos',5,'Cra 53 #4-53','Catedra'),
('CC3045','Rocío Forero','Lic. Matemáticas',8,'Calle 54 #5-54','Planta'),
('CC3046','Julio Cárdenas','MSc. Software',11,'Cra 55 #6-55','Catedra'),
('CC3047','Noelia Blanco','PhD. Educación',14,'Calle 56 #7-56','Planta'),
('CC3048','Emilio Bravo','Esp. Analítica',17,'Cra 57 #8-57','Catedra'),
('CC3049','Fabián Cortés','MSc. Estadística',20,'Calle 58 #9-58','Planta'),
('CC3050','Pilar Mora','Ing. Electrónica',23,'Cra 59 #10-59','Catedra');

-- -- Se insertan más proyectos usando el INSERT INTO y VALUES en lugar del CALL a los procedimientos almacenados


INSERT INTO proyecto (nombre, descripcion, fecha_inicial, fecha_final, presupuesto, horas, docente_id_jefe) VALUES
('Proyecto Académico 02','Descripción del proyecto 02 orientado a innovación educativa','2023-01-29','2023-08-17',32000.00,120,2),
('Proyecto Académico 03','Descripción del proyecto 03 orientado a innovación educativa','2023-02-12',NULL,35500.00,130,3),
('Proyecto Académico 04','Descripción del proyecto 04 orientado a innovación educativa','2023-02-26','2023-09-14',39000.00,140,4),
('Proyecto Académico 05','Descripción del proyecto 05 orientado a innovación educativa','2023-03-12',NULL,42500.00,150,5),
('Proyecto Académico 06','Descripción del proyecto 06 orientado a innovación educativa','2023-03-26','2023-10-12',46000.00,160,6),
('Proyecto Académico 07','Descripción del proyecto 07 orientado a innovación educativa','2023-04-09',NULL,49500.00,170,7),
('Proyecto Académico 08','Descripción del proyecto 08 orientado a innovación educativa','2023-04-23','2023-11-09',53000.00,180,8),
('Proyecto Académico 09','Descripción del proyecto 09 orientado a innovación educativa','2023-05-07',NULL,56500.00,190,9),
('Proyecto Académico 10','Descripción del proyecto 10 orientado a innovación educativa','2023-05-21','2023-12-07',60000.00,200,10),
('Proyecto Académico 11','Descripción del proyecto 11 orientado a innovación educativa','2023-06-04',NULL,63500.00,210,11),
('Proyecto Académico 12','Descripción del proyecto 12 orientado a innovación educativa','2023-06-18','2024-01-04',67000.00,220,12),
('Proyecto Académico 13','Descripción del proyecto 13 orientado a innovación educativa','2023-07-02',NULL,70500.00,230,13),
('Proyecto Académico 14','Descripción del proyecto 14 orientado a innovación educativa','2023-07-16','2024-02-01',74000.00,240,14),
('Proyecto Académico 15','Descripción del proyecto 15 orientado a innovación educativa','2023-07-30',NULL,77500.00,250,15),
('Proyecto Académico 16','Descripción del proyecto 16 orientado a innovación educativa','2023-08-13','2024-02-29',81000.00,260,16),
('Proyecto Académico 17','Descripción del proyecto 17 orientado a innovación educativa','2023-08-27',NULL,84500.00,270,17),
('Proyecto Académico 18','Descripción del proyecto 18 orientado a innovación educativa','2023-09-10','2024-03-28',88000.00,280,18),
('Proyecto Académico 19','Descripción del proyecto 19 orientado a innovación educativa','2023-09-24',NULL,91500.00,290,19),
('Proyecto Académico 20','Descripción del proyecto 20 orientado a innovación educativa','2023-10-08','2024-04-26',95000.00,300,20),
('Proyecto Académico 21','Descripción del proyecto 21 orientado a innovación educativa','2023-10-22',NULL,98500.00,310,21),
('Proyecto Académico 22','Descripción del proyecto 22 orientado a innovación educativa','2023-11-05','2024-05-23',102000.00,320,22),
('Proyecto Académico 23','Descripción del proyecto 23 orientado a innovación educativa','2023-11-19',NULL,105500.00,330,23),
('Proyecto Académico 24','Descripción del proyecto 24 orientado a innovación educativa','2023-12-03','2024-06-20',109000.00,340,24),
('Proyecto Académico 25','Descripción del proyecto 25 orientado a innovación educativa','2023-12-17',NULL,112500.00,350,25),
('Proyecto Académico 26','Descripción del proyecto 26 orientado a innovación educativa','2023-12-31','2024-07-18',116000.00,360,26),
('Proyecto Académico 27','Descripción del proyecto 27 orientado a innovación educativa','2024-01-14',NULL,119500.00,370,27),
('Proyecto Académico 28','Descripción del proyecto 28 orientado a innovación educativa','2024-01-28','2024-08-15',123000.00,380,28),
('Proyecto Académico 29','Descripción del proyecto 29 orientado a innovación educativa','2024-02-11',NULL,126500.00,390,29),
('Proyecto Académico 30','Descripción del proyecto 30 orientado a innovación educativa','2024-02-25','2024-09-12',130000.00,400,30),
('Proyecto Académico 31','Descripción del proyecto 31 orientado a innovación educativa','2024-03-10',NULL,133500.00,410,31),
('Proyecto Académico 32','Descripción del proyecto 32 orientado a innovación educativa','2024-03-24','2024-10-09',137000.00,420,32),
('Proyecto Académico 33','Descripción del proyecto 33 orientado a innovación educativa','2024-04-07',NULL,140500.00,430,33),
('Proyecto Académico 34','Descripción del proyecto 34 orientado a innovación educativa','2024-04-21','2024-11-06',144000.00,440,34),
('Proyecto Académico 35','Descripción del proyecto 35 orientado a innovación educativa','2024-05-05',NULL,147500.00,450,35),
('Proyecto Académico 36','Descripción del proyecto 36 orientado a innovación educativa','2024-05-19','2024-12-03',151000.00,460,36),
('Proyecto Académico 37','Descripción del proyecto 37 orientado a innovación educativa','2024-06-02',NULL,154500.00,470,37),
('Proyecto Académico 38','Descripción del proyecto 38 orientado a innovación educativa','2024-06-16','2025-01-12',158000.00,480,38),
('Proyecto Académico 39','Descripción del proyecto 39 orientado a innovación educativa','2024-06-30',NULL,161500.00,490,39),
('Proyecto Académico 40','Descripción del proyecto 40 orientado a innovación educativa','2024-07-14','2025-02-08',165000.00,500,40),
('Proyecto Académico 41','Descripción del proyecto 41 orientado a innovación educativa','2024-07-28',NULL,168500.00,510,41),
('Proyecto Académico 42','Descripción del proyecto 42 orientado a innovación educativa','2024-08-11','2025-03-08',172000.00,520,42),
('Proyecto Académico 43','Descripción del proyecto 43 orientado a innovación educativa','2024-08-25',NULL,175500.00,530,43),
('Proyecto Académico 44','Descripción del proyecto 44 orientado a innovación educativa','2024-09-08','2025-04-05',179000.00,540,44),
('Proyecto Académico 45','Descripción del proyecto 45 orientado a innovación educativa','2024-09-22',NULL,182500.00,550,45),
('Proyecto Académico 46','Descripción del proyecto 46 orientado a innovación educativa','2024-10-06','2025-05-03',186000.00,560,46),
('Proyecto Académico 47','Descripción del proyecto 47 orientado a innovación educativa','2024-10-20',NULL,189500.00,570,47),
('Proyecto Académico 48','Descripción del proyecto 48 orientado a innovación educativa','2024-11-03','2025-05-31',193000.00,580,48),
('Proyecto Académico 49','Descripción del proyecto 49 orientado a innovación educativa','2024-11-17',NULL,196500.00,590,49),
('Proyecto Académico 50','Descripción del proyecto 50 orientado a innovación educativa','2024-12-01','2025-06-19',200000.00,600,50);

