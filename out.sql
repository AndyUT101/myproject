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
  `rule_id` int(11) NOT NULL,
  `applied_datetime` datetime NOT NULL,
  `class_code_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `attendance_applied_rule_0ece160a` (`rule_id`),
  KEY `attendance_applied_rule_e57bc57a` (`class_code_id`),
  CONSTRAINT `attendance_applied__class_code_id_0458d92f_fk_user_class_code_id` FOREIGN KEY (`class_code_id`) REFERENCES `user_class_code` (`id`),
  CONSTRAINT `attendance_applied_rule_rule_id_8ec42629_fk_attendance_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `attendance_rule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_applied_rule`
--

LOCK TABLES `attendance_applied_rule` WRITE;
/*!40000 ALTER TABLE `attendance_applied_rule` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_attandance`
--

LOCK TABLES `attendance_attandance` WRITE;
/*!40000 ALTER TABLE `attendance_attandance` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_rule`
--

LOCK TABLES `attendance_rule` WRITE;
/*!40000 ALTER TABLE `attendance_rule` DISABLE KEYS */;
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
INSERT INTO `auth_permission` VALUES (1,'Can add user',1,'add_user'),(2,'Can change user',1,'change_user'),(3,'Can delete user',1,'delete_user'),(4,'Can add role',2,'add_role'),(5,'Can change role',2,'change_role'),(6,'Can delete role',2,'delete_role'),(7,'Can add parent_contact',3,'add_parent_contact'),(8,'Can change parent_contact',3,'change_parent_contact'),(9,'Can delete parent_contact',3,'delete_parent_contact'),(10,'Can add question',4,'add_question'),(11,'Can change question',4,'change_question'),(12,'Can delete question',4,'delete_question'),(13,'Can add choice',5,'add_choice'),(14,'Can change choice',5,'change_choice'),(15,'Can delete choice',5,'delete_choice'),(16,'Can add log entry',6,'add_logentry'),(17,'Can change log entry',6,'change_logentry'),(18,'Can delete log entry',6,'delete_logentry'),(19,'Can add permission',7,'add_permission'),(20,'Can change permission',7,'change_permission'),(21,'Can delete permission',7,'delete_permission'),(22,'Can add group',8,'add_group'),(23,'Can change group',8,'change_group'),(24,'Can delete group',8,'delete_group'),(25,'Can add user',9,'add_user'),(26,'Can change user',9,'change_user'),(27,'Can delete user',9,'delete_user'),(28,'Can add content type',10,'add_contenttype'),(29,'Can change content type',10,'change_contenttype'),(30,'Can delete content type',10,'delete_contenttype'),(31,'Can add session',11,'add_session'),(32,'Can change session',11,'change_session'),(33,'Can delete session',11,'delete_session'),(34,'Can add session',12,'add_session'),(35,'Can change session',12,'change_session'),(36,'Can delete session',12,'delete_session'),(37,'Can add class_code',13,'add_class_code'),(38,'Can change class_code',13,'change_class_code'),(39,'Can delete class_code',13,'delete_class_code'),(40,'Can add class_assignment',14,'add_class_assignment'),(41,'Can change class_assignment',14,'change_class_assignment'),(42,'Can delete class_assignment',14,'delete_class_assignment'),(46,'Can add permission',16,'add_permission'),(47,'Can change permission',16,'change_permission'),(48,'Can delete permission',16,'delete_permission'),(49,'Can add permission_meta',17,'add_permission_meta'),(50,'Can change permission_meta',17,'change_permission_meta'),(51,'Can delete permission_meta',17,'delete_permission_meta'),(52,'Can add event_terms',18,'add_event_terms'),(53,'Can change event_terms',18,'change_event_terms'),(54,'Can delete event_terms',18,'delete_event_terms'),(55,'Can add activity_event',19,'add_activity_event'),(56,'Can change activity_event',19,'change_activity_event'),(57,'Can delete activity_event',19,'delete_activity_event'),(58,'Can add calendar',20,'add_calendar'),(59,'Can change calendar',20,'change_calendar'),(60,'Can delete calendar',20,'delete_calendar'),(61,'Can add timetable',21,'add_timetable'),(62,'Can change timetable',21,'change_timetable'),(63,'Can delete timetable',21,'delete_timetable'),(64,'Can add room',22,'add_room'),(65,'Can change room',22,'change_room'),(66,'Can delete room',22,'delete_room'),(67,'Can add facilities',23,'add_facilities'),(68,'Can change facilities',23,'change_facilities'),(69,'Can delete facilities',23,'delete_facilities'),(70,'Can add lesson',24,'add_lesson'),(71,'Can change lesson',24,'change_lesson'),(72,'Can delete lesson',24,'delete_lesson'),(73,'Can add booking',25,'add_booking'),(74,'Can change booking',25,'change_booking'),(75,'Can delete booking',25,'delete_booking'),(76,'Can add user_assignment',26,'add_user_assignment'),(77,'Can change user_assignment',26,'change_user_assignment'),(78,'Can delete user_assignment',26,'delete_user_assignment'),(79,'Can add classroom',27,'add_classroom'),(80,'Can change classroom',27,'change_classroom'),(81,'Can delete classroom',27,'delete_classroom'),(82,'Can add announce',28,'add_announce'),(83,'Can change announce',28,'change_announce'),(84,'Can delete announce',28,'delete_announce'),(85,'Can add assignment',29,'add_assignment'),(86,'Can change assignment',29,'change_assignment'),(87,'Can delete assignment',29,'delete_assignment'),(91,'Can add note',31,'add_note'),(92,'Can change note',31,'change_note'),(93,'Can delete note',31,'delete_note'),(94,'Can add material_type',32,'add_material_type'),(95,'Can change material_type',32,'change_material_type'),(96,'Can delete material_type',32,'delete_material_type'),(97,'Can add material_ext',33,'add_material_ext'),(98,'Can change material_ext',33,'change_material_ext'),(99,'Can delete material_ext',33,'delete_material_ext'),(100,'Can add material',34,'add_material'),(101,'Can change material',34,'change_material'),(102,'Can delete material',34,'delete_material'),(103,'Can add inbox_content',35,'add_inbox_content'),(104,'Can change inbox_content',35,'change_inbox_content'),(105,'Can delete inbox_content',35,'delete_inbox_content'),(106,'Can add inbox',36,'add_inbox'),(107,'Can change inbox',36,'change_inbox'),(108,'Can delete inbox',36,'delete_inbox'),(109,'Can add inbox_classroom',37,'add_inbox_classroom'),(110,'Can change inbox_classroom',37,'change_inbox_classroom'),(111,'Can delete inbox_classroom',37,'delete_inbox_classroom'),(112,'Can add time_meta',38,'add_time_meta'),(113,'Can change time_meta',38,'change_time_meta'),(114,'Can delete time_meta',38,'delete_time_meta'),(115,'Can add assignment_pool',39,'add_assignment_pool'),(116,'Can change assignment_pool',39,'change_assignment_pool'),(117,'Can delete assignment_pool',39,'delete_assignment_pool'),(118,'Can add classroom_note',40,'add_classroom_note'),(119,'Can change classroom_note',40,'change_classroom_note'),(120,'Can delete classroom_note',40,'delete_classroom_note'),(121,'Can add attandance',41,'add_attandance'),(122,'Can change attandance',41,'change_attandance'),(123,'Can delete attandance',41,'delete_attandance'),(124,'Can add rule',42,'add_rule'),(125,'Can change rule',42,'change_rule'),(126,'Can delete rule',42,'delete_rule'),(127,'Can add applied_rule',43,'add_applied_rule'),(128,'Can change applied_rule',43,'change_applied_rule'),(129,'Can delete applied_rule',43,'delete_applied_rule'),(130,'Can add report_type',44,'add_report_type'),(131,'Can change report_type',44,'change_report_type'),(132,'Can delete report_type',44,'delete_report_type');
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
INSERT INTO `auth_user` VALUES (1,'bcrypt_sha256$$2b$12$on3O3oq5QdFBH/quosRkAee9U/iEYffNYQmVblXIp35gs.ni4PrAO','2016-03-14 06:16:03',1,'wormcih','','','',1,1,'2016-03-11 03:54:26');
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
  `room_id` int(11) NOT NULL,
  `start_lesson_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_booking_753b6c87` (`end_lesson_id`),
  KEY `booking_booking_8273f993` (`room_id`),
  KEY `booking_booking_41f03037` (`start_lesson_id`),
  KEY `booking_booking_e8701ad4` (`user_id`),
  CONSTRAINT `booking_booking_user_id_e1eb6912_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `booking_booking_end_lesson_id_622c978f_fk_booking_lesson_id` FOREIGN KEY (`end_lesson_id`) REFERENCES `booking_lesson` (`id`),
  CONSTRAINT `booking_booking_room_id_8844468d_fk_facilities_room_id` FOREIGN KEY (`room_id`) REFERENCES `facilities_room` (`id`),
  CONSTRAINT `booking_booking_start_lesson_id_5e29f817_fk_booking_lesson_id` FOREIGN KEY (`start_lesson_id`) REFERENCES `booking_lesson` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_booking`
