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
INSERT INTO `album_photobook` VALUES (8,2),(8,3),(8,6),(8,8),(8,9);
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
  `favorite` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  CONSTRAINT `albums_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
INSERT INTO `albums` VALUES (8,'Favorite album','./uploads/media/2/images/309cdf11-451c-46af-bbf1-8b940201413f.jpg',2,0),(16,'Old fashion','./uploads/media/2/images/b5630f2f-c594-4292-a35c-8934f78ffd8b.jpg',2,0),(17,'Journey','./uploads/media/2/images/d20bd67d-35e8-4a0e-bd8e-b62159394bc2.jpg',2,0),(18,'Memory','./uploads/media/4/images/af534523-6870-4830-a919-fea2c6958336.jpg',4,0),(22,'Test',NULL,9,0);
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
  `favorite` tinyint(1) NOT NULL DEFAULT '0',
  `description` text,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  CONSTRAINT `photobooks_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photobooks`
--

LOCK TABLES `photobooks` WRITE;
/*!40000 ALTER TABLE `photobooks` DISABLE KEYS */;
INSERT INTO `photobooks` VALUES (1,'My book','./uploads/media/2/images/27ff93fb-890d-4bc1-8f3c-605de4453621.jpg',2,1,'Risus diam quidem platea tempus cupiditate, blandit impedit culpa cupiditate per natoque, unde accusantium fugiat, quisquam, erat hac, quisquam porta maiores varius accusamus? Felis. Sed minus aliquam! Dictumst blandit assumenda, pharetra ultrices, incididunt varius. Lacus, alias, varius tortor magnam laoreet, sodales nullam, dolor ex tincidunt natoque delectus voluptatibus.'),(2,'Peace','./uploads/media/2/images/2b3d68af-dd72-4da9-9feb-fb06274d33be.jpg',2,1,'Eum varius, eaque tempore suscipit odit tristique mollis molestias veritatis, in dolores, nisi dui corporis. Turpis? Cum quae et numquam eiusmod, laoreet inventore sodales aenean animi proident et wisi. Volutpat cupiditate hendrerit, dis, accusamus. Scelerisque facere! Primis corrupti magnam! Bibendum nam inventore eget illum nibh? Dictumst beatae, magnam.'),(3,'Love','./uploads/media/2/images/32e12a21-ef24-4b30-93c1-1b956bb189bd.jpg',2,1,'Sapiente scelerisque libero earum fames elit occaecat nostrud lacus officiis risus nulla? Odit mi, excepteur mattis voluptatum harum? Sequi, animi sociis taciti cumque aptent suscipit sagittis? Cumque fames, hymenaeos orci? Quaerat aute adipisci exercitationem aliquip montes, repellat earum placeat diamlorem! Unde quia tellus minim, nesciunt, officia consequatur quam.'),(4,'Happy','./uploads/media/2/images/fc1a359e-7e22-4e20-bac1-dd9fe09c58ea.jpg',2,0,'Tellus voluptas convallis eos malesuada excepteur. Nunc sint neque natus illum hendrerit quaerat facilis feugiat lacus, potenti aliquid, fuga platea, illo, tempor accusamus felis, repellendus do eligendi ex fames netus quibusdam, excepturi nibh lacinia tempora dictum lectus occaecat doloribus illum, malesuada odit perspiciatis quo, praesentium, felis, dui consequuntur.'),(6,'Falling','./uploads/media/2/images/1ad84df8-8cc6-43db-8356-eeab585c77f4.jpg',2,0,'Ullamcorper ullamco, ornare luctus consectetur cupiditate, tristique earum dolore diamlorem, elit quos, voluptate? Malesuada? Doloremque fugit, dolores sit, cumque fugit hic, felis, hac laboris veritatis laoreet, turpis iaculis! Gravida laboriosam voluptatum exercitationem? Nibh tenetur optio, vero! Gravida nemo, tristique hic, inceptos necessitatibus id inventore deleniti ea etiam recusandae.'),(7,'On Ice','./uploads/media/2/images/c019b9c3-fa46-4b66-ba8a-5c9eb4fef501.jpg',2,0,NULL),(8,'My first photobook','./uploads/media/3/images/556d6493-bfce-46c7-bd0f-25c2ddd16ebd.png',3,0,NULL),(9,'Snow wolf','./uploads/media/4/images/0929bd0a-8280-45d2-b0b4-0a8995d67a85.jpg',4,0,NULL),(10,'Wonderland','./uploads/media/4/images/4e5b504f-f69f-4da1-8ec8-e5c48cba4a94.jpg',4,0,NULL),(11,'A little star','./uploads/media/4/images/0faab02f-664e-4af9-847a-6bd711f80060.jpg',4,0,NULL),(30,'Love book','./uploads/media/2/images/4ea42d9e-c8ac-4e32-a3ea-362068074f19.jpg',2,0,'\"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?\"'),(39,'Hic consectetuer','./uploads/media/2/images/b493c4ae-547c-45d4-a4ec-6dba359fa41c.jpg',2,0,'Nesciunt dicta suscipit culpa, illo, earum lacinia nunc omnis habitant gravida, impedit viverra a suscipit magnam cursus ut luctus! Vitae ipsa, porttitor molestie debitis occaecat tortor occaecati excepturi illum donec, porta, cras, eros et ut elit? Parturient lacus feugiat dicta maecenas faucibus, quod, semper temporibus, aliquip quod class.'),(40,'Nostrud id cras dolores.','./uploads/media/4/images/655dc38b-5b4d-4e9e-b2ca-a7445eb51b9d.jpg',4,0,'Tortor quibusdam arcu cras lacus. Est proident, nobis adipisci semper quia fusce, magni turpis iste cillum, itaque voluptas? Maiores dicta amet maecenas facere? Dignissim potenti eleifend. Proin minus primis hendrerit placeat at. Integer, porta netus, congue cursus ut, dignissim, tortor, tristique volutpat! Egestas elementum ab, hic. Sociosqu augue.');
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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photopages`
--

