#include <YSI_Coding\y_hooks>

CMD:drughelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_DARKGREEN, "____________DRUGS HELP____________");

    SendClientMessage(playerid, -1, "");
    SendClientMessage(playerid, -1, "/checkdrug (ตรวจดูยาภายใน บ้าน หรือ ยานพาหนะ)");
    SendClientMessage(playerid, -1, "/mydrug (ดูยาเสพติดภายในตัว)");
    SendClientMessage(playerid, -1, "/givedrug (ให้ยา)");
    SendClientMessage(playerid, -1, "/usedrug (ใช้ยา)");
    SendClientMessage(playerid, -1, "/getdrug (เอายาออกมา)");
    SendClientMessage(playerid, -1, "/placedrug (วางยาเสพติด *ในบ้าน หรือ ยานพาหนะเท่านั้น*)");
    SendClientMessage(playerid, -1, "");

    SendClientMessage(playerid, COLOR_DARKGREEN, "__________________________________");
    return 1;
}

CMD:placedrug(playerid, params[])
{
    new type, Float:amount;

    if(sscanf(params, "df", type, amount))
    {
        SendUsageMessage(playerid, "/placedrug <ประเภท> <จำนวน>");
        SendUsageMessage(playerid, "1.Cocaine 2.Cannabis 3.Heroin");
        return 1;
    }

    if(type < 1 || type > 3)
        return SendErrorMessage(playerid, "กรุณาใส่ประเภทให้ถูกต้อง");

    if(amount < 0.01)
        return SendErrorMessage(playerid, "กรุณาใส่จำนวนให้ถูกต้อง");

    if(PlayerInfo[playerid][pDrug][type-1] < amount)
        return SendErrorMessage(playerid, "ยาเสพติดของคุณไม่เพียงพอ");

    if(IsPlayerInAnyVehicle(playerid))
    {
        new vehicleid = GetPlayerVehicleID(playerid);

        if(HasNoEngine(vehicleid))
            return SendErrorMessage(playerid, "ไม่สามารถใช้กับยานพาหนะที่เป็น จักรยานได้");

        PlaceDrugVehicle(playerid, vehicleid, type, amount);
        return 1;
    }
    else if(PlayerInfo[playerid][pInsideProperty])
    {
        new id = PlayerInfo[playerid][pInsideProperty];

        if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
            return SendErrorMessage(playerid, "นี่ไม่ใช่บ้านของคุณ");

        if(!IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[id][HousePlacePos][0], HouseInfo[id][HousePlacePos][1], HouseInfo[id][HousePlacePos][2]))
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่จุด Place Pos");

        PlaceDrugHouse(playerid, id, type, amount);
        return 1;
    }
    else SendErrorMessage(playerid, "คุณไม่ได้อยุ่อยุ่ภายใน บ้าน หรือ ยานหานะของคุณ");
    return 1;
}

CMD:getdrug(playerid, params[])
{
    new type, Float:amount;

    if(sscanf(params, "df", type, amount))
    {
        SendUsageMessage(playerid, "/getdrug <ประเภท> <จำนวน>");
        SendUsageMessage(playerid, "1.Cocaine 2.Cannabis 3.Heroin");
        return 1;
    }

    if(type < 1 || type > 3)
        return SendErrorMessage(playerid, "กรุณาใส่ประเภทให้ถูกต้อง");

    if(amount < 0.01)
        return SendErrorMessage(playerid, "กรุณาใส่จำนวนให้ถูกต้อง");


    if(IsPlayerInAnyVehicle(playerid))
    {
        new vehicleid = GetPlayerVehicleID(playerid);

        if(HasNoEngine(vehicleid))
            return SendErrorMessage(playerid, "ไม่สามารถใช้กับยานพาหนะที่เป็น จักรยานได้");

        if(VehicleInfo[vehicleid][eVehicleDrug][type-1] < amount)
            return SendErrorMessage(playerid, "ยาเสพติดของคุณไม่เพียงพอ");

        GetDrugVehicle(playerid, vehicleid, type, amount);
        return 1;
    }
    else if(PlayerInfo[playerid][pInsideProperty])
    {
        new id = PlayerInfo[playerid][pInsideProperty];

        if(HouseInfo[id][HouseDrug][type-1] < amount)
            return SendErrorMessage(playerid, "ยาเสพติดของคุณไม่เพียงพอ");

        if(!IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[id][HousePlacePos][0], HouseInfo[id][HousePlacePos][1], HouseInfo[id][HousePlacePos][2]))
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่จุด Place Pos");

        GetDrugHouse(playerid, id, type, amount);
        return 1;
    }
    else SendErrorMessage(playerid, "คุณไม่ได้อยุ่อยุ่ภายใน บ้าน หรือ ยานหานะของคุณ");
    return 1;
}

