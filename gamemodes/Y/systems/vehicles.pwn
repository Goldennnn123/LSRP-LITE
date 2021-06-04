#include <YSI_Coding\y_hooks>

new PlayerText:Unscrambler_PTD[MAX_PLAYERS][7]; 
new PlayerText:Statsvehicle[MAX_PLAYERS][2];

new gLastCar[MAX_PLAYERS];
new gPassengerCar[MAX_PLAYERS];
new playerInsertID[MAX_PLAYERS];


new PlayerVehicleScrap[MAX_PLAYERS];

new bool:playerTowingVehicle[MAX_PLAYERS] = false;
new	playerTowTimer[MAX_PLAYERS] = 0;

//new possibleVehiclePlates[][] = 
	//{"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};

hook OnPlayerConnect(playerid)
{
	PlayerVehicleScrap[playerid] = 0;
	playerTowingVehicle[playerid] = false;
	playerTowTimer[playerid] = 0;
	return 1;
}

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

	VehicleInfo[vehicleid][eVehiclePrice] = 0;
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

		ShowspeedVehicle(playerid, vehicleid);
		if(!VehicleInfo[vehicleid][eVehicleEngineStatus] && !IsRentalVehicle(vehicleid))
			SendClientMessage(playerid, COLOR_DARKGREEN, "����ͧ¹��Ѻ���� (/engine)");
	
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] == PlayerInfo[playerid][pDBID])
			SendClientMessageEx(playerid, COLOR_WHITE, "�Թ�յ�͹�Ѻ��� %s �ͧ�س", ReturnVehicleName(vehicleid));

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
	else
	{
		PlayerTextDrawDestroy(playerid, Statsvehicle[playerid][0]);
		PlayerTextDrawDestroy(playerid, Statsvehicle[playerid][1]);
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
	
	SendServerMessage(playerb, "�س���Ѻ�ҹ��˹Шҡ %s ���������͵��� %i.", ReturnName(playerid), playerInsertID[playerb]);
	SendServerMessage(playerid, "�س %s �͡�ҹ��˹�����", ReturnName(playerb));
	
	playerInsertID[playerb] = 0;
	CharacterSave(playerb);
	return 1;
}

