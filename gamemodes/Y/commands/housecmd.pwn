CMD:housecmds(playerid, params[])
{
    SendClientMessage(playerid, COLOR_DARKGREEN, "____________________HOUSE COMMAND__________________________");

    SendClientMessage(playerid, COLOR_GRAD2,"[HOUSE] /house /buyhouse /sellhouse /lock /placepos /swicth");

    SendClientMessage(playerid, COLOR_GREEN,"________________________________________________________________");
    SendClientMessage(playerid, COLOR_GRAD1,"�ô�֡�Ҥ���������������������㹿��������� /helpme ���ͤ͢������������");
    return 1;
}

CMD:house(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideProperty];

    if(id == 0)
        return SendErrorMessage(playerid, "�س���������㹺�ҹ�ͧ�س");

    if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendErrorMessage(playerid, "�س���������㹺�ҹ�ͧ�س");

    new str[MAX_STRING], longstr[MAX_STRING];

    format(longstr, sizeof(longstr), "��ҹ�Ţ���: %s\n",HouseInfo[id][HouseName]);
    strcat(str, longstr);
    format(longstr, sizeof(longstr), "�ҤҺ�ҹ: %s\n",MoneyFormat(HouseInfo[id][HousePrice]));
    strcat(str, longstr);

    Dialog_Show(playerid, DIALOG_MYHOUSE, DIALOG_STYLE_MSGBOX, "HOUSE:", str, ">>", "");
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

CMD:placepos(playerid,params[])
{
    new id = PlayerInfo[playerid][pInsideProperty];

    if(!PlayerInfo[playerid][pInsideProperty])
        return SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} �س���������㹺�ҹ");

    if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} ��ҹ��ѧ���������ҹ�ͧ�س");

    GetPlayerPos(playerid, HouseInfo[id][HousePlacePos][0], HouseInfo[id][HousePlacePos][1], HouseInfo[id][HousePlacePos][2]);


    SendClientMessage(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF} �س���ҧ�ش���૿���ç���˹觵ç�������");
    Savehouse(id);
    return 1;
}

CMD:ds(playerid, params[])
{
    if(!PlayerInfo[playerid][pInsideProperty] && !IsPlayerNearHouse(playerid))
        return SendErrorMessage(playerid, "�س���������˹��/� ��ҹ");

    if(isnull(params))
	    return SendClientMessage(playerid, COLOR_GRAD2, "/ds [��ͤ���]");
    
    new str[128];
	if (strlen(params) > 80) {
	    format(str, sizeof(str), "%s ��⡹: %.80s", ReturnRealName(playerid, 0), params);
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
        format(str, sizeof(str), "%s ��⡹: %s!", ReturnRealName(playerid, 0), params), ProxDetector(playerid, 30.0, str);

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
        return SendErrorMessage(playerid, "�س���������˹��/� ��ҹ");

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


CMD:swicth(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideProperty], str[32];

    if(id == 0)
        return SendErrorMessage(playerid, "��س��������㹺�ҹ��͹");

    new trun[10];

    if(sscanf(params, "s[10]",trun))
    {
        SendClientMessage(playerid, -1, "on = �Դ����㹺�ҹ");
        SendClientMessage(playerid, -1, "off = �Դ����㹺�ҹ");
        SendUsageMessage(playerid, "/swicth <on ���� off>");
        return 1;
    }

    if(!strcmp(trun, "on"))
    {
        if(HouseInfo[id][HouseSwicth])
            return 1;

        HouseInfo[id][HouseSwicth] = true;
        SetHouseOffSwitch(playerid, id);

        format(str, sizeof(str), "�Դ��Է������㹺�ҹ");
        callcmd::me(playerid,str);
        return 1;
    }
    else if(!strcmp(trun, "off"))
    {
        if(!HouseInfo[id][HouseSwicth])
            return 1;

        HouseInfo[id][HouseSwicth] = false;
        SetHouseOffSwitch(playerid, id);

        format(str, sizeof(str), "�Դ��Է������㹺�ҹ");
        callcmd::me(playerid,str);
        return 1;
    }
    return 1;
}

CMD:checkele(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideProperty], bill;

    if(!PlayerInfo[playerid][pInsideProperty])
        return SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} �س���������㹺�ҹ");

    if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendClientMessage(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} ��ҹ��ѧ���������ҹ�ͧ�س");

    bill = HouseInfo[id][HouseEle];

    if(bill == 0)
        return SendClientMessage(playerid, -1, "俿�Ңͧ�س�ѧ���֧˹��·���˹�");
    
    SendClientMessageEx(playerid, -1, "[HOUSE BILL] ���俷����� %s ˹��� ����� $%s ����ö仨��¤������� City Hall",MoneyFormat(HouseInfo[id][HouseEle]), MoneyFormat(bill * 7));
    return 1;
}