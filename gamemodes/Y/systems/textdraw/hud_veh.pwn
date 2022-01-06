
#include <YSI_Coding\y_hooks>

new PlayerText:Hud_Vehicle[MAX_PLAYERS][1];

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        ShowHudVehicle(playerid, true);
        return 1;
    }
    else ShowHudVehicle(playerid, false);

    return 1;
}

stock ShowHudVehicle(playerid, show = false)
{

    if(show)
    {
        Hud_Vehicle[playerid][0] = CreatePlayerTextDraw(playerid, 133.000000, 375.000000, "");
        PlayerTextDrawFont(playerid, Hud_Vehicle[playerid][0], 1);
        PlayerTextDrawLetterSize(playerid, Hud_Vehicle[playerid][0], 0.237500, 1.350000);
        PlayerTextDrawTextSize(playerid, Hud_Vehicle[playerid][0], 189.000000, 17.000000);
        PlayerTextDrawSetOutline(playerid, Hud_Vehicle[playerid][0], 1);
        PlayerTextDrawSetShadow(playerid, Hud_Vehicle[playerid][0], 0);
        PlayerTextDrawAlignment(playerid, Hud_Vehicle[playerid][0], 1);
        PlayerTextDrawColor(playerid, Hud_Vehicle[playerid][0], -1);
        PlayerTextDrawBackgroundColor(playerid, Hud_Vehicle[playerid][0], 255);
        PlayerTextDrawBoxColor(playerid, Hud_Vehicle[playerid][0], 50);
        PlayerTextDrawUseBox(playerid, Hud_Vehicle[playerid][0], 0);
        PlayerTextDrawSetProportional(playerid, Hud_Vehicle[playerid][0], 1);
        PlayerTextDrawSetSelectable(playerid, Hud_Vehicle[playerid][0], 0);

        PlayerTextDrawShow(playerid, Hud_Vehicle[playerid][0]);
    }
    else
    {
        PlayerTextDrawDestroy(playerid, Hud_Vehicle[playerid][0]);
    }

    return 1;
}

hook OnPlayerUpdate(playerid)
{
	new str[120];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		format(str, sizeof(str), "km/h: %d~n~Fuel: %.1f", GetVehicleSpeed(vehicleid), VehicleInfo[vehicleid][eVehicleFuel]);
		PlayerTextDrawSetString(playerid, Hud_Vehicle[playerid][0], str);
	}
	return 1;
}