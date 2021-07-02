#include <YSI_Coding\y_hooks>

new bool:PlayerHelpUp[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
	PlayerHelpUp[playerid] = false;
	return 1;
}

CMD:help(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "___________www.lsrp-lite.co___________");
	SendClientMessage(playerid, COLOR_GRAD2,"[ACCOUNT] /stats /levelup /myweapon /setspawn /license /fines");
	SendClientMessage(playerid, COLOR_GRAD2,"[GENERAL] /pay /time /buy /call /coin /admins /housecmds /blindfold /gps /makegps /editgps");
	SendClientMessage(playerid, COLOR_GRAD2,"[GENERAL] /global /bitsamphelp /setstaion /boombox");
	SendClientMessage(playerid, COLOR_GRAD2,"[CHAT] (/s)hout /(w)hisper /(o)oc /b /pm(ooc) (/l)ocal /me /ame /do(low) /low /radiohelp(/rhelp) ");
	SendClientMessage(playerid, COLOR_GRAD1,"[HELP] /jobhelp /fishhelp  /minerhelp /stats /report /helpme /computerhelp");
	SendClientMessage(playerid, COLOR_GRAD2,"[ANIMATION] /anim /animlist /sa(stopanimation)");
	SendClientMessage(playerid, COLOR_GREEN,"_____________________________________");
    SendClientMessage(playerid, COLOR_GRAD1,"โปรดศึกษาคำสั่งในเซิร์ฟเวอร์เพิ่มเติมในฟอรั่มหรือ /helpme เพื่อขอความช่วยเหลือ");
	return 1; 
}

alias:radiohelp("rhelp")
CMD:radiohelp(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN,"|_____________________Radio_help______________________|");
	SendClientMessage(playerid, COLOR_YELLOW,"HINT: คุณสามารถซื้อวิทยุได้ที่ร้าน 24/7");
	SendClientMessage(playerid, COLOR_WHITE,"/setchannel - ตั้งค่าแชแนล");
	SendClientMessage(playerid, COLOR_WHITE,"/setslot - ตั้งค่าห้องของแชแนล");
	SendClientMessage(playerid, COLOR_WHITE,"/r - พูดวิทยุ");
	SendClientMessage(playerid, COLOR_WHITE,"/rlow - พูดวิทยุแบบเบา");
	SendClientMessage(playerid, COLOR_GREEN,"|_____________________________________________________|");
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

	if(PlayerInfo[playerid][pJob] == JOB_TRUCKER) {
	    SendClientMessage(playerid,COLOR_LIGHTRED,"คำสั่งของพนักงานส่งของ:");
		SendClientMessage(playerid,COLOR_WHITE,"/cargo (เพื่อดูคำสั่งเกี่ยวกับคลังสินค้า)");
	}

	if(PlayerInfo[playerid][pJob] == JOB_MECHANIC)
	{
 		SendClientMessage(playerid,COLOR_LIGHTRED,"คำสั่งของพนักงานช่างยนต์:");
		SendClientMessage(playerid,COLOR_WHITE,"/service (คำสั่งซ่อมยานพาหนะ)");
		SendClientMessage(playerid,COLOR_WHITE,"/checkcomponents (เช็ค อะไหล่)");
		SendClientMessage(playerid,COLOR_WHITE,"/buycomponents (ซื้อ อะไหล่)");
	}

	if(PlayerInfo[playerid][pJob] == JOB_MINER)
	{
 		SendClientMessage(playerid,COLOR_LIGHTRED,"คำสั่งของพนักงานช่างยนต์:");
		SendClientMessage(playerid,COLOR_WHITE,"/checkore (เช็คแร่ในตัว)");
		SendClientMessage(playerid,COLOR_WHITE,"/ptze (แปรรูป)");
		SendClientMessage(playerid,COLOR_WHITE,"/sellore (ขายแร่)");
		SendClientMessage(playerid,COLOR_WHITE,"/giveore (ให้แร่)");
	}

	return 1;
}

CMD:bitsamphelp(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "___________BITSAMP : HELP___________");
	SendClientMessage(playerid, COLOR_DARKGREEN, "");
	SendClientMessage(playerid, COLOR_GRAD2,"[GENERAL] /checkbit /givebit /sellbit");
	SendClientMessage(playerid, COLOR_DARKGREEN, "");
	SendClientMessage(playerid, COLOR_DARKGREEN, "___________BITSAMP : HELP___________");
	return 1;
}


