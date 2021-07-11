CMD:drughelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_DARKGREEN, "____________DRUGS HELP____________");

    SendClientMessage(playerid, -1, "");
    SendClientMessage(playerid, -1, "/checkdrug (ตรวจดูยาภายในตัว)");
    SendClientMessage(playerid, -1, "/givedrug (ให้ยา)");
    SendClientMessage(playerid, -1, "/usedrug (ใช้ยา)");
    SendClientMessage(playerid, -1, "");

    SendClientMessage(playerid, COLOR_DARKGREEN, "__________________________________");
    return 1;
}

CMD:checkdrug(playerid, params[])
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

            SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "* %s ยื่นบางอย่างให้กับ %s",ReturnName(playerid,0), ReturnName(tagetid,0));
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้มอบ Cocaine ให้กับ %s จำนวน %.2f กรัม",ReturnName(tagetid,0), amout);
            
            format(str, sizeof(str), "[%s] %s Give Drug 'Cocaine' for %s Amount: %.2f", ReturnDate(),ReturnName(playerid,0), ReturnName(tagetid,0), amout);
            SendDiscordMessage(5, str);

            Log(druglog, WARNING, str);

            PlayerInfo[playerid][pDrug][0]-=amout;
            PlayerInfo[tagetid][pDrug][0]+=amout;
            GiveDrug(tagetid, type, amout);
            CharacterSave(playerid);
        }
        case 2:
        {
            if(PlayerInfo[playerid][pDrug][1] < amout)
                return SendErrorMessage(playerid, "คุณมีจำนวนยาไม่เพียงพอต่อการให้");

            SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "* %s ยื่นบางอย่างให้กับ %s",ReturnName(playerid,0), ReturnName(tagetid,0));
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้มอบ Cannabis ให้กับ %s จำนวน %.2f กรัม",ReturnName(tagetid,0), amout);
            
            format(str, sizeof(str), "[%s] %s Give Drug 'Cannabis' for %s Amount: %.2f", ReturnDate(),ReturnName(playerid,0), ReturnName(tagetid,0), amout);
            SendDiscordMessage(5, str);    
            Log(druglog, WARNING, str);        
            
            PlayerInfo[playerid][pDrug][1]-=amout;
            PlayerInfo[tagetid][pDrug][1]+=amout;
            GiveDrug(tagetid, type, amout);
            CharacterSave(playerid);
        }
        case 3:
        {
            if(PlayerInfo[playerid][pDrug][2] < amout)
                return SendErrorMessage(playerid, "คุณมีจำนวนยาไม่เพียงพอต่อการให้");

            SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "* %s ยื่นบางอย่างให้กับ %s",ReturnName(playerid,0), ReturnName(tagetid,0));
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้มอบ Heroin ให้กับ %s จำนวน %.2f กรัม",ReturnName(tagetid,0), amout);
            
            format(str, sizeof(str), "[%s] %s Give Drug 'Heroin' for %s Amount: %.2f", ReturnDate(),ReturnName(playerid,0), ReturnName(tagetid,0), amout);
            SendDiscordMessage(5, str);  
            Log(druglog, WARNING, str);

            PlayerInfo[playerid][pDrug][2]-=amout;
            PlayerInfo[tagetid][pDrug][2]+=amout;
            GiveDrug(tagetid, type, amout);
            CharacterSave(playerid);
        }
        default: SendErrorMessage(playerid, "ใส่ประเภทให้ถูกต้อง");
    }
    return 1;
}

