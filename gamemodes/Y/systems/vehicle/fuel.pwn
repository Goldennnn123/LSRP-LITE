#include <YSI_Coding\y_hooks>


new PlayerEditObjectFuel[MAX_PLAYERS];

hook OnGameModeInit()
{
    mysql_tquery(dbCon, "SELECT * FROM fuel ORDER BY F_ID", "LoadFuel");
    return 1;
}

hook OnPlayerConnect(playerid)
{
    PlayerEditObjectFuel[playerid] = INVALID_OBJECT_ID;
    return 1;
}


hook OnPlayerDisconnect(playerid, reason)
{
    DeletePVar(playerid, "RefillFuelStats");
    return 1;
}

forward LoadFuel();
public LoadFuel()
{
    if(!cache_num_rows())
		return printf("[SERVER]: No Fuel were loaded from \"%s\" database...", MYSQL_DB);

    new rows; cache_get_row_count(rows);

    for (new i = 0; i < rows && i < MAX_FUELS; i ++)
    {
        cache_get_value_name_int(i,"F_ID",FuelInfo[i+1][F_ID]);
        cache_get_value_name_int(i,"F_OwnerDBID",FuelInfo[i+1][F_OwnerDBID]);
        cache_get_value_name_float(i,"F_Fuel",FuelInfo[i+1][F_Fuel]);

        cache_get_value_name_int(i,"F_Business",FuelInfo[i+1][F_Business]);
        cache_get_value_name_int(i,"F_Price",FuelInfo[i+1][F_Price]);
        cache_get_value_name_int(i,"F_PriceBuy",FuelInfo[i+1][F_PriceBuy]);

        cache_get_value_name_float(i,"F_PosX",FuelInfo[i+1][F_Pos][0]);
        cache_get_value_name_float(i,"F_PosY",FuelInfo[i+1][F_Pos][1]);
        cache_get_value_name_float(i,"F_PosZ",FuelInfo[i+1][F_Pos][2]);
        cache_get_value_name_float(i,"F_PosRX",FuelInfo[i+1][F_Pos][3]);
        cache_get_value_name_float(i,"F_PosRY",FuelInfo[i+1][F_Pos][4]);
        cache_get_value_name_float(i,"F_PosRZ",FuelInfo[i+1][F_Pos][5]);

        if(IsValidDynamic3DTextLabel(FuelInfo[i+1][F_Text]))
		    DestroyDynamic3DTextLabel(FuelInfo[i+1][F_Text]);
        
        UpdateFuel(i+1);


        if(IsValidDynamicObject(FuelInfo[i+1][F_Object]))
			DestroyDynamicObject(FuelInfo[i+1][F_Object]);
    
        FuelInfo[i+1][F_Object] = CreateDynamicObject(3465, FuelInfo[i+1][F_Pos][0], FuelInfo[i+1][F_Pos][1], FuelInfo[i+1][F_Pos][2], FuelInfo[i+1][F_Pos][3], FuelInfo[i+1][F_Pos][4], FuelInfo[i+1][F_Pos][5], 0, 0, -1);
    }
    return 1;
}

CMD:fuelcmds(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 5)
        return SendUnauthMessage(playerid);

    SendClientMessage(playerid, COLOR_DARKGREEN, "___________www.lsrplite.xyz___________");
    SendClientMessage(playerid, COLOR_GRAD2,"[FUEL] /makefuelstation /gotofuel /editfuel");
    SendClientMessage(playerid, COLOR_GREEN,"_____________________________________");
    SendClientMessage(playerid, COLOR_GRAD1,"โปรดศึกษาคำสั่งในเซิร์ฟเวอร์เพิ่มเติมในฟอรั่มหรือ /helpme เพื่อขอความช่วยเหลือ");   
    return 1;
}


