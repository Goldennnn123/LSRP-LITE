#include <YSI_Coding\y_hooks>

new PlayerGetFuel[MAX_PLAYERS];

CMD:fuel(playerid, params[])
{
    new option[16];

    if(sscanf(params, "s[16]", option))
    {
        SendClientMessage(playerid, COLOR_GRAD3, "Available commands:");
	    SendClientMessage(playerid, -1, ""EMBED_YELLOW"/fuel list "EMBED_WHITE"- แสดงจำนวนถังน้ำมันที่อยู่ภายในรถ");
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/fuel place "EMBED_WHITE"- วางถังน้ำมันลงไป");
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/fuel get "EMBED_WHITE"- ยกถังน้ำมันขึ้นมา");
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/fuel drop "EMBED_WHITE"- วางถังน้ำมัน");
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/fuel buy "EMBED_WHITE"- ซื้อถังน้ำมัน");
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/fuel sell "EMBED_WHITE"- ขายน้ำมันให้กับกิจการ");
        return 1;
    }

    if(!strcmp(option, "list", true))
    {
        new Float:x, Float:y, Float:z;
        if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
        {
            GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
            new 
                vehicleid = GetNearestVehicle(playerid)
            ;

            if(!IsCheckVehicleFuel(vehicleid))
                return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ยานพาหนะที่ไว้สำหรับขนส่งน้ำมัน");

            if(VehicleInfo[vehicleid][eVehicleLocked])
                return SendServerMessage(playerid, "รถคันนี้ถูกล็อคอยู่");

            if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
                return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ท้ายรถ");

            SendClientMessageEx(playerid, COLOR_ORANGE, "น้ำมันที่มีอยู่ภายในยานพาหนะ %s จำนวน: %d ถัง",ReturnVehicleName(vehicleid), VehicleInfo[vehicleid][eVehicleFuelStock]);
            return 1;

        }

        else SendErrorMessage(playerid, "คุณไม่ได้อยู่ท้ายยานพาหนะ");
    }
    else if(!strcmp(option, "place", true))
    {
        if(!PlayerGetFuel[playerid])
            return SendErrorMessage(playerid, "คุณไม่ได้ถือถังน้ำมัน");

        new Float:x, Float:y, Float:z;
        if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
        {
            GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
            new 
                vehicleid = GetNearestVehicle(playerid)
            ;

            if(!IsCheckVehicleFuel(vehicleid))
                return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ยานพาหนะที่ไว้สำหรับขนส่งน้ำมัน");

            if(VehicleInfo[vehicleid][eVehicleLocked])
                return SendServerMessage(playerid, "รถคันนี้ถูกล็อคอยู่");

            if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
                return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ท้ายรถ");


            new modelid = GetVehicleModel(vehicleid);


            switch(modelid)
            {
                case 422, 554:
                {
                    if(VehicleInfo[vehicleid][eVehicleFuelStock] > 4)
                        return SendErrorMessage(playerid, "ยานพหานะคันนี้เต็มแล้ว");

                    VehicleInfo[vehicleid][eVehicleFuelStock]++;
                    PlaceFuel(playerid);
                    return 1;
                }
                case 573:
                {
                    if(VehicleInfo[vehicleid][eVehicleFuelStock] > 10)
                        return SendErrorMessage(playerid, "ยานพหานะคันนี้เต็มแล้ว");

                    VehicleInfo[vehicleid][eVehicleFuelStock]++;
                    PlaceFuel(playerid);
                    return 1;
                }
            }
            return 1;

        }
    }
    else if(!strcmp(option, "get", true))
    {
        if(PlayerGetFuel[playerid])
            return SendErrorMessage(playerid, "คุณถือถังน้ำมันอยู่");

        new Float:x, Float:y, Float:z;
        if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
        {
            GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
            new 
                vehicleid = GetNearestVehicle(playerid)
            ;

            if(!IsCheckVehicleFuel(vehicleid))
                return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ยานพาหนะที่ไว้สำหรับขนส่งน้ำมัน");

            if(VehicleInfo[vehicleid][eVehicleLocked])
                return SendServerMessage(playerid, "รถคันนี้ถูกล็อคอยู่");

            if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
                return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ท้ายรถ");


            if(!VehicleInfo[vehicleid][eVehicleFuelStock])
                return SendErrorMessage(playerid, "ยานพาหนะคันนี้ไม่ได้มีถังน้ำมันกักเก็บไว้");


            VehicleInfo[vehicleid][eVehicleFuelStock]--;
            GetPlayerFuel(playerid);
            return 1;

        }
    }
    else if(!strcmp(option, "buy", true))
    {
        if(!IsPlayerInRangeOfPoint(playerid, 3.0, -1024.2225,-688.4048,32.0078) && !IsPlayerInRangeOfPoint(playerid, 3.0, -1030.3638,-688.3743,32.0126) && !IsPlayerInRangeOfPoint(playerid, 3.0, -1037.9266,-688.1974,32.0126))
            return SendErrorMessage(playerid,"คุณไม่ได้อยู่ในจุดรับน้ำมัน");

        if(PlayerInfo[playerid][pCash] < 100)
            return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอ ($100)");
        
        GiveMoney(playerid, -100);
        GetPlayerFuel(playerid);
        return 1;
    }
    else if(!strcmp(option, "sell", true))
    {
        if(!PlayerGetFuel[playerid])
            return SendErrorMessage(playerid, "คุณไม่ได้ถือถังน้ำมัน");

        
        new id;
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

        new b_id = FuelInfo[id][F_Business];

        if(!BusinessInfo[b_id][BusinessCash])
            return SendErrorMessage(playerid, "เงินภายในกิจการนี้หมดแล้ว");
        

        if(FuelInfo[id][F_Fuel] >= 99999.0)
            return SendErrorMessage(playerid, "ถังนี้ได้มีน้ำมันที่เต็มแล้ว");

        FuelInfo[id][F_Fuel] += 50.0;
        UpdateFuel(id);
        PlaceFuel(playerid);
        GiveMoney(playerid, FuelInfo[id][F_PriceBuy]);
        BusinessInfo[b_id][BusinessCash] -= FuelInfo[id][F_PriceBuy];

        CharacterSave(playerid);
        SaveFuel(id);
        return 1;
    }
    else if(!strcmp(option, "drop", true))
    {
        if(!PlayerGetFuel[playerid])
            return SendErrorMessage(playerid, "คุณไม่ได้ถือถังน้ำมัน");
        
        PlaceFuel(playerid);
        SendNearbyMessage(playerid, 5.5, COLOR_EMOTE, "> %s ได้วางถังน้ำมันลงไป", ReturnName(playerid,0));
        return 1;
    }
    return 1;
}


stock GetPlayerFuel(playerid)
{
    PlayerGetFuel[playerid] = true;
    ApplyAnimation(playerid, "CARRY","liftup", 4.1, 0, 0, 0, 0, 0, 1);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    SetPlayerAttachedObject(playerid, 9, 3632, 5, 0.092999, 0.373000, 0.186999, -80.899963, -9.800071, 178.300048, 0.714000, 0.712000, 0.793000);

    new str[90];
    format(str, sizeof(str), "ได้ยกถังน้ำมันขึ้นมถือไว้ด้วยสองมือ");
    callcmd::me(playerid, str);
    return 1;
}

stock PlaceFuel(playerid)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid, 9);
    PlayerGetFuel[playerid] = false;
    return 1;
}