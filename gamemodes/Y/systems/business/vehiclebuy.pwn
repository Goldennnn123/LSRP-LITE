#include <YSI_Coding\y_hooks>


new PlayerText:VehicleBuy[MAX_PLAYERS][13];
new PlayerText:VehicleSelect[MAX_PLAYERS][9];
new PlayerSeleteVehicle[MAX_PLAYERS];
new PLayerVehiclePrice[MAX_PLAYERS];
new PlayerVehicleColor1[MAX_PLAYERS];
new PlayerVehicleColor2[MAX_PLAYERS];


new possibleVehiclePlates[][] = 
	{"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};


stock ShowVehicleSelect(playerid)
{
	new str[255];
	
	for(new i = 0; i < 13; i++)
	{
		PlayerTextDrawHide(playerid, VehicleBuy[playerid][i]);
	}

	VehicleSelect[playerid][0] = CreatePlayerTextDraw(playerid, 313.000000, 81.000000, "_");
	PlayerTextDrawFont(playerid, VehicleSelect[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, VehicleSelect[playerid][0], 35.049999, 35.049999);
	PlayerTextDrawTextSize(playerid, VehicleSelect[playerid][0], 0.600000, 425.549987);
	PlayerTextDrawSetOutline(playerid, VehicleSelect[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, VehicleSelect[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, VehicleSelect[playerid][0], 2);
	PlayerTextDrawColor(playerid, VehicleSelect[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleSelect[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, VehicleSelect[playerid][0], 1296911871);
	PlayerTextDrawUseBox(playerid, VehicleSelect[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, VehicleSelect[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleSelect[playerid][0], 0);

	VehicleSelect[playerid][1] = CreatePlayerTextDraw(playerid, 313.000000, 93.000000, "_");
	PlayerTextDrawFont(playerid, VehicleSelect[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, VehicleSelect[playerid][1], 0.600000, 32.300010);
	PlayerTextDrawTextSize(playerid, VehicleSelect[playerid][1], 298.500000, 404.000000);
	PlayerTextDrawSetOutline(playerid, VehicleSelect[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, VehicleSelect[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, VehicleSelect[playerid][1], 2);
	PlayerTextDrawColor(playerid, VehicleSelect[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleSelect[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, VehicleSelect[playerid][1], -1094795521);
	PlayerTextDrawUseBox(playerid, VehicleSelect[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, VehicleSelect[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleSelect[playerid][1], 0);

	VehicleSelect[playerid][2] = CreatePlayerTextDraw(playerid, 510.000000, 73.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, VehicleSelect[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, VehicleSelect[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleSelect[playerid][2], 25.000000, 24.500000);
	PlayerTextDrawSetOutline(playerid, VehicleSelect[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, VehicleSelect[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, VehicleSelect[playerid][2], 1);
	PlayerTextDrawColor(playerid, VehicleSelect[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleSelect[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, VehicleSelect[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, VehicleSelect[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, VehicleSelect[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleSelect[playerid][2], 1);

	VehicleSelect[playerid][3] = CreatePlayerTextDraw(playerid, 249.000000, 113.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, VehicleSelect[playerid][3], 5);
	PlayerTextDrawLetterSize(playerid, VehicleSelect[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleSelect[playerid][3], 105.000000, 95.000000);
	PlayerTextDrawSetOutline(playerid, VehicleSelect[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, VehicleSelect[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, VehicleSelect[playerid][3], 1);
	PlayerTextDrawColor(playerid, VehicleSelect[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleSelect[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, VehicleSelect[playerid][3], 255);
	PlayerTextDrawUseBox(playerid, VehicleSelect[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, VehicleSelect[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleSelect[playerid][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, VehicleSelect[playerid][3], PlayerSeleteVehicle[playerid]);
	PlayerTextDrawSetPreviewRot(playerid, VehicleSelect[playerid][3], -10.000000, 0.000000, -48.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, VehicleSelect[playerid][3], PlayerVehicleColor1[playerid], PlayerVehicleColor2[playerid]);

	VehicleSelect[playerid][4] = CreatePlayerTextDraw(playerid, 250.000000, 193.000000, ReturnVehicleModelName(PlayerSeleteVehicle[playerid]));
	PlayerTextDrawFont(playerid, VehicleSelect[playerid][4], 2);
	PlayerTextDrawLetterSize(playerid, VehicleSelect[playerid][4], 0.316666, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleSelect[playerid][4], 391.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, VehicleSelect[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, VehicleSelect[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, VehicleSelect[playerid][4], 1);
	PlayerTextDrawColor(playerid, VehicleSelect[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleSelect[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, VehicleSelect[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, VehicleSelect[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, VehicleSelect[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleSelect[playerid][4], 0);

	format(str, sizeof(str), "PRICE: %s", MoneyFormat(PLayerVehiclePrice[playerid]));
	VehicleSelect[playerid][5] = CreatePlayerTextDraw(playerid, 121.000000, 260.000000, str);
	PlayerTextDrawFont(playerid, VehicleSelect[playerid][5], 2);
	PlayerTextDrawLetterSize(playerid, VehicleSelect[playerid][5], 0.316666, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleSelect[playerid][5], 391.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, VehicleSelect[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, VehicleSelect[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, VehicleSelect[playerid][5], 1);
	PlayerTextDrawColor(playerid, VehicleSelect[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleSelect[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, VehicleSelect[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, VehicleSelect[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, VehicleSelect[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleSelect[playerid][5], 0);

	VehicleSelect[playerid][6] = CreatePlayerTextDraw(playerid, 212.000000, 221.000000, "COLOR1");
	PlayerTextDrawFont(playerid, VehicleSelect[playerid][6], 2);
	PlayerTextDrawLetterSize(playerid, VehicleSelect[playerid][6], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, VehicleSelect[playerid][6], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, VehicleSelect[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, VehicleSelect[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, VehicleSelect[playerid][6], 2);
	PlayerTextDrawColor(playerid, VehicleSelect[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleSelect[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, VehicleSelect[playerid][6], 200);
	PlayerTextDrawUseBox(playerid, VehicleSelect[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, VehicleSelect[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleSelect[playerid][6], 1);

	VehicleSelect[playerid][7] = CreatePlayerTextDraw(playerid, 354.000000, 221.000000, "COLOR2");
	PlayerTextDrawFont(playerid, VehicleSelect[playerid][7], 2);
	PlayerTextDrawLetterSize(playerid, VehicleSelect[playerid][7], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, VehicleSelect[playerid][7], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, VehicleSelect[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, VehicleSelect[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, VehicleSelect[playerid][7], 2);
	PlayerTextDrawColor(playerid, VehicleSelect[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleSelect[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, VehicleSelect[playerid][7], 200);
	PlayerTextDrawUseBox(playerid, VehicleSelect[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, VehicleSelect[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleSelect[playerid][7], 1);

	VehicleSelect[playerid][8] = CreatePlayerTextDraw(playerid, 466.000000, 363.000000, "BUY!!");
	PlayerTextDrawFont(playerid, VehicleSelect[playerid][8], 2);
	PlayerTextDrawLetterSize(playerid, VehicleSelect[playerid][8], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, VehicleSelect[playerid][8], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, VehicleSelect[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, VehicleSelect[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, VehicleSelect[playerid][8], 2);
	PlayerTextDrawColor(playerid, VehicleSelect[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleSelect[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, VehicleSelect[playerid][8], 9109759);
	PlayerTextDrawUseBox(playerid, VehicleSelect[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, VehicleSelect[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleSelect[playerid][8], 1);

	for(new i = 0; i < 9; i++)
	{
		PlayerTextDrawShow(playerid, VehicleSelect[playerid][i]);
	}
	SelectTextDraw(playerid, 0xFFFFFF95);
	return 1;
}

stock ShowVehicleBuy(playerid)
{
	VehicleBuy[playerid][0] = CreatePlayerTextDraw(playerid, 307.000000, 78.000000, "_");
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][0], 0.600000, 35.049999);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][0], 298.500000, 401.500000);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][0], 2);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][0], 1296911871);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][0], 0);

	VehicleBuy[playerid][1] = CreatePlayerTextDraw(playerid, 307.000000, 90.000000, "_");
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][1], 0);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][1], 0.600000, 32.250007);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][1], 298.500000, 380.500000);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][1], 2);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][1], -1094795521);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][1], 0);

	VehicleBuy[playerid][2] = CreatePlayerTextDraw(playerid, 122.000000, 99.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][2], 5);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][2], 68.000000, 73.000000);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][2], 1);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][2], 9);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][2], 255);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][2], 1);
	PlayerTextDrawSetPreviewModel(playerid, VehicleBuy[playerid][2], 521);
	PlayerTextDrawSetPreviewRot(playerid, VehicleBuy[playerid][2], -10.000000, 0.000000, -44.000000, 0.660000);
	PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuy[playerid][2], 1, 1);

	VehicleBuy[playerid][3] = CreatePlayerTextDraw(playerid, 194.000000, 99.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][3], 5);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][3], 68.000000, 73.000000);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][3], 1);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][3], 9);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][3], 255);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][3], 1);
	PlayerTextDrawSetPreviewModel(playerid, VehicleBuy[playerid][3], 526);
	PlayerTextDrawSetPreviewRot(playerid, VehicleBuy[playerid][3], -10.000000, 0.000000, -44.000000, 0.829999);
	PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuy[playerid][3], 1, 1);

	VehicleBuy[playerid][4] = CreatePlayerTextDraw(playerid, 266.000000, 99.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][4], 5);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][4], 68.000000, 73.000000);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][4], 1);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][4], 9);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][4], 255);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][4], 1);
	PlayerTextDrawSetPreviewModel(playerid, VehicleBuy[playerid][4], 420);
	PlayerTextDrawSetPreviewRot(playerid, VehicleBuy[playerid][4], -10.000000, 0.000000, -44.000000, 0.829999);
	PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuy[playerid][4], 1, 1);

	VehicleBuy[playerid][5] = CreatePlayerTextDraw(playerid, 415.000000, 99.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][5], 5);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][5], 68.000000, 73.000000);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][5], 1);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][5], 9);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][5], 255);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][5], 1);
	PlayerTextDrawSetPreviewModel(playerid, VehicleBuy[playerid][5], 499);
	PlayerTextDrawSetPreviewRot(playerid, VehicleBuy[playerid][5], -10.000000, 0.000000, -44.000000, 0.829999);
	PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuy[playerid][5], 1, 1);

	VehicleBuy[playerid][6] = CreatePlayerTextDraw(playerid, 122.000000, 175.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][6], 5);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][6], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][6], 68.000000, 73.000000);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][6], 1);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][6], 9);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][6], 255);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][6], 1);
	PlayerTextDrawSetPreviewModel(playerid, VehicleBuy[playerid][6], 459);
	PlayerTextDrawSetPreviewRot(playerid, VehicleBuy[playerid][6], -10.000000, 0.000000, -44.000000, 0.829999);
	PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuy[playerid][6], 1, 1);

	VehicleBuy[playerid][7] = CreatePlayerTextDraw(playerid, 194.000000, 175.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][7], 5);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][7], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][7], 68.000000, 73.000000);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][7], 1);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][7], 9);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][7], 255);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][7], 1);
	PlayerTextDrawSetPreviewModel(playerid, VehicleBuy[playerid][7], 400);
	PlayerTextDrawSetPreviewRot(playerid, VehicleBuy[playerid][7], -17.000000, 0.000000, -44.000000, 0.740000);
	PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuy[playerid][7], 1, 1);

	VehicleBuy[playerid][8] = CreatePlayerTextDraw(playerid, 266.000000, 175.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][8], 5);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][8], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][8], 68.000000, 73.000000);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][8], 1);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][8], 9);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][8], 255);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][8], 1);
	PlayerTextDrawSetPreviewModel(playerid, VehicleBuy[playerid][8], 534);
	PlayerTextDrawSetPreviewRot(playerid, VehicleBuy[playerid][8], -17.000000, 0.000000, -44.000000, 0.889998);
	PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuy[playerid][8], 1, 1);

	VehicleBuy[playerid][9] = CreatePlayerTextDraw(playerid, 339.000000, 175.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][9], 5);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][9], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][9], 68.000000, 73.000000);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][9], 1);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][9], 9);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][9], 255);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][9], 1);
	PlayerTextDrawSetPreviewModel(playerid, VehicleBuy[playerid][9], 402);
	PlayerTextDrawSetPreviewRot(playerid, VehicleBuy[playerid][9], -17.000000, 0.000000, -44.000000, 0.839999);
	PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuy[playerid][9], 1, 1);

	VehicleBuy[playerid][10] = CreatePlayerTextDraw(playerid, 415.000000, 175.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][10], 5);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][10], 68.000000, 73.000000);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][10], 1);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][10], 9);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][10], 255);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][10], 1);
	PlayerTextDrawSetPreviewModel(playerid, VehicleBuy[playerid][10], 541);
	PlayerTextDrawSetPreviewRot(playerid, VehicleBuy[playerid][10], -17.000000, 0.000000, -44.000000, 0.839999);
	PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuy[playerid][10], 6, 1);

	VehicleBuy[playerid][11] = CreatePlayerTextDraw(playerid, 491.000000, 69.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][11], 4);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][11], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][11], 27.000000, 27.500000);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][11], 1);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][11], -16777166);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][11], 1);

	VehicleBuy[playerid][12] = CreatePlayerTextDraw(playerid, 339.000000, 99.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][12], 5);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][12], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][12], 68.000000, 73.000000);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][12], 1);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][12], 9);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][12], 255);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][12], 1);
	PlayerTextDrawSetPreviewModel(playerid, VehicleBuy[playerid][12], 445);
	PlayerTextDrawSetPreviewRot(playerid, VehicleBuy[playerid][12], -10.000000, 0.000000, -44.000000, 0.829999);
	PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuy[playerid][12], 1, 1);

    for(new i = 0; i < 13; i++)
    {
        PlayerTextDrawShow(playerid, VehicleBuy[playerid][i]);
    }
	PlayerInfo[playerid][pGUI] = 2;
    return 1;
}

