#include <YSI_Coding\y_hooks>


#define MAX_CCTV (50)

enum S_CCTV_DATA
{
    cctv_id,
    Float:cctv_viewpos[4],
    cctv_name[60],
    cctv_vieww,
    
    Float:cctv_lockpos[4],
}
new cctvinfo[MAX_CCTV][S_CCTV_DATA];

enum S_PCCTV_DATA
{
    Float:cctvLastPos[4],
    cctvLastWorld,
    cctvLastInterior,

    cctvLastBiz,
    cctvLastHouse
}
new pcctvinfo[MAX_PLAYERS][S_PCCTV_DATA];


CMD:makecctv(playerid, params[])
{
    if(!PlayerInfo[playerid][pAdmin])
        return 1;

    new idx = 0;

    for(new i = 1; i < MAX_CCTV; i++)
    {
        if(cctvinfo[i][cctv_id])
            continue;

        
        idx = i;
        break;    
    } 
    if(!idx) return SendErrorMessage(playerid, "การสร้าง CCTV เต็มแล้ว");
    
    CreateCCTV(playerid, idx);
    return 1;
}


CMD:editcctv(playerid, params[])
{
    if(!PlayerInfo[playerid][pAdmin])
        return 1;


    new id, a_str[60], b_str[60];


    if(sscanf(params, "is[60]S()[60]", id, a_str, b_str))
    {
        SendUsageMessage(playerid, "/editcctv [ไอดีกล้อง] [option]");
        SendUsageMessage(playerid, "name,viewpos,lockpos, (del)ete");
        return 1;
    }

    if(!cctvinfo[id][cctv_id])
        return SendErrorMessage(playerid, "ไม่มี ไอดี cctv ที่ต้องการ");

    if(!strcmp(a_str, "name"))
    {   
        new newname[60];

        if(sscanf(b_str, "s[60]", newname))
            return SendUsageMessage(playerid, "/editcctv name [ชื่อที่จะตั้งใหม่]");

        if(strlen(newname) < 3 || strlen(newname) > 60)
            return SendErrorMessage(playerid, "คุณตั้งชื่อไม่ถูกต้องกรุณาตั้งใหม่อีกครั้ง");

        format(cctvinfo[id][cctv_name], cctvinfo[id][cctv_name], "%s",newname);
        SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "คุณได้เปลี่ยนชื่อให้กับ cctv ไอดีที่ %d เป็น %s", cctvinfo[id][cctv_id], cctvinfo[id][cctv_name]);
        return 1;
    }
    else if(!strcmp(a_str, "viewpos"))
    {
        new Float:x, Float:y, Float:z, Float:a,world;
    
        GetPlayerPos(playerid, x, y, z);
        world = GetPlayerVirtualWorld(playerid);

        cctvinfo[id][cctv_viewpos][0] = x;
        cctvinfo[id][cctv_viewpos][1] = y;
        cctvinfo[id][cctv_viewpos][2] = z;
        cctvinfo[id][cctv_viewpos][3] = a;
        
        cctvinfo[id][cctv_vieww] = world;
        SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "คุณแก้ไขจุดวาง cctv ไอดีที่ %d",id);
        return 1;
    }
    else if(!strcmp(a_str, "lockpos"))
    {
        new Float:x, Float:y, Float:z, Float:a,world;
    
        GetPlayerPos(playerid, x, y, z);
        world = GetPlayerVirtualWorld(playerid);

        cctvinfo[id][cctv_lockpos][0] = x;
        cctvinfo[id][cctv_lockpos][1] = y;
        cctvinfo[id][cctv_lockpos][2] = z;
        cctvinfo[id][cctv_lockpos][3] = a;
        
        cctvinfo[id][cctv_vieww] = world;
        SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "คุณแก้ไข lock pos cctv ไอดีที่ %d",id);
        return 1;
    }
    else if(!strcmp(a_str, "del"))
    {
        RemoveCCTV(playerid, id);
        return 1;
    }
    else if(!strcmp(a_str, "export"))
    {
        printf("---------EXPORT CCTV POS (%d)---------",id);
        printf("SetPlayerCameraPos(playerid, %.3f,%.3f,%.3f);",cctvinfo[id][cctv_viewpos][0],cctvinfo[id][cctv_viewpos][1],cctvinfo[id][cctv_viewpos][2]);
        printf("SetPlayerCameraLookAt(playerid, %.3f,%.3f,%.3f);",cctvinfo[id][cctv_lockpos][0],cctvinfo[id][cctv_lockpos][1],cctvinfo[id][cctv_lockpos][2]);
        printf("SetPlayerPos(playerid, %.3f,%.3f,%.3f);",cctvinfo[id][cctv_lockpos][0],cctvinfo[id][cctv_lockpos][1],cctvinfo[id][cctv_lockpos][2]);
        printf("---------EXPORT CCTV POS (%d)---------",id);

        SendClientMessage(playerid, COLOR_LIGHTGREEN, "EXPORT YOUR LOG OPEN LOG CCTV_EXPORT");
        return 1;
    }
    else return SendErrorMessage(playerid, "กรุณาเลือก option ให้ถูกต้องเพื่อดำเนินการต่อ");
}


