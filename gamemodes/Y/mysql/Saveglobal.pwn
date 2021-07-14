stock Saveglobal(thread = MYSQL_TYPE_THREAD)
{
    new query[150];
	mysql_init("global", "ID",1, thread);

	mysql_int(query, "G_BITSAMP",GlobalInfo[G_BITSAMP]);
    mysql_int(query, "G_GovCash",GlobalInfo[G_GovCash]);
    mysql_flo(query, "G_BitStock",GlobalInfo[G_BitStock]);

	mysql_finish(query);
    return 1;
}