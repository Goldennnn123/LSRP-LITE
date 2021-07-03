#define MAX_MCGARAGE 100

new mechanic_pickup;

new
	pToAccept[MAX_PLAYERS],
	vToAccept[MAX_PLAYERS],
	tToAccept[MAX_PLAYERS],
    pvToAccept[MAX_PLAYERS],
    RepairTimer[MAX_PLAYERS],
    ServiceComp[MAX_PLAYERS],
    ServiceCall[MAX_PLAYERS],
    bool:ServiceConfirm[MAX_PLAYERS]
;

new Float:oldhp;

enum M_MCGARAGE_DATA
{
    Mc_GarageDBID,

    Float:Mc_GaragePos[3],
    Mc_GarageWorld,
    Mc_GarageInterior,
    Mc_GarageIcon
}

new McGarageInfo[MAX_MCGARAGE][M_MCGARAGE_DATA];

hook OnGameModeInit@14()
{
    mysql_tquery(dbCon, "SELECT * FROM mc_garage ORDER BY Mc_GarageDBID", "LoadMcGarage");

    mechanic_pickup = CreateDynamicPickup(1239, 2, 88.1169,-164.9625,2.5938, -1, -1,-1);
    return 1;
}

forward LoadMcGarage();
public LoadMcGarage()
{
    if(!cache_num_rows())
		return printf("[SERVER]: No MC_Garage were loaded from \"%s\" database...", MYSQL_DB);

    new rows,countmc_garage; cache_get_row_count(rows);

    for (new i = 0; i < rows && i < MAX_MCGARAGE; i ++)
    {
        cache_get_value_name_int(i,"Mc_GarageDBID",McGarageInfo[i+1][Mc_GarageDBID]);
        cache_get_value_name_float(i,"Mc_GaragePosX",McGarageInfo[i+1][Mc_GaragePos][0]);
        cache_get_value_name_float(i,"Mc_GaragePosY",McGarageInfo[i+1][Mc_GaragePos][1]);
        cache_get_value_name_float(i,"Mc_GaragePosZ",McGarageInfo[i+1][Mc_GaragePos][2]);

        cache_get_value_name_int(i,"Mc_GarageWorld",McGarageInfo[i+1][Mc_GarageWorld]);
        cache_get_value_name_int(i,"Mc_GarageInterior",McGarageInfo[i+1][Mc_GarageInterior]);

        if(IsValidDynamicPickup(McGarageInfo[i+1][Mc_GarageIcon]))
			DestroyDynamicPickup(McGarageInfo[i+1][Mc_GarageIcon]);

        McGarageInfo[i+1][Mc_GarageIcon] = CreateDynamicPickup(1239, 2, McGarageInfo[i+1][Mc_GaragePos][0], McGarageInfo[i+1][Mc_GaragePos][1], McGarageInfo[i+1][Mc_GaragePos][2], McGarageInfo[i+1][Mc_GarageWorld], McGarageInfo[i+1][Mc_GarageInterior], -1);
        countmc_garage++;
    }

    

    printf("[SERVER]: %d MC_Garage loaded from \"%s\" database...", countmc_garage, MYSQL_DB);
    return 1;
}

forward Query_InsertMcGarage(playerid, newid, Float:X, Float:Y, Float:Z, World, Interior);
public Query_InsertMcGarage(playerid, newid, Float:X, Float:Y, Float:Z, World, Interior)
{
    McGarageInfo[newid][Mc_GarageDBID] = newid;
    McGarageInfo[newid][Mc_GaragePos][0] = X;
    McGarageInfo[newid][Mc_GaragePos][1] = Y;
    McGarageInfo[newid][Mc_GaragePos][2] = Z;
    McGarageInfo[newid][Mc_GarageWorld] = World;
    McGarageInfo[newid][Mc_GarageInterior] = Interior;
    McGarageInfo[newid][Mc_GarageIcon] = CreateDynamicPickup(1239, 2, McGarageInfo[newid][Mc_GaragePos][0], McGarageInfo[newid][Mc_GaragePos][1], McGarageInfo[newid][Mc_GaragePos][2], McGarageInfo[newid][Mc_GarageWorld], McGarageInfo[newid][Mc_GarageInterior], -1);

    SendAdminMessageEx(-1, 5, "MCGARAGE: สร้าง อู่ซ่อมรถ %d",newid);
    return 1;
}

