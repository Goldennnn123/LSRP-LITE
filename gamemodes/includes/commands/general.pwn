

CMD:help(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "______________________________________________");
	
	SendClientMessage(playerid, COLOR_GRAD2,"[CHAT] (/s)hout (/l)ocal /me /ame /do /low");
	SendClientMessage(playerid, COLOR_GRAD1,"[HELP] /jobhelp /fishhelp");
	SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
    SendClientMessage(playerid, COLOR_GRAD1,"โปรดศึกษาคำสั่งในเซิร์ฟเวอร์เพิ่มเติมในฟอรั่มหรือ /helpme เพื่อขอความช่วยเหลือ");
	return 1; 
}

CMD:jobhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
	SendClientMessage(playerid, COLOR_GRAD3,"อาชีพในปัจจุบันของคุณ:");
	SendClientMessageEx(playerid,COLOR_GRAD3,"%s", GetJobName(PlayerInfo[playerid][pCareer], PlayerInfo[playerid][pJob]));

	if(PlayerInfo[playerid][pSideJob]) {
		SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
		SendClientMessage(playerid, COLOR_GRAD3,"อาชีพเสริม:");
		SendClientMessageEx(playerid,COLOR_GRAD3,"%s", GetJobName(PlayerInfo[playerid][pCareer], PlayerInfo[playerid][pSideJob]));
	}

	// อาชีพเสริม
	

	// อาชีพหลัก
	if(PlayerInfo[playerid][pJob] == JOB_FARMER) {
	    SendClientMessage(playerid,COLOR_LIGHTRED,"คำสั่งของชาวไร่:");
		SendClientMessage(playerid,COLOR_WHITE,"/harvest");
		SendClientMessage(playerid,COLOR_WHITE,"/stopharvest");
	}


	return 1;
}

CMD:time(playerid, params[])
{
	//cmd_ame(playerid, "ดูนาฬิกา");
	
	new string[128], hour, minute, seconds;

	gettime(hour, minute, seconds);

	if(PlayerInfo[playerid][pAdminjailed] == true)
		format(string, sizeof(string), "~g~|~w~%02d:%02d~g~|~n~~w~Jail Time left: %d SEC", hour, minute, PlayerInfo[playerid][pAdminjailTime]);
		
	/*if(PlayerInfo[playerid][pArrest] > 0)
		format(string, sizeof(string), "~g~|~w~%02d:%02d~g~|~n~~w~Jail Time left: %d SEC", hour, minute, PlayerInfo[playerid][pArrestjailTime]);*/

	else
		format(string, sizeof(string), "~g~|~w~%02d:%02d~g~|", hour, minute);
		
	GameTextForPlayer(playerid, string, 2000, 1);
	
	return 1;
}

CMD:mask(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] < 3 && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "คุณเลเวลยังไม่พอที่จะสวมใส่ Mask ได้ (เลเวลต้องมากกว่า 3 ขึ้นไป)"); 
		
	if(!PlayerInfo[playerid][pHasMask] /*&& !PlayerInfo[playerid][pAdmin]*/)
		return SendErrorMessage(playerid, "คุณไม่มี Mask"); 
	
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

			GivePlayerMoney(playerid, -BusinessInfo[b][BusinessEntrancePrice]);
			BusinessInfo[b][BusinessCash] += BusinessInfo[b][BusinessEntrancePrice];

			TogglePlayerControllable(playerid, 0);
			SetTimerEx("OnPlayerEnterBusiness", 2000, false, "ii", playerid, b); 
			SendBusinessType(playerid, b);
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
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ประตูทางออก");
		
		SetPlayerPos(playerid, HouseInfo[id][HouseEntrance][0], HouseInfo[id][HouseEntrance][1], HouseInfo[id][HouseEntrance][2]);
		
		SetPlayerVirtualWorld(playerid, HouseInfo[id][HouseEntranceWorld]);
		SetPlayerInterior(playerid, HouseInfo[id][HouseEntranceInterior]);
		PlayerInfo[playerid][pInsideProperty] = 0;
		return 1;
    }
	if(b_id != 0)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[b_id][BusinessInterior][0], BusinessInfo[b_id][BusinessInterior][1], BusinessInfo[b_id][BusinessInterior][2]))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ประตูทางออก");
		
		SetPlayerPos(playerid, BusinessInfo[b_id][BusinessEntrance][0], BusinessInfo[b_id][BusinessEntrance][1], BusinessInfo[b_id][BusinessEntrance][2]);
		SetPlayerVirtualWorld(playerid, BusinessInfo[id][BusinessEntranceWorld]);
		SetPlayerInterior(playerid, BusinessInfo[id][BusinessEntranceInterior]);
		PlayerInfo[playerid][pInsideBusiness] = 0;
		return 1;
	}

	return 1;
}


