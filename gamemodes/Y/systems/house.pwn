#include <YSI_Coding\y_hooks>
new PlayerCreHouse[MAX_PLAYERS][90],
    PlayerCreHousePrice[MAX_PLAYERS],
    PlayerCreHouseLevel[MAX_PLAYERS];

new PlayerSelectHouse[MAX_PLAYERS];
new OnPlayerNereHouse[MAX_PLAYERS][MAX_HOUSE];


new PlayerText:PlayerSwicthOff[MAX_PLAYERS][1];


hook OnPlayerConnect(playerid)
{
    PlayerCreHouse[playerid] = "";
    PlayerCreHousePrice[playerid] = 0;
    PlayerCreHouseLevel[playerid] = 0;

    PlayerSwicthOff[playerid][0] = CreatePlayerTextDraw(playerid, 316.000000, 2.000000, "_");
	PlayerTextDrawFont(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, PlayerSwicthOff[playerid][0], 0.600000, 48.999988);
	PlayerTextDrawTextSize(playerid, PlayerSwicthOff[playerid][0], 1920.500000, 1080.500000);
	PlayerTextDrawSetOutline(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PlayerSwicthOff[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, PlayerSwicthOff[playerid][0], 2);
	PlayerTextDrawColor(playerid, PlayerSwicthOff[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerSwicthOff[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, PlayerSwicthOff[playerid][0], 225);
	PlayerTextDrawUseBox(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerSwicthOff[playerid][0], 0);
    return 1;
}


forward Query_LoadHouse();
public Query_LoadHouse()
{
    if(!cache_num_rows())
		return printf("[SERVER]: No House were loaded from \"%s\" database...", MYSQL_DB);

    new rows,countHouse,str[MAX_STRING]; cache_get_row_count(rows);

    for (new i = 0; i < rows && i < MAX_HOUSE; i ++)
    {
        cache_get_value_name_int(i,"HouseDBID",HouseInfo[i+1][HouseDBID]);
        cache_get_value_name(i,"HouseName",HouseInfo[i+1][HouseName],90);
        cache_get_value_name_int(i,"HouseOwnerDBID",HouseInfo[i+1][HouseOwnerDBID]);


        cache_get_value_name_float(i,"HouseEntranceX",HouseInfo[i+1][HouseEntrance][0]);
        cache_get_value_name_float(i,"HouseEntranceY",HouseInfo[i+1][HouseEntrance][1]);
        cache_get_value_name_float(i,"HouseEntranceZ",HouseInfo[i+1][HouseEntrance][2]);
        cache_get_value_name_int(i,"HouseEntranceWorld",HouseInfo[i+1][HouseEntranceWorld]);
        cache_get_value_name_int(i,"HouseEntranceInterior",HouseInfo[i+1][HouseEntranceInterior]);

        cache_get_value_name_float(i,"HouseInteriorX",HouseInfo[i+1][HouseInterior][0]);
        cache_get_value_name_float(i,"HouseInteriorY",HouseInfo[i+1][HouseInterior][1]);
        cache_get_value_name_float(i,"HouseInteriorZ",HouseInfo[i+1][HouseInterior][2]);
        cache_get_value_name_int(i,"HouseInteriorWorld",HouseInfo[i+1][HouseInteriorWorld]);
        cache_get_value_name_int(i,"HouseInteriorID",HouseInfo[i+1][HouseInteriorID]);

        cache_get_value_name_int(i,"HousePrice",HouseInfo[i+1][HousePrice]);
        cache_get_value_name_int(i,"HouseLevel",HouseInfo[i+1][HouseLevel]);
        cache_get_value_name_int(i,"HouseLock",HouseInfo[i+1][HouseLock]);

        cache_get_value_name_int(i,"HouseStockCPU",HouseInfo[i+1][HouseStockCPU]);
        cache_get_value_name_int(i,"HouseStockGPU",HouseInfo[i+1][HouseStockGPU]);
        cache_get_value_name_int(i,"HouseStockRAM",HouseInfo[i+1][HouseStockRAM]);
        cache_get_value_name_int(i,"HouseStockStored",HouseInfo[i+1][HouseStockStored]);

        cache_get_value_name_int(i,"HousePrice",HouseInfo[i+1][HousePrice]);
        cache_get_value_name_int(i,"HouseLevel",HouseInfo[i+1][HouseLevel]);
        cache_get_value_name_int(i,"HouseLock",HouseInfo[i+1][HouseLock]);


        cache_get_value_name_int(i,"HouseEle",HouseInfo[i+1][HouseEle]);
        for(new w = 1; w < 22; w++)
        {
            format(str, sizeof(str), "HouseWeapons%i",w);
            cache_get_value_name_int(i,str,HouseInfo[i+1][HouseWeapons][w]);
        }
        for(new wa = 1; wa < 22; wa++)
        {
            format(str, sizeof(str), "HouseWeaponsAmmo%i",wa);
            cache_get_value_name_int(i,str,HouseInfo[i+1][HouseWeaponsAmmo][wa]);
        }

        if(IsValidDynamicPickup(HouseInfo[i+1][HousePickup]))
            DestroyDynamicPickup(HouseInfo[i+1][HousePickup]);
        
        /*if(HouseInfo[i+1][HouseOwnerDBID])
        {
            HouseInfo[i+1][HousePickup] = CreateDynamicPickup(1272, 23, HouseInfo[i+1][HouseEntrance][0], HouseInfo[i+1][HouseEntrance][1], HouseInfo[i+1][HouseEntrance][2],-1,-1);
        }
        else
        {
            HouseInfo[i+1][HousePickup] = CreateDynamicPickup(1273, 23, HouseInfo[i+1][HouseEntrance][0], HouseInfo[i+1][HouseEntrance][1], HouseInfo[i+1][HouseEntrance][2],-1,-1);
        }*/
        countHouse++;

        HouseInfo[i+1][HouseSwicth] = false;
        
    }

	printf("[SERVER]: %i House were loaded from \"%s\" database...", countHouse, MYSQL_DB);
    return 1;
}


Dialog:DIALOG_CRE_HOUSE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return SendClientMessage(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} ¡��ԡ������ҧ��ҹ");

    else
    {  
        new idx = 0;
	
        for (new i = 1; i < MAX_HOUSE; i ++)
        {
            if(!HouseInfo[i][HouseDBID])
            {
                idx = i; 
                break;
            }
        }
        if(idx == 0)
        {
            return SendServerMessage(playerid, "���Һ��ҹ�Թ���ҹ����������� (30)"); 
        }
        new Float:X,Float:Y,Float:Z, InsertHouse[MAX_STRING],str[MAX_STRING];
        GetPlayerPos(playerid, X, Y, Z);

        new Price = PlayerCreHousePrice[playerid];
        new Level = PlayerCreHouseLevel[playerid];

        mysql_format(dbCon, InsertHouse, sizeof(InsertHouse), "INSERT INTO house (`HouseName`,`HouseEntranceX`,`HouseEntranceY`,`HouseEntranceZ`,`HouseEntranceWorld`,`HouseEntranceInterior`,`HousePrice`,`HouseLevel`) VALUES('%e',%f,%f,%f,%i,%i,%i,%i)",PlayerCreHouse[playerid],X,Y,Z,GetPlayerVirtualWorld(playerid),GetPlayerInterior(playerid),Price,Level); 
	    mysql_tquery(dbCon, InsertHouse);

        HouseInfo[idx][HouseDBID] = idx;
        HouseInfo[idx][HouseName] = PlayerCreHouse[playerid];
        HouseInfo[idx][HouseEntrance][0] = X;
        HouseInfo[idx][HouseEntrance][1] = Y;
        HouseInfo[idx][HouseEntrance][2] = Z;
        HouseInfo[idx][HouseEntranceWorld] = GetPlayerVirtualWorld(playerid);
        HouseInfo[idx][HouseEntranceInterior] = GetPlayerInterior(playerid);

        HouseInfo[idx][HousePrice] = Price;
        HouseInfo[idx][HouseLevel] = Level;

        HouseInfo[idx][HousePickup] = CreateDynamicPickup(1273, 23, HouseInfo[idx][HouseEntrance][0], HouseInfo[idx][HouseEntrance][1], HouseInfo[idx][HouseEntrance][2],-1,-1);
        SendClientMessageEx(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF} �س�����ҧ��ҹ ID {66FFFF}%i {FFFFFF}����",HouseInfo[idx][HouseDBID]);

        format(str, sizeof(str), "{27AE60}HOUSE {F39C12}SYSTEM:{FFA000} %s {FFFFFF}�����ҧ��ҹ ID {66FFFF}%i {FFFFFF}����",ReturnRealName(playerid),HouseInfo[idx][HouseDBID]);
		SendAdminMessage(2, str);
    }
    return 1;
}


stock ShowSelectHouse(playerid)
{
    new str[MAX_STRING];

    new id = PlayerSelectHouse[playerid];

    new HouseNames[96];

    format(HouseNames, sizeof(HouseNames), "HOUSE: %s",HouseInfo[id][HouseName]);

    format(str, sizeof(str), "�ʹպ�ҹ: %i\n\
                              ���ͺ�ҹ:  %s\n\
                              �Ҥ�:    %s\n\
                              �����:   %i\n\
                              �ش˹�Һ�ҹ\n\
                              �ش����\n",HouseInfo[id][HouseDBID],HouseInfo[id][HouseName],MoneyFormat(HouseInfo[id][HousePrice]),HouseInfo[id][HouseLevel]);

    Dialog_Show(playerid, DIALOG_SELETE_HOUSE, DIALOG_STYLE_LIST, HouseNames, str, "�Թ�ѹ", "¡��ԡ",HouseInfo[id][HouseName]);

    return 1;
}

Dialog:DIALOG_VIEWHOUSE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return SendClientMessage(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} ¡��ԡ������ҧ��ҹ");
    
    new str_h[MAX_STRING], str[MAX_STRING];
    format(str_h, sizeof(str_h), "%d",listitem);

    new id = GetPVarInt(playerid, str_h);
    PlayerSelectHouse[playerid] = id;


    if(!HouseInfo[id][HouseDBID] || id > MAX_HOUSE)
        return 1;

    new HouseNames[96];
    format(HouseNames, sizeof(HouseNames), "HOUSE: %s",HouseInfo[id][HouseName]);

    format(str, sizeof(str), "�ʹպ�ҹ: %i\n\
                              ���ͺ�ҹ:  %s\n\
                              �Ҥ�:    %s\n\
                              �����:   %i\n\
                              �ش˹�Һ�ҹ\n\
                              �ش����\n",HouseInfo[id][HouseDBID],HouseInfo[id][HouseName],MoneyFormat(HouseInfo[id][HousePrice]),HouseInfo[id][HouseLevel]);

    Dialog_Show(playerid, DIALOG_SELETE_HOUSE, DIALOG_STYLE_LIST, HouseNames, str, "�Թ�ѹ", "¡��ԡ",HouseInfo[id][HouseName]);
    return 1;
}

Dialog:DIALOG_SELETE_HOUSE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    else
    {
        switch(listitem)
        {
            case 0: return ShowSelectHouse(playerid);
            case 1:
            {
                return Dialog_Show(playerid, DIALOG_HOUSE_NAME, DIALOG_STYLE_INPUT, "����������ͧ��ҹ", "����¹���ͺ�ҹ��ѧ���:", "�׹�ѹ", "¡��ԡ");
            }
            case 2:
            {
                return Dialog_Show(playerid, DIALOG_HOUSE_PRICE, DIALOG_STYLE_INPUT, "����Ҥ�����ͧ��ҹ", "�����¹�ҤҢͧ��ҹ��ѧ���:", "�׹�ѹ", "¡��ԡ");
            }
            case 3:
            {
                return Dialog_Show(playerid, DIALOG_HOUSE_LEVEL, DIALOG_STYLE_INPUT, "������������ͧ��ҹ", "�����¹����Ţͧ��ҹ��ѧ���:", "�׹�ѹ", "¡��ԡ");
            }
            case 4:
            {
                new id = PlayerSelectHouse[playerid],Float:X,Float:Y,Float:Z;
                GetPlayerPos(playerid,X,Y,Z);

                HouseInfo[id][HouseEntrance][0] = X;
                HouseInfo[id][HouseEntrance][1] = Y;
                HouseInfo[id][HouseEntrance][2] = Z;
                HouseInfo[id][HouseEntranceWorld] = GetPlayerVirtualWorld(playerid);
                HouseInfo[id][HouseEntranceInterior] = GetPlayerInterior(playerid);

                Savehouse(id);


                if(IsValidDynamicPickup(HouseInfo[id][HousePickup]))
                    DestroyDynamicPickup(HouseInfo[id][HousePickup]);
        
                /*if(HouseInfo[id][HouseOwnerDBID])
                {
                    HouseInfo[id][HousePickup] = CreateDynamicPickup(1272, 23, HouseInfo[id][HouseEntrance][0], HouseInfo[id][HouseEntrance][1], HouseInfo[id][HouseEntrance][2],-1,-1);
                }
                else
                {
                    HouseInfo[id][HousePickup] = CreateDynamicPickup(1273, 23, HouseInfo[id][HouseEntrance][0], HouseInfo[id][HouseEntrance][1], HouseInfo[id][HouseEntrance][2],-1,-1);
                }*/
            }
            case 5:
            {
                new id = PlayerSelectHouse[playerid],Float:X,Float:Y,Float:Z;
                GetPlayerPos(playerid,X,Y,Z);

                HouseInfo[id][HouseInterior][0] = X;
                HouseInfo[id][HouseInterior][1] = Y;
                HouseInfo[id][HouseInterior][2] = Z;
                
                HouseInfo[id][HouseInteriorID] = GetPlayerInterior(playerid);

                if(GetPlayerVirtualWorld(playerid) != 0)
                {
                    HouseInfo[id][HouseInteriorWorld] = GetPlayerVirtualWorld(playerid);
                }
                else
                {
                    HouseInfo[id][HouseInteriorWorld] = random(9000);
                }


                foreach(new i : Player)
                {
                    if(PlayerInfo[i][pInsideProperty] != id)
                        continue;

                    SetPlayerPos(i,HouseInfo[id][HouseInterior][0],HouseInfo[id][HouseInterior][1],HouseInfo[id][HouseInterior][2]);
                    SetPlayerVirtualWorld(playerid, HouseInfo[id][HouseInteriorWorld]);
                    SetPlayerInterior(playerid, HouseInfo[id][HouseInteriorID]);
                    SendServerMessage(i,"������㹤������ʴǡ���ͧ�ҡ�ա������¹�ŧ ����(Interior) ���ҧ��зѹ�ѹ�֧���繷���ͧ����͹���µ���Ф÷���ҹ�������  � ��й��价�� Interior");
                    SendServerMessage(i,"....����");
                }
                Savehouse(id);
            }
        }
    }
    return ShowSelectHouse(playerid);
}