--

LOCK TABLES `booking_booking` WRITE;
/*!40000 ALTER TABLE `booking_booking` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_lesson`
--

LOCK TABLES `booking_lesson` WRITE;
/*!40000 ALTER TABLE `booking_lesson` DISABLE KEYS */;
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
  `announce_date` datetime NOT NULL,
  `classroom_id` int(11) NOT NULL,
  `content` longtext NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_announce_837734a3` (`classroom_id`),
  CONSTRAINT `classroom_announ_classroom_id_6adc29f2_fk_classroom_classroom_id` FOREIGN KEY (`classroom_id`) REFERENCES `classroom_classroom` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_announce`
--

LOCK TABLES `classroom_announce` WRITE;
/*!40000 ALTER TABLE `classroom_announce` DISABLE KEYS */;
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
  `deadline_datetime` datetime NOT NULL,
  `fullmark` smallint(5) unsigned NOT NULL,
  `handin_method` varchar(1) NOT NULL,
  `instruction` longtext NOT NULL,
  `title` varchar(255) NOT NULL,
  `classroom_id` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_assignment_837734a3` (`classroom_id`),
  CONSTRAINT `classroom_assign_classroom_id_8c5ff526_fk_classroom_classroom_id` FOREIGN KEY (`classroom_id`) REFERENCES `classroom_classroom` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_assignment`
