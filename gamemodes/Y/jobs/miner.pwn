#include <YSI_Coding\y_hooks>

new miner_pickup, startjob[2], proceed_pickup;
new bool:PlayerStartOre[MAX_PLAYERS];


hook OnGameModeInit@13()
{
    miner_pickup = CreateDynamicPickup(1239, 2, 586.4755,872.6391,-42.4973, -1, -1,-1);
    proceed_pickup = CreateDynamicPickup(1239, 2, 674.1799,828.0583,-38.9921, -1, -1,-1);

    startjob[0] = CreateDynamicCircle(595.3938,926.8503, 15.0,-1);
    startjob[1] = CreateDynamicCircle(545.7205,919.6435, 15.0,-1);
    Create3DTextLabel("คลิก ขวาเพื่อทำการขุดแร่ในบริเวรนี้", COLOR_EMOTE, 594.6451,926.9291,-37.3309, 50, 0, 0);
    //CreateDynamicCircle(Float:x, Float:y, Float:size, worldid = -1, interiorid = -1, playerid = -1);
    return 1;
}

hook OP_PickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
    if(pickupid == miner_pickup)
    {
        SendClientMessage(playerid, -1, "พิมพ์ /takejob เพื่อสมัครงาน นักขุดเหมือง");
        return 1;
    }
    if(pickupid == proceed_pickup)
    {
        SendClientMessage(playerid, -1, "พิมพ์ /ptze เพื่อแปรรูป");
        return 1;
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(RELEASED(KEY_RIGHT) || RELEASED(KEY_CTRL_BACK))
    {
        if(PlayerInfo[playerid][pJob] != JOB_MINER && PlayerInfo[playerid][pSideJob] != JOB_MINER)
            return 1;

        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            return 1;

        if(!IsPlayerInDynamicArea(playerid, startjob[0]) && !IsPlayerInDynamicArea(playerid, startjob[1]))
            return 1;

        if(PlayerStartOre[playerid])
            return 1;

        //GetPlayerPos(playerid, newPos[0], newPos[1], newPos[2]);

        if(IsPlayerInRangeOfPoint(playerid, 2.5, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]))
            return SendErrorMessage(playerid, "คุณต้องเปลี่ยนจุดขุดของคุณ");

        if(PlayerInfo[playerid][pOre] >= 50)
            return SendErrorMessage(playerid, "คุณมีแร่ในตัวเต็มแล้ว");

        new str[120];
        format(str, sizeof(str), "ได้เริ่มขุดแร่...");
        callcmd::me(playerid, str);
        TogglePlayerControllable(playerid, 0);
        PlayerStartOre[playerid] = true;
        GetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
        SetTimerEx("StartMine", 5000, false, "d",playerid);
        
        return 1;
    }
    return 1;
}

forward StartMine(playerid);
public StartMine(playerid)
{
    new amount = Random(1,3);
    PlayerStartOre[playerid] = false;
    PlayerInfo[playerid][pOre] += amount;
    SendClientMessageEx(playerid, COLOR_REPORT, "[MINER JOB] คุณได้เริ่มขุดแร่แล้วได้แร่ที่ยังไม่ได้แปรรูปจำนวน %d ชิ้น",amount);
    TogglePlayerControllable(playerid, 1);
    CharacterSave(playerid);
    return 1;
}

CMD:checkore(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MINER && PlayerInfo[playerid][pSideJob] != JOB_MINER && !PlayerInfo[playerid][pAdmin])
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพ นักขุดเหมือง");

    if(PlayerInfo[playerid][pAdmin])
    {
        new tagetid;
        if(sscanf(params, "i(-1)", tagetid))
            return 1;

        if(tagetid == -1)
		{
			return  ShowOre(playerid);
		}
		else
		{
			if(!IsPlayerConnected(tagetid))
				return SendErrorMessage(tagetid, "ผู้เล่นไม่ได้ทำการเชื่อมต่อเข้าเซืฟเวอร์");
				
			if(!BitFlag_Get(gPlayerBitFlag[tagetid], IS_LOGGED))
				return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
				
			ShowOre(tagetid);
		}
        return 1;
    }
    else ShowOre(playerid);
    return 1;
}


