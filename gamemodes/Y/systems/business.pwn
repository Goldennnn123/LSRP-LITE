#include <YSI_Coding\y_hooks>


#define BUSINESS_TYPE_STORE         (1)
#define BUSINESS_TYPE_DEALERVEHICLE (2)
#define BUSINESS_TYPE_AMMUNITION    (3)
#define BUSINESS_TYPE_RESTAURANT    (4)
#define BUSINESS_TYPE_BANK          (5)
#define BUSINESS_TYPE_CLUB          (6)


new PlayerSelectBusiness[MAX_PLAYERS];
new PlayerText:BuyFood[MAX_PLAYERS][13];

hook OnPlayerConnect(playerid)
{
    PlayerSelectBusiness[playerid] = 0;
    return 1;
}

forward Query_LoadBusiness();
public Query_LoadBusiness()
{
    if(!cache_num_rows())
		return printf("[SERVER]: No Business were loaded from \"%s\" database...", MYSQL_DB);

    new rows,countBusiness; cache_get_row_count(rows);

    for (new i = 0; i < rows && i < MAX_BUSINESS; i ++)
    {
        cache_get_value_name_int(i,"BusinessDBID",BusinessInfo[i+1][BusinessDBID]);
        cache_get_value_name(i,"BusinessName",BusinessInfo[i+1][BusinessName],90);
        cache_get_value_name_int(i,"BusinessOwnerDBID",BusinessInfo[i+1][BusinessOwnerDBID]);

        cache_get_value_name_int(i,"BusinessType",BusinessInfo[i+1][BusinessType]);
        cache_get_value_name_int(i,"BusinessPrice",BusinessInfo[i+1][BusinessPrice]);
        cache_get_value_name_int(i,"BusinessLevel",BusinessInfo[i+1][Businesslevel]);
        cache_get_value_name_int(i,"BusinessEntrancePrice",BusinessInfo[i+1][BusinessEntrancePrice]);
        cache_get_value_name_int(i,"BusinessLock",BusinessInfo[i+1][BusinessLock]);

        cache_get_value_name_float(i, "BusinessEntranceX", BusinessInfo[i+1][BusinessEntrance][0]);
        cache_get_value_name_float(i, "BusinessEntranceY", BusinessInfo[i+1][BusinessEntrance][1]);
        cache_get_value_name_float(i, "BusinessEntranceZ", BusinessInfo[i+1][BusinessEntrance][2]);
        cache_get_value_name_int(i,"BusinessEntranceWorld",BusinessInfo[i+1][BusinessEntranceWorld]);
        cache_get_value_name_int(i,"BusinessEntranceInterior",BusinessInfo[i+1][BusinessEntranceInterior]);

        cache_get_value_name_float(i, "BusinessInteriorX", BusinessInfo[i+1][BusinessInterior][0]);
        cache_get_value_name_float(i, "BusinessInteriorY", BusinessInfo[i+1][BusinessInterior][1]);
        cache_get_value_name_float(i, "BusinessInteriorZ", BusinessInfo[i+1][BusinessInterior][2]);
        cache_get_value_name_int(i,"BusinessInteriorWorld",BusinessInfo[i+1][BusinessInteriorWorld]);
        cache_get_value_name_int(i,"BusinessInteriorID",BusinessInfo[i+1][BusinessInteriorID]);

        cache_get_value_name_float(i,"BusinessBankPickupLocX",BusinessInfo[i+1][BusinessBankPickupLoc][0]);
        cache_get_value_name_float(i,"BusinessBankPickupLocY",BusinessInfo[i+1][BusinessBankPickupLoc][1]);
        cache_get_value_name_float(i,"BusinessBankPickupLocZ",BusinessInfo[i+1][BusinessBankPickupLoc][2]);
        cache_get_value_name_int(i,"BusinessBankWorld",BusinessInfo[i+1][BusinessBankWorld]);

        cache_get_value_name_int(i,"BusinessCash",BusinessInfo[i+1][BusinessCash]);


        if(IsValidDynamicPickup(BusinessInfo[i+1][BusinessEntrancePickUp]))
            DestroyDynamicPickup(BusinessInfo[i+1][BusinessEntrancePickUp]);

        if(BusinessInfo[i+1][BusinessType] == BUSINESS_TYPE_RESTAURANT)
        {
            if(BusinessInfo[i+1][BusinessOwnerDBID])
            {
                BusinessInfo[i+1][BusinessEntrancePickUp] = CreateDynamicPickup(1239, 23, BusinessInfo[i+1][BusinessEntrance][0], BusinessInfo[i+1][BusinessEntrance][1], BusinessInfo[i+1][BusinessEntrance][2],-1,-1);
            }
            else
            {
                BusinessInfo[i+1][BusinessEntrancePickUp] = CreateDynamicPickup(1274, 23, BusinessInfo[i+1][BusinessEntrance][0], BusinessInfo[i+1][BusinessEntrance][1], BusinessInfo[i+1][BusinessEntrance][2],-1,-1);
            }
        }
        else
        {
            BusinessInfo[i+1][BusinessEntrancePickUp] = CreateDynamicPickup(1239, 23, BusinessInfo[i+1][BusinessEntrance][0], BusinessInfo[i+1][BusinessEntrance][1], BusinessInfo[i+1][BusinessEntrance][2],-1,-1);
        }

        if(BusinessInfo[i+1][BusinessType] == BUSINESS_TYPE_BANK)
        {
            if(IsValidDynamicPickup(BusinessInfo[i+1][BusinessBankPickup]))
                    DestroyDynamicPickup(BusinessInfo[i+1][BusinessBankPickup]);
                
            BusinessInfo[i+1][BusinessBankPickup] = CreateDynamicPickup(1274, 23, BusinessInfo[i+1][BusinessBankPickupLoc][0], BusinessInfo[i+1][BusinessBankPickupLoc][1], BusinessInfo[i+1][BusinessBankPickupLoc][2],-1,-1);
        }
        
        countBusiness++;
    }

    printf("[SERVER]: %i Business were loaded from \"%s\" database...", countBusiness, MYSQL_DB);
    return 1;
}

