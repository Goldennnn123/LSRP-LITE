stock SaveMc_Garage(id)
{
    new query[MAX_STRING];
    
    mysql_format(dbCon, query, sizeof(query),"UPDATE mc_garage SET Mc_GaragePosX = %f, Mc_GaragePosY = %f, Mc_GaragePosZ = %f, Mc_GarageWorld = %d, Mc_GarageInterior = %d WHERE Mc_GarageDBID = %i",
        McGarageInfo[id][Mc_GaragePos][0],
        McGarageInfo[id][Mc_GaragePos][1],
        McGarageInfo[id][Mc_GaragePos][2],
        McGarageInfo[id][Mc_GarageWorld],
        McGarageInfo[id][Mc_GarageInterior],
        McGarageInfo[id][Mc_GarageDBID]);
    mysql_tquery(dbCon, query);
    return 1;
}