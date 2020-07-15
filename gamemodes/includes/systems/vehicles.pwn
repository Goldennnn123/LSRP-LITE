#include <YSI\y_hooks>

new PlayerText:Unscrambler_PTD[MAX_PLAYERS][7]; 

new gLastCar[MAX_PLAYERS];
new gPassengerCar[MAX_PLAYERS];
new playerInsertID[MAX_PLAYERS];

static const UnscrambleWord[][] = {
	"SPIDER", "DROP", "HIRE", "EARTH", "GOLD", "HEART", "FLOWER", "KNIFE",
	"POOL", "BEACH", "HEEL", "APPLE", "ART", "BEAN", "BEHIND", "AWAY",
	"COOKIE", "DANCE", "SALE", "SEXY", "BULLET", "GRAPE", "GROUND", "FLIP", "DIRT",
	"PRIDE", "AROUSE", "SOUP", "CIRCUS", "VERBA", "RENT", "REFUND", "HUMAN", "ANIMAL",
	"SNOOP", "FOUR", "TURKEY", "HOLE", "HUMOR"
}
;

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
    "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Cruiser", "SFPD Cruiser", "LVPD Cruiser",
    "Police Rancher", "Picador", "S.W.A.T. Tank", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
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

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
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

stock ResetVehicleVars(vehicleid)
{
	if(vehicleid == INVALID_VEHICLE_ID)
		return 0;
		
	VehicleInfo[vehicleid][eVehicleDBID] = 0; 
	VehicleInfo[vehicleid][eVehicleExists] = false;
	
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

stock CreateUnscrambleTextdraw(playerid, bool:showTextdraw = true)
{
	if(showTextdraw)
	{
		//Unscrambler Textdraws:
		Unscrambler_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 199.873275, 273.593383, "<UNSCRAMBLED_WORD>");
		PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][0], 0.206330, 1.118813);
		PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][0], 1);
		PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][0], -1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][0], 1);
		PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][0], 255);
		PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][0], 2);
		PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][0], 0);
		PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][0]);

		Unscrambler_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 137.369461, 273.593383, "/unscramble");
		PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][1], 0.206330, 1.118813);
		PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][1], 1);
		PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][1], -490707969);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][1], 1);
		PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][1], 255);
		PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][1], 2);
		PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][1], 0);
		PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][1]);

		Unscrambler_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 305.179687, 273.593383, "TO_UNSCRAMBLE_THE_WORD");
		PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][2], 0.206330, 1.118813);
		PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][2], 1);
		PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][2], -2147483393);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][2], 1);
		PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][2], 255);
		PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][2], 2);
		PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][2], 0);
		PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][2]);

		Unscrambler_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 141.369705, 285.194091, "scrambledword");
		PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][3], 0.206330, 1.118813);
		PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][3], 1);
		PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][3], -1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][3], 1);
		PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][3], 255);
		PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][3], 2);
		PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][3], 1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][3], 0);
		PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][3]);

		Unscrambler_PTD[playerid][4] = CreatePlayerTextDraw(playerid, 137.902801, 296.924377, "YOU_HAVE");
		PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][4], 0.206330, 1.118813);
		PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][4], 1);
		PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][4], -2147483393);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][4], 1);
		PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][4], 255);
		PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][4], 2);
		PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][4], 1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][4], 0);
		PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][4]);

		Unscrambler_PTD[playerid][5] = CreatePlayerTextDraw(playerid, 184.539016, 297.024383, "001");
		PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][5], 0.206330, 1.118813);
		PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][5], 1);
		PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][5], 0);
		PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][5], 1);
		PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][5], 255);
		PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][5], 2);
		PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][5], 1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][5], 0);
		PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][5]);

		Unscrambler_PTD[playerid][6] = CreatePlayerTextDraw(playerid, 202.540191, 297.124389, "SECONDS_LEFT_TO_FINISh.");
		PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][6], 0.206330, 1.118813);
		PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][6], 1);
		PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][6], -2147483393);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][6], 1);
		PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][6], 255);
		PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][6], 2);
		PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][6], 1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][6], 0);
		PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][6]);
	}
	else
	{
		PlayerTextDrawDestroy(playerid, Unscrambler_PTD[playerid][0]);
		PlayerTextDrawDestroy(playerid, Unscrambler_PTD[playerid][1]);
		PlayerTextDrawDestroy(playerid, Unscrambler_PTD[playerid][2]);
		PlayerTextDrawDestroy(playerid, Unscrambler_PTD[playerid][3]);
		PlayerTextDrawDestroy(playerid, Unscrambler_PTD[playerid][4]);
		PlayerTextDrawDestroy(playerid, Unscrambler_PTD[playerid][5]);
		PlayerTextDrawDestroy(playerid, Unscrambler_PTD[playerid][6]);
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(!VehicleInfo[vehicleid][eVehicleEngineStatus] && !IsRentalVehicle(vehicleid))
			SendClientMessage(playerid, COLOR_DARKGREEN, "เครื่องยนต์ดับอยู่ (/engine)");
	
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
		
	new vehicleid = GetPlayerVehicleID(playerid);
	
	if(HasNoEngine(vehicleid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "ยานพาหนะคันนี้ไม่มีเครื่องยนต์"); 

	if(!VehicleInfo[vehicleid][eVehicleDBID] && !VehicleInfo[vehicleid][eVehicleAdminSpawn] && !IsRentalVehicle(vehicleid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คำสั่งนี้สามารถใช้ได้เฉพาะยานพาหนะส่วนตัว แต่คุณอยู่ในยานพาหนะสาธารณะ (Static)");
		
	if(VehicleInfo[vehicleid][eVehicleFuel] <= 0.0 && !VehicleInfo[vehicleid][eVehicleAdminSpawn])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "ยานพาหนะนี้ไม่มีเชื้อเพลิง!"); 
	
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
	
	/*
	ยานพาหนะที่ต่อสายตรงได้ต้อง (Hotwire)
	- ไม่ใช่ของแฟคชั่น
	- ไม่ใช่รถที่เป็นเจ้าของ
	- ไม่ใช่รถที่มีกุญแจสำรอง
	- ไม่ใช่ที่แอดมินเสกขึ้น
	- ไม่ใช่รถเช่า

	*/
	if(
	!VehicleInfo[vehicleid][eVehicleFaction] && 
	PlayerInfo[playerid][pDuplicateKey] != vehicleid && 
	VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID] && 
	!VehicleInfo[vehicleid][eVehicleAdminSpawn] && 
	!IsRentalVehicle(vehicleid))
	{
		new idx, str[128];
		
		if(VehicleInfo[vehicleid][eVehicleEngineStatus] && !PlayerInfo[playerid][pAdminDuty])
			return GameTextForPlayer(playerid, "~g~ENGINE IS ALREADY ON", 3000, 3);
		
		PlayerInfo[playerid][pUnscrambling] = true;
	
		for(new i = 0; i < sizeof(UnscrambleWord); i++)
		{
			idx = random(sizeof(UnscrambleWord));
		}
		
		PlayerInfo[playerid][pUnscrambleID] = idx;
		
		switch(VehicleInfo[vehicleid][eVehicleImmobLevel])
		{
			case 1: PlayerInfo[playerid][pUnscramblerTime] = 125; 
			case 2: PlayerInfo[playerid][pUnscramblerTime] = 100; 
			case 3: PlayerInfo[playerid][pUnscramblerTime] = 75; 
			case 4: PlayerInfo[playerid][pUnscramblerTime] = 50;
			case 5: PlayerInfo[playerid][pUnscramblerTime] = 25;
		}
		
		PlayerInfo[playerid][pUnscrambleTimer] = repeat OnPlayerUnscramble(playerid);
		
		CreateUnscrambleTextdraw(playerid);

		format(str, sizeof(str), "%s", UnscrambleWord[idx]); 
		PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][3], str);
		
		format(str, sizeof(str), "%d", PlayerInfo[playerid][pUnscramblerTime]);
		PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][5], str);
	
		return 1; 
	}
	
	if(!VehicleInfo[vehicleid][eVehicleEngineStatus])
	{
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s สตาร์ทเครื่องยนต์ของ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid)); 
		ToggleVehicleEngine(vehicleid, true); VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
	}
	else
	{
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s ดับเครื่องยนต์ของ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid)); 
		ToggleVehicleEngine(vehicleid, false); VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
	}
	return 1;
}