--

LOCK TABLES `classroom_assignment` WRITE;
/*!40000 ALTER TABLE `classroom_assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `classroom_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_assignment_pool`
--

DROP TABLE IF EXISTS `classroom_assignment_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom_assignment_pool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_json` longtext NOT NULL,
  `mark` smallint(5) unsigned NOT NULL,
  `user_assign_id` int(11) NOT NULL,
  `assignment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_assignment_pool_2bb76e59` (`user_assign_id`),
  KEY `classroom_assignment_pool_93c4899b` (`assignment_id`),
  CONSTRAINT `classroom_assi_assignment_id_586b50c8_fk_classroom_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `classroom_assignment` (`id`),
  CONSTRAINT `classroo_user_assign_id_89aeec6b_fk_classroom_user_assignment_id` FOREIGN KEY (`user_assign_id`) REFERENCES `classroom_user_assignment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_assignment_pool`
--

LOCK TABLES `classroom_assignment_pool` WRITE;
/*!40000 ALTER TABLE `classroom_assignment_pool` DISABLE KEYS */;
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
  `creator_id` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_classroom_3700153c` (`creator_id`),
  CONSTRAINT `classroom_classroom_creator_id_ab812779_fk_user_user_id` FOREIGN KEY (`creator_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_classroom`
--

LOCK TABLES `classroom_classroom` WRITE;
/*!40000 ALTER TABLE `classroom_classroom` DISABLE KEYS */;
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
  KEY `classroom_classroom_note_837734a3` (`classroom_id`),
  KEY `classroom_classroom_note_2115813b` (`note_id`),
  CONSTRAINT `classroom_classroom_note_note_id_85f47391_fk_classroom_note_id` FOREIGN KEY (`note_id`) REFERENCES `classroom_note` (`id`),
  CONSTRAINT `classroom_classr_classroom_id_ce4bd5e3_fk_classroom_classroom_id` FOREIGN KEY (`classroom_id`) REFERENCES `classroom_classroom` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_classroom_note`
--

LOCK TABLES `classroom_classroom_note` WRITE;
/*!40000 ALTER TABLE `classroom_classroom_note` DISABLE KEYS */;
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
  `material_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_material_af76a535` (`uploader_id`),
  KEY `classroom_material_bcca2c2a` (`material_type_id`),
  CONSTRAINT `classroom_m_uploader_id_eda8f3b6_fk_classroom_user_assignment_id` FOREIGN KEY (`uploader_id`) REFERENCES `classroom_user_assignment` (`id`),
  CONSTRAINT `classroo_material_type_id_a2b7567c_fk_classroom_material_type_id` FOREIGN KEY (`material_type_id`) REFERENCES `classroom_material_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_material`
--

LOCK TABLES `classroom_material` WRITE;
/*!40000 ALTER TABLE `classroom_material` DISABLE KEYS */;
/*!40000 ALTER TABLE `classroom_material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_material_ext`
--

DROP TABLE IF EXISTS `classroom_material_ext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom_material_ext` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ext_name` varchar(255) NOT NULL,
  `material_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ext_name` (`ext_name`),
  KEY `classroom_material_ext_bcca2c2a` (`material_type_id`),
  CONSTRAINT `classroo_material_type_id_38c5a795_fk_classroom_material_type_id` FOREIGN KEY (`material_type_id`) REFERENCES `classroom_material_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_material_ext`
--

LOCK TABLES `classroom_material_ext` WRITE;
/*!40000 ALTER TABLE `classroom_material_ext` DISABLE KEYS */;
/*!40000 ALTER TABLE `classroom_material_ext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_material_type`
--

DROP TABLE IF EXISTS `classroom_material_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom_material_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_description` longtext NOT NULL,
  `type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_material_type`
--

LOCK TABLES `classroom_material_type` WRITE;
/*!40000 ALTER TABLE `classroom_material_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `classroom_material_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_note`
--

DROP TABLE IF EXISTS `classroom_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `publish_datetime` datetime NOT NULL,
  `status` varchar(1) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_note`
--

LOCK TABLES `classroom_note` WRITE;
/*!40000 ALTER TABLE `classroom_note` DISABLE KEYS */;
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
  `user_id` int(11) NOT NULL,
  `classroom_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_user_assignment_e8701ad4` (`user_id`),
  KEY `classroom_user_assignment_837734a3` (`classroom_id`),
  CONSTRAINT `classroom_user_a_classroom_id_efdb60c1_fk_classroom_classroom_id` FOREIGN KEY (`classroom_id`) REFERENCES `classroom_classroom` (`id`),
  CONSTRAINT `classroom_user_assignment_user_id_d5ed8a40_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_user_assignment`
