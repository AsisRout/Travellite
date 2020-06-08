-- MySQL dump 10.13  Distrib 8.0.20, for Linux (x86_64)
--
-- Host: localhost    Database: smart_travel_guide_webApp
-- ------------------------------------------------------
-- Server version	8.0.20-0ubuntu0.20.04.1

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
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `hotelbookid` int NOT NULL,
  `tourbookid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hotelbookid` (`hotelbookid`),
  KEY `tourbookid` (`tourbookid`),
  KEY `username` (`username`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`hotelbookid`) REFERENCES `hotelbook` (`id`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`tourbookid`) REFERENCES `tourbook` (`id`),
  CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8891 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (8888,'akbhobhiya',7777,1111),(8889,'asisrout',7778,1112),(8890,'jeeuk',7779,1113);
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `city_in_hotel`
--

DROP TABLE IF EXISTS `city_in_hotel`;
/*!50001 DROP VIEW IF EXISTS `city_in_hotel`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `city_in_hotel` AS SELECT 
 1 AS `hotelid`,
 1 AS `hotelname`,
 1 AS `hoteladd`,
 1 AS `rating`,
 1 AS `cost_per_room`,
 1 AS `room_avi`,
 1 AS `imgurl`,
 1 AS `cityid`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS `hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `dailyCost` decimal(6,2) NOT NULL,
  `address` varchar(30) DEFAULT NULL,
  `locationid` int NOT NULL,
  `roomAvi` int NOT NULL,
  `roomBook` int NOT NULL,
  `noOfStar` int NOT NULL,
  `img_url` varchar(200) NOT NULL,
  `amenities` varchar(1000) NOT NULL,
  `abouthotel` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `locationid` (`locationid`),
  CONSTRAINT `hotel_ibfk_1` FOREIGN KEY (`locationid`) REFERENCES `tourist_place` (`id`),
  CONSTRAINT `hotel_chk_1` CHECK ((`dailyCost` > 0)),
  CONSTRAINT `hotel_chk_2` CHECK (((`noOfStar` >= 1) and (`noOfStar` <= 10)))
) ENGINE=InnoDB AUTO_INCREMENT=2225 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel`
--

LOCK TABLES `hotel` WRITE;
/*!40000 ALTER TABLE `hotel` DISABLE KEYS */;
INSERT INTO `hotel` VALUES (2222,'SHRI SAI HOTEL',1200.00,'main road lal bhag',3112,100,23,10,'','',''),(2223,'SHRI SAI HOTEL1',1100.00,'Bhuto vali road',3113,100,23,8,'','',''),(2224,'SHRI SAI HOTEL2',1000.00,'Bhutni rahti hai yaha par',3114,100,23,7,'','','');
/*!40000 ALTER TABLE `hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotelbook`
--

DROP TABLE IF EXISTS `hotelbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotelbook` (
  `id` int NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `hotelid` int NOT NULL,
  `checkin` date NOT NULL,
  `checkout` date NOT NULL,
  `noOfrooms` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `hotelid` (`hotelid`),
  CONSTRAINT `hotelbook_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `hotelbook_ibfk_2` FOREIGN KEY (`hotelid`) REFERENCES `hotel` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotelbook`
--

LOCK TABLES `hotelbook` WRITE;
/*!40000 ALTER TABLE `hotelbook` DISABLE KEYS */;
INSERT INTO `hotelbook` VALUES (7777,'akbhobhiya',2222,'2020-05-30','2020-05-31',1),(7778,'asisrout',2223,'2020-05-30','2020-06-05',2),(7779,'jeeuk',2224,'2020-05-30','2020-06-05',2);
/*!40000 ALTER TABLE `hotelbook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotelreview`
--

DROP TABLE IF EXISTS `hotelreview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotelreview` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hotelname` varchar(100) NOT NULL,
  `detailedReview` varchar(1000) DEFAULT NULL,
  `submissionDate` datetime NOT NULL,
  `author` varchar(35) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `author` (`author`),
  KEY `hotelname` (`hotelname`),
  CONSTRAINT `hotelreview_ibfk_1` FOREIGN KEY (`author`) REFERENCES `users` (`username`),
  CONSTRAINT `hotelreview_ibfk_2` FOREIGN KEY (`hotelname`) REFERENCES `hotel` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1225 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotelreview`
--

LOCK TABLES `hotelreview` WRITE;
/*!40000 ALTER TABLE `hotelreview` DISABLE KEYS */;
INSERT INTO `hotelreview` VALUES (1222,'SHRI SAI HOTEL','its a good place to visit','2020-05-30 18:41:35','akbhobhiya'),(1223,'SHRI SAI HOTEL1','its a very good place to visit','2020-05-30 18:45:35','asisrout'),(1224,'SHRI SAI HOTEL2','its a not a good place to visit','2020-05-30 18:47:35','jeeuk');
/*!40000 ALTER TABLE `hotelreview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `place_pics`
--

DROP TABLE IF EXISTS `place_pics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `place_pics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `locationid` int NOT NULL,
  `caption` varchar(50) DEFAULT 'pic',
  `description` varchar(1000) DEFAULT NULL,
  `img` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `locationid` (`locationid`),
  CONSTRAINT `place_pics_ibfk_1` FOREIGN KEY (`locationid`) REFERENCES `tourist_place` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4325 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `place_pics`
--

LOCK TABLES `place_pics` WRITE;
/*!40000 ALTER TABLE `place_pics` DISABLE KEYS */;
INSERT INTO `place_pics` VALUES (4322,3112,'its a clockHouse','mana ki yahi clockhouse hai apn jayada kuch nahi kar sakte hai','/home/ashok/Desktop/image/clock.jpg'),(4323,3113,'its a Hawamahal','mana ki yahi hawamahal hai apn jayada kuch nahi kar sakte hai','/home/ashok/Desktop/image/hawamahal.jpg'),(4324,3114,'its a lack','mana ki yahi lack hai apn jayada kuch nahi kar sakte hai','/home/ashok/Desktop/image/lack.jpg');
/*!40000 ALTER TABLE `place_pics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numStars` int NOT NULL,
  `locationid` int NOT NULL,
  `detailedReview` varchar(1000) DEFAULT NULL,
  `submissionDate` datetime NOT NULL,
  `author` varchar(35) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `author` (`author`),
  KEY `locationid` (`locationid`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`author`) REFERENCES `users` (`username`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`locationid`) REFERENCES `tourist_place` (`id`),
  CONSTRAINT `review_chk_1` CHECK (((`numStars` >= 1) and (`numStars` <= 10)))
) ENGINE=InnoDB AUTO_INCREMENT=1519 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1516,8,3112,'its a good place to visit','2020-05-30 18:41:35','akbhobhiya'),(1517,10,3113,'its a very good place to visit','2020-05-30 18:45:35','asisrout'),(1518,4,3114,'its a not a good place to visit','2020-05-30 18:47:35','jeeuk');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourbook`
--

DROP TABLE IF EXISTS `tourbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourbook` (
  `id` int NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `locationid` int NOT NULL,
  `checkin` date NOT NULL,
  `checkout` date NOT NULL,
  `noOfticket` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `locationid` (`locationid`),
  CONSTRAINT `tourbook_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `tourbook_ibfk_4` FOREIGN KEY (`locationid`) REFERENCES `tourist_place` (`id`),
  CONSTRAINT `tourbook_ibfk_5` FOREIGN KEY (`locationid`) REFERENCES `tourist_place` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourbook`
--

LOCK TABLES `tourbook` WRITE;
/*!40000 ALTER TABLE `tourbook` DISABLE KEYS */;
INSERT INTO `tourbook` VALUES (1111,'akbhobhiya',3112,'2020-05-30','2020-05-31',11),(1112,'asisrout',3113,'2020-05-30','2020-06-01',10),(1113,'jeeuk',3114,'2020-05-30','2020-06-05',9);
/*!40000 ALTER TABLE `tourbook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourist_place`
--

DROP TABLE IF EXISTS `tourist_place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourist_place` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city` varchar(30) NOT NULL,
  `region` varchar(20) NOT NULL,
  `country` varchar(20) NOT NULL DEFAULT 'IN',
  `dailyCost` decimal(6,2) NOT NULL,
  `aviTour` int NOT NULL,
  `bookedTour` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `city` (`city`,`region`,`country`),
  CONSTRAINT `tourist_place_chk_1` CHECK ((`dailyCost` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=3115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourist_place`
--

LOCK TABLES `tourist_place` WRITE;
/*!40000 ALTER TABLE `tourist_place` DISABLE KEYS */;
INSERT INTO `tourist_place` VALUES (3112,'Churu','ClockHouse','India',3433.23,100,25),(3113,'jaipur','hawamahal','India',3422.23,125,50),(3114,'udaipur','sambharlack','India',3411.23,75,50);
/*!40000 ALTER TABLE `tourist_place` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(10) NOT NULL,
  `password` varchar(100) NOT NULL,
  `fullname` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  UNIQUE KEY `username` (`username`,`email`),
  UNIQUE KEY `username_2` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('akbhobhiya','kuchbhibolo','Ashok Bhobhiya','akbhobhiya2000@gmail.com'),('asisrout','kuchbhibolomat','Asis Rout','asisrout@gmail.com'),('jeeuk','kuchbhiboloabhi','Jeeu Kayshap','geetkayshap@gmail.com');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'smart_travel_guide_webApp'
--
/*!50003 DROP PROCEDURE IF EXISTS `get_hotel_from_city` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_hotel_from_city`(in Querycity varchar(100))
begin
select h.name,h.address,t.city,h.noOfStar as Rating, h.roomAvi,h.dailyCost as Price, h.img_url from hotel h, tourist_place t where h.locationid=t.id and t.city= Querycity;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `city_in_hotel`
--

/*!50001 DROP VIEW IF EXISTS `city_in_hotel`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `city_in_hotel` AS select `h`.`id` AS `hotelid`,`h`.`name` AS `hotelname`,`h`.`address` AS `hoteladd`,`h`.`noOfStar` AS `rating`,`h`.`dailyCost` AS `cost_per_room`,`h`.`roomAvi` AS `room_avi`,`h`.`img_url` AS `imgurl`,`t`.`id` AS `cityid` from (`hotel` `h` join `tourist_place` `t`) where (`t`.`id` = `h`.`locationid`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-06  0:38:48
