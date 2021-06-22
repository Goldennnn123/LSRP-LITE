CREATE TABLE IF NOT EXISTS `fine` (
    `FineDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `FineOwner` int(11) UNSIGNED NOT NULL,
    `FineReson` varchar(255) NOT NULL,
    `FinePrice` int(11) NOT NULL,
    `FineBy` int(11) NOT NULL,
    `FineDate` varchar(255) NOT NULL,
    PRIMARY KEY
        (FineDBID),
    FOREIGN KEY
        (FineOwner)
    REFERENCES
        masters(acc_dbid)
    ON DELETE
        CASCADE
    ON UPDATE
        NO ACTION
);