-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: warehouse
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `area` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `house_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `house_type` tinyint DEFAULT NULL COMMENT '仓库类型（1药品，2医疗器械，3医疗辅助用品，4放射物资及危险品）',
  `area_type` tinyint DEFAULT NULL COMMENT '(0-暂存区，1-普通存储区，2-处理品区)',
  `shelve_num` int DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `area`
--

LOCK TABLES `area` WRITE;
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` VALUES (1,'A',1,0,6),(2,'A',1,1,12),(3,'A',1,2,4),(4,'B',2,0,6),(5,'B',2,1,12),(6,'B',2,2,4),(7,'C',3,0,2),(8,'C',3,1,6),(9,'C',3,2,2),(10,'D',4,0,1),(11,'D',4,1,0),(12,'D',4,2,0);
/*!40000 ALTER TABLE `area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `check_record`
--

DROP TABLE IF EXISTS `check_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `check_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `creator_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `state` tinyint DEFAULT NULL COMMENT '1创建盘点单，2完成盘点，3盘点审核通过，4盘点审核未通过，5已根据盘点结果修正系统数据 ',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `position_id` bigint DEFAULT NULL,
  `record_id` bigint DEFAULT NULL,
  `record_type` tinyint DEFAULT NULL,
  `batch_info` bigint DEFAULT NULL,
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `unit` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `unit_price` float(10,2) NOT NULL,
  `record_num` float DEFAULT NULL COMMENT '系统记录中的该货位物资数量',
  `real_num` float DEFAULT NULL COMMENT '经盘点该货位实际物资数量',
  `diff_num` float DEFAULT NULL COMMENT '差异数量（real_num-record_num）',
  `diff_price` float DEFAULT NULL COMMENT '总盘盈/盘亏金（含负数）',
  PRIMARY KEY (`id`,`unit_price`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `check_record`
--

LOCK TABLES `check_record` WRITE;
/*!40000 ALTER TABLE `check_record` DISABLE KEYS */;
INSERT INTO `check_record` VALUES (1,'2023-04-22 19:21:12',1,'zts',3,'盘一下',47,24,2,56,'消毒液','瓶',80.00,50,45,-5,-400),(2,'2023-04-22 22:56:48',1,'zts',3,'确定数量',30,27,2,65,'血糖仪','台',120.00,20,18,-2,-240),(3,'2023-04-22 23:32:53',1,'zts',3,'',29,31,2,84,'血糖仪','台',120.00,15,20,5,600),(4,'2023-05-31 01:25:13',1,'zts',1,'测试记录',8,32,2,88,'999感冒灵','盒',37.50,49,45,-4,-150);
/*!40000 ALTER TABLE `check_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`department_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'呼吸内科','12345678901'),(3,'神经内科','13987654321'),(7,'心血管内科','18876543210'),(8,'内分泌科','13512345678'),(9,'普通外科','13698765432'),(10,'神经外科','13876543210'),(11,'骨外科','13012345678'),(12,'妇科','13198765432'),(13,'产科','13276543210'),(14,'儿科','13312345678'),(15,'皮肤科','13498765432'),(16,'肿瘤内科','13776543210'),(17,'肿瘤外科','13812345678'),(18,'耳鼻喉科','13998765432'),(19,'眼科','13176543210'),(20,'口腔科','13212345678'),(21,'放射科','13398765432');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distance`
--

DROP TABLE IF EXISTS `distance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `distance` (
  `related_type` tinyint NOT NULL,
  `related_id` bigint NOT NULL,
  `distance` float DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distance`
--

LOCK TABLES `distance` WRITE;
/*!40000 ALTER TABLE `distance` DISABLE KEYS */;
INSERT INTO `distance` VALUES (0,5,30,1),(0,8,50,2),(1,1,0.5,5),(1,3,0.8,6),(1,7,1.2,7),(1,8,0.65,8),(1,9,0.9,9),(1,10,1.5,10),(1,11,0.7,11),(1,12,1,12),(1,13,1.3,13),(1,14,0.6,14),(1,15,0.85,15),(1,16,2,16),(1,17,1.8,17),(1,18,0.95,18),(1,19,1.1,19),(1,20,0.75,20),(1,21,1.7,21),(0,9,35,22),(0,10,1200,23),(0,11,2000,24),(0,12,1600,25),(0,13,1800,26);
/*!40000 ALTER TABLE `distance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods` (
  `goods_id` bigint NOT NULL AUTO_INCREMENT,
  `goods_type` tinyint DEFAULT NULL,
  `goods_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `goods_info` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `grounding_num` float DEFAULT '0',
  `unit` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`goods_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (1,1,'999感冒灵','每盒9袋，每袋10g',149,'盒'),(2,3,'医用口罩','10个/包',0,'包'),(5,1,'红霉素软膏','200g/盒',0,'盒'),(6,1,'阿莫西林胶囊','每粒含阿莫西林250mg，每盒装100粒',0,'盒'),(7,1,'盐酸氨溴索片','每片含氨溴索8mg，每盒装60片',0,'盒'),(9,2,'心电图机','12导联心电图机，附带电极贴片和导线',0,'台'),(11,2,'血液透析机','单台透析机，附带透析器和管路',0,'台'),(13,2,'血糖仪','家用血糖仪，附带试纸和针头',88,'台'),(15,3,'一次性手套','乳胶手套，每包100个',0,'包'),(16,3,'消毒液','有效杀菌消毒，每瓶500ml',45,'瓶'),(17,3,'吸氧管','成人型吸氧管，单个包装',30,'个'),(18,4,'碘放射性治疗仪','用于治疗甲状腺癌的放射性物品',1,'个'),(19,4,'放射性钴源','用于医学放射治疗的放射性物品',0,'个');
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trigger_warning_record` AFTER UPDATE ON `goods` FOR EACH ROW BEGIN
    DECLARE max_num FLOAT;
    DECLARE min_num FLOAT;
    SELECT max, min INTO max_num, min_num FROM warning WHERE goods_id = NEW.goods_id AND type = 1;
    IF EXISTS(SELECT * FROM warning_record WHERE goods_id = NEW.goods_id AND state = 0) THEN
        IF EXISTS(SELECT * FROM warning_record WHERE goods_id = NEW.goods_id AND state = 0 AND type = 1) THEN
            UPDATE warning_record SET extra_num = extra_num - (OLD.grounding_num - NEW.grounding_num), num = NEW.grounding_num WHERE goods_id = NEW.goods_id AND extra_num IS NOT NULL AND state = 0 AND type = 1;
        ELSEIF EXISTS(SELECT * FROM warning_record WHERE goods_id = NEW.goods_id AND state = 0 AND type = 2) THEN
            UPDATE warning_record SET extra_num = extra_num + (OLD.grounding_num - NEW.grounding_num), num = NEW.grounding_num WHERE goods_id = NEW.goods_id AND extra_num IS NOT NULL AND state = 0 AND type = 2;
        END IF;
    ELSE
        IF max_num IS NOT NULL AND NEW.grounding_num > max_num THEN
            INSERT INTO warning_record (warning_id, time, type, goods_id, num, extra_num)
            VALUES ((SELECT id FROM warning WHERE goods_id = NEW.goods_id AND type = 1), NOW(), 1, NEW.goods_id, NEW.grounding_num, NEW.grounding_num - max_num);
        ELSEIF min_num IS NOT NULL AND NEW.grounding_num < min_num THEN
            INSERT INTO warning_record (warning_id, time, type, goods_id, num, extra_num)
            VALUES ((SELECT id FROM warning WHERE goods_id = NEW.goods_id AND type = 1), NOW(), 2, NEW.goods_id, NEW.grounding_num, min_num - NEW.grounding_num);
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `goods_batch`
--

DROP TABLE IF EXISTS `goods_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_batch` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `goods_id` bigint DEFAULT NULL,
  `record_type` tinyint DEFAULT NULL COMMENT '1采购单，2入库单，3出库单，4内配单，5待入库单',
  `record_id` bigint DEFAULT NULL,
  `num` float DEFAULT NULL,
  `manufacture_date` date DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `unit_price` float DEFAULT NULL,
  `total_price` float DEFAULT NULL,
  `unit_weight` float DEFAULT NULL,
  `total_weight` float DEFAULT NULL,
  `supplier_id` bigint DEFAULT NULL,
  `related_id` bigint DEFAULT NULL,
  `position_id` bigint DEFAULT NULL COMMENT '绑定下货位（盘点统计的时候用）',
  `in_date` date DEFAULT NULL COMMENT '入库时间',
  `out_date` date DEFAULT NULL COMMENT '出库时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `goods_batch_goods_goods_id_fk` (`goods_id`) USING BTREE,
  KEY `goods_batch_supplier_id_fk` (`supplier_id`) USING BTREE,
  KEY `goods_batch_related_id_fk` (`related_id`) USING BTREE,
  CONSTRAINT `goods_batch_goods_goods_id_fk` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`goods_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `goods_batch_related_id_fk` FOREIGN KEY (`related_id`) REFERENCES `goods_batch` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `goods_batch_supplier_id_fk` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_batch`
--

LOCK TABLES `goods_batch` WRITE;
/*!40000 ALTER TABLE `goods_batch` DISABLE KEYS */;
INSERT INTO `goods_batch` VALUES (48,13,1,14,500,'2023-05-20','2025-05-20',120,60000,0.3,150,13,NULL,NULL,NULL,NULL),(49,16,1,14,1000,'2023-05-20','2025-05-20',80,80000,0.5,500,13,NULL,NULL,NULL,NULL),(50,18,1,14,2,'2023-05-20','2025-05-20',150000,300000,800,1600,13,NULL,NULL,NULL,NULL),(51,19,1,14,5,'2023-05-20','2025-05-20',100000,500000,500,2500,13,NULL,NULL,NULL,NULL),(52,13,5,19,170,'2023-05-20','2025-05-20',120,60000,0.3,150,13,NULL,NULL,NULL,NULL),(53,16,5,19,855,'2023-05-20','2025-05-20',80,80000,0.5,500,13,NULL,NULL,NULL,NULL),(54,18,5,19,1,'2023-05-20','2025-05-20',150000,300000,800,1600,13,NULL,NULL,NULL,NULL),(55,19,5,19,5,'2023-05-20','2025-05-20',100000,500000,500,2500,13,NULL,NULL,NULL,NULL),(56,16,2,24,100,'2023-05-20','2025-05-20',80,8000,0.5,50,13,53,NULL,'2023-04-20',NULL),(57,13,2,24,200,'2023-05-20','2025-05-20',120,24000,0.3,60,13,52,NULL,'2023-04-20','2023-04-20'),(58,13,4,17,50,'2023-05-20','2025-05-20',120,6000,0.3,15,13,57,23,NULL,NULL),(59,18,2,25,1,'2023-05-20','2025-05-20',150000,150000,800,800,13,54,NULL,NULL,NULL),(60,13,3,10,50,'2023-05-20','2025-05-20',120,6000,0.3,15,13,57,29,'2023-04-20','2023-04-22'),(61,13,3,10,50,'2023-05-20','2025-05-20',120,6000,0.3,15,13,57,30,'2023-04-20','2023-04-22'),(62,13,3,10,50,'2023-05-20','2025-05-20',120,6000,0.3,15,13,57,31,'2023-04-20','2023-04-22'),(63,13,3,10,50,'2023-05-20','2025-05-20',120,6000,0.3,15,13,57,32,'2023-04-20','2023-04-22'),(64,13,2,26,35,'2023-05-20','2025-05-20',120,4200,0.3,10.5,13,52,NULL,'2023-04-22',NULL),(65,13,2,27,30,'2023-05-20','2025-05-20',120,3600,0.3,9,13,52,NULL,'2023-04-22',NULL),(66,16,2,28,25,'2023-05-20','2025-05-20',80,2000,0.5,12.5,13,53,NULL,'2023-04-22',NULL),(67,16,2,29,20,'2023-05-20','2025-05-20',80,1600,0.5,10,13,53,NULL,'2023-04-22','2023-04-22'),(68,16,3,12,45,'2023-05-20','2025-05-20',80,3600,0.5,22.5,13,56,47,'2022-04-20','2023-04-22'),(69,16,3,12,5,'2023-05-20','2025-05-20',80,400,0.5,2.5,13,56,48,'2023-04-20','2023-04-22'),(70,13,3,14,25,'2023-05-20','2025-05-20',120,3000,0.3,7.5,13,64,29,'2023-04-22','2023-04-22'),(71,16,3,16,45,'2023-05-20','2025-05-20',80,3600,0.5,22.5,13,56,48,'2023-04-20','2023-04-22'),(72,17,1,15,200,'2023-05-22','2025-05-22',5,1000,0.001,0.2,11,NULL,NULL,NULL,NULL),(73,17,5,20,170,'2023-05-22','2025-05-22',5,1000,0.001,0.2,11,NULL,NULL,NULL,NULL),(74,17,2,30,30,'2023-05-22','2025-05-22',5,150,0.001,0.03,11,73,NULL,'2023-04-22','2023-04-22'),(75,17,4,18,30,'2023-05-22','2025-05-22',5,150,0.001,0.03,11,74,46,NULL,NULL),(76,13,3,17,10,'2023-05-20','2025-05-20',120,1200,0.3,3,13,64,29,'2023-04-22','2023-04-22'),(77,13,3,17,10,'2023-05-20','2025-05-20',120,1200,0.3,3,13,65,30,'2023-04-22','2023-04-22'),(78,15,1,16,500,'2023-05-22','2025-05-22',10,5000,0.02,10,11,NULL,NULL,NULL,NULL),(79,16,1,16,20,'2023-05-22','2025-05-22',50,1000,0.5,10,11,NULL,NULL,NULL,NULL),(80,17,1,16,300,'2023-05-22','2025-05-22',5,1500,0.001,0.3,11,NULL,NULL,NULL,NULL),(81,15,5,21,500,'2023-05-22','2025-05-22',10,5000,0.02,10,11,NULL,NULL,NULL,NULL),(82,16,5,21,20,'2023-05-22','2025-05-22',50,1000,0.5,10,11,NULL,NULL,NULL,NULL),(83,17,5,21,300,'2023-05-22','2025-05-22',5,1500,0.001,0.3,11,NULL,NULL,NULL,NULL),(84,13,2,31,15,'2023-05-20','2025-05-20',120,1800,0.3,4.5,13,52,NULL,'2023-04-22',NULL),(85,16,4,19,20,'2023-05-20','2025-05-20',80,1600,0.5,10,13,67,47,NULL,NULL),(86,1,1,17,1100,'2023-05-23','2025-05-23',37.5,41250,0.45,495,8,NULL,NULL,NULL,NULL),(87,1,5,22,900,'2023-05-23','2025-05-23',37.5,41250,0.45,495,8,NULL,NULL,NULL,NULL),(88,1,2,32,200,'2023-05-23','2025-05-23',37.5,7500,0.45,90,8,87,NULL,'2023-04-23',NULL),(89,1,3,22,50,'2023-05-23','2025-05-23',37.5,1875,0.45,22.5,8,88,7,'2023-04-23','2023-04-23'),(90,15,1,18,100,'2023-05-23','2025-05-23',10,1000,0.02,2,11,NULL,NULL,NULL,NULL),(91,16,1,18,20,'2023-05-23','2025-05-23',50,1000,0.5,10,11,NULL,NULL,NULL,NULL),(92,15,5,23,100,'2023-05-23','2025-05-23',10,1000,0.02,2,11,NULL,NULL,NULL,NULL),(93,16,5,23,20,'2023-05-23','2025-05-23',50,1000,0.5,10,11,NULL,NULL,NULL,NULL),(94,13,2,33,50,'2023-05-20','2025-05-20',120,6000,0.3,15,13,52,NULL,NULL,NULL),(95,1,3,23,1,'2023-05-23','2025-05-23',37.5,37.5,0.45,0.45,8,88,8,'2023-04-23','2023-05-31');
/*!40000 ALTER TABLE `goods_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_supplier`
--

DROP TABLE IF EXISTS `goods_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_supplier` (
  `goods_id` bigint NOT NULL,
  `supplier_id` bigint NOT NULL,
  `unit_price` float DEFAULT NULL,
  `unit_weight` float DEFAULT NULL,
  PRIMARY KEY (`supplier_id`,`goods_id`) USING BTREE,
  KEY `good_supplier_goods_goods_id_fk` (`goods_id`) USING BTREE,
  CONSTRAINT `good_supplier_goods_goods_id_fk` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`goods_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `good_supplier_supplier_supplier_id_fk` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_supplier`
--

LOCK TABLES `goods_supplier` WRITE;
/*!40000 ALTER TABLE `goods_supplier` DISABLE KEYS */;
INSERT INTO `goods_supplier` VALUES (1,5,38,0.5),(2,5,10,0.03),(1,8,37.5,0.45),(1,9,50,0.1),(5,9,80,0.2),(6,9,25,0.05),(7,9,30,0.01),(9,9,8000,50),(13,9,150,0.2),(2,10,20,0.01),(15,11,10,0.02),(16,11,50,0.5),(17,11,5,0.001),(11,12,20000,300),(13,13,120,0.3),(16,13,80,0.5),(18,13,150000,800),(19,13,100000,500);
/*!40000 ALTER TABLE `goods_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_and_out`
--

DROP TABLE IF EXISTS `in_and_out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_and_out` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `time` date DEFAULT NULL COMMENT '时间',
  `goods_num` float DEFAULT NULL COMMENT '商品数量',
  `goods_price` double DEFAULT NULL COMMENT '商品价格',
  `logistics_price` double DEFAULT NULL COMMENT '物流费用',
  `storage_cost` double DEFAULT NULL COMMENT '仓储费用',
  `total_price` double DEFAULT NULL COMMENT '总价格',
  `type` tinyint DEFAULT NULL COMMENT '1-采购 2-入库 3-出库',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='进出库统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_and_out`
--

LOCK TABLES `in_and_out` WRITE;
/*!40000 ALTER TABLE `in_and_out` DISABLE KEYS */;
INSERT INTO `in_and_out` VALUES (5,'2023-04-21',0,5200,0,NULL,5200,3),(6,'2023-04-22',455,45350,NULL,NULL,2000,2),(7,'2023-04-22',340,37000,5900.000259399414,NULL,42900.000259399414,3),(8,'2023-04-20',NULL,30000,NULL,NULL,30000,3),(9,'2023-04-19',NULL,6500,NULL,NULL,6500,3),(10,'2023-04-18',NULL,2000,NULL,NULL,2000,3),(11,'2023-04-21',NULL,5799,NULL,NULL,5799,2),(12,'2023-04-20',NULL,8888,NULL,NULL,8888,2),(13,'2023-04-19',NULL,6666,NULL,NULL,6666,2),(14,'2023-04-18',NULL,19999,NULL,NULL,19999,2),(15,'2023-04-23',200,7500,NULL,NULL,NULL,2),(16,'2023-04-23',0,0,0,NULL,0,3);
/*!40000 ALTER TABLE `in_and_out` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logistics_expense`
--

DROP TABLE IF EXISTS `logistics_expense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logistics_expense` (
  `logistics_type` int NOT NULL AUTO_INCREMENT,
  `desc` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `unit_price` float DEFAULT NULL,
  PRIMARY KEY (`logistics_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logistics_expense`
--

LOCK TABLES `logistics_expense` WRITE;
/*!40000 ALTER TABLE `logistics_expense` DISABLE KEYS */;
INSERT INTO `logistics_expense` VALUES (1,'海运',50),(2,'陆运',10),(3,'空运',30);
/*!40000 ALTER TABLE `logistics_expense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `out_record`
--

DROP TABLE IF EXISTS `out_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `out_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `creator_id` bigint DEFAULT NULL,
  `department_id` bigint DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `state` tinyint DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `goods_price` double DEFAULT NULL,
  `logistics_type` tinyint DEFAULT NULL,
  `logistics_price` double DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `goods_id` bigint DEFAULT NULL,
  `num` float DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `out_record`
--

LOCK TABLES `out_record` WRITE;
/*!40000 ALTER TABLE `out_record` DISABLE KEYS */;
INSERT INTO `out_record` VALUES (10,1,1,'2023-04-22 19:13:04',5,'O(∩_∩)O',24000,1,3000.000244140625,27000,'不错噢',13,200,'2023-04-22 19:13:04'),(12,1,1,'2023-04-22 22:32:18',5,'拜拜',4000,1,1250,5250,'ok',16,50,'2023-04-22 22:32:18'),(14,1,1,'2023-04-22 22:34:07',5,'出库',3000,3,225.00001525878906,3225,'ok',13,25,'2023-04-22 22:34:07'),(16,1,7,'2023-04-22 22:35:03',5,'出库',3600,1,1125,4725,NULL,16,45,'2023-04-22 22:35:03'),(17,1,15,'2023-04-22 22:55:55',5,'111',2400,1,300,2700,'3',13,20,'2023-04-22 22:55:54'),(18,1,NULL,'2023-04-22 23:31:48',1,NULL,NULL,NULL,NULL,NULL,NULL,16,20,NULL),(19,1,NULL,'2023-04-22 23:31:54',1,'111',NULL,NULL,NULL,NULL,NULL,16,20,NULL),(20,1,NULL,'2023-04-22 23:32:11',1,'111',NULL,NULL,NULL,NULL,NULL,13,15,NULL),(22,1,9,'2023-04-23 14:45:33',1,NULL,1875,1,1125,3000,NULL,1,50,'2023-04-23 14:45:33'),(23,1,NULL,'2023-05-31 01:23:13',2,'测试记录',37.5,2,4.5,42,'test',1,1,'2023-05-31 01:23:13');
/*!40000 ALTER TABLE `out_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `position`
--

DROP TABLE IF EXISTS `position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `position` (
  `position_id` bigint NOT NULL AUTO_INCREMENT,
  `area_id` bigint NOT NULL,
  `shelve_id` bigint NOT NULL,
  `goods_type` bigint DEFAULT NULL,
  `state` tinyint DEFAULT '0',
  `goods_num` float DEFAULT '0',
  `manufacture_date` date DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `batch_info` bigint DEFAULT NULL,
  `capacity` float DEFAULT NULL COMMENT '货位容量',
  `in_date` date DEFAULT NULL COMMENT '入库时间',
  PRIMARY KEY (`position_id`) USING BTREE,
  KEY `area_shelve` (`area_id`) USING BTREE,
  KEY `position_goods` (`goods_type`) USING BTREE,
  CONSTRAINT `area_shelve` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `position_goods` FOREIGN KEY (`goods_type`) REFERENCES `goods` (`goods_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `position`
--

LOCK TABLES `position` WRITE;
/*!40000 ALTER TABLE `position` DISABLE KEYS */;
INSERT INTO `position` VALUES (1,1,1,NULL,0,0,NULL,NULL,NULL,50,NULL),(2,1,2,NULL,0,0,NULL,NULL,NULL,50,NULL),(3,1,3,NULL,0,0,NULL,NULL,NULL,50,NULL),(4,1,4,NULL,0,0,NULL,NULL,NULL,50,NULL),(5,1,5,NULL,0,0,NULL,NULL,NULL,50,NULL),(6,1,6,NULL,0,0,NULL,NULL,NULL,50,NULL),(7,2,1,NULL,0,0,NULL,NULL,NULL,50,NULL),(8,2,2,1,1,49,'2023-05-23','2025-05-23',88,50,'2023-04-23'),(9,2,3,1,1,50,'2023-05-23','2025-05-23',88,50,'2023-04-23'),(10,2,4,1,1,50,'2023-05-23','2025-05-23',88,50,'2023-04-23'),(11,2,5,NULL,0,0,NULL,NULL,NULL,50,NULL),(12,2,6,NULL,0,0,NULL,NULL,NULL,50,NULL),(13,2,7,NULL,0,0,NULL,NULL,NULL,50,NULL),(14,2,8,NULL,0,0,NULL,NULL,NULL,50,NULL),(15,2,9,NULL,0,0,NULL,NULL,NULL,50,NULL),(16,2,10,NULL,0,0,NULL,NULL,NULL,50,NULL),(17,2,11,NULL,0,0,NULL,NULL,NULL,50,NULL),(18,2,12,NULL,0,0,NULL,NULL,NULL,50,NULL),(19,3,1,NULL,0,0,NULL,NULL,NULL,50,NULL),(20,3,2,NULL,0,0,NULL,NULL,NULL,50,NULL),(21,3,3,NULL,0,0,NULL,NULL,NULL,50,NULL),(22,3,4,NULL,0,0,NULL,NULL,NULL,50,NULL),(23,4,1,NULL,0,0,NULL,NULL,NULL,50,NULL),(24,4,2,NULL,0,0,NULL,NULL,NULL,50,NULL),(25,4,3,NULL,0,0,NULL,NULL,NULL,50,NULL),(26,4,4,NULL,0,0,NULL,NULL,NULL,50,NULL),(27,4,5,NULL,0,0,NULL,NULL,NULL,50,NULL),(28,4,6,NULL,0,0,NULL,NULL,NULL,50,NULL),(29,5,1,13,1,20,'2023-05-20','2025-05-20',84,50,'2023-04-22'),(30,5,2,13,1,18,'2023-05-20','2023-04-20',65,50,'2023-04-22'),(31,5,3,13,2,50,'2023-05-20','2025-05-20',94,50,NULL),(32,5,4,NULL,0,0,NULL,NULL,NULL,50,NULL),(33,5,5,NULL,0,0,NULL,NULL,NULL,50,NULL),(34,5,6,NULL,0,0,NULL,NULL,NULL,50,NULL),(35,5,7,NULL,0,0,NULL,NULL,NULL,50,NULL),(36,5,8,NULL,0,0,NULL,NULL,NULL,50,NULL),(37,5,8,NULL,0,0,NULL,NULL,NULL,50,NULL),(38,5,8,NULL,0,0,NULL,NULL,NULL,50,NULL),(39,5,8,NULL,0,0,NULL,NULL,NULL,50,NULL),(40,5,8,NULL,0,0,NULL,NULL,NULL,50,NULL),(41,6,1,NULL,0,0,NULL,NULL,NULL,50,NULL),(42,6,2,NULL,0,0,NULL,NULL,NULL,50,NULL),(43,6,3,NULL,0,0,NULL,NULL,NULL,50,NULL),(44,6,4,NULL,0,0,NULL,NULL,NULL,50,NULL),(45,7,1,NULL,0,0,NULL,NULL,NULL,50,NULL),(46,7,2,17,1,30,'2023-05-22','2025-05-22',74,50,'2023-04-22'),(47,8,1,16,1,20,'2023-05-20','2025-05-20',67,50,'2023-04-22'),(48,8,2,NULL,0,0,NULL,NULL,NULL,50,NULL),(49,8,3,16,1,25,'2023-05-20','2025-05-20',66,50,'2023-04-22'),(50,8,4,NULL,0,0,NULL,NULL,NULL,50,NULL),(51,8,5,NULL,0,0,NULL,NULL,NULL,50,NULL),(52,8,6,NULL,0,0,NULL,NULL,NULL,50,NULL),(53,9,7,NULL,0,0,NULL,NULL,NULL,50,NULL),(54,9,8,NULL,0,0,NULL,NULL,NULL,50,NULL),(55,10,1,18,2,1,'2023-05-20','2025-05-20',59,50,NULL);
/*!40000 ALTER TABLE `position` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `p_insert` AFTER INSERT ON `position` FOR EACH ROW BEGIN
	update area,
	(select area_id,count(shelve_id) as c from position group by area_id) p
	set area.shelve_num = p.c 
	where area.id = p.area_id;
    
	update goods,
	(select goods_type,sum(goods_num) as s from position group by goods_type) g
	set goods.grounding_num = g.s
	where goods.goods_id = g.goods_type;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `p_update` AFTER UPDATE ON `position` FOR EACH ROW BEGIN
	update area,
	(select area_id,count(shelve_id) as c from position group by area_id) p
	set area.shelve_num = p.c 
	where area.id = p.area_id;
    
	update goods,
	(select goods_type,sum(goods_num) as s from position group by goods_type) g
	set goods.grounding_num = g.s
	where goods.goods_id = g.goods_type;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_warning_record_num` AFTER UPDATE ON `position` FOR EACH ROW BEGIN
    -- 当position表里的goods_num变化时，更新相应的warning_record
    IF NEW.goods_num != OLD.goods_num THEN
        UPDATE warning_record
        SET num = NEW.goods_num
        WHERE position_id = OLD.position_id
        AND state = 0;
    END IF;
    
    -- 当goods_num=0时，将相应的warning_record的state设置为1
    IF NEW.goods_num = 0 THEN
        UPDATE warning_record
        SET state = 1
        WHERE position_id = OLD.position_id
        AND state = 0;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `p_delete` AFTER DELETE ON `position` FOR EACH ROW BEGIN
	update area,
	(select area_id,count(shelve_id) as c from position group by area_id) p
	set area.shelve_num = p.c 
	where area.id = p.area_id;
    
	update goods,
	(select goods_type,sum(goods_num) as s from position group by goods_type) g
	set goods.grounding_num = g.s
	where goods.goods_id = g.goods_type;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `purchase_record`
--

DROP TABLE IF EXISTS `purchase_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL,
  `creator_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `creator_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `supplier_id` bigint DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `state` tinyint DEFAULT '1',
  `logistics_price` double DEFAULT NULL,
  `goods_price` double DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `logistics_type` int DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `purchase_record_supplier_supplier_id_fk` (`supplier_id`) USING BTREE,
  CONSTRAINT `purchase_record_supplier_supplier_id_fk` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_record`
--

LOCK TABLES `purchase_record` WRITE;
/*!40000 ALTER TABLE `purchase_record` DISABLE KEYS */;
INSERT INTO `purchase_record` VALUES (14,'2023-04-20 21:57:54','1','zts',13,'我超有钱',4,47500,940000,987500,'好的！',2,'2023-04-20 21:57:53'),(15,'2023-04-22 22:52:10','1','zts',11,'111',4,2,1000,1002,'111',2,'2023-04-22 22:52:09'),(16,'2023-04-22 23:28:36','1','zts',11,'111',4,203,7500,7703,'111',2,'2023-04-22 23:28:35'),(17,'2023-04-23 14:39:34','1','zts',8,'',4,24750,41250,66000,NULL,1,'2023-04-23 14:39:33'),(18,'2023-04-23 15:31:47','1','zts',11,'111',4,600,2000,2600,'111',1,'2023-04-23 15:31:47');
/*!40000 ALTER TABLE `purchase_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `supplier_id` bigint NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`supplier_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (5,'BECON','北京海淀区','111'),(8,'林千琬','海南省海口市','8888'),(9,'北京医疗器械有限公司','北京市昌平区','010-12345678'),(10,'上海医药集团有限公司','上海市徐汇区','021-87654321'),(11,'广州医疗器械股份有限公司','广东省广州市','020-55555555'),(12,'重庆医药集团有限公司','重庆市渝北区','023-66666666'),(13,'深圳医疗科技有限公司','深圳市南山区','0755-12345678');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT,
  `role_name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `role_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','拥有所有功能权限'),(2,'库存管理员','查询库位的占用情况，处理积压库存，盘点各类货物的库存及情况，以进行及时采购和对库内货物进行内配。'),(3,'审批人员','对采购单、内配单、盘点单和出入库表单进行审核，检查需求是否合理合法。'),(4,'出入库管理员','对出入库进行管理'),(5,'工作人员','进行内配、盘点、打包、清点上架的完成确认。'),(6,'医院调拨员','根据科室需求创建出库单');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `user_name` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `real_name` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  KEY `real_name` (`real_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'admin','zts','$2a$10$hi5n0ZMuZ7TwYhuGwvEpdOwhTZPXoU7Q5Tv66Ic0IVlTtLXtT7YMq','12345678901'),(7,'工作人员','工作人员','$2a$10$hi5n0ZMuZ7TwYhuGwvEpdOwhTZPXoU7Q5Tv66Ic0IVlTtLXtT7YMq','66666666666'),(36,'审批人员','测试','$2a$10$hi5n0ZMuZ7TwYhuGwvEpdOwhTZPXoU7Q5Tv66Ic0IVlTtLXtT7YMq','11111111111');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_record`
--

DROP TABLE IF EXISTS `task_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_record` (
  `task_id` bigint NOT NULL AUTO_INCREMENT,
  `record_type` tinyint DEFAULT NULL,
  `record_id` bigint DEFAULT NULL,
  `task_type` tinyint DEFAULT NULL,
  `operator_id` bigint DEFAULT NULL,
  `operate_time` datetime DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`task_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_record`
--

LOCK TABLES `task_record` WRITE;
/*!40000 ALTER TABLE `task_record` DISABLE KEYS */;
INSERT INTO `task_record` VALUES (37,1,14,1,1,'2023-04-20 21:57:54',NULL),(38,1,14,3,1,'2023-04-20 21:58:32','买买买'),(39,1,14,5,1,'2023-04-20 21:58:47','好的！'),(40,2,24,5,1,'2023-04-20 22:00:50',NULL),(41,2,24,7,1,'2023-04-20 22:01:43','验收合格，不错'),(42,2,24,8,1,'2023-04-20 22:01:55','确认收货，嘿嘿嘿可以'),(43,2,24,10,1,'2023-04-20 22:04:03','确认上架，阿瑟请上架'),(44,11,17,NULL,1,'2023-04-20 22:16:26',NULL),(45,4,17,12,1,'2023-04-20 22:16:49','尊重祝福'),(46,2,25,5,1,'2023-04-22 19:09:28',NULL),(47,3,10,15,1,'2023-04-22 19:13:04',NULL),(48,3,10,16,1,'2023-04-22 19:14:51','不错'),(49,3,10,17,1,'2023-04-22 19:15:06','不错'),(50,3,10,18,1,'2023-04-22 19:15:13','不错'),(51,3,10,19,1,'2023-04-22 19:15:24','不错噢'),(52,6,1,21,1,'2023-04-22 19:21:12','创建盘点任务'),(53,6,1,22,1,'2023-04-22 19:21:40','少了'),(54,6,1,23,1,'2023-04-22 19:21:56',NULL),(55,2,26,5,1,'2023-04-22 22:24:56',NULL),(56,2,26,7,1,'2023-04-22 22:25:10','验收合格，ok'),(57,2,26,8,1,'2023-04-22 22:25:19','确认收货，收货'),(58,2,26,10,1,'2023-04-22 22:25:26','确认上架，上架'),(59,2,27,5,1,'2023-04-22 22:29:05',NULL),(60,2,27,7,1,'2023-04-22 22:29:16','验收合格，入库'),(61,2,27,8,1,'2023-04-22 22:29:23','确认收货，收货'),(62,2,27,10,1,'2023-04-22 22:29:30','确认上架，上架'),(63,2,28,5,1,'2023-04-22 22:29:47',NULL),(64,2,28,7,1,'2023-04-22 22:29:58','验收合格，合格'),(65,2,28,8,1,'2023-04-22 22:30:05','确认收货，收货'),(66,2,28,10,1,'2023-04-22 22:30:14','确认上架，上架'),(67,2,29,5,1,'2023-04-22 22:30:51',NULL),(68,2,29,7,1,'2023-04-22 22:31:04','验收合格，11'),(69,2,29,8,1,'2023-04-22 22:31:10','确认收货，1'),(70,2,29,10,1,'2023-04-22 22:31:15','确认上架，1'),(71,3,12,15,1,'2023-04-22 22:32:18',NULL),(72,3,12,16,1,'2023-04-22 22:32:31','ok'),(73,3,12,17,1,'2023-04-22 22:32:34','ok'),(74,3,12,18,1,'2023-04-22 22:32:35','ok'),(75,3,12,19,1,'2023-04-22 22:32:41','ok'),(76,3,14,15,1,'2023-04-22 22:34:07',NULL),(77,3,14,16,1,'2023-04-22 22:34:14',NULL),(78,3,14,17,1,'2023-04-22 22:34:16',NULL),(79,3,14,18,1,'2023-04-22 22:34:17',NULL),(80,3,14,19,1,'2023-04-22 22:34:24','ok'),(81,3,16,15,1,'2023-04-22 22:35:03',NULL),(82,3,16,16,1,'2023-04-22 22:35:10',NULL),(83,3,16,17,1,'2023-04-22 22:35:12',NULL),(84,3,16,17,1,'2023-04-22 22:35:14',NULL),(85,3,16,18,1,'2023-04-22 22:35:15',NULL),(86,3,16,19,1,'2023-04-22 22:36:04',NULL),(87,1,15,1,1,'2023-04-22 22:52:10',NULL),(88,1,15,3,1,'2023-04-22 22:52:31','111'),(89,1,15,5,1,'2023-04-22 22:52:37','111'),(90,2,30,5,1,'2023-04-22 22:53:27',NULL),(91,2,30,7,1,'2023-04-22 22:53:44','验收合格，111'),(92,2,30,8,1,'2023-04-22 22:53:50','确认收货，111'),(93,2,30,10,1,'2023-04-22 22:54:00','确认上架，111'),(94,11,18,NULL,1,'2023-04-22 22:54:29',NULL),(95,4,18,12,1,'2023-04-22 22:54:43','222'),(96,4,18,14,1,'2023-04-22 22:54:49','222'),(97,3,17,15,1,'2023-04-22 22:55:54',NULL),(98,3,17,16,1,'2023-04-22 22:56:10','1'),(99,3,17,17,1,'2023-04-22 22:56:14','2'),(100,3,17,18,1,'2023-04-22 22:56:17','3'),(101,3,17,19,1,'2023-04-22 22:56:24','3'),(102,6,2,21,1,'2023-04-22 22:56:48','创建盘点任务'),(103,6,2,22,1,'2023-04-22 22:57:07','缺少两台血糖仪'),(104,6,2,23,1,'2023-04-22 22:57:19',NULL),(105,1,16,1,1,'2023-04-22 23:28:35',NULL),(106,1,16,3,1,'2023-04-22 23:28:53','111'),(107,1,16,5,1,'2023-04-22 23:29:01','111'),(108,2,31,5,1,'2023-04-22 23:30:14',NULL),(109,2,31,7,1,'2023-04-22 23:30:33','验收合格，1'),(110,2,31,8,1,'2023-04-22 23:30:38','确认收货，1'),(111,2,31,10,1,'2023-04-22 23:30:46','确认上架，1'),(112,11,19,NULL,1,'2023-04-22 23:31:13',NULL),(113,4,19,12,1,'2023-04-22 23:31:25',NULL),(114,4,19,14,1,'2023-04-22 23:31:31',NULL),(115,6,3,21,1,'2023-04-22 23:32:53','创建盘点任务'),(116,6,3,22,1,'2023-04-22 23:33:08',''),(117,6,3,23,1,'2023-04-22 23:33:15',NULL),(118,1,17,1,1,'2023-04-23 14:39:33',NULL),(119,1,17,3,1,'2023-04-23 14:39:40',NULL),(120,1,17,5,1,'2023-04-23 14:39:43',NULL),(121,2,32,5,1,'2023-04-23 14:40:06',NULL),(122,2,32,7,1,'2023-04-23 14:40:17','验收合格'),(123,2,32,8,1,'2023-04-23 14:40:22','确认收货'),(124,2,32,10,1,'2023-04-23 14:40:26','确认上架'),(125,3,22,15,1,'2023-04-23 14:45:33',NULL),(126,1,18,1,1,'2023-04-23 15:31:47',NULL),(127,1,18,3,1,'2023-04-23 15:33:51','111'),(128,1,18,5,1,'2023-04-23 15:33:56','111'),(129,2,33,5,1,'2023-04-23 15:34:22',NULL),(130,2,33,7,1,'2023-04-23 15:34:35','验收合格，111'),(131,3,23,15,1,'2023-05-31 01:23:13',NULL),(132,3,23,16,1,'2023-05-31 01:37:16','test'),(133,3,23,16,1,'2023-05-31 01:39:25','test');
/*!40000 ALTER TABLE `task_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transfer_record`
--

DROP TABLE IF EXISTS `transfer_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transfer_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL,
  `creator_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `creator_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `state` tinyint DEFAULT '1',
  `origin_position` bigint DEFAULT NULL,
  `target_position` bigint DEFAULT NULL,
  `num` float DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `transfer_record_position_position_id_fk` (`origin_position`) USING BTREE,
  KEY `transfer_record_position_position_id_fk2` (`target_position`) USING BTREE,
  CONSTRAINT `transfer_record_position_position_id_fk` FOREIGN KEY (`origin_position`) REFERENCES `position` (`position_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transfer_record_position_position_id_fk2` FOREIGN KEY (`target_position`) REFERENCES `position` (`position_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfer_record`
--

LOCK TABLES `transfer_record` WRITE;
/*!40000 ALTER TABLE `transfer_record` DISABLE KEYS */;
INSERT INTO `transfer_record` VALUES (17,'2023-04-20 22:16:26','1','zts','血糖仪移库',2,29,23,50,'移库','2023-04-20 22:16:26'),(18,'2023-04-22 22:54:30','1','zts','111',4,47,46,30,'222','2023-04-22 22:54:29'),(19,'2023-04-22 23:31:13','1','zts','无',4,45,47,20,NULL,'2023-04-22 23:31:13');
/*!40000 ALTER TABLE `transfer_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `user_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `fk_user_role_role_id` (`role_id`) USING BTREE,
  CONSTRAINT `fk_user_role_role_id` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_role_user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,1),(1,2),(36,3),(7,5);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waiting_record`
--

DROP TABLE IF EXISTS `waiting_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waiting_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waiting_record`
--

LOCK TABLES `waiting_record` WRITE;
/*!40000 ALTER TABLE `waiting_record` DISABLE KEYS */;
INSERT INTO `waiting_record` VALUES (19,'2023-04-20 21:58:47'),(20,'2023-04-22 22:52:37'),(21,'2023-04-22 23:29:01'),(22,'2023-04-23 14:39:44'),(23,'2023-04-23 15:33:56');
/*!40000 ALTER TABLE `waiting_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehousing_record`
--

DROP TABLE IF EXISTS `warehousing_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehousing_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL COMMENT '入库单自动创建时间',
  `state` tinyint DEFAULT '1' COMMENT '1待预检验收，2已删除，3待确认收货，4审核不通过，5待入库上架，6已上架',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `goods_price` double DEFAULT NULL,
  `creator_id` bigint DEFAULT NULL,
  `creator_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehousing_record`
--

LOCK TABLES `warehousing_record` WRITE;
/*!40000 ALTER TABLE `warehousing_record` DISABLE KEYS */;
INSERT INTO `warehousing_record` VALUES (24,'2023-04-20 22:00:51',6,'入库单',32000,1,'zts','2023-04-22 22:16:02'),(25,'2023-04-22 19:09:29',1,'',150000,1,'zts','2023-04-22 19:09:28'),(26,'2023-04-22 22:24:57',6,'入库了',4200,1,'zts','2023-04-22 22:24:56'),(27,'2023-04-22 22:29:06',6,'入库',3600,1,'zts','2023-04-22 22:29:05'),(28,'2023-04-22 22:29:48',6,'入库',2000,1,'zts','2023-04-22 22:29:47'),(29,'2023-04-22 22:30:52',6,'入库',1600,1,'zts','2023-04-22 22:30:51'),(30,'2023-04-22 22:53:27',6,'111',150,1,'zts','2023-04-22 22:53:27'),(31,'2023-04-22 23:30:15',6,'111',1800,1,'zts','2023-04-22 23:30:14'),(32,'2023-04-23 14:40:06',6,'',7500,1,'zts','2023-04-23 14:40:06'),(33,'2023-04-23 15:34:22',3,'',6000,1,'zts','2023-04-23 15:34:22');
/*!40000 ALTER TABLE `warehousing_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warning`
--

DROP TABLE IF EXISTS `warning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warning` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `creator_id` bigint DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `type` tinyint DEFAULT NULL COMMENT '1库存预警 2过期预警 3 库龄预警 ',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `goods_id` bigint DEFAULT NULL,
  `max` float DEFAULT NULL,
  `min` float DEFAULT NULL COMMENT '预警下限',
  `expiration` int DEFAULT NULL COMMENT '距离过期x天前预警',
  `store_age` int DEFAULT NULL COMMENT '库龄/天',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `warning_goods_id_fk` (`goods_id`) USING BTREE,
  CONSTRAINT `warning_goods_id_fk` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`goods_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warning`
--

LOCK TABLES `warning` WRITE;
/*!40000 ALTER TABLE `warning` DISABLE KEYS */;
INSERT INTO `warning` VALUES (2,1,'2023-04-05 23:05:34',1,'库存预警规则，总量最多为40，最少为10',1,40,10,NULL,NULL),(3,1,'2023-04-05 23:08:55',2,'过期前6天发出预警',1,NULL,NULL,6,NULL),(4,1,'2023-04-05 23:26:07',3,'在仓库存储时长超过3天后预警',1,NULL,NULL,NULL,3),(20,1,'2023-04-22 20:26:42',2,'',16,NULL,NULL,5,NULL),(21,1,'2023-04-22 20:30:11',3,'',16,NULL,NULL,NULL,200),(25,1,'2023-04-22 23:06:42',1,'',7,500,300,NULL,NULL),(26,1,'2023-04-22 23:07:42',2,'',13,NULL,NULL,30,NULL),(27,1,'2023-04-22 23:33:42',1,'',9,20,10,NULL,NULL);
/*!40000 ALTER TABLE `warning` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_warning_insert` AFTER INSERT ON `warning` FOR EACH ROW BEGIN
  DECLARE max_num FLOAT;
  DECLARE min_num FLOAT;
  SELECT `max`, `min` INTO max_num, min_num FROM warning WHERE id = NEW.id;
  IF NEW.type = 1 THEN
    IF (SELECT grounding_num FROM goods WHERE goods_id = NEW.goods_id) > max_num OR (SELECT grounding_num FROM goods WHERE goods_id = NEW.goods_id) < min_num THEN 
      INSERT INTO warning_record (warning_id, time, type, goods_id, num, extra_num)
      VALUES (NEW.id, NOW(), IF((SELECT grounding_num FROM goods WHERE goods_id = NEW.goods_id) > max_num, 1, 2), NEW.goods_id, (SELECT grounding_num FROM goods WHERE goods_id = NEW.goods_id), IF((SELECT grounding_num FROM goods WHERE goods_id = NEW.goods_id) > max_num, (SELECT grounding_num FROM goods WHERE goods_id = NEW.goods_id) - NEW.max, NEW.min - (SELECT grounding_num FROM goods WHERE goods_id = NEW.goods_id)));
    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `warning_record`
--

DROP TABLE IF EXISTS `warning_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warning_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `warning_id` bigint DEFAULT NULL,
  `time` date DEFAULT NULL,
  `type` tinyint DEFAULT NULL COMMENT '1 库存过剩 2库存不足 3即将过期 4已过期 5积压预警',
  `position_id` bigint DEFAULT NULL,
  `goods_id` bigint DEFAULT NULL,
  `num` float DEFAULT NULL,
  `extra_num` float DEFAULT NULL COMMENT '异常数量',
  `extra_time` int DEFAULT NULL COMMENT '异常时长/天(state=3 距过期时长，4已过期时长，5已积压时长)',
  `state` tinyint DEFAULT '0' COMMENT '0 未解决 1 已解决',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `warning_record_warning_id_fk` (`warning_id`) USING BTREE,
  CONSTRAINT `warning_record_warning_id_fk` FOREIGN KEY (`warning_id`) REFERENCES `warning` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warning_record`
--

LOCK TABLES `warning_record` WRITE;
/*!40000 ALTER TABLE `warning_record` DISABLE KEYS */;
INSERT INTO `warning_record` VALUES (15,2,'2023-04-20',2,NULL,1,35,-25,NULL,1),(18,2,'2023-04-22',2,NULL,1,50,-40,NULL,1),(22,20,'2023-04-22',4,47,16,0,NULL,2,1),(23,21,'2023-04-22',5,47,16,0,NULL,168,1),(25,25,'2023-04-22',2,NULL,7,0,300,NULL,0),(26,26,'2023-04-22',3,30,13,18,NULL,-1,1),(27,26,'2023-06-10',4,30,13,18,NULL,51,0),(28,27,'2023-04-22',2,NULL,9,0,10,NULL,0),(29,2,'2023-04-23',1,NULL,1,149,109,NULL,0);
/*!40000 ALTER TABLE `warning_record` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trigger_warning_record_update` BEFORE UPDATE ON `warning_record` FOR EACH ROW BEGIN
    DECLARE max_num FLOAT;
    DECLARE min_num FLOAT;
    SELECT max, min INTO max_num, min_num FROM warning WHERE id = NEW.warning_id AND type = 1;
    IF NEW.state = 0 AND NEW.type = 1 AND max_num IS NOT NULL AND NEW.num < max_num THEN
        SET NEW.state = 1;
    ELSEIF NEW.state = 0 AND NEW.type = 2 AND min_num IS NOT NULL AND NEW.num > min_num THEN
        SET NEW.state = 1;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_warning_record_state` BEFORE UPDATE ON `warning_record` FOR EACH ROW BEGIN
    IF NEW.type = 3 AND NEW.extra_time < 0 THEN
        SET NEW.state = 1;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-10 21:26:00
