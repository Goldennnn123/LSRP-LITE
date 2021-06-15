CREATE TABLE IF NOT EXISTS `phonebook` (
  `PhoneDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `PhoneOwnerDBID` int(11) UNSIGNED NOT NULL,
  `PhoneName` varchar(60) COLLATE utf8mb4_croatian_ci NOT NULL,
  `PhoneNumber` int(11) NOT NULL,
    PRIMARY KEY
      (PhoneDBID),
    FOREIGN KEY
      (PhoneOwnerDBID)
    REFERENCES
      masters(acc_dbid)
    ON DELETE
      CASCADE
    ON UPDATE
      NO ACTION
);