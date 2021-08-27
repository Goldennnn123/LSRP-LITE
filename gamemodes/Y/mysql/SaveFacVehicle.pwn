stock SaveFacVehicle(vehicleid, thread = MYSQL_TYPE_THREAD)
{
	new query[MAX_STRING];

	mysql_init("vehicles", "VehicleDBID", VehicleInfo[vehicleid][eVehicleDBID], thread);

	mysql_int(query, "VehicleModel",VehicleInfo[vehicleid][eVehicleModel]);
	mysql_int(query, "VehicleFaction",VehicleInfo[vehicleid][eVehicleFaction]);

	mysql_flo(query, "VehicleParkPosX",VehicleInfo[vehicleid][eVehicleParkPos][0]);
	mysql_flo(query, "VehicleParkPosY",VehicleInfo[vehicleid][eVehicleParkPos][1]);
	mysql_flo(query, "VehicleParkPosZ",VehicleInfo[vehicleid][eVehicleParkPos][2]);
	mysql_flo(query, "VehicleParkPosA",VehicleInfo[vehicleid][eVehicleParkPos][3]);
	mysql_int(query, "VehicleParkWorld",VehicleInfo[vehicleid][eVehicleParkWorld]);

	mysql_int(query, "VehicleColor1",VehicleInfo[vehicleid][eVehicleColor1]);
	mysql_int(query, "VehicleColor2",VehicleInfo[vehicleid][eVehicleColor2]);
	mysql_finish(query);
    return 1;
}