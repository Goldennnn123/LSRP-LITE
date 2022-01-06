#include <YSI_Coding\y_hooks>

#define SHOT_MS 700


new gLastCar[MAX_PLAYERS];
new gPassengerCar[MAX_PLAYERS];
new playerInsertID[MAX_PLAYERS];


new PlayerVehicleScrap[MAX_PLAYERS];
new PlayerOwnerDBID[MAX_PLAYERS];

new bool:playerTowingVehicle[MAX_PLAYERS] = false;
new	playerTowTimer[MAX_PLAYERS] = 0;
new CheckPointGetCar;

enum S_SELLVEH_DATA
{
	S_BY,
	S_ID,
	S_VID
}
new SellVehData[MAX_PLAYERS][S_SELLVEH_DATA];

new rental_vehicles[21];
new RentCarKey[MAX_PLAYERS];




hook OnPlayerConnect(playerid)
{
	PlayerVehicleScrap[playerid] = 0;
	playerTowingVehicle[playerid] = false;
	playerTowTimer[playerid] = 0;

	SellVehData[playerid][S_ID] = INVALID_PLAYER_ID;
	SellVehData[playerid][S_BY] = INVALID_PLAYER_ID;
	SellVehData[playerid][S_VID] = INVALID_VEHICLE_ID;

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(playerTowingVehicle[playerid])
	{
		new vehicleid = PlayerInfo[playerid][pVehicleSpawnedID];
		KillTimer(playerTowTimer[playerid]);
		playerTowingVehicle[playerid] = false;
		Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleTowDisplay]);
		VehicleInfo[vehicleid][eVehicleTowCount] = 0;
	}

	if(SellVehData[playerid][S_ID] != INVALID_PLAYER_ID)
	{
		new tagetid = SellVehData[playerid][S_ID];
		
		SendClientMessageEx(tagetid, COLOR_YELLOWEX, "%s ได้ออกจากเกมจึงทำให้ข้อเสนอถูกลบออก", ReturnName(playerid,0));
		SellVehData[tagetid][S_ID] = INVALID_PLAYER_ID;
		SellVehData[tagetid][S_BY] = INVALID_PLAYER_ID;
		SellVehData[tagetid][S_VID] = INVALID_VEHICLE_ID;
	}

	if(SellVehData[playerid][S_BY] != INVALID_PLAYER_ID)
	{
		new tagetid = SellVehData[playerid][S_BY];

		SendClientMessageEx(tagetid, COLOR_YELLOWEX, "%s ได้ออกจากเกมจึงทำให้ข้อเสนอถูกลบออก", ReturnName(playerid,0));
		SellVehData[tagetid][S_ID] = INVALID_PLAYER_ID;
		SellVehData[tagetid][S_BY] = INVALID_PLAYER_ID;
		SellVehData[tagetid][S_VID] = INVALID_VEHICLE_ID;
	}
	return 1;
}


hook OnGameModeInit()
{
	SetTimer("OnVehicleUpdate", 250, true);

	CheckPointGetCar = CreateDynamicPickup(19134, 2, 1539.552 ,-2362.102,13.554, -1, -1, -1);
	return 1;
}

hook OP_PickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
	if(pickupid == CheckPointGetCar)
	{
		SendClientMessage(playerid, COLOR_LIGHTGREEN, "/vehicle get [sloit]");
		return 1;
	}

	
	return 1;
}


static stock g_arrVehicleNames[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Cruiser", "SFPD Cruiser", "LVPD Cruiser",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

stock HasNoEngine(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case 481, 509, 510: return 1;
	}
	return 0;
}

stock ReturnVehicleName(vehicleid)
{
	new
		model = GetVehicleModel(vehicleid),
		name[32] = "None";

	if(!strcmp(VehicleInfo[vehicleid][eVehicleName], "None"))
	{
		if (model < 400 || model > 611)
	    	return name;

		format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	}
	else
	{
		format(name, sizeof(name), "%s", VehicleInfo[vehicleid][eVehicleName]);
	}
	return name;
}

stock ReturnVehicleModelName(model)
{
	new
	    name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}


stock GetVehicleBoot(vehicleid, &Float:x, &Float:y, &Float:z) 
{ 
    if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID) 
        return (x = 0.0, y = 0.0, z = 0.0), 0; 

    static 
        Float:pos[7] 
    ; 
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]); 
    GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]); 
    GetVehicleZAngle(vehicleid, pos[6]); 

    x = pos[3] - (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees)); 
    y = pos[4] - (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees)); 
    z = pos[5]; 

    return 1; 
} 

stock ResetVehicleVars(vehicleid)
{
	if(vehicleid == INVALID_VEHICLE_ID)
		return 0;
		
	format(VehicleInfo[vehicleid][eVehicleName], 60, "None");
	VehicleInfo[vehicleid][eVehicleDBID] = 0; 
	VehicleInfo[vehicleid][eVehicleExists] = false;
	VehicleInfo[vehicleid][eVehicleLights] = false;
	
	VehicleInfo[vehicleid][eVehicleOwnerDBID] = 0;
	VehicleInfo[vehicleid][eVehicleFaction] = 0;
	
	VehicleInfo[vehicleid][eVehicleImpounded] = false;
	VehicleInfo[vehicleid][eVehiclePaintjob] = -1; 
	
	VehicleInfo[vehicleid][eVehicleFuel] = 100; 
	
	for(new i = 1; i < 6; i++)
	{
		VehicleInfo[vehicleid][eVehicleWeapons][i] = 0;
		VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i] = 0;
	}
	
	for(new i = 1; i < 5; i++)
	{
		VehicleInfo[vehicleid][eVehicleLastDrivers][i] = 0;
		VehicleInfo[vehicleid][eVehicleLastPassengers][i] = 0;
	}
	
	VehicleInfo[vehicleid][eVehicleTowCount] = 0;
	VehicleInfo[vehicleid][eVehicleRepairCount] = 0;
	
	VehicleInfo[vehicleid][eVehicleHasXMR] = false;
	VehicleInfo[vehicleid][eVehicleBattery] = 100.0;
	VehicleInfo[vehicleid][eVehicleEngine] = 100.0;
	VehicleInfo[vehicleid][eVehicleTimesDestroyed] = 0;
	
	VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
	VehicleInfo[vehicleid][eVehicleLights] = false;
	
	VehicleInfo[vehicleid][eVehicleTruck] = 0;

	VehicleInfo[vehicleid][eVehiclePrice] = 0;

	VehicleInfo[vehicleid][eVehicleElmTimer] = -1;

	if(IsValidDynamicObject(VehicleSiren[vehicleid]))
		DestroyDynamicObject(VehicleSiren[vehicleid]);

	VehicleSiren[vehicleid] = INVALID_OBJECT_ID;

	Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleCarsign]); 
	VehicleInfo[vehicleid][eVehicleHasCarsign] = false;

	VehicleInfo[vehicleid][eVehicleCarPark] = true; 


	Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleCarsign]); 
	VehicleInfo[vehicleid][eVehicleHasCarsign] = false;
	VehicleInfo[vehicleid][eVehicleEngineStatus] = false;

	//ปิดไฟ
	VehicleInfo[vehicleid][eVehicleLights] = false;
	ToggleVehicleLights(vehicleid, false);


	////ดับเครื่องยนต์
	ToggleVehicleEngine(vehicleid, false); 
	VehicleInfo[vehicleid][eVehicleEngineStatus] = false;

	///ลบ ELM
	KillTimer(VehicleInfo[vehicleid][eVehicleElmTimer]);
	VehicleInfo[vehicleid][eVehicleElmTimer] = -1;
	VehicleInfo[vehicleid][eVehicleFuel] = 100.0;


	DestroyDynamicObject(VehicleSiren[vehicleid]);
	VehicleSiren[vehicleid] = INVALID_OBJECT_ID;
	return 1;
}

stock ToggleVehicleEngine(vehicleid, bool:enginestate)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, enginestate, lights, alarm, doors, bonnet, boot, objective);
	return 1;
}

stock ToggleVehicleAlarms(vehicleid, bool:alarmstate, time = 5000)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;
 
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lights, alarmstate, doors, bonnet, boot, alarmstate);
	
	if(alarmstate) defer OnVehicleAlarm[time](vehicleid);
	return 1;
}

stock ScrambleWord(const str[])
{
	new scam[16];
    strcat(scam, str);
	new tmp[2], num, len = strlen(scam);

	while(strequal(str, scam)) {
		for(new i=0; scam[i] != EOS; ++i)
		{
			num = random(len);
			tmp[0] = scam[i];
			tmp[1] = scam[num];
			scam[num] = tmp[0];
			scam[i] = tmp[1];
		}
	}
	return scam;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		if(!VehicleInfo[vehicleid][eVehicleEngineStatus] && !IsRentalVehicle(vehicleid) && !HasNoEngine(vehicleid))
		{
			SendClientMessage(playerid, COLOR_DARKGREEN, "เครื่องยนต์ดับอยู่ /engine");
			SendClientMessage(playerid,COLOR_WHITE,"ข้อแนะ: คุณสามารถออกจากรถด้วยการพิมพ์ /exitveh(icle)");
			TogglePlayerControllable(playerid, 0);
			ClearUnscramble(playerid);
		}
	
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] == PlayerInfo[playerid][pDBID])
			SendClientMessageEx(playerid, COLOR_WHITE, "ยินดีต้อนรับสู่ %s ของคุณ", ReturnVehicleName(vehicleid));

		new oldcar = gLastCar[playerid];
		if(oldcar != 0)
		{
			if((!VehicleInfo[oldcar][eVehicleDBID] && !VehicleInfo[oldcar][eVehicleAdminSpawn]) && !IsRentalVehicle(oldcar))
			{
				if(oldcar != vehicleid)
				{
					new
						engine,
						lights,
						alarm,
						doors,
						bonnet,
						boot,
						objective;
	
					GetVehicleParamsEx(oldcar, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(oldcar, engine, lights, alarm, 0, bonnet, boot, objective);
				}
			}
		}
		gLastCar[playerid] = vehicleid;
	}

	if (newstate == PLAYER_STATE_PASSENGER) {
		gPassengerCar[playerid] = GetPlayerVehicleID(playerid);
	}

	return 1;
}

forward Query_AddPlayerVehicle(playerid, playerb);
public Query_AddPlayerVehicle(playerid, playerb)
{
	PlayerInfo[playerb][pOwnedVehicles][playerInsertID[playerb]] = cache_insert_id(); 
	
	SendServerMessage(playerb, "คุณได้รับยานพาหนะจาก %s เข้าสู่สล็อตที่ %i.", ReturnName(playerid), playerInsertID[playerb]);
	SendServerMessage(playerid, "คุณ %s ออกยานพาหนะใหม่", ReturnName(playerb));
	
	playerInsertID[playerb] = 0;
	CharacterSave(playerb);
	return 1;
}