--

LOCK TABLES `classroom_user_assignment` WRITE;
/*!40000 ALTER TABLE `classroom_user_assignment` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2016-03-11 04:00:38','1','wormcih',2,'Changed username.',1,1),(2,'2016-03-11 04:00:49','1','ADM',1,'Added.',2,1),(3,'2016-03-11 04:01:02','2','ADM',1,'Added.',2,1),(4,'2016-03-11 04:01:11','2','ADM',3,'',2,1),(5,'2016-03-11 04:52:29','1','Session object',1,'Added.',12,1),(6,'2016-03-12 06:20:01','1','wormcih',2,'Changed password_hash.',1,1),(7,'2016-03-12 07:10:49','1','wormcih',2,'No fields changed.',1,1),(8,'2016-03-12 07:29:43','1','wormcih',2,'Changed password_hash.',1,1),(9,'2016-03-12 08:26:34','1','wormcih',2,'Changed password_hash.',1,1),(10,'2016-03-12 08:45:10','1','wormcih',2,'Changed password_hash.',1,1),(11,'2016-03-13 08:24:29','1','Permission_meta object',1,'Added.',17,1),(12,'2016-03-13 08:24:47','1','Permission_meta object',2,'Changed permission_key.',17,1),(13,'2016-03-13 08:25:03','2','Permission_meta object',1,'Added.',17,1),(14,'2016-03-13 08:25:19','3','Permission_meta object',1,'Added.',17,1),(15,'2016-03-13 08:39:01','4','user_allow_detail_view',1,'Added.',17,1),(16,'2016-03-13 08:40:02','1','Permission object',1,'Added.',16,1),(17,'2016-03-13 17:20:36','1','Time_meta object',1,'Added.',38,1),(18,'2016-03-13 17:20:42','2','Time_meta object',1,'Added.',38,1),(19,'2016-03-13 17:21:07','1','Event_terms object',1,'Added.',18,1),(20,'2016-03-13 17:21:12','1','Activity_event object',1,'Added.',19,1),(21,'2016-03-13 17:31:29','1','test',3,'',18,1),(22,'2016-03-13 17:34:11','2','test',1,'Added.',18,1),(23,'2016-03-13 17:37:23','3','2016-03-14 18:00:00+08:00',1,'Added.',38,1),(24,'2016-03-14 06:16:23','1','Class_assignment object',1,'Added.',14,1);
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
INSERT INTO `django_content_type` VALUES (6,'admin','logentry'),(43,'attendance','applied_rule'),(41,'attendance','attandance'),(42,'attendance','rule'),(8,'auth','group'),(7,'auth','permission'),(9,'auth','user'),(25,'booking','booking'),(24,'booking','lesson'),(28,'classroom','announce'),(29,'classroom','assignment'),(39,'classroom','assignment_pool'),(27,'classroom','classroom'),(40,'classroom','classroom_note'),(34,'classroom','material'),(33,'classroom','material_ext'),(32,'classroom','material_type'),(31,'classroom','note'),(26,'classroom','user_assignment'),(10,'contenttypes','contenttype'),(23,'facilities','facilities'),(22,'facilities','room'),(36,'inbox','inbox'),(37,'inbox','inbox_classroom'),(35,'inbox','inbox_content'),(5,'polls','choice'),(4,'polls','question'),(44,'report','report_type'),(11,'sessions','session'),(19,'timetable','activity_event'),(20,'timetable','calendar'),(18,'timetable','event_terms'),(21,'timetable','timetable'),(38,'timetable','time_meta'),(14,'user','class_assignment'),(13,'user','class_code'),(3,'user','parent_contact'),(16,'user','permission'),(17,'user','permission_meta'),(2,'user','role'),(12,'user','session'),(1,'user','user');
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
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2016-03-08 09:48:49'),(2,'auth','0001_initial','2016-03-08 09:48:49'),(3,'admin','0001_initial','2016-03-08 09:48:49'),(4,'admin','0002_logentry_remove_auto_add','2016-03-08 09:48:49'),(5,'contenttypes','0002_remove_content_type_name','2016-03-08 09:48:49'),(6,'auth','0002_alter_permission_name_max_length','2016-03-08 09:48:49'),(7,'auth','0003_alter_user_email_max_length','2016-03-08 09:48:49'),(8,'auth','0004_alter_user_username_opts','2016-03-08 09:48:49'),(9,'auth','0005_alter_user_last_login_null','2016-03-08 09:48:49'),(10,'auth','0006_require_contenttypes_0002','2016-03-08 09:48:49'),(11,'auth','0007_alter_validators_add_error_messages','2016-03-08 09:48:49'),(12,'polls','0001_initial','2016-03-08 09:48:49'),(13,'sessions','0001_initial','2016-03-08 09:48:49'),(14,'user','0001_initial','2016-03-08 09:48:50'),(15,'user','0002_auto_20160308_1555','2016-03-08 15:57:44'),(16,'user','0003_auto_20160308_1556','2016-03-08 15:57:44'),(17,'user','0004_auto_20160309_0100','2016-03-09 01:00:21'),(18,'user','0005_auto_20160310_0529','2016-03-10 05:29:37'),(19,'user','0006_auto_20160310_0559','2016-03-10 05:59:50'),(20,'timetable','0001_initial','2016-03-10 06:32:02'),(21,'facilities','0001_initial','2016-03-10 07:40:12'),(22,'booking','0001_initial','2016-03-10 09:28:52'),(23,'classroom','0001_initial','2016-03-10 14:28:05'),(24,'inbox','0001_initial','2016-03-10 14:28:06'),(25,'user','0007_session_timeout','2016-03-11 04:51:20'),(26,'user','0008_auto_20160312_1643','2016-03-12 08:44:15'),(27,'timetable','0002_auto_20160314_0118','2016-03-13 17:18:46'),(28,'timetable','0003_auto_20160314_1221','2016-03-14 04:22:13'),(29,'user','0009_auto_20160314_1220','2016-03-14 04:22:13'),(30,'user','0010_auto_20160314_1221','2016-03-14 04:22:13'),(31,'timetable','0004_auto_20160314_1222','2016-03-14 04:23:22'),(32,'user','0011_auto_20160314_1222','2016-03-14 04:23:22'),(33,'timetable','0005_auto_20160314_1223','2016-03-14 04:24:02'),(34,'user','0012_auto_20160314_1223','2016-03-14 04:24:02'),(35,'timetable','0006_auto_20160314_1231','2016-03-14 04:48:08'),(36,'timetable','0007_auto_20160314_1247','2016-03-14 04:48:08'),(37,'user','0013_auto_20160314_1231','2016-03-14 04:48:08'),(38,'user','0014_auto_20160314_1247','2016-03-14 04:48:08'),(39,'user','0015_auto_20160314_1247','2016-03-14 04:48:08'),(40,'user','0010_auto_20160314_1301','2016-03-14 05:02:26'),(41,'user','0007_auto_20160314_1405','2016-03-14 06:15:34'),(42,'user','0008_auto_20160315_0932','2016-03-15 01:34:26'),(43,'user','0009_auto_20160315_1036','2016-03-15 02:44:12'),(44,'user','0010_auto_20160315_1038','2016-03-15 02:44:12'),(45,'user','0011_auto_20160315_1043','2016-03-15 02:44:12'),(46,'classroom','0002_auto_20160315_1043','2016-03-15 02:44:13'),(47,'user','0012_auto_20160315_1044','2016-03-15 04:25:41'),(48,'user','0013_auto_20160315_1044','2016-03-15 04:25:41'),(49,'user','0014_auto_20160315_1044','2016-03-15 04:25:41'),(50,'user','0015_auto_20160315_2341','2016-03-15 15:44:03'),(51,'user','0016_auto_20160315_2343','2016-03-15 15:44:03'),(52,'attendance','0001_initial','2016-03-15 15:44:03'),(53,'user','0017_auto_20160316_0035','2016-03-15 16:37:08'),(54,'attendance','0002_auto_20160316_0035','2016-03-15 16:37:08'),(55,'classroom','0003_assignment_pool_assignment','2016-03-16 01:10:02'),(56,'classroom','0004_material_material_type','2016-03-16 01:10:02'),(57,'user','0018_auto_20160316_0907','2016-03-16 01:10:03'),(58,'user','0019_auto_20160316_0909','2016-03-16 01:10:03'),(59,'user','0020_auto_20160316_0945','2016-03-16 01:46:04'),(60,'attendance','0003_auto_20160316_0945','2016-03-16 01:46:04'),(61,'booking','0002_booking_user','2016-03-16 01:46:04'),(62,'classroom','0005_auto_20160316_0945','2016-03-16 01:46:04'),(63,'classroom','0006_auto_20160316_1019','2016-03-16 02:19:30'),(64,'report','0001_initial','2016-03-16 02:44:35'),(65,'classroom','0007_auto_20160316_1044','2016-03-16 02:45:04');
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
INSERT INTO `django_session` VALUES ('3cunpai3scsesx5s1hictndtu0prdww2','YzZjYjZlYzBmYTU4ZDQ4NWRiYWRkN2ExYTg0MzNkMmUwZTc1MzIxMDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5Zjg2ZmRiZDBlOGQ2MzgyZmM5NGQyMjExMzczM2U3OGEwOTRjYzA2In0=','2016-03-28 06:16:03'),('3l5840eyorfc6qq10p94j50umfgrtgq7','MGU1OGYyOTJjMmM3M2E5MjQ5MTZhMTc5MDBmNTQzMDI2NDhhNjlkYTp7Il9hdXRoX3VzZXJfaGFzaCI6IjA1ZjNkMzNkNzQxNzBkNjc2ZmZmN2JmNWJkZDk3OWRlMGJlYzA1ZDkiLCJ0b2tlbiI6IjA3ZmFWZlJLbzlQdSRlMDhlM2JhNzNkYzNiNzBhYWFkNjU0M2ExNDcyMmE5ZSIsIl9hdXRoX3VzZXJfaWQiOiIxIiwiX3Nlc3Npb25fZXhwaXJ5IjoxODAwLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2016-03-13 07:29:23'),('d8c4nzs356slmxvttfojxddwx62ijitt','MTk1ZGQwYjk0Y2JmMzdlNzVkM2QxNmYyOTNiNTk3MTlkNGFlNmExNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjlmODZmZGJkMGU4ZDYzODJmYzk0ZDIyMTEzNzMzZTc4YTA5NGNjMDYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-03-27 17:19:12'),('e73rc7x8w93bv43n0w9rls2w3ndna1ze','OTdhZGMwN2VhZTIwYWM2NzVhMDhkOTkyMGFjMzNhYjRjZDU1MDFmZTp7Il9zZXNzaW9uX2V4cGlyeSI6MTgwMCwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjlmODZmZGJkMGU4ZDYzODJmYzk0ZDIyMTEzNzMzZTc4YTA5NGNjMDYifQ==','2016-03-14 01:05:52'),('n094tczrcavbz3li6lzqt5f3i3ddf169','ZjFmNzM4Yzc1MjIzZjRhYjE2N2U5MjE5MTBhZWVjNzQ0ZmI4Y2FhNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOWY4NmZkYmQwZThkNjM4MmZjOTRkMjIxMTM3MzNlNzhhMDk0Y2MwNiIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-03-27 08:23:29'),('nrmhqf99i694n744lw7r91seqqdddedn','YjNhNjZhNjJmOThjOGEwYzM4ZjA0MzlhMjQ2ZGVhZGY2NWNhZDhlMDp7Il9zZXNzaW9uX2V4cGlyeSI6MTgwMCwidG9rZW4iOiJOSUM2WGpLNnlKSk0kM2FhNWVjODE0MTA4YjE0YmZmMTA0N2Y0ZmRmYmZmODIifQ==','2016-03-13 07:59:08'),('o31hhzkp4vwtjifdfgrziwp9fs7z8kv4','NzJmOTQxYzRmZDkzMGEzMDJiMGIxOWI4YWVhMGZhNzAxZWFhYWIxZTp7Il9zZXNzaW9uX2V4cGlyeSI6MTgwMH0=','2016-03-13 08:08:52'),('ocrbk0v1l9nqvz0c2swqte8knqzlt3yl','YzM1NTIxMGU5ZjY1YWU2MmZiOWZjYjlmOTIyM2Q2MmNlZTcwYjcxZTp7Il9hdXRoX3VzZXJfaGFzaCI6IjA1ZjNkMzNkNzQxNzBkNjc2ZmZmN2JmNWJkZDk3OWRlMGJlYzA1ZDkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-03-26 07:09:08'),('r98r9r5b7xudghdpdtfaxv8axs6rg031','MjIzOWE1MWQ5Y2I5NzM3Y2E2MjgyODI4N2E1ZTJjMjY3YzQ1Y2ViMDp7InRva2VuIjoiJDEkeXVCTy8xUHAkOTJYcWFVZUlnNHRURUw5NUdnTzlhLiJ9','2016-03-25 08:51:21'),('w9idicbvgop9s63zasxt6d5wnnys0bc6','YzlhM2Y2OGFjODA5MGVkYjU0MGZhNmNhNDYxMjk5NzAzYzRiNzllMzp7Il9hdXRoX3VzZXJfaGFzaCI6IjA1ZjNkMzNkNzQxNzBkNjc2ZmZmN2JmNWJkZDk3OWRlMGJlYzA1ZDkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIiwiX3Nlc3Npb25fZXhwaXJ5IjoxODAwLCJ0b2tlbiI6IiQxJHA3d2E4dG1jJDhWZnVHcFNIeGRsQ1NTS3BlRmxyMDAifQ==','2016-03-11 10:10:03');
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
  KEY `facilities_facilities_8273f993` (`room_id`),
  CONSTRAINT `facilities_facilities_room_id_f06ad5af_fk_facilities_room_id` FOREIGN KEY (`room_id`) REFERENCES `facilities_room` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facilities_facilities`
--

LOCK TABLES `facilities_facilities` WRITE;
/*!40000 ALTER TABLE `facilities_facilities` DISABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facilities_room`
--

LOCK TABLES `facilities_room` WRITE;
/*!40000 ALTER TABLE `facilities_room` DISABLE KEYS */;
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
  `content_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `inbox_inbox_e14f02ad` (`content_id`),
  KEY `inbox_inbox_d41c2251` (`receiver_id`),
  KEY `inbox_inbox_924b1846` (`sender_id`),
  CONSTRAINT `inbox_inbox_sender_id_3d895d80_fk_user_user_id` FOREIGN KEY (`sender_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `inbox_inbox_content_id_166823dd_fk_inbox_inbox_content_id` FOREIGN KEY (`content_id`) REFERENCES `inbox_inbox_content` (`id`),
  CONSTRAINT `inbox_inbox_receiver_id_92b958fa_fk_user_user_id` FOREIGN KEY (`receiver_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbox_inbox`
--

LOCK TABLES `inbox_inbox` WRITE;
/*!40000 ALTER TABLE `inbox_inbox` DISABLE KEYS */;
/*!40000 ALTER TABLE `inbox_inbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inbox_inbox_classroom`
--

DROP TABLE IF EXISTS `inbox_inbox_classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inbox_inbox_classroom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classroom_id` int(11) NOT NULL,
  `inbox_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `inbox_inbox_clas_classroom_id_ff0b2bd4_fk_classroom_classroom_id` (`classroom_id`),
  KEY `inbox_inbox_classroom_inbox_id_93bc12c6_fk_inbox_inbox_id` (`inbox_id`),
  CONSTRAINT `inbox_inbox_classroom_inbox_id_93bc12c6_fk_inbox_inbox_id` FOREIGN KEY (`inbox_id`) REFERENCES `inbox_inbox` (`id`),
  CONSTRAINT `inbox_inbox_clas_classroom_id_ff0b2bd4_fk_classroom_classroom_id` FOREIGN KEY (`classroom_id`) REFERENCES `classroom_classroom` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbox_inbox_classroom`
--

LOCK TABLES `inbox_inbox_classroom` WRITE;
/*!40000 ALTER TABLE `inbox_inbox_classroom` DISABLE KEYS */;
/*!40000 ALTER TABLE `inbox_inbox_classroom` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbox_inbox_content`
--

LOCK TABLES `inbox_inbox_content` WRITE;
/*!40000 ALTER TABLE `inbox_inbox_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `inbox_inbox_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `polls_choice`
--

DROP TABLE IF EXISTS `polls_choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `polls_choice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `choice_text` varchar(200) NOT NULL,
  `votes` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `polls_choice_7aa0f6ee` (`question_id`),
  CONSTRAINT `polls_choice_question_id_c5b4b260_fk_polls_question_id` FOREIGN KEY (`question_id`) REFERENCES `polls_question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polls_choice`
--

LOCK TABLES `polls_choice` WRITE;
/*!40000 ALTER TABLE `polls_choice` DISABLE KEYS */;
/*!40000 ALTER TABLE `polls_choice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `polls_question`
--

DROP TABLE IF EXISTS `polls_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `polls_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_text` varchar(200) NOT NULL,
  `pub_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polls_question`
--

LOCK TABLES `polls_question` WRITE;
/*!40000 ALTER TABLE `polls_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `polls_question` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_report_type`
--

LOCK TABLES `report_report_type` WRITE;
/*!40000 ALTER TABLE `report_report_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_report_type` ENABLE KEYS */;
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
  CONSTRAINT `timetable_activ_start_date_id_81377377_fk_timetable_time_meta_id` FOREIGN KEY (`start_date_id`) REFERENCES `timetable_time_meta` (`id`),
  CONSTRAINT `timetable_activit_end_date_id_dcfdaa38_fk_timetable_time_meta_id` FOREIGN KEY (`end_date_id`) REFERENCES `timetable_time_meta` (`id`),
  CONSTRAINT `timetable__activity_name_id_8fd93868_fk_timetable_event_terms_id` FOREIGN KEY (`activity_name_id`) REFERENCES `timetable_event_terms` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timetable_event_terms`
--

LOCK TABLES `timetable_event_terms` WRITE;
/*!40000 ALTER TABLE `timetable_event_terms` DISABLE KEYS */;
INSERT INTO `timetable_event_terms` VALUES (2,'test');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timetable_time_meta`
--

LOCK TABLES `timetable_time_meta` WRITE;
/*!40000 ALTER TABLE `timetable_time_meta` DISABLE KEYS */;
INSERT INTO `timetable_time_meta` VALUES (1,'2016-03-13 16:00:00'),(2,'2016-03-13 17:20:17'),(3,'2016-03-14 10:00:00');
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
  `calender_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `system_generated` tinyint(1) NOT NULL,
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
  `class_code_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `class_number` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_class_assignment_e57bc57a` (`class_code_id`),
  KEY `user_class_assignment_e8701ad4` (`user_id`),
  CONSTRAINT `user_class_assignment_user_id_31874b31_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `user_class_assignme_class_code_id_41bf0707_fk_user_class_code_id` FOREIGN KEY (`class_code_id`) REFERENCES `user_class_code` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_class_assignment`
--

LOCK TABLES `user_class_assignment` WRITE;
/*!40000 ALTER TABLE `user_class_assignment` DISABLE KEYS */;
INSERT INTO `user_class_assignment` VALUES (1,1,2,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_class_code`
--

LOCK TABLES `user_class_code` WRITE;
/*!40000 ALTER TABLE `user_class_code` DISABLE KEYS */;
INSERT INTO `user_class_code` VALUES (1,'1A',''),(2,'1B',''),(3,'1C',''),(4,'1D',''),(5,'1E',''),(6,'2A',''),(7,'2B',''),(8,'2C',''),(9,'2D',''),(10,'2E',''),(11,'3A',''),(12,'3B',''),(13,'3C',''),(14,'3D',''),(15,'3E',''),(16,'4A',''),(17,'5A',''),(18,'6A',''),(19,'4B',''),(20,'5B',''),(21,'6B',''),(22,'4C',''),(23,'5C',''),(24,'6C',''),(25,'4D',''),(26,'5D',''),(27,'6D','');
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
  `permission_key_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_permission_2e788633` (`permission_key_id`),
  KEY `user_permission_e8701ad4` (`user_id`),
  CONSTRAINT `user_permi_permission_key_id_b566784c_fk_user_permission_meta_id` FOREIGN KEY (`permission_key_id`) REFERENCES `user_permission_meta` (`id`),
  CONSTRAINT `user_permission_user_id_094cc8c7_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permission`
--

LOCK TABLES `user_permission` WRITE;
/*!40000 ALTER TABLE `user_permission` DISABLE KEYS */;
INSERT INTO `user_permission` VALUES (1,4,1),(2,1,1);
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
  `permission_key` varchar(255) NOT NULL,
  `permission_description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permission_meta`
--

LOCK TABLES `user_permission_meta` WRITE;
/*!40000 ALTER TABLE `user_permission_meta` DISABLE KEYS */;
INSERT INTO `user_permission_meta` VALUES (1,'user_allow_delete','Allow delete user account'),(2,'user_allow_modify','Allow modify user account'),(3,'user_allow_add','Allow add user account'),(4,'user_allow_detail_view','user_allow_detail_view');
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
  `role_user` varchar(3) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_role_e8701ad4` (`user_id`),
  CONSTRAINT `user_role_user_id_12d84374_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,'ADM',1);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_session`
--

DROP TABLE IF EXISTS `user_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_token` varchar(32) NOT NULL,
  `user_id` int(11) NOT NULL,
  `timeout` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_session_user_id_babcef0a_fk_user_user_id` (`user_id`),
  CONSTRAINT `user_session_user_id_babcef0a_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_session`
