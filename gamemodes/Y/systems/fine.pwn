hook OnGameModeInit()
{
    mysql_tquery(dbCon, "SELECT * FROM fine ORDER BY FineDBID", "LoadFines");
    return 1;
}

forward LoadFines();
public LoadFines()
{
    if(!cache_num_rows())
		return printf("[SERVER]: No Fines were loaded from \"%s\" database...", MYSQL_DB);

    new rows,countFine; cache_get_row_count(rows);

    for (new i = 0; i < rows && i < MAX_FINES; i ++)
    {
        cache_get_value_name_int(i,"FineDBID",FineInfo[i+1][FineDBID]);
        cache_get_value_name_int(i,"FineOwner",FineInfo[i+1][FineOwner]);
        cache_get_value_name(i,"FineReson",FineInfo[i+1][FineReson], 60);
        cache_get_value_name_int(i,"FinePrice",FineInfo[i+1][FinePrice]);
        cache_get_value_name_int(i,"FineBy",FineInfo[i+1][FineBy]);
        cache_get_value_name(i,"FineDate",FineInfo[i+1][FineDate], 60);
        countFine++;
    }
    printf("[SERVER]: %d Fines were loaded from \"%s\" database...", countFine, MYSQL_DB);
    return 1;
}