forward Query_InsertBusiness(playerid,newid,type,name);
public Query_InsertBusiness(playerid,newid,type,name)
{
    new Float:X,Float:Y,Float:Z;

    GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);


    BusinessInfo[newid][BusinessDBID] = cache_insert_id();
    format(BusinessInfo[newid][BusinessName], 90, "BusinessName");
    BusinessInfo[newid][BusinessType] = type;

    BusinessInfo[newid][BusinessEntrance][0] = X;
    BusinessInfo[newid][BusinessEntrance][1] = Y;
    BusinessInfo[newid][BusinessEntrance][2] = Z;

    BusinessInfo[newid][BusinessPrice] = 5000;
    BusinessInfo[newid][Businesslevel] = 1;

    if(IsValidDynamicPickup(BusinessInfo[newid][BusinessEntrancePickUp]))
        DestroyDynamicPickup(BusinessInfo[newid][BusinessEntrancePickUp]);

    if(BusinessInfo[newid][BusinessType] == BUSINESS_TYPE_RESTAURANT)
    {
        BusinessInfo[newid][BusinessEntrancePickUp] = CreateDynamicPickup(1274, 23, X, Y, Z,-1,-1);
    }
    else
    {
        BusinessInfo[newid][BusinessEntrancePickUp] = CreateDynamicPickup(1239, 23, X, Y, Z,-1,-1);
    }

    SendClientMessageEx(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF}�س�����ҧ�Ԩ��� %s �ʹ� %d �����", BusinessInfo[newid][BusinessName],newid);

    new str[MAX_STRING];

    format(str, sizeof(str), "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} %s {FFFFFF}�����ҧ�Ԩ��� ID {66FFFF}%d {FFFFFF}����",ReturnRealName(playerid),newid);
	SendAdminMessage(2, str);

    SaveBusiness(newid);
    return 1;
}

stock ShowViewBusiness(playerid)
{
    new str[182], longstr[556], str_b[MAX_STRING];
	new businessid; 
	for (new i = 1; i < MAX_HOUSE; i ++)
	{
		if(!BusinessInfo[i][BusinessDBID])
			continue;
			
		format(str, sizeof(str), "{ADC3E7}%d \t %s \t\n", i, BusinessInfo[i][BusinessName]);
		strcat(longstr, str);

		format(str_b, sizeof(str_b), "%d",businessid);
		SetPVarInt(playerid, str_b, i);

		businessid++;
		
	}
	
	Dialog_Show(playerid, DIALOG_VIEWBUSINESS, DIALOG_STYLE_LIST, "BUSINESS:", longstr, "���͡", "�͡");
    return 1;

}

stock ShowSelectBusiness(playerid)
{
    new id = PlayerSelectBusiness[playerid];

    new BusinessNames[96],infoString[MAX_STRING],showString[MAX_STRING];

    format(BusinessNames, sizeof(BusinessNames), "BUSINESS: %s",BusinessInfo[id][BusinessName]);

    format(infoString, sizeof(infoString), "�ʹ�: %i\n",BusinessInfo[id][BusinessDBID]);
	strcat(showString, infoString);

    format(infoString, sizeof(infoString), "����: %s\n", BusinessInfo[id][BusinessName]);
	strcat(showString, infoString);

    if(BusinessInfo[id][BusinessType])
    {
        if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_STORE)
        {
            format(infoString, sizeof(infoString), "������: ��ҹʴǡ����\n");
            strcat(showString, infoString);
        }
        else if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_DEALERVEHICLE)
        {
            format(infoString, sizeof(infoString), "������: ��ҹ���᷹��˹���\n");
            strcat(showString, infoString);
        }
        else if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_AMMUNITION)
        {
            format(infoString, sizeof(infoString), "������: ��ҹ��»׹\n");
            strcat(showString, infoString);
        }
        else if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_RESTAURANT)
        {
            format(infoString, sizeof(infoString), "������: ��ҹ�����\n");
            strcat(showString, infoString);
        }
        else if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_BANK)
        {
            format(infoString, sizeof(infoString), "������: ��Ҥ��\n");
            strcat(showString, infoString);
        }
        else if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_CLUB)
        {
            format(infoString, sizeof(infoString), "������: ��Ѻ\n");
            strcat(showString, infoString);
        }
    }

    format(infoString, sizeof(infoString), "�ҤҡԨ���: %s\n", MoneyFormat(BusinessInfo[id][BusinessPrice]));
	strcat(showString, infoString);

    format(infoString, sizeof(infoString), "����šԨ���: %d\n",BusinessInfo[id][Businesslevel]);
	strcat(showString, infoString);

    format(infoString, sizeof(infoString), "�����ҡԨ���: %s\n",MoneyFormat(BusinessInfo[id][BusinessEntrancePrice]));
	strcat(showString, infoString);

    format(infoString, sizeof(infoString), "�ش˹����ҹ:\n");
	strcat(showString, infoString);

    format(infoString, sizeof(infoString), "�ش����:\n");
	strcat(showString, infoString);

    if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_BANK)
    {
        format(infoString, sizeof(infoString), "�ش BankPickUp:\n");
	    strcat(showString, infoString);
    }

    Dialog_Show(playerid, DIALOG_EDITBUSINESS, DIALOG_STYLE_LIST, BusinessNames, showString, "�Թ�ѹ", "¡��ԡ");

    return 1;
}

Dialog:DIALOG_VIEWBUSINESS(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new str_b[MAX_STRING];
    format(str_b, sizeof(str_b), "%d",listitem);

    new id = GetPVarInt(playerid, str_b);
    PlayerSelectBusiness[playerid] = id;

    if(!BusinessInfo[id][BusinessDBID] || id > MAX_BUSINESS)
        return 1;

    ShowSelectBusiness(playerid);
    return 1;
}

stock ShowSelectBusinessType(playerid)
{
    new
		select_type[MAX_STRING]
	;


    strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}��ҹ���(24/7)\n");
	strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}��ҹ���᷹��˹���ö\n"); 
    strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}��ҹ�׹\n"); 
    strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}��ҹ�����\n"); 
    strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}��Ҥ��\n"); 
    strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}��Ѻ\n"); 

    Dialog_Show(playerid, DIALOG_BU_TYPE, DIALOG_STYLE_LIST, "����¹�������Ԩ���", select_type, "�׹�ѹ", "¡��ԡ");
    return 1;
}

