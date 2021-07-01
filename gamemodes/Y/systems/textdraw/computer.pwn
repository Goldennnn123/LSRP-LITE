#define TEXTDRAW_CUSTOM "mdl-2000:"

#include <YSI_Coding\y_hooks>

new PlayerText:PL_Computer[MAX_PLAYERS][22];

stock LoadTD_Computer(playerid)
{
    PL_Computer[playerid][0] = CreatePlayerTextDraw(playerid, 133.000000, 105.000000, "mdl-2000:1");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][0], 379.500000, 241.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][0], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][0], 0);

	PL_Computer[playerid][1] = CreatePlayerTextDraw(playerid, 140.000000, 115.000000, "mdl-2000:0");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][1], 31.500000, 32.500000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][1], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][1], 1);

	PL_Computer[playerid][2] = CreatePlayerTextDraw(playerid, 323.000000, 327.000000, "_");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][2], 0.600000, 1.849997);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][2], 298.500000, 375.500000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][2], 2);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][2], 135);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][2], 0);

	PL_Computer[playerid][3] = CreatePlayerTextDraw(playerid, 135.000000, 325.000000, "mdl-2000:2");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][3], 17.000000, 20.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][3], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][3], 1);

	PL_Computer[playerid][4] = CreatePlayerTextDraw(playerid, 141.000000, 160.000000, "mdl-2000:3");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][4], 28.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][4], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][4], 1);

	////////////////////////////////////////เมื่อคลิกหน้าต่างโปรแกรม/////////////////////////////////////
	PL_Computer[playerid][5] = CreatePlayerTextDraw(playerid, 318.000000, 121.000000, "_");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][5], 0.600000, 20.849950);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][5], 298.500000, 304.500000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][5], 2);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][5], -1094795521);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][5], 0);

	PL_Computer[playerid][6] = CreatePlayerTextDraw(playerid, 318.000000, 121.000000, "_");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][6], 0.600000, 1.199998);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][6], 298.500000, 304.500000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][6], 2);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][6], -1);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][6], 0);

	PL_Computer[playerid][7] = CreatePlayerTextDraw(playerid, 456.000000, 117.000000, "x");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][7], 2);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][7], 0.608333, 2.000000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][7], 471.000000, 19.500000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][7], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][7], 1);
	////////////////////////////////////////เมื่อคลิกหน้าต่างโปรแกรม/////////////////////////////////////


	////////////////////////////////////////เมื่อคลิกหน้าต่าง This PC/////////////////////////////////////
	PL_Computer[playerid][8] = CreatePlayerTextDraw(playerid, 169.000000, 119.000000, "Computer Spec");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][8], 2);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][8], 0.258333, 1.550000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][8], 264.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][8], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][8], 0);

	PL_Computer[playerid][9] = CreatePlayerTextDraw(playerid, 174.000000, 153.000000, "CPU: I3-I9");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][9], 2);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][9], 0.225000, 1.500000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][9], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][9], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][9], 0);

	PL_Computer[playerid][10] = CreatePlayerTextDraw(playerid, 174.000000, 177.000000, "GPU 1: RTX XXXX");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][10], 2);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][10], 0.225000, 1.500000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][10], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][10], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][10], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][10], 0);

	PL_Computer[playerid][11] = CreatePlayerTextDraw(playerid, 174.000000, 195.000000, "GPU 2: RTX XXXX");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][11], 2);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][11], 0.225000, 1.500000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][11], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][11], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][11], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][11], 0);

	PL_Computer[playerid][12] = CreatePlayerTextDraw(playerid, 174.000000, 212.000000, "GPU 3: RTX XXXX");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][12], 2);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][12], 0.225000, 1.500000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][12], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][12], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][12], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][12], 0);

	PL_Computer[playerid][13] = CreatePlayerTextDraw(playerid, 174.000000, 229.000000, "GPU 4: RTX XXXX");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][13], 2);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][13], 0.225000, 1.500000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][13], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][13], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][13], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][13], 0);

	PL_Computer[playerid][14] = CreatePlayerTextDraw(playerid, 174.000000, 246.000000, "GPU 5: RTX XXXX");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][14], 2);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][14], 0.225000, 1.500000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][14], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][14], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][14], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][14], 0);

	PL_Computer[playerid][15] = CreatePlayerTextDraw(playerid, 174.000000, 266.000000, "RAM: XXX GB");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][15], 2);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][15], 0.225000, 1.500000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][15], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][15], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][15], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][15], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][15], 0);

	PL_Computer[playerid][16] = CreatePlayerTextDraw(playerid, 174.000000, 283.000000, "STORED: XXX GB");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][16], 2);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][16], 0.225000, 1.500000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][16], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][16], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][16], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][16], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][16], 0);

	PL_Computer[playerid][17] = CreatePlayerTextDraw(playerid, 355.000000, 181.000000, "mdl-2000:2");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][17], 4);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][17], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][17], 56.000000, 55.500000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][17], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][17], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][17], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][17], 0);
	////////////////////////////////////////เมื่อคลิกหน้าต่าง This PC/////////////////////////////////////


	////////////////////////////////////////เมื่อคลิกหน้าต่าง BITSAMP/////////////////////////////////////
	PL_Computer[playerid][18] = CreatePlayerTextDraw(playerid, 169.000000, 119.000000, "BITSAMP");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][18], 2);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][18], 0.258332, 1.549999);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][18], 264.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][18], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][18], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][18], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][18], 0);

	PL_Computer[playerid][19] = CreatePlayerTextDraw(playerid, 271.000000, 172.000000, "X.XXXXX");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][19], 1);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][19], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][19], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][19], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][19], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][19], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][19], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][19], 0);

	PL_Computer[playerid][20] = CreatePlayerTextDraw(playerid, 167.000000, 266.000000, "Digging Force: 0.00001");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][20], 1);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][20], 0.312500, 1.750000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][20], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][20], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][20], 1);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][20], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][20], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][20], 50);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][20], 0);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][20], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][20], 0);

	PL_Computer[playerid][21] = CreatePlayerTextDraw(playerid, 316.000000, 203.000000, "STRAT");
	PlayerTextDrawFont(playerid, PL_Computer[playerid][21], 2);
	PlayerTextDrawLetterSize(playerid, PL_Computer[playerid][21], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, PL_Computer[playerid][21], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, PL_Computer[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, PL_Computer[playerid][21], 0);
	PlayerTextDrawAlignment(playerid, PL_Computer[playerid][21], 2);
	PlayerTextDrawColor(playerid, PL_Computer[playerid][21], -1);
	PlayerTextDrawBackgroundColor(playerid, PL_Computer[playerid][21], 255);
	PlayerTextDrawBoxColor(playerid, PL_Computer[playerid][21], 200);
	PlayerTextDrawUseBox(playerid, PL_Computer[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, PL_Computer[playerid][21], 1);
	PlayerTextDrawSetSelectable(playerid, PL_Computer[playerid][21], 1);
	////////////////////////////////////////เมื่อคลิกหน้าต่าง BITSAMP/////////////////////////////////////
    return 1;
}

stock DesTD_Computer(playerid)
{
    for(new t = 0; t < 22; t++)
    {
        PlayerTextDrawDestroy(playerid, PL_Computer[playerid][t]);
    }
	PlayerInfo[playerid][pGUI] = 0;
    CancelSelectTextDraw(playerid);
    return 1;
}

stock ShowTD_Computer(playerid)
{
    for(new t = 0; t < 5; t++)
    {
        PlayerTextDrawShow(playerid, PL_Computer[playerid][t]);
    }
    SelectTextDraw(playerid, 0xFFFFFF95);
    return 1;
}

stock LoadBox(playerid)
{

	for(new t = 5; t <= 7; t++)
    {
        PlayerTextDrawShow(playerid, PL_Computer[playerid][t]);
    }
	return 1;
}

stock ShowTD_Computer_ThisPc(playerid)
{
	new id = IsPlayerNearComputer(playerid), str[32];

	for(new t = 8; t <= 17; t++)
    {
        PlayerTextDrawShow(playerid, PL_Computer[playerid][t]);
    }
	
	format(str, sizeof(str), "CPU: %s", ReturnCPUNames(ComputerInfo[id][ComputerCPU]));
	PlayerTextDrawSetString(playerid,PL_Computer[playerid][9], str);

	format(str, sizeof(str), "GPU 1: %s", ReturnGPUNames(ComputerInfo[id][ComputerGPU][0]));
	PlayerTextDrawSetString(playerid,PL_Computer[playerid][10], str);

	format(str, sizeof(str), "GPU 2: %s", ReturnGPUNames(ComputerInfo[id][ComputerGPU][1]));
	PlayerTextDrawSetString(playerid,PL_Computer[playerid][11], str);

	format(str, sizeof(str), "GPU 3: %s", ReturnGPUNames(ComputerInfo[id][ComputerGPU][2]));
	PlayerTextDrawSetString(playerid,PL_Computer[playerid][12], str);

	format(str, sizeof(str), "GPU 4: %s", ReturnGPUNames(ComputerInfo[id][ComputerGPU][3]));
	PlayerTextDrawSetString(playerid,PL_Computer[playerid][13], str);

	format(str, sizeof(str), "GPU 5: %s", ReturnGPUNames(ComputerInfo[id][ComputerGPU][4]));
	PlayerTextDrawSetString(playerid,PL_Computer[playerid][14], str);

	format(str, sizeof(str), "RAM: %s", ReturnRams(ComputerInfo[id][ComputerRAM]));
	PlayerTextDrawSetString(playerid,PL_Computer[playerid][15], str);

	format(str, sizeof(str), "STORED: %s", ReturnStoreds(ComputerInfo[id][ComputerStored]));
	PlayerTextDrawSetString(playerid,PL_Computer[playerid][16], str);
	return 1;
}

stock ShowTD_Computer_BTC(playerid)
{
	new id = IsPlayerNearComputer(playerid);

	if(id == 0)
	{
		DesTD_Computer(playerid);
		CancelSelectTextDraw(playerid);
		SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้คอมพิวเตอร์ของคุณ");
		return 1;
	}

	for(new t = 18; t <= 21; t++)
	{
		PlayerTextDrawShow(playerid, PL_Computer[playerid][t]);
	}

	new str[62];

	if(!ComputerInfo[id][ComputerStartBTC])
	{
		format(str, sizeof(str), "~g~START");
	}
	else
	{
		format(str, sizeof(str), "~r~STOP");
	}
	PlayerTextDrawSetString(playerid,PL_Computer[playerid][21], str);

	format(str, sizeof(str), "%.5f", ComputerInfo[id][ComputerBTC]);
	PlayerTextDrawSetString(playerid,PL_Computer[playerid][19], str);

	format(str, sizeof(str), "Digging Force: %s",CalculaterBTC(id));
	PlayerTextDrawSetString(playerid,PL_Computer[playerid][20], str);
	return 1;
}
hook OnPlayerDisconnect@036(playerid, reason)
{
    DesTD_Computer(playerid);
    return 1;
}

hook OP_ClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(PlayerInfo[playerid][pGUI] == 3)
	{
		if(playertextid == PL_Computer[playerid][3])
		{
			Dialog_Show(playerid, D_COMPUTER_CLOSE, DIALOG_STYLE_MSGBOX, "คุณจะปิดคอม?", "คุณเลือกที่จะปิดคอมหรือจะไม่ปิด", "ปิด", "ไม่ปิด");
			return 1;
		}
		if(playertextid == PL_Computer[playerid][1])
		{
			LoadBox(playerid);
			ShowTD_Computer_ThisPc(playerid);
			PlayerTextDrawHide(playerid, PL_Computer[playerid][1]);
			PlayerTextDrawHide(playerid, PL_Computer[playerid][4]);
			return 1;
		}
		if(playertextid == PL_Computer[playerid][7])
		{
			for(new t = 5; t <= 21; t++)
			{
				PlayerTextDrawHide(playerid, PL_Computer[playerid][t]);
			}

			PlayerTextDrawShow(playerid, PL_Computer[playerid][1]);
			PlayerTextDrawShow(playerid, PL_Computer[playerid][4]);
			return 1;
		}
		if(playertextid == PL_Computer[playerid][4])
		{
			LoadBox(playerid);
			ShowTD_Computer_BTC(playerid);
			PlayerTextDrawHide(playerid, PL_Computer[playerid][1]);
			PlayerTextDrawHide(playerid, PL_Computer[playerid][4]);
			return 1;
		}
		if(playertextid == PL_Computer[playerid][21])
		{
			new id = IsPlayerNearComputer(playerid);

			if(id == 0)
			{
				DesTD_Computer(playerid);
				CancelSelectTextDraw(playerid);
				SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้คอมพิวเตอร์");
			}

			if(!ComputerInfo[id][ComputerStartBTC])
			{
				ComputerInfo[id][ComputerStartBTC] = true;
				SendClientMessageEx(playerid, COLOR_YELLOWEX, "คุณได้เริ่มขุด เหรียญ BTC..... ด้วยแรงขุด %s", CalculaterBTC(id));
				ComputerInfo[id][ComputerTimer] = SetTimerEx("StartComputerBTC", 1800000, true, "dd", playerid, id);
				PlayerTextDrawSetString(playerid,PL_Computer[playerid][21], "~r~STOP");
				return 1;
			}
			else
			{
				new str[150];
				ComputerInfo[id][ComputerStartBTC] = false;
				SendClientMessage(playerid, COLOR_DARKGREEN, "คุณได้หยุดขุด เหรียญ BTC.....");

				KillTimer(ComputerInfo[id][ComputerTimer]);
				PlayerTextDrawSetString(playerid,PL_Computer[playerid][21], "~g~START");
				
				PlayerInfo[playerid][pBTC] += ComputerInfo[id][ComputerBTC];
				SendClientMessageEx(playerid, COLOR_DARKGOLDENROD, "BITSAMP: จำนวน %.5f เข้าไปที่บัญชี BITSAMP ของคุณ",ComputerInfo[id][ComputerBTC]);
				
				ComputerInfo[id][ComputerBTC] = 0.0;
				format(str, sizeof(str), "%.5f", ComputerInfo[id][ComputerBTC]);
				PlayerTextDrawSetString(playerid,PL_Computer[playerid][19], str);

				SaveComputer(id);
				CharacterSave(playerid);
				return 1;
			}
		}
	}
    return 1;
}

