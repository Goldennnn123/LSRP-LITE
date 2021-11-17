-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 10, 2021 at 09:26 AM
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
-- Database: `lsrplite`
--

-- --------------------------------------------------------

--
-- Table structure for table `ajaillog`
--

CREATE TABLE `ajaillog` (
  `id` int(11) UNSIGNED NOT NULL,
  `JailedDBID` int(11) UNSIGNED NOT NULL,
  `JailedName` varchar(32) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `Date` varchar(90) NOT NULL,
  `JailedBy` varchar(32) NOT NULL,
  `Time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `arrestrecord`
--

CREATE TABLE `arrestrecord` (
  `ArrestDBID` int(11) UNSIGNED NOT NULL,
  `ArrestOwnerDBID` int(11) UNSIGNED NOT NULL,
  `ArrestByDBID` int(11) NOT NULL,
  `ArrestReason` varchar(255) NOT NULL,
  `ArrestTime` int(11) NOT NULL,
  `ArrestDate` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `bannedlist`
--

CREATE TABLE `bannedlist` (
  `id` int(11) UNSIGNED NOT NULL,
  `CharacterDBID` int(11) UNSIGNED NOT NULL,
  `MasterDBID` int(11) UNSIGNED NOT NULL,
  `CharacterName` varchar(32) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `Date` varchar(90) NOT NULL,
  `BannedBy` varchar(32) NOT NULL,
  `IpAddress` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ban_logs`
--

CREATE TABLE `ban_logs` (
  `id` int(11) UNSIGNED NOT NULL,
  `CharacterDBID` int(11) UNSIGNED NOT NULL,
  `MasterDBID` int(11) UNSIGNED NOT NULL,
  `CharacterName` varchar(32) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `BannedBy` varchar(32) NOT NULL,
  `Date` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `business`
--

CREATE TABLE `business` (
  `BusinessDBID` int(11) UNSIGNED NOT NULL,
  `BusinessName` varchar(90) NOT NULL,
  `BusinessOwnerDBID` int(11) NOT NULL DEFAULT 0,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `C_ID` int(11) NOT NULL,
  `C_DBID` int(11) NOT NULL,
  `C_DUTY` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `char_dbid` int(11) UNSIGNED NOT NULL,
  `master_id` int(11) UNSIGNED NOT NULL,
  `char_name` varchar(255) NOT NULL,
  `pWhitelist` int(10) NOT NULL,
  `pLastOnline` varchar(255) NOT NULL,
  `pTimeplayed` int(11) NOT NULL,
  `pTutorial` tinyint(1) NOT NULL DEFAULT 0,
  `pAdmin` int(11) NOT NULL,
  `pTester` int(11) NOT NULL,
  `pRadioOn` int(11) NOT NULL,
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
  `pHouseKey` int(11) NOT NULL,
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
  `pHasMask` int(11) NOT NULL,
  `pBoomBox` int(11) NOT NULL,
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
  `pTxaiLicense` int(11) NOT NULL,
  `pCPU` int(11) NOT NULL,
  `pGPU` int(11) NOT NULL,
  `pRAM` int(11) NOT NULL,
  `pBTC` float NOT NULL DEFAULT 0,
  `pStored` int(11) NOT NULL,
  `pArrest` int(11) NOT NULL,
  `pArrestBy` int(11) NOT NULL,
  `pArrestTime` int(11) NOT NULL,
  `pArrestRoom` int(11) NOT NULL,
  `pSkinClothing1` int(11) NOT NULL,
  `pSkinClothing2` int(11) NOT NULL,
  `pSkinClothing3` int(11) NOT NULL,
  `pDonater` int(11) NOT NULL,
  `pOre` int(11) NOT NULL,
  `pCoal` int(11) NOT NULL,
  `pIron` int(11) NOT NULL,
  `pCopper` int(11) NOT NULL,
  `pKNO3` int(11) NOT NULL,
  `RentCarKey` int(11) NOT NULL,
  `pInsideBusiness` int(11) NOT NULL,
  `pInsideProperty` int(11) NOT NULL,
  `pClothing1` int(11) NOT NULL,
  `pClothing2` int(11) NOT NULL,
  `pClothing3` int(11) NOT NULL,
  `pClothing4` int(11) NOT NULL,
  `pClothing5` int(11) NOT NULL,
  `pTicket` varchar(6) NOT NULL,
  `pDrug1` float NOT NULL DEFAULT 0,
  `pDrug2` float NOT NULL DEFAULT 0,
  `pDrug3` float NOT NULL DEFAULT 0,
  `pAddicted` int(11) NOT NULL,
  `pAddictedCount` int(11) NOT NULL DEFAULT 0,
  `pWalk` int(11) NOT NULL DEFAULT 0,
  `pFight` int(11) NOT NULL,
  `pTogPm` int(11) NOT NULL,
  `pCigare` int(11) NOT NULL DEFAULT 0,
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
  `pOwnedVehicles7` int(11) NOT NULL,
  `pOwnedVehicles8` int(11) NOT NULL,
  `pOwnedVehicles9` int(11) NOT NULL,
  `pOwnedVehicles10` int(11) NOT NULL,
  `pOwnedVehicles11` int(11) NOT NULL,
  `pVehicleSpawned` int(11) NOT NULL,
  `pVehicleSpawnedID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=tis620;

-- --------------------------------------------------------

--
-- Table structure for table `clothing`
--

CREATE TABLE `clothing` (
  `ClothingDBID` int(11) UNSIGNED NOT NULL,
  `ClothingOwnerDBID` int(11) UNSIGNED NOT NULL,
  `ClothingSpawn` int(11) NOT NULL,
  `ClothingModel` int(11) NOT NULL,
  `ClothingIndex` int(11) NOT NULL,
  `ClothingBone` int(11) NOT NULL,
  `ClothingOffPosX` float NOT NULL,
  `ClothingOffPosY` float NOT NULL,
  `ClothingOffPosZ` float NOT NULL,
  `ClothingOffPosRX` float NOT NULL,
  `ClothingOffPosRY` float NOT NULL,
  `ClothingOffPosRZ` float NOT NULL,
  `ClothingOffPosSacalX` float NOT NULL,
  `ClothingOffPosSacalY` float NOT NULL,
  `ClothingOffPosSacalZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `computer`
--

CREATE TABLE `computer` (
  `ComputerDBID` int(11) NOT NULL,
  `ComputerOwnerDBID` int(11) NOT NULL,
  `ComputerSpawn` int(11) NOT NULL DEFAULT 0,
  `ComputerOn` int(11) NOT NULL DEFAULT 0,
  `ComputerCPU` int(11) NOT NULL DEFAULT 0,
  `ComputerRAM` int(11) NOT NULL DEFAULT 0,
  `ComputerGPU1` int(11) NOT NULL DEFAULT 0,
  `ComputerGPU2` int(11) NOT NULL DEFAULT 0,
  `ComputerGPU3` int(11) NOT NULL DEFAULT 0,
  `ComputerGPU4` int(11) NOT NULL DEFAULT 0,
  `ComputerGPU5` int(11) NOT NULL DEFAULT 0,
  `ComputerStored` int(11) NOT NULL DEFAULT 0,
  `ComputerHouseDBID` int(11) NOT NULL DEFAULT 0,
  `ComputerStartBTC` int(11) NOT NULL DEFAULT 0,
  `ComputerBTC` float NOT NULL DEFAULT 0,
  `ComputerPosX` float NOT NULL DEFAULT 0,
  `ComputerPosY` float NOT NULL DEFAULT 0,
  `ComputerPosZ` float NOT NULL DEFAULT 0,
  `ComputerPosRX` float NOT NULL DEFAULT 0,
  `ComputerPosRY` float NOT NULL DEFAULT 0,
  `ComputerPosRZ` float NOT NULL DEFAULT 0,
  `ComputerPosWorld` int(11) NOT NULL DEFAULT 0,
  `ComputerPosInterior` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `customskinfac`
--

CREATE TABLE `customskinfac` (
  `factionid` int(11) NOT NULL,
  `FactionSkin1` int(11) NOT NULL DEFAULT 0,
  `FactionSkin2` int(11) NOT NULL DEFAULT 0,
  `FactionSkin3` int(11) NOT NULL DEFAULT 0,
  `FactionSkin4` int(11) NOT NULL DEFAULT 0,
  `FactionSkin5` int(11) NOT NULL DEFAULT 0,
  `FactionSkin6` int(11) NOT NULL DEFAULT 0,
  `FactionSkin7` int(11) NOT NULL DEFAULT 0,
  `FactionSkin8` int(11) NOT NULL DEFAULT 0,
  `FactionSkin9` int(11) NOT NULL DEFAULT 0,
  `FactionSkin10` int(11) NOT NULL DEFAULT 0,
  `FactionSkin11` int(11) NOT NULL DEFAULT 0,
  `FactionSkin12` int(11) NOT NULL DEFAULT 0,
  `FactionSkin13` int(11) NOT NULL DEFAULT 0,
  `FactionSkin14` int(11) NOT NULL DEFAULT 0,
  `FactionSkin15` int(11) NOT NULL DEFAULT 0,
  `FactionSkin16` int(11) NOT NULL DEFAULT 0,
  `FactionSkin17` int(11) NOT NULL DEFAULT 0,
  `FactionSkin18` int(11) NOT NULL DEFAULT 0,
  `FactionSkin19` int(11) NOT NULL DEFAULT 0,
  `FactionSkin20` int(11) NOT NULL DEFAULT 0,
  `FactionSkin21` int(11) NOT NULL DEFAULT 0,
  `FactionSkin22` int(11) NOT NULL DEFAULT 0,
  `FactionSkin23` int(11) NOT NULL DEFAULT 0,
  `FactionSkin24` int(11) NOT NULL DEFAULT 0,
  `FactionSkin25` int(11) NOT NULL DEFAULT 0,
  `FactionSkin26` int(11) NOT NULL DEFAULT 0,
  `FactionSkin27` int(11) NOT NULL DEFAULT 0,
  `FactionSkin28` int(11) NOT NULL DEFAULT 0,
  `FactionSkin29` int(11) NOT NULL DEFAULT 0,
  `FactionSkin30` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `entrance`
--

CREATE TABLE `entrance` (
  `EntranceDBID` int(11) UNSIGNED NOT NULL,
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
  `DBID` int(11) UNSIGNED NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `fine`
--

CREATE TABLE `fine` (
  `FineDBID` int(11) UNSIGNED NOT NULL,
  `FineOwner` int(11) UNSIGNED NOT NULL,
  `FineReson` varchar(255) NOT NULL,
  `FinePrice` int(11) NOT NULL,
  `FineBy` int(11) NOT NULL,
  `FineDate` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `fuel`
--

CREATE TABLE `fuel` (
  `F_ID` int(11) NOT NULL,
  `F_OwnerDBID` int(11) NOT NULL,
  `F_Business` int(11) NOT NULL,
  `F_Fuel` float NOT NULL,
  `F_Price` int(11) NOT NULL,
  `F_PriceBuy` int(11) NOT NULL,
  `F_PosX` float NOT NULL,
  `F_PosY` float NOT NULL,
  `F_PosZ` float NOT NULL,
  `F_PosRX` float NOT NULL,
  `F_PosRY` float NOT NULL,
  `F_PosRZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `furniture`
--

CREATE TABLE `furniture` (
  `fID` int(11) NOT NULL,
  `fModel` int(11) NOT NULL,
  `fName` varchar(60) NOT NULL,
  `fHouseID` int(11) NOT NULL,
  `fInterior` int(11) NOT NULL,
  `fVirtualWorld` int(11) NOT NULL,
  `fMarketPrice` int(11) NOT NULL,
  `fPosX` float NOT NULL,
  `fPosY` float NOT NULL,
  `fPosZ` float NOT NULL,
  `fPosRX` float NOT NULL,
  `fPosRY` float NOT NULL,
  `fPosRZ` float NOT NULL,
  `fLocked` int(11) NOT NULL,
  `fOpened` int(11) NOT NULL,
  `fType` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `global`
--

CREATE TABLE `global` (
  `ID` int(11) UNSIGNED NOT NULL,
  `G_BITSAMP` int(11) NOT NULL,
  `G_GovCash` int(11) NOT NULL,
  `G_BITStock` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `gps`
--

CREATE TABLE `gps` (
  `GPSDBID` int(11) UNSIGNED NOT NULL,
  `GPSOwner` int(11) UNSIGNED NOT NULL,
  `GPSName` varchar(255) NOT NULL,
  `GPSGobal` int(11) NOT NULL,
  `GPSPosX` float NOT NULL,
  `GPSPosY` float NOT NULL,
  `GPSPosZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `house`
--

CREATE TABLE `house` (
  `HouseDBID` int(11) UNSIGNED NOT NULL,
  `HouseName` varchar(90) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NOT NULL,
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
  `HouseStockCPU` int(11) NOT NULL DEFAULT 0,
  `HouseStockGPU` int(11) NOT NULL DEFAULT 0,
  `HouseStockRAM` int(11) NOT NULL DEFAULT 0,
  `HouseStockStored` int(11) NOT NULL DEFAULT 0,
  `HousePlacePosX` float NOT NULL,
  `HousePlacePosY` float NOT NULL,
  `HousePlacePosZ` float NOT NULL,
  `HouseDrug1` float NOT NULL DEFAULT 0,
  `HouseDrug2` float NOT NULL DEFAULT 0,
  `HouseDrug3` float NOT NULL DEFAULT 0,
  `HouseRentStats` int(11) NOT NULL DEFAULT 0,
  `HouseRent` int(11) NOT NULL DEFAULT 0,
  `HouseRentPrice` int(11) NOT NULL DEFAULT 0,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `kick_logs`
--

CREATE TABLE `kick_logs` (
  `id` int(11) UNSIGNED NOT NULL,
  `KickedDBID` int(11) UNSIGNED NOT NULL,
  `KickedName` varchar(32) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `KickedBy` varchar(32) NOT NULL,
  `Date` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `masters`
--

CREATE TABLE `masters` (
  `acc_dbid` int(11) UNSIGNED NOT NULL,
  `acc_name` varchar(64) NOT NULL,
  `forum_name` varchar(255) NOT NULL,
  `acc_pass` varchar(129) NOT NULL,
  `acc_email` varchar(255) NOT NULL,
  `admin` int(11) NOT NULL,
  `active_ip` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `phonebook`
--

CREATE TABLE `phonebook` (
  `PhoneDBID` int(11) UNSIGNED NOT NULL,
  `PhoneOwnerDBID` int(11) UNSIGNED NOT NULL,
  `PhoneName` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NOT NULL,
  `PhoneNumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `VehicleDBID` int(11) UNSIGNED NOT NULL,
  `VehicleOwnerDBID` int(11) UNSIGNED NOT NULL,
  `VehicleCarPark` int(11) NOT NULL,
  `VehicleName` varchar(60) NOT NULL,
  `VehicleFaction` int(11) NOT NULL DEFAULT 0,
  `VehicleModel` int(11) NOT NULL,
  `VehicleHealth` float NOT NULL DEFAULT 1000,
  `VehicleDamage0` int(11) NOT NULL DEFAULT 0,
  `VehicleDamage1` int(11) NOT NULL DEFAULT 0,
  `VehicleDamage2` int(11) NOT NULL DEFAULT 0,
  `VehicleDamage3` int(11) NOT NULL DEFAULT 0,
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
  `VehicleDrug1` float NOT NULL DEFAULT 0,
  `VehicleDrug2` float NOT NULL DEFAULT 0,
  `VehicleDrug3` float NOT NULL DEFAULT 0,
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
  `VehicleBattery` float NOT NULL DEFAULT 100,
  `VehicleEngine` float NOT NULL DEFAULT 100,
  `VehicleTimesDestroyed` int(11) NOT NULL DEFAULT 0,
  `VehicleXMR` tinyint(1) NOT NULL DEFAULT 0,
  `VehicleAlarmLevel` int(11) NOT NULL DEFAULT 0,
  `VehicleLockLevel` int(11) NOT NULL DEFAULT 0,
  `VehicleImmobLevel` int(11) NOT NULL DEFAULT 1,
  `VehiclePrice` int(11) NOT NULL,
  `VehicleMod0` int(11) NOT NULL,
  `VehicleMod1` int(11) NOT NULL,
  `VehicleMod2` int(11) NOT NULL,
  `VehicleMod3` int(11) NOT NULL,
  `VehicleMod4` int(11) NOT NULL,
  `VehicleMod5` int(11) NOT NULL,
  `VehicleMod6` int(11) NOT NULL,
  `VehicleMod7` int(11) NOT NULL,
  `VehicleMod8` int(11) NOT NULL,
  `VehicleMod9` int(11) NOT NULL,
  `VehicleMod10` int(11) NOT NULL,
  `VehicleMod11` int(11) NOT NULL,
  `VehicleMod12` int(11) NOT NULL,
  `VehicleMod13` int(11) NOT NULL,
  `VehicleMod14` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `weapons_package`
--

CREATE TABLE `weapons_package` (
  `wp_id` int(11) NOT NULL,
  `wp_owner` int(11) NOT NULL,
  `wp_type` int(11) NOT NULL,
  `wp_posx` float NOT NULL,
  `wp_posy` float NOT NULL,
  `wp_posz` float NOT NULL,
  `wp_world` int(11) NOT NULL,
  `wp_weapon1` int(11) NOT NULL,
  `wp_weapon2` int(11) NOT NULL,
  `wp_weapon3` int(11) NOT NULL,
  `wp_weapon4` int(11) NOT NULL,
  `wp_weapon5` int(11) NOT NULL,
  `wp_weapon6` int(11) NOT NULL,
  `wp_weapon7` int(11) NOT NULL,
  `wp_weapon8` int(11) NOT NULL,
  `wp_weapon9` int(11) NOT NULL,
  `wp_weapon10` int(11) NOT NULL,
  `wp_weapon11` int(11) NOT NULL,
  `wp_weapon12` int(11) NOT NULL,
  `wp_weaponAmmo1` int(11) NOT NULL,
  `wp_weaponAmmo2` int(11) NOT NULL,
  `wp_weaponAmmo3` int(11) NOT NULL,
  `wp_weaponAmmo4` int(11) NOT NULL,
  `wp_weaponAmmo5` int(11) NOT NULL,
  `wp_weaponAmmo6` int(11) NOT NULL,
  `wp_weaponAmmo7` int(11) NOT NULL,
  `wp_weaponAmmo8` int(11) NOT NULL,
  `wp_weaponAmmo9` int(11) NOT NULL,
  `wp_weaponAmmo10` int(11) NOT NULL,
  `wp_weaponAmmo11` int(11) NOT NULL,
  `wp_weaponAmmo12` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ajaillog`
--
ALTER TABLE `ajaillog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `JailedDBID` (`JailedDBID`);

--
-- Indexes for table `arrestrecord`
--
ALTER TABLE `arrestrecord`
  ADD PRIMARY KEY (`ArrestDBID`),
  ADD KEY `ArrestOwnerDBID` (`ArrestOwnerDBID`);

--
-- Indexes for table `bannedlist`
--
ALTER TABLE `bannedlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CharacterDBID` (`CharacterDBID`);

--
-- Indexes for table `ban_logs`
--
ALTER TABLE `ban_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `MasterDBID` (`MasterDBID`);

--
-- Indexes for table `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`BusinessDBID`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`C_ID`);

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`char_dbid`),
  ADD KEY `master_id` (`master_id`);

--
-- Indexes for table `clothing`
--
ALTER TABLE `clothing`
  ADD PRIMARY KEY (`ClothingDBID`),
  ADD KEY `ClothingOwnerDBID` (`ClothingOwnerDBID`);

--
-- Indexes for table `computer`
--
ALTER TABLE `computer`
  ADD PRIMARY KEY (`ComputerDBID`);

--
-- Indexes for table `customskinfac`
--
ALTER TABLE `customskinfac`
  ADD PRIMARY KEY (`factionid`);

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
  ADD PRIMARY KEY (`factionid`);

--
-- Indexes for table `fine`
--
ALTER TABLE `fine`
  ADD PRIMARY KEY (`FineDBID`),
  ADD KEY `FineOwner` (`FineOwner`);

--
-- Indexes for table `fuel`
--
ALTER TABLE `fuel`
  ADD PRIMARY KEY (`F_ID`);

--
-- Indexes for table `global`
--
ALTER TABLE `global`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `gps`
--
ALTER TABLE `gps`
  ADD PRIMARY KEY (`GPSDBID`),
  ADD KEY `GPSOwner` (`GPSOwner`);

--
-- Indexes for table `house`
--
ALTER TABLE `house`
  ADD PRIMARY KEY (`HouseDBID`);

--
-- Indexes for table `kick_logs`
--
ALTER TABLE `kick_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `KickedDBID` (`KickedDBID`);

--
-- Indexes for table `masters`
--
ALTER TABLE `masters`
  ADD PRIMARY KEY (`acc_dbid`),
  ADD UNIQUE KEY `acc_name` (`acc_name`);

--
-- Indexes for table `phonebook`
--
ALTER TABLE `phonebook`
  ADD PRIMARY KEY (`PhoneDBID`),
  ADD KEY `PhoneOwnerDBID` (`PhoneOwnerDBID`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`VehicleDBID`),
  ADD KEY `VehicleOwnerDBID` (`VehicleOwnerDBID`);

--
-- Indexes for table `weapons_package`
--
ALTER TABLE `weapons_package`
  ADD PRIMARY KEY (`wp_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ajaillog`
--
ALTER TABLE `ajaillog`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `arrestrecord`
--
ALTER TABLE `arrestrecord`
  MODIFY `ArrestDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bannedlist`
--
ALTER TABLE `bannedlist`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ban_logs`
--
ALTER TABLE `ban_logs`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `business`
--
ALTER TABLE `business`
  MODIFY `BusinessDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cache`
--
ALTER TABLE `cache`
  MODIFY `C_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `char_dbid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clothing`
--
ALTER TABLE `clothing`
  MODIFY `ClothingDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `computer`
--
ALTER TABLE `computer`
  MODIFY `ComputerDBID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `entrance`
--
ALTER TABLE `entrance`
  MODIFY `EntranceDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `DBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fine`
--
ALTER TABLE `fine`
  MODIFY `FineDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fuel`
--
ALTER TABLE `fuel`
  MODIFY `F_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `global`
--
ALTER TABLE `global`
  MODIFY `ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gps`
--
ALTER TABLE `gps`
  MODIFY `GPSDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `house`
--
ALTER TABLE `house`
  MODIFY `HouseDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kick_logs`
--
ALTER TABLE `kick_logs`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `masters`
--
ALTER TABLE `masters`
  MODIFY `acc_dbid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phonebook`
--
ALTER TABLE `phonebook`
  MODIFY `PhoneDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `VehicleDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `weapons_package`
--
ALTER TABLE `weapons_package`
  MODIFY `wp_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ajaillog`
--
ALTER TABLE `ajaillog`
  ADD CONSTRAINT `ajaillog_ibfk_1` FOREIGN KEY (`JailedDBID`) REFERENCES `characters` (`char_dbid`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `arrestrecord`
--
ALTER TABLE `arrestrecord`
  ADD CONSTRAINT `arrestrecord_ibfk_1` FOREIGN KEY (`ArrestOwnerDBID`) REFERENCES `characters` (`char_dbid`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `bannedlist`
--
ALTER TABLE `bannedlist`
  ADD CONSTRAINT `bannedlist_ibfk_1` FOREIGN KEY (`CharacterDBID`) REFERENCES `characters` (`char_dbid`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `ban_logs`
--
ALTER TABLE `ban_logs`
  ADD CONSTRAINT `ban_logs_ibfk_1` FOREIGN KEY (`MasterDBID`) REFERENCES `masters` (`acc_dbid`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `characters`
--
ALTER TABLE `characters`
  ADD CONSTRAINT `characters_ibfk_1` FOREIGN KEY (`master_id`) REFERENCES `masters` (`acc_dbid`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `clothing`
--
ALTER TABLE `clothing`
  ADD CONSTRAINT `clothing_ibfk_1` FOREIGN KEY (`ClothingOwnerDBID`) REFERENCES `characters` (`char_dbid`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `fine`
--
ALTER TABLE `fine`
  ADD CONSTRAINT `fine_ibfk_1` FOREIGN KEY (`FineOwner`) REFERENCES `characters` (`char_dbid`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `gps`
--
ALTER TABLE `gps`
  ADD CONSTRAINT `gps_ibfk_1` FOREIGN KEY (`GPSOwner`) REFERENCES `characters` (`char_dbid`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `kick_logs`
--
ALTER TABLE `kick_logs`
  ADD CONSTRAINT `kick_logs_ibfk_1` FOREIGN KEY (`KickedDBID`) REFERENCES `masters` (`acc_dbid`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `phonebook`
--
ALTER TABLE `phonebook`
  ADD CONSTRAINT `phonebook_ibfk_1` FOREIGN KEY (`PhoneOwnerDBID`) REFERENCES `characters` (`char_dbid`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
