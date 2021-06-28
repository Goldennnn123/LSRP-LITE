CREATE TABLE IF NOT EXISTS `characters` (
  `char_dbid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `master_id` int(11) UNSIGNED NOT NULL,
  `char_name` varchar(255) NOT NULL,
  `pWhitelist` int(10) NOT NULL,
  `pLastOnline` varchar(255) NOT NULL,
  `pTimeplayed` int(11) NOT NULL,
  `pTutorial` tinyint(1) NOT NULL DEFAULT 0,
  `pAdmin` int(11) NOT NULL,
  `pTester` int(11) NOT NULL,
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
  `pHasMask` int(11) NOT NULL,
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
  `pCPU` int(11) NOT NULL,
  `pGPU` int(11) NOT NULL,
  `pRAM` int(11) NOT NULL,
  `pBTC` float(11) NOT NULL DEFAULT 0.00000,
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
  `RentCarKey` int(11) NOT NULL,
  `pInsideBusiness` int(11) NOT NULL,
  `pInsideProperty` int(11) NOT NULL,
  `pKNO3` int(11) NOT NULL,
  `pCigare` int(11) NOT NULL,
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
  `pVehicleSpawnedID` int(11) NOT NULL,
  PRIMARY KEY
        (char_dbid),
    FOREIGN KEY
        (master_id)
    REFERENCES
        masters(acc_dbid)
    ON DELETE
        CASCADE
    ON UPDATE
        NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=tis620;