CMD:lock(playerid,params[])
{
	/*if(!PlayerInfo[playerid][pInsideProperty] || !PlayerInfo[playerid][pInsideBusiness] || !IsPlayerNearBusiness(playerid) || !IsPlayerNearHouse(playerid))
		return SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้/ใน บ้าน/กิจการ");*/
	
	if(PlayerInfo[playerid][pInsideProperty])
	{
		new id = PlayerInfo[playerid][pInsideProperty];

		if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid,"คุณไม่ใช่เจ้าของบ้านหลังนี้");

		
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
			return SendErrorMessage(playerid,"คุณไม่ใช่เจ้าของบ้านหลังนี้");

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
			return SendErrorMessage(playerid,"คุณไม่ใช่เจ้าของกิจการนี้");

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
			return SendErrorMessage(playerid,"คุณไม่ใช่เจ้าของกิจการนี้");

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
				return SendErrorMessage(playerid, "คุณไม่มีกุญแจสำหรับรถคันนี้"); 
				
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
		else SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้ประตู บ้าน/กิจการ/รถ");
	}
	return 1;
}


CMD:check(playerid,params[])
{
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) == INVALID_VEHICLE_ID && !PlayerInfo[playerid][pInsideProperty])
		return SendErrorMessage(playerid, "คุณไม่ได้สามารถใช้คำสั่งนี้ได้ในขณะนี้");

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
			return SendServerMessage(playerid, "รถคันนี้เป็นรถส่วนบุคคนไม่สามารถใช้คำสั่ง /check ได้");

		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่กระโปรงท้ายรถ");

		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

		if(!bonnet)
			return SendClientMessage(playerid, COLOR_YELLOWEX, "กระโปรงท้ายรถยังไม่ได้ถูกเปิด");
		
		for(new i = 1; i < 6; i++)
		{
			if(VehicleInfo[vehicleid][eVehicleWeapons][i])
				format(principal_str, sizeof(principal_str), "%s%i. %s[กระสุน: %i]\n", principal_str, i, ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][i]), VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i]);
				
			else
				format(principal_str, sizeof(principal_str), "%s%i. [ว่างเปล่า]\n", principal_str, i);
		}
		Dialog_Show(playerid, DIALOG_VEHICLE_WEAPONS, DIALOG_STYLE_LIST, "Trunk:", principal_str, "ตกลง", "<<");
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		new
			vehicleid = GetPlayerVehicleID(playerid)
		;

		if(!VehicleInfo[vehicleid][eVehicleDBID] && !VehicleInfo[vehicleid][eVehicleAdminSpawn])
			return SendServerMessage(playerid, "รถคันนี้เป็นรถส่วนบุคคนไม่สามารถใช้คำสั่งนี้ได้");	

		if(VehicleInfo[vehicleid][eVehicleFaction] && PlayerInfo[playerid][pFaction] != VehicleInfo[vehicleid][eVehicleFaction])
			return SendClientMessage(playerid, COLOR_YELLOW, "รถคันนี้เป็นรถของเฟคชั่นไม่สามารถใช้คำสั่งนี้ได้");
		
		for(new i = 1; i < 6; i++)
		{
			if(VehicleInfo[vehicleid][eVehicleWeapons][i])
				format(principal_str, sizeof(principal_str), "%s%i. %s[กระสุน: %i]\n", principal_str, i, ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][i]), VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i]);
				
			else
				format(principal_str, sizeof(principal_str), "%s%i. [ว่างเปล่า]\n", principal_str, i);
		}
			 
		Dialog_Show(playerid, DIALOG_VEHICLE_WEAPONS, DIALOG_STYLE_LIST, "Trunk:", principal_str, "ตกลง", "<<");
	}
	else if(PlayerInfo[playerid][pInsideProperty])
	{
		new
			id = PlayerInfo[playerid][pInsideProperty],
			longstr[600]
		;
		
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[id][HousePlacePos][0], HouseInfo[id][HousePlacePos][1], HouseInfo[id][HousePlacePos][2]))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้จุดตู้เซฟ");
			
		for(new i = 1; i < 22; i++)
		{
			if(!HouseInfo[id][HouseWeapons][i])
				format(longstr, sizeof(longstr), "%s%d. [ว่างเปล่า]\n", longstr, i);
				
			else format(longstr, sizeof(longstr), "%s%d. %s[กระสุน: %d]\n", longstr, i, ReturnWeaponName(HouseInfo[id][HouseWeapons][i]), HouseInfo[id][HouseWeaponsAmmo][i]); 
		}
		
		Dialog_Show(playerid, DIALOG_HOUSE_WEAPONS, DIALOG_STYLE_LIST, "Weapons:", longstr, "ตกลง", "ยกเลิก");		
	}
	return 1;
}