CMD:sellbit(playerid, params[])
{
	new Float:bit;
	if(sscanf(params, "f", bit))
		return SendUsageMessage(playerid, "/sellbit <จำนวนบิต:>");

	if(bit < 0.00001)
		return SendErrorMessage(playerid, "กรุณาใส่จำนวน บิตให้ถูกต้อง (*ต้องมากกว่า 0.00001*)");


	if(PlayerInfo[playerid][pBTC] < bit)
		return SendErrorMessage(playerid, "คุณมีบิตไม่เพียงพอ");
	new Float:result;
	
	PlayerInfo[playerid][pBTC]-= bit;
	result  = GlobalInfo[G_BITSAMP] * bit;
	
	floatround(result,floatround_round);
	GiveMoney(playerid, floatround(result,floatround_round));
	CharacterSave(playerid);
	SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้ขาย BITSMAP ได้เงินมาจำนวน $%s", MoneyFormat(floatround(result,floatround_round)));
	SendClientMessageEx(playerid, COLOR_GREY, "เหลือ: %.5f",PlayerInfo[playerid][pBTC]);
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

CMD:gps(playerid, params[])
{
	Dialog_Show(playerid, D_GPS_LIST, DIALOG_STYLE_LIST, "GPS SYSTEM:", "[GPS GLOBAL]\n[GPS PRIVATE]", "ยินยัน", "ยกเลิก");
	return 1;
}

CMD:global(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "___________GLOBAL: PRICE___________");
	SendClientMessage(playerid, COLOR_DARKGREEN, "");
	SendClientMessageEx(playerid, COLOR_GRAD2, "BITSAMP: 1 บิตมีค่าเท่ากับ %s ", MoneyFormat(GlobalInfo[G_BITSAMP]));
	SendClientMessage(playerid, COLOR_DARKGREEN, "");
	SendClientMessage(playerid, COLOR_DARKGREEN, "___________GLOBAL: PRICE___________");
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

			if(HouseInfo[p][HouseMusic])
			{
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid, HouseInfo[p][HouseMusicLink]);
			}
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

			if(BusinessInfo[b][BusinessMusic])
			{
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid,  BusinessInfo[b][BusinessMusicLink]);
			}
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
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ประตูทางออก");
		
		SetPlayerPos(playerid, HouseInfo[id][HouseEntrance][0], HouseInfo[id][HouseEntrance][1], HouseInfo[id][HouseEntrance][2]);
		
		SetPlayerVirtualWorld(playerid, HouseInfo[id][HouseEntranceWorld]);
		SetPlayerInterior(playerid, HouseInfo[id][HouseEntranceInterior]);
		PlayerInfo[playerid][pInsideProperty] = 0;
		PlayerTextDrawHide(playerid, PlayerSwicthOff[playerid][0]);
		StopAudioStreamForPlayer(playerid);
		return 1;
    }
	if(b_id != 0)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[b_id][BusinessInterior][0], BusinessInfo[b_id][BusinessInterior][1], BusinessInfo[b_id][BusinessInterior][2]))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ประตูทางออก");

		if(BusinessInfo[b_id][BusinessType] == BUSINESS_TYPE_RESTAURANT || BusinessInfo[b_id][BusinessType] == BUSINESS_TYPE_STORE)
		{
			if(PlayerInfo[playerid][pGUI] == 5)
			{
				for(new f = 0; f < 8; f++)
				{
					PlayerTextDrawDestroy(playerid, BuyFood[playerid][f]);
				}
				PlayerInfo[playerid][pGUI] = 0;
				CancelSelectTextDraw(playerid);
			}
			if(PlayerInfo[playerid][pGUI] == 6)
			{
				MenuStore_Close(playerid);
				PlayerInfo[playerid][pGUI] = 0;
			}
		}


		StopAudioStreamForPlayer(playerid);
		
		SetPlayerPos(playerid, BusinessInfo[b_id][BusinessEntrance][0], BusinessInfo[b_id][BusinessEntrance][1], BusinessInfo[b_id][BusinessEntrance][2]);
		SetPlayerVirtualWorld(playerid, BusinessInfo[b_id][BusinessEntranceWorld]);
		SetPlayerInterior(playerid, BusinessInfo[b_id][BusinessEntranceInterior]);
		PlayerInfo[playerid][pInsideBusiness] = 0;

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

		if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID] && PlayerInfo[playerid][pAdminDuty])
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
	else SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้ประตู บ้าน/กิจการ");
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

		if(HasNoEngine(vehicleid))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "ยานพาหนะไม่สามารถเก็บของได้"); 

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

