hook OnGameModeInit()
{
    mysql_tquery_file(MySQL_GetHandle(), "db/master.sql");
    print("[SQL] Install master.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/character.sql");
    print("[SQL] Install character.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/kick_logs.sql");
    print("[SQL] Install kick_logs.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/banlog.sql");
    print("[SQL] Install banlog.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/bannedlist.sql");
    print("[SQL] Install bannedlist.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/ajaillog.sql");
    print("[SQL] Install ajaillog.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/phonebook.sql");
    print("[SQL] Install phonebook.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/vehicles.sql");
    print("[SQL] Install vehicles.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/vehicles.sql");
    print("[SQL] Install vehicles.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/factions.sql");
    print("[SQL] Install factions.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/faction_ranks.sql");
    print("[SQL] Install faction_ranks.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/vehicle_faction.sql");
    print("[SQL] Install vehicle_faction.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/house.sql");
    print("[SQL] Install house.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/entrance.sql");
    print("[SQL] Install entrance.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/computer.sql");
    print("[SQL] Install computer.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/business.sql");
    print("[SQL] Install business.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/mc_garage.sql");
    print("[SQL] Install mc_garage.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/arrest.sql");
    print("[SQL] Install Arrest.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/fine.sql");
    print("[SQL] Install fine.sql");


    mysql_tquery_file(MySQL_GetHandle(), "db/fine.sql");
    print("[SQL] Install Arrest.sql");

    mysql_tquery_file(MySQL_GetHandle(), "db/gps.sql");
    print("[SQL] Install gps.sql");


    return 1;
}