CMD:engine(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "�س���������㹷���觤��Ѻ�ͧ�ҹ��˹�"); 
		
	new vehicleid = GetPlayerVehicleID(playerid);
	
	if(HasNoEngine(vehicleid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "�ҹ��˹Фѹ������������ͧ¹��"); 

	if(!VehicleInfo[vehicleid][eVehicleDBID] && !VehicleInfo[vehicleid][eVehicleAdminSpawn] && !IsRentalVehicle(vehicleid) && !VehicleInfo[vehicleid][eVehicleFaction])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "����觹������ö����੾���ҹ��˹���ǹ��� ��س������ҹ��˹��Ҹ�ó� (Static)");
		
	if(VehicleInfo[vehicleid][eVehicleFuel] <= 0 && !VehicleInfo[vehicleid][eVehicleAdminSpawn])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "�ҹ��˹й�������������ԧ!"); 
	
	if(VehicleInfo[vehicleid][eVehicleFaction] > 0)
	{
		if(PlayerInfo[playerid][pFaction] != VehicleInfo[vehicleid][eVehicleFaction] && !PlayerInfo[playerid][pAdminDuty])
		{
			return SendClientMessage(playerid, COLOR_LIGHTRED, "�س����աح�����Ѻ�ҹ��˹Фѹ���"); 
		}
	}

	if(IsRentalVehicle(vehicleid) && !IsPlayerRentVehicle(playerid, vehicleid)) {
		return SendClientMessage(playerid, COLOR_LIGHTRED, "�س����աح�����Ѻ�ҹ��˹Фѹ���");
	}
	
	/*
	�ҹ��˹з������µç���ͧ (Hotwire)
	- �����ͧῤ���
	- �����ö�������Ңͧ
	- �����ö����աح����ͧ
	- ��������ʹ�Թ�ʡ���
	- �����ö���

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
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s ʵ�������ͧ¹��ͧ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid)); 
		ToggleVehicleEngine(vehicleid, true); VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
	}
	else
	{
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s �Ѻ����ͧ¹��ͧ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid)); 
		ToggleVehicleEngine(vehicleid, false); VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
	}
	return 1;
}

alias:unscramble("uns")
CMD:unscramble(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "�س�����Ѻ�ҹ��˹�");
		
	if(!PlayerInfo[playerid][pUnscrambling])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "�س���������µç�ҹ��˹�");
	
	if(isnull(params)) return SendSyntaxMessage(playerid, "/(uns)cramble [�Ӷʹ����]");
	
	if(strequal(UnscrambleWord[PlayerInfo[playerid][pUnscrambleID]], params, true))
	{ // ��ҵͺ�١:
	
		PlayerInfo[playerid][pUnscrambleID] = random(sizeof(UnscrambleWord)); 
		
		new displayString[60], vehicleid = GetPlayerVehicleID(playerid);
		
		format(displayString, 60, "%s", ScrambleWord(UnscrambleWord[PlayerInfo[playerid][pUnscrambleID]]));
		PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][3], displayString); 
		
		//���ҷ��������鹨Т������Ѻ����Ţͧ��͹���:
		PlayerInfo[playerid][pUnscramblerTime] += (7 - VehicleInfo[vehicleid][eVehicleImmobLevel]) * 2;
		PlayerInfo[playerid][pScrambleSuccess]++; 
		
		PlayerPlaySound(playerid, 1052, 0, 0, 0);
		//�е����µç������稹�� �������Ѻ�������͹���:
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
			
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s ʵ�������ͧ¹��ͧ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid)); 
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
		SendServerMessage(playerid, "scrap, tow, find, stats, list");
		return 1;
	}
	if(!strcmp(oneString, "get"))
	{
		new
			slotid
		;

		if(sscanf(secString, "d", slotid))
			return SendUsageMessage(playerid, "/vehicle get [���͵ö]");

		if(slotid < 0)
			return SendErrorMessage(playerid, "�������͵����ͧ���");

		if(!PlayerInfo[playerid][pOwnedVehicles][slotid])
			return SendErrorMessage(playerid, "�����ö����͵���");

		if(PlayerInfo[playerid][pVehicleSpawned] == true)
			return SendErrorMessage(playerid, "��ö�١���͡������");

		new threadLoad[128];

		for(new i = 0; i < MAX_VEHICLES; i++)
		{
			if(VehicleInfo[i][eVehicleDBID] == PlayerInfo[playerid][pOwnedVehicles][slotid])
				return SendErrorMessage(playerid, "ö�١���͡����������");
		}
		//Easiest way to prevent players with faction vehicles duplicating it.

		mysql_format(dbCon, threadLoad, sizeof(threadLoad), "SELECT * FROM vehicles WHERE VehicleDBID = %i", PlayerInfo[playerid][pOwnedVehicles][slotid]);
		mysql_tquery(dbCon, threadLoad, "Query_LoadPrivateVehicle", "i", playerid);
	}
	else if(!strcmp(oneString, "park"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "�س�������������ö");
			
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return SendErrorMessage(playerid, "�س������繤��Ѻö");

		new 
			vehicleid = GetPlayerVehicleID(playerid);
			
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "�س�������Ңͧö"); 
			
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2]))
		{
			SendErrorMessage(playerid, "�س���������㹾�鹷��ʹö�ͧ�س");
			SendClientMessage(playerid, 0xFF00FFFF, "�Ѻ��ѧ�ش��������ӡ�� ����ҡ���ѧ�����");
		
			SetPlayerCheckpoint(playerid, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2], 5.0);
			PlayerCheckpoint[playerid] = 3;
			return 1;
		}
		
		PlayerInfo[playerid][pVehicleSpawned] = false; 
		PlayerInfo[playerid][pVehicleSpawnedID] = INVALID_VEHICLE_ID;
		
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "�س��Ѵ��ö %s ���º����", ReturnVehicleName(vehicleid));
		
		SaveVehicle(vehicleid);
		
		ResetVehicleVars(vehicleid);
		DestroyVehicle(vehicleid); 
	}
	else if(!strcmp(oneString, "buypark"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "�س��������躹ö");
		
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return SendErrorMessage(playerid, "�س������繤��Ѻ");

		if(PlayerInfo[playerid][pVehicleSpawned] == false) return SendErrorMessage(playerid, "ö�ͧ�س�����١���͡��");

		if(PlayerInfo[playerid][pCash] < 5000)
			return SendErrorMessage(playerid, "�س���Թ�����§��");

		new  vehicleid = GetPlayerVehicleID(playerid);

		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "�س�������Ңͧö");

		GetVehiclePos(vehicleid, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2]);
		GetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][eVehicleParkPos][3]); 
		
		VehicleInfo[vehicleid][eVehicleParkInterior] = GetPlayerInterior(playerid);
		VehicleInfo[vehicleid][eVehicleParkWorld] = GetPlayerVirtualWorld(playerid); 
		
		SendServerMessage(playerid, "�س����;�鹷��ʹö������Ҥ� $5,000.");
		GiveMoney(playerid, -5000);
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(oneString, "list"))
	{
		ShowVehicleList(playerid);
	}
	else if(!strcmp(oneString, "buy"))
	{
		new id = IsPlayerNearBusiness(playerid);
		new idx = 0;
		
		if(id == 0)
			return SendErrorMessage(playerid,"�س��������������ҹ���᷹��˹���ö");

		if(BusinessInfo[id][BusinessType] != 2)
			return SendErrorMessage(playerid,"�س�����������ҹ���ö");

		for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
		{
			if(!PlayerInfo[playerid][pOwnedVehicles][i])
			{
				idx = i;
				break;
			}
		}

		if(idx == 0)
			return SendErrorMessage(playerid,"�س��ö����������");

		
		//PlayerOwnerDBID[playerid] = idx;
		//ShowVehicleBuy(playerid);
	}
	else if(!strcmp(oneString, "duplicatekey"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "�س��������躹ö");

		if(PlayerInfo[playerid][pVehicleSpawned] == false) return SendErrorMessage(playerid, "ö�ͧ�س�����١���͡��");

		new 
			playerb, vehicleid = GetPlayerVehicleID(playerid);

		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "�س�������Ңͧö");

		if(sscanf(secString, "u", playerb))
			return SendUsageMessage(playerid, "/vehicle duplicatekey [���ͺҧ��ǹ/�ʹ�]");

		if(playerb == playerid)return SendErrorMessage(playerid, "�س�������ö���ح����ͧ�Ѻ����ͧ��");

		if(!IsPlayerConnected(playerb))
			return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����");

		if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
			return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");
		
		if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
			return SendErrorMessage(playerid, "������������������س");

		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s �����ش�ح����ͧ�Ѻ %s", ReturnName(playerid, 0), ReturnName(playerb, 0));
		SendServerMessage(playerb, "%s �����ش�ح����ͧ�Ѻ�س", ReturnName(playerid, 0));
		
		GiveMoney(playerid, -500);
		SendServerMessage(playerid, "�س�����ش�ح����ͧ�Ѻ %s  ��������Թ $500", ReturnName(playerb, 0));
		PlayerInfo[playerb][pDuplicateKey] = vehicleid;
	}
	else if(!strcmp(oneString, "scrap"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "�س��������������ö");
			
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return SendErrorMessage(playerid, "�س������繤��Ѻö");
			
		if(PlayerInfo[playerid][pVehicleSpawned] == false) return SendErrorMessage(playerid, "ö�ͧ�س�ѧ�����١���͡��");

		new 
			str[160], 
			vehicleid = GetPlayerVehicleID(playerid)
		;

		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "�س�������Ңͧö");

		PlayerVehicleScrap[playerid] = vehicleid;

		format(str, sizeof(str), "�س������������Т��ö�ͧ�س��� ��Ҥس���ö�ͧ�س�س�����Ѻ�Թ $%s ������Թ��� 2 �ͧ�Ҥ�����ͧö\n�����ô����������ö�ͧ�س���������ö�ӡ�Ѻ�����ա���ա",MoneyFormat(VehicleInfo[vehicleid][eVehiclePrice] / 2));
		Dialog_Show(playerid, DIALOG_VEH_SELL, DIALOG_STYLE_MSGBOX, "�س��������?", str, "�׹�ѹ", "¡��ԡ");
	}
	else if(!strcmp(oneString, "tow"))
	{
		if(PlayerInfo[playerid][pVehicleSpawned] == false) 
			return SendErrorMessage(playerid, "�س������ö�͡��");
			
		if(IsVehicleOccupied(PlayerInfo[playerid][pVehicleSpawnedID]))
			return SendErrorMessage(playerid, "ö�ѹ����ѧ����͹�������");

		if(playerTowingVehicle[playerid])
			return SendErrorMessage(playerid, "�س���ѧ��ö��Ѻ����....");

		VehicleInfo[PlayerInfo[playerid][pVehicleSpawnedID]][eVehicleTowDisplay] = 
			Create3DTextLabel("(( | ))\nTOWING VEHICLE", COLOR_DARKGREEN, 0.0, 0.0, 0.0, 25.0, 0, 1);
		
		Attach3DTextLabelToVehicle(VehicleInfo[PlayerInfo[playerid][pVehicleSpawnedID]][eVehicleTowDisplay], PlayerInfo[playerid][pVehicleSpawnedID], -0.0, -0.0, -0.0);

		playerTowingVehicle[playerid] = true;
		playerTowTimer[playerid] = SetTimerEx("OnVehicleTow", 5000, true, "i", playerid);
		
		SendServerMessage(playerid, "�س���觤Ӣ�����Сѹ��ö %s �������ش�Դ����", ReturnVehicleName(PlayerInfo[playerid][pVehicleSpawnedID]));
	}
	else if(!strcmp(oneString, "find"))
	{
		if(PlayerInfo[playerid][pVehicleSpawned] == false) 
			return SendErrorMessage(playerid, "�س������ö�͡��");
			
		if(IsVehicleOccupied(PlayerInfo[playerid][pVehicleSpawnedID]))
			return SendErrorMessage(playerid, "ö�ͧ�س�ѧ�ա������͹�������");
			
		new 
			Float:fetchPos[3];
		
		GetVehiclePos(PlayerInfo[playerid][pVehicleSpawnedID], fetchPos[0], fetchPos[1], fetchPos[2]);
		SetPlayerCheckpoint(playerid, fetchPos[0], fetchPos[1], fetchPos[2], 3.0);
	}
	else if(!strcmp(oneString, "stats"))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "�س�������Ңͧö");
			
		SendClientMessageEx(playerid, COLOR_WHITE, "Life Span: Engine Life[%.2f], Battery Life[%.2f], Times Destroyed[%i]", VehicleInfo[vehicleid][eVehicleEngine], VehicleInfo[vehicleid][eVehicleBattery], VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Security: Lock Level[%i], Alarm Level[%i], Immobilizer[%i]", VehicleInfo[vehicleid][eVehicleLockLevel], VehicleInfo[vehicleid][eVehicleAlarmLevel], VehicleInfo[vehicleid][eVehicleImmobLevel]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Misc: Primary Color[%d], Secondary Color[%d], License Plate[%s]",VehicleInfo[vehicleid][eVehicleColor1],VehicleInfo[vehicleid][eVehicleColor2], VehicleInfo[vehicleid][eVehiclePlates]);
	}
	return 1;
}

CMD:lights(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
		
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "�س�������������ö");
			
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "�س������繤��Ѻ");
		
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
			return SendServerMessage(playerid, "ö�ѹ���١��ͤ����"); 
			
		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "�س������������ҡ���ç����ö");
			
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
		if(!boot)
		{

			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 1, objective);
				
			SendClientMessage(playerid, COLOR_YELLOWEX, "�س��ӡ���Դ�ҡ���ç����ö");
			SendClientMessage(playerid, COLOR_WHITE, "����ö����� /check ���� /place ��");

			format(str, sizeof(str), "* %s ���Դ�ҡ���çö %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
		else
		{

			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 0, objective);
				
			SendClientMessage(playerid, COLOR_YELLOWEX, "�س��Դ�ҡ���ç����ö");

			format(str, sizeof(str), "* %s ��Դ�ҡ���çö %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
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
			return SendErrorMessage(playerid, "�س������繤��Ѻ");
			
		if(PlayerInfo[playerid][pDBID] != VehicleInfo[vehicleid][eVehicleOwnerDBID] && PlayerInfo[playerid][pDuplicateKey] != vehicleid)
			return SendErrorMessage(playerid, "�س������աح�"); 
			
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
		if(!boot)
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 1, objective);
				
			SendClientMessage(playerid, COLOR_YELLOWEX, "�س��ӡ���Դ�ҡ���ç����ö");
			SendClientMessage(playerid, COLOR_WHITE, "����ö����� /check ���� /place ��"); 

			format(str, sizeof(str), "* %s ���Դ�ҡ���çö %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
		else
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 0, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "�س��Դ�ҡ���ç����ö");

			format(str, sizeof(str), "* %s ��Դ�ҡ���çö %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
	}
	else SendErrorMessage(playerid, "�س���������/�ö �ͧ�س");
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
			return SendServerMessage(playerid, "ö�ѹ���١��ͤ����"); 
			
		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "�س������������ҡ���ç˹��ö");
			
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
		if(!bonnet)
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 1, boot, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "�س���Դ�ҡ���ç˹��ö");

			format(str, sizeof(str), "* %s ���Դ�ҡ���ç˹��ö %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
		else
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 0, boot, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "�س���Դ�ҡ���ç˹��ö");

			format(str, sizeof(str), "* %s ��Դ�ҡ���ç˹��ö %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		new
			vehicleid = GetPlayerVehicleID(playerid)
		;
			
		if(PlayerInfo[playerid][pDBID] != VehicleInfo[vehicleid][eVehicleOwnerDBID] && PlayerInfo[playerid][pDuplicateKey] != vehicleid)
			return SendErrorMessage(playerid, "�س����աح�ö"); 
				
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendErrorMessage(playerid, "�س������繤��Ѻ");
				
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
		if(!bonnet)
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 1, boot, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "�س���Դ�ҡ���ç˹��ö");

			format(str, sizeof(str), "* %s ���Դ�ҡ���ç˹��ö %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
		else
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 0, boot, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "�س���Դ�ҡ���ç˹��ö");

			format(str, sizeof(str), "* %s ��Դ�ҡ���ç˹��ö %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
	}
	else return SendServerMessage(playerid, "�س������������ö");
	return 1;
}

stock ShowVehicleList(playerid)
{
	new thread[MAX_STRING];

	SendClientMessageEx(playerid, COLOR_DARKGREEN, "_________________Your vehicles(%i)_________________", CountPlayerVehicles(playerid));

	for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
	{
		if(PlayerInfo[playerid][pOwnedVehicles][i])
		{
			mysql_format(dbCon, thread, sizeof(thread), "SELECT * FROM vehicles WHERE VehicleDBID = %i", PlayerInfo[playerid][pOwnedVehicles][i]);
			mysql_tquery(dbCon, thread, "Query_ShowVehicleList", "ii", playerid, i);
		}
	}

	return 1;
}

stock CountPlayerVehicles(playerid)
{
	new
		count = 0
	;
	
	for(new i = 1; i < 6; i++)
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
		bool:isSpawned = false,
		color
	;

	for(new i = 0; i < rows; i++)
	{
		cache_get_value_name_int(0,"VehicleDBID",vehicleDBID);
		cache_get_value_name_int(0,"VehicleModel",vehicleModel);

		cache_get_value_name_int(0,"VehicleLockLevel",vehicleLockLevel);
		cache_get_value_name_int(0,"VehicleAlarmLevel",vehicleAlarmLevel);
		cache_get_value_name_int(0,"VehicleImmobLevel",vehicleImmobLevel);

		cache_get_value_name_int(0,"vehicleTimesDestroyed",vehicleTimesDestroyed);

		cache_get_value_name(0,"VehiclePlates",vehiclePlates,32);
	}

	for(new id = 0; id < MAX_VEHICLES; id++)
	{
		if(VehicleInfo[id][eVehicleDBID] == vehicleDBID)
		{
			isSpawned = true;
		}
	}

	if(isSpawned)
		color = COLOR_DARKGREEN;

	else color = COLOR_WHITE;

	SendClientMessageEx(playerid, color, "Vehicle %i: %s, Lock[%i], Alarm[%i], Immobiliser[%i], Times destroyed[%i], Plates[%s]", idx, ReturnVehicleModelName(vehicleModel), vehicleLockLevel, vehicleAlarmLevel, vehicleImmobLevel, vehicleTimesDestroyed, vehiclePlates);
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
			return SendClientMessage(playerid, COLOR_YELLOW2, "SMS: �ѭ�ҳ��͹����ҹ��˹Тͧ�س�ѧ���, �����: �ѭ�ҳ��͹��¢ͧ�ҹ��˹� (����Һ)");
		}
	}
	return 0;
}


forward LoadFactionVehicle();
public LoadFactionVehicle()
{
	if(!cache_num_rows())
		return print("No Vehicle Faction In Database");

	new rows; cache_get_row_count(rows);
	new vehicleid = INVALID_VEHICLE_ID, amout_veh;

	new VehicleModel,Float:VehicleParkPos[4],VehicleColor1,VehicleColor2;

	for (new i = 0; i < rows && i < MAX_FACTION_VEHICLE; i++)
	{
		cache_get_value_name_int(i, "VehicleModel", VehicleModel);
		cache_get_value_name_float(i, "VehicleParkPosX", VehicleParkPos[0]);
		cache_get_value_name_float(i, "VehicleParkPosY", VehicleParkPos[1]);
		cache_get_value_name_float(i, "VehicleParkPosZ", VehicleParkPos[2]);
		cache_get_value_name_float(i, "VehicleParkPosA", VehicleParkPos[3]);
		cache_get_value_name_int(i, "VehicleColor1", VehicleColor1);
		cache_get_value_name_int(i, "VehicleColor2", VehicleColor2);

		vehicleid = CreateVehicle(VehicleModel, 
			VehicleParkPos[0],
			VehicleParkPos[1],
			VehicleParkPos[2],
			VehicleParkPos[3],
			VehicleColor1,
			VehicleColor2,
			-1,
			0);

		if(vehicleid != INVALID_VEHICLE_ID)
		{
			VehicleInfo[vehicleid][eVehicleExists] = true; 

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
		amout_veh++;
	}

	printf("%d Vehicle Faction In Database...", amout_veh);
	return 1;
}


forward Query_LoadPrivateVehicle(playerid);
public Query_LoadPrivateVehicle(playerid)
{
	if(!cache_num_rows())
		return SendErrorMessage(playerid, "�����ö��������͵���"); 
		
	new rows; cache_get_row_count(rows); 
	new str[MAX_STRING], vehicleid = INVALID_VEHICLE_ID; 

	new VehicleModel,Float:VehicleParkPos[4],VehicleColor1,VehicleColor2;
	
	for (new i = 0; i < rows && i < MAX_VEHICLES; i++)
	{
		cache_get_value_name_int(i, "VehicleModel", VehicleModel);
		cache_get_value_name_float(i, "VehicleParkPosX", VehicleParkPos[0]);
		cache_get_value_name_float(i, "VehicleParkPosY", VehicleParkPos[1]);
		cache_get_value_name_float(i, "VehicleParkPosZ", VehicleParkPos[2]);
		cache_get_value_name_float(i, "VehicleParkPosA", VehicleParkPos[3]);
		cache_get_value_name_int(i, "VehicleColor1", VehicleColor1);
		cache_get_value_name_int(i, "VehicleColor2", VehicleColor2);

		vehicleid = CreateVehicle(VehicleModel, 
			VehicleParkPos[0],
			VehicleParkPos[1],
			VehicleParkPos[2],
			VehicleParkPos[3],
			VehicleColor1,
			VehicleColor2,
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
			
			cache_get_value_name_int(i, "VehicleFuel",VehicleInfo[vehicleid][eVehicleFuel]);
			
			cache_get_value_name_int(i, "VehicleXMR",VehicleInfo[vehicleid][eVehicleHasXMR]);
			cache_get_value_name_int(i, "VehicleTimesDestroyed",VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
			
			cache_get_value_name_float(i, "VehicleEngine",VehicleInfo[vehicleid][eVehicleEngine]);
			cache_get_value_name_float(i, "VehicleBattery",VehicleInfo[vehicleid][eVehicleBattery]);
			
			cache_get_value_name_int(i, "VehicleAlarmLevel",VehicleInfo[vehicleid][eVehicleAlarmLevel]);
			cache_get_value_name_int(i, "VehicleLockLevel",VehicleInfo[vehicleid][eVehicleLockLevel]);
			cache_get_value_name_int(i, "VehicleImmobLevel",VehicleInfo[vehicleid][eVehicleImmobLevel]);
			
			
			cache_get_value_name_int(i, "VehiclePaintjob",VehicleInfo[vehicleid][eVehiclePaintjob]);

			cache_get_value_name_int(i, "VehiclePrice",VehicleInfo[vehicleid][eVehiclePrice]);

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
	
	SendClientMessageEx(playerid, COLOR_DARKGREEN, "�س���ö %s �͡������", ReturnVehicleName(vehicleid));
	SendClientMessageEx(playerid, COLOR_WHITE, "Lifespan: Engine Life[%.2f], Battery Life[%.2f], Times Destroyed[%d]", VehicleInfo[vehicleid][eVehicleEngine], VehicleInfo[vehicleid][eVehicleBattery], VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
	if(VehicleInfo[vehicleid][eVehicleImpounded]) SendClientMessage(playerid, COLOR_RED, "ö�ͧ�س�١�ִ");
	
	SendClientMessage(playerid, 0xFF00FFFF, "Hint: 仵���ش�������������������价��ö");
	SetPlayerCheckpoint(playerid, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2], 3.0);
	
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
			return SendErrorMessage(playerid, "�س������������ö"); 
					
		if(!VehicleInfo[vehicleid][eVehicleWeapons][listitem+1])
			return SendErrorMessage(playerid, "");
				
		GivePlayerGun(playerid, VehicleInfo[vehicleid][eVehicleWeapons][listitem+1], VehicleInfo[vehicleid][eVehicleWeaponsAmmo][listitem+1]); 
				
		format(str, sizeof(str), "* %s ��Ժ %s �͡�Ҩҡö %s", ReturnName(playerid, 0), ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][listitem+1]), 
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
		return SendServerMessage(playerid,"�س¡��ԡ��â��ö�ͧ�س����");

	if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "�س��������躹ö����㹵͹�������¡��ԡ㹡�â���ҹ��˹�㹵͹���ѹ��");
	
	new vehicleid = PlayerVehicleScrap[playerid];
	new id = IsPlayerNearBusiness(playerid);
	new dbid = VehicleInfo[vehicleid][eVehicleDBID];
	new cash_back = VehicleInfo[vehicleid][eVehiclePrice] / 2;

	if(!id)
		return SendErrorMessage(playerid,"�س��������������ҹ���ö");
	
	new delQuery[128];
		
	mysql_format(dbCon, delQuery, sizeof(delQuery), "DELETE FROM vehicles WHERE VehicleDBID = %i", dbid);
	mysql_tquery(dbCon, delQuery);

	SendServerMessage(playerid, "�س����ö ��� %s �͡�ҡ��Ǥس����", ReturnVehicleName(GetPlayerVehicleID(playerid))); 
	SendServerMessage(playerid, "��Фس���Ѻ�Թ�׹㹨ӹǹ $%s", MoneyFormat(cash_back));
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

forward OnVehicleTow(playerid);
public OnVehicleTow(playerid)
{
	new vehicleid = PlayerInfo[playerid][pVehicleSpawnedID], newDisplay[128]; 
	
	if(IsVehicleOccupied(vehicleid))
	{
		KillTimer(playerTowTimer[playerid]);
		SendServerMessage(playerid, "��ù�ö��Ѻ��ѧ�ش�Դ��鹶١�Ѵ�������úҧ���ҧ"); 
		
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
		SendServerMessage(playerid, "ö�ͧ�س�١�觡�Ѻ�ش�Դ����");
		GiveMoney(playerid, -2000);
		
		playerTowingVehicle[playerid] = false;	
		SetVehicleToRespawn(vehicleid); 
		
		Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleTowDisplay]);
		KillTimer(playerTowTimer[playerid]);
		
		VehicleInfo[vehicleid][eVehicleTowCount] = 0; 
		return 1;
	}
	
	return 1;
}

stock ToggleVehicleLights(vehicleid, bool:lightstate)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lightstate, alarm, doors, bonnet, boot, objective);
	
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

stock ShowspeedVehicle(playerid, vehicleid)
{
	Statsvehicle[playerid][0] = CreatePlayerTextDraw(playerid, 529.000000, 384.000000, "100 KPH/MPH");
	PlayerTextDrawFont(playerid, Statsvehicle[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, Statsvehicle[playerid][0], 0.333332, 2.049998);
	PlayerTextDrawTextSize(playerid, Statsvehicle[playerid][0], 646.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Statsvehicle[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Statsvehicle[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, Statsvehicle[playerid][0], 1);
	PlayerTextDrawColor(playerid, Statsvehicle[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, Statsvehicle[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, Statsvehicle[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, Statsvehicle[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, Statsvehicle[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, Statsvehicle[playerid][0], 0);

	Statsvehicle[playerid][1] = CreatePlayerTextDraw(playerid, 549.000000, 404.000000, "100%");
	PlayerTextDrawFont(playerid, Statsvehicle[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, Statsvehicle[playerid][1], 0.370833, 1.299999);
	PlayerTextDrawTextSize(playerid, Statsvehicle[playerid][1], 595.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Statsvehicle[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, Statsvehicle[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, Statsvehicle[playerid][1], 1);
	PlayerTextDrawColor(playerid, Statsvehicle[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, Statsvehicle[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, Statsvehicle[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, Statsvehicle[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, Statsvehicle[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, Statsvehicle[playerid][1], 0);


	PlayerTextDrawShow(playerid, Statsvehicle[playerid][0]);
	PlayerTextDrawShow(playerid, Statsvehicle[playerid][1]);

	new str[MAX_STRING];

	format(str, sizeof(str), "%d%",VehicleInfo[vehicleid][eVehicleFuel]);
	PlayerTextDrawSetString(playerid, Statsvehicle[playerid][1], str);
	return 1;
}

forward OnVehicleUpdate(playerid);
public OnVehicleUpdate(playerid)
{
	new str[120];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		format(str, sizeof(str), "%d KPH/MPH",GetVehicleSpeed(vehicleid));
		PlayerTextDrawSetString(playerid, Statsvehicle[playerid][0], str);
	}
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

/*forward Query_InsertVehicle_Faction(playerid, factionid, modelid,color1,color2,Float:x,Float:y,Float:z,Float:a,world,newid);
public Query_InsertVehicle_Faction(playerid, factionid, modelid,color1,color2,Float:x,Float:y,Float:z,Float:a,world,newid)
{
	new vehicleid = INVALID_VEHICLE_ID;

	vehicleid = CreateVehicle(modelid, x, y, z, a, color1, color2, -1, 0);

	if(vehicleid != INVALID_VEHICLE_ID)
	{
		VehicleInfo[vehicleid][eVehicleDBID] = newid;
		VehicleInfo[vehicleid][eVehicleModel] = modelid;
		VehicleInfo[vehicleid][eVehicleFaction] = factionid;

		VehicleInfo[vehicleid][eVehicleColor1] = color1;
		VehicleInfo[vehicleid][eVehicleColor2] = color2;
	}

	SendClientMessageEx(playerid, -1, "�س�����ҧö࿤������Ѻ {FF5722}%s {FFFFFF}(%d)",FactionInfo[factionid][eFactionName],newid);
	return 1;
}*/

