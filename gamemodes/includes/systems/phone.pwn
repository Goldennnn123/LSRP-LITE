#include <YSI_Coding\y_hooks>

new PlayerText:PlayerPhone[MAX_PLAYERS][23];
new PlayerSelectPhoneBook[MAX_PLAYERS];
new PhoneAddName[MAX_PLAYERS][60], PhoneAddNumber[MAX_PLAYERS];

stock ShowPhone(playerid)
{
    PlayerPhone[playerid][0] = CreatePlayerTextDraw(playerid, 516.000000, 216.000000, "_");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][0], 1);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][0], 0.600000, 24.949962);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][0], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][0], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][0], 255);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][0], 0);

    PlayerPhone[playerid][1] = CreatePlayerTextDraw(playerid, 516.000000, 226.000000, "_");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][1], 0.600000, 10.300003);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][1], 298.500000, 99.000000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][1], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][1], -1094795521);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][1], 0);

    PlayerPhone[playerid][2] = CreatePlayerTextDraw(playerid, 480.000000, 355.000000, "1");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][2], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][2], 0.237498, 1.250000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][2], 10.500000, 26.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][2], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][2], 1296911871);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][2], 1);

    PlayerPhone[playerid][3] = CreatePlayerTextDraw(playerid, 516.000000, 355.000000, "2");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][3], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][3], 0.237498, 1.250000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][3], 10.500000, 26.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][3], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][3], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][3], 1296911871);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][3], 1);

    PlayerPhone[playerid][4] = CreatePlayerTextDraw(playerid, 552.000000, 355.000000, "3");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][4], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][4], 0.237498, 1.250000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][4], 10.500000, 26.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][4], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][4], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][4], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][4], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][4], 1296911871);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][4], 1);

    PlayerPhone[playerid][5] = CreatePlayerTextDraw(playerid, 480.000000, 376.000000, "4");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][5], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][5], 0.237498, 1.250000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][5], 10.500000, 26.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][5], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][5], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][5], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][5], 1296911871);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][5], 1);

    PlayerPhone[playerid][6] = CreatePlayerTextDraw(playerid, 516.000000, 376.000000, "5");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][6], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][6], 0.237498, 1.250000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][6], 10.500000, 26.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][6], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][6], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][6], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][6], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][6], 1296911871);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][6], 1);

    PlayerPhone[playerid][7] = CreatePlayerTextDraw(playerid, 552.000000, 376.000000, "6");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][7], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][7], 0.237498, 1.250000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][7], 10.500000, 26.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][7], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][7], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][7], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][7], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][7], 1296911871);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][7], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][7], 1);

    PlayerPhone[playerid][8] = CreatePlayerTextDraw(playerid, 480.000000, 397.000000, "7");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][8], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][8], 0.237498, 1.250000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][8], 10.500000, 26.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][8], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][8], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][8], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][8], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][8], 1296911871);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][8], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][8], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][8], 1);

    PlayerPhone[playerid][9] = CreatePlayerTextDraw(playerid, 516.000000, 397.000000, "8");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][9], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][9], 0.237498, 1.250000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][9], 10.500000, 26.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][9], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][9], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][9], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][9], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][9], 1296911871);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][9], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][9], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][9], 1);

    PlayerPhone[playerid][10] = CreatePlayerTextDraw(playerid, 552.000000, 397.000000, "9");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][10], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][10], 0.237498, 1.250000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][10], 10.500000, 26.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][10], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][10], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][10], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][10], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][10], 1296911871);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][10], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][10], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][10], 1);

    PlayerPhone[playerid][11] = CreatePlayerTextDraw(playerid, 516.000000, 420.000000, "0");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][11], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][11], 0.237498, 1.250000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][11], 10.500000, 26.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][11], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][11], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][11], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][11], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][11], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][11], 1296911871);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][11], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][11], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][11], 1);

    PlayerPhone[playerid][12] = CreatePlayerTextDraw(playerid, 480.000000, 331.000000, "MENU");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][12], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][12], 0.258332, 1.250000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][12], 16.500000, 26.000000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][12], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][12], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][12], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][12], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][12], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][12], 1296911871);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][12], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][12], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][12], 1);

    PlayerPhone[playerid][13] = CreatePlayerTextDraw(playerid, 552.000000, 331.000000, "BACK");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][13], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][13], 0.258332, 1.250000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][13], 16.500000, 26.000000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][13], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][13], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][13], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][13], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][13], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][13], 1296911871);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][13], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][13], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][13], 1);

    PlayerPhone[playerid][14] = CreatePlayerTextDraw(playerid, 480.000000, 420.000000, "Y");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][14], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][14], 0.258332, 1.250000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][14], 16.500000, 26.000000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][14], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][14], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][14], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][14], 1433087999);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][14], 1433087999);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][14], 1433087999);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][14], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][14], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][14], 1);

    PlayerPhone[playerid][15] = CreatePlayerTextDraw(playerid, 552.000000, 420.000000, "N");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][15], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][15], 0.258332, 1.250000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][15], 16.500000, 26.000000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][15], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][15], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][15], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][15], -1962934017);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][15], -1962934017);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][15], -1962934017);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][15], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][15], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][15], 1);

    PlayerPhone[playerid][16] = CreatePlayerTextDraw(playerid, 546.000000, 224.000000, "100%");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][16], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][16], 0.187500, 1.450000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][16], 565.000000, -0.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][16], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][16], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][16], 1);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][16], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][16], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][16], 50);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][16], 0);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][16], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][16], 0);

    PlayerPhone[playerid][17] = CreatePlayerTextDraw(playerid, 487.000000, 249.000000, "14:26");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][17], 1);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][17], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][17], 544.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][17], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][17], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][17], 1);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][17], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][17], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][17], 50);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][17], 0);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][17], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][17], 0);

    PlayerPhone[playerid][18] = CreatePlayerTextDraw(playerid, 496.000000, 268.000000, ReturnPhoneDate());
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][18], 1);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][18], 0.216664, 1.649999);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][18], 548.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][18], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][18], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][18], 1);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][18], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][18], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][18], 50);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][18], 0);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][18], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][18], 0);

    PlayerPhone[playerid][19] = CreatePlayerTextDraw(playerid, 516.000000, 243.000000, "PhoneBook");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][19], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][19], 0.204166, 1.500000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][19], 16.500000, 98.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][19], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][19], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][19], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][19], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][19], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][19], 200);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][19], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][19], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][19], 1);

    PlayerPhone[playerid][20] = CreatePlayerTextDraw(playerid, 516.000000, 263.000000, "SMS");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][20], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][20], 0.204166, 1.500000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][20], 16.500000, 98.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][20], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][20], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][20], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][20], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][20], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][20], 200);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][20], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][20], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][20], 1);

    PlayerPhone[playerid][21] = CreatePlayerTextDraw(playerid, 516.000000, 283.000000, "Calls");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][21], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][21], 0.204166, 1.500000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][21], 16.500000, 98.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][21], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][21], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][21], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][21], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][21], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][21], 200);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][21], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][21], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][21], 1);

    PlayerPhone[playerid][22] = CreatePlayerTextDraw(playerid, 516.000000, 303.000000, "SEETINGS");
    PlayerTextDrawFont(playerid, PlayerPhone[playerid][22], 2);
    PlayerTextDrawLetterSize(playerid, PlayerPhone[playerid][22], 0.204166, 1.500000);
    PlayerTextDrawTextSize(playerid, PlayerPhone[playerid][22], 16.500000, 98.500000);
    PlayerTextDrawSetOutline(playerid, PlayerPhone[playerid][22], 1);
    PlayerTextDrawSetShadow(playerid, PlayerPhone[playerid][22], 0);
    PlayerTextDrawAlignment(playerid, PlayerPhone[playerid][22], 2);
    PlayerTextDrawColor(playerid, PlayerPhone[playerid][22], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerPhone[playerid][22], 255);
    PlayerTextDrawBoxColor(playerid, PlayerPhone[playerid][22], 200);
    PlayerTextDrawUseBox(playerid, PlayerPhone[playerid][22], 1);
    PlayerTextDrawSetProportional(playerid, PlayerPhone[playerid][22], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerPhone[playerid][22], 1);
    return 1;
}

