-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: students
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_customuser'),(22,'Can change user',6,'change_customuser'),(23,'Can delete user',6,'delete_customuser'),(24,'Can view user',6,'view_customuser'),(25,'Can add attendance',7,'add_attendance'),(26,'Can change attendance',7,'change_attendance'),(27,'Can delete attendance',7,'delete_attendance'),(28,'Can view attendance',7,'view_attendance'),(29,'Can add courses',8,'add_courses'),(30,'Can change courses',8,'change_courses'),(31,'Can delete courses',8,'delete_courses'),(32,'Can view courses',8,'view_courses'),(33,'Can add session year model',9,'add_sessionyearmodel'),(34,'Can change session year model',9,'change_sessionyearmodel'),(35,'Can delete session year model',9,'delete_sessionyearmodel'),(36,'Can view session year model',9,'view_sessionyearmodel'),(37,'Can add subjects',10,'add_subjects'),(38,'Can change subjects',10,'change_subjects'),(39,'Can delete subjects',10,'delete_subjects'),(40,'Can view subjects',10,'view_subjects'),(41,'Can add students',11,'add_students'),(42,'Can change students',11,'change_students'),(43,'Can delete students',11,'delete_students'),(44,'Can view students',11,'view_students'),(45,'Can add staffs',12,'add_staffs'),(46,'Can change staffs',12,'change_staffs'),(47,'Can delete staffs',12,'delete_staffs'),(48,'Can view staffs',12,'view_staffs'),(49,'Can add notification student',13,'add_notificationstudent'),(50,'Can change notification student',13,'change_notificationstudent'),(51,'Can delete notification student',13,'delete_notificationstudent'),(52,'Can view notification student',13,'view_notificationstudent'),(53,'Can add notification staffs',14,'add_notificationstaffs'),(54,'Can change notification staffs',14,'change_notificationstaffs'),(55,'Can delete notification staffs',14,'delete_notificationstaffs'),(56,'Can view notification staffs',14,'view_notificationstaffs'),(57,'Can add leave report student',15,'add_leavereportstudent'),(58,'Can change leave report student',15,'change_leavereportstudent'),(59,'Can delete leave report student',15,'delete_leavereportstudent'),(60,'Can view leave report student',15,'view_leavereportstudent'),(61,'Can add leave report staff',16,'add_leavereportstaff'),(62,'Can change leave report staff',16,'change_leavereportstaff'),(63,'Can delete leave report staff',16,'delete_leavereportstaff'),(64,'Can view leave report staff',16,'view_leavereportstaff'),(65,'Can add feed back student',17,'add_feedbackstudent'),(66,'Can change feed back student',17,'change_feedbackstudent'),(67,'Can delete feed back student',17,'delete_feedbackstudent'),(68,'Can view feed back student',17,'view_feedbackstudent'),(69,'Can add feed back staffs',18,'add_feedbackstaffs'),(70,'Can change feed back staffs',18,'change_feedbackstaffs'),(71,'Can delete feed back staffs',18,'delete_feedbackstaffs'),(72,'Can view feed back staffs',18,'view_feedbackstaffs'),(73,'Can add attendance report',19,'add_attendancereport'),(74,'Can change attendance report',19,'change_attendancereport'),(75,'Can delete attendance report',19,'delete_attendancereport'),(76,'Can view attendance report',19,'view_attendancereport'),(77,'Can add admin hod',20,'add_adminhod'),(78,'Can change admin hod',20,'change_adminhod'),(79,'Can delete admin hod',20,'delete_adminhod'),(80,'Can view admin hod',20,'view_adminhod'),(81,'Can add student result',21,'add_studentresult'),(82,'Can change student result',21,'change_studentresult'),(83,'Can delete student result',21,'delete_studentresult'),(84,'Can view student result',21,'view_studentresult');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_student_m` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_student_m` FOREIGN KEY (`user_id`) REFERENCES `student_management_app_customuser` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(5,'sessions','session'),(20,'student_management_app','adminhod'),(7,'student_management_app','attendance'),(19,'student_management_app','attendancereport'),(8,'student_management_app','courses'),(6,'student_management_app','customuser'),(18,'student_management_app','feedbackstaffs'),(17,'student_management_app','feedbackstudent'),(16,'student_management_app','leavereportstaff'),(15,'student_management_app','leavereportstudent'),(14,'student_management_app','notificationstaffs'),(13,'student_management_app','notificationstudent'),(9,'student_management_app','sessionyearmodel'),(12,'student_management_app','staffs'),(21,'student_management_app','studentresult'),(11,'student_management_app','students'),(10,'student_management_app','subjects');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-04-07 09:57:35.981323'),(2,'contenttypes','0002_remove_content_type_name','2025-04-07 09:57:36.189570'),(3,'auth','0001_initial','2025-04-07 09:57:37.249003'),(4,'auth','0002_alter_permission_name_max_length','2025-04-07 09:57:37.432753'),(5,'auth','0003_alter_user_email_max_length','2025-04-07 09:57:37.448270'),(6,'auth','0004_alter_user_username_opts','2025-04-07 09:57:37.462000'),(7,'auth','0005_alter_user_last_login_null','2025-04-07 09:57:37.474974'),(8,'auth','0006_require_contenttypes_0002','2025-04-07 09:57:37.481213'),(9,'auth','0007_alter_validators_add_error_messages','2025-04-07 09:57:37.495956'),(10,'auth','0008_alter_user_username_max_length','2025-04-07 09:57:37.508890'),(11,'auth','0009_alter_user_last_name_max_length','2025-04-07 09:57:37.522548'),(12,'auth','0010_alter_group_name_max_length','2025-04-07 09:57:37.562463'),(13,'auth','0011_update_proxy_permissions','2025-04-07 09:57:37.590753'),(14,'student_management_app','0001_initial','2025-04-07 09:57:42.844110'),(15,'admin','0001_initial','2025-04-07 09:57:43.302407'),(16,'admin','0002_logentry_remove_auto_add','2025-04-07 09:57:43.319558'),(17,'admin','0003_logentry_add_action_flag_choices','2025-04-07 09:57:43.342146'),(18,'auth','0012_alter_user_first_name_max_length','2025-04-07 09:57:43.358149'),(19,'sessions','0001_initial','2025-04-07 09:57:43.472891'),(20,'student_management_app','0002_auto_20200626_1629','2025-04-07 09:57:43.486345'),(21,'student_management_app','0003_auto_20200627_0534','2025-04-07 09:57:43.668435'),(22,'student_management_app','0004_auto_20200703_0740','2025-04-07 09:57:43.855972'),(23,'student_management_app','0005_studentresult','2025-04-07 09:57:44.319814'),(24,'student_management_app','0006_alter_customuser_first_name','2025-04-07 09:57:44.533872'),(25,'student_management_app','0002_auto_20200328_1334','2025-04-07 12:53:32.380568'),(26,'student_management_app','0003_alter_customuser_first_name','2025-04-07 12:54:24.507997');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('j7jpwwvvkaqrhmdmkzndz34hyktcbend','NTdkOGMzN2ViOThlZTNhMTc2YjVlMzFiMzUwYzI3ZGU1YjRlZGQwMjp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoic3R1ZGVudF9tYW5hZ2VtZW50X2FwcC5FbWFpbEJhY2tFbmQuRW1haWxCYWNrRW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOTIzMjdmYWJmN2MwNmQ0ZDc2NjdmYmJiZTkxN2JjMDRmYzRjNDM3NCJ9','2025-05-19 09:06:47.484927'),('p6trz6bski5ebxig6qnde6lij3qaonpz','.eJxVjMEOwiAQRP-FszHsUgp4NOl3kAU20iikETgZ_932Zm8z8ybvIzyNnv1o_PZrEjcB4vK_BYpPrgdofSSu3Req9OByRNq261Jofd3311LTqZw9mVreJc5OLK1BVFGDtcjIBOQoKAyQtNLEoKMzIeEkJcJsAidDrGZtJUQpvj-jgjnm:1u1lzq:_gUZkfaQYSb7u2cEVv0DhD5CLi8Yj1NGjzVRmGhicKM','2025-04-21 12:54:38.052477'),('u0obfvy38dy5lwqs3xadmdvnelsxdz0h','.eJxVjk0KwyAQhe_iuhR1jDFdFnIOGZ2xCW0k1LgqvXtjodDs3h8f7yU81m3ytfDTzyQuQonTfxYw3jm3omyVOG9-wYw3XprEdT2PC86P674aMx3MkTNhmXYIaFasBxvdkCwkHWRCgkAyymCNVdKB7mhIPSVyEU3HvQLVBbLBgHUN-vvxfQvi_QHeTUAS:1u1jRF:lVcj8yMh5LLWZ_6wqFAAJSWOr7roXub4BBOeb1Ry2DI','2025-04-21 10:10:45.152339');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_adminhod`
--

DROP TABLE IF EXISTS `student_management_app_adminhod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_adminhod` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `admin_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_id` (`admin_id`),
  CONSTRAINT `student_management_a_admin_id_2d75304f_fk_student_m` FOREIGN KEY (`admin_id`) REFERENCES `student_management_app_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_adminhod`
--

LOCK TABLES `student_management_app_adminhod` WRITE;
/*!40000 ALTER TABLE `student_management_app_adminhod` DISABLE KEYS */;
INSERT INTO `student_management_app_adminhod` VALUES (1,'2025-04-07 09:59:06.963115','2025-04-07 09:59:06.975195',1),(2,'2025-05-05 08:28:00.970775','2025-05-05 08:28:00.970775',5),(3,'2025-05-05 08:48:53.540553','2025-05-05 08:48:53.556179',6);
/*!40000 ALTER TABLE `student_management_app_adminhod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_attendance`
--

DROP TABLE IF EXISTS `student_management_app_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attendance_date` date NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `session_year_id_id` int NOT NULL,
  `subject_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_management_a_session_year_id_id_0d30545d_fk_student_m` (`session_year_id_id`),
  KEY `student_management_a_subject_id_id_9ae82fd0_fk_student_m` (`subject_id_id`),
  CONSTRAINT `student_management_a_session_year_id_id_0d30545d_fk_student_m` FOREIGN KEY (`session_year_id_id`) REFERENCES `student_management_app_sessionyearmodel` (`id`),
  CONSTRAINT `student_management_a_subject_id_id_9ae82fd0_fk_student_m` FOREIGN KEY (`subject_id_id`) REFERENCES `student_management_app_subjects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_attendance`
--

LOCK TABLES `student_management_app_attendance` WRITE;
/*!40000 ALTER TABLE `student_management_app_attendance` DISABLE KEYS */;
INSERT INTO `student_management_app_attendance` VALUES (1,'2025-05-05','2025-05-05 09:07:03.050872','2025-05-05 09:07:03.050872',1,2);
/*!40000 ALTER TABLE `student_management_app_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_attendancereport`
--

DROP TABLE IF EXISTS `student_management_app_attendancereport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_attendancereport` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `attendance_id_id` int NOT NULL,
  `student_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_management_a_attendance_id_id_f765f2a1_fk_student_m` (`attendance_id_id`),
  KEY `student_management_a_student_id_id_5a58ceea_fk_student_m` (`student_id_id`),
  CONSTRAINT `student_management_a_attendance_id_id_f765f2a1_fk_student_m` FOREIGN KEY (`attendance_id_id`) REFERENCES `student_management_app_attendance` (`id`),
  CONSTRAINT `student_management_a_student_id_id_5a58ceea_fk_student_m` FOREIGN KEY (`student_id_id`) REFERENCES `student_management_app_students` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_attendancereport`
