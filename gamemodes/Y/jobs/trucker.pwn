/// /takejob:
  // /startjob:
    // /getbox:
    // /placebox:
    //check car 422,413,543,554,600

/*enum v_trucker {
	v_cargo,
};

new const VehicleTrucker[MAX_VEHICLES][v_trucker] =
{
    {4}, //422
    {6}, //413
    {4}, //543
    {4}, //554
    {2} //600
};*/


new VehicleCargo[MAX_VEHICLES];
new bool:PlayerGetcargo[MAX_PLAYERS];
new CargoCount[MAX_PLAYERS];

new trucker_picup;

enum T_TRUCK_PLACE
{
    Float:TruckPos[3]
}
new TruckerPosData[MAX_PLAYERS][T_TRUCK_PLACE];

hook OP_Connect(playerid)
{
    PlayerGetcargo[playerid] = false;
    CargoCount[playerid] = 0;
    return 1;
}

hook OnGameModeInit()
{
    trucker_picup = CreateDynamicPickup(1239, 2, -242.5856,-235.4501,2.4297, -1);
    return 1;
}

hook OP_PickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
    if(pickupid == trucker_picup)
    {
        SendClientMessage(playerid, COLOR_GREY, "/takejob เพื่อสมัครงาน พนักงานส่งของ");
        return 1;
    }
    return 1;
}

hook OP_EnterCheckpoint(playerid)
{
    if(TruckerPosData[playerid][TruckPos][0] && TruckerPosData[playerid][TruckPos][1] && TruckerPosData[playerid][TruckPos][2])
    {
        DisablePlayerCheckpoint(playerid);
        return 1;
    }
    return 1;
}


CMD:getcargo(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_TRUCKER)
        return SendErrorMessage(playerid, "คุณไม่ใช่พนักงานส่งของ");
    
    new
		Float:x,
		Float:y,
		Float:z
	;

    if(PlayerGetcargo[playerid])
        return SendErrorMessage(playerid, "คุณยกกล่องสินค้าอยู่");
	
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
    {
        GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
        new 
			vehicleid = GetNearestVehicle(playerid)
		;

        if(GetVehicleModel(vehicleid) != 422 && GetVehicleModel(vehicleid) != 413 && GetVehicleModel(vehicleid) != 543 && GetVehicleModel(vehicleid) != 554 && GetVehicleModel(vehicleid) != 600)
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้รถที่ใช้สำหรับการขนกล่องส่งของ");

        
        if(VehicleInfo[vehicleid][eVehicleLocked])
			return SendServerMessage(playerid, "รถคันนี้ถูกล็อคอยู่");

        new modelid = GetVehicleModel(vehicleid);


        if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ท้ายรถ");

        switch(modelid)
        {
            case 422:
            {
                if(!VehicleCargo[vehicleid])
                    return SendErrorMessage(playerid, "รถไม่มีกล่องสินค้า");

                VehicleCargo[vehicleid]--;
                GetPlayerCargo(playerid);
                return 1;
            }
        }
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 3.0, -204.7082,-191.9789,1.4297) || IsPlayerInRangeOfPoint(playerid, 3.0, -225.8368,-187.2693,1.4297) || IsPlayerInRangeOfPoint(playerid, 3.0, -177.5965,-198.4599,1.4219))
    {
        GetPlayerCargo(playerid);
        return 1;
    }
    else return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในจุดรับส่งของ");
}

