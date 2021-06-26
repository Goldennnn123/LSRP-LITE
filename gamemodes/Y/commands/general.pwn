CMD:help(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "___________www.lsrp-lite.co___________");
	SendClientMessage(playerid, COLOR_GRAD2,"[ACCOUNT] /stats /levelup /myweapon /setspawn /license /fines");
	SendClientMessage(playerid, COLOR_GRAD2,"[GENERAL] /pay /time /buy /call /coin /admins /housecmds");
	SendClientMessage(playerid, COLOR_GRAD2,"[CHAT] (/s)hout /(w)hisper /(o)oc /b /pm(ooc) (/l)ocal /me /ame /do(low) /low /radiohelp(/rhelp) ");
	SendClientMessage(playerid, COLOR_GRAD1,"[HELP] /jobhelp /fishhelp /stats /report");
	SendClientMessage(playerid, COLOR_GRAD2,"[ANIMATION] /anim /animlist /sa(stopanimation)");
	SendClientMessage(playerid, COLOR_GREEN,"_____________________________________");
    SendClientMessage(playerid, COLOR_GRAD1,"�ô�֡�Ҥ���������������������㹿��������� /report ���ͤ͢������������");
	return 1; 
}

alias:radiohelp("rhelp")
CMD:radiohelp(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN,"|_____________________Radio_help______________________|");
	SendClientMessage(playerid, COLOR_YELLOW,"HINT: �س����ö�����Է��������ҹ 24/7");
	SendClientMessage(playerid, COLOR_WHITE,"/setchannel - ��駤�����");
	SendClientMessage(playerid, COLOR_WHITE,"/setslot - ��駤����ͧ�ͧ���");
	SendClientMessage(playerid, COLOR_WHITE,"/r - �ٴ�Է��");
	SendClientMessage(playerid, COLOR_WHITE,"/rlow - �ٴ�Է��Ẻ��");
	SendClientMessage(playerid, COLOR_GREEN,"|_____________________________________________________|");
	return 1;
}

CMD:jobhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
	SendClientMessage(playerid, COLOR_GRAD3,"�Ҫվ㹻Ѩ�غѹ�ͧ�س:");
	SendClientMessageEx(playerid,COLOR_GRAD3,"%s", GetJobName(PlayerInfo[playerid][pCareer], PlayerInfo[playerid][pJob]));

	if(PlayerInfo[playerid][pSideJob]) {
		SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
		SendClientMessage(playerid, COLOR_GRAD3,"�Ҫվ�����:");
		SendClientMessageEx(playerid,COLOR_GRAD3,"%s", GetJobName(PlayerInfo[playerid][pCareer], PlayerInfo[playerid][pSideJob]));
	}

	// �Ҫվ�����
	

	// �Ҫվ��ѡ
	if(PlayerInfo[playerid][pJob] == JOB_FARMER) {
	    SendClientMessage(playerid,COLOR_LIGHTRED,"����觢ͧ������:");
		SendClientMessage(playerid,COLOR_WHITE,"/harvest");
		SendClientMessage(playerid,COLOR_WHITE,"/stopharvest");
	}

	if(PlayerInfo[playerid][pJob] == JOB_TRUCKER) {
	    SendClientMessage(playerid,COLOR_LIGHTRED,"����觢ͧ��ѡ�ҹ�觢ͧ:");
		SendClientMessage(playerid,COLOR_WHITE,"/cargo (���ʹ٤��������ǡѺ��ѧ�Թ���)");
	}

	if(PlayerInfo[playerid][pJob] == JOB_MECHANIC)
	{
 		SendClientMessage(playerid,COLOR_LIGHTRED,"����觢ͧ��ѡ�ҹ��ҧ¹��:");
		SendClientMessage(playerid,COLOR_WHITE,"/service (����觫����ҹ��˹�)");
		SendClientMessage(playerid,COLOR_WHITE,"/checkcomponents (�� ������)");
		SendClientMessage(playerid,COLOR_WHITE,"/buycomponents (���� ������)");
	}

	return 1;
}


CMD:mask(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] < 3 && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "�س������ѧ���ͷ��������� Mask �� (����ŵ�ͧ�ҡ���� 3 ����)"); 
		
	if(!PlayerInfo[playerid][pHasMask] /*&& !PlayerInfo[playerid][pAdmin]*/)
		return SendErrorMessage(playerid, "�س����� Mask"); 
	
	if(!PlayerInfo[playerid][pMasked])
	{
		foreach(new i : Player)
		{
			if(!PlayerInfo[i][pAdminDuty])
				ShowPlayerNameTagForPlayer(i, playerid, 0);
		}
		
		PlayerInfo[playerid][pMasked] = true;
		GameTextForPlayer(playerid, "~p~YOUR MASK IS NOW ON", 3000, 5); 
	}
	else
	{
		foreach(new i : Player)
		{	
			ShowPlayerNameTagForPlayer(i, playerid, 1);
		}
		
		PlayerInfo[playerid][pMasked] = false;
		GameTextForPlayer(playerid, "~p~YOUR MASK IS NOW OFF", 3000, 5); 
	}
		
	return 1;
}


