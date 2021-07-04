#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    mysql_tquery(dbCon, "SELECT * FROM clothing ORDER BY ClothingDBID", "LoadClothing");
    return 1;
}

forward LoadClothing();
public LoadClothing()
{
    if(!cache_num_rows())
		return printf("[SERVER]: Error Clothing \"%s\" database...", MYSQL_DB);

    new rows; cache_get_row_count(rows);
    for (new i = 0; i < rows && i < MAX_CLOTHING; i ++)
    {
        cache_get_value_name_int(i,"ClothingDBID",ClothingInfo[i+1][ClothingDBID]);
        cache_get_value_name_int(i,"ClothingOwnerDBID",ClothingInfo[i+1][ClothingOwnerDBID]);
        cache_get_value_name_int(i,"ClothingSpawn",ClothingInfo[i+1][ClothingSpawn]);

        cache_get_value_name_int(i,"ClothingModel",ClothingInfo[i+1][ClothingModel]);
        cache_get_value_name_int(i,"ClothingIndex",ClothingInfo[i+1][ClothingIndex]);
        cache_get_value_name_int(i,"ClothingBone",ClothingInfo[i+1][ClothingBone]);

        cache_get_value_name_float(i,"ClothingOffPosX",ClothingInfo[i+1][ClothingOffPos][0]);
        cache_get_value_name_float(i,"ClothingOffPosY",ClothingInfo[i+1][ClothingOffPos][1]);
        cache_get_value_name_float(i,"ClothingOffPosZ",ClothingInfo[i+1][ClothingOffPos][2]);

        cache_get_value_name_float(i,"ClothingOffPosRX",ClothingInfo[i+1][ClothingOffPosR][0]);
        cache_get_value_name_float(i,"ClothingOffPosRY",ClothingInfo[i+1][ClothingOffPosR][1]);
        cache_get_value_name_float(i,"ClothingOffPosRZ",ClothingInfo[i+1][ClothingOffPosR][2]);

        cache_get_value_name_float(i,"ClothingOffPosRX",ClothingInfo[i+1][ClothingOffPosR][0]);
        cache_get_value_name_float(i,"ClothingOffPosRY",ClothingInfo[i+1][ClothingOffPosR][1]);
        cache_get_value_name_float(i,"ClothingOffPosRZ",ClothingInfo[i+1][ClothingOffPosR][2]);

        cache_get_value_name_float(i,"ClothingOffPosSacalX",ClothingInfo[i+1][ClothingOffPosSacal][0]);
        cache_get_value_name_float(i,"ClothingOffPosSacalY",ClothingInfo[i+1][ClothingOffPosSacal][1]);
        cache_get_value_name_float(i,"ClothingOffPosSacalZ",ClothingInfo[i+1][ClothingOffPosSacal][2]);
    }
    printf("[SERVER]: Load Clothing \"%s\" database...", MYSQL_DB);
    return 1;
}