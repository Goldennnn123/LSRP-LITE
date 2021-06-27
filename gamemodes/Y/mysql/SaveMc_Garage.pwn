stock SaveMc_Garage(id, thread = MYSQL_TYPE_THREAD)
{
    new query[MAX_STRING];
    
    mysql_init("mc_garage", "Mc_GarageDBID", McGarageInfo[id][Mc_GarageDBID], thread);

    mysql_flo(query, "Mc_GaragePosX",McGarageInfo[id][Mc_GaragePos][0]);
    mysql_flo(query, "Mc_GaragePosY",McGarageInfo[id][Mc_GaragePos][1]);
    mysql_flo(query, "Mc_GaragePosZ",McGarageInfo[id][Mc_GaragePos][2]);

    mysql_int(query, "Mc_GarageWorld",McGarageInfo[id][Mc_GarageWorld]);
    mysql_int(query, "Mc_GarageInterior",McGarageInfo[id][Mc_GarageInterior]);
    mysql_finish(query);
    return 1;
}