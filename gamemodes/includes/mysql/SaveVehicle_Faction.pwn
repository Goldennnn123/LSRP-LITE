stock SaveVehicle_Faction(vehicleid)
{
    mysql_format(dbCon, query, sizeof(query), "UPDATE vehicle_faction SET VehicleModel = %d, VehicleFaction = %d WHERE VehicleDBID = %i",
		VehicleInfo[vehicleid][eVehicleModel],
		VehicleInfo[vehicleid][eVehicleFaction],
		VehicleInfo[vehicleid][eVehicleDBID]);
	mysql_tquery(dbCon, query);

    mysql_format(dbCon, query, sizeof(query), "UPDATE vehicle_faction SET VehicleParkPosX = %f, VehicleParkPosY = %f, VehicleParkPosZ = %f, VehicleParkPosA = %f WHERE VehicleDBID = %i",
		VehicleInfo[vehicleid][eVehicleParkPos][0],
		VehicleInfo[vehicleid][eVehicleParkPos][1],
        VehicleInfo[vehicleid][eVehicleParkPos][2],
        VehicleInfo[vehicleid][eVehicleParkPos][3],
		VehicleInfo[vehicleid][eVehicleDBID]);
	mysql_tquery(dbCon, query);

    mysql_format(dbCon, query, sizeof(query), "UPDATE vehicle_faction SET VehicleColor1 = %d, VehicleColor2 = %d WHERE VehicleDBID = %i",
		VehicleInfo[vehicleid][eVehicleColor1],
		VehicleInfo[vehicleid][eVehicleColor2],
		VehicleInfo[vehicleid][eVehicleDBID]);
	mysql_tquery(dbCon, query);

    return 1;
}