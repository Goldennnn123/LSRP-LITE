stock SaveVehicle(vehicleid, thread = MYSQL_TYPE_THREAD)
{
	new query[MAX_STRING], str[60];

	mysql_init("vehicles", "VehicleDBID", VehicleInfo[vehicleid][eVehicleDBID], thread);

	mysql_str(query, "VehicleName",VehicleInfo[vehicleid][eVehicleName]);
	mysql_bool(query, "VehicleCarPark",VehicleInfo[vehicleid][eVehicleCarPark]);
	mysql_int(query, "VehicleOwnerDBID",VehicleInfo[vehicleid][eVehicleOwnerDBID]);
	mysql_int(query, "VehicleFaction",VehicleInfo[vehicleid][eVehicleFaction]);
	mysql_int(query, "VehicleColor1",VehicleInfo[vehicleid][eVehicleColor1]);

	mysql_int(query, "VehiclePaintjob",VehicleInfo[vehicleid][eVehiclePaintjob]);

	mysql_str(query, "VehiclePlates",VehicleInfo[vehicleid][eVehiclePlates]);
	mysql_int(query, "VehicleLocked",VehicleInfo[vehicleid][eVehicleLocked]);
	mysql_int(query, "VehicleSirens",VehicleInfo[vehicleid][eVehicleSirens]);
	mysql_flo(query, "VehicleFuel",VehicleInfo[vehicleid][eVehicleFuel]);
	mysql_int(query, "VehicleColor1",VehicleInfo[vehicleid][eVehicleColor1]);
	mysql_int(query, "VehicleColor2",VehicleInfo[vehicleid][eVehicleColor2]);
	
	mysql_int(query, "VehicleXMR",VehicleInfo[vehicleid][eVehicleHasXMR]);
	mysql_flo(query, "VehicleBattery",VehicleInfo[vehicleid][eVehicleBattery]);
	mysql_flo(query, "VehicleEngine",VehicleInfo[vehicleid][eVehicleEngine]);
	mysql_flo(query, "VehicleTimesDestroyed",VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
	mysql_int(query, "VehicleLockLevel",VehicleInfo[vehicleid][eVehicleLockLevel]);
	mysql_int(query, "VehicleAlarmLevel",VehicleInfo[vehicleid][eVehicleAlarmLevel]);
	mysql_int(query, "VehicleImmobLevel",VehicleInfo[vehicleid][eVehicleImmobLevel]);
	
	
	mysql_flo(query, "VehicleParkPosX",VehicleInfo[vehicleid][eVehicleParkPos][0]);
	mysql_flo(query, "VehicleParkPosY",VehicleInfo[vehicleid][eVehicleParkPos][1]);
	mysql_flo(query, "VehicleParkPosZ",VehicleInfo[vehicleid][eVehicleParkPos][2]);
	mysql_flo(query, "VehicleParkPosA",VehicleInfo[vehicleid][eVehicleParkPos][3]);
	mysql_int(query, "VehicleParkInterior",VehicleInfo[vehicleid][eVehicleParkInterior]);
	mysql_int(query, "VehicleParkWorld",VehicleInfo[vehicleid][eVehicleParkWorld]);
	
	mysql_int(query, "VehicleImpounded",VehicleInfo[vehicleid][eVehicleImpounded]);
	mysql_flo(query, "VehicleImpoundPosX",VehicleInfo[vehicleid][eVehicleImpoundPos][0]);
	mysql_flo(query, "VehicleImpoundPosY",VehicleInfo[vehicleid][eVehicleImpoundPos][1]);
	mysql_flo(query, "VehicleImpoundPosZ",VehicleInfo[vehicleid][eVehicleImpoundPos][2]);

	
	for(new i = 1; i < 6; i++)
	{
		format(str, sizeof(str), "VehicleWeapons%d",i);
		mysql_int(query, str,VehicleInfo[vehicleid][eVehicleWeapons][i]);
		
		format(str, sizeof(str), "VehicleWeaponsAmmo%d",i);
		mysql_int(query, str,VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i]);
	}

	for(new i = 0; i < 14; i++)
	{
		format(str, sizeof(str), "VehicleMod%d",i);

		VehicleInfo[vehicleid][eVehicleMod][i] = GetVehicleComponentInSlot(vehicleid, i);
		mysql_int(query, str,VehicleInfo[vehicleid][eVehicleMod][i]);
	}

	GetVehicleDamageStatus(vehicleid, VehicleInfo[vehicleid][eVehicleDamage][0], VehicleInfo[vehicleid][eVehicleDamage][1], VehicleInfo[vehicleid][eVehicleDamage][2],VehicleInfo[vehicleid][eVehicleDamage][3]);
	for(new i = 0; i < 4; i++)
	{
		format(str, sizeof(str), "VehicleDamage%d",i);
		mysql_int(query, str,VehicleInfo[vehicleid][eVehicleDamage][i]);
	}

	GetVehicleHealth(vehicleid, VehicleInfo[vehicleid][eVehicleHealth]);
	mysql_flo(query, "VehicleHealth", VehicleInfo[vehicleid][eVehicleHealth]);

	mysql_int(query, "VehicleComp",VehicleInfo[vehicleid][eVehicleComp]);

	mysql_flo(query, "VehicleDrug1",VehicleInfo[vehicleid][eVehicleDrug][0]);
	mysql_flo(query, "VehicleDrug2",VehicleInfo[vehicleid][eVehicleDrug][1]);
	mysql_flo(query, "VehicleDrug3",VehicleInfo[vehicleid][eVehicleDrug][2]);
	
	mysql_finish(query);
	return 1;
}