CMD:enter(playerid,params[])
{
	for(new p = 1; p < MAX_HOUSE; p++)
	{
		if(!HouseInfo[p][HouseDBID])
			continue;

		if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[p][HouseEntrance][0], HouseInfo[p][HouseEntrance][1], HouseInfo[p][HouseEntrance][2]))
		{
			if(GetPlayerInterior(playerid) != HouseInfo[p][HouseEntranceWorld])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[p][HouseEntranceInterior])
				continue;

			if(HouseInfo[p][HouseLock] == true)
				return GameTextForPlayer(playerid, "~r~Locked", 3000, 1);

			if(!HouseInfo[p][HouseInterior][0] || !HouseInfo[p][HouseInterior][1] || !HouseInfo[p][HouseInterior][2])
				return GameTextForPlayer(playerid, "~r~Close", 3000, 1);

			PlayerInfo[playerid][pInsideProperty] = p;

			SetPlayerPos(playerid, HouseInfo[p][HouseInterior][0], HouseInfo[p][HouseInterior][1], HouseInfo[p][HouseInterior][2] - 3);
			
			SetPlayerVirtualWorld(playerid, HouseInfo[p][HouseInteriorWorld]);
			SetPlayerInterior(playerid, HouseInfo[p][HouseInteriorID]);
			
			TogglePlayerControllable(playerid, 0);
			SetTimerEx("OnPlayerEnterProperty", 2000, false, "ii", playerid, p); 
		}

	}
	for(new b = 1; b < MAX_BUSINESS; b++)
	{
		if(!BusinessInfo[b][BusinessDBID])
			continue;

		if(IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[b][BusinessEntrance][0], BusinessInfo[b][BusinessEntrance][1], BusinessInfo[b][BusinessEntrance][2]))
		{
			if(GetPlayerInterior(playerid) != BusinessInfo[b][BusinessEntranceWorld])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != BusinessInfo[b][BusinessEntranceInterior])
				continue;

			if(GetPlayerMoney(playerid) < BusinessInfo[b][BusinessEntrancePrice])
				return GameTextForPlayer(playerid, "~r~You don't have money", 3000, 1);

			if(!BusinessInfo[b][BusinessInterior][0] || !BusinessInfo[b][BusinessInterior][1] || !BusinessInfo[b][BusinessInterior][2] || BusinessInfo[b][BusinessType] == BUSINESS_TYPE_DEALERVEHICLE)
				return GameTextForPlayer(playerid, "~r~Close", 3000, 1);

			if(BusinessInfo[b][BusinessLock] == true && !PlayerInfo[playerid][pAdminDuty] && BusinessInfo[b][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
				return GameTextForPlayer(playerid, "~r~Lock", 3000, 1);


			PlayerInfo[playerid][pInsideBusiness] = b;

			SetPlayerPos(playerid, BusinessInfo[b][BusinessInterior][0], BusinessInfo[b][BusinessInterior][1], BusinessInfo[b][BusinessInterior][2] - 3);
			SetPlayerVirtualWorld(playerid, BusinessInfo[b][BusinessInteriorWorld]);
			SetPlayerInterior(playerid, BusinessInfo[b][BusinessInteriorID]);

			GiveMoney(playerid, -BusinessInfo[b][BusinessEntrancePrice]);
			BusinessInfo[b][BusinessCash] += BusinessInfo[b][BusinessEntrancePrice];

			TogglePlayerControllable(playerid, 0);
			SetTimerEx("OnPlayerEnterBusiness", 2000, false, "ii", playerid, b); 
			SendBusinessType(playerid, b);
		}
	}
	for(new e = 1; e < MAX_ENTRANCE; e++)
	{
		if(!EntranceInfo[e][EntranceDBID])
			continue;

		if(IsPlayerInRangeOfPoint(playerid, 3.0, EntranceInfo[e][EntranceLoc][0], EntranceInfo[e][EntranceLoc][1], EntranceInfo[e][EntranceLoc][2]))
		{
			if(GetPlayerInterior(playerid) != EntranceInfo[e][EntranceLocInID])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != EntranceInfo[e][EntranceLocWorld])
				continue;

			if(!EntranceInfo[e][EntranceLocIn][0] || !EntranceInfo[e][EntranceLocIn][1] || !EntranceInfo[e][EntranceLocIn][2])
				return GameTextForPlayer(playerid, "~r~Close", 3000, 1);

			TogglePlayerControllable(playerid, 0);
			SetPlayerPos(playerid, EntranceInfo[e][EntranceLocIn][0], EntranceInfo[e][EntranceLocIn][1], EntranceInfo[e][EntranceLocIn][2] - 3);
			SetPlayerVirtualWorld(playerid, EntranceInfo[e][EntanceLocInWorld]);
			SetPlayerInterior(playerid, EntranceInfo[e][EntranceLocInInID]);
			SetTimerEx("OnPlayerEnter", 2000, false, "ii", playerid, e);

			return 1;
		}
	}

	return 1;
}

CMD:exit(playerid, params[])
{
	new 
		id = PlayerInfo[playerid][pInsideProperty],
		b_id = PlayerInfo[playerid][pInsideBusiness]
	;

	if(id != 0)
	{
        if(!IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[id][HouseInterior][0], HouseInfo[id][HouseInterior][1], HouseInfo[id][HouseInterior][2]))
			return SendErrorMessage(playerid, "�س�������������еٷҧ�͡");
		
		SetPlayerPos(playerid, HouseInfo[id][HouseEntrance][0], HouseInfo[id][HouseEntrance][1], HouseInfo[id][HouseEntrance][2]);
		
		SetPlayerVirtualWorld(playerid, HouseInfo[id][HouseEntranceWorld]);
		SetPlayerInterior(playerid, HouseInfo[id][HouseEntranceInterior]);
		PlayerInfo[playerid][pInsideProperty] = 0;
		PlayerTextDrawHide(playerid, PlayerSwicthOff[playerid][0]);
		return 1;
    }
	if(b_id != 0)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[b_id][BusinessInterior][0], BusinessInfo[b_id][BusinessInterior][1], BusinessInfo[b_id][BusinessInterior][2]))
			return SendErrorMessage(playerid, "�س�������������еٷҧ�͡");
		
		SetPlayerPos(playerid, BusinessInfo[b_id][BusinessEntrance][0], BusinessInfo[b_id][BusinessEntrance][1], BusinessInfo[b_id][BusinessEntrance][2]);
		SetPlayerVirtualWorld(playerid, BusinessInfo[b_id][BusinessEntranceWorld]);
		SetPlayerInterior(playerid, BusinessInfo[b_id][BusinessEntranceInterior]);
		PlayerInfo[playerid][pInsideBusiness] = b_id;
		return 1;
	}
	for(new e = 1; e < MAX_ENTRANCE; e++)
	{
		if(!EntranceInfo[e][EntranceDBID])
			continue;

		if(IsPlayerInRangeOfPoint(playerid, 3.0, EntranceInfo[e][EntranceLocIn][0], EntranceInfo[e][EntranceLocIn][1], EntranceInfo[e][EntranceLocIn][2]))
		{
			if(GetPlayerInterior(playerid) != EntranceInfo[e][EntranceLocInInID])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != EntranceInfo[e][EntanceLocInWorld])
				continue;

			if(EntranceInfo[e][EntranceLocWorld] != 0)
			{
				TogglePlayerControllable(playerid, 0);
				SetPlayerPos(playerid, EntranceInfo[e][EntranceLoc][0], EntranceInfo[e][EntranceLoc][1], EntranceInfo[e][EntranceLoc][2]-3);
				SetTimerEx("OnPlayerExit", 2000, false, "ii", playerid, e);
				return 1;
			}
			//else SetPlayerPos(playerid, EntranceInfo[e][EntranceLoc][0], EntranceInfo[e][EntranceLoc][1], EntranceInfo[e][EntranceLoc][2]);

			SetPlayerPos(playerid, EntranceInfo[e][EntranceLoc][0], EntranceInfo[e][EntranceLoc][1], EntranceInfo[e][EntranceLoc][2]);
			SetPlayerVirtualWorld(playerid, EntranceInfo[e][EntranceLocInID]);
			SetPlayerInterior(playerid, EntranceInfo[e][EntranceLocWorld]);

			return 1;
		}
	}
	return 1;
}

