CREATE TABLE IF NOT EXISTS `vehicle_faction` (
  `VehicleDBID` int(11) NOT NULL AUTO_INCREMENT,
  `VehicleModel` int(11) NOT NULL,
  `VehicleFaction` int(11) NOT NULL,
  `VehicleColor1` int(11) NOT NULL,
  `VehicleColor2` int(11) NOT NULL,
  `VehicleParkPosX` float NOT NULL,
  `VehicleParkPosY` float NOT NULL,
  `VehicleParkPosZ` float NOT NULL,
  `VehicleParkPosA` float NOT NULL,
  `VehicleParkWorld` int(11) NOT NULL,
    PRIMARY KEY
      (VehicleDBID)
);