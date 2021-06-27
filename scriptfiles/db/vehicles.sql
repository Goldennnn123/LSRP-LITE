CREATE TABLE IF NOT EXISTS `vehicles` (
  `VehicleDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `VehicleOwnerDBID` int(11) UNSIGNED NOT NULL,
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
  `VehicleBattery` float NOT NULL DEFAULT 100,
  `VehicleEngine` float NOT NULL DEFAULT 100,
  `VehicleTimesDestroyed` int(11) NOT NULL DEFAULT 0,
  `VehicleXMR` tinyint(1) NOT NULL DEFAULT 0,
  `VehicleAlarmLevel` int(11) NOT NULL DEFAULT 0,
  `VehicleLockLevel` int(11) NOT NULL DEFAULT 0,
  `VehicleImmobLevel` int(11) NOT NULL DEFAULT 1,
  `VehiclePrice` int(11) NOT NULL,
    PRIMARY KEY
        (VehicleDBID),
    FOREIGN KEY
        (VehicleOwnerDBID)
    REFERENCES
        masters(acc_dbid)
    ON DELETE
        CASCADE
    ON UPDATE
        NO ACTION
);