Dialog:DIALOG_HOUSE_NAME(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowSelectHouse(playerid);
    
    else
    {
        if(strlen(inputtext) > 90 || strlen(inputtext) < 3)
        {   
            SendClientMessage(playerid,COLOR_RED,"���������١��ͧ");
            return ShowSelectHouse(playerid);
        }

        
        new id = PlayerSelectHouse[playerid];

        format(HouseInfo[id][HouseName], 90, "%s", inputtext);
        Savehouse(id);
    }
    return ShowSelectHouse(playerid);
}

Dialog:DIALOG_HOUSE_PRICE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    else
    {
        if(strlen(inputtext) > 90000000 || strlen(inputtext) < 1)
        {   
            SendClientMessage(playerid,COLOR_RED,"����Ţ���١��ͧ");
            return ShowSelectHouse(playerid);
        }

        new price = strval(inputtext);

        if(price < 1 || price > 90000000)
        {   
            SendClientMessage(playerid,COLOR_RED,"����Ţ���١��ͧ");
            return ShowSelectHouse(playerid);
        }

        new id = PlayerSelectHouse[playerid];

        HouseInfo[id][HousePrice] = price;
        Savehouse(id);
    }
    return ShowSelectHouse(playerid);
}

Dialog:DIALOG_HOUSE_LEVEL(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    else
    {
        if(strlen(inputtext) > 90000000 || strlen(inputtext) < 1)
        {   
            SendClientMessage(playerid,COLOR_RED,"����Ţ���١��ͧ");
            return ShowSelectHouse(playerid);
        }

        new Level = strval(inputtext);

        if(Level < 1 || Level > 90000000)
        {   
            SendClientMessage(playerid,COLOR_RED,"����Ţ���١��ͧ");
            return ShowSelectHouse(playerid);
        }

        new id = PlayerSelectHouse[playerid];

        HouseInfo[id][HouseLevel] = Level;
        Savehouse(id);
    }
    return ShowSelectHouse(playerid);
}


