CREATE TABLE IF NOT EXISTS `gps` (
     `GPSDBID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
     `GPSOwner` int(11) UNSIGNED NOT NULL,
     `GPSName` varchar(255) NOT NULL,
     `GPSGobal` int(11) NOT NULL,
     `GPSPosX` float(11) NOT NULL,
     `GPSPosY` float(11) NOT NULL,
     `GPSPosZ` float(11) NOT NULL,
        PRIMARY KEY
            (GPSDBID),
        FOREIGN KEY
            (GPSOwner)
        REFERENCES
            characters(char_dbid)
        ON DELETE
            CASCADE
        ON UPDATE
            NO ACTION
);