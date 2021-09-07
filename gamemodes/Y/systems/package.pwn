#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    mysql_tquery(dbCon, "SELECT * FROM weapons_package ORDER BY wp_id", "LoadPackage");
    return 1;
}

forward LoadPackage();
public LoadPackage()
{
    if(!cache_num_rows())
		return printf("[SERVER]: No Package were loaded from \"%s\" database...", MYSQL_DB);
    
    new rows,count; cache_get_row_count(rows);

    for (new i = 0; i < rows && i < MAX_PACKAGE; i ++)
    {
        cache_get_value_name_int(i,"wp_id",WpInfo[i+1][wp_id]);
        cache_get_value_name_int(i,"wp_owner",WpInfo[i+1][wp_owner]);
        cache_get_value_name_int(i,"wp_type",WpInfo[i+1][wp_type]);

        cache_get_value_name_float(i,"wp_posx",WpInfo[i+1][wp_pos][0]);
        cache_get_value_name_float(i,"wp_posy",WpInfo[i+1][wp_pos][1]);
        cache_get_value_name_float(i,"wp_posz",WpInfo[i+1][wp_pos][2]);
        cache_get_value_name_int(i,"wp_world",WpInfo[i+1][wp_world]);

        if(IsValidDynamicObject(WpInfo[i+1][wp_object]))
            DestroyDynamicObject(WpInfo[i+1][wp_object]);
        
        if(WpInfo[i+1][wp_type] == 1)
            WpInfo[i+1][wp_object] = CreateDynamicObject(2358, WpInfo[i+1][wp_pos][0], WpInfo[i+1][wp_pos][1], WpInfo[i+1][wp_pos][2], 0.0, 0.0, 0.0, WpInfo[i+1][wp_world], -1, -1);
        else WpInfo[i+1][wp_object] = CreateDynamicObject(2969, WpInfo[i+1][wp_pos][0], WpInfo[i+1][wp_pos][1], WpInfo[i+1][wp_pos][2], 0.0, 0.0, 0.0, WpInfo[i+1][wp_world], -1, -1);
        
        count++;
    }

    printf("[SERVER]: %d Package were loaded from \"%s\" database...", count, MYSQL_DB);

    return 1;
}


stock IsPlayerNearPackage(playerid)
{
    for(new i = 1; i < MAX_PACKAGE; i++)
    {
        if(!WpInfo[i][wp_id])
            continue;

        if(IsPlayerInRangeOfPoint(playerid, 3.0, WpInfo[i][wp_pos][0], WpInfo[i][wp_pos][1], WpInfo[i][wp_pos][2]))
		    return i;
    }

    return 0;
}


forward CreatePackage(playerid, newid, type);
public CreatePackage(playerid, newid, type)
{

	WpInfo[newid][wp_id] = cache_insert_id();
	WpInfo[newid][wp_owner] = PlayerInfo[playerid][pDBID];
	WpInfo[newid][wp_type] = type;
	
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	if(type == 1)
		WpInfo[newid][wp_object] = CreateDynamicObject(2358, x, y, z- 0.8, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1);
	else
		WpInfo[newid][wp_object] = CreateDynamicObject(2969, x, y, z- 0.8, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1);
	
	WpInfo[newid][wp_world] = GetPlayerVirtualWorld(playerid);
	WpInfo[newid][wp_pos][0] = x;
	WpInfo[newid][wp_pos][1] = y;
	WpInfo[newid][wp_pos][2] = z - 0.8;
	SendClientMessageEx(playerid, COLOR_HELPME, "คุณได้สร้าง กล่องสำหรับการเก็บอาวุธ (%d)",WpInfo[newid][wp_id]);
	return 1;
}