CMD:engine(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้อยู่ในที่นั่งคนขับของยานพาหนะ"); 
		
	new vehicleid = GetPlayerVehicleID(playerid),  Float:health;
	
	if(HasNoEngine(vehicleid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "ยานพาหนะคันนี้ไม่มีเครื่องยนต์"); 

	GetVehicleHealth(vehicleid, health);
	
	if(health <= 300)
		return SendErrorMessage(playerid, "ยานพหานะของคุณมีความเสียหายอย่างหนักจึงไม่สามารถ สตาร์ทเครื่องยนต์ได้");

	if(!VehicleInfo[vehicleid][eVehicleDBID] && !VehicleInfo[vehicleid][eVehicleAdminSpawn] && !IsRentalVehicle(vehicleid) && !VehicleInfo[vehicleid][eVehicleFaction] && !IsElecVehicle(vehicleid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คำสั่งนี้สามารถใช้ได้เฉพาะยานพาหนะส่วนตัว แต่คุณอยู่ในยานพาหนะสาธารณะ (Static)");
		
	if(VehicleInfo[vehicleid][eVehicleFuel] <= 0.0 && !VehicleInfo[vehicleid][eVehicleAdminSpawn])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "ยานพาหนะนี้ไม่มีเชื้อเพลิง!"); 

	if(VehicleInfo[vehicleid][eVehicleEngine] < 1 && !VehicleInfo[vehicleid][eVehicleFaction])
		return SendErrorMessage(playerid, "ยานพาหนะของคุณแบตตารี่หมด กรุณาไปเติมก่อน");

	if(VehicleInfo[vehicleid][eVehicleImpounded])
		return SendErrorMessage(playerid, "ยานพาพนะคันนี้ถูกยึดอยู่โปรดติดต่อ เจ้าหน้าที่ตำรวจให้ทำการยกเลิกการยึดยานพาหนะ");
	
	if(VehicleInfo[vehicleid][eVehicleFaction] > 0)
	{
		if(PlayerInfo[playerid][pFaction] != VehicleInfo[vehicleid][eVehicleFaction] && !PlayerInfo[playerid][pAdminDuty])
		{
			return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่มีกุญแจสำหรับยานพาหนะคันนี้"); 
		}
	}

	if(IsRentalVehicle(vehicleid) && !IsPlayerRentVehicle(playerid, vehicleid)) {
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่มีกุญแจสำหรับยานพาหนะคันนี้");
	}

	if(
	!VehicleInfo[vehicleid][eVehicleFaction] && 
	PlayerInfo[playerid][pDuplicateKey] != vehicleid && 
	VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID] && 
	!VehicleInfo[vehicleid][eVehicleAdminSpawn] && 
	!IsRentalVehicle(vehicleid) &&
	!IsElecVehicle(vehicleid) &&
	!PlayerInfo[playerid][pAdminDuty]
	)
	{
		SendErrorMessage(playerid, "คุณไม่มีกุญแจยานพาหนะคันนี้ พิพม์ /unscramble เพื่อต่อสายตรง!!!");
		return 1;
	}
	
	if(!VehicleInfo[vehicleid][eVehicleEngineStatus])
	{
		if(VehicleInfo[vehicleid][eVehicleCarPark])
			return SendErrorMessage(playerid, "คุณยังไม่ได้ carget ยานพาหนะของคุณ");

		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "> %s สตาร์ทเครื่องยนต์ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid)); 
		ToggleVehicleEngine(vehicleid, true); VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
		TogglePlayerControllable(playerid, 1);
	}
	else
	{
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "> %s ดับเครื่องยนต์ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid)); 
		ToggleVehicleEngine(vehicleid, false); VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
		
		VehicleInfo[vehicleid][eVehicleLights] = false;
		ToggleVehicleLights(vehicleid, false);
		
		TogglePlayerControllable(playerid, 0);
	}
	return 1;
}

alias:unscramble("uns")
CMD:unscramble(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้ขับยานพาหนะ");
		
	if(PlayerInfo[playerid][pUnscrambling])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้ต่อสายตรงยานพาหนะ");
	
	new vehicleid = GetPlayerVehicleID(playerid);

	PlayerInfo[playerid][pUnscramblerTime] = 10 * VehicleInfo[vehicleid][eVehicleAlarmLevel];
	PlayerInfo[playerid][pUnscrambleID] = vehicleid;
	PlayerInfo[playerid][pUnscrambling] = true;


	new str[255];
	format(str, sizeof(str), "~y~You Are Unscramble %d", MoneyFormat(10 * VehicleInfo[vehicleid][eVehicleAlarmLevel]));
	SendInfomationMess(playerid, str, 10 * VehicleInfo[vehicleid][eVehicleAlarmLevel]);
	return 1;
}

stock ClearUnscramble(playerid)
{
	PlayerInfo[playerid][pUnscrambling] = false;
	PlayerInfo[playerid][pUnscramblerTime] = 0;
	PlayerInfo[playerid][pUnscrambleID] = INVALID_VEHICLE_ID;
	PlayerInfo[playerid][pUnscrambling] = false;


	return 1;
}


ptask PlayerUnscramble[1000](playerid) 
{
	if(PlayerInfo[playerid][pUnscrambling] == true)
	{
		if(GetPlayerVehicleID(playerid) != PlayerInfo[playerid][pUnscrambleID])
		{
			ClearUnscramble(playerid);
			StopPlayerInfomation(playerid);
			SendErrorMessage(playerid, "คุณได้ออกจากยานพาหนะในขณะที่คุณนั้นกำลัง");
		}


		if(PlayerInfo[playerid][pUnscramblerTime] > 1)
		{
			PlayerInfo[playerid][pUnscramblerTime]--;
		}
		else
		{
			new vehicleid = PlayerInfo[playerid][pUnscrambleID];

			ClearUnscramble(playerid);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "> %s สตาร์ทเครื่องยนต์ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid)); 
			ToggleVehicleEngine(vehicleid, true); VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
			TogglePlayerControllable(playerid, 1);
			NotifyVehicleOwner(vehicleid);
		}
	}
	return 1;
}




alias:vehicle("v")
CMD:vehicle(playerid, params[])
{
	new oneString[30], secString[90];

	if(sscanf(params, "s[30]S()[90]", oneString, secString))
	{
 	    SendClientMessage(playerid, COLOR_YELLOWEX, "___________________________________________________________");
	 	SendClientMessage(playerid, COLOR_YELLOWEX, "USAGE: /(v)ehicle <action>");
	    SendClientMessage(playerid, COLOR_YELLOWEX, "[Actions] get, sell, buy, upgrade, list, lock");
        SendClientMessage(playerid, COLOR_YELLOWEX, "[Actions] stats, tow, duplicatekey");
        SendClientMessage(playerid, COLOR_YELLOWEX, "[Delete] scrap (ตำเตือน: หากใช้คำสั่งนี้จะทำการขายรถทิ้งในทันที.)");
        SendClientMessage(playerid, COLOR_YELLOWEX, "[Hint] หากพบบัคหรือสิ่งผิดปกติให้ทำการแจ้งผู้ดูแลในทันที");
		SendClientMessage(playerid, COLOR_YELLOWEX, "___________________________________________________________");
		return 1;
	}

	if(!strcmp(oneString, "get"))
	{
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1539.552 ,-2362.102,13.554))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในจุดในการเรียกยานพาหนะ");
		
		new
			slotid
		;

		if(sscanf(secString, "d", slotid))
			return SendUsageMessage(playerid, "/vehicle get [สล็อตรถ]");

		if(PlayerInfo[playerid][pDonater] == 2)
		{
			if(slotid < 1 || slotid > 8)
				return SendErrorMessage(playerid, "ไม่มีส็อตที่ต้องการ");
		}
		else if(PlayerInfo[playerid][pDonater] == 3)
		{
			if(slotid < 1 || slotid > 11)
				return SendErrorMessage(playerid, "ไม่มีส็อตที่ต้องการ");
		}
		else
		{
			if(slotid < 1 || slotid > 5)
				return SendErrorMessage(playerid, "ไม่มีส็อตที่ต้องการ");
		}

		if(!PlayerInfo[playerid][pOwnedVehicles][slotid])
			return SendErrorMessage(playerid, "ไม่มีรถในสล็อตนี้");

		new threadLoad[128];

		for(new i = 0; i < MAX_VEHICLES; i++)
		{
			if(VehicleInfo[i][eVehicleDBID] == PlayerInfo[playerid][pOwnedVehicles][slotid])
				return SendErrorMessage(playerid, "รถถูกนำออกมาอยู่แล้ว");
		}

		mysql_format(dbCon, threadLoad, sizeof(threadLoad), "SELECT * FROM vehicles WHERE VehicleDBID = %i", PlayerInfo[playerid][pOwnedVehicles][slotid]);
		mysql_tquery(dbCon, threadLoad, "Query_LoadPrivateVehicle", "i", playerid);
		return 1;
	}
	/*else if(!strcmp(oneString, "park"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ภายในรถ");

		if(PlayerTaxiDuty[playerid])
			return SendErrorMessage(playerid, "คุณยังมีการทำงาน Taxi อยู่");
			
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "คุณไม่ได้เป็นคนขับรถ");

		new 
			vehicleid = GetPlayerVehicleID(playerid);
			
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของรถ"); 
			
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2]))
		{
			if(VehicleInfo[vehicleid][eVehicleImpounded])
			{
				PlayerInfo[playerid][pVehicleSpawned] = false; 
				PlayerInfo[playerid][pVehicleSpawnedID] = INVALID_VEHICLE_ID;
			
				SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้จัดเก็บรถ %s เรียบร้อย", ReturnVehicleName(vehicleid));
				
				SaveVehicle(vehicleid);
				TogglePlayerControllable(playerid, 1);
				ResetVehicleVars(vehicleid);
				DestroyVehicle(vehicleid); 
				return 1;	
			}
			SendErrorMessage(playerid, "คุณไม่ได้อยู่ในพื้นที่จอดรถของคุณ");
			SendClientMessage(playerid, 0xFF00FFFF, "ขับไปยังจุดที่เราได้ทำการ มาร์ากไว้ดังกล่าว");
		
			SetPlayerCheckpoint(playerid, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2], 5.0);
			PlayerCheckpoint[playerid] = 3;
			return 1;
		}
		
		PlayerInfo[playerid][pVehicleSpawned] = false; 
		PlayerInfo[playerid][pVehicleSpawnedID] = INVALID_VEHICLE_ID;
		
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้จัดเก็บรถ %s เรียบร้อย", ReturnVehicleName(vehicleid));
		
		SaveVehicle(vehicleid);
		
		ResetVehicleVars(vehicleid);
		DestroyVehicle(vehicleid); 
		TogglePlayerControllable(playerid, 1);
		return 1;
	}*/
	/*else if(!strcmp(oneString, "buypark"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ");
		
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return SendErrorMessage(playerid, "คุณไม่ได้เป็นคนขับ");

		if(PlayerInfo[playerid][pVehicleSpawned] == false) return SendErrorMessage(playerid, "รถของคุณไม่ได้ถูกนำออกมา");

		if(PlayerInfo[playerid][pCash] < 2500)
			return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอ");

		new  vehicleid = GetPlayerVehicleID(playerid);

		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "คุณไม่ไช่เจ้าของรถ");

		GetVehiclePos(vehicleid, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2]);
		GetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][eVehicleParkPos][3]); 
		
		VehicleInfo[vehicleid][eVehicleParkInterior] = GetPlayerInterior(playerid);
		VehicleInfo[vehicleid][eVehicleParkWorld] = GetPlayerVirtualWorld(playerid); 
		
		SendServerMessage(playerid, "คุณได้ซื้อพื้นที่จอดรถใหม่ในราคา $2,500.");
		GiveMoney(playerid, -2500);
		SaveVehicle(vehicleid);

		callcmd::vehicle(playerid, "park");
		return 1;
	}*/
	else if(!strcmp(oneString, "list"))
	{
		ShowVehicleList(playerid);
		return 1;
	}
	else if(!strcmp(oneString, "buy"))
	{
		new id = IsPlayerNearBusiness(playerid);
		new idx = 0;
		
		if(id == 0)
			return SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้ร้านตัวแทนจำหน่ายรถ");

		if(BusinessInfo[id][BusinessType] != 2)
			return SendErrorMessage(playerid,"คุณไม่ได้อยู่ร้านขายรถ");


		if(PlayerInfo[playerid][pDonater] == 2)
		{
			for(new i = 1; i < MAX_PLAYER_VEHICLES_V2; i++)
			{
				if(!PlayerInfo[playerid][pOwnedVehicles][i])
				{
					idx = i;
					break;
				}
			}
		}
		else if(PlayerInfo[playerid][pDonater] == 3)
		{
			for(new i = 1; i < MAX_PLAYER_VEHICLES_V3; i++)
			{
				if(!PlayerInfo[playerid][pOwnedVehicles][i])
				{
					idx = i;
					break;
				}
			}
		}
		else
		{
			for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
			{
				if(!PlayerInfo[playerid][pOwnedVehicles][i])
				{
					idx = i;
					break;
				}
			}
		}


		if(idx == 0)
			return SendErrorMessage(playerid,"คุณมีรถเต็มตัวแล้ว");

		
		PlayerOwnerDBID[playerid] = idx;

		ShowModelVehicleBuy(playerid);
		return 1;
	}
	else if(!strcmp(oneString, "sell"))
	{
		if(SellVehData[playerid][S_ID] != INVALID_PLAYER_ID)
			return SendErrorMessage(playerid, "คุณได้มีข้อตกลงการซื้อขายกับผู้เล่นคนอืนอยู่");

		new tagetid;
		if(sscanf(secString, "u", tagetid))
			return SendUsageMessage(playerid, "/vehicle sell <ชื่อบางส่วน/ไอดี>");
		
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "คุณต้องอยู่บนยานพาหนะ");

		if(playerid == tagetid)
			return SendErrorMessage(playerid, "คุณไม่สามารถยื่นข้อเสนอนี้ได้");

		if(!IsPlayerConnected(tagetid))
			return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยูภายในเซิร์ฟเวอร์");

		if(IsPlayerLogin(playerid))
			return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

		if(!IsPlayerNearPlayer(playerid, tagetid, 5.0))
			return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");

		/*if(PlayerInfo[tagetid][pVehicleSpawned] == true)
			return SendErrorMessage(playerid, "ไม่สามารถให้ยานพาหนะกับผู้เล่นได้ เนื่องจาก ผู้เล่นยังไม่ได้เก็บยานพหานะคันเดิม");*/

		new idx = 0;

		if(PlayerInfo[tagetid][pDonater] == 2)
		{
			for(new i = 1; i < MAX_PLAYER_VEHICLES_V2; i++)
			{
				if(!PlayerInfo[tagetid][pOwnedVehicles][i])
				{
					idx = i;
					break;
				}
			}
		}
		else if(PlayerInfo[tagetid][pDonater] == 3)
		{
			for(new i = 1; i < MAX_PLAYER_VEHICLES_V3; i++)
			{
				if(!PlayerInfo[tagetid][pOwnedVehicles][i])
				{
					idx = i;
					break;
				}
			}
		}
		else
		{
			for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
			{
				if(!PlayerInfo[tagetid][pOwnedVehicles][i])
				{
					idx = i;
					break;
				}
			}
		}

		if(idx == 0)
			return SendErrorMessage(playerid,"ผู้เล่นมียานพาหนะเต็มแล้ว");

		new vehicleid = GetPlayerVehicleID(playerid);

		if(vehicleid == 0)
			return SendErrorMessage(playerid, "คุณยังไม่ได้นำยานพาหนะออกมา");

		
		SellVehData[playerid][S_ID] = tagetid;

		SellVehData[tagetid][S_BY] = playerid;
		SellVehData[tagetid][S_VID] = vehicleid;
		PlayerOwnerDBID[tagetid] = idx;

		SendClientMessageEx(playerid, COLOR_YELLOWEX, "คุณได้ยื่นข้อเสนอการให้ยานพาหนะ %s กับ %s",ReturnVehicleName(vehicleid), ReturnName(tagetid,0));
		SendClientMessageEx(tagetid, COLOR_YELLOWEX, "%s ได้ยื่นข้อเสนอการให้ยานพาหนะ %s กับคุณ",ReturnName(playerid,0), ReturnVehicleName(vehicleid));
		SendClientMessage(tagetid, -1, "ข้อเสนอ: หากคุณยอมรับให้กด Y หากไม่ให้กด N");
		return 1;
	}
	else if(!strcmp(oneString, "duplicatekey"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ");

		new 
			playerb, vehicleid = GetPlayerVehicleID(playerid);

		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของรถ");

		if(sscanf(secString, "u", playerb))
			return SendUsageMessage(playerid, "/vehicle duplicatekey [ชื่อบางส่วน/ไอดี]");

		if(playerb == playerid)return SendErrorMessage(playerid, "คุณไม่สามารถให้กุญแจสำรองกับตัวเองได้");

		if(!IsPlayerConnected(playerb))
			return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");

		if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
			return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
		
		if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
			return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");

		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "> %s ได้ให้ชุดกุญแจสำรองกับ %s", ReturnName(playerid, 0), ReturnName(playerb, 0));
		SendServerMessage(playerb, "%s ได้ให้ชุดกุญแจสำรองกับคุณ", ReturnName(playerid, 0));
		
		GiveMoney(playerid, -500);
		SendServerMessage(playerid, "คุณได้ให้ชุดกุญแจสำรองกับ %s  และเสียเงิน $500", ReturnName(playerb, 0));
		PlayerInfo[playerb][pDuplicateKey] = vehicleid;
		return 1;
	}
	else if(!strcmp(oneString, "scrap"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ภภายในรถ");
			
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return SendErrorMessage(playerid, "คุณไม่ได้เป็นคนขับรถ");
			
		/*if(PlayerInfo[playerid][pVehicleSpawned] == false) return SendErrorMessage(playerid, "รถของคุณยังไม่ได้ถูกนำออกมา");*/

		new 
			str[160], 
			vehicleid = GetPlayerVehicleID(playerid)
		;

		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของรถ");

		PlayerVehicleScrap[playerid] = vehicleid;

		format(str, sizeof(str), "คุณมั่นใจใช่ไหมที่จะขายรถของคุณทิ้ง ถ้าคุณขายรถของคุณคุณจะได้รับเงิน ซึ่งเป็นเงินหาร 2 ของราคาเต็มของรถ\nแล้วโปรดจงจำไว้ว่ารถของคุณจะไม่สามารถนำกลับมาได้อีกได้อีก");
		Dialog_Show(playerid, DIALOG_VEH_SELL, DIALOG_STYLE_MSGBOX, "คุณแน่ในใช่ไหม?", str, "ยืนยัน", "ยกเลิก");
	}
	else if(!strcmp(oneString, "tow"))
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "คำสั่งนี้ยังไม่เปิดให้ใช้งาน");
		return 1;

		/*if(PlayerInfo[playerid][pVehicleSpawned] == false) 
			return SendErrorMessage(playerid, "คุณไม่ได้นำรถออกมา");
			
		if(IsVehicleOccupied(PlayerInfo[playerid][pVehicleSpawnedID]))
			return SendErrorMessage(playerid, "รถคันนี้ยังเคลื่อนที่อยู่");

		if(playerTowingVehicle[playerid])
			return SendErrorMessage(playerid, "คุณกำลังส่งรถกลับอยู่....");

		VehicleInfo[PlayerInfo[playerid][pVehicleSpawnedID]][eVehicleTowDisplay] = 
			Create3DTextLabel("(( | ))\nTOWING VEHICLE", COLOR_DARKGREEN, 0.0, 0.0, 0.0, 25.0, 0, 1);
		
		Attach3DTextLabelToVehicle(VehicleInfo[PlayerInfo[playerid][pVehicleSpawnedID]][eVehicleTowDisplay], PlayerInfo[playerid][pVehicleSpawnedID], -0.0, -0.0, -0.0);

		playerTowingVehicle[playerid] = true;
		playerTowTimer[playerid] = SetTimerEx("OnVehicleTow", 5000, true, "i", playerid);
		
		SendServerMessage(playerid, "คุณได้ส่งคำขอให้ประกันนำรถ %s มาไว้ที่จุดเกิดแล้ว", ReturnVehicleName(PlayerInfo[playerid][pVehicleSpawnedID]));
		return 1;*/
	}
	else if(!strcmp(oneString, "find"))
	{
		
		ShowVehicleFind(playerid);
	
		/*new 
			Float:fetchPos[3];
		
		GetVehiclePos(PlayerInfo[playerid][pVehicleSpawnedID], fetchPos[0], fetchPos[1], fetchPos[2]);
		SetPlayerCheckpoint(playerid, fetchPos[0], fetchPos[1], fetchPos[2], 3.0);*/
		return 1;
	}
	else if(!strcmp(oneString, "stats"))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ภายในรถ");

		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID] && !PlayerInfo[playerid][pAdmin])
			return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของรถ");

		
		
		if(PlayerInfo[playerid][pAdmin])
		{
			SendClientMessageEx(playerid, COLOR_WHITE, "เจ้าของรถ: %s", ReturnDBIDName(VehicleInfo[vehicleid][eVehicleOwnerDBID]));
			SendClientMessageEx(playerid, COLOR_WHITE, "Vehicle DBID: %d",VehicleInfo[vehicleid][eVehicleDBID]);
		}
		SendClientMessageEx(playerid, COLOR_WHITE, "Life Span: Engine Life[%.2f], Battery Life[%.2f], Times Destroyed[%i]", VehicleInfo[vehicleid][eVehicleEngine], VehicleInfo[vehicleid][eVehicleBattery], VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Security: Lock Level[%i], Alarm Level[%i], Immobilizer[%i]", VehicleInfo[vehicleid][eVehicleLockLevel], VehicleInfo[vehicleid][eVehicleAlarmLevel], VehicleInfo[vehicleid][eVehicleImmobLevel]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Misc: Primary Color[%d], Secondary Color[%d], License Plate[%s]",VehicleInfo[vehicleid][eVehicleColor1],VehicleInfo[vehicleid][eVehicleColor2], VehicleInfo[vehicleid][eVehiclePlates]);
	}
	else if(!strcmp(oneString, "lock"))
	{
		callcmd::lock(playerid, "");
		return 1;
	}
	else if(!strcmp(oneString, "upgrade"))
	{
		new id = IsPlayerNearBusiness(playerid);
		
		if(id == 0)
			return SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้ร้านตัวแทนจำหน่ายรถ");

		if(BusinessInfo[id][BusinessType] != 2)
			return SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้ร้านตัวแทนจำหน่ายรถ");
		
		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ภายในรถ");

		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID] && !PlayerInfo[playerid][pAdmin])
			return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของรถ");

		new str[255], longstr[255];

		format(str, sizeof(str), "LockLevel: %d\n",VehicleInfo[vehicleid][eVehicleLockLevel]);
		strcat(longstr, str);
		format(str, sizeof(str), "AlarmLevel: %d\n",VehicleInfo[vehicleid][eVehicleAlarmLevel]);
		strcat(longstr, str);
		
		Dialog_Show(playerid, D_VEHUPGRADE, DIALOG_STYLE_LIST, "VEHICLE: UPGRADE", longstr, "เลือก", "ออก");
		return 1;
	}
	else SendErrorMessage(playerid, "พิพม์ให้ถูกต้อง");
	return 1;
}


