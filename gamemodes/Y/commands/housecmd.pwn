#include <YSI_Coding\y_hooks>

CMD:housecmds(playerid, params[])
{
    SendClientMessage(playerid, COLOR_DARKGREEN, "____________________HOUSE COMMAND__________________________");

    SendClientMessage(playerid, COLOR_GRAD2,"[HOUSE] /house /buyhouse /sellhouse /lock /placepos /switch /knock /ddo /ds");

    SendClientMessage(playerid, COLOR_GRAD2,"[HOUSE] /renthouse /sethouse /givehousekey");

    SendClientMessage(playerid, COLOR_GREEN,"________________________________________________________________");
    SendClientMessage(playerid, COLOR_GRAD1,"โปรดศึกษาคำสั่งในเซิร์ฟเวอร์เพิ่มเติมในฟอรั่มหรือ /helpme เพื่อขอความช่วยเหลือ");
    return 1;
}

CMD:house(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideProperty];

    if(id == 0)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในบ้านของคุณ");

    if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในบ้านของคุณ");

    new str[MAX_STRING], longstr[MAX_STRING];

    format(longstr, sizeof(longstr), "บ้านเลขที่: %s\n",HouseInfo[id][HouseName]);
    strcat(str, longstr);
    format(longstr, sizeof(longstr), "ราคาบ้าน: %s\n",MoneyFormat(HouseInfo[id][HousePrice]));
    strcat(str, longstr);

    Dialog_Show(playerid, DIALOG_MYHOUSE, DIALOG_STYLE_MSGBOX, "HOUSE:", str, ">>", "");
    return 1;
}

CMD:sethouse(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideProperty];

    if(!id)
        return SendErrorMessage(playerid, "คุณจำเป็นจะต้องอยู่ภายในบ้านของคุณ");

    if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendErrorMessage(playerid,"บ้านหลังนี้ไม่ใช่บ้านของคุณ");

    new str[60], secstr[60];

    if(sscanf(params, "s[60]S()[60]", str, secstr))
    {
        SendUsageMessage(playerid, "/sethouse <option>");
        SendClientMessage(playerid, -1, "OPTION: rentopen , rentprice");
        return 1;
    }

    if(!strcmp(str, "rentopen", true))
    {
        new query[MAX_STRING], count;

        if(HouseInfo[id][HouseRentStats])
        {
            HouseInfo[id][HouseRentStats] = false;
            SendClientMessage(playerid, COLOR_LIGHTRED, "คุณได้ยกเลิกสัญญาการเช่าบ้านหลังนี้ออก");

            foreach(new i : Player)
            {
                if(PlayerInfo[i][pDBID] != HouseInfo[id][HouseRent])
                    continue;
                
                SendClientMessageEx(i, COLOR_LIGHTRED, "บ้าน: %s, Los Santos, San Andreas ได้มีการยกเลิกสัญญาการเช่าบ้านหลังดังกล่าวแล้ว",HouseInfo[id][HouseName]);
                SendClientMessage(i, COLOR_LIGHTRED, "หากคุณพบว่า เจ้าของบ้านหลังดังกล่าวไม่ได้มีการตกลงหรือทำผิดข้อสัญญาที่พวกคุณให้กันไว้ตามเอกสาร (IC)");
                SendClientMessage(i, COLOR_LIGHTRED, "คุณสามารถเลือกที่จะร้องเรียนเรื่องนี้ได้ในทันที โดยการไปแจ้งกับเจ้าหน้าที่ตำรวจภายใน สำนักงานตำรวจ");
                
                if(PlayerInfo[i][pSpawnHouse] == HouseInfo[id][HouseDBID])
                {
                    PlayerInfo[i][pSpawnPoint] = SPAWN_AT_DEFAULT;
                    PlayerInfo[i][pSpawnHouse] = 0;
                    SendClientMessage(i, -1, "คุณได้ถูกเซ็ตจุดเกิดกลับมาที่ สนามบินแล้ว!");
                    count++;
                }
            }

            if(!count)
            {
                mysql_format(dbCon, query, sizeof(query), "UPDATE `characters` SET `pSpawnPoint`='0', `pSpawnHouse` = '0' WHERE `char_dbid` = %d", HouseInfo[id][HouseRent]);
                mysql_tquery(dbCon, query);
                
            }
            HouseInfo[id][HouseRent] = 0;
            Savehouse(id);
            return 1;
        }
        else
        {
            if(!HouseInfo[id][HouseRentPrice])
                return SendErrorMessage(playerid, "บ้านหลังนี้ยังไมได้ต้องราคาในการช่า");
              
            HouseInfo[id][HouseRentStats] = true;
            SendClientMessage(playerid, COLOR_LIGHTRED, "คุณได้ทำการปล่อยบ้านหลังนี้ของคุณเป็นการเช่า");
            Savehouse(id);
        }
        return 1;
    }
    else if(!strcmp(str, "rentprice", true))
    {
        new value;

        if(HouseInfo[id][HouseRent])
            return SendErrorMessage(playerid, "ยังมีผู้เช่าบ้านของคุณอยู่");
    
        if(sscanf(secstr, "d", value))
            return SendUsageMessage(playerid, "/sethouse <rentprice> <จำนวนค่าเช่า>");

        if(value < 1 || value > 200000)
            return SendErrorMessage(playerid, "คุณใส่ราคาค่าเช่าบ้านไม่ถูกต้อง <1-200000>");

        HouseInfo[id][HouseRentPrice] = value;
        SendClientMessageEx(playerid, COLOR_DARKGREEN, "บ้าน: %d %s Los Santos, San Andreas",HouseInfo[id][HouseDBID], HouseInfo[id][HouseName]);
        SendClientMessageEx(playerid, COLOR_DARKGREEN, "ได้มีการปรับราคาค่าเช่าบ้านหลังนี้เป็น $%s",MoneyFormat(value));
        return 1;
    }
    return 1;
}

