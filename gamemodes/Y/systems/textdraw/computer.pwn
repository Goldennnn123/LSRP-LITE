#define TEXTDRAW_CUSTOM "mdl-2000:"
new PlayerText:PL_Computer[MAX_PLAYERS][5];

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
    return 1;
}

stock DesTD_Computer(playerid)
{
    for(new t = 0; t < 5; t++)
    {
        PlayerTextDrawDestroy(playerid, PL_Computer[playerid][t]);
    }
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

hook OP_Disconnect(playerid, reason)
{
    DesTD_Computer(playerid);
    return 1;
}

hook OP_ClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == PL_Computer[playerid][3])
    {
        Dialog_Show(playerid, D_COMPUTER_CLOSE, DIALOG_STYLE_MSGBOX, "คุณจะปิดคอม?", "คุณเลือกที่จะปิดคอมหรือจะไม่ปิด", "ปิด", "ไม่ปิด");
        return 1;
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


    ComputerInfo[id][ComputerOn] = false;
    DesTD_Computer(playerid);
    CancelSelectTextDraw(playerid);
    SendClientMessage(playerid, -1, "คุณได้ปิดคอมของคุณแล้ว");
    return 1;
}