CMD:phone(playerid, params[])
{
    if(PlayerInfo[playerid][pGUI] == false)
    {
        ShowPhone(playerid);
        for(new p = 0; p < 19; p++)
        {
            PlayerTextDrawShow(playerid, PlayerPhone[playerid][p]);
        }

        new hour, seconds, minute;
        gettime(hour, seconds, minute);

        new str_time[60], str[60];

        format(str_time, sizeof(str_time), "%d:%02d",hour,minute);
        PlayerTextDrawSetString(playerid, PlayerPhone[playerid][17], str_time);

        format(str, sizeof(str), "%d%",PlayerInfo[playerid][pPhonePower]);
        PlayerTextDrawSetString(playerid, PlayerPhone[playerid][16], str);

        SelectTextDraw(playerid, COLOR_GRAD1);
        PlayerInfo[playerid][pGUI] = true;
    }
    else
    {
        for(new p = 0; p < 23; p++)
        {
            PlayerTextDrawDestroy(playerid, PlayerPhone[playerid][p]);
        }
        CancelSelectTextDraw(playerid);
        PlayerInfo[playerid][pGUI] = false;

    }
    return 1;
}

stock ReturnPhoneDate()
{
    new MonthStr[40],str[266];
    new year,month,day;

    getdate(year, month, day);

    switch(month)
	{
	    case 1:  MonthStr = "January";
	    case 2:  MonthStr = "February";
	    case 3:  MonthStr = "March";
	    case 4:  MonthStr = "April";
	    case 5:  MonthStr = "May";
	    case 6:  MonthStr = "June";
	    case 7:  MonthStr = "July";
	    case 8:  MonthStr = "August";
	    case 9:  MonthStr = "September";
	    case 10: MonthStr = "October";
	    case 11: MonthStr = "November";
	    case 12: MonthStr = "December";
	}
    format(str, 90, "%s %d", MonthStr,day);
    return str;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == PlayerPhone[playerid][12])
    {
        for(new p = 16; p <= 18; p++)
        {
            PlayerTextDrawHide(playerid, PlayerPhone[playerid][p]);
        }

        for(new p = 19; p <= 22; p++)
        {
            PlayerTextDrawShow(playerid, PlayerPhone[playerid][p]);
        }
        PlayerTextDrawShow(playerid, PlayerPhone[playerid][16]);

        return 1;
    }
    if(playertextid == PlayerPhone[playerid][19])
    {
        Dialog_Show(playerid,DIALOG_PHONEBOOK_LIST,DIALOG_STYLE_LIST,"PhoneBook","เพื่มรายชื่อติดต่อ\nดูรายชื่อติดต่อ","ยืนยัน","ยกเลิก");
        return 1;
    }
    return 1;
}