Dialog:DIALOG_EDITBUSINESS(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowViewBusiness(playerid);

    switch(listitem)
    {
        case 0: return ShowSelectBusiness(playerid);
        case 1: return Dialog_Show(playerid, DIALOG_BU_NAME, DIALOG_STYLE_INPUT, "����¹���͡Ԩ���","�����͡Ԩ�������ͧ�س:", "�׹�ѹ", "¡��ԡ");
        case 2: ShowSelectBusinessType(playerid);
        case 3: return Dialog_Show(playerid, DIALOG_BU_PRICE, DIALOG_STYLE_INPUT, "����¹�ҤҡԨ���","����ҤҡԨ�������ͧ�س:", "�׹�ѹ", "¡��ԡ");
        case 4: return Dialog_Show(playerid, DIALOG_BU_LEVEL, DIALOG_STYLE_INPUT, "����¹����šԨ���","������������ͧ�Ԩ��äس:", "�׹�ѹ", "¡��ԡ");
        case 5: return Dialog_Show(playerid, DIALOG_BU_EN_PRICE, DIALOG_STYLE_INPUT, "����¹�����ҡԨ���","�������ҡԨ�������ͧ�Ԩ���:", "�׹�ѹ", "¡��ԡ");
        case 6:
        {
            new id = PlayerSelectBusiness[playerid];
            GetPlayerPos(playerid,BusinessInfo[id][BusinessEntrance][0],BusinessInfo[id][BusinessEntrance][1],BusinessInfo[id][BusinessEntrance][2]);
            
            BusinessInfo[id][BusinessEntranceWorld] = GetPlayerVirtualWorld(playerid);
            BusinessInfo[id][BusinessEntranceInterior] = GetPlayerInterior(playerid);

            if(IsValidDynamicPickup(BusinessInfo[id][BusinessEntrancePickUp]))
                DestroyDynamicPickup(BusinessInfo[id][BusinessEntrancePickUp]);

            if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_RESTAURANT)
            {
                if(BusinessInfo[id][BusinessOwnerDBID])
                {
                    BusinessInfo[id][BusinessEntrancePickUp] = CreateDynamicPickup(1239, 23, BusinessInfo[id][BusinessEntrance][0], BusinessInfo[id][BusinessEntrance][1], BusinessInfo[id][BusinessEntrance][2],-1,-1);
                }
                else
                {
                    BusinessInfo[id][BusinessEntrancePickUp] = CreateDynamicPickup(1274, 23, BusinessInfo[id][BusinessEntrance][0], BusinessInfo[id][BusinessEntrance][1], BusinessInfo[id][BusinessEntrance][2],-1,-1);
                }
            }
            else
            {
                BusinessInfo[id][BusinessEntrancePickUp] = CreateDynamicPickup(1239, 23, BusinessInfo[id][BusinessEntrance][0], BusinessInfo[id][BusinessEntrance][1], BusinessInfo[id][BusinessEntrance][2],-1,-1);
            }

            SendClientMessage(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} �س������¹�ش˹����ҹ����");
            SaveBusiness(id);
            return ShowSelectBusiness(playerid);
        }
        case 7:
        {
            new id = PlayerSelectBusiness[playerid];
            GetPlayerPos(playerid,BusinessInfo[id][BusinessInterior][0],BusinessInfo[id][BusinessInterior][1],BusinessInfo[id][BusinessInterior][2]);
            
            if(GetPlayerVirtualWorld(playerid) != 0)
            {
                BusinessInfo[id][BusinessInteriorWorld] = GetPlayerVirtualWorld(playerid);
            }
            else
            {
                BusinessInfo[id][BusinessInteriorWorld] = random(90000);
            }

            BusinessInfo[id][BusinessInteriorID] = GetPlayerInterior(playerid);

            if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_BANK)
            {
                for(new m = 0; m < 3; m++)
                {
                    BusinessInfo[id][BusinessBankPickupLoc][m] = 0;
                }
                SendClientMessage(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FF0033}��͹!{D81B60} ��س���ҧ 'BankPickup �������ͧ�ҡ�ա������¹ Inteior ����'");
            }

            foreach(new i : Player)
            {
                if(PlayerInfo[i][pInsideBusiness] != id)
                    continue;
                
                SetPlayerPos(i,BusinessInfo[id][BusinessInterior][0],BusinessInfo[id][BusinessInterior][1],BusinessInfo[id][BusinessInterior][2]);
                SetPlayerVirtualWorld(i, BusinessInfo[id][BusinessInteriorWorld]);
                SetPlayerInterior(i, BusinessInfo[id][BusinessInteriorID]);
                PlayerInfo[i][pInsideBusiness] = id;

                SendClientMessage(i, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFF00} ������㹤������ʴǡ���ͧ�ҡ�ա������¹ Interior ��зѹ�ѹ�֧������ա���һ� Interior �����ѵ��ѵ");
            }

            SendClientMessage(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} �س������¹�ش������ҹ����");
            SaveBusiness(id);
            return ShowSelectBusiness(playerid);
        }
        case 8:
        {
            new id = PlayerSelectBusiness[playerid];
            GetPlayerPos(playerid,BusinessInfo[id][BusinessBankPickupLoc][0],BusinessInfo[id][BusinessBankPickupLoc][1],BusinessInfo[id][BusinessBankPickupLoc][2]);
            BusinessInfo[id][BusinessBankWorld] = GetPlayerVirtualWorld(playerid);

            if(IsValidDynamicPickup(BusinessInfo[id][BusinessBankPickup]))
                DestroyDynamicPickup(BusinessInfo[id][BusinessBankPickup]);
            
            BusinessInfo[id][BusinessBankPickup] = CreateDynamicPickup(1274, 23, BusinessInfo[id][BusinessBankPickupLoc][0], BusinessInfo[id][BusinessBankPickupLoc][1], BusinessInfo[id][BusinessBankPickupLoc][2],-1,-1);
            SendClientMessage(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} ����¹�ش 'BankPickUp' ����");
            SaveBusiness(id);
            return ShowSelectBusiness(playerid);
        }
    }
    return 1;
}

Dialog:DIALOG_BU_NAME(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowSelectBusiness(playerid);

    new id = PlayerSelectBusiness[playerid];

    if(strlen(inputtext) < 1 || strlen(inputtext) > 90)
        return Dialog_Show(playerid, DIALOG_BU_NAME, DIALOG_STYLE_INPUT, "����¹���͡Ԩ���","�����͡Ԩ������١��ͧ:", "�׹�ѹ", "¡��ԡ");
    
    format(BusinessInfo[id][BusinessName], 90, inputtext);

    SaveBusiness(id);
    return ShowSelectBusiness(playerid);
}

Dialog:DIALOG_BU_TYPE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowSelectBusiness(playerid);

    new id = PlayerSelectBusiness[playerid];

    switch(listitem)
    {
        case 0:
        {
            BusinessInfo[id][BusinessType] = BUSINESS_TYPE_STORE;
            if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_BANK)
            {
                for(new m = 0; m < 3; m++)
                {
                    BusinessInfo[id][BusinessBankPickupLoc][m] = 0;
                }
            }
            SaveBusiness(id);
        }
        case 1:
        {
            BusinessInfo[id][BusinessType] = BUSINESS_TYPE_DEALERVEHICLE;
            if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_BANK)
            {
                for(new m = 0; m < 3; m++)
                {
                    BusinessInfo[id][BusinessBankPickupLoc][m] = 0;
                }
            }
            SaveBusiness(id);
        }
        case 2:
        {
            BusinessInfo[id][BusinessType] = BUSINESS_TYPE_AMMUNITION;
            if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_BANK)
            {
                for(new m = 0; m < 3; m++)
                {
                    BusinessInfo[id][BusinessBankPickupLoc][m] = 0;
                }
            }
            SaveBusiness(id);
        }
        case 3:
        {
            BusinessInfo[id][BusinessType] = BUSINESS_TYPE_RESTAURANT;
            if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_BANK)
            {
                for(new m = 0; m < 3; m++)
                {
                    BusinessInfo[id][BusinessBankPickupLoc][m] = 0;
                }
            }
            SaveBusiness(id);
        }
        case 4:
        {
            BusinessInfo[id][BusinessType] = BUSINESS_TYPE_BANK;
            SaveBusiness(id);
        }
        case 5:
        {
            BusinessInfo[id][BusinessType] = BUSINESS_TYPE_CLUB;
            SaveBusiness(id);
        }
    }
    return ShowSelectBusiness(playerid);
}

