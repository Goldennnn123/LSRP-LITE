-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 28, 2020 at 09:41 AM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database`
--

-- --------------------------------------------------------

--
-- Table structure for table `ajail_logs`
--

CREATE TABLE `ajail_logs` (
  `id` int(11) NOT NULL,
  `JailedDBID` int(11) NOT NULL,
  `JailedName` varchar(32) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `Date` varchar(90) NOT NULL,
  `JailedBy` varchar(32) NOT NULL,
  `Time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ajail_logs`
--

INSERT INTO `ajail_logs` (`id`, `JailedDBID`, `JailedName`, `Reason`, `Date`, `JailedBy`, `Time`) VALUES
(1, 1, 'Asan_Rodnuna', 'test', 'July 12, 2020 12:38:39', 'Asan_Rodnuna', 1),
(2, 1, 'Asan_Rodnuna', '2', 'July 12, 2020 12:49:49', 'Asan_Rodnuna', 1),
(3, 1, 'Asan_Rodnuna', 'PG', 'July 25, 2020 21:07:42', 'Boston_Vinson', 10);

-- --------------------------------------------------------

--
-- Table structure for table `bannedlist`
--

CREATE TABLE `bannedlist` (
  `id` int(11) NOT NULL,
  `CharacterDBID` int(11) NOT NULL,
  `MasterDBID` int(11) NOT NULL,
  `CharacterName` varchar(32) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `Date` varchar(90) NOT NULL,
  `BannedBy` varchar(32) NOT NULL,
  `IpAddress` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ban_logs`
--

