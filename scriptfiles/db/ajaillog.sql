CREATE TABLE IF NOT EXISTS `ajaillog` (
    `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `JailedDBID` int(11) UNSIGNED NOT NULL,
    `JailedName` varchar(32) NOT NULL,
    `Reason` varchar(128) NOT NULL,
    `Date` varchar(90) NOT NULL,
    `JailedBy` varchar(32) NOT NULL,
    `Time` int(11) NOT NULL,
    PRIMARY KEY
        (id),
    FOREIGN KEY
        (JailedDBID)
    REFERENCES
        masters(acc_dbid)
    ON DELETE
        CASCADE
    ON UPDATE
        NO ACTION
);