hook OP_EnterCheckpoint@12(playerid)
{
    if(PlayerCheckpoint[playerid] == 5)
    {
        GameTextForPlayer(playerid, "~p~This GPS TO BUY COMP!", 3000, 3);
        PlayerCheckpoint[playerid] = 0; DisablePlayerCheckpoint(playerid);
        return 1;
    }
    return 1;
}

hook OnPlayerConnect@12(playerid)
{
    pToAccept[playerid] = INVALID_PLAYER_ID;
	vToAccept[playerid] = INVALID_VEHICLE_ID;
	tToAccept[playerid] = INVALID_PLAYER_ID;
    pvToAccept[playerid] = INVALID_VEHICLE_ID;
    KillTimer(RepairTimer[playerid]);
    ServiceComp[playerid] = 0;
    ServiceCall[playerid] = 0;
    ServiceConfirm[playerid] = true;
    return 1;
}

stock DeleteMcGarage(id)
{
    new delMc_garage[MAX_STRING];

    mysql_format(dbCon, delMc_garage, sizeof(delMc_garage), "DELETE FROM mc_garage WHERE Mc_GarageDBID = %d", McGarageInfo[id][Mc_GarageDBID]);
	mysql_tquery(dbCon, delMc_garage); 

    McGarageInfo[id][Mc_GarageDBID] = 0;
	McGarageInfo[id][Mc_GaragePos][0] = 0.0;
	McGarageInfo[id][Mc_GaragePos][1] = 0.0;
	McGarageInfo[id][Mc_GaragePos][2] = 0.0;
	McGarageInfo[id][Mc_GarageWorld] = 0;
	McGarageInfo[id][Mc_GarageInterior] = 0;
    DestroyDynamicPickup(McGarageInfo[id][Mc_GarageIcon]);
    return 1;
}

stock GetRepairPrice(vehicleid)
{
	new	panels,
		doors,
		lights,
		tires;
		
	GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
	new front_left_panel 	= 	0xf & panels;
	new front_right_panel 	= 	( ( 0xf << 4 ) & panels ) >> 4;
	new rear_left_panel 	= 	( ( 0xf << 8 ) & panels ) >> 8;
	new rear_right_panel 	= 	( ( 0xf << 12 ) & panels ) >> 12;
	
	new wind_shield			= 	( ( 0xf << 16 ) & panels ) >> 16;
	
	new front_bumper 		= 	( ( 0xf << 20 ) & panels ) >> 20;
	new rear_bumper 		= 	( ( 0xf << 24 ) & panels ) >> 24;
	new hood 				= 	0xf & doors;	
	new trunk				= 	( ( 0xf << 8 ) & doors ) >> 8;

	new front_left_seat 	= 	( ( 0xf << 16 ) & doors ) >> 16;
	new front_right_seat 	= 	( ( 0xf << 24 ) & doors ) >> 24;
	new rear_left_seat 		= 	( ( 0xf << 32 ) & doors ) >> 32;
	new rear_right_seat 	= 	( ( 0xf << 40 ) & doors ) >> 40;

	new tire_front_left = 1 & tires;
	new tire_front_right = ( ( 1 << 1 ) & tires ) >> 1;
	new tire_rear_left = ( ( 1 << 2 ) & tires ) >> 2;
	new tire_rear_right = ( ( 1 << 3 ) & tires ) >> 3;
	new panel_add = floatround( ( 	front_left_panel +
									front_right_panel +
									rear_left_panel +
									rear_right_panel +
									wind_shield +
									front_bumper +
									rear_bumper ) / 0.21 );
						
	new door_add = floatround( ( 	hood +
									trunk +
									front_left_seat +
									front_right_seat +
									rear_left_seat +
									rear_right_seat ) / 0.24 );
	
	new tire_add = floatround( ( 	tire_front_left +
									tire_front_right +
									tire_rear_left +
									tire_rear_right ) / 0.04 );
	
	new pprice = 1 * panel_add;
	new dprice = 1 * door_add;
	new tprice = 2 * tire_add;
	return tprice + dprice + pprice;
}




