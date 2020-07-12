-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 06, 2020 at 09:28 AM
-- Server version: 10.1.31-MariaDB
-- PHP Version: 7.1.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `samp`
--

-- --------------------------------------------------------

--
-- Table structure for table `masters`
--

CREATE TABLE `masters` (
  `acc_dbid` int(11) NOT NULL,
  `acc_name` varchar(64) NOT NULL,
  `acc_pass` varchar(129) NOT NULL,
  `acc_email` varchar(255) NOT NULL,
  `admin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `char_dbid` int(11) NOT NULL,
  `master_id` int(11) NOT NULL,
  `char_name` varchar(255) NOT NULL,
  `pTutorial` tinyint(1) NOT NULL DEFAULT '0',
  `pLevel` int(11) NOT NULL DEFAULT '0',
  `pExp` int(11) NOT NULL DEFAULT '0',
  `pLastSkin` int(11) NOT NULL DEFAULT '264',
  `pFaction` int(11) DEFAULT '0',
  `pCash` int(11) NOT NULL DEFAULT '0',
  `pSpawnPoint` int(11) NOT NULL DEFAULT '0',
  `pSpawnHouse` int(11) NOT NULL DEFAULT '0',
  `pTimeout` int(11) NOT NULL DEFAULT '0',
  `pHealth` float NOT NULL DEFAULT '100.0',
  `pArmour` float NOT NULL DEFAULT '0.0',
  `pLastPosX` float NOT NULL DEFAULT '0.0',
  `pLastPosY` float NOT NULL DEFAULT '0.0',
  `pLastPosZ` float NOT NULL DEFAULT '0.0',
  `pLastInterior` int(11) NOT NULL DEFAULT '0',
  `pLastWorld` int(11) NOT NULL DEFAULT '0',
  `pJob` int(11) NOT NULL DEFAULT '0',
  `pSideJob` int(11) NOT NULL DEFAULT '0',
  `pCareer` int(11) NOT NULL DEFAULT '0',
  `pPaycheck` int(11) NOT NULL DEFAULT '0',
  `pFishes` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `masters`
--
ALTER TABLE `masters`
  ADD PRIMARY KEY (`acc_dbid`);

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`char_dbid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `masters`
--
ALTER TABLE `masters`
  MODIFY `acc_dbid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `char_dbid` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