CMD:mydrug(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin])
    {
        new tagetid;

        if(sscanf(params, "I(-1)", tagetid))
        {
            SendClientMessage(playerid, COLOR_DARKGREEN, "__________DRUGS__________");
            SendClientMessageEx(playerid, -1, "Cocaine: %.2f",PlayerInfo[playerid][pDrug][0]);
            SendClientMessageEx(playerid, -1, "Cannabis: %.2f",PlayerInfo[playerid][pDrug][1]);
            SendClientMessageEx(playerid, -1, "Heroin: %.2f",PlayerInfo[playerid][pDrug][2]);
            return 1;
        }

        if(tagetid == -1)
        {
            SendClientMessage(playerid, COLOR_DARKGREEN, "__________DRUGS__________");
            SendClientMessageEx(playerid, -1, "Cocaine: %.2f",PlayerInfo[playerid][pDrug][0]);
            SendClientMessageEx(playerid, -1, "Cannabis: %.2f",PlayerInfo[playerid][pDrug][1]);
            SendClientMessageEx(playerid, -1, "Heroin: %.2f",PlayerInfo[playerid][pDrug][2]);
            return 1;
        }

        if(!IsPlayerConnected(tagetid))
            return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซิร์ฟเวอร์");

        if(IsPlayerLogin(tagetid))
            return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
        
        SendClientMessageEx(playerid, COLOR_DARKGREEN, "__________DRUGS %s__________", ReturnName(tagetid,0));
        SendClientMessageEx(playerid, -1, "Cocaine: %.2f",PlayerInfo[tagetid][pDrug][0]);
        SendClientMessageEx(playerid, -1, "Cannabis: %.2f",PlayerInfo[tagetid][pDrug][1]);
        SendClientMessageEx(playerid, -1, "Heroin: %.2f",PlayerInfo[tagetid][pDrug][2]);
        return 1;
        
    }
    SendClientMessage(playerid, COLOR_DARKGREEN, "__________DRUGS__________");
    SendClientMessageEx(playerid, -1, "Cocaine: %.2f",PlayerInfo[playerid][pDrug][0]);
    SendClientMessageEx(playerid, -1, "Cannabis: %.2f",PlayerInfo[playerid][pDrug][1]);
    SendClientMessageEx(playerid, -1, "Heroin: %.2f",PlayerInfo[playerid][pDrug][2]);
    return 1;
}