Dialog:D_COMPUTER_CLOSE(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        DesTD_Computer(playerid);
        CancelSelectTextDraw(playerid);
        SendClientMessage(playerid, -1, "คุณยังไม่ได้ปิดคอม");
        return 1;
    }
    
    new id = IsPlayerNearComputer(playerid);

    if(!id)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้คอมพิวเตอร์ หรือ แล็ปท็อปของคุณ");


	if(ComputerInfo[id][ComputerStartBTC])
	{
		ComputerInfo[id][ComputerStartBTC] = false;
		SendClientMessage(playerid, COLOR_LIGHTRED, "คุณได้ปิดคอม การขุด BTC ของคุณหยุดทำการขุดแล้วตอนนี้...");
		KillTimer(ComputerInfo[id][ComputerTimer]);
	}
	
    ComputerInfo[id][ComputerOn] = false;
    DesTD_Computer(playerid);
    CancelSelectTextDraw(playerid);
    SendClientMessage(playerid, -1, "คุณได้ปิดคอมของคุณแล้ว");
    return 1;
}

forward StartComputerBTC(playerid, id);
public StartComputerBTC(playerid, id)
{
	new all_cpu_gpu, Float:result;

	if(!ComputerInfo[id][ComputerGPU][0] && !ComputerInfo[id][ComputerGPU][1] && !ComputerInfo[id][ComputerGPU][2] && !ComputerInfo[id][ComputerGPU][3] && !ComputerInfo[id][ComputerGPU][4] && !ComputerInfo[id][ComputerRAM])
	{
		return 1;
	}
	
	all_cpu_gpu = ComputerInfo[id][ComputerGPU][0] + ComputerInfo[id][ComputerGPU][1] + ComputerInfo[id][ComputerGPU][2] + ComputerInfo[id][ComputerGPU][3] + ComputerInfo[id][ComputerGPU][4] + ComputerInfo[id][ComputerCPU];
	result = (all_cpu_gpu * 0.00001);

	
	ComputerInfo[id][ComputerBTC] += result;
	SaveComputer(id);
	CharacterSave(playerid);
	return 1;
}

stock CalculaterBTC(id)
{
	new str_send[155], all_cpu_gpu, Float:result;

	if(!ComputerInfo[id][ComputerGPU][0] && !ComputerInfo[id][ComputerGPU][1] && !ComputerInfo[id][ComputerGPU][2] && !ComputerInfo[id][ComputerGPU][3] && !ComputerInfo[id][ComputerGPU][4])
	{
		format(str_send, sizeof(str_send), "COMPUTER NOT GPU");
		return str_send;
	}
	
	all_cpu_gpu = ComputerInfo[id][ComputerGPU][0] + ComputerInfo[id][ComputerGPU][1] + ComputerInfo[id][ComputerGPU][2] + ComputerInfo[id][ComputerGPU][3] + ComputerInfo[id][ComputerGPU][4] + ComputerInfo[id][ComputerCPU];
	result = (all_cpu_gpu * 0.00001);
	format(str_send, sizeof(str_send), "%.5f", result);

	return str_send;
}