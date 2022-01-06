#include <YSI_Coding\y_hooks>


#define BUSINESS_TYPE_STORE         (1)
#define BUSINESS_TYPE_DEALERVEHICLE (2)
#define BUSINESS_TYPE_AMMUNITION    (3)
#define BUSINESS_TYPE_RESTAURANT    (4)
#define BUSINESS_TYPE_BANK          (5)
#define BUSINESS_TYPE_CLUB          (6)
#define BUSINESS_TYPE_SKIN          (7)
#define BUSINESS_TYPE_ROLE          (8)
#define BUSINESS_TYPE_JOB          (9)


new PlayerSelectBusiness[MAX_PLAYERS];
new PlayerText:BuyFood[MAX_PLAYERS][8];

hook OnPlayerConnect(playerid)
{
    PlayerSelectBusiness[playerid] = 0;
    DeletePVar(playerid, "ReadyRobing");
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

        cache_get_value_name_int(i,"BusinessS_Cemara",BusinessInfo[i+1][BusinessS_Cemara]);
        cache_get_value_name_int(i,"BusinessS_Mask",BusinessInfo[i+1][BusinessS_Mask]);
        cache_get_value_name_int(i,"BusinessS_Flower",BusinessInfo[i+1][BusinessS_Flower]);


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

    BusinessInfo[newid][BusinessS_Cemara] = 50;
    BusinessInfo[newid][BusinessS_Mask] = 5;
    BusinessInfo[newid][BusinessS_Flower] = 15;

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

    SendClientMessageEx(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF}คุณได้สร้างกิจการ %s ไอดี %d ขึ้นมา", BusinessInfo[newid][BusinessName],newid);

    new str[MAX_STRING];

    format(str, sizeof(str), "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} %s {FFFFFF}ได้สร้างกิจการ ID {66FFFF}%d {FFFFFF}แล้ว",ReturnRealName(playerid),newid);
	SendAdminMessage(2, str);

    SaveBusiness(newid);
    return 1;
}

