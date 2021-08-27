stock SaveGps(id, thread = MYSQL_TYPE_THREAD)
{
    new query[MAX_STRING];

    mysql_init("gps", "GPSDBID", GpsInfo[id][GPSDBID], thread);

    mysql_int(query, "GPSOwner",GpsInfo[id][GPSOwner]);
    mysql_str(query, "GPSName",GpsInfo[id][GPSName]);
    mysql_int(query, "GPSGobal",GpsInfo[id][GPSGobal]);

    mysql_flo(query, "GPSPosX",GpsInfo[id][GPSPos][0]);
    mysql_flo(query, "GPSPosY",GpsInfo[id][GPSPos][1]);
    mysql_flo(query, "GPSPosZ",GpsInfo[id][GPSPos][2]);
    mysql_finish(query);

    return 1;
}