
#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
    PlayerSeClo[playerid] = 0;
    PlayerSeCloBuy[playerid] = 0;
    PlayerSeCloBuy[playerid] = 0;
    return 1;
}


new pick_cloth[2];
hook OnGameModeInit()
{
    pick_cloth[0] = CreateDynamicPickup(1329, 1, 1103.0364,-1440.3457,15.7969, -1, -1, -1, -1);
    return 1;
}




stock SetPlayerClothing(playerid)
{
    new query[MAX_STRING]; new id;

    for(new i = 0; i < MAX_PLAYER_CLOTHING; i++)
    {

        if(PlayerInfo[playerid][pClothing][i])
        {
            mysql_format(dbCon, query, sizeof(query), "SELECT `ClothingDBID`, `ClothingOwnerDBID`, `ClothingSpawn`, `ClothingModel`, `ClothingIndex`, `ClothingBone`, `ClothingOffPosX`, `ClothingOffPosY`, `ClothingOffPosZ`, `ClothingOffPosRX`, `ClothingOffPosRY`, `ClothingOffPosRZ`, `ClothingOffPosSacalX`, `ClothingOffPosSacalY`, `ClothingOffPosSacalZ` FROM `clothing` WHERE `ClothingDBID` = '%d'",PlayerInfo[playerid][pClothing][i]);
            new Cache:cache = mysql_query(dbCon, query);

            if(!cache_num_rows())
                continue;

            cache_get_value_index_int(0, 0, id);
            
            cache_get_value_index_int(0, 1, ClothingData[id][C_Owner]);
            cache_get_value_index_bool(0, 2, ClothingData[id][C_Spawn]);
            cache_get_value_index_int(0, 3, ClothingData[id][C_Model]);
            cache_get_value_index_int(0, 4, ClothingData[id][C_Index]);
            cache_get_value_index_int(0, 5, ClothingData[id][C_Bone]);
            cache_get_value_index_float(0, 6, ClothingData[id][C_OFFPOS][0]);
            cache_get_value_index_float(0, 7, ClothingData[id][C_OFFPOS][1]);
            cache_get_value_index_float(0, 8, ClothingData[id][C_OFFPOS][2]);
            cache_get_value_index_float(0, 9, ClothingData[id][C_OFFPOSR][0]);
            cache_get_value_index_float(0, 10, ClothingData[id][C_OFFPOSR][1]);
            cache_get_value_index_float(0, 11, ClothingData[id][C_OFFPOSR][2]);
            cache_get_value_index_float(0, 12, ClothingData[id][C_OFFPOSS][0]);
            cache_get_value_index_float(0, 13, ClothingData[id][C_OFFPOSS][1]);
            cache_get_value_index_float(0, 14, ClothingData[id][C_OFFPOSS][2]);
            cache_delete(cache);

            ClothingData[id][C_ID] = id;
            
            if(!ClothingData[id][C_Spawn])
                continue;

            SetPlayerAttachedObject(playerid, ClothingData[id][C_Index], ClothingData[id][C_Model], ClothingData[id][C_Bone], ClothingData[id][C_OFFPOS][0], ClothingData[id][C_OFFPOS][1], ClothingData[id][C_OFFPOS][2], ClothingData[id][C_OFFPOSR][0], ClothingData[id][C_OFFPOSR][1], ClothingData[id][C_OFFPOSR][2], ClothingData[id][C_OFFPOSS][0], ClothingData[id][C_OFFPOSS][1], ClothingData[id][C_OFFPOSS][2], 0);
            
        }
    }
    return 1;
}

alias:buyclothing("buyc")
CMD:buyclothing(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "คุณต้องลงจากยานพาหนะ");

    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1103.0364,-1440.3457,15.7969))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่จุดซื้อ Item");

    new idx = 0;

    for(new i = 1; i < MAX_PLAYER_CLOTHING; i++)
    {        
        if(!PlayerInfo[playerid][pClothing][i-1])
        {
            idx = i-1;
            break;
        }
    }
    if(idx == -1) return SendErrorMessage(playerid, "คุณมีการซื้อเต็มแล้ว");
    
    PlayerSeCloBuySect[playerid] = idx;

    ShowClothmenu(playerid);
    return 1;
}