CMD:makefuelstation(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < LEAD_ADMIN)
		return SendUnauthMessage(playerid);

    new id;

    if(sscanf(params, "i", id))
        return SendUsageMessage(playerid, "/makefuelstation [ID-กิจการที่เป็น 24/7]");

    if(!BusinessInfo[id][BusinessDBID] || id > MAX_BUSINESS)
		return SendErrorMessage(playerid, "ไม่มีกิจการที่ต้องการ");


    SetPVarInt(playerid, "BusinessSelete", id);
	SetPVarInt(playerid, "MakeFuelObject",1);

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid,x, y, z);
	PlayerEditObjectFuel[playerid] = CreateDynamicObject(3465,x+3, y, z, 0.0, 0.0, 0.0, 0, 0, -1);
	EditDynamicObject(playerid, PlayerEditObjectFuel[playerid]);
	return 1;
}

CMD:gotofuel(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 5)
		return SendUnauthMessage(playerid);

    new id;

    if(sscanf(params, "d", id))
        return SendUsageMessage(playerid, "/gotofuel [ID]");

    if(!FuelInfo[id][F_ID])
        return SendErrorMessage(playerid, "ไม่มีไอดีที่คุณต้องการ");

    SetPlayerPos(playerid, FuelInfo[id][F_Pos][0]+2, FuelInfo[id][F_Pos][1], FuelInfo[id][F_Pos][2]);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);

    PlayerInfo[playerid][pInsideProperty] = 0; 
	PlayerInfo[playerid][pInsideBusiness] = 0;
    SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เคลื่อยย้ายตัวคุณมาที่ปั้มน้ำมันไอดีที่ %d", id);
    return 1;
}

