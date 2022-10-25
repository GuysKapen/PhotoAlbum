mysqldump: [Warning] Using a password on the command line interface can be insecure.
-- MySQL dump 10.13  Distrib 8.0.31, for Linux (x86_64)
--
-- Host: localhost    Database: photobook
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `album_photobook`
--

DROP TABLE IF EXISTS `album_photobook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album_photobook` (
  `album_id` int NOT NULL,
  `photobook_id` int NOT NULL,
  PRIMARY KEY (`album_id`,`photobook_id`),
  KEY `photobook_id` (`photobook_id`),
  CONSTRAINT `album_photobook_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`) ON DELETE CASCADE,
  CONSTRAINT `album_photobook_ibfk_2` FOREIGN KEY (`photobook_id`) REFERENCES `photobooks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_photobook`
--

LOCK TABLES `album_photobook` WRITE;
/*!40000 ALTER TABLE `album_photobook` DISABLE KEYS */;
INSERT INTO `album_photobook` VALUES (8,2),(8,3);
/*!40000 ALTER TABLE `album_photobook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albums` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `cover` text,
  `owner` int DEFAULT NULL,
  `favorite` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  CONSTRAINT `albums_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
INSERT INTO `albums` VALUES (8,'My album','./uploads/media/2/images/ab4c656d-a140-4ef1-9ea8-a56de258cd87.jpg',2,NULL);
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photobooks`
--

DROP TABLE IF EXISTS `photobooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photobooks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `cover` text,
  `owner` int DEFAULT NULL,
  `favorite` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  CONSTRAINT `photobooks_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photobooks`
--

LOCK TABLES `photobooks` WRITE;
/*!40000 ALTER TABLE `photobooks` DISABLE KEYS */;
INSERT INTO `photobooks` VALUES (1,'My book','./uploads/media/2/images/1197261a-584c-4e66-9506-5bcf2b1ed938.jpg',2,NULL),(2,'Peace','./uploads/media/2/images/2b3d68af-dd72-4da9-9feb-fb06274d33be.jpg',2,NULL),(3,'Love','./uploads/media/2/images/32e12a21-ef24-4b30-93c1-1b956bb189bd.jpg',2,NULL),(4,'Happy','./uploads/media/2/images/fc1a359e-7e22-4e20-bac1-dd9fe09c58ea.jpg',2,NULL),(6,'Test','./uploads/media/2/images/cca58eaf-b3bb-439f-8e18-079f1649fa83.jpg',2,NULL),(7,'On Ice','./uploads/media/2/images/c019b9c3-fa46-4b66-ba8a-5c9eb4fef501.jpg',2,NULL);
/*!40000 ALTER TABLE `photobooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photopages`
--

DROP TABLE IF EXISTS `photopages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photopages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `photobook_id` int DEFAULT NULL,
  `image` text,
  `content` text,
  PRIMARY KEY (`id`),
  KEY `photobook_id` (`photobook_id`),
  CONSTRAINT `photopages_ibfk_1` FOREIGN KEY (`photobook_id`) REFERENCES `photobooks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photopages`
--

LOCK TABLES `photopages` WRITE;
/*!40000 ALTER TABLE `photopages` DISABLE KEYS */;
INSERT INTO `photopages` VALUES (1,6,'./uploads/media/2/images/f59e68b1-138a-4328-b27f-94ef205f3b1a.jpg','First page'),(2,7,'./uploads/media/2/images/5090b65a-8982-4dcc-b74e-14c47fa99e3a.png','A New Way of Life'),(3,7,'./uploads/media/2/images/455bee34-23d1-4bf8-8c66-8d5774ae954a.jpg','Becoming a Creative Channel');
/*!40000 ALTER TABLE `photopages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'Student','student@gmail.com','password');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-25  4:39:22
