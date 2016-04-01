-- MySQL dump 10.14  Distrib 5.5.47-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: schpro
-- ------------------------------------------------------
-- Server version	5.5.47-MariaDB-1ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attendance_applied_rule`
--

DROP TABLE IF EXISTS `attendance_applied_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance_applied_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_code_id` int(11) NOT NULL,
  `rule_id` int(11) NOT NULL,
  `exclude_weekend` tinyint(1) NOT NULL,
  `end_date` date NOT NULL,
  `start_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `attendance_applied__class_code_id_0458d92f_fk_user_class_code_id` (`class_code_id`),
  KEY `attendance_applied_rule_e1150e65` (`rule_id`),
  CONSTRAINT `attendance_applied_rule_rule_id_8ec42629_fk_attendance_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `attendance_rule` (`id`),
  CONSTRAINT `attendance_applied__class_code_id_0458d92f_fk_user_class_code_id` FOREIGN KEY (`class_code_id`) REFERENCES `user_class_code` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_applied_rule`
--

LOCK TABLES `attendance_applied_rule` WRITE;
/*!40000 ALTER TABLE `attendance_applied_rule` DISABLE KEYS */;
INSERT INTO `attendance_applied_rule` VALUES (8,1,4,1,'2016-03-28','2016-03-28'),(9,3,4,1,'2016-03-28','2016-03-28'),(10,1,5,1,'2016-03-28','2016-03-28'),(14,1,6,0,'2016-04-01','2016-04-01'),(15,2,6,0,'2016-04-01','2016-04-01'),(16,3,6,0,'2016-04-01','2016-04-01');
/*!40000 ALTER TABLE `attendance_applied_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance_attandance`
--

DROP TABLE IF EXISTS `attendance_attandance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance_attandance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logged_datetime` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `attendance_attandance_user_id_216a10ce_fk_user_user_id` (`user_id`),
  CONSTRAINT `attendance_attandance_user_id_216a10ce_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_attandance`
--

LOCK TABLES `attendance_attandance` WRITE;
/*!40000 ALTER TABLE `attendance_attandance` DISABLE KEYS */;
INSERT INTO `attendance_attandance` VALUES (1,'2016-04-01 01:38:16',12),(2,'2016-04-01 01:38:24',18),(3,'2016-04-01 01:38:30',25),(4,'2016-04-01 01:38:33',29),(5,'2016-04-01 01:38:37',116);
/*!40000 ALTER TABLE `attendance_attandance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance_rule`
--

DROP TABLE IF EXISTS `attendance_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `recursive` tinyint(1) NOT NULL,
  `priority` int(10) unsigned NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_rule`
--

LOCK TABLES `attendance_rule` WRITE;
/*!40000 ALTER TABLE `attendance_rule` DISABLE KEYS */;
INSERT INTO `attendance_rule` VALUES (4,'School Day',0,1,'10:00:00','17:00:00'),(5,'School Competition',0,2,'09:30:00','17:00:00'),(6,'School Normal Day',0,0,'08:00:00','17:00:00');
/*!40000 ALTER TABLE `attendance_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add role',1,'add_role'),(2,'Can change role',1,'change_role'),(3,'Can delete role',1,'delete_role'),(4,'Can add user',2,'add_user'),(5,'Can change user',2,'change_user'),(6,'Can delete user',2,'delete_user'),(7,'Can add permission_meta',3,'add_permission_meta'),(8,'Can change permission_meta',3,'change_permission_meta'),(9,'Can delete permission_meta',3,'delete_permission_meta'),(10,'Can add permission',4,'add_permission'),(11,'Can change permission',4,'change_permission'),(12,'Can delete permission',4,'delete_permission'),(13,'Can add parent_contact',5,'add_parent_contact'),(14,'Can change parent_contact',5,'change_parent_contact'),(15,'Can delete parent_contact',5,'delete_parent_contact'),(16,'Can add class_code',6,'add_class_code'),(17,'Can change class_code',6,'change_class_code'),(18,'Can delete class_code',6,'delete_class_code'),(19,'Can add class_assignment',7,'add_class_assignment'),(20,'Can change class_assignment',7,'change_class_assignment'),(21,'Can delete class_assignment',7,'delete_class_assignment'),(22,'Can add time_meta',8,'add_time_meta'),(23,'Can change time_meta',8,'change_time_meta'),(24,'Can delete time_meta',8,'delete_time_meta'),(25,'Can add event_terms',9,'add_event_terms'),(26,'Can change event_terms',9,'change_event_terms'),(27,'Can delete event_terms',9,'delete_event_terms'),(28,'Can add activity_event',10,'add_activity_event'),(29,'Can change activity_event',10,'change_activity_event'),(30,'Can delete activity_event',10,'delete_activity_event'),(31,'Can add calendar',11,'add_calendar'),(32,'Can change calendar',11,'change_calendar'),(33,'Can delete calendar',11,'delete_calendar'),(34,'Can add timetable',12,'add_timetable'),(35,'Can change timetable',12,'change_timetable'),(36,'Can delete timetable',12,'delete_timetable'),(37,'Can add room',13,'add_room'),(38,'Can change room',13,'change_room'),(39,'Can delete room',13,'delete_room'),(40,'Can add facilities',14,'add_facilities'),(41,'Can change facilities',14,'change_facilities'),(42,'Can delete facilities',14,'delete_facilities'),(43,'Can add lesson',15,'add_lesson'),(44,'Can change lesson',15,'change_lesson'),(45,'Can delete lesson',15,'delete_lesson'),(46,'Can add booking',16,'add_booking'),(47,'Can change booking',16,'change_booking'),(48,'Can delete booking',16,'delete_booking'),(49,'Can add classroom',17,'add_classroom'),(50,'Can change classroom',17,'change_classroom'),(51,'Can delete classroom',17,'delete_classroom'),(52,'Can add announce',18,'add_announce'),(53,'Can change announce',18,'change_announce'),(54,'Can delete announce',18,'delete_announce'),(55,'Can add assignment',19,'add_assignment'),(56,'Can change assignment',19,'change_assignment'),(57,'Can delete assignment',19,'delete_assignment'),(58,'Can add user_assignment',20,'add_user_assignment'),(59,'Can change user_assignment',20,'change_user_assignment'),(60,'Can delete user_assignment',20,'delete_user_assignment'),(61,'Can add assignment_pool',21,'add_assignment_pool'),(62,'Can change assignment_pool',21,'change_assignment_pool'),(63,'Can delete assignment_pool',21,'delete_assignment_pool'),(64,'Can add note',22,'add_note'),(65,'Can change note',22,'change_note'),(66,'Can delete note',22,'delete_note'),(67,'Can add classroom_note',23,'add_classroom_note'),(68,'Can change classroom_note',23,'change_classroom_note'),(69,'Can delete classroom_note',23,'delete_classroom_note'),(76,'Can add material',26,'add_material'),(77,'Can change material',26,'change_material'),(78,'Can delete material',26,'delete_material'),(79,'Can add inbox_content',27,'add_inbox_content'),(80,'Can change inbox_content',27,'change_inbox_content'),(81,'Can delete inbox_content',27,'delete_inbox_content'),(82,'Can add inbox',28,'add_inbox'),(83,'Can change inbox',28,'change_inbox'),(84,'Can delete inbox',28,'delete_inbox'),(88,'Can add attandance',30,'add_attandance'),(89,'Can change attandance',30,'change_attandance'),(90,'Can delete attandance',30,'delete_attandance'),(91,'Can add rule',31,'add_rule'),(92,'Can change rule',31,'change_rule'),(93,'Can delete rule',31,'delete_rule'),(94,'Can add applied_rule',32,'add_applied_rule'),(95,'Can change applied_rule',32,'change_applied_rule'),(96,'Can delete applied_rule',32,'delete_applied_rule'),(97,'Can add report_type',33,'add_report_type'),(98,'Can change report_type',33,'change_report_type'),(99,'Can delete report_type',33,'delete_report_type'),(100,'Can add report',34,'add_report'),(101,'Can change report',34,'change_report'),(102,'Can delete report',34,'delete_report'),(103,'Can add schoolinfo',35,'add_schoolinfo'),(104,'Can change schoolinfo',35,'change_schoolinfo'),(105,'Can delete schoolinfo',35,'delete_schoolinfo'),(106,'Can add sitemap',36,'add_sitemap'),(107,'Can change sitemap',36,'change_sitemap'),(108,'Can delete sitemap',36,'delete_sitemap'),(109,'Can add log entry',37,'add_logentry'),(110,'Can change log entry',37,'change_logentry'),(111,'Can delete log entry',37,'delete_logentry'),(112,'Can add permission',38,'add_permission'),(113,'Can change permission',38,'change_permission'),(114,'Can delete permission',38,'delete_permission'),(115,'Can add group',39,'add_group'),(116,'Can change group',39,'change_group'),(117,'Can delete group',39,'delete_group'),(118,'Can add user',40,'add_user'),(119,'Can change user',40,'change_user'),(120,'Can delete user',40,'delete_user'),(121,'Can add content type',41,'add_contenttype'),(122,'Can change content type',41,'change_contenttype'),(123,'Can delete content type',41,'delete_contenttype'),(124,'Can add session',42,'add_session'),(125,'Can change session',42,'change_session'),(126,'Can delete session',42,'delete_session'),(127,'Can add material_classroom',43,'add_material_classroom'),(128,'Can change material_classroom',43,'change_material_classroom'),(129,'Can delete material_classroom',43,'delete_material_classroom'),(130,'Can add assignment_format',44,'add_assignment_format'),(131,'Can change assignment_format',44,'change_assignment_format'),(132,'Can delete assignment_format',44,'delete_assignment_format');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'bcrypt_sha256$$2b$12$AQMTgGiN1eyQmSTZTSKPbeEIVIJKQupCbektgCh.d6RoDRrjZm/yu','2016-04-01 01:38:05',1,'wormcih','','','',1,1,'2016-03-25 14:03:51');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_booking`
--

DROP TABLE IF EXISTS `booking_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking_booking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_date` date NOT NULL,
  `end_lesson_id` int(11) NOT NULL,
  `start_lesson_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `facility_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_booking_753b6c87` (`end_lesson_id`),
  KEY `booking_booking_41f03037` (`start_lesson_id`),
  KEY `booking_booking_e8701ad4` (`user_id`),
  KEY `booking_booking_e32a5395` (`facility_id`),
  CONSTRAINT `booking_booking_end_lesson_id_622c978f_fk_booking_lesson_id` FOREIGN KEY (`end_lesson_id`) REFERENCES `booking_lesson` (`id`),
  CONSTRAINT `booking_booking_facility_id_fbef0df1_fk_facilities_facilities_id` FOREIGN KEY (`facility_id`) REFERENCES `facilities_facilities` (`id`),
  CONSTRAINT `booking_booking_start_lesson_id_5e29f817_fk_booking_lesson_id` FOREIGN KEY (`start_lesson_id`) REFERENCES `booking_lesson` (`id`),
  CONSTRAINT `booking_booking_user_id_e1eb6912_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_booking`
--

LOCK TABLES `booking_booking` WRITE;
/*!40000 ALTER TABLE `booking_booking` DISABLE KEYS */;
INSERT INTO `booking_booking` VALUES (17,'2016-03-24',2,2,1,1),(18,'2016-03-28',4,1,1,1),(19,'2016-03-27',4,1,1,1),(21,'2016-03-28',7,7,1,1),(23,'2016-03-29',4,2,1,1),(24,'2016-03-30',2,1,1,1),(25,'2016-03-31',5,2,1,1),(26,'2016-04-01',3,3,1,1);
/*!40000 ALTER TABLE `booking_booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_lesson`
--

DROP TABLE IF EXISTS `booking_lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking_lesson` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_lesson`
--

LOCK TABLES `booking_lesson` WRITE;
/*!40000 ALTER TABLE `booking_lesson` DISABLE KEYS */;
INSERT INTO `booking_lesson` VALUES (1,'Lesson 1','08:25:00','09:15:00'),(2,'Lesson 2','09:25:00','10:15:00'),(3,'Lesson 3','10:30:00','11:20:00'),(4,'Lesson 4','11:25:00','12:15:00'),(5,'Lesson 5','13:20:00','14:10:00'),(6,'Lesson 6','14:20:00','15:10:00'),(7,'Lesson 7','15:15:00','16:05:00');
/*!40000 ALTER TABLE `booking_lesson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_announce`
--

DROP TABLE IF EXISTS `classroom_announce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom_announce` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `announce_date` datetime NOT NULL,
  `classroom_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_announce_837734a3` (`classroom_id`),
  CONSTRAINT `classroom_announ_classroom_id_6adc29f2_fk_classroom_classroom_id` FOREIGN KEY (`classroom_id`) REFERENCES `classroom_classroom` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_announce`
--

LOCK TABLES `classroom_announce` WRITE;
/*!40000 ALTER TABLE `classroom_announce` DISABLE KEYS */;
INSERT INTO `classroom_announce` VALUES (1,'Hihi','This is the first announce of classroom!','2016-03-29 02:59:38',1),(2,'Hi','testing','2016-03-29 07:26:57',1),(3,'dfdf','dfdff','2016-03-29 07:29:32',1),(4,'tyty','tty','2016-03-29 07:31:37',1);
/*!40000 ALTER TABLE `classroom_announce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_assignment`
--

DROP TABLE IF EXISTS `classroom_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom_assignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `instruction` longtext NOT NULL,
  `deadline_datetime` datetime NOT NULL,
  `fullmark` smallint(5) unsigned NOT NULL,
  `create_date` datetime NOT NULL,
  `classroom_id` int(11) NOT NULL,
  `upload_format_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_assignment_837734a3` (`classroom_id`),
  KEY `classroom_assignment_c81fb49e` (`upload_format_id`),
  CONSTRAINT `classroom_assign_classroom_id_8c5ff526_fk_classroom_classroom_id` FOREIGN KEY (`classroom_id`) REFERENCES `classroom_classroom` (`id`),
  CONSTRAINT `clas_upload_format_id_9cc84fb4_fk_classroom_assignment_format_id` FOREIGN KEY (`upload_format_id`) REFERENCES `classroom_assignment_format` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_assignment`
--

LOCK TABLES `classroom_assignment` WRITE;
/*!40000 ALTER TABLE `classroom_assignment` DISABLE KEYS */;
INSERT INTO `classroom_assignment` VALUES (1,'Assignment paper 1','This is the assignment of Chinese Language. It takes 50 marks of overall grade.','2016-03-29 08:07:32',50,'2016-03-29 08:13:51',1,1);
/*!40000 ALTER TABLE `classroom_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_assignment_format`
--

DROP TABLE IF EXISTS `classroom_assignment_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom_assignment_format` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datatype` varchar(255) NOT NULL,
  `dataext` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_assignment_format`
--

LOCK TABLES `classroom_assignment_format` WRITE;
/*!40000 ALTER TABLE `classroom_assignment_format` DISABLE KEYS */;
INSERT INTO `classroom_assignment_format` VALUES (1,'Document','doc,docx,pdf'),(2,'Pictures','jpg,png,svg');
/*!40000 ALTER TABLE `classroom_assignment_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_assignment_pool`
--

DROP TABLE IF EXISTS `classroom_assignment_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom_assignment_pool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mark` smallint(5) unsigned NOT NULL,
  `assignment_id` int(11) NOT NULL,
  `user_assign_id` int(11) NOT NULL,
  `content` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_assi_assignment_id_586b50c8_fk_classroom_assignment_id` (`assignment_id`),
  KEY `classroom_assignment_pool_e4d3a180` (`user_assign_id`),
  CONSTRAINT `classroom_assi_assignment_id_586b50c8_fk_classroom_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `classroom_assignment` (`id`),
  CONSTRAINT `classroo_user_assign_id_89aeec6b_fk_classroom_user_assignment_id` FOREIGN KEY (`user_assign_id`) REFERENCES `classroom_user_assignment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_assignment_pool`
--

LOCK TABLES `classroom_assignment_pool` WRITE;
/*!40000 ALTER TABLE `classroom_assignment_pool` DISABLE KEYS */;
INSERT INTO `classroom_assignment_pool` VALUES (1,100,1,1,'uploads/2016/03/29/??_6-2-2016_??8.39.jpg'),(2,100,1,1,'uploads/2016/03/29/IMG_2016-01-17_230554.jpg'),(3,100,1,1,'uploads/2016/03/29/IMG_2016-01-17_230554_s52xBT6.jpg'),(4,100,1,1,'uploads/2016/03/29/IMG_2016-01-17_230554_CwKeyLN.jpg'),(5,100,1,1,'uploads/2016/03/29/IMG_2016-01-17_230554_o9Hzo0O.jpg'),(6,100,1,2,'uploads/2016/03/29/vfrontier_interview.jpg');
/*!40000 ALTER TABLE `classroom_assignment_pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_classroom`
--

DROP TABLE IF EXISTS `classroom_classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom_classroom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `shortcode` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `status` varchar(1) NOT NULL,
  `creator_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shortcode` (`shortcode`),
  KEY `classroom_classroom_creator_id_ab812779_fk_user_user_id` (`creator_id`),
  CONSTRAINT `classroom_classroom_creator_id_ab812779_fk_user_user_id` FOREIGN KEY (`creator_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_classroom`
--

LOCK TABLES `classroom_classroom` WRITE;
/*!40000 ALTER TABLE `classroom_classroom` DISABLE KEYS */;
INSERT INTO `classroom_classroom` VALUES (1,'First classroom','first-classroom','test1','O',1);
/*!40000 ALTER TABLE `classroom_classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_classroom_note`
--

DROP TABLE IF EXISTS `classroom_classroom_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom_classroom_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classroom_id` int(11) NOT NULL,
  `note_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_classr_classroom_id_ce4bd5e3_fk_classroom_classroom_id` (`classroom_id`),
  KEY `classroom_classroom_note_2115813b` (`note_id`),
  CONSTRAINT `classroom_classroom_note_note_id_85f47391_fk_classroom_note_id` FOREIGN KEY (`note_id`) REFERENCES `classroom_note` (`id`),
  CONSTRAINT `classroom_classr_classroom_id_ce4bd5e3_fk_classroom_classroom_id` FOREIGN KEY (`classroom_id`) REFERENCES `classroom_classroom` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_classroom_note`
--

LOCK TABLES `classroom_classroom_note` WRITE;
/*!40000 ALTER TABLE `classroom_classroom_note` DISABLE KEYS */;
INSERT INTO `classroom_classroom_note` VALUES (1,1,1);
/*!40000 ALTER TABLE `classroom_classroom_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_material`
--

DROP TABLE IF EXISTS `classroom_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom_material` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime NOT NULL,
  `path` varchar(100) NOT NULL,
  `uploader_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_material_af76a535` (`uploader_id`),
  CONSTRAINT `classroom_m_uploader_id_eda8f3b6_fk_classroom_user_assignment_id` FOREIGN KEY (`uploader_id`) REFERENCES `classroom_user_assignment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_material`
--

LOCK TABLES `classroom_material` WRITE;
/*!40000 ALTER TABLE `classroom_material` DISABLE KEYS */;
INSERT INTO `classroom_material` VALUES (2,'2016-03-27 14:38:29','uploads/2016/03/27/01ZDS615B3A8EBC4153DD0n.jpg',1);
/*!40000 ALTER TABLE `classroom_material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_material_classroom`
--

DROP TABLE IF EXISTS `classroom_material_classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom_material_classroom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classroom_id` int(11) NOT NULL,
  `material_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_materi_classroom_id_2393e5a9_fk_classroom_classroom_id` (`classroom_id`),
  KEY `classroom_material_classroom_eb4b9aaa` (`material_id`),
  CONSTRAINT `classroom_material_material_id_73917cdc_fk_classroom_material_id` FOREIGN KEY (`material_id`) REFERENCES `classroom_material` (`id`),
  CONSTRAINT `classroom_materi_classroom_id_2393e5a9_fk_classroom_classroom_id` FOREIGN KEY (`classroom_id`) REFERENCES `classroom_classroom` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_material_classroom`
--

LOCK TABLES `classroom_material_classroom` WRITE;
/*!40000 ALTER TABLE `classroom_material_classroom` DISABLE KEYS */;
INSERT INTO `classroom_material_classroom` VALUES (1,1,2);
/*!40000 ALTER TABLE `classroom_material_classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_note`
--

DROP TABLE IF EXISTS `classroom_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `publish_datetime` datetime NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_note`
--

LOCK TABLES `classroom_note` WRITE;
/*!40000 ALTER TABLE `classroom_note` DISABLE KEYS */;
INSERT INTO `classroom_note` VALUES (1,'ABOUT THIS SET OF COURSES','\"Databases\" was one of Stanford\'s three inaugural massive open online courses in the fall of 2011; it was offered again in MOOC format in 2013 and 2014. The course is now being offered as a set of smaller self-paced \"mini-courses\", which can be assembled in a variety of ways to learn about different aspects of databases. All of the mini-courses are based around video lectures and/or video demos. Many of them include in-video quizzes to check understanding, in-depth standalone quizzes, and/or a variety of automatically-checked interactive programming exercises. Each mini-course also includes a discussion forum and pointers to readings and resources. Individual mini-courses can be accessed by selecting the title from the dropdown list above. The mini-courses are described briefly below, along with suggested pathways through them. Taught by Professor Jennifer Widom, the overall curriculum draws from Stanford\'s popular Databases course.','2016-04-01 04:31:22','P');
/*!40000 ALTER TABLE `classroom_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_user_assignment`
--

DROP TABLE IF EXISTS `classroom_user_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom_user_assignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assign_date` datetime NOT NULL,
  `role` varchar(3) NOT NULL,
  `classroom_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_user_a_classroom_id_efdb60c1_fk_classroom_classroom_id` (`classroom_id`),
  KEY `classroom_user_assignment_user_id_d5ed8a40_fk_user_user_id` (`user_id`),
  CONSTRAINT `classroom_user_assignment_user_id_d5ed8a40_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `classroom_user_a_classroom_id_efdb60c1_fk_classroom_classroom_id` FOREIGN KEY (`classroom_id`) REFERENCES `classroom_classroom` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_user_assignment`
--

LOCK TABLES `classroom_user_assignment` WRITE;
/*!40000 ALTER TABLE `classroom_user_assignment` DISABLE KEYS */;
INSERT INTO `classroom_user_assignment` VALUES (1,'2016-03-27 14:35:22','TEA',1,1),(2,'2016-03-29 01:51:45','STU',1,11);
/*!40000 ALTER TABLE `classroom_user_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2016-03-25 14:07:49','3','student',1,'Added.',1,1),(2,'2016-03-25 14:08:16','1','admin',1,'Added.',2,1),(3,'2016-03-25 14:30:01','2','add_user_add',1,'Added.',3,1),(4,'2016-03-25 14:30:12','2','allow_user_add',2,'Changed key.',3,1),(5,'2016-03-25 14:30:19','2','allow:user_add',2,'Changed key.',3,1),(6,'2016-03-25 14:46:32','1','admin: allow:user_add',1,'Added.',4,1),(7,'2016-03-25 14:51:13','1','admin: allow:user_add',3,'',4,1),(8,'2016-03-25 14:51:34','4','admin',1,'Added.',1,1),(9,'2016-03-25 14:51:36','1','admin',2,'Changed role.',2,1),(10,'2016-03-25 15:15:56','3','allow:delete_user',1,'Added.',3,1),(11,'2016-03-25 15:16:14','2','allow:user_add',2,'Changed level.',3,1),(12,'2016-03-25 15:16:18','3','allow:delete_user',2,'Changed level.',3,1),(13,'2016-03-25 15:16:25','2','allow:user_add',2,'Changed level.',3,1),(14,'2016-03-25 15:16:29','3','allow:delete_user',2,'Changed level.',3,1),(15,'2016-03-25 15:17:26','4','allow:user_edit',1,'Added.',3,1),(16,'2016-03-25 15:17:35','3','allow:user_delete',2,'Changed key.',3,1),(17,'2016-03-25 15:17:45','3','allow:user_delete',2,'Changed description.',3,1),(18,'2016-03-25 15:31:57','1','Hello World',1,'Added.',27,1),(19,'2016-03-25 15:31:58','1','Hello World',1,'Added.',28,1),(20,'2016-03-25 18:53:12','6','s1501005',3,'',2,1),(21,'2016-03-26 05:08:33','8','',3,'',2,1),(22,'2016-03-26 08:00:11','1','admin',2,'Changed intake_date.',2,1),(23,'2016-03-26 08:00:20','1','admin',2,'Changed intake_date.',2,1),(24,'2016-03-26 08:00:45','9','s1501003',1,'Added.',2,1),(25,'2016-03-26 08:10:09','1','admin',2,'Changed last_logged.',2,1),(26,'2016-03-26 08:31:25','1','admin',2,'Changed address.',2,1),(27,'2016-03-26 10:15:53','1','Sitemap object',1,'Added.',36,1),(28,'2016-03-26 10:16:04','1','Sitemap object',2,'No fields changed.',36,1),(29,'2016-03-26 10:18:15','2','Inbox',1,'Added.',36,1),(30,'2016-03-26 10:19:20','3','Compose message',1,'Added.',36,1),(31,'2016-03-26 10:20:52','4','Timetable',1,'Added.',36,1),(32,'2016-03-26 10:24:55','5','Add event',1,'Added.',36,1),(33,'2016-03-26 10:27:09','6','Booking',1,'Added.',36,1),(34,'2016-03-26 10:29:44','7','Make booking',1,'Added.',36,1),(35,'2016-03-26 10:31:04','8','Report',1,'Added.',36,1),(36,'2016-03-26 10:39:21','9','Management',1,'Added.',36,1),(37,'2016-03-26 10:39:40','10','User management',1,'Added.',36,1),(38,'2016-03-26 10:41:35','11','Attendance management',1,'Added.',36,1),(39,'2016-03-26 10:42:53','12','Facilities management',1,'Added.',36,1),(40,'2016-03-26 10:44:36','13','Site setting',1,'Added.',36,1),(41,'2016-03-26 14:46:34','10','User management',2,'Changed url_route.',36,1),(42,'2016-03-26 14:59:26','13','Site setting',2,'No fields changed.',36,1),(43,'2016-03-26 15:00:00','3','student',2,'Changed level.',1,1),(44,'2016-03-26 15:55:18','1','Lesson object',1,'Added.',15,1),(45,'2016-03-26 15:55:31','2','Lesson object',1,'Added.',15,1),(46,'2016-03-26 15:59:16','1','Lesson object',2,'Changed start_time and end_time.',15,1),(47,'2016-03-26 16:00:26','2','Lesson 2',2,'Changed start_time and end_time.',15,1),(48,'2016-03-26 16:00:43','3','Lesson 3',1,'Added.',15,1),(49,'2016-03-26 16:01:00','4','Lesson 4',1,'Added.',15,1),(50,'2016-03-26 16:01:18','5','Lesson 5',1,'Added.',15,1),(51,'2016-03-26 16:01:28','6','Lesson 6',1,'Added.',15,1),(52,'2016-03-26 16:01:47','7','Lesson 7',1,'Added.',15,1),(53,'2016-03-26 16:33:25','5','allow:booking',1,'Added.',3,1),(54,'2016-03-26 16:46:23','1','Room object',1,'Added.',13,1),(55,'2016-03-26 16:47:22','2','Room object',1,'Added.',13,1),(56,'2016-03-26 16:47:27','1','Room object',2,'Changed plate_name.',13,1),(57,'2016-03-26 16:48:04','3','Room object',1,'Added.',13,1),(58,'2016-03-26 16:48:38','4','Room object',1,'Added.',13,1),(59,'2016-03-26 16:49:16','1','Facilities object',1,'Added.',14,1),(60,'2016-03-26 16:59:12','1','Booking object',1,'Added.',16,1),(61,'2016-03-26 17:03:15','1','Booking object',3,'',16,1),(62,'2016-03-26 17:06:34','2','Booking object',1,'Added.',16,1),(63,'2016-03-27 05:32:02','6','view:booking',1,'Added.',3,1),(64,'2016-03-27 07:07:36','2','Information Technology Learning Centre',1,'Added.',14,1),(65,'2016-03-27 07:24:12','2','105',2,'Changed available.',13,1),(66,'2016-03-27 07:27:26','2','105',2,'Changed available.',13,1),(67,'2016-03-27 07:27:37','2','105',2,'Changed available.',13,1),(68,'2016-03-27 07:40:18','7','view:facilites',1,'Added.',3,1),(69,'2016-03-27 13:01:08','3','Testing',3,'',27,1),(70,'2016-03-27 14:20:53','8','allow:facilities_add',1,'Added.',3,1),(71,'2016-03-27 14:21:14','5','teacher',1,'Added.',1,1),(72,'2016-03-27 14:21:32','6','principal',1,'Added.',1,1),(73,'2016-03-27 14:22:41','7','GO Staff',1,'Added.',1,1),(74,'2016-03-27 14:22:58','8','alumni',1,'Added.',1,1),(75,'2016-03-27 14:36:02','1','First classroom',1,'Added.',17,1),(76,'2016-03-27 14:36:05','1','admin: First classroom [TEA]',1,'Added.',20,1),(77,'2016-03-27 14:36:21','1','Material_type object',1,'Added.',NULL,1),(78,'2016-03-27 14:36:22','1','Material object',1,'Added.',26,1),(79,'2016-03-27 14:38:28','1','Material object',3,'',26,1),(80,'2016-03-27 14:38:39','2','Material object',1,'Added.',26,1),(81,'2016-03-27 15:08:52','7','Hello World',1,'Added.',28,1),(82,'2016-03-27 15:27:13','9','allow:facilities_modify',1,'Added.',3,1),(83,'2016-03-27 15:28:04','9','allow:facilities_edit',2,'Changed key.',3,1),(84,'2016-03-27 15:39:07','10','allow:facilities_delete',1,'Added.',3,1),(85,'2016-03-27 16:18:46','7','allow:view_facilities',2,'Changed key.',3,1),(86,'2016-03-27 16:19:16','7','allow:facilities_view',2,'Changed key.',3,1),(87,'2016-03-28 04:45:48','1','1A',1,'Added.',6,1),(88,'2016-03-28 04:45:54','2','2B',1,'Added.',6,1),(89,'2016-03-28 04:46:01','3','4A',1,'Added.',6,1),(90,'2016-03-28 04:46:16','1','Class_assignment object',1,'Added.',7,1),(91,'2016-03-28 05:08:37','1','Rule object',1,'Added.',31,1),(92,'2016-03-28 05:28:46','2','Attandance object',3,'',30,1),(93,'2016-03-28 05:28:46','1','Attandance object',3,'',30,1),(94,'2016-03-28 05:28:55','1','Normal',3,'',31,1),(95,'2016-03-28 05:31:09','2','Normal school day',1,'Added.',31,1),(96,'2016-03-28 05:31:24','1','Applied_rule object',1,'Added.',32,1),(97,'2016-03-28 06:18:30','11','allow:attendance_view',1,'Added.',3,1),(98,'2016-03-28 06:18:47','11','allow:attendance_edit',2,'Changed key and description.',3,1),(99,'2016-03-28 06:50:16','4','Applied_rule object',3,'',32,1),(100,'2016-03-28 06:50:16','3','Applied_rule object',3,'',32,1),(101,'2016-03-28 06:50:16','2','Applied_rule object',3,'',32,1),(102,'2016-03-28 06:50:16','1','Applied_rule object',3,'',32,1),(103,'2016-03-28 08:44:09','6','Applied_rule object',1,'Added.',32,1),(104,'2016-03-28 08:44:15','7','Applied_rule object',1,'Added.',32,1),(105,'2016-03-28 11:47:58','12','allow:classroom_viewall',1,'Added.',3,1),(106,'2016-03-28 11:48:19','12','allow:classroom_viewall',2,'Changed level.',3,1),(107,'2016-03-28 11:50:45','12','allow:classroom_all',2,'Changed key and description.',3,1),(108,'2016-03-28 13:12:30','12','allow:classroom_all',2,'Changed level.',3,1),(109,'2016-03-29 01:51:51','2','s1501004: First classroom [STU]',1,'Added.',20,1),(110,'2016-03-29 02:03:32','9','Management',2,'Changed url_route.',36,1),(111,'2016-03-29 03:00:39','1','Announce object',1,'Added.',18,1),(112,'2016-03-29 08:11:41','1','Assignment_format object',1,'Added.',44,1),(113,'2016-03-29 10:22:04','131','Kong Tony',3,'',2,1),(114,'2016-03-29 11:04:39','2','Class_assignment object',1,'Added.',7,1),(115,'2016-03-29 12:47:38','14','My Booking',1,'Added.',36,1),(116,'2016-03-29 14:17:07','6','Booking',2,'Changed url_route.',36,1),(117,'2016-03-29 14:23:59','5','Add event',3,'',36,1),(118,'2016-03-29 14:23:59','4','Timetable',3,'',36,1),(119,'2016-03-29 15:03:09','13','allow:site_edit',1,'Added.',3,1),(120,'2016-04-01 01:38:22','1','Attandance object',1,'Added.',30,1),(121,'2016-04-01 01:38:27','2','Attandance object',1,'Added.',30,1),(122,'2016-04-01 01:38:32','3','Attandance object',1,'Added.',30,1),(123,'2016-04-01 01:38:35','4','Attandance object',1,'Added.',30,1),(124,'2016-04-01 01:38:39','5','Attandance object',1,'Added.',30,1),(125,'2016-04-01 01:38:56','4','1B',1,'Added.',6,1),(126,'2016-04-01 01:54:06','5','1C',1,'Added.',6,1),(127,'2016-04-01 01:54:13','6','1D',1,'Added.',6,1),(128,'2016-04-01 01:54:18','7','1E',1,'Added.',6,1),(129,'2016-04-01 01:54:31','8','2A',1,'Added.',6,1),(130,'2016-04-01 01:54:39','9','2C',1,'Added.',6,1),(131,'2016-04-01 01:54:55','10','2D',1,'Added.',6,1),(132,'2016-04-01 01:55:01','11','2E',1,'Added.',6,1),(133,'2016-04-01 01:55:11','12','3A',1,'Added.',6,1),(134,'2016-04-01 01:55:19','13','3B',1,'Added.',6,1),(135,'2016-04-01 01:55:24','14','3C',1,'Added.',6,1),(136,'2016-04-01 01:55:30','15','3D',1,'Added.',6,1),(137,'2016-04-01 01:55:37','16','3E',1,'Added.',6,1),(138,'2016-04-01 03:07:40','17','4B',1,'Added.',6,1),(139,'2016-04-01 03:07:44','18','4C',1,'Added.',6,1),(140,'2016-04-01 03:07:49','19','5A',1,'Added.',6,1),(141,'2016-04-01 03:07:54','20','5B',1,'Added.',6,1),(142,'2016-04-01 03:08:00','21','5C',1,'Added.',6,1),(143,'2016-04-01 03:08:07','22','6A',1,'Added.',6,1),(144,'2016-04-01 03:08:12','23','6B',1,'Added.',6,1),(145,'2016-04-01 03:08:17','24','6C',1,'Added.',6,1),(146,'2016-04-01 03:25:38','16','Wing Lam Cheung',2,'Changed sex_code.',2,1),(147,'2016-04-01 03:26:11','3','Class_assignment object',1,'Added.',7,1),(148,'2016-04-01 03:26:17','4','Class_assignment object',1,'Added.',7,1),(149,'2016-04-01 04:31:02','2','Pictures(jpg, png, svg) (jpg,png,svg)',1,'Added.',44,1),(150,'2016-04-01 04:31:10','2','Pictures (jpg,png,svg)',2,'Changed datatype.',44,1),(151,'2016-04-01 04:33:06','1','Note object',1,'Added.',22,1),(152,'2016-04-01 04:33:31','1','Classroom_note object',1,'Added.',23,1),(153,'2016-04-01 04:33:48','1','Material_classroom object',1,'Added.',43,1),(154,'2016-04-01 04:34:39','1','Report_type object',1,'Added.',33,1),(155,'2016-04-01 04:34:58','2','Report_type object',1,'Added.',33,1),(156,'2016-04-01 04:35:05','3','Report_type object',1,'Added.',33,1),(157,'2016-04-01 04:35:26','1','Schoolinfo object',1,'Added.',35,1),(158,'2016-04-01 04:35:35','2','Schoolinfo object',1,'Added.',35,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (37,'admin','logentry'),(32,'attendance','applied_rule'),(30,'attendance','attandance'),(31,'attendance','rule'),(39,'auth','group'),(38,'auth','permission'),(40,'auth','user'),(16,'booking','booking'),(15,'booking','lesson'),(18,'classroom','announce'),(19,'classroom','assignment'),(44,'classroom','assignment_format'),(21,'classroom','assignment_pool'),(17,'classroom','classroom'),(23,'classroom','classroom_note'),(26,'classroom','material'),(43,'classroom','material_classroom'),(22,'classroom','note'),(20,'classroom','user_assignment'),(41,'contenttypes','contenttype'),(14,'facilities','facilities'),(13,'facilities','room'),(28,'inbox','inbox'),(27,'inbox','inbox_content'),(34,'report','report'),(33,'report','report_type'),(42,'sessions','session'),(35,'siteinfo','schoolinfo'),(36,'siteinfo','sitemap'),(10,'timetable','activity_event'),(11,'timetable','calendar'),(9,'timetable','event_terms'),(12,'timetable','timetable'),(8,'timetable','time_meta'),(7,'user','class_assignment'),(6,'user','class_code'),(5,'user','parent_contact'),(4,'user','permission'),(3,'user','permission_meta'),(1,'user','role'),(2,'user','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2016-03-25 14:01:11'),(2,'auth','0001_initial','2016-03-25 14:01:11'),(3,'admin','0001_initial','2016-03-25 14:01:11'),(4,'admin','0002_logentry_remove_auto_add','2016-03-25 14:01:11'),(5,'user','0001_initial','2016-03-25 14:01:11'),(6,'attendance','0001_initial','2016-03-25 14:01:11'),(7,'contenttypes','0002_remove_content_type_name','2016-03-25 14:01:12'),(8,'auth','0002_alter_permission_name_max_length','2016-03-25 14:01:12'),(9,'auth','0003_alter_user_email_max_length','2016-03-25 14:01:12'),(10,'auth','0004_alter_user_username_opts','2016-03-25 14:01:12'),(11,'auth','0005_alter_user_last_login_null','2016-03-25 14:01:12'),(12,'auth','0006_require_contenttypes_0002','2016-03-25 14:01:12'),(13,'auth','0007_alter_validators_add_error_messages','2016-03-25 14:01:12'),(14,'facilities','0001_initial','2016-03-25 14:01:12'),(15,'booking','0001_initial','2016-03-25 14:01:12'),(16,'classroom','0001_initial','2016-03-25 14:01:12'),(17,'inbox','0001_initial','2016-03-25 14:01:12'),(18,'report','0001_initial','2016-03-25 14:01:12'),(19,'sessions','0001_initial','2016-03-25 14:01:12'),(20,'siteinfo','0001_initial','2016-03-25 14:01:12'),(21,'timetable','0001_initial','2016-03-25 14:01:13'),(22,'user','0002_auto_20160325_2226','2016-03-25 14:27:01'),(23,'user','0003_auto_20160325_2229','2016-03-25 14:29:54'),(24,'user','0004_auto_20160326_1557','2016-03-26 07:58:20'),(25,'user','0005_auto_20160326_1609','2016-03-26 08:09:25'),(26,'siteinfo','0002_sitemap_order','2016-03-26 10:13:27'),(27,'siteinfo','0003_auto_20160326_1815','2016-03-26 10:15:40'),(28,'booking','0002_auto_20160327_0105','2016-03-26 17:06:17'),(29,'booking','0003_auto_20160327_0150','2016-03-26 17:51:18'),(30,'facilities','0002_auto_20160327_1536','2016-03-27 07:36:48'),(31,'inbox','0002_auto_20160327_1859','2016-03-27 10:59:25'),(32,'facilities','0003_room_capacity','2016-03-27 16:03:14'),(33,'user','0006_auto_20160328_1157','2016-03-28 03:57:31'),(34,'user','0007_auto_20160328_1158','2016-03-28 03:59:07'),(35,'attendance','0002_applied_rule_exclude_weekend','2016-03-28 05:30:22'),(36,'attendance','0003_auto_20160328_1453','2016-03-28 06:53:29'),(37,'classroom','0002_auto_20160328_1751','2016-03-28 09:52:23'),(38,'classroom','0003_auto_20160328_1843','2016-03-28 10:43:47'),(39,'classroom','0004_auto_20160329_1251','2016-03-29 04:52:01'),(40,'classroom','0005_auto_20160329_1303','2016-03-29 05:03:12'),(41,'user','0008_auto_20160329_1816','2016-03-29 10:16:59'),(42,'user','0009_auto_20160401_0619','2016-03-31 22:20:00');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0afb3mywwb9dkcjooxw67hnlkfdnmerg','NDE5Y2E4OGE0MWNkZTIzOWNlNWMwNDEyMmZhYjk5YjgyNDgzZGZiNTp7InVzZXIiOiJhZG1pbiIsIl9zZXNzaW9uX2V4cGlyeSI6NzIwMCwidG9rZW4iOiJrTEVMTGt1Q1EycWUkOWEyODkwM2RiMmU1ZDliZjc3ZTA4YzgxYzY3M2Y1NzIifQ==','2016-03-29 07:58:06'),('23gcbpex5iuobmvrnbkeo5x4pog4keka','ZmUzNDY5MjZhYTdhNzdjYTY3YTMwZmFhM2U4ZTA4NzAyOGY2Mzg0Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDhlNDRiYmJjNThjM2YwNGM4MTkwNGYxYWMyZDdjNjM2MmY4NDI4NCIsIl9hdXRoX3VzZXJfaWQiOiIxIiwiX3Nlc3Npb25fZXhwaXJ5Ijo3MjAwLCJ0b2tlbiI6IjkzRmtDMHhYSWxORCRkNzQ4NTZiYzAyNjZkMDdmMTVmYTMwZjc3ZDcxM2JhMCIsInVzZXIiOiJhZG1pbiJ9','2016-03-29 11:25:38'),('2qftrnvgd8azu3ffw3rrps3pkhtbrzec','MmJiNzE3MDc3OWM5Y2RiN2U2MjRhMWY2NWJmMGYyZWJmNzczZDIwNTp7InRva2VuIjoiSVdhUkNlSG1VS3ZwJDcxOTdiOWE4NzAxNjdjNTEyYjFjNDg0ODE1ODU5MWRiIiwidXNlciI6ImFkbWluIiwiX3Nlc3Npb25fZXhwaXJ5Ijo3MjAwfQ==','2016-03-28 18:29:35'),('3a3l9cohx6u4cdemt0m7bu78ic8ed7u1','MjYzY2Y3Y2Q2OWM1Yzk5MWI3MTFmYTdlMjFiNGE2ODg2Mjk3ZGRjMDp7Il9zZXNzaW9uX2V4cGlyeSI6NzIwMH0=','2016-04-01 09:12:13'),('3ahab6wfy6ksmpb8jwboqskgaz5g5bv1','ZWRlNWM4MGRiNzM4NWFhMmFhMWY0NDYzOGNiZjUxM2VkMzQzNWNmNTp7Il9hdXRoX3VzZXJfaGFzaCI6IjA4ZTQ0YmJiYzU4YzNmMDRjODE5MDRmMWFjMmQ3YzYzNjJmODQyODQiLCJfc2Vzc2lvbl9leHBpcnkiOjcyMDAsInVzZXIiOiJhZG1pbiIsInRva2VuIjoiRnB1dnFVYU1welowJGQ5YWI3N2QxMmViNDBjODU1ZmU0NzYzMmZhMGU4ZmM4IiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2016-03-27 15:12:31'),('6mm1tlv2zhk0nj8qvtfbzan4xlquqcup','MzcyZTNlMzMxM2Y4M2Q3NzA1ZDRhNGUyN2M4MmM3MWQ0YjZjMzZiYzp7Il9zZXNzaW9uX2V4cGlyeSI6NzIwMCwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJ0b2tlbiI6Ijk3VWNrcHQ4UnNpbSRiOTg4OTMxYmZhMTZjZmUzYjRlYjM3MDBkMDhjYWI2MSIsIl9hdXRoX3VzZXJfaGFzaCI6IjA4ZTQ0YmJiYzU4YzNmMDRjODE5MDRmMWFjMmQ3YzYzNjJmODQyODQiLCJfYXV0aF91c2VyX2lkIjoiMSIsInVzZXIiOiJhZG1pbiJ9','2016-03-27 08:31:15'),('89wiboymn1le8oay0ywen3pbgaxki1a9','NWFmYWU2MDc2M2ZiNjBlMDkxMzY3MTA2NTMyZDcwMTg4YzAyOWFmYjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJ1c2VyIjoiYWRtaW4iLCJfc2Vzc2lvbl9leHBpcnkiOjcyMDAsInRva2VuIjoiWTJMcVNOaVBKTVNTJGZmZGVhMDMyN2VlYTAxODJhNjBmMDQ0NjMzYzk5ZjEwIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDhlNDRiYmJjNThjM2YwNGM4MTkwNGYxYWMyZDdjNjM2MmY4NDI4NCJ9','2016-03-29 03:58:17'),('a5qplhlx5yuy0wncwyjhddjhgm3qif39','MmNmMTMxMTI1ZTVhM2NhNjQzNDgxOTdkYjMzZTRlMzA2NmZjZGI0Yzp7Il9zZXNzaW9uX2V4cGlyeSI6NzIwMCwidG9rZW4iOiJnTWJ5Z3Z3Q3FqQzUkNTFiMDlhZGFhYzY2Mzg1M2JjYmQ1M2FjYzc1NTAzZTgiLCJ1c2VyIjoiYWRtaW4ifQ==','2016-03-29 16:08:52'),('agree5wrpb576rmc2numhr9dky0on9a4','ZDAzNzE1NjQ0MDM1YzAyYmY2ZTRmMDg3ODc3NzllZTZjNmJjMTExYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwidXNlciI6ImFkbWluIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwOGU0NGJiYmM1OGMzZjA0YzgxOTA0ZjFhYzJkN2M2MzYyZjg0Mjg0IiwiX3Nlc3Npb25fZXhwaXJ5Ijo3MjAwLCJ0b2tlbiI6ImNoeGVVWFN1ZTB2NSRjNGMyMTQ3MmZjZDIwMjc1ZWQ3NjRjNmQ5NmQ2OTE1MCJ9','2016-03-28 14:38:07'),('b8o6pfb3czhzu5qo3pyk11w97l5jhuqv','NGUzZTZkNTIyYTUzNDM3OWE2NzAzYzQwM2VlNzgyOWFiZjRkNTBmYTp7Il9hdXRoX3VzZXJfaGFzaCI6IjA4ZTQ0YmJiYzU4YzNmMDRjODE5MDRmMWFjMmQ3YzYzNjJmODQyODQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9zZXNzaW9uX2V4cGlyeSI6NzIwMCwiX2F1dGhfdXNlcl9pZCI6IjEiLCJ1c2VyIjoiYWRtaW4iLCJ0b2tlbiI6InhleVdaRWtVSm9VQyRlMTUyZDk0YjRlNjI5MTNlYzIxODAwZGY3N2NkZDY4OSJ9','2016-03-26 07:59:46'),('b9f7pkfeby2n47aqt1z76lnvtcd4r9up','MWQ1M2JiOWRiZGM4N2NlNjBiMmY0MTEzMWRmOGRkNDFkZDE2ZGU1ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwidG9rZW4iOiJjRTlWNGNqZnRQN3kkZDZlNzE4YzJjMDE0YWMzMDEwODFkYmJlZmRkYjdlOTgiLCJfYXV0aF91c2VyX2lkIjoiMSIsInVzZXIiOiJhZG1pbiIsIl9zZXNzaW9uX2V4cGlyeSI6NzIwMCwiX2F1dGhfdXNlcl9oYXNoIjoiMDhlNDRiYmJjNThjM2YwNGM4MTkwNGYxYWMyZDdjNjM2MmY4NDI4NCJ9','2016-03-29 16:08:34'),('crgnok3sv3sf29g08pia2ip8r4ffiz71','NmQ3Mzc2Yzg1MmQ5NTg3ZTVjYTNhMTgyMzM4YzIzYzFjMTJiMTY5Yjp7Il9hdXRoX3VzZXJfaGFzaCI6IjA4ZTQ0YmJiYzU4YzNmMDRjODE5MDRmMWFjMmQ3YzYzNjJmODQyODQiLCJ1c2VyIjoiYWRtaW4iLCJ0b2tlbiI6IndxZ04yQlVUbVNMcyRhYjM1ZDIxZjdjZTdjY2M1NjZhZTE3ZjMwODY3ZjcxNiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX3Nlc3Npb25fZXhwaXJ5Ijo3MjAwLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2016-03-28 09:21:12'),('cro9453psowqbgnv6n3lq715oda4bngl','Nzc3NGJkYmZjYTgwYjNiOGUxYzQzMDg0ZmEwYmM5Zjg2MzgwOTNlYzp7InRva2VuIjoiZHlCdE5nR2h0bXU0JDEzNjM2MGE1NGE2ZGUwYzJkYmIyY2YzYmUyNmU4ZTQzIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDhlNDRiYmJjNThjM2YwNGM4MTkwNGYxYWMyZDdjNjM2MmY4NDI4NCIsIl9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJ1c2VyIjoia2tjIiwiX3Nlc3Npb25fZXhwaXJ5Ijo3MjAwfQ==','2016-04-01 00:20:40'),('cw78xu6eyxotxaxs7k3zevq962w2jvrh','MGU3ZTRiYzNhMzhmODBlMTVmYzc1NGNiYzk1MDEyMTgzMGUwYTVlNjp7Il9zZXNzaW9uX2V4cGlyeSI6NzIwMCwidG9rZW4iOiJPdkc2bnhXQTU3TnokMTgyZDA1MTg3YzFiMmE0MDVkNTFjMjFjNmFjNTljMDAiLCJ1c2VyIjoiYWRtaW4iLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDhlNDRiYmJjNThjM2YwNGM4MTkwNGYxYWMyZDdjNjM2MmY4NDI4NCJ9','2016-03-28 06:28:47'),('ebuu3tqafvrbvpfr8zzbri5zfafixvoc','MjdkZmE2M2EwOGNkNTNmODUwZDIyZDY5MTcwOWM2ZDZlYjdhNDFlNjp7InRva2VuIjoiMG1mZkJBNzNXRmZaJDI2NWY5MDI1YTgwYWI4OWI0MjgxMTdmZjk3ZTVlMjE3IiwiX2F1dGhfdXNlcl9oYXNoIjoiMDhlNDRiYmJjNThjM2YwNGM4MTkwNGYxYWMyZDdjNjM2MmY4NDI4NCIsIl9zZXNzaW9uX2V4cGlyeSI6NzIwMCwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsInVzZXIiOiJhZG1pbiJ9','2016-03-29 07:42:41'),('f8glb9ekqsumizpo3tb424lryieqt6i5','MDFlZmMyOWFiYjk4Y2NkYjA5ZDQ1OWJiMDdiNzdjYmM1YjY1N2E4Yjp7InRva2VuIjoiU25rcEptOWRqYkJSJDljOTY3YTEyMzYxNmU3Y2FkYmM4ODM4NWI1MDY4MzhjIiwidXNlciI6ImFkbWluIiwiX3Nlc3Npb25fZXhwaXJ5Ijo3MjAwfQ==','2016-03-31 09:15:05'),('g3bi18iw280apu41cf10lytzadd27bm5','N2U2YzdmOTczMDllYjg2YmZiZjg4YmUyMjEyYWUxNjM2YmQ1YmFiZjp7InVzZXIiOiJhZG1pbiIsIl9zZXNzaW9uX2V4cGlyeSI6NzIwMCwidG9rZW4iOiJmSUsxbXd6YWhCWDIkMDBlNDMwMzJlZDVmMjgyOTRlNWU4NjI4ZmE5Yjg2NTkiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDhlNDRiYmJjNThjM2YwNGM4MTkwNGYxYWMyZDdjNjM2MmY4NDI4NCJ9','2016-03-31 21:51:41'),('hr1pcdsvix9v0x8vgvg8956ime0k2o4o','MTYzOWJmN2FmNDkxMDk3MGU4ZWEwZGNiMmE5YTg3OTFhZjMyM2U4ZTp7InRva2VuIjoiOU5adHpCbElkVjF5JDYyMjVjYmYzZTEzZWY2ZDliYTcyNDkwYmI1Yjk1N2ZmIiwiX3Nlc3Npb25fZXhwaXJ5Ijo3MjAwLCJ1c2VyIjoiYWRtaW4ifQ==','2016-03-30 18:59:49'),('lhgsp28m2vfsv8xic0mc2xftglev3uei','MzE3NmRiZjcwMmY1NTg1Yzc2MzIzNTU0OTA4MDIxM2Y2MTJjOTVhNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDhlNDRiYmJjNThjM2YwNGM4MTkwNGYxYWMyZDdjNjM2MmY4NDI4NCIsIl9zZXNzaW9uX2V4cGlyeSI6NzIwMCwidXNlciI6ImFkbWluIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJ0b2tlbiI6Imd4WWIxaE9sbGtiNSQ4YmIzZTdjN2RkNTBhZTQyMTQ3MDdlZDZlYTg3ZDBlNSJ9','2016-03-25 17:32:12'),('nyrgwept2s0fv0r6aba3kd5icxv19n48','OTU0Yzk4Y2IwYjIwMzQ5YWE5NzUwYjM1MWIxNGQwYjNmMmNlYjNhZTp7InVzZXIiOiJhZG1pbiIsInRva2VuIjoia0NxRldrb0g2bG9wJDNjNzQ4ZGMzN2NiNDg3NzMxN2U3NGJlODVlMzFkNmUzIiwiX3Nlc3Npb25fZXhwaXJ5Ijo3MjAwfQ==','2016-03-30 02:23:12'),('p0fxpidooyu1a3fimect5lqedom85b1t','NjkwYzUwMTEwNGY1MTMzZjdkNGY0MmRlMTA3MWI1ZThmNjE2NjNmNDp7Il9zZXNzaW9uX2V4cGlyeSI6NzIwMCwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSIsInRva2VuIjoiQnlqUVQ1UHlNNm13JDBkMWI2YTZjYzc5M2NmNjVjMzA1MGZlOGRkMTBiZWYwIiwidXNlciI6ImFkbWluIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDhlNDRiYmJjNThjM2YwNGM4MTkwNGYxYWMyZDdjNjM2MmY4NDI4NCJ9','2016-03-27 18:52:51'),('pgpj7qjnk3h5j71qunx7ljb1ktgo3f9a','ZDBkN2ZlZTBhY2IwMWJkNjY2YmQ4MTQyMGZkYzdhZGU0ZTllODU3MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwidG9rZW4iOiJmZjdBbVNrUUdpOFYkOTBmYWZjMTAyNjAwZTY5OWFjZGRhZGNiNjUxZTZjOTUiLCJfc2Vzc2lvbl9leHBpcnkiOjcyMDAsIl9hdXRoX3VzZXJfaWQiOiIxIiwidXNlciI6ImFkbWluIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDhlNDRiYmJjNThjM2YwNGM4MTkwNGYxYWMyZDdjNjM2MmY4NDI4NCJ9','2016-03-27 12:53:10'),('slztght2v3czgzsp14hry5bv26v1kpk3','ZTVkOWFmNmVlOTRiNDVlY2M2NzFkOGNkMDMyZmY2MjI3ODUxYWJlOTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX3Nlc3Npb25fZXhwaXJ5Ijo3MjAwLCJ1c2VyIjoiYWRtaW4iLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjA4ZTQ0YmJiYzU4YzNmMDRjODE5MDRmMWFjMmQ3YzYzNjJmODQyODQiLCJ0b2tlbiI6Ikp3WmlhTVBqNjFJRCRjNzBjYjcxMDljNjRjMTgxZDgzYTc5ZWE2MGM2MjBiMyJ9','2016-04-01 06:14:32'),('vb5fsncu07gz6ad0vol7kiti4iwsem52','N2Y2NzY0YjlmYTJhN2ZmYWFlNzEzZmZjNzBkYmE1YTQzZWY2YjIyNjp7Il9zZXNzaW9uX2V4cGlyeSI6NzIwMCwidXNlciI6ImFkbWluIiwidG9rZW4iOiJKdHdnTkhhVlFIQ2IkZjNhNzYwN2FmZmE4ZGNhOWY5ZmQwNmVjOTZiZTQwYjEifQ==','2016-03-28 11:22:19'),('vudajliho8r6xd14mo2cr82c6h3kf0md','OWE2Y2NmNTRjNWVmYWM4NjY3MDY2MTU5ZWMwNjhlMjZmODBjZmQzODp7Il9hdXRoX3VzZXJfaGFzaCI6IjA4ZTQ0YmJiYzU4YzNmMDRjODE5MDRmMWFjMmQ3YzYzNjJmODQyODQiLCJfc2Vzc2lvbl9leHBpcnkiOjcyMDAsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJ1c2VyIjoiYWRtaW4iLCJ0b2tlbiI6InVhcmVERGl6dzJObiQ2ZTE2ZWIxNzlhNjAzN2M1ZjM2MGEwY2UzN2RiZDY3OCJ9','2016-03-26 18:24:16'),('wf5f78wmbrilr6xj8i3p2rycsbt1dcer','NjE2OGI1ZDI0Y2ZlZmVjZDFkNmU1MTI4YzNiNTNmOTdmNzE5ZjdiMTp7InVzZXIiOiJhZG1pbiIsInRva2VuIjoiQjhzNWN5Y1M4emN2JGNjY2RjNTc2NGM4MWM4MjAxNmMyZmRmM2Y4Y2Q2MjM1IiwiX3Nlc3Npb25fZXhwaXJ5Ijo3MjAwfQ==','2016-03-31 03:48:08'),('xf4jl5ep268phoz0q5jur3lisartzvli','Yzc0NzUwZWNjMzg4YmE1NzI3YWNkYjk2NmRhY2JmNzJiOTNmODE3ODp7Il9zZXNzaW9uX2V4cGlyeSI6NzIwMCwidG9rZW4iOiJXaEtuSHpZSTBDNUUkY2M5NTUxMmJkNGYwMWJmMDdlYjJlODJkNDZiNTRlN2EiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDhlNDRiYmJjNThjM2YwNGM4MTkwNGYxYWMyZDdjNjM2MmY4NDI4NCIsInVzZXIiOiJhZG1pbiJ9','2016-03-25 20:49:29'),('yb9yn6h4g45vtilwk13mynx4jzwt7yts','NzI2YTQwZDAyNGQ5M2NmZjM0ODRlYTA5NjkzNTcwY2JlZjk3NjcwYTp7Il9zZXNzaW9uX2V4cGlyeSI6NzIwMCwiX2F1dGhfdXNlcl9pZCI6IjEiLCJ0b2tlbiI6Im9EenhOeEFUYUtOViQ4MTg5MGUyZmU2ODk4OWEzNmJkZmJlYmE2ZDlkYTkwZCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDhlNDRiYmJjNThjM2YwNGM4MTkwNGYxYWMyZDdjNjM2MmY4NDI4NCIsInVzZXIiOiJzMTUwMTAyOCJ9','2016-03-26 11:38:45'),('yrb3462q4wmqcb2xqr3pq3ydn2yhv41h','NmJhZDAzNjY0M2U2YTc4OWYwM2UxNzM4NDA4N2FkNzA3Mjg0MzAwYTp7InRva2VuIjoibG5oUVphMTRYSXprJGIyN2VhZDFjYzJjYTZjZGVmZjJjYTMzZTcyZGJjOWYzIiwidXNlciI6ImFkbWluIiwiX3Nlc3Npb25fZXhwaXJ5Ijo3MjAwfQ==','2016-03-28 19:10:11');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facilities_facilities`
--

DROP TABLE IF EXISTS `facilities_facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facilities_facilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `room_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `facilities_facilities_room_id_f06ad5af_uniq` (`room_id`),
  KEY `facilities_facilities_8273f993` (`room_id`),
  CONSTRAINT `facilities_facilities_room_id_f06ad5af_fk_facilities_room_id` FOREIGN KEY (`room_id`) REFERENCES `facilities_room` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facilities_facilities`
--

LOCK TABLES `facilities_facilities` WRITE;
/*!40000 ALTER TABLE `facilities_facilities` DISABLE KEYS */;
INSERT INTO `facilities_facilities` VALUES (1,'Multimedia Learning Centre',4),(3,'School CampusTV',3),(5,'Hall',5),(6,'Ro3om',6);
/*!40000 ALTER TABLE `facilities_facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facilities_room`
--

DROP TABLE IF EXISTS `facilities_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facilities_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate_name` varchar(6) NOT NULL,
  `floor` varchar(1) NOT NULL,
  `description` varchar(255) NOT NULL,
  `available` tinyint(1) NOT NULL,
  `capacity` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facilities_room`
--

LOCK TABLES `facilities_room` WRITE;
/*!40000 ALTER TABLE `facilities_room` DISABLE KEYS */;
INSERT INTO `facilities_room` VALUES (3,'510','5','Room 510',1,0),(4,'204','2','Room 204',1,0),(5,'H1','2','Hall',1,500),(6,'150','1','rm 150',1,80);
/*!40000 ALTER TABLE `facilities_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inbox_inbox`
--

DROP TABLE IF EXISTS `inbox_inbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inbox_inbox` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `send_datetime` datetime NOT NULL,
  `read` tinyint(1) NOT NULL,
  `content_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `inbox_inbox_e14f02ad` (`content_id`),
  KEY `inbox_inbox_d41c2251` (`receiver_id`),
  KEY `inbox_inbox_924b1846` (`sender_id`),
  CONSTRAINT `inbox_inbox_content_id_166823dd_fk_inbox_inbox_content_id` FOREIGN KEY (`content_id`) REFERENCES `inbox_inbox_content` (`id`),
  CONSTRAINT `inbox_inbox_receiver_id_92b958fa_fk_user_user_id` FOREIGN KEY (`receiver_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `inbox_inbox_sender_id_3d895d80_fk_user_user_id` FOREIGN KEY (`sender_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbox_inbox`
--

LOCK TABLES `inbox_inbox` WRITE;
/*!40000 ALTER TABLE `inbox_inbox` DISABLE KEYS */;
INSERT INTO `inbox_inbox` VALUES (1,'2016-03-25 15:31:58',1,1,1,1),(4,'2016-03-27 13:11:39',1,5,1,1),(5,'2016-03-27 13:11:39',0,5,111,1),(8,'2016-03-27 16:35:21',1,7,1,61),(9,'2016-03-27 16:37:21',0,8,111,61),(10,'2016-03-27 16:37:21',0,8,62,61),(11,'2016-03-27 16:54:08',1,9,1,1),(14,'2016-03-29 02:28:24',0,12,62,1),(15,'2016-03-29 02:28:24',0,12,111,1),(16,'2016-03-29 12:58:08',1,13,1,1);
/*!40000 ALTER TABLE `inbox_inbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inbox_inbox_content`
--

DROP TABLE IF EXISTS `inbox_inbox_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inbox_inbox_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbox_inbox_content`
--

LOCK TABLES `inbox_inbox_content` WRITE;
/*!40000 ALTER TABLE `inbox_inbox_content` DISABLE KEYS */;
INSERT INTO `inbox_inbox_content` VALUES (1,'Hello World','A good day.'),(2,'[\'No title\']','[\'\']'),(4,'Testing','First message'),(5,'No title','test'),(6,'Hi admin','hihi\r\n\\dfdf\r\n\r\ndfdfdf'),(7,'Hi admin','hihi'),(8,'No title','suds'),(9,'Re: Hi admin','hihi\r\n\r\n#####\r\nReply:\r\nHi admin'),(10,'Re: No title','hi admin\r\n\r\n\r\n\r\n\r\n#####\r\n>> Reply:\r\nNo title'),(11,'ererer','hihi'),(12,'No title','hihi'),(13,'No title','hi admin'),(14,'No title','Break line \r\n\r\ntest\r\n\r\nha\r\nha\r\nhh\r\naa');
/*!40000 ALTER TABLE `inbox_inbox_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_report`
--

DROP TABLE IF EXISTS `report_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `generate_datetime` datetime NOT NULL,
  `report_type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `report_report_42a62d8b` (`report_type_id`),
  KEY `report_report_e8701ad4` (`user_id`),
  CONSTRAINT `report_report_report_type_id_93f63394_fk_report_report_type_id` FOREIGN KEY (`report_type_id`) REFERENCES `report_report_type` (`id`),
  CONSTRAINT `report_report_user_id_97759155_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_report`
--

LOCK TABLES `report_report` WRITE;
/*!40000 ALTER TABLE `report_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_report_type`
--

DROP TABLE IF EXISTS `report_report_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_report_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `layout_json` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_report_type`
--

LOCK TABLES `report_report_type` WRITE;
/*!40000 ALTER TABLE `report_report_type` DISABLE KEYS */;
INSERT INTO `report_report_type` VALUES (1,'Attendant Report','Attendant Report','[]'),(2,'Class student list','Class student list','[]'),(3,'All student list','All student list','[]');
/*!40000 ALTER TABLE `report_report_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `siteinfo_schoolinfo`
--

DROP TABLE IF EXISTS `siteinfo_schoolinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `siteinfo_schoolinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `infokey` varchar(255) NOT NULL,
  `infoval` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `infokey` (`infokey`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `siteinfo_schoolinfo`
--

LOCK TABLES `siteinfo_schoolinfo` WRITE;
/*!40000 ALTER TABLE `siteinfo_schoolinfo` DISABLE KEYS */;
INSERT INTO `siteinfo_schoolinfo` VALUES (1,'school_name','HGC College'),(2,'school_tel','24752152');
/*!40000 ALTER TABLE `siteinfo_schoolinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `siteinfo_sitemap`
--

DROP TABLE IF EXISTS `siteinfo_sitemap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `siteinfo_sitemap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `level` smallint(5) unsigned NOT NULL,
  `url_route` varchar(255) NOT NULL,
  `top_level_id` int(11) DEFAULT NULL,
  `order` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `siteinfo_sitemap_top_level_id_9f3d0bc1_fk_siteinfo_sitemap_id` (`top_level_id`),
  CONSTRAINT `siteinfo_sitemap_top_level_id_9f3d0bc1_fk_siteinfo_sitemap_id` FOREIGN KEY (`top_level_id`) REFERENCES `siteinfo_sitemap` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `siteinfo_sitemap`
--

LOCK TABLES `siteinfo_sitemap` WRITE;
/*!40000 ALTER TABLE `siteinfo_sitemap` DISABLE KEYS */;
INSERT INTO `siteinfo_sitemap` VALUES (1,'Classroom',1,'classroom:classroom_list',NULL,1),(2,'Inbox',1,'inbox:inbox',NULL,2),(3,'Compose message',1,'inbox:compose',2,1),(6,'Booking',2,'booking:all',NULL,3),(7,'Make booking',2,'booking:reserve',6,1),(8,'Report',3,'report:index',NULL,4),(9,'Management',4,'user:list_user',NULL,5),(10,'User management',4,'user:list_user',9,1),(11,'Attendance management',3,'attendance:rulelist',9,2),(12,'Facilities management',4,'facilities:index',9,3),(13,'Site setting',5,'siteinfo:overview',9,4),(14,'My Booking',1,'booking:index',6,1);
/*!40000 ALTER TABLE `siteinfo_sitemap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timetable_activity_event`
--

DROP TABLE IF EXISTS `timetable_activity_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timetable_activity_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `activity_name_id` int(11) NOT NULL,
  `end_date_id` int(11) NOT NULL,
  `start_date_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `timetable_activity_event_184a53ba` (`activity_name_id`),
  KEY `timetable_activity_event_e7b2b296` (`end_date_id`),
  KEY `timetable_activity_event_0b5eff24` (`start_date_id`),
  CONSTRAINT `timetable_activit_end_date_id_dcfdaa38_fk_timetable_time_meta_id` FOREIGN KEY (`end_date_id`) REFERENCES `timetable_time_meta` (`id`),
  CONSTRAINT `timetable_activ_start_date_id_81377377_fk_timetable_time_meta_id` FOREIGN KEY (`start_date_id`) REFERENCES `timetable_time_meta` (`id`),
  CONSTRAINT `timetable__activity_name_id_8fd93868_fk_timetable_event_terms_id` FOREIGN KEY (`activity_name_id`) REFERENCES `timetable_event_terms` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timetable_activity_event`
--

LOCK TABLES `timetable_activity_event` WRITE;
/*!40000 ALTER TABLE `timetable_activity_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `timetable_activity_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timetable_calendar`
--

DROP TABLE IF EXISTS `timetable_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timetable_calendar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timetable_calendar`
--

LOCK TABLES `timetable_calendar` WRITE;
/*!40000 ALTER TABLE `timetable_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `timetable_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timetable_event_terms`
--

DROP TABLE IF EXISTS `timetable_event_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timetable_event_terms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_term` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timetable_event_terms`
--

LOCK TABLES `timetable_event_terms` WRITE;
/*!40000 ALTER TABLE `timetable_event_terms` DISABLE KEYS */;
/*!40000 ALTER TABLE `timetable_event_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timetable_time_meta`
--

DROP TABLE IF EXISTS `timetable_time_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timetable_time_meta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time_obj` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `time_obj` (`time_obj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timetable_time_meta`
--

LOCK TABLES `timetable_time_meta` WRITE;
/*!40000 ALTER TABLE `timetable_time_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `timetable_time_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timetable_timetable`
--

DROP TABLE IF EXISTS `timetable_timetable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timetable_timetable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `system_generated` tinyint(1) NOT NULL,
  `calender_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `timetable_timetabl_calender_id_a74f5259_fk_timetable_calendar_id` (`calender_id`),
  KEY `timetable_timet_event_id_8f589358_fk_timetable_activity_event_id` (`event_id`),
  KEY `timetable_timetable_user_id_0d214170_fk_user_user_id` (`user_id`),
  CONSTRAINT `timetable_timetable_user_id_0d214170_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `timetable_timetabl_calender_id_a74f5259_fk_timetable_calendar_id` FOREIGN KEY (`calender_id`) REFERENCES `timetable_calendar` (`id`),
  CONSTRAINT `timetable_timet_event_id_8f589358_fk_timetable_activity_event_id` FOREIGN KEY (`event_id`) REFERENCES `timetable_activity_event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timetable_timetable`
--

LOCK TABLES `timetable_timetable` WRITE;
/*!40000 ALTER TABLE `timetable_timetable` DISABLE KEYS */;
/*!40000 ALTER TABLE `timetable_timetable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_class_assignment`
--

DROP TABLE IF EXISTS `user_class_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_class_assignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_number` int(11) NOT NULL,
  `class_code_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_class_assignment_e57bc57a` (`class_code_id`),
  KEY `user_class_assignment_e8701ad4` (`user_id`),
  CONSTRAINT `user_class_assignment_user_id_31874b31_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `user_class_assignme_class_code_id_41bf0707_fk_user_class_code_id` FOREIGN KEY (`class_code_id`) REFERENCES `user_class_code` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_class_assignment`
--

LOCK TABLES `user_class_assignment` WRITE;
/*!40000 ALTER TABLE `user_class_assignment` DISABLE KEYS */;
INSERT INTO `user_class_assignment` VALUES (2,2,2,20),(3,1,1,11),(4,2,1,12);
/*!40000 ALTER TABLE `user_class_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_class_code`
--

DROP TABLE IF EXISTS `user_class_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_class_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(2) NOT NULL,
  `class_description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_class_code`
--

LOCK TABLES `user_class_code` WRITE;
/*!40000 ALTER TABLE `user_class_code` DISABLE KEYS */;
INSERT INTO `user_class_code` VALUES (1,'1A','1A'),(2,'2B','2B'),(3,'4A','4A'),(4,'1B','Class 1B'),(5,'1C','Class 1C'),(6,'1D','Class 1D'),(7,'1E','Class 1E'),(8,'2A','Class 2A'),(9,'2C','Class 2C'),(10,'2D','Class 2D'),(11,'2E','Class 2E'),(12,'3A','Class 3A'),(13,'3B','Class 3B'),(14,'3C','Class 3C'),(15,'3D','Class 3D'),(16,'3E','Class 3E'),(17,'4B','Class 4B'),(18,'4C','Class 4C'),(19,'5A','Class 5A'),(20,'5B','Class 5B'),(21,'5C','Class 5C'),(22,'6A','Class 6A'),(23,'6B','Class 6B'),(24,'6C','Class 6C');
/*!40000 ALTER TABLE `user_class_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_parent_contact`
--

DROP TABLE IF EXISTS `user_parent_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_parent_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_name` varchar(255) NOT NULL,
  `parent_type` varchar(1) NOT NULL,
  `parent_phone` varchar(24) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_parent_contact_e8701ad4` (`user_id`),
  CONSTRAINT `user_parent_contact_user_id_bd69108b_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_parent_contact`
--

LOCK TABLES `user_parent_contact` WRITE;
/*!40000 ALTER TABLE `user_parent_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_parent_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permission`
--

DROP TABLE IF EXISTS `user_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_permission_2e788633` (`permission_id`),
  KEY `user_permission_e8701ad4` (`user_id`),
  CONSTRAINT `user_permission_user_id_094cc8c7_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `user_permissio_permission_id_e75c2bfd_fk_user_permission_meta_id` FOREIGN KEY (`permission_id`) REFERENCES `user_permission_meta` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permission`
--

LOCK TABLES `user_permission` WRITE;
/*!40000 ALTER TABLE `user_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permission_meta`
--

DROP TABLE IF EXISTS `user_permission_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_permission_meta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `level` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permission_meta`
--

LOCK TABLES `user_permission_meta` WRITE;
/*!40000 ALTER TABLE `user_permission_meta` DISABLE KEYS */;
INSERT INTO `user_permission_meta` VALUES (2,'allow:user_add','Allow user to add a new user',3),(3,'allow:user_delete','Allow user to delete a user',3),(4,'allow:user_edit','Allow edit user account information',3),(5,'allow:booking','Allow user to make a room reservation',2),(6,'view:booking','Allow user to view the booking',2),(7,'allow:facilities_view','Allow user to view the facilities',2),(8,'allow:facilities_add','Allow user to add facilities',4),(9,'allow:facilities_edit','Allow user to modify facilities',4),(10,'allow:facilities_delete','Allow user to delete the facilities',4),(11,'allow:attendance_edit','allow:attendance_edit',3),(12,'allow:classroom_all','allow:classroom_all',2),(13,'allow:site_edit','allow:site_edit',5);
/*!40000 ALTER TABLE `user_permission_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(24) NOT NULL,
  `level` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (3,'student',1),(4,'admin',5),(5,'teacher',2),(6,'principal',4),(7,'GO Staff',3),(8,'alumni',0);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_user`
--

DROP TABLE IF EXISTS `user_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `password` varchar(96) NOT NULL,
  `sex_code` varchar(1) NOT NULL,
  `card_id` varchar(20) NOT NULL,
  `strn_code` varchar(12) NOT NULL,
  `sams_code` varchar(12) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `hkid_card` varchar(12) NOT NULL,
  `address` longtext NOT NULL,
  `phone` varchar(24) NOT NULL,
  `mobile` varchar(24) NOT NULL,
  `email` varchar(254) NOT NULL,
  `national` varchar(24) NOT NULL,
  `location_of_birth` varchar(24) NOT NULL,
  `intake_date` date NOT NULL,
  `role_id` int(11) NOT NULL,
  `last_logged` datetime,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `user_user_role_id_aee6bf52_fk_user_role_id` (`role_id`),
  CONSTRAINT `user_user_role_id_aee6bf52_fk_user_role_id` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user`
--

LOCK TABLES `user_user` WRITE;
/*!40000 ALTER TABLE `user_user` DISABLE KEYS */;
INSERT INTO `user_user` VALUES (1,'admin','Admin','Super','bcrypt$$2b$12$LAyAbQMGx7o12mlA.21orO8NP18zL.FYiSZE0g/k4vMjcHbfL1Avm','M','','','',NULL,'','Flat K, 11/F, BRD\r\n\r\nfdfdf','','','','','','2015-12-09',4,'2016-04-01 07:10:54'),(11,'s1501004','Tang','Ka Wai','bcrypt$$2b$12$TBiypk31yddF.p4de4ruwe7EEImHPM/fKFNCI5Eumhj4h2VmewKFO','','','','',NULL,'','','','','','','','2016-03-26',3,'2016-03-29 09:23:00'),(12,'s1501005','Tai','Yu Kam','bcrypt$$2b$12$FjU81huzlGqgHXVJaKv3YOOCNN8KIARZ/Df5Yn9HxQhtezE4IAabO','','','','',NULL,'','<br />','','','','','','2016-03-26',3,'2016-03-29 01:52:26'),(13,'s1501006','Wong','Siu Ming','bcrypt$$2b$12$K6nbp/ZWofp74tStsygAl.wwmAvin0Kk1b1j7lIKFGxAtXf9A0iNG','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(14,'s1501020','Lee','Mei Fung','bcrypt$$2b$12$XXBGjue1yVRqXP.dsjs8LeHFbrCC84zvWTuKjU8Sp0iy3oZ9PbTM6','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(16,'s1501022','Cheung','Wing Lam','bcrypt$$2b$12$NgmpXdUP04XFmtkDMfBX7.rR/G35oLSfxWNW3yjMuYMbXgr96Vc6G','M','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(17,'s1501023','Fung','Fung Kung','bcrypt$$2b$12$kf3lo0IGm19W/5WfQfxJrO4WuI2JIDucelLpmFZbOmW7F9UNycHky','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(18,'s1501024','Cheung','Wing Lam','bcrypt$$2b$12$i3n3b8pT2l8S9djJWV3IXOz2yQuHsgxAZM92jx2InhItqE3dcA2Kq','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(20,'s1501026','Wong','Wing On','bcrypt$$2b$12$T9vO.wvtBErfWa2SkQoJ2O8Sd0du3cElfvDnbkB1N1Yl6WvFm94oq','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(21,'s1501027','Lee','Mei Fung','bcrypt$$2b$12$bfvxbE3qBV2TEps0YCbAUeJlLIjkbtxlg59u6Hk0QjQ9tpZlMq44y','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(22,'s1501028','Wong','Wing On','bcrypt$$2b$12$4xxr.sivrkxZvqQfS7iAOuQKU.5uR2lfv65BhStx3tb4dHBjtm73S','','','','',NULL,'','','','','','','','2016-03-26',3,'2016-03-26 09:38:45'),(23,'s1501029','Fung','Siu Ming','bcrypt$$2b$12$dzFhpEJGjZUYOuzFypwdje1cC9HcGeifL8hYP.8jfyiIdXWY9Nrq2','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(24,'s1501030','Cheung','Siu Ming','bcrypt$$2b$12$Ht7WDxbchc00bCTNxZAOKOqUf7fRqgOoRWshsqDJEvqPA35We49nG','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(25,'s1501031','Chan','Yee','bcrypt$$2b$12$vgMfLRJLBjvigBnrEafKXOk024KYUGqSwoRF/Uj7io/QsFeJymTeS','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(26,'s1501032','Fung','Ka Wing','bcrypt$$2b$12$PH09Ny54KWOXg97tiCItAODojsiKShCwxthmBeTtCP6v8KQwAchlO','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(27,'s1501033','Ho','Mei Fung','bcrypt$$2b$12$RQxALXu7jdJqdLojLrcvL.QUcua9D8NB.nshMCbbPSzkBCrMLyJw6','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(28,'s1501034','Wong','Wing Lam','bcrypt$$2b$12$JlRd/AOeOLHZtwggrS6nn.2.mhBdm9fRQYYCz.3qWLF0TteFn3h7K','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(29,'s1501035','Cheung','Wing On','bcrypt$$2b$12$6j3ycwSbmCrP4cZB9TIyFuPw.38UxA5uIVKmmLeM/1OqLwmGBtX52','','','','',NULL,'','','','','','','','2016-03-26',3,'2016-03-29 04:11:46'),(30,'s1501036','Tai','Sai To','bcrypt$$2b$12$XWP9PRmlWs34jyCcEfx/wuQBkAK3UJVVbxmArOTqa04EBlaLhffji','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(31,'s1501037','Ho','Ka Wai','bcrypt$$2b$12$SpO1UX.X6fAQ.xW7Gg6D/uiSRCA64rR0c0vf3Mdv1QhAq2gSU84Z6','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(32,'s1501038','Chan','Wing Lam','bcrypt$$2b$12$hHIVJNIOWmsHobHC33aNDupmxvycMDzkraBnruVniz1tO0ruAxwMy','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(33,'s1501039','Fung','Fung Kung','bcrypt$$2b$12$vP44aFF53EG5gdMSdHwjEOUmsGCtIwUHexA2IJqWyyKKCbz5rln36','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(52,'s1501041','Ho','Yu Ka','bcrypt$$2b$12$wiRcc8746lJOSzzz2Qf9AOT5A7WMxFczOngJqHh3FRjQLjpdUp4j2','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(53,'s1501042','Fung','Ka Wing','bcrypt$$2b$12$74UXgXcmcu.V98G1ZmYoyuoTY8/aASutPI9h3ziUqvemuotxNo15u','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(54,'s1501043','Lee','Siu Ming','bcrypt$$2b$12$snulk5WjbleIZl/bVwydZuN6oW177doyxNNU7rU30PGtGk6r/Y4Kq','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(55,'s1501044','Tai','Mei Fung','bcrypt$$2b$12$8Y4mC3GCROYlYkLoVgGG1u0aAkzY.7u1ZbCY1lLULU0YlL6lE8lWa','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(56,'s1501045','Fung','Mei Fung','bcrypt$$2b$12$VWO24fYWULV0CrdqpFBkq.DpOGpOAGUA28hnA1p.nE2j2Zqs/bkqe','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(57,'s1501046','Tang','Wing On','bcrypt$$2b$12$Bm5lH49k/PF2WpSKK5Lm5ub6hWmWFZWxFl3w//kmxe6prxvWiGZxK','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(58,'s1501047','Mak','Mei Fung','bcrypt$$2b$12$a7.tx5nSgJPcoQl1sP/kA.Yr/dn.Ezu/rbQ2m3KFu6a3oq3XlM0im','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(59,'s1501048','Tang','Yee','bcrypt$$2b$12$bRCC215/0kdIHezPKFd0neSaDxQ4gbzakIRcRGH3gJ9zMl74QECSm','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(60,'s1501049','Ho','Yee','bcrypt$$2b$12$4XYgc4WidxnoBCbZ9PUvceCuIDYz0otS092EqEdJKhUTYToIYUyl2','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(61,'s1501050','Tai','Yee','bcrypt$$2b$12$Fh4BndwM8mxhgmladIuoEeFqgl9Ro5XUQSxGXwurXFySWQt1WNMxS','','','','',NULL,'','','','','','','','2016-03-26',3,'2016-03-27 16:34:53'),(62,'s1501051','Ho','Wing Lam','bcrypt$$2b$12$jGmxshIsyezEcFpW8bzEPe/N/VcRB8hrq1YQlorl6LI4DtgFnkEk2','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(63,'s1501052','Ho','Ka Wai','bcrypt$$2b$12$NetEfGhoa6m7M5OEEc3qneD3vxxV.dp/Yp4jbGiLfxTAgyt.LhD.m','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(64,'s1501053','Chan','Wing On','bcrypt$$2b$12$4pnyt94Nld/lZqAyfBBY5eiJXjLER2MCTAWOEio7CNSQJ39zmPBUm','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(65,'s1501054','Mak','Yu Ka','bcrypt$$2b$12$LVJR9bnpDkLv65Mjk5RN9O0NmylAJi41oQGxBt/TQRXgenSsRxkvq','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(66,'s1501055','Tang','Ka Wing','bcrypt$$2b$12$TCdB73Sdk03.CHr7QozgwOkkBhlrUfsL9oh6mTv0GSMsfhkEu69BO','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(67,'s1501056','Lee','Wing On','bcrypt$$2b$12$O.Ck4gDqyelRAEK2BuNx1OdB5K0e2VVhtIWrCDqxXs0qeb2KYipyi','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(68,'s1501057','Tai','Wing On','bcrypt$$2b$12$vaKUQY5s6p7ez5rVvLSDXuIuNcsEzxEENM7BWBnEDPVb/ZeMB53h2','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(69,'s1501058','Kong','Mei Fung','bcrypt$$2b$12$XnQslg3NIm/uGeuZFvqpaeeXFbhKIhw9AAj2mkKu4ykQUIbKrEBqe','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(70,'s1501059','Lee','Siu Ming','bcrypt$$2b$12$.SNC747bwoN2GcdpCEVuU.AckxNszlYghzijGUOqYueUL9Iqkm7XC','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(71,'s1501060','Cheung','Sai To','bcrypt$$2b$12$LrZdnpO/spCcJqL2BF6DpeiwHZpRNrH7PFIeni25XWWFMTqQF9O4q','','','','',NULL,'','','','','','','','2016-03-26',3,'2016-03-30 16:50:01'),(72,'s1501061','Cheung','Sai To','bcrypt$$2b$12$qnJWOewkR1G5fUws9Rhq5u3QerC0RhNzwGR64CgW4qfoIbZ1Ne7lq','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(73,'s1501062','Mak','Ka Wai','bcrypt$$2b$12$e30uQ189pTJqdCEsaA.A6.qNtlFOK4n8PJmXH5lYyOPGWBvxJTR5K','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(74,'s1501063','Cheung','Fung Kung','bcrypt$$2b$12$g/Ey/zb3aaTKeos5WToyv.GKwUxEr9H.6sNdZ68lcrwtTq7hpdiPu','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(75,'s1501064','Cheung','Siu Ming','bcrypt$$2b$12$OMF2jQzGC/ByNuDkoe1qd.b4KZaly2bRPSUFAOss.H0rnCTbKQW4G','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(76,'s1501065','Lee','Ka Wing','bcrypt$$2b$12$G.HoZyDX0O8fF54X5X3A4.3el8ClJ2zz/5HbzOvj2qUHuUpayF1Uq','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(77,'s1501066','Lee','Wing On','bcrypt$$2b$12$5.f1U1PnShU42oUwTe1mP.Ywn62uLLYzR1eC4QwSISMI9NUYfiSHG','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(78,'s1501067','Wong','Ka Wing','bcrypt$$2b$12$8ARwPMGMxXAPzcY1Rmnd3uN6rQDc7Ok0OjLleFOz8s/u/k0quewv.','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(79,'s1501068','Tang','Wing Lam','bcrypt$$2b$12$xTrdqM9/2w6xod9Z7/PL.eOPJTRSLxW4wub2yfw50IoRsTB3Pii/2','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(80,'s1501069','Tai','Sai To','bcrypt$$2b$12$qsQN9svasgEpQHy6WkdXHO3JCGcm4XpYS3MrZgZ.Xo8Y.Gnt/zt32','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(81,'s1501070','Tang','Ka Wing','bcrypt$$2b$12$cKgp9fwyjMYNhcv3n6QB0un14LNq9Z/7lOOzFlbOm.LZuwSsyBDFO','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(82,'s1501071','Lee','Yee','bcrypt$$2b$12$nwaaqHdYPbJG7EtShUrWiOmjd.pajz2dMaZIO/CSZWxHAKvhpobyu','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(83,'s1501072','Tang','Mei Fung','bcrypt$$2b$12$2og/q/eMHNESBAZuNP4xpeKkpvRxMf6kP6xHpf1k0M2hBBQSZLsq2','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(84,'s1501073','Lee','Ka Wing','bcrypt$$2b$12$4sLsWFF4ex425ijxSkbixeYJSlsSiJP7/ejU2e3GY4Z1kZ2FO9agO','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(85,'s1501074','Wong','Ka Wing','bcrypt$$2b$12$J6hxr.OgVJgBw5muy9dEV.DomFoj5iJAm2YnePdeOuLmyBpVBtX6C','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(86,'s1501075','Tai','Wing On','bcrypt$$2b$12$.3aSJon4i7TfGXW7G5voTu33nb90d41NRxmNyH7/ZTfVso/nR5pw2','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(87,'s1501076','Tang','Wing Lam','bcrypt$$2b$12$niS1GOD02mYQ0n1DCHqMyeTeGMjyZ9vFe4o6c7I5uPbYUutWM14.2','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(88,'s1501077','Wong','Yu Ka','bcrypt$$2b$12$e2rmpNsCNgL0Px.AxbJjKuQIjkFVATz5TQNka9rv6aufKZ2BY7xuC','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(89,'s1501078','Mak','Fung Kung','bcrypt$$2b$12$CIrlEbM5LXXcPpvRdQJruOG.tc46/91eeskfZlCLVfaFcIIUgqI0a','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(90,'s1501079','Kong','Mei Fung','bcrypt$$2b$12$SE1uIN6xyJUblI6mM/nu.uU/xCQWp/0s59l/8oQ0KO8i7beA3Qspq','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(91,'s1501080','Lee','Ka Wai','bcrypt$$2b$12$cPklVRPvqMrFXRIwD8UfMOh4okz/0lkEnq1grD8q47rX0Kx.0gvRm','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(92,'s1501081','Mak','Yu Ka','bcrypt$$2b$12$xjAsuJx8SnjZEIYMLPDXauyTNvLZUMkArnI7sUcW0.7Xd/FGb.R5q','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(93,'s1501082','Tai','Ka Wing','bcrypt$$2b$12$nSGtEPmA5KAJQvIITZw9suIg5Aqa8ivXzs0yMkencEJzHGLMD8P6.','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(94,'s1501083','Cheung','Ka Wai','bcrypt$$2b$12$PwxKhn13vwPBp/ArhW.IjOdfTczkZmasoxR4O69gtnnSk8g8I8X52','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(95,'s1501084','Lee','Sai To','bcrypt$$2b$12$0Jon3mgsc5flI8keCknjqePvp..GNUydE2PHCt7GszsK5vIDQxnLW','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(96,'s1501085','Tang','Sai To','bcrypt$$2b$12$/tkoULEYLfaVtz7PfqX3xO7otS19pk5EkL1Ms4gOAwTrGKO2pxO.m','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(97,'s1501086','Ho','Siu Ming','bcrypt$$2b$12$us/FiOpjKJMoOearrTcJd.dUuGHLs2HAL2SuiGlSHNyCyPSlq3lkW','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(98,'s1501087','Fung','Siu Ming','bcrypt$$2b$12$oYGlRBLMsvQHXNbtyaAjJutFK.aZE8Z2YpKENzOvF8g9IWtLtyL3u','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(99,'s1501088','Kong','Wing On','bcrypt$$2b$12$/J2WgZYt0KnnTL88YOPIeOR7AuDyr8U1/6aSRN0.stXOZNselg1I6','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(100,'s1501089','Kong','Ka Wai','bcrypt$$2b$12$FB8u./5NQbahofWmh0z1qOJTPyJfOsnD9IyoP5sfKQHrLiE4JgnBu','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(101,'s1501090','Chan','Yee','bcrypt$$2b$12$4wBwUUeJM.Vn2Ralfg3iluqU7wMsCDU9avCacH0DK00u3L45FE2My','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(102,'s1501091','Fung','Yee','bcrypt$$2b$12$md3g0V/bsmy/Q6febNHV3u00unFJcdbksa8UUPgnrH0UPvbB3N8K.','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(103,'s1501092','Mak','Fung Kung','bcrypt$$2b$12$ILIWJz3n0ZmCDv6eSFzWO.W/rOgf1AYamGPcH/1ETNzXI2VSNL0Ci','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(104,'s1501093','Lee','Ka Wai','bcrypt$$2b$12$KIaZXZStxNO3IG83JRW1au/95BFDtc4Mm0NHexpbS8aX77ChlsrA6','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(105,'s1501094','Mak','Yu Ka','bcrypt$$2b$12$rDf80aB990XCK3vCsFKEF.IJem6htt/u0IBGtDDWx5l4JWciIeP0i','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(106,'s1501095','Mak','Sai To','bcrypt$$2b$12$00syWR8r0WaNLa2w3SEa.eHehfLNPHI6n0eQ/bPVhZUkpOqxSE8XO','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(107,'s1501096','Chan','Ka Wing','bcrypt$$2b$12$XpvubnpwGM3p8ycqCO5x9OlQlleo6gHM8n6kb/ZJ5tzYc44Fwf02q','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(108,'s1501097','Tang','Wing On','bcrypt$$2b$12$Lzr04a69GLQXQL3/1KqkGOdlg0/tzNeRu0yVQZT9BWj97Vu6WvDNy','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(109,'s1501098','Lee','Wing On','bcrypt$$2b$12$XmdcvVgVdFFEPJlIjDdP5eBxzR7Uoq2kl7zh7OO6SbGRrae6EYTI2','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(110,'s1501099','Kong','Ka Wai','bcrypt$$2b$12$OMGpSA8ow5dQwHnnEhEBNOYYujPRsF0guOZG8wAflEIi6C0uodEIW','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(111,'s1501100','Ho','Wing On','bcrypt$$2b$12$qKh.m1JwcQwBn1HYAxJlPOaNLJocnE/izBY5OU0eKYbyZidaScIP2','','','','',NULL,'','','','','','','','2016-03-26',3,'2016-03-26 14:54:51'),(112,'s1501101','Tang','Fung Kung','bcrypt$$2b$12$A7FHAxaY7LU1S.HIXurkZusvNIXuC0HpOw1q4JMb33RdLdci8d4c6','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(113,'s1501102','Wong','Mei Fung','bcrypt$$2b$12$TyUxVlhKCrpYdStqC1AuzebYD/lYKUj6WM.yKnN4.fTKtI6SxwI/i','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(114,'s1501103','Tai','Siu Ming','bcrypt$$2b$12$gCjPUDp1uzvNQbZOLsNKnOLVl8LSh/IcW1oyj/rfWUWdMp5pNoE.u','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(115,'s1501104','Kong','Siu Ming','bcrypt$$2b$12$E9e5rr4Qh118BuW0Auv3f.TVasaYVb7N2p2Jfa8n7kQcz01GAkk3y','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(116,'s1501105','Tai','Wing On','bcrypt$$2b$12$RP.pKJs75lnwYSjQWJG3FeF4MCRGe/QWZX0iPZ9SpBXXbymQryutS','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(117,'s1501106','Kong','Wing Lam','bcrypt$$2b$12$bwGww/SoutvIlpWhRkV2M.lliExtfq9LJOXj2n9xsdNNfhgDcEQDO','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(118,'s1501107','Wong','Wing On','bcrypt$$2b$12$/KFJRT1oBG3shVGoVJVyquuOSyem.HXVl06GhvnRMZhgh/WYETv/W','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(119,'s1501108','Tang','Wing On','bcrypt$$2b$12$ibooc8pgNp1/SG.o1B.3T.ukeQUALlwn1edPtXjfblpFCYB92hX/K','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(120,'s1501109','Ho','Yee','bcrypt$$2b$12$97nQwG1hGTCGlU8e/zJ4VOla3Re5qSwKEm3D3sJmQ3/uk9s63VoAa','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(121,'s1501110','Chan','Siu Ming','bcrypt$$2b$12$GDKBzto0da3moo4q9IeCyuXNQa9vRv472O/UiBs03AMRpbTYVlsXa','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(122,'s1501111','Wong','Sai To','bcrypt$$2b$12$lWEFJBiurk6KBy2dAv9qBeVSCXVFx343Juf.nEsicxcwbd1zBUaCy','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(123,'s1501112','Wong','Mei Fung','bcrypt$$2b$12$lHRRNPV0CxFdako37zNGYevpSZC6YcVj6pwmsRReyomRDomVsxVHu','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(124,'s1501113','Chan','Ka Wai','bcrypt$$2b$12$uAIVdbOCXTgf9PUkoxh5veDGE4Hq8fm3Zv.T2kCSXyfwbAXF2B0R.','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(125,'s1501114','Ho','Siu Ming','bcrypt$$2b$12$rpTTW5OPlclZ6SzjICzlSu4qtp/gXTgnvjXRgAf43K6qyIjbjhVta','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(126,'s1501115','Lee','Yee','bcrypt$$2b$12$orpG1zY.Ys4KuuigVHpLbO.EyOsSzKBNlSkaeJFsv6/e2EqB05QCG','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(127,'s1501116','Tang','Siu Ming','bcrypt$$2b$12$il8scr.bRAkxW4ytrL/si.kRIvVnvMnI2nriFpCTNF6gHhkJTCi7.','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(128,'s1501117','Fung','Yee','bcrypt$$2b$12$.mSMuJZ8npvgxIGbZKVlK.69SrHVe4mG.02ivs8R6jyVHwtrSWAwC','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(129,'s1501118','Tang','Mei Fung','bcrypt$$2b$12$YoYiFP1xV1a1AuBkar3VNuZJhyqgE95LUW3iDsO35aa36SouQAcDe','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(130,'s1501119','Tai','Sai To','bcrypt$$2b$12$XjEAdDokCshl81NlV6bieuy5YUz1.CdQdYzkfKtspxA0blKMUEsl2','','','','',NULL,'','','','','','','','2016-03-26',3,NULL),(133,'kkc','Kong','Kin Cho','bcrypt$$2b$12$v6spWWfbUvQYV4zlOk5OPu2J.bshxkj0m6aOJLnbOy/oJTRSCMMoG','M','','','',NULL,'','','','','','','','2016-04-01',5,'2016-03-31 22:20:40');
/*!40000 ALTER TABLE `user_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-01  3:13:03
