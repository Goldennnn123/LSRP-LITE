stock SaveComputer(id, thread = MYSQL_TYPE_THREAD)
{
    new query[MAX_STRING], str[120];

    mysql_init("computer", "ComputerDBID", ComputerInfo[id][ComputerDBID], thread);

    mysql_int(query, "ComputerCPU",ComputerInfo[id][ComputerCPU]);
    mysql_int(query, "ComputerRAM",ComputerInfo[id][ComputerRAM]);

    mysql_int(query, "ComputerSpawn",ComputerInfo[id][ComputerSpawn]);

    for(new i = 1; i < 6; i++)
    {
        format(str, sizeof(str), "ComputerGPU%d",i);
        mysql_int(query, str,ComputerInfo[id][ComputerGPU][i-1]);
    }

    mysql_int(query, "ComputerStored",ComputerInfo[id][ComputerStored]);
    mysql_flo(query, "ComputerPosX",ComputerInfo[id][ComputerPos][0]);
    mysql_flo(query, "ComputerPosY",ComputerInfo[id][ComputerPos][1]);
    mysql_flo(query, "ComputerPosZ",ComputerInfo[id][ComputerPos][2]);
    mysql_flo(query, "ComputerPosRX",ComputerInfo[id][ComputerPos][3]);
    mysql_flo(query, "ComputerPosRY",ComputerInfo[id][ComputerPos][4]);
    mysql_flo(query, "ComputerPosRZ",ComputerInfo[id][ComputerPos][5]);


    mysql_int(query, "ComputerPosWorld",ComputerInfo[id][ComputerPosWorld]);
    mysql_int(query, "ComputerPosInterior",ComputerInfo[id][ComputerPosInterior]);
    mysql_int(query, "ComputerStartBTC",ComputerInfo[id][ComputerStartBTC]);
    mysql_flo(query, "ComputerBTC",ComputerInfo[id][ComputerBTC]);
    mysql_finish(query);
    return 1;
}