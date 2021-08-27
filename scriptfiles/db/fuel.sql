CREATE TABLE IF NOT EXISTS `fuel` (
  `F_ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `F_OwnerDBID` int(11) UNSIGNED NOT NULL,
  `F_Business` int(11) NOT NULL,
  `F_Fuel` float(11) NOT NULL,
  `F_Price` int(11) NOT NULL,
  `F_PriceBuy` int(11) NOT NULL
  `F_PosX` float(11) NOT NULL,
  `F_PosY` float(11) NOT NULL,
  `F_PosZ` float(11) NOT NULL,
  `F_PosRX` float(11) NOT NULL,
  `F_PosRY` float(11) NOT NULL,
  `F_PosRZ` float(11) NOT NULL,
    PRIMARY KEY
        (F_ID)
);