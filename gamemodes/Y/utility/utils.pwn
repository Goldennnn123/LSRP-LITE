stock SendClientMessageToAllEx(colour, const fmat[], va_args<>)
{
	new
		str[145];
	va_format(str, sizeof (str), fmat, va_start<2>);
	return SendClientMessageToAll(colour, str);
}

stock SendClientMessageEx(playerid, colour, const fmat[],  va_args<>)
{
	new
		str[145];
	va_format(str, sizeof (str), fmat, va_start<3>);
	return SendClientMessage(playerid, colour, str);
}


stock SendNearbyMessage(playerid, Float:radius, color, const fmat[], {Float,_}:...)
{
	new
		str[145];
	va_format(str, sizeof (str), fmat, va_start<4>);

	foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius)) {
			SendClientMessage(i, color, str);
		}
	}

	return 1;
}

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	if(targetid == INVALID_PLAYER_ID || !IsPlayerConnected(targetid)) {
		return 0;
	}

	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}

stock IsValidRoleplayName(const name[]) {
	if (!name[0] || strfind(name, "_") == -1)
	    return 0;

	else for (new i = 0, len = strlen(name); i != len; i ++) {
	    if ((i == 0) && (name[i] < 'A' || name[i] > 'Z'))
	        return 0;

		else if ((i != 0 && i < len  && name[i] == '_') && (name[i + 1] < 'A' || name[i + 1] > 'Z'))
		    return 0;

		else if ((name[i] < 'A' || name[i] > 'Z') && (name[i] < 'a' || name[i] > 'z') && name[i] != '_' && name[i] != '.')
		    return 0;
	}
	return 1;
}

stock KickEx(playerid)
{
	return SetTimerEx("KickTimer", 100, false, "i", playerid);
}

forward KickTimer(playerid);
public KickTimer(playerid) { return Kick(playerid); }

stock GetNearestVehicle(playerid, except_player_vehicle = false)
{
 	new
	 	Float:fX,
	 	Float:fY,
	 	Float:fZ,
	 	Float:fSX,
	    Float:fSY,
		Float:fSZ,
		Float:fRadius,
		playerVehicle = GetPlayerVehicleID(playerid);

	for (new i = 1, j = GetVehiclePoolSize(); i <= j; i ++)
	{
	    if (!IsVehicleStreamedIn(i, playerid) || (except_player_vehicle && playerVehicle == i))
		{
			continue;
	    }
	    else
	    {
			GetVehiclePos(i, fX, fY, fZ);

			GetVehicleModelInfo(GetVehicleModel(i), VEHICLE_MODEL_INFO_SIZE, fSX, fSY, fSZ);

			fRadius = floatsqroot((fSX + fSX) + (fSY + fSY));

			if (IsPlayerInRangeOfPoint(playerid, fRadius, fX, fY, fZ) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(i))
			{
				return i;
			}
		}
	}
	return INVALID_VEHICLE_ID;
}


stock GetPlayerNearVehicle(playerid)
{
	new bool:foundCar = false, vehicleid, Float:fetchPos[3];

	for (new i = 0; i < MAX_VEHICLES; i++)
		{
		GetVehiclePos(i, fetchPos[0], fetchPos[1], fetchPos[2]);
		if(IsPlayerInRangeOfPoint(playerid, 5.0, fetchPos[0], fetchPos[1], fetchPos[2]))
		{
			foundCar = true;
			vehicleid = i; 
			break; 
		}
	}

	if(foundCar == true)
	{
		return vehicleid;
	}
	else return INVALID_VEHICLE_ID;
}


stock SendTeleportMessage(playerid)
{
	return SendClientMessage(playerid, COLOR_GREY, "คุณถูกเคลื่อยย้ายโดยผู้ดูแลระบบ"); 
}