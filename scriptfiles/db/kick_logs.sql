CREATE TABLE IF NOT EXISTS `kick_logs` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `KickedDBID` int(11) UNSIGNED NOT NULL,
  `KickedName` varchar(32) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `KickedBy` varchar(32) NOT NULL,
  `Date` varchar(90) NOT NULL,
    PRIMARY KEY
      (id),
    FOREIGN KEY
      (KickedDBID)
    REFERENCES
      masters(acc_dbid)
    ON DELETE
      CASCADE
    ON UPDATE
      NO ACTION
);