alias:unscramble("uns")
CMD:unscramble(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้ขับยานพาหนะ");
		
	if(!PlayerInfo[playerid][pUnscrambling])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้ต่อสายตรงยานพาหนะ");
	
	if(isnull(params)) return SendSyntaxMessage(playerid, "/(uns)cramble [คำถอดรหัส]");
	
	if(strequal(UnscrambleWord[PlayerInfo[playerid][pUnscrambleID]], params, true))
	{ // ถ้าตอบถูก:
	
		PlayerInfo[playerid][pUnscrambleID] = random(sizeof(UnscrambleWord)); 
		
		new displayString[60], vehicleid = GetPlayerVehicleID(playerid);
		
		format(displayString, 60, "%s", ScrambleWord(UnscrambleWord[PlayerInfo[playerid][pUnscrambleID]]));
		PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][3], displayString); 
		
		//เวลาที่เพิ่มขึ้นจะขึ้นอยู่กับเลเวลของเตือนภัย:
		PlayerInfo[playerid][pUnscramblerTime] += (7 - VehicleInfo[vehicleid][eVehicleImmobLevel]) * 2;
		PlayerInfo[playerid][pScrambleSuccess]++; 
		
		PlayerPlaySound(playerid, 1052, 0, 0, 0);
		//จะต่อสายตรงได้สำเร็จนั้น ขึ้นอยู่กับเลเวลเตือนภัย:
		if(PlayerInfo[playerid][pScrambleSuccess] >= (VehicleInfo[vehicleid][eVehicleImmobLevel] * 2) + 2)
		{
			stop PlayerInfo[playerid][pUnscrambleTimer];
			PlayerInfo[playerid][pScrambleSuccess] = 0; 
			PlayerInfo[playerid][pUnscrambling] = false;
			
			PlayerInfo[playerid][pUnscrambleID] = 0;
			PlayerInfo[playerid][pUnscramblerTime] = 0;
			
			PlayerInfo[playerid][pScrambleFailed] = 0;
			
			GameTextForPlayer(playerid, "~g~ENGINE TURNED ON", 2000, 3); 
			CreateUnscrambleTextdraw(playerid, false);
			
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s สตาร์ทเครื่องยนต์ของ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid)); 
			ToggleVehicleEngine(vehicleid, true); VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
		}	
	}
	else
	{
		PlayerPlaySound(playerid, 1055, 0, 0, 0); 
		
		PlayerInfo[playerid][pUnscrambleID] = random(sizeof(UnscrambleWord)); 
		
		new displayString[60];
		
		format(displayString, 60, "%s", ScrambleWord(UnscrambleWord[PlayerInfo[playerid][pUnscrambleID]]));
		PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][3], displayString); 
		
		PlayerInfo[playerid][pScrambleFailed]++; 
		PlayerInfo[playerid][pUnscramblerTime] -= random(6)+1;
		
		if(PlayerInfo[playerid][pScrambleFailed] >= 5)
		{
			stop PlayerInfo[playerid][pUnscrambleTimer];
			PlayerInfo[playerid][pScrambleSuccess] = 0; 
			PlayerInfo[playerid][pUnscrambling] = false;
			
			PlayerInfo[playerid][pUnscrambleID] = 0;
			PlayerInfo[playerid][pUnscramblerTime] = 0;
			
			PlayerInfo[playerid][pScrambleFailed] = 0;
			
			new 
				vehicleid = GetPlayerVehicleID(playerid)
			;
			
			ToggleVehicleAlarms(vehicleid, true);
			NotifyVehicleOwner(vehicleid);
			
			ClearAnimations(playerid);
			CreateUnscrambleTextdraw(playerid, false);
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
		SendUsageMessage(playerid, "/vehicle [action]");
		SendServerMessage(playerid, "get, park, buypark, duplicatekey, buy");
		SendServerMessage(playerid, "scrap, tow, lock, lights, find, stats");
		SendServerMessage(playerid, "list, faction, unfaction, trunk, hood");
		return 1;
	}
	if(!strcmp(oneString, "get"))
	{
		new
			slotid
		;

		if(sscanf(secString, "d", slotid))
			return SendUsageMessage(playerid, "/vehicle get [สล็อตรถ]");

		if(slotid < 0)
			return SendErrorMessage(playerid, "ไม่มีส็อตที่ต้องการ");

		if(!PlayerInfo[playerid][pOwnedVehicles][slotid])
			return SendErrorMessage(playerid, "ไม่มีรถในสล็อตนี้");

		if(PlayerInfo[playerid][pVehicleSpawned] == true)
			return SendErrorMessage(playerid, "มีรถถูกนำออกมาแล้ว");

		new threadLoad[128];

		for(new i = 0; i < MAX_VEHICLES; i++)
		{
			if(VehicleInfo[i][eVehicleDBID] == PlayerInfo[playerid][pOwnedVehicles][slotid])
				return SendErrorMessage(playerid, "รถถูกนำออกมาอยู่แล้ว");
		}
		//Easiest way to prevent players with faction vehicles duplicating it.

		mysql_format(dbCon, threadLoad, sizeof(threadLoad), "SELECT * FROM vehicles WHERE VehicleDBID = %i", PlayerInfo[playerid][pOwnedVehicles][slotid]);
		mysql_tquery(dbCon, threadLoad, "Query_LoadPrivateVehicle", "i", playerid);
	}
	return 1;
}