CMD:place(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) == INVALID_VEHICLE_ID && !PlayerInfo[playerid][pInsideProperty])
		return SendErrorMessage(playerid, "คุณไม่สามรถใช้คำสั่งนี้ได้ในขณะนี้");

	new
		Float: x,
		Float: y,
		Float: z,
		str[128],
		weaponid,
		idx
	;

	if(sscanf(params, "i", weaponid))
		return SendUsageMessage(playerid, "/place [ไอดีอาวุธ]");
		
	if(!PlayerHasWeapon(playerid, weaponid))
		return SendErrorMessage(playerid, "คุณไม่มีอาวุธดังกล่าว");

	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
	{
		GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
		
		new 
			vehicleid = GetNearestVehicle(playerid)
		;
		
		if(VehicleInfo[vehicleid][eVehicleFaction])
			return SendClientMessage(playerid, COLOR_YELLOW, "รถคันนี้เป็นรถของเฟคชั่นไม่สามารถใช้คำสั่งนี้ได้");
		
		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ฝากระโปรงท้ายรถ");
 
		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		
		if(!bonnet)
			return SendClientMessage(playerid, COLOR_YELLOWEX, "คุณไม่ได้เปิดฝากระโปรงท้ายรถ"); 
			
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
		
		format(str, sizeof(str), "* %s ได้วาง %s ลงไปในรถ %s.", ReturnName(playerid, 0), ReturnWeaponName(weaponid), ReturnVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000);
		SaveVehicle(vehicleid); 
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		new 
			vehicleid = GetPlayerVehicleID(playerid)
		;
		
		if(VehicleInfo[vehicleid][eVehicleFaction])
			return SendClientMessage(playerid, COLOR_YELLOW, "รถคันนี้เป็นรถของเฟคชั่นไม่สามารถใช้คำสั่งนี้ได้");
			
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
		
		format(str, sizeof(str), "* %s ได้วาง %s ลงไปในรถ %s.", ReturnName(playerid, 0), ReturnWeaponName(weaponid), ReturnVehicleName(vehicleid));
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
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้จุดตู้เซฟ");

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

		format(str, sizeof(str), "* %s ได้วาง %s ไว้ในตู้เซฟ", ReturnName(playerid, 0), ReturnWeaponName(weaponid));
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
				format(longstr, sizeof(longstr), "%s%d. [ว่างเปล่า]\n", longstr, i);
				
			else format(longstr, sizeof(longstr), "%s%d. %s[กระสุน: %d]\n", longstr, i, ReturnWeaponName(PlayerInfo[playerid][pWeapons][i]), PlayerInfo[playerid][pWeaponsAmmo][i]); 
	}
	Dialog_Show(playerid, DIALOG_MYEAPON, DIALOG_STYLE_LIST, "Weapons:", longstr, "ตกลง", "ยกเลิก");
	return 1;
}

CMD:damages(playerid, params[])
{
	new playerb;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/damages [ชื่อบางส่วน/ไอดี]");
		
	if(!IsPlayerConnected(playerb))	
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้ทำการเชื่อมต่อเข้าเซืฟเวอร์");
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
		
	if(PlayerInfo[playerid][pAdminDuty])
	{
		ShowPlayerDamages(playerb, playerid, 1); 
	}
	else
	{
		if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ผู้เล่น");
			
		ShowPlayerDamages(playerb, playerid, 0); 
	}
	return 1;
}

CMD:acceptdeath(playerid, params[])
{
	if(GetPlayerTeam(playerid) != PLAYER_STATE_WOUNDED)
		return SendErrorMessage(playerid, "คุณยังไม่ได้รับบาดเจ็บ");
		
	CallLocalFunction("OnPlayerDead", "iii", playerid, INVALID_PLAYER_ID, -1, 0); 
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
				return SendErrorMessage(playerid, "ผู้เล่นไม่ได้ทำการเชื่อมต่อเข้าเซืฟเวอร์");
				
			if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
				return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
				
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