CMD:carpark(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะ");

	new vehicleid = GetPlayerVehicleID(playerid);
	new engine, lights, alarm, doors, bonnet, boot, objective, threadLoad[255]; 	
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);


	if(PlayerInfo[playerid][pDuplicateKey] != vehicleid && VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
		return SendErrorMessage(playerid, "คุณไม่มีกุญแจยานพาหนะคันนี้");

	if(VehicleInfo[vehicleid][eVehicleEngineStatus] == true && !HasNoEngine(vehicleid))
		return SendErrorMessage(playerid, "กรุณาดับเครื่องยนต์ก่อน");

	if(VehicleInfo[vehicleid][eVehicleCarPark] == true)
		return SendErrorMessage(playerid, "คุณได้ทำการ park ยานพาหนะคุณไว้เรียบร้อยแล้ว");

	VehicleInfo[vehicleid][eVehicleCarPark] = true;
	GetVehiclePos(vehicleid, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2]);
	GetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][eVehicleParkPos][3]);
	VehicleInfo[vehicleid][eVehicleParkWorld] = GetVehicleVirtualWorld(vehicleid);


	
	SaveVehicle(vehicleid);
	//ResetVehicleVars(vehicleid);
	DestroyVehicle(vehicleid);	

	mysql_format(dbCon, threadLoad, sizeof(threadLoad), "SELECT * FROM vehicles WHERE VehicleDBID = %i", VehicleInfo[vehicleid][eVehicleDBID]);
	mysql_tquery(dbCon, threadLoad, "LoadVehicleCarpark", "i", playerid);

	TogglePlayerControllable(playerid, 1);
	SetVehicleParamsEx(vehicleid, engine, lights, alarm, true, bonnet, boot, objective);
	VehicleInfo[vehicleid][eVehicleLocked] = true;

	SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "You Park %s is now",  ReturnVehicleName(vehicleid));
	SendDiscordMessageEx("vehicle-park-get", "[%s] %s Park Vehicle %s(%d)",ReturnDate(), ReturnRealName(playerid), ReturnVehicleName(vehicleid), VehicleInfo[vehicleid][eVehicleDBID]);
	return 1;
}

forward LoadVehicleCarpark(playerid);
public LoadVehicleCarpark(playerid)
{
	if(!cache_num_rows())
		return SendErrorMessage(playerid, "ไม่มีรถอยู่ในสล็อตนี้"); 
		
	new rows; cache_get_row_count(rows); 
	new str[MAX_STRING], vehicleid = INVALID_VEHICLE_ID; 

	new VehicleModel,Float:VehicleParkPos[4],VehicleColor1,VehicleColor2, VehiclePaintjob;
	
	for (new i = 0; i < rows && i < MAX_VEHICLES; i++)
	{
		cache_get_value_name_int(i, "VehicleModel", VehicleModel);
		cache_get_value_name_float(i, "VehicleParkPosX", VehicleParkPos[0]);
		cache_get_value_name_float(i, "VehicleParkPosY", VehicleParkPos[1]);
		cache_get_value_name_float(i, "VehicleParkPosZ", VehicleParkPos[2]);
		cache_get_value_name_float(i, "VehicleParkPosA", VehicleParkPos[3]);
		cache_get_value_name_int(i, "VehicleColor1", VehicleColor1);
		cache_get_value_name_int(i, "VehicleColor2", VehicleColor2);
		cache_get_value_name_int(i, "VehiclePaintjob",VehiclePaintjob);

		vehicleid = CreateVehicle(VehicleModel, 
			VehicleParkPos[0],
			VehicleParkPos[1],
			VehicleParkPos[2],
			VehicleParkPos[3],
			VehicleColor1,
			VehicleColor2,
			VehiclePaintjob,
			0);
			
		if(vehicleid != INVALID_VEHICLE_ID)
		{
			VehicleInfo[vehicleid][eVehicleExists] = true; 
			cache_get_value_name_int(i, "VehicleDBID",VehicleInfo[vehicleid][eVehicleDBID]);
			
			cache_get_value_name(i, "VehicleName",VehicleInfo[vehicleid][eVehicleName]);
			cache_get_value_name_int(i, "VehicleOwnerDBID",VehicleInfo[vehicleid][eVehicleOwnerDBID]);
			cache_get_value_name_int(i, "VehicleFaction",VehicleInfo[vehicleid][eVehicleFaction]);
			
			cache_get_value_name_int(i, "VehicleModel",VehicleInfo[vehicleid][eVehicleModel]);
			
			cache_get_value_name_int(i, "VehicleColor1",VehicleInfo[vehicleid][eVehicleColor1]);
			cache_get_value_name_int(i, "VehicleColor2",VehicleInfo[vehicleid][eVehicleColor2]);
			
			cache_get_value_name_float(i, "VehicleParkPosX", VehicleInfo[vehicleid][eVehicleParkPos][0]);
			cache_get_value_name_float(i, "VehicleParkPosY", VehicleInfo[vehicleid][eVehicleParkPos][1]);
			cache_get_value_name_float(i, "VehicleParkPosZ", VehicleInfo[vehicleid][eVehicleParkPos][2]);
			cache_get_value_name_float(i, "VehicleParkPosA", VehicleInfo[vehicleid][eVehicleParkPos][3]);
			
			cache_get_value_name_int(i, "VehicleParkInterior",VehicleInfo[vehicleid][eVehicleParkInterior]);
			cache_get_value_name_int(i, "VehicleParkWorld",VehicleInfo[vehicleid][eVehicleParkWorld]);
			

			cache_get_value_name(i, "VehiclePlates",VehicleInfo[vehicleid][eVehiclePlates], 32);
			cache_get_value_name_int(i, "VehicleLocked",VehicleInfo[vehicleid][eVehicleLocked]);
			
			cache_get_value_name_int(i, "VehicleImpounded",VehicleInfo[vehicleid][eVehicleImpounded]);
			
			cache_get_value_name_float(i, "VehicleImpoundPosX", VehicleInfo[vehicleid][eVehicleImpoundPos][0]);
			cache_get_value_name_float(i, "VehicleImpoundPosY", VehicleInfo[vehicleid][eVehicleImpoundPos][1]);
			cache_get_value_name_float(i, "VehicleImpoundPosZ", VehicleInfo[vehicleid][eVehicleImpoundPos][2]);
			cache_get_value_name_float(i, "VehicleImpoundPosA", VehicleInfo[vehicleid][eVehicleImpoundPos][3]);
			
			cache_get_value_name_float(i, "VehicleFuel",VehicleInfo[vehicleid][eVehicleFuel]);
			
			cache_get_value_name_int(i, "VehicleXMR",VehicleInfo[vehicleid][eVehicleHasXMR]);
			cache_get_value_name_int(i, "VehicleTimesDestroyed",VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
			
			cache_get_value_name_float(i, "VehicleEngine",VehicleInfo[vehicleid][eVehicleEngine]);
			cache_get_value_name_float(i, "VehicleBattery",VehicleInfo[vehicleid][eVehicleBattery]);
			
			cache_get_value_name_int(i, "VehicleAlarmLevel",VehicleInfo[vehicleid][eVehicleAlarmLevel]);
			cache_get_value_name_int(i, "VehicleLockLevel",VehicleInfo[vehicleid][eVehicleLockLevel]);
			cache_get_value_name_int(i, "VehicleImmobLevel",VehicleInfo[vehicleid][eVehicleImmobLevel]);
			
			
			cache_get_value_name_int(i, "VehiclePaintjob",VehicleInfo[vehicleid][eVehiclePaintjob]);

			cache_get_value_name_int(i, "VehiclePrice",VehicleInfo[vehicleid][eVehiclePrice]);


			cache_get_value_name_int(i, "VehicleComp",VehicleInfo[vehicleid][eVehicleComp]);

			cache_get_value_name_float(i, "VehicleDrug1", VehicleInfo[vehicleid][eVehicleDrug][0]);
			cache_get_value_name_float(i, "VehicleDrug2", VehicleInfo[vehicleid][eVehicleDrug][1]);
			cache_get_value_name_float(i, "VehicleDrug3", VehicleInfo[vehicleid][eVehicleDrug][2]);

			for(new j = 0; j < 14; j++)
			{
				format(str, sizeof(str), "VehicleMod%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleMod][j]);
			}
			
			for(new j = 1; j < 6; j++)
			{
				format(str, sizeof(str), "VehicleWeapons%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleWeapons][j]);
				
				format(str, sizeof(str), "VehicleWeaponsAmmo%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleWeaponsAmmo][j]);
			}

			for(new j = 0; j < 4; j++)
			{
				format(str, sizeof(str), "VehicleDamage%d",i);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleDamage][j]);
			}

			cache_get_value_name_float(i, "VehicleHealth",VehicleInfo[vehicleid][eVehicleHealth]);

			//AddVehicleComponent(vehicleid, componentid);
			
			
			if(VehicleInfo[vehicleid][eVehicleParkInterior] != 0)
			{
				LinkVehicleToInterior(vehicleid, VehicleInfo[vehicleid][eVehicleParkInterior]); 
				SetVehicleVirtualWorld(vehicleid, VehicleInfo[vehicleid][eVehicleParkWorld]);
			}
			
			if(!isnull(VehicleInfo[vehicleid][eVehiclePlates]))
			{
				SetVehicleNumberPlate(vehicleid, VehicleInfo[vehicleid][eVehiclePlates]);
				SetVehicleToRespawn(vehicleid); 
			}
			
			if(VehicleInfo[vehicleid][eVehicleImpounded] == true)
			{
				SetVehiclePos(vehicleid, VehicleInfo[vehicleid][eVehicleImpoundPos][0], VehicleInfo[vehicleid][eVehicleImpoundPos][1], VehicleInfo[vehicleid][eVehicleImpoundPos][2]);
				SetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][eVehicleImpoundPos][3]); 
			}
			
			if(VehicleInfo[vehicleid][eVehicleLocked] == false)
				SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0);
				
			else SetVehicleParamsEx(vehicleid, 0, 0, 0, 1, 0, 0, 0);
			
			VehicleInfo[vehicleid][eVehicleAdminSpawn] = false;
			
			
			SetVehicleToRespawn(vehicleid); 
			SetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][eVehicleParkPos][3]);
			UpdateVehicleDamageStatus(vehicleid, VehicleInfo[vehicleid][eVehicleDamage][0], VehicleInfo[vehicleid][eVehicleDamage][1], VehicleInfo[vehicleid][eVehicleDamage][2],0);
			
			if(VehicleInfo[vehicleid][eVehicleHealth] < 310)
			{
				SetVehicleHp(vehicleid);
			}
			else
			{
				SetVehicleHealth(vehicleid, VehicleInfo[vehicleid][eVehicleHealth]);
			}
			
			if(HasNoEngine(playerid))
				ToggleVehicleEngine(vehicleid, true); 
			
			for(new j = 0; j < 14; j++)
			{
				AddVehicleComponent(vehicleid, VehicleInfo[vehicleid][eVehicleMod][j]);
			}

		}
	}
	
	VehicleInfo[vehicleid][eVehicleFaction] = 0;


	if(VehicleInfo[vehicleid][eVehicleImpounded]) 
	{
		SetPlayerCheckpoint(playerid, VehicleInfo[vehicleid][eVehicleImpoundPos][0], VehicleInfo[vehicleid][eVehicleImpoundPos][1], VehicleInfo[vehicleid][eVehicleImpoundPos][2], 3.0);
	}
	else
	{
		new Float:x, Float:y, Float:z, Float:a;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);

		SetVehiclePos(vehicleid, x, y, z);
		SetVehicleZAngle(vehicleid, a);
		PutPlayerInVehicle(playerid, vehicleid, 0);
	}
	return 1;
}

CMD:carget(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะ");

	new vehicleid = GetPlayerVehicleID(playerid);

	if(PlayerInfo[playerid][pDuplicateKey] != vehicleid && VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
		return SendErrorMessage(playerid, "คุณไม่มีกุญแจยานพาหนะคันนี้");

	if(VehicleInfo[vehicleid][eVehicleEngineStatus] == true)
		return SendErrorMessage(playerid, "กรุณาดับเครื่องยนต์ก่อน");

	if(VehicleInfo[vehicleid][eVehicleCarPark] == false)
		return SendErrorMessage(playerid, "ยานพาหนะคันนี้ถูก Carget อยู่แล้ว");

	VehicleInfo[vehicleid][eVehicleCarPark] = false;

	SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "You GetCar %s is now",  ReturnVehicleName(vehicleid));
	SendDiscordMessageEx("vehicle-park-get", "[%s] %s Get Vehicle %s(%d)",ReturnDate(), ReturnRealName(playerid), ReturnVehicleName(vehicleid), VehicleInfo[vehicleid][eVehicleDBID]);

	SaveVehicle(vehicleid);
	return 1;
}