CMD:renthouse(playerid, params[])
{
    new bool:Check;
    for(new p = 1; p < MAX_HOUSE; p++)
	{
		if(!HouseInfo[p][HouseDBID])
			continue;

        if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[p][HouseEntrance][0], HouseInfo[p][HouseEntrance][1], HouseInfo[p][HouseEntrance][2]))
		{
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[p][HouseEntranceWorld])
				continue;
					
			if(GetPlayerInterior(playerid) != HouseInfo[p][HouseEntranceInterior])
				continue;

            if(!HouseInfo[p][HouseRentStats])
                return SendErrorMessage(playerid, "คุณไม่สามารถเช่าบ้านหลังนี้ได้เนื่องจากบ้านหลังนี้เป็นบ้านส่วนบุคคล ไม่ได้มีการเปิดให้เช่าอยู่แต่อย่างใด");

            if(HouseInfo[p][HouseRent])
                return SendErrorMessage(playerid, "บ้านหลังนี้มีคนอยู่ภายในบ้านอยู่แล้ว");

            if(PlayerInfo[playerid][pDBID] == HouseInfo[p][HouseRent])
                return SendErrorMessage(playerid, "คุณได้เช่าบ้านหลังนี้อยู่แล้ว");

            if(PlayerInfo[playerid][pDBID] == HouseInfo[p][HouseOwnerDBID])
                return SendErrorMessage(playerid, "คุณไม่สามารถเช่าบ้านของตัวเองได้");

            if(PlayerInfo[playerid][pCash] < HouseInfo[p][HouseRentPrice])
                return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอต่อการเช่า ราคาเช่าคือ $%s, (ยังขาดอยู่ $%s)",MoneyFormat(HouseInfo[p][HouseRentPrice]), MoneyFormat(HouseInfo[p][HouseRentPrice] - PlayerInfo[playerid][pCash]));

            HouseInfo[p][HouseRent] = PlayerInfo[playerid][pDBID];

            
            GiveMoney(playerid, -HouseInfo[p][HouseRentPrice]);
            
            new total_tax = floatround(HouseInfo[p][HouseRentPrice] * 0.07,floatround_round);

            foreach(new i : Player)
            {
                if(PlayerInfo[i][pDBID] == HouseInfo[p][HouseOwnerDBID])
                {
                    GiveMoney(playerid, HouseInfo[p][HouseRentPrice] - total_tax);
                    GiveMoney(i, HouseInfo[p][HouseRentPrice] - total_tax);
                    GlobalInfo[G_GovCash]+= total_tax;
                    SendClientMessageEx(i, COLOR_RADIO, "SMS: %s ได้มีการเช่าบ้าน %d %s, Los Santos, San Andreas ของคุณแล้ว ได้จ่ายค่าเช่ามาที่คุณ $%s",ReturnName(playerid,0), HouseInfo[p][HouseDBID], HouseInfo[p][HouseName], MoneyFormat(HouseInfo[p][HouseRentPrice] - total_tax));
                }
                else
                {
                    AddPlayerCash(HouseInfo[p][HouseOwnerDBID], HouseInfo[p][HouseRentPrice] - total_tax);
                }
            }

            Savehouse(p);
            Saveglobal();

            Check = true;

            return 1;
        }
        else Check = false;
    }

    if(!Check)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้บ้านที่เปิดให้เช่า");
    
    return 1;
}

CMD:buyhouse(playerid, params[])
{
    for(new p = 1; p < MAX_HOUSE; p++)
	{
		if(!HouseInfo[p][HouseDBID])
			continue;

        if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[p][HouseEntrance][0], HouseInfo[p][HouseEntrance][1], HouseInfo[p][HouseEntrance][2]))
		{
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[p][HouseEntranceWorld])
				continue;
					
			if(GetPlayerInterior(playerid) != HouseInfo[p][HouseEntranceInterior])
				continue;

            if(CountPlayerProperties(playerid) > 3)
			    return SendErrorMessage(playerid, "คุณสามารถเป็นเจ้าของบ้านได้เพียงแค่ 3 หลังเท่านั้น");


            if(HouseInfo[p][HouseOwnerDBID])
                return SendClientMessage(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF} บ้านหลังนี้มีเจ้าของอยู่แล้ว");

            if(GetPlayerMoney(playerid) < HouseInfo[p][HousePrice] || PlayerInfo[playerid][pLevel] < HouseInfo[p][HouseLevel])
                return SendClientMessage(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF} คุณมีเงินหรือ เลเวล ไม่เพียงพอต่อการซื้อบ้าน");

            HouseInfo[p][HouseOwnerDBID] = PlayerInfo[playerid][pDBID];
            GiveMoney(playerid, -HouseInfo[p][HousePrice]);
            SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{66FF99}คุณได้ซื้อบ้านสำเร็จแล้ว");
            HouseInfo[p][HouseLock] = false;

            if(IsValidDynamicPickup(HouseInfo[p][HousePickup]))
                DestroyDynamicPickup(HouseInfo[p][HousePickup]);
            
            Savehouse(p);

            //HouseInfo[p][HousePickup] = CreateDynamicPickup(1272, 23, HouseInfo[p][HouseEntrance][0], HouseInfo[p][HouseEntrance][1], HouseInfo[p][HouseEntrance][2],-1,-1);
            return 1;
        }
        else SendErrorMessage(playerid, "คุณไมได้อยู่ใกล้บ้านที่จะซื้อ");
    }
    return 1;
}

CMD:sellhouse(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideProperty];

    if(!PlayerInfo[playerid][pInsideProperty])
        return SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} คุณไม่ได้อยู่ในบ้าน");

    if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} บ้านหลังนี้ไม่ใช่บ้านของคุณ");

    if(HouseInfo[id][HouseRentStats])
        return SendErrorMessage(playerid, "คุณจำเป็นต้องไปปิดการเช่าบ้านก่อน");
    
    Dialog_Show(playerid, DIALOG_SELL_HOUSE, DIALOG_STYLE_MSGBOX, "คุณแน่ใจ?", "คุณแน่ใจใช่ไหมที่จะขายบ้านหลังนี้\n\
                                                                               คุณจะได้เงินคืนแค่ครึ่งของราคาบ้านทั้งมหด\n\
                                                                               โปรดคิดให้ดีก่อนที่จะกดปุ่ม ยืนยัน", "ยืนยัน", "ยกเลิก");

    return 1;
}

CMD:placepos(playerid,params[])
{
    new id = PlayerInfo[playerid][pInsideProperty];

    if(!PlayerInfo[playerid][pInsideProperty])
        return SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} คุณไม่ได้อยู่ในบ้าน");

    if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} บ้านหลังนี้ไม่ใช่บ้านของคุณ");

    GetPlayerPos(playerid, HouseInfo[id][HousePlacePos][0], HouseInfo[id][HousePlacePos][1], HouseInfo[id][HousePlacePos][2]);


    SendClientMessage(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF} คุณได้วางจุดตู้เซฟไว้ตรงตำแหน่งตรงนี้แล้ว");
    Savehouse(id);
    return 1;
}

