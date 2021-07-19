#include <YSI_Coding\y_hooks>



forward LoadGlobal();
public LoadGlobal()
{
    if(!cache_num_rows())
		{
        new query[255];
        mysql_format(dbCon, query, sizeof(query), "INSERT INTO `global`(`G_BITSAMP`, `G_GovCash`, `G_BITStock`) VALUES ('10000','20000','5')");
        mysql_tquery(dbCon, query);
        printf("[SERVER]: Insert Global \"%s\" database...", MYSQL_DB);
        return 1;
    }

    new rows; cache_get_row_count(rows);
    for (new i = 0; i < rows; i ++)
    {
        cache_get_value_name_int(i,"G_BITSAMP",GlobalInfo[G_BITSAMP]);
        cache_get_value_name_int(i,"G_GovCash",GlobalInfo[G_GovCash]);
        cache_get_value_name_float(i,"G_BITStock",GlobalInfo[G_BitStock]);
    }

    printf("[SERVER]: Load Global \"%s\" database...", MYSQL_DB);
    return 1;
}