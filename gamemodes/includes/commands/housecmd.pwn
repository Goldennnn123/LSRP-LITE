CMD:housecmds(playerid, params[])
{
    SendClientMessage(playerid, COLOR_DARKGREEN, "______________________________________________");

    SendClientMessage(playerid, COLOR_GRAD2,"/buyhouse /sellhouse /lock /placepos");
    SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
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