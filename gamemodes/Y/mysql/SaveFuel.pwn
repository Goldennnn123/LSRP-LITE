stock SaveFuel(id, thread = MYSQL_TYPE_THREAD)
{
    new query[MAX_STRING];
    
	mysql_init("fuel", "F_ID",FuelInfo[id][F_ID], thread);

	mysql_int(query, "F_OwnerDBID",FuelInfo[id][F_OwnerDBID]);
    mysql_int(query, "F_Business",FuelInfo[id][F_Business]);
    mysql_flo(query, "F_Fuel",FuelInfo[id][F_Fuel]);

    mysql_int(query, "F_Price",FuelInfo[id][F_Price]);
    mysql_int(query, "F_PriceBuy",FuelInfo[id][F_PriceBuy]);

    mysql_flo(query, "F_PosX",FuelInfo[id][F_Pos][0]);
    mysql_flo(query, "F_PosY",FuelInfo[id][F_Pos][1]);
    mysql_flo(query, "F_PosZ",FuelInfo[id][F_Pos][2]);
    mysql_flo(query, "F_PosRX",FuelInfo[id][F_Pos][3]);
    mysql_flo(query, "F_PosRZ",FuelInfo[id][F_Pos][4]);
    mysql_flo(query, "F_PosRZ",FuelInfo[id][F_Pos][5]);

	mysql_finish(query);
    return 1;
}