alias:stopanimation("sa", "stopanim")
CMD:stopanimation(playerid, params[])
{
	if(PlayerInfo[playerid][pHandcuffed])
	{
		ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
    	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);
		return 1;
	}

	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	return 1;
}


CMD:lock(playerid,params[])
{
	/*if(!PlayerInfo[playerid][pInsideProperty] || !PlayerInfo[playerid][pInsideBusiness] || !IsPlayerNearBusiness(playerid) || !IsPlayerNearHouse(playerid))
		return SendErrorMessage(playerid,"�س������������/� ��ҹ/�Ԩ���");*/
	
	if(PlayerInfo[playerid][pInsideProperty])
	{
		new id = PlayerInfo[playerid][pInsideProperty];

		if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid,"�س�������Ңͧ��ҹ��ѧ���");

		
		if(HouseInfo[id][HouseLock])
		{
			GameTextForPlayer(playerid, "~w~DOOR ~g~UNLOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			HouseInfo[id][HouseLock] = false;
		}
		else
		{
			GameTextForPlayer(playerid, "~w~DOOR ~r~LOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			HouseInfo[id][HouseLock] = true;
		}
		return 1;
	}
	else if(IsPlayerNearHouse(playerid) != 0)
	{
		new id = IsPlayerNearHouse(playerid);

		if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID] || PlayerInfo[playerid][pAdminDuty])
			return SendErrorMessage(playerid,"�س�������Ңͧ��ҹ��ѧ���");

		if(HouseInfo[id][HouseLock])
		{
			GameTextForPlayer(playerid, "~w~DOOR ~g~UNLOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			HouseInfo[id][HouseLock] = false;
		}
		else
		{
			GameTextForPlayer(playerid, "~w~DOOR ~r~LOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			HouseInfo[id][HouseLock] = true;
		}
		return 1;
	}
	else if(PlayerInfo[playerid][pInsideBusiness])
	{
		new id = PlayerInfo[playerid][pInsideBusiness];

		if(BusinessInfo[id][BusinessOwnerDBID] !=  PlayerInfo[playerid][pDBID] || PlayerInfo[playerid][pAdminDuty])
			return SendErrorMessage(playerid,"�س�������Ңͧ�Ԩ��ù��");

		if(BusinessInfo[id][BusinessLock] == true)
		{
			GameTextForPlayer(playerid, "~w~DOOR ~g~UNLOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			BusinessInfo[id][BusinessLock] = false;
		}
		else
		{
			GameTextForPlayer(playerid, "~w~DOOR ~r~LOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			BusinessInfo[id][BusinessLock] = true;
		}

		return 1;
	}
	else if(IsPlayerNearBusiness(playerid) != 0)
	{
		new id = IsPlayerNearBusiness(playerid);

		if(BusinessInfo[id][BusinessOwnerDBID] !=  PlayerInfo[playerid][pDBID] && !PlayerInfo[playerid][pAdminDuty])
			return SendErrorMessage(playerid,"�س�������Ңͧ�Ԩ��ù��");

		if(BusinessInfo[id][BusinessLock] == true)
		{
			GameTextForPlayer(playerid, "~w~DOOR ~g~UNLOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			BusinessInfo[id][BusinessLock] = false;
		}
		else
		{
			GameTextForPlayer(playerid, "~w~DOOR ~r~LOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			BusinessInfo[id][BusinessLock] = true;
		}
		return 1;

	}
	else
	{
		new bool:foundCar = false, vehicleid, Float:fetchPos[3];
		
		for (new i = 0; i < MAX_VEHICLES; i++)
		{
			GetVehiclePos(i, fetchPos[0], fetchPos[1], fetchPos[2]);
			if(IsPlayerInRangeOfPoint(playerid, 4.0, fetchPos[0], fetchPos[1], fetchPos[2]))
			{
				foundCar = true;
				vehicleid = i; 
				break; 
			}
		}
		if(foundCar == true)
		{
			if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID] && PlayerInfo[playerid][pDuplicateKey] != vehicleid)
				return SendErrorMessage(playerid, "�س����աح�����Ѻö�ѹ���"); 
				
			new statusString[90]; 
			new engine, lights, alarm, doors, bonnet, boot, objective; 
	
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
			if(VehicleInfo[vehicleid][eVehicleLocked])
			{
				format(statusString, sizeof(statusString), "~g~%s UNLOCKED", ReturnVehicleName(vehicleid));
			
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, false, bonnet, boot, objective);
				VehicleInfo[vehicleid][eVehicleLocked] = false;
			}
			else 
			{
				format(statusString, sizeof(statusString), "~r~%s LOCKED", ReturnVehicleName(vehicleid));
				
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, true, bonnet, boot, objective);
				VehicleInfo[vehicleid][eVehicleLocked] = true;
			}
			GameTextForPlayer(playerid, statusString, 3000, 3);
		}
		else SendErrorMessage(playerid,"�س�������������е� ��ҹ/�Ԩ���/�ҹ��˹�");
	}
	return 1;
}


CMD:check(playerid,params[])
{
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) == INVALID_VEHICLE_ID && !PlayerInfo[playerid][pInsideProperty])
		return SendErrorMessage(playerid, "�س���������ö�����觹����㹢�й��");

	new
		Float: x,
		Float: y,
		Float: z,
		principal_str[256]
	;

	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
	{
		GetVehicleBoot(GetNearestVehicle(playerid), x, y, z);

		new 
			vehicleid = GetNearestVehicle(playerid)
		;

		if(!VehicleInfo[vehicleid][eVehicleDBID] && !VehicleInfo[vehicleid][eVehicleAdminSpawn])
			return SendServerMessage(playerid, "ö�ѹ�����ö��ǹ�ؤ���������ö������ /check ��");

		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "�س������������ç����ö");

		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

		if(!bonnet)
			return SendClientMessage(playerid, COLOR_YELLOWEX, "����ç����ö�ѧ�����١�Դ");
		
		for(new i = 1; i < 6; i++)
		{
			if(VehicleInfo[vehicleid][eVehicleWeapons][i])
				format(principal_str, sizeof(principal_str), "%s%i. %s[����ع: %i]\n", principal_str, i, ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][i]), VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i]);
				
			else
				format(principal_str, sizeof(principal_str), "%s%i. [��ҧ����]\n", principal_str, i);
		}
		Dialog_Show(playerid, DIALOG_VEHICLE_WEAPONS, DIALOG_STYLE_LIST, "Trunk:", principal_str, "��ŧ", "<<");
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		new
			vehicleid = GetPlayerVehicleID(playerid)
		;

		if(!VehicleInfo[vehicleid][eVehicleDBID] && !VehicleInfo[vehicleid][eVehicleAdminSpawn])
			return SendServerMessage(playerid, "ö�ѹ�����ö��ǹ�ؤ���������ö�����觹����");	

		if(VehicleInfo[vehicleid][eVehicleFaction] && PlayerInfo[playerid][pFaction] != VehicleInfo[vehicleid][eVehicleFaction])
			return SendClientMessage(playerid, COLOR_YELLOW, "ö�ѹ�����ö�ͧ࿤����������ö�����觹����");
		
		for(new i = 1; i < 6; i++)
		{
			if(VehicleInfo[vehicleid][eVehicleWeapons][i])
				format(principal_str, sizeof(principal_str), "%s%i. %s[����ع: %i]\n", principal_str, i, ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][i]), VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i]);
				
			else
				format(principal_str, sizeof(principal_str), "%s%i. [��ҧ����]\n", principal_str, i);
		}
			 
		Dialog_Show(playerid, DIALOG_VEHICLE_WEAPONS, DIALOG_STYLE_LIST, "Trunk:", principal_str, "��ŧ", "<<");
	}
	else if(PlayerInfo[playerid][pInsideProperty])
	{
		new
			id = PlayerInfo[playerid][pInsideProperty],
			longstr[600]
		;
		
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[id][HousePlacePos][0], HouseInfo[id][HousePlacePos][1], HouseInfo[id][HousePlacePos][2]))
			return SendErrorMessage(playerid, "�س������������ش���૿");
			
		for(new i = 1; i < 22; i++)
		{
			if(!HouseInfo[id][HouseWeapons][i])
				format(longstr, sizeof(longstr), "%s%d. [��ҧ����]\n", longstr, i);
				
			else format(longstr, sizeof(longstr), "%s%d. %s[����ع: %d]\n", longstr, i, ReturnWeaponName(HouseInfo[id][HouseWeapons][i]), HouseInfo[id][HouseWeaponsAmmo][i]); 
		}
		
		Dialog_Show(playerid, DIALOG_HOUSE_WEAPONS, DIALOG_STYLE_LIST, "Weapons:", longstr, "��ŧ", "¡��ԡ");		
	}
	return 1;
}

