stock SaveEntrance(id, thread = MYSQL_TYPE_THREAD)
{
    new query[MAX_STRING];

    mysql_init("entrance", "EntranceDBID", EntranceInfo[id][EntranceDBID], thread);

    mysql_int(query, "EntranceIconID",EntranceInfo[id][EntranceIconID]);
    mysql_flo(query, "EntranceLocX",EntranceInfo[id][EntranceLoc][0]);
    mysql_flo(query, "EntranceLocY",EntranceInfo[id][EntranceLoc][1]);
    mysql_flo(query, "EntranceLocZ",EntranceInfo[id][EntranceLoc][2]);
    mysql_int(query, "EntranceLocWorld",EntranceInfo[id][EntranceLocWorld]);
    mysql_int(query, "EntranceLocInID",EntranceInfo[id][EntranceLocInID]);


    mysql_flo(query, "EntranceLocInX",EntranceInfo[id][EntranceLocIn][0]);
    mysql_flo(query, "EntranceLocInY",EntranceInfo[id][EntranceLocIn][1]);
    mysql_flo(query, "EntranceLocInZ",EntranceInfo[id][EntranceLocIn][2]);
    mysql_int(query, "EntanceLocInWorld",EntranceInfo[id][EntanceLocInWorld]);
    mysql_int(query, "EntranceLocInInID",EntranceInfo[id][EntranceLocInInID]);
    mysql_finish(query);

    return 1;
}