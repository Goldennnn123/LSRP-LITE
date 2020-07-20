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


        if(IsValidDynamicPickup(BusinessInfo[i+1][BusinessBankPickup]))
            DestroyDynamicPickup(BusinessInfo[i+1][BusinessBankPickup]);

        if(BusinessInfo[i+1][BusinessType] == BUSINESS_TYPE_RESTAURANT)
        {
            if(BusinessInfo[i+1][BusinessOwnerDBID])
            {
                BusinessInfo[i+1][BusinessBankPickup] = CreateDynamicPickup(1239, 23, BusinessInfo[i+1][BusinessEntrance][0], BusinessInfo[i+1][BusinessEntrance][1], BusinessInfo[i+1][BusinessEntrance][2],-1,-1);
            }
            else
            {
                BusinessInfo[i+1][BusinessBankPickup] = CreateDynamicPickup(1274, 23, BusinessInfo[i+1][BusinessEntrance][0], BusinessInfo[i+1][BusinessEntrance][1], BusinessInfo[i+1][BusinessEntrance][2],-1,-1);
            }
        }
        else
        {
            BusinessInfo[i+1][BusinessBankPickup] = CreateDynamicPickup(1239, 23, BusinessInfo[i+1][BusinessEntrance][0], BusinessInfo[i+1][BusinessEntrance][1], BusinessInfo[i+1][BusinessEntrance][2],-1,-1);
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
        case 1: Dialog_Show(playerid, DIALOG_BU_NAME, DIALOG_STYLE_INPUT, "เปลี่ยนชื่อกิจการ","ใส่ชื่อกิจการใหม่ของคุณ:", "ยืนยัน", "ยกเลิก");
        case 2: ShowSelectBusinessType(playerid);
        case 3:
        {
            new id = PlayerSelectBusiness[playerid];
            GetPlayerPos(playerid,BusinessInfo[id][BusinessEntrance][0],BusinessInfo[id][BusinessEntrance][1],BusinessInfo[id][BusinessEntrance][2]);
            
            BusinessInfo[id][BusinessEntranceWorld] = GetPlayerVirtualWorld(playerid);
            BusinessInfo[id][BusinessEntranceInterior] = GetPlayerInterior(playerid);

            if(IsValidDynamicPickup(BusinessInfo[id][BusinessBankPickup]))
                DestroyDynamicPickup(BusinessInfo[id][BusinessBankPickup]);

            if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_RESTAURANT)
            {
                if(BusinessInfo[id][BusinessOwnerDBID])
                {
                    BusinessInfo[id][BusinessBankPickup] = CreateDynamicPickup(1239, 23, BusinessInfo[id][BusinessEntrance][0], BusinessInfo[id][BusinessEntrance][1], BusinessInfo[id][BusinessEntrance][2],-1,-1);
                }
                else
                {
                    BusinessInfo[id][BusinessBankPickup] = CreateDynamicPickup(1274, 23, BusinessInfo[id][BusinessEntrance][0], BusinessInfo[id][BusinessEntrance][1], BusinessInfo[id][BusinessEntrance][2],-1,-1);
                }
            }
            else
            {
                BusinessInfo[id][BusinessBankPickup] = CreateDynamicPickup(1239, 23, BusinessInfo[id][BusinessEntrance][0], BusinessInfo[id][BusinessEntrance][1], BusinessInfo[id][BusinessEntrance][2],-1,-1);
            }

            SendClientMessage(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} คุณได้เปลี่ยนจุดหน้าร้านแล้ว");
            SaveBusiness(id);
            return ShowSelectBusiness(playerid);
        }
        case 4:
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
            BusinessInfo[id][BusinessEntranceInterior] = GetPlayerInterior(playerid);

            if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_BANK)
            {
                for(new m = 0; m < 3; m++)
                {
                    BusinessInfo[id][BusinessBankPickupLoc][m] = 0;
                }
                SendClientMessage(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FF0033}เตือน!{D81B60} กรุณาไปวาง 'BankPickup ใหม่เนื่องจากมีการเปลี่ยน Inteior ภายใน'");
            }

            SendClientMessage(playerid, -1, "{0D47A1}BUSINESS {F57C00}SYSTEM:{FFFFFF} คุณได้เปลี่ยนจุดภายในร้านแล้ว");
            SaveBusiness(id);
            return ShowSelectBusiness(playerid);
        }
        case 5:
        {
            new id = PlayerSelectBusiness[playerid];
            GetPlayerPos(playerid,BusinessInfo[id][BusinessBankPickupLoc][0],BusinessInfo[id][BusinessBankPickupLoc][1],BusinessInfo[id][BusinessBankPickupLoc][2]);
            BusinessInfo[id][BusinessBankWorld] = GetPlayerVirtualWorld(playerid);

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
            SaveBusiness(id);
        }
        case 1:
        {
            BusinessInfo[id][BusinessType] = BUSINESS_TYPE_DEALERVEHICLE;
            SaveBusiness(id);
        }
        case 2:
        {
            BusinessInfo[id][BusinessType] = BUSINESS_TYPE_AMMUNITION;
            SaveBusiness(id);
        }
        case 3:
        {
            BusinessInfo[id][BusinessType] = BUSINESS_TYPE_RESTAURANT;
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