hook OnVehicleSpawn(vehicleid)
{
	if(HasNoEngine(vehicleid))
		ToggleVehicleEngine(vehicleid, true);
	
	return 1;
}

timer OnPlayerUnscramble[1000](playerid)
{	
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
		PlayerInfo[playerid][pUnscrambling] = false;
		PlayerInfo[playerid][pUnscramblerTime] = 0;
		PlayerInfo[playerid][pUnscrambleID] = 0;
		
		PlayerInfo[playerid][pScrambleSuccess] = 0; 
		PlayerInfo[playerid][pScrambleFailed] = 0; 
		stop PlayerInfo[playerid][pUnscrambleTimer];
		
		CreateUnscrambleTextdraw(playerid, false);
		return 1;
	}
	
	PlayerInfo[playerid][pUnscramblerTime]--;
	
	new timerString[20];
	
	format(timerString, 20, "%d", PlayerInfo[playerid][pUnscramblerTime]);
	PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][5], timerString);
	
	if(PlayerInfo[playerid][pUnscramblerTime] < 1)
	{
		PlayerInfo[playerid][pUnscrambling] = false;
		PlayerInfo[playerid][pUnscramblerTime] = 0;
		PlayerInfo[playerid][pUnscrambleID] = 0;
		
		PlayerInfo[playerid][pScrambleSuccess] = 0; 
		PlayerInfo[playerid][pScrambleFailed] = 0; 
		stop PlayerInfo[playerid][pUnscrambleTimer]; 
		
		CreateUnscrambleTextdraw(playerid, false);
		
		new 
			vehicleid = GetPlayerVehicleID(playerid)
		;
			
		ToggleVehicleAlarms(vehicleid, true);
		NotifyVehicleOwner(vehicleid);
		
		ClearAnimations(playerid);
	}
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