stock ShowPhoneBook(playerid)
{
    new str[MAX_STRING], str_long[MAX_STRING],str_p[MAX_STRING],Phoneid;

    for(new l = 0; l < MAX_PHONEBOOK; l++)
    {
        if(!PhoneInfo[l][PhoneDBID])
            continue;
            
        if(PhoneInfo[l][PhoneOwnerDBID] != PlayerInfo[playerid][pDBID])
            continue;

        format(str, sizeof(str), "%s: %d\n",PhoneInfo[l][PhoneName], PhoneInfo[l][PhoneNumber]);
        strcat(str_long, str);

        format(str_p, sizeof(str_p), "%d",Phoneid);
        SetPVarInt(playerid, str_p, l);

        Phoneid++;
    }
    Dialog_Show(playerid, DIALOG_PHONEBOOK, DIALOG_STYLE_LIST, "Phone Book", str_long, "ยืนยัน", "ยกเลิก");
    return 1;
}

Dialog:DIALOG_PHONEBOOK_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    switch(listitem)
    {
        case 0: return Dialog_Show(playerid, DIALOG_ADD_PHONEBOOK, DIALOG_STYLE_INPUT, "เพื่มรายชื่อผู้ติดต่อ", "เพื่มรายชื่อผู้ติดต่อใหม่ของคุณ", "ยืนยัน", "ยกเลิก");
        case 1: return ShowPhoneBook(playerid);
    }
    return 1;
}