CMD:place(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) == INVALID_VEHICLE_ID && !PlayerInfo[playerid][pInsideProperty])
		return SendErrorMessage(playerid, "�س������ö�����觹����㹢�й��");

	new
		Float: x,
		Float: y,
		Float: z,
		str[128],
		weaponid,
		idx
	;

	if(sscanf(params, "i", weaponid))
		return SendUsageMessage(playerid, "/place [�ʹ����ظ]");
		
	if(!PlayerHasWeapon(playerid, weaponid))
		return SendErrorMessage(playerid, "�س��������ظ�ѧ�����");

	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
	{
		GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
		
		new 
			vehicleid = GetNearestVehicle(playerid)
		;
		
		if(VehicleInfo[vehicleid][eVehicleFaction])
			return SendClientMessage(playerid, COLOR_YELLOW, "ö�ѹ�����ö�ͧ࿤����������ö�����觹����");
		
		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "�س������������ҡ���ç����ö");
 
		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		
		if(!bonnet)
			return SendClientMessage(playerid, COLOR_YELLOWEX, "�س������Դ�ҡ���ç����ö"); 
			
		for(new i = 1; i < 6; i++)
		{
			if(!VehicleInfo[vehicleid][eVehicleWeapons][i])
			{
				idx = i;
				break;
			}
		}
		
		VehicleInfo[vehicleid][eVehicleWeapons][idx] = weaponid; 
		VehicleInfo[vehicleid][eVehicleWeaponsAmmo][idx] = PlayerInfo[playerid][pWeaponsAmmo][ReturnWeaponIDSlot(weaponid)];

		PlayerInfo[playerid][pWeaponsAmmo][ReturnWeaponIDSlot(weaponid)] = 0;
		PlayerInfo[playerid][pWeapons][ReturnWeaponIDSlot(weaponid)] = 0;
		
		RemovePlayerWeapon(playerid, weaponid);
		
		format(str, sizeof(str), "* %s ���ҧ %s ŧ��ö %s.", ReturnName(playerid, 0), ReturnWeaponName(weaponid), ReturnVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000);
		SaveVehicle(vehicleid); 
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		new 
			vehicleid = GetPlayerVehicleID(playerid)
		;
		
		if(VehicleInfo[vehicleid][eVehicleFaction])
			return SendClientMessage(playerid, COLOR_YELLOW, "ö�ѹ�����ö�ͧ࿤����������ö�����觹����");
			
		for(new i = 1; i < 6; i++)
		{
			if(!VehicleInfo[vehicleid][eVehicleWeapons][i])
			{
				idx = i;
				break;
			}
		}
		
		VehicleInfo[vehicleid][eVehicleWeapons][idx] = weaponid; 
		VehicleInfo[vehicleid][eVehicleWeaponsAmmo][idx] = PlayerInfo[playerid][pWeaponsAmmo][ReturnWeaponIDSlot(weaponid)];

		PlayerInfo[playerid][pWeaponsAmmo][ReturnWeaponIDSlot(weaponid)] = 0;
		PlayerInfo[playerid][pWeapons][ReturnWeaponIDSlot(weaponid)] = 0;
		
		RemovePlayerWeapon(playerid, weaponid);
		
		format(str, sizeof(str), "* %s ���ҧ %s ŧ��ö %s.", ReturnName(playerid, 0), ReturnWeaponName(weaponid), ReturnVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000); 
		SendClientMessage(playerid, COLOR_EMOTE, str);
		SaveVehicle(vehicleid); 
	}
	else if(IsPlayerInHouse(playerid) != 0)
	{
		new
			id = IsPlayerInHouse(playerid),
			pid
		;

		if(!IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[id][HousePlacePos][0], HouseInfo[id][HousePlacePos][1], HouseInfo[id][HousePlacePos][2]))
			return SendErrorMessage(playerid, "�س������������ش���૿");

		for(new i = 1; i < 22; i++)
		{
			if(!HouseInfo[id][HouseWeapons][i])
			{
				pid = i;
				break;
			}
		}

		HouseInfo[id][HouseWeapons][pid] = weaponid;
		HouseInfo[id][HouseWeaponsAmmo][pid] = PlayerInfo[playerid][pWeaponsAmmo][ReturnWeaponIDSlot(weaponid)];

		PlayerInfo[playerid][pWeaponsAmmo][ReturnWeaponIDSlot(weaponid)] = 0;
		PlayerInfo[playerid][pWeapons][ReturnWeaponIDSlot(weaponid)] = 0;

		RemovePlayerWeapon(playerid, weaponid);

		format(str, sizeof(str), "* %s ���ҧ %s ���㹵��૿", ReturnName(playerid, 0), ReturnWeaponName(weaponid));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000); 
		SendClientMessage(playerid, COLOR_EMOTE, str);
		CharacterSave(playerid); Savehouse(id);
	}
	return 1;
}