CMD:checkdrug(playerid, params[])
{
    if(PlayerInfo[playerid][pInsideProperty])
    {
        new id = PlayerInfo[playerid][pInsideProperty];

        if(!IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[id][HousePlacePos][0], HouseInfo[id][HousePlacePos][1], HouseInfo[id][HousePlacePos][2]))
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่จุด Place Pos");

        SendClientMessage(playerid, COLOR_DARKGREEN, "__________DRUGS House__________");
        SendClientMessageEx(playerid, -1, "Cocaine: %.2f",HouseInfo[id][HouseDrug][0]);
        SendClientMessageEx(playerid, -1, "Cannabis: %.2f",HouseInfo[id][HouseDrug][1]);
        SendClientMessageEx(playerid, -1, "Heroin: %.2f",HouseInfo[id][HouseDrug][2]);
        return 1;
    }
    else if(IsPlayerInAnyVehicle(playerid))
    {
        new vehicleid = GetPlayerVehicleID(playerid);

        if(HasNoEngine(vehicleid))
            return SendErrorMessage(playerid, "ไม่สามารถใช้กับยานพาหนะที่เป็น จักรยานได้");

        SendClientMessage(playerid, COLOR_DARKGREEN, "__________DRUGS Vehicle__________");
        SendClientMessageEx(playerid, -1, "Cocaine: %.2f",VehicleInfo[vehicleid][eVehicleDrug][0]);
        SendClientMessageEx(playerid, -1, "Cannabis: %.2f",VehicleInfo[vehicleid][eVehicleDrug][1]);
        SendClientMessageEx(playerid, -1, "Heroin: %.2f",VehicleInfo[vehicleid][eVehicleDrug][2]);
        return 1;
    }
    return 1;
}

CMD:givedrug(playerid, params[])
{
    new tagetid, type, Float:amout, str[200];

    if(sscanf(params, "udf", tagetid, type, amout))
    {
        SendUsageMessage(playerid, "/givedrug <ชื่อบางส่วน> <ไอดี> <จำนวน : กรัม>");
        SendUsageMessage(playerid, "1.Cocaine 2.Cannabis 3.Heroin");
        return 1;
    }

    if(tagetid == playerid)
        return SendErrorMessage(playerid, "ไม่สามารถใช้กับตัวเองได้");

    if(!IsPlayerConnected(tagetid))
        return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซิร์ฟเวอร์");

    if(IsPlayerLogin(tagetid))
        return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

    if(!IsPlayerNearPlayer(playerid, tagetid, 2.5))
        return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้ตัวของคุณ");

    if(amout < 0.01)
        return SendErrorMessage(playerid, "ใส่จำนวนน้อยเกินไป");

    switch(type)
    {
        case 1:
        {
            if(PlayerInfo[playerid][pDrug][0] < amout)
                return SendErrorMessage(playerid, "คุณมีจำนวนยาไม่เพียงพอต่อการให้");

            SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "> %s ยื่นบางอย่างให้กับ %s",ReturnName(playerid,0), ReturnName(tagetid,0));
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้มอบ Cocaine ให้กับ %s จำนวน %.2f กรัม",ReturnName(tagetid,0), amout);
            
            format(str, sizeof(str), "[%s] %s Give Drug 'Cocaine' to %s Amount: %.2f", ReturnDate(),ReturnName(playerid,0), ReturnName(tagetid,0), amout);
            SendDiscordMessage("drug", str);

            Log(druglog, WARNING, str);

            PlayerInfo[playerid][pDrug][0]-=amout;
            PlayerInfo[tagetid][pDrug][0]+=amout;
            //GiveDrug(tagetid, type, amout);
            CharacterSave(playerid);
        }
        case 2:
        {
            if(PlayerInfo[playerid][pDrug][1] < amout)
                return SendErrorMessage(playerid, "คุณมีจำนวนยาไม่เพียงพอต่อการให้");

            SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "> %s ยื่นบางอย่างให้กับ %s",ReturnName(playerid,0), ReturnName(tagetid,0));
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้มอบ Cannabis ให้กับ %s จำนวน %.2f กรัม",ReturnName(tagetid,0), amout);
            
            format(str, sizeof(str), "[%s] %s Give Drug 'Cannabis' to %s Amount: %.2f", ReturnDate(),ReturnName(playerid,0), ReturnName(tagetid,0), amout);
            SendDiscordMessage("drug", str);
            Log(druglog, WARNING, str);        
            
            PlayerInfo[playerid][pDrug][1]-=amout;
            PlayerInfo[tagetid][pDrug][1]+=amout;
            //GiveDrug(tagetid, type, amout);
            CharacterSave(playerid);
        }
        case 3:
        {
            if(PlayerInfo[playerid][pDrug][2] < amout)
                return SendErrorMessage(playerid, "คุณมีจำนวนยาไม่เพียงพอต่อการให้");

            SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "> %s ยื่นบางอย่างให้กับ %s",ReturnName(playerid,0), ReturnName(tagetid,0));
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้มอบ Heroin ให้กับ %s จำนวน %.2f กรัม",ReturnName(tagetid,0), amout);
            
            format(str, sizeof(str), "[%s] %s Give Drug 'Heroin' to %s Amount: %.2f", ReturnDate(),ReturnName(playerid,0), ReturnName(tagetid,0), amout);
            SendDiscordMessage("drug", str);
            Log(druglog, WARNING, str);

            PlayerInfo[playerid][pDrug][2]-=amout;
            PlayerInfo[tagetid][pDrug][2]+=amout;
            //GiveDrug(tagetid, type, amout);
            CharacterSave(playerid);
        }
        default: SendErrorMessage(playerid, "ใส่ประเภทให้ถูกต้อง");
    }
    return 1;
}