CMD:ds(playerid, params[])
{
    if(!PlayerInfo[playerid][pInsideProperty] && !IsPlayerNearHouse(playerid))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่หน้า/ใน บ้าน");

    if(isnull(params))
	    return SendClientMessage(playerid, COLOR_GRAD2, "/ds [ข้อความ]");
    
    new str[128];
	if (strlen(params) > 80) {
	    format(str, sizeof(str), "%s ตะโกน: %.80s", ReturnRealName(playerid, 0), params);
	    ProxDetector(playerid, 30.0, str);

	    format(str, sizeof(str), "... %s!", params[80]);
	    ProxDetector(playerid, 30.0, str);

        foreach(new i : Player)
        {
            if(IsPlayerInHouse(i) != IsPlayerNearHouse(playerid) || IsPlayerInHouse(playerid) != IsPlayerNearHouse(i))
                continue;

            SendClientMessage(i, COLOR_GRAD1, str);
        }
	}
	else 
    {
        format(str, sizeof(str), "%s ตะโกน: %s!", ReturnRealName(playerid, 0), params), ProxDetector(playerid, 30.0, str);

        foreach(new i : Player)
        {
            if(IsPlayerInHouse(i) != IsPlayerNearHouse(playerid) || IsPlayerInHouse(playerid) != IsPlayerNearHouse(i))
                continue;

            SendClientMessage(i, COLOR_GRAD1, str);
        }

    }

    return 1;
}

CMD:ddo(playerid, params[])
{
    if(!PlayerInfo[playerid][pInsideProperty] && !IsPlayerNearHouse(playerid))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่หน้า/ใน บ้าน");

    if(isnull(params))
	    return SendSyntaxMessage(playerid, "/ddo [action]");
    
    if(strlen(params) > 80)
    {
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %.80s", params);
	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "... %s (( %s ))", params[80], ReturnRealName(playerid, 0));

        foreach(new i : Player)
        {
            if(IsPlayerInHouse(i) != IsPlayerNearHouse(playerid) || IsPlayerInHouse(playerid) != IsPlayerNearHouse(i))
                continue;

            SendClientMessageEx(i, COLOR_PURPLE, "* %.80s",params);
            SendClientMessageEx(i, COLOR_PURPLE, "... %s (( %s ))",params[80],ReturnRealName(playerid, 0));
        }
    }
    else
    {
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s (( %s ))", params, ReturnRealName(playerid, 0));
        foreach(new i : Player)
        {
            if(IsPlayerInHouse(i) != IsPlayerNearHouse(playerid) || IsPlayerInHouse(playerid) != IsPlayerNearHouse(i))
                continue;

            SendClientMessageEx(i, COLOR_PURPLE, "* %s (( %s ))",params,ReturnRealName(playerid, 0));
        }
    }
    return 1;
}

CMD:knock(playerid, params[])
{
    if(!IsPlayerNearHouse(playerid))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่หน้า/ใน บ้าน");
    
    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* เคาะประตู (( %s ))", ReturnRealName(playerid, 0));

    foreach(new i : Player)
    {
        if(IsPlayerInHouse(i) != IsPlayerNearHouse(playerid) || IsPlayerInHouse(playerid) != IsPlayerNearHouse(i))
            continue;

        SendClientMessageEx(i, COLOR_PURPLE, "* เคาะประตู (( %s ))",ReturnRealName(playerid, 0));
    }
    return 1;
}


CMD:switch(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideProperty], str[32];

    if(id == 0)
        return SendErrorMessage(playerid, "กรุณาอยู่ภายในบ้านก่อน");

    new trun[10];

    if(sscanf(params, "s[10]",trun))
    {
        SendClientMessage(playerid, -1, "on = เปิดไฟภายในบ้าน");
        SendClientMessage(playerid, -1, "off = ปิดไฟภายในบ้าน");
        SendUsageMessage(playerid, "/switch <on หรือ off>");
        return 1;
    }

    if(!strcmp(trun, "on"))
    {
        if(HouseInfo[id][HouseSwicth])
            return 1;

        HouseInfo[id][HouseSwicth] = true;

        foreach(new i : Player)
        {
            if(!IsPlayerInHouse(i))
                continue;
                
            PlayerTextDrawHide(i, PlayerSwicthOff[playerid][0]);
        }

        if(HouseInfo[id][HouseEle] * 7 >=  10000)
        {
            GiveMoney(playerid, -HouseInfo[id][HouseEle] * 7 / 2);
            CharacterSave(playerid);
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "คุณไมได้จ่ายค่าไฟบ้าน เราจำเป็นต้องตัดเงินของคุณ $%s ซึ่งเป็นครึ่งนึงของบิลค่าไฟ",MoneyFormat(HouseInfo[id][HouseEle] * 7 / 2));
            HouseInfo[id][HouseEle] -= HouseInfo[id][HouseEle] / 2;
        }
        
        HouseInfo[id][HouseTimerEle] = SetTimerEx("HouseElectricitybill", 3600000, true, "i",id);//1800000
        format(str, sizeof(str), "เปิดสวิทซ์ไฟภายในบ้าน");
        callcmd::me(playerid,str);
        return 1;
    }
    else if(!strcmp(trun, "off"))
    {
        if(!HouseInfo[id][HouseSwicth])
            return 1;

        HouseInfo[id][HouseSwicth] = false;

        foreach(new i : Player)
        {
            if(!IsPlayerInHouse(i))
                continue;

            PlayerTextDrawShow(i, PlayerSwicthOff[playerid][0]);
        }

        for(new c = 1; c < MAX_COMPUTER; c++)
        {
            if(ComputerInfo[c][ComputerOwnerDBID] != HouseInfo[id][HouseOwnerDBID])
                continue;
            
            ComputerInfo[c][ComputerStartBTC] = false;
            ComputerInfo[id][ComputerOn] = false;
            KillTimer(ComputerInfo[id][ComputerTimer]);
        }

        KillTimer(HouseInfo[id][HouseTimerEle]);

        format(str, sizeof(str), "ปิดสวิทซ์ไฟภายในบ้าน");
        SendClientMessage(playerid, COLOR_YELLOWEX, "ไฟที่บ้านของคุณดับอยู่พิมพ์ /switch on เพื่อเปิด");
        callcmd::me(playerid,str);
        return 1;
    }
    return 1;
}

CMD:checkele(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideProperty], bill;

    if(!PlayerInfo[playerid][pInsideProperty])
        return SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} คุณไม่ได้อยู่ในบ้าน");

    if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID] && HouseInfo[id][HouseRent] != PlayerInfo[playerid][pDBID])
        return SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} บ้านหลังนี้ไม่ใช่บ้านของคุณ");

    bill = HouseInfo[id][HouseEle];

    if(bill == 0)
        return SendClientMessage(playerid, -1, "ไฟฟ้าของคุณยังไม่ถึงหน่วยที่กำหนด");
    
    SendClientMessageEx(playerid, -1, "[HOUSE BILL] ค่าไฟที่ใช้ไป %s หน่วย รวมเป็น $%s สามารถไปจ่ายค่าไฟได้ที่ City Hall",MoneyFormat(HouseInfo[id][HouseEle]), MoneyFormat(bill * 7));
    return 1;
}

