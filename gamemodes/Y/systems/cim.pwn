

stock CreateCim(playerid, id,text[])
{
	new Float:x, Float:y, Float:z;

	CimInfo[id][c_cimid] = id;
	CimInfo[id][c_cimby] = PlayerInfo[playerid][pDBID];
	format(CimInfo[id][c_cimtext], 60, "%s", text);
	format(CimInfo[id][c_cimtime], 120, "%s", ReturnDate());

	GetPlayerPos(playerid, x, y, z);
	CimInfo[id][c_cimpos][0] = x;
	CimInfo[id][c_cimpos][1] = y;
	CimInfo[id][c_cimpos][2] = z;
	CimInfo[id][c_cimworld] = GetPlayerVirtualWorld(playerid);
	
	DestroyDynamicPickup(CimInfo[id][c_cimItem]);
	CimInfo[id][c_cimItem] = CreateDynamicPickup(1239, 1, x, y, z, GetPlayerVirtualWorld(playerid), -1, -1, 60);
	SendClientMessageEx(playerid, COLOR_YELLOWEX, "�س�����ҧ cim �ʹ� %d", id);
	return 1;
}

stock IsNearPlayerCim(playerid)
{
	new id = 0;
	for(new i = 1; i < MAX_CIM; i++)
	{
		if(!CimInfo[i][c_cimid])
			continue;

		if(!IsPlayerInRangeOfPoint(playerid, 2.0, CimInfo[i][c_cimpos][0], CimInfo[i][c_cimpos][1], CimInfo[i][c_cimpos][2]))
			continue;

		if(CimInfo[i][c_cimworld] != GetPlayerVirtualWorld(playerid))
			continue;

		id = i;
	}

	return id;
}

hook OP_PickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
	if(IsNearPlayerCim(playerid))
	{
		new id = IsNearPlayerCim(playerid);

		if(pickupid == CimInfo[id][c_cimItem])
		{
            if(CimpInfo[playerid][c_cimpid] == id)
                return 1;
            
            if(PlayerInfo[playerid][pAdminDuty])
            {
                SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "[INFOMATION] %s", CimInfo[id][c_cimtext]);
                SendClientMessage(playerid, COLOR_HELPME, "------��ǹ�ͧ������------");
                SendClientMessageEx(playerid, COLOR_HELPME, "ID: %d", CimInfo[id][c_cimid]);
                SendClientMessageEx(playerid, COLOR_HELPME, "BY: %s", ReturnDBIDName(CimInfo[id][c_cimby]));
                SendClientMessageEx(playerid, COLOR_HELPME, "DATE: %s", CimInfo[id][c_cimtime]);
            }
            else SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "[INFOMATION] %s", CimInfo[id][c_cimtext]);

            CimpInfo[playerid][c_cimpid] = id;
            CimpInfo[playerid][c_cimptime] = SetTimerEx("GetPlayerNearCim", 60000, false, "d",playerid);
			return 1;
		}
	}

	return 1;
}

forward GetPlayerNearCim(playerid);
public GetPlayerNearCim(playerid)
{
    CimpInfo[playerid][c_cimpid] = 0;
    KillTimer(CimpInfo[playerid][c_cimptime]);
    CimpInfo[playerid][c_cimptime] = -1;
    return 1;
}