CMD:myweapon(playerid, params[])
{
	new longstr[MAX_STRING];

	for(new i = 0; i < 13; i++)
	{
			if(!PlayerInfo[playerid][pWeapons][i])
				format(longstr, sizeof(longstr), "%s%d. [��ҧ����]\n", longstr, i);
				
			else format(longstr, sizeof(longstr), "%s%d. %s[����ع: %d]\n", longstr, i, ReturnWeaponName(PlayerInfo[playerid][pWeapons][i]), PlayerInfo[playerid][pWeaponsAmmo][i]); 
	}
	Dialog_Show(playerid, DIALOG_MYEAPON, DIALOG_STYLE_LIST, "Weapons:", longstr, "��ŧ", "¡��ԡ");
	return 1;
}

CMD:damages(playerid, params[])
{
	new playerb;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/damages [���ͺҧ��ǹ/�ʹ�]");
		
	if(!IsPlayerConnected(playerb))	
		return SendErrorMessage(playerid, "�����������ӡ��������������׿�����");
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");
		
	if(PlayerInfo[playerid][pAdminDuty])
	{
		ShowPlayerDamages(playerb, playerid, 1); 
	}
	else
	{
		if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
			return SendErrorMessage(playerid, "�س�����������������");
			
		ShowPlayerDamages(playerb, playerid, 0); 
	}
	return 1;
}

CMD:acceptdeath(playerid, params[])
{
	if(GetPlayerTeam(playerid) != PLAYER_STATE_WOUNDED)
		return SendErrorMessage(playerid, "�س�ѧ������Ѻ�Ҵ��");
		
	CallLocalFunction("OnPlayerDead", "iii", playerid, INVALID_PLAYER_ID, -1, 0); 
	return 1;
}

CMD:respawnme(playerid, params[])
{
	
	if(GetPlayerTeam(playerid) != PLAYER_STATE_WOUNDED)
		return SendErrorMessage(playerid, "�س�ѧ������Ѻ�Ҵ��");

	if(gettime() - PlayerInfo[playerid][pRespawnTime] < 60)
		return SendErrorMessage(playerid, "�س�ѧ�������ö�Դ���ô���ա %d",gettime() - PlayerInfo[playerid][pRespawnTime]);

	PlayerInfo[playerid][pRespawnTime] = 0;
	SetPlayerChatBubble(playerid, "Respawned", COLOR_WHITE, 20.0, 1500);
	SetPlayerTeam(playerid, PLAYER_STATE_ALIVE); 
			
	TogglePlayerControllable(playerid, 1);
	SetPlayerHealth(playerid, 100);
	ClearDamages(playerid);
	SpawnPlayer(playerid);	
	return 1;
}

CMD:stats(playerid, params[])
{
	new playerb;
	
	if(PlayerInfo[playerid][pAdmin])
	{
		if (sscanf(params, "I(-1)", playerb))
			return 1; 
			
		if(playerb == -1)
		{
			return ShowCharacterStats(playerid, playerid);
		}
		else
		{
			if(!IsPlayerConnected(playerb))
				return SendErrorMessage(playerid, "�����������ӡ��������������׿�����");
				
			if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
				return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
				
			ShowCharacterStats(playerb, playerid); 
		}
	}
	else return ShowCharacterStats(playerid, playerid);
	return 1;
}

CMD:pc(playerid, params[])
{
	return SelectTextDraw(playerid, COLOR_GRAD1);
}

CMD:admins(playerid, params[])
{
	new bool:adminOn = false;
	
	foreach (new i : Player)
	{
		if (PlayerInfo[playerid][pAdmin]) adminOn = true;
	}
	
	if(adminOn == true)
	{
		SendClientMessage(playerid, COLOR_GREY, "Admins Online:");
		
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pAdmin] > 1 && PlayerInfo[i][pAdmin] < 5)
			{
				if(PlayerInfo[i][pAdminDuty])
				{
					SendClientMessageEx(playerid, COLOR_DARKGREEN, "(Level: %d) %s (%s) - On Duty: Yes", PlayerInfo[i][pAdmin], ReturnRealName(i, 0), e_pAccountData[i][mForumName]);
				}
				else SendClientMessageEx(playerid, COLOR_GREY, "(Level: %d) %s (%s) - On Duty: No", PlayerInfo[i][pAdmin], ReturnRealName(i, 0), e_pAccountData[i][mForumName]);
			}
		}
	}
	else
	{
		return SendClientMessage(playerid, COLOR_GREY, "Admins Online:");
	}

	return 1;
}


CMD:testers(playerid, params[])
{
	new bool:TesterOn = false;
	
	foreach (new i : Player)
	{
		if (PlayerInfo[playerid][pTester]) TesterOn = true;
	}
	
	if(TesterOn == true)
	{
		SendClientMessage(playerid, COLOR_GREY, "Tester Online:");
		
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pTester])
			{
				if(PlayerInfo[i][pTesterDuty])
				{
					SendClientMessageEx(playerid, COLOR_DARKGREEN, "(Level: %d) %s (%s) - On Duty: Yes", PlayerInfo[i][pTester], ReturnRealName(i, 0), e_pAccountData[i][mForumName]);
				}
				else SendClientMessageEx(playerid, COLOR_GREY, "(Level: %d) %s (%s) - On Duty: No", PlayerInfo[i][pTester], ReturnRealName(i, 0), e_pAccountData[i][mForumName]);
			}
		}
	}
	else
	{
		return SendClientMessage(playerid, COLOR_GREY, "Tester Online:");
	}
	return 1;
}