Dialog:DIALOG_ADD_PHONEBOOK(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    if(strlen(inputtext) < 1 || strlen(inputtext) > 60)
        return Dialog_Show(playerid, DIALOG_ADD_PHONEBOOK, DIALOG_STYLE_INPUT, "เพื่มรายชื่อผู้ติดต่อ", "กรุณาใส่ชื่อผู้ติดต่อให้ถูกต้อง {D32F2F}ห้ามเกิน 60 ตัวอักษร", "ยืนยัน", "ยกเลิก");
    
    new str[60];

    format(str, sizeof(str), inputtext);

    PhoneAddName[playerid] = str;
    Dialog_Show(playerid, DIALOG_ADD_NUMBER, DIALOG_STYLE_INPUT, "ใส่หมายเลขโทรศัพท์", "กรุณาใส่เบอร์โทรศัพท์ของรายชื่อที่คุณต้องการบันทึก", "ยืนยัน", "ยกเลิก");
    return 1;
}

Dialog:DIALOG_ADD_NUMBER(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    if(strlen(inputtext) < 1 || strlen(inputtext) > 5)
        return Dialog_Show(playerid, DIALOG_ADD_NUMBER, DIALOG_STYLE_INPUT, "ใส่หมายเลขโทรศัพท์", "กรุณาใส่หมายเลขโทรศัพท์ให้ถูกต้องด้วย {D32F2F}ห้ามเกิน 5 ตัวอักษร", "ยืนยัน", "ยกเลิก");

    new Number = strval(inputtext);
    PhoneAddNumber[playerid] = Number;
    AddPhoneBook(playerid);
    return 1;
}

Dialog:DIALOG_PHONEBOOK(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    new str_p[MAX_STRING], str[MAX_STRING],str_long[MAX_STRING];

    format(str_p, sizeof(str_p), "%d",listitem);

    new id = GetPVarInt(playerid, str_p);
    PlayerSelectPhoneBook[playerid] = id;

    if(!PhoneInfo[id][PhoneDBID] || id > MAX_PHONEBOOK)
        return 1;

    new PhoneNames[96];
    format(PhoneNames, sizeof(PhoneNames), "PHONE: %s",PhoneInfo[id][PhoneName]);

    format(str, sizeof(str), "ชื่อผู้ติดต่อ: %s\n", PhoneInfo[id][PhoneName]);
    strcat(str_long, str);
    format(str, sizeof(str), "เบอร์: %d\n", PhoneInfo[id][PhoneNumber]);
    strcat(str_long, str);
    format(str, sizeof(str), "โทรออก\n");
    strcat(str_long, str);
    format(str, sizeof(str), "ส่งข้อความ\n");
    strcat(str_long, str);

    Dialog_Show(playerid, DIALOG_PHONE_SELETE_ID, DIALOG_STYLE_LIST, PhoneNames, str_long, "ยินยัน", "ยกเลิก");
    return 1;
}

Dialog:DIALOG_PHONE_SELETE_ID(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowPhoneBook(playerid);

    switch(listitem)
    {
        case 0: return Dialog_Show(playerid, DIALOG_PHONE_EDIT_NAME, DIALOG_STYLE_INPUT, "แก้ไขรายชื่อติดต่อ:", "โปรดใส่รายชื่อผู้ติดต่อใหม่ที่ต้องการของคุณ:", "ยืนยัน", "ยกเลิก");
        case 1: return Dialog_Show(playerid, DIALOG_PHONE_EDIT_NUMBER, DIALOG_STYLE_INPUT, "แก้ไขเบอร์ติดต่อ:", "โปรดใส่หมายเลขโทรศัพท์ใหม่ของรายชื่อนี้ของคุณ:", "ยืนยัน", "ยกเลิก");
    }
    return 1;
}

Dialog:DIALOG_PHONE_EDIT_NAME(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowPhoneBook(playerid);

    new id = PlayerSelectPhoneBook[playerid];

    if(strlen(inputtext) < 1 || strlen(inputtext) > 60)
        return Dialog_Show(playerid, DIALOG_PHONE_EDIT_NAME, DIALOG_STYLE_INPUT, "แก้ไขรายชื่อติดต่อ:", "โปรดใส่รายชื่อผู้ติดต่อให้ถูกต้อง:", "ยืนยัน", "ยกเลิก");

    format(PhoneInfo[id][PhoneName], PhoneInfo[id][PhoneName], inputtext);
    SetPhoneBookName(id, inputtext);
    ShowPhoneBook(playerid);
    return 1;
}

