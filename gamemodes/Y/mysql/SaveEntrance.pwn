stock SaveEntrance(id)
{
    new query[MAX_STRING];
    
    mysql_format(dbCon, query, sizeof(query),"UPDATE entrance SET EntranceIconID = %d WHERE EntranceDBID = %i",
        EntranceInfo[id][EntranceIconID],
        EntranceInfo[id][EntranceDBID]);
    mysql_tquery(dbCon, query);

    mysql_format(dbCon, query, sizeof(query),"UPDATE entrance SET EntranceLocX = %f, EntranceLocY = %f, EntranceLocZ = %f, EntranceLocWorld = %d, EntranceLocInID = %d WHERE EntranceDBID = %i",
        EntranceInfo[id][EntranceLoc][0],
        EntranceInfo[id][EntranceLoc][1],
        EntranceInfo[id][EntranceLoc][2],
        EntranceInfo[id][EntranceLocWorld],
        EntranceInfo[id][EntranceLocInID],
        EntranceInfo[id][EntranceDBID]);
    mysql_tquery(dbCon, query);

    mysql_format(dbCon, query, sizeof(query),"UPDATE entrance SET EntranceLocInX = %f, EntranceLocInY = %f, EntranceLocInZ = %f, EntanceLocInWorld = %d, EntranceLocInInID = %d WHERE EntranceDBID = %i",
        EntranceInfo[id][EntranceLocIn][0],
        EntranceInfo[id][EntranceLocIn][1],
        EntranceInfo[id][EntranceLocIn][2],
        EntranceInfo[id][EntanceLocInWorld],
        EntranceInfo[id][EntranceLocInInID],
        EntranceInfo[id][EntranceDBID]);
    mysql_tquery(dbCon, query);
    return 1;
}