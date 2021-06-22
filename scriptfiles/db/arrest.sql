CREATE TABLE IF NOT EXISTS `ArrestRecord` (
    `ArrestDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `ArrestOwnerDBID` int(11) UNSIGNED NOT NULL,
    `ArrestByDBID` int(11) NOT NULL,
    `ArrestReason` varchar(255) NOT NULL,
    `ArrestTime` int(11) NOT NULL,
    `ArrestDate` varchar(120) NOT NULL,
    PRIMARY KEY
        (ArrestDBID),
    FOREIGN KEY
        (ArrestOwnerDBID)
    REFERENCES
        masters(acc_dbid)
    ON DELETE
        CASCADE
    ON UPDATE
        NO ACTION
);