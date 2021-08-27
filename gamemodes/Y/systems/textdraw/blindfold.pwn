new PlayerText:Blindfold[MAX_PLAYERS][1];


hook OnPlayerConnect(playerid)
{
	Blindfold[playerid][0] = CreatePlayerTextDraw(playerid, 326.000000, -1.000000, "_");
	PlayerTextDrawFont(playerid, Blindfold[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, Blindfold[playerid][0], 0.600000, 54.700004);
	PlayerTextDrawTextSize(playerid, Blindfold[playerid][0], 298.500000, 730.000000);
	PlayerTextDrawSetOutline(playerid, Blindfold[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Blindfold[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, Blindfold[playerid][0], 2);
	PlayerTextDrawColor(playerid, Blindfold[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, Blindfold[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, Blindfold[playerid][0], 255);
	PlayerTextDrawUseBox(playerid, Blindfold[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, Blindfold[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, Blindfold[playerid][0], 0);

	return 1;
}

alias:blindfold("screenshot")
CMD:blindfold(playerid, params[])
{

	if(PlayerInfo[playerid][pGUI] == 7)
	{
		PlayerTextDrawHide(playerid, Blindfold[playerid][0]);
		PlayerInfo[playerid][pGUI] = 0;
		return 1;
	}
	
	PlayerTextDrawShow(playerid, Blindfold[playerid][0]);
	PlayerInfo[playerid][pGUI] = 7;
	return 1;
}