CMD:usedrug(playerid, params[])
{
    new type, Float:health;

    if(sscanf(params, "d", type))
    {
        SendUsageMessage(playerid, "/usedrug <ประเภท>");
        SendUsageMessage(playerid, "1.Cocaine 2.Cannabis 3.Heroin");
        return 1;
    }

    GetPlayerHealth(playerid, health);
    switch(type)
    {
        case 1:
        {
            if(health > 200)
                return SendErrorMessage(playerid, "คุณมีเลือดถึงขีดจำกัดแล้ว");

            SetPlayerHealth(playerid, health+2);
            SendClientMessage(playerid, COLOR_GREY, "คุณได้มีการเสพยาเสพติด 'Cocaine' ทำให้เลือดของคุณเพิ่ม +2");
            PlayerInfo[playerid][pDrug][0]-= 0.01;
            if(PlayerInfo[playerid][pAddictedCount] > 4)
            {
                PlayerInfo[playerid][pAddicted] = true;
            }
            else
            {
                PlayerInfo[playerid][pAddicted] = true;
                PlayerInfo[playerid][pAddictedCount]++;
            }
            Log(druglog, WARNING, "%s มีการใช้ ยาเสพติด 'Cocaine'", ReturnName(playerid, 0));
            return 1;
        }
        case 2:
        {
            if(health > 200)
                return SendErrorMessage(playerid, "คุณมีเลือดถึงขีดจำกัดแล้ว");

            SetPlayerHealth(playerid, health+3);
            SendClientMessage(playerid, COLOR_GREY, "คุณได้มีการเสพยาเสพติด 'Cannabis' ทำให้เลือดของคุณเพิ่ม +3");
            PlayerInfo[playerid][pDrug][1]-= 0.01;
            PlayerInfo[playerid][pAddicted] = true;
            if(PlayerInfo[playerid][pAddictedCount] > 4)
            {
                PlayerInfo[playerid][pAddicted] = true;
            }
            else
            {
                PlayerInfo[playerid][pAddicted] = true;
                PlayerInfo[playerid][pAddictedCount]+=2;
            }
            Log(druglog, WARNING, "%s มีการใช้ ยาเสพติด 'Cannabis'", ReturnName(playerid, 0));
        }
        case 3:
        {
            if(health > 200)
                return SendErrorMessage(playerid, "คุณมีเลือดถึงขีดจำกัดแล้ว");

            SetPlayerHealth(playerid, health+5);
            SendClientMessage(playerid, COLOR_GREY, "คุณได้มีการเสพยาเสพติด 'Heroin' ทำให้เลือดของคุณเพิ่ม +5");
            PlayerInfo[playerid][pDrug][1]-= 0.01;
            PlayerInfo[playerid][pAddicted] = true;
            if(PlayerInfo[playerid][pAddictedCount] > 4)
            {
                PlayerInfo[playerid][pAddicted] = true;
            }
            else
            {
                PlayerInfo[playerid][pAddicted] = true;
                PlayerInfo[playerid][pAddictedCount]++;
            }
            Log(druglog, WARNING, "%s มีการใช้ ยาเสพติด 'Cannabis'", ReturnName(playerid, 0));
        }
    }
    return 1;
}

CMD:buydrug(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, DrugBuyPos[RanDomDrugPoint][DrugPosX], DrugBuyPos[RanDomDrugPoint][DrugPosY], DrugBuyPos[RanDomDrugPoint][DrugPosZ]))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่จุดซื้อยาเสพติด");
    
    new Float:amout, type;

    if(sscanf(params, "df",type,amout))
    {
        SendUsageMessage(playerid, "/buydrug <ยาที่ต้องการ> <จำนวนยาที่ต้องการ ตัวอย่าง: 0.01>");
        SendUsageMessage(playerid, "1.Cocaine 2.Cannabis 3.Heroin 4.Random");
        return 1;
    }

    BuyDrug(playerid, amout, type);
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

    if(!IsPlayerNearPlayer(playerid, tagetid, 2.5))
        return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้ตัวของคุณ");

    if(amout < 0.01)
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

    if(!IsPlayerNearPlayer(playerid, tagetid, 2.5))
        return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้ตัวของคุณ");

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
            PlayerInfo[tagetid][pDrug][1] += amout;
            SendClientMessageEx(tagetid, COLOR_YELLOWEX, "ผู้ดูแลได้เพิ่มยาเสพติด 'Heroin' ของคุณ %.2f กรัม",amout);
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เพิ่มยาเสพติด 'Heroin' ของ %s ให้ %.2f กรัม",ReturnName(tagetid,0), amout);
        }
        default: SendErrorMessage(playerid, "ใส่ปรเะเภทของยาเสพติดให้ถูกต้อง");
    }
    return 1;
}