alias:clothing("cloth")
CMD:clothing(playerid, params[])
{
    new type[20], str_2[20];

    if(sscanf(params, "s[20]S()[20]", type, str_2))
    {
        SendUsageMessage(playerid, "/clothing < type >");
        SendClientMessage(playerid, COLOR_GREY, "TYPE: list give"); 
        return 1;
    }
    
    if(strcmp(type, "list", true) == 0 || strcmp(type, "l", true) == 0)
    {
        ShowClothing(playerid);
        PlayerCloID[playerid] = 0;
        return 1;
    }
    else if(strcmp(type, "give", true) == 0 || strcmp(type, "g", true) == 0)
    {
        new tagetid, id, idx = -1;

        if(sscanf(str_2, "ud", tagetid, id))
            return SendUsageMessage(playerid, "/clothing <give> <ชื่อบางส่วน/ไอดี> <slotid ที่ต้องการให้>");

        if(!IsPlayerConnected(tagetid))
            return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซิร์ฟเวอร์");

        if(!IsPlayerConnected(tagetid))
            return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ะรบบ");

        if(!IsPlayerNearPlayer(playerid, tagetid, 5.0))
            return SendErrorMessage(playerid, "คุณไมได้อยู่ใกล้ผู้เล่น");

        if(id < 1 || id > 6)
            return SendErrorMessage(playerid, "ใส่ช่องที่จะให้ให้ถูกต้อง"); 

        if(!PlayerInfo[playerid][pClothing][id-1])
            return SendErrorMessage(playerid, "ไม่มีสิ่งของในช่องนั้น");

        
        for(new i = 1; i < MAX_PLAYER_CLOTHING; i++)
        {
            if(PlayerInfo[tagetid][pClothing][i-1])
                continue;
            
            if(!PlayerInfo[tagetid][pClothing][i-1])
            {
                idx = i-1;
                break;
            }
        }
        if(idx == -1) return SendErrorMessage(tagetid, "คุณมีการซื้อเต็มแล้ว");

        if(ClothingData[PlayerInfo[playerid][pClothing][id-1]][C_Spawn])
        {
            RemovePlayerAttachedObject(playerid, ClothingData[PlayerInfo[playerid][pClothing][id-1]][C_Index]);
        }

        PlayerInfo[tagetid][pClothing][idx] = PlayerInfo[playerid][pClothing][id-1];

        ClothingData[PlayerInfo[playerid][pClothing][id-1]][C_Owner] = PlayerInfo[tagetid][pDBID];
        SaveClothing(PlayerInfo[playerid][pClothing][id-1]);

        SendClientMessageEx(playerid, COLOR_GREY, "คุณได้มอบสิ่งของให้กับ %s",ReturnName(tagetid,0));
        SendClientMessageEx(tagetid, COLOR_GREY, "คุณได้รับสิ่งของจาก %s",ReturnName(playerid,0));
        PlayerInfo[playerid][pClothing][id-1] = 0;
        CharacterSave(playerid); 
        CharacterSave(tagetid);
        return 1;
    }
    else SendErrorMessage(playerid, "กรุณาพิพม์ให้ถูกต้อง");
    return 1;
}

