#include <YSI_Coding\y_hooks>

new PlayerText:Infomation[MAX_PLAYERS][1];

new bool:_PlayerShowTextDraw_Infomation[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    Infomation[playerid][0] = CreatePlayerTextDraw(playerid, 251.000000, 412.000000, "infomation textdraw");
	PlayerTextDrawFont(playerid, Infomation[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, Infomation[playerid][0], 0.262500, 0.950000);
	PlayerTextDrawTextSize(playerid, Infomation[playerid][0], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Infomation[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Infomation[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, Infomation[playerid][0], 1);
	PlayerTextDrawColor(playerid, Infomation[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, Infomation[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, Infomation[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, Infomation[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, Infomation[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, Infomation[playerid][0], 0);
    return 1;
}

hook OnPlayerDisconnect(playerid)
{
    return PlayerTextDrawDestroy(playerid, Infomation[playerid][0]);
}

stock SendInfomationMess(playerid, const message[], time = 5)
{

    PlayerTextDrawSetString(playerid, Infomation[playerid][0], message);
    PlayerTextDrawShow(playerid, Infomation[playerid][0]);

    SetTimerEx("PlayerDeleteTextdraw", 1000 * time, false, "d", playerid);
    _PlayerShowTextDraw_Infomation[playerid] = true;
    return 1;
}

stock StopPlayerInfomation(playerid)
{
    PlayerDeleteTextdraw(playerid);
    return 1;
}

forward PlayerDeleteTextdraw(playerid);
public PlayerDeleteTextdraw(playerid)
{
    PlayerTextDrawHide(playerid, Infomation[playerid][0]);
    _PlayerShowTextDraw_Infomation[playerid] = false;
    return 1;
}