CMD:checkweapons(playerid, params[])
{
	new longstr[MAX_STRING], playerb;

	if(PlayerInfo[playerid][pAdmin])
	{
		if(sscanf(params, "I(-1)", playerb))
			return 1; 

		if(playerb == -1)
		{
			for(new i = 0; i < 13; i++)
			{
					if(!PlayerInfo[playerid][pWeapons][i])
						format(longstr, sizeof(longstr), "%s%d. [ว่างเปล่า]\n", longstr, i);
						
					else format(longstr, sizeof(longstr), "%s%d. %s[กระสุน: %d]\n", longstr, i, ReturnWeaponName(PlayerInfo[playerid][pWeapons][i]), PlayerInfo[playerid][pWeaponsAmmo][i]); 
			}
			Dialog_Show(playerid, DIALOG_MYEAPON, DIALOG_STYLE_LIST, "Weapons:", longstr, "ตกลง", "ยกเลิก");
			return 1;
		}
		else
		{
			for(new i = 0; i < 13; i++)
			{
					if(!PlayerInfo[playerb][pWeapons][i])
						format(longstr, sizeof(longstr), "%s%d. [ว่างเปล่า]\n", longstr, i);
						
					else format(longstr, sizeof(longstr), "%s%d. %s[กระสุน: %d]\n", longstr, i, ReturnWeaponName(PlayerInfo[playerb][pWeapons][i]), PlayerInfo[playerb][pWeaponsAmmo][i]); 
			}
			new weapons[13][2];
			SendClientMessage(playerid, -1, "-------------------------WEAPONS NOT IN DATABSE----------------------");
			for (new i = 0; i <= 12; i++)
			{	
				GetPlayerWeaponData(playerb, i, weapons[i][0], weapons[i][1]);


				if(!weapons[i][0])
					continue;

				if(PlayerInfo[playerb][pWeapons][i])
					continue;

				if(PlayerInfo[playerb][pWeaponsAmmo][i] == weapons[i][1])
					continue;

				SendClientMessageEx(playerid, COLOR_LIGHTRED, "%s %d", ReturnWeaponName(weapons[i][0]), weapons[i][1]);
			}
			Dialog_Show(playerid, DIALOG_MYEAPON, DIALOG_STYLE_LIST, "Weapons: %s", longstr, "ตกลง", "ยกเลิก", ReturnName(playerb,0));
			return 1;
		}
		
	}
	else
	{
		for(new i = 0; i < 13; i++)
		{
				if(!PlayerInfo[playerid][pWeapons][i])
					format(longstr, sizeof(longstr), "%s%d. [ว่างเปล่า]\n", longstr, i);
					
				else format(longstr, sizeof(longstr), "%s%d. %s[กระสุน: %d]\n", longstr, i, ReturnWeaponName(PlayerInfo[playerid][pWeapons][i]), PlayerInfo[playerid][pWeaponsAmmo][i]); 
		}
		Dialog_Show(playerid, DIALOG_MYEAPON, DIALOG_STYLE_LIST, "Weapons:", longstr, "ตกลง", "ยกเลิก");
	}
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

CMD:respawnme(playerid, params[])
{
	
	if(GetPlayerTeam(playerid) != PLAYER_STATE_WOUNDED)
		return SendErrorMessage(playerid, "คุณยังไม่ได้รับบาดเจ็บ");

	if(gettime() - PlayerInfo[playerid][pRespawnTime] < 60)
		return SendErrorMessage(playerid, "คุณยังไม่สามารถเกิดได้โปรดรออีก %d",gettime() - PlayerInfo[playerid][pRespawnTime]);

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
		if (PlayerInfo[i][pTester]) TesterOn = true;
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
		return SendErrorMessage(playerid, "OOC ถูกปิดการใช้งานในเวลานี้"); 
		
	if(PlayerInfo[playerid][pAdminDuty])
		SendClientMessageToAllEx(COLOR_SAMP, "{adc3e7}[OOC] {FB8C00}%s{adc3e7}: %s", ReturnRealName(playerid, 0), params); 
	else if(PlayerInfo[playerid][pTesterDuty])	
		SendClientMessageToAllEx(COLOR_SAMP, "{adc3e7}[OOC] {229954}%s{adc3e7}: %s", ReturnRealName(playerid, 0), params);

	else SendClientMessageToAllEx(COLOR_SAMP, "{adc3e7}[OOC] %s: %s", ReturnRealName(playerid, 0), params);
	return 1;
}

CMD:pay(playerid, params[])
{
	new playerb, amount, emote[90], str[128]; 

	if(sscanf(params, "uiS('None')[90]", playerb, amount, emote))
		return SendUsageMessage(playerid, "/pay [ชื่อบางส่วน/ไอดี] [จำนวน] [การกระทำ (ถ้ามี)]");

	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซืฟเวอร์");

	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 

	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");

	if(amount > PlayerInfo[playerid][pCash])
		return SendErrorMessage(playerid, "คุณไม่มีเงินพอที่จะให้");

	if(!amount)
		return SendErrorMessage(playerid, "กรุณาใส่เงินให้ถูกต้อง");

	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0); PlayerPlaySound(playerb, 1052, 0.0, 0.0, 0.0);

	SendClientMessageEx(playerid, COLOR_GREY, " คุณได้ทำการจ่ายเงินให้ %s จำนวน $%s.", ReturnRealName(playerb, 0), MoneyFormat(amount)); 
	SendClientMessageEx(playerb, COLOR_GREY, " คุณได้รับเงิน จำนวน $%s จาก %s", MoneyFormat(amount), ReturnRealName(playerid, 0));

	if(!strcmp(emote, "'None'", false))
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s ได้ควักเงินบางส่วนออกมาจากกระเป๋าและมอบให้กับ %s", ReturnName(playerid, 0), ReturnName(playerb, 0)); 

	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s %s %s", ReturnName(playerid, 0), emote, ReturnName(playerb, 0));

	if(PlayerInfo[playerid][pLevel] <= 3 && PlayerInfo[playerb][pLevel] <= 3 || amount >= 50000)
	{
		format(str, sizeof(str), "%s ได้จ่ายเงิน จำนวน $%s ให้กับ %s ซึ่งเหมือนจะเป็นการผิดกฏเซือเวอร์โปรดตรวจสอบด้วย", ReturnName(playerid), MoneyFormat(amount), ReturnName(playerb)); 
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
		return SendErrorMessage(playerid, "คุณไม่มี วิทยุ"); 
	
	if(sscanf(params, "ii", channel, slot))
		return SendUsageMessage(playerid, "/setchannel [แชลเเนว] [ส็อต]"); 
		
	if(slot > 10 || slot < 1)
		return SendErrorMessage(playerid, "ส็อตจะสามารถปรับได้เพียงแค่ (1-10)");
		
	if(channel < 1 || channel > 1000000)
		return SendErrorMessage(playerid, "คุณไม่สามารถปรับแชลแนวเกิน (1-1000000)"); 
	
	if(channel == 911)
	{
		if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
			return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่สามารถตั้งค่า คลื่นวิทยุนี้ได้เนื่องจากคุณไม่ใช่หน่วยงานรัฐบาล"); 
	}
	
	PlayerInfo[playerid][pRadio][slot] = channel;
	PlayerInfo[playerid][pMainSlot] = slot;
	SendClientMessageEx(playerid, COLOR_RADIOEX, "คุณได้ปรับวิทยุไปที่คลื่น %i ภายใต้ สล็อต %i.", channel, slot);
	CharacterSave(playerid); 
	return 1;
}


alias:radio("r")
CMD:radio(playerid, params[])
{
	if(!PlayerInfo[playerid][pHasRadio])
		return SendErrorMessage(playerid, "คุณไม่มีวิทยุ");

	new
		local,
		channel
	;
		
	local = PlayerInfo[playerid][pMainSlot]; 
	channel = PlayerInfo[playerid][pRadio][local]; 
	
	if(!PlayerInfo[playerid][pRadio][local])
		return SendErrorMessage(playerid, "คุณยังไม่ได้เซ็ต สล็อต"); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/r(adio) [ข้อความ]");
		
	foreach(new i : Player)
	{
		for(new r = 1; r < 3; r ++)
		{
			if(PlayerInfo[i][pRadio][r] == channel)
			{
				if(r != PlayerInfo[i][pMainSlot])
					SendClientMessageEx(i, COLOR_RADIOEX, "**[CH: %d, S: %d] %s พูดว่า: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
					
				else SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s พูดว่า: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
			}
		}
	}
	
	new str[120];
	format(str, sizeof(str),"(วิทยุ) %s พูดว่า: %s", ReturnName(playerid, 0), params);
	SetPlayerChatBubble(playerid, str, COLOR_GRAD1, 10.0, 6000);

	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 10.0, posx,posy,posz))
		{
			SendClientMessageEx(i, COLOR_GRAD1, "(วิทยุ) %s พูดว่า: %s", ReturnName(playerid, 0), params);
		}
	}
	return 1;
}

