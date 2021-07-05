

new PlayerSeClo[MAX_PLAYERS], PlayerSeCloBuy[MAX_PLAYERS], PlayerSeCloBuySect[MAX_PLAYERS], PlayerCloID[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    PlayerSeClo[playerid] = 0;
    PlayerSeCloBuy[playerid] = 0;
    PlayerSeCloBuy[playerid] = 0;
    return 1;
}

CMD:buyclothing(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "คุณต้องลงจากยานพาหนะ");


    if(PlayerInfo[playerid][pCash] < 700)
        return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอ (700)");

    
    new str[255], longstr[255], idx = -1;

    for(new i = 1; i < MAX_PLAYER_CLOTHING; i++)
    {
        if(PlayerInfo[playerid][pClothing][i-1])
            continue;
        
        if(!PlayerInfo[playerid][pClothing][i-1])
        {
            idx = i-1;
            break;
        }
    }
    if(idx == -1) return SendErrorMessage(playerid, "คุณมีการซื้อเต็มแล้ว");



    PlayerSeCloBuySect[playerid] = idx;

    if(IsPlayerInRangeOfPoint(playerid, 3.5, 1103.0127,-1440.1101,15.7969))
    {
        format(str, sizeof(str), "Hammer\n");
        strcat(longstr, str);
        format(str, sizeof(str), "Crowbar\n");
        strcat(longstr, str);
        format(str, sizeof(str), "BlackHat\n");
        strcat(longstr, str);
        format(str, sizeof(str), "HardHat\n");
        strcat(longstr, str);
        format(str, sizeof(str), "Screwdriver\n");
        strcat(longstr, str);
        format(str, sizeof(str), "HoldAllEdited\n");
        strcat(longstr, str);
        format(str, sizeof(str), "MedicCase\n");
        strcat(longstr, str);
        format(str, sizeof(str), "CapTrucker\n");
        strcat(longstr, str);
        format(str, sizeof(str), "GlassesType\n");
        strcat(longstr, str);
        format(str, sizeof(str), "WatchType\n");
        strcat(longstr, str);
        format(str, sizeof(str), "PoliceGlasses\n");
        strcat(longstr, str);
        format(str, sizeof(str), "bassguitar\n");
        strcat(longstr, str);
        format(str, sizeof(str), "Flashlight\n");
        strcat(longstr, str);

        Dialog_Show(playerid, D_CLOTHING_BUY, DIALOG_STYLE_LIST, "BUY CLOTHING:", longstr, "ยืนยัน", "ยกเลิก");
        PlayerSeClo[playerid] = 0;
        return 1;
    }
    else SendErrorMessage(playerid, "คุณไมได้อยู่จุดซื้อ Clothing");
    return 1;
}


CMD:clothing(playerid, params[])
{
    new type[20], str_2[20];

    if(sscanf(params, "s[20]S()[20]", type, str_2))
    {
        SendUsageMessage(playerid, "/clothing < type >");
        SendClientMessage(playerid, COLOR_GREY, "TYPE: list give"); 
        return 1;
    }
    
    if(!strcmp(type, "list", true))
    {
        ShowClothing(playerid);
        return 1;
    }
    else if(!strcmp(type, "give", true))
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

        if(ClothingInfo[PlayerInfo[playerid][pClothing][id-1]][ClothingSpawn])
        {
            RemovePlayerAttachedObject(playerid, ClothingInfo[PlayerInfo[playerid][pClothing][id-1]][ClothingIndex]);
        }

        PlayerInfo[tagetid][pClothing][idx] = PlayerInfo[playerid][pClothing][id-1];

        ClothingInfo[id][ClothingOwnerDBID] = PlayerInfo[tagetid][pDBID];
        SaveClothing(id);

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
    }
    return 1;
}

