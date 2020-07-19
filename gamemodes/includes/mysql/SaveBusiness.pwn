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
    return 1;
}