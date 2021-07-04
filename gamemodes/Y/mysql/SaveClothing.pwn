stock SaveClothing(id, thread = MYSQL_TYPE_THREAD)
{
    new query[MAX_STRING];

    mysql_init("clothing", "ClothingDBID", ClothingInfo[id][ClothingDBID], thread);

    mysql_int(query, "ClothingOwnerDBID", ClothingInfo[id][ClothingOwnerDBID]);
    mysql_int(query, "ClothingSpawn", ClothingInfo[id][ClothingSpawn]);

    mysql_int(query, "ClothingModel", ClothingInfo[id][ClothingModel]);
    mysql_int(query, "ClothingIndex", ClothingInfo[id][ClothingIndex]);
    mysql_int(query, "ClothingBone", ClothingInfo[id][ClothingBone]);

    mysql_flo(query, "ClothingOffPosX", ClothingInfo[id][ClothingOffPos][0]);
    mysql_flo(query, "ClothingOffPosY", ClothingInfo[id][ClothingOffPos][1]);
    mysql_flo(query, "ClothingOffPosZ", ClothingInfo[id][ClothingOffPos][2]);

    mysql_flo(query, "ClothingOffPosRX", ClothingInfo[id][ClothingOffPosR][0]);
    mysql_flo(query, "ClothingOffPosRY", ClothingInfo[id][ClothingOffPosR][1]);
    mysql_flo(query, "ClothingOffPosRZ", ClothingInfo[id][ClothingOffPosR][2]);

    mysql_flo(query, "ClothingOffPosSacalX", ClothingInfo[id][ClothingOffPosSacal][0]);
    mysql_flo(query, "ClothingOffPosSacalY", ClothingInfo[id][ClothingOffPosSacal][1]);
    mysql_flo(query, "ClothingOffPosSacalZ", ClothingInfo[id][ClothingOffPosSacal][2]);
    
    mysql_finish(query);
    return 1;
}