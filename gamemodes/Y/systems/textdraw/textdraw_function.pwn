new PlayerText:pPT_Footer[MAX_PLAYERS];


hook OP_Connect(playerid)
{
	pPT_Footer[playerid] = CreatePlayerTextDraw(playerid,118.000000, 283.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,pPT_Footer[playerid], 255);
	PlayerTextDrawFont(playerid,pPT_Footer[playerid], 2);
	PlayerTextDrawLetterSize(playerid,pPT_Footer[playerid], 0.220000, 1.199999);
	PlayerTextDrawColor(playerid,pPT_Footer[playerid], -1);
	PlayerTextDrawSetOutline(playerid,pPT_Footer[playerid], 1);
	PlayerTextDrawSetProportional(playerid,pPT_Footer[playerid], 1);
	return 1;
}

stock ShowPlayerFooter(playerid, const string[], time = 5000) {
	if (PlayerInfo[playerid][pShowFooter]) {
	    PlayerTextDrawSetString(playerid, pPT_Footer[playerid], "_");
	    PlayerTextDrawHide(playerid, pPT_Footer[playerid]);
		KillTimer(PlayerInfo[playerid][pFooterTimer]);
	}

 	PlayerTextDrawSetString(playerid, pPT_Footer[playerid], string);
	PlayerTextDrawShow(playerid, pPT_Footer[playerid]);
	PlayerInfo[playerid][pShowFooter] = true;

	if(time != -1)
		PlayerInfo[playerid][pFooterTimer] = SetTimerEx("HidePlayerFooter", time, 0, "i", playerid);
	
	return 1;
}


forward HidePlayerFooter(playerid);
public HidePlayerFooter(playerid) {
	if(!IsPlayerConnected(playerid))
		return 0;
	
	if (!PlayerInfo[playerid][pShowFooter])
	    return 0;

	PlayerInfo[playerid][pShowFooter] = false;
	return PlayerTextDrawHide(playerid, pPT_Footer[playerid]);
}