Dialog:D_CLOTHING_BUY_POLICE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    switch(listitem)
    {
        case 0:
        {
            PlayerSeCloBuy[playerid] = 19783;
            SetPlayerAttachedObject(playerid, 6, 19783, 3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 1:
        {
            PlayerSeCloBuy[playerid] = 19784;
            SetPlayerAttachedObject(playerid, 6, 19784, 3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 2:
        {
            PlayerSeCloBuy[playerid] = 19785;
            SetPlayerAttachedObject(playerid, 6, 19785, 3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 3:
        {
            PlayerSeCloBuy[playerid] = 19781;
            SetPlayerAttachedObject(playerid, 6, 19781, 3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 4:
        {
            PlayerSeCloBuy[playerid] = 19782;
            SetPlayerAttachedObject(playerid, 6, 19782, 3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 5:
        {
            PlayerSeCloBuy[playerid] = 19778;
            SetPlayerAttachedObject(playerid, 6, 19778, 3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 6:
        {
            PlayerSeCloBuy[playerid] = 19779;
            SetPlayerAttachedObject(playerid, 6, 19779, 3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 7:
        {
            PlayerSeCloBuy[playerid] = 19780;
            SetPlayerAttachedObject(playerid, 6, 19780, 3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 8:
        {
            PlayerSeCloBuy[playerid] = 19780;
            SetPlayerAttachedObject(playerid, 6, 19780, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 9:
        {
            PlayerSeCloBuy[playerid] = 19142;
            SetPlayerAttachedObject(playerid, 6, 19142, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 10:
        {
            PlayerSeCloBuy[playerid] = 19521;
            SetPlayerAttachedObject(playerid, 6, 19521, 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 11:
        {
            PlayerSeCloBuy[playerid] = 18637;
            SetPlayerAttachedObject(playerid, 6, 18637, 5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 12:
        {
            PlayerSeCloBuy[playerid] = 19200;
            SetPlayerAttachedObject(playerid, 6, 19200, 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 13:
        {
            PlayerSeCloBuy[playerid] = 19141;
            SetPlayerAttachedObject(playerid, 6, 19141, 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
    }
    return 1;
}

Dialog:D_CLOTHING_BUY(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    switch(listitem)
    {
        case 0:
        {
            PlayerSeCloBuy[playerid] = 18635;
            SetPlayerAttachedObject(playerid, 6, 18635, 5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 1:
        {
            PlayerSeCloBuy[playerid] = 18634;
            SetPlayerAttachedObject(playerid, 6, 18634, 5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 2:
        {
            PlayerSeCloBuy[playerid] = 18639;
            SetPlayerAttachedObject(playerid, 6, 18639, 5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 3:
        {
            PlayerSeCloBuy[playerid] = 18644;
            SetPlayerAttachedObject(playerid, 6, 18644, 5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 4:
        {
            PlayerSeCloBuy[playerid] = 18644;
            SetPlayerAttachedObject(playerid, 6, 18644, 5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 5:
        {
            PlayerSeCloBuy[playerid] = 11745;
            SetPlayerAttachedObject(playerid, 6, 11745, 5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 6:
        {
            PlayerSeCloBuy[playerid] = 11738;
            SetPlayerAttachedObject(playerid, 6, 11738, 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 7:
        {
            PlayerSeCloBuy[playerid] = 18961;
            SetPlayerAttachedObject(playerid, 6, 18961, 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 8:
        {
            PlayerSeCloBuy[playerid] = 19033;
            SetPlayerAttachedObject(playerid, 6, 19033, 5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 9:
        {
            PlayerSeCloBuy[playerid] = 19043;
            SetPlayerAttachedObject(playerid, 6, 19043, 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 10:
        {
            PlayerSeCloBuy[playerid] = 19138;
            SetPlayerAttachedObject(playerid, 6, 19138, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 11:
        {
            PlayerSeCloBuy[playerid] = 18641;
            SetPlayerAttachedObject(playerid, 6, 18641, 6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 12:
        {
            PlayerSeCloBuy[playerid] = 19624;
            SetPlayerAttachedObject(playerid, 6, 19624, 5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
        case 13:
        {
            PlayerSeCloBuy[playerid] = 3026;
            SetPlayerAttachedObject(playerid, 6, 3026, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
            EditAttachedObject(playerid, 6);
            return 1;
        }
    }
    return 1;
}

Dialog:D_CLOTHING_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    new query[MAX_STRING];

    switch(listitem)
    {
        case 0:
        {
            if(!PlayerInfo[playerid][pClothing][0])
                return SendErrorMessage(playerid, "คุณไม่มี Model ในนี้");


            mysql_format(dbCon, query, sizeof(query), "SELECT `ClothingDBID`, `ClothingOwnerDBID`, `ClothingSpawn`, `ClothingModel`, `ClothingIndex`, `ClothingBone`, `ClothingOffPosX`, `ClothingOffPosY`, `ClothingOffPosZ`, `ClothingOffPosRX`, `ClothingOffPosRY`, `ClothingOffPosRZ`, `ClothingOffPosSacalX`, `ClothingOffPosSacalY`, `ClothingOffPosSacalZ` FROM `clothing` WHERE `ClothingDBID` = '%d'",PlayerInfo[playerid][pClothing][0]);
            new Cache:cache = mysql_query(dbCon, query);

            if(!cache_num_rows())
            {
                PlayerInfo[playerid][pClothing][0] = 0;
                return SendErrorMessage(playerid, "ไม่มี ไอดีนี้ในฐ้านข้อมูล");
            }

            new id;

            cache_get_value_index_int(0, 0, id);
            
            cache_get_value_index_int(0, 1, ClothingData[id][C_Owner]);
            cache_get_value_index_bool(0, 2, ClothingData[id][C_Spawn]);
            cache_get_value_index_int(0, 3, ClothingData[id][C_Model]);
            cache_get_value_index_int(0, 4, ClothingData[id][C_Index]);
            cache_get_value_index_int(0, 5, ClothingData[id][C_Bone]);
            cache_get_value_index_float(0, 6, ClothingData[id][C_OFFPOS][0]);
            cache_get_value_index_float(0, 7, ClothingData[id][C_OFFPOS][1]);
            cache_get_value_index_float(0, 8, ClothingData[id][C_OFFPOS][2]);
            cache_get_value_index_float(0, 9, ClothingData[id][C_OFFPOSR][0]);
            cache_get_value_index_float(0, 10, ClothingData[id][C_OFFPOSR][1]);
            cache_get_value_index_float(0, 11, ClothingData[id][C_OFFPOSR][2]);
            cache_get_value_index_float(0, 12, ClothingData[id][C_OFFPOSS][0]);
            cache_get_value_index_float(0, 13, ClothingData[id][C_OFFPOSS][1]);
            cache_get_value_index_float(0, 14, ClothingData[id][C_OFFPOSS][2]);
            cache_delete(cache);

            ClothingData[id][C_ID] = id;

            new str[120], longstr[120];

            format(str, sizeof(str), "ID: %d\n",ClothingData[id][C_ID]);
            strcat(longstr, str);
            format(str, sizeof(str), "Model: %d\n",ClothingData[id][C_Model]);
            strcat(longstr, str);
            format(str, sizeof(str), "Index: %d\n",ClothingData[id][C_Index]);
            strcat(longstr, str);
            format(str, sizeof(str), "Bone: %d\n",ClothingData[id][C_Bone]);
            strcat(longstr, str);

            format(str, sizeof(str), "Pos\n");
            strcat(longstr, str);


            if(ClothingData[id][C_Spawn])
            {
                format(str, sizeof(str), ""EMBED_GREENMONEY"Take Off\n");
                strcat(longstr, str);
            }
            else
            {
                format(str, sizeof(str), ""EMBED_LIGHTRED"Take On\n");
                strcat(longstr, str);
            }

            format(str, sizeof(str), ""EMBED_LIGHTRED"Delete\n");
            strcat(longstr, str);

            

            PlayerCloID[playerid] = ClothingData[id][C_ID];
            SetPVarInt(playerid, "PlayerClothing", ClothingData[id][C_ID]);

            Dialog_Show(playerid, D_CLOTHING_SELECT, DIALOG_STYLE_LIST, "การแต่งตัว:", longstr, "เลือก", "ยกเลิก");
            return 1;
        }
        case 1:
        {
            if(!PlayerInfo[playerid][pClothing][1])
                return SendErrorMessage(playerid, "คุณไม่มี Model ในนี้");


            mysql_format(dbCon, query, sizeof(query), "SELECT `ClothingDBID`, `ClothingOwnerDBID`, `ClothingSpawn`, `ClothingModel`, `ClothingIndex`, `ClothingBone`, `ClothingOffPosX`, `ClothingOffPosY`, `ClothingOffPosZ`, `ClothingOffPosRX`, `ClothingOffPosRY`, `ClothingOffPosRZ`, `ClothingOffPosSacalX`, `ClothingOffPosSacalY`, `ClothingOffPosSacalZ` FROM `clothing` WHERE `ClothingDBID` = '%d'",PlayerInfo[playerid][pClothing][1]);
            new Cache:cache = mysql_query(dbCon, query);
        

            if(!cache_num_rows())
            {
                PlayerInfo[playerid][pClothing][1] = 0;
                return SendErrorMessage(playerid, "ไม่มี ไอดีนี้ในฐ้านข้อมูล");
            }

            new id;

            cache_get_value_index_int(0, 0, id);
            
            cache_get_value_index_int(0, 1, ClothingData[id][C_Owner]);
            cache_get_value_index_bool(0, 2, ClothingData[id][C_Spawn]);
            cache_get_value_index_int(0, 3, ClothingData[id][C_Model]);
            cache_get_value_index_int(0, 4, ClothingData[id][C_Index]);
            cache_get_value_index_int(0, 5, ClothingData[id][C_Bone]);
            cache_get_value_index_float(0, 6, ClothingData[id][C_OFFPOS][0]);
            cache_get_value_index_float(0, 7, ClothingData[id][C_OFFPOS][1]);
            cache_get_value_index_float(0, 8, ClothingData[id][C_OFFPOS][2]);
            cache_get_value_index_float(0, 9, ClothingData[id][C_OFFPOSR][0]);
            cache_get_value_index_float(0, 10, ClothingData[id][C_OFFPOSR][1]);
            cache_get_value_index_float(0, 11, ClothingData[id][C_OFFPOSR][2]);
            cache_get_value_index_float(0, 12, ClothingData[id][C_OFFPOSS][0]);
            cache_get_value_index_float(0, 13, ClothingData[id][C_OFFPOSS][1]);
            cache_get_value_index_float(0, 14, ClothingData[id][C_OFFPOSS][2]);
            cache_delete(cache);

            ClothingData[id][C_ID] = id;

            new str[120], longstr[120];

            format(str, sizeof(str), "ID: %d\n",ClothingData[id][C_ID]);
            strcat(longstr, str);
            format(str, sizeof(str), "Model: %d\n",ClothingData[id][C_Model]);
            strcat(longstr, str);
            format(str, sizeof(str), "Index: %d\n",ClothingData[id][C_Index]);
            strcat(longstr, str);
            format(str, sizeof(str), "Bone: %d\n",ClothingData[id][C_Bone]);
            strcat(longstr, str);

            format(str, sizeof(str), "Pos\n");
            strcat(longstr, str);


            if(ClothingData[id][C_Spawn])
            {
                format(str, sizeof(str), ""EMBED_GREENMONEY"Take Off\n");
                strcat(longstr, str);
            }
            else
            {
                format(str, sizeof(str), ""EMBED_LIGHTRED"Take On\n");
                strcat(longstr, str);
            }

            format(str, sizeof(str), ""EMBED_LIGHTRED"Delete\n");
            strcat(longstr, str);

            

            PlayerCloID[playerid] = ClothingData[id][C_ID];
            SetPVarInt(playerid, "PlayerClothing", ClothingData[id][C_ID]);

            Dialog_Show(playerid, D_CLOTHING_SELECT, DIALOG_STYLE_LIST, "การแต่งตัว:", longstr, "เลือก", "ยืนยัน");
            return 1;
        }
        case 2:
        {
            if(!PlayerInfo[playerid][pClothing][2])
                return SendErrorMessage(playerid, "คุณไม่มี Model ในนี้");


            mysql_format(dbCon, query, sizeof(query), "SELECT `ClothingDBID`, `ClothingOwnerDBID`, `ClothingSpawn`, `ClothingModel`, `ClothingIndex`, `ClothingBone`, `ClothingOffPosX`, `ClothingOffPosY`, `ClothingOffPosZ`, `ClothingOffPosRX`, `ClothingOffPosRY`, `ClothingOffPosRZ`, `ClothingOffPosSacalX`, `ClothingOffPosSacalY`, `ClothingOffPosSacalZ` FROM `clothing` WHERE `ClothingDBID` = '%d'",PlayerInfo[playerid][pClothing][2]);
            new Cache:cache = mysql_query(dbCon, query);

            if(!cache_num_rows())
            {
                PlayerInfo[playerid][pClothing][2] = 0;
                return SendErrorMessage(playerid, "ไม่มี ไอดีนี้ในฐ้านข้อมูล");
            }

            new id;

            cache_get_value_index_int(0, 0, id);
            
            cache_get_value_index_int(0, 1, ClothingData[id][C_Owner]);
            cache_get_value_index_bool(0, 2, ClothingData[id][C_Spawn]);
            cache_get_value_index_int(0, 3, ClothingData[id][C_Model]);
            cache_get_value_index_int(0, 4, ClothingData[id][C_Index]);
            cache_get_value_index_int(0, 5, ClothingData[id][C_Bone]);
            cache_get_value_index_float(0, 6, ClothingData[id][C_OFFPOS][0]);
            cache_get_value_index_float(0, 7, ClothingData[id][C_OFFPOS][1]);
            cache_get_value_index_float(0, 8, ClothingData[id][C_OFFPOS][2]);
            cache_get_value_index_float(0, 9, ClothingData[id][C_OFFPOSR][0]);
            cache_get_value_index_float(0, 10, ClothingData[id][C_OFFPOSR][1]);
            cache_get_value_index_float(0, 11, ClothingData[id][C_OFFPOSR][2]);
            cache_get_value_index_float(0, 12, ClothingData[id][C_OFFPOSS][0]);
            cache_get_value_index_float(0, 13, ClothingData[id][C_OFFPOSS][1]);
            cache_get_value_index_float(0, 14, ClothingData[id][C_OFFPOSS][2]);
            cache_delete(cache);

            ClothingData[id][C_ID] = id;

            new str[120], longstr[120];

            format(str, sizeof(str), "ID: %d\n",ClothingData[id][C_ID]);
            strcat(longstr, str);
            format(str, sizeof(str), "Model: %d\n",ClothingData[id][C_Model]);
            strcat(longstr, str);
            format(str, sizeof(str), "Index: %d\n",ClothingData[id][C_Index]);
            strcat(longstr, str);
            format(str, sizeof(str), "Bone: %d\n",ClothingData[id][C_Bone]);
            strcat(longstr, str);

            format(str, sizeof(str), "Pos\n");
            strcat(longstr, str);


            if(ClothingData[id][C_Spawn])
            {
                format(str, sizeof(str), ""EMBED_GREENMONEY"Take Off\n");
                strcat(longstr, str);
            }
            else
            {
                format(str, sizeof(str), ""EMBED_LIGHTRED"Take On\n");
                strcat(longstr, str);
            }

            format(str, sizeof(str), ""EMBED_LIGHTRED"Delete\n");
            strcat(longstr, str);

            

            PlayerCloID[playerid] = ClothingData[id][C_ID];
            SetPVarInt(playerid, "PlayerClothing", ClothingData[id][C_ID]);

            Dialog_Show(playerid, D_CLOTHING_SELECT, DIALOG_STYLE_LIST, "การแต่งตัว:", longstr, "เลือก", "ยืนยัน");
            return 1;
        }
        case 3:
        {
            if(!PlayerInfo[playerid][pClothing][3])
                return SendErrorMessage(playerid, "คุณไม่มี Model ในนี้");


            mysql_format(dbCon, query, sizeof(query), "SELECT `ClothingDBID`, `ClothingOwnerDBID`, `ClothingSpawn`, `ClothingModel`, `ClothingIndex`, `ClothingBone`, `ClothingOffPosX`, `ClothingOffPosY`, `ClothingOffPosZ`, `ClothingOffPosRX`, `ClothingOffPosRY`, `ClothingOffPosRZ`, `ClothingOffPosSacalX`, `ClothingOffPosSacalY`, `ClothingOffPosSacalZ` FROM `clothing` WHERE `ClothingDBID` = '%d'",PlayerInfo[playerid][pClothing][3]);
            new Cache:cache = mysql_query(dbCon, query);

            if(!cache_num_rows())
            {
                PlayerInfo[playerid][pClothing][3] = 0;
                return SendErrorMessage(playerid, "ไม่มี ไอดีนี้ในฐ้านข้อมูล");
            }

            new id;

            cache_get_value_index_int(0, 0, id);
            
            cache_get_value_index_int(0, 1, ClothingData[id][C_Owner]);
            cache_get_value_index_bool(0, 2, ClothingData[id][C_Spawn]);
            cache_get_value_index_int(0, 3, ClothingData[id][C_Model]);
            cache_get_value_index_int(0, 4, ClothingData[id][C_Index]);
            cache_get_value_index_int(0, 5, ClothingData[id][C_Bone]);
            cache_get_value_index_float(0, 6, ClothingData[id][C_OFFPOS][0]);
            cache_get_value_index_float(0, 7, ClothingData[id][C_OFFPOS][1]);
            cache_get_value_index_float(0, 8, ClothingData[id][C_OFFPOS][2]);
            cache_get_value_index_float(0, 9, ClothingData[id][C_OFFPOSR][0]);
            cache_get_value_index_float(0, 10, ClothingData[id][C_OFFPOSR][1]);
            cache_get_value_index_float(0, 11, ClothingData[id][C_OFFPOSR][2]);
            cache_get_value_index_float(0, 12, ClothingData[id][C_OFFPOSS][0]);
            cache_get_value_index_float(0, 13, ClothingData[id][C_OFFPOSS][1]);
            cache_get_value_index_float(0, 14, ClothingData[id][C_OFFPOSS][2]);
            cache_delete(cache);

            ClothingData[id][C_ID] = id;

            new str[120], longstr[120];

            format(str, sizeof(str), "ID: %d\n",ClothingData[id][C_ID]);
            strcat(longstr, str);
            format(str, sizeof(str), "Model: %d\n",ClothingData[id][C_Model]);
            strcat(longstr, str);
            format(str, sizeof(str), "Index: %d\n",ClothingData[id][C_Index]);
            strcat(longstr, str);
            format(str, sizeof(str), "Bone: %d\n",ClothingData[id][C_Bone]);
            strcat(longstr, str);

            format(str, sizeof(str), "Pos\n");
            strcat(longstr, str);


            if(ClothingData[id][C_Spawn])
            {
                format(str, sizeof(str), ""EMBED_GREENMONEY"Take Off\n");
                strcat(longstr, str);
            }
            else
            {
                format(str, sizeof(str), ""EMBED_LIGHTRED"Take On\n");
                strcat(longstr, str);
            }

            format(str, sizeof(str), ""EMBED_LIGHTRED"Delete\n");
            strcat(longstr, str);

            

            PlayerCloID[playerid] = ClothingData[id][C_ID];
            SetPVarInt(playerid, "PlayerClothing", ClothingData[id][C_ID]);

            Dialog_Show(playerid, D_CLOTHING_SELECT, DIALOG_STYLE_LIST, "การแต่งตัว:", longstr, "เลือก", "ยืนยัน");
            return 1;
        }
        case 4:
        {
            if(!PlayerInfo[playerid][pClothing][4])
                return SendErrorMessage(playerid, "คุณไม่มี Model ในนี้");


            mysql_format(dbCon, query, sizeof(query), "SELECT `ClothingDBID`, `ClothingOwnerDBID`, `ClothingSpawn`, `ClothingModel`, `ClothingIndex`, `ClothingBone`, `ClothingOffPosX`, `ClothingOffPosY`, `ClothingOffPosZ`, `ClothingOffPosRX`, `ClothingOffPosRY`, `ClothingOffPosRZ`, `ClothingOffPosSacalX`, `ClothingOffPosSacalY`, `ClothingOffPosSacalZ` FROM `clothing` WHERE `ClothingDBID` = '%d'",PlayerInfo[playerid][pClothing][4]);
            new Cache:cache = mysql_query(dbCon, query);

            if(!cache_num_rows())
            {
                PlayerInfo[playerid][pClothing][4] = 0;
                return SendErrorMessage(playerid, "ไม่มี ไอดีนี้ในฐ้านข้อมูล");
            }

            new id;

            cache_get_value_index_int(0, 0, id);
            
            cache_get_value_index_int(0, 1, ClothingData[id][C_Owner]);
            cache_get_value_index_bool(0, 2, ClothingData[id][C_Spawn]);
            cache_get_value_index_int(0, 3, ClothingData[id][C_Model]);
            cache_get_value_index_int(0, 4, ClothingData[id][C_Index]);
            cache_get_value_index_int(0, 5, ClothingData[id][C_Bone]);
            cache_get_value_index_float(0, 6, ClothingData[id][C_OFFPOS][0]);
            cache_get_value_index_float(0, 7, ClothingData[id][C_OFFPOS][1]);
            cache_get_value_index_float(0, 8, ClothingData[id][C_OFFPOS][2]);
            cache_get_value_index_float(0, 9, ClothingData[id][C_OFFPOSR][0]);
            cache_get_value_index_float(0, 10, ClothingData[id][C_OFFPOSR][1]);
            cache_get_value_index_float(0, 11, ClothingData[id][C_OFFPOSR][2]);
            cache_get_value_index_float(0, 12, ClothingData[id][C_OFFPOSS][0]);
            cache_get_value_index_float(0, 13, ClothingData[id][C_OFFPOSS][1]);
            cache_get_value_index_float(0, 14, ClothingData[id][C_OFFPOSS][2]);
            cache_delete(cache);

            ClothingData[id][C_ID] = id;

            new str[120], longstr[120];

            format(str, sizeof(str), "ID: %d\n",ClothingData[id][C_ID]);
            strcat(longstr, str);
            format(str, sizeof(str), "Model: %d\n",ClothingData[id][C_Model]);
            strcat(longstr, str);
            format(str, sizeof(str), "Index: %d\n",ClothingData[id][C_Index]);
            strcat(longstr, str);
            format(str, sizeof(str), "Bone: %d\n",ClothingData[id][C_Bone]);
            strcat(longstr, str);

            format(str, sizeof(str), "Pos\n");
            strcat(longstr, str);


            if(ClothingData[id][C_Spawn])
            {
                format(str, sizeof(str), ""EMBED_GREENMONEY"Take Off\n");
                strcat(longstr, str);
            }
            else
            {
                format(str, sizeof(str), ""EMBED_LIGHTRED"Take On\n");
                strcat(longstr, str);
            }

            format(str, sizeof(str), ""EMBED_LIGHTRED"Delete\n");
            strcat(longstr, str);

            

            PlayerCloID[playerid] = ClothingData[id][C_ID];
            SetPVarInt(playerid, "PlayerClothing", ClothingData[id][C_ID]);

            Dialog_Show(playerid, D_CLOTHING_SELECT, DIALOG_STYLE_LIST, "การแต่งตัว:", longstr, "เลือก", "ยืนยัน");
            return 1;
        }
    }

    return 1;
}

Dialog:D_CLOTHING_SELECT(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    new id = GetPVarInt(playerid, "PlayerClothing");

    switch(listitem)
    {
        case 0: return 1;
        case 1: 
        {
            if(PlayerInfo[playerid][pAdmin] < 3)
                return 1;

            Dialog_Show(playerid, D_CLOTHING_SETMODEL, DIALOG_STYLE_INPUT, "เปลี่ยน Model", "กรุณาใส่เลขโมเดลของคุณ", "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 2:
        {
            new str[255], longstr[255];

            format(str, sizeof(str), "1\n");
            strcat(longstr, str);
            format(str, sizeof(str), "2\n");
            strcat(longstr, str);
            format(str, sizeof(str), "3\n");
            strcat(longstr, str);
            format(str, sizeof(str), "4\n");
            strcat(longstr, str);
            format(str, sizeof(str), "5\n");
            strcat(longstr, str);

            Dialog_Show(playerid, D_CLOTHING_INDEX, DIALOG_STYLE_LIST, "เปลี่ยนสล็อต", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 3:
        {
            new str[255], longstr[255];

            format(str, sizeof(str), "กระดูกสันหลัง\n");
            strcat(longstr, str);
            format(str, sizeof(str), "ศีรษะ\n");
            strcat(longstr, str);
            format(str, sizeof(str), "ต้นแขนซ้าย\n");
            strcat(longstr, str);
            format(str, sizeof(str), "ต้นแขนขวา\n");
            strcat(longstr, str);
            format(str, sizeof(str), "มือซ้าย\n");
            strcat(longstr, str);
            format(str, sizeof(str), "มือขวา\n");
            strcat(longstr, str);
            format(str, sizeof(str), "ต้นขาซ้าย\n");
            strcat(longstr, str);
            format(str, sizeof(str), "ต้นขาขวา\n");
            strcat(longstr, str);
            format(str, sizeof(str), "เท้าซ้าย\n");
            strcat(longstr, str);
            format(str, sizeof(str), "เท้าขวา\n");
            strcat(longstr, str);
            format(str, sizeof(str), "น่องขวา\n");
            strcat(longstr, str);
            format(str, sizeof(str), "น่องซ้าย\n");
            strcat(longstr, str);
            format(str, sizeof(str), "แขนซ้าย\n");
            strcat(longstr, str);
            format(str, sizeof(str), "ท่อนแขนขวา\n");
            strcat(longstr, str);
            format(str, sizeof(str), "กระดูกไหปลาร้าซ้าย (ไหล่)\n");
            strcat(longstr, str);
            format(str, sizeof(str), "กระดูกไหปลาร้าขวา (ไหล่)\n");
            strcat(longstr, str);
            format(str, sizeof(str), "คอ\n");
            strcat(longstr, str);
            format(str, sizeof(str), "กราม\n");
            strcat(longstr, str);

            Dialog_Show(playerid, D_CLOTHING_BONE, DIALOG_STYLE_LIST, "เปลี่ยนจุด", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 4:
        {

            if(ClothingData[id][C_Spawn])
            {
                EditAttachedObject(playerid, ClothingData[id][C_Index]);
            }
            else
            {
                SetPlayerAttachedObject(playerid, ClothingData[id][C_Index], ClothingData[id][C_Model], ClothingData[id][C_Bone], ClothingData[id][C_OFFPOS][0], ClothingData[id][C_OFFPOS][1], ClothingData[id][C_OFFPOS][2], ClothingData[id][C_OFFPOSR][0], ClothingData[id][C_OFFPOSR][1], ClothingData[id][C_OFFPOSR][2], ClothingData[id][C_OFFPOSS][0], ClothingData[id][C_OFFPOSS][1], ClothingData[id][C_OFFPOSS][2], 0);
                EditAttachedObject(playerid, ClothingData[id][C_Index]);
            }
            return 1;
        }
        case 5:
        {
            if(ClothingData[id][C_Spawn])
            {
                RemovePlayerAttachedObject(playerid, ClothingData[id][C_Index]);
                ClothingData[id][C_Spawn] = false;
                SaveClothing(id);
                DeletePVar(playerid, "PlayerClothing");
                return 1;
            }

            if(IsPlayerAttachedObjectSlotUsed(playerid, ClothingData[id][C_Index]))
                RemovePlayerAttachedObject(playerid, ClothingData[id][C_Index]);

            SetPlayerAttachedObject(playerid, ClothingData[id][C_Index], ClothingData[id][C_Model], ClothingData[id][C_Bone], ClothingData[id][C_OFFPOS][0], ClothingData[id][C_OFFPOS][1], ClothingData[id][C_OFFPOS][2], ClothingData[id][C_OFFPOSR][0], ClothingData[id][C_OFFPOSR][1], ClothingData[id][C_OFFPOSR][2], ClothingData[id][C_OFFPOSS][0], ClothingData[id][C_OFFPOSS][1], ClothingData[id][C_OFFPOSS][2], 0);
            ClothingData[id][C_Spawn] = true;
            SendClientMessageEx(playerid, -1, "คุณได้ใส่เครื่องแต่ตัวแล้ว %d", ClothingData[id][C_Model]);
            SaveClothing(id);
            DeletePVar(playerid, "PlayerClothing");
            return 1;
        }
        case 6:
        {
           
            if(ClothingData[id][C_Spawn])
                RemovePlayerAttachedObject(playerid, ClothingData[id][C_Index]);

            new query[120];
            mysql_format(dbCon, query, sizeof(query), "DELETE FROM `clothing` WHERE `ClothingDBID` = '%d'", id);
            mysql_tquery(dbCon, query);


            for(new i = 1; i < MAX_PLAYER_CLOTHING; i++)
            {
                if(PlayerInfo[playerid][pClothing][i] == id)
                {
                    PlayerInfo[playerid][pClothing][i] = 0;
                }
            }

            ClothingData[id][C_ID] = 0;
            ClothingData[id][C_Spawn] = false;
            ClothingData[id][C_Model] = 0;
            CharacterSave(playerid);
            DeletePVar(playerid, "PlayerClothing");
            return 1;
        }
    }
    return 1;
}

Dialog:D_CLOTHING_SETMODEL(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        ShowClothing(playerid);
        PlayerCloID[playerid] = 0;
        return 1;
    }

    new modelid = strval(inputtext);

    new id = GetPVarInt(playerid, "PlayerClothing");

    ClothingData[id][C_Model] = modelid;
    SendClientMessageEx(playerid, COLOR_LIGHTRED, "คุณได้เปลี่ยน Model เป็น %d", modelid);
    SaveClothing(id);
    DeletePVar(playerid, "PlayerClothing");
    return 1;
}

Dialog:D_CLOTHING_BONE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new id = GetPVarInt(playerid, "PlayerClothing");
    ClothingData[id][C_Bone] = listitem+1;

    SendClientMessageEx(playerid, -1, "คุณได้เปลี่ยนต่ำแหน่ง Bone ไปที่ %d",listitem+1);
    SaveClothing(id);
    DeletePVar(playerid, "PlayerClothing");
    return 1;
}

Dialog:D_CLOTHING_INDEX(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new id = GetPVarInt(playerid, "PlayerClothing");

    ClothingData[id][C_Index] = listitem+1;

    SendClientMessageEx(playerid, -1, "คุณได้เปลี่ยนต่ำแหน่ง Index ไปที่ %d",listitem+1);
    SaveClothing(id);
    DeletePVar(playerid, "PlayerClothing");
    return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    if(response)
    {
        if(GetPVarInt(playerid, "PlayerClothing"))
        {
            new id = GetPVarInt(playerid, "PlayerClothing");

            if(IsPlayerAttachedObjectSlotUsed(playerid, ClothingData[id][C_Index]))
                RemovePlayerAttachedObject(playerid, ClothingData[id][C_Index]);


            ClothingData[id][C_OFFPOS][0] = fOffsetX;
            ClothingData[id][C_OFFPOS][1] = fOffsetY;
            ClothingData[id][C_OFFPOS][2] = fOffsetZ;

            ClothingData[id][C_OFFPOSR][0] = fRotX;
            ClothingData[id][C_OFFPOSR][1] = fRotY;
            ClothingData[id][C_OFFPOSR][2] = fRotZ;

            ClothingData[id][C_OFFPOSS][0] = fScaleX;
            ClothingData[id][C_OFFPOSS][1] = fScaleY;
            ClothingData[id][C_OFFPOSS][2] = fScaleZ;

            ClothingData[id][C_Spawn] = true;
            
            SetPlayerAttachedObject(playerid, index, modelid, boneid, fOffsetX, fOffsetY, fOffsetZ,fRotX, fRotY, fRotZ,fScaleX,fScaleY,fScaleZ,0,0);
            SaveClothing(id);
            DeletePVar(playerid, "PlayerClothing");
            return 1;
        }
        if(PlayerSeCloBuy[playerid])
        {
        
            new query[1000];
            mysql_format(dbCon, query, sizeof(query), "INSERT INTO `clothing` (`ClothingOwnerDBID`, `ClothingModel`, `ClothingIndex`, `ClothingBone`, `ClothingOffPosX`, `ClothingOffPosY`, `ClothingOffPosZ`, `ClothingOffPosRX`, `ClothingOffPosRY`, `ClothingOffPosRZ`, `ClothingOffPosSacalX`, `ClothingOffPosSacalY`, `ClothingOffPosSacalZ`) VALUE ('%d','%d','%d','%d', '%f','%f','%f','%f','%f','%f','%f','%f','%f')",
            PlayerInfo[playerid][pDBID],
            modelid,
            index,
            boneid,
            fOffsetX,
            fOffsetY,
            fOffsetZ,
            fRotX,
            fRotY,
            fRotZ,
            fScaleX,
            fScaleY,
            fScaleZ);
            mysql_tquery(dbCon, query, "Query_InsertClothing", "ddddfffffffff",playerid, modelid, index, boneid, fOffsetX, fOffsetY,fOffsetZ,fRotX, fRotY, fRotZ,fScaleX, fScaleY, fScaleZ);
            
            return 1;
        }
        return 1;
    }
    else
    {
        if(GetPVarInt(playerid, "PlayerClothing"))
        {
            new id = GetPVarInt(playerid, "PlayerClothing");
            RemovePlayerAttachedObject(playerid, ClothingData[id][C_Index]);
            return 1;
        }
        if(PlayerSeCloBuy[playerid])
        {
            RemovePlayerAttachedObject(playerid, 6);
            CharacterSave(playerid);

            PlayerSeCloBuy[playerid] = 0;
            return 1;
        }
    }
    return 1;
}

forward Query_InsertClothing(playerid, modelid, index, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ);
public Query_InsertClothing(playerid, modelid, index, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{

    new id = PlayerSeCloBuySect[playerid];

    PlayerInfo[playerid][pClothing][id] = cache_insert_id();

    SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้ทำการซื้อ %d สำเร็จแล้ว",id);
    PlayerSeCloBuy[playerid] = 0;
    PlayerEdit[playerid] = PLAYER_EDIT_NONE;
    RemovePlayerAttachedObject(playerid, index);
    
    CharacterSave(playerid);
    return 1;
}

stock ShowClothing(playerid)
{
    new str[120], longstr[120];

    for(new i = 1; i < MAX_PLAYER_CLOTHING; i++)
    {
        format(str, sizeof(str), "CLOTHING %d\n", i);
        strcat(longstr, str);
    }

    Dialog_Show(playerid, D_CLOTHING_LIST, DIALOG_STYLE_LIST, "ของแต่งตัว:", longstr, "เลือก", "ยกเลิก");
    return 1;
}