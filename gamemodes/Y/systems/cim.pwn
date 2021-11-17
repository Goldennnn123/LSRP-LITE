
CMD:cim(playerid, params[])
{
	new str[120];

	if(sscanf(params, "s[60]", str))
		return SendUsageMessage(playerid, "/cim <การกระทำ>");


	if(strlen(str) < 5 || strlen(str) > 60)
		return SendErrorMessage(playerid, "กรุณาใส่ชื่อให้มากกว่านี้");
	

	new idx = 0;
	for(new i = 1; i < MAX_CIM; i++)
	{
		if(!CimInfo[i][c_cimid])
		{
			idx = i;
			break;
		}
	}
	if(!idx)
		return SendErrorMessage(playerid, "การสร้าง cim เต็มแล้ว");

	
	CreateCim(playerid, idx, str);
	return 1;
}

CMD:cimdel(playerid, params[])
{
	if(IsNearPlayerCim(playerid))
	{
		if(PlayerInfo[playerid][pDBID] != CimInfo[IsNearPlayerCim(playerid)][c_cimby])
			return 1;
		
		RemoveCim(playerid, IsNearPlayerCim(playerid));
	}
	else if(PlayerInfo[playerid][pAdmin])
	{
		new id;
		if(sscanf(params, "d", id))
			return SendUsageMessage(playerid, "/(cimdel)ete");

		if(!CimInfo[id][c_cimid])
			return SendErrorMessage(playerid, "ไม่มี ไอดีที่คุณต้องการ");

		RemoveCim(playerid, id);
	}
	else SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ CIM ของคุณ");

	return 1;
}

CMD:cimlist(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);

	for(new i = 1; i < MAX_CIM; i++)
	{
		if(!CimInfo[i][c_cimid])
			continue;

		SendClientMessageEx(playerid, COLOR_HELPME, "ID: %d BY: %s DETEL: %.10s.. TIME: %s",CimInfo[i][c_cimid], ReturnDBIDName(CimInfo[i][c_cimby]), CimInfo[i][c_cimtext], CimInfo[i][c_cimtime]);
	}
	return 1;
}

stock RemoveCim(playerid, id)
{
	if(!CimInfo[id][c_cimid])
		return 1;

	CimInfo[id][c_cimid] = 0;
	CimInfo[id][c_cimby] = 0;
	format(CimInfo[id][c_cimtext], 60, " ");
	format(CimInfo[id][c_cimtime], 120, " ");

	CimInfo[id][c_cimpos][0] = 0;
	CimInfo[id][c_cimpos][1] = 0;
	CimInfo[id][c_cimpos][2] = 0;
	CimInfo[id][c_cimworld] = 0;
	
	DestroyDynamicPickup(CimInfo[id][c_cimItem]);
	SendClientMessageEx(playerid, COLOR_YELLOWEX, "คุณได้ลบ cim id ที่ %d", id);
	return 1;
}

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
	SendClientMessageEx(playerid, COLOR_YELLOWEX, "คุณได้สร้าง cim ไอดี %d", id);
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
                SendClientMessage(playerid, COLOR_HELPME, "------ส่วนของผู้ดูแล------");
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