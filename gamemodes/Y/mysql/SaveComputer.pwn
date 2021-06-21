stock SaveComputer(id)
{
    new query[1000];

    mysql_format(dbCon, query, sizeof(query), "UPDATE computer SET ComputerOwnerDBID = %d, ComputerOn = %d, ComputerSpawn = %d, ComputerHouseDBID = %d WHERE ComputerDBID = %d",
        ComputerInfo[id][ComputerOwnerDBID],
        ComputerInfo[id][ComputerOn],
        ComputerInfo[id][ComputerSpawn],
        ComputerInfo[id][ComputerHouseDBID],
        ComputerInfo[id][ComputerDBID]);
    mysql_tquery(dbCon, query);

    mysql_format(dbCon, query, sizeof(query), "UPDATE computer SET ComputerCPU = %d, ComputerRAM = %d, ComputerGPU1 = %d, ComputerGPU2 = %d, ComputerGPU3 = %d, ComputerGPU4 = %d, ComputerGPU5 = %d, ComputerStored = %d WHERE ComputerDBID = %d",
        ComputerInfo[id][ComputerCPU],
        ComputerInfo[id][ComputerRAM],
        ComputerInfo[id][ComputerGPU][0],
        ComputerInfo[id][ComputerGPU][1],
        ComputerInfo[id][ComputerGPU][2],
        ComputerInfo[id][ComputerGPU][3],
        ComputerInfo[id][ComputerGPU][4],
        ComputerInfo[id][ComputerStored],
        ComputerInfo[id][ComputerDBID]);
    mysql_tquery(dbCon, query);


    mysql_format(dbCon, query, sizeof(query), "UPDATE computer SET ComputerPosX = %f, ComputerPosY = %f, ComputerPosZ = %f, ComputerPosRX = %f, ComputerPosRY = %f, ComputerPosRZ = %f WHERE ComputerDBID = %d",
        ComputerInfo[id][ComputerPos][0],
        ComputerInfo[id][ComputerPos][1],
        ComputerInfo[id][ComputerPos][2],
        ComputerInfo[id][ComputerPos][3],
        ComputerInfo[id][ComputerPos][4],
        ComputerInfo[id][ComputerPos][5],
        ComputerInfo[id][ComputerDBID]);
    mysql_tquery(dbCon, query);

    mysql_format(dbCon, query, sizeof(query), "UPDATE computer SET ComputerPosWorld = %d, ComputerPosInterior = %d, ComputerStartBTC = %d, ComputerBTC = %.5f WHERE ComputerDBID = %d",
        ComputerInfo[id][ComputerPosWorld],
        ComputerInfo[id][ComputerPosInterior],
        ComputerInfo[id][ComputerStartBTC],
        ComputerInfo[id][ComputerBTC],
        ComputerInfo[id][ComputerDBID]);
    mysql_tquery(dbCon, query);
    return 1;
}