CMD:rlow(playerid, params[])
{
	if(!PlayerInfo[playerid][pHasRadio])
		return SendErrorMessage(playerid, "คุณไม่มีวิทยุ");

	new
		local,
		channel
	;
		
	local = PlayerInfo[playerid][pMainSlot]; 
	channel = PlayerInfo[playerid][pRadio][local]; 
	
	if(!PlayerInfo[playerid][pRadio][local])
		return SendErrorMessage(playerid, "คุณยังไม่ได้เซ็ตสล็อต"); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/rlow [ข้อความ]");
		
	foreach(new i : Player)
	{
		for(new r = 1; r < 3; r ++)
		{
			if(PlayerInfo[i][pRadio][r] == channel)
			{
				if(r != PlayerInfo[i][pMainSlot])
					SendClientMessageEx(i, COLOR_RADIOEX, "**[CH: %d, S: %d] %s พูดว่า: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
					
				else SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s พูดว่า: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
			}
		}
	}

	new str[120];
	format(str, sizeof(str),"(วิทยุ) %s พูดว่า: %s", ReturnName(playerid, 0), params);
	SetPlayerChatBubble(playerid, str, COLOR_GRAD1, 5.0, 6000);
	
	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 5.0, posx,posy,posz))
		{
			SendClientMessageEx(i, COLOR_GRAD1, "(วิทยุ) %s พูดว่า[เบา]: %s", ReturnName(playerid, 0), params);
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
		SendClientMessage(playerid, COLOR_WHITE, "1. สนามบิน, 2. บ้าน, 3. เฟคชั่น, 4.จุดเกิดล่าสุด");
		return 1;
	}

	if(id > 4 || id < 1)
		return SendErrorMessage(playerid, "ไอ้ดีสปาว มีเพียง (1-4)");

	switch(id)
	{
		case 1:
		{
			if(PlayerInfo[playerid][pSpawnPoint] == 0)
				return SendErrorMessage(playerid, "คุณได้ทำการเซ็ตจุดเกิดของคุณเป็น สนามบินอยู่แล้ว");

			PlayerInfo[playerid][pSpawnPoint] = SPAWN_AT_DEFAULT; 
			SendServerMessage(playerid, "คุณได้ทำการเซ็ตจุดเกิดของคุณเป็น สนามบิน");
		}
		case 2:
		{
			new id_house = IsPlayerInHouse(playerid);

			if(id_house == 0)
				return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในบ้าน");

			if(HouseInfo[id_house][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
			{
				new tagerid = INVALID_PLAYER_ID;

				foreach(new i : Player)
				{
					if(HouseInfo[id_house][HouseOwnerDBID] != PlayerInfo[i][pDBID])
						continue;
					
					tagerid = i;
				}

				if(tagerid == INVALID_PLAYER_ID)
					return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของบ้านหลังนี้");

				SendClientMessageEx(tagerid, COLOR_REPORT, "SMS-HOUSE: %s ได้เริ่มเข้ามาอยู่บ้านของคุณ", ReturnName(playerid,0));
			}

			PlayerInfo[playerid][pSpawnPoint] = SPAWN_AT_HOUSE;
			PlayerInfo[playerid][pSpawnHouse] = id_house;
			SendServerMessage(playerid, "คุณได้ทำการเซ็ตจุดเกิดของคุณเป็น บ้าน %s", HouseInfo[id_house][HouseName]);
		}
		case 3:
		{
			new id_fac = PlayerInfo[playerid][pFaction];

			if(id_fac == 0)
				return SendErrorMessage(playerid, "คุณไม่มีเฟคชั่น");
			
			if(!FactionInfo[id_fac][eFactionSpawn][0] || !FactionInfo[id_fac][eFactionSpawn][1] || !FactionInfo[id_fac][eFactionSpawn][2])
				return SendErrorMessage(playerid, "เฟคชั่นของคุณยังไม่มีการเซ็ตจุดเกิด");

			PlayerInfo[playerid][pSpawnPoint] = SPAWN_AT_FACTION;
			SendServerMessage(playerid, "คุณได้ทำการเซ็ตจุดเกิดของคุณเป็น เฟคชั่น");
		}
		case 4:
		{
			PlayerInfo[playerid][pSpawnPoint] = SPAWN_AT_LASTPOS;
			SendServerMessage(playerid, "คุณได้เลือกจุดเกิดไปจุดปัจจุบันของคุณ");
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
		SendUsageMessage(playerid, "/leavegun [ไอดีอาวุธ]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF}คุณสามารถหยิบปืนขึ้นมาโดยการพิมพ์ /grabgun."); 
		return 1;
	}
	
	if(weaponid < 1 || weaponid > 46 || weaponid == 35 || weaponid == 36 || weaponid == 37 || weaponid == 38 || weaponid == 39)
	    return SendErrorMessage(playerid, "อาวุธเหล่านี้ถูกจัดเป็นอาวุธต้องห้ามภายในเซืฟเวอร์");
		
	if(!PlayerHasWeapon(playerid, weaponid))
		return SendErrorMessage(playerid, "คุณไม่ได้มีอาวุธชนิดดังกล่าว"); 
		
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
	SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} อาวุธของคุณจะยังคงอยู่บนพื้นได้ถึง 10 นาทีก่อนจะถูกลบออกจากเซืฟเวอร์");
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
		
		format(str, sizeof(str), "* %s หยิบ %s ขึ้นมาจากพื้น", ReturnName(playerid, 0), ReturnWeaponName(WeaponDropInfo[id][eWeaponWepID]));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 3000);
		SendClientMessage(playerid, COLOR_EMOTE, str);
		
		WeaponDropInfo[id][eWeaponDropped] = false; 
		WeaponDropInfo[id][eWeaponDroppedBy] = 0;
		
		WeaponDropInfo[id][eWeaponWepID] = 0; WeaponDropInfo[id][eWeaponWepAmmo] = 0; 
		
		KillTimer(WeaponDropInfo[id][eWeaponTimer]); 
		DestroyDynamicObject(WeaponDropInfo[id][eWeaponObject]); 
	}
	else return SendServerMessage(playerid, "ไม่มีอาวุธหรือสิ่งๆใดภายในบริเวณรนี้");
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
		SendServerMessage(playerid, "คุณยังมี ค่าประสบการณ์ไม่มากพอ จำเป็นต้องมีค่าประสบการณ์ %i จึงจะสามารถอัปเกรดได้", exp_count); 
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
		return SendUsageMessage(playerid, "/license [ชื่อบางส่วน/ไอดี]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซืฟเวอร์");
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
		
	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ"); 
		
	if(playerb != playerid)
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s หยิบบัตรประจำตัวบัตรประชาชนและยื่นให้ %s", ReturnName(playerid, 0), ReturnName(playerb, 0));
		
	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s หยิบบัตรประจำตัวบัตรประชาชนขึ้นมาดู", ReturnName(playerid, 0));
	
	ReturnLicenses(playerid, playerb); 	
	return 1;
}