--

LOCK TABLES `student_management_app_attendancereport` WRITE;
/*!40000 ALTER TABLE `student_management_app_attendancereport` DISABLE KEYS */;
INSERT INTO `student_management_app_attendancereport` VALUES (1,1,'2025-05-05 09:07:03.061870','2025-05-05 09:07:03.061870',1,1);
/*!40000 ALTER TABLE `student_management_app_attendancereport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_courses`
--

DROP TABLE IF EXISTS `student_management_app_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_courses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_name` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_courses`
--

LOCK TABLES `student_management_app_courses` WRITE;
/*!40000 ALTER TABLE `student_management_app_courses` DISABLE KEYS */;
INSERT INTO `student_management_app_courses` VALUES (1,'BSIT','2025-04-07 10:01:00.677469','2025-05-05 09:05:29.904623'),(2,'BSBA','2025-04-07 10:04:43.718459','2025-04-07 10:04:43.718459'),(3,'BSIT','2025-05-05 09:05:21.786232','2025-05-05 09:05:21.786232');
/*!40000 ALTER TABLE `student_management_app_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_customuser`
--

DROP TABLE IF EXISTS `student_management_app_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_customuser` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `user_type` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_customuser`
--

LOCK TABLES `student_management_app_customuser` WRITE;
/*!40000 ALTER TABLE `student_management_app_customuser` DISABLE KEYS */;
INSERT INTO `student_management_app_customuser` VALUES (1,'pbkdf2_sha256$870000$HX4giI3zXvbqj36hSw6LYZ$gJIYvaaYznOQGyabNWfPLcC01yPw52m3bFhT71rZ0js=','2025-04-13 13:53:00.708475',1,'admin','','','karlanthony521@gmail.com',1,1,'2025-04-07 09:59:06.180354','1'),(2,'pbkdf2_sha256$870000$ggH38Y6EH8HgZLSyKTN5MD$j7YUfxvxonlBlnTkaUCBs4XHpOGuczeGucw66ortxHg=',NULL,0,'staff','Yna','Dela Cruz','ynayssabel@gmail.com',0,1,'2025-04-07 10:01:29.494266','2'),(3,'pbkdf2_sha256$870000$KFTjNKk2lyBybHz4GMvmaC$JziWgod20hLxtPYumctzC2jAH7eDxSHf2Eq7Og8XRj8=',NULL,0,'Karl521','Karl Anthony','Dela Cru','karlanthonydelacruz128@gmail.com',0,1,'2025-04-07 10:02:34.824711','3'),(4,'pbkdf2_sha256$870000$mF7bqIohl3wKTGGPt7JArP$5pmLOl1Yr4N5Iqg3yYKXr1ubhRqREWS0HDbSctNJAjg=',NULL,0,'admin123','grose','Dela Cruz','karl@gmail.com',0,1,'2025-04-07 10:06:35.133914','3'),(5,'pbkdf2_sha256$180000$eq4GViMxCQJl$1RO4mjtqXd1i5jo4abqm+1IB8sfxDHi3VPRnwZ7ljjE=','2025-05-05 09:04:46.044662',1,'admin1','','','admin@gmail.com',1,1,'2025-05-05 08:28:00.071213','1'),(6,'pbkdf2_sha256$180000$zegRiwwcMeP4$ewaxbvv/q2KQR5Il2NV0x+mZZaNg/CW5XmgHQqaHrnY=','2025-05-05 08:49:19.161814',1,'teacher','','','staff@gmail.com',1,1,'2025-05-05 08:48:53.378940','1'),(7,'pbkdf2_sha256$180000$d6XwAj5vbb2a$ArEVd+Yy5J/KyZY0+b8U4UdsjkbfR097Scih2Z0YBuE=','2025-05-05 09:06:47.474304',0,'marc','marc','de vera','marc@gmail.com',0,1,'2025-05-05 08:58:21.406888','2');
/*!40000 ALTER TABLE `student_management_app_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_customuser_groups`
--

DROP TABLE IF EXISTS `student_management_app_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_customuser_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customuser_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_management_app_c_customuser_id_group_id_d872a780_uniq` (`customuser_id`,`group_id`),
  KEY `student_management_a_group_id_61accfd6_fk_auth_grou` (`group_id`),
  CONSTRAINT `student_management_a_customuser_id_1e347552_fk_student_m` FOREIGN KEY (`customuser_id`) REFERENCES `student_management_app_customuser` (`id`),
  CONSTRAINT `student_management_a_group_id_61accfd6_fk_auth_grou` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_customuser_groups`
--

LOCK TABLES `student_management_app_customuser_groups` WRITE;
/*!40000 ALTER TABLE `student_management_app_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_management_app_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_customuser_user_permissions`
--

DROP TABLE IF EXISTS `student_management_app_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_customuser_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customuser_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_management_app_c_customuser_id_permission_af9a6989_uniq` (`customuser_id`,`permission_id`),
  KEY `student_management_a_permission_id_cd344297_fk_auth_perm` (`permission_id`),
  CONSTRAINT `student_management_a_customuser_id_41a474d7_fk_student_m` FOREIGN KEY (`customuser_id`) REFERENCES `student_management_app_customuser` (`id`),
  CONSTRAINT `student_management_a_permission_id_cd344297_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_customuser_user_permissions`
--

LOCK TABLES `student_management_app_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `student_management_app_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_management_app_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_feedbackstaffs`
--

DROP TABLE IF EXISTS `student_management_app_feedbackstaffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_feedbackstaffs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feedback` longtext NOT NULL,
  `feedback_reply` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `staff_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_management_a_staff_id_id_6f22a616_fk_student_m` (`staff_id_id`),
  CONSTRAINT `student_management_a_staff_id_id_6f22a616_fk_student_m` FOREIGN KEY (`staff_id_id`) REFERENCES `student_management_app_staffs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_feedbackstaffs`
--

LOCK TABLES `student_management_app_feedbackstaffs` WRITE;
/*!40000 ALTER TABLE `student_management_app_feedbackstaffs` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_management_app_feedbackstaffs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_feedbackstudent`
--

DROP TABLE IF EXISTS `student_management_app_feedbackstudent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_feedbackstudent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feedback` longtext NOT NULL,
  `feedback_reply` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `student_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_management_a_student_id_id_099e23ad_fk_student_m` (`student_id_id`),
  CONSTRAINT `student_management_a_student_id_id_099e23ad_fk_student_m` FOREIGN KEY (`student_id_id`) REFERENCES `student_management_app_students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_feedbackstudent`
--

LOCK TABLES `student_management_app_feedbackstudent` WRITE;
/*!40000 ALTER TABLE `student_management_app_feedbackstudent` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_management_app_feedbackstudent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_leavereportstaff`
--

DROP TABLE IF EXISTS `student_management_app_leavereportstaff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_leavereportstaff` (
  `id` int NOT NULL AUTO_INCREMENT,
  `leave_date` varchar(255) NOT NULL,
  `leave_message` longtext NOT NULL,
  `leave_status` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `staff_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_management_a_staff_id_id_c7710cd5_fk_student_m` (`staff_id_id`),
  CONSTRAINT `student_management_a_staff_id_id_c7710cd5_fk_student_m` FOREIGN KEY (`staff_id_id`) REFERENCES `student_management_app_staffs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_leavereportstaff`
--

LOCK TABLES `student_management_app_leavereportstaff` WRITE;
/*!40000 ALTER TABLE `student_management_app_leavereportstaff` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_management_app_leavereportstaff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_leavereportstudent`
--

DROP TABLE IF EXISTS `student_management_app_leavereportstudent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_leavereportstudent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `leave_date` varchar(255) NOT NULL,
  `leave_message` longtext NOT NULL,
  `leave_status` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `student_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_management_a_student_id_id_9ea5372c_fk_student_m` (`student_id_id`),
  CONSTRAINT `student_management_a_student_id_id_9ea5372c_fk_student_m` FOREIGN KEY (`student_id_id`) REFERENCES `student_management_app_students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_leavereportstudent`
--

LOCK TABLES `student_management_app_leavereportstudent` WRITE;
/*!40000 ALTER TABLE `student_management_app_leavereportstudent` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_management_app_leavereportstudent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_notificationstaffs`
--

DROP TABLE IF EXISTS `student_management_app_notificationstaffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_notificationstaffs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `stafff_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_management_a_stafff_id_id_e69db87c_fk_student_m` (`stafff_id_id`),
  CONSTRAINT `student_management_a_stafff_id_id_e69db87c_fk_student_m` FOREIGN KEY (`stafff_id_id`) REFERENCES `student_management_app_staffs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_notificationstaffs`
--

LOCK TABLES `student_management_app_notificationstaffs` WRITE;
/*!40000 ALTER TABLE `student_management_app_notificationstaffs` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_management_app_notificationstaffs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_notificationstudent`
--

DROP TABLE IF EXISTS `student_management_app_notificationstudent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_notificationstudent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `student_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_management_a_student_id_id_f8c05ed7_fk_student_m` (`student_id_id`),
  CONSTRAINT `student_management_a_student_id_id_f8c05ed7_fk_student_m` FOREIGN KEY (`student_id_id`) REFERENCES `student_management_app_students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_notificationstudent`
--

LOCK TABLES `student_management_app_notificationstudent` WRITE;
/*!40000 ALTER TABLE `student_management_app_notificationstudent` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_management_app_notificationstudent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_sessionyearmodel`
--

DROP TABLE IF EXISTS `student_management_app_sessionyearmodel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_sessionyearmodel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_start_year` date NOT NULL,
  `session_end_year` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_sessionyearmodel`
--

LOCK TABLES `student_management_app_sessionyearmodel` WRITE;
/*!40000 ALTER TABLE `student_management_app_sessionyearmodel` DISABLE KEYS */;
INSERT INTO `student_management_app_sessionyearmodel` VALUES (1,'2025-04-01','2025-12-01');
/*!40000 ALTER TABLE `student_management_app_sessionyearmodel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_staffs`
--

DROP TABLE IF EXISTS `student_management_app_staffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_staffs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `admin_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_id` (`admin_id`),
  CONSTRAINT `student_management_a_admin_id_5bfdd57d_fk_student_m` FOREIGN KEY (`admin_id`) REFERENCES `student_management_app_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_staffs`
--

LOCK TABLES `student_management_app_staffs` WRITE;
/*!40000 ALTER TABLE `student_management_app_staffs` DISABLE KEYS */;
INSERT INTO `student_management_app_staffs` VALUES (2,'abilan','2025-05-05 08:58:21.580880','2025-05-05 08:58:21.611380',7);
/*!40000 ALTER TABLE `student_management_app_staffs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_studentresult`
--

DROP TABLE IF EXISTS `student_management_app_studentresult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_studentresult` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject_exam_marks` double NOT NULL,
  `subject_assignment_marks` double NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `student_id_id` int NOT NULL,
  `subject_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_management_a_student_id_id_f6cc67b8_fk_student_m` (`student_id_id`),
  KEY `student_management_a_subject_id_id_1f0cd017_fk_student_m` (`subject_id_id`),
  CONSTRAINT `student_management_a_student_id_id_f6cc67b8_fk_student_m` FOREIGN KEY (`student_id_id`) REFERENCES `student_management_app_students` (`id`),
  CONSTRAINT `student_management_a_subject_id_id_1f0cd017_fk_student_m` FOREIGN KEY (`subject_id_id`) REFERENCES `student_management_app_subjects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_studentresult`
--

LOCK TABLES `student_management_app_studentresult` WRITE;
/*!40000 ALTER TABLE `student_management_app_studentresult` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_management_app_studentresult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_students`
--

DROP TABLE IF EXISTS `student_management_app_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gender` varchar(50) NOT NULL,
  `profile_pic` varchar(100) NOT NULL,
  `address` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `admin_id` int NOT NULL,
  `course_id_id` int NOT NULL,
  `session_year_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_id` (`admin_id`),
  KEY `student_management_a_course_id_id_fcd09bed_fk_student_m` (`course_id_id`),
  KEY `student_management_a_session_year_id_id_594fc55d_fk_student_m` (`session_year_id_id`),
  CONSTRAINT `student_management_a_admin_id_1a8517ae_fk_student_m` FOREIGN KEY (`admin_id`) REFERENCES `student_management_app_customuser` (`id`),
  CONSTRAINT `student_management_a_course_id_id_fcd09bed_fk_student_m` FOREIGN KEY (`course_id_id`) REFERENCES `student_management_app_courses` (`id`),
  CONSTRAINT `student_management_a_session_year_id_id_594fc55d_fk_student_m` FOREIGN KEY (`session_year_id_id`) REFERENCES `student_management_app_sessionyearmodel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_students`
--

LOCK TABLES `student_management_app_students` WRITE;
/*!40000 ALTER TABLE `student_management_app_students` DISABLE KEYS */;
INSERT INTO `student_management_app_students` VALUES (1,'Male','/media/16ecd447df34950052cc634f8e0e0146.jpg','abilan','2025-04-07 10:02:35.603399','2025-04-07 10:07:46.028076',3,1,1);
/*!40000 ALTER TABLE `student_management_app_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_management_app_subjects`
--

DROP TABLE IF EXISTS `student_management_app_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_management_app_subjects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject_name` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `course_id_id` int NOT NULL,
  `staff_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_management_a_course_id_id_342668dd_fk_student_m` (`course_id_id`),
  KEY `student_management_a_staff_id_id_5f47119a_fk_student_m` (`staff_id_id`),
  CONSTRAINT `student_management_a_course_id_id_342668dd_fk_student_m` FOREIGN KEY (`course_id_id`) REFERENCES `student_management_app_courses` (`id`),
  CONSTRAINT `student_management_a_staff_id_id_5f47119a_fk_student_m` FOREIGN KEY (`staff_id_id`) REFERENCES `student_management_app_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_management_app_subjects`
--

LOCK TABLES `student_management_app_subjects` WRITE;
/*!40000 ALTER TABLE `student_management_app_subjects` DISABLE KEYS */;
INSERT INTO `student_management_app_subjects` VALUES (1,'MATH','2025-04-07 10:01:38.827429','2025-05-05 09:04:53.426006',1,2),(2,'MATH','2025-05-05 09:05:47.606310','2025-05-05 09:06:37.272156',1,7);
/*!40000 ALTER TABLE `student_management_app_subjects` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-08 23:00:50