CMD:placecom(playerid, params[])
{
    if(IsPlayerAndroid(playerid) == true)
        return SendErrorMessage(playerid, "ระบบนี้บนแพล็ตฟอร์มของคุณยังไม่รองรับ");
        
    new id = PlayerInfo[playerid][pInsideProperty];

    if(!PlayerInfo[playerid][pInsideProperty])
        return SendClientMessage(playerid,-1,"คุณไม่ได้อยู่ในบ้าน");

    if(PlayerEditObject[playerid])
        return SendErrorMessage(playerid, "คุณกำลังแก้ไข Object อยู่");

    if(sscanf(params, "d", id))
        return SendUsageMessage(playerid, "/placecom < ไอดีคอมพิวเตอร์ของคุณ >");

    if(!ComputerInfo[id][ComputerDBID])
        return SendErrorMessage(playerid,"ไม่มีคอมที่คุณเลือก");
    
    if(ComputerInfo[id][ComputerOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendErrorMessage(playerid, "คอมเครื่องนี้ไม่ใช่ของคุณ");

    if(ComputerInfo[id][ComputerSpawn])
        return SendErrorMessage(playerid, "คอมพิวเตอร์ได้ถูกวางอยู่แล้ว");
    
    EditObjectComputer(playerid, id);
    return 1;
}

CMD:editcom(playerid, params[])
{
    new id, option[32];

    if(IsPlayerAndroid(playerid) == true)
        return SendErrorMessage(playerid, "ระบบนี้บนแพล็ตฟอร์มของคุณยังไม่รองรับ");

    if(!PlayerInfo[playerid][pInsideProperty])
        return SendClientMessage(playerid,-1,"คุณไม่ได้อยู่ในบ้าน");

    /*if(ComputerInfo[id][ComputerOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendErrorMessage(playerid, "คอมเครื่องนี้ไม่ใช่ของคุณ");*/

    if(PlayerEditObject[playerid])
        return SendErrorMessage(playerid, "คุณกำลังแก้ไข Object อยู่");

    id = IsPlayerNearComputer(playerid);

    if(id == 0)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้คอม หรือ แล็ปท็อป");

    if(sscanf(params, "s[32]", option))
    {
        SendUsageMessage(playerid, "/editcom < option >");
        SendClientMessageEx(playerid, COLOR_GREY, "pos upgrade get");
        return 1;
    }  


    if(!strcmp(option, "pos"))
    {
        if(!ComputerInfo[id][ComputerDBID])
            return SendErrorMessage(playerid,"ไม่มีคอมที่คุณเลือก");

        if(!ComputerInfo[id][ComputerSpawn])
            return SendErrorMessage(playerid, "คอมพิวเตอร์ไม่ได้ถูกวาง");

        if(IsPlayerNearComputer(playerid) != id)
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้คอมพิวเตอร์ หรือ แล็ปท็อป");


        DestroyDynamicObject(ComputerInfo[id][ComputerObject]);

        EditObjectComputer(playerid, id);
        return 1;
    }
    else if(!strcmp(option, "upgrade"))
    {
        if(!ComputerInfo[id][ComputerDBID])
            return SendErrorMessage(playerid,"ไม่มีคอมที่คุณเลือก");

        if(!ComputerInfo[id][ComputerSpawn])
            return SendErrorMessage(playerid, "คอมพิวเตอร์ไม่ได้ถูกวาง");

        if(IsPlayerNearComputer(playerid) != id)
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้คอมพิวเตอร์ หรือ แล็ปท็อป");

        new str[255], longstr[255];
        format(str, sizeof(str), "CPU: %s\n", ReturnCPUNames(ComputerInfo[id][ComputerCPU]));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 1: %s\n", ReturnGPUNames(ComputerInfo[id][ComputerGPU][0]));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 2: %s\n", ReturnGPUNames(ComputerInfo[id][ComputerGPU][1]));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 3: %s\n", ReturnGPUNames(ComputerInfo[id][ComputerGPU][2]));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 4: %s\n", ReturnGPUNames(ComputerInfo[id][ComputerGPU][3]));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 5: %s\n", ReturnGPUNames(ComputerInfo[id][ComputerGPU][4]));
        strcat(longstr, str);
        format(str, sizeof(str), "RAM: %s \n", ReturnRams(ComputerInfo[id][ComputerRAM]));
        strcat(longstr, str);
        format(str, sizeof(str), "Stored: %s\n", ReturnStoreds(ComputerInfo[id][ComputerStored]));
        strcat(longstr, str);

        Dialog_Show(playerid, D_COMPUTER_UPGRAD_LIST, DIALOG_STYLE_LIST, "Upgrade computer:", longstr, "ยืนยัน", "ยกเลิก");
        return 1;
    }
    else if(!strcmp(option, "get"))
    {
        if(!ComputerInfo[id][ComputerDBID])
            return SendErrorMessage(playerid,"ไม่มีคอมที่คุณเลือก");
    
        if(ComputerInfo[id][ComputerOwnerDBID] != PlayerInfo[playerid][pDBID])
            return SendErrorMessage(playerid, "คอมเครื่องนี้ไม่ใช่ของคุณ");

        if(!ComputerInfo[id][ComputerSpawn])
            return SendErrorMessage(playerid, "คอมพิวเตอร์ไม่ได้ถูกวาง");

        if(IsPlayerNearComputer(playerid) != id)
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้คอมพิวเตอร์ หรือ แล็ปท็อป");

        DestroyDynamicObject(ComputerInfo[id][ComputerObject]);
        ComputerInfo[id][ComputerSpawn] = false;
    }
    else SendErrorMessage(playerid, "ใส่ให้ถูกต้อง");
    return 1;
}