CMD:vstats(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
	
	new vehicleid;

	if(!IsPlayerInAnyVehicle(playerid))
	{
		if(sscanf(params, "d", vehicleid))
			return SendUsageMessage(playerid, "/vstats <id>");

		
		if(!IsValidVehicle(vehicleid))
			return SendErrorMessage(playerid, "ไม่มีไอดีรถที่คุณต้องการ");


		if(VehicleInfo[vehicleid][eVehicleAdminSpawn] == true)
			return SendErrorMessage(playerid, "คุณไม่สามารถลบรถที่ไม่ใช่รถเสกได้"); 



		SendClientMessageEx(playerid, COLOR_WHITE, "เจ้าของรถ: %s", ReturnDBIDName(VehicleInfo[vehicleid][eVehicleOwnerDBID]));
		SendClientMessageEx(playerid, COLOR_WHITE, "Vehicle DBID: %d",VehicleInfo[vehicleid][eVehicleDBID]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Life Span: Engine Life[%.2f], Battery Life[%.2f], Times Destroyed[%i]", VehicleInfo[vehicleid][eVehicleEngine], VehicleInfo[vehicleid][eVehicleBattery], VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Security: Lock Level[%i], Alarm Level[%i], Immobilizer[%i]", VehicleInfo[vehicleid][eVehicleLockLevel], VehicleInfo[vehicleid][eVehicleAlarmLevel], VehicleInfo[vehicleid][eVehicleImmobLevel]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Misc: Primary Color[%d], Secondary Color[%d], License Plate[%s]",VehicleInfo[vehicleid][eVehicleColor1],VehicleInfo[vehicleid][eVehicleColor2], VehicleInfo[vehicleid][eVehiclePlates]);
		return 1;
	}
	else
	{
		vehicleid = GetPlayerVehicleID(playerid);

		
		SendClientMessageEx(playerid, COLOR_WHITE, "เจ้าของรถ: %s", ReturnDBIDName(VehicleInfo[vehicleid][eVehicleOwnerDBID]));
		SendClientMessageEx(playerid, COLOR_WHITE, "Vehicle DBID: %d",VehicleInfo[vehicleid][eVehicleDBID]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Life Span: Engine Life[%.2f], Battery Life[%.2f], Times Destroyed[%i]", VehicleInfo[vehicleid][eVehicleEngine], VehicleInfo[vehicleid][eVehicleBattery], VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Security: Lock Level[%i], Alarm Level[%i], Immobilizer[%i]", VehicleInfo[vehicleid][eVehicleLockLevel], VehicleInfo[vehicleid][eVehicleAlarmLevel], VehicleInfo[vehicleid][eVehicleImmobLevel]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Misc: Primary Color[%d], Secondary Color[%d], License Plate[%s]",VehicleInfo[vehicleid][eVehicleColor1],VehicleInfo[vehicleid][eVehicleColor2], VehicleInfo[vehicleid][eVehiclePlates]);
	}
	return 1;
}



Dialog:D_VEHUPGRADE(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	new str[255], longstr[255];

	switch(listitem)
	{
		case 0:
		{
			for(new i = 1; i < 4; i++)
			{
				format(str, sizeof(str), "Lock Level: %d - {F4D03F}$%s\n",i,MoneyFormat(2000*i));
				strcat(longstr, str);
			}

			Dialog_Show(playerid, D_VEHUPGRADE_LOCK, DIALOG_STYLE_LIST, "VEHICLE: UPGRADE LOCK", longstr, "เลือก", "ออก");
		}
		case 1:
		{
			for(new i = 1; i < 4; i++)
			{
				format(str, sizeof(str), "Alarm Level: %d - {F4D03F}$%s\n",i,MoneyFormat(5000*i));
				strcat(longstr, str);
			}

			Dialog_Show(playerid, D_VEHUPGRADE_ALARM, DIALOG_STYLE_LIST, "VEHICLE: UPGRADE ALARM", longstr, "เลือก", "ออก");
		}
	}
	return 1;
}

Dialog:D_VEHUPGRADE_LOCK(playerid, response, listitem, inputtext[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะ");

	new id = IsPlayerNearBusiness(playerid);
		
	if(id == 0)
		return SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้ร้านตัวแทนจำหน่ายรถ");

	if(BusinessInfo[id][BusinessType] != 2)
		return SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้ร้านตัวแทนจำหน่ายรถ");



	new level = listitem+1, vehicleid = GetPlayerVehicleID(playerid);

	if(!response)
	{
		new str[255], longstr[255];

		format(str, sizeof(str), "LockLevel: %d\n",VehicleInfo[vehicleid][eVehicleLockLevel]);
		strcat(longstr, str);
		format(str, sizeof(str), "AlarmLevel: %d\n",VehicleInfo[vehicleid][eVehicleAlarmLevel]);
		strcat(longstr, str);
		
		Dialog_Show(playerid, D_VEHUPGRADE, DIALOG_STYLE_LIST, "VEHICLE: UPGRADE", longstr, "เลือก", "ออก");
		return 1;
	}

	if(PlayerInfo[playerid][pCash] < 2000 * level)
		return SendErrorMessage(playerid, "คุณมีจำนวนเงินไม่เพียงพอ (ยังขาดอีก: $%s)", MoneyFormat(2000 * level - PlayerInfo[playerid][pCash]));

	VehicleInfo[vehicleid][eVehicleLockLevel] = level;
	GiveMoney(playerid, -2000 * level);
	
	new Float:tax = (2000 * level) * 0.07;

	GlobalInfo[G_GovCash] += floatround(Float:tax, floatround_round);
	BusinessInfo[id][BusinessCash] += (2000 * level) - tax;

	SendClientMessageEx(playerid, COLOR_HELPME, "คุณได้อัพเกรด การล็อค ยานพาหนะ %s ของคุณไปเลเวล %d พร้อมกับเสียงเงินจำนวน $%s",ReturnVehicleName(vehicleid), level, MoneyFormat(2000 * level));
	CharacterSave(playerid);
	SaveVehicle(vehicleid);
	SaveBusiness(id);
	Saveglobal();
	return 1;
}

Dialog:D_VEHUPGRADE_ALARM(playerid, response, listitem, inputtext[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะ");

	new id = IsPlayerNearBusiness(playerid);
		
	if(id == 0)
		return SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้ร้านตัวแทนจำหน่ายรถ");

	if(BusinessInfo[id][BusinessType] != 2)
		return SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้ร้านตัวแทนจำหน่ายรถ");

	new level = listitem+1, vehicleid = GetPlayerVehicleID(playerid);

	if(!response)
	{
		new str[255], longstr[255];

		format(str, sizeof(str), "LockLevel: %d\n",VehicleInfo[vehicleid][eVehicleLockLevel]);
		strcat(longstr, str);
		format(str, sizeof(str), "AlarmLevel: %d\n",VehicleInfo[vehicleid][eVehicleAlarmLevel]);
		strcat(longstr, str);
		
		Dialog_Show(playerid, D_VEHUPGRADE, DIALOG_STYLE_LIST, "VEHICLE: UPGRADE", longstr, "เลือก", "ออก");
		return 1;
	}

	if(PlayerInfo[playerid][pCash] < 5000 * level)
		return SendErrorMessage(playerid, "คุณมีจำนวนเงินไม่เพียงพอ (ยังขาดอีก: $%s)", MoneyFormat(5000 * level - PlayerInfo[playerid][pCash]));
	
	new Float:tax = (5000 * level) * 0.07;

	GlobalInfo[G_GovCash] += floatround(Float:tax, floatround_round);
	BusinessInfo[id][BusinessCash] += (5000 * level) - tax;


	VehicleInfo[vehicleid][eVehicleAlarmLevel] = level;
	GiveMoney(playerid, -5000 * level);
	SendClientMessageEx(playerid, COLOR_HELPME, "คุณได้อัพเกรด การแจ้งเตือน ยานพาหนะ %s ของคุณไปเลเวล %d พร้อมกับเสียงเงินจำนวน $%s",ReturnVehicleName(vehicleid), level, MoneyFormat(5000 * level));
	CharacterSave(playerid);
	SaveVehicle(vehicleid);
	SaveBusiness(id);
	Saveglobal();
	return 1;
}

CMD:lights(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
		
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ภายในรถ");
			
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "คุณไม่ได้เป็นคนขับ");
		
	if(VehicleInfo[vehicleid][eVehicleLights] == false)
	{
		ToggleVehicleLights(vehicleid, true);
	}		
	else ToggleVehicleLights(vehicleid, false);

	return 1;
}

CMD:trunk(playerid, params[])
{
	new
		Float:x,
		Float:y,
		Float:z
	;
		
	new engine, lights, alarm, doors, bonnet, boot, objective;
	
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
	{
		GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
			
		new 
			vehicleid = GetNearestVehicle(playerid)
		;
		new str[MAX_STRING];
				
		if(VehicleInfo[vehicleid][eVehicleLocked])
			return SendServerMessage(playerid, "รถคันนี้ถูกล็อคอยู่"); 
			
		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ฝากระโปรงท้ายรถ");
			
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
		if(!boot)
		{

			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 1, objective);
				
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้ทำการเปิดฝากระโปรงท้ายรถ");
			SendClientMessage(playerid, COLOR_WHITE, "สามารถพิมพ์ /check หรือ /place ได้");

			format(str, sizeof(str), "* %s ได้เปิดฝากระโปรงรถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
		else
		{

			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 0, objective);
				
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้ปิดฝากระโปรงท้ายรถ");

			format(str, sizeof(str), "* %s ได้ปิดฝากระโปรงรถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		new
			vehicleid = GetPlayerVehicleID(playerid)
		;
		new str[MAX_STRING];
			
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendErrorMessage(playerid, "คุณไม่ได้เป็นคนขับ");
			
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
		if(!boot)
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 1, objective);
				
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้ทำการเปิดฝากระโปรงท้ายรถ");
			SendClientMessage(playerid, COLOR_WHITE, "สามารถพิมพ์ /check หรือ /place ได้"); 

			format(str, sizeof(str), "* %s ได้เปิดฝากระโปรงรถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
		else
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 0, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้ปิดฝากระโปรงท้ายรถ");

			format(str, sizeof(str), "* %s ได้ปิดฝากระโปรงรถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
	}
	else SendErrorMessage(playerid, "คุณได้อยู่ใกล้/ในรถ ของคุณ");
	return 1;
}

CMD:hood(playerid, params[])
{
	new
		Float:x,
		Float:y,
		Float:z
	;

	new str[MAX_STRING];
		
	new engine, lights, alarm, doors, bonnet, boot, objective;
	
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
	{
		GetVehicleHood(GetNearestVehicle(playerid), x, y, z); 
			
		new 
			vehicleid = GetNearestVehicle(playerid)
		;
				
		if(VehicleInfo[vehicleid][eVehicleLocked])
			return SendServerMessage(playerid, "รถคันนี้ถูกล็อคอยู่"); 
			
		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ฝากระโปรงหน้ารถ");
			
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
		if(!bonnet)
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 1, boot, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เปิดฝากระโปรงหน้ารถ");

			format(str, sizeof(str), "* %s ได้เปิดฝากระโปรงหน้ารถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
		else
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 0, boot, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เปิดฝากระโปรงหน้ารถ");

			format(str, sizeof(str), "* %s ได้ปิดฝากระโปรงหน้ารถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		new
			vehicleid = GetPlayerVehicleID(playerid)
		;
				
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendErrorMessage(playerid, "คุณไม่ได้เป็นคนขับ");
				
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
		if(!bonnet)
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 1, boot, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เปิดฝากระโปรงหน้ารถ");

			format(str, sizeof(str), "* %s ได้เปิดฝากระโปรงหน้ารถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
		else
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 0, boot, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เปิดฝากระโปรงหน้ารถ");

			format(str, sizeof(str), "* %s ได้ปิดฝากระโปรงหน้ารถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
	}
	else return SendServerMessage(playerid, "คุณไม่ได้อยู่ใกล้รถ");
	return 1;
}




alias:rollwindow("rw")
CMD:rollwindow(playerid, params[])
{
	if (!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GRAD2, "คุณต้องอยู่ในพาหนะเพื่อใช้สิ่งนี้ !");

	new vehicleid = GetPlayerVehicleID(playerid);
	if (!IsDoorVehicle(vehicleid)) return SendClientMessage(playerid, COLOR_GRAD2, "พาหนะนี้ไม่มีหน้าต่าง");

	new item[16];

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	  	if(sscanf(params, "s[32]", item)) {
	  	    SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ]"EMBED_WHITE" TIP: เมื่อเป็นคนขับ คุณสามารถระบุหน้าต่างที่จะเปิดได้");
			SendClientMessage(playerid, COLOR_LIGHTRED, "การใช้: "EMBED_WHITE"/rollwindow [all/frontleft(fl)/frontright(fr)/rearleft(rl)/rearright(rr)]");
		}
		else
		{
			new wdriver, wpassenger, wbackleft, wbackright;
			GetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, wbackright);

			if(strcmp(item, "all", true) == 0)
			{
			    if(wdriver == VEHICLE_PARAMS_OFF)
			    {
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, 1, 1, 1, 1);
				}
				else if(wdriver == VEHICLE_PARAMS_ON || wdriver == VEHICLE_PARAMS_UNSET)
				{
		    		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, 0, 0, 0, 0);
				}
			}
			else if(strcmp(item, "frontleft", true) == 0 || strcmp(item, "fl", true) == 0)
			{
			    if(wdriver == VEHICLE_PARAMS_OFF)
			    {
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, 1, wpassenger, wbackleft, wbackright);
				}
				else if(wdriver == VEHICLE_PARAMS_ON || wdriver == VEHICLE_PARAMS_UNSET)
				{
		    		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, 0, wpassenger, wbackleft, wbackright);
				}
			}
			else if(strcmp(item, "frontright", true) == 0 || strcmp(item, "fr", true) == 0)
			{
			    if(wpassenger == VEHICLE_PARAMS_OFF)
			    {
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, wdriver, 1, wbackleft, wbackright);
				}
				else if(wpassenger == VEHICLE_PARAMS_ON || wpassenger == VEHICLE_PARAMS_UNSET)
				{
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, wdriver, 0, wbackleft, wbackright);
				}
			}
			else if(strcmp(item, "rearleft", true) == 0 || strcmp(item, "rl", true) == 0)
			{
	      		if(wbackleft == VEHICLE_PARAMS_OFF)
			    {
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, 1, wbackright);
				}
				else if(wbackleft == VEHICLE_PARAMS_ON || wbackleft == VEHICLE_PARAMS_UNSET)
				{
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, 0, wbackright);
				}
			}
			else if(strcmp(item, "rearright", true) == 0 || strcmp(item, "rr", true) == 0)
			{
			    if(wbackright == VEHICLE_PARAMS_OFF)
			    {
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, 1);
				}
				else if(wbackright == VEHICLE_PARAMS_ON || wbackright == VEHICLE_PARAMS_UNSET)
				{
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, 0);
				}
			}
			else SendErrorMessage(playerid, "คุณพิพม์ไม่ถูกต้อง");
		}
	}
	else if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
		new iSeat = GetPlayerVehicleSeat(playerid);
		new wdriver, wpassenger, wbackleft, wbackright;
		GetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, wbackright);

		if(iSeat == 128) return SendClientMessage(playerid, COLOR_LIGHTRED, "เกิดข้อผิดพลาดเกี่ยวกับหมายเลขที่นั่ง");

		if(iSeat == 1)
		{
			if(wpassenger == VEHICLE_PARAMS_OFF)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, 1, wbackleft, wbackright);
			}
			else if(wpassenger == VEHICLE_PARAMS_ON || wpassenger == VEHICLE_PARAMS_UNSET)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, 0, wbackleft, wbackright);
			}
		}
		else if(iSeat == 2)
		{
			if(wbackleft == VEHICLE_PARAMS_OFF)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, 1, wbackright);
			}
			else if(wbackleft == VEHICLE_PARAMS_ON || wbackleft == VEHICLE_PARAMS_UNSET)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, 0, wbackright);
			}
		}
		else if(iSeat == 3)
		{
			if(wbackright == VEHICLE_PARAMS_OFF)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, 1);
			}
			else if(wbackright == VEHICLE_PARAMS_ON || wbackright == VEHICLE_PARAMS_UNSET)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, 0);
			}
		}
	}
	else SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะ");
	return 1;
}

CMD:sitin(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะ");

	new vehicleid = GetPlayerVehicleID(playerid);

	if(HasNoEngine(vehicleid))
		return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งนี้กับยานพาหนะนี้ได้");


	new seatid = GetPlayerVehicleSeat(playerid);

	PutPlayerInVehicle(playerid, vehicleid, seatid);
	return 1;
}

alias:changevehiclename("changvehname")
CMD:changevehiclename(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะ");

	new vehicleid = GetPlayerVehicleID(playerid);

	if(PlayerInfo[playerid][pTester] < 3 && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "สำหรับผู้ดูแล โปรดติดต่อผู้ดูแลให้ทำการเปลี่ยนชื่อยานพาหนะให้คุณ");

	if(VehicleInfo[vehicleid][eVehicleFaction])
		return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งนี้กับยานพาหนะของแฟคชั่นได้");

	new Newname[35];
	if(sscanf(params, "s[35]", Newname))
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "คุณสามารถตั้งชื่อยานพาหนะของคุณได้แต่จำเป็นจะต้องคำนึงถึงสภาพความเป็นจริงของยานพาหนะด้วย");
		SendClientMessage(playerid, COLOR_LIGHTRED, "หากมีการตั้งชื่อยานพาหนะที่ไม่เหมาะสมกับตัวของยานพาหนะ เราจะทำการลบชื่อของยานพาหนะและลงโทษตามกฎ");
		SendUsageMessage(playerid, "/changevehiclename <name:>");
	}

	if(strlen(Newname) < 5 || strlen(Newname) > 35)
		return SendErrorMessage(playerid, "คุณตั้งชื่อไม่ถูกต้องกรุณาตั้งชื่อใหม่");

	format(VehicleInfo[vehicleid][eVehicleName], 35, "%s",Newname);
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "คุณได้เปลี่ยนชื่อยานพาหนะของคุณเป็น %s เรียบร้อยแล้ว",Newname);
	SaveVehicle(vehicleid);
	return 1;
}

stock ShowVehicleList(playerid)
{
	new thread[MAX_STRING];

	SendClientMessageEx(playerid, COLOR_DARKGREEN, "_________________Your vehicles(%i)_________________", CountPlayerVehicles(playerid));

	if(PlayerInfo[playerid][pDonater] == 2)
	{
		for(new i = 1; i < MAX_PLAYER_VEHICLES_V2; i++)
		{
			if(PlayerInfo[playerid][pOwnedVehicles][i])
			{
				mysql_format(dbCon, thread, sizeof(thread), "SELECT * FROM vehicles WHERE VehicleDBID = %i", PlayerInfo[playerid][pOwnedVehicles][i]);
				mysql_tquery(dbCon, thread, "Query_ShowVehicleList", "ii", playerid, i);
			}
		}
	}
	else if(PlayerInfo[playerid][pDonater] == 3)
	{
		for(new i = 1; i < MAX_PLAYER_VEHICLES_V3; i++)
		{
			if(PlayerInfo[playerid][pOwnedVehicles][i])
			{
				mysql_format(dbCon, thread, sizeof(thread), "SELECT * FROM vehicles WHERE VehicleDBID = %i", PlayerInfo[playerid][pOwnedVehicles][i]);
				mysql_tquery(dbCon, thread, "Query_ShowVehicleList", "ii", playerid, i);
			}
		}
	}
	else
	{
		for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
		{
			if(PlayerInfo[playerid][pOwnedVehicles][i])
			{
				mysql_format(dbCon, thread, sizeof(thread), "SELECT * FROM vehicles WHERE VehicleDBID = %i", PlayerInfo[playerid][pOwnedVehicles][i]);
				mysql_tquery(dbCon, thread, "Query_ShowVehicleList", "ii", playerid, i);
			}
		}
	}

	return 1;
}

