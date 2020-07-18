stock Savehouse(id)
{
    new query[MAX_STRING];
    mysql_format(dbCon, query, sizeof(query),"UPDATE house SET HouseName = '%e', HouseOwnerDBID = %i, HouseEntranceX = %f, HouseEntranceY = %f, HouseEntranceZ = %f, HouseEntranceWorld = %i, HouseEntranceInterior = %i WHERE HouseDBID = %i",
        HouseInfo[id][HouseName],
        HouseInfo[id][HouseOwnerDBID],
        HouseInfo[id][HouseEntrance][0],
        HouseInfo[id][HouseEntrance][1],
        HouseInfo[id][HouseEntrance][2],
        HouseInfo[id][HouseEntranceWorld],
        HouseInfo[id][HouseEntranceInterior],
        HouseInfo[id][HouseDBID]);
    mysql_tquery(dbCon, query);

    mysql_format(dbCon, query, sizeof(query),"UPDATE house SET HouseInteriorX = %f, HouseInteriorY = %f, HouseInteriorZ = %f, HouseInteriorWorld = %i, HouseInteriorID = %i WHERE HouseDBID = %i",
        HouseInfo[id][HouseInterior][0],
        HouseInfo[id][HouseInterior][1],
        HouseInfo[id][HouseInterior][2],
        HouseInfo[id][HouseInteriorWorld],
        HouseInfo[id][HouseInteriorID],
        HouseInfo[id][HouseDBID]);
    mysql_tquery(dbCon, query);

    mysql_format(dbCon, query, sizeof(query),"UPDATE house SET HousePrice = %d, HouseLevel = %d WHERE HouseDBID = %i",
        HouseInfo[id][HousePrice],
        HouseInfo[id][HouseLevel],
        HouseInfo[id][HouseDBID]);
    mysql_tquery(dbCon, query);

    mysql_format(dbCon, query, sizeof(query),"UPDATE house SET HousePlacePosX = %f, HousePlacePosY = %f, HousePlacePosZ = %f WHERE HouseDBID = %i",
        HouseInfo[id][HousePlacePos][0],
        HouseInfo[id][HousePlacePos][1],
        HouseInfo[id][HousePlacePos][2],
        HouseInfo[id][HouseDBID]);
    mysql_tquery(dbCon, query);

    for(new i = 1; i < 22; i++)
    {
        mysql_format(dbCon, query, sizeof(query),"UPDATE house SET HouseWeapons%d = %d WHERE HouseDBID = %i",
        i,
        HouseInfo[id][HouseWeapons][i],
        HouseInfo[id][HouseDBID]);
        mysql_tquery(dbCon, query);
    }
    for(new i = 1; i < 22; i++)
    {
        mysql_format(dbCon, query, sizeof(query),"UPDATE house SET HouseWeaponsAmmo%d = %d WHERE HouseDBID = %i",
        i,
        HouseInfo[id][HouseWeaponsAmmo][i],
        HouseInfo[id][HouseDBID]);
        mysql_tquery(dbCon, query);
    }


    return 1;
}