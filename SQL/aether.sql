-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 23, 2018 at 03:11 PM
-- Server version: 5.7.23-2ubuntu1
-- PHP Version: 7.2.10-0ubuntu1

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
CREATE DATABASE  IF NOT EXISTS `aether` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `aether`;
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
  `transaction_address` varchar(64) NOT NULL,
  `uuid` char(36) NOT NULL,
  `facial_encoding` blob,
  `contract_address` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
('beebee', 0x24326124313224444c7167376e756e7a75506832526a342f59635563756e6a6156716f57455050444d62566134742e4b525847716f357665514d682e, '0x6b741638e289931e6347a11e5e6d8aaf0f69d8e1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('clarencethemonster', 0x24326124313224514236616e586b387671737a3741506447487449792e715467584e464f567244534d4a667252753546656b702e6a496c3866565779, '0x312a06d4b014d7a1c77a7a0cf5188c635ccbe714\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('jordysamuel', 0x243261243132244d723071616d753549777a6d6f376a4e704948314165305861763375776a6c6856653357574a7a444e49714478714f2f5453495232, '0xe442eb4d7a7a4888036ac92c0b25b1f52dd5b098\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),
('ouioui', 0x243261243132246530526b6c6e77786667577141494850773933726e7558324a43735872483353694e4f736f6d58616d774c536e4d542f7446323043, '0xf04c5b5ba62e7efdc6dcb5855e0f644a1fa0f5b8\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0');

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
