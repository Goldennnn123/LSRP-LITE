CMD:housecmds(playerid, params[])
{
    SendClientMessage(playerid, COLOR_DARKGREEN, "______________________________________________");

    SendClientMessage(playerid, COLOR_GRAD2,"/buyhouse /sellhouse /lock /placepos");
    SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
    SendClientMessage(playerid, COLOR_GRAD1,"�ô�֡�Ҥ���������������������㹿��������� /helpme ���ͤ͢������������");
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
			    return SendErrorMessage(playerid, "�س����ö����Ңͧ��ҹ����§�� 3 ��ѧ��ҹ��");


            if(HouseInfo[p][HouseOwnerDBID])
                return SendClientMessage(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF} ��ҹ��ѧ�������Ңͧ��������");

            if(GetPlayerMoney(playerid) < HouseInfo[p][HousePrice] || PlayerInfo[playerid][pLevel] < HouseInfo[p][HouseLevel])
                return SendClientMessage(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF} �س���Թ���� ����� �����§�͵�͡�ë��ͺ�ҹ");

            HouseInfo[p][HouseOwnerDBID] = PlayerInfo[playerid][pDBID];
            GivePlayerMoney(playerid, -HouseInfo[p][HousePrice]);
            SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{66FF99}�س����ͺ�ҹ���������");
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
        return SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} �س���������㹺�ҹ");

    if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} ��ҹ��ѧ���������ҹ�ͧ�س");
    
    Dialog_Show(playerid, DIALOG_SELL_HOUSE, DIALOG_STYLE_MSGBOX, "�س���?", "�س�����������Т�º�ҹ��ѧ���\n\
                                                                               �س�����Թ�׹����觢ͧ�ҤҺ�ҹ����˴\n\
                                                                               �ô�Դ���ա�͹���С����� �׹�ѹ", "�׹�ѹ", "¡��ԡ");

    return 1;
}