alias:ooc("o")
CMD:ooc(playerid, params[])
{
	if(isnull(params))
		return SendUsageMessage(playerid, "/(o)oc [text]"); 
		
	if(!oocEnabled && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "OOC �١�Դ�����ҹ����ҹ��"); 
		
	if(PlayerInfo[playerid][pAdminDuty])
		SendClientMessageToAllEx(COLOR_SAMP, "{adc3e7}[OOC] {FB8C00}%s{adc3e7}: %s", ReturnRealName(playerid, 0), params); 
		
	else SendClientMessageToAllEx(COLOR_SAMP, "{adc3e7}[OOC] %s: %s", ReturnRealName(playerid, 0), params);
	return 1;
}

CMD:pay(playerid, params[])
{
	new playerb, amount, emote[90], str[128]; 

	if(sscanf(params, "uiS('None')[90]", playerb, amount, emote))
		return SendUsageMessage(playerid, "/pay [���ͺҧ��ǹ/�ʹ�] [�ӹǹ] [��á�з� (�����)]");

	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "��������������������׿�����");

	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 

	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "������������������س");

	if(amount > PlayerInfo[playerid][pCash])
		return SendErrorMessage(playerid, "�س������Թ�ͷ������");

	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0); PlayerPlaySound(playerb, 1052, 0.0, 0.0, 0.0);

	SendClientMessageEx(playerid, COLOR_GREY, " �س��ӡ�è����Թ��� %s �ӹǹ $%s.", ReturnRealName(playerb, 0), MoneyFormat(amount)); 
	SendClientMessageEx(playerb, COLOR_GREY, " �س���Ѻ�Թ �ӹǹ $%s �ҡ %s", MoneyFormat(amount), ReturnRealName(playerid, 0));

	if(!strcmp(emote, "None"))
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s ���ѡ�Թ�ҧ��ǹ�͡�Ҩҡ����������ͺ���Ѻ %s", ReturnName(playerid, 0), ReturnName(playerb, 0)); 

	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s %s %s", ReturnName(playerid, 0), emote, ReturnName(playerb, 0));

	if(PlayerInfo[playerid][pLevel] <= 3 && PlayerInfo[playerb][pLevel] <= 3 || amount >= 50000)
	{
		format(str, sizeof(str), "%s ������Թ �ӹǹ $%s ���Ѻ %s �������͹���繡�üԴ�����������ô��Ǩ�ͺ����", ReturnName(playerid), MoneyFormat(amount), ReturnName(playerb)); 
		SendAdminMessage(1, str);
	}
	
	GiveMoney(playerid, -amount); GiveMoney(playerb, amount);
	return 1;
}

CMD:setchannel(playerid, params[])
{
	new 
		slot, 
		channel
	;

	if(!PlayerInfo[playerid][pHasRadio])
		return SendErrorMessage(playerid, "�س����� �Է��"); 
	
	if(sscanf(params, "ii", channel, slot))
		return SendUsageMessage(playerid, "/setchannel [�����] [��͵]"); 
		
	if(slot > 10 || slot < 1)
		return SendErrorMessage(playerid, "��͵������ö��Ѻ����§�� (1-10)");
		
	if(channel < 1 || channel > 1000000)
		return SendErrorMessage(playerid, "�س�������ö��Ѻ�����Թ (1-1000000)"); 
	
	if(channel == 911)
	{
		if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
			return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س�������ö��駤�� �����Է�ع�������ͧ�ҡ�س�����˹��§ҹ�Ѱ���"); 
	}
	
	PlayerInfo[playerid][pRadio][slot] = channel;
	PlayerInfo[playerid][pMainSlot] = slot;
	SendClientMessageEx(playerid, COLOR_RADIOEX, "�س���Ѻ�Է��价����� %i ����� ���͵ %i.", channel, slot);
	CharacterSave(playerid); 
	return 1;
}


alias:radio("r")
CMD:radio(playerid, params[])
{
	if(!PlayerInfo[playerid][pHasRadio])
		return SendErrorMessage(playerid, "�س������Է��");

	new
		local,
		channel
	;
		
	local = PlayerInfo[playerid][pMainSlot]; 
	channel = PlayerInfo[playerid][pRadio][local]; 
	
	if(!PlayerInfo[playerid][pRadio][local])
		return SendErrorMessage(playerid, "�س�ѧ������� ���͵"); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/r(adio) [��ͤ���]");
		
	foreach(new i : Player)
	{
		for(new r = 1; r < 3; r ++)
		{
			if(PlayerInfo[i][pRadio][r] == channel)
			{
				if(r != PlayerInfo[i][pMainSlot])
					SendClientMessageEx(i, COLOR_RADIOEX, "**[CH: %d, S: %d] %s �ٴ���: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
					
				else SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s �ٴ���: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
			}
		}
	}
	
	new str[120];
	format(str, sizeof(str),"(�Է��) %s �ٴ���: %s", ReturnName(playerid, 0), params);
	SetPlayerChatBubble(playerid, str, COLOR_GRAD1, 10.0, 6000);

	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 10.0, posx,posy,posz))
		{
			SendClientMessageEx(i, COLOR_GRAD1, "(�Է��) %s �ٴ���: %s", ReturnName(playerid, 0), params);
		}
	}
	return 1;
}

CMD:rlow(playerid, params[])
{
	if(!PlayerInfo[playerid][pHasRadio])
		return SendErrorMessage(playerid, "�س������Է��");

	new
		local,
		channel
	;
		
	local = PlayerInfo[playerid][pMainSlot]; 
	channel = PlayerInfo[playerid][pRadio][local]; 
	
	if(!PlayerInfo[playerid][pRadio][local])
		return SendErrorMessage(playerid, "�س�ѧ����������͵"); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/rlow [��ͤ���]");
		
	foreach(new i : Player)
	{
		for(new r = 1; r < 3; r ++)
		{
			if(PlayerInfo[i][pRadio][r] == channel)
			{
				if(r != PlayerInfo[i][pMainSlot])
					SendClientMessageEx(i, COLOR_RADIOEX, "**[CH: %d, S: %d] %s �ٴ���: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
					
				else SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s �ٴ���: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
			}
		}
	}

	new str[120];
	format(str, sizeof(str),"(�Է��) %s �ٴ���: %s", ReturnName(playerid, 0), params);
	SetPlayerChatBubble(playerid, str, COLOR_GRAD1, 5.0, 6000);
	
	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 5.0, posx,posy,posz))
		{
			SendClientMessageEx(i, COLOR_GRAD1, "(�Է��) %s �ٴ���[��]: %s", ReturnName(playerid, 0), params);
		}
	}
	return 1;
}