stock ShowViewBusiness(playerid)
{
    new str[182], longstr[556], str_b[MAX_STRING];
	new businessid; 
    
	for (new i = 1; i < MAX_BUSINESS; i ++)
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
        else if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_CLUB)
        {
            format(infoString, sizeof(infoString), "ประเภท: คลับ\n");
            strcat(showString, infoString);
        }
        else if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_SKIN)
        {
            format(infoString, sizeof(infoString), "ประเภท: ร้านขายเสื้อผ้า\n");
            strcat(showString, infoString);
        }
        else if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_ROLE)
        {
            format(infoString, sizeof(infoString), "ประเภท: บทบาท\n");
            strcat(showString, infoString);
        }
        else if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_JOB)
        {
            format(infoString, sizeof(infoString), "ประเภท: ร้านอุปกรณ์\n");
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
    strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}คลับ\n"); 
    strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}ร้านขายเสื้อผ้า\n"); 
    strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}บทบาท\n"); 
    strcat(select_type, "{FF0033}[ {FFFF33}! {FF0033}] {90CAF9}ร้านอุปกรณ์\n"); 

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
        case 5:
        {
            BusinessInfo[id][BusinessType] = BUSINESS_TYPE_CLUB;
            SaveBusiness(id);
        }
        case 6:
        {
            BusinessInfo[id][BusinessType] = BUSINESS_TYPE_SKIN;
            SaveBusiness(id);
        }
        case 7:
        {
            BusinessInfo[id][BusinessType] = BUSINESS_TYPE_ROLE;
            SaveBusiness(id);
        }
        case 8:
        {
            BusinessInfo[id][BusinessType] = BUSINESS_TYPE_JOB;
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
        return SendClientMessage(playerid, -1, "ยกเลิกการขายกิจการแล้ว");

    new id = PlayerInfo[playerid][pInsideBusiness];

    if(id == 0)
        return SendErrorMessage(playerid,"คุณไม่ได้อยู่ในกิจการ");

    if(BusinessInfo[id][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendErrorMessage(playerid,"คุณได้ม่ได้เป็นเจ้าของกิจการนี้");

    new BusinessPrices = BusinessInfo[id][BusinessPrice] / 2;
    new BusinessCashs = BusinessInfo[id][BusinessCash];

    GiveMoney(playerid, BusinessPrices + BusinessCashs);

    SendClientMessageEx(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFF33} คุณได้ขายกิจการแล้ว คุณได้รับจากิจการทั้งหมด $%s ซึ่งเป็นเงินจาก ราคากิจการ หารครึ่ง และเงินเก็บใน",MoneyFormat(BusinessPrices + BusinessCashs));
    SendClientMessage(playerid, -1,"{FFFF33}กิจการของคุณ");

    BusinessInfo[id][BusinessCash] = 0;
    BusinessInfo[id][BusinessOwnerDBID] = 0;
    SaveBusiness(id); CharacterSave(playerid);
    return 1;
}

stock ShowPlayerBusiness(playerid, id)
{
    new str[MAX_STRING],  longstr[MAX_STRING];

    format(str, sizeof(str), "ชื่อกิจการ: %s\n", BusinessInfo[id][BusinessName]);
    strcat(longstr,  str);
    format(str, sizeof(str), "ค่าทางเข้ากิจการ: %s\n", MoneyFormat(BusinessInfo[id][BusinessEntrancePrice]));
    strcat(longstr,  str);
    format(str, sizeof(str), "เงินในกิจการ: %s\n", MoneyFormat(BusinessInfo[id][BusinessCash]));
    strcat(longstr,  str);

    if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_STORE)
    {
        format(str, sizeof(str), "กล้อง: %d\n", BusinessInfo[id][BusinessS_Cemara]);
        strcat(longstr,  str);
        format(str, sizeof(str), "OOC Mask: %d\n", BusinessInfo[id][BusinessS_Mask]);
        strcat(longstr,  str);
        format(str, sizeof(str), "Flower: %d\n", BusinessInfo[id][BusinessS_Flower]);
        strcat(longstr,  str);
    }

    PlayerSelectBusiness[playerid] = id;
    Dialog_Show(playerid, DIALOG_BU_EDIT, DIALOG_STYLE_LIST, "Business Managment", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

Dialog:DIALOG_BU_EDIT(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    new id = PlayerSelectBusiness[playerid];

    switch(listitem)
    {
        case 0: return ShowPlayerBusiness(playerid, id);
        case 1:
        {
            Dialog_Show(playerid, DIALOG_BU_CH_ENTERPRICE, DIALOG_STYLE_INPUT, "Business Managment: เปลี่ยนค่าทางเข้า", "ใส่ราคาทางเข้าใหม่ของกิจการ:", "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 2:
        {
            new str[600];

            format(str, sizeof(str), "ถอนเงินกิจการ:\n\
                                      นำเงินเข้ากิจการ:");

            Dialog_Show(playerid, DIALOG_BU_CASH, DIALOG_STYLE_LIST, "Business Managment: เงินกิจการ", str, "ยืนยัน", "ยกเลิก");
            return 1;
        }
    }
    return 1;
}

Dialog:DIALOG_BU_CH_ENTERPRICE(playerid, response, listitem, inputtext[])
{
    new id = PlayerSelectBusiness[playerid];

    if(!response)
        return ShowPlayerBusiness(playerid, id);
    
    new price = strval(inputtext);

    if(price > 1500)
        return Dialog_Show(playerid, DIALOG_BU_CH_ENTERPRICE, DIALOG_STYLE_INPUT, "Business Managment: เปลี่ยนค่าทางเข้า", "คุณใส่ราคาเกิน $1,500 โปรดใส่ราคาให้ถูกต้อง:", "ยืนยัน", "ยกเลิก");

    BusinessInfo[id][BusinessEntrancePrice] = price;
    SaveBusiness(id);
    return ShowPlayerBusiness(playerid, id);
}
Dialog:DIALOG_BU_CASH(playerid, response, listitem, inputtext[])
{
    new id = PlayerSelectBusiness[playerid];
    if(!response)
        return ShowPlayerBusiness(playerid, id);
    
    //new id = PlayerSelectBusiness[playerid];

    switch(listitem)
    {
        case 0: return Dialog_Show(playerid, DIALOG_BU_CASH_WIHDRAW, DIALOG_STYLE_INPUT, "Business Managment: ถอนเงินกิจการ", "ใส่จำนวนเงินที่จะถอนจากกิจการ:", "ยืนยัน", "ยกเลิก");
        case 1: return Dialog_Show(playerid, DIALOG_BU_CASH_DEPOSIT, DIALOG_STYLE_INPUT, "Business Managment: ฝากเงินกิจการ", "ใส่จำนวนเงินที่จะฝากเข้ากิจการ:", "ยืนยัน", "ยกเลิก");
    }

    return 1;
}

Dialog:DIALOG_BU_CASH_WIHDRAW(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        new str[600];

        format(str, sizeof(str), "ถอนเงินกิจการ:\n\
                                  นำเงินเข้ากิจการ:");

        Dialog_Show(playerid, DIALOG_BU_CASH, DIALOG_STYLE_LIST, "Business Managment: เงินกิจการ", str, "ยืนยัน", "ยกเลิก");
        return 1;
    }

    new id = PlayerSelectBusiness[playerid];

    new witdraw = strval(inputtext);

    if(witdraw < 1)
    {
        new str[600];

        format(str, sizeof(str), "ถอนเงินกิจการ:\n\
                                  นำเงินเข้ากิจการ:");

        Dialog_Show(playerid, DIALOG_BU_CASH, DIALOG_STYLE_LIST, "Business Managment: เงินกิจการ", str, "ยืนยัน", "ยกเลิก");
        return 1;
    }

    if(witdraw > BusinessInfo[id][BusinessCash])
        return Dialog_Show(playerid, DIALOG_BU_CASH_WIHDRAW, DIALOG_STYLE_INPUT, "Business Managment: ถอนเงินกิจการ", "เงินในกิจการของคุณไม่เพียง กรุณาใส่จำนวนให้ถูกต้อง:", "ยืนยัน", "ยกเลิก");

    BusinessInfo[id][BusinessCash] -= witdraw;
    GiveMoney(playerid, witdraw);
    SendClientMessageEx(playerid, -1,"{0D47A1}BUSINESS {F57C00}SYSTEM:{FF5722} คุณได้ถอนเงินจากกิจการของคุณจำนวน {4CAF50}$%s {FF5722}เงินในกิจการของคุณเหลือ {42A5F5}$%s",MoneyFormat(witdraw),MoneyFormat(BusinessInfo[id][BusinessCash]));
    SaveBusiness(id); CharacterSave(playerid);
    return ShowPlayerBusiness(playerid, id);
}

Dialog:DIALOG_BU_CASH_DEPOSIT(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        new str[600];

        format(str, sizeof(str), "ถอนเงินกิจการ:\n\
                                  นำเงินเข้ากิจการ:");

        Dialog_Show(playerid, DIALOG_BU_CASH, DIALOG_STYLE_LIST, "Business Managment: เงินกิจการ", str, "ยืนยัน", "ยกเลิก");
        return 1;
    }

    new id = PlayerSelectBusiness[playerid];

    new deposit = strval(inputtext);
    new Mymoney = GetPlayerMoney(playerid);

    if(deposit < 1)
    {
        new str[600];

        format(str, sizeof(str), "ถอนเงินกิจการ:\n\
                                  นำเงินเข้ากิจการ:");

        Dialog_Show(playerid, DIALOG_BU_CASH, DIALOG_STYLE_LIST, "Business Managment: เงินกิจการ", str, "ยืนยัน", "ยกเลิก");
        return 1;
    }

    if(deposit > Mymoney)
        return Dialog_Show(playerid, DIALOG_BU_CASH_DEPOSIT, DIALOG_STYLE_INPUT, "Business Managment: ฝากเงินเข้ากิจการ", "เงินในตัวของคุณไม่เพียง กรุณาใส่จำนวนให้ถูกต้อง:", "ยืนยัน", "ยกเลิก");

    BusinessInfo[id][BusinessCash] += deposit;
    GiveMoney(playerid, -deposit);
    SendClientMessageEx(playerid, -1,"{0D47A1}BUSINESS {F57C00}SYSTEM:{FF5722} คุณได้ฝากเงินเข้ากิจการของคุณจำนวน {4CAF50}$%s {FF5722}เงินในตัวของคุณเหลือ {42A5F5}$%s",MoneyFormat(deposit),MoneyFormat(deposit - Mymoney));
    SaveBusiness(id); CharacterSave(playerid);
    return ShowPlayerBusiness(playerid, id);
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
    BusinessInfo[id][BusinessS_Cemara] = 0;
    BusinessInfo[id][BusinessS_Mask] = 0;
    BusinessInfo[id][BusinessS_Flower] = 0;

    if(IsValidDynamicPickup(BusinessInfo[id][BusinessEntrancePickUp]))
        DestroyDynamicPickup(BusinessInfo[id][BusinessEntrancePickUp]);

    if(IsValidDynamicPickup(BusinessInfo[id][BusinessBankPickup]))
        DestroyDynamicPickup(BusinessInfo[id][BusinessBankPickup]);


    new str[MAX_STRING];
    format(str, sizeof(str), "ผู้ดูแล %d: %s ได้ลบกิจการ ไอดี %d ออกจากเซืฟเวร์แล้ว", PlayerInfo[playerid][pAdmin], ReturnRealName(playerid), id);
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
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "ยินดีตอยรับเข้าสู่ร้าน  %s", BusinessInfo[id][BusinessName]);
			SendClientMessage(playerid, COLOR_WHITE, "Available commands: /buygun."); 
		}
		case BUSINESS_TYPE_BANK:
		{
            if(!PlayerInfo[playerid][pSaving])
                SendClientMessage(playerid, COLOR_DARKGREEN, "Bank: /saveing สำหรับการฝากออมทรัพท์");
			SendClientMessage(playerid, COLOR_DARKGREEN, "Bank: /bank, /withdraw, /balance."); 
		}
		case BUSINESS_TYPE_STORE:
		{
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "ยินดีตอยรับเข้าสู่ร้าน %s", BusinessInfo[id][BusinessName]);
			SendClientMessage(playerid, COLOR_WHITE, "Available commands: /buy, /withdraw, /balance, /checkbil, /buyticket"); 
		}
		case BUSINESS_TYPE_CLUB:
		{
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "ยินดีตอยรับเข้าสู่ร้าน %s", BusinessInfo[id][BusinessName]);
			SendClientMessage(playerid, COLOR_WHITE, "Available commands: /buydrink."); 
		}
		case BUSINESS_TYPE_RESTAURANT:
		{
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "ยินดีตอยรับเข้าสู่ร้าน %s", BusinessInfo[id][BusinessName]);
			SendClientMessage(playerid, COLOR_WHITE, "Available commands: /eat."); 
		}
        case BUSINESS_TYPE_SKIN:
		{
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "ยินดีตอยรับเข้าสู่ร้าน %s", BusinessInfo[id][BusinessName]);
			SendClientMessage(playerid, COLOR_WHITE, "Available commands: /skin"); 
		}
        case BUSINESS_TYPE_JOB:
		{
			SendClientMessageEx(playerid, COLOR_DARKGREEN, "ยินดีตอยรับเข้าสู่ร้าน %s", BusinessInfo[id][BusinessName]);
			SendClientMessage(playerid, COLOR_WHITE, "Available commands: /buy"); 
		}
	}
	return 1;
}


