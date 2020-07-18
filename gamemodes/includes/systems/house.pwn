
#include <YSI\y_hooks>

new PlayerCreHouse[MAX_PLAYERS][90],
    PlayerCreHousePrice[MAX_PLAYERS],
    PlayerCreHouseLevel[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    PlayerCreHouse[playerid] = "";
    PlayerCreHousePrice[playerid] = 0;
    PlayerCreHouseLevel[playerid] = 0;
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

        cache_get_value_name_float(i,"HousePlacePosX",HouseInfo[i+1][HousePlacePos][0]);
        cache_get_value_name_float(i,"HousePlacePosY",HouseInfo[i+1][HousePlacePos][1]);
        cache_get_value_name_float(i,"HousePlacePosZ",HouseInfo[i+1][HousePlacePos][2]);


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
        
        if(HouseInfo[i+1][HouseOwnerDBID])
        {
            HouseInfo[i+1][HousePickup] = CreateDynamicPickup(1272, 23, HouseInfo[i+1][HouseEntrance][0], HouseInfo[i+1][HouseEntrance][1], HouseInfo[i+1][HouseEntrance][2],-1,-1);
        }
        else
        {
            HouseInfo[i+1][HousePickup] = CreateDynamicPickup(1273, 23, HouseInfo[i+1][HouseEntrance][0], HouseInfo[i+1][HouseEntrance][1], HouseInfo[i+1][HouseEntrance][2],-1,-1);
        }
        countHouse++;
    }

	printf("[SERVER]: %i House were loaded from \"%s\" database...", countHouse, MYSQL_DB);
    return 1;
}


Dialog:DIALOG_CRE_HOUSE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return SendClientMessage(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} ยกเลิกการสร้างบ้าน");

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
            return SendServerMessage(playerid, "สร้าบบ้านเกินกว่านี้ไม่ได้แล้ว (30)"); 
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
        SendClientMessageEx(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF} คุณได้สร้างบ้าน ID {66FFFF}%i {FFFFFF}แล้ว",HouseInfo[idx][HouseDBID]);

        format(str, sizeof(str), "{27AE60}HOUSE {F39C12}SYSTEM:{FFA000} %s {FFFFFF}ได้สร้างบ้าน ID {66FFFF}%i {FFFFFF}แล้ว",ReturnRealName(playerid),HouseInfo[idx][HouseDBID]);
		SendAdminMessage(2, str);
    }
    return 1;
}