CMD:checkbill(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 3.5, 1480.9369,-1769.4884,18.7958))
    {
        new str[255], longstr[255], idx[255], houseid;


        format(str, sizeof(str), "บ้าน\tค่าไฟ\n");
        strcat(longstr,str);

        for(new h = 1; h < MAX_HOUSE; h++)
        {
            if(!HouseInfo[h][HouseDBID])
                continue;
            
            if(HouseInfo[h][HouseOwnerDBID] != PlayerInfo[playerid][pDBID] && HouseInfo[h][HouseRent] != PlayerInfo[playerid][pDBID])
                continue;

            if(HouseInfo[h][HouseEle] <= 200)
                continue;
            
            format(idx, sizeof(idx), "%d",houseid);
            SetPVarInt(playerid, idx, h);
            houseid++;

            format(str, sizeof(str), "%d %s, Los Santos, San Andreas\t$%s",HouseInfo[h][HouseDBID], HouseInfo[h][HouseName], MoneyFormat(HouseInfo[h][HouseEle] * 7));
            strcat(longstr,str);
        }
        if(!houseid)
            return Dialog_Show(playerid, DIALOG_ELE_NONEBILL, DIALOG_STYLE_LIST, "ค่าไฟ", "ไม่มีค่าไฟทีต้องจ่าย", "ยืนยัน", "ยกเลิก");

        
        Dialog_Show(playerid, DIALOG_ELE_BILL, DIALOG_STYLE_TABLIST_HEADERS, "ค่าไฟ:", longstr, "ยืนยัน", "ยกเลิก");
    }
    else if(PlayerInfo[playerid][pInsideBusiness])
    {
        new id = PlayerInfo[playerid][pInsideBusiness];

        if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_STORE)
            return SendErrorMessage(playerid, "คุณไมได้อยู่ในร้าน 24/7");
        
        new str[255], longstr[255], idx[255], houseid;


        format(str, sizeof(str), "บ้าน\tค่าไฟ\n");
        strcat(longstr,str);

        for(new h = 1; h < MAX_HOUSE; h++)
        {
            if(!HouseInfo[h][HouseDBID])
                continue;
            
            if(HouseInfo[h][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
                continue;

            if(HouseInfo[h][HouseEle] <= 200)
                continue;
            
            format(idx, sizeof(idx), "%d",houseid);
            SetPVarInt(playerid, idx, h);
            houseid++;

            format(str, sizeof(str), "%d %s, Los Santos, San Andreas\t$%s",HouseInfo[h][HouseDBID], HouseInfo[h][HouseName], MoneyFormat(HouseInfo[h][HouseEle] * 7));
            strcat(longstr,str);
        }
        if(!houseid)
            return Dialog_Show(playerid, DIALOG_ELE_NONEBILL, DIALOG_STYLE_LIST, "ค่าไฟ", "ไม่มีค่าไฟทีต้องจ่าย", "ยืนยัน", "ยกเลิก");

        
        Dialog_Show(playerid, DIALOG_ELE_BILL, DIALOG_STYLE_TABLIST_HEADERS, "ค่าไฟ:", longstr, "ยืนยัน", "ยกเลิก");

    }
    else SendErrorMessage(playerid, "ตุณไมได้อยู่หน้า City Hall หรือใน 24/7");

    return 1;
}

CMD:checkbit(playerid, params[])
{
    SendClientMessageEx(playerid, -1, "BITSAMP: %.5f",PlayerInfo[playerid][pBTC]);    
    return 1;
}