forward OnPlayerEnterProperty(playerid,id);
public OnPlayerEnterProperty(playerid,id)
{
	SetPlayerPos(playerid, HouseInfo[id][HouseInterior][0], HouseInfo[id][HouseInterior][1], HouseInfo[id][HouseInterior][2]);
    
    SetHouseOffSwitch(playerid);
    if(!HouseInfo[id][HouseSwicth])
    {
        PlayerTextDrawShow(playerid, PlayerSwicthOff[playerid][0]);
    }
    else
    {
        PlayerTextDrawDestroy(playerid, PlayerSwicthOff[playerid][0]);
    }
    
    return TogglePlayerControllable(playerid, 1);
}

stock SetHouseOffSwitch(playerid)
{
    PlayerSwicthOff[playerid][0] = CreatePlayerTextDraw(playerid, 316.000000, 2.000000, "_");
	PlayerTextDrawFont(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, PlayerSwicthOff[playerid][0], 0.600000, 48.999988);
	PlayerTextDrawTextSize(playerid, PlayerSwicthOff[playerid][0], 1920.500000, 1080.500000);
	PlayerTextDrawSetOutline(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PlayerSwicthOff[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, PlayerSwicthOff[playerid][0], 2);
	PlayerTextDrawColor(playerid, PlayerSwicthOff[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerSwicthOff[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, PlayerSwicthOff[playerid][0], 225);
	PlayerTextDrawUseBox(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerSwicthOff[playerid][0], 0);
    return 1;
}


forward HouseElectricitybill(id);
public HouseElectricitybill(id)
{
    new ele, idx, result;

    if(!HouseInfo[id][HouseSwicth])
        return 1;

    if(!HouseInfo[id][HouseOwnerDBID])
        return 1;

    for(new c = 1; c < sizeof(ComputerInfo); c++)
    {
        if(!ComputerInfo[c][ComputerDBID])
            continue;

        if(ComputerInfo[c][ComputerHouseDBID] != HouseInfo[id][HouseDBID])
            continue;

        if(ComputerInfo[c][ComputerOn] == true)
        {
            idx = c;
            printf("idx = %d", c);
            break;
        }
    }

    result = ComputerInfo[idx][ComputerCPU] + ComputerInfo[idx][ComputerGPU][0] + ComputerInfo[idx][ComputerGPU][1] + ComputerInfo[idx][ComputerGPU][2] + ComputerInfo[idx][ComputerGPU][3] + ComputerInfo[idx][ComputerGPU][4];

    if(ComputerInfo[idx][ComputerStartBTC])
    {
        HouseInfo[id][HouseEle] += result *2;
        printf("result computer: %d", result * 2);
    }
    else
    {
        HouseInfo[id][HouseEle] += result;
    }
        
    ele = Random(1, 5);
    HouseInfo[id][HouseEle] += ele;
    //printf("�س�Դ俷���ҹ��������� ����㹺�ҹ %s ������� %d ˹��� �� %d", HouseInfo[id][HouseName], ele + result, HouseInfo[id][HouseEle]);
    Savehouse(id);
    return 1;

}


forward OnPlayerNereHouseTime();
public OnPlayerNereHouseTime()
{

    foreach(new i : Player)
    {
        if(!BitFlag_Get(gPlayerBitFlag[i], IS_LOGGED))
            continue;
        
        for(new p = 1; p < MAX_HOUSE; p++)
		{
            if(!HouseInfo[p][HouseDBID])
				continue;
            
            if(IsPlayerInRangeOfPoint(i, 3.0, HouseInfo[p][HouseEntrance][0], HouseInfo[p][HouseEntrance][1], HouseInfo[p][HouseEntrance][2]))
            {
                if(gettime() - OnPlayerNereHouse[i][p] < 300)
                    continue;
                
                if(GetPlayerInterior(i) != HouseInfo[p][HouseEntranceInterior])
					continue;
					
				if(GetPlayerVirtualWorld(i) != HouseInfo[p][HouseEntranceWorld])
					continue;
                
                if(HouseInfo[p][HouseOwnerDBID])
                {
                    SendClientMessageEx(i,-1,"{3498DB}��ҹ�Ţ���: {27AE60}%s {3498DB}��Ңͧ��ҹ:{27AE60} %s", HouseInfo[p][HouseName],ReturnDBIDName(HouseInfo[p][HouseOwnerDBID]));
                    SendClientMessage(i,-1,"����ö����� /ds(��⡹������ҹ) /ddo(��á�зӷ���ҧ㹺�ҹ���) /enter(��Һ�ҹ)");
                    OnPlayerNereHouse[i][p] = gettime();
                }
                else
                {
                    SendClientMessageEx(i,-1,"{3498DB}��ҹ�Ţ���: {27AE60}%s {3498DB}�Ҥ�:{D35400} %s", HouseInfo[p][HouseName],MoneyFormat(HouseInfo[p][HousePrice]));
                    SendClientMessageEx(i,-1,"{3498DB}�����: {58D68D}%d", HouseInfo[p][HouseLevel]);
                    OnPlayerNereHouse[i][p] = gettime();
                }
            }
            else
            {
                OnPlayerNereHouse[i][p] = 0;
            }
        }
    }
    return 1;
}


stock CountPlayerProperties(playerid)
{
	new
		count = 0
	;

	for(new i = 1; i < MAX_HOUSE; i++)
	{
		if(!HouseInfo[i][HouseDBID])
			continue;
			
		if(HouseInfo[i][HouseOwnerDBID] == PlayerInfo[playerid][pDBID])
			count++; 
	}
	return count; 
}

Dialog:DIALOG_SELL_HOUSE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    if(response)
    {
        new id = PlayerInfo[playerid][pInsideProperty];

        if(id == 0)
            return 1;

        if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
            return SendClientMessage(playerid, -1,"�س�������Ңͧ��ҹ");
        
        new Money = HouseInfo[id][HousePrice] / 2;

        new bill = HouseInfo[id][HouseEle];
        HouseInfo[id][HouseOwnerDBID] = 0;
        HouseInfo[id][HouseLock] = true;

        for(new w = 1; w < 22; w++)
        {
            HouseInfo[id][HouseWeapons][w] = 0;
            HouseInfo[id][HouseWeaponsAmmo][w] = 0;
        }

        for(new pos = 0; pos < 3; pos++)
        {
            HouseInfo[id][HousePlacePos][pos] = 0;
        }

        GiveMoney(playerid, Money);
        GiveMoney(playerid, -bill*7);
        SetPlayerPos(playerid,HouseInfo[id][HouseEntrance][0],HouseInfo[id][HouseEntrance][1],HouseInfo[id][HouseEntrance][2]);
        SetPlayerVirtualWorld(playerid, HouseInfo[id][HouseEntranceWorld]);
        SetPlayerInterior(playerid, HouseInfo[id][HouseEntranceInterior]);
        HouseInfo[id][HouseSwicth] = false;
        SetHouseOffSwitch(playerid);
        PlayerTextDrawDestroy(playerid, PlayerSwicthOff[playerid][0]);


        if(IsValidDynamicPickup(HouseInfo[id][HousePickup]))
            DestroyDynamicPickup(HouseInfo[id][HousePickup]);

        //HouseInfo[id][HousePickup] = CreateDynamicPickup(1273, 23, HouseInfo[id][HouseEntrance][0], HouseInfo[id][HouseEntrance][1], HouseInfo[id][HouseEntrance][2],-1,-1);

        SendClientMessageEx(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{009933} �س���º�ҹ�ͧ�س�������Թ�Ҩӹǹ %s",MoneyFormat(Money));
        SendClientMessageEx(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{009933} �س�պ�Ť��俷���ҧ������������ӡ���ѡ˹����俿�Ңͧ�س�ӹǹ $%s",MoneyFormat(bill));
        Savehouse(id);
        return 1;
    }
    return 1;
}


stock IsPlayerNearHouse(playerid)
{
	for(new i = 1; i < MAX_HOUSE; i++)
	{
		if(!HouseInfo[i][HouseDBID])
			continue; 
			
		if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseEntrance][0], HouseInfo[i][HouseEntrance][1], HouseInfo[i][HouseEntrance][2]) && GetPlayerVirtualWorld(playerid) == HouseInfo[i][HouseEntranceWorld])
			return i;
	} 
	return 0; 
}



Dialog:DIALOG_HOUSE_WEAPONS(playerid, response, listitem, inputtext[])
{
    if(response)
	{
		new
		id = PlayerInfo[playerid][pInsideProperty],
		str[128]
		;
				
		if(!HouseInfo[id][HouseWeapons][listitem+1])
			return SendErrorMessage(playerid, ""); 
					
		GivePlayerGun(playerid, HouseInfo[id][HouseWeapons][listitem+1], HouseInfo[id][HouseWeaponsAmmo][listitem+1]);
				
		format(str, sizeof(str), "* %s ��Ժ %s �͡�Ҩҡ���૿", ReturnName(playerid, 0), ReturnWeaponName(HouseInfo[id][HouseWeapons][listitem+1])); 
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
		SendClientMessage(playerid, COLOR_EMOTE, str); 
				
		HouseInfo[id][HouseWeapons][listitem+1] = 0; 
		HouseInfo[id][HouseWeaponsAmmo][listitem+1] = 0; 
			
		CharacterSave(playerid); Savehouse(id);
		return 1;
	}
    return 1;
}

stock IsPlayerInHouse(playerid)
{
	if(PlayerInfo[playerid][pInsideProperty])
	{
		for(new i = 1; i < MAX_HOUSE; i++)
		{
			if(i == PlayerInfo[playerid][pInsideProperty] && GetPlayerVirtualWorld(playerid) == HouseInfo[i][HouseInteriorWorld])
				return i;
		}
	}
	return 0;
}

stock RemoveHouse(playerid,id)
{
    new delHouse[MAX_STRING];

    mysql_format(dbCon, delHouse, sizeof(delHouse), "DELETE FROM house WHERE HouseDBID = %d", HouseInfo[id][HouseDBID]);
	mysql_tquery(dbCon, delHouse); 

    HouseInfo[id][HouseDBID] = 0;
    format(HouseInfo[id][HouseName], HouseInfo[id][HouseName], "");
    HouseInfo[id][HouseOwnerDBID] = 0;
    HouseInfo[id][HouseEntrance][0] = 0;
    HouseInfo[id][HouseEntrance][1] = 0;
    HouseInfo[id][HouseEntrance][2] = 0;
    HouseInfo[id][HouseEntranceWorld] = 0;
    HouseInfo[id][HouseEntranceInterior] = 0;

    HouseInfo[id][HouseInterior][0] = 0;
    HouseInfo[id][HouseInterior][1] = 0;
    HouseInfo[id][HouseInterior][2] = 0;
    HouseInfo[id][HouseInteriorWorld] = 0;
    HouseInfo[id][HouseInteriorID] = 0;

    HouseInfo[id][HousePrice] = 0;
    HouseInfo[id][HouseLevel] = 0;

    HouseInfo[id][HouseLock] = true;

    for(new w = 0; w < 22; w++)
    {
        HouseInfo[id][HouseWeapons][w] = 0;
        HouseInfo[id][HouseWeaponsAmmo][w] = 0;
    }

    if(IsValidDynamicPickup(HouseInfo[id][HousePickup]))
        DestroyDynamicPickup(HouseInfo[id][HousePickup]);

    new str[MAX_STRING];
    format(str, sizeof(str), "������ %d: %s ��ź��ҹ �ʹ� %d �͡�ҡ�׿��������", PlayerInfo[playerid][pAdmin], ReturnRealName(playerid), id);
    SendAdminMessage(5,str);

    return 1;
}