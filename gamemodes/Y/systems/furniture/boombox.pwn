#include <YSI_Coding\y_hooks>


new PlayerEditBoomBox[MAX_PLAYERS];

hook OnPlayerDisconnect(playerid, reason)
{
    if(PlayerInfo[playerid][pBoomBoxSpawnID])
    {
        DestroyDynamicObject(BoomBoxInfo[PlayerInfo[playerid][pBoomBoxSpawnID]][BoomBoxObject]);

        foreach(new i : Player)
        {
            new id = PlayerInfo[playerid][pBoomBoxSpawnID];

            if(!IsPlayerInRangeOfPoint(i, 35.0, BoomBoxInfo[id][BoomBoxPos][0], BoomBoxInfo[id][BoomBoxPos][1], BoomBoxInfo[id][BoomBoxPos][2]))
                continue;

            StopAudioStreamForPlayer(i);
        }
    }
    return 1;
}

CMD:boombox(playerid, params[])
{
    new option[35], option_2[255];

    if(sscanf(params, "s[35]S()[255]",option,option_2))
    {
        SendClientMessage(playerid,-1, "___________BOOOM BOX___________");
        SendClientMessage(playerid, -1, "");
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/boombox place"EMBED_WHITE" (วาง Boombox)");
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/boombox get"EMBED_WHITE" (เก็บ Boombox)");
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/boombox give"EMBED_WHITE" (ให้ Boombox)");
        SendClientMessage(playerid, -1, "");
        SendClientMessage(playerid,-1, "___________BOOOM BOX___________");
        return 1;
    }

    if(!PlayerInfo[playerid][pBoomBox])
        return SendErrorMessage(playerid,  "คุณไม่มี BoomBox");

    if(!strcmp(option, "place",true))
    {
        new idx = 0;

        if(PlayerInfo[playerid][pBoomBoxSpawnID])
            return SendErrorMessage(playerid, "คุณได้มีการวาง BoomBox แล้ว");

        for(new i = 1; i < MAX_BOOMBOX; i++)
        {
            if(BoomBoxInfo[i][BoomBoxID])
                continue;
            
            idx = i;
            break;
        }
        if(idx == 0) return SendErrorMessage(playerid, "มีการใช้  BoomBox ถึงขีดจำกัดของเซิร์ฟเวอร์แล้ว");
        
        if(IsPlayerAndroid(playerid) == true)
        {
            PlaceBoomBox(playerid, idx);
            return 1;
        }
        else EditObjectBoomBox(playerid, idx);
        return 1;
    }
    if(!strcmp(option, "get",true))
    {
        if(!PlayerInfo[playerid][pBoomBoxSpawnID])
            return SendErrorMessage(playerid, "คุณไม่ได้มีการวาง BoomBox");

        new id = PlayerInfo[playerid][pBoomBoxSpawnID];
        
        if(!IsPlayerInRangeOfPoint(playerid, 3.5, BoomBoxInfo[id][BoomBoxPos][0], BoomBoxInfo[id][BoomBoxPos][1], BoomBoxInfo[id][BoomBoxPos][2]))
            return  SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ BoomBox ของคุณ");

        BoomBoxInfo[id][BoomBoxID] = 0;
        BoomBoxInfo[id][BoomBoxSpawn] = false;
        PlayerInfo[playerid][pBoomBoxSpawnID] = 0;
        DestroyDynamicObject(BoomBoxInfo[id][BoomBoxObject]);
        SendNearbyMessage(playerid, 5.5, COLOR_EMOTE, "> %s เก็บ BoomBox",ReturnName(playerid,0));
        return 1;
    }
    else SendErrorMessage(playerid,  "กรุณาพิพม์ให้ถูกต้อง");
    return 1;
}

stock EditObjectBoomBox(playerid, id)
{
    new Float:x, Float:y, Float:z, worldid, interiorid;
    GetPlayerPos(playerid, x, y, z);
    worldid = GetPlayerVirtualWorld(playerid);
    interiorid = GetPlayerInterior(playerid);

    BoomBoxInfo[id][BoomBoxID] = id;
    BoomBoxInfo[id][BoomBoxSpawn] = true;
    BoomBoxInfo[id][BoomBoxObject] =  CreateDynamicObject(2226, x, y, z-2, 0.0, 0.0, 0.0, worldid, interiorid, -1);
    EditDynamicObject(playerid, BoomBoxInfo[id][BoomBoxObject]);
    PlayerEditBoomBox[playerid] = id;
    PlayerEditObject[playerid] = true;
    PlayerInfo[playerid][pBoomBoxSpawnID] = id;
    return 1;
}

stock PlaceBoomBox(playerid, id)
{
    new Float:x,Float:y, Float:z;
    GetPlayerPos(playerid, x,y, z);

    BoomBoxInfo[id][BoomBoxPos][0] = x;
    BoomBoxInfo[id][BoomBoxPos][1] = y;
    BoomBoxInfo[id][BoomBoxPos][2] = z-1;
    BoomBoxInfo[id][BoomBoxPos][3] = 0.0;
    BoomBoxInfo[id][BoomBoxPos][4] = 0.0;
    BoomBoxInfo[id][BoomBoxPos][5] = 0.0;
    BoomBoxInfo[id][BoomBoxWorld] = GetPlayerVirtualWorld(playerid);

    SendClientMessageEx(playerid, -1, "คุณได้มีการวาง BoomBox (%d)",id);
    SendNearbyMessage(playerid, 5.5, COLOR_EMOTE, "> %s วาง BoomBox",ReturnName(playerid,0));
    PlayerEditBoomBox[playerid] = 0;
    PlayerEditObject[playerid] = false;
    return 1;
}

hook OP_EditDynamicObject(playerid, STREAMER_TAG_OBJECT:objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    switch(response)
    {
        case EDIT_RESPONSE_FINAL:
        {
            if(PlayerEditBoomBox[playerid])
            {
                new id = PlayerEditBoomBox[playerid];
                BoomBoxInfo[id][BoomBoxPos][0] = x;
                BoomBoxInfo[id][BoomBoxPos][1] = y;
                BoomBoxInfo[id][BoomBoxPos][2] = z;
                BoomBoxInfo[id][BoomBoxPos][3] = rx;
                BoomBoxInfo[id][BoomBoxPos][4] = ry;
                BoomBoxInfo[id][BoomBoxPos][5] = rz;
                BoomBoxInfo[id][BoomBoxWorld] = GetPlayerVirtualWorld(playerid);
                DestroyDynamicObject(objectid);

                BoomBoxInfo[id][BoomBoxObject] = CreateDynamicObject(2226, x, y, z, rx,ry,rz, BoomBoxInfo[id][BoomBoxWorld], -1, -1);
                SendClientMessageEx(playerid, -1, "คุณได้มีการวาง BoomBox (%d)",id);
                SendNearbyMessage(playerid, 5.5, COLOR_EMOTE, "> %s วาง BoomBox",ReturnName(playerid,0));

                PlayerEditBoomBox[playerid] = 0;
                PlayerEditObject[playerid] = false;
                return 1;
            }
        }
        case EDIT_RESPONSE_CANCEL:
        {
            new id = PlayerEditBoomBox[playerid];

            BoomBoxInfo[id][BoomBoxID] = 0;
            BoomBoxInfo[id][BoomBoxSpawn] = false;
            DestroyDynamicObject(objectid);
            PlayerEditBoomBox[playerid] = 0;
            PlayerEditObject[playerid] = false;
            PlayerInfo[playerid][pBoomBoxSpawnID] = 0;
        }
    }
    return 1;
}