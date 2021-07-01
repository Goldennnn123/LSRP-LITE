#include <YSI_Coding\y_hooks>



forward LoadGlobal();
public LoadGlobal()
{
    if(!cache_num_rows())
		return printf("[SERVER]: Error Load Global \"%s\" database...", MYSQL_DB);

    new rows; cache_get_row_count(rows);
    for (new i = 0; i < rows; i ++)
    {
        cache_get_value_name_int(i,"G_BITSAMP",GlobalInfo[G_BITSAMP]);
        cache_get_value_name_int(i,"G_GovCash",GlobalInfo[G_GovCash]);
    }

    printf("[SERVER]: Load Global \"%s\" database...", MYSQL_DB);
    return 1;
}