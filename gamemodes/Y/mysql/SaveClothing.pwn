stock SaveClothing(id, thread = MYSQL_TYPE_THREAD)
{
    new query[MAX_STRING];

    mysql_init("clothing", "ClothingDBID", ClothingData[id][C_ID], thread);

    mysql_int(query, "ClothingOwnerDBID", ClothingData[id][C_Owner]);
    mysql_int(query, "ClothingSpawn", ClothingData[id][C_Spawn]);

    mysql_int(query, "ClothingModel", ClothingData[id][C_Model]);
    mysql_int(query, "ClothingIndex", ClothingData[id][C_Index]);
    mysql_int(query, "ClothingBone", ClothingData[id][C_Bone]);

    mysql_flo(query, "ClothingOffPosX", ClothingData[id][C_OFFPOS][0]);
    mysql_flo(query, "ClothingOffPosY", ClothingData[id][C_OFFPOS][1]);
    mysql_flo(query, "ClothingOffPosZ", ClothingData[id][C_OFFPOS][2]);

    mysql_flo(query, "ClothingOffPosRX", ClothingData[id][C_OFFPOSR][0]);
    mysql_flo(query, "ClothingOffPosRY", ClothingData[id][C_OFFPOSR][1]);
    mysql_flo(query, "ClothingOffPosRZ", ClothingData[id][C_OFFPOSR][2]);

    mysql_flo(query, "ClothingOffPosSacalX", ClothingData[id][C_OFFPOSS][0]);
    mysql_flo(query, "ClothingOffPosSacalY", ClothingData[id][C_OFFPOSS][1]);
    mysql_flo(query, "ClothingOffPosSacalZ", ClothingData[id][C_OFFPOSS][2]);
    
    mysql_finish(query);
    return 1;
}