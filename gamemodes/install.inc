hook OnGameModeInit()
{
    mysql_tquery_file(MySQL_GetHandle(), "db/lsrplite.sql");
    print("[SQL] Install MY SQL");

    return 1;
}
