#include <YSI\y_hooks>


#define BUSINESS_TYPE_STORE         (1)
#define BUSINESS_TYPE_DEALERVEHICLE (2)
#define BUSINESS_TYPE_AMMUNITION    (3)
#define BUSINESS_TYPE_RESTAURANT    (4)
#define BUSINESS_TYPE_BANK          (5)


new PlayerSelectBusiness[MAX_PLAYERS];

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

    if(IsValidDynamicPickup(BusinessInfo[newid][BusinessBankPickup]))
        DestroyDynamicPickup(BusinessInfo[newid][BusinessBankPickup]);

    if(BusinessInfo[newid][BusinessType] == BUSINESS_TYPE_RESTAURANT)
    {
        BusinessInfo[newid][BusinessBankPickup] = CreateDynamicPickup(1274, 23, X, Y, Z,-1,-1);
    }
    else
    {
        BusinessInfo[newid][BusinessBankPickup] = CreateDynamicPickup(1239, 23, X, Y, Z,-1,-1);
    }

    SendClientMessageEx(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF}คุณได้สร้างกิจการ %s ไอดี %d ขึ้นมา", BusinessInfo[newid][BusinessName],cache_insert_id());

    new str[MAX_STRING];

    format(str, sizeof(str), "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} %s {FFFFFF}ได้สร้างกิจการ ID {66FFFF}%d {FFFFFF}แล้ว",ReturnRealName(playerid),cache_insert_id());
	SendAdminMessage(2, str);

    SaveBusiness(cache_insert_id());
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
	
	Dialog_Show(playerid, DIALOG_VIEWBUSINESS, DIALOG_STYLE_LIST, "BUSINESS:", longstr, "เลือก", "ออก");
    return 1;

}

stock ShowSelectBusiness(playerid)
{
    new id = PlayerSelectBusiness[playerid];

    new BusinessNames[96],infoString[MAX_STRING],showString[MAX_STRING];

    format(BusinessNames, sizeof(BusinessNames), "BUSINESS: %s",BusinessInfo[id][BusinessName]);

    format(infoString, sizeof(infoString), "ไอดี: %i\n",BusinessInfo[id][BusinessDBID]);
	strcat(showString, infoString);

    format(infoString, sizeof(infoString), "ชื่อ: %s\n", BusinessInfo[id][BusinessName]);
	strcat(showString, infoString);

    if(BusinessInfo[id][BusinessType])
    {
        if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_STORE)
        {
            format(infoString, sizeof(infoString), "ประเภท: ร้านสดวกซื้อ\n");
            strcat(showString, infoString);
        }
        else if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_DEALERVEHICLE)
        {
            format(infoString, sizeof(infoString), "ประเภท: ร้านตัวแทนจำหน่าย\n");
            strcat(showString, infoString);
        }
        else if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_AMMUNITION)
        {
            format(infoString, sizeof(infoString), "ประเภท: ร้านขายปืน\n");
            strcat(showString, infoString);
        }
        else if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_RESTAURANT)
        {
            format(infoString, sizeof(infoString), "ประเภท: ร้านอาหาร\n");
            strcat(showString, infoString);
        }
        else if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_BANK)
        {
            format(infoString, sizeof(infoString), "ประเภท: ธนาคาร\n");
            strcat(showString, infoString);
        }
    }

    format(infoString, sizeof(infoString), "ราคากิจการ: %s\n", MoneyFormat(BusinessInfo[id][BusinessPrice]));
	strcat(showString, infoString);

    format(infoString, sizeof(infoString), "เลเวลกิจการ: %d\n",BusinessInfo[id][Businesslevel]);
	strcat(showString, infoString);

    format(infoString, sizeof(infoString), "ค่าเข้ากิจการ: %s\n",MoneyFormat(BusinessInfo[id][BusinessEntrancePrice]));
	strcat(showString, infoString);

    format(infoString, sizeof(infoString), "จุดหน้าร้าน:\n");
	strcat(showString, infoString);

    format(infoString, sizeof(infoString), "จุดภายใน:\n");
	strcat(showString, infoString);

    if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_BANK)
    {
        format(infoString, sizeof(infoString), "จุด BankPickUp:\n");
	    strcat(showString, infoString);
    }

    Dialog_Show(playerid, DIALOG_EDITBUSINESS, DIALOG_STYLE_LIST, BusinessNames, showString, "ยินยัน", "ยกเลิก");

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


    strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}ร้านค้า(24/7)\n");
	strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}ร้านตัวแทนจำหน่ายรถ\n"); 
    strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}ร้านปืน\n"); 
    strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}ร้านอาหาร\n"); 
    strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}ธนาคาร\n"); 

    Dialog_Show(playerid, DIALOG_BU_TYPE, DIALOG_STYLE_LIST, "เปลี่ยนประเภทกิจการ", select_type, "ยืนยัน", "ยกเลิก");
    return 1;
}