CMD:ptze(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MINER && PlayerInfo[playerid][pSideJob] != JOB_MINER)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพ นักขุดเหมือง");

    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 674.1799,828.0583,-38.9921))
        return SendErrorMessage(playerid, "คุณไมไ่ด้อยู่ในจุด Proceed");

    new amount, str[255];

    if(sscanf(params, "d",amount))
        return SendUsageMessage(playerid, "/ptze <จำนวน>");

    if(amount < 1)
        return SendUsageMessage(playerid, "/ptze <จำนวน> ใส่จำนวนให้ถูกต้อง");

    if(PlayerInfo[playerid][pOre] < amount)
        return SendErrorMessage(playerid, "จำนวนไม่เพียงพอ");

    format(str, sizeof(str), "ทำการแปรรูปแร่...");
    callcmd::me(playerid, str);
    TogglePlayerControllable(playerid, 0);
    SendClientMessageEx(playerid, COLOR_YELLOW, "คุณเริ่มแปรรูปแร่ของคุณ จำนวน %d ชิ้น ต้องใช้เวลาในการแปรรูป %d วินาที",amount, amount);
    PlayerInfo[playerid][pOre]-= amount;
    SetTimerEx("ProceedOre", amount*1000, false, "dd", playerid, amount);
    return 1;
}

CMD:giveore(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MINER && PlayerInfo[playerid][pSideJob] != JOB_MINER)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพ นักขุดเหมือง");

    new amount, type[60], tagetid;

    if(sscanf(params, "s[60]dd",type, amount, tagetid))
    {
        SendUsageMessage(playerid, "/giveore <ประเภท :  แร่> <จำนวน> <ชื่อบางส่วน/ไอดี>");
        SendClientMessage(playerid, -1, "[ORE TYPE:] ore coal iron copper kno3");
        return 1;
    }


    if(!strcmp(type, "ore", true))
    {
        if(PlayerInfo[playerid][pOre] < amount)
            return SendErrorMessage(playerid, "คุณมีจำนวนแร่ Ore ไม่เพียงพอ");

        if(!IsPlayerConnected(tagetid))
            return SendErrorMessage(playerid,"ผู้เล่นไม่ได้อยู่ภายมรเซิร์ฟเวอร์");

        if(playerid  == tagetid)
            return SendErrorMessage(playerid, "คุณไม่สามารถให้แร่กับตัวเองได้");

        if(IsPlayerLogin(playerid))
            return SendErrorMessage(playerid,"ผู้เล่นกำลังเข้าสู่ระบบ");

        
        PlayerInfo[tagetid][pOre] += amount;
        PlayerInfo[playerid][pOre] -= amount;
        SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้ให้ Unprocessed Ores จำนวน %d ก้อนกับ %s",amount,  ReturnName(tagetid,0));
        SendClientMessageEx(tagetid, COLOR_DARKGREEN, "คุณได้รับ Unprocessed Ores จำนวน %d ก้อนจาก %s",amount,  ReturnName(playerid,0));
        SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "* %s หยิบ Unprocessed Ores ให้กับ %s", ReturnName(playerid,0), ReturnName(tagetid,0));
        return 1;
    }
    else if(!strcmp(type, "coal", true))
    {
        if(PlayerInfo[playerid][pCoal] < amount)
            return SendErrorMessage(playerid, "คุณมีจำนวนแร่ Coal Ore ไม่เพียงพอ");

        if(!IsPlayerConnected(tagetid))
            return SendErrorMessage(playerid,"ผู้เล่นไม่ได้อยู่ภายมรเซิร์ฟเวอร์");

        if(playerid  == tagetid)
            return SendErrorMessage(playerid, "คุณไม่สามารถให้แร่กับตัวเองได้");

        if(IsPlayerLogin(playerid))
            return SendErrorMessage(playerid,"ผู้เล่นกำลังเข้าสู่ระบบ");

        
        PlayerInfo[tagetid][pCoal] += amount;
        PlayerInfo[playerid][pCoal] -= amount;
        SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้ให้ Coal Ore จำนวน %d ก้อนกับ %s",amount,  ReturnName(tagetid,0));
        SendClientMessageEx(tagetid, COLOR_DARKGREEN, "คุณได้รับ Coal Ore จำนวน %d ก้อนจาก %s",amount,  ReturnName(playerid,0));
        SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "* %s หยิบ Coal Ore ให้กับ %s", ReturnName(playerid,0), ReturnName(tagetid,0));
        return 1;
    }
    else if(!strcmp(type, "iron", true))
    {
        if(PlayerInfo[playerid][pIron] < amount)
            return SendErrorMessage(playerid, "คุณมีจำนวนแร่ Iron Ore ไม่เพียงพอ");

        if(!IsPlayerConnected(tagetid))
            return SendErrorMessage(playerid,"ผู้เล่นไม่ได้อยู่ภายมรเซิร์ฟเวอร์");

        if(playerid  == tagetid)
            return SendErrorMessage(playerid, "คุณไม่สามารถให้แร่กับตัวเองได้");

        if(IsPlayerLogin(playerid))
            return SendErrorMessage(playerid,"ผู้เล่นกำลังเข้าสู่ระบบ");

        
        PlayerInfo[tagetid][pIron] += amount;
        PlayerInfo[playerid][pIron] -= amount;
        SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้ให้ Iron Ore จำนวน %d ก้อนกับ %s",amount,  ReturnName(tagetid,0));
        SendClientMessageEx(tagetid, COLOR_DARKGREEN, "คุณได้รับ Iron Ore จำนวน %d ก้อนจาก %s",amount,  ReturnName(playerid,0));
        SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "* %s หยิบ Iron Ore ให้กับ %s", ReturnName(playerid,0), ReturnName(tagetid,0));
        return 1;
    }
    else if(!strcmp(type, "copper", true))
    {
        if(PlayerInfo[playerid][pCopper] < amount)
            return SendErrorMessage(playerid, "คุณมีจำนวนแร่ Iron Ore ไม่เพียงพอ");

        if(!IsPlayerConnected(tagetid))
            return SendErrorMessage(playerid,"ผู้เล่นไม่ได้อยู่ภายมรเซิร์ฟเวอร์");

        if(playerid  == tagetid)
            return SendErrorMessage(playerid, "คุณไม่สามารถให้แร่กับตัวเองได้");

        if(IsPlayerLogin(playerid))
            return SendErrorMessage(playerid,"ผู้เล่นกำลังเข้าสู่ระบบ");

        
        PlayerInfo[tagetid][pCopper] += amount;
        PlayerInfo[playerid][pCopper] -= amount;
        SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้ให้ Copper Ore จำนวน %d ก้อนกับ %s",amount,  ReturnName(tagetid,0));
        SendClientMessageEx(tagetid, COLOR_DARKGREEN, "คุณได้รับ Copper Ore จำนวน %d ก้อนจาก %s",amount,  ReturnName(playerid,0));
        SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "* %s หยิบ Copper Ore ให้กับ %s", ReturnName(playerid,0), ReturnName(tagetid,0));
        return 1;
    }
    else if(!strcmp(type, "kno3", true))
    {
        if(PlayerInfo[playerid][pCopper] < amount)
            return SendErrorMessage(playerid, "คุณมีจำนวนแร่ Potassium Nitrate ไม่เพียงพอ");

        if(!IsPlayerConnected(tagetid))
            return SendErrorMessage(playerid,"ผู้เล่นไม่ได้อยู่ภายมรเซิร์ฟเวอร์");

        if(playerid  == tagetid)
            return SendErrorMessage(playerid, "คุณไม่สามารถให้แร่กับตัวเองได้");

        if(IsPlayerLogin(playerid))
            return SendErrorMessage(playerid,"ผู้เล่นกำลังเข้าสู่ระบบ");

        
        PlayerInfo[tagetid][pKNO3] += amount;
        PlayerInfo[playerid][pKNO3] -= amount;
        SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้ให้ Potassium Nitrate จำนวน %d ก้อนกับ %s",amount,  ReturnName(tagetid,0));
        SendClientMessageEx(tagetid, COLOR_DARKGREEN, "คุณได้รับ Potassium Nitrate จำนวน %d ก้อนจาก %s",amount,  ReturnName(playerid,0));
        SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "* %s หยิบ Potassium Nitrate ให้กับ %s", ReturnName(playerid,0), ReturnName(tagetid,0));
        return 1;
    }
    else SendErrorMessage(playerid, "ใส่ประเภทไม่ถูกต้อง");

    return 1;
}