CMD:usedrug(playerid, params[])
{
    if(PlayerDrugUse[playerid] != -1)
        return SendErrorMessage(playerid, "คุณยังมีการเสพยาเสพติดอยู่ในขณะนี้");

    new type, Float:health;

    if(sscanf(params, "d", type))
    {
        SendUsageMessage(playerid, "/usedrug <ประเภท>");
        SendUsageMessage(playerid, "1.Cocaine 2.Cannabis 3.Heroin");
        return 1;
    }

    if(type < 1 || type > 3)
        return SendErrorMessage(playerid, "คุณใส่ประเภทยาเสพติดไม่ถูก (1-3 เท่านั้น)");

    if(PlayerInfo[playerid][pDrug][type-1] < 0.2)
        return SendErrorMessage(playerid, "คุณมียาไม่เพียงพอต่อการที่จะเสพ");
    

    GetPlayerHealth(playerid, health);

    switch(type)
    {
        case 1:
        {
            if(health > 170)
                return SendErrorMessage(playerid, "คุณมีเลือดถึงขีดจำกัดแล้ว");

            PlayerDrugUse[playerid] = SetTimerEx("SetPlayerHealth_Stap", 2000, true, "dd",playerid, type);

            SendClientMessage(playerid, COLOR_GREY, "คุณได้มีการเสพยาเสพติด 'Cocaine' ทำให้เลือดของคุณเพิ่มทีละ +2");
            PlayerInfo[playerid][pDrug][0]-= 0.2;
            PlayerInfo[playerid][pAddicted] = false;
            PlayerInfo[playerid][pAddictedCount] = 1;
            Log(druglog, WARNING, "%s มีการใช้ ยาเสพติด 'Cocaine'", ReturnName(playerid, 0));
            
            new str[120];
            format(str, sizeof(str), "หยิบยาออกมาเสพ");
            callcmd::ame(playerid, str);

            format(str, sizeof(str), "%s use drug 'Cocaine'",ReturnRealName(playerid, 0));
            SendDiscordMessageEx("drug", str);
            return 1;
        }
        case 2:
        {
            if(health > 150)
                return SendErrorMessage(playerid, "คุณมีเลือดถึงขีดจำกัดแล้ว");

            PlayerDrugUse[playerid] = SetTimerEx("SetPlayerHealth_Stap", 2000, true, "dd",playerid, type);
            SendClientMessage(playerid, COLOR_GREY, "คุณได้มีการเสพยาเสพติด 'Cannabis' ทำให้เลือดของคุณเพิ่มทีละ +2");
            PlayerInfo[playerid][pDrug][1]-= 0.2;
            PlayerInfo[playerid][pAddicted] = false;
            PlayerInfo[playerid][pAddictedCount] = 1;
            Log(druglog, WARNING, "%s มีการใช้ ยาเสพติด 'Cannabis'", ReturnName(playerid, 0));
            
            new str[120];
            format(str, sizeof(str), "หยิบยาออกมาเสพ");
            callcmd::ame(playerid, str);

            format(str, sizeof(str), "%s use drug 'Cannabis'",ReturnRealName(playerid, 0));
            SendDiscordMessageEx("drug", str);
        }
        case 3:
        {
            if(health > 200)
                return SendErrorMessage(playerid, "คุณมีเลือดถึงขีดจำกัดแล้ว");

            PlayerDrugUse[playerid] = SetTimerEx("SetPlayerHealth_Stap", 2000, true, "dd",playerid, type);
            SendClientMessage(playerid, COLOR_GREY, "คุณได้มีการเสพยาเสพติด 'Heroin' ทำให้เลือดของคุณเพิ่มทีละ +2");
            PlayerInfo[playerid][pDrug][1]-= 0.2;
            PlayerInfo[playerid][pAddicted] = false;
            PlayerInfo[playerid][pAddictedCount] = 1;
            Log(druglog, WARNING, "%s มีการใช้ ยาเสพติด ''", ReturnName(playerid, 0));
            
            new str[120];
            format(str, sizeof(str), "หยิบยาออกมาเสพ");
            callcmd::ame(playerid, str);

            format(str, sizeof(str), "%s use drug 'Heroin'",ReturnRealName(playerid, 0));
            SendDiscordMessageEx("drug", str);
        }
    }
    return 1;
}

