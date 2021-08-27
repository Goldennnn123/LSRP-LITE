stock SaveBusiness(id, thread = MYSQL_TYPE_THREAD)
{
    new query[MAX_STRING];

    mysql_init("business", "BusinessDBID", BusinessInfo[id][BusinessDBID], thread);

    mysql_str(query, "BusinessName",BusinessInfo[id][BusinessName]);
    mysql_int(query, "BusinessOwnerDBID",BusinessInfo[id][BusinessOwnerDBID]);

    mysql_int(query, "BusinessType",BusinessInfo[id][BusinessType]);
    mysql_flo(query, "BusinessEntranceX",BusinessInfo[id][BusinessEntrance][0]);
    mysql_flo(query, "BusinessEntranceY",BusinessInfo[id][BusinessEntrance][1]);
    mysql_flo(query, "BusinessEntranceZ",BusinessInfo[id][BusinessEntrance][2]);
    mysql_int(query, "BusinessEntranceWorld",BusinessInfo[id][BusinessEntranceWorld]);
    mysql_int(query, "BusinessEntranceInterior",BusinessInfo[id][BusinessEntranceInterior]);


    mysql_flo(query, "BusinessInteriorX",BusinessInfo[id][BusinessInterior][0]);
    mysql_flo(query, "BusinessInteriorY",BusinessInfo[id][BusinessInterior][1]);
    mysql_flo(query, "BusinessInteriorZ",BusinessInfo[id][BusinessInterior][2]);
    mysql_int(query, "BusinessInteriorWorld",BusinessInfo[id][BusinessInteriorWorld]);
    mysql_int(query, "BusinessInteriorID",BusinessInfo[id][BusinessInteriorID]);


    mysql_flo(query, "BusinessBankPickupLocX",BusinessInfo[id][BusinessBankPickupLoc][0]);
    mysql_flo(query, "BusinessBankPickupLocY",BusinessInfo[id][BusinessBankPickupLoc][1]);
    mysql_flo(query, "BusinessBankPickupLocZ",BusinessInfo[id][BusinessBankPickupLoc][2]);
    mysql_int(query, "BusinessBankWorld",BusinessInfo[id][BusinessBankWorld]);
    
    mysql_int(query, "BusinessCash",BusinessInfo[id][BusinessCash]);
    mysql_int(query, "BusinessPrice",BusinessInfo[id][BusinessPrice]);
    mysql_int(query, "Businesslevel",BusinessInfo[id][Businesslevel]);
    mysql_int(query, "BusinessEntrancePrice",BusinessInfo[id][BusinessEntrancePrice]);


    mysql_int(query, "BusinessLock",BusinessInfo[id][BusinessLock]);

    mysql_int(query, "BusinessS_Cemara",BusinessInfo[id][BusinessS_Cemara]);
    mysql_int(query, "BusinessS_Mask",BusinessInfo[id][BusinessS_Mask]);
    mysql_int(query, "BusinessS_Flower",BusinessInfo[id][BusinessS_Flower]);
    mysql_int(query, "BusinessS_Flower",BusinessInfo[id][BusinessS_Flower]);

    mysql_finish(query);
    return 1;
}