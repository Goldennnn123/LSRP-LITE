CREATE TABLE IF NOT EXISTS `ban_logs` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharacterDBID` int(11) UNSIGNED NOT NULL,
  `MasterDBID` int(11) UNSIGNED NOT NULL,
  `CharacterName` varchar(32) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `BannedBy` varchar(32) NOT NULL,
  `Date` varchar(90) NOT NULL,
    PRIMARY KEY
        (id),
    FOREIGN KEY
        (MasterDBID)
    REFERENCES
        masters(acc_dbid)
    ON DELETE
        CASCADE
    ON UPDATE
        NO ACTION
);