stock CountPlayerVehicles(playerid)
{
	new
		count = 0
	;
	
	for(new i = 1; i < 12; i++)
	{
		if(PlayerInfo[playerid][pOwnedVehicles][i])
		{
			count++;
		}
	}
	return count;
}

forward Query_ShowVehicleList(playerid, idx);
public Query_ShowVehicleList(playerid, idx)
{
	new rows; cache_get_row_count(rows);

	new
		vehicleDBID,
		vehicleModel,
		vehicleLockLevel,
		vehicleAlarmLevel,
		vehicleImmobLevel,
		vehicleTimesDestroyed,
		vehiclePlates[32],
		bool:isSpawned = false
	;

	for(new i = 0; i < rows; i++)
	{
		cache_get_value_name_int(0,"VehicleDBID",vehicleDBID);
		cache_get_value_name_int(0,"VehicleModel",vehicleModel);

		cache_get_value_name_int(0,"VehicleLockLevel",vehicleLockLevel);
		cache_get_value_name_int(0,"VehicleAlarmLevel",vehicleAlarmLevel);
		cache_get_value_name_int(0,"VehicleImmobLevel",vehicleImmobLevel);

		cache_get_value_name_int(0,"VehicleTimesDestroyed",vehicleTimesDestroyed);

		cache_get_value_name(0,"VehiclePlates",vehiclePlates,32);
	}

	new v_id;
	for(new id = 0; id < MAX_VEHICLES; id++)
	{
		if(VehicleInfo[id][eVehicleDBID] == vehicleDBID)
		{
			isSpawned = true;
			v_id = id;
		}
	}

	if(isSpawned)
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "[ID: %d] Vehicle %i: %s, Lock[%i], Alarm[%i], Immobiliser[%i], Times destroyed[%i], Plates[%s]", v_id, idx, ReturnVehicleModelName(vehicleModel), vehicleLockLevel, vehicleAlarmLevel, vehicleImmobLevel, vehicleTimesDestroyed, vehiclePlates);

	else SendClientMessageEx(playerid, COLOR_WHITE, "Vehicle %i: %s, Lock[%i], Alarm[%i], Immobiliser[%i], Times destroyed[%i], Plates[%s]", idx, ReturnVehicleModelName(vehicleModel), vehicleLockLevel, vehicleAlarmLevel, vehicleImmobLevel, vehicleTimesDestroyed, vehiclePlates);

	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	if(HasNoEngine(vehicleid))
		ToggleVehicleEngine(vehicleid, true);
	
	SetVehicleHp(vehicleid);

	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, objective);
	VehicleInfo[vehicleid][eVehicleLocked] = false;
	VehicleInfo[vehicleid][eVehicleElmTimer] = -1;
	VehicleSiren[vehicleid] = INVALID_OBJECT_ID;
	return 1;
}

stock SetVehicleHp(vehicleid)
{
	new modelid = GetVehicleModel(vehicleid);
	SetVehicleHealth(vehicleid, VehicleData[modelid - 400][c_max_health]);
	return 1;
}

timer OnVehicleAlarm[5000](vehicleid)
{
	return ToggleVehicleAlarms(vehicleid, false);
}

stock NotifyVehicleOwner(vehicleid)
{
	new playerid = INVALID_PLAYER_ID;

	foreach(new i : Player)
	{
		if(PlayerInfo[i][pDBID] == VehicleInfo[vehicleid][eVehicleOwnerDBID])
		{
			return SendClientMessage(playerid, COLOR_YELLOW2, "SMS: สัญญาณเตือนภัยยานพาหนะของคุณดังขึ้น, ผู้ส่ง: สัญญาณเตือนภัยของยานพาหนะ (ไม่ทราบ)");
		}
	}
	return 0;
}


forward LoadFactionVehicle();
public LoadFactionVehicle()
{
	if(!cache_num_rows())
		return print("[SERVER]: No Vehicle Faction In Database");

	new rows; cache_get_row_count(rows);
	new vehicleid = INVALID_VEHICLE_ID, amout_veh;

	new VehicleModel,Float:VehicleParkPos[4],VehicleColor1,VehicleColor2, VehicleFaction;

	for (new i = 0; i < rows && i < MAX_FACTION_VEHICLE; i++)
	{
		cache_get_value_name_int(i, "VehicleModel", VehicleModel);
		cache_get_value_name_float(i, "VehicleParkPosX", VehicleParkPos[0]);
		cache_get_value_name_float(i, "VehicleParkPosY", VehicleParkPos[1]);
		cache_get_value_name_float(i, "VehicleParkPosZ", VehicleParkPos[2]);
		cache_get_value_name_float(i, "VehicleParkPosA", VehicleParkPos[3]);
		cache_get_value_name_int(i, "VehicleColor1", VehicleColor1);
		cache_get_value_name_int(i, "VehicleColor2", VehicleColor2);


		cache_get_value_name_int(i, "VehicleFaction",VehicleFaction);

		if(FactionInfo[VehicleFaction][eFactionType] != 2)
		{
			vehicleid = CreateVehicle(VehicleModel, 
			VehicleParkPos[0],
			VehicleParkPos[1],
			VehicleParkPos[2],
			VehicleParkPos[3],
			VehicleColor1,
			VehicleColor2,
			-1,
			0);
		}
		else
		{
			vehicleid = CreateVehicle(VehicleModel, 
			VehicleParkPos[0],
			VehicleParkPos[1],
			VehicleParkPos[2],
			VehicleParkPos[3],
			VehicleColor1,
			VehicleColor2,
			-1,
			1);
		}

		if(vehicleid != INVALID_VEHICLE_ID)
		{
			//VehicleInfo[vehicleid][eVehicleExists] = true; 

			cache_get_value_name_int(i, "VehicleDBID",VehicleInfo[vehicleid][eVehicleDBID]);

			cache_get_value_name_int(i, "VehicleFaction",VehicleInfo[vehicleid][eVehicleFaction]);
			
			cache_get_value_name_int(i, "VehicleModel",VehicleInfo[vehicleid][eVehicleModel]);
			
			cache_get_value_name_int(i, "VehicleColor1",VehicleInfo[vehicleid][eVehicleColor1]);
			cache_get_value_name_int(i, "VehicleColor2",VehicleInfo[vehicleid][eVehicleColor2]);
			
			cache_get_value_name_float(i, "VehicleParkPosX", VehicleInfo[vehicleid][eVehicleParkPos][0]);
			cache_get_value_name_float(i, "VehicleParkPosY", VehicleInfo[vehicleid][eVehicleParkPos][1]);
			cache_get_value_name_float(i, "VehicleParkPosZ", VehicleInfo[vehicleid][eVehicleParkPos][2]);
			cache_get_value_name_float(i, "VehicleParkPosA", VehicleInfo[vehicleid][eVehicleParkPos][3]);
			
			cache_get_value_name_int(i, "VehicleParkWorld",VehicleInfo[vehicleid][eVehicleParkWorld]);

			VehicleInfo[vehicleid][eVehicleFuel] = 100;
		}

		SetVehicleNumberPlate(vehicleid, FactionInfo[VehicleInfo[vehicleid][eVehicleFaction]][eFactionAbbrev]);
		
		VehicleInfo[vehicleid][eVehiclePlates] = FactionInfo[VehicleInfo[vehicleid][eVehicleFaction]][eFactionAbbrev];
		SetVehicleToRespawn(vehicleid);
		SetVehicleHp(vehicleid);
		
		new engine, lights, alarm, doors, bonnet, boot, objective; 
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(vehicleid, engine, lights, alarm, false, bonnet, false, objective);
		
		VehicleInfo[vehicleid][eVehicleLocked] = false;
		VehicleInfo[vehicleid][eVehicleElmTimer] = -1;
		VehicleSiren[vehicleid] = INVALID_OBJECT_ID;
		amout_veh++;
	}

	printf("[SERVER]: %d Vehicle Faction In Database...", amout_veh);
	return 1;
}


forward LoadCarPark();
public LoadCarPark()
{
	if(!cache_num_rows())
		return print("[SERVER]: No Vehicle Faction In Database");

	new rows; cache_get_row_count(rows);
	new vehicleid = INVALID_VEHICLE_ID, str[255];

	new VehicleModel,Float:VehicleParkPos[4],VehicleColor1,VehicleColor2, VehiclePaintjob;

	for (new i = 0; i < rows && i < MAX_FACTION_VEHICLE; i++)
	{
		cache_get_value_name_int(i, "VehicleModel", VehicleModel);
		cache_get_value_name_float(i, "VehicleParkPosX", VehicleParkPos[0]);
		cache_get_value_name_float(i, "VehicleParkPosY", VehicleParkPos[1]);
		cache_get_value_name_float(i, "VehicleParkPosZ", VehicleParkPos[2]);
		cache_get_value_name_float(i, "VehicleParkPosA", VehicleParkPos[3]);
		cache_get_value_name_int(i, "VehicleColor1", VehicleColor1);
		cache_get_value_name_int(i, "VehicleColor2", VehicleColor2);
		cache_get_value_name_int(i, "VehiclePaintjob",VehiclePaintjob);

		vehicleid = CreateVehicle(VehicleModel, 
		VehicleParkPos[0],
		VehicleParkPos[1],
		VehicleParkPos[2],
		VehicleParkPos[3],
		VehicleColor1,
		VehicleColor2,
		VehiclePaintjob,
		1);

		if(vehicleid != INVALID_VEHICLE_ID)
		{
			VehicleInfo[vehicleid][eVehicleExists] = true; 
			cache_get_value_name_int(i, "VehicleDBID",VehicleInfo[vehicleid][eVehicleDBID]);
			
			cache_get_value_name(i, "VehicleName",VehicleInfo[vehicleid][eVehicleName]);
			cache_get_value_name_int(i, "VehicleCarPark",VehicleInfo[vehicleid][eVehicleCarPark]);
			cache_get_value_name_int(i, "VehicleOwnerDBID",VehicleInfo[vehicleid][eVehicleOwnerDBID]);
			cache_get_value_name_int(i, "VehicleFaction",VehicleInfo[vehicleid][eVehicleFaction]);
			
			cache_get_value_name_int(i, "VehicleModel",VehicleInfo[vehicleid][eVehicleModel]);
			
			cache_get_value_name_int(i, "VehicleColor1",VehicleInfo[vehicleid][eVehicleColor1]);
			cache_get_value_name_int(i, "VehicleColor2",VehicleInfo[vehicleid][eVehicleColor2]);
			
			cache_get_value_name_float(i, "VehicleParkPosX", VehicleInfo[vehicleid][eVehicleParkPos][0]);
			cache_get_value_name_float(i, "VehicleParkPosY", VehicleInfo[vehicleid][eVehicleParkPos][1]);
			cache_get_value_name_float(i, "VehicleParkPosZ", VehicleInfo[vehicleid][eVehicleParkPos][2]);
			cache_get_value_name_float(i, "VehicleParkPosA", VehicleInfo[vehicleid][eVehicleParkPos][3]);
			
			cache_get_value_name_int(i, "VehicleParkInterior",VehicleInfo[vehicleid][eVehicleParkInterior]);
			cache_get_value_name_int(i, "VehicleParkWorld",VehicleInfo[vehicleid][eVehicleParkWorld]);
			

			cache_get_value_name(i, "VehiclePlates",VehicleInfo[vehicleid][eVehiclePlates], 32);
			cache_get_value_name_int(i, "VehicleLocked",VehicleInfo[vehicleid][eVehicleLocked]);
			
			cache_get_value_name_int(i, "VehicleImpounded",VehicleInfo[vehicleid][eVehicleImpounded]);
			
			cache_get_value_name_float(i, "VehicleImpoundPosX", VehicleInfo[vehicleid][eVehicleImpoundPos][0]);
			cache_get_value_name_float(i, "VehicleImpoundPosY", VehicleInfo[vehicleid][eVehicleImpoundPos][1]);
			cache_get_value_name_float(i, "VehicleImpoundPosZ", VehicleInfo[vehicleid][eVehicleImpoundPos][2]);
			cache_get_value_name_float(i, "VehicleImpoundPosA", VehicleInfo[vehicleid][eVehicleImpoundPos][3]);
			
			cache_get_value_name_float(i, "VehicleFuel",VehicleInfo[vehicleid][eVehicleFuel]);
			
			cache_get_value_name_int(i, "VehicleXMR",VehicleInfo[vehicleid][eVehicleHasXMR]);
			cache_get_value_name_int(i, "VehicleTimesDestroyed",VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
			
			cache_get_value_name_float(i, "VehicleEngine",VehicleInfo[vehicleid][eVehicleEngine]);
			cache_get_value_name_float(i, "VehicleBattery",VehicleInfo[vehicleid][eVehicleBattery]);
			
			cache_get_value_name_int(i, "VehicleAlarmLevel",VehicleInfo[vehicleid][eVehicleAlarmLevel]);
			cache_get_value_name_int(i, "VehicleLockLevel",VehicleInfo[vehicleid][eVehicleLockLevel]);
			cache_get_value_name_int(i, "VehicleImmobLevel",VehicleInfo[vehicleid][eVehicleImmobLevel]);
			
			
			cache_get_value_name_int(i, "VehiclePaintjob",VehicleInfo[vehicleid][eVehiclePaintjob]);

			cache_get_value_name_int(i, "VehiclePrice",VehicleInfo[vehicleid][eVehiclePrice]);


			cache_get_value_name_int(i, "VehicleComp",VehicleInfo[vehicleid][eVehicleComp]);

			cache_get_value_name_float(i, "VehicleDrug1", VehicleInfo[vehicleid][eVehicleDrug][0]);
			cache_get_value_name_float(i, "VehicleDrug2", VehicleInfo[vehicleid][eVehicleDrug][1]);
			cache_get_value_name_float(i, "VehicleDrug3", VehicleInfo[vehicleid][eVehicleDrug][2]);

			for(new j = 0; j < 14; j++)
			{
				format(str, sizeof(str), "VehicleMod%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleMod][j]);
			}
			
			for(new j = 1; j < 6; j++)
			{
				format(str, sizeof(str), "VehicleWeapons%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleWeapons][j]);
				
				format(str, sizeof(str), "VehicleWeaponsAmmo%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleWeaponsAmmo][j]);
			}

			for(new j = 0; j < 4; j++)
			{
				format(str, sizeof(str), "VehicleDamage%d",j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleDamage][j]);
			}

			cache_get_value_name_float(i, "VehicleHealth",VehicleInfo[vehicleid][eVehicleHealth]);

			//AddVehicleComponent(vehicleid, componentid);
			
			
			if(VehicleInfo[vehicleid][eVehicleParkInterior] != 0)
			{
				LinkVehicleToInterior(vehicleid, VehicleInfo[vehicleid][eVehicleParkInterior]); 
				SetVehicleVirtualWorld(vehicleid, VehicleInfo[vehicleid][eVehicleParkWorld]);
			}
			
			if(!isnull(VehicleInfo[vehicleid][eVehiclePlates]))
			{
				SetVehicleNumberPlate(vehicleid, VehicleInfo[vehicleid][eVehiclePlates]);
				SetVehicleToRespawn(vehicleid); 
			}
			
			if(VehicleInfo[vehicleid][eVehicleImpounded] == true)
			{
				SetVehiclePos(vehicleid, VehicleInfo[vehicleid][eVehicleImpoundPos][0], VehicleInfo[vehicleid][eVehicleImpoundPos][1], VehicleInfo[vehicleid][eVehicleImpoundPos][2]);
				SetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][eVehicleImpoundPos][3]); 
			}
			
			if(VehicleInfo[vehicleid][eVehicleLocked] == false)
				SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0);
				
			else SetVehicleParamsEx(vehicleid, 0, 0, 0, 1, 0, 0, 0);
			
			VehicleInfo[vehicleid][eVehicleAdminSpawn] = false;
			
			
			SetVehicleToRespawn(vehicleid); 
			SetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][eVehicleParkPos][3]);
			UpdateVehicleDamageStatus(vehicleid, VehicleInfo[vehicleid][eVehicleDamage][0], VehicleInfo[vehicleid][eVehicleDamage][1], VehicleInfo[vehicleid][eVehicleDamage][2],0);
			
			if(VehicleInfo[vehicleid][eVehicleHealth] < 310)
			{
				SetVehicleHp(vehicleid);
			}
			else
			{
				SetVehicleHealth(vehicleid, VehicleInfo[vehicleid][eVehicleHealth]);
			}
		
			
			for(new j = 0; j < 14; j++)
			{
				AddVehicleComponent(vehicleid, VehicleInfo[vehicleid][eVehicleMod][j]);
			}

			VehicleInfo[vehicleid][eVehicleLocked] = true;
			SetVehicleParamsEx(vehicleid, 0, 0, 0, 1, 0, 0, 0);

		}
	}
	return 1;
}


