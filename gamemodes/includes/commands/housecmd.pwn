CMD:housecmds(playerid, params[])
{
    SendClientMessage(playerid, COLOR_DARKGREEN, "____________________HOUSE COMMAND__________________________");

    SendClientMessage(playerid, COLOR_GRAD2,"[HOUSE] /buyhouse /sellhouse /lock /placepos");

    SendClientMessage(playerid, COLOR_GREEN,"________________________________________________________________");
    SendClientMessage(playerid, COLOR_GRAD1,"โปรดศึกษาคำสั่งในเซิร์ฟเวอร์เพิ่มเติมในฟอรั่มหรือ /helpme เพื่อขอความช่วยเหลือ");
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
			if(GetPlayerInterior(playerid) != HouseInfo[p][HouseEntranceWorld])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[p][HouseEntranceInterior])
				continue;

            if(CountPlayerProperties(playerid) > 3)
			    return SendErrorMessage(playerid, "คุณสามารถเป็นเจ้าของบ้านได้เพียงแค่ 3 หลังเท่านั้น");


            if(HouseInfo[p][HouseOwnerDBID])
                return SendClientMessage(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF} บ้านหลังนี้มีเจ้าของอยู่แล้ว");

            if(GetPlayerMoney(playerid) < HouseInfo[p][HousePrice] || PlayerInfo[playerid][pLevel] < HouseInfo[p][HouseLevel])
                return SendClientMessage(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF} คุณมีเงินหรือ เลเวล ไม่เพียงพอต่อการซื้อบ้าน");

            HouseInfo[p][HouseOwnerDBID] = PlayerInfo[playerid][pDBID];
            GivePlayerMoney(playerid, -HouseInfo[p][HousePrice]);
            SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{66FF99}คุณได้ซื้อบ้านสำเร็จแล้ว");
            HouseInfo[p][HouseLock] = false;

            if(IsValidDynamicPickup(HouseInfo[p][HousePickup]))
                DestroyDynamicPickup(HouseInfo[p][HousePickup]);
            
            Savehouse(p);

            HouseInfo[p][HousePickup] = CreateDynamicPickup(1272, 23, HouseInfo[p][HouseEntrance][0], HouseInfo[p][HouseEntrance][1], HouseInfo[p][HouseEntrance][2],-1,-1);
            return 1;
        }
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
