CREATE TABLE IF NOT EXISTS `factions` (
  `DBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
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
  `FactionHouse` int(11) NOT NULL,
    PRIMARY KEY
      (DBID)
);