CMD:editfuel(playerid, params[])
{
    new id;

    for(new i = 1; i < MAX_FUELS; i++)
    {
        if(!FuelInfo[i][F_ID])
            continue;
        
        if(IsPlayerInRangeOfPoint(playerid, 2.5, FuelInfo[i][F_Pos][0], FuelInfo[i][F_Pos][1], FuelInfo[i][F_Pos][2]))
        {
            id = i;
            break;
        }
    }

    if(id == 0)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้กิจการ");

    if(PlayerInfo[playerid][pAdmin] < 5 && BusinessInfo[FuelInfo[id][F_Business]][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของ");

    
    new str[MAX_STRING], longstr[MAX_STRING];

    format(str, sizeof(str), "ID: %d\n",FuelInfo[id][F_ID]);
    strcat(longstr, str);

    format(str, sizeof(str), "เจ้าของ: %s\n",ReturnDBIDName(BusinessInfo[FuelInfo[id][F_Business]][BusinessOwnerDBID]));
    strcat(longstr, str);

    format(str, sizeof(str), "น้ำมันที่เหลือ: %.1f ลิตร\n",FuelInfo[id][F_Fuel]);
    strcat(longstr, str);

    format(str, sizeof(str), "ราคาต่อลิตร: %s\n",MoneyFormat(FuelInfo[id][F_Price]));
    strcat(longstr, str);

    format(str, sizeof(str), "ตั้งราคารับ: %s ต่อลิตร\n",MoneyFormat(FuelInfo[id][F_PriceBuy]));
    strcat(longstr, str);


    if(PlayerInfo[playerid][pAdmin] >= 5)
    {
        format(str, sizeof(str), "ลบ\n");
        strcat(longstr, str);
    }

    SetPVarInt(playerid, "SetIdFuel", id);
    Dialog_Show(playerid, D_FUEL_MENU, DIALOG_STYLE_LIST, "FULE EDITER", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

alias:refill("fill", "เติมน้ำมัน")
CMD:refill(playerid, params[])
{
    if(!IsPlayerInAnyVehicle(playerid))
    {
        if(!PlayerInfo[playerid][pGasCan])
            return SendErrorMessage(playerid, "คุณไม่มี Gascan");

        if(!GetNearestVehicle(playerid))
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ยานพาหนะ");

        
        new vehicleid = GetNearestVehicle(playerid);

        if(VehicleInfo[vehicleid][eVehicleLocked] == true)
            return SendErrorMessage(playerid, "ยานพาหานะ ล็อคอยู่");

        if(VehicleInfo[vehicleid][eVehicleFuel] > 30)
            return SendErrorMessage(playerid, "น้ำมันจำเป็นต้องตต่ำกว่า 30");

        SendClientMessage(playerid, COLOR_YELLOWEX, "คุณกำลังเติมน้ำมันผ่าน Gascan");
        VehicleInfo[vehicleid][eVehicleFuelTimer] = SetTimerEx("RefillFuelGascan", 1500, true, "dd",playerid, vehicleid);
        SetPVarInt(playerid, "RefillFuelStats", 1);
        return 1;
    }
    else if(IsPlayerInAnyVehicle(playerid))
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
            return SendErrorMessage(playerid, "คุณต้องเป็นคนขับ");

        if(GetPVarInt(playerid, "RefillFuelStats"))
            return SendErrorMessage(playerid, "คุณกำลังเติมน้ำมันอยู่");

        new id, Float:FuelCount;

        for(new i = 1; i < MAX_FUELS; i++)
        {
            if(!FuelInfo[i][F_ID])
                continue;
            
            if(IsPlayerInRangeOfPoint(playerid, 3.5, FuelInfo[i][F_Pos][0], FuelInfo[i][F_Pos][1], FuelInfo[i][F_Pos][2]))
            {
                id = i;
                break;
            }
        }

        if(id == 0)
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ที่เติมน้ำมัน");
        
        
        new vehicleid = GetPlayerVehicleID(playerid);

        if(VehicleInfo[vehicleid][eVehicleEngineStatus] == true)
            return SendErrorMessage(playerid, "คุณต้องดับเครื่องยนต์ก่อน");

        if(VehicleInfo[vehicleid][eVehicleFuel] >= 100)
            return SendErrorMessage(playerid, "คุณมีน้ำมันที่เต็มอยู่แล้ว");

        if(FuelInfo[id][F_Fuel] <= 0.0)
            return SendErrorMessage(playerid, "น้ำมันในหัวจ่ายนี้หมด");

        FuelCount = 100 - VehicleInfo[vehicleid][eVehicleFuel];

        VehicleInfo[vehicleid][eVehicleFuelTimer] = SetTimerEx("RefillFuel", 1500, true, "dddf", id, playerid, vehicleid, FuelCount);
        SetPVarInt(playerid, "RefillFuelStats", 1);
    }
    else SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะหรือใกล้ยานพาหนะ");
    return 1;
}

forward RefillFuelGascan(playerid, vehicleid);
public RefillFuelGascan(playerid, vehicleid)
{
    if(!GetNearestVehicle(playerid))
    {

        KillTimer(VehicleInfo[vehicleid][eVehicleFuelTimer]);
        VehicleInfo[vehicleid][eVehicleFuelTimer] = -1;

        DeletePVar(playerid, "RefillFuelStats");
        return 1;
    }
    else if(VehicleInfo[vehicleid][eVehicleFuel] >= 70.0)
    {
        KillTimer(VehicleInfo[vehicleid][eVehicleFuelTimer]);
        VehicleInfo[vehicleid][eVehicleFuelTimer] = -1;
        VehicleInfo[vehicleid][eVehicleFuel] = 70;

        DeletePVar(playerid, "RefillFuelStats");
        SendClientMessage(playerid, COLOR_HELPME, "คุณได้เติมน้ำมันสำเร็จแล้ว");
        return 1;
    }


    else if(VehicleInfo[vehicleid][eVehicleEngineStatus] == true)
    {
        KillTimer(VehicleInfo[vehicleid][eVehicleFuelTimer]);
        VehicleInfo[vehicleid][eVehicleFuelTimer] = -1;

        DeletePVar(playerid, "RefillFuelStats");
        return 1;
    }

    VehicleInfo[vehicleid][eVehicleFuel] += 5;
    return 1;
}

forward RefillFuel(id,playerid, vehicleid, Float:Fuel, Float:FuelCount);
public RefillFuel(id,playerid, vehicleid, Float:Fuel, Float:FuelCount)
{
    if(VehicleInfo[vehicleid][eVehicleFuel] >= 100.0)
    {
        KillTimer(VehicleInfo[vehicleid][eVehicleFuelTimer]);
        VehicleInfo[vehicleid][eVehicleFuelTimer] = -1;
        VehicleInfo[vehicleid][eVehicleFuel] = 100;

        CalculaterFuel(playerid, id, FuelCount);
        FuelCount = 0.0;
        DeletePVar(playerid, "RefillFuelStats");
        return 1;
    }

    else if(VehicleInfo[vehicleid][eVehicleEngineStatus] == true)
    {
        KillTimer(VehicleInfo[vehicleid][eVehicleFuelTimer]);
        VehicleInfo[vehicleid][eVehicleFuelTimer] = -1;

        CalculaterFuel(playerid, id, FuelCount);
        FuelCount = 0.0;
        DeletePVar(playerid, "RefillFuelStats");
        return 1;
    }

    VehicleInfo[vehicleid][eVehicleFuel] += 5; FuelCount += 5;

    new str[65];
    format(str, sizeof(str), "PRICE: $%s",MoneyFormat(floatround(FuelCount * FuelInfo[id][F_Price],floatround_round)));
    GameTextForPlayer(playerid, str, 2000, 3);
    return 1;
}


stock CalculaterFuel(playerid, id, Float:fuel)
{
    GiveMoney(playerid, -floatround(FuelInfo[id][F_Price] * fuel, floatround_round));
        
    new Float:tax = 0.30, result;

    result = floatround((FuelInfo[id][F_Price] * fuel) * tax, floatround_round);
    
    GlobalInfo[G_GovCash]+= result;
    FuelInfo[id][F_Fuel] -= fuel;
    BusinessInfo[FuelInfo[id][F_Business]][BusinessCash] += floatround(FuelInfo[id][F_Price] * fuel, floatround_round) - result;
    SaveFuel(id);
    SaveBusiness(FuelInfo[id][F_Business]);
    UpdateFuel(id);
    DeletePVar(playerid, "RefillFuelStats");
    return 1;
}


Dialog:D_FUEL_MENU(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    switch(listitem)
    {
        case 0: return 1;
        case 1: return 1;
        case 2:
        {
            if(PlayerInfo[playerid][pAdmin] < 5)
                return callcmd::editfuel(playerid, "");

            return Dialog_Show(playerid, D_FUEL_ADD, DIALOG_STYLE_INPUT, "FUEL ADD", "ใส่น้ำมันลงไป", "ยืนยัน", "ยกเลิก");
        }
        case 3:
        {
            Dialog_Show(playerid, D_FUEL_CHANG_PRICE, DIALOG_STYLE_INPUT, "FUEL CHANG PRICE", "ใส่ราคาใหม่ลงไป", "ยืนยัน", "ยกเลิก");
            return 1; 
        }
        case 4:
        {
            Dialog_Show(playerid, D_FUEL_CHANG_PRICEBUY, DIALOG_STYLE_INPUT, "FUEL CHANG PRICE BUY", "ตั้งราคารับในการรับน้ำมัน", "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 5:
        {
            new id = GetPVarInt(playerid, "SetIdFuel");
            new query[MAX_STRING];

            mysql_format(dbCon, query, sizeof(query),"DELETE FROM `fuel` WHERE %d", id);
			mysql_tquery(dbCon, query, "RemoveFuel", "dd", playerid, id);
            DeletePVar(playerid, "SetIdFuel");
            return 1;
        }
    }
    return 1;
}


Dialog:D_FUEL_ADD(playerid, response, listitem, inputtext[])
{
    if(!response)
        return callcmd::editfuel(playerid, "");
    
    new Float:fuel = strval(inputtext);

    new id = GetPVarInt(playerid, "SetIdFuel");

    if(fuel < 0.0 || fuel > 50000.0)
        return SendErrorMessage(playerid, "ใส่จำนวนให้ถูกต้อง");

    FuelInfo[id][F_Fuel] = fuel;
    UpdateFuel(id);
    SaveFuel(id);
    DeletePVar(playerid, "SetIdFuel");
    return 1;
}

Dialog:D_FUEL_CHANG_PRICE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return callcmd::editfuel(playerid, "");
    
    new price = strval(inputtext);

    new id = GetPVarInt(playerid, "SetIdFuel");

    if(price < 1 || price > 50000)
        return SendErrorMessage(playerid, "ใส่จำนวนให้ถูกต้อง");

    FuelInfo[id][F_Price] = price;
    UpdateFuel(id);
    SaveFuel(id);
    DeletePVar(playerid, "SetIdFuel");
    return 1;
}

Dialog:D_FUEL_CHANG_PRICEBUY(playerid, response, listitem, inputtext[])
{
    if(!response)
        return callcmd::editfuel(playerid, "");
    
    new price = strval(inputtext);

    new id = GetPVarInt(playerid, "SetIdFuel");

    if(price < 200 || price > 100000)
        return SendErrorMessage(playerid, "ใส่จำนวนให้ถูกต้อง");

    FuelInfo[id][F_PriceBuy] = price;
    UpdateFuel(id);
    SaveFuel(id);
    DeletePVar(playerid, "SetIdFuel");
    return 1;
}



hook OP_EditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(GetPVarInt(playerid, "MakeFuelObject"))
	{
        new b_id = GetPVarInt(playerid, "BusinessSelete");

		new query[MAX_STRING];

		switch(response)
		{
			case EDIT_RESPONSE_FINAL:
			{
				if(IsValidDynamicObject(PlayerEditObjectFuel[playerid]))
					DestroyDynamicObject(PlayerEditObjectFuel[playerid]);

                if(!BusinessInfo[b_id][BusinessDBID] || b_id > MAX_BUSINESS)
		        {
                    DeletePVar(playerid, "MakeFuelObject");
                    DeletePVar(playerid, "BusinessSelete");
                    PlayerEditObjectFuel[playerid] = INVALID_OBJECT_ID;
                    SendErrorMessage(playerid, "ไม่มีกิจการที่ต้องการ");
                    return 1;
                }

                new idx;

                for(new i = 1; i < MAX_FUELS; i++)
                {
                    if(!FuelInfo[i][F_ID])
                    {
                        idx = i;
                        break;
                    }
                }

                if(idx == 0)
                {
                    if(IsValidDynamicObject(PlayerEditObjectFuel[playerid]))
					    DestroyDynamicObject(PlayerEditObjectFuel[playerid]);

                    DeletePVar(playerid, "MakeFuelObject");
                    DeletePVar(playerid, "BusinessSelete");
                    PlayerEditObjectFuel[playerid] = INVALID_OBJECT_ID;
                    SendClientMessage(playerid, COLOR_LIGHTRED, "การสร้างถึงขีดจำกัดแล้ว");
                    return 1;
                }

                
				mysql_format(dbCon, query, sizeof(query),"INSERT INTO `fuel`(`F_Business`,`F_PosX`, `F_PosY`, `F_PosZ`, `F_PosRX`, `F_PosRY`, `F_PosRZ`) VALUES ('%d','%f', '%f', '%f', '%f', '%f', '%f')", b_id,x, y, z, rx, ry, rz);
				mysql_tquery(dbCon, query, "InsertFuelStation", "dddffffff", playerid, b_id, idx, x, y, z, rx, ry, rz);
			
				return 1;
			}
			case EDIT_RESPONSE_CANCEL: 
			{
				if(IsValidDynamicObject(PlayerEditObjectFuel[playerid]))
					DestroyDynamicObject(PlayerEditObjectFuel[playerid]);
				
                DeletePVar(playerid, "MakeFuelObject");
                DeletePVar(playerid, "BusinessSelete");
                PlayerEditObjectFuel[playerid] = INVALID_OBJECT_ID;
				return 1;
			}
		}

		return 1;
	}
	return 1;
}

forward InsertFuelStation(playerid, b_id, newid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
public InsertFuelStation(playerid, b_id, newid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	FuelInfo[newid][F_ID] = cache_insert_id();
    FuelInfo[newid][F_Business] = b_id;
	FuelInfo[newid][F_OwnerDBID] = BusinessInfo[b_id][BusinessOwnerDBID]; 
    FuelInfo[newid][F_Price] = 100;
    FuelInfo[newid][F_PriceBuy] = 2000;
	FuelInfo[newid][F_Pos][0] = x;
	FuelInfo[newid][F_Pos][1] = y;
	FuelInfo[newid][F_Pos][2] = z;
	FuelInfo[newid][F_Pos][3] = rx;
	FuelInfo[newid][F_Pos][4] = ry;
	FuelInfo[newid][F_Pos][5] = rz;

    SendClientMessageEx(playerid, COLOR_HELPME, "คุณได้สร้าง Fuel %d", newid);


    FuelInfo[newid][F_Object] = CreateDynamicObject(3465,x, y, z, ry, ry, rz, 0, 0, -1);
    UpdateFuel(newid);

    DeletePVar(playerid, "MakeFuelObject");
    DeletePVar(playerid, "BusinessSelete");
    PlayerEditObjectFuel[playerid] = INVALID_OBJECT_ID;
	return 1;
}

forward RemoveFuel(playerid, id);
public RemoveFuel(playerid, id)
{
    SendClientMessageEx(playerid, COLOR_GREY, "คุณได้ลบ Fuel ID %d",id);
    FuelInfo[id][F_ID] = 0;
	FuelInfo[id][F_OwnerDBID] = 0;
    FuelInfo[id][F_Business] = 0; 
    FuelInfo[id][F_Fuel] = 0.0;
    FuelInfo[id][F_Price] = 0;
    FuelInfo[id][F_PriceBuy] = 0;
	FuelInfo[id][F_Pos][0] = 0.0;
	FuelInfo[id][F_Pos][1] = 0.0;
	FuelInfo[id][F_Pos][2] = 0.0;
	FuelInfo[id][F_Pos][3] = 0.0;
	FuelInfo[id][F_Pos][4] = 0.0;
	FuelInfo[id][F_Pos][5] = 0.0;

	DestroyDynamicObject(FuelInfo[id][F_Object]);
	DestroyDynamic3DTextLabel(FuelInfo[id][F_Text]);
    return 1;
}

stock UpdateFuel(id)
{

    new str[120];
	format(str, sizeof(str), "FUEL: %.1f\n ราคาต่อลิตร: $%s\nราคารับ: $%s",FuelInfo[id][F_Fuel], MoneyFormat(FuelInfo[id][F_Price]), MoneyFormat(FuelInfo[id][F_PriceBuy]));

	if(IsValidDynamic3DTextLabel(FuelInfo[id][F_Text]))
		DestroyDynamic3DTextLabel(FuelInfo[id][F_Text]);

	FuelInfo[id][F_Text] = CreateDynamic3DTextLabel(str, COLOR_GREY, FuelInfo[id][F_Pos][0], FuelInfo[id][F_Pos][1], FuelInfo[id][F_Pos][2], 10.0);
    return 1;
}


stock IsCheckVehicleFuel(vehicleid)
{
    new model = GetVehicleModel(vehicleid);

    if(model == 422 || model == 573 || model == 554)
        return 1;

    return 0;
}