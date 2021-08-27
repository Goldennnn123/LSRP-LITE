#include <YSI_Coding\y_hooks>


new PlayerEditGps[MAX_PLAYERS];
hook OnGameModeInit()
{
    mysql_tquery(dbCon, "SELECT * FROM gps ORDER BY GPSDBID", "LoadGPS");
    return 1;
}

forward LoadGPS();
public LoadGPS()
{
    if(!cache_num_rows())
		return printf("[SERVER]: No GPS were loaded from \"%s\" database...", MYSQL_DB);

    new rows,countGPS; cache_get_row_count(rows);
    for (new i = 0; i < rows && i < MAX_GPS; i ++)
    {
        cache_get_value_name_int(i,"GPSDBID",GpsInfo[i+1][GPSDBID]);
        cache_get_value_name_int(i,"GPSOwner",GpsInfo[i+1][GPSOwner]);
        cache_get_value_name(i,"GPSName",GpsInfo[i+1][GPSName]);

        cache_get_value_name_int(i,"GPSGobal",GpsInfo[i+1][GPSGobal]);
        cache_get_value_name_float(i,"GPSPosX",GpsInfo[i+1][GPSPos][0]);
        cache_get_value_name_float(i,"GPSPosY",GpsInfo[i+1][GPSPos][1]);
        cache_get_value_name_float(i,"GPSPosZ",GpsInfo[i+1][GPSPos][2]);
        countGPS++;
    }
    return 1;
}


hook OnPlayerEnterCheckpoint(playerid)
{
    if(PlayerCheckpoint[playerid] == 10)
    {
        GameTextForPlayer(playerid, "~p~You have found it!", 3000, 3);
		PlayerCheckpoint[playerid] = 0; DisablePlayerCheckpoint(playerid);
        return 1;
    }
    return 1;
}

forward InsertGps(newid, playerid, const name[], Float:x, Float:y, Float:z);
public InsertGps(newid, playerid, const name[], Float:x, Float:y, Float:z)
{
	GpsInfo[newid][GPSDBID] = newid;
	format(GpsInfo[newid][GPSName], 32,"%s",name);
	GpsInfo[newid][GPSGobal] = 0;
	GpsInfo[newid][GPSPos][0] = x;
	GpsInfo[newid][GPSPos][1] = y;
	GpsInfo[newid][GPSPos][2] = z;
	SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้สร้าง GPS %d ขึ้นมาแล้ว สามารถพิมพ์ /gps เพื่อดู GPS ได้", newid);
	return 1;
}

Dialog:D_GPS_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    switch(listitem)
    {
        case 0:
        {
            new str[255], longstr[255], gpsid, str_g[15];
            for(new i = 1; i < MAX_GPS; i++)
            {
                if(!GpsInfo[i][GPSDBID])
                    continue;

                if(!GpsInfo[i][GPSGobal])
                    continue;
                
                format(str, sizeof(str), "%d: %s\n",i, GpsInfo[i][GPSName]);
                strcat(longstr,str);
                
                format(str_g, sizeof(str_g), "%d",gpsid);
                SetPVarInt(playerid, str_g, i);

                gpsid++;
            }
            if(!gpsid)  return Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, "GPS SYSTEM: GOBAL", "ยังไม่มีการเพิ่ม GPS มา....", "ยืนยัน", "ยกเลิก");
            Dialog_Show(playerid, D_GPS_SET, DIALOG_STYLE_LIST, "GPS SYSTEM: GOBAL", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 1:
        {
            new str[255], longstr[255], gpsid, str_g[15];

            for(new i = 1; i < MAX_GPS; i++)
            {
                if(!GpsInfo[i][GPSDBID])
                    continue;
                
                if(GpsInfo[i][GPSGobal])
                    continue;

                if(GpsInfo[i][GPSOwner] != PlayerInfo[playerid][pDBID])
                    continue;
                
                format(str, sizeof(str), "%d: %s\n",i, GpsInfo[i][GPSName]);
                strcat(longstr,str);
                
                format(str_g, sizeof(str_g), "%d",gpsid);
                SetPVarInt(playerid, str_g, i);
                gpsid++;
            }
            if(!gpsid)  return Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, "GPS SYSTEM: PRIVATE", "ยังไม่มีการเพิ่ม GPS มา....", "ยืนยัน", "ยกเลิก");
            Dialog_Show(playerid, D_GPS_SET, DIALOG_STYLE_LIST, "GPS SYSTEM: PRIVATE", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
    }
    return 1;
}

Dialog:D_GPS_SET(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    new str_g[15];
    format(str_g, sizeof(str_g), "%d",listitem);

    new id = GetPVarInt(playerid, str_g);

    PlayerCheckpoint[playerid] = 10;
    SetPlayerCheckpoint(playerid, GpsInfo[id][GPSPos][0], GpsInfo[id][GPSPos][1],GpsInfo[id][GPSPos][2], 3.0);
    SendClientMessageEx(playerid, -1, "{3FBF75}GPS SYSTEM:{FFFFFF} ระบบได้กำหนดทาง GPS %s ให้กับคุณแล้ว คุณสามารถยกเลิกได้โดยการพิพม์ /rcp",GpsInfo[id][GPSName]);
    return 1;
}

Dialog:D_GPS_CHANG_NAME(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new name = strlen(inputtext);
    new id = PlayerEditGps[playerid];

    if(name < 3 || name > 45)
        return Dialog_Show(playerid, D_GPS_CHANG_NAME, DIALOG_STYLE_INPUT, "GPS SYSTEM:", ""EMBED_LIGHTRED"กรุณาใส่ชื่อให้ถูกต้อง", "ยืนยัน", "ยกเลิก");
    
    format(GpsInfo[id][GPSName], 45, "%s", inputtext);
    SendClientMessage(playerid, COLOR_LIGHTGREEN, "คุณได้เปลี่ยนชื่อ GPS ของคุณแล้วเรียบร้อย");
    SaveGps(id);
    return 1;
}

