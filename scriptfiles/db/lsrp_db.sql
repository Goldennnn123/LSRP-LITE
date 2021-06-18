-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2021 at 07:37 AM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lsrptest`
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
  `BusinessS_Cemara` int(11) NOT NULL,
  `BusinessS_Mask` int(11) NOT NULL,
  `BusinessS_Flower` int(11) NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `char_dbid` int(11) NOT NULL,
  `master_id` int(11) NOT NULL,
  `char_name` varchar(255) NOT NULL,
  `pLastOnline` varchar(255) NOT NULL,
  `pTimeplayed` int(11) NOT NULL,
  `pTutorial` tinyint(1) NOT NULL DEFAULT 0,
  `pAdmin` int(11) NOT NULL,
  `pLevel` int(11) NOT NULL DEFAULT 0,
  `pExp` int(11) NOT NULL DEFAULT 0,
  `pLastSkin` int(11) NOT NULL DEFAULT 264,
  `pFaction` int(11) DEFAULT 0,
  `pFactionRank` int(11) NOT NULL,
  `pBadge` int(11) NOT NULL,
  `pCash` int(11) NOT NULL DEFAULT 0,
  `pBank` int(11) NOT NULL,
  `pSaving` int(11) NOT NULL DEFAULT 0,
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
  `pJobRank` int(11) NOT NULL,
  `pJobExp` int(11) NOT NULL DEFAULT 0,
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
  `pDriverLicense` int(11) NOT NULL DEFAULT 0,
  `pDriverLicenseWarn` int(11) NOT NULL DEFAULT 0,
  `pDriverLicenseRevoke` int(11) NOT NULL DEFAULT 0,
  `pDriverLicenseSus` int(11) NOT NULL DEFAULT 0,
  `pWeaponLicense` int(11) NOT NULL DEFAULT 0,
  `pWeaponLicenseType` int(11) NOT NULL DEFAULT 0,
  `pWeaponLicenseRevoke` int(11) NOT NULL DEFAULT 0,
  `pWeaponLicenseSus` int(11) NOT NULL DEFAULT 0,
  `pPilotLicense` int(11) NOT NULL DEFAULT 0,
  `pPilotLicenseBlacklist` int(11) NOT NULL DEFAULT 0,
  `pPilotLicenseRevoke` int(11) NOT NULL DEFAULT 0,
  `pMedicLicense` int(11) NOT NULL DEFAULT 0,
  `pMedicLicenseRevoke` int(11) NOT NULL DEFAULT 0,
  `pTuckingLicense` int(11) NOT NULL,
  `pTuckingLicenseWarn` int(11) NOT NULL,
  `pTuckingLicenseSus` int(11) NOT NULL,
  `pTuckingLicenseRevoke` int(11) NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `entrance`
--

CREATE TABLE `entrance` (
  `EntranceDBID` int(11) NOT NULL,
  `EntranceIconID` int(11) NOT NULL,
  `EntranceLocX` float NOT NULL,
  `EntranceLocY` float NOT NULL,
  `EntranceLocZ` float NOT NULL,
  `EntranceLocWorld` int(11) NOT NULL,
  `EntranceLocInID` int(11) NOT NULL,
  `EntranceLocInX` float NOT NULL,
  `EntranceLocInY` float NOT NULL,
  `EntranceLocInZ` float NOT NULL,
  `EntanceLocInWorld` int(11) NOT NULL,
  `EntranceLocInInID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `HouseEle` int(11) NOT NULL DEFAULT 0,
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
  `forum_name` varchar(255) NOT NULL,
  `acc_pass` varchar(129) NOT NULL,
  `acc_email` varchar(255) NOT NULL,
  `admin` int(11) NOT NULL,
  `active_ip` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mc_garage`
--

CREATE TABLE `mc_garage` (
  `Mc_GarageDBID` int(11) NOT NULL,
  `Mc_GaragePosX` float NOT NULL,
  `Mc_GaragePosY` float NOT NULL,
  `Mc_GaragePosZ` float NOT NULL,
  `Mc_GarageWorld` int(11) NOT NULL,
  `Mc_GarageInterior` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `VehicleComp` int(11) NOT NULL DEFAULT 0,
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

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_faction`
--

CREATE TABLE `vehicle_faction` (
  `VehicleDBID` int(11) NOT NULL,
  `VehicleModel` int(11) NOT NULL,
  `VehicleFaction` int(11) NOT NULL,
  `VehicleColor1` int(11) NOT NULL,
  `VehicleColor2` int(11) NOT NULL,
  `VehicleParkPosX` float NOT NULL,
  `VehicleParkPosY` float NOT NULL,
  `VehicleParkPosZ` float NOT NULL,
  `VehicleParkPosA` float NOT NULL,
  `VehicleParkWorld` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Indexes for table `entrance`
--
ALTER TABLE `entrance`
  ADD PRIMARY KEY (`EntranceDBID`);

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
-- Indexes for table `mc_garage`
--
ALTER TABLE `mc_garage`
  ADD PRIMARY KEY (`Mc_GarageDBID`);

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
-- Indexes for table `vehicle_faction`
--
ALTER TABLE `vehicle_faction`
  ADD PRIMARY KEY (`VehicleDBID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ajail_logs`
--
ALTER TABLE `ajail_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `BusinessDBID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `char_dbid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `entrance`
--
ALTER TABLE `entrance`
  MODIFY `EntranceDBID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `DBID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faction_ranks`
--
ALTER TABLE `faction_ranks`
  MODIFY `factionid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `house`
--
ALTER TABLE `house`
  MODIFY `HouseDBID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kick_logs`
--
ALTER TABLE `kick_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `masters`
--
ALTER TABLE `masters`
  MODIFY `acc_dbid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mc_garage`
--
ALTER TABLE `mc_garage`
  MODIFY `Mc_GarageDBID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phonebook`
--
ALTER TABLE `phonebook`
  MODIFY `PhoneDBID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `VehicleDBID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicle_faction`
--
ALTER TABLE `vehicle_faction`
  MODIFY `VehicleDBID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