stock ShowPlayerBuyFood(playerid)
{
    BuyFood[playerid][0] = CreatePlayerTextDraw(playerid, 315.000000, 174.000000, "_");
	PlayerTextDrawFont(playerid, BuyFood[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, BuyFood[playerid][0], 0.600000, 13.350055);
	PlayerTextDrawTextSize(playerid, BuyFood[playerid][0], 298.500000, 350.000000);
	PlayerTextDrawSetOutline(playerid, BuyFood[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, BuyFood[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, BuyFood[playerid][0], 2);
	PlayerTextDrawColor(playerid, BuyFood[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, BuyFood[playerid][0], 1296911871);
	PlayerTextDrawUseBox(playerid, BuyFood[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, BuyFood[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][0], 0);

	BuyFood[playerid][1] = CreatePlayerTextDraw(playerid, 145.000000, 185.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, BuyFood[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid, BuyFood[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BuyFood[playerid][1], 89.500000, 85.500000);
	PlayerTextDrawSetOutline(playerid, BuyFood[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, BuyFood[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, BuyFood[playerid][1], 1);
	PlayerTextDrawColor(playerid, BuyFood[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][1], 125);
	PlayerTextDrawBoxColor(playerid, BuyFood[playerid][1], 255);
	PlayerTextDrawUseBox(playerid, BuyFood[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, BuyFood[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][1], 1);
	PlayerTextDrawSetPreviewModel(playerid, BuyFood[playerid][1], 2221);
	PlayerTextDrawSetPreviewRot(playerid, BuyFood[playerid][1], -10.000000, 0.000000, -61.000000, 0.780000);
	PlayerTextDrawSetPreviewVehCol(playerid, BuyFood[playerid][1], 1, 1);

	BuyFood[playerid][2] = CreatePlayerTextDraw(playerid, 269.000000, 185.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, BuyFood[playerid][2], 5);
	PlayerTextDrawLetterSize(playerid, BuyFood[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BuyFood[playerid][2], 89.500000, 85.500000);
	PlayerTextDrawSetOutline(playerid, BuyFood[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, BuyFood[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, BuyFood[playerid][2], 1);
	PlayerTextDrawColor(playerid, BuyFood[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][2], 125);
	PlayerTextDrawBoxColor(playerid, BuyFood[playerid][2], 255);
	PlayerTextDrawUseBox(playerid, BuyFood[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, BuyFood[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][2], 1);
	PlayerTextDrawSetPreviewModel(playerid, BuyFood[playerid][2], 2222);
	PlayerTextDrawSetPreviewRot(playerid, BuyFood[playerid][2], -10.000000, 0.000000, -61.000000, 0.780000);
	PlayerTextDrawSetPreviewVehCol(playerid, BuyFood[playerid][2], 1, 1);

	BuyFood[playerid][3] = CreatePlayerTextDraw(playerid, 390.000000, 185.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, BuyFood[playerid][3], 5);
	PlayerTextDrawLetterSize(playerid, BuyFood[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BuyFood[playerid][3], 89.500000, 85.500000);
	PlayerTextDrawSetOutline(playerid, BuyFood[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, BuyFood[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, BuyFood[playerid][3], 1);
	PlayerTextDrawColor(playerid, BuyFood[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][3], 125);
	PlayerTextDrawBoxColor(playerid, BuyFood[playerid][3], 255);
	PlayerTextDrawUseBox(playerid, BuyFood[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, BuyFood[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][3], 1);
	PlayerTextDrawSetPreviewModel(playerid, BuyFood[playerid][3], 2223);
	PlayerTextDrawSetPreviewRot(playerid, BuyFood[playerid][3], -10.000000, 0.000000, -61.000000, 0.780000);
	PlayerTextDrawSetPreviewVehCol(playerid, BuyFood[playerid][3], 1, 1);

	BuyFood[playerid][4] = CreatePlayerTextDraw(playerid, 477.000000, 166.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, BuyFood[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid, BuyFood[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BuyFood[playerid][4], 22.000000, 21.000000);
	PlayerTextDrawSetOutline(playerid, BuyFood[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, BuyFood[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, BuyFood[playerid][4], 1);
	PlayerTextDrawColor(playerid, BuyFood[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, BuyFood[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, BuyFood[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, BuyFood[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][4], 1);

	BuyFood[playerid][5] = CreatePlayerTextDraw(playerid, 146.000000, 256.000000, "$150");
	PlayerTextDrawFont(playerid, BuyFood[playerid][5], 2);
	PlayerTextDrawLetterSize(playerid, BuyFood[playerid][5], 0.166667, 1.450000);
	PlayerTextDrawTextSize(playerid, BuyFood[playerid][5], 232.000000, 22.000000);
	PlayerTextDrawSetOutline(playerid, BuyFood[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, BuyFood[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, BuyFood[playerid][5], 1);
	PlayerTextDrawColor(playerid, BuyFood[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, BuyFood[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, BuyFood[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, BuyFood[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][5], 0);

	BuyFood[playerid][6] = CreatePlayerTextDraw(playerid, 271.000000, 256.000000, "$200");
	PlayerTextDrawFont(playerid, BuyFood[playerid][6], 2);
	PlayerTextDrawLetterSize(playerid, BuyFood[playerid][6], 0.166667, 1.450000);
	PlayerTextDrawTextSize(playerid, BuyFood[playerid][6], 232.000000, 22.000000);
	PlayerTextDrawSetOutline(playerid, BuyFood[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, BuyFood[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, BuyFood[playerid][6], 1);
	PlayerTextDrawColor(playerid, BuyFood[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, BuyFood[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, BuyFood[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, BuyFood[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][6], 0);

	BuyFood[playerid][7] = CreatePlayerTextDraw(playerid, 393.000000, 256.000000, "$300");
	PlayerTextDrawFont(playerid, BuyFood[playerid][7], 2);
	PlayerTextDrawLetterSize(playerid, BuyFood[playerid][7], 0.166667, 1.450000);
	PlayerTextDrawTextSize(playerid, BuyFood[playerid][7], 232.000000, 22.000000);
	PlayerTextDrawSetOutline(playerid, BuyFood[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, BuyFood[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, BuyFood[playerid][7], 1);
	PlayerTextDrawColor(playerid, BuyFood[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, BuyFood[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, BuyFood[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, BuyFood[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, BuyFood[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, BuyFood[playerid][7], 0);


    for(new f = 0; f < 8; f++)
    {
        PlayerTextDrawShow(playerid, BuyFood[playerid][f]);
    }
    SelectTextDraw(playerid, 0xB4B5B7FF);
    return 1;
}


hook OP_ClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(PlayerInfo[playerid][pGUI] == 5)
    {
        if(playertextid == BuyFood[playerid][4])
        {
            for(new f = 0; f < 8; f++)
            {
                PlayerTextDrawDestroy(playerid, BuyFood[playerid][f]);
            }
            CancelSelectTextDraw(playerid);
            return 1;
        }
        if(playertextid == BuyFood[playerid][1])
        {
            new Float:HP, id = PlayerInfo[playerid][pInsideBusiness];
            GetPlayerHealth(playerid, HP);

            if(HP > 100)
                return SendErrorMessage(playerid, "คุณมีเลือดมากว่า 100");

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

            SendClientMessage(playerid, -1, "คุณได้ซื้ออาหารแล้ว เสียเงินไป $150");
            GiveMoney(playerid, -150);
            BusinessInfo[id][BusinessCash] += 150;

            GetMealOder(playerid);
            for(new f = 0; f < 8; f++)
            {
                PlayerTextDrawDestroy(playerid, BuyFood[playerid][f]);
            }
            CancelSelectTextDraw(playerid);

            CharacterSave(playerid);
            SaveBusiness(id);
            return 1;
        }
        if(playertextid == BuyFood[playerid][2])
        {
            new Float:HP, id = PlayerInfo[playerid][pInsideBusiness];
            GetPlayerHealth(playerid, HP);

            if(HP > 100)
                return SendErrorMessage(playerid, "คุณมีเลือดมากว่า 100");

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

            SendClientMessage(playerid, -1, "คุณได้ซื้ออาหารแล้ว เสียเงินไป $300");
            GiveMoney(playerid, -300);

            GetMealOder(playerid);
            for(new f = 0; f < 8; f++)
            {
                PlayerTextDrawDestroy(playerid, BuyFood[playerid][f]);
            }
            CancelSelectTextDraw(playerid);

            BusinessInfo[id][BusinessCash] += 300;
            CharacterSave(playerid);
            SaveBusiness(id);
            return 1;
        }
        if(playertextid == BuyFood[playerid][3])
        {
            new Float:HP, id = PlayerInfo[playerid][pInsideBusiness];
            GetPlayerHealth(playerid, HP);

            if(HP > 100)
                return SendErrorMessage(playerid, "คุณมีเลือดมากว่า 100");

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

            SendClientMessage(playerid, -1, "คุณได้ซื้ออาหารแล้ว เสียเงินไป $500");
            GiveMoney(playerid, -500);

            GetMealOder(playerid);
            for(new f = 0; f < 8; f++)
            {
                PlayerTextDrawDestroy(playerid, BuyFood[playerid][f]);
            }
            CancelSelectTextDraw(playerid);
            
            BusinessInfo[id][BusinessCash] += 500;
            CharacterSave(playerid);
            SaveBusiness(id);
            return 1;
        }
        return 1;
    }
    return 1;
}

stock GetMealOder(playerid)
{
    MealOder[playerid] = true;
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	SetPlayerAttachedObject(playerid,9, 2222, 5,0.165000,0.100999,0.139999,-78.300018,-11.500016,20.599998,1.000000,1.000000,1.000000);
    return 1;
}


hook OP_EditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(GetPVarInt(playerid, "MealEditPosObj"))
    {
        switch(response)
        {
            case EDIT_RESPONSE_FINAL:
            {
                if(IsValidDynamicObject(PlayerInfo[playerid][pObject][9]))
                    DestroyDynamicObject(PlayerInfo[playerid][pObject][9]);

                MealOder[playerid] = false;
                PlayerInfo[playerid][pObject][9] = CreateDynamicObject(2222, x, y, z, rx, ry, rz, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
                SendClientMessage(playerid, -1, "คุณได้วางถาดอาหารไว้ในจุดที่คุณต้องการแล้ว");
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

                return 1;
            }
            case EDIT_RESPONSE_CANCEL: 
            {
                GetMealOder(playerid);
                DeletePVar(playerid, "MealEditPosObj");
                SendClientMessage(playerid, -1, "คุณได้ยกเลิกการวางอาหารของคุณแล้ว");
                MealOder[playerid] = true;
                return 1;
            }
        }
    }
    return 1;
}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(PlayerInfo[playerid][pInsideBusiness])
    {
        new id = PlayerInfo[playerid][pInsideBusiness];

        if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_STORE)
            return 1;

        if(BusinessInfo[id][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
        {
            if(RELEASED(KEY_NO))
            {
                if(GetPVarInt(playerid, "ReadyRobing"))
                    return 1;

                if(gettime() - BusinessInfo[id][BizTimeRob] < 18000)//18000 = ชั่วโมง
                    return SendErrorMessage(playerid, "ร้านนนี้ยังไม่สามารถที่จะปล้นได้");

                
                SetPVarInt(playerid, "ReadyRobing", id);

                SendFactionMessageToAll(1 , COLOR_COP, "สัญญาญการแจ้งเตือนที่ %s (211)", BusinessInfo[id][BusinessName]);

                BusinessInfo[id][BizTimeRob] = gettime();
                SendClientMessage(playerid, COLOR_LIGHTRED, "คุณกำลังปล้นร้านสะดวกซื้อ..... (รอ 20 วิ)");
                SetTimerEx("RobingStoreWait", 20000, false, "dd", playerid, id);

            }
            return 1;
        }
    } 
    return 1;
}


forward RobingStoreWait(playerid, id);
public RobingStoreWait(playerid, id)
{
    if(PlayerInfo[playerid][pInsideBusiness] != id)
    {   
        DeletePVar(playerid, "ReadyRobing");
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ภายในกิจการที่คุณจะต้องการปล้นแล้ว");
    }

    if(!BusinessInfo[id][BusinessCash])
    {   
        DeletePVar(playerid, "ReadyRobing");
        return SendErrorMessage(playerid, "เงินภายในร้านนนี้ไม่มีให้ปล้นแล้ว");
    }

    new money = Random(1, BusinessInfo[id][BusinessCash] / 2);

    
    GiveMoney(playerid, money);
    BusinessInfo[id][BusinessCash] -= money;
    SendClientMessageEx(playerid, COLOR_LIGHTRED, "คุณได้ปล้นกิจการ %s สำเร็จแล้วได้เงินมาจำนวน $%s", BusinessInfo[id][BusinessName], MoneyFormat(money));
    return 1;
}


ptask BizTimeRobDely[1000]()
{
    for(new i = 1; i < MAX_BUSINESS; i++)
    {
        if(BusinessInfo[i][BizTimeRob])
        {
            BusinessInfo[i][BizTimeRob] --;
        }
        else
        {
            BusinessInfo[i][BizTimeRob] = 0;
        }
    }
    return 1;
}