Dialog:DIALOG_BU_PRICE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowSelectBusiness(playerid);
    
    new id = PlayerSelectBusiness[playerid];
    new price = strval(inputtext);

    if(price < 1 || price > 90000000)
        return Dialog_Show(playerid, DIALOG_BU_PRICE, DIALOG_STYLE_INPUT, "����¹�ҤҡԨ���","�س�������ö����Ҥҵ�ӡ��� $1 ����Թ $90,000,000 ��\n�ô����Ҥҷ��١��ͧ����:", "�׹�ѹ", "¡��ԡ");

    BusinessInfo[id][BusinessPrice] = price;
    SendClientMessageEx(playerid,-1,"{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} �س������¹�ҤҡԨ����� {33FF33}$%s",MoneyFormat(price));
    SaveBusiness(id);
    return ShowSelectBusiness(playerid);
}

Dialog:DIALOG_BU_LEVEL(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowSelectBusiness(playerid);
    
    new id = PlayerSelectBusiness[playerid];
    new level = strval(inputtext);

    if(level < 1 || level > 90000000)
        return Dialog_Show(playerid, DIALOG_BU_PRICE, DIALOG_STYLE_INPUT, "����¹�ҤҡԨ���","�س�������ö�������ŵ�ӡ��� 1 ����Թ 90,000,000 ��\n�ô�������ŷ��١��ͧ����:", "�׹�ѹ", "¡��ԡ");

    BusinessInfo[id][Businesslevel] = level;
    SendClientMessageEx(playerid,-1,"{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} �س������¹����šԨ����� {33FF33}%d",level);
    SaveBusiness(id);
    return ShowSelectBusiness(playerid);
}

Dialog:DIALOG_BU_EN_PRICE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowSelectBusiness(playerid);
    
    new id = PlayerSelectBusiness[playerid];
    new price = strval(inputtext);

    if(price < 1 || price > 90000000)
        return Dialog_Show(playerid, DIALOG_BU_PRICE, DIALOG_STYLE_INPUT, "����¹�ҤҡԨ���","�س�������ö����Ҥҵ�ӡ��� $1 ����Թ $90,000,000 ��\n�ô����Ҥҷ��١��ͧ����:", "�׹�ѹ", "¡��ԡ");

    BusinessInfo[id][BusinessEntrancePrice] = price;
    SendClientMessageEx(playerid,-1,"{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} �س������¹����šԨ����� {33FF33}$%s",MoneyFormat(price));
    SaveBusiness(id);
    return ShowSelectBusiness(playerid);
}

forward OnPlayerEnterBusiness(playerid,id);
public OnPlayerEnterBusiness(playerid,id)
{
    TogglePlayerControllable(playerid, 1);
    SetPlayerPos(playerid, BusinessInfo[id][BusinessInterior][0], BusinessInfo[id][BusinessInterior][1], BusinessInfo[id][BusinessInterior][2]);
    return 1;
}

forward OnPlayerNereBusinessTime();
public OnPlayerNereBusinessTime()
{
    new str[MAX_STRING];

    foreach(new i : Player)
    {
        if(!BitFlag_Get(gPlayerBitFlag[i], IS_LOGGED))
            continue;

        for(new b = 1; b < MAX_BUSINESS; b++)
        {
            if(!IsPlayerInRangeOfPoint(i, 3.0, BusinessInfo[b][BusinessEntrance][0], BusinessInfo[b][BusinessEntrance][1], BusinessInfo[b][BusinessEntrance][2]))
                continue;

            if(GetPlayerInterior(i) != BusinessInfo[b][BusinessEntranceInterior])
				continue;
					
			if(GetPlayerVirtualWorld(i) != BusinessInfo[b][BusinessEntranceWorld])
				continue;

            if(BusinessInfo[b][BusinessOwnerDBID])
            {
                format(str, sizeof(str), "%s~n~~w~Owned By : %s~n~Entrance Fee : ~g~$%d~n~~p~To use /enter", BusinessInfo[b][BusinessName], ReturnDBIDName(BusinessInfo[b][BusinessOwnerDBID]), BusinessInfo[b][BusinessEntrancePrice]); 
            }
            else
            {
                format(str, sizeof(str), "%s~n~~w~This business is for sale~n~Price : ~g~$%d~w~ Level : %d~n~~p~To buy use /buybiz", BusinessInfo[b][BusinessName], BusinessInfo[b][BusinessPrice], BusinessInfo[b][Businesslevel]); 
            }
            GameTextForPlayer(i, str, 3500, 3);
        }
    }
    return 1;
}


stock IsPlayerNearBusiness(playerid)
{
	for(new i = 1; i < MAX_BUSINESS; i++)
	{
		if(!BusinessInfo[i][BusinessDBID])
			continue;
			
		if(IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[i][BusinessEntrance][0], BusinessInfo[i][BusinessEntrance][1], BusinessInfo[i][BusinessEntrance][2]))
			return i;
	}
	return 0;
}

stock CountPlayerBusiness(playerid)
{
	new
		count = 0
	;
	
	for(new i = 1; i < MAX_BUSINESS; i++)
	{
		if(!BusinessInfo[i][BusinessDBID])
			continue;
			
		if(BusinessInfo[i][BusinessOwnerDBID] == PlayerInfo[playerid][pDBID])
			count++;
	}
	return count;
}