CMD:sellore(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MINER && PlayerInfo[playerid][pSideJob] != JOB_MINER)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพ นักขุดเหมือง");

    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2151.4236,-2266.5696,13.3064) && !IsPlayerInRangeOfPoint(playerid, 3.0, 2149.4441,-2264.5461,13.3057))
        return SendErrorMessage(playerid,  "คุณไม่ได้อยู่ในจุดขายแร่");

    new type[60],amount;

    if(sscanf(params, "s[60]d", type, amount))
    {
        SendUsageMessage(playerid, "/sellore <ประเภท  :แร่> <จำนวน>");
        SendClientMessage(playerid, -1, "[ORE TYPE:] Coal Iron Copper KNO3"); 
        return 1; 
    }  

    if(!strcmp(type, "coal", true))
    {
        if(PlayerInfo[playerid][pCoal] < amount)
            return SendErrorMessage(playerid, "คุณมี Coal Ore ไม่เพียงพอ");

        PlayerInfo[playerid][pCoal]-= amount;
        GiveMoney(playerid, amount*5);
        SendClientMessageEx(playerid, -1, "คุณได้ขายแร่ Coal Ore จำนวน %d ได้เงินมา %s",amount, MoneyFormat(amount *5));       
        return 1;
    }
    else if(!strcmp(type, "iron", true))
    {
        if(PlayerInfo[playerid][pIron] < amount)
            return SendErrorMessage(playerid, "คุณมี Iron Ore ไม่เพียงพอ");

        PlayerInfo[playerid][pIron]-= amount;
        GiveMoney(playerid, amount*15);
        SendClientMessageEx(playerid, -1, "คุณได้ขายแร่ Iron Ore จำนวน %d ได้เงินมา %s",amount, MoneyFormat(amount *15));       
        return 1;
    }
    else if(!strcmp(type, "copper", true))
    {
        if(PlayerInfo[playerid][pCopper] < amount)
            return SendErrorMessage(playerid, "คุณมี Copper Ore ไม่เพียงพอ");

        PlayerInfo[playerid][pCopper]-= amount;
        GiveMoney(playerid, amount*10);
        SendClientMessageEx(playerid, -1, "คุณได้ขายแร่ Copper Ore จำนวน %d ได้เงินมา %s",amount, MoneyFormat(amount *10));       
        return 1;
    }
    else if(!strcmp(type, "kno3", true))
    {
        if(PlayerInfo[playerid][pKNO3] < amount)
            return SendErrorMessage(playerid, "คุณมี Potassium Nitrate ไม่เพียงพอ");

        PlayerInfo[playerid][pKNO3]-= amount;
        GiveMoney(playerid, amount*50);
        SendClientMessageEx(playerid, -1, "คุณได้ขายแร่ Potassium Nitrate จำนวน %d ได้เงินมา %s",amount, MoneyFormat(amount *50));       
        return 1;
    }
    return 1;
}


