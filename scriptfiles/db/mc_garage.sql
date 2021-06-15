CREATE TABLE IF NOT EXISTS `mc_garage` (
  `Mc_GarageDBID` int(11) NOT NULL,
  `Mc_GaragePosX` float NOT NULL,
  `Mc_GaragePosY` float NOT NULL,
  `Mc_GaragePosZ` float NOT NULL,
  `Mc_GarageWorld` int(11) NOT NULL,
  `Mc_GarageInterior` int(11) NOT NULL,
    PRIMARY KEY
        (Mc_GarageDBID)
);