CMD:setspawn(playerid, params[])
{
	new 
		id;

	if(sscanf(params, "i", id))
	{
		SendUsageMessage(playerid, "/setspawn [spawn id]");
		SendClientMessage(playerid, COLOR_WHITE, "1. ʹ���Թ, 2. ��ҹ, 3. ࿤���");
		return 1;
	}

	if(id > 3 || id < 1)
		return SendErrorMessage(playerid, "����ʻ�� ����§ (1-3)");

	switch(id)
	{
		case 1:
		{
			if(PlayerInfo[playerid][pSpawnPoint] == 0)
				return SendErrorMessage(playerid, "�س��ӡ���絨ش�Դ�ͧ�س�� ʹ���Թ��������");

			PlayerInfo[playerid][pSpawnPoint] = SPAWN_AT_DEFAULT; 
			SendServerMessage(playerid, "�س��ӡ���絨ش�Դ�ͧ�س�� ʹ���Թ");
		}
		case 2:
		{
			new id_house = IsPlayerInHouse(playerid);

			if(id_house == 0)
				return SendErrorMessage(playerid, "�س���������㹺�ҹ");

			if(HouseInfo[id_house][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
				return SendErrorMessage(playerid, "�س�������Ңͧ��ҹ");

			PlayerInfo[playerid][pSpawnPoint] = SPAWN_AT_HOUSE;
			PlayerInfo[playerid][pSpawnHouse] = id_house;
			SendServerMessage(playerid, "�س��ӡ���絨ش�Դ�ͧ�س�� ��ҹ");
		}
		case 3:
		{
			new id_fac = PlayerInfo[playerid][pFaction];

			if(id_fac == 0)
				return SendErrorMessage(playerid, "�س�����࿤���");
			
			if(!FactionInfo[id_fac][eFactionSpawn][0] || !FactionInfo[id_fac][eFactionSpawn][1] || !FactionInfo[id_fac][eFactionSpawn][2])
				return SendErrorMessage(playerid, "࿤��蹢ͧ�س�ѧ����ա���絨ش�Դ");

			PlayerInfo[playerid][pSpawnPoint] = SPAWN_AT_FACTION;
			SendServerMessage(playerid, "�س��ӡ���絨ش�Դ�ͧ�س�� ࿤���");
		}
	}
	return 1;
}


alias:leavegun("lg")
CMD:leavegun(playerid, params[])
{
	new 
		weaponid, 
		idx,
		id, 
		Float:x,
		Float:y,
		Float:z
	;
	
	if(sscanf(params, "i", weaponid))
	{
		SendUsageMessage(playerid, "/leavegun [�ʹ����ظ]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF}�س����ö��Ժ�׹������¡�þ���� /grabgun."); 
		return 1;
	}
	
	if(weaponid < 1 || weaponid > 46 || weaponid == 35 || weaponid == 36 || weaponid == 37 || weaponid == 38 || weaponid == 39)
	    return SendErrorMessage(playerid, "���ظ����ҹ��١�Ѵ�����ظ��ͧ���������׿�����");
		
	if(!PlayerHasWeapon(playerid, weaponid))
		return SendErrorMessage(playerid, "�س����������ظ��Դ�ѧ�����"); 
		
	for(new i = 0; i < sizeof(WeaponDropInfo); i++)
	{
		if(!WeaponDropInfo[i][eWeaponDropped])
		{
			idx = i;
			break;
		}
	}
	
	id = ReturnWeaponIDSlot(weaponid); 
	GetPlayerPos(playerid, x, y, z); 
	
	WeaponDropInfo[idx][eWeaponDropped] = true;
	WeaponDropInfo[idx][eWeaponDroppedBy] = PlayerInfo[playerid][pDBID]; 
	
	WeaponDropInfo[idx][eWeaponWepID] = weaponid;
	WeaponDropInfo[idx][eWeaponWepAmmo] = PlayerInfo[playerid][pWeaponsAmmo][id];
	
	WeaponDropInfo[idx][eWeaponPos][0] = x;
	WeaponDropInfo[idx][eWeaponPos][1] = y;
	WeaponDropInfo[idx][eWeaponPos][2] = z;
	
	WeaponDropInfo[idx][eWeaponInterior] = GetPlayerInterior(playerid);
	WeaponDropInfo[idx][eWeaponWorld] = GetPlayerVirtualWorld(playerid); 
	
	RemovePlayerWeapon(playerid, weaponid);
	PlayerInfo[playerid][pWeapons][id] = 0;
	PlayerInfo[playerid][pWeaponsAmmo][id] = 0; 
	
	WeaponDropInfo[idx][eWeaponObject] = CreateDynamicObject(
		ReturnWeaponsModel(weaponid),
		x,
		y,
		z - 1,
		80.0,
		0.0,
		0.0,
		GetPlayerVirtualWorld(playerid),
		GetPlayerInterior(playerid)); 
		
	WeaponDropInfo[idx][eWeaponTimer] = SetTimerEx("OnPlayerLeaveWeapon", 600000, false, "i", idx); 
	SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} ���ظ�ͧ�س���ѧ�����躹�����֧ 10 �ҷա�͹�ж١ź�͡�ҡ�׿�����");
	return 1;
}

alias:grabgun("gg")
CMD:grabgun(playerid, params[])
{	
	new
		bool:foundWeapon = false,
		id,
		str[128]
	;

	for(new i = 0; i < sizeof(WeaponDropInfo); i++)
	{
		if(!WeaponDropInfo[i][eWeaponDropped])
			continue; 
	
		if(IsPlayerInRangeOfPoint(playerid, 3.0, WeaponDropInfo[i][eWeaponPos][0], WeaponDropInfo[i][eWeaponPos][1], WeaponDropInfo[i][eWeaponPos][2]))
		{
			if(GetPlayerVirtualWorld(playerid) == WeaponDropInfo[i][eWeaponWorld])
			{
				foundWeapon = true;
				id = i;
			}							
		}
	}
	
	if(foundWeapon)
	{
		GivePlayerGun(playerid, WeaponDropInfo[id][eWeaponWepID], WeaponDropInfo[id][eWeaponWepAmmo]);
		
		format(str, sizeof(str), "* %s ��Ժ %s ����Ҩҡ���", ReturnName(playerid, 0), ReturnWeaponName(WeaponDropInfo[id][eWeaponWepID]));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 3000);
		SendClientMessage(playerid, COLOR_EMOTE, str);
		
		WeaponDropInfo[id][eWeaponDropped] = false; 
		WeaponDropInfo[id][eWeaponDroppedBy] = 0;
		
		WeaponDropInfo[id][eWeaponWepID] = 0; WeaponDropInfo[id][eWeaponWepAmmo] = 0; 
		
		KillTimer(WeaponDropInfo[id][eWeaponTimer]); 
		DestroyDynamicObject(WeaponDropInfo[id][eWeaponObject]); 
	}
	else return SendServerMessage(playerid, "��������ظ������������㹺���ǳù��");
	return 1;
}