CMD:placecargo(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_TRUCKER)
        return SendErrorMessage(playerid, "คุณไม่ใช่พนักงานส่งของ");

    if(PlayerGetcargo[playerid] == false)
        return SendErrorMessage(playerid, "คุณไม่ได้ถือกล่องสินค้า");
    new
		Float:x,
		Float:y,
		Float:z
	;
		
	//new engine, lights, alarm, doors, bonnet, boot, objective;
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
    {
        GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
        new 
			vehicleid = GetNearestVehicle(playerid)
		;

        if(GetVehicleModel(vehicleid) != 422 && GetVehicleModel(vehicleid) != 413 && GetVehicleModel(vehicleid) != 543 && GetVehicleModel(vehicleid) != 554 && GetVehicleModel(vehicleid) != 600)
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้รถที่ใช้สำหรับการขนกล่องส่งของ");

        
        if(VehicleInfo[vehicleid][eVehicleLocked])
			return SendServerMessage(playerid, "รถคันนี้ถูกล็อคอยู่");

        new modelid = GetVehicleModel(vehicleid);


        if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ท้ายรถ");

        switch(modelid)
        {
            case 422:
            {
                if(VehicleCargo[vehicleid] == 4)
                    return SendErrorMessage(playerid, "รถของคุณได้มีกล่องสินค้าเต็มแล้ว");

                VehicleCargo[vehicleid]++;
                PlaceCrate(playerid);

                new str[90];
                format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                callcmd::me(playerid, str);
                return 1;
            }
        }
        return 1;
    }

    if(TruckerPosData[playerid][TruckPos][0] && TruckerPosData[playerid][TruckPos][1] && TruckerPosData[playerid][TruckPos][2])
    {
        if(!IsPlayerInRangeOfPoint(playerid, 3.2, TruckerPosData[playerid][TruckPos][0],TruckerPosData[playerid][TruckPos][1],TruckerPosData[playerid][TruckPos][2]))
            return 1;
        
        PlaceCrate(playerid);
        new money = Random(90, 350);

        SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้ส่งกล่องสินค้าเข้าสู่ที่เก็บแล้วจำนวน 1 กล่อง ได้เงิน $%s",MoneyFormat(money));
        GiveMoney(playerid, money);
        return 1;
    }

    PlaceCrate(playerid);
    return 1;
}


CMD:startjob(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_TRUCKER)
        return SendErrorMessage(playerid, "คุณไม่ใช่พนักงานส่งของ");

    new vehicleid = GetPlayerVehicleID(playerid);
    
    if(IsPlayerInVehicle(playerid, vehicleid))
    Randomtruck(playerid);
    return 1;
}

stock Randomtruck(playerid)
{
    switch(Random(1,5))
    {
        case 1:
        {
            TruckerPosData[playerid][TruckPos][0] = 1992.3217;
            TruckerPosData[playerid][TruckPos][1] = -2068.4460;
            TruckerPosData[playerid][TruckPos][2] = 12.9471;
            SetPlayerCheckpoint(playerid, 1992.3217,-2068.4460,12.9471, 3);
            return 1;
        }
        case 2:
        {
            TruckerPosData[playerid][TruckPos][0] = 733.0740;
            TruckerPosData[playerid][TruckPos][1] = -1349.2097;
            TruckerPosData[playerid][TruckPos][2] = 13.0733;
            SetPlayerCheckpoint(playerid, 733.0740,-1349.2097,13.0733, 3);
            return 1;
        }
        case 3:
        {
            TruckerPosData[playerid][TruckPos][0] = 866.7595;
            TruckerPosData[playerid][TruckPos][1] = -1204.5474;
            TruckerPosData[playerid][TruckPos][2] = 16.5495;
            SetPlayerCheckpoint(playerid, 866.7595,-1204.5474,16.5495, 3);
            return 1;
        }
        case 4:
        {
            TruckerPosData[playerid][TruckPos][0] = 2460.9534;
            TruckerPosData[playerid][TruckPos][1] = -2119.8049;
            TruckerPosData[playerid][TruckPos][2] = 13.1120;
            SetPlayerCheckpoint(playerid, 2460.9534,-2119.8049,13.1120, 3);
            return 1;
        }
        case 5:
        {
            TruckerPosData[playerid][TruckPos][0] = 2348.5645;
            TruckerPosData[playerid][TruckPos][1] = -2302.4021;
            TruckerPosData[playerid][TruckPos][2] = 13.1200;
            SetPlayerCheckpoint(playerid, 2348.5645,-2302.4021,13.1200, 3);
            return 1;
        }
    }
    return 1;
}

stock GetPlayerCargo(playerid)
{
    PlayerGetcargo[playerid] = true;
    ApplyAnimation(playerid, "CARRY","liftup", 4.1, 0, 0, 0, 0, 0, 1);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    SetPlayerAttachedObject(playerid, 9, 2912, 1, -0.019, 0.713999, -0.076, 0, 87.1, -9.4, 1.0000, 1.0000, 1.0000);

    new str[90];
    format(str, sizeof(str), "ได้ยกกล่องสินค้าขึ้นมถือไว้ด้วยสองมือ");
    callcmd::me(playerid, str);
    return 1;
}

stock PlaceCrate(playerid)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid, 9);
    PlayerGetcargo[playerid] = false;
    return 1;
}