CMD:viewcctv(playerid, params[])
{
    new id;
    if(sscanf(params, "i", id))
    {
        SendUsageMessage(playerid, "/viewcctv [ไอดีกล้อง]");
        return 1;
    }

    if(!cctvinfo[id][cctv_id])
        return SendErrorMessage(playerid, "ไม่มี ไอดี cctv ที่ต้องการ");


    PlayerViewCCTV(playerid, id);
    return 1;
}

CMD:stopcctv(playerid, params[])
{

    PlayerStopCCTV(playerid);
    return 1;
}

stock PlayerStopCCTV(playerid)
{
    SetCameraBehindPlayer(playerid);

    SetPlayerVirtualWorld(playerid, pcctvinfo[playerid][cctvLastWorld]);
    SetPlayerInterior(playerid, pcctvinfo[playerid][cctvLastInterior]);

    SetPlayerPos(playerid, pcctvinfo[playerid][cctvLastPos][0], pcctvinfo[playerid][cctvLastPos][1], pcctvinfo[playerid][cctvLastPos][2]);
    SetPlayerFacingAngle(playerid, pcctvinfo[playerid][cctvLastPos][3]);
    return 1;
}

stock PlayerViewCCTV(playerid, id)
{

    GetPlayerPos(playerid, pcctvinfo[playerid][cctvLastPos][0], pcctvinfo[playerid][cctvLastPos][1], pcctvinfo[playerid][cctvLastPos][2]);
    GetPlayerFacingAngle(playerid, pcctvinfo[playerid][cctvLastPos][3]);

    pcctvinfo[playerid][cctvLastInterior] = GetPlayerInterior(playerid);
    pcctvinfo[playerid][cctvLastWorld] = GetPlayerVirtualWorld(playerid);

    pcctvinfo[playerid][cctvLastBiz] = PlayerInfo[playerid][pInsideBusiness];
    pcctvinfo[playerid][cctvLastHouse] = PlayerInfo[playerid][pInsideProperty];
    
    SetPlayerCameraPos(playerid, cctvinfo[id][cctv_viewpos][0],cctvinfo[id][cctv_viewpos][1],cctvinfo[id][cctv_viewpos][2]);
	SetPlayerCameraLookAt(playerid, cctvinfo[id][cctv_lockpos][0],cctvinfo[id][cctv_lockpos][1],cctvinfo[id][cctv_lockpos][2], 0);
	SetPlayerPos(playerid, cctvinfo[id][cctv_lockpos][0],cctvinfo[id][cctv_lockpos][1],cctvinfo[id][cctv_lockpos][2]);
    SetPlayerVirtualWorld(playerid, cctvinfo[id][cctv_vieww]);

    return 1;
}


stock CreateCCTV(playerid, newid)
{
    new Float:x, Float:y, Float:z, Float:a,world;
    
    GetPlayerPos(playerid, x, y, z);
    world = GetPlayerVirtualWorld(playerid);

    cctvinfo[newid][cctv_id] = newid;
    cctvinfo[newid][cctv_viewpos][0] = x;
    cctvinfo[newid][cctv_viewpos][1] = y;
    cctvinfo[newid][cctv_viewpos][2] = z;
    cctvinfo[newid][cctv_viewpos][3] = a;
    
    cctvinfo[newid][cctv_vieww] = world;

    SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "คุณได้สร้างมุมกล้อง cctv ออกมาแล้ว (%d)",cctvinfo[newid][cctv_id]);
    return 1;
}

stock RemoveCCTV(playerid, id)
{
    cctvinfo[id][cctv_viewpos][0] = 0.0;
    cctvinfo[id][cctv_viewpos][1] = 0.0;
    cctvinfo[id][cctv_viewpos][2] = 0.0;
    cctvinfo[id][cctv_viewpos][3] = 0.0;
    cctvinfo[id][cctv_lockpos][0] = 0.0;
    cctvinfo[id][cctv_lockpos][1] = 0.0;
    cctvinfo[id][cctv_lockpos][2] = 0.0;
    cctvinfo[id][cctv_lockpos][3] = 0.0;
    
    cctvinfo[id][cctv_vieww] = 0;

    format(cctvinfo[id][cctv_name], cctvinfo[id][cctv_name], "None");
    cctvinfo[id][cctv_id] = 0;

    SendClientMessageEx(playerid, COLOR_LIGHTRED, "คุณได้ลบ cctv ไอดีที่ %d ไปเป็นที่เรียบร้อยแล้ว", id);
    return 1;
}