stock SetVehicleComponent(vehicleid)
{
	for(new j = 0; j < 14; j++)
	{
		AddVehicleComponent(vehicleid, VehicleInfo[vehicleid][eVehicleMod][j]);
	}

	return 1;
}

forward Query_LoadPrivateVehicle(playerid);
public Query_LoadPrivateVehicle(playerid)
{
	if(!cache_num_rows())
		return SendErrorMessage(playerid, "ไม่มีรถอยู่ในสล็อตนี้"); 
		
	new rows; cache_get_row_count(rows); 
	new str[MAX_STRING], vehicleid = INVALID_VEHICLE_ID; 

	new VehicleModel,Float:VehicleParkPos[4],VehicleColor1,VehicleColor2, VehiclePaintjob;
	
	for (new i = 0; i < rows && i < MAX_VEHICLES; i++)
	{
		cache_get_value_name_int(i, "VehicleModel", VehicleModel);
		cache_get_value_name_float(i, "VehicleParkPosX", VehicleParkPos[0]);
		cache_get_value_name_float(i, "VehicleParkPosY", VehicleParkPos[1]);
		cache_get_value_name_float(i, "VehicleParkPosZ", VehicleParkPos[2]);
		cache_get_value_name_float(i, "VehicleParkPosA", VehicleParkPos[3]);
		cache_get_value_name_int(i, "VehicleColor1", VehicleColor1);
		cache_get_value_name_int(i, "VehicleColor2", VehicleColor2);
		cache_get_value_name_int(i, "VehiclePaintjob",VehiclePaintjob);

		vehicleid = CreateVehicle(VehicleModel, 
			VehicleParkPos[0],
			VehicleParkPos[1],
			VehicleParkPos[2],
			VehicleParkPos[3],
			VehicleColor1,
			VehicleColor2,
			VehiclePaintjob,
			0);
			
		if(vehicleid != INVALID_VEHICLE_ID)
		{
			VehicleInfo[vehicleid][eVehicleExists] = true; 
			cache_get_value_name_int(i, "VehicleDBID",VehicleInfo[vehicleid][eVehicleDBID]);
			
			cache_get_value_name(i, "VehicleName",VehicleInfo[vehicleid][eVehicleName]);
			cache_get_value_name_int(i, "VehicleOwnerDBID",VehicleInfo[vehicleid][eVehicleOwnerDBID]);
			cache_get_value_name_int(i, "VehicleFaction",VehicleInfo[vehicleid][eVehicleFaction]);
			
			cache_get_value_name_int(i, "VehicleModel",VehicleInfo[vehicleid][eVehicleModel]);
			
			cache_get_value_name_int(i, "VehicleColor1",VehicleInfo[vehicleid][eVehicleColor1]);
			cache_get_value_name_int(i, "VehicleColor2",VehicleInfo[vehicleid][eVehicleColor2]);
			
			cache_get_value_name_float(i, "VehicleParkPosX", VehicleInfo[vehicleid][eVehicleParkPos][0]);
			cache_get_value_name_float(i, "VehicleParkPosY", VehicleInfo[vehicleid][eVehicleParkPos][1]);
			cache_get_value_name_float(i, "VehicleParkPosZ", VehicleInfo[vehicleid][eVehicleParkPos][2]);
			cache_get_value_name_float(i, "VehicleParkPosA", VehicleInfo[vehicleid][eVehicleParkPos][3]);
			
			cache_get_value_name_int(i, "VehicleParkInterior",VehicleInfo[vehicleid][eVehicleParkInterior]);
			cache_get_value_name_int(i, "VehicleParkWorld",VehicleInfo[vehicleid][eVehicleParkWorld]);
			

			cache_get_value_name(i, "VehiclePlates",VehicleInfo[vehicleid][eVehiclePlates], 32);
			cache_get_value_name_int(i, "VehicleLocked",VehicleInfo[vehicleid][eVehicleLocked]);
			
			cache_get_value_name_int(i, "VehicleImpounded",VehicleInfo[vehicleid][eVehicleImpounded]);
			
			cache_get_value_name_float(i, "VehicleImpoundPosX", VehicleInfo[vehicleid][eVehicleImpoundPos][0]);
			cache_get_value_name_float(i, "VehicleImpoundPosY", VehicleInfo[vehicleid][eVehicleImpoundPos][1]);
			cache_get_value_name_float(i, "VehicleImpoundPosZ", VehicleInfo[vehicleid][eVehicleImpoundPos][2]);
			cache_get_value_name_float(i, "VehicleImpoundPosA", VehicleInfo[vehicleid][eVehicleImpoundPos][3]);
			
			cache_get_value_name_float(i, "VehicleFuel",VehicleInfo[vehicleid][eVehicleFuel]);
			
			cache_get_value_name_int(i, "VehicleXMR",VehicleInfo[vehicleid][eVehicleHasXMR]);
			cache_get_value_name_int(i, "VehicleTimesDestroyed",VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
			
			cache_get_value_name_float(i, "VehicleEngine",VehicleInfo[vehicleid][eVehicleEngine]);
			cache_get_value_name_float(i, "VehicleBattery",VehicleInfo[vehicleid][eVehicleBattery]);
			
			cache_get_value_name_int(i, "VehicleAlarmLevel",VehicleInfo[vehicleid][eVehicleAlarmLevel]);
			cache_get_value_name_int(i, "VehicleLockLevel",VehicleInfo[vehicleid][eVehicleLockLevel]);
			cache_get_value_name_int(i, "VehicleImmobLevel",VehicleInfo[vehicleid][eVehicleImmobLevel]);
			
			
			cache_get_value_name_int(i, "VehiclePaintjob",VehicleInfo[vehicleid][eVehiclePaintjob]);

			cache_get_value_name_int(i, "VehiclePrice",VehicleInfo[vehicleid][eVehiclePrice]);


			cache_get_value_name_int(i, "VehicleComp",VehicleInfo[vehicleid][eVehicleComp]);

			cache_get_value_name_float(i, "VehicleDrug1", VehicleInfo[vehicleid][eVehicleDrug][0]);
			cache_get_value_name_float(i, "VehicleDrug2", VehicleInfo[vehicleid][eVehicleDrug][1]);
			cache_get_value_name_float(i, "VehicleDrug3", VehicleInfo[vehicleid][eVehicleDrug][2]);

			for(new j = 0; j < 14; j++)
			{
				format(str, sizeof(str), "VehicleMod%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleMod][j]);
			}
			
			for(new j = 1; j < 6; j++)
			{
				format(str, sizeof(str), "VehicleWeapons%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleWeapons][j]);
				
				format(str, sizeof(str), "VehicleWeaponsAmmo%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleWeaponsAmmo][j]);
			}

			for(new j = 0; j < 4; j++)
			{
				format(str, sizeof(str), "VehicleDamage%d",i);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleDamage][j]);
			}

			cache_get_value_name_float(i, "VehicleHealth",VehicleInfo[vehicleid][eVehicleHealth]);

			//AddVehicleComponent(vehicleid, componentid);
			
			
			if(VehicleInfo[vehicleid][eVehicleParkInterior] != 0)
			{
				LinkVehicleToInterior(vehicleid, VehicleInfo[vehicleid][eVehicleParkInterior]); 
				SetVehicleVirtualWorld(vehicleid, VehicleInfo[vehicleid][eVehicleParkWorld]);
			}
			
			if(!isnull(VehicleInfo[vehicleid][eVehiclePlates]))
			{
				SetVehicleNumberPlate(vehicleid, VehicleInfo[vehicleid][eVehiclePlates]);
				SetVehicleToRespawn(vehicleid); 
			}
			
			if(VehicleInfo[vehicleid][eVehicleImpounded] == true)
			{
				SetVehiclePos(vehicleid, VehicleInfo[vehicleid][eVehicleImpoundPos][0], VehicleInfo[vehicleid][eVehicleImpoundPos][1], VehicleInfo[vehicleid][eVehicleImpoundPos][2]);
				SetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][eVehicleImpoundPos][3]); 
			}
			
			if(VehicleInfo[vehicleid][eVehicleLocked] == false)
				SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0);
				
			else SetVehicleParamsEx(vehicleid, 0, 0, 0, 1, 0, 0, 0);
			
			VehicleInfo[vehicleid][eVehicleAdminSpawn] = false;
			
			
			SetVehicleToRespawn(vehicleid); 
			SetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][eVehicleParkPos][3]);
			UpdateVehicleDamageStatus(vehicleid, VehicleInfo[vehicleid][eVehicleDamage][0], VehicleInfo[vehicleid][eVehicleDamage][1], VehicleInfo[vehicleid][eVehicleDamage][2],0);
			
			if(VehicleInfo[vehicleid][eVehicleHealth] < 310)
			{
				SetVehicleHp(vehicleid);
			}
			else
			{
				SetVehicleHealth(vehicleid, VehicleInfo[vehicleid][eVehicleHealth]);
			}
			
			if(HasNoEngine(playerid))
				ToggleVehicleEngine(vehicleid, true); 
			
			for(new j = 0; j < 14; j++)
			{
				AddVehicleComponent(vehicleid, VehicleInfo[vehicleid][eVehicleMod][j]);
			}

		}
	}
	
	VehicleInfo[vehicleid][eVehicleFaction] = 0;

	
	SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้นำรถ %s ออกมาแล้ว", ReturnVehicleName(vehicleid));
	SendClientMessageEx(playerid, COLOR_WHITE, "Lifespan: Engine Life[%.2f], Battery Life[%.2f], Times Destroyed[%d]", VehicleInfo[vehicleid][eVehicleEngine], VehicleInfo[vehicleid][eVehicleBattery], VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
	if(VehicleInfo[vehicleid][eVehicleImpounded]) 
	{
		SendClientMessage(playerid, COLOR_RED, "รถของคุณถูกยึด");
		SendClientMessage(playerid, 0xFF00FFFF, "Hint: ไปตามจุดที่เราได้มาร์กไว้เพื่อไปที่รถ");
		SetPlayerCheckpoint(playerid, VehicleInfo[vehicleid][eVehicleImpoundPos][0], VehicleInfo[vehicleid][eVehicleImpoundPos][1], VehicleInfo[vehicleid][eVehicleImpoundPos][2], 3.0);
	}
	else
	{
		new Float:x, Float:y, Float:z, Float:a;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);

		SetVehiclePos(vehicleid, x, y, z);
		SetVehicleZAngle(vehicleid, a);
		PutPlayerInVehicle(playerid, vehicleid, 0);

		SendClientMessage(playerid, 0xFF00FFFF, "Hint: ไปตามจุดที่เราได้มาร์กไว้เพื่อไปที่รถ");
		SetPlayerCheckpoint(playerid, x, y, z, 3.0);
	}
	PlayerCheckpoint[playerid] = 1; 
	return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(PlayerCheckpoint[playerid] == 1)
	{
		GameTextForPlayer(playerid, "~p~You have found it!", 3000, 3);
		PlayerCheckpoint[playerid] = 0; DisablePlayerCheckpoint(playerid);
	}
	if(PlayerCheckpoint[playerid] == 3)
	{
		GameTextForPlayer(playerid, "~p~This is park vehicle!", 3000, 3);
		PlayerCheckpoint[playerid] = 0; DisablePlayerCheckpoint(playerid);
	}
	return 1;
}


Dialog:DIALOG_VEHICLE_WEAPONS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new vehicleid = INVALID_VEHICLE_ID, str[128];
				
		if(!IsPlayerInAnyVehicle(playerid))
			vehicleid = GetNearestVehicle(playerid);
					
		else
		vehicleid = GetPlayerVehicleID(playerid);
					
		if(vehicleid == INVALID_VEHICLE_ID)
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้รถ"); 
					
		if(!VehicleInfo[vehicleid][eVehicleWeapons][listitem+1])
			return SendErrorMessage(playerid, "");
				
		GivePlayerGun(playerid, VehicleInfo[vehicleid][eVehicleWeapons][listitem+1], VehicleInfo[vehicleid][eVehicleWeaponsAmmo][listitem+1]); 
				
		format(str, sizeof(str), "* %s หยิบ %s ออกมาจากรถ %s", ReturnName(playerid, 0), ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][listitem+1]), 
		ReturnVehicleName(vehicleid)); 
					
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
		SendClientMessage(playerid, COLOR_EMOTE, str);
				
		VehicleInfo[vehicleid][eVehicleWeapons][listitem+1] = 0; 
		VehicleInfo[vehicleid][eVehicleWeaponsAmmo][listitem+1] = 0; 
				
		SaveVehicle(vehicleid); CharacterSave(playerid);
		return 1;
	}
	return 1;
}

Dialog:DIALOG_VEH_SELL(playerid, response, listitem, inputtext[])
{
	if(!response)
		return SendServerMessage(playerid,"คุณยกเลิกการขายรถของคุณแล้ว");

	if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถแล้วในตอนนี้ทำให้ยกเลิกในการขายยานพาหนะในตอนนี้ทันที");
	
	new vehicleid = PlayerVehicleScrap[playerid];
	new id = IsPlayerNearBusiness(playerid);
	new dbid = VehicleInfo[vehicleid][eVehicleDBID]; new model_id;

	for(new i = 0; i < sizeof(g_aDealershipDatas); i++)
	{
		if(GetVehicleModel(vehicleid) != g_aDealershipDatas[i][V_Model])
			continue;

		model_id = i;
	}

	new cash_back = g_aDealershipDatas[model_id][V_PRICE] / 2;
	SendClientMessageEx(playerid, COLOR_GREEN, "Cash Back: %s", MoneyFormat(cash_back));

	if(!id)
		return SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้ร้านขายรถ");
	
	new delQuery[128];
		
	mysql_format(dbCon, delQuery, sizeof(delQuery), "DELETE FROM vehicles WHERE VehicleDBID = %i", dbid);
	mysql_tquery(dbCon, delQuery);

	SendServerMessage(playerid, "คุณได้ขายรถ รุ่น %s ออกจากตัวคุณแล้ว", ReturnVehicleName(GetPlayerVehicleID(playerid))); 
	SendServerMessage(playerid, "และคุณได้รับเงินคืนในจำนวน $%s", MoneyFormat(cash_back));
	GiveMoney(playerid, cash_back);
	BusinessInfo[id][BusinessCash] -= cash_back;

	ResetVehicleVars(GetPlayerVehicleID(playerid)); 
	DestroyVehicle(GetPlayerVehicleID(playerid));

	PlayerInfo[playerid][pVehicleSpawned] = false;
	PlayerInfo[playerid][pVehicleSpawnedID] = 0;
		
	for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
	{
		if(PlayerInfo[playerid][pOwnedVehicles][i] == dbid)
		{
			PlayerInfo[playerid][pOwnedVehicles][i] = 0;
		}
	}
	return 1;
}

stock IsVehicleOccupied(vehicleid)
{
	foreach(new i : Player){
		if(IsPlayerInVehicle(i, vehicleid))return true; 
	}
	return false;
}

public OnVehicleDeath(vehicleid, killerid)
{
	VehicleInfo[vehicleid][eVehicleTimesDestroyed]++;
	VehicleInfo[vehicleid][eVehicleEngine]--;
	VehicleInfo[vehicleid][eVehicleBattery]--;
	VehicleInfo[vehicleid][eVehicleLocked] = true;
	SaveVehicle(vehicleid);
    return 1;
}

forward OnVehicleTow(playerid);
public OnVehicleTow(playerid)
{
	new vehicleid = PlayerInfo[playerid][pVehicleSpawnedID], newDisplay[128]; 
	
	if(IsVehicleOccupied(vehicleid))
	{
		KillTimer(playerTowTimer[playerid]);
		SendServerMessage(playerid, "การนำรถกลับมยังจุดเกิดนั้นถูกขัดด้วยอะไรบางอย่าง"); 
		
		playerTowingVehicle[playerid] = false;
		Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleTowDisplay]);
		
		VehicleInfo[vehicleid][eVehicleTowCount] = 0;
		return 1;
	}
	
	VehicleInfo[vehicleid][eVehicleTowCount]++;
	
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 1) newDisplay = "(( || ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 2) newDisplay = "(( ||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 3) newDisplay = "(( |||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 4) newDisplay = "(( ||||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 5) newDisplay = "(( |||||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 6) newDisplay = "(( ||||||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 7) newDisplay = "(( |||||||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 8) newDisplay = "(( |||||||| ))\nTOWING VEHICLE"; 
	
	Update3DTextLabelText(VehicleInfo[vehicleid][eVehicleTowDisplay], COLOR_DARKGREEN, newDisplay);
	
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 9)
	{
		SendServerMessage(playerid, "รถของคุณถูกส่งกลับจุดเกิดแล้ว");
		GiveMoney(playerid, -2000);
		
		playerTowingVehicle[playerid] = false;	
		SetVehicleToRespawn(vehicleid); 
		
		Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleTowDisplay]);
		KillTimer(playerTowTimer[playerid]);
		
		VehicleInfo[vehicleid][eVehicleTowCount] = 0; 
		VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
		return 1;
	}
	
	return 1;
}

stock ToggleVehicleLights(vehicleid, bool:lightstate)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lightstate, alarm, doors, bonnet, boot, objective);
	
	if(lightstate == false)
	{
		KillTimer(VehicleInfo[vehicleid][eVehicleElmTimer]);
		VehicleInfo[vehicleid][eVehicleElmTimer] = -1;
	}

	VehicleInfo[vehicleid][eVehicleLights] = lightstate;
	return 1;
}

stock GetVehicleHood(vehicleid, &Float:x, &Float:y, &Float:z) 
{ 
    if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID) 
        return (x = 0.0, y = 0.0, z = 0.0), 0; 

    static 
        Float:pos[7] 
    ; 
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]); 
    GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]); 
    GetVehicleZAngle(vehicleid, pos[6]); 

    x = pos[3] + (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees)); 
    y = pos[4] + (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees)); 
    z = pos[5]; 

    return 1; 
}

hook OnPlayerUpdate(playerid)
{
	/*new str[120];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		format(str, sizeof(str), "~b~km/h: ~g~%d~n~~b~Fuel: ~g~%.1f", GetVehicleSpeed(vehicleid), VehicleInfo[vehicleid][eVehicleFuel]);
		//PlayerTextDrawSetString(playerid, Statsvehicle[playerid], str);
	}*/
	return 1;
}

stock GetVehicleSpeed(vehicleid)
{
    new
        Float:x,
        Float:y,
        Float:z,
        vel;
    GetVehicleVelocity( vehicleid, x, y, z );
    vel = floatround( floatsqroot( x*x + y*y + z*z ) * 180 );           // KM/H
//  vel = floatround( floatsqroot( x*x + y*y + z*z ) * 180 / MPH_KMH ); // Mph
    return vel;
}

forward InsertVehicleFaction(playerid,newid, modelid, factionid, color1,color2);
public InsertVehicleFaction(playerid,newid, modelid, factionid, color1,color2)
{
	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y,z);
	GetPlayerFacingAngle(playerid, a);

	new vehicleid = CreateVehicle(modelid, x, y, z, a, color1, color2, -1, 0);

	if(vehicleid != INVALID_VEHICLE_ID)
	{
		VehicleInfo[vehicleid][eVehicleDBID] = cache_insert_id();
		VehicleInfo[vehicleid][eVehicleModel] = modelid;
		VehicleInfo[vehicleid][eVehicleFaction] = factionid;

		VehicleInfo[vehicleid][eVehicleColor1] = color1;
		VehicleInfo[vehicleid][eVehicleColor2] = color2;
		VehicleInfo[vehicleid][eVehicleFuel] = 100;
		SetVehicleToRespawn(vehicleid);
	}

	PutPlayerInVehicle(playerid, vehicleid, 0);
	SendClientMessageEx(playerid, -1, "คุณได้สร้างรถเฟคชั่นให้กับ {FF5722}%s {FFFFFF}(%d)",FactionInfo[factionid][eFactionName],cache_insert_id());
	return 1;
}

GetClosestVehicle(playerid, exception = INVALID_VEHICLE_ID) {

	new
	    Float:fDistance = FLOAT_INFINITY,
	    iIndex = -1
	;
	for(new i=0;i!=MAX_VEHICLES;i++) {
		if(i != exception) {
			new
	        	Float:temp = GetDistancePlayerVeh(playerid, i);

			if (temp < fDistance && temp < 6.0)
			{
			    fDistance = temp;
			    iIndex = i;
			}
		}
	}
	return iIndex;
}

GetDistancePlayerVeh(playerid, veh) {

	new
	    Float:Floats[7];

	GetPlayerPos(playerid, Floats[0], Floats[1], Floats[2]);
	GetVehiclePos(veh, Floats[3], Floats[4], Floats[5]);
	Floats[6] = floatsqroot((Floats[3]-Floats[0])*(Floats[3]-Floats[0])+(Floats[4]-Floats[1])*(Floats[4]-Floats[1])+(Floats[5]-Floats[2])*(Floats[5]-Floats[2]));

	return floatround(Floats[6]);
}

IsPlayerInRangeOfVehicle(playerid, vehicleid, Float: radius) {

	new
		Float:Floats[3];

	GetVehiclePos(vehicleid, Floats[0], Floats[1], Floats[2]);
	return IsPlayerInRangeOfPoint(playerid, radius, Floats[0], Floats[1], Floats[2]);
}

IsDoorVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 400..424, 426..429, 431..440, 442..445, 451, 455, 456, 458, 459, 466, 467, 470, 474, 475:
		    return 1;

		case 477..480, 482, 483, 486, 489, 490..492, 494..496, 498..500, 502..508, 514..518, 524..529, 533..536:
		    return 1;

		case 540..547, 549..552, 554..562, 565..568, 573, 575, 576, 578..580, 582, 585, 587..589, 596..605, 609:
			return 1;
	}
	return 0;
}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	new Float:health;

	GetVehicleHealth(vehicleid, health);
	
	if(vehicleid != 0)
	{
		if(RELEASED(KEY_SECONDARY_ATTACK))
		{
			if(!IsPlayerInAnyVehicle(playerid))
				return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ");

			RemovePlayerFromVehicle(playerid);
			TogglePlayerControllable(playerid, 1);

			if(VehicleInfo[vehicleid][eVehicleMusic])
			{
				StopAudioStreamForPlayer(playerid);
			}
			return 1;

		}
		if(RELEASED(KEY_NO))
		{
			if(PlayerInfo[playerid][pAdmin])
			{
				new str[2];
				format(str, sizeof(str), "");
				callcmd::engine(playerid, str);
				return 1;
			}
		}
		if(health <= 300)
		{
			new RandomStart = Random(0, 1);
			
			if(!RandomStart)
			{
				GameTextForPlayer(playerid, "~r~ENGINE COULDN'T START DUE TO DAMAGE", 5000, 4);
				return 1;
			}
			else
			{
				GameTextForPlayer(playerid, "~g~ENGINE TURNED ON", 2000, 3);
				SetVehicleHealth(vehicleid, 300.0);
				ToggleVehicleEngine(vehicleid, true); VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
				return 1;
			}

		}
	}
	
	if(SellVehData[playerid][S_BY] != INVALID_PLAYER_ID)
	{
		if(RELEASED(KEY_YES))
		{
			new id = PlayerOwnerDBID[playerid];
			new vehicleid_ID = SellVehData[playerid][S_VID];
			new tagetid = SellVehData[playerid][S_BY];

			PlayerInfo[playerid][pOwnedVehicles][id] = VehicleInfo[vehicleid_ID][eVehicleDBID];
			/*PlayerInfo[playerid][pVehicleSpawned] = true;
			PlayerInfo[playerid][pVehicleSpawnedID] = vehicleid_ID;*/

			VehicleInfo[vehicleid_ID][eVehicleOwnerDBID] = PlayerInfo[playerid][pDBID];

			for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
			{
				if(PlayerInfo[tagetid][pOwnedVehicles][i] == VehicleInfo[vehicleid_ID][eVehicleDBID])
				{
					PlayerInfo[tagetid][pOwnedVehicles][i] = 0;
					break;
				}
			}
			PlayerInfo[tagetid][pVehicleSpawned] = false;
			PlayerInfo[tagetid][pVehicleSpawnedID] = 0;

			SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้ยอมรับข้อเสนอการให้ยานพาหนะจาก %s",ReturnName(tagetid,0));
			SendClientMessageEx(tagetid, COLOR_HELPME, "%s ได้ยอมรับข้อเสนอการให้ยานพาหนะจากคุณแล้ว",  ReturnName(playerid,0));
			SaveVehicle(vehicleid_ID); CharacterSave(playerid); CharacterSave(tagetid);

			SellVehData[tagetid][S_ID] = INVALID_PLAYER_ID;
			PlayerOwnerDBID[playerid] = 0;

			SellVehData[playerid][S_VID] = INVALID_VEHICLE_ID;
			SellVehData[playerid][S_BY] = INVALID_PLAYER_ID;
			return 1;
		}
		if(RELEASED(KEY_NO))
		{	
			new vehicleid_ID = SellVehData[playerid][S_VID];
			new tagetid = SellVehData[playerid][S_BY];

			SendClientMessageEx(playerid, COLOR_LIGHTRED, "คุณปฏิเสธข้อเสนอของ %s สำหรับการให้ยานพาหนะ %s",ReturnName(tagetid,0), ReturnVehicleName(vehicleid_ID));
			SendClientMessageEx(tagetid, COLOR_GREY, "%s ปฏิเสธข้อเสนอการให้ยานพาหนะ %s",ReturnName(playerid,0), ReturnVehicleName(vehicleid_ID));
			
			SellVehData[tagetid][S_ID] = INVALID_PLAYER_ID;
			PlayerOwnerDBID[playerid] = 0;

			SellVehData[playerid][S_VID] = INVALID_VEHICLE_ID;
			SellVehData[playerid][S_BY] = INVALID_PLAYER_ID;
			return 1;
		}
	}
	return 1;
}

forward OnVehicleUpdate();
public OnVehicleUpdate()
{
	new Float:Health;
	for(new vehicleid = 1; vehicleid < MAX_VEHICLES; vehicleid++)
	{
		GetVehicleHealth(vehicleid, Health);

		foreach(new i : Player)
		{
			if(GetPlayerVehicleID(i) == vehicleid)
			{
				if(Health < 250)
				{
					SetVehicleHealth(vehicleid, 300.0);
					ToggleVehicleEngine(vehicleid, false); VehicleInfo[vehicleid][eVehicleEngineStatus] = false;

					if(VehicleInfo[vehicleid][eVehicleDBID] && !VehicleInfo[vehicleid][eVehicleFaction])
					{
						VehicleInfo[vehicleid][eVehicleBattery]--;
						SendClientMessageEx(i, -1, "ยานพาหนะมีความเสียหาย ทำให้แบตตารี่ ลดลง เหลือ %f", VehicleInfo[vehicleid][eVehicleBattery]);
					}

					GameTextForPlayer(i, "~r~ENGINE COULDN'T START DUE TO DAMAGE", 5000, 4);
					SendClientMessage(i, COLOR_LIGHTRED, "SERVER: เครื่องยนต์เสียหายอย่างหนัก");
					SendClientMessage(i, COLOR_YELLOW, "ข้อแนะ: กดปุ่ม "EMBED_WHITE"W"EMBED_YELLOW" เพื่อติดเครื่องยนต์");
					SendClientMessage(i, COLOR_YELLOW, "ข้อแนะ: คุณมีเวลา "EMBED_WHITE"10"EMBED_YELLOW" วินาที เพื่อติดเครื่องยนต์");
				}
			}
		}
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(VehicleInfo[vehicleid][eVehicleMusic])
	{
		StopAudioStreamForPlayer(playerid);
	}
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(HasNoEngine(vehicleid))
	{
		ToggleVehicleEngine(vehicleid, true); VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
	}
	if(VehicleInfo[vehicleid][eVehicleMusic])
	{
		StopAudioStreamForPlayer(playerid);
		PlayAudioStreamForPlayer(playerid, VehicleInfo[vehicleid][eVehicleMusicLink]);
	}

	if(!ispassenger && VehicleInfo[vehicleid][eVehicleFaction] && PlayerInfo[playerid][pFaction] != VehicleInfo[vehicleid][eVehicleFaction])
	{
		SendErrorMessage(playerid, "คุณไม่สามารถขึ้นรถของแฟคชั่น");		
		ClearAnimations(playerid);
	}
	return 1;
}


stock IsCheckBike(vehicleid)
{
	new modelid = GetVehicleModel(vehicleid);

	switch(modelid)
	{
		case 581, 462, 521,463,522,461,448, 468,586,523: return 1;
	}

	return 0;
}

CMD:setfuel(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendUnauthMessage(playerid);

	new Float:value, vehicleid;

	if(sscanf(params, "df", vehicleid, value))
		return SendUsageMessage(playerid, "/setfuel <ไอดียานพาหนะ> <น้ำมัน ไม่เกิน 100>");

	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "ไม่มีไอดีรถที่ต้องการ"); 

	
	if(value < 1 || value > 100)
		return SendErrorMessage(playerid, "คุณใส่ค่าน้ำมันไม่ถูกต้อง");

	VehicleInfo[vehicleid][eVehicleFuel] = value;
	SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เซ็ตค่าน้ำมันให้กับยานพาหนะ %s เป็น %.1f", ReturnVehicleName(vehicleid), value);
	SaveVehicle(vehicleid);
	return 1;
}

task ServerVehicleFuelTimer[20000]()
{
	for(new i = 1; i < MAX_VEHICLES; i++)
	{
		if(HasNoEngine(i))
			continue;

		if(!VehicleInfo[i][eVehicleEngineStatus])
			continue;

		if(VehicleInfo[i][eVehicleFuel] <= 0.0)
		{
			VehicleInfo[i][eVehicleFuel] = 0.0;
			VehicleInfo[i][eVehicleEngineStatus] = false;
			ToggleVehicleEngine(i, false);
			SaveVehicle(i);
			continue;
		}

		VehicleInfo[i][eVehicleFuel] -= 0.1;
	}
	return 1;
}

IsVehicleSeatUsed(vehicleid, seat)
{
	foreach (new i : Player) if (IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == seat) {
	    return 1;
	}
	return 0;
}

GetAvailableSeat(vehicleid, start = 1)
{
	new seats = GetVehicleMaxSeats(vehicleid);

	for (new i = start; i < seats; i ++) if (!IsVehicleSeatUsed(vehicleid, i)) {
	    return i;
	}
	return -1;
}


GetVehicleMaxSeats(vehicleid)
{
    new const g_arrMaxSeats[] = {
		4, 2, 2, 2, 4, 4, 1, 2, 2, 4, 2, 2, 2, 4, 2, 2, 4, 2, 4, 2, 4, 4, 2, 2, 2, 1, 4, 4, 4, 2,
		1, 7, 1, 2, 2, 0, 2, 7, 4, 2, 4, 1, 2, 2, 2, 4, 1, 2, 1, 0, 0, 2, 1, 1, 1, 2, 2, 2, 4, 4,
		2, 2, 2, 2, 1, 1, 4, 4, 2, 2, 4, 2, 1, 1, 2, 2, 1, 2, 2, 4, 2, 1, 4, 3, 1, 1, 1, 4, 2, 2,
		4, 2, 4, 1, 2, 2, 2, 4, 4, 2, 2, 1, 2, 2, 2, 2, 2, 4, 2, 1, 1, 2, 1, 1, 2, 2, 4, 2, 2, 1,
		1, 2, 2, 2, 2, 2, 2, 2, 2, 4, 1, 1, 1, 2, 2, 2, 2, 7, 7, 1, 4, 2, 2, 2, 2, 2, 4, 4, 2, 2,
		4, 4, 2, 1, 2, 2, 2, 2, 2, 2, 4, 4, 2, 2, 1, 2, 4, 4, 1, 0, 0, 1, 1, 2, 1, 2, 2, 1, 2, 4,
		4, 2, 4, 1, 0, 4, 2, 2, 2, 2, 0, 0, 7, 2, 2, 1, 4, 4, 4, 2, 2, 2, 2, 2, 4, 2, 0, 0, 0, 4,
		0, 0
	};
	new
	    model = GetVehicleModel(vehicleid);

	if (400 <= model <= 611)
	    return g_arrMaxSeats[model - 400];

	return 0;
}

stock SetVehicleToRespawnEx(vehicleid)
{
	if(IsVehicleRented(vehicleid))
	{
		foreach(new i : Player)
		{
			if(RentCarKey[i] == vehicleid)
			{
				RentCarKey[i] = 9999;
				SendServerMessage(i, "ผู้ดูแลได้ทำการรียานพาหนะ ยานพาหนะเช่า");
			}
		}
	}
	////ลบ Carsign 
	Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleCarsign]); 
	VehicleInfo[vehicleid][eVehicleHasCarsign] = false;
	VehicleInfo[vehicleid][eVehicleEngineStatus] = false;

	//ปิดไฟ
	VehicleInfo[vehicleid][eVehicleLights] = false;
	ToggleVehicleLights(vehicleid, false);


	////ดับเครื่องยนต์
	ToggleVehicleEngine(vehicleid, false); 
	VehicleInfo[vehicleid][eVehicleEngineStatus] = false;

	///ลบ ELM
	KillTimer(VehicleInfo[vehicleid][eVehicleElmTimer]);
	VehicleInfo[vehicleid][eVehicleElmTimer] = -1;
	VehicleInfo[vehicleid][eVehicleFuel] = 100.0;


	DestroyDynamicObject(VehicleSiren[vehicleid]);
	VehicleSiren[vehicleid] = INVALID_OBJECT_ID;

	////ส่งยานพาหนะเกิด พร้อมกับ Sethp ยานพาหนะ
	SetVehicleToRespawn(vehicleid);
	SetVehicleVirtualWorld(vehicleid, VehicleInfo[vehicleid][eVehicleParkWorld]);
	SetVehicleHp(vehicleid);
	return 1;
}




public OnEnterExitModShop(playerid, enterexit, interiorid)
{	
	if(enterexit == 0)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		SetPVarInt(playerid, "OnplayerModShopVeh", vehicleid);
		
		SendClientMessage(playerid, COLOR_HELPME, "คุณได้ทำการแต่งยานพาหนะของคุณเสร็จแล้ว คุณรีบออกมาข้างนอกและโปรดรอ สักครู่.....");
		SetTimerEx("GetPlayerPosVehmod", 5000, false, "dd",playerid, vehicleid);
		return 1;
	}
	return 1;
}

forward GetPlayerPosVehmod(playerid, vehicleid);
public GetPlayerPosVehmod(playerid, vehicleid)
{
	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);
	SetVehiclePos(vehicleid, x, y, z);
	SetVehicleZAngle(vehicleid, a);


	PutPlayerInVehicle(playerid, vehicleid, 0);
	return 1;
}

GetVehicleSize(modelID, &Float: size_X, &Float: size_Y, &Float: size_Z) // Author: RyDeR`
{
	static const
		Float: sizeData[212][3] =
		{
			{ 2.32, 5.11, 1.63 }, { 2.56, 5.82, 1.71 }, { 2.41, 5.80, 1.52 }, { 3.15, 9.22, 4.17 },
			{ 2.20, 5.80, 1.84 }, { 2.34, 6.00, 1.49 }, { 5.26, 11.59, 4.42 }, { 2.84, 8.96, 2.70 },
			{ 3.11, 10.68, 3.91 }, { 2.36, 8.18, 1.52 }, { 2.25, 5.01, 1.79 }, { 2.39, 5.78, 1.37 },
			{ 2.45, 7.30, 1.38 }, { 2.27, 5.88, 2.23 }, { 2.51, 7.07, 4.59 }, { 2.31, 5.51, 1.13 },
			{ 2.73, 8.01, 3.40 }, { 5.44, 23.27, 6.61 }, { 2.56, 5.67, 2.14 }, { 2.40, 6.21, 1.40 },
			{ 2.41, 5.90, 1.76 }, { 2.25, 6.38, 1.37 }, { 2.26, 5.38, 1.54 }, { 2.31, 4.84, 4.90 },
			{ 2.46, 3.85, 1.77 }, { 5.15, 18.62, 5.19 }, { 2.41, 5.90, 1.76 }, { 2.64, 8.19, 3.23 },
			{ 2.73, 6.28, 3.48 }, { 2.21, 5.17, 1.27 }, { 4.76, 16.89, 5.92 }, { 3.00, 12.21, 4.42 },
			{ 4.30, 9.17, 3.88 }, { 3.40, 10.00, 4.86 }, { 2.28, 4.57, 1.72 }, { 3.16, 13.52, 4.76 },
			{ 2.27, 5.51, 1.72 }, { 3.03, 11.76, 4.01 }, { 2.41, 5.82, 1.72 }, { 2.22, 5.28, 1.47 },
			{ 2.30, 5.55, 2.75 }, { 0.87, 1.40, 1.01 }, { 2.60, 6.67, 1.75 }, { 4.15, 20.04, 4.42 },
			{ 3.66, 6.01, 3.28 }, { 2.29, 5.86, 1.75 }, { 4.76, 17.02, 4.30 }, { 2.42, 14.80, 3.15 },
			{ 0.70, 2.19, 1.62 }, { 3.02, 9.02, 4.98 }, { 3.06, 13.51, 3.72 }, { 2.31, 5.46, 1.22 },
			{ 3.60, 14.56, 3.28 }, { 5.13, 13.77, 9.28 }, { 6.61, 19.04, 13.84 }, { 3.31, 9.69, 3.63 },
			{ 3.23, 9.52, 4.98 }, { 1.83, 2.60, 2.72 }, { 2.41, 6.13, 1.47 }, { 2.29, 5.71, 2.23 },
			{ 10.85, 13.55, 4.44 }, { 0.69, 2.46, 1.67 }, { 0.70, 2.19, 1.62 }, { 0.69, 2.42, 1.34 },
			{ 1.58, 1.54, 1.14 }, { 0.87, 1.40, 1.01 }, { 2.52, 6.17, 1.64 }, { 2.52, 6.36, 1.66 },
			{ 0.70, 2.23, 1.41 }, { 2.42, 14.80, 3.15 }, { 2.66, 5.48, 2.09 }, { 1.41, 2.00, 1.71 },
			{ 2.67, 9.34, 4.86 }, { 2.90, 5.40, 2.22 }, { 2.43, 6.03, 1.69 }, { 2.45, 5.78, 1.48 },
			{ 11.02, 11.28, 3.28 }, { 2.67, 5.92, 1.39 }, { 2.45, 5.57, 1.74 }, { 2.25, 6.15, 1.99 },
			{ 2.26, 5.26, 1.41 }, { 0.70, 1.87, 1.32 }, { 2.33, 5.69, 1.87 }, { 2.04, 6.19, 2.10 },
			{ 5.34, 26.20, 7.15 }, { 1.97, 4.07, 1.44 }, { 4.34, 7.84, 4.44 }, { 2.32, 15.03, 4.67 },
			{ 2.32, 12.60, 4.65 }, { 2.53, 5.69, 2.14 }, { 2.92, 6.92, 2.14 }, { 2.30, 6.32, 1.28 },
			{ 2.34, 6.17, 1.78 }, { 4.76, 17.82, 3.84 }, { 2.25, 6.48, 1.50 }, { 2.77, 5.44, 1.99 },
			{ 2.27, 4.75, 1.78 }, { 2.32, 15.03, 4.65 }, { 2.90, 6.59, 4.28 }, { 2.64, 7.19, 3.75 },
			{ 2.28, 5.01, 1.85 }, { 0.87, 1.40, 1.01 }, { 2.34, 5.96, 1.51 }, { 2.21, 6.13, 1.62 },
			{ 2.52, 6.03, 1.64 }, { 2.53, 5.69, 2.14 }, { 2.25, 5.21, 1.16 }, { 2.56, 6.59, 1.62 },
			{ 2.96, 8.05, 3.33 }, { 0.70, 1.89, 1.32 }, { 0.72, 1.74, 1.12 }, { 21.21, 21.19, 5.05 },
			{ 11.15, 6.15, 2.99 }, { 8.69, 9.00, 2.23 }, { 3.19, 10.06, 3.05 }, { 3.54, 9.94, 3.42 },
			{ 2.59, 6.23, 1.71 }, { 2.52, 6.32, 1.64 }, { 2.43, 6.00, 1.57 }, { 20.30, 19.29, 6.94 },
			{ 8.75, 14.31, 2.16 }, { 0.69, 2.46, 1.67 }, { 0.69, 2.46, 1.67 }, { 0.69, 2.47, 1.67 },
			{ 3.58, 8.84, 3.64 }, { 3.04, 6.46, 3.28 }, { 2.20, 5.40, 1.25 }, { 2.43, 5.71, 1.74 },
			{ 2.54, 5.55, 2.14 }, { 2.38, 5.63, 1.86 }, { 1.58, 4.23, 2.68 }, { 1.96, 3.70, 1.66 },
			{ 8.61, 11.39, 4.17 }, { 2.38, 5.42, 1.49 }, { 2.18, 6.26, 1.15 }, { 2.67, 5.48, 1.58 },
			{ 2.46, 6.42, 1.29 }, { 3.32, 18.43, 5.19 }, { 3.26, 16.59, 4.94 }, { 2.50, 3.86, 2.55 },
			{ 2.58, 6.07, 1.50 }, { 2.26, 4.94, 1.24 }, { 2.48, 6.40, 1.70 }, { 2.38, 5.73, 1.86 },
			{ 2.80, 12.85, 3.89 }, { 2.19, 4.80, 1.69 }, { 2.56, 5.86, 1.66 }, { 2.49, 5.84, 1.76 },
			{ 4.17, 24.42, 4.90 }, { 2.40, 5.53, 1.42 }, { 2.53, 5.88, 1.53 }, { 2.66, 6.71, 1.76 },
			{ 2.65, 6.71, 3.55 }, { 28.73, 23.48, 7.38 }, { 2.68, 6.17, 2.08 }, { 2.00, 5.13, 1.41 },
			{ 3.66, 6.36, 3.28 }, { 3.66, 6.26, 3.28 }, { 2.23, 5.25, 1.75 }, { 2.27, 5.48, 1.39 },
			{ 2.31, 5.40, 1.62 }, { 2.50, 5.80, 1.78 }, { 2.25, 5.30, 1.50 }, { 3.39, 18.62, 4.71 },
			{ 0.87, 1.40, 1.01 }, { 2.02, 4.82, 1.50 }, { 2.50, 6.46, 1.65 }, { 2.71, 6.63, 1.58 },
			{ 2.71, 4.61, 1.41 }, { 3.25, 18.43, 5.03 }, { 3.47, 21.06, 5.19 }, { 1.57, 2.32, 1.58 },
			{ 1.65, 2.34, 2.01 }, { 2.93, 7.38, 3.16 }, { 1.62, 3.84, 2.50 }, { 2.49, 5.82, 1.92 },
			{ 2.42, 6.36, 1.85 }, { 62.49, 61.43, 34.95 }, { 3.15, 11.78, 2.77 }, { 2.47, 6.21, 2.55 },
			{ 2.66, 5.76, 2.24 }, { 0.69, 2.46, 1.67 }, { 2.44, 7.21, 3.19 }, { 1.66, 3.66, 3.21 },
			{ 3.54, 15.90, 3.40 }, { 2.44, 6.53, 2.05 }, { 0.69, 2.79, 1.96 }, { 2.60, 5.76, 1.45 },
			{ 3.07, 8.61, 7.53 }, { 2.25, 5.09, 2.11 }, { 3.44, 18.39, 5.03 }, { 3.18, 13.63, 4.65 },
			{ 44.45, 57.56, 18.43 }, { 12.59, 13.55, 3.56 }, { 0.50, 0.92, 0.30 }, { 2.84, 13.47, 2.21 },
			{ 2.41, 5.90, 1.76 }, { 2.41, 5.90, 1.76 }, { 2.41, 5.78, 1.76 }, { 2.92, 6.15, 2.14 },
			{ 2.40, 6.05, 1.55 }, { 3.07, 6.96, 3.82 }, { 2.31, 5.53, 1.28 }, { 2.64, 6.07, 1.42 },
			{ 2.52, 6.17, 1.64 }, { 2.38, 5.73, 1.86 }, { 2.93, 3.38, 1.97 }, { 3.01, 3.25, 1.60 },
			{ 1.45, 4.65, 6.36 }, { 2.90, 6.59, 4.21 }, { 2.48, 1.42, 1.62 }, { 2.13, 3.16, 1.83 }
		}
	;
	if(400 <= modelID <= 611)
	{
		size_X = sizeData[modelID - 400][0];
		size_Y = sizeData[modelID - 400][1];
		size_Z = sizeData[modelID - 400][2];
		return 1;
	}
	return 0;
}


public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	new testtick = GetTickCount();
	new cammode = GetPlayerCameraMode(playerid);
	if(cammode == 7 || cammode == 8 || cammode == 53 || GetPlayerWeapon(playerid) <= 15)
	{
		new newkeys,plylr,plyup;
		GetPlayerKeys(playerid,newkeys,plyup,plylr);
		if(Holding(KEY_FIRE) || (GetTickCount()-playershottick[playerid]) <= SHOT_MS)
		{
			if(GetPlayerWeapon(playerid) <= 15)
			{
				new Float:VehSize[3],Float:VehPos[3];
				GetVehicleSize(GetVehicleModel(vehicleid),VehSize[0],VehSize[1],VehSize[2]);
				GetVehiclePos(vehicleid,VehPos[0],VehPos[1],VehPos[2]);
				if(IsPlayerInRangeOfPoint(playerid,VehSize[1],VehPos[0],VehPos[1],VehPos[2]))
				{
					new animidx = GetPlayerAnimationIndex(playerid);
					if(	animidx == 1136 || animidx == 1137 || animidx == 1138 || animidx == 1141 || //Fightstyle ...
						animidx == 17 || animidx == 18 || animidx == 19 || // Bat
						animidx == 749 || animidx == 750 || animidx == 751 || // Knife
						animidx == 1545 || animidx == 1546 || animidx == 1547 || // Sword
						animidx == 313 || animidx == 314 || animidx == 315 || // CSaw
						animidx == 423 || animidx == 424 || animidx == 425 || // Dildo
						animidx == 533) //Flowerattack
					{
						if(playerblock[playerid] == 0){playerblock[playerid] = 1;}
						else{return 1;}
					}
					else
					{
						playerblock[playerid] = 0;
						return 1;
					}
				}
				else{return 1;}

				OnEmptyVehicleDamage(vehicleid,playerid,(GetTickCount()-testtick));
			}
		}
		else if(playerblock[playerid] == 1){playerblock[playerid] = 0;}
	}
    return 1;
}

forward OnEmptyVehicleDamage(vehicleid,playerid,exems);
public OnEmptyVehicleDamage(vehicleid,playerid,exems)
{
	if(VehicleInfo[vehicleid][eVehicleBreak])
	{
		if(VehicleInfo[vehicleid][eVedhicleBreaktime])
		{
			VehicleInfo[vehicleid][eVedhicleBreaktime]--;

			NotifyVehicleOwner(vehicleid);

			new str[65];
			format(str, sizeof(str), "กำลังดำเนินการพังยานพาหนะ %d",VehicleInfo[vehicleid][eVedhicleBreaktime]);
			Update3DTextLabelText(VehicleInfo[vehicleid][eVehicleBreakUI], COLOR_WHITE, str);
			return 1;
		}
		else if(!VehicleInfo[vehicleid][eVedhicleBreaktime])
		{
			new statusString[60];

			VehicleInfo[vehicleid][eVehicleBreak] = false;
			VehicleInfo[vehicleid][eVedhicleBreaktime] = 0;
			
			Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleBreakUI]); 

			new engine, lights, alarm, doors, bonnet, boot, objective; 
			
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

			format(statusString, sizeof(statusString), "~g~%s UNLOCKED", ReturnVehicleName(vehicleid));
					
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, false, bonnet, boot, objective);
			VehicleInfo[vehicleid][eVehicleLocked] = false;
			GameTextForPlayer(playerid, statusString, 3000, 3);
			SendClientMessageEx(playerid, COLOR_YELLOWEX, "คุณได้ทำการพังยานพาหนะ %s สำเร็จแล้ว",ReturnVehicleName(vehicleid));
			return 1;
		}
	}
	return 1;
}

stock CheckPlayeyKey(playerid, vehicleid)
{
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID] && PlayerInfo[playerid][pDuplicateKey] != vehicleid && RentCarKey[playerid] != vehicleid && !VehicleInfo[vehicleid][eVehicleFaction] && !PlayerInfo[playerid][pAdminDuty] && !IsPlayerInElecVehicle(playerid) && !IsPlayerRentVehicle(playerid, vehicleid))
		return 1;

	return 0;
}


/*VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID] && 
	   PlayerInfo[playerid][pDuplicateKey] != vehicleid && 