LOCK TABLES `photopages` WRITE;
/*!40000 ALTER TABLE `photopages` DISABLE KEYS */;
INSERT INTO `photopages` VALUES (1,6,'./uploads/media/2/images/ff17195b-97d5-47c6-ada5-ac30cdc477d6.png','First page'),(2,7,'./uploads/media/2/images/5090b65a-8982-4dcc-b74e-14c47fa99e3a.png','A New Way of Life'),(3,7,'./uploads/media/2/images/455bee34-23d1-4bf8-8c66-8d5774ae954a.jpg','Becoming a Creative Channel'),(4,8,'./uploads/media/3/images/40c2900e-b225-4373-867d-5567417db096.png','Blind Forest'),(5,10,'./uploads/media/4/images/db116838-599d-4d20-9e0e-8d352a98b89e.png','Land of giant'),(6,11,'./uploads/media/4/images/c56bb4e7-0463-4508-b3fa-d66a11a01a91.jpg','First star'),(7,11,'./uploads/media/4/images/c3bf62fd-5adf-48c7-b54f-5661e3f3e823.png','Falling stars'),(8,11,'./uploads/media/4/images/905f1611-93f8-4680-8644-28217a793344.jpg','Wander stars'),(9,11,'./uploads/media/4/images/95a358c6-ed96-4cc0-8666-35f14fac1d44.jpg','Nebula'),(16,30,'./uploads/media/2/images/7c806a3a-cff6-4c9f-befb-d435b222e6ec.jpg','Self love'),(17,2,'./uploads/media/2/images/6dbc0d35-2d3f-4706-9864-8d0ec8030418.jpg','Tellus esse tempora, proin.'),(18,2,'./uploads/media/2/images/16be4303-5125-4909-9cc6-3051f9b925bd.jpg','Labore odit! Iaculis pulvinar.'),(19,2,NULL,NULL),(20,2,NULL,NULL),(21,2,'./uploads/media/2/images/8bd98fcf-6128-4e31-85a0-9a3afe6c1646.jpg','Mollis reiciendis eveniet quas.'),(22,4,'./uploads/media/2/images/839cbccb-38e1-4c96-b225-ac7da72d157a.jpg','Suscipit ullam proident quisque.'),(23,4,'./uploads/media/2/images/c6819f84-66aa-4a2a-95e9-c6e2bca92656.png','Quis conubia exercitationem eleifend.'),(24,4,'./uploads/media/2/images/353b8c5a-c2de-451e-b06a-d532deaef02b.jpg','Deleniti nostrud proident autem.'),(25,4,'./uploads/media/2/images/839cbccb-38e1-4c96-b225-ac7da72d157a.jpg','Suscipit ullam proident quisque.'),(26,4,'./uploads/media/2/images/c6819f84-66aa-4a2a-95e9-c6e2bca92656.png','Quis conubia exercitationem eleifend.'),(27,4,'./uploads/media/2/images/4a93b46b-73ee-4302-9cd7-572c5bc89995.jpg','Deleniti nostrud proident autem.'),(28,4,'./uploads/media/2/images/839cbccb-38e1-4c96-b225-ac7da72d157a.jpg','Suscipit ullam proident quisque.'),(29,4,'./uploads/media/2/images/c6819f84-66aa-4a2a-95e9-c6e2bca92656.png','Quis conubia exercitationem eleifend.'),(30,4,'./uploads/media/2/images/4a93b46b-73ee-4302-9cd7-572c5bc89995.jpg','Deleniti nostrud proident autem.'),(31,4,'./uploads/media/2/images/839cbccb-38e1-4c96-b225-ac7da72d157a.jpg','Suscipit ullam proident quisque.'),(32,4,'./uploads/media/2/images/c6819f84-66aa-4a2a-95e9-c6e2bca92656.png','Quis conubia exercitationem eleifend.'),(33,4,'./uploads/media/2/images/4a93b46b-73ee-4302-9cd7-572c5bc89995.jpg','Deleniti nostrud proident autem.'),(34,1,'./uploads/media/2/images/02d08555-fa5f-46da-a068-ba35fdd39e87.jpg','Nesciunt vero, inceptos enim.'),(35,1,'./uploads/media/2/images/0fda7fdf-5bba-4147-a7b2-ec6e46ec4ac5.jpg','Praesent perferendis etiam vulputate.'),(36,1,'./uploads/media/2/images/1d5db5ea-c68b-4216-8d81-6897e96f3d9a.jpg','Perferendis phasellus ipsam animi.'),(37,1,'./uploads/media/2/images/02d08555-fa5f-46da-a068-ba35fdd39e87.jpg','Nesciunt vero, inceptos enim.'),(38,1,'./uploads/media/2/images/0fda7fdf-5bba-4147-a7b2-ec6e46ec4ac5.jpg','Praesent perferendis etiam vulputate.'),(39,1,'./uploads/media/2/images/587d6870-544f-4898-af20-8abdaba47455.jpg','Perferendis phasellus ipsam animi.'),(40,3,'./uploads/media/2/images/2dd6cd60-be99-44db-a7d2-b554cd9f1159.jpg','Deserunt etiam donec. Sagittis.'),(41,3,'./uploads/media/2/images/9c0bbbfd-eb3f-4973-ac5f-4bd5c2bdeb10.jpg','Ea curabitur, ridiculus neque.'),(42,3,'./uploads/media/2/images/20c9070a-7ca1-4a6d-b953-cf167860bd4c.jpg','Exercitationem, magna tristique. Augue.'),(43,39,'./uploads/media/2/images/94abb7aa-ec07-4ed4-bb04-612387bd9150.jpg','Nostrum enim, rhoncus nihil.'),(44,39,'./uploads/media/2/images/b465e860-9e13-4ebe-86e8-189dbb8f6fa9.jpg','Cillum conubia quas? Aptent.'),(45,40,'./uploads/media/4/images/303f94af-5e08-4109-b2e6-9a3932c99fc4.jpg','Dui! Felis tellus nesciunt.'),(46,40,'./uploads/media/4/images/4823a6a4-5cf7-4dde-9fc0-ca0484999ee3.jpg','Parturient. Id sunt facilisis.');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'Student','student@gmail.com','$2a$10$8mIe7T4/YhXg/BJ983cI1OCNcfvZMjBPGX2cuqXNJr6vKU.7ugb8u'),(3,'User','user@gmail.com','$2a$10$8mIe7T4/YhXg/BJ983cI1OCNcfvZMjBPGX2cuqXNJr6vKU.7ugb8u'),(4,'Guys','guys@gmail.com','$2a$10$8mIe7T4/YhXg/BJ983cI1OCNcfvZMjBPGX2cuqXNJr6vKU.7ugb8u'),(5,'Nghia','nghia@gmail.com','$2a$10$8mIe7T4/YhXg/BJ983cI1OCNcfvZMjBPGX2cuqXNJr6vKU.7ugb8u'),(8,'Rose','rose@gmail.com','$2b$10$kbBJbPwFWlMNy5QsmLkdnePGbiPCNV0InnPEosQ6R7QXe8H0EwpZ6'),(9,'XXX','xxx@gmail.com','$2b$10$aSzCe50.TzTeo7i4wuqVhub0tUDBzEtkGdDjvPsN20ee0cRvGUbXC'),(10,'Abc','abc@gmail.com','$2b$10$AusE7f.u3NKoeSHnLn.oouS/jDgl5T3ZcPb4aJ1dmZkzm6VfhYC0m');
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

-- Dump completed on 2022-12-04 10:54:57