CMD:levelup(playerid, params[])
{
	new
		exp_count,
		str[128]
	;
	
	exp_count = ((PlayerInfo[playerid][pLevel]) * 4 + 2); 
	
	if(PlayerInfo[playerid][pExp] < exp_count)
	{
		SendServerMessage(playerid, "�س�ѧ�� ��һ��ʺ��ó�����ҡ�� ���繵�ͧ�դ�һ��ʺ��ó� %i �֧������ö�ѻ�ô��", exp_count); 
		return 1; 
	}
	
	PlayerInfo[playerid][pLevel]++; 
	PlayerInfo[playerid][pExp] = 0; 
	
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]); 
	
	format(str, sizeof(str), "~g~Leveled Up~n~~w~You leveled up to level %i", PlayerInfo[playerid][pLevel]);
	GameTextForPlayer(playerid, str, 5000, 1);

	CharacterSave(playerid); 
	return 1;
}

CMD:license(playerid, params[])
{
	new playerb;
		
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/license [���ͺҧ��ǹ/�ʹ�]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "��������������������׿�����");
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");
		
	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "������������������س"); 
		
	if(playerb != playerid)
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s ��Ժ�ѵû�Шӵ�Ǻѵû�ЪҪ���������� %s", ReturnName(playerid, 0), ReturnName(playerb, 0));
		
	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s ��Ժ�ѵû�Шӵ�Ǻѵû�ЪҪ�����Ҵ�", ReturnName(playerid, 0));
	
	ReturnLicenses(playerid, playerb); 	
	return 1;
}

CMD:time(playerid, params[])
{
	new str[20];
	format(str, sizeof(str), "�ٹ��ԡ�");
	callcmd::ame(playerid, str);
	
	new string[128], hour, minute, seconds;
	
	gettime(hour, minute, seconds);
	
	if(PlayerInfo[playerid][pAdminjailed] == true)
		format(string, sizeof(string), "~g~|~w~%02d:%02d~g~|~n~~w~Jail Time left: %d SEC", hour, minute, PlayerInfo[playerid][pAdminjailTime]);

	else if(PlayerInfo[playerid][pArrest] == true)
		format(string, sizeof(string), "~g~|~w~%02d:%02d~g~|~n~~w~Arrest Time left: %d SEC", hour, minute, PlayerInfo[playerid][pArrestTime]);
	else
		format(string, sizeof(string), "~g~|~w~%02d:%02d~g~|", hour, minute);


		
		
	GameTextForPlayer(playerid, string, 2000, 1);
	
	return 1;
}

CMD:rcp(playerid, params[])
{
	DisablePlayerCheckpoint(playerid);
	
	//Disabling checkpoint referring variables:
	PlayerCheckpoint[playerid] = 0;
	return 1;
}

CMD:b(playerid, params[])
{
	if (isnull(params))
		return SendUsageMessage(playerid, "/b [��ͤ���]"); 
	
	if(PlayerInfo[playerid][pAdminDuty] == true)
	{
		if(strlen(params) > 84)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {FF9900}%s{AFAFAF}: %.84s ))", playerid, ReturnName(playerid), params);
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {FF9900}%s{AFAFAF}: ...%s ))", playerid, ReturnName(playerid), params[84]);
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {FF9900}%s{AFAFAF}: %s ))", playerid, ReturnName(playerid), params);
	}
	else
	{
		if(strlen(params) > 84)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] %s: %.84s ))", playerid, ReturnName(playerid), params);
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] %s: ...%s ))", playerid, ReturnName(playerid), params[84]); 
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] %s: %s ))", playerid, ReturnName(playerid), params);
	}	
	return 1;
}

CMD:pm(playerid, params[])
{
	new
		playerb,
		text[144]
	;
		
	if(sscanf(params, "us[144]", playerb, text))
		return SendUsageMessage(playerid, "/pm [���ͺҧ��ǹ/�ʹ�] [text]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����");
		
	if(PlayerInfo[playerid][pAdminDuty])
	{
		SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM �ҡ {FF9900}%s{FFDC18} (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
		
		if(!PlayerInfo[playerb][pAdminDuty])
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ����ѧ %s (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
			
		else SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ����ѧ {FF9900}%s{EEE854} (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
	}
	else
	{
		if(PlayerInfo[playerb][pAdminDuty])
		{
			SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM �ҡ %s (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ����ѧ {FF9900}%s{EEE854} (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
		}
		else
		{
			SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM �ҡ %s (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ����ѧ %s (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
		}
	}
	return 1;
}

CMD:fines(playerid, params[])
{
	new str[255], fineid, longstr[255];

	format(str, sizeof(str), "���˵�:\t��һ�Ѻ:\t �ѹ���:\n");
	strcat(longstr, str);

	for(new i = 1; i < MAX_FINES; i++)
	{
		if(!FineInfo[i][FineDBID])
			continue;

		if(FineInfo[i][FineOwner] != PlayerInfo[playerid][pDBID])
			continue;

		format(str, sizeof(str), "%s\t$%s\t%s\n", FineInfo[i][FineReson], MoneyFormat(FineInfo[i][FinePrice]), FineInfo[i][FineDate]);
		strcat(longstr, str);

		format(str, sizeof(str), "%d",fineid);
		SetPVarInt(playerid, str, i);
		fineid++;
	}

	if(!fineid)
	{
		Dialog_Show(playerid, DIALOG_FINES_LIST_NONE, DIALOG_STYLE_LIST, "����", "�س���������...", "�׹�ѹ", "¡��ԡ");
		return 1;
	}

	Dialog_Show(playerid, DIALOG_FINES_LIST, DIALOG_STYLE_TABLIST_HEADERS, "����", longstr, "�׹�ѹ", "¡��ԡ");
	return 1;
}