CMD:time(playerid, params[])
{
	new str[20];
	format(str, sizeof(str), "ดูนาฬิกา");
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
		return SendUsageMessage(playerid, "/b [ข้อความ]"); 
	
	if(PlayerInfo[playerid][pAdminDuty] == true)
	{
		if(strlen(params) > 84)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {FF9900}%s{AFAFAF}: %.84s ))", playerid, ReturnName(playerid), params);
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {FF9900}%s{AFAFAF}: ...%s ))", playerid, ReturnName(playerid), params[84]);
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {FF9900}%s{AFAFAF}: %s ))", playerid, ReturnName(playerid), params);
	}
	else if(PlayerInfo[playerid][pTesterDuty] == true)
	{
		if(strlen(params) > 84)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {229954}%s{AFAFAF}: %.84s ))", playerid, ReturnName(playerid), params);
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {229954}%s{AFAFAF}: ...%s ))", playerid, ReturnName(playerid), params[84]);
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {229954}%s{AFAFAF}: %s ))", playerid, ReturnName(playerid), params);
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
		return SendUsageMessage(playerid, "/pm [ชื่อบางส่วน/ไอดี] [text]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");
		
	if(PlayerInfo[playerid][pAdminDuty])
	{
		SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM จาก {FF9900}%s{FFDC18} (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
		
		if(!PlayerInfo[playerb][pAdminDuty])
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ส่งไปยัง %s (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
			
		else SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ส่งไปยัง {FF9900}%s{EEE854} (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
	}
	else if(PlayerInfo[playerid][pTesterDuty])
	{
		SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM จาก {229954}%s{FFDC18} (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
		
		if(!PlayerInfo[playerb][pTesterDuty])
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ส่งไปยัง %s (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
			
		else SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ส่งไปยัง {229954}%s{EEE854} (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
	}
	else
	{
		if(PlayerInfo[playerb][pAdminDuty])
		{
			SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM จาก %s (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ส่งไปยัง {FF9900}%s{EEE854} (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
		}
		else if(PlayerInfo[playerb][pTesterDuty])
		{
			SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM จาก %s (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ส่งไปยัง {229954}%s{EEE854} (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
		}
		else
		{
			SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM จาก %s (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ส่งไปยัง %s (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
		}
	}
	return 1;
}

alias:quit("q")
CMD:quit(playerid, params[])
{
	if(IsPlayerAndroid(playerid))
	{
		CharacterSave(playerid);
		Kick(playerid);
		return 1;
	}
	return 1;
}

CMD:fines(playerid, params[])
{
	new str[255], fineid, longstr[255];

	format(str, sizeof(str), "สาเหตุ:\tค่าปรับ:\t วันที่:\n");
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
		Dialog_Show(playerid, DIALOG_FINES_LIST_NONE, DIALOG_STYLE_LIST, "ใบสั่ง", "คุณไม่มีใบสั่ง...", "ยืนยัน", "ยกเลิก");
		return 1;
	}

	Dialog_Show(playerid, DIALOG_FINES_LIST, DIALOG_STYLE_TABLIST_HEADERS, "ใบสั่ง", longstr, "ยืนยัน", "ยกเลิก");
	return 1;
}

CMD:helpme(playerid, params[])
{
	if(isnull(params) || strlen(params) < 3)
		return SendUsageMessage(playerid, "/helpme <ข้อความ>"); 

	format(PlayerHelpme[playerid], 120, "%s",params);

	SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: คำขอความช่วยเหลือของคุณได้ถูกส่งไปยังผู้ดูแลทุกคนที่ออนไลน์");

	new idx;
	
	for (new i = 1; i < sizeof(HelpmeData); i ++)
	{
		if (HelpmeData[i][hHelpmeExit] == false)
		{
			idx = i;
			break; 
		}
	}
			
	OnPlayerHelpme(playerid, idx, PlayerHelpme[playerid]);
	return 1;
}

CMD:givecigare(playerid, params[])
{
	if(!PlayerInfo[playerid][pCigare])
		return SendErrorMessage(playerid, "ไม่มีบุหรี่");

	new tagerid, amount;

	if(sscanf(params, "ud", tagerid, amount))
		return SendUsageMessage(playerid, "/givecigare <ชื่อบางส่วน/ไอดี> <จำนวน>");

	if(amount > PlayerInfo[playerid][pCigare])
		return SendErrorMessage(playerid, "คุณมีบุหรี่ไม่เพียงพอ");

	if(!IsPlayerConnected(tagerid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซืฟเวอร์");
		
	if(!BitFlag_Get(gPlayerBitFlag[tagerid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
		
	if(!IsPlayerNearPlayer(playerid, tagerid, 5.0))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");

	if(PlayerInfo[tagerid][pCigare] >= 20)
		return SendErrorMessage(playerid, "ผู้เล่นมี บุหรี่เต็มแล้ว");

	PlayerInfo[tagerid][pCigare]+= amount;
	PlayerInfo[playerid][pCigare]-= amount;
	SendClientMessageEx(playerid, -1, "คุณได้ให้บุหรี่จำนวน %d ม้วนกับ %s",amount, ReturnName(tagerid,0));
	SendClientMessageEx(tagerid, -1, "คุณได้รับบุหรี่จำนวน %d ม้วนจาก %s",amount, ReturnName(playerid,0));
	SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "* %s ได้หยิบซองบุหรี่ออกมาแล้วหยิบม้วนบุหรี่บางส่วนให้กับ %s", ReturnName(playerid,0),ReturnName(tagerid,0));
	return 1;
}

CMD:smoke(playerid, params[])
{
    new gesture;
    if(sscanf(params, "d", gesture)) 
		return SendUsageMessage(playerid,"/smoke [1-2]");

	if(!PlayerInfo[playerid][pCigare])
		return SendErrorMessage(playerid, "คุณไม่มีบุหรี่");

	switch(gesture)
	{
		case 1: 
		{
			ApplyAnimation(playerid,"SMOKING","M_smk_in",4.1, 0, 1, 1, 1, 1, 1);
			PlayerInfo[playerid][pCigare]--;
			SendNearbyMessage(playerid, 3.2, COLOR_EMOTE, "* %s หยิบบุหรีออกมาหนึ่งม้วนพร้อมกับจุดแล้วคีบไว้ที่ปาก",ReturnName(playerid,0));
		}
		case 2: 
		{
			ApplyAnimation(playerid,"SMOKING","M_smklean_loop",4.1, 0, 1, 1, 1, 1, 1);
			PlayerInfo[playerid][pCigare]--;
			SendNearbyMessage(playerid, 3.2, COLOR_EMOTE, "* %s หยิบบุหรีออกมาหนึ่งม้วนพร้อมกับจุดแล้วคีบไว้ที่ปาก",ReturnName(playerid,0));
		}
		default: return SendUsageMessage(playerid,"/smoke [1-2]");
	}
    return 1;
}

CMD:checkcom(playerid, params[])
{
	new count;
	for(new i = 1; i < MAX_COMPUTER; i++)
	{
		if(!ComputerInfo[i][ComputerDBID])
			continue;

		if(ComputerInfo[i][ComputerOwnerDBID] != PlayerInfo[playerid][pDBID])
			continue;

		count++;
		SendClientMessageEx(playerid, COLOR_GREY, "COMPUTER ID %d: Spawn: %s",ComputerInfo[i][ComputerDBID], (ComputerInfo[i][ComputerSpawn] != 0) ? (""EMBED_GREENMONEY"วางอยู่") : ("ยังไม่ได้วาง"));
	}
	if(!count)
		return SendClientMessage(playerid, COLOR_GREY, "คุณยังไม่มีการซื้อคอมพิวเตอร์");

	return 1;
}

CMD:helpup(playerid, params[])
{
	new tagerid;

	if(sscanf(params, "u", tagerid))
		return SendUsageMessage(playerid, "/helpup <ชื่อบางส่วน/ไอดี>");

	if(tagerid == playerid)
		return SendErrorMessage(playerid, "ไม่สามารถใช้กับตัวเองได้");

	if(!IsPlayerConnected(tagerid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซืฟเวอร์");
		
	if(!BitFlag_Get(gPlayerBitFlag[tagerid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
		
	if(!IsPlayerNearPlayer(playerid, tagerid, 2.5))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");

	if(GetPlayerTeam(playerid) == PLAYER_STATE_DEAD || GetPlayerTeam(playerid) == PLAYER_STATE_WOUNDED)
		return SendErrorMessage(playerid, "คุณไม่สามารถช่วยได้เนืองจากคุณเองก็มีสภาพร่างกายไม่พร้อม และต้องการการรักษาอย่างด่านเช่นกัน");

	
	if(GetPlayerTeam(tagerid) == PLAYER_STATE_ALIVE)
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้รับบาดเจ็บขนาดขั้นเสียชีวิต");

	if(GetPlayerTeam(tagerid) == PLAYER_STATE_DEAD)
		return SendErrorMessage(playerid, "ผู้เล่นเสียชีวิตแล้ว");

	if(PlayerHelpUp[tagerid])
		return SendErrorMessage(playerid, "มีการช่วยเหลืออยู่...");

	SendClientMessageEx(playerid, -1, "คุณกำลังช่วยเหลือ %s ห้ามขยับหรืออกไปไหน ในระหว่างการช่วยเหลือ", ReturnName(tagerid,0));
	PlayerHelpUp[tagerid] = true;
	SetTimerEx("HelpUpPLayer", 15000, false, "dd",playerid, tagerid);
	return 1;
}

CMD:id(playerid, params[])
{
	new tagerid;

	if(sscanf(params, "u", tagerid))
		return SendUsageMessage(playerid, "/id <ชื่อบางส่วน/ไอดี>");

	if(!IsPlayerConnected(tagerid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซืฟเวอร์");
		
	if(!BitFlag_Get(gPlayerBitFlag[tagerid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

	SendClientMessageEx(playerid, COLOR_GREY, "ชื่อ: %s เล่นผ่าน: %s",ReturnName(tagerid,0), (IsPlayerAndroid(tagerid)) ? ("Android") : ("PC"));
	return 1;
}

CMD:setstaion(playerid, params[])
{
	new option[15],url[400], secstr[150];

	if(sscanf(params, "s[15]S()[150]", option,secstr)) 
	{
		SendUsageMessage(playerid, "/setstaion <option>");
		SendClientMessage(playerid, -1, "ลิ้งค์สำหรับการแปลง: https://vocaroo.com/upload");
		SendClientMessage(playerid, -1, "วิธีการใช้คือ อัปโหลดเพลงที่ต้องการจากคอมพิวเตอร์ของคุณลงไปในลิ้งค์นี้");
		SendClientMessage(playerid, -1, "และนำลิ้งค์นั้นมาเป็นลิ้งในการเปิดเพลง");
		SendClientMessage(playerid, COLOR_GREY, "OPTION: Close Open");
		return 1;
	}

	if(!strcmp(option, "close", true))
	{
		if(PlayerInfo[playerid][pInsideProperty])
		{
			new id = PlayerInfo[playerid][pInsideProperty];

			foreach(new i : Player)
			{
				if(PlayerInfo[i][pInsideProperty] != PlayerInfo[playerid][pInsideProperty])
					continue;

				StopAudioStreamForPlayer(i);
			}

			HouseInfo[id][HouseMusic] = true;
			format(HouseInfo[id][HouseMusicLink], 150, "");
			SendNearbyMessage(playerid, 30.5, COLOR_EMOTE, "* %s ได้ปิดเครื่องเล่นวิทยุ", ReturnName(playerid,0));
			return 1;
		}
		if(GetPlayerVehicleID(playerid) != 0)
		{
			foreach(new i : Player)
			{
				if(GetPlayerVehicleID(i) != GetPlayerVehicleID(playerid))
					continue;

				StopAudioStreamForPlayer(i);
			}
			new vehicleid = GetPlayerVehicleID(playerid);
			VehicleInfo[vehicleid][eVehicleMusic] = false;
			format(VehicleInfo[vehicleid][eVehicleMusicLink],1,"");
			SendNearbyMessage(playerid, 30.5, COLOR_EMOTE, "* %s ได้ปิดเครื่องเล่นวิทยุ", ReturnName(playerid,0));
			return 1;
		}
		else if(PlayerInfo[playerid][pInsideBusiness])
		{
			new id = PlayerInfo[playerid][pInsideBusiness];

			foreach(new i : Player)
			{
				if(PlayerInfo[i][pInsideBusiness] != PlayerInfo[playerid][pInsideBusiness])
					continue;

				StopAudioStreamForPlayer(i);
			}

			BusinessInfo[id][BusinessMusic] = true;
			format(BusinessInfo[id][BusinessMusicLink], 150, "");
			SendNearbyMessage(playerid, 30.5, COLOR_EMOTE, "* %s ได้ปิดเครื่องเล่นวิทยุ", ReturnName(playerid,0));
			return 1;
		}
		else if(PlayerInfo[playerid][pBoomBoxSpawnID] && !PlayerInfo[playerid][pInsideBusiness] && !PlayerInfo[playerid][pInsideProperty])
		{
			new id = PlayerInfo[playerid][pBoomBoxSpawnID];
			if(IsPlayerInRangeOfPoint(playerid, 2.5, BoomBoxInfo[id][BoomBoxPos][0], BoomBoxInfo[id][BoomBoxPos][1], BoomBoxInfo[id][BoomBoxPos][2]))
			{
				foreach(new i : Player)
				{
					if(!IsPlayerInRangeOfPoint(i, 35.0, BoomBoxInfo[id][BoomBoxPos][0], BoomBoxInfo[id][BoomBoxPos][1], BoomBoxInfo[id][BoomBoxPos][2]))
						continue;

					StopAudioStreamForPlayer(i);
				}
			}
			SendNearbyMessage(playerid, 15.5, COLOR_EMOTE, "* %s ได้ปิดสถานีวิทยุ", ReturnName(playerid,0));
		}
		else SendErrorMessage(playerid, "คุณไมได้อยู่ใกล้ บ้าน / กิจการ / BoomBox");
	}
	else if(!strcmp(option, "open", true))
	{
		if(sscanf(secstr, "s[400]",url))
			return SendUsageMessage(playerid, "/setstaion <open> <url>");
	
		if(PlayerInfo[playerid][pInsideProperty])
		{
			new id = PlayerInfo[playerid][pInsideProperty];

			if(strlen(url) < 5)
				return SendErrorMessage(playerid, "กรุณาใส่ลิ้งค์ที่ถูกต้อง");

			foreach(new i : Player)
			{
				if(PlayerInfo[i][pInsideProperty] != PlayerInfo[playerid][pInsideProperty])
					continue;

				StopAudioStreamForPlayer(i);
				PlayAudioStreamForPlayer(i, url);
			}

			HouseInfo[id][HouseMusic] = true;
			format(HouseInfo[id][HouseMusicLink], 150, "%s",url);
			SendNearbyMessage(playerid, 30.5, COLOR_EMOTE, "* %s ได้เปลี่ยนสถานีวิทยุ", ReturnName(playerid,0));
			return 1;
		}
		else if(GetPlayerVehicleID(playerid) != 0)
		{
			if(HasNoEngine(GetPlayerVehicleID(playerid)))
				return SendErrorMessage(playerid, "ไม่มีเครื่องยนต์");

			if(!VehicleInfo[GetPlayerVehicleID(playerid)][eVehicleEngineStatus])
				return SendErrorMessage(playerid, "ต้องติดเครื่องยนต์ก่อน");

			if(strlen(url) < 5)
				return SendErrorMessage(playerid, "กรุณาใส่ลิ้งค์ที่ถูกต้อง");

			foreach(new i : Player)
			{
				if(GetPlayerVehicleID(i) != GetPlayerVehicleID(playerid))
					continue;

				StopAudioStreamForPlayer(i);
				PlayAudioStreamForPlayer(i, url);
			}
			new vehicleid = GetPlayerVehicleID(playerid);
			VehicleInfo[vehicleid][eVehicleMusic] = true;
			format(VehicleInfo[vehicleid][eVehicleMusicLink], 150, "%s",url);
			SendNearbyMessage(playerid, 30.5, COLOR_EMOTE, "* %s ได้เปลี่ยนสถานีวิทยุ", ReturnName(playerid,0));
			return 1;
		}
		else if(PlayerInfo[playerid][pInsideBusiness])
		{
			new id = PlayerInfo[playerid][pInsideBusiness];

			if(strlen(url) < 5)
				return SendErrorMessage(playerid, "กรุณาใส่ลิ้งค์ที่ถูกต้อง");


			if(BusinessInfo[id][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
				return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของกิจการนี้");

			foreach(new i : Player)
			{
				if(PlayerInfo[i][pInsideBusiness] != PlayerInfo[playerid][pInsideBusiness])
					continue;

				StopAudioStreamForPlayer(i);
				PlayAudioStreamForPlayer(i, url);
			}

			BusinessInfo[id][BusinessMusic] = true;
			format(BusinessInfo[id][BusinessMusicLink], 150, "%s",url);
			SendNearbyMessage(playerid, 30.5, COLOR_EMOTE, "* %s ได้เปลี่ยนสถานีวิทยุ", ReturnName(playerid,0));
		}
		else if(PlayerInfo[playerid][pBoomBoxSpawnID] && !PlayerInfo[playerid][pInsideBusiness] && !PlayerInfo[playerid][pInsideProperty])
		{
			new id = PlayerInfo[playerid][pBoomBoxSpawnID];
			if(IsPlayerInRangeOfPoint(playerid, 2.5, BoomBoxInfo[id][BoomBoxPos][0], BoomBoxInfo[id][BoomBoxPos][1], BoomBoxInfo[id][BoomBoxPos][2]))
			{
				foreach(new i : Player)
				{
					if(!IsPlayerInRangeOfPoint(i, 35.0, BoomBoxInfo[id][BoomBoxPos][0], BoomBoxInfo[id][BoomBoxPos][1], BoomBoxInfo[id][BoomBoxPos][2]))
						continue;

					StopAudioStreamForPlayer(i);
					PlayAudioStreamForPlayer(i, url, BoomBoxInfo[id][BoomBoxPos][0], BoomBoxInfo[id][BoomBoxPos][1], BoomBoxInfo[id][BoomBoxPos][2], 35.0,1);
				}
				SendNearbyMessage(playerid, 15.5, COLOR_EMOTE, "* %s ได้เปลี่ยนสถานีวิทยุ", ReturnName(playerid,0));
				return 1;
			}
		}
		else SendErrorMessage(playerid, "คุณไมได้อยู่ใกล้ บ้าน / กิจการ / BoomBox");
	}
	else SendErrorMessage(playerid, "กรุณาพิพม์ให้ถูกต้อง");
    return 1;
}

forward HelpUpPLayer(playerid, tagerid);
public HelpUpPLayer(playerid, tagerid)
{
	if(GetPlayerTeam(playerid) == PLAYER_STATE_DEAD || GetPlayerTeam(playerid) == PLAYER_STATE_WOUNDED)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "การช่วยเหลือไม่สำเร็จเนื่องจากคุณได้เสียชีวิตก่อน");
		PlayerHelpUp[tagerid] = false;
		return 1;
	}

	if(GetPlayerTeam(tagerid) == PLAYER_STATE_ALIVE)
	{
		PlayerHelpUp[tagerid] = false;
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้รับบาจเจ็บขนาดขั้นเสียชีวิต");
	}

	if(GetPlayerTeam(tagerid) == PLAYER_STATE_DEAD)
	{
		SendErrorMessage(playerid, "ผู้เล่นเสียชีวิตแล้ว");
		PlayerHelpUp[tagerid] = false;
		return 1;
	}

	if(!IsPlayerNearPlayer(playerid, tagerid, 2.5))
	{
		PlayerHelpUp[tagerid] = false;
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");
	}

	SetPlayerTeam(tagerid, PLAYER_STATE_ALIVE); 
	SetPlayerHealth(tagerid, 10); 
	TogglePlayerControllable(tagerid, 1); 
	SetPlayerWeather(tagerid, globalWeather);  
	PlayerHelpUp[tagerid] = false;
	SendNearbyMessage(playerid, 3.5, COLOR_EMOTE, "* %s ปฐมพยาบาลเบื่องต้นให้กับ %s",ReturnName(playerid,0), ReturnName(tagerid,0));
	return 1;
}



stock OnPlayerHelpme(playerid, reportid, text[])
{
	if(HelpmeData[reportid][hHelpmeExit] == true)
	{
		for (new i = 1; i < sizeof(PlayerHelpme); i ++)
		{
			if(HelpmeData[i][hHelpmeExit] == false)
			{
				reportid = i;
				break;
			}
		}
	}
	
	HelpmeData[reportid][hHelpmeDBID] = reportid;
	HelpmeData[reportid][hHelpmeExit] = true;
		
	format(HelpmeData[reportid][hHelpmeDetel], 90, "%s", text);
	HelpmeData[reportid][hHelpmeBy] = playerid;
		
	SendTesterMessageEx(COLOR_YELLOWEX, "มีการขอความช่วยเหลือเข้ามาพิมพ์ /helpmes l เพื่อตรวจสอบ");
		
	if(strfind(text, "hack", true) != -1 || strfind(text, "cheat", true) != -1)
	{
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pAdmin] || PlayerInfo[i][pTester]) GameTextForPlayer(i, "~y~~h~Priority Report", 4000, 1);
		}
	}
	return 1;
}

stock ClearHelpme(reportid)
{
	HelpmeData[reportid][hHelpmeExit] = false;
	HelpmeData[reportid][hHelpmeDBID] = 0;
    HelpmeData[reportid][hHelpmeBy] = INVALID_PLAYER_ID;
    HelpmeData[reportid][hHelpmeDetel] = ' ';
	return 1;
}

CMD:close(playerid, params[])
{
	if(PlayerInfo[playerid][pGUI] != 6)
		return 1;

	PlayerInfo[playerid][pGUI] = 6;
	MenuStore_Close(playerid);
	return 1;
}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PlayerInfo[playerid][pGUI] == 6)
	{
		if(RELEASED(KEY_CTRL_BACK))
		{
			PlayerInfo[playerid][pGUI] = 0;
			MenuStore_Close(playerid);
			return 1;
		}
	}
	return 1;
}	