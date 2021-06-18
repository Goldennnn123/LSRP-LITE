CREATE TABLE IF NOT EXISTS `entrance` (
  `EntranceDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
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
  `EntranceLocInInID` int(11) NOT NULL,
    PRIMARY KEY
      (EntranceDBID)
);