hook OP_ClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(PlayerInfo[playerid][pGUI] == 2)
    {
        if(playertextid == VehicleBuy[playerid][11])
        {
            for(new i = 0; i < 13; i++)
            {
                PlayerTextDrawDestroy(playerid, VehicleBuy[playerid][i]);
            }
            PlayerInfo[playerid][pGUI] = 0;
            CancelSelectTextDraw(playerid);
            return 1;
        }
        if(playertextid == VehicleSelect[playerid][2])
        {
            for(new i = 0; i < 13; i++)
            {
                PlayerTextDrawShow(playerid, VehicleBuy[playerid][i]);
            }

            for(new i = 0; i < 9; i++)
            {
                PlayerTextDrawDestroy(playerid, VehicleSelect[playerid][i]);
            }
            return 1;
        }
        if(playertextid == VehicleSelect[playerid][6])
        {
            Dialog_Show(playerid, DIALOG_VEH_COLOR1, DIALOG_STYLE_INPUT, "ใส่สีรถ", "กรุณาเลือกสีรถที่คุณต้องการเปลี่ยน (0-255)", "ยืนยัน", "ยกเลิก");
            return 1;
        }
        if(playertextid == VehicleSelect[playerid][7])
        {
            Dialog_Show(playerid, DIALOG_VEH_COLOR2, DIALOG_STYLE_INPUT, "ใส่สีรถ", "กรุณาเลือกสีรถที่คุณต้องการเปลี่ยน (0-255)", "ยืนยัน", "ยกเลิก");
            return 1;
        }
        if(playertextid == VehicleBuy[playerid][2])
        {
            for(new i = 0; i < 13; i++)
            {
                PlayerTextDrawHide(playerid, VehicleBuy[playerid][i]);
            }
            ShowVehicleBike(playerid);
            return 1;
        }
        if(playertextid == VehicleBuy[playerid][3])
        {
            for(new i = 0; i < 13; i++)
            {
                PlayerTextDrawHide(playerid, VehicleBuy[playerid][i]);
            }
            ShowVehicleCompact(playerid);
            return 1;
        }
        if(playertextid == VehicleBuy[playerid][4])
        {
            for(new i = 0; i < 13; i++)
            {
                PlayerTextDrawHide(playerid, VehicleBuy[playerid][i]);
            }
            ShowVehicleService(playerid);
            return 1;
        }
        if(playertextid == VehicleBuy[playerid][12])
        {
            for(new i = 0; i < 13; i++)
            {
                PlayerTextDrawHide(playerid, VehicleBuy[playerid][i]);
            }
            ShowVehicleLuxury(playerid);
            return 1;
        }
        if(playertextid == VehicleBuy[playerid][5])
        {
            for(new i = 0; i < 13; i++)
            {
                PlayerTextDrawHide(playerid, VehicleBuy[playerid][i]);
            }
            ShowVehicleHeavy(playerid);
            return 1;
        }
        if(playertextid == VehicleBuy[playerid][6])
        {
            for(new i = 0; i < 13; i++)
            {
                PlayerTextDrawHide(playerid, VehicleBuy[playerid][i]);
            }
            ShowVehicleTrucks(playerid);
            return 1;
        }
        if(playertextid == VehicleBuy[playerid][7])
        {
            for(new i = 0; i < 13; i++)
            {
                PlayerTextDrawHide(playerid, VehicleBuy[playerid][i]);
            }
            ShowVehicleVans(playerid);
            return 1;
        }
        if(playertextid == VehicleBuy[playerid][8])
        {
            for(new i = 0; i < 13; i++)
            {
                PlayerTextDrawHide(playerid, VehicleBuy[playerid][i]);
            }
            ShowVehicleLowriders(playerid);
            return 1;
        }
        if(playertextid == VehicleBuy[playerid][9])
        {
            for(new i = 0; i < 13; i++)
            {
                PlayerTextDrawHide(playerid, VehicleBuy[playerid][i]);
            }
            ShowVehicleMuscle(playerid);
            return 1;
        }
        if(playertextid == VehicleBuy[playerid][10])
        {
            if(PlayerInfo[playerid][pDonater] < 2)
                return SendErrorMessage(playerid, "คุณไม่ใช่ Donater ระดับ Gold");

        
            for(new i = 0; i < 13; i++)
            {
                PlayerTextDrawHide(playerid, VehicleBuy[playerid][i]);
            }
            ShowVehicleVip(playerid);
            return 1;
        }
        if(playertextid == VehicleSelect[playerid][8])
        {
            if(PlayerInfo[playerid][pCash] < PLayerVehiclePrice[playerid])
            {
                for(new v = 0; v < 9; v++)
                {
                    PlayerTextDrawDestroy(playerid, VehicleSelect[playerid][v]);
                }

                PlayerSeleteVehicle[playerid] = 0;
                PlayerVehicleColor1[playerid] = 0;
                PlayerVehicleColor2[playerid] = 0;

                SendErrorMessage(playerid,"คุณมีเงินไม่เพียงพอต่อการซื้อ ยังขาดอเงินอยู่ ($%s)",MoneyFormat(PLayerVehiclePrice[playerid] - PlayerInfo[playerid][pCash]));
                
                for(new i = 0; i < 13; i++)
                {
                    PlayerTextDrawDestroy(playerid, VehicleBuy[playerid][i]);
                }
                CancelSelectTextDraw(playerid);

                return 1;
            }

            new
                thread[MAX_STRING],
                Float:X = 1658.7107,
                Float:Y = -1089.3168,
                Float:Z = 23.6117,
                Float:A = 88.6202
            ;


            new
				idx, 
				plates[32],
				randset[3]
			;
				
			for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
			{
				if(!PlayerInfo[playerid][pOwnedVehicles][i])
				{
					idx = i;
					break;
				}
			}


            new modelid = PlayerSeleteVehicle[playerid];
            new Price = PLayerVehiclePrice[playerid];

            randset[0] = random(sizeof(possibleVehiclePlates)); 
			randset[1] = random(sizeof(possibleVehiclePlates)); 
			randset[2] = random(sizeof(possibleVehiclePlates)); 

            format(plates, 32, "%d%s%s%s%d%d%d", random(9), possibleVehiclePlates[randset[0]], possibleVehiclePlates[randset[1]], possibleVehiclePlates[randset[2]], random(9), random(9)); 

            mysql_format(dbCon, thread, sizeof(thread), "INSERT INTO `vehicles` (VehicleOwnerDBID, VehicleModel, VehicleParkPosX, VehicleParkPosY, VehicleParkPosZ, VehicleParkPosA, VehiclePrice) VALUES(%i, %i, %f, %f, %f, %f, %d)",
            PlayerInfo[playerid][pDBID],
            modelid,
            X,
            Y,
            Z,
            A,
            Price);
            mysql_tquery(dbCon, thread, "OnPlayerVehiclePurchase", "iisffff",playerid,idx, plates, X, Y, Z, A);
            return 1;
        }
        return 1;
    }


    return 1;
}

