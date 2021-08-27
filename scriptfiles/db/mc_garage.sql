CREATE TABLE IF NOT EXISTS `garage` (
  `GarageDBID` int(11) NOT NULL,
  `GaragePosX` float NOT NULL,
  `GaragePosY` float NOT NULL,
  `GaragePosZ` float NOT NULL,
  `GarageWorld` int(11) NOT NULL,
  `GarageInterior` int(11) NOT NULL,
    PRIMARY KEY
        (GarageDBID)
);