Dialog:D_CLOTHING_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    switch(listitem)
    {
        case 0:
        {
            if(!PlayerInfo[playerid][pClothing][0])
                return SendErrorMessage(playerid, "คุณไม่มี Model ในนี้");


            new id = PlayerInfo[playerid][pClothing][0];

            new query[400];

            mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `clothing` WHERE `ClothingDBID` = '%d'", id);
            mysql_tquery(dbCon, query, "SelectClothingID", "d", playerid);
            return 1;
        }
        case 1:
        {
            if(!PlayerInfo[playerid][pClothing][1])
                return SendErrorMessage(playerid, "คุณไม่มี Model ในนี้");


            new id = PlayerInfo[playerid][pClothing][1];

            new query[400];

            mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `clothing` WHERE `ClothingDBID` = '%d'", id);
            mysql_tquery(dbCon, query, "SelectClothingID", "d", playerid);
            return 1;
        }
        case 2:
        {
            if(!PlayerInfo[playerid][pClothing][2])
                return SendErrorMessage(playerid, "คุณไม่มี Model ในนี้");


            new id = PlayerInfo[playerid][pClothing][2];

            new query[400];

            mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `clothing` WHERE `ClothingDBID` = '%d'", id);
            mysql_tquery(dbCon, query, "SelectClothingID", "d", playerid);
            return 1;
        }
        case 3:
        {
            if(!PlayerInfo[playerid][pClothing][3])
                return SendErrorMessage(playerid, "คุณไม่มี Model ในนี้");


            new id = PlayerInfo[playerid][pClothing][3];

            new query[400];

            mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `clothing` WHERE `ClothingDBID` = '%d'", id);
            mysql_tquery(dbCon, query, "SelectClothingID", "d", playerid);
            return 1;
        }
        case 4:
        {
            if(!PlayerInfo[playerid][pClothing][4])
                return SendErrorMessage(playerid, "คุณไม่มี Model ในนี้");


            new id = PlayerInfo[playerid][pClothing][4];

            new query[400];

            mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `clothing` WHERE `ClothingDBID` = '%d'", id);
            mysql_tquery(dbCon, query, "SelectClothingID", "d", playerid);
            return 1;
        }
    }

    return 1;
}

Dialog:D_CLOTHING_SELECT(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    new id = PlayerCloID[playerid];

    switch(listitem)
    {
        case 0: return 1;
        case 1: return 1;
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
            if(ClothingInfo[id][ClothingSpawn])
            {
                EditAttachedObject(playerid, ClothingInfo[id][ClothingIndex]);
            }
            else
            {
                SetPlayerAttachedObject(playerid, ClothingInfo[id][ClothingIndex], ClothingInfo[id][ClothingModel], ClothingInfo[id][ClothingBone], ClothingInfo[id][ClothingOffPos][0], ClothingInfo[id][ClothingOffPos][1], ClothingInfo[id][ClothingOffPos][2], ClothingInfo[id][ClothingOffPosR][0], ClothingInfo[id][ClothingOffPosR][1], ClothingInfo[id][ClothingOffPosR][2], ClothingInfo[id][ClothingOffPosSacal][0], ClothingInfo[id][ClothingOffPosSacal][1], ClothingInfo[id][ClothingOffPosSacal][2],0);
                EditAttachedObject(playerid, ClothingInfo[id][ClothingIndex]);
            }
            return 1;
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
        case 6:
        {
            for(new i = 1; i < MAX_PLAYER_CLOTHING; i++)
            {
                if(PlayerInfo[playerid][pClothing][i-1] != ClothingInfo[id][ClothingDBID])
                    continue;

                PlayerInfo[playerid][pClothing][i-1] = 0;
            }

            if(ClothingInfo[id][ClothingSpawn])
                RemovePlayerAttachedObject(playerid, ClothingInfo[id][ClothingIndex]);

            new query[120];
            mysql_format(dbCon, query, sizeof(query), "DELETE FROM `clothing` WHERE `ClothingDBID` = '%d'", ClothingInfo[id][ClothingDBID]);
            mysql_tquery(dbCon, query);

            ClothingInfo[id][ClothingDBID] = 0;
            ClothingInfo[id][ClothingSpawn] = false;
            ClothingInfo[id][ClothingModel] = 0;
            CharacterSave(playerid);
            return 1;
        }
    }
    return 1;
}

Dialog:D_CLOTHING_BONE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new id = PlayerSeClo[playerid];
    ClothingInfo[id][ClothingBone] = listitem+1;

    SendClientMessageEx(playerid, -1, "คุณได้เปลี่ยนต่ำแหน่ง Bone ไปที่ %d",listitem+1);
    SaveClothing(id);
    return 1;
}