hook OnPlayerConnect(playerid)
{
    return 1;
}

hook OnPlayerDisconnect(playerid)
{
    for(new i = 0; i < 12; i++)
    {
        PlayerTextDrawDestroy(playerid, VehicleBuy[playerid][i]);
    }
    CancelSelectTextDraw(playerid);
    return 1;
}

stock ShowVehicleBike(playerid)
{   
    new longstr[MAX_STRING], str[MAX_STRING];

    format(str, sizeof(str), "NAME\tPRICE\n",MoneyFormat(700));
    strcat(longstr, str);

    format(str, sizeof(str), "BIKE\t$%s\n",MoneyFormat(700));
    strcat(longstr, str);
    format(str, sizeof(str), "Faggio\t$%s\n",MoneyFormat(10000));
    strcat(longstr, str);
    format(str, sizeof(str), "Pizzaboy\t$%s\n",MoneyFormat(12000));
    strcat(longstr, str);
    format(str, sizeof(str), "Freeway\t$%s\n",MoneyFormat(30000));
    strcat(longstr, str);
    format(str, sizeof(str), "Wayfarer\t$%s\n",MoneyFormat(35000));
    strcat(longstr, str);

    Dialog_Show(playerid, DIALOG_BUY_BIKE_LIST, DIALOG_STYLE_TABLIST_HEADERS, "VEHICLE BUY", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

stock ShowVehicleCompact(playerid)
{  
    new longstr[MAX_STRING], str[MAX_STRING];

    format(str, sizeof(str), "NAME\tPRICE\n");
    strcat(longstr, str);

    format(str, sizeof(str), "Alpha\t$%s\n",MoneyFormat(70000));
    strcat(longstr, str);
    format(str, sizeof(str), "Blista Compact\t$%s\n",MoneyFormat(75000));
    strcat(longstr, str);
    format(str, sizeof(str), "Bravura\t$%s\n",MoneyFormat(55000));
    strcat(longstr, str);
    format(str, sizeof(str), "Buccaneer\t$%s\n",MoneyFormat(40000));
    strcat(longstr, str);
    format(str, sizeof(str), "Cadrona\t$%s\n",MoneyFormat(50000));
    strcat(longstr, str);
    format(str, sizeof(str), "Club\t$%s\n",MoneyFormat(90000));
    strcat(longstr, str);
    format(str, sizeof(str), "Esperanto\t$%s\n",MoneyFormat(70000));
    strcat(longstr, str);
    format(str, sizeof(str), "Euros\t$%s\n",MoneyFormat(45000));
    strcat(longstr, str);
    format(str, sizeof(str), "Feltzer\t$%s\n",MoneyFormat(60000));
    strcat(longstr, str);
    format(str, sizeof(str), "Fortune\t$%s\n",MoneyFormat(80000));
    strcat(longstr, str);
    format(str, sizeof(str), "Hermes\t$%s\n",MoneyFormat(200000));
    strcat(longstr, str);
    format(str, sizeof(str), "Hustler\t$%s\n",MoneyFormat(200000));
    strcat(longstr, str);
    format(str, sizeof(str), "Majestic\t$%s\n",MoneyFormat(90000));
    strcat(longstr, str);
    format(str, sizeof(str), "Manana\t$%s\n",MoneyFormat(90000));
    strcat(longstr, str);
    format(str, sizeof(str), "Picador\t$%s\n",MoneyFormat(90000));
    strcat(longstr, str);
    format(str, sizeof(str), "Previon\t$%s\n",MoneyFormat(90000));
    strcat(longstr, str);
    format(str, sizeof(str), "Stallion\t$%s\n",MoneyFormat(85000));
    strcat(longstr, str);
    format(str, sizeof(str), "Tampa\t$%s\n",MoneyFormat(85000));
    strcat(longstr, str);
    format(str, sizeof(str), "Virgo\t$%s\n",MoneyFormat(50000));
    strcat(longstr, str);

    Dialog_Show(playerid, DIALOG_BUY_COMPACT_LIST, DIALOG_STYLE_TABLIST_HEADERS, "VEHICLE BUY", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

stock ShowVehicleService(playerid)
{   
    new longstr[MAX_STRING], str[MAX_STRING];

    format(str, sizeof(str), "NAME\tPRICE\n",MoneyFormat(700));
    strcat(longstr, str);

    format(str, sizeof(str), "Bus\t$%s\n",MoneyFormat(120000));
    strcat(longstr, str);
    format(str, sizeof(str), "Coach\t$%s\n",MoneyFormat(120000));
    strcat(longstr, str);
    format(str, sizeof(str), "Cabbie\t$%s\n",MoneyFormat(100000));
    strcat(longstr, str);
    format(str, sizeof(str), "Taxi\t$%s\n",MoneyFormat(100000));
    strcat(longstr, str);
    format(str, sizeof(str), "Towtruck\t$%s\n",MoneyFormat(30000));
    strcat(longstr, str);
    format(str, sizeof(str), "Trashmaster\t$%s\n",MoneyFormat(200000));
    strcat(longstr, str);
    format(str, sizeof(str), "Utility Van\t$%s\n",MoneyFormat(400000));
    strcat(longstr, str);

    Dialog_Show(playerid, DIALOG_BUY_SERVICE_LIST, DIALOG_STYLE_TABLIST_HEADERS, "VEHICLE BUY", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

stock ShowVehicleLuxury(playerid)
{   
    new longstr[MAX_STRING], str[MAX_STRING];

    format(str, sizeof(str), "NAME\tPRICE\n");
    strcat(longstr, str);

    format(str, sizeof(str), "Admiral\t$%s\n",MoneyFormat(80000));
    strcat(longstr, str);
    format(str, sizeof(str), "Elegant\t$%s\n",MoneyFormat(80000));
    strcat(longstr, str);
    format(str, sizeof(str), "Emperor\t$%s\n",MoneyFormat(80000));
    strcat(longstr, str);
    format(str, sizeof(str), "Glendale\t$%s\n",MoneyFormat(60000));
    strcat(longstr, str);
    format(str, sizeof(str), "Greenwood\t$%s\n",MoneyFormat(50000));
    strcat(longstr, str);
    format(str, sizeof(str), "Intruder\t$%s\n",MoneyFormat(50000));
    strcat(longstr, str);
    format(str, sizeof(str), "Merit\t$%s\n",MoneyFormat(75000));
    strcat(longstr, str);
    format(str, sizeof(str), "Nebula\t$%s\n",MoneyFormat(75000));
    strcat(longstr, str);
    format(str, sizeof(str), "Oceanic\t$%s\n",MoneyFormat(100000));
    strcat(longstr, str);
    format(str, sizeof(str), "Premier\t$%s\n",MoneyFormat(50000));
    strcat(longstr, str);
    format(str, sizeof(str), "Primo\t$%s\n",MoneyFormat(50000));
    strcat(longstr, str);
    format(str, sizeof(str), "Sentinel\t$%s\n",MoneyFormat(60000));
    strcat(longstr, str);
    format(str, sizeof(str), "Stafford\t$%s\n",MoneyFormat(60000));
    strcat(longstr, str);
    format(str, sizeof(str), "Stretch\t$%s\n",MoneyFormat(900000));
    strcat(longstr, str);
    format(str, sizeof(str), "Sunrise\t$%s\n",MoneyFormat(60000));
    strcat(longstr, str);
    format(str, sizeof(str), "Tahoma\t$%s\n",MoneyFormat(60000));
    strcat(longstr, str);
    format(str, sizeof(str), "Vincent\t$%s\n",MoneyFormat(60000));
    strcat(longstr, str);
    format(str, sizeof(str), "Washington\t$%s\n",MoneyFormat(90000));
    strcat(longstr, str);
    format(str, sizeof(str), "Willard\t$%s\n",MoneyFormat(80000));
    strcat(longstr, str);

    Dialog_Show(playerid, DIALOG_BUY_LUXURY_LIST, DIALOG_STYLE_TABLIST_HEADERS, "VEHICLE BUY", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

stock ShowVehicleHeavy(playerid)
{
    new longstr[MAX_STRING], str[MAX_STRING];

    format(str, sizeof(str), "NAME\tPRICE\n",MoneyFormat(700));
    strcat(longstr, str);

    format(str, sizeof(str), "Benson\t$%s\n",MoneyFormat(60000));
    strcat(longstr, str);
    format(str, sizeof(str), "Boxville Mission\t$%s\n",MoneyFormat(90000));
    strcat(longstr, str);
    format(str, sizeof(str), "Boxville\t$%s\n",MoneyFormat(80000));
    strcat(longstr, str);
    format(str, sizeof(str), "DFT-30\t$%s\n",MoneyFormat(500000));
    strcat(longstr, str);
    format(str, sizeof(str), "Hotdog\t$%s\n",MoneyFormat(60000));
    strcat(longstr, str);
    format(str, sizeof(str), "Linerunner\t$%s\n",MoneyFormat(400000));
    strcat(longstr, str);
    format(str, sizeof(str), "Mule\t$%s\n",MoneyFormat(70000));
    strcat(longstr, str);
    format(str, sizeof(str), "Roadtrain\t$%s\n",MoneyFormat(1200000));
    strcat(longstr, str);
    format(str, sizeof(str), "Tanker\t$%s\n",MoneyFormat(1300000));
    strcat(longstr, str);
    format(str, sizeof(str), "Yankee\t$%s\n",MoneyFormat(80000));
    strcat(longstr, str);

    Dialog_Show(playerid, DIALOG_BUY_HEAVRY, DIALOG_STYLE_TABLIST_HEADERS, "VEHICLE BUY", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

stock ShowVehicleTrucks(playerid)
{
   
    new longstr[MAX_STRING], str[MAX_STRING];

    format(str, sizeof(str), "NAME\tPRICE\n",MoneyFormat(700));
    strcat(longstr, str);

    format(str, sizeof(str), "Berkley's RC Van\t$%s\n",MoneyFormat(80000));
    strcat(longstr, str);
    format(str, sizeof(str), "Bobcat\t$%s\n",MoneyFormat(60000));
    strcat(longstr, str);
    format(str, sizeof(str), "Burrito\t$%s\n",MoneyFormat(80000));
    strcat(longstr, str);
    format(str, sizeof(str), "Moonbeam\t$%s\n",MoneyFormat(80000));
    strcat(longstr, str);
    format(str, sizeof(str), "News Van\t$%s\n",MoneyFormat(80000));
    strcat(longstr, str);
    format(str, sizeof(str), "Pony\t$%s\n",MoneyFormat(70000));
    strcat(longstr, str);
    format(str, sizeof(str), "Rumpo\t$%s\n",MoneyFormat(75000));
    strcat(longstr, str);
    format(str, sizeof(str), "Sadler\t$%s\n",MoneyFormat(75000));
    strcat(longstr, str);
    format(str, sizeof(str), "Walton\t$%s\n",MoneyFormat(25000));
    strcat(longstr, str);
    format(str, sizeof(str), "Yosemite\t$%s\n",MoneyFormat(40000));
    strcat(longstr, str);

    Dialog_Show(playerid, DIALOG_BUY_TRUCKS_LIST, DIALOG_STYLE_TABLIST_HEADERS, "VEHICLE BUY", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

stock ShowVehicleVans(playerid)
{   
    new longstr[MAX_STRING], str[MAX_STRING];

    format(str, sizeof(str), "NAME\tPRICE\n",MoneyFormat(700));
    strcat(longstr, str);

    format(str, sizeof(str), "Huntley\t$%s\n",MoneyFormat(75000));
    strcat(longstr, str);
    format(str, sizeof(str), "Landstalker\t$%s\n",MoneyFormat(90000));
    strcat(longstr, str);
    format(str, sizeof(str), "Perennial\t$%s\n",MoneyFormat(90000));
    strcat(longstr, str);
    format(str, sizeof(str), "Rancher\t$%s\n",MoneyFormat(95000));
    strcat(longstr, str);
    format(str, sizeof(str), "Regina\t$%s\n",MoneyFormat(100000));
    strcat(longstr, str);
    format(str, sizeof(str), "Romero\t$%s\n",MoneyFormat(80000));
    strcat(longstr, str);
    format(str, sizeof(str), "Solair\t$%s\n",MoneyFormat(50000));
    strcat(longstr, str);

    Dialog_Show(playerid, DIALOG_BUY_VANS_LIST, DIALOG_STYLE_TABLIST_HEADERS, "VEHICLE BUY", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

stock ShowVehicleLowriders(playerid)
{
   
    new longstr[MAX_STRING], str[MAX_STRING];

    format(str, sizeof(str), "NAME\tPRICE\n",MoneyFormat(700));
    strcat(longstr, str);

    format(str, sizeof(str), "Blade\t$%s\n",MoneyFormat(100000));
    strcat(longstr, str);
    format(str, sizeof(str), "Broadway\t$%s\n",MoneyFormat(200000));
    strcat(longstr, str);
    format(str, sizeof(str), "Remington\t$%s\n",MoneyFormat(250000));
    strcat(longstr, str);
    format(str, sizeof(str), "Savanna\t$%s\n",MoneyFormat(100000));
    strcat(longstr, str);
    format(str, sizeof(str), "Slamvan\t$%s\n",MoneyFormat(150000));
    strcat(longstr, str);
    format(str, sizeof(str), "Tornado\t$%s\n",MoneyFormat(100000));
    strcat(longstr, str);
    format(str, sizeof(str), "Voodoo\t$%s\n",MoneyFormat(150000));
    strcat(longstr, str);

    Dialog_Show(playerid, DIALOG_BUY_LOWIDER_LIST, DIALOG_STYLE_TABLIST_HEADERS, "VEHICLE BUY", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

stock ShowVehicleMuscle(playerid)
{   
    new longstr[MAX_STRING], str[MAX_STRING];

    format(str, sizeof(str), "NAME\tPRICE\n",MoneyFormat(700));
    strcat(longstr, str);

    format(str, sizeof(str), "Buffalo\t$%s\n",MoneyFormat(200000));
    strcat(longstr, str);
    format(str, sizeof(str), "Clover\t$%s\n",MoneyFormat(80000));
    strcat(longstr, str);
    format(str, sizeof(str), "Phoenix\t$%s\n",MoneyFormat(60000));
    strcat(longstr, str);
    format(str, sizeof(str), "Sabre\t$%s\n",MoneyFormat(78000));
    strcat(longstr, str);

    Dialog_Show(playerid, DIALOG_BUY_MUSCLE, DIALOG_STYLE_TABLIST_HEADERS, "VEHICLE BUY", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

stock ShowVehicleVip(playerid)
{   
    new longstr[MAX_STRING], str[MAX_STRING];

    format(str, sizeof(str), "NAME\tPRICE\n",MoneyFormat(700));
    strcat(longstr, str);

    format(str, sizeof(str), "Banshee\t$%s\n",MoneyFormat(300000));
    strcat(longstr, str);
    format(str, sizeof(str), "Bullet\t$%s\n",MoneyFormat(400000));
    strcat(longstr, str);
    format(str, sizeof(str), "Cheetah\t$%s\n",MoneyFormat(400000));
    strcat(longstr, str);
    format(str, sizeof(str), "Comet\t$%s\n",MoneyFormat(400000));
    strcat(longstr, str);
    format(str, sizeof(str), "Elegy\t$%s\n",MoneyFormat(400000));
    strcat(longstr, str);
    format(str, sizeof(str), "Flash\t$%s\n",MoneyFormat(400000));
    strcat(longstr, str);
    format(str, sizeof(str), "Jester\t$%s\n",MoneyFormat(400000));
    strcat(longstr, str);
    format(str, sizeof(str), "Sultan\t$%s\n",MoneyFormat(400000));
    strcat(longstr, str);
    format(str, sizeof(str), "Uranus\t$%s\n",MoneyFormat(400000));
    strcat(longstr, str);

    Dialog_Show(playerid, DIALOG_BUY_VIP, DIALOG_STYLE_TABLIST_HEADERS, "VEHICLE BUY", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}


Dialog:DIALOG_BUY_BIKE_LIST(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		for(new i = 0; i < 13; i++)
		{
			PlayerTextDrawShow(playerid, VehicleBuy[playerid][i]);
		}
		return 1;
	}

	switch(listitem)
    {
        case 0:
        {
            PlayerSeleteVehicle[playerid] = 509;
            PLayerVehiclePrice[playerid] = 700;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 1:
        {
            PlayerSeleteVehicle[playerid] = 462;
            PLayerVehiclePrice[playerid] = 10000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 2:
        {
            PlayerSeleteVehicle[playerid] = 448;
            PLayerVehiclePrice[playerid] = 12000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 3:
        {
            PlayerSeleteVehicle[playerid] = 463;
            PLayerVehiclePrice[playerid] = 30000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 4:
        {
            PlayerSeleteVehicle[playerid] = 586;
            PLayerVehiclePrice[playerid] = 35000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            ShowVehicleSelect(playerid);
            return 1;
        }
    }

	return 1;
}

Dialog:DIALOG_BUY_COMPACT_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowVehicleBuy(playerid);

    switch(listitem)
    {
        case 0:
        {
            PlayerSeleteVehicle[playerid] = 602;
            PLayerVehiclePrice[playerid] = 70000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 1:
        {
            PlayerSeleteVehicle[playerid] = 496;
            PLayerVehiclePrice[playerid] = 75000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 2:
        {
            PlayerSeleteVehicle[playerid] = 401;
            PLayerVehiclePrice[playerid] = 55000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 3:
        {
            PlayerSeleteVehicle[playerid] = 518;
            PLayerVehiclePrice[playerid] = 40000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 4:
        {
            PlayerSeleteVehicle[playerid] = 527;
            PLayerVehiclePrice[playerid] = 50000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 5:
        {
            PlayerSeleteVehicle[playerid] = 589;
            PLayerVehiclePrice[playerid] = 90000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 6:
        {
            PlayerSeleteVehicle[playerid] = 419;
            PLayerVehiclePrice[playerid] = 70000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 7:
        {
            PlayerSeleteVehicle[playerid] = 587;
            PLayerVehiclePrice[playerid] = 45000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 8:
        {
            PlayerSeleteVehicle[playerid] = 533;
            PLayerVehiclePrice[playerid] = 60000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 9:
        {
            PlayerSeleteVehicle[playerid] = 526;
            PLayerVehiclePrice[playerid] = 80000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 10:
        {
            PlayerSeleteVehicle[playerid] = 474;
            PLayerVehiclePrice[playerid] = 200000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 11:
        {
            PlayerSeleteVehicle[playerid] = 545;
            PLayerVehiclePrice[playerid] = 200000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 12:
        {
            PlayerSeleteVehicle[playerid] = 517;
            PLayerVehiclePrice[playerid] = 90000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 13:
        {
            PlayerSeleteVehicle[playerid] = 410;
            PLayerVehiclePrice[playerid] = 90000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 14:
        {
            PlayerSeleteVehicle[playerid] = 600;
            PLayerVehiclePrice[playerid] = 90000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 15:
        {
            PlayerSeleteVehicle[playerid] = 436;
            PLayerVehiclePrice[playerid] = 90000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 16:
        {
            PlayerSeleteVehicle[playerid] = 439;
            PLayerVehiclePrice[playerid] = 85000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 17:
        {
            PlayerSeleteVehicle[playerid] = 549;
            PLayerVehiclePrice[playerid] = 85000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 18:
        {
            PlayerSeleteVehicle[playerid] = 491;
            PLayerVehiclePrice[playerid] = 50000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
    }
    return 1;
}

Dialog:DIALOG_BUY_SERVICE_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowVehicleBuy(playerid);

    switch(listitem)
    {
        case 0:
        {
            PlayerSeleteVehicle[playerid] = 431;
            PLayerVehiclePrice[playerid] = 120000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 1:
        {
            PlayerSeleteVehicle[playerid] = 437;
            PLayerVehiclePrice[playerid] = 120000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 2:
        {
            PlayerSeleteVehicle[playerid] = 438;
            PLayerVehiclePrice[playerid] = 100000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 3:
        {
            PlayerSeleteVehicle[playerid] = 420;
            PLayerVehiclePrice[playerid] = 100000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 4:
        {
            PlayerSeleteVehicle[playerid] = 525;
            PLayerVehiclePrice[playerid] = 30000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 5:
        {
            PlayerSeleteVehicle[playerid] = 408;
            PLayerVehiclePrice[playerid] = 200000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 6:
        {
            PlayerSeleteVehicle[playerid] = 552;
            PLayerVehiclePrice[playerid] = 400000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
    }
    return 1;
}

Dialog:DIALOG_BUY_LUXURY_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowVehicleBuy(playerid);

    switch(listitem)
    {
        case 0:
        {
            PlayerSeleteVehicle[playerid] = 445;
            PLayerVehiclePrice[playerid] = 80000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 1:
        {
            PlayerSeleteVehicle[playerid] = 507;
            PLayerVehiclePrice[playerid] = 80000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 2:
        {
            PlayerSeleteVehicle[playerid] = 585;
            PLayerVehiclePrice[playerid] = 80000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 3:
        {
            PlayerSeleteVehicle[playerid] = 466;
            PLayerVehiclePrice[playerid] = 60000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 4:
        {
            PlayerSeleteVehicle[playerid] = 492;
            PLayerVehiclePrice[playerid] = 50000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 5:
        {
            PlayerSeleteVehicle[playerid] = 549;
            PLayerVehiclePrice[playerid] = 50000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 6:
        {
            PlayerSeleteVehicle[playerid] = 516;
            PLayerVehiclePrice[playerid] = 75000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 7:
        {
            PlayerSeleteVehicle[playerid] = 587;
            PLayerVehiclePrice[playerid] = 75000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 8:
        {
            PlayerSeleteVehicle[playerid] = 467;
            PLayerVehiclePrice[playerid] = 100000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 9:
        {
            PlayerSeleteVehicle[playerid] = 426;
            PLayerVehiclePrice[playerid] = 50000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 10:
        {
            PlayerSeleteVehicle[playerid] = 547;
            PLayerVehiclePrice[playerid] = 50000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 11:
        {
            PlayerSeleteVehicle[playerid] = 405;
            PLayerVehiclePrice[playerid] = 60000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 12:
        {
            PlayerSeleteVehicle[playerid] = 580;
            PLayerVehiclePrice[playerid] = 60000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 13:
        {
            PlayerSeleteVehicle[playerid] = 409;
            PLayerVehiclePrice[playerid] = 900000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 14:
        {
            PlayerSeleteVehicle[playerid] = 550;
            PLayerVehiclePrice[playerid] = 60000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 15:
        {
            PlayerSeleteVehicle[playerid] = 566;
            PLayerVehiclePrice[playerid] = 60000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 16:
        {
            PlayerSeleteVehicle[playerid] = 540;
            PLayerVehiclePrice[playerid] = 60000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 17:
        {
            PlayerSeleteVehicle[playerid] = 421;
            PLayerVehiclePrice[playerid] = 90000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 18:
        {
            PlayerSeleteVehicle[playerid] = 529;
            PLayerVehiclePrice[playerid] = 80000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
    }
    return 1;
}

Dialog:DIALOG_BUY_TRUCKS_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowVehicleBuy(playerid);

    switch(listitem)
    {
        case 0:
        {
            PlayerSeleteVehicle[playerid] = 459;
            PLayerVehiclePrice[playerid] = 80000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 1:
        {
            PlayerSeleteVehicle[playerid] = 422;
            PLayerVehiclePrice[playerid] = 60000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 2:
        {
            PlayerSeleteVehicle[playerid] = 482;
            PLayerVehiclePrice[playerid] = 80000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 3:
        {
            PlayerSeleteVehicle[playerid] = 418;
            PLayerVehiclePrice[playerid] = 80000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 4:
        {
            PlayerSeleteVehicle[playerid] = 582;
            PLayerVehiclePrice[playerid] = 80000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 5:
        {
            PlayerSeleteVehicle[playerid] = 413;
            PLayerVehiclePrice[playerid] = 70000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 6:
        {
            PlayerSeleteVehicle[playerid] = 440;
            PLayerVehiclePrice[playerid] = 75000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 7:
        {
            PlayerSeleteVehicle[playerid] = 543;
            PLayerVehiclePrice[playerid] = 75000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 8:
        {
            PlayerSeleteVehicle[playerid] = 478;
            PLayerVehiclePrice[playerid] = 25000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 9:
        {
            PlayerSeleteVehicle[playerid] = 554;
            PLayerVehiclePrice[playerid] = 40000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
    }
    return 1;
}

Dialog:DIALOG_BUY_VANS_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowVehicleBuy(playerid);

    switch(listitem)
    {
        case 0:
        {
            PlayerSeleteVehicle[playerid] = 579;
            PLayerVehiclePrice[playerid] = 75000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 1:
        {
            PlayerSeleteVehicle[playerid] = 400;
            PLayerVehiclePrice[playerid] = 90000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 2:
        {
            PlayerSeleteVehicle[playerid] = 404;
            PLayerVehiclePrice[playerid] = 90000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 3:
        {
            PlayerSeleteVehicle[playerid] = 489;
            PLayerVehiclePrice[playerid] = 95000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 4:
        {
            PlayerSeleteVehicle[playerid] = 479;
            PLayerVehiclePrice[playerid] = 100000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 5:
        {
            PlayerSeleteVehicle[playerid] = 442;
            PLayerVehiclePrice[playerid] = 70000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 6:
        {
            PlayerSeleteVehicle[playerid] = 458;
            PLayerVehiclePrice[playerid] = 50000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
    }
    return 1;
}

Dialog:DIALOG_BUY_LOWIDER_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowVehicleBuy(playerid);

    switch(listitem)
    {
        case 0:
        {
            PlayerSeleteVehicle[playerid] = 536;
            PLayerVehiclePrice[playerid] = 100000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 1:
        {
            PlayerSeleteVehicle[playerid] = 575;
            PLayerVehiclePrice[playerid] = 200000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 2:
        {
            PlayerSeleteVehicle[playerid] = 534;
            PLayerVehiclePrice[playerid] = 250000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 3:
        {
            PlayerSeleteVehicle[playerid] = 567;
            PLayerVehiclePrice[playerid] = 100000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 4:
        {
            PlayerSeleteVehicle[playerid] = 535;
            PLayerVehiclePrice[playerid] = 150000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 5:
        {
            PlayerSeleteVehicle[playerid] = 576;
            PLayerVehiclePrice[playerid] = 100000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 6:
        {
            PlayerSeleteVehicle[playerid] = 412;
            PLayerVehiclePrice[playerid] = 150000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
    }
    return 1;
}

Dialog:DIALOG_BUY_MUSCLE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowVehicleBuy(playerid);

    switch(listitem)
    {
        case 0:
        {
            PlayerSeleteVehicle[playerid] = 402;
            PLayerVehiclePrice[playerid] = 200000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 1:
        {
            PlayerSeleteVehicle[playerid] = 542;
            PLayerVehiclePrice[playerid] = 80000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 2:
        {
            PlayerSeleteVehicle[playerid] = 603;
            PLayerVehiclePrice[playerid] = 60000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 3:
        {
            PlayerSeleteVehicle[playerid] = 475;
            PLayerVehiclePrice[playerid] = 78000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
    }
    return 1;
}

Dialog:DIALOG_BUY_HEAVRY(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowVehicleBuy(playerid);

    switch(listitem)
    {
        case 0:
        {
            PlayerSeleteVehicle[playerid] = 499;
            PLayerVehiclePrice[playerid] = 60000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 1:
        {
            PlayerSeleteVehicle[playerid] = 609;
            PLayerVehiclePrice[playerid] = 90000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 2:
        {
            PlayerSeleteVehicle[playerid] = 498;
            PLayerVehiclePrice[playerid] = 80000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 3:
        {
            PlayerSeleteVehicle[playerid] = 578;
            PLayerVehiclePrice[playerid] = 500000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 4:
        {
            PlayerSeleteVehicle[playerid] = 588;
            PLayerVehiclePrice[playerid] = 60000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 5:
        {
            PlayerSeleteVehicle[playerid] = 403;
            PLayerVehiclePrice[playerid] = 400000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 6:
        {
            PlayerSeleteVehicle[playerid] = 414;
            PLayerVehiclePrice[playerid] = 70000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 7:
        {
            PlayerSeleteVehicle[playerid] = 515;
            PLayerVehiclePrice[playerid] = 1200000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 8:
        {
            PlayerSeleteVehicle[playerid] = 514;
            PLayerVehiclePrice[playerid] = 1300000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 9:
        {
            PlayerSeleteVehicle[playerid] = 456;
            PLayerVehiclePrice[playerid] = 80000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
    }
    return 1;
}

Dialog:DIALOG_BUY_VIP(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowVehicleBuy(playerid);

    switch(listitem)
    {
        case 0:
        {
            PlayerSeleteVehicle[playerid] = 429;
            PLayerVehiclePrice[playerid] = 300000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 1:
        {
            PlayerSeleteVehicle[playerid] = 541;
            PLayerVehiclePrice[playerid] = 400000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 2:
        {
            PlayerSeleteVehicle[playerid] = 415;
            PLayerVehiclePrice[playerid] = 400000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 3:
        {
            PlayerSeleteVehicle[playerid] = 480;
            PLayerVehiclePrice[playerid] = 400000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 4:
        {
            PlayerSeleteVehicle[playerid] = 562;
            PLayerVehiclePrice[playerid] = 400000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 5:
        {
            PlayerSeleteVehicle[playerid] = 565;
            PLayerVehiclePrice[playerid] = 400000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 6:
        {
            PlayerSeleteVehicle[playerid] = 559;
            PLayerVehiclePrice[playerid] = 400000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 7:
        {
            PlayerSeleteVehicle[playerid] = 560;
            PLayerVehiclePrice[playerid] = 400000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 8:
        {
            PlayerSeleteVehicle[playerid] = 558;
            PLayerVehiclePrice[playerid] = 400000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
    }
    return 1;
}


Dialog:DIALOG_VEH_COLOR1(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new color1 = strval(inputtext);

    if(color1 > 255)
        return SendErrorMessage(playerid,"โปรดใส่สีให้ถุกต้อง");

    PlayerVehicleColor1[playerid] = color1;

    for(new v = 0; v < 9; v++)
    {
        PlayerTextDrawHide(playerid, VehicleSelect[playerid][v]);
    }
    ShowVehicleSelect(playerid);
    return 1;
}

Dialog:DIALOG_VEH_COLOR2(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new color2 = strval(inputtext);

    if(color2 > 255)
        return SendErrorMessage(playerid,"โปรดใส่สีให้ถุกต้อง");

    PlayerVehicleColor2[playerid] = color2;

    for(new v = 0; v < 9; v++)
    {
        PlayerTextDrawHide(playerid, VehicleSelect[playerid][v]);
    }
    ShowVehicleSelect(playerid);
    return 1;
}


forward OnPlayerVehiclePurchase(playerid, newid, plates[], Float:x, Float:y, Float:z, Float:a);
public OnPlayerVehiclePurchase(playerid, newid, plates[], Float:x, Float:y, Float:z, Float:a)
{
    new modelid = PlayerSeleteVehicle[playerid];
    new color1 = PlayerVehicleColor1[playerid];
    new color2 = PlayerVehicleColor2[playerid];
    new Price = PLayerVehiclePrice[playerid];
    new id = PlayerOwnerDBID[playerid];

    new
		vehicleid = INVALID_VEHICLE_ID
	;

    vehicleid = 
		CreateVehicle(modelid, x, y, z, a, color1, color2, -1);

    SetVehicleNumberPlate(vehicleid, plates); 
	SetVehicleToRespawn(vehicleid); 

    PutPlayerInVehicle(playerid, vehicleid, 0);

    PlayerInfo[playerid][pOwnedVehicles][id] = cache_insert_id();


    if(vehicleid != INVALID_VEHICLE_ID)
	{
		VehicleInfo[vehicleid][eVehicleDBID] = cache_insert_id();
		VehicleInfo[vehicleid][eVehicleOwnerDBID] = PlayerInfo[playerid][pDBID]; 
		
		VehicleInfo[vehicleid][eVehicleModel] = modelid;
		
		VehicleInfo[vehicleid][eVehicleColor1] = color1;
		VehicleInfo[vehicleid][eVehicleColor2] = color2;
		
		VehicleInfo[vehicleid][eVehiclePaintjob] = -1;
		
		VehicleInfo[vehicleid][eVehicleParkPos][0] = x;
		VehicleInfo[vehicleid][eVehicleParkPos][1] = y;
		VehicleInfo[vehicleid][eVehicleParkPos][2] = z;
		VehicleInfo[vehicleid][eVehicleParkPos][3] = a;
		
		format(VehicleInfo[vehicleid][eVehiclePlates], 32, "%s", plates); 
		
		VehicleInfo[vehicleid][eVehicleLocked] = false;
		VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
		
		VehicleInfo[vehicleid][eVehicleFuel] = 50; 
		
		VehicleInfo[vehicleid][eVehicleBattery] = 100.0;
		VehicleInfo[vehicleid][eVehicleEngine] = 100.0; 
		
		VehicleInfo[vehicleid][eVehicleHasXMR] = false;
		VehicleInfo[vehicleid][eVehicleTimesDestroyed] = 0;
		
		VehicleInfo[vehicleid][eVehicleAlarmLevel] = 0;
		VehicleInfo[vehicleid][eVehicleLockLevel] = 0; 
		VehicleInfo[vehicleid][eVehicleImmobLevel] = 0; 

        VehicleInfo[vehicleid][eVehiclePrice] = Price;
		
		for(new i = 1; i< 6; i++)
		{
			VehicleInfo[vehicleid][eVehicleWeapons][i] = 0;
			VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i] = 0; 
		}
		SaveVehicle(vehicleid);

		
		PlayerInfo[playerid][pVehicleSpawned] = true;
		PlayerInfo[playerid][pVehicleSpawnedID] = vehicleid;
	}

    SendClientMessageEx(playerid, 0xB9E35EFF, "PROCESSED: คุณได้ทำการซื้อรถรุ่น %s ด้วยเงิน $%s  เรียบร้อยแล้ว", ReturnVehicleName(vehicleid), MoneyFormat(Price));
    GiveMoney(playerid, -Price);
    GlobalInfo[G_GovCash]+= Price;
    PlayerSeleteVehicle[playerid] = 0;
    PlayerVehicleColor1[playerid] = 0;
    PlayerVehicleColor2[playerid] = 0;
    PLayerVehiclePrice[playerid] = 0;

    SetVehicleHp(vehicleid);

    for(new v = 0; v < 13; v++)
    {
        PlayerTextDrawDestroy(playerid, VehicleBuy[playerid][v]);
    }

    for(new v = 0; v < 9; v++)
    {
        PlayerTextDrawDestroy(playerid, VehicleSelect[playerid][v]);
    }

    CancelSelectTextDraw(playerid);
    return 1;
}