Dialog:DIALOG_SELL_BU(playerid, response, listitem, inputtext[])
{
    if(!response)
        return SendClientMessage(playerid, -1, "¡��ԡ��â�¡Ԩ�������");

    new id = PlayerInfo[playerid][pInsideBusiness];

    if(id == 0)
        return SendErrorMessage(playerid,"�س���������㹡Ԩ���");

    if(BusinessInfo[id][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendErrorMessage(playerid,"�س����������Ңͧ�Ԩ��ù��");

    new BusinessPrices = BusinessInfo[id][BusinessPrice] / 2;
    new BusinessCashs = BusinessInfo[id][BusinessCash];

    GivePlayerMoney(playerid, BusinessPrices + BusinessCashs);

    SendClientMessageEx(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFF33} �س���¡Ԩ������� �س���Ѻ�ҡԨ��÷����� $%s ������Թ�ҡ �ҤҡԨ��� ��ä��� ����Թ���",MoneyFormat(BusinessPrices + BusinessCashs));
    SendClientMessage(playerid, -1,"{FFFF33}�Ԩ��âͧ�س");

    BusinessInfo[id][BusinessCash] = 0;
    BusinessInfo[id][BusinessOwnerDBID] = 0;
    SaveBusiness(id); CharacterSave(playerid);
    return 1;
}

stock ShowPlayerBusiness(playerid)
{
    new str[MAX_STRING];

    for(new b_id = 1; b_id < MAX_BUSINESS; b_id++)
    {
        if(BusinessInfo[b_id][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
            continue;
        
        format(str, sizeof(str), "���͡Ԩ���: %s\n\
                                  ��ҷҧ��ҡԨ���: %s\n\
                                  �Թ㹡Ԩ���: %s",BusinessInfo[b_id][BusinessName],MoneyFormat(BusinessInfo[b_id][BusinessEntrancePrice]),MoneyFormat(BusinessInfo[b_id][BusinessCash]));
        
        PlayerSelectBusiness[playerid] = b_id;
    }

    Dialog_Show(playerid, DIALOG_BU_EDIT, DIALOG_STYLE_LIST, "Business Managment", str, "�׹�ѹ", "¡��ԡ");
    return 1;
}

Dialog:DIALOG_BU_EDIT(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    //new id = PlayerSelectBusiness[playerid];

    switch(listitem)
    {
        case 0: return ShowPlayerBusiness(playerid);
        case 1:
        {
            Dialog_Show(playerid, DIALOG_BU_CH_ENTERPRICE, DIALOG_STYLE_INPUT, "Business Managment: ����¹��ҷҧ���", "����Ҥҷҧ�������ͧ�Ԩ���:", "�׹�ѹ", "¡��ԡ");
            return 1;
        }
        case 2:
        {
            new str[600];

            format(str, sizeof(str), "�͹�Թ�Ԩ���:\n\
                                      ���Թ��ҡԨ���:");

            Dialog_Show(playerid, DIALOG_BU_CASH, DIALOG_STYLE_LIST, "Business Managment: �Թ�Ԩ���", str, "�׹�ѹ", "¡��ԡ");
            return 1;
        }
    }
    return 1;
}

Dialog:DIALOG_BU_CH_ENTERPRICE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowPlayerBusiness(playerid);
    
    new price = strval(inputtext);


    new id = PlayerSelectBusiness[playerid];

    if(price > 1500)
        return Dialog_Show(playerid, DIALOG_BU_CH_ENTERPRICE, DIALOG_STYLE_INPUT, "Business Managment: ����¹��ҷҧ���", "�س����Ҥ��Թ $1,500 �ô����Ҥ����١��ͧ:", "�׹�ѹ", "¡��ԡ");

    BusinessInfo[id][BusinessEntrancePrice] = price;
    SaveBusiness(id);
    return ShowPlayerBusiness(playerid);
}
Dialog:DIALOG_BU_CASH(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowPlayerBusiness(playerid);
    
    //new id = PlayerSelectBusiness[playerid];

    switch(listitem)
    {
        case 0: return Dialog_Show(playerid, DIALOG_BU_CASH_WIHDRAW, DIALOG_STYLE_INPUT, "Business Managment: �͹�Թ�Ԩ���", "���ӹǹ�Թ���ж͹�ҡ�Ԩ���:", "�׹�ѹ", "¡��ԡ");
        case 1: return Dialog_Show(playerid, DIALOG_BU_CASH_DEPOSIT, DIALOG_STYLE_INPUT, "Business Managment: �ҡ�Թ�Ԩ���", "���ӹǹ�Թ���нҡ��ҡԨ���:", "�׹�ѹ", "¡��ԡ");
    }

    return 1;
}

Dialog:DIALOG_BU_CASH_WIHDRAW(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        new str[600];

        format(str, sizeof(str), "�͹�Թ�Ԩ���:\n\
                                  ���Թ��ҡԨ���:");

        Dialog_Show(playerid, DIALOG_BU_CASH, DIALOG_STYLE_LIST, "Business Managment: �Թ�Ԩ���", str, "�׹�ѹ", "¡��ԡ");
        return 1;
    }

    new id = PlayerSelectBusiness[playerid];

    new witdraw = strval(inputtext);

    if(witdraw < 1)
    {
        new str[600];

        format(str, sizeof(str), "�͹�Թ�Ԩ���:\n\
                                  ���Թ��ҡԨ���:");

        Dialog_Show(playerid, DIALOG_BU_CASH, DIALOG_STYLE_LIST, "Business Managment: �Թ�Ԩ���", str, "�׹�ѹ", "¡��ԡ");
        return 1;
    }

    if(witdraw > BusinessInfo[id][BusinessCash])
        return Dialog_Show(playerid, DIALOG_BU_CASH_WIHDRAW, DIALOG_STYLE_INPUT, "Business Managment: �͹�Թ�Ԩ���", "�Թ㹡Ԩ��âͧ�س�����§ ��س����ӹǹ���١��ͧ:", "�׹�ѹ", "¡��ԡ");

    BusinessInfo[id][BusinessCash] -= witdraw;
    GivePlayerMoney(playerid, witdraw);
    SendClientMessageEx(playerid, -1,"{0D47A1}BUSINESS {F57C00}SYSTEM:{FF5722} �س��͹�Թ�ҡ�Ԩ��âͧ�س�ӹǹ {4CAF50}$%s {FF5722}�Թ㹡Ԩ��âͧ�س����� {42A5F5}$%s",MoneyFormat(witdraw),MoneyFormat(BusinessInfo[id][BusinessCash]));
    SaveBusiness(id); CharacterSave(playerid);
    return ShowPlayerBusiness(playerid);
}

Dialog:DIALOG_BU_CASH_DEPOSIT(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        new str[600];

        format(str, sizeof(str), "�͹�Թ�Ԩ���:\n\
                                  ���Թ��ҡԨ���:");

        Dialog_Show(playerid, DIALOG_BU_CASH, DIALOG_STYLE_LIST, "Business Managment: �Թ�Ԩ���", str, "�׹�ѹ", "¡��ԡ");
        return 1;
    }

    new id = PlayerSelectBusiness[playerid];

    new deposit = strval(inputtext);
    new Mymoney = GetPlayerMoney(playerid);

    if(deposit < 1)
    {
        new str[600];

        format(str, sizeof(str), "�͹�Թ�Ԩ���:\n\
                                  ���Թ��ҡԨ���:");

        Dialog_Show(playerid, DIALOG_BU_CASH, DIALOG_STYLE_LIST, "Business Managment: �Թ�Ԩ���", str, "�׹�ѹ", "¡��ԡ");
        return 1;
    }

    if(deposit > Mymoney)
        return Dialog_Show(playerid, DIALOG_BU_CASH_DEPOSIT, DIALOG_STYLE_INPUT, "Business Managment: �ҡ�Թ��ҡԨ���", "�Թ㹵�Ǣͧ�س�����§ ��س����ӹǹ���١��ͧ:", "�׹�ѹ", "¡��ԡ");

    BusinessInfo[id][BusinessCash] += deposit;
    GivePlayerMoney(playerid, -deposit);
    SendClientMessageEx(playerid, -1,"{0D47A1}BUSINESS {F57C00}SYSTEM:{FF5722} �س��ҡ�Թ��ҡԨ��âͧ�س�ӹǹ {4CAF50}$%s {FF5722}�Թ㹵�Ǣͧ�س����� {42A5F5}$%s",MoneyFormat(deposit),MoneyFormat(deposit - Mymoney));
    SaveBusiness(id); CharacterSave(playerid);
    return ShowPlayerBusiness(playerid);
}

stock RemoveBusiness(playerid,id)
{
    new delBusiness[MAX_STRING];

    mysql_format(dbCon, delBusiness, sizeof(delBusiness), "DELETE FROM business WHERE BusinessDBID = %d", BusinessInfo[id][BusinessDBID]);
	mysql_tquery(dbCon, delBusiness); 

    BusinessInfo[id][BusinessDBID] = 0;
    format(BusinessInfo[id][BusinessName], BusinessInfo[id][BusinessName], "");
    BusinessInfo[id][BusinessOwnerDBID] = 0;
    BusinessInfo[id][BusinessType] = 0;
    BusinessInfo[id][BusinessEntrance][0] = 0;
    BusinessInfo[id][BusinessEntrance][1] = 0;
    BusinessInfo[id][BusinessEntrance][2] = 0;
    BusinessInfo[id][BusinessEntranceWorld] = 0;
    BusinessInfo[id][BusinessEntranceInterior] = 0;

    BusinessInfo[id][BusinessInterior][0] = 0;
    BusinessInfo[id][BusinessInterior][1] = 0;
    BusinessInfo[id][BusinessInterior][2] = 0;
    BusinessInfo[id][BusinessInteriorWorld] = 0;
    BusinessInfo[id][BusinessInteriorID] = 0;

    BusinessInfo[id][BusinessBankPickupLoc][0] = 0;
    BusinessInfo[id][BusinessBankPickupLoc][1] = 0;
    BusinessInfo[id][BusinessBankPickupLoc][2] = 0;
    BusinessInfo[id][BusinessBankWorld] = 0;

    BusinessInfo[id][BusinessCash] = 0;

    BusinessInfo[id][BusinessPrice] = 0;
    BusinessInfo[id][Businesslevel] = 0;
    BusinessInfo[id][BusinessEntrancePrice] = 0;

    BusinessInfo[id][BusinessLock] = true;

    if(IsValidDynamicPickup(BusinessInfo[id][BusinessEntrancePickUp]))
        DestroyDynamicPickup(BusinessInfo[id][BusinessEntrancePickUp]);

    if(IsValidDynamicPickup(BusinessInfo[id][BusinessBankPickup]))
        DestroyDynamicPickup(BusinessInfo[id][BusinessBankPickup]);


    new str[MAX_STRING];
    format(str, sizeof(str), "������ %d: %s ��ź�Ԩ��� �ʹ� %d �͡�ҡ�׿��������", PlayerInfo[playerid][pAdmin], ReturnRealName(playerid), id);
    SendAdminMessage(5,str);

    return 1;
}

stock IsPlayerInBusiness(playerid)
{
	if(PlayerInfo[playerid][pInsideBusiness])
	{
		for(new i = 1; i < MAX_BUSINESS; i++)
		{
			if(!BusinessInfo[i][BusinessDBID])
				continue;
				
			if(i == PlayerInfo[playerid][pInsideBusiness] && GetPlayerVirtualWorld(playerid) == BusinessInfo[i][BusinessInteriorWorld])
				return i;
		}
	}
	return 0;
}

stock SendBusinessType(playerid, id)
{
	switch(BusinessInfo[id][BusinessType])
	{
		case BUSINESS_TYPE_AMMUNITION:
		{
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "�Թ�յ���Ѻ��������ҹ  %s", BusinessInfo[id][BusinessName]);
			SendClientMessage(playerid, COLOR_WHITE, "Available commands: /buygun, /buyammo."); 
		}
		case BUSINESS_TYPE_BANK:
		{
            if(!PlayerInfo[playerid][pSaving])
                SendClientMessage(playerid, COLOR_DARKGREEN, "Bank: /saving ����Ѻ��ýҡ�����Ѿ��");
			SendClientMessage(playerid, COLOR_DARKGREEN, "Bank: /bank, /withdraw, /balance."); 
		}
		case BUSINESS_TYPE_STORE:
		{
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "�Թ�յ���Ѻ��������ҹ %s", BusinessInfo[id][BusinessName]);
			SendClientMessage(playerid, COLOR_WHITE, "Available commands: /buy, /withdraw, /balance."); 
		}
		case BUSINESS_TYPE_CLUB:
		{
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "�Թ�յ���Ѻ��������ҹ %s", BusinessInfo[id][BusinessName]);
			SendClientMessage(playerid, COLOR_WHITE, "Available commands: /buydrink."); 
		}
		case BUSINESS_TYPE_RESTAURANT:
		{
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "�Թ�յ���Ѻ��������ҹ %s", BusinessInfo[id][BusinessName]);
			SendClientMessage(playerid, COLOR_WHITE, "Available commands: /eat."); 
		}
	}
	return 1;
}