forward CountVehicle(playerid,factionid, modelid,color1,color2,Float:x,Float:y,Float:z,Float:a,world);
public CountVehicle(playerid,factionid, modelid,color1,color2,Float:x,Float:y,Float:z,Float:a,world)
{
	new VEHDBID = 0,thread[MAX_STRING];

	new rows; cache_get_row_count(rows);

	for (new i = 0; i < rows; i++)
	{
		VEHDBID++;
	}

	mysql_format(dbCon, thread, sizeof(thread), "SELECT * FROM vehicle_faction ORDER BY VehicleDBID");
	mysql_tquery(dbCon, thread, "CountVehicle2", "dddddffffdd", playerid,factionid,modelid,color1,color2,x,y,z,a,world,VEHDBID);
	return 1;
}

forward CountVehicle2(playerid,factionid, modelid,color1,color2,Float:x,Float:y,Float:z,Float:a,world,newid);
public CountVehicle2(playerid,factionid, modelid,color1,color2,Float:x,Float:y,Float:z,Float:a,world,newid)
{
	new thread[MAX_STRING],vehicleid = INVALID_VEHICLE_ID;

	new rows; cache_get_row_count(rows);

	for (new i = 0; i < rows; i++)
	{
		newid++;
	}

	newid++;

	mysql_format(dbCon, thread, sizeof(thread), "INSERT INTO vehicle_faction (`VehicleModel`, `VehicleFaction`,`VehicleColor1`,`VehicleColor2`,`VehicleParkPosX`,`VehicleParkPosY`,`VehicleParkPosZ`,`VehicleParkPosA`,`VehicleParkWorld`) VALUES(%d,%d,%d,%d,%f,%f,%f,%f,%d)",
		modelid,
		factionid,
		color1,
		color2,
		x,
		y,
		z,
		a,
		world);
	mysql_tquery(dbCon, thread);

	vehicleid = CreateVehicle(modelid, x, y, z, a, color1, color2, -1, 0);

	if(vehicleid != INVALID_VEHICLE_ID)
	{
		VehicleInfo[vehicleid][eVehicleDBID] = newid;
		VehicleInfo[vehicleid][eVehicleModel] = modelid;
		VehicleInfo[vehicleid][eVehicleFaction] = factionid;

		VehicleInfo[vehicleid][eVehicleColor1] = color1;
		VehicleInfo[vehicleid][eVehicleColor2] = color2;
	}

	SendClientMessageEx(playerid, -1, "�س�����ҧö࿤������Ѻ {FF5722}%s {FFFFFF}(%d)",FactionInfo[factionid][eFactionName],newid);

	return 1;
}