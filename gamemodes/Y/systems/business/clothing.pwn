

new PlayerSeClo[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    PlayerSeClo[playerid] = 0;
    return 1;
}

CMD:buyclothing(playerid, params[])
{
    
    return 1;
}


CMD:clothing(playerid, params[])
{
    new str[120], longstr[120], clogid, str_c[9];

    for(new i = 1; i < MAX_PLAYER_CLOTHING; i++)
    {
        format(str, sizeof(str), "CLOTHING: %d index:\n",PlayerInfo[playerid][pClothing][i-1]);
        strcat(longstr, str);
        
        format(str_c, sizeof(str_c), "%d",clogid);
		SetPVarInt(playerid, str_c, i);
        clogid++;
    }

    Dialog_Show(playerid, D_CLOTHING_LIST, DIALOG_STYLE_LIST, "ของแต่งตัว:", longstr, "เลือก", "ยกเลิก");
    return 1;
}

Dialog:D_CLOTHING_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    new str_c[9], str[MAX_STRING], longstr[MAX_STRING];
    format(str_c, sizeof(str_c), "%d",listitem);

    new id = GetPVarInt(playerid, str_c);
    PlayerSeClo[playerid] = id;
    printf("%d", id);

    format(str, sizeof(str), "ID: %d\n",ClothingInfo[id][ClothingDBID]);
    strcat(longstr, str);
    format(str, sizeof(str), "Model: %d\n",ClothingInfo[id][ClothingModel]);
    strcat(longstr, str);
    format(str, sizeof(str), "Index: %d\n",ClothingInfo[id][ClothingIndex]);
    strcat(longstr, str);
    format(str, sizeof(str), "Bone: %d\n",ClothingInfo[id][ClothingBone]);
    strcat(longstr, str);

    format(str, sizeof(str), "Pos\n");
    strcat(longstr, str);

    if(ClothingInfo[id][ClothingSpawn])
    {
        format(str, sizeof(str), ""EMBED_GREENMONEY"Take Off\n");
        strcat(longstr, str);
    }
    else
    {
        format(str, sizeof(str), ""EMBED_LIGHTRED"Take On\n");
        strcat(longstr, str);
    }
    Dialog_Show(playerid, D_CLOTHING_SELECT, DIALOG_STYLE_LIST, "การแต่งตัว:", longstr, "เลือก", "ยืนยัน");
    return 1;
}

Dialog:D_CLOTHING_SELECT(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    new id = PlayerSeClo[playerid];

    switch(listitem)
    {
        case 0: return 1;
        case 1: return 1;
        case 2: return 1;
        case 3: return 1;
        case 4:
        {
            if(ClothingInfo[id][ClothingSpawn])
            {
                EditAttachedObject(playerid, ClothingInfo[id][ClothingIndex]);
            }
            else
            {
                SetPlayerAttachedObject(playerid, ClothingInfo[id][ClothingIndex], ClothingInfo[id][ClothingModel], ClothingInfo[id][ClothingBone], ClothingInfo[id][ClothingOffPos][0], ClothingInfo[id][ClothingOffPos][1], ClothingInfo[id][ClothingOffPos][2], ClothingInfo[id][ClothingOffPosR][0], ClothingInfo[id][ClothingOffPosR][1], ClothingInfo[id][ClothingOffPosR][2], ClothingInfo[id][ClothingOffPosSacal][0], ClothingInfo[id][ClothingOffPosSacal][1], ClothingInfo[id][ClothingOffPosSacal][2],0);
                EditAttachedObject(playerid, ClothingInfo[id][ClothingIndex]);
            }
        }
        case 5:
        {
            if(ClothingInfo[id][ClothingSpawn])
            {
                RemovePlayerAttachedObject(playerid, ClothingInfo[id][ClothingIndex]);
                ClothingInfo[id][ClothingSpawn] = false;
                return 1;
            }

            if(IsPlayerAttachedObjectSlotUsed(playerid, ClothingInfo[id][ClothingIndex]))
                RemovePlayerAttachedObject(playerid, ClothingInfo[id][ClothingIndex]);

            SetPlayerAttachedObject(playerid, ClothingInfo[id][ClothingIndex], ClothingInfo[id][ClothingModel], ClothingInfo[id][ClothingBone], ClothingInfo[id][ClothingOffPos][0], ClothingInfo[id][ClothingOffPos][1], ClothingInfo[id][ClothingOffPos][2], ClothingInfo[id][ClothingOffPosR][0], ClothingInfo[id][ClothingOffPosR][1], ClothingInfo[id][ClothingOffPosR][2], ClothingInfo[id][ClothingOffPosSacal][0], ClothingInfo[id][ClothingOffPosSacal][1], ClothingInfo[id][ClothingOffPosSacal][2],0);
            ClothingInfo[id][ClothingSpawn] = true;
            SendClientMessageEx(playerid, -1, "คุณได้ใส่เครื่องแต่ตัวแล้ว %d", ClothingInfo[id][ClothingModel]);
            return 1;
        }
    }
    return 1;
}


public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    if(response)
    {
        new id = PlayerSeClo[playerid];

        if(IsPlayerAttachedObjectSlotUsed(playerid, ClothingInfo[id][ClothingIndex]))
            RemovePlayerAttachedObject(playerid, ClothingInfo[id][ClothingIndex]);

        ClothingInfo[id][ClothingOffPos][0] = fOffsetX;
        ClothingInfo[id][ClothingOffPos][2] = fOffsetY;
        ClothingInfo[id][ClothingOffPos][2] = fOffsetZ;

        ClothingInfo[id][ClothingOffPosR][0] = fRotX;
        ClothingInfo[id][ClothingOffPosR][1] = fRotY;
        ClothingInfo[id][ClothingOffPosR][2] = fRotZ;

        ClothingInfo[id][ClothingOffPosSacal][0] = fScaleX;
        ClothingInfo[id][ClothingOffPosSacal][1] = fScaleY;
        ClothingInfo[id][ClothingOffPosSacal][2] = fScaleZ;
        ClothingInfo[id][ClothingSpawn] = true;
        
        SetPlayerAttachedObject(playerid, 0, 19521, 2, fOffsetX, fOffsetY, fOffsetZ,fRotX, fRotY, fRotZ,fScaleX,fScaleY,fScaleZ,0,0);
        SaveClothing(id);
        PlayerSeClo[playerid] = 0;
        return 1;
    }
    else
    {
        RemovePlayerAttachedObject(playerid, 0);
        return 1;
    }
}