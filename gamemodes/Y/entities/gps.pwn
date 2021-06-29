#define MAX_GPS (300)

enum G_GPS_DATA
{
    GPSDBID,
    GPSOwner,
    GPSName[32],
    GPSGobal,
    Float:GPSPos[3],
}
new GpsInfo[MAX_GPS][G_GPS_DATA];