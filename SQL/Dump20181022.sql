CREATE DATABASE  IF NOT EXISTS `aether` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `aether`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: aether
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.33-MariaDB

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
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application` (
  `uuid` varchar(40) DEFAULT NULL,
  `bank` char(10) DEFAULT NULL,
  `transactionHash` binary(100) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT NULL,
  `camimage` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
INSERT INTO `application` VALUES ('4f3c1af2-cbab-4d95-aff0-3b9176b3862c','DBS',NULL,0,'');
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract` (
  `contract_address` binary(60) NOT NULL,
  `user_deploying` varchar(100) NOT NULL,
  PRIMARY KEY (`contract_address`),
  KEY `fk_user_deploying` (`user_deploying`),
  CONSTRAINT `fk_user_deploying` FOREIGN KEY (`user_deploying`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz`
--

DROP TABLE IF EXISTS `quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz` (
  `quizid` varchar(100) NOT NULL,
  `acadterm` varchar(15) NOT NULL,
  `correctans` varchar(5) NOT NULL,
  `points` int(11) NOT NULL,
  PRIMARY KEY (`quizid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz`
--

LOCK TABLES `quiz` WRITE;
/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
INSERT INTO `quiz` VALUES ('1','AY','A',100),('2','AY','A',100),('3','AY','B',100),('4','AY','B',100);
/*!40000 ALTER TABLE `quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `transactionid` binary(60) NOT NULL,
  `user_from` varchar(100) DEFAULT NULL,
  `user_to` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`transactionid`),
  KEY `fk_user_from` (`user_from`),
  KEY `fk_user_to` (`user_to`),
  CONSTRAINT `fk_user_from` FOREIGN KEY (`user_from`) REFERENCES `user` (`userid`),
  CONSTRAINT `fk_user_to` FOREIGN KEY (`user_to`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `userid` varchar(100) NOT NULL,
  `password` binary(60) NOT NULL,
  `publickey` binary(60) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('beebee','$2a$12$DLqg7nunzuPh2Rj4/YcUcunjaVqoWEPPDMbVa4t.KRXGqo5veQMh.','0x6b741638e289931e6347a11e5e6d8aaf0f69d8e1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),('clarencethemonster','$2a$12$QB6anXk8vqsz7APdGHtIy.qTgXNFOVrDSMJfrRu5Fekp.jIl8fVWy','0x312a06d4b014d7a1c77a7a0cf5188c635ccbe714\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),('jordysamuel','$2a$12$Mr0qamu5Iwzmo7jNpIH1Ae0Xav3uwjlhVe3WWJzDNIqDxqO/TSIR2','0xe442eb4d7a7a4888036ac92c0b25b1f52dd5b098\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userquiz`
--

DROP TABLE IF EXISTS `userquiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userquiz` (
  `iduserquiz` varchar(100) NOT NULL,
  `userans` varchar(5) NOT NULL,
  `timetaken` varchar(45) NOT NULL,
  `points` int(11) DEFAULT NULL,
  `time` varchar(10) NOT NULL,
  PRIMARY KEY (`iduserquiz`),
  CONSTRAINT `quizid` FOREIGN KEY (`iduserquiz`) REFERENCES `quiz` (`quizid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `userid` FOREIGN KEY (`iduserquiz`) REFERENCES `user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userquiz`
--

LOCK TABLES `userquiz` WRITE;
/*!40000 ALTER TABLE `userquiz` DISABLE KEYS */;
/*!40000 ALTER TABLE `userquiz` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-22 22:37:17
