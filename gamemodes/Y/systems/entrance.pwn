#include <YSI_Coding\y_hooks>

new PlayerSeleteEnter[MAX_PLAYERS];

hook OnPlayerDisconnect(playerid, reason)
{
    PlayerSeleteEnter[playerid] = 0;
    return 1;
}

forward LoadEntrance();
public LoadEntrance()
{
    if(!cache_num_rows())
		return printf("[SERVER]: No Entrance were loaded from \"%s\" database...", MYSQL_DB);

    new rows,countEntrance; cache_get_row_count(rows);

    for (new i = 0; i < rows && i < MAX_ENTRANCE; i ++)
    {
        cache_get_value_name_int(i,"EntranceDBID",EntranceInfo[i+1][EntranceDBID]);
        cache_get_value_name_int(i,"EntranceIconID",EntranceInfo[i+1][EntranceIconID]);

        cache_get_value_name_float(i,"EntranceLocX",EntranceInfo[i+1][EntranceLoc][0]);
        cache_get_value_name_float(i,"EntranceLocY",EntranceInfo[i+1][EntranceLoc][1]);
        cache_get_value_name_float(i,"EntranceLocZ",EntranceInfo[i+1][EntranceLoc][2]);
        cache_get_value_name_int(i,"EntranceLocWorld",EntranceInfo[i+1][EntranceLocWorld]);
        cache_get_value_name_int(i,"EntranceLocInID",EntranceInfo[i+1][EntranceLocInID]);

        cache_get_value_name_float(i,"EntranceLocInX",EntranceInfo[i+1][EntranceLocIn][0]);
        cache_get_value_name_float(i,"EntranceLocInY",EntranceInfo[i+1][EntranceLocIn][1]);
        cache_get_value_name_float(i,"EntranceLocInZ",EntranceInfo[i+1][EntranceLocIn][2]);
        cache_get_value_name_int(i,"EntanceLocInWorld",EntranceInfo[i+1][EntanceLocInWorld]);
        cache_get_value_name_int(i,"EntranceLocInInID",EntranceInfo[i+1][EntranceLocInInID]);

        if(EntranceInfo[i+1][EntranceIconID])
        {
            if(IsValidDynamicPickup(EntranceInfo[i+1][EntrancePickup]))
                DestroyDynamicPickup(EntranceInfo[i+1][EntrancePickup]);
            
            EntranceInfo[i+1][EntrancePickup] = CreateDynamicPickup(EntranceInfo[i+1][EntranceIconID], 23, EntranceInfo[i+1][EntranceLoc][0], EntranceInfo[i+1][EntranceLoc][1], EntranceInfo[i+1][EntranceLoc][2],EntranceInfo[i+1][EntranceLocWorld],EntranceInfo[i+1][EntranceLocInID]);
        }
        countEntrance++;
    }

    printf("[SERVER]: %d Entrance were loaded from \"%s\" database...", countEntrance, MYSQL_DB);
    return 1;
}

forward Query_InsertEntrance(playerid, newid, icon, Float:X, Float:Y, Float:Z, World, Interior);
public Query_InsertEntrance(playerid, newid, icon, Float:X, Float:Y, Float:Z, World, Interior)
{
    
    EntranceInfo[newid][EntranceDBID] = cache_insert_id();
    EntranceInfo[newid][EntranceIconID] = icon;

    EntranceInfo[newid][EntranceLoc][0] = X;
    EntranceInfo[newid][EntranceLoc][1] = Y;
    EntranceInfo[newid][EntranceLoc][2] = Z;
    EntranceInfo[newid][EntranceLocWorld] = World;
    EntranceInfo[newid][EntranceLocInID] =Interior;

    if(EntranceInfo[newid][EntranceIconID])
    {
        if(IsValidDynamicPickup(EntranceInfo[newid][EntrancePickup]))
                DestroyDynamicPickup(EntranceInfo[newid][EntrancePickup]);
            
        EntranceInfo[newid][EntrancePickup] = CreateDynamicPickup(EntranceInfo[newid][EntranceIconID], 23, EntranceInfo[newid][EntranceLoc][0], EntranceInfo[newid][EntranceLoc][1], EntranceInfo[newid][EntranceLoc][2],-1,-1);
    }

    SendClientMessageEx(playerid, -1, "{43A047}ENTRANCE {F4511E}SYSTEM{FAFAFA}: คุณได้สร้าง entrance ไอดี {F4511E}%d {FAFAFA}สำเร็จแล้ว",newid);
    return 1;
}