forward ProceedOre(playerid, amount);
public ProceedOre(playerid, amount)
{
    TogglePlayerControllable(playerid, 1);
    
    new randore = random(9);
    
    switch(randore)
    {
        case 0:
        {
            PlayerInfo[playerid][pCoal] += amount;
            SendClientMessageEx(playerid, -1, "คุณได้แปรรูปแร่ของคุณ คุณได้ ถ่าน มา %d ก้อน",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 1:
        {
            PlayerInfo[playerid][pCoal] += amount;
            SendClientMessageEx(playerid, -1, "คุณได้แปรรูปแร่ของคุณ คุณได้ ถ่าน มา %d ก้อน",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 2:
        {
            PlayerInfo[playerid][pCoal] += amount;
            SendClientMessageEx(playerid, -1, "คุณได้แปรรูปแร่ของคุณ คุณได้ ถ่าน มา %d ก้อน",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 3:
        {
            PlayerInfo[playerid][pIron] += amount;
            SendClientMessageEx(playerid, -1, "คุณได้แปรรูปแร่ของคุณ คุณได้ เหล็ก มา %d ก้อน",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 4:
        {
            PlayerInfo[playerid][pIron] += amount;
            SendClientMessageEx(playerid, -1, "คุณได้แปรรูปแร่ของคุณ คุณได้ เหล็ก มา %d ก้อน",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 5:
        {
            PlayerInfo[playerid][pCopper] += amount;
            SendClientMessageEx(playerid, -1, "คุณได้แปรรูปแร่ของคุณ คุณได้ ทองแดง มา %d ก้อน",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 6:
        {
            PlayerInfo[playerid][pCopper] += amount;
            SendClientMessageEx(playerid, -1, "คุณได้แปรรูปแร่ของคุณ คุณได้ ทองแดง มา %d ก้อน",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 7:
        {
            PlayerInfo[playerid][pCopper] += amount;
            SendClientMessageEx(playerid, -1, "คุณได้แปรรูปแร่ของคุณ คุณได้ ทองแดง มา %d ก้อน",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 8:
        {
            PlayerInfo[playerid][pKNO3] += amount / 2;
            SendClientMessageEx(playerid, -1, "คุณได้แปรรูปแร่ของคุณ คุณได้ ทองแดง มา %d ก้อน",amount /2);
            CharacterSave(playerid);
            return 1;
        }
    }
    return 1;
}

stock ShowOre(playerid)
{
    SendClientMessageEx(playerid, COLOR_DARKGREEN, "---------- ORE %s ----------",  ReturnName(playerid,0));
    SendClientMessageEx(playerid, COLOR_WHITE, "Unprocessed Ores: %d ชิ้น", PlayerInfo[playerid][pOre]);
    SendClientMessageEx(playerid, COLOR_WHITE, "Coal Ore: %d ชิ้น", PlayerInfo[playerid][pCoal]);
    SendClientMessageEx(playerid, COLOR_WHITE, "Iron Ore: %d ชิ้น", PlayerInfo[playerid][pIron]);
    SendClientMessageEx(playerid, COLOR_WHITE, "Copper Ore: %d ชิ้น", PlayerInfo[playerid][pCopper]);
    SendClientMessageEx(playerid, COLOR_WHITE, "Potassium Nitrate: %d ชิ้น", PlayerInfo[playerid][pKNO3]);
    SendClientMessage(playerid, COLOR_DARKGREEN, "---------- ORE ----------");
    return 1;
}