Dialog:D_CLOTHING_INDEX(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new id = PlayerSeClo[playerid];
    ClothingInfo[id][ClothingIndex] = listitem+1;

    SendClientMessageEx(playerid, -1, "คุณได้เปลี่ยนต่ำแหน่ง Index ไปที่ %d",listitem+1);
    SaveClothing(id);
    return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    if(response)
    {
        if(PlayerCloID[playerid])
        {
            new id = PlayerCloID[playerid];

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
            
            SetPlayerAttachedObject(playerid, index, modelid, boneid, fOffsetX, fOffsetY, fOffsetZ,fRotX, fRotY, fRotZ,fScaleX,fScaleY,fScaleZ,0,0);
            SaveClothing(id);
            PlayerCloID[playerid] = 0;
            return 1;
        }
        if(PlayerSeCloBuy[playerid])
        {
            new idx = 0;

            for(new i = 1; i < MAX_CLOTHING; i++)
            {
                if(!ClothingInfo[i][ClothingDBID])
                {
                    idx = i;
                    break;
                }
            }

            if(idx == 0) return SendErrorMessage(playerid, "ของแต่ตัวเต็มเซิร์ฟเวอร์แล้ว");
        
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
            mysql_tquery(dbCon, query, "Query_InsertClothing", "dddddfffffffff",playerid, idx, modelid, index, boneid, fOffsetX, fOffsetY,fOffsetZ,fRotX, fRotY, fRotZ,fScaleX, fScaleY, fScaleZ);
            
            return 1;
        }
        return 1;
    }
    else
    {
        if(PlayerSeClo[playerid])
        {
            new id = PlayerSeClo[playerid];
            RemovePlayerAttachedObject(playerid, ClothingInfo[id][ClothingIndex]);
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

forward Query_InsertClothing(playerid, newid, modelid, index, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ);
public Query_InsertClothing(playerid, newid, modelid, index, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{

    new id = PlayerSeCloBuySect[playerid];

    PlayerInfo[playerid][pClothing][id] = cache_insert_id();
    ClothingInfo[newid][ClothingDBID] = cache_insert_id();
    ClothingInfo[newid][ClothingOwnerDBID] = PlayerInfo[playerid][pDBID];
    ClothingInfo[newid][ClothingModel] = PlayerSeCloBuy[playerid];
    ClothingInfo[newid][ClothingSpawn] = false;

    ClothingInfo[newid][ClothingOffPos][0] = fOffsetX;
    ClothingInfo[newid][ClothingOffPos][2] = fOffsetY;
    ClothingInfo[newid][ClothingOffPos][2] = fOffsetZ;

    ClothingInfo[newid][ClothingOffPosR][0] = fRotX;
    ClothingInfo[newid][ClothingOffPosR][1] = fRotY;
    ClothingInfo[newid][ClothingOffPosR][2] = fRotZ;

    ClothingInfo[newid][ClothingOffPosSacal][0] = fScaleX;
    ClothingInfo[newid][ClothingOffPosSacal][1] = fScaleY;
    ClothingInfo[newid][ClothingOffPosSacal][2] = fScaleZ;

    SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้ทำการซื้อ %d สำเร็จแล้ว",PlayerSeCloBuy[playerid]);
    PlayerSeCloBuy[playerid] = 0;
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


forward SelectClothingID(playerid);
public SelectClothingID(playerid)
{
    if(!cache_num_rows())
		return SendErrorMessage(playerid, "ไม่มีรถอยู่ในสล็อตนี้"); 
    
    new rows; cache_get_row_count(rows); 

    new C_ID, C_Model, C_Index, C_Bone, bool:C_Spawn;

    for (new i = 0; i < rows && i < MAX_CLOTHING; i++)
    {
        cache_get_value_name_int(i, "ClothingDBID", C_ID);
        cache_get_value_name_int(i, "ClothingModel", C_Model);
        cache_get_value_name_int(i, "ClothingIndex", C_Index);
        cache_get_value_name_int(i, "ClothingBone", C_Bone);
        cache_get_value_name_int(i, "ClothingSpawn", C_Spawn);
    }

    new idx = 0;
    for(new i = 1; i < MAX_CLOTHING; i++)
    {
        if(ClothingInfo[i][ClothingDBID] == C_ID)
        {
            idx = i;
        }
    }
    
    PlayerCloID[playerid] = idx;

    new str[120], longstr[120];

    format(str, sizeof(str), "ID: %d\n",C_ID);
    strcat(longstr, str);
    format(str, sizeof(str), "Model: %d\n",C_Model);
    strcat(longstr, str);
    format(str, sizeof(str), "Index: %d\n",C_Index);
    strcat(longstr, str);
    format(str, sizeof(str), "Bone: %d\n",C_Bone);
    strcat(longstr, str);

    format(str, sizeof(str), "Pos\n");
    strcat(longstr, str);


    if(C_Spawn)
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

    
    Dialog_Show(playerid, D_CLOTHING_SELECT, DIALOG_STYLE_LIST, "การแต่งตัว:", longstr, "เลือก", "ยืนยัน");
    return 1;
}