Dialog:EDIT_ENTRANCE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new id = PlayerSeleteEnter[playerid];

    switch(listitem)
    {
        case 0: return Dialog_Show(playerid, EDIT_ENTRANCE_ICONID, DIALOG_STYLE_INPUT, "Entrance Editer", "โปรดใส่ ไอดีไอคอนใหม่:", "ยืนยัน", "ยกเลิก");
        case 1:
        {
            GetPlayerPos(playerid, EntranceInfo[id][EntranceLoc][0], EntranceInfo[id][EntranceLoc][1], EntranceInfo[id][EntranceLoc][2]);
            EntranceInfo[id][EntranceLocWorld] = GetPlayerVirtualWorld(playerid);
            EntranceInfo[id][EntranceLocInID] = GetPlayerInterior(playerid);

            if(EntranceInfo[id][EntranceIconID])
            {
                if(IsValidDynamicPickup(EntranceInfo[id][EntrancePickup]))
                        DestroyDynamicPickup(EntranceInfo[id][EntrancePickup]);
                    
                EntranceInfo[id][EntrancePickup] = CreateDynamicPickup(EntranceInfo[id][EntranceIconID], 23, EntranceInfo[id][EntranceLoc][0], EntranceInfo[id][EntranceLoc][1], EntranceInfo[id][EntranceLoc][2],-1,-1);
            }
            SaveEntrance(id);
            return 1;
        }
        case 2:
        {
            GetPlayerPos(playerid, EntranceInfo[id][EntranceLocIn][0], EntranceInfo[id][EntranceLocIn][1], EntranceInfo[id][EntranceLocIn][2]);
            
            if(GetPlayerVirtualWorld(playerid) == 0)
            {
                EntranceInfo[id][EntanceLocInWorld] = random(99999);
            }
            else
            {
                EntranceInfo[id][EntanceLocInWorld] = GetPlayerVirtualWorld(playerid);
            }
            EntranceInfo[id][EntranceLocInInID] = GetPlayerInterior(playerid);
            SaveEntrance(id);
            return 1;
        }

    }
    return 1;
}

Dialog:EDIT_ENTRANCE_ICONID(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new iconid = strval(inputtext);
    new id = PlayerSeleteEnter[playerid];

    EntranceInfo[id][EntranceIconID] = iconid;

    if(iconid == 0)
    {
        if(IsValidDynamicPickup(EntranceInfo[id][EntrancePickup]))
            DestroyDynamicPickup(EntranceInfo[id][EntrancePickup]);
        
        SaveEntrance(id);
        return 1;
    }

    if(EntranceInfo[id][EntranceIconID])
    {
        if(IsValidDynamicPickup(EntranceInfo[id][EntrancePickup]))
                DestroyDynamicPickup(EntranceInfo[id][EntrancePickup]);
            
        EntranceInfo[id][EntrancePickup] = CreateDynamicPickup(EntranceInfo[id][EntranceIconID], 23, EntranceInfo[id][EntranceLoc][0], EntranceInfo[id][EntranceLoc][1], EntranceInfo[id][EntranceLoc][2],-1,-1);
    }
    SaveEntrance(id);
    
    return 1;
}

forward OnPlayerEnter(playerid, id);
public OnPlayerEnter(playerid, id)
{
	SetPlayerPos(playerid, EntranceInfo[id][EntranceLocIn][0], EntranceInfo[id][EntranceLocIn][1], EntranceInfo[id][EntranceLocIn][2]);
    TogglePlayerControllable(playerid, 1);
    return 1;
}

forward OnPlayerExit(playerid, id);
public OnPlayerExit(playerid, id)
{
	SetPlayerPos(playerid, EntranceInfo[id][EntranceLoc][0], EntranceInfo[id][EntranceLoc][1], EntranceInfo[id][EntranceLoc][2]);
    //SetPlayerVirtualWorld(playerid, EntranceInfo[id][EntranceLocInID]);
	//SetPlayerInterior(playerid, EntranceInfo[id][EntranceLocWorld]);
    TogglePlayerControllable(playerid, 1);
    return 1;
}
