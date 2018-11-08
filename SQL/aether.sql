-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 24, 2018 at 03:00 PM
-- Server version: 5.7.14
-- PHP Version: 7.0.10
CREATE DATABASE IF NOT EXISTS `aether`;
USE `aether`;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aether`
--

-- --------------------------------------------------------

--
-- Table structure for table `application`
--

CREATE TABLE `application` (
  `uuid` varchar(40) DEFAULT NULL,
  `bank` char(10) DEFAULT NULL,
  `transactionHash` binary(100) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT NULL,
  `camimage` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `application`
--

INSERT INTO `application` (`uuid`, `bank`, `transactionHash`, `verified`, `camimage`) VALUES
('4f3c1af2-cbab-4d95-aff0-3b9176b3862c', 'DBS', NULL, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `contract`
--

CREATE TABLE `contract` (
  `transaction_address` varchar(70) NOT NULL,
  `uuid` char(36) NOT NULL,
  `facial_encoding` blob,
  `contract_address` varchar(45) DEFAULT NULL,
  `json_data` mediumblob,
  `integrity_hash` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contract`
--
-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE `quiz` (
  `quizid` varchar(100) NOT NULL,
  `acadterm` varchar(15) NOT NULL,
  `correctans` varchar(5) NOT NULL,
  `points` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`quizid`, `acadterm`, `correctans`, `points`) VALUES
('1', 'AY', 'A', 100),
('2', 'AY', 'A', 100),
('3', 'AY', 'B', 100),
('4', 'AY', 'B', 100);

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transactionid` binary(60) NOT NULL,
  `user_from` varchar(100) DEFAULT NULL,
  `user_to` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userid` varchar(100) NOT NULL,
  `password` binary(60) NOT NULL,
  `publickey` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userid`, `password`, `publickey`) VALUES
('admin', 0x243261243132245341336542672f774975664e766a444e746d2e36582e375a6576694a354764456f4e73412e74346557424c4a56334933336642706d, '0x995a78a3e47bf647a68a22e978fd983d16cf1437');

-- --------------------------------------------------------

--
-- Table structure for table `userquiz`
--

CREATE TABLE `userquiz` (
  `iduserquiz` varchar(100) NOT NULL,
  `userans` varchar(5) NOT NULL,
  `timetaken` varchar(45) NOT NULL,
  `points` int(11) DEFAULT NULL,
  `time` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contract`
--
ALTER TABLE `contract`
  ADD PRIMARY KEY (`transaction_address`);

--
-- Indexes for table `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`quizid`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transactionid`),
  ADD KEY `fk_user_from` (`user_from`),
  ADD KEY `fk_user_to` (`user_to`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userid`);

--
-- Indexes for table `userquiz`
--
ALTER TABLE `userquiz`
  ADD PRIMARY KEY (`iduserquiz`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `fk_user_from` FOREIGN KEY (`user_from`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `fk_user_to` FOREIGN KEY (`user_to`) REFERENCES `user` (`userid`);

--
-- Constraints for table `userquiz`
--
ALTER TABLE `userquiz`
  ADD CONSTRAINT `quizid` FOREIGN KEY (`iduserquiz`) REFERENCES `quiz` (`quizid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `userid` FOREIGN KEY (`iduserquiz`) REFERENCES `user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
