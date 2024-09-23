CREATE DATABASE  IF NOT EXISTS `gestionpersonasloaiza` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gestionpersonasloaiza`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: gestionpersonasloaiza
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `capacitaciones`
--

DROP TABLE IF EXISTS `capacitaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `capacitaciones` (
  `id_capacitacion` int NOT NULL AUTO_INCREMENT,
  `nombre_capacitacion` varchar(80) NOT NULL,
  `dirigido_a` varchar(150) DEFAULT NULL,
  `hrs_capacitacion` decimal(3,1) DEFAULT NULL,
  `tipo_capacitacion` enum('INTERNA','EXTERNA') DEFAULT NULL,
  `tipo_malla` enum('NORMATIVA','TRANSVERSAL','VENTA_Y_SERVICIO_AL_CLIENTE','DEI','TECNICA','LIDERAZGO') DEFAULT NULL,
  `plataforma` enum('PORTAL_FORMACION_LH','PORTAL_ACHS','TEAMS','OTRA') DEFAULT NULL,
  `nombre_institucion` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id_capacitacion`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capacitaciones`
--

LOCK TABLES `capacitaciones` WRITE;
/*!40000 ALTER TABLE `capacitaciones` DISABLE KEYS */;
INSERT INTO `capacitaciones` VALUES (1,'INDUCCION CORPORATIVA',NULL,1.5,'INTERNA','TRANSVERSAL','PORTAL_FORMACION_LH','LH'),(2,'ATENCION AL CLIENTE',NULL,2.0,'INTERNA','VENTA_Y_SERVICIO_AL_CLIENTE','PORTAL_FORMACION_LH','LH'),(3,'ODI',NULL,1.0,'INTERNA','NORMATIVA','PORTAL_ACHS','LH'),(4,'RIESGO',NULL,1.0,'INTERNA','NORMATIVA','PORTAL_FORMACION_LH','LH'),(5,'EXCEL',NULL,8.5,'INTERNA','TECNICA','PORTAL_FORMACION_LH','LH'),(6,'EQUIDAD',NULL,2.5,'INTERNA','DEI','PORTAL_FORMACION_LH','LH'),(7,'SEGUROS',NULL,2.0,'INTERNA','VENTA_Y_SERVICIO_AL_CLIENTE','PORTAL_FORMACION_LH','LH'),(8,'CREDITOS',NULL,2.0,'INTERNA','VENTA_Y_SERVICIO_AL_CLIENTE','PORTAL_FORMACION_LH','LH'),(12,'SEGURIDAD INFORMATICA',NULL,1.0,'INTERNA','NORMATIVA','PORTAL_FORMACION_LH','LH'),(13,'EMISION DE TARJETAS',NULL,3.5,'INTERNA','VENTA_Y_SERVICIO_AL_CLIENTE','PORTAL_FORMACION_LH','LH'),(14,'LICENCIAS',NULL,2.5,'INTERNA','VENTA_Y_SERVICIO_AL_CLIENTE','PORTAL_FORMACION_LH','LH'),(15,'PRODUCTOS',NULL,2.0,'INTERNA','TRANSVERSAL','PORTAL_FORMACION_LH','LH');
/*!40000 ALTER TABLE `capacitaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capacitaciones_cargos`
--

DROP TABLE IF EXISTS `capacitaciones_cargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `capacitaciones_cargos` (
  `id_capacitacion` int NOT NULL,
  `codigo_cargo` int NOT NULL,
  PRIMARY KEY (`id_capacitacion`,`codigo_cargo`),
  KEY `FK_CAPACITACIONES_CARGOS_CARGOS` (`codigo_cargo`),
  CONSTRAINT `FK_CAPACITACIONES_CARGOS_CAPACITACIONES` FOREIGN KEY (`id_capacitacion`) REFERENCES `capacitaciones` (`id_capacitacion`),
  CONSTRAINT `FK_CAPACITACIONES_CARGOS_CARGOS` FOREIGN KEY (`codigo_cargo`) REFERENCES `cargos` (`codigo_cargo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capacitaciones_cargos`
--

LOCK TABLES `capacitaciones_cargos` WRITE;
/*!40000 ALTER TABLE `capacitaciones_cargos` DISABLE KEYS */;
INSERT INTO `capacitaciones_cargos` VALUES (1,124),(3,124),(1,132),(3,132),(5,132),(7,132),(8,132),(3,257),(5,257),(1,345),(3,345),(3,435),(5,435),(1,451),(2,451),(3,451),(4,451),(6,451),(7,451),(8,451),(1,527),(6,527),(1,826),(2,826),(3,826);
/*!40000 ALTER TABLE `capacitaciones_cargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cargos`
--

DROP TABLE IF EXISTS `cargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargos` (
  `codigo_cargo` int NOT NULL,
  `cargo` varchar(60) NOT NULL,
  `id_estructura` int NOT NULL,
  `rol` enum('GENERAL','PRIVADO') NOT NULL,
  `familia_cargo` varchar(60) DEFAULT NULL,
  `nivel_cargo` int DEFAULT NULL,
  `personas_a_cargo` enum('SI','NO') NOT NULL,
  `cargo_comercial` enum('SI','NO') DEFAULT NULL,
  `region_comercial` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`codigo_cargo`),
  KEY `FK_CARGOS_ESTRUCTURA` (`id_estructura`),
  CONSTRAINT `FK_CARGOS_ESTRUCTURA` FOREIGN KEY (`id_estructura`) REFERENCES `estructura_organizacional` (`id_estructura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargos`
--

LOCK TABLES `cargos` WRITE;
/*!40000 ALTER TABLE `cargos` DISABLE KEYS */;
INSERT INTO `cargos` VALUES (105,'Administrativo de Recaudacion',13,'GENERAL','ADMINISTRATIVO',9,'NO','NO',NULL),(124,'Asistente Administrativo',3,'GENERAL','ADMINISTRATIVO',9,'NO','NO',NULL),(132,'Analista de Marketing',1,'PRIVADO','PROFESIONALES',11,'NO','NO',NULL),(189,'Especialista Estudios de Riesgo',14,'PRIVADO','PROFESIONALES',14,'NO','NO',NULL),(196,'Analista Comercial Senior',15,'PRIVADO','PROFESIONALES',16,'NO','NO',NULL),(203,'Analista Aseguramiento Calidad TI',9,'PRIVADO','PROFESIONALES',14,'NO','NO',NULL),(208,'Jefe(a) de Canales Digitales',10,'PRIVADO','JEFATURA',15,'SI','NO',NULL),(256,'Analista de Proveedores, Procesos y Contratos',12,'PRIVADO','PROFESIONALES',14,'NO','NO',NULL),(257,'Analista de Compras',6,'PRIVADO','PROFESIONALES',14,'NO','NO','AUSTRAL'),(345,'Analista de Remuneraciones',4,'PRIVADO','PROFESIONALES',14,'NO','NO','AUSTRAL'),(435,'Analista de Finanzas',6,'PRIVADO','PROFESIONALES',12,'NO','NO',NULL),(451,'Gerente Comercial',7,'PRIVADO','GERENCIA',16,'SI','SI','RM_NORTE'),(527,'Especialista en RRHH',5,'PRIVADO','PROFESIONALES',13,'NO','NO',NULL),(826,'Secretaria',8,'GENERAL','ADMINISTRATIVO',9,'NO','NO',NULL);
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colaboradores`
--

DROP TABLE IF EXISTS `colaboradores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colaboradores` (
  `id_colaborador` varchar(12) NOT NULL,
  `nombres_colaborador` varchar(60) NOT NULL,
  `apellidos_colaborador` varchar(60) NOT NULL,
  `fecha_de_nacimiento` date NOT NULL,
  `sexo` enum('F','M') NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `email_colaborador` varchar(30) NOT NULL,
  `direccion_colaborador` varchar(60) DEFAULT NULL,
  `telefono_colaborador` varchar(15) DEFAULT NULL,
  `codigo_cargo` int DEFAULT NULL,
  `id_jefatura` varchar(12) DEFAULT NULL,
  `sucursal` varchar(30) NOT NULL,
  `id_estructura` int NOT NULL,
  `nivel_jerarquico` enum('AREA','SUBGERENCIA','GERENCIA') NOT NULL,
  `tipo_contrato` enum('PLAZO_FIJO','INDEFINIDO') NOT NULL,
  `plazo_contrato` int NOT NULL,
  `modalidad_jornada` enum('PRESENCIAL','TELETRABAJO_PARCIAL','TELETRABAJO_TOTAL') DEFAULT NULL,
  `nivel_academico` enum('ENSEÑANZA_MEDIA','TECNICO','UNIVERSITARIO','ESTUDIOS_SUPERIORES','MAGISTER') NOT NULL,
  `cant_hijos` int DEFAULT NULL,
  `estado_civil` enum('SOLTERO/A','CASADO/A','VIUDO','CONVIVIENTE_CIVIL','DIVORCIADO/A','SEPARADO/A') DEFAULT NULL,
  PRIMARY KEY (`id_colaborador`),
  KEY `FK_COLABORADOR_ESTRUCTURA_ORGANIZACIONAL` (`id_estructura`),
  KEY `FK_COLABORADOR_CARGOS` (`codigo_cargo`),
  CONSTRAINT `FK_COLABORADOR_CARGOS` FOREIGN KEY (`codigo_cargo`) REFERENCES `cargos` (`codigo_cargo`),
  CONSTRAINT `FK_COLABORADOR_ESTRUCTURA_ORGANIZACIONAL` FOREIGN KEY (`id_estructura`) REFERENCES `estructura_organizacional` (`id_estructura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colaboradores`
--

LOCK TABLES `colaboradores` WRITE;
/*!40000 ALTER TABLE `colaboradores` DISABLE KEYS */;
INSERT INTO `colaboradores` VALUES ('05.752.658-5','Juan Eduardo','Perez Lopez','1975-05-15','M','2020-06-20','juan.perez@email.com','Calle 123','123456789',451,'13.568.125-5','Sucursal A',1,'GERENCIA','INDEFINIDO',0,'PRESENCIAL','UNIVERSITARIO',2,'CASADO/A'),('08.757.685-1','Traci Bryan','Martinez Holt','1974-03-06','F','2017-07-07','traci.martinez@yahoo.com','551 Silva Flats','566801624',208,'54.874.949-5','Sucursal E',10,'AREA','PLAZO_FIJO',6,'TELETRABAJO_PARCIAL','UNIVERSITARIO',4,'CASADO/A'),('10.987.654-3','Ana Maria','Lopez Acevedo','1977-08-25','F','2016-09-18','ana.lopez@email.com','Pasaje 234','789123456',527,'16.745.842-6','Sucursal A',3,'AREA','INDEFINIDO',4,'PRESENCIAL','UNIVERSITARIO',2,'CASADO/A'),('11.234.567-7','Carlos Raul','Sanchez Olivares','1975-03-10','M','2019-11-30','carlos.sanchez@email.com','Plaza 567','987654321',435,'19.215.125-6','Sucursal B',2,'AREA','PLAZO_FIJO',5,'PRESENCIAL','UNIVERSITARIO',0,'SOLTERO/A'),('12.345.678-9','Maria Soledad','Gomez Figueroa','1980-09-20','F','2018-03-10','maria.gomez@email.com','Avenida 456','987654321',132,'23.456.784-4','Sucursal B',2,'AREA','INDEFINIDO',0,'PRESENCIAL','TECNICO',0,'SOLTERO/A'),('13.456.789-0','Laura Elena','Rodriguez Linares','1973-07-02','F','2020-02-15','laura.rodriguez@email.com','Callejon 890','654987321',826,'08.785.451-1','Sucursal C',2,'AREA','PLAZO_FIJO',6,'TELETRABAJO_PARCIAL','UNIVERSITARIO',0,'SOLTERO/A'),('18.765.432-1','Pedro Luis','Martinez Suarez','1975-12-12','M','2017-01-05','pedro.martinez@email.com','Carrera 789','456789123',124,'06.785.975-5','Sucursal C',3,'AREA','PLAZO_FIJO',1,'PRESENCIAL','TECNICO',1,'CASADO/A'),('19.876.543-2','Roberto Carlos','Hernandez Jimenez','1978-01-30','M','2017-05-12','roberto.hernandez@email.com','Calle Mayor 123','159357486',257,'05.547.652-5','Sucursal A',1,'AREA','INDEFINIDO',7,'PRESENCIAL','TECNICO',2,'CASADO/A'),('20.123.456-4','Luisa Cristina','Garcia Ramirez','1972-11-18','F','2018-08-03','luisa.garcia@email.com','Avenida Central 456','258741369',345,'14.547.120-8','Sucursal B',3,'AREA','PLAZO_FIJO',8,'TELETRABAJO_TOTAL','TECNICO',1,'CASADO/A'),('24.686.336-7','Justin Jason','Young Williamson','1990-11-26','F','2022-03-25','justin.young@yahoo.com','869 Patrick Mountains','464828692',345,'14.547.120-8','Sucursal B',3,'AREA','PLAZO_FIJO',8,'TELETRABAJO_TOTAL','TECNICO',1,'CASADO/A'),('25.451.854-4','Elias Andres','Hernandez Loaiza','1985-05-31','M','2022-09-16','elias.hernandez@email.com','Blanco Viel 1111','258757896',435,'19.215.125-6','Sucursal B',2,'AREA','INDEFINIDO',0,'TELETRABAJO_TOTAL','UNIVERSITARIO',0,'SOLTERO/A'),('28.799.585-3','Carol Brian','Sanders Patterson','1969-09-16','F','2023-02-16','carol.sanders@hotmail.com','31050 Howard Radial','1729976',203,'87.248.145-K','Sucursal D',9,'AREA','INDEFINIDO',0,'PRESENCIAL','UNIVERSITARIO',1,'CASADO/A'),('29.896.096-5','Kathryn Trevor','Ingram Farmer','1994-07-31','F','2021-10-06','kathryn.ingram@hotmail.com','89887 Wong Vista Apt. 534','541852881',196,'87.903.836-6','Sucursal A',15,'AREA','INDEFINIDO',6,'TELETRABAJO_PARCIAL','UNIVERSITARIO',1,'SOLTERO/A'),('42.588.140-2','Tracy Laura','Garcia Ayala','1997-12-11','M','2021-02-04','tracy.garcia@yahoo.com','6292 Rice Branch Suite 045','771650578',105,'84.357.767-9','Sucursal A',13,'AREA','PLAZO_FIJO',8,'TELETRABAJO_TOTAL','TECNICO',0,'SOLTERO/A'),('44.617.189-3','Harry James','Gill Hernandez','1971-11-27','M','2021-08-16','harry.gill@yahoo.com','43225 Padilla Viaduct','68921803',189,'10.078.815-9','Sucursal B',14,'AREA','INDEFINIDO',0,'TELETRABAJO_TOTAL','UNIVERSITARIO',0,'SOLTERO/A'),('46.327.804-7','Cathy Katherine','Cannon Woodard','1974-04-29','F','2020-09-18','cathy.cannon@hotmail.com','4406 Wells Track Apt. 491','589432533',105,'84.357.767-9','Sucursal A',13,'AREA','PLAZO_FIJO',8,'TELETRABAJO_TOTAL','TECNICO',0,'SOLTERO/A'),('56.250.816-9','Ryan Bryan','Wilkerson Dunn','1986-04-03','M','2021-05-30','ryan.wilkerson@gmail.com','590 Paul Street','843249495',256,'22.644.379-8','Sucursal A',12,'AREA','PLAZO_FIJO',7,'PRESENCIAL','UNIVERSITARIO',2,'CASADO/A'),('77.477.780-5','Ashley Elizabeth','Lewis Snyder','1992-10-24','M','2019-10-06','ashley.lewis@yahoo.com','6209 James Forks Suite 643','213659037',132,'23.456.784-4','Sucursal B',2,'AREA','INDEFINIDO',0,'PRESENCIAL','TECNICO',0,'SOLTERO/A');
/*!40000 ALTER TABLE `colaboradores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `desempeno`
--

DROP TABLE IF EXISTS `desempeno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `desempeno` (
  `id_desempeno` int NOT NULL AUTO_INCREMENT,
  `id_colaborador` varchar(12) NOT NULL,
  `periodo_evaluacion` date NOT NULL,
  `calificacion_desempeno` decimal(5,2) NOT NULL,
  `categoria_desempeno` enum('BAJO_DESEMPENO','NECESIDADES_DE_MEJORA','TRABAJO_BIEN_HECHO','DESEMPENO_DESTACADO') DEFAULT NULL,
  `conformidad_colaborador` enum('SI','NO') DEFAULT NULL,
  `evaluacion_publicada` enum('SI','NO') DEFAULT NULL,
  `plan_de_mejora` enum('SI','NO') DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_desempeno`),
  KEY `FK_COLABORADOR_DESEMPENO` (`id_colaborador`),
  CONSTRAINT `FK_COLABORADOR_DESEMPENO` FOREIGN KEY (`id_colaborador`) REFERENCES `colaboradores` (`id_colaborador`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `desempeno`
--

LOCK TABLES `desempeno` WRITE;
/*!40000 ALTER TABLE `desempeno` DISABLE KEYS */;
INSERT INTO `desempeno` VALUES (1,'05.752.658-5','2023-01-01',4.00,'DESEMPENO_DESTACADO','SI','NO','NO',NULL),(2,'13.456.789-0','2021-01-01',3.17,'TRABAJO_BIEN_HECHO','SI','SI','SI','Se sugiere curso de excel avanzado para agilizar algunas de sus labores'),(3,'18.765.432-1','2023-01-01',2.60,'NECESIDADES_DE_MEJORA','NO','SI','SI','Se recomienda ajustarse a los plazos de entrega establecidos, se propone agenda automatizada como apoyo'),(4,'12.345.678-9','2022-01-01',1.50,'BAJO_DESEMPENO','NO','SI','SI',NULL),(5,'20.123.456-4','2023-01-01',3.88,'DESEMPENO_DESTACADO','SI','SI','NO',NULL),(6,'10.987.654-3','2022-01-01',2.90,'TRABAJO_BIEN_HECHO','NO','SI','NO',NULL),(7,'05.752.658-5','2023-01-01',3.10,'TRABAJO_BIEN_HECHO','SI','SI','NO',NULL),(8,'19.876.543-2','2022-01-01',2.20,'BAJO_DESEMPENO','NO','SI','SI',NULL);
/*!40000 ALTER TABLE `desempeno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estructura_organizacional`
--

DROP TABLE IF EXISTS `estructura_organizacional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estructura_organizacional` (
  `id_estructura` int NOT NULL AUTO_INCREMENT,
  `id_area` int DEFAULT NULL,
  `area` varchar(60) DEFAULT NULL,
  `id_subgerencia` int DEFAULT NULL,
  `subgerencia` varchar(60) DEFAULT NULL,
  `id_gerencia` int DEFAULT NULL,
  `gerencia` varchar(60) NOT NULL,
  `id_filial` int NOT NULL,
  `filial` enum('A','B','C') NOT NULL,
  PRIMARY KEY (`id_estructura`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estructura_organizacional`
--

LOCK TABLES `estructura_organizacional` WRITE;
/*!40000 ALTER TABLE `estructura_organizacional` DISABLE KEYS */;
INSERT INTO `estructura_organizacional` VALUES (1,5,'Marketing',4,'Subgerencia de Marketing',3,'Recursos Humanos',1,'A'),(2,8,'Afiliaciones',14,'Subgerencia Afiliacion Trabajadores',1,'Red Comercial',2,'A'),(3,16,'Compras',23,'Subgerencia de Compras',2,'Administracion',2,'C'),(4,10,'Remuneraciones',9,'Subgerencia de Compensaciones',3,'Recursos Humanos',1,'A'),(5,4,'Calidad de Vida',8,'Subgerencia de Compensaciones',3,'Recursos Humanos',1,'A'),(6,13,'Pagos',20,'Subgerencia de Finanzas',2,'Administracion',2,'C'),(7,2,'General',2,'Gerencia',3,'Gerencia General',3,'C'),(8,15,'Mantenimiento',22,'Subgerencia de Infraestructura',2,'Administracion',2,'C'),(9,7,'Aseguramiento_de_Calidad_TI',10,'Subgerencia de Transformación Digital',4,'Gerencia de Operaciones y Tecnología',2,'C'),(10,12,'Canales Digitales',11,'Subgerencia de Canales Digitales y Servicio Empresa',5,'Gerencia Empresas y Trabajadores',2,'A'),(11,14,'Innovacion',10,'Subgerencia deTransformación Digital',6,'Gerencia de Operaciones y Tecnología',1,'A'),(12,6,'Proveedores y Procesos',23,'Subgerencia de Compras',2,'Administracion',2,'C'),(13,9,'Recaudacion',12,'Subgerencia de Operaciones Financieras',6,'Gerencia de Operaciones y Tecnología',1,'A'),(14,11,'Modelos de Riesgo',15,'Subgerencia Riesgo Crédito y Financiero',7,'Gerencia de Riesgo',3,'C'),(15,17,'Gestion Comercial',16,'Subgerencia Gestión Comercial',1,'Red Comercial',2,'A');
/*!40000 ALTER TABLE `estructura_organizacional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postulaciones_movilidades`
--

DROP TABLE IF EXISTS `postulaciones_movilidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `postulaciones_movilidades` (
  `id_postulacion` int NOT NULL,
  `id_proceso` int NOT NULL,
  `id_colaborador` varchar(12) NOT NULL,
  `fecha_postulacion` date DEFAULT NULL,
  `direccion_movimiento` enum('VERTICAL','HORIZONTAL') DEFAULT NULL,
  `ultima_etapa` enum('FILTRO_REQUISITOS','EVALUACION','FINALISTA','SELECCIONADO/A') NOT NULL,
  PRIMARY KEY (`id_postulacion`),
  KEY `FK_COLABORADOR_POSTULACIONES_MOVILIDADES` (`id_colaborador`),
  KEY `FK_VACANTES_INTERNAS_POSTULACIONES_MOVILIDADES` (`id_proceso`),
  CONSTRAINT `FK_COLABORADOR_POSTULACIONES_MOVILIDADES` FOREIGN KEY (`id_colaborador`) REFERENCES `colaboradores` (`id_colaborador`),
  CONSTRAINT `FK_VACANTES_INTERNAS_POSTULACIONES_MOVILIDADES` FOREIGN KEY (`id_proceso`) REFERENCES `vacantes_internas` (`id_proceso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postulaciones_movilidades`
--

LOCK TABLES `postulaciones_movilidades` WRITE;
/*!40000 ALTER TABLE `postulaciones_movilidades` DISABLE KEYS */;
INSERT INTO `postulaciones_movilidades` VALUES (1,2156,'18.765.432-1','2023-01-18','VERTICAL','FILTRO_REQUISITOS'),(2,2156,'13.456.789-0','2023-01-13','VERTICAL','EVALUACION'),(3,2156,'12.345.678-9','2023-01-10','VERTICAL','SELECCIONADO/A'),(4,2250,'18.765.432-1','2023-01-20','VERTICAL','FILTRO_REQUISITOS'),(5,2250,'12.345.678-9','2023-01-26','VERTICAL','EVALUACION'),(6,2211,'05.752.658-5','2024-07-12','VERTICAL','FILTRO_REQUISITOS'),(7,2211,'18.765.432-1','2024-07-11','VERTICAL','FILTRO_REQUISITOS'),(8,2211,'12.345.678-9','2024-07-10','VERTICAL','EVALUACION'),(9,2150,'05.752.658-5','2024-02-02','HORIZONTAL','FILTRO_REQUISITOS'),(10,2150,'10.987.654-3','2024-02-03','VERTICAL','EVALUACION'),(11,2150,'11.234.567-7','2024-02-04','VERTICAL','SELECCIONADO/A'),(12,2150,'12.345.678-9','2024-02-05','HORIZONTAL','FILTRO_REQUISITOS'),(13,2302,'29.896.096-5','2023-08-23','VERTICAL','EVALUACION'),(14,2302,'77.477.780-5','2023-08-23','VERTICAL','SELECCIONADO/A'),(15,2302,'24.686.336-7','2023-08-25','HORIZONTAL','FILTRO_REQUISITOS');
/*!40000 ALTER TABLE `postulaciones_movilidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registro_beneficios`
--

DROP TABLE IF EXISTS `registro_beneficios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro_beneficios` (
  `id_beneficio` int NOT NULL AUTO_INCREMENT,
  `detalle_beneficio` varchar(100) NOT NULL,
  `categoria_beneficio` enum('BECA','CURSOS_PLAN_GERENCIA') DEFAULT NULL,
  `id_colaborador` varchar(12) NOT NULL,
  `fecha_otorgamiento` date DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `resultado` enum('EN CURSO','APROBADO','REPROBADO','DESISTE') DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_beneficio`),
  KEY `FK_REGISTRO_BENEFICIOS_COLABORADORES` (`id_colaborador`),
  CONSTRAINT `FK_REGISTRO_BENEFICIOS_COLABORADORES` FOREIGN KEY (`id_colaborador`) REFERENCES `colaboradores` (`id_colaborador`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro_beneficios`
--

LOCK TABLES `registro_beneficios` WRITE;
/*!40000 ALTER TABLE `registro_beneficios` DISABLE KEYS */;
INSERT INTO `registro_beneficios` VALUES (1,'Diplomado en Compensaciones','BECA','18.765.432-1','2023-01-01','2023-01-18','2023-06-30','REPROBADO',NULL),(2,'Curso Ingles','CURSOS_PLAN_GERENCIA','05.752.658-5','2022-06-01','2022-07-01','2022-12-31','DESISTE','No puede culminar por enfermedad'),(3,'Curso Data Science','CURSOS_PLAN_GERENCIA','12.345.678-9','2023-08-01','2023-10-01','2023-10-25','APROBADO',NULL),(4,'Diplomado en Remuneraciones','BECA','20.123.456-4','2024-02-01','2024-04-01','2024-10-29','APROBADO',NULL),(5,'Ingenieria Comercial','BECA','11.234.567-7','2024-02-01','2024-04-01','2024-10-29','APROBADO',NULL),(6,'Ingenieria en Recursos Humanos','BECA','05.752.658-5','2024-02-01','2024-04-01','2024-10-29','APROBADO',NULL),(7,'Power_BI','CURSOS_PLAN_GERENCIA','10.987.654-3','2024-05-01','2024-06-01','2024-07-01','APROBADO',NULL),(8,'Diplomado en Analisis de Datos','BECA','13.456.789-0','2024-05-06','2024-06-05','2024-10-29','EN CURSO',NULL),(9,'SQL','CURSOS_PLAN_GERENCIA','44.617.189-3','2020-03-15','2020-03-20','2020-05-20','REPROBADO',NULL),(10,'Curso Excel','CURSOS_PLAN_GERENCIA','29.896.096-5','2023-05-14','2023-06-18','2023-06-30','DESISTE',NULL),(11,'Curso Ingles','CURSOS_PLAN_GERENCIA','77.477.780-5','2022-06-16','2022-07-17','2022-12-21','APROBADO',NULL),(12,'SQL','CURSOS_PLAN_GERENCIA','24.686.336-7','2020-03-15','2020-03-20','2020-05-20','APROBADO',NULL),(13,'Curso Excel','CURSOS_PLAN_GERENCIA','42.588.140-2','2023-05-14','2023-06-18','2023-06-30','REPROBADO',NULL),(14,'Curso Ingles','CURSOS_PLAN_GERENCIA','08.757.685-1','2022-06-16','2022-07-17','2022-12-21','DESISTE',NULL),(15,'Curso Excel','CURSOS_PLAN_GERENCIA','05.752.658-5','2023-05-14','2023-06-18','2023-06-30','APROBADO',NULL);
/*!40000 ALTER TABLE `registro_beneficios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registro_capacitaciones`
--

DROP TABLE IF EXISTS `registro_capacitaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro_capacitaciones` (
  `id_capacitacion` int NOT NULL,
  `id_colaborador` varchar(12) NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `estado` enum('APROBADO','REPROBADO','NO_REALIZADO','PENDIENTE INSCRIBIR') DEFAULT NULL,
  `numero_llamado` int DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  KEY `FK_COLABORADOR_REGISTRO_CAPACITACIONES` (`id_colaborador`),
  KEY `FK_CAPACITACION_REGISTRO_CAPACITACIONES` (`id_capacitacion`),
  CONSTRAINT `FK_CAPACITACION_REGISTRO_CAPACITACIONES` FOREIGN KEY (`id_capacitacion`) REFERENCES `capacitaciones` (`id_capacitacion`),
  CONSTRAINT `FK_COLABORADOR_REGISTRO_CAPACITACIONES` FOREIGN KEY (`id_colaborador`) REFERENCES `colaboradores` (`id_colaborador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro_capacitaciones`
--

LOCK TABLES `registro_capacitaciones` WRITE;
/*!40000 ALTER TABLE `registro_capacitaciones` DISABLE KEYS */;
INSERT INTO `registro_capacitaciones` VALUES (1,'05.752.658-5','2024-01-01','2024-02-01','NO_REALIZADO',1,NULL),(1,'13.456.789-0','2024-03-01','2024-03-27','APROBADO',2,NULL),(3,'18.765.432-1','2024-02-15','2024-03-03','APROBADO',1,NULL),(5,'12.345.678-9','2024-03-24','2024-04-15','REPROBADO',3,NULL),(5,'20.123.456-4','2024-04-16','2024-04-30','APROBADO',1,NULL),(6,'10.987.654-3','2024-05-08','2024-05-28','APROBADO',2,NULL),(7,'05.752.658-5','2024-06-01','2024-06-16','NO_REALIZADO',3,NULL),(7,'19.876.543-2','2024-06-10','2024-06-27','REPROBADO',3,NULL),(3,'25.451.854-4',NULL,NULL,'PENDIENTE INSCRIBIR',NULL,NULL),(5,'25.451.854-4',NULL,NULL,'PENDIENTE INSCRIBIR',NULL,NULL),(1,'77.477.780-5',NULL,NULL,'PENDIENTE INSCRIBIR',NULL,NULL),(3,'77.477.780-5',NULL,NULL,'PENDIENTE INSCRIBIR',NULL,NULL),(5,'77.477.780-5',NULL,NULL,'PENDIENTE INSCRIBIR',NULL,NULL),(7,'77.477.780-5',NULL,NULL,'PENDIENTE INSCRIBIR',NULL,NULL),(8,'77.477.780-5',NULL,NULL,'PENDIENTE INSCRIBIR',NULL,NULL),(1,'24.686.336-7',NULL,NULL,'PENDIENTE INSCRIBIR',NULL,NULL),(3,'24.686.336-7',NULL,NULL,'PENDIENTE INSCRIBIR',NULL,NULL);
/*!40000 ALTER TABLE `registro_capacitaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registro_capacitaciones_max_calificacion`
--

DROP TABLE IF EXISTS `registro_capacitaciones_max_calificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro_capacitaciones_max_calificacion` (
  `id_capacitacion` int NOT NULL,
  `id_colaborador` varchar(12) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `estado` enum('APROBADO','REPROBADO','NO_REALIZADO') DEFAULT NULL,
  `numero_llamado` int DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_capacitacion`,`id_colaborador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro_capacitaciones_max_calificacion`
--

LOCK TABLES `registro_capacitaciones_max_calificacion` WRITE;
/*!40000 ALTER TABLE `registro_capacitaciones_max_calificacion` DISABLE KEYS */;
INSERT INTO `registro_capacitaciones_max_calificacion` VALUES (1,'05.752.658-5','2024-01-01','2024-02-01','NO_REALIZADO',1,NULL),(1,'13.456.789-0','2024-03-01','2024-03-27','APROBADO',2,NULL),(3,'18.765.432-1','2024-02-15','2024-03-03','APROBADO',1,NULL),(5,'12.345.678-9','2024-03-24','2024-04-15','REPROBADO',3,NULL),(5,'20.123.456-4','2024-04-16','2024-04-30','APROBADO',1,NULL),(6,'10.987.654-3','2024-05-08','2024-05-28','APROBADO',2,NULL),(7,'05.752.658-5','2024-06-01','2024-06-16','NO_REALIZADO',3,NULL),(7,'19.876.543-2','2024-06-10','2024-06-27','REPROBADO',3,NULL);
/*!40000 ALTER TABLE `registro_capacitaciones_max_calificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vacantes_internas`
--

DROP TABLE IF EXISTS `vacantes_internas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vacantes_internas` (
  `id_proceso` int NOT NULL,
  `codigo_cargo` int NOT NULL,
  `tipo_movilidad` enum('MOVILIDAD_DIRIGIDA','CONCURSO') DEFAULT NULL,
  `fecha_apertura` date DEFAULT NULL,
  `fecha_publicacion` date DEFAULT NULL,
  `fecha_cierre` date DEFAULT NULL,
  `estado` enum('VIGENTE','CERRADA') DEFAULT NULL,
  PRIMARY KEY (`id_proceso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vacantes_internas`
--

LOCK TABLES `vacantes_internas` WRITE;
/*!40000 ALTER TABLE `vacantes_internas` DISABLE KEYS */;
INSERT INTO `vacantes_internas` VALUES (2105,450,'MOVILIDAD_DIRIGIDA','2022-07-02',NULL,'2022-07-05','CERRADA'),(2150,256,'CONCURSO','2024-01-15','2024-02-02','2024-02-19','CERRADA'),(2156,132,'CONCURSO','2023-01-01','2023-02-01','2023-01-03','CERRADA'),(2172,451,'MOVILIDAD_DIRIGIDA','2023-03-01','2023-03-05',NULL,'CERRADA'),(2189,196,'MOVILIDAD_DIRIGIDA','2023-07-02',NULL,'2023-07-05','CERRADA'),(2196,435,'CONCURSO','2023-01-01','2023-05-05','2023-05-29','CERRADA'),(2198,208,'MOVILIDAD_DIRIGIDA','2024-04-01',NULL,'2024-05-01','CERRADA'),(2206,345,'CONCURSO','2024-05-03','2024-05-10',NULL,'VIGENTE'),(2210,517,'MOVILIDAD_DIRIGIDA','2024-06-01',NULL,'2024-06-10','CERRADA'),(2211,257,'CONCURSO','2024-07-01','2024-07-10',NULL,'VIGENTE'),(2245,124,'MOVILIDAD_DIRIGIDA','2023-04-10','2023-04-15',NULL,'CERRADA'),(2250,527,'CONCURSO','2023-01-01',NULL,'2023-01-06','VIGENTE'),(2275,203,'CONCURSO','2023-10-09','2023-10-27','2023-11-22','CERRADA'),(2302,189,'CONCURSO','2023-07-31','2023-08-22',NULL,'VIGENTE');
/*!40000 ALTER TABLE `vacantes_internas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-10  4:09:52