CMD:setdrug(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 3)
        return SendUnauthMessage(playerid);

    new tagetid,type, Float:amout;

    if(sscanf(params, "udf", tagetid, type, amout))
    {
        SendUsageMessage(playerid, "/setdrug <ชื่อบางส่วน/ไอดี> <ประเภทยาเสพติด> <จำนวน : กรัม>");
        SendUsageMessage(playerid, "1.Cocaine 2.Cannabis 3.Heroin");
        return 1;
    }

    if(!IsPlayerConnected(tagetid))
        return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซิร์ฟเวอร์");

    if(IsPlayerLogin(tagetid))
        return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

    if(amout < 0.00)
        return SendErrorMessage(playerid, "ใส่จำนวนน้อยเกินไป");

    switch(type)
    {
        case 1:
        {
            PlayerInfo[tagetid][pDrug][0] = amout;
            SendClientMessageEx(tagetid, COLOR_YELLOWEX, "ผู้ดูแลได้ปรับยาเสพติด 'Cocaine' ของคุณเป็น %.2f กรัม",amout);
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้ปรับยาเสพติด 'Cocaine' ของ %s ให้เป็น %.2f กรัม",ReturnName(tagetid,0), amout);
        }
        case 2:
        {
            PlayerInfo[tagetid][pDrug][1] = amout;
            SendClientMessageEx(tagetid, COLOR_YELLOWEX, "ผู้ดูแลได้ปรับยาเสพติด 'Cannabis' ของคุณเป็น %.2f กรัม",amout);
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้ปรับยาเสพติด 'Cannabis' ของ %s ให้เป็น %.2f กรัม",ReturnName(tagetid,0), amout);
        }
        case 3:
        {
            PlayerInfo[tagetid][pDrug][1] = amout;
            SendClientMessageEx(tagetid, COLOR_YELLOWEX, "ผู้ดูแลได้ปรับยาเสพติด 'Heroin' ของคุณเป็น %.2f กรัม",amout);
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้ปรับยาเสพติด 'Heroin' ของ %s ให้เป็น %.2f กรัม",ReturnName(tagetid,0), amout);
        }
        default: SendErrorMessage(playerid, "ใส่ปรเะเภทของยาเสพติดให้ถูกต้อง");
    }
    return 1;
}

