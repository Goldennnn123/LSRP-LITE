#include <YSI\y_hooks>


#define BUSINESS_TYPE_STORE         (1)
#define BUSINESS_TYPE_DEALERVEHICLE (2)
#define BUSINESS_TYPE_AMMUNITION    (3)
#define BUSINESS_TYPE_RESTAURANT    (4)
#define BUSINESS_TYPE_BANK          (5)

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