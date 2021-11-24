#include <YSI_Coding\y_hooks>

#define SPAWN_VEHICLE_START_X = 1658.7107
#define SPAWN_VEHICLE_START_Y = -1089.3168
#define SPAWN_VEHICLE_START_Z = 23.6117
#define SPAWN_VEHICLE_START_A = 88.6202

new VehiclePlateChar[][] = 
	{"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};


CMD:vbuy(playerid, params[])
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


stock ShowVehiclePreview(playerid, modelid, price)
{
    new str[255], lonstr[255];

    format(str, sizeof(str), "VehicleName: %s\n",ReturnVehicleModelName(modelid));
    strcat(lonstr, str);
    format(str, sizeof(str), "PRICE: %s",MoneyFormat(price));
    strcat(lonstr, str);

    Dialog_Show(playerid, D_VEHBUY_SHOW, DIALOG_STYLE_MSGBOX, "VEHICLE BUY", lonstr, "ยืนยันซื้อ!!", "ยกเลิก");

    SetPVarInt(playerid, "VehicleBuy:Model", modelid);
    SetPVarInt(playerid, "VehicleBuy:Price", price);
    return 1;
}

Dialog:D_VEHBUY_SHOW(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowModelVehicleBuy(playerid);

    
    new plates[32], randset[3], idx;

    new modelid = GetPVarInt(playerid, "VehicleBuy:Model");
    new price = GetPVarInt(playerid, "VehicleBuy:Price");

    if(PlayerInfo[playerid][pCash] < price)
        return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอต่อการซื้อยานพาหนะ");

    for(new i = 1; i < MAX_PLAYER_VEHICLES_V3; i++)
	{
		if(!PlayerInfo[playerid][pOwnedVehicles][i])
		{
			idx = i;
			break;
		}
	}
    

    randset[0] = random(sizeof(VehiclePlateChar)); 
	randset[1] = random(sizeof(VehiclePlateChar)); 
	randset[2] = random(sizeof(VehiclePlateChar)); 
    format(plates, 32, "%d%s%s%s%d%d%d", random(9), VehiclePlateChar[randset[0]], VehiclePlateChar[randset[1]], VehiclePlateChar[randset[2]], random(9), random(9)); 

    new thread[255];

    new 
    Float:x = 1658.7107, 
    Float:y = -1089.3168, 
    Float:z = 23.6117, 
    Float:a = 88.6202;

    mysql_format(dbCon, thread, sizeof(thread), "INSERT INTO `vehicles` (VehicleOwnerDBID, VehicleModel, VehicleParkPosX, VehicleParkPosY, VehicleParkPosZ, VehicleParkPosA) VALUES(%i, %i, %f, %f, %f, %f)",
        PlayerInfo[playerid][pDBID],
        modelid,
        x,
        y,
        z,
        a);
    mysql_tquery(dbCon, thread, "OnPlayerVehiclePurchases", "iisffff",playerid,idx, plates, x, y, z, a);
    
    return 1;
}


forward OnPlayerVehiclePurchases(playerid, newid, plates[], Float:x, Float:y, Float:z, Float:a);
public OnPlayerVehiclePurchases(playerid, newid, plates[], Float:x, Float:y, Float:z, Float:a)
{
    new modelid = GetPVarInt(playerid, "VehicleBuy:Model");
    new price = GetPVarInt(playerid, "VehicleBuy:Price");

    new
		vehicleid = INVALID_VEHICLE_ID,
        color[2]
	;

    vehicleid = 
		CreateVehicle(modelid, x, y, z, a, color[0] = random(255), color[1] = random(255), -1);

    SetVehicleNumberPlate(vehicleid, plates); 
	SetVehicleToRespawn(vehicleid); 

    PlayerInfo[playerid][pOwnedVehicles][newid] = cache_insert_id();


    if(vehicleid != INVALID_VEHICLE_ID)
	{
		VehicleInfo[vehicleid][eVehicleDBID] = cache_insert_id();
		VehicleInfo[vehicleid][eVehicleOwnerDBID] = PlayerInfo[playerid][pDBID]; 
		
		VehicleInfo[vehicleid][eVehicleModel] = modelid;
		
		VehicleInfo[vehicleid][eVehicleColor1] = color[0];
		VehicleInfo[vehicleid][eVehicleColor2] = color[1];
		
		VehicleInfo[vehicleid][eVehiclePaintjob] = -1;
		
		VehicleInfo[vehicleid][eVehicleParkPos][0] = x;
		VehicleInfo[vehicleid][eVehicleParkPos][1] = y;
		VehicleInfo[vehicleid][eVehicleParkPos][2] = z;
		VehicleInfo[vehicleid][eVehicleParkPos][3] = a;
		
		format(VehicleInfo[vehicleid][eVehiclePlates], 32, "%s", plates); 
		
		VehicleInfo[vehicleid][eVehicleLocked] = false;
		VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
		
		VehicleInfo[vehicleid][eVehicleFuel] = 50; 
		
		VehicleInfo[vehicleid][eVehicleBattery] = 100.0;
		VehicleInfo[vehicleid][eVehicleEngine] = 100.0; 
		
		VehicleInfo[vehicleid][eVehicleHasXMR] = false;
		VehicleInfo[vehicleid][eVehicleTimesDestroyed] = 0;
		
		VehicleInfo[vehicleid][eVehicleAlarmLevel] = 0;
		VehicleInfo[vehicleid][eVehicleLockLevel] = 0; 
		VehicleInfo[vehicleid][eVehicleImmobLevel] = 0; 
		
		for(new i = 1; i< 6; i++)
		{
			VehicleInfo[vehicleid][eVehicleWeapons][i] = 0;
			VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i] = 0; 
		}
        SetVehicleHp(vehicleid);
		SaveVehicle(vehicleid);
	}

    

    SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "You have purchased a %s price $%s", ReturnVehicleName(vehicleid), price);
    GiveMoney(playerid, -price);
    GlobalInfo[G_GovCash]+= price;
    Saveglobal();

    PutPlayerInVehicle(playerid, vehicleid, 0);
    return 1;
}