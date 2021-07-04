CREATE TABLE IF NOT EXISTS `clothing` (
    `ClothingDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `ClothingOwnerDBID` int(11) UNSIGNED NOT NULL,
    `ClothingSpawn` int(11) NOT NULL,
    `ClothingModel` int(11) NOT NULL,
    `ClothingIndex` int(11) NOT NULL,
    `ClothingBone` int(11) NOT NULL,
    `ClothingOffPosX` float(11) NOT NULL,
    `ClothingOffPosY` float(11) NOT NULL,
    `ClothingOffPosZ` float(11) NOT NULL,
    `ClothingOffPosRX` float(11) NOT NULL,
    `ClothingOffPosRY` float(11) NOT NULL,
    `ClothingOffPosRZ` float(11) NOT NULL,
    `ClothingOffPosSacalX` float(11) NOT NULL,
    `ClothingOffPosSacalY` float(11) NOT NULL,
    `ClothingOffPosSacalZ` float(11) NOT NULL,
        PRIMARY KEY
        (ClothingDBID),
        FOREIGN KEY
            (ClothingOwnerDBID)
        REFERENCES
            characters(char_dbid)
        ON DELETE
            CASCADE
        ON UPDATE
            NO ACTION
);