--

LOCK TABLES `user_session` WRITE;
/*!40000 ALTER TABLE `user_session` DISABLE KEYS */;
INSERT INTO `user_session` VALUES (1,'rtertefeegvtrgtr',1,'2016-03-14 11:05:43');
/*!40000 ALTER TABLE `user_session` ENABLE KEYS */;
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
  `password_hash` varchar(96) NOT NULL,
  `card_id` varchar(20) NOT NULL,
  `strn_code` varchar(12) NOT NULL,
  `sams_code` varchar(12) NOT NULL,
  `jupas_app_code` varchar(32) NOT NULL,
  `barcode` varchar(32) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `hkid_card` varchar(12) NOT NULL,
  `address` longtext NOT NULL,
  `phone` varchar(24) NOT NULL,
  `mobile` varchar(24) NOT NULL,
  `email` varchar(254) NOT NULL,
  `national` varchar(24) NOT NULL,
  `location_of_birth` varchar(24) NOT NULL,
  `intake_date` varchar(24) NOT NULL,
  `sex_code` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user`
--

LOCK TABLES `user_user` WRITE;
/*!40000 ALTER TABLE `user_user` DISABLE KEYS */;
INSERT INTO `user_user` VALUES (1,'wormcih','Kong','Andy','bcrypt_sha256$$2b$12$XWmNIWDfMgwj6GnFspiOXeHsCmDqfxD93LtGttmYQVkU4o7oAl0gO','00023230262','y1091733','y1091733','aaa87231','023562356896523','2016-03-08','y1091733','flat z, 50/f, block d, gfkjrktrmgv graden, tin shui wai, nt, hk','685326523','53231565','s0002352@gmail.com','test','Hong Kong','now',''),(2,'user2','Wong','Kin Gwok','$2a$04$.dc9ojnByDAYACp35k4WKOSdZ6ffSJ5nSYMmYy0CmuJff.7rNns7e','3002302303','0fd56343','0fd56343','545435132','346353421365623421','1908-01-03','0fd56343','flat z, 50/f, block d, gfkjrktrmgv graden, tin shui wai, nt, hk','6853452326523','343423445','s0002342@gmail.com','test2','Hong Kong','2016-01-03','');
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

-- Dump completed on 2016-03-15 22:45:35
