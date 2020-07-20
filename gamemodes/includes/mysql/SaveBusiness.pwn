stock SaveBusiness(id)
{
    new query[MAX_STRING];
    mysql_format(dbCon, query, sizeof(query),"UPDATE business SET BusinessName = '%e', BusinessOwnerDBID = %i, BusinessType = %i, BusinessEntranceX = %f, BusinessEntranceY = %f, BusinessEntranceZ = %f, BusinessEntranceWorld = %i, BusinessEntranceInterior = %i WHERE BusinessDBID = %i",
        BusinessInfo[id][BusinessName],
        BusinessInfo[id][BusinessOwnerDBID],
        BusinessInfo[id][BusinessType],
        BusinessInfo[id][BusinessEntrance][0],
        BusinessInfo[id][BusinessEntrance][1],
        BusinessInfo[id][BusinessEntrance][2],
        BusinessInfo[id][BusinessEntranceWorld],
        BusinessInfo[id][BusinessEntranceInterior],
        BusinessInfo[id][BusinessDBID]);
    mysql_tquery(dbCon, query);


    mysql_format(dbCon, query, sizeof(query),"UPDATE business SET BusinessInteriorX = %f, BusinessInteriorY = %f, BusinessInteriorZ = %f, BusinessInteriorWorld = %i, BusinessInteriorID = %i WHERE BusinessDBID = %i",
        BusinessInfo[id][BusinessInterior][0],
        BusinessInfo[id][BusinessInterior][1],
        BusinessInfo[id][BusinessInterior][2],
        BusinessInfo[id][BusinessInteriorWorld],
        BusinessInfo[id][BusinessInteriorID],
        BusinessInfo[id][BusinessDBID]);
    mysql_tquery(dbCon, query);


    mysql_format(dbCon, query, sizeof(query),"UPDATE business SET BusinessBankPickupLocX = %f, BusinessBankPickupLocY = %f, BusinessBankPickupLocZ = %f, BusinessBankWorld = %i WHERE BusinessDBID = %i",
        BusinessInfo[id][BusinessBankPickupLoc][0],
        BusinessInfo[id][BusinessBankPickupLoc][1],
        BusinessInfo[id][BusinessBankPickupLoc][2],
        BusinessInfo[id][BusinessBankWorld],
        BusinessInfo[id][BusinessDBID]);
    mysql_tquery(dbCon, query);

    mysql_format(dbCon, query, sizeof(query),"UPDATE business SET BusinessCash = %d WHERE BusinessDBID = %i",
        BusinessInfo[id][BusinessCash],
        BusinessInfo[id][BusinessDBID]);
    mysql_tquery(dbCon, query);

    mysql_format(dbCon, query, sizeof(query),"UPDATE business SET BusinessPrice = %d,BusinessLevel = %d,BusinessEntrancePrice = %d WHERE BusinessDBID = %i",
        BusinessInfo[id][BusinessPrice],
        BusinessInfo[id][Businesslevel],
        BusinessInfo[id][BusinessEntrancePrice],
        BusinessInfo[id][BusinessDBID]);
    mysql_tquery(dbCon, query);

    mysql_format(dbCon, query, sizeof(query),"UPDATE business SET BusinessLock = %d WHERE BusinessDBID = %i",
        BusinessInfo[id][BusinessLock],
        BusinessInfo[id][BusinessDBID]);
    mysql_tquery(dbCon, query);

    return 1;
}