stock ShowPlayerBuyFoodTextDraw(playerid)
{
    BuyFood[playerid][0] = CreatePlayerTextDraw(playerid, 313.000000, 100.000000, "_");
    PlayerTextDrawFont(playerid, BuyFood[playerid][0], 1);
    PlayerTextDrawLetterSize(playerid, BuyFood[playerid][0], 0.600000, 22.650009);
    PlayerTextDrawTextSize(playerid, BuyFood[playerid][0], 298.500000, 430.000000);
    PlayerTextDrawSetOutline(playerid, BuyFood[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, BuyFood[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, BuyFood[playerid][0], 2);
    PlayerTextDrawColor(playerid, BuyFood[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, BuyFood[playerid][0], -1094795521);
    PlayerTextDrawUseBox(playerid, BuyFood[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, BuyFood[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][0], 0);

    BuyFood[playerid][1] = CreatePlayerTextDraw(playerid, 313.000000, 100.000000, "_");
    PlayerTextDrawFont(playerid, BuyFood[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid, BuyFood[playerid][1], 0.600000, 1.750002);
    PlayerTextDrawTextSize(playerid, BuyFood[playerid][1], 298.500000, 430.000000);
    PlayerTextDrawSetOutline(playerid, BuyFood[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, BuyFood[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, BuyFood[playerid][1], 2);
    PlayerTextDrawColor(playerid, BuyFood[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, BuyFood[playerid][1], -1962934017);
    PlayerTextDrawUseBox(playerid, BuyFood[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, BuyFood[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][1], 0);

    BuyFood[playerid][2] = CreatePlayerTextDraw(playerid, 522.000000, 100.000000, "X");
    PlayerTextDrawFont(playerid, BuyFood[playerid][2], 2);
    PlayerTextDrawLetterSize(playerid, BuyFood[playerid][2], 0.258332, 1.750000);
    PlayerTextDrawTextSize(playerid, BuyFood[playerid][2], 16.500000, 13.000000);
    PlayerTextDrawSetOutline(playerid, BuyFood[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, BuyFood[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, BuyFood[playerid][2], 2);
    PlayerTextDrawColor(playerid, BuyFood[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, BuyFood[playerid][2], -16776961);
    PlayerTextDrawUseBox(playerid, BuyFood[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, BuyFood[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][2], 1);

    BuyFood[playerid][3] = CreatePlayerTextDraw(playerid, 95.641998, 117.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, BuyFood[playerid][3], 5);
    PlayerTextDrawLetterSize(playerid, BuyFood[playerid][3], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, BuyFood[playerid][3], 113.000000, 106.500000);
    PlayerTextDrawSetOutline(playerid, BuyFood[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, BuyFood[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, BuyFood[playerid][3], 1);
    PlayerTextDrawColor(playerid, BuyFood[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][3], 125);
    PlayerTextDrawBoxColor(playerid, BuyFood[playerid][3], 255);
    PlayerTextDrawUseBox(playerid, BuyFood[playerid][3], 0);
    PlayerTextDrawSetProportional(playerid, BuyFood[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][3], 1);
    PlayerTextDrawSetPreviewModel(playerid, BuyFood[playerid][3], 19580);
    PlayerTextDrawSetPreviewRot(playerid, BuyFood[playerid][3], -10.000000, 0.000000, -20.000000, 0.730000);
    PlayerTextDrawSetPreviewVehCol(playerid, BuyFood[playerid][3], 1, 1);

    BuyFood[playerid][4] = CreatePlayerTextDraw(playerid, 256.641998, 117.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, BuyFood[playerid][4], 5);
    PlayerTextDrawLetterSize(playerid, BuyFood[playerid][4], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, BuyFood[playerid][4], 113.000000, 106.500000);
    PlayerTextDrawSetOutline(playerid, BuyFood[playerid][4], 0);
    PlayerTextDrawSetShadow(playerid, BuyFood[playerid][4], 0);
    PlayerTextDrawAlignment(playerid, BuyFood[playerid][4], 1);
    PlayerTextDrawColor(playerid, BuyFood[playerid][4], -1);
    PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][4], 125);
    PlayerTextDrawBoxColor(playerid, BuyFood[playerid][4], 255);
    PlayerTextDrawUseBox(playerid, BuyFood[playerid][4], 0);
    PlayerTextDrawSetProportional(playerid, BuyFood[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][4], 1);
    PlayerTextDrawSetPreviewModel(playerid, BuyFood[playerid][4], 2222);
    PlayerTextDrawSetPreviewRot(playerid, BuyFood[playerid][4], -10.000000, 0.000000, -79.000000, 0.860000);
    PlayerTextDrawSetPreviewVehCol(playerid, BuyFood[playerid][4], 1, 1);

    BuyFood[playerid][5] = CreatePlayerTextDraw(playerid, 416.641998, 117.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, BuyFood[playerid][5], 5);
    PlayerTextDrawLetterSize(playerid, BuyFood[playerid][5], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, BuyFood[playerid][5], 113.000000, 106.500000);
    PlayerTextDrawSetOutline(playerid, BuyFood[playerid][5], 0);
    PlayerTextDrawSetShadow(playerid, BuyFood[playerid][5], 0);
    PlayerTextDrawAlignment(playerid, BuyFood[playerid][5], 1);
    PlayerTextDrawColor(playerid, BuyFood[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][5], 125);
    PlayerTextDrawBoxColor(playerid, BuyFood[playerid][5], 255);
    PlayerTextDrawUseBox(playerid, BuyFood[playerid][5], 0);
    PlayerTextDrawSetProportional(playerid, BuyFood[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][5], 1);
    PlayerTextDrawSetPreviewModel(playerid, BuyFood[playerid][5], 2222);
    PlayerTextDrawSetPreviewRot(playerid, BuyFood[playerid][5], -10.000000, 0.000000, -79.000000, 0.860000);
    PlayerTextDrawSetPreviewVehCol(playerid, BuyFood[playerid][5], 1, 1);

    BuyFood[playerid][6] = CreatePlayerTextDraw(playerid, 98.000000, 225.000000, "$150");
    PlayerTextDrawFont(playerid, BuyFood[playerid][6], 1);
    PlayerTextDrawLetterSize(playerid, BuyFood[playerid][6], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, BuyFood[playerid][6], 207.000000, 67.000000);
    PlayerTextDrawSetOutline(playerid, BuyFood[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, BuyFood[playerid][6], 0);
    PlayerTextDrawAlignment(playerid, BuyFood[playerid][6], 1);
    PlayerTextDrawColor(playerid, BuyFood[playerid][6], -1);
    PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][6], 255);
    PlayerTextDrawBoxColor(playerid, BuyFood[playerid][6], 50);
    PlayerTextDrawUseBox(playerid, BuyFood[playerid][6], 0);
    PlayerTextDrawSetProportional(playerid, BuyFood[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][6], 0);

    BuyFood[playerid][7] = CreatePlayerTextDraw(playerid, 258.000000, 225.000000, "$300");
    PlayerTextDrawFont(playerid, BuyFood[playerid][7], 1);
    PlayerTextDrawLetterSize(playerid, BuyFood[playerid][7], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, BuyFood[playerid][7], 368.000000, 67.000000);
    PlayerTextDrawSetOutline(playerid, BuyFood[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, BuyFood[playerid][7], 0);
    PlayerTextDrawAlignment(playerid, BuyFood[playerid][7], 1);
    PlayerTextDrawColor(playerid, BuyFood[playerid][7], -1);
    PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][7], 255);
    PlayerTextDrawBoxColor(playerid, BuyFood[playerid][7], 50);
    PlayerTextDrawUseBox(playerid, BuyFood[playerid][7], 0);
    PlayerTextDrawSetProportional(playerid, BuyFood[playerid][7], 1);
    PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][7], 0);

    BuyFood[playerid][8] = CreatePlayerTextDraw(playerid, 418.000000, 225.000000, "$500");
    PlayerTextDrawFont(playerid, BuyFood[playerid][8], 1);
    PlayerTextDrawLetterSize(playerid, BuyFood[playerid][8], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, BuyFood[playerid][8], 528.000000, 67.000000);
    PlayerTextDrawSetOutline(playerid, BuyFood[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, BuyFood[playerid][8], 0);
    PlayerTextDrawAlignment(playerid, BuyFood[playerid][8], 1);
    PlayerTextDrawColor(playerid, BuyFood[playerid][8], -1);
    PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][8], 255);
    PlayerTextDrawBoxColor(playerid, BuyFood[playerid][8], 50);
    PlayerTextDrawUseBox(playerid, BuyFood[playerid][8], 0);
    PlayerTextDrawSetProportional(playerid, BuyFood[playerid][8], 1);
    PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][8], 0);

    BuyFood[playerid][9] = CreatePlayerTextDraw(playerid, 97.000000, 246.000000, "+15");
    PlayerTextDrawFont(playerid, BuyFood[playerid][9], 1);
    PlayerTextDrawLetterSize(playerid, BuyFood[playerid][9], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, BuyFood[playerid][9], 132.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, BuyFood[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, BuyFood[playerid][9], 0);
    PlayerTextDrawAlignment(playerid, BuyFood[playerid][9], 1);
    PlayerTextDrawColor(playerid, BuyFood[playerid][9], 1433087999);
    PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][9], 255);
    PlayerTextDrawBoxColor(playerid, BuyFood[playerid][9], 50);
    PlayerTextDrawUseBox(playerid, BuyFood[playerid][9], 0);
    PlayerTextDrawSetProportional(playerid, BuyFood[playerid][9], 1);
    PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][9], 0);

    BuyFood[playerid][10] = CreatePlayerTextDraw(playerid, 258.000000, 246.000000, "+30");
    PlayerTextDrawFont(playerid, BuyFood[playerid][10], 1);
    PlayerTextDrawLetterSize(playerid, BuyFood[playerid][10], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, BuyFood[playerid][10], 294.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, BuyFood[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid, BuyFood[playerid][10], 0);
    PlayerTextDrawAlignment(playerid, BuyFood[playerid][10], 1);
    PlayerTextDrawColor(playerid, BuyFood[playerid][10], 1433087999);
    PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][10], 255);
    PlayerTextDrawBoxColor(playerid, BuyFood[playerid][10], 50);
    PlayerTextDrawUseBox(playerid, BuyFood[playerid][10], 0);
    PlayerTextDrawSetProportional(playerid, BuyFood[playerid][10], 1);
    PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][10], 0);

    BuyFood[playerid][11] = CreatePlayerTextDraw(playerid, 418.000000, 246.000000, "+50");
    PlayerTextDrawFont(playerid, BuyFood[playerid][11], 1);
    PlayerTextDrawLetterSize(playerid, BuyFood[playerid][11], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, BuyFood[playerid][11], 458.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, BuyFood[playerid][11], 1);
    PlayerTextDrawSetShadow(playerid, BuyFood[playerid][11], 0);
    PlayerTextDrawAlignment(playerid, BuyFood[playerid][11], 1);
    PlayerTextDrawColor(playerid, BuyFood[playerid][11], 1433087999);
    PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][11], 255);
    PlayerTextDrawBoxColor(playerid, BuyFood[playerid][11], 50);
    PlayerTextDrawUseBox(playerid, BuyFood[playerid][11], 0);
    PlayerTextDrawSetProportional(playerid, BuyFood[playerid][11], 1);
    PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][11], 0);

    BuyFood[playerid][12] = CreatePlayerTextDraw(playerid, 234.000000, 100.000000, "BUSINESS NAME");
    PlayerTextDrawFont(playerid, BuyFood[playerid][12], 2);
    PlayerTextDrawLetterSize(playerid, BuyFood[playerid][12], 0.600000, 1.700000);
    PlayerTextDrawTextSize(playerid, BuyFood[playerid][12], 438.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, BuyFood[playerid][12], 1);
    PlayerTextDrawSetShadow(playerid, BuyFood[playerid][12], 0);
    PlayerTextDrawAlignment(playerid, BuyFood[playerid][12], 1);
    PlayerTextDrawColor(playerid, BuyFood[playerid][12], -1);
    PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][12], 255);
    PlayerTextDrawBoxColor(playerid, BuyFood[playerid][12], 50);
    PlayerTextDrawUseBox(playerid, BuyFood[playerid][12], 0);
    PlayerTextDrawSetProportional(playerid, BuyFood[playerid][12], 1);
    PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][12], 0);
    return 1;
}