Dialog:DIALOG_EDITBUSINESS(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowViewBusiness(playerid);

    switch(listitem)
    {
        case 0: return ShowSelectBusiness(playerid);
        case 1: return Dialog_Show(playerid, DIALOG_BU_NAME, DIALOG_STYLE_INPUT, "เปลี่ยนชื่อกิจการ","ใส่ชื่อกิจการใหม่ของคุณ:", "ยืนยัน", "ยกเลิก");
        case 2: ShowSelectBusinessType(playerid);
        case 3: return Dialog_Show(playerid, DIALOG_BU_PRICE, DIALOG_STYLE_INPUT, "เปลี่ยนราคากิจการ","ใส่ราคากิจการใหม่ของคุณ:", "ยืนยัน", "ยกเลิก");
        case 4: return Dialog_Show(playerid, DIALOG_BU_LEVEL, DIALOG_STYLE_INPUT, "เปลี่ยนเลเวลกิจการ","ใส่เลเวลใหม่ของกิจการคุณ:", "ยืนยัน", "ยกเลิก");
        case 5: return Dialog_Show(playerid, DIALOG_BU_EN_PRICE, DIALOG_STYLE_INPUT, "เปลี่ยนค่าเข้ากิจการ","ใส่ค่าเข้ากิจการใหม่ของกิจการ:", "ยืนยัน", "ยกเลิก");
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

            SendClientMessage(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} คุณได้เปลี่ยนจุดหน้าร้านแล้ว");
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
                SendClientMessage(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FF0033}เตือน!{D81B60} กรุณาไปวาง 'BankPickup ใหม่เนื่องจากมีการเปลี่ยน Inteior ภายใน'");
            }

            foreach(new i : Player)
            {
                if(PlayerInfo[i][pInsideBusiness] != id)
                    continue;
                
                SetPlayerPos(i,BusinessInfo[id][BusinessInterior][0],BusinessInfo[id][BusinessInterior][1],BusinessInfo[id][BusinessInterior][2]);
                SetPlayerVirtualWorld(i, BusinessInfo[id][BusinessInteriorWorld]);
                SetPlayerInterior(i, BusinessInfo[id][BusinessInteriorID]);
                PlayerInfo[i][pInsideBusiness] = id;

                SendClientMessage(i, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFF00} ขออภัยในความไม่สดวกเนื่องจากมีการเปลี่ยน Interior กระทันหันจึงทำให้มีการวาปไป Interior ใหม่อัตโนมัต");
            }

            SendClientMessage(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} คุณได้เปลี่ยนจุดภายในร้านแล้ว");
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
            SendClientMessage(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} เปลี่ยนจุด 'BankPickUp' แล่ว");
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
        return Dialog_Show(playerid, DIALOG_BU_NAME, DIALOG_STYLE_INPUT, "เปลี่ยนชื่อกิจการ","ใส่ชื่อกิจการไม่ถูกต้อง:", "ยืนยัน", "ยกเลิก");
    
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
        return Dialog_Show(playerid, DIALOG_BU_PRICE, DIALOG_STYLE_INPUT, "เปลี่ยนราคากิจการ","คุณไม่สามารถใส่ราคาต่ำกว่า $1 และเกิน $90,000,000 ได้\nโปรดใส่ราคาที่ถูกต้องด้วย:", "ยืนยัน", "ยกเลิก");

    BusinessInfo[id][BusinessPrice] = price;
    SendClientMessageEx(playerid,-1,"{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} คุณได้เปลี่ยนราคากิจการเป็น {33FF33}$%s",MoneyFormat(price));
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
        return Dialog_Show(playerid, DIALOG_BU_PRICE, DIALOG_STYLE_INPUT, "เปลี่ยนราคากิจการ","คุณไม่สามารถใส่เลเวลต่ำกว่า 1 และเกิน 90,000,000 ได้\nโปรดใส่เลเวลที่ถูกต้องด้วย:", "ยืนยัน", "ยกเลิก");

    BusinessInfo[id][Businesslevel] = level;
    SendClientMessageEx(playerid,-1,"{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} คุณได้เปลี่ยนเลเวลกิจการเป็น {33FF33}%d",level);
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
        return Dialog_Show(playerid, DIALOG_BU_PRICE, DIALOG_STYLE_INPUT, "เปลี่ยนราคากิจการ","คุณไม่สามารถใส่ราคาต่ำกว่า $1 และเกิน $90,000,000 ได้\nโปรดใส่ราคาที่ถูกต้องด้วย:", "ยืนยัน", "ยกเลิก");

    BusinessInfo[id][BusinessEntrancePrice] = price;
    SendClientMessageEx(playerid,-1,"{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} คุณได้เปลี่ยนเลเวลกิจการเป็น {33FF33}$%s",MoneyFormat(price));
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


