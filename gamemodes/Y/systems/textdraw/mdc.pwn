#include <YSI_Coding\y_hooks>


new PlayerText:PlayerMdcTD_Home[MAX_PLAYERS][22];


hook OnGameModeInit()
{
    
    return 1;
}



CMD:mdc(playerid, params[])
{
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ"); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");


    ShowPlayerMDC_Home(playerid, true);
    PlayerInfo[playerid][pGUI] = 911;
    return 1;
}

stock ShowPlayerMDC_Home(playerid, loadtd = false)
{
    if(loadtd)
    {
        PlayerMdcTD_Home[playerid][0] = CreatePlayerTextDraw(playerid, 304.000000, 53.000000, "_");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][0], 1);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][0], 0.600000, 37.850040);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][0], 298.500000, 438.000000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][0], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][0], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][0], 2);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][0], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][0], 255);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][0], -1061109505);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][0], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][0], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][0], 0);

        PlayerMdcTD_Home[playerid][1] = CreatePlayerTextDraw(playerid, 304.000000, 53.000000, "_");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][1], 1);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][1], 0.600000, 1.350062);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][1], 298.500000, 438.000000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][1], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][1], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][1], 2);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][1], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][1], 255);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][1], 35839);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][1], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][1], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][1], 0);

        PlayerMdcTD_Home[playerid][2] = CreatePlayerTextDraw(playerid, 88.000000, 52.000000, "HUD:radar_ammugun");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][2], 4);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][2], 0.600000, 2.000000);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][2], 12.500000, 12.000000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][2], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][2], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][2], 1);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][2], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][2], 255);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][2], 50);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][2], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][2], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][2], 0);

        PlayerMdcTD_Home[playerid][3] = CreatePlayerTextDraw(playerid, 104.000000, 51.000000, "Police");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][3], 2);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][3], 0.270832, 1.399999);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][3], 146.500000, 17.000000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][3], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][3], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][3], 1);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][3], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][3], 0);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][3], 50);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][3], 0);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][3], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][3], 0);

        PlayerMdcTD_Home[playerid][4] = CreatePlayerTextDraw(playerid, 495.000000, 53.000000, "-");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][4], 2);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][4], 1.095832, 1.250000);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][4], 506.500000, 17.000000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][4], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][4], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][4], 1);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][4], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][4], 255);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][4], -1378294017);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][4], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][4], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][4], 1);

        PlayerMdcTD_Home[playerid][5] = CreatePlayerTextDraw(playerid, 510.000000, 53.000000, "X");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][5], 2);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][5], 0.504164, 1.250000);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][5], 523.000000, 17.000000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][5], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][5], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][5], 1);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][5], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][5], 255);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][5], -1962934017);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][5], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][5], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][5], 1);

        //ชื่อตรง tab bar
        PlayerMdcTD_Home[playerid][6] = CreatePlayerTextDraw(playerid, 388.000000, 53.000000, "Fristname Lastname");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][6], 1);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][6], 0.224999, 1.200000);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][6], 490.500000, 17.000000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][6], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][6], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][6], 1);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][6], -741092353);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][6], 0);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][6], 50);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][6], 0);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][6], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][6], 0);

        PlayerMdcTD_Home[playerid][7] = CreatePlayerTextDraw(playerid, 168.000000, 76.000000, "_");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][7], 1);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][7], 0.600000, 34.450092);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][7], 289.500000, -2.000000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][7], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][7], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][7], 2);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][7], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][7], 255);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][7], 1296911727);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][7], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][7], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][7], 0);

        PlayerMdcTD_Home[playerid][8] = CreatePlayerTextDraw(playerid, 125.000000, 77.000000, "MAIN SCREEN");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][8], 2);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][8], 0.233333, 1.350000);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][8], 15.500000, 73.500000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][8], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][8], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][8], 2);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][8], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][8], 40);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][8], 200);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][8], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][8], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][8], 1);

        PlayerMdcTD_Home[playerid][9] = CreatePlayerTextDraw(playerid, 125.000000, 96.000000, "LOOK UP");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][9], 2);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][9], 0.233333, 1.350000);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][9], 15.500000, 73.500000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][9], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][9], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][9], 2);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][9], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][9], 0);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][9], 114);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][9], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][9], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][9], 1);

        PlayerMdcTD_Home[playerid][10] = CreatePlayerTextDraw(playerid, 125.000000, 115.000000, "WARRNTS");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][10], 2);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][10], 0.233333, 1.350000);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][10], 15.500000, 73.500000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][10], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][10], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][10], 2);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][10], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][10], 0);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][10], 114);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][10], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][10], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][10], 1);

        PlayerMdcTD_Home[playerid][11] = CreatePlayerTextDraw(playerid, 125.000000, 134.000000, "CALLS");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][11], 2);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][11], 0.233333, 1.350000);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][11], 15.500000, 73.500000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][11], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][11], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][11], 2);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][11], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][11], 0);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][11], 114);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][11], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][11], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][11], 1);

        PlayerMdcTD_Home[playerid][12] = CreatePlayerTextDraw(playerid, 125.000000, 175.000000, "ROSTER");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][12], 2);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][12], 0.233333, 1.350000);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][12], 15.500000, 73.500000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][12], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][12], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][12], 2);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][12], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][12], 0);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][12], 114);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][12], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][12], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][12], 1);

        PlayerMdcTD_Home[playerid][13] = CreatePlayerTextDraw(playerid, 125.000000, 194.000000, "RECORDS DB");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][13], 2);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][13], 0.233333, 1.350000);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][13], 15.500000, 73.500000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][13], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][13], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][13], 2);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][13], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][13], 0);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][13], 114);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][13], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][13], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][13], 1);

        PlayerMdcTD_Home[playerid][14] = CreatePlayerTextDraw(playerid, 125.000000, 214.000000, "CCTV");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][14], 2);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][14], 0.233333, 1.350000);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][14], 15.500000, 73.500000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][14], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][14], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][14], 2);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][14], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][14], 0);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][14], 114);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][14], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][14], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][14], 1);

        PlayerMdcTD_Home[playerid][15] = CreatePlayerTextDraw(playerid, 199.000000, 76.000000, "Preview_Model");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][15], 5);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][15], 0.600000, 2.000000);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][15], 266.000000, 306.500000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][15], 0);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][15], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][15], 1);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][15], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][15], 0);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][15], 0);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][15], 0);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][15], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][15], 0);
        PlayerTextDrawSetPreviewModel(playerid, PlayerMdcTD_Home[playerid][15], 280);
        PlayerTextDrawSetPreviewRot(playerid, PlayerMdcTD_Home[playerid][15], -10.000000, 0.000000, -2.000000, 0.860000);
        PlayerTextDrawSetPreviewVehCol(playerid, PlayerMdcTD_Home[playerid][15], 1, 1);

        PlayerMdcTD_Home[playerid][16] = CreatePlayerTextDraw(playerid, 324.000000, 166.000000, "_");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][16], 1);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][16], 0.600000, 24.850040);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][16], 298.500000, 151.500000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][16], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][16], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][16], 2);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][16], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][16], 255);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][16], -1061109505);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][16], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][16], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][16], 0);

        PlayerMdcTD_Home[playerid][17] = CreatePlayerTextDraw(playerid, 343.000000, 169.000000, "_");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][17], 1);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][17], 0.600000, 1.549998);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][17], 298.500000, 327.500000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][17], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][17], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][17], 2);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][17], -1);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][17], 255);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][17], 115);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][17], 1);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][17], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][17], 0);

        //ชื่อพร้อมยศในหน้าจอ Display
        PlayerMdcTD_Home[playerid][18] = CreatePlayerTextDraw(playerid, 269.000000, 168.000000, "Chief Of Police Fristname Lastname");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][18], 1);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][18], 0.216666, 1.549999);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][18], 490.500000, 17.000000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][18], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][18], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][18], 1);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][18], 255);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][18], 0);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][18], 50);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][18], 0);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][18], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][18], 0);

        PlayerMdcTD_Home[playerid][19] = CreatePlayerTextDraw(playerid, 180.000000, 198.000000, "MEMBER ON DUTY");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][19], 2);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][19], 0.216666, 1.549999);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][19], 490.500000, 17.000000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][19], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][19], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][19], 1);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][19], 255);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][19], 0);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][19], 50);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][19], 0);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][19], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][19], 0);

        PlayerMdcTD_Home[playerid][20] = CreatePlayerTextDraw(playerid, 180.000000, 212.000000, "ACTIVE WARRANTS\t\t\t\t 0");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][20], 2);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][20], 0.216666, 1.549999);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][20], 490.500000, 17.000000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][20], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][20], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][20], 1);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][20], 255);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][20], 0);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][20], 50);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][20], 0);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][20], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][20], 0);

        PlayerMdcTD_Home[playerid][21] = CreatePlayerTextDraw(playerid, 180.000000, 227.000000, "ACTIVE BOLO'S\t\t\t\t 0");
        PlayerTextDrawFont(playerid, PlayerMdcTD_Home[playerid][21], 2);
        PlayerTextDrawLetterSize(playerid, PlayerMdcTD_Home[playerid][21], 0.216666, 1.549999);
        PlayerTextDrawTextSize(playerid, PlayerMdcTD_Home[playerid][21], 490.500000, 17.000000);
        PlayerTextDrawSetOutline(playerid, PlayerMdcTD_Home[playerid][21], 1);
        PlayerTextDrawSetShadow(playerid, PlayerMdcTD_Home[playerid][21], 0);
        PlayerTextDrawAlignment(playerid, PlayerMdcTD_Home[playerid][21], 1);
        PlayerTextDrawColor(playerid, PlayerMdcTD_Home[playerid][21], 255);
        PlayerTextDrawBackgroundColor(playerid, PlayerMdcTD_Home[playerid][21], 0);
        PlayerTextDrawBoxColor(playerid, PlayerMdcTD_Home[playerid][21], 50);
        PlayerTextDrawUseBox(playerid, PlayerMdcTD_Home[playerid][21], 0);
        PlayerTextDrawSetProportional(playerid, PlayerMdcTD_Home[playerid][21], 1);
        PlayerTextDrawSetSelectable(playerid, PlayerMdcTD_Home[playerid][21], 0);
    }

    new str[62];
    for(new i = 0; i < 22; i++)
    {
        PlayerTextDrawShow(playerid, PlayerMdcTD_Home[playerid][i]);
    }

    format(str, sizeof(str), "%s",ReturnRealName(playerid));
    PlayerTextDrawSetString(playerid, PlayerMdcTD_Home[playerid][6], str);


    format(str, sizeof(str), "%s %s",ReturnFactionRank(playerid), ReturnRealName(playerid));
    PlayerTextDrawSetString(playerid, PlayerMdcTD_Home[playerid][18], str);


    new onduty;
    foreach(new i : Player)
	{
		new factiontype = FactionInfo[PlayerInfo[i][pFaction]][eFactionJob];
		
		if(factiontype == POLICE || factiontype == SHERIFF)
			onduty++;
	}

    format(str, sizeof(str), "MEMBER ON DUTY\t\t\t\t %d",onduty);
    PlayerTextDrawSetString(playerid, PlayerMdcTD_Home[playerid][19], str);

    SelectTextDraw(playerid, COLOR_GREY);
    return 1;
}


stock ClosePlayerMDC_Home(playerid)
{
    for(new i = 0; i < 22; i++)
    {
        PlayerTextDrawDestroy(playerid, PlayerMdcTD_Home[playerid][i]);
    }
    PlayerInfo[playerid][pGUI] = 0;
    return 1;
}




hook OP_ClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(PlayerInfo[playerid][pGUI] == 911)
    {
        if(playertextid == PlayerMdcTD_Home[playerid][5])
        {
            ClosePlayerMDC_Home(playerid);
            CancelSelectTextDraw(playerid);
            return 1;
        }
        else if(playertextid == PlayerMdcTD_Home[playerid][9])
        {
            ClosePlayerMDC_Home(playerid);
            
            return 1;
        }
        return 1;
    }
    return 1;
}


hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(PlayerInfo[playerid][pGUI] == 911)
    {
        if(clickedid == Text:INVALID_TEXT_DRAW)
        {
            ClosePlayerMDC_Home(playerid);
            CancelSelectTextDraw(playerid);
			return 1;
        }
        return 1;
    }
    return 1;
}