stock ShowPlayerBuyFood(playerid)
{
    new str[300];
    new id = PlayerInfo[playerid][pInsideBusiness];
    ShowPlayerBuyFoodTextDraw(playerid);

    for(new f = 0; f <= 12; f++)
    {
        PlayerTextDrawShow(playerid, BuyFood[playerid][f]);
    }

    format(str, sizeof(str), "%s", BusinessInfo[id][BusinessName]);
    PlayerTextDrawSetString(playerid, BuyFood[playerid][12], str);
    SelectTextDraw(playerid, 0xB4B5B7FF);
    return 1;
}


hook OP_ClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == BuyFood[playerid][2])
    {
        for(new f = 0; f <= 12; f++)
        {
            PlayerTextDrawDestroy(playerid, BuyFood[playerid][f]);
        }
        CancelSelectTextDraw(playerid);
        return 1;
    }
    if(playertextid == BuyFood[playerid][3])
    {
        new Float:HP, id = PlayerInfo[playerid][pInsideBusiness];
        GetPlayerHealth(playerid, HP);

        if(HP > 100)
            return SendErrorMessage(playerid, "�س�����ʹ�ҡ��� 100");

        if(HP >= 90)
        {
            SetPlayerHealth(playerid, HP+10);
        }
        else if(HP >= 85)
        {
            SetPlayerHealth(playerid, HP+15);
        }
        else
        {
            SetPlayerHealth(playerid, HP+15);
        }

        SendClientMessage(playerid, -1, "�س�������������� �����Թ� $150");
        GivePlayerMoney(playerid, -150);
        BusinessInfo[id][BusinessCash] += 150;
        CharacterSave(playerid);
        SaveBusiness(id);
        return 1;
    }
    if(playertextid == BuyFood[playerid][4])
    {
        new Float:HP, id = PlayerInfo[playerid][pInsideBusiness];
        GetPlayerHealth(playerid, HP);

        if(HP > 100)
            return SendErrorMessage(playerid, "�س�����ʹ�ҡ��� 100");

        if(HP >= 90)
        {
            SetPlayerHealth(playerid, HP+10);
        }
        else if(HP >= 85)
        {
            SetPlayerHealth(playerid, HP+15);
        }
        else
        {
            SetPlayerHealth(playerid, HP+30);
        }

        SendClientMessage(playerid, -1, "�س�������������� �����Թ� $300");
        GivePlayerMoney(playerid, -300);
        BusinessInfo[id][BusinessCash] += 300;
        CharacterSave(playerid);
        SaveBusiness(id);
        return 1;
    }
    if(playertextid == BuyFood[playerid][5])
    {
        new Float:HP, id = PlayerInfo[playerid][pInsideBusiness];
        GetPlayerHealth(playerid, HP);

        if(HP > 100)
            return SendErrorMessage(playerid, "�س�����ʹ�ҡ��� 100");

        if(HP >= 90)
        {
            SetPlayerHealth(playerid, HP+10);
        }
        else if(HP >= 85)
        {
            SetPlayerHealth(playerid, HP+15);
        }
        else
        {
            SetPlayerHealth(playerid, HP+50);
        }

        SendClientMessage(playerid, -1, "�س�������������� �����Թ� $500");
        GivePlayerMoney(playerid, -500);
        BusinessInfo[id][BusinessCash] += 500;
        CharacterSave(playerid);
        SaveBusiness(id);
        return 1;
    }
    return 1;
}





