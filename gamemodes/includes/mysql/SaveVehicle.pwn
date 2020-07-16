stock SaveVehicle(vehicleid)
{
	new query[256];
	
	mysql_format(dbCon, query, sizeof(query), "UPDATE vehicles SET VehicleOwnerDBID = %i, VehicleFaction = %i, VehicleColor1 = %i, VehicleColor2 = %i, VehiclePaintjob = %i, VehiclePlates = '%e', VehicleLocked = %i, VehicleSirens = %i, VehicleFuel = %i WHERE VehicleDBID = %i",
		VehicleInfo[vehicleid][eVehicleOwnerDBID], 
		VehicleInfo[vehicleid][eVehicleFaction],
		VehicleInfo[vehicleid][eVehicleColor1],
		VehicleInfo[vehicleid][eVehicleColor2],
		VehicleInfo[vehicleid][eVehiclePaintjob],
		VehicleInfo[vehicleid][eVehiclePlates],
		VehicleInfo[vehicleid][eVehicleLocked],
		VehicleInfo[vehicleid][eVehicleSirens],
		VehicleInfo[vehicleid][eVehicleFuel],
		VehicleInfo[vehicleid][eVehicleDBID]);
	mysql_tquery(dbCon, query);
	
	mysql_format(dbCon, query, sizeof(query), "UPDATE vehicles SET VehicleXMR = %i, VehicleBattery = %f, VehicleEngine = %f, VehicleTimesDestroyed = %i WHERE VehicleDBID = %i",
		VehicleInfo[vehicleid][eVehicleHasXMR],
		VehicleInfo[vehicleid][eVehicleBattery],
		VehicleInfo[vehicleid][eVehicleEngine],
		VehicleInfo[vehicleid][eVehicleTimesDestroyed],
		VehicleInfo[vehicleid][eVehicleDBID]);
	mysql_tquery(dbCon, query);
	
	mysql_format(dbCon, query, sizeof(query), "UPDATE vehicles SET VehicleParkPosX = %f, VehicleParkPosY = %f, VehicleParkPosZ = %f, VehicleParkPosA = %f, VehicleParkInterior = %i, VehicleParkWorld = %i WHERE VehicleDBID = %i",
		VehicleInfo[vehicleid][eVehicleParkPos][0],
		VehicleInfo[vehicleid][eVehicleParkPos][1], 
		VehicleInfo[vehicleid][eVehicleParkPos][2],
		VehicleInfo[vehicleid][eVehicleParkPos][3],
		VehicleInfo[vehicleid][eVehicleParkInterior],
		VehicleInfo[vehicleid][eVehicleParkWorld],
		VehicleInfo[vehicleid][eVehicleDBID]);
	mysql_tquery(dbCon, query);
	
	mysql_format(dbCon, query, sizeof(query), "UPDATE vehicles SET VehicleImpounded = %i, VehicleImpoundPosX = %f, VehicleImpoundPosY = %f, VehicleImpoundPosZ = %f, VehicleImpoundPosA = %f WHERE VehicleDBID = %i",
		VehicleInfo[vehicleid][eVehicleImpounded],
		VehicleInfo[vehicleid][eVehicleImpoundPos][0],
		VehicleInfo[vehicleid][eVehicleImpoundPos][1],
		VehicleInfo[vehicleid][eVehicleImpoundPos][2],
		VehicleInfo[vehicleid][eVehicleImpoundPos][3],
		VehicleInfo[vehicleid][eVehicleDBID]);
	mysql_tquery(dbCon, query);


	mysql_format(dbCon, query, sizeof(query), "UPDATE vehicles SET VehicleLockLevel = %i, VehicleAlarmLevel = %i, VehicleImmobLevel = %i WHERE VehicleDBID = %i",
		VehicleInfo[vehicleid][eVehicleLockLevel],
		VehicleInfo[vehicleid][eVehicleAlarmLevel],
		VehicleInfo[vehicleid][eVehicleImmobLevel],
		VehicleInfo[vehicleid][eVehicleDBID]);
	mysql_tquery(dbCon, query);
	
	for(new i = 1; i < 6; i++)
	{
		mysql_format(dbCon, query, sizeof(query), "UPDATE vehicles SET VehicleWeapons%d = %i, VehicleWeaponsAmmo%d = %i WHERE VehicleDBID = %i",
			i,
			VehicleInfo[vehicleid][eVehicleWeapons][i],
			i,
			VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i],
			VehicleInfo[vehicleid][eVehicleDBID]);
		mysql_tquery(dbCon, query);
	}
	
	for(new j = 1; j < 5; j++)
	{
		mysql_format(dbCon, query, sizeof(query), "UPDATE vehicles SET VehicleLastDrivers%d = %i, VehicleLastPassengers%d = %i WHERE VehicleDBID = %i",
			j,
			VehicleInfo[vehicleid][eVehicleLastDrivers][j],
			j,
			VehicleInfo[vehicleid][eVehicleLastPassengers][j],
			VehicleInfo[vehicleid][eVehicleDBID]);
		mysql_tquery(dbCon, query);
			
	}
	return 1;
}