CMD:givebit(playerid, params[])
{
    new number,tagetid, Float:bit;

    if(sscanf(params, "df",number, bit))
        return SendUsageMessage(playerid, "/givebit <เบอร์โทร> <จำนวน>");

    foreach(new i : Player)
    {
        if(PlayerInfo[i][pPhone] == number)
        {
            tagetid = i;
        }
    }

    if(!IsPlayerConnected(tagetid))
		return SendErrorMessage(playerid, "เบอร์ที่คุณต้องการโอนไม่ออนไลน์อยู่");

	if(!BitFlag_Get(gPlayerBitFlag[tagetid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 

    if(PlayerInfo[playerid][pBTC] < bit)
        return SendErrorMessage(playerid, "คุณมี BIT ไม่เพียงพอ");

    PlayerInfo[playerid][pBTC]-=bit;
    PlayerInfo[tagetid][pBTC]+=bit;
    SendClientMessageEx(playerid, COLOR_REPORT, "SMS: คุณได้โอน BITSAMP จำนวน %.5f ให้กับเบอร์ %d",bit, PlayerInfo[tagetid][pPhone]);
    return 1;
}

stock EditObjectComputer(playerid, id)
{
    new Float:x, Float:y, Float:z, worldid, interiorid;
    GetPlayerPos(playerid, x, y, z);
    worldid = GetPlayerVirtualWorld(playerid);
    interiorid = GetPlayerInterior(playerid);

    ComputerInfo[id][ComputerObject] =  CreateDynamicObject(19893, x, y, z, 0.0, 0.0, 0.0, worldid, interiorid, -1);
    EditDynamicObject(playerid, ComputerInfo[id][ComputerObject]);
    ComputerEdit[playerid] = id;
    PlayerEditObject[playerid] = true;
    return 1;
}

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{

    switch(response)
    {
        case EDIT_RESPONSE_FINAL:
        {

            if(ComputerEdit[playerid])
            {
                new id = ComputerEdit[playerid];
                new id_h = PlayerInfo[playerid][pInsideProperty];

                ComputerInfo[id][ComputerPos][0] = x;
                ComputerInfo[id][ComputerPos][1] = y;
                ComputerInfo[id][ComputerPos][2] = z;
                ComputerInfo[id][ComputerPos][3] = rx;
                ComputerInfo[id][ComputerPos][4] = ry;
                ComputerInfo[id][ComputerPos][5] = rz;
                ComputerInfo[id][ComputerPosWorld] = GetPlayerVirtualWorld(playerid);
                ComputerInfo[id][ComputerPosInterior] = GetPlayerInterior(playerid);
                ComputerInfo[id][ComputerSpawn] = true;
                ComputerInfo[id][ComputerHouseDBID] = id_h;
                ComputerEdit[playerid]  = 0;
                PlayerEditObject[playerid] = false;

                DestroyDynamicObject(ComputerInfo[id][ComputerObject]);
                
                ComputerInfo[id][ComputerObject] = CreateDynamicObject(19893, x, y, z, rx, ry, rz, ComputerInfo[id][ComputerPosWorld], ComputerInfo[id][ComputerPosInterior], -1);
                SaveComputer(id);
                return 1;
            }
        }
        case EDIT_RESPONSE_CANCEL:
        {

            if(ComputerEdit[playerid])
            {
                new id = ComputerEdit[playerid];

                if(ComputerInfo[id][ComputerSpawn])
                {
                    DestroyDynamicObject(objectid);
                    objectid = CreateDynamicObject(19893, ComputerInfo[id][ComputerPos][0], ComputerInfo[id][ComputerPos][1], ComputerInfo[id][ComputerPos][2], ComputerInfo[id][ComputerPos][3], ComputerInfo[id][ComputerPos][4], ComputerInfo[id][ComputerPos][5], ComputerInfo[id][ComputerPosWorld], ComputerInfo[id][ComputerPosInterior], -1);
                    ComputerEdit[playerid]  = 0;
                    PlayerEditObject[playerid] = false;
                    return 1;
                }

                DestroyDynamicObject(objectid);
                ComputerEdit[playerid]  = 0;
                PlayerEditObject[playerid] = false;
                return 1;
            }
        }
    }
    return 1;
}

Dialog:DIALOG_ELE_BILL(playerid, response, listitem, inputtext[])
{
    if(!response)
        SendServerMessage(playerid, "ยกเลิกการจ่ายค่าไฟ");

    new idx[255];
    format(idx, sizeof(idx), "%d",listitem);
    new id = GetPVarInt(playerid, idx);

    if(HouseInfo[id][HouseEle] * 7 > PlayerInfo[playerid][pCash])
        return SendErrorMessage(playerid, "คุณมียอดเงินไม่เพียงพอต่อการจ่าย");

    if(PlayerInfo[playerid][pInsideBusiness])
    {
        new id_b = PlayerInfo[playerid][pInsideBusiness];

        GiveMoney(playerid, -HouseInfo[id][HouseEle] * 7+15);
        SendClientMessageEx(playerid, COLOR_YELLOWEX, "คุณได้จ่ายค่าไฟบ้านของคุณเรียบร้อยแล้วด้วยจำนวนเงิน $%s",  MoneyFormat(HouseInfo[id][HouseEle] * 7+15));
        BusinessInfo[id_b][BusinessCash] += 15;
        GlobalInfo[G_GovCash]+= HouseInfo[id][HouseEle] * 7;
        HouseInfo[id][HouseEle] = 0;
        Savehouse(id);
        CharacterSave(playerid);
    }
    else
    {
        GiveMoney(playerid, -HouseInfo[id][HouseEle] * 7);
        SendClientMessageEx(playerid, COLOR_YELLOWEX, "คุณได้จ่ายค่าไฟบ้านของคุณเรียบร้อยแล้วด้วยจำนวนเงิน $%s",  MoneyFormat(HouseInfo[id][HouseEle] * 7));
        HouseInfo[id][HouseEle] = 0;
        GlobalInfo[G_GovCash]+= HouseInfo[id][HouseEle] * 7;
        Savehouse(id);
        CharacterSave(playerid);
    }
    return 1;
}

Dialog:D_COMPUTER_UPGRAD_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        ClearSelectBuyComputer(playerid);
        return 1;
    }

    if(!IsPlayerNearComputer(playerid))
    {
        ClearSelectBuyComputer(playerid);
        return 1;
    }

    new id = IsPlayerNearComputer(playerid), str[400], longstr[400];

    switch(listitem)
    {
        case 0: // CPU
        {
            format(str, sizeof(str), "CPU ที่คุณมี: %s\n",ReturnCPUNames(PlayerInfo[playerid][pCPU]));
            strcat(longstr, str);

            if(ComputerInfo[id][ComputerCPU])
            {
                format(str, sizeof(str), "[ ! ] ถอด CPU %s ออก\n",ReturnCPUNames(ComputerInfo[id][ComputerCPU]));
                strcat(longstr, str);
            }

            Dialog_Show(playerid, D_COM_UPGRAD_CPU, DIALOG_STYLE_LIST, "Upgrad CPU:", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 1: // GPU SLOTID 1
        {
            format(str, sizeof(str), "GPU ที่คุณมี: %s\n",ReturnGPUNames(PlayerInfo[playerid][pGPU]));
            strcat(longstr, str);

            if(ComputerInfo[id][ComputerGPU][0])
            {
                format(str, sizeof(str), "[ ! ] ถอด GPU %s ออก\n",ReturnGPUNames(ComputerInfo[id][ComputerGPU][0]));
                strcat(longstr, str);
            }
            
            PlayerSelectSlot[playerid] = 0;
            Dialog_Show(playerid, D_COM_UPGRAD_GPU, DIALOG_STYLE_LIST, "Upgrad GPU:", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 2: // GPU SLOTID 2
        {

            format(str, sizeof(str), "GPU ที่คุณมี: %s\n",ReturnGPUNames(PlayerInfo[playerid][pGPU]));
            strcat(longstr, str);

            if(ComputerInfo[id][ComputerGPU][1])
            {
                format(str, sizeof(str), "[ ! ] ถอด GPU %s ออก\n",ReturnGPUNames(ComputerInfo[id][ComputerGPU][1]));
                strcat(longstr, str);
            }
            
            PlayerSelectSlot[playerid] = 1;
            Dialog_Show(playerid, D_COM_UPGRAD_GPU, DIALOG_STYLE_LIST, "Upgrad GPU:", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 3: // GPU SLOTID 3
        {
            format(str, sizeof(str), "GPU ที่คุณมี: %s\n",ReturnGPUNames(PlayerInfo[playerid][pGPU]));
            strcat(longstr, str);

            if(ComputerInfo[id][ComputerGPU][2])
            {
                format(str, sizeof(str), "[ ! ] ถอด GPU %s ออก\n",ReturnGPUNames(ComputerInfo[id][ComputerGPU][2]));
                strcat(longstr, str);
            }
            
            PlayerSelectSlot[playerid] = 2;
            Dialog_Show(playerid, D_COM_UPGRAD_GPU, DIALOG_STYLE_LIST, "Upgrad GPU:", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 4: // GPU SLOTID 4
        {
            format(str, sizeof(str), "GPU ที่คุณมี: %s\n",ReturnGPUNames(PlayerInfo[playerid][pGPU]));
            strcat(longstr, str);

            if(ComputerInfo[id][ComputerGPU][3])
            {
                format(str, sizeof(str), "[ ! ] ถอด GPU %s ออก\n",ReturnGPUNames(ComputerInfo[id][ComputerGPU][3]));
                strcat(longstr, str);
            }
            
            PlayerSelectSlot[playerid] = 3;
            Dialog_Show(playerid, D_COM_UPGRAD_GPU, DIALOG_STYLE_LIST, "Upgrad GPU:", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 5: // GPU SLOTID 5
        {
            format(str, sizeof(str), "GPU ที่คุณมี: %s\n",ReturnGPUNames(PlayerInfo[playerid][pGPU]));
            strcat(longstr, str);

            if(ComputerInfo[id][ComputerGPU][4])
            {
                format(str, sizeof(str), "[ ! ] ถอด GPU %s ออก\n",ReturnGPUNames(ComputerInfo[id][ComputerGPU][4]));
                strcat(longstr, str);
            }
            
            PlayerSelectSlot[playerid] = 4;
            Dialog_Show(playerid, D_COM_UPGRAD_GPU, DIALOG_STYLE_LIST, "Upgrad GPU:", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 6: // RAM
        {
            format(str, sizeof(str), "RAM ที่คุณมี: %s\n",ReturnRams(PlayerInfo[playerid][pRAM]));
            strcat(longstr, str);

            if(ComputerInfo[id][ComputerRAM])
            {
                format(str, sizeof(str), "[ ! ] ถอด RAM %s ออก\n",ReturnRams(ComputerInfo[id][ComputerRAM]));
                strcat(longstr, str);
            }
        
            Dialog_Show(playerid, D_COM_UPGRAD_RAM, DIALOG_STYLE_LIST, "Upgrad RAM:", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 7: // STORED
        {
            format(str, sizeof(str), "SSD ที่คุณมี: %s\n",ReturnStoreds(PlayerInfo[playerid][pStored]));
            strcat(longstr, str);

            if(ComputerInfo[id][ComputerStored])
            {
                format(str, sizeof(str), "[ ! ] ถอด SSD %s ออก\n",ReturnStoreds(ComputerInfo[id][ComputerStored]));
                strcat(longstr, str);
            }
        
            Dialog_Show(playerid, D_COM_UPGRAD_STORED, DIALOG_STYLE_LIST, "Upgrad STORED:", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
    }
    return 1;
}

Dialog:D_COM_UPGRAD_CPU(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        ClearSelectBuyComputer(playerid);
        return 1;
    }

    if(!IsPlayerNearComputer(playerid))
    {
        ClearSelectBuyComputer(playerid);
        return 1;
    }

    new id = IsPlayerNearComputer(playerid);

    switch(listitem)
    {
        case 0:
        {
            if(!PlayerInfo[playerid][pCPU])
                return SendErrorMessage(playerid, "คุณไม่มี CPU อยู่ในตัว");

            
            if(ComputerInfo[id][ComputerCPU] == PlayerInfo[playerid][pCPU])
            {
                SendErrorMessage(playerid, "คุณไม่สามารถเปลี่ยน CPU ที่รุ่นเดิมได้");
                PlayerSelectSlot[playerid] = 0;
                CharacterSave(playerid);
                SaveComputer(id);
                return 1;
            }

            PlayerOldComp[playerid] = ComputerInfo[id][ComputerCPU];
            ComputerInfo[id][ComputerCPU] = PlayerInfo[playerid][pCPU];
            PlayerInfo[playerid][pCPU] = PlayerOldComp[playerid];
            SendClientMessageEx(playerid, -1, "คุณได้อัพเกรด CPU เป็น %s", ReturnCPUNames(ComputerInfo[id][ComputerCPU]));
            ClearSelectBuyComputer(playerid);
            CharacterSave(playerid);
            SaveComputer(id);
            return 1;
        }
        case 1:
        {
            if(!ComputerInfo[id][ComputerCPU])
                return SendErrorMessage(playerid, "คอมพิวเตอร์ หรือ แล็ปท็อปเครื่องนี้ ไม่มี CPU");

            if(PlayerInfo[playerid][pCPU])
                return SendErrorMessage(playerid, "คุณมี CPU อยู่ในตัว");
            
            SendClientMessageEx(playerid, -1, "คุณได้ถอด CPU  %s ออก", ReturnCPUNames(ComputerInfo[id][ComputerCPU]));
            PlayerInfo[playerid][pCPU] = ComputerInfo[id][ComputerCPU];
            ComputerInfo[id][ComputerCPU] = 0;
            CharacterSave(playerid);
            SaveComputer(id);
            return 1;
        }
    }


    return 1;
}


Dialog:D_COM_UPGRAD_GPU(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        ClearSelectBuyComputer(playerid);
        return 1;
    }

    if(!IsPlayerNearComputer(playerid))
    {
        ClearSelectBuyComputer(playerid);
        return 1;
    }

    new id = IsPlayerNearComputer(playerid), slotid = PlayerSelectSlot[playerid];

    switch(listitem)
    {
        case 0:
        {
            if(ComputerInfo[id][ComputerGPU][slotid] == PlayerInfo[playerid][pGPU])
            {
                SendErrorMessage(playerid, "คุณไม่สามารถเปลี่ยน GPU ที่รุ่นเดิมได้");
                PlayerSelectSlot[playerid] = 0;
                CharacterSave(playerid);
                SaveComputer(id);
                return 1;
            }

            PlayerOldComp[playerid] = ComputerInfo[id][ComputerGPU][slotid];
            ComputerInfo[id][ComputerGPU][slotid] = PlayerInfo[playerid][pGPU];
            PlayerInfo[playerid][pGPU] = PlayerOldComp[playerid];
            SendClientMessageEx(playerid, -1, "คุณได้อัพเกรด GPU Slot %d เป็น %s",  slotid,ReturnGPUNames(ComputerInfo[id][ComputerGPU][slotid]));
            PlayerSelectSlot[playerid] = 0;
            CharacterSave(playerid);
            SaveComputer(id);
            return 1;
        }
        case 1:
        {
            if(PlayerInfo[playerid][pCPU])
                return SendErrorMessage(playerid, "คุณมี GPU อยู่ในตัว");

            SendClientMessageEx(playerid, -1, "คุณได้ถอด GPU  %s ออก", ReturnGPUNames(ComputerInfo[id][ComputerGPU][slotid]));
            PlayerInfo[playerid][pGPU] = ComputerInfo[id][ComputerGPU][slotid];
            ComputerInfo[id][ComputerGPU][slotid] = 0;
            CharacterSave(playerid);
            SaveComputer(id);
            return 1;
        
        }
    }
    return 1;
}

Dialog:D_COM_UPGRAD_RAM(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        ClearSelectBuyComputer(playerid);
        return 1;
    }

    if(!IsPlayerNearComputer(playerid))
    {
        ClearSelectBuyComputer(playerid);
        return 1;
    }

    new id = IsPlayerNearComputer(playerid);

    switch(listitem)
    {
        case 0:
        {
            if(!PlayerInfo[playerid][pRAM])
                return SendErrorMessage(playerid, "คุณไม่มี RAM อยู่ในตัว");

            
            if(ComputerInfo[id][ComputerRAM] == PlayerInfo[playerid][pRAM])
            {
                SendErrorMessage(playerid, "คุณไม่สามารถเปลี่ยน RAM ที่รุ่นเดิมได้");
                CharacterSave(playerid);
                SaveComputer(id);
                return 1;
            }

            PlayerOldComp[playerid] = ComputerInfo[id][ComputerRAM];
            ComputerInfo[id][ComputerRAM] = PlayerInfo[playerid][pRAM];
            PlayerInfo[playerid][pRAM] = PlayerOldComp[playerid];
            SendClientMessageEx(playerid, -1, "คุณได้อัพเกรด RAM เป็น %s", ReturnRams(ComputerInfo[id][ComputerRAM]));
            ClearSelectBuyComputer(playerid);
            CharacterSave(playerid);
            SaveComputer(id);
            return 1;
        }
        case 1:
        {
            if(!ComputerInfo[id][ComputerRAM])
                return SendErrorMessage(playerid, "คอมพิวเตอร์ หรือ แล็ปท็อปเครื่องนี้ ไม่มี RAM");

            if(PlayerInfo[playerid][pRAM])
                return SendErrorMessage(playerid, "คุณมี RAM อยู่ในตัว");
            
            SendClientMessageEx(playerid, -1, "คุณได้ถอด RAM  %s ออก", ReturnRams(ComputerInfo[id][ComputerRAM]));
            PlayerInfo[playerid][pRAM] = ComputerInfo[id][ComputerRAM];
            ComputerInfo[id][ComputerRAM] = 0;
            CharacterSave(playerid);
            SaveComputer(id);
            return 1;
        }
    }


    return 1;
}

Dialog:D_COM_UPGRAD_STORED(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        ClearSelectBuyComputer(playerid);
        return 1;
    }

    if(!IsPlayerNearComputer(playerid))
    {
        ClearSelectBuyComputer(playerid);
        return 1;
    }

    new id = IsPlayerNearComputer(playerid);

    switch(listitem)
    {
        case 0:
        {
            if(!PlayerInfo[playerid][pStored])
                return SendErrorMessage(playerid, "คุณไม่มี SSD อยู่ในตัว");

            
            if(ComputerInfo[id][ComputerStored] == PlayerInfo[playerid][pStored])
            {
                SendErrorMessage(playerid, "คุณไม่สามารถเปลี่ยน SSD ที่รุ่นเดิมได้");
                CharacterSave(playerid);
                SaveComputer(id);
                return 1;
            }

            PlayerOldComp[playerid] = ComputerInfo[id][ComputerStored];
            ComputerInfo[id][ComputerStored] = PlayerInfo[playerid][pStored];
            PlayerInfo[playerid][pStored] = PlayerOldComp[playerid];
            SendClientMessageEx(playerid, -1, "คุณได้อัพเกรด SSD เป็น %s", ReturnStoreds(ComputerInfo[id][ComputerStored]));
            ClearSelectBuyComputer(playerid);
            CharacterSave(playerid);
            SaveComputer(id);
            return 1;
        }
        case 1:
        {
            if(!ComputerInfo[id][ComputerStored])
                return SendErrorMessage(playerid, "คอมพิวเตอร์ หรือ แล็ปท็อปเครื่องนี้ ไม่มี SSD");

            if(PlayerInfo[playerid][pStored])
                return SendErrorMessage(playerid, "คุณมี SSD อยู่ในตัว");
            
            SendClientMessageEx(playerid, -1, "คุณได้ถอด SSD %s ออก", ReturnStoreds(ComputerInfo[id][ComputerStored]));
            PlayerInfo[playerid][pStored] = ComputerInfo[id][ComputerStored];
            ComputerInfo[id][ComputerStored] = 0;
            CharacterSave(playerid);
            SaveComputer(id);
            return 1;
        }
    }
    return 1;
}


alias:givehousekey("ให้กุญแจบ้าน")
CMD:givehousekey(playerid, params[])
{
    if(!IsPlayerInHouse(playerid))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ภายในบ้าน");

    new id = PlayerInfo[playerid][pInsideProperty];

    if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendErrorMessage(playerid, "คุณไม่ได้เป็นเจ้าของบ้านหลังนี้");

    new tagetid;
    
    if(sscanf(params, "u", tagetid))
        return SendUsageMessage(playerid, "/givehousekey <ชื่อบางส่วน/ไอดี>");

    if(playerid == tagetid)
        return SendErrorMessage(playerid, "ไม่สามารถให้กุญแจบ้านสำรองกับตัวเองได้");
    
    if(!IsPlayerConnected(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[tagetid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

    if(!IsPlayerNearPlayer(playerid, tagetid, 2.0))
        return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");

    if(PlayerInfo[tagetid][pHouseKey] == id)
    {
        PlayerInfo[tagetid][pHouseKey] = 0;
        SendServerMessage(playerid, "คุณได้ยึดกุญแจบ้านของ %s เรียบร้อยแล้ว", ReturnName(tagetid));
        SendServerMessage(tagetid, "คุณได้ถูกยึดกุญแจบ้านโดย %s", ReturnName(playerid));

        CharacterSave(tagetid);
        CharacterSave(playerid);
        return 1;
    }
    else 
    {
        PlayerInfo[tagetid][pHouseKey] = id;
        SendServerMessage(playerid, "คุณได้ให้คุณแจบ้านสำรองกับ %s แล้ว เสียเงิน ($500)", ReturnName(tagetid));
        SendServerMessage(tagetid, "คุณได้รับกุญแจสำรองของบ้าน %d  จาก %s แล้ว", ReturnName(playerid));

        CharacterSave(tagetid);
        CharacterSave(playerid);
    }
    return 1;
}


CMD:bareswitch(playerid, params[])
{
    if(!IsPlayerInHouse(playerid))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ภายในบ้าน");

    new id = PlayerInfo[playerid][pInsideProperty];
    
    if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID] && PlayerInfo[playerid][pHouseKey] != id)
        return SendErrorMessage(playerid, "คุณไม่ได้เป็นเจ้าของบ้านหลังนี้");

    new Float:x, Float:y, Float:z;

    if(HouseInfo[id][HouseStatus])
    {
        HouseInfo[id][HouseStatus]=0;
	    SendClientMessage(playerid, COLOR_WHITE, "คุณปิดโหมด Bareswitch");
	    //HouseInfo[id][HouseInterior][2]+=100.0;

        foreach(new i : Player)
		{
			if(PlayerInfo[i][pInsideProperty] == id)
     		{
				GetPlayerPos(i, x, y, z);
				//SetPlayerPos(i, x, y, z+100.5);
            }
        }
    
    }
    else
    {
        HouseInfo[id][HouseStatus]=1;
	    SendClientMessage(playerid, COLOR_WHITE, "คุณได้เปิดโหมด Bareswitch");
		//HouseInfo[id][HouseInterior][2]-=100.0;

        foreach(new i : Player)
		{
			if(PlayerInfo[i][pInsideProperty] == id)
     		{
				GetPlayerPos(i, x, y, z);
				//SetPlayerPos(i, x, y, z+100.5);
            }
        }
    }

    DestroyDynamicArea(HouseInfo[id][HouseAreaID]);
	HouseInfo[id][HouseAreaID] = CreateDynamicSphere(HouseInfo[id][HouseInterior][0], HouseInfo[id][HouseInterior][1], HouseInfo[id][HouseInterior][2], 3.0, HouseInfo[id][HouseInteriorWorld], HouseInfo[id][HouseInteriorID]); // The house interior.	
	Streamer_SetIntData(STREAMER_TYPE_AREA, HouseInfo[id][HouseAreaID], E_STREAMER_EXTRA_ID, id);
    Savehouse(id);
    return 1;
}