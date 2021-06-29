stock SaveFacVehicle(vehicleid, thread = MYSQL_TYPE_THREAD)
{
	new query[MAX_STRING];

	mysql_init("vehicle_faction", "VehicleDBID", VehFacInfo[vehicleid][VehFacDBID], thread);

	mysql_int(query, "VehicleModel",VehFacInfo[vehicleid][VehFacModel]);
	mysql_int(query, "VehicleFaction",VehFacInfo[vehicleid][VehFacFaction]);

	mysql_flo(query, "VehicleParkPosX",VehFacInfo[vehicleid][VehFacPos][0]);
	mysql_flo(query, "VehicleParkPosY",VehFacInfo[vehicleid][VehFacPos][1]);
	mysql_flo(query, "VehicleParkPosZ",VehFacInfo[vehicleid][VehFacPos][2]);
	mysql_flo(query, "VehicleParkPosA",VehFacInfo[vehicleid][VehFacPos][3]);
	mysql_int(query, "VehicleParkWorld",VehFacInfo[vehicleid][VehFacPosWorld]);

	mysql_int(query, "VehicleColor1",VehFacInfo[vehicleid][VehFacColor][0]);
	mysql_int(query, "VehicleColor2",VehFacInfo[vehicleid][VehFacColor][1]);
	mysql_finish(query);
    return 1;
}