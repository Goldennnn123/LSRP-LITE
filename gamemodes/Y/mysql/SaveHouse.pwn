stock Savehouse(id, thread = MYSQL_TYPE_THREAD)
{
    new query[MAX_STRING], str[100];

    mysql_init("house", "HouseDBID", HouseInfo[id][HouseDBID], thread);

    mysql_str(query, "HouseName",HouseInfo[id][HouseName]);
    mysql_int(query, "HouseOwnerDBID",HouseInfo[id][HouseOwnerDBID]);

    mysql_flo(query, "HouseEntranceX",HouseInfo[id][HouseEntrance][0]);
    mysql_flo(query, "HouseEntranceY",HouseInfo[id][HouseEntrance][1]);
    mysql_flo(query, "HouseEntranceZ",HouseInfo[id][HouseEntrance][2]);
    mysql_int(query, "HouseEntranceWorld",HouseInfo[id][HouseEntranceWorld]);
    mysql_int(query, "HouseEntranceInterior",HouseInfo[id][HouseEntranceInterior]);

    mysql_flo(query, "HouseInteriorX",HouseInfo[id][HouseInterior][0]);
    mysql_flo(query, "HouseInteriorY",HouseInfo[id][HouseInterior][1]);
    mysql_flo(query, "HouseInteriorZ",HouseInfo[id][HouseInterior][2]);
    mysql_int(query, "HouseInteriorWorld",HouseInfo[id][HouseInteriorWorld]);
    mysql_int(query, "HouseInteriorID",HouseInfo[id][HouseInteriorID]);

    mysql_int(query, "HousePrice",HouseInfo[id][HousePrice]);
    mysql_int(query, "HouseLevel",HouseInfo[id][HouseLevel]);
    mysql_int(query, "HouseLock",HouseInfo[id][HouseLock]);


    mysql_flo(query, "HousePlacePosX",HouseInfo[id][HousePlacePos][0]);
    mysql_flo(query, "HousePlacePosY",HouseInfo[id][HousePlacePos][1]);
    mysql_flo(query, "HousePlacePosZ",HouseInfo[id][HousePlacePos][2]);



    for(new i = 1; i < 22; i++)
    {
        format(str, sizeof(str), "HouseWeapons%d",i);
        mysql_int(query, str,HouseInfo[id][HouseWeapons][i]);
        format(str, sizeof(str), "HouseWeaponsAmmo%d",i);
        mysql_int(query, str,HouseInfo[id][HouseWeaponsAmmo][i]);
    }

    mysql_int(query, "HouseEle",HouseInfo[id][HouseEle]);
    mysql_int(query, "HouseStockCPU",HouseInfo[id][HouseStockCPU]);
    mysql_int(query, "HouseStockGPU",HouseInfo[id][HouseStockGPU]);
    mysql_int(query, "HouseStockRAM",HouseInfo[id][HouseStockRAM]);
    mysql_int(query, "HouseStockStored",HouseInfo[id][HouseStockStored]);


    mysql_finish(query);
    return 1;
}