CMD:agivedrug(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 3)
        return SendUnauthMessage(playerid);

    new tagetid,type, Float:amout;

    if(sscanf(params, "udf", tagetid, type, amout))
    {
        SendUsageMessage(playerid, "/agivedrug <ชื่อบางส่วน/ไอดี> <ประเภทยาเสพติด> <จำนวน : กรัม>");
        SendUsageMessage(playerid, "1.Cocaine 2.Cannabis 3.Heroin");
        return 1;
    }

    if(!IsPlayerConnected(tagetid))
        return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซิร์ฟเวอร์");

    if(IsPlayerLogin(tagetid))
        return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

    if(amout < 0.01)
        return SendErrorMessage(playerid, "ใส่จำนวนน้อยเกินไป");

    switch(type)
    {
        case 1:
        {
            PlayerInfo[tagetid][pDrug][0] += amout;
            SendClientMessageEx(tagetid, COLOR_YELLOWEX, "ผู้ดูแลได้เพิ่มยาเสพติด 'Cocaine' ของคุณ %.2f กรัม",amout);
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เพิ่มยาเสพติด 'Cocaine' ของ %s ให้ %.2f กรัม",ReturnName(tagetid,0), amout);
        }
        case 2:
        {
            PlayerInfo[tagetid][pDrug][1] += amout;
            SendClientMessageEx(tagetid, COLOR_YELLOWEX, "ผู้ดูแลได้เพิ่มยาเสพติด 'Cannabis' ของคุณ %.2f กรัม",amout);
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เพิ่มยาเสพติด 'Cannabis' ของ %s ให้ %.2f กรัม",ReturnName(tagetid,0), amout);
        }
        case 3:
        {
            PlayerInfo[tagetid][pDrug][2] += amout;
            SendClientMessageEx(tagetid, COLOR_YELLOWEX, "ผู้ดูแลได้เพิ่มยาเสพติด 'Heroin' ของคุณ %.2f กรัม",amout);
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เพิ่มยาเสพติด 'Heroin' ของ %s ให้ %.2f กรัม",ReturnName(tagetid,0), amout);
        }
        default: SendErrorMessage(playerid, "ใส่ปรเะเภทของยาเสพติดให้ถูกต้อง");
    }
    return 1;
}


forward SetPlayerHealth_Stap(playerid, type);
public SetPlayerHealth_Stap(playerid, type)
{
    new Float:health;

    GetPlayerHealth(playerid, health);

    if(GetPlayerTeam(playerid) != PLAYER_STATE_ALIVE)
    {
        KillTimer(PlayerDrugUse[playerid]);
        PlayerDrugUse[playerid] = -1;
        SendClientMessage(playerid, COLOR_LIGHTRED, "สถานะคุณไม่ได้อยู้สำหรับการเสพยา");
        return 1;
    }

    if(PlayerDrugUse[playerid] == -1)
        return 1;

    switch(type)
    {
        case 1:
        {
            if(health > 170)
            {
                SetPlayerHealth(playerid, 170);
                KillTimer(PlayerDrugUse[playerid]);
                PlayerDrugUse[playerid] = -1;
                GameTextForPlayer(playerid, "~r~Max Health Increase", 5000, 4);
                return 1;
            }

            GivePlayerHealth(playerid, 2);
        }
        case 2:
        {
            if(health > 150)
            {
                SetPlayerHealth(playerid, 150);
                KillTimer(PlayerDrugUse[playerid]);
                PlayerDrugUse[playerid] = -1;
                GameTextForPlayer(playerid, "~r~Max Health Increase", 5000, 4);
                return 1;
            }
            GivePlayerHealth(playerid, 2);
        }
        case 3:
        {
            if(health > 200)
            {
                SetPlayerHealth(playerid, 200);
                KillTimer(PlayerDrugUse[playerid]);
                PlayerDrugUse[playerid] = -1;
                GameTextForPlayer(playerid, "~r~Max Health Increase", 5000, 4);
                return 1;
            }
            GivePlayerHealth(playerid, 2);
        }
    }
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    KillTimer(PlayerDrugUse[playerid]);
    PlayerDrugUse[playerid] = -1;
    return 1;
}