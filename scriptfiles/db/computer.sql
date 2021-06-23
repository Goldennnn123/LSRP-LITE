CREATE TABLE IF NOT EXISTS `computer` (
    `ComputerDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `ComputerOwnerDBID` int(11) UNSIGNED NOT NULL,
    `ComputerSpawn` int(11) NOT NULL DEFAULT 0,
    `ComputerOn` int(11) NOT NULL DEFAULT 0,
    `ComputerCPU` int(11) NOT NULL DEFAULT 0,
    `ComputerRAM` int(11) NOT NULL DEFAULT 0,
    `ComputerGPU1` int(11) NOT NULL DEFAULT 0,
    `ComputerGPU2` int(11) NOT NULL DEFAULT 0,
    `ComputerGPU3` int(11) NOT NULL DEFAULT 0,
    `ComputerGPU4` int(11) NOT NULL DEFAULT 0,
    `ComputerGPU5` int(11) NOT NULL DEFAULT 0,
    `ComputerStored` int(11) NOT NULL DEFAULT 0,
    `ComputerHouseDBID` int(11) NOT NULL DEFAULT 0,
    `ComputerStartBTC` int(11) NOT NULL DEFAULT 0,
    `ComputerBTC` float(11) NOT NULL DEFAULT 0.000,
    `ComputerPosX` float(11) NOT NULL DEFAULT 0.0,
    `ComputerPosY` float(11) NOT NULL DEFAULT 0.0,
    `ComputerPosZ` float(11) NOT NULL DEFAULT 0.0,
    `ComputerPosRX` float(11) NOT NULL DEFAULT 0.0,
    `ComputerPosRY` float(11) NOT NULL DEFAULT 0.0,
    `ComputerPosRZ` float(11) NOT NULL DEFAULT 0.0,
    `ComputerPosWorld` int(11) NOT NULL DEFAULT 0,
    `ComputerPosInterior` int(11) NOT NULL DEFAULT 0,
    PRIMARY KEY
        (ComputerDBID),
    FOREIGN KEY
        (ComputerOwnerDBID)
    REFERENCES
        masters(acc_dbid)
    ON DELETE
        CASCADE
    ON UPDATE
        NO ACTION
);