forward Query_LoadPrivateVehicle(playerid);
public Query_LoadPrivateVehicle(playerid)
{
	if(!cache_num_rows())
		return SendErrorMessage(playerid, "ไม่มีรถอยู่ในสล็อตนี้"); 
		
	new rows; cache_get_row_count(rows); 
	new str[128], vehicleid = INVALID_VEHICLE_ID; 
	
	for (new i = 0; i < rows && i < MAX_VEHICLES; i++)
	{
		vehicleid = CreateVehicle(cache_get_value_name_int(i, "VehicleModel", VehicleInfo[i][eVehicleModel]), 
			cache_get_value_name_float(i, "VehicleParkPosX", VehicleInfo[i][eVehicleParkPos][0]),
			cache_get_value_name_float(i, "VehicleParkPosY", VehicleInfo[i][eVehicleParkPos][1]),
			cache_get_value_name_float(i, "VehicleParkPosZ", VehicleInfo[i][eVehicleParkPos][2]),
			cache_get_value_name_float(i, "VehicleParkPosA", VehicleInfo[i][eVehicleParkPos][3]),
			cache_get_value_name_int(i, "VehicleColor1", VehicleInfo[i][eVehicleColor1]),
			cache_get_value_name_int(i, "VehicleColor2", VehicleInfo[i][eVehicleColor2]),
			-1,
			0);
			
		if(vehicleid != INVALID_VEHICLE_ID)
		{
			VehicleInfo[vehicleid][eVehicleExists] = true; 
			cache_get_value_name_int(i, "VehicleDBID",VehicleInfo[vehicleid][eVehicleDBID]);

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

			/*for(new j = 1; j < 15; j++)
			{
				format(str, sizeof(str), "VehicleMod%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleMod][j]);
			}*/
			
			for(new j = 1; j < 6; j++)
			{
				format(str, sizeof(str), "VehicleWeapons%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleWeapons][j]);
				
				format(str, sizeof(str), "VehicleWeaponsAmmo%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleWeaponsAmmo][j]);
			}
			
			for(new d = 1; d < 5; d++)
			{
				format(str, sizeof(str), "VehicleLastDrivers%d", d);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleLastDrivers][d]);
				
				format(str, sizeof(str), "VehicleLastPassengers%d", d);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleLastPassengers][d]);
			}
			
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
			
			
			//LoadVeh(vehicleid);
			
			if(HasNoEngine(playerid))
				ToggleVehicleEngine(vehicleid, true); 
		}
	}
	
	PlayerInfo[playerid][pVehicleSpawned] = true;
	PlayerInfo[playerid][pVehicleSpawnedID] = vehicleid; 
	
	SendClientMessageEx(playerid, COLOR_DARKGREEN, "%s รถได้ออกมาแล้ว", ReturnVehicleName(vehicleid));
	SendClientMessageEx(playerid, COLOR_WHITE, "Lifespan: Engine Life[%.2f], Battery Life[%.2f], Times Destroyed[%d]", VehicleInfo[vehicleid][eVehicleEngine], VehicleInfo[vehicleid][eVehicleBattery], VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
	if(VehicleInfo[vehicleid][eVehicleImpounded]) SendClientMessage(playerid, COLOR_RED, "Your vehicle is impounded.");
	
	SendClientMessage(playerid, 0xFF00FFFF, "Hint: ไปตามจุดที่เราได้มาร์กไว้เพื่อไปที่รถ");
	SetPlayerCheckpoint(playerid, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2], 3.0);
	
	PlayerCheckpoint[playerid] = 1; 
	return 1;
}