CMD:service(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MECHANIC)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพช่างยนต์");

    new option, tagetid, confirm[16];

    if(sscanf(params, "udS()[16]", tagetid, option, confirm))
    {
        SendUsageMessage(playerid, "/service <ชื่อบางส่วน/ไอดี> <service>");
        SendClientMessage(playerid, COLOR_GREY, "SERVICE : OPTION");
        SendClientMessage(playerid, -1, "1. ซ่อมภายนอก (ซ่อมให้กลับมาสภาพดีแต่ไม่เพิ่มเลือดยานพหานะ)");
        SendClientMessage(playerid, -1, "2. ซ่อมภายใน (เพิ่มเลือดยานพาหนะ)");
        SendClientMessage(playerid, -1, "3. เปลี่ยนแบตตารี่ ");
        return 1;
    }

	if(!IsPlayerConnected(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[tagetid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

    if(!IsPlayerNearPlayer(playerid, tagetid, 5.0))
        return SendErrorMessage(playerid, "ผู้เล่นไมได้อยู่ใกล้คุณ");


    new vehicleid = GetPlayerVehicleID(tagetid);

    if(!IsPlayerInVehicle(tagetid, vehicleid))
        return SendErrorMessage(playerid, "ผู้เล่นไม่ได้ขึ้นรถ");
    
    if(!IsPlayerInVehicle(playerid, GetPlayerVehicleID(playerid)))
        return SendErrorMessage(playerid, "คุณต้องอยู่บนรถ TowTruck");
    
    new modelid = GetVehicleModel(GetPlayerVehicleID(playerid));

    if(modelid != 525)
        return SendErrorMessage(playerid, "คุณต้องอยู่บนรถ TowTruck");

    new comp;
    
    if(option >= 1 && option <= 3)
    {
        switch(option)
        {
            case 1:
            {
                GetVehicleHealth(vehicleid, oldhp);

                comp = floatround(float(GetRepairPrice(vehicleid)) / 10.0, floatround_round);

                if(comp < 1)
                    return SendErrorMessage(playerid, "รถไม่ได้รับความเสียหาย");

                if(!strcmp(confirm, "yes", true) && strlen(confirm))
                {
                    if(VehicleInfo[GetPlayerVehicleID(playerid)][eVehicleComp] < comp)
                        return SendErrorMessage(playerid, "อะไหล่ของคุณไม่เพียงพอ");
                
                    SendClientMessage(playerid, COLOR_YELLOW, "SERVER: ข้อเสนอถูกส่ง");
                    
                    pToAccept[playerid] = tagetid;
                    pToAccept[tagetid] = playerid;
                    vToAccept[playerid] = vehicleid;
                    pvToAccept[playerid] = GetPlayerVehicleID(playerid);
                    ServiceComp[playerid] = comp;
                    ServiceCall[playerid] = option;
                    ServiceConfirm[tagetid] = false;
                    SendClientMessageEx(tagetid, -1, "%s ได้ยืนข้อเสนอสำหรับการซ่อมยานพาหนะ %s ของคุณ "EMBED_LIGHTRED"- กด Y ย้ำๆ(1-5 ครั้ง) เพื่อยอมรับข้อเสนอนี้", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
                    return 1;
                }
                else
                {
                    SendClientMessageEx(playerid, COLOR_YELLOW, "บริการนี้ต้องใช้ อะไหล่ ทั้งหมด %d ชิ้น", comp);
                    SendSyntaxMessage(playerid, "/service %d %d yes", tagetid, option);
                    return 1;
                }
                //return 1;
            }
            case 2:
            {
                new Float:vehhp;
                new modelid_taget = GetVehicleModel(vehicleid);

                GetVehicleHealth(vehicleid, vehhp);
                
                if(GetVehicleHealth(vehicleid, vehhp) == VehicleData[modelid_taget - 400][c_maxhp])
                    return SendErrorMessage(playerid, "ภายในของรถไม่ได้รับความเสียหาย");
                
                comp = floatround(VehicleData[modelid_taget - 400][c_maxhp]- vehhp / 50.0 * 2.0);
                
                if(!strcmp(confirm, "yes", true) && strlen(confirm))
                {
                    if(VehicleInfo[GetPlayerVehicleID(playerid)][eVehicleComp] < comp)
                        return SendErrorMessage(playerid, "อะไหล่ของคุณไม่เพียงพอ");
                
                    SendClientMessage(playerid, COLOR_YELLOW, "SERVER: ข้อเสนอถูกส่ง");
                    
                    pToAccept[playerid] = tagetid;
                    pToAccept[tagetid] = playerid;
                    vToAccept[playerid] = vehicleid;
                    pvToAccept[playerid] = GetPlayerVehicleID(playerid);
                    ServiceComp[playerid] = comp;
                    ServiceCall[playerid] = option;
                    ServiceConfirm[tagetid] = false;
                    SendClientMessageEx(tagetid, -1, "%s ได้ยืนข้อเสนอสำหรับการซ่อมยานพาหนะ %s ของคุณ "EMBED_LIGHTRED"- กด Y ย้ำๆ(1-5 ครั้ง) เพื่อยอมรับข้อเสนอนี้", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
                    return 1;
                }
                else
                {
                    SendClientMessageEx(playerid, COLOR_YELLOW, "บริการนี้ต้องใช้ อะไหล่ ทั้งหมด %d ชิ้น", comp);
                    SendSyntaxMessage(playerid, "/service %d %d yes", tagetid, option);
                    return 1;
                }

            }
            case 3:
            {
                new Float:EngineLife;

                if(VehicleInfo[vehicleid][eVehicleEngine] >= 100)
                    return SendErrorMessage(playerid, "แบตตารี่เต็มแล้ว");
            
                EngineLife = 100 - VehicleInfo[vehicleid][eVehicleEngine];

                comp = floatround(EngineLife);
                if(!strcmp(confirm, "yes", true) && strlen(confirm))
                {
                    if(VehicleInfo[GetPlayerVehicleID(playerid)][eVehicleComp] < comp)
                        return SendErrorMessage(playerid, "อะไหล่ของคุณไม่เพียงพอ");
                
                    SendClientMessage(playerid, COLOR_YELLOW, "SERVER: ข้อเสนอถูกส่ง");
                    
                    pToAccept[playerid] = tagetid;
                    pToAccept[tagetid] = playerid;
                    vToAccept[playerid] = vehicleid;
                    pvToAccept[playerid] = GetPlayerVehicleID(playerid);
                    ServiceComp[playerid] = comp;
                    ServiceCall[playerid] = option;
                    ServiceConfirm[tagetid] = false;
                    SendClientMessageEx(tagetid, -1, "%s ได้ยืนข้อเสนอสำหรับการซ่อมยานพาหนะ %s ของคุณ "EMBED_LIGHTRED"- กด Y ย้ำๆ(1-5 ครั้ง) เพื่อยอมรับข้อเสนอนี้", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
                    return 1;
                }
                else
                {
                    SendClientMessageEx(playerid, COLOR_YELLOW, "บริการนี้ต้องใช้ อะไหล่ ทั้งหมด %d ชิ้น", comp);
                    SendSyntaxMessage(playerid, "/service %d %d yes", tagetid, option);
                    return 1;
                }
            }
        }
    }
    else SendErrorMessage(playerid, "กรุณาเลือกให้ถูกต้อง");
    
    return 1;
}

alias:checkcomponents("checkcomp")
CMD:checkcomponents(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MECHANIC)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพช่างยนต์");

    if(!IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ TowTruck");

    new vehicleid = GetPlayerVehicleID(playerid);

    if(GetVehicleModel(vehicleid) != 525)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้นั่งอยู่บน Tow Truck");

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้นั่งอยู่ที่นั่งคนขับของยานพาหนะ");

    SendClientMessageEx(playerid, COLOR_WHITE, "Components: %d", VehicleInfo[vehicleid][eVehicleComp]);
    return 1;
}


alias:buycomponents("buycomp")
CMD:buycomponents(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MECHANIC)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพช่างยนต์");

    if(!IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ TowTruck");

    new vehicleid = GetPlayerVehicleID(playerid);

    if(GetVehicleModel(vehicleid) != 525)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้นั่งอยู่บน Tow Truck");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้นั่งอยู่ที่นั่งคนขับของยานพาหนะ");

    if(!IsPlayerInRangeOfPoint(playerid, 3.0, -1841.0283,111.5464,15.1172))
    {
        PlayerCheckpoint[playerid] = 5;
        SetPlayerCheckpoint(playerid, -1841.0283,111.5464,15.1172, 3.0);
        return SendErrorMessage(playerid, "คุณไมได้อยู่ในจุดซื้อ อะไหล่");
    }

    new amount, price = 70, confirm[60];

    if(sscanf(params, "dS()[60]", amount, confirm))
        return SendUsageMessage(playerid, "/buycomp(onents) <จำนวน> (อะไหล่ หนึ่งชิ้น เท่ากับ $70)");
    
    if(amount < 1)
        return SendErrorMessage(playerid, "กรุณาซื้อมากกกว่า 1 ชิ้น");
    
    if(!strcmp(confirm, "yes", true) && strlen(confirm))
    {
        SendClientMessageEx(playerid, -1, "คุณได้ซื้อะไหล่ จำนวน "EMBED_GREENMONEY"%s ชิ้น "EMBED_WHITE"ราคาทั้งหมด: "EMBED_LIGHTRED"$%s", MoneyFormat(amount), MoneyFormat(price * amount));
        VehicleInfo[vehicleid][eVehicleComp]+=amount;
        GiveMoney(playerid, -price * amount);
    }
    else
    {
        SendClientMessageEx(playerid, -1, "อะไหล่ จำนวน %s ชิ้น ราคารวมทั้งหมด %s", MoneyFormat(amount), MoneyFormat(price * amount));
        SendUsageMessage(playerid, "/buycomp(onents) <%d> yes",amount);
        return 1;
    }
    return 1;
}


CMD:addcomp(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 5)
        return SendUnauthMessage(playerid);


    new vehicleid = GetPlayerVehicleID(playerid);

    VehicleInfo[vehicleid][eVehicleComp] = 9999;
    SendClientMessage(playerid, COLOR_DARKGREEN, "คุณได้ใช้คำสั่งในการ เพิ่มอะไหล่ในรถของคุณเป็น 9999 ชิ้น");
    return 1;
}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(RELEASED(KEY_YES))
	{
        if(ServiceConfirm[playerid])
            return 1;

        if(pToAccept[playerid] == INVALID_PLAYER_ID)
            return 1;
            
        SendClientMessageEx(pToAccept[playerid], -1, "%s ได้ยินยันข้อเสนอของคุณแล้ว ขั้นตอนต่อไปจะเริ่มทำการซ่อมรถ "EMBED_LIGHTBLUE"- พิมพ์คำสั่ง /fixcar ใกล้ๆรถที่จะซ่อม", ReturnName(pToAccept[playerid],0));
        SendClientMessage(playerid, -1, "คุณได้รับข้อเสนอแล้ว");

        new tagetid = pToAccept[playerid];
        tToAccept[tagetid] = playerid;
        ServiceConfirm[playerid] = true;
        return 1;
	}
    return 1;
}

CMD:fixcar(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MECHANIC)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพช่างยนต์");
    
    if(tToAccept[playerid] == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "คุณยังไมได้ยื่นข้อเสนอกับใคร");


    if(IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "ลงมาจากรถเพื่อทำการซ่อมรถ");

    new vehicleid = vToAccept[playerid];

    if(GetNearestVehicle(playerid) != vehicleid)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้รถที่จะซ่อม");


    RepairTimer[pToAccept[playerid]] = SetTimerEx("OnRepairVehicle", 1000 * ServiceComp[playerid], false, "ddd",playerid, vToAccept[playerid], ServiceCall[playerid]);
    ApplyAnimation(playerid, "CAR", "FIXN_CAR_LOOP", 4.1, 0, 0, 0, 1, 0, 0);
    SendClientMessage(playerid, COLOR_YELLOWEX, "คุณกำลังซ่อมยานพาหนะ.....");
    printf("%d",vToAccept[playerid]);
    return 1;
}

forward OnRepairVehicle(playerid, vehicleid, option);
public OnRepairVehicle(playerid, vehicleid, option)
{
    switch(option)
    {
        case 1:
        {
            VehicleInfo[pvToAccept[playerid]][eVehicleComp] -= ServiceComp[playerid];
            RepairVehicle(vehicleid);
            SetVehicleHealth(vehicleid, oldhp);

            TogglePlayerControllable(playerid, 1);
            ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
            ClearAnimations(playerid);
            SendClientMessageEx(playerid, -1, "คุณได้ซ่อมรถ %s สำเร็จแล้วใช้อะไหล่ไป %d ชิ้น", ReturnVehicleName(vehicleid), ServiceComp[playerid]);
            ResetService(tToAccept[playerid]);
            ResetService(playerid);
            return 1;
        }
        case 2:
        {
            new modelid = GetVehicleModel(vehicleid);
            SendClientMessageEx(playerid, -1, "คุณได้ซ่อมรถ %s สำเร็จแล้วใช้อะไหล่ไป %d ชิ้น", ReturnVehicleName(vehicleid), ServiceComp[playerid]);
            VehicleInfo[pvToAccept[playerid]][eVehicleComp] -= ServiceComp[playerid];
            RepairVehicle(vehicleid);
            SetVehicleHealth(vehicleid, VehicleData[modelid - 400][c_maxhp]);
            TogglePlayerControllable(playerid, 1);
            ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
            ClearAnimations(playerid);
            ResetService(tToAccept[playerid]);
            ResetService(playerid);
            return 1;
        }
        case 3:
        {
            VehicleInfo[vehicleid][eVehicleEngine] = 100;
            SendClientMessageEx(playerid, -1, "คุณได้เติมแบตตารี่ %s สำเร็จแล้วใช้อะไหล่ไป %d ชิ้น", ReturnVehicleName(vehicleid), ServiceComp[playerid]);
            VehicleInfo[pvToAccept[playerid]][eVehicleComp] -= ServiceComp[playerid];
            TogglePlayerControllable(playerid, 1);
            ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
            ClearAnimations(playerid);
            ResetService(tToAccept[playerid]);
            ResetService(playerid);
            return 1;
        }
    }
    return 1;
}

stock ResetService(playerid)
{
    pToAccept[playerid] = INVALID_PLAYER_ID;
	vToAccept[playerid] = INVALID_VEHICLE_ID;
	tToAccept[playerid] = INVALID_PLAYER_ID;
    pvToAccept[playerid] = INVALID_VEHICLE_ID;
    KillTimer(RepairTimer[playerid]);
    ServiceComp[playerid] = 0;
    ServiceCall[playerid] = 0;
    return 1;
}