CREATE TABLE `ban_logs` (
  `id` int(11) NOT NULL,
  `CharacterDBID` int(11) NOT NULL,
  `MasterDBID` int(11) NOT NULL,
  `CharacterName` varchar(32) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `BannedBy` varchar(32) NOT NULL,
  `Date` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `business`
--

CREATE TABLE `business` (
  `BusinessDBID` int(11) NOT NULL,
  `BusinessName` varchar(90) COLLATE utf8mb4_croatian_ci NOT NULL,
  `BusinessOwnerDBID` int(11) NOT NULL,
  `BusinessType` int(11) NOT NULL,
  `BusinessPrice` int(11) NOT NULL DEFAULT 5000,
  `BusinessLevel` int(11) NOT NULL DEFAULT 1,
  `BusinessEntrancePrice` int(11) NOT NULL DEFAULT 200,
  `BusinessLock` int(11) NOT NULL,
  `BusinessEntranceX` float NOT NULL,
  `BusinessEntranceY` float NOT NULL,
  `BusinessEntranceZ` float NOT NULL,
  `BusinessEntranceWorld` int(11) NOT NULL,
  `BusinessEntranceInterior` int(11) NOT NULL,
  `BusinessInteriorX` float NOT NULL,
  `BusinessInteriorY` float NOT NULL,
  `BusinessInteriorZ` float NOT NULL,
  `BusinessInteriorWorld` int(11) NOT NULL,
  `BusinessInteriorID` int(11) NOT NULL,
  `BusinessBankPickupLocX` float NOT NULL,
  `BusinessBankPickupLocY` float NOT NULL,
  `BusinessBankPickupLocZ` float NOT NULL,
  `BusinessBankWorld` int(11) NOT NULL,
  `BusinessCash` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_croatian_ci;

--
-- Dumping data for table `business`
--

INSERT INTO `business` (`BusinessDBID`, `BusinessName`, `BusinessOwnerDBID`, `BusinessType`, `BusinessPrice`, `BusinessLevel`, `BusinessEntrancePrice`, `BusinessLock`, `BusinessEntranceX`, `BusinessEntranceY`, `BusinessEntranceZ`, `BusinessEntranceWorld`, `BusinessEntranceInterior`, `BusinessInteriorX`, `BusinessInteriorY`, `BusinessInteriorZ`, `BusinessInteriorWorld`, `BusinessInteriorID`, `BusinessBankPickupLocX`, `BusinessBankPickupLocY`, `BusinessBankPickupLocZ`, `BusinessBankWorld`, `BusinessCash`) VALUES
(1, 'Los Santos Bank', 0, 5, 3000, 1, 3000, 0, 595.095, -1249.65, 18.2519, 0, 0, 1667.18, -994.891, 683.691, 47987, 0, 1667.38, -972.982, 683.687, 47987, 0),
(7, 'Vehicle Shop', 0, 2, 5000, 1, 0, 0, 543.88, -1291.21, 17.2422, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(9, 'Pizza Stcak', 0, 4, 1, 1, 20, 0, 2104.89, -1806.64, 13.5547, 0, 0, 227.49, -89.845, 1001.49, 47800, 0, 0, 0, 0, 0, 920),
(10, '24/7', 0, 1, 5000, 1, 0, 0, 1352.29, -1758.75, 13.5078, 0, 0, 6.14169, -31.4951, 1003.55, 1338, 10, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `char_dbid` int(11) NOT NULL,
  `master_id` int(11) NOT NULL,
  `char_name` varchar(255) NOT NULL,
  `pTutorial` tinyint(1) NOT NULL DEFAULT 0,
  `pAdmin` int(11) NOT NULL,
  `pLevel` int(11) NOT NULL DEFAULT 0,
  `pExp` int(11) NOT NULL DEFAULT 0,
  `pLastSkin` int(11) NOT NULL DEFAULT 264,
  `pFaction` int(11) DEFAULT 0,
  `pFactionRank` int(11) NOT NULL,
  `pCash` int(11) NOT NULL DEFAULT 0,
  `pBank` int(11) NOT NULL,
  `pSpawnPoint` int(11) NOT NULL DEFAULT 0,
  `pSpawnHouse` int(11) NOT NULL DEFAULT 0,
  `pTimeout` int(11) NOT NULL DEFAULT 0,
  `pHealth` float NOT NULL DEFAULT 100,
  `pArmour` float NOT NULL DEFAULT 0,
  `pLastPosX` float NOT NULL DEFAULT 0,
  `pLastPosY` float NOT NULL DEFAULT 0,
  `pLastPosZ` float NOT NULL DEFAULT 0,
  `pLastInterior` int(11) NOT NULL DEFAULT 0,
  `pLastWorld` int(11) NOT NULL DEFAULT 0,
  `pJob` int(11) NOT NULL DEFAULT 0,
  `pSideJob` int(11) NOT NULL DEFAULT 0,
  `pCareer` int(11) NOT NULL DEFAULT 0,
  `pPaycheck` int(11) NOT NULL DEFAULT 0,
  `pFishes` int(11) NOT NULL DEFAULT 0,
  `pAdminjailed` int(11) NOT NULL,
  `pAdminjailTime` int(11) NOT NULL,
  `pPhone` int(11) NOT NULL,
  `pPhonePower` int(11) NOT NULL,
  `pHasRadio` int(11) NOT NULL,
  `pRadio1` int(11) NOT NULL,
  `pRadio2` int(11) NOT NULL,
  `pMainSlot` int(11) NOT NULL,
  `pWeapon0` int(11) NOT NULL,
  `pWeapon1` int(11) NOT NULL,
  `pWeapon2` int(11) NOT NULL,
  `pWeapon3` int(11) NOT NULL,
  `pWeapon4` int(11) NOT NULL,
  `pWeapon5` int(11) NOT NULL,
  `pWeapon6` int(11) NOT NULL,
  `pWeapon7` int(11) NOT NULL,
  `pWeapon8` int(11) NOT NULL,
  `pWeapon9` int(11) NOT NULL,
  `pWeapon10` int(11) NOT NULL,
  `pWeapon11` int(11) NOT NULL,
  `pWeapon12` int(11) NOT NULL,
  `pWeaponsAmmo0` int(11) NOT NULL,
  `pWeaponsAmmo1` int(11) NOT NULL,
  `pWeaponsAmmo2` int(11) NOT NULL,
  `pWeaponsAmmo3` int(11) NOT NULL,
  `pWeaponsAmmo4` int(11) NOT NULL,
  `pWeaponsAmmo5` int(11) NOT NULL,
  `pWeaponsAmmo6` int(11) NOT NULL,
  `pWeaponsAmmo7` int(11) NOT NULL,
  `pWeaponsAmmo8` int(11) NOT NULL,
  `pWeaponsAmmo9` int(11) NOT NULL,
  `pWeaponsAmmo10` int(11) NOT NULL,
  `pWeaponsAmmo11` int(11) NOT NULL,
  `pWeaponsAmmo12` int(11) NOT NULL,
  `pOwnedVehicles1` int(11) NOT NULL,
  `pOwnedVehicles2` int(11) NOT NULL,
  `pOwnedVehicles3` int(11) NOT NULL,
  `pOwnedVehicles4` int(11) NOT NULL,
  `pOwnedVehicles5` int(11) NOT NULL,
  `pOwnedVehicles6` int(11) NOT NULL,
  `pVehicleSpawned` int(11) NOT NULL,
  `pVehicleSpawnedID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `characters`
--

INSERT INTO `characters` (`char_dbid`, `master_id`, `char_name`, `pTutorial`, `pAdmin`, `pLevel`, `pExp`, `pLastSkin`, `pFaction`, `pFactionRank`, `pCash`, `pBank`, `pSpawnPoint`, `pSpawnHouse`, `pTimeout`, `pHealth`, `pArmour`, `pLastPosX`, `pLastPosY`, `pLastPosZ`, `pLastInterior`, `pLastWorld`, `pJob`, `pSideJob`, `pCareer`, `pPaycheck`, `pFishes`, `pAdminjailed`, `pAdminjailTime`, `pPhone`, `pPhonePower`, `pHasRadio`, `pRadio1`, `pRadio2`, `pMainSlot`, `pWeapon0`, `pWeapon1`, `pWeapon2`, `pWeapon3`, `pWeapon4`, `pWeapon5`, `pWeapon6`, `pWeapon7`, `pWeapon8`, `pWeapon9`, `pWeapon10`, `pWeapon11`, `pWeapon12`, `pWeaponsAmmo0`, `pWeaponsAmmo1`, `pWeaponsAmmo2`, `pWeaponsAmmo3`, `pWeaponsAmmo4`, `pWeaponsAmmo5`, `pWeaponsAmmo6`, `pWeaponsAmmo7`, `pWeaponsAmmo8`, `pWeaponsAmmo9`, `pWeaponsAmmo10`, `pWeaponsAmmo11`, `pWeaponsAmmo12`, `pOwnedVehicles1`, `pOwnedVehicles2`, `pOwnedVehicles3`, `pOwnedVehicles4`, `pOwnedVehicles5`, `pOwnedVehicles6`, `pVehicleSpawned`, `pVehicleSpawnedID`) VALUES
(1, 1, 'Asan_Rodnuna', 1, 1339, 20, 0, 299, 1, 1, 0, 2515699, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 59272, 50, 1, 911, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0),
(2, 1, 'Asan_Admin', 1, 1339, 1, 0, 264, 0, 0, 5000, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 2, 'Boston_Vinson', 1, 1339, 1, 0, 280, 0, 0, 0, 3000, 0, 0, 0, 98, 0, 1638.18, -2325.58, -2.67969, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 463, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0),
(4, 4, 'Admin_Admin', 1, 1339, 1, 0, 281, 0, 0, 4599, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 6, 'Justin_Bieber', 1, 1339, 1, 0, 264, 0, 0, 4970, 20, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `factions`
--

CREATE TABLE `factions` (
  `DBID` int(11) NOT NULL,
  `FactionName` varchar(90) NOT NULL,
  `FactionAbbrev` varchar(30) NOT NULL,
  `FactionSpawnX` float NOT NULL,
  `FactionSpawnY` float NOT NULL,
  `FactionSpawnZ` float NOT NULL,
  `FactionInterior` int(11) NOT NULL DEFAULT 0,
  `FactionWorld` int(11) NOT NULL DEFAULT 0,
  `FactionJoinRank` int(11) NOT NULL,
  `FactionAlterRank` int(11) NOT NULL,
  `FactionChatRank` int(11) NOT NULL,
  `FactionTowRank` int(11) NOT NULL,
  `FactionChatColor` int(11) NOT NULL,
  `FactionType` tinyint(4) NOT NULL,
  `FactionJob` int(11) NOT NULL,
  `FactionHouse` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factions`
--

INSERT INTO `factions` (`DBID`, `FactionName`, `FactionAbbrev`, `FactionSpawnX`, `FactionSpawnY`, `FactionSpawnZ`, `FactionInterior`, `FactionWorld`, `FactionJoinRank`, `FactionAlterRank`, `FactionChatRank`, `FactionTowRank`, `FactionChatColor`, `FactionType`, `FactionJob`, `FactionHouse`) VALUES
(1, 'Los Santos Police Department', 'POLICE', 297.29, 187.044, 1007.17, 3, 1339, 19, 3, 19, 7, -2130738945, 2, 1, 0),
(2, 'The Los Santos Fire & Medical Department', 'MEDIC&FIRE', 1175.81, -1313.68, -44.284, 0, 1339, 14, 3, 14, 6, -2130738945, 2, 2, 0),
(3, 'The Los Santos County Sheriff\'s Department', 'SHERIFF', 254.167, 1446.28, -8.381, 0, 1339, 15, 3, 15, 6, -2130738945, 2, 3, 0),
(4, '{A5D6A7}Vagos', 'GANG', 1647.32, -2327.82, -2.67969, 0, 15445, 2, 2, 14, 8, -2130738945, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `faction_ranks`
--

CREATE TABLE `faction_ranks` (
  `factionid` int(11) NOT NULL,
  `FactionRank1` varchar(60) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL DEFAULT 'NotSet',
  `FactionRank2` varchar(60) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL DEFAULT 'NotSet',
  `FactionRank3` varchar(60) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL DEFAULT 'NotSet',
  `FactionRank4` varchar(60) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL DEFAULT 'NotSet',
  `FactionRank5` varchar(60) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL DEFAULT 'NotSet',
  `FactionRank6` varchar(60) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL DEFAULT 'NotSet',
  `FactionRank7` varchar(60) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL DEFAULT 'NotSet',
  `FactionRank8` varchar(60) NOT NULL DEFAULT 'NotSet',
  `FactionRank9` varchar(60) NOT NULL DEFAULT 'NotSet',
  `FactionRank10` varchar(60) NOT NULL DEFAULT 'NotSet',
  `FactionRank11` varchar(60) NOT NULL DEFAULT 'NotSet',
  `FactionRank12` varchar(60) NOT NULL DEFAULT 'NotSet',
  `FactionRank13` varchar(60) NOT NULL DEFAULT 'NotSet',
  `FactionRank14` varchar(60) NOT NULL DEFAULT 'NotSet',
  `FactionRank15` varchar(60) NOT NULL DEFAULT 'NotSet',
  `FactionRank16` varchar(60) NOT NULL DEFAULT 'NotSet',
  `FactionRank17` varchar(60) NOT NULL DEFAULT 'NotSet',
  `FactionRank18` varchar(60) NOT NULL DEFAULT 'NotSet',
  `FactionRank19` varchar(60) NOT NULL DEFAULT 'NotSet',
  `FactionRank20` varchar(60) NOT NULL DEFAULT 'NotSet'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `faction_ranks`
--

INSERT INTO `faction_ranks` (`factionid`, `FactionRank1`, `FactionRank2`, `FactionRank3`, `FactionRank4`, `FactionRank5`, `FactionRank6`, `FactionRank7`, `FactionRank8`, `FactionRank9`, `FactionRank10`, `FactionRank11`, `FactionRank12`, `FactionRank13`, `FactionRank14`, `FactionRank15`, `FactionRank16`, `FactionRank17`, `FactionRank18`, `FactionRank19`, `FactionRank20`) VALUES
(1, 'Chief of Police', 'Assistant Chief of Police', 'Deputy Chief of Police', 'Commander', 'Captain III', 'Captain II', 'Captain I', 'Lieutenant II', 'Lieutenant I', ' Sergeant II', ' Sergeant I', 'Detective III', 'Detective II', 'Detective I', 'Police Officer III+1', 'Police Officer III', 'Police Officer II', 'Police Officer I', 'Police Cadet', 'NotSet'),
(2, 'Chief of Fire & Medical', 'Chief of Fire', 'Chief of Medical', 'Assistant Chief Fire & Medical', 'Supervisory Medic', 'Supervisory Fire', 'Medic Officer III', 'Medic Officer II', 'Medic Officer I', 'Fire Officer III', 'Fire Officer II', 'Fire Officer I', 'Medic Officer & Fire Officer', 'Cadet', '', '', '', '', '', ''),
(3, 'SHERIFF', 'Undersheriff', 'Assistant Sheriff', 'Captain III', 'Captain II', 'Captain I', 'Lieutenant II', 'Lieutenant I', 'Sergeant III', 'Sergeant II', 'Sergeant I', 'Deputy Sheriff III', 'Deputy Sheriff II', 'Deputy Sheriff I', 'Sheriff Cadet', '', '', '', '', ''),
(4, 'Head Of Gang', '78', '78', '78', '78', '78', '78', '78', '78', '78', '78', '78', '78', '78', '78', '78', '78', '78', '78', '78');

-- --------------------------------------------------------

--
-- Table structure for table `house`
--

CREATE TABLE `house` (
  `HouseDBID` int(11) NOT NULL,
  `HouseName` varchar(90) COLLATE utf8mb4_croatian_ci NOT NULL,
  `HouseOwnerDBID` int(11) NOT NULL,
  `HouseEntranceX` float NOT NULL,
  `HouseEntranceY` float NOT NULL,
  `HouseEntranceZ` float NOT NULL,
  `HouseEntranceWorld` int(11) NOT NULL,
  `HouseEntranceInterior` int(11) NOT NULL,
  `HouseInteriorX` float NOT NULL,
  `HouseInteriorY` float NOT NULL,
  `HouseInteriorZ` float NOT NULL,
  `HouseInteriorWorld` int(11) NOT NULL,
  `HouseInteriorID` int(11) NOT NULL,
  `HousePrice` int(11) NOT NULL,
  `HouseLevel` int(11) NOT NULL,
  `HouseLock` int(11) NOT NULL,
  `HousePlacePosX` float NOT NULL,
  `HousePlacePosY` float NOT NULL,
  `HousePlacePosZ` float NOT NULL,
  `HouseWeapons1` int(11) NOT NULL,
  `HouseWeapons2` int(11) NOT NULL,
  `HouseWeapons3` int(11) NOT NULL,
  `HouseWeapons4` int(11) NOT NULL,
  `HouseWeapons5` int(11) NOT NULL,
  `HouseWeapons6` int(11) NOT NULL,
  `HouseWeapons7` int(11) NOT NULL,
  `HouseWeapons8` int(11) NOT NULL,
  `HouseWeapons9` int(11) NOT NULL,
  `HouseWeapons10` int(11) NOT NULL,
  `HouseWeapons11` int(11) NOT NULL,
  `HouseWeapons12` int(11) NOT NULL,
  `HouseWeapons13` int(11) NOT NULL,
  `HouseWeapons14` int(11) NOT NULL,
  `HouseWeapons15` int(11) NOT NULL,
  `HouseWeapons16` int(11) NOT NULL,
  `HouseWeapons17` int(11) NOT NULL,
  `HouseWeapons18` int(11) NOT NULL,
  `HouseWeapons19` int(11) NOT NULL,
  `HouseWeapons20` int(11) NOT NULL,
  `HouseWeapons21` int(11) NOT NULL,
  `HouseWeaponsAmmo1` int(11) NOT NULL,
  `HouseWeaponsAmmo2` int(11) NOT NULL,
  `HouseWeaponsAmmo3` int(11) NOT NULL,
  `HouseWeaponsAmmo4` int(11) NOT NULL,
  `HouseWeaponsAmmo5` int(11) NOT NULL,
  `HouseWeaponsAmmo6` int(11) NOT NULL,
  `HouseWeaponsAmmo7` int(11) NOT NULL,
  `HouseWeaponsAmmo8` int(11) NOT NULL,
  `HouseWeaponsAmmo9` int(11) NOT NULL,
  `HouseWeaponsAmmo10` int(11) NOT NULL,
  `HouseWeaponsAmmo11` int(11) NOT NULL,
  `HouseWeaponsAmmo12` int(11) NOT NULL,
  `HouseWeaponsAmmo13` int(11) NOT NULL,
  `HouseWeaponsAmmo14` int(11) NOT NULL,
  `HouseWeaponsAmmo15` int(11) NOT NULL,
  `HouseWeaponsAmmo16` int(11) NOT NULL,
  `HouseWeaponsAmmo17` int(11) NOT NULL,
  `HouseWeaponsAmmo18` int(11) NOT NULL,
  `HouseWeaponsAmmo19` int(11) NOT NULL,
  `HouseWeaponsAmmo20` int(11) NOT NULL,
  `HouseWeaponsAmmo21` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_croatian_ci;

--
-- Dumping data for table `house`
--

INSERT INTO `house` (`HouseDBID`, `HouseName`, `HouseOwnerDBID`, `HouseEntranceX`, `HouseEntranceY`, `HouseEntranceZ`, `HouseEntranceWorld`, `HouseEntranceInterior`, `HouseInteriorX`, `HouseInteriorY`, `HouseInteriorZ`, `HouseInteriorWorld`, `HouseInteriorID`, `HousePrice`, `HouseLevel`, `HouseLock`, `HousePlacePosX`, `HousePlacePosY`, `HousePlacePosZ`, `HouseWeapons1`, `HouseWeapons2`, `HouseWeapons3`, `HouseWeapons4`, `HouseWeapons5`, `HouseWeapons6`, `HouseWeapons7`, `HouseWeapons8`, `HouseWeapons9`, `HouseWeapons10`, `HouseWeapons11`, `HouseWeapons12`, `HouseWeapons13`, `HouseWeapons14`, `HouseWeapons15`, `HouseWeapons16`, `HouseWeapons17`, `HouseWeapons18`, `HouseWeapons19`, `HouseWeapons20`, `HouseWeapons21`, `HouseWeaponsAmmo1`, `HouseWeaponsAmmo2`, `HouseWeaponsAmmo3`, `HouseWeaponsAmmo4`, `HouseWeaponsAmmo5`, `HouseWeaponsAmmo6`, `HouseWeaponsAmmo7`, `HouseWeaponsAmmo8`, `HouseWeaponsAmmo9`, `HouseWeaponsAmmo10`, `HouseWeaponsAmmo11`, `HouseWeaponsAmmo12`, `HouseWeaponsAmmo13`, `HouseWeaponsAmmo14`, `HouseWeaponsAmmo15`, `HouseWeaponsAmmo16`, `HouseWeaponsAmmo17`, `HouseWeaponsAmmo18`, `HouseWeaponsAmmo19`, `HouseWeaponsAmmo20`, `HouseWeaponsAmmo21`) VALUES
(2, '1/1 SMB', 5, 315.782, -1769.94, 4.6356, 0, 0, 243.368, -1851.53, 3333.93, 5621, 0, 10, 1, 0, 254.558, -1856.39, 3336.87, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `kick_logs`
--

CREATE TABLE `kick_logs` (
  `id` int(11) NOT NULL,
  `KickedDBID` int(11) NOT NULL,
  `KickedName` varchar(32) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `KickedBy` varchar(32) NOT NULL,
  `Date` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

--
-- Dumping data for table `masters`
--

INSERT INTO `masters` (`acc_dbid`, `acc_name`, `acc_pass`, `acc_email`, `admin`) VALUES
(1, 'Backerss', 'FD9D94340DBD72C11B37EBB0D2A19B4D05E00FD78E4E2CE8923B9EA3A54E900DF181CFB112A8A73228D1F3551680E2AD9701A4FCFB248FA7FA77B95180628BB2', '', 0),
(2, 'warriorkung', '98A420652EE71B259E5EDC47D03CB9171D055C5CCDDE2CD3C9D235054D1A336B293574A050BA29379E204CA1D6F847F42072D32A645D3F1574EA466D434C6DAB', '', 0),
(4, 'Asan', '344907E89B981CAF221D05F597EB57A6AF408F15F4DD7895BBD1B96A2938EC24A7DCF23ACB94ECE0B6D7B0640358BC56BDB448194B9305311AFF038A834A079F', '', 0),
(5, '', 'F05CAEFCDE493D748E32784B418DCB0399F8B48F0D932501857C2EFE9C46FBA8E4AE6D70D9EB0481BCE21CB32314EA4AE00C3F3E44D1C9422A620DC31A996F2F', '', 0),
(6, 'Justin_Bieber', 'EBDAF73BF4BA32150A6F9C7CDE8C7E6EA327324A9445407D727BD0A97FBD77C6D456D1A8942096E596238DF0A754DE10C1309A918ED0D1203CC379B24F062224', '', 0),
(7, '', 'F05CAEFCDE493D748E32784B418DCB0399F8B48F0D932501857C2EFE9C46FBA8E4AE6D70D9EB0481BCE21CB32314EA4AE00C3F3E44D1C9422A620DC31A996F2F', '', 0),
(8, '', 'F05CAEFCDE493D748E32784B418DCB0399F8B48F0D932501857C2EFE9C46FBA8E4AE6D70D9EB0481BCE21CB32314EA4AE00C3F3E44D1C9422A620DC31A996F2F', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `phonebook`
--

CREATE TABLE `phonebook` (
  `PhoneDBID` int(11) NOT NULL,
  `PhoneOwnerDBID` int(11) NOT NULL,
  `PhoneName` varchar(60) COLLATE utf8mb4_croatian_ci NOT NULL,
  `PhoneNumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_croatian_ci;

--
-- Dumping data for table `phonebook`
--

INSERT INTO `phonebook` (`PhoneDBID`, `PhoneOwnerDBID`, `PhoneName`, `PhoneNumber`) VALUES
(2, 1, 'Beem', 12345),
(3, 2, 'Beem', 12345),
(4, 1, 'Ken', 12345),
(5, 3, 'Asan', 59272);

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `VehicleDBID` int(11) NOT NULL,
  `VehicleOwnerDBID` int(11) NOT NULL,
  `VehicleFaction` int(11) NOT NULL DEFAULT 0,
  `VehicleModel` int(11) NOT NULL,
  `VehicleColor1` int(11) NOT NULL DEFAULT 0,
  `VehicleColor2` int(11) NOT NULL DEFAULT 0,
  `VehiclePaintjob` int(11) NOT NULL DEFAULT -1,
  `VehicleParkPosX` float NOT NULL,
  `VehicleParkPosY` float NOT NULL,
  `VehicleParkPosZ` float NOT NULL,
  `VehicleParkPosA` float NOT NULL,
  `VehicleParkInterior` int(11) NOT NULL DEFAULT 0,
  `VehicleParkWorld` int(11) NOT NULL DEFAULT 0,
  `VehiclePlates` varchar(32) NOT NULL,
  `VehicleLocked` int(11) NOT NULL,
  `VehicleImpounded` tinyint(1) NOT NULL DEFAULT 0,
  `VehicleImpoundPosX` float NOT NULL,
  `VehicleImpoundPosY` float NOT NULL,
  `VehicleImpoundPosZ` float NOT NULL,
  `VehicleImpoundPosA` float NOT NULL,
  `VehicleSirens` int(11) NOT NULL DEFAULT 0,
  `VehicleFuel` int(11) NOT NULL DEFAULT 100,
  `VehicleWeapons1` int(11) NOT NULL DEFAULT 0,
  `VehicleWeapons2` int(11) NOT NULL DEFAULT 0,
  `VehicleWeapons3` int(11) NOT NULL DEFAULT 0,
  `VehicleWeapons4` int(11) NOT NULL DEFAULT 0,
  `VehicleWeapons5` int(11) NOT NULL DEFAULT 0,
  `VehicleWeaponsAmmo1` int(11) NOT NULL DEFAULT 0,
  `VehicleWeaponsAmmo2` int(11) NOT NULL DEFAULT 0,
  `VehicleWeaponsAmmo3` int(11) NOT NULL DEFAULT 0,
  `VehicleWeaponsAmmo4` int(11) NOT NULL DEFAULT 0,
  `VehicleWeaponsAmmo5` int(11) NOT NULL DEFAULT 0,
  `VehicleLastDrivers1` int(11) NOT NULL DEFAULT 0,
  `VehicleLastDrivers2` int(11) NOT NULL DEFAULT 0,
  `VehicleLastDrivers3` int(11) NOT NULL DEFAULT 0,
  `VehicleLastDrivers4` int(11) NOT NULL DEFAULT 0,
  `VehicleLastPassengers1` int(11) NOT NULL DEFAULT 0,
  `VehicleLastPassengers2` int(11) NOT NULL DEFAULT 0,
  `VehicleLastPassengers3` int(11) NOT NULL DEFAULT 0,
  `VehicleLastPassengers4` int(11) NOT NULL DEFAULT 0,
  `VehicleBattery` float NOT NULL DEFAULT 100,
  `VehicleEngine` float NOT NULL DEFAULT 100,
  `VehicleTimesDestroyed` int(11) NOT NULL DEFAULT 0,
  `VehicleXMR` tinyint(1) NOT NULL DEFAULT 0,
  `VehicleAlarmLevel` int(11) NOT NULL DEFAULT 0,
  `VehicleLockLevel` int(11) NOT NULL DEFAULT 0,
  `VehicleImmobLevel` int(11) NOT NULL DEFAULT 1,
  `VehiclePrice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`VehicleDBID`, `VehicleOwnerDBID`, `VehicleFaction`, `VehicleModel`, `VehicleColor1`, `VehicleColor2`, `VehiclePaintjob`, `VehicleParkPosX`, `VehicleParkPosY`, `VehicleParkPosZ`, `VehicleParkPosA`, `VehicleParkInterior`, `VehicleParkWorld`, `VehiclePlates`, `VehicleLocked`, `VehicleImpounded`, `VehicleImpoundPosX`, `VehicleImpoundPosY`, `VehicleImpoundPosZ`, `VehicleImpoundPosA`, `VehicleSirens`, `VehicleFuel`, `VehicleWeapons1`, `VehicleWeapons2`, `VehicleWeapons3`, `VehicleWeapons4`, `VehicleWeapons5`, `VehicleWeaponsAmmo1`, `VehicleWeaponsAmmo2`, `VehicleWeaponsAmmo3`, `VehicleWeaponsAmmo4`, `VehicleWeaponsAmmo5`, `VehicleLastDrivers1`, `VehicleLastDrivers2`, `VehicleLastDrivers3`, `VehicleLastDrivers4`, `VehicleLastPassengers1`, `VehicleLastPassengers2`, `VehicleLastPassengers3`, `VehicleLastPassengers4`, `VehicleBattery`, `VehicleEngine`, `VehicleTimesDestroyed`, `VehicleXMR`, `VehicleAlarmLevel`, `VehicleLockLevel`, `VehicleImmobLevel`, `VehiclePrice`) VALUES
(8, 1, 0, 526, 2, 3, -1, 318.054, -1788.83, 4.44319, 358.129, 0, 0, '3YRR74', 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 100, 0, 0, 0, 0, 0, 80000),
(9, 3, 0, 541, 217, 188, -1, 556.215, -1291.02, 16.8665, 334.908, 0, 0, '4XBU12', 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 100, 0, 0, 0, 0, 0, 400000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ajail_logs`
--
ALTER TABLE `ajail_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bannedlist`
--
ALTER TABLE `bannedlist`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ban_logs`
--
ALTER TABLE `ban_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`BusinessDBID`);

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`char_dbid`);

--
-- Indexes for table `factions`
--
ALTER TABLE `factions`
  ADD PRIMARY KEY (`DBID`);

--
-- Indexes for table `faction_ranks`
--
ALTER TABLE `faction_ranks`
  ADD PRIMARY KEY (`factionid`),
  ADD UNIQUE KEY `factionid` (`factionid`);

--
-- Indexes for table `house`
--
ALTER TABLE `house`
  ADD PRIMARY KEY (`HouseDBID`);

--
-- Indexes for table `kick_logs`
--
ALTER TABLE `kick_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `masters`
--
ALTER TABLE `masters`
  ADD PRIMARY KEY (`acc_dbid`);

--
-- Indexes for table `phonebook`
--
ALTER TABLE `phonebook`
  ADD PRIMARY KEY (`PhoneDBID`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`VehicleDBID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ajail_logs`
--
ALTER TABLE `ajail_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `bannedlist`
--
ALTER TABLE `bannedlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ban_logs`
--
ALTER TABLE `ban_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `business`
--
ALTER TABLE `business`
  MODIFY `BusinessDBID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `char_dbid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `DBID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `faction_ranks`
--
ALTER TABLE `faction_ranks`
  MODIFY `factionid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `house`
--
ALTER TABLE `house`
  MODIFY `HouseDBID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `kick_logs`
--
ALTER TABLE `kick_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `masters`
--
ALTER TABLE `masters`
  MODIFY `acc_dbid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `phonebook`
--
ALTER TABLE `phonebook`
  MODIFY `PhoneDBID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `VehicleDBID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
