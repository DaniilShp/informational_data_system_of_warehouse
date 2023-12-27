CREATE DATABASE  IF NOT EXISTS `sclad` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sclad`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sclad
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `accounting`
--

DROP TABLE IF EXISTS `accounting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounting` (
  `idaccounting` int NOT NULL AUTO_INCREMENT,
  `product_cost` int unsigned DEFAULT NULL,
  `product_amount` int unsigned DEFAULT NULL,
  `varification_date` date DEFAULT NULL,
  `idproduct` int DEFAULT NULL,
  PRIMARY KEY (`idaccounting`),
  KEY `idproduct_idx` (`idproduct`),
  CONSTRAINT `idproduct` FOREIGN KEY (`idproduct`) REFERENCES `product` (`idproduct`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounting`
--

LOCK TABLES `accounting` WRITE;
/*!40000 ALTER TABLE `accounting` DISABLE KEYS */;
INSERT INTO `accounting` VALUES (1,1000,41,'2023-12-16',1),(2,2000,5,'2023-11-10',2),(3,1100,10,'2023-11-10',3),(4,1900,10,'2023-11-10',4),(6,1,1,'2023-12-14',16),(7,700,10,'2023-12-14',14),(8,5000,10,'2023-12-14',12),(9,2000,10,'2023-12-14',13),(10,1200,40,'2023-12-14',14),(11,14,1250,'2023-12-14',15),(12,800,50,'2023-12-14',3),(13,2500,20,'2023-12-14',4),(14,25000,10,'2023-12-14',16),(15,50000,6,'2023-12-15',17),(16,2000,20,'2023-12-14',18),(17,8750,4,'2023-12-14',19),(18,12500,4,'2023-12-14',20),(19,1200,5,'2023-12-14',2),(20,3500,11,'2023-12-16',11),(21,1500,10,'2023-12-16',14),(22,1500,10,'2023-12-16',15),(23,3000,10,'2023-12-16',5),(24,1500,5,'2023-12-16',1),(25,3800,5,'2023-12-16',12),(26,1125,8,'2023-12-16',13),(27,1600,5,'2023-12-16',2),(28,1400,12,'2023-12-16',3),(29,4000,8,'2023-12-16',4),(30,1200,15,'2023-12-16',1);
/*!40000 ALTER TABLE `accounting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `count_invoices`
--

DROP TABLE IF EXISTS `count_invoices`;
/*!50001 DROP VIEW IF EXISTS `count_invoices`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `count_invoices` AS SELECT 
 1 AS `number_of_invoices`,
 1 AS `idseller`,
 1 AS `name`,
 1 AS `location`,
 1 AS `bank`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `external_users`
--

DROP TABLE IF EXISTS `external_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_users` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `login` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `id_seller` int unsigned DEFAULT NULL,
  PRIMARY KEY (`userid`),
  KEY `idseller_idx` (`id_seller`),
  CONSTRAINT `id_seller` FOREIGN KEY (`id_seller`) REFERENCES `seller` (`idseller`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_users`
--

LOCK TABLES `external_users` WRITE;
/*!40000 ALTER TABLE `external_users` DISABLE KEYS */;
INSERT INTO `external_users` VALUES (1,'seller1','1',1),(2,'seller2','2',2),(3,'seller3','3',3),(4,'seller4','4',4);
/*!40000 ALTER TABLE `external_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `internal_users`
--

DROP TABLE IF EXISTS `internal_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internal_users` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `login` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `user_group` varchar(45) NOT NULL DEFAULT 'ordinary',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internal_users`
--

LOCK TABLES `internal_users` WRITE;
/*!40000 ALTER TABLE `internal_users` DISABLE KEYS */;
INSERT INTO `internal_users` VALUES (1,'admin1','1234','admin'),(2,'admin2','4321','admin'),(3,'manager1','0000','manager'),(4,'ordinary worker1','1','ordinary'),(5,'ordinary worker2','2','ordinary'),(6,'ordinary worker3','3','ordinary'),(7,'admin','1234','admin'),(8,'director','!','director');
/*!40000 ALTER TABLE `internal_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `idinvoice` int NOT NULL AUTO_INCREMENT,
  `total_sum` int unsigned NOT NULL,
  `idseller` int unsigned NOT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`idinvoice`),
  KEY `fk_idseller_idx` (`idseller`),
  CONSTRAINT `fk_idseller` FOREIGN KEY (`idseller`) REFERENCES `seller` (`idseller`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (1,10000,1,'2020-10-13'),(2,20000,1,'2020-10-15'),(3,30000,2,'2020-10-20'),(31,7000,1,'2020-10-21'),(32,135500,1,'2021-12-14'),(33,90000,2,'2022-12-15'),(34,625000,4,'2023-12-14'),(36,50000,4,'2022-12-15'),(37,98500,1,'2022-12-16'),(38,43500,1,'2023-12-16'),(39,48800,2,'2023-12-16'),(40,29000,1,'2023-12-16');
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `idproduct` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `measurerment_unit` varchar(45) DEFAULT NULL,
  `shifr` varchar(45) NOT NULL,
  `idseller` int unsigned NOT NULL,
  PRIMARY KEY (`idproduct`),
  KEY `fk_product_seller1_idx` (`idseller`),
  CONSTRAINT `fk_product_seller1` FOREIGN KEY (`idseller`) REFERENCES `seller` (`idseller`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'спорт инвентарь','шт','мяч футбольный 1',1),(2,'спорт инвентарь','шт','мяч футбольный 2',1),(3,'спорт инвентарь','шт','мяч футбольный 3',2),(4,'обувь','пара','бутсы 1',2),(5,'обувь','пара','кроссовки1',1),(11,'обувь','пара','кроссовки2',1),(12,'одежда','шт','зимняя куртка',1),(13,'одежда','шт','спортивные брюки',1),(14,'одежда','шт','футболка1',1),(15,'одежда','шт','футболка2',1),(16,'портативная электроника','шт','смартфон1',4),(17,'портативная электроника','шт','ноутбук1',4),(18,'портативная электроника','шт','беспроводные наушники 1',4),(19,'умный дом','комплект','датчики безопасности1',4),(20,'умный дом','комплект','система видеонаблюдения1',4),(21,'умный дом','комплект','умные розетки1',4);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `idseller` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `location` varchar(45) DEFAULT NULL,
  `bank` varchar(45) DEFAULT NULL,
  `bank_account_number` int DEFAULT NULL,
  `contract_signing` date DEFAULT NULL,
  `telephone_number` decimal(11,0) DEFAULT NULL,
  PRIMARY KEY (`idseller`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` VALUES (1,'поставщик спортивных товаров 1','Москва','sber',1234,'2020-03-12',84951234567),(2,'поставщик спортивных товаров 2','Московская область','vtb',1235,'2020-03-10',84951234568),(3,'неактивный продавец','Москва','bank№1',1236,'2023-10-12',89871234455),(4,'поставщик электроники 1','Тайвань, Синьчжу','bank_taiwan',7643,'2023-11-02',88603952484);
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supply`
--

DROP TABLE IF EXISTS `supply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supply` (
  `idsupply` int NOT NULL AUTO_INCREMENT,
  `product_cost` int DEFAULT NULL,
  `product_amount` int DEFAULT NULL,
  `idinvoice` int DEFAULT NULL,
  `idproduct` int DEFAULT NULL,
  PRIMARY KEY (`idsupply`),
  KEY `fk_idinvoice_idx` (`idinvoice`),
  KEY `fk_idproduct_idx` (`idproduct`),
  CONSTRAINT `fk_idinvoice` FOREIGN KEY (`idinvoice`) REFERENCES `invoice` (`idinvoice`),
  CONSTRAINT `fk_idproduct` FOREIGN KEY (`idproduct`) REFERENCES `product` (`idproduct`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supply`
--

LOCK TABLES `supply` WRITE;
/*!40000 ALTER TABLE `supply` DISABLE KEYS */;
INSERT INTO `supply` VALUES (1,1000,10,1,1),(2,1000,10,2,1),(3,2000,5,2,2),(4,1100,10,3,3),(5,1900,10,3,4),(26,700,10,31,14),(27,5000,10,32,12),(28,2000,10,32,13),(29,1200,40,32,14),(30,14,1250,32,15),(31,800,50,33,3),(32,2500,20,33,4),(33,25000,10,34,16),(34,50000,5,34,17),(35,2000,20,34,18),(36,8750,4,34,19),(37,12500,4,34,20),(41,3500,11,37,11),(42,1500,10,37,14),(43,1500,10,37,15),(44,3000,10,37,5),(45,1500,5,38,1),(46,3800,5,38,12),(47,1125,8,38,13),(48,1600,5,38,2),(49,1400,12,39,3),(50,4000,8,39,4),(51,1000,11,40,1),(52,1200,15,40,1);
/*!40000 ALTER TABLE `supply` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `supply_AFTER_INSERT` AFTER INSERT ON `supply` FOR EACH ROW BEGIN
	if exists(select * FROM accounting WHERE idproduct = new.idproduct and product_cost = new.product_cost)
		then update accounting set product_amount = product_amount+new.product_amount, varification_date = curdate()
        WHERE idproduct = new.idproduct and product_cost = new.product_cost; 
	else
		insert into accounting VALUES (NULL, new.product_cost, new.product_amount, curdate(), new.idproduct);
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `update_activities`
--

DROP TABLE IF EXISTS `update_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `update_activities` (
  `idreport` int NOT NULL AUTO_INCREMENT,
  `idseller` int unsigned DEFAULT NULL,
  `invoice_amount` int DEFAULT NULL,
  `average_cost` int DEFAULT NULL,
  `total_sum` int DEFAULT NULL,
  `mounth_activity` int DEFAULT NULL,
  `year_activity` int DEFAULT NULL,
  PRIMARY KEY (`idreport`),
  KEY `idseller_idx` (`idseller`),
  CONSTRAINT `idseller` FOREIGN KEY (`idseller`) REFERENCES `seller` (`idseller`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `update_activities`
--

LOCK TABLES `update_activities` WRITE;
/*!40000 ALTER TABLE `update_activities` DISABLE KEYS */;
INSERT INTO `update_activities` VALUES (15,1,3,1057,37000,10,2020),(16,2,1,1500,30000,10,2020);
/*!40000 ALTER TABLE `update_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `update_supply`
--

DROP TABLE IF EXISTS `update_supply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `update_supply` (
  `id_report` int NOT NULL AUTO_INCREMENT,
  `id_product` int DEFAULT NULL,
  `idseller` int unsigned DEFAULT NULL,
  `product_cost` int DEFAULT NULL,
  `product_amount` int DEFAULT NULL,
  `year_supply` int DEFAULT NULL,
  `mounth_supply` int DEFAULT NULL,
  PRIMARY KEY (`id_report`),
  KEY `idseller_idx` (`idseller`),
  KEY `id_prod_idx` (`id_product`),
  CONSTRAINT `fk_id_slr` FOREIGN KEY (`idseller`) REFERENCES `seller` (`idseller`),
  CONSTRAINT `id_prod` FOREIGN KEY (`id_product`) REFERENCES `product` (`idproduct`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `update_supply`
--

LOCK TABLES `update_supply` WRITE;
/*!40000 ALTER TABLE `update_supply` DISABLE KEYS */;
INSERT INTO `update_supply` VALUES (121,1,1,1000,20,2020,10),(122,2,1,2000,5,2020,10),(123,3,2,1100,10,2020,10),(124,4,2,1900,10,2020,10),(125,14,1,700,10,2020,10);
/*!40000 ALTER TABLE `update_supply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'sclad'
--

--
-- Dumping routines for database 'sclad'
--
/*!50003 DROP PROCEDURE IF EXISTS `update_accounting` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_accounting`(date_accounting DATE, unused INT)
BEGIN
declare done int default 0;
declare num int;
declare amount int;
declare cost int;
declare total int default 0;
declare c1 cursor for select idproduct, sum(product_amount), product_cost from invoice join supply using(idinvoice)
WHERE invoice.date <= date_accounting group by idproduct, product_cost;
declare continue handler for sqlstate '02000' set done = 1;
open c1;
while done = 0
do
fetch c1 into num, amount, cost;
if done = 0
then
	if exists(select * FROM update_accounting WHERE id_product = num and product_cost = cost and varification_date = date_accounting)
	then
		update update_accounting set product_amount = amount WHERE id_product = num and product_cost = cost; 
	else
		insert into update_accounting VALUES (NULL, num, cost, amount, date_accounting);
	end if; 
end if;
end while;
close c1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_activities` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_activities`(year_of_activity INT, mounth_of_activity int)
BEGIN
declare idslr INT DEFAULT 0; 
declare inv_mnt INT DEFAULT 0;
declare avg_cost INT default 0;
declare ttl_sum INT DEFAULT 0;
declare done INT default 0;
declare c1 cursor for select idseller, count(DISTINCT idinvoice) as invoice_amount, sum(product_cost * product_amount)/sum(product_amount), sum(product_cost * product_amount) as total_sum from invoice join supply using(idinvoice)
WHERE YEAR(invoice.date)=year_of_activity and MONTH(invoice.date)=mounth_of_activity group by idseller;
declare continue handler for sqlstate '02000' set done = 1;
open c1;
while done = 0
do
fetch c1 into idslr, inv_mnt, avg_cost, ttl_sum;
if done = 0
then
INSERT INTO update_activities (idreport, idseller, invoice_amount, average_cost, total_sum, mounth_activity, year_activity) 
VALUES(NULL, idslr, inv_mnt, avg_cost, ttl_sum, mounth_of_activity, year_of_activity);
end if;
end while;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_supply` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_supply`(year_s INT, mounth_s INT)
BEGIN
declare done int default 0;
declare num int;
declare amount int;
declare cost int;
declare idslr int;
declare total int default 0;
declare c1 cursor for select idseller, idproduct, sum(product_amount), product_cost from invoice join supply using(idinvoice)
WHERE Year(invoice.date) = year_s and MONTH(invoice.date) = mounth_s group by idseller, idproduct, product_cost;
declare continue handler for sqlstate '02000' set done = 1;
open c1;
while done = 0
do
fetch c1 into idslr, num, amount, cost;
if done = 0
then
	if exists(select * FROM update_supply WHERE id_product = num and product_cost = cost and year_supply = year_s and mounth_supply = mounth_s and idslr = idseller)
	then
		update update_supply set product_amount = amount WHERE id_product = num and product_cost = cost; 
	else
		insert into update_supply VALUES (NULL, num, idslr, cost, amount, year_s, mounth_s);
	end if; 
end if;
end while;
close c1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `count_invoices`
--

/*!50001 DROP VIEW IF EXISTS `count_invoices`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `count_invoices` AS select count(`invoice`.`idinvoice`) AS `number_of_invoices`,`invoice`.`idseller` AS `idseller`,`seller`.`name` AS `name`,`seller`.`location` AS `location`,`seller`.`bank` AS `bank` from (`invoice` join `seller` on((`invoice`.`idseller` = `seller`.`idseller`))) group by `invoice`.`idseller` */;
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

-- Dump completed on 2023-12-27 15:15:00