Dialog:DIALOG_PHONE_EDIT_NUMBER(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowPhoneBook(playerid);

    new id = PlayerSelectPhoneBook[playerid];

    new Number = strval(inputtext);

    if(strlen(inputtext) < 1 || strlen(inputtext) > 5)
        return Dialog_Show(playerid, DIALOG_PHONE_EDIT_NUMBER, DIALOG_STYLE_INPUT, "แก้ไขเบอร์ติดต่อ:", "โปรดใส่หมายเลขโทรศัพท์ให้ถูกต้อง:", "ยืนยัน", "ยกเลิก");

    PhoneInfo[id][PhoneNumber] = Number;
    SetPhoneBookNumber(id, Number);
    ShowPhoneBook(playerid);
    return 1;
}


forward LoadPhoneBook();
public LoadPhoneBook()
{
    if(!cache_num_rows())
        return 1;
    
    new rows; cache_get_row_count(rows);
    for (new i = 0; i < rows && i < MAX_PHONEBOOK; i ++)
    {
        cache_get_value_name_int(i,"PhoneDBID",PhoneInfo[i+1][PhoneDBID]);
        cache_get_value_name_int(i,"PhoneOwnerDBID",PhoneInfo[i+1][PhoneOwnerDBID]);

        cache_get_value_name(i,"PhoneName",PhoneInfo[i+1][PhoneName],60);
        cache_get_value_name_int(i,"PhoneNumber",PhoneInfo[i+1][PhoneNumber]);
    }

    return 1;
}

stock SetPhoneBookName(id, const string[])
{
    new query[MAX_STRING];

    mysql_format(dbCon, query, sizeof(query),"UPDATE phonebook SET PhoneName = '%e' WHERE PhoneDBID = %d",
        string,
        PhoneInfo[id][PhoneDBID]);
    mysql_tquery(dbCon, query);
    return 1;
}
stock SetPhoneBookNumber(id, Number)
{
    new query[MAX_STRING];

    mysql_format(dbCon, query, sizeof(query),"UPDATE phonebook SET PhoneNumber = %d WHERE PhoneDBID = %d",
        Number,
        PhoneInfo[id][PhoneDBID]);
    mysql_tquery(dbCon, query);
    return 1;
}

stock AddPhoneBook(playerid)
{
    new query[MAX_STRING];

    new idx = 0;
	
    for (new i = 1; i < MAX_PHONEBOOK; i ++)
    {
        if(!PhoneInfo[i][PhoneDBID])
        {
            idx = i; 
            break;
        }
    }
    if(idx == 0)
    {
        return SendServerMessage(playerid, "ไม่สามารถสร้างรายชื่อติดต่อได้มากว่านี้แล้ว (700)"); 
    }

    PhoneInfo[idx][PhoneDBID] = idx;
    PhoneInfo[idx][PhoneOwnerDBID] = PlayerInfo[playerid][pDBID];
    PhoneInfo[idx][PhoneName] = PhoneAddName[playerid];
    PhoneInfo[idx][PhoneNumber] = PhoneAddNumber[playerid];
    //mysql_tquery(dbCon, "SELECT * FROM phonebook ORDER BY PhoneDBID", "LoadPhoneBook");

    mysql_format(dbCon, query, sizeof(query),"INSERT INTO `phonebook` (`PhoneOwnerDBID`,`PhoneName`,`PhoneNumber`) VALUES(%d,'%e',%d)",
        PlayerInfo[playerid][pDBID],
        PhoneAddName[playerid],
        PhoneAddNumber[playerid]);
    mysql_tquery(dbCon, query);

    SendClientMessageEx(playerid, -1, "%d", PhoneInfo[idx][PhoneDBID]);
    SendClientMessageEx(playerid, -1, "{F57C00}PHONE SYSTEM:{388E3C} คุณได้เพื่มรายชื่อผู้ติดต่อ {FFEB3B}%s{388E3C} โดยใช้เบอร์: {FFEB3B}%d", PhoneAddName[playerid], PhoneAddNumber[playerid]);
    PhoneAddName[playerid] = "";
    PhoneAddNumber[playerid] = 0;
    ShowPhoneBook(playerid);
    return 1;
}