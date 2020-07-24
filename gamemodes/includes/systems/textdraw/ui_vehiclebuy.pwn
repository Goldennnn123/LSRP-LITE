#include <YSI_Coding\y_hooks>

new PlayerText:VehiclebuyTD[MAX_PLAYERS][14];
new PlayerText:VehicleBuySelect[MAX_PLAYERS][9];


new PlayerSeleteVehicle[MAX_PLAYERS];
new PLayerVehiclePrice[MAX_PLAYERS];
new PlayerVehicleColor1[MAX_PLAYERS];
new PlayerVehicleColor2[MAX_PLAYERS];

stock VehicleBuyTextdraw(playerid)
{
    VehiclebuyTD[playerid][0] = CreatePlayerTextDraw(playerid, 311.000000, 46.000000, "_");
    PlayerTextDrawFont(playerid, VehiclebuyTD[playerid][0], 1);
    PlayerTextDrawLetterSize(playerid, VehiclebuyTD[playerid][0], 0.600000, 39.300003);
    PlayerTextDrawTextSize(playerid, VehiclebuyTD[playerid][0], 298.500000, 575.000000);
    PlayerTextDrawSetOutline(playerid, VehiclebuyTD[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, VehiclebuyTD[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, VehiclebuyTD[playerid][0], 2);
    PlayerTextDrawColor(playerid, VehiclebuyTD[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, VehiclebuyTD[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, VehiclebuyTD[playerid][0], -1094795521);
    PlayerTextDrawUseBox(playerid, VehiclebuyTD[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, VehiclebuyTD[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, VehiclebuyTD[playerid][0], 0);

    VehiclebuyTD[playerid][1] = CreatePlayerTextDraw(playerid, 311.000000, 46.000000, "_");
    PlayerTextDrawFont(playerid, VehiclebuyTD[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid, VehiclebuyTD[playerid][1], 0.600000, 1.300003);
    PlayerTextDrawTextSize(playerid, VehiclebuyTD[playerid][1], 298.500000, 575.000000);
    PlayerTextDrawSetOutline(playerid, VehiclebuyTD[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, VehiclebuyTD[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, VehiclebuyTD[playerid][1], 2);
    PlayerTextDrawColor(playerid, VehiclebuyTD[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, VehiclebuyTD[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, VehiclebuyTD[playerid][1], 1296911871);
    PlayerTextDrawUseBox(playerid, VehiclebuyTD[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, VehiclebuyTD[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, VehiclebuyTD[playerid][1], 0);

    VehiclebuyTD[playerid][2] = CreatePlayerTextDraw(playerid, 593.000000, 40.000000, "X");
    PlayerTextDrawFont(playerid, VehiclebuyTD[playerid][2], 2);
    PlayerTextDrawLetterSize(playerid, VehiclebuyTD[playerid][2], 0.612497, 2.250000);
    PlayerTextDrawTextSize(playerid, VehiclebuyTD[playerid][2], 16.500000, 5.500000);
    PlayerTextDrawSetOutline(playerid, VehiclebuyTD[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, VehiclebuyTD[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, VehiclebuyTD[playerid][2], 2);
    PlayerTextDrawColor(playerid, VehiclebuyTD[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, VehiclebuyTD[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, VehiclebuyTD[playerid][2], 255);
    PlayerTextDrawUseBox(playerid, VehiclebuyTD[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid, VehiclebuyTD[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, VehiclebuyTD[playerid][2], 1);

    VehiclebuyTD[playerid][3] = CreatePlayerTextDraw(playerid, 277.000000, 46.000000, "Vehicle Buy");
    PlayerTextDrawFont(playerid, VehiclebuyTD[playerid][3], 3);
    PlayerTextDrawLetterSize(playerid, VehiclebuyTD[playerid][3], 0.308333, 1.299999);
    PlayerTextDrawTextSize(playerid, VehiclebuyTD[playerid][3], 340.000000, 16.000000);
    PlayerTextDrawSetOutline(playerid, VehiclebuyTD[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, VehiclebuyTD[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, VehiclebuyTD[playerid][3], 1);
    PlayerTextDrawColor(playerid, VehiclebuyTD[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, VehiclebuyTD[playerid][3], 255);
    PlayerTextDrawBoxColor(playerid, VehiclebuyTD[playerid][3], 50);
    PlayerTextDrawUseBox(playerid, VehiclebuyTD[playerid][3], 0);
    PlayerTextDrawSetProportional(playerid, VehiclebuyTD[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, VehiclebuyTD[playerid][3], 0);

    VehiclebuyTD[playerid][4] = CreatePlayerTextDraw(playerid, 29.000000, 67.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehiclebuyTD[playerid][4], 5);
    PlayerTextDrawLetterSize(playerid, VehiclebuyTD[playerid][4], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehiclebuyTD[playerid][4], 90.500000, 87.000000);
    PlayerTextDrawSetOutline(playerid, VehiclebuyTD[playerid][4], 0);
    PlayerTextDrawSetShadow(playerid, VehiclebuyTD[playerid][4], 0);
    PlayerTextDrawAlignment(playerid, VehiclebuyTD[playerid][4], 1);
    PlayerTextDrawColor(playerid, VehiclebuyTD[playerid][4], -1);
    PlayerTextDrawBackgroundColor(playerid, VehiclebuyTD[playerid][4], 90);
    PlayerTextDrawBoxColor(playerid, VehiclebuyTD[playerid][4], 255);
    PlayerTextDrawUseBox(playerid, VehiclebuyTD[playerid][4], 0);
    PlayerTextDrawSetProportional(playerid, VehiclebuyTD[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, VehiclebuyTD[playerid][4], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehiclebuyTD[playerid][4], 461);
    PlayerTextDrawSetPreviewRot(playerid, VehiclebuyTD[playerid][4], -10.000000, 0.000000, -55.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehiclebuyTD[playerid][4], 1, 1);

    VehiclebuyTD[playerid][5] = CreatePlayerTextDraw(playerid, 123.000000, 67.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehiclebuyTD[playerid][5], 5);
    PlayerTextDrawLetterSize(playerid, VehiclebuyTD[playerid][5], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehiclebuyTD[playerid][5], 90.500000, 87.000000);
    PlayerTextDrawSetOutline(playerid, VehiclebuyTD[playerid][5], 0);
    PlayerTextDrawSetShadow(playerid, VehiclebuyTD[playerid][5], 0);
    PlayerTextDrawAlignment(playerid, VehiclebuyTD[playerid][5], 1);
    PlayerTextDrawColor(playerid, VehiclebuyTD[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, VehiclebuyTD[playerid][5], 90);
    PlayerTextDrawBoxColor(playerid, VehiclebuyTD[playerid][5], 255);
    PlayerTextDrawUseBox(playerid, VehiclebuyTD[playerid][5], 0);
    PlayerTextDrawSetProportional(playerid, VehiclebuyTD[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, VehiclebuyTD[playerid][5], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehiclebuyTD[playerid][5], 602);
    PlayerTextDrawSetPreviewRot(playerid, VehiclebuyTD[playerid][5], -10.000000, 0.000000, -55.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehiclebuyTD[playerid][5], 1, 1);

    VehiclebuyTD[playerid][6] = CreatePlayerTextDraw(playerid, 217.000000, 67.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehiclebuyTD[playerid][6], 5);
    PlayerTextDrawLetterSize(playerid, VehiclebuyTD[playerid][6], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehiclebuyTD[playerid][6], 90.500000, 87.000000);
    PlayerTextDrawSetOutline(playerid, VehiclebuyTD[playerid][6], 0);
    PlayerTextDrawSetShadow(playerid, VehiclebuyTD[playerid][6], 0);
    PlayerTextDrawAlignment(playerid, VehiclebuyTD[playerid][6], 1);
    PlayerTextDrawColor(playerid, VehiclebuyTD[playerid][6], -1);
    PlayerTextDrawBackgroundColor(playerid, VehiclebuyTD[playerid][6], 90);
    PlayerTextDrawBoxColor(playerid, VehiclebuyTD[playerid][6], 255);
    PlayerTextDrawUseBox(playerid, VehiclebuyTD[playerid][6], 0);
    PlayerTextDrawSetProportional(playerid, VehiclebuyTD[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, VehiclebuyTD[playerid][6], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehiclebuyTD[playerid][6], 492);
    PlayerTextDrawSetPreviewRot(playerid, VehiclebuyTD[playerid][6], -10.000000, 0.000000, -55.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehiclebuyTD[playerid][6], 1, 1);

    VehiclebuyTD[playerid][7] = CreatePlayerTextDraw(playerid, 311.000000, 67.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehiclebuyTD[playerid][7], 5);
    PlayerTextDrawLetterSize(playerid, VehiclebuyTD[playerid][7], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehiclebuyTD[playerid][7], 90.500000, 87.000000);
    PlayerTextDrawSetOutline(playerid, VehiclebuyTD[playerid][7], 0);
    PlayerTextDrawSetShadow(playerid, VehiclebuyTD[playerid][7], 0);
    PlayerTextDrawAlignment(playerid, VehiclebuyTD[playerid][7], 1);
    PlayerTextDrawColor(playerid, VehiclebuyTD[playerid][7], -1);
    PlayerTextDrawBackgroundColor(playerid, VehiclebuyTD[playerid][7], 90);
    PlayerTextDrawBoxColor(playerid, VehiclebuyTD[playerid][7], 255);
    PlayerTextDrawUseBox(playerid, VehiclebuyTD[playerid][7], 0);
    PlayerTextDrawSetProportional(playerid, VehiclebuyTD[playerid][7], 1);
    PlayerTextDrawSetSelectable(playerid, VehiclebuyTD[playerid][7], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehiclebuyTD[playerid][7], 420);
    PlayerTextDrawSetPreviewRot(playerid, VehiclebuyTD[playerid][7], -10.000000, 0.000000, -55.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehiclebuyTD[playerid][7], 1, 1);

    VehiclebuyTD[playerid][8] = CreatePlayerTextDraw(playerid, 405.000000, 67.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehiclebuyTD[playerid][8], 5);
    PlayerTextDrawLetterSize(playerid, VehiclebuyTD[playerid][8], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehiclebuyTD[playerid][8], 90.500000, 87.000000);
    PlayerTextDrawSetOutline(playerid, VehiclebuyTD[playerid][8], 0);
    PlayerTextDrawSetShadow(playerid, VehiclebuyTD[playerid][8], 0);
    PlayerTextDrawAlignment(playerid, VehiclebuyTD[playerid][8], 1);
    PlayerTextDrawColor(playerid, VehiclebuyTD[playerid][8], -1);
    PlayerTextDrawBackgroundColor(playerid, VehiclebuyTD[playerid][8], 90);
    PlayerTextDrawBoxColor(playerid, VehiclebuyTD[playerid][8], 255);
    PlayerTextDrawUseBox(playerid, VehiclebuyTD[playerid][8], 0);
    PlayerTextDrawSetProportional(playerid, VehiclebuyTD[playerid][8], 1);
    PlayerTextDrawSetSelectable(playerid, VehiclebuyTD[playerid][8], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehiclebuyTD[playerid][8], 499);
    PlayerTextDrawSetPreviewRot(playerid, VehiclebuyTD[playerid][8], -10.000000, 0.000000, -55.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehiclebuyTD[playerid][8], 1, 1);

    VehiclebuyTD[playerid][9] = CreatePlayerTextDraw(playerid, 500.000000, 67.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehiclebuyTD[playerid][9], 5);
    PlayerTextDrawLetterSize(playerid, VehiclebuyTD[playerid][9], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehiclebuyTD[playerid][9], 90.500000, 87.000000);
    PlayerTextDrawSetOutline(playerid, VehiclebuyTD[playerid][9], 0);
    PlayerTextDrawSetShadow(playerid, VehiclebuyTD[playerid][9], 0);
    PlayerTextDrawAlignment(playerid, VehiclebuyTD[playerid][9], 1);
    PlayerTextDrawColor(playerid, VehiclebuyTD[playerid][9], -1);
    PlayerTextDrawBackgroundColor(playerid, VehiclebuyTD[playerid][9], 90);
    PlayerTextDrawBoxColor(playerid, VehiclebuyTD[playerid][9], 255);
    PlayerTextDrawUseBox(playerid, VehiclebuyTD[playerid][9], 0);
    PlayerTextDrawSetProportional(playerid, VehiclebuyTD[playerid][9], 1);
    PlayerTextDrawSetSelectable(playerid, VehiclebuyTD[playerid][9], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehiclebuyTD[playerid][9], 459);
    PlayerTextDrawSetPreviewRot(playerid, VehiclebuyTD[playerid][9], -10.000000, 0.000000, -55.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehiclebuyTD[playerid][9], 1, 1);

    VehiclebuyTD[playerid][10] = CreatePlayerTextDraw(playerid, 29.000000, 158.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehiclebuyTD[playerid][10], 5);
    PlayerTextDrawLetterSize(playerid, VehiclebuyTD[playerid][10], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehiclebuyTD[playerid][10], 90.500000, 87.000000);
    PlayerTextDrawSetOutline(playerid, VehiclebuyTD[playerid][10], 0);
    PlayerTextDrawSetShadow(playerid, VehiclebuyTD[playerid][10], 0);
    PlayerTextDrawAlignment(playerid, VehiclebuyTD[playerid][10], 1);
    PlayerTextDrawColor(playerid, VehiclebuyTD[playerid][10], -1);
    PlayerTextDrawBackgroundColor(playerid, VehiclebuyTD[playerid][10], 90);
    PlayerTextDrawBoxColor(playerid, VehiclebuyTD[playerid][10], 255);
    PlayerTextDrawUseBox(playerid, VehiclebuyTD[playerid][10], 0);
    PlayerTextDrawSetProportional(playerid, VehiclebuyTD[playerid][10], 1);
    PlayerTextDrawSetSelectable(playerid, VehiclebuyTD[playerid][10], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehiclebuyTD[playerid][10], 579);
    PlayerTextDrawSetPreviewRot(playerid, VehiclebuyTD[playerid][10], -10.000000, 0.000000, -55.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehiclebuyTD[playerid][10], 1, 1);

    VehiclebuyTD[playerid][11] = CreatePlayerTextDraw(playerid, 123.000000, 158.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehiclebuyTD[playerid][11], 5);
    PlayerTextDrawLetterSize(playerid, VehiclebuyTD[playerid][11], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehiclebuyTD[playerid][11], 90.500000, 87.000000);
    PlayerTextDrawSetOutline(playerid, VehiclebuyTD[playerid][11], 0);
    PlayerTextDrawSetShadow(playerid, VehiclebuyTD[playerid][11], 0);
    PlayerTextDrawAlignment(playerid, VehiclebuyTD[playerid][11], 1);
    PlayerTextDrawColor(playerid, VehiclebuyTD[playerid][11], -1);
    PlayerTextDrawBackgroundColor(playerid, VehiclebuyTD[playerid][11], 90);
    PlayerTextDrawBoxColor(playerid, VehiclebuyTD[playerid][11], 255);
    PlayerTextDrawUseBox(playerid, VehiclebuyTD[playerid][11], 0);
    PlayerTextDrawSetProportional(playerid, VehiclebuyTD[playerid][11], 1);
    PlayerTextDrawSetSelectable(playerid, VehiclebuyTD[playerid][11], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehiclebuyTD[playerid][11], 567);
    PlayerTextDrawSetPreviewRot(playerid, VehiclebuyTD[playerid][11], -10.000000, 0.000000, -55.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehiclebuyTD[playerid][11], 1, 1);

    VehiclebuyTD[playerid][12] = CreatePlayerTextDraw(playerid, 217.000000, 158.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehiclebuyTD[playerid][12], 5);
    PlayerTextDrawLetterSize(playerid, VehiclebuyTD[playerid][12], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehiclebuyTD[playerid][12], 90.500000, 87.000000);
    PlayerTextDrawSetOutline(playerid, VehiclebuyTD[playerid][12], 0);
    PlayerTextDrawSetShadow(playerid, VehiclebuyTD[playerid][12], 0);
    PlayerTextDrawAlignment(playerid, VehiclebuyTD[playerid][12], 1);
    PlayerTextDrawColor(playerid, VehiclebuyTD[playerid][12], -1);
    PlayerTextDrawBackgroundColor(playerid, VehiclebuyTD[playerid][12], 90);
    PlayerTextDrawBoxColor(playerid, VehiclebuyTD[playerid][12], 255);
    PlayerTextDrawUseBox(playerid, VehiclebuyTD[playerid][12], 0);
    PlayerTextDrawSetProportional(playerid, VehiclebuyTD[playerid][12], 1);
    PlayerTextDrawSetSelectable(playerid, VehiclebuyTD[playerid][12], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehiclebuyTD[playerid][12], 402);
    PlayerTextDrawSetPreviewRot(playerid, VehiclebuyTD[playerid][12], -10.000000, 0.000000, -55.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehiclebuyTD[playerid][12], 1, 1);

    VehiclebuyTD[playerid][13] = CreatePlayerTextDraw(playerid, 311.000000, 158.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehiclebuyTD[playerid][13], 5);
    PlayerTextDrawLetterSize(playerid, VehiclebuyTD[playerid][13], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehiclebuyTD[playerid][13], 90.500000, 87.000000);
    PlayerTextDrawSetOutline(playerid, VehiclebuyTD[playerid][13], 0);
    PlayerTextDrawSetShadow(playerid, VehiclebuyTD[playerid][13], 0);
    PlayerTextDrawAlignment(playerid, VehiclebuyTD[playerid][13], 1);
    PlayerTextDrawColor(playerid, VehiclebuyTD[playerid][13], -1);
    PlayerTextDrawBackgroundColor(playerid, VehiclebuyTD[playerid][13], 90);
    PlayerTextDrawBoxColor(playerid, VehiclebuyTD[playerid][13], 255);
    PlayerTextDrawUseBox(playerid, VehiclebuyTD[playerid][13], 0);
    PlayerTextDrawSetProportional(playerid, VehiclebuyTD[playerid][13], 1);
    PlayerTextDrawSetSelectable(playerid, VehiclebuyTD[playerid][13], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehiclebuyTD[playerid][13], 541);
    PlayerTextDrawSetPreviewRot(playerid, VehiclebuyTD[playerid][13], -10.000000, 0.000000, -55.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehiclebuyTD[playerid][13], 6, 0);
    ////////////////////VEHICLE Vip//////////////////////////////////////

    ///////////////////VEHICLE SELECT///////////////////////////////////
    ///////////////////VEHICLE SELECT///////////////////////////////////
    return 1;
}

stock ShowVehicleBuy(playerid)
{
    VehicleBuyTextdraw(playerid);
    for(new v = 0; v < 14; v++)
    {
        PlayerTextDrawShow(playerid, VehiclebuyTD[playerid][v]);
    }
    SelectTextDraw(playerid, 0xFFFFFF95);
    return 1;
}


stock ShowVehicleBike(playerid)
{
    for(new v = 0; v < 14; v++)
    {
        PlayerTextDrawHide(playerid, VehiclebuyTD[playerid][v]);
    }
    CancelSelectTextDraw(playerid);

   
    new longstr[MAX_STRING], str[MAX_STRING];

    format(str, sizeof(str), "NAME\tPRICE\n",MoneyFormat(700));
    strcat(longstr, str);

    format(str, sizeof(str), "BIKE\t$%s\n",MoneyFormat(700));
    strcat(longstr, str);
    format(str, sizeof(str), "BMX\t$%s\n",MoneyFormat(1200));
    strcat(longstr, str);
    format(str, sizeof(str), "Mountain Bike\t$%s\n",MoneyFormat(1500));
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
    for(new v = 0; v < 14; v++)
    {
        PlayerTextDrawHide(playerid, VehiclebuyTD[playerid][v]);
    }
    CancelSelectTextDraw(playerid);

   
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

stock ShowVehicleLuxury(playerid)
{
    for(new v = 0; v < 14; v++)
    {
        PlayerTextDrawHide(playerid, VehiclebuyTD[playerid][v]);
    }
    CancelSelectTextDraw(playerid);

   
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


stock ShowVehicleService(playerid)
{
    for(new v = 0; v < 14; v++)
    {
        PlayerTextDrawHide(playerid, VehiclebuyTD[playerid][v]);
    }
    CancelSelectTextDraw(playerid);

   
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

stock ShowVehicleTrucks(playerid)
{
    for(new v = 0; v < 14; v++)
    {
        PlayerTextDrawHide(playerid, VehiclebuyTD[playerid][v]);
    }
    CancelSelectTextDraw(playerid);

   
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
    for(new v = 0; v < 14; v++)
    {
        PlayerTextDrawHide(playerid, VehiclebuyTD[playerid][v]);
    }
    CancelSelectTextDraw(playerid);

   
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
    for(new v = 0; v < 14; v++)
    {
        PlayerTextDrawHide(playerid, VehiclebuyTD[playerid][v]);
    }
    CancelSelectTextDraw(playerid);

   
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

    Dialog_Show(playerid, DIALOG_BUY_VANS_LIST, DIALOG_STYLE_TABLIST_HEADERS, "VEHICLE BUY", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

stock ShowVehicleHeavy(playerid)
{
    for(new v = 0; v < 14; v++)
    {
        PlayerTextDrawHide(playerid, VehiclebuyTD[playerid][v]);
    }
    CancelSelectTextDraw(playerid);

   
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

stock ShowVehicleMuscle(playerid)
{
    for(new v = 0; v < 14; v++)
    {
        PlayerTextDrawHide(playerid, VehiclebuyTD[playerid][v]);
    }
    CancelSelectTextDraw(playerid);

   
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
    for(new v = 0; v < 14; v++)
    {
        PlayerTextDrawHide(playerid, VehiclebuyTD[playerid][v]);
    }
    CancelSelectTextDraw(playerid);

   
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
        return ShowVehicleBuy(playerid);

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
            PlayerSeleteVehicle[playerid] = 481;
            PLayerVehiclePrice[playerid] = 1200;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 2:
        {
            PlayerSeleteVehicle[playerid] = 510;
            PLayerVehiclePrice[playerid] = 1500;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 3:
        {
            PlayerSeleteVehicle[playerid] = 462;
            PLayerVehiclePrice[playerid] = 10000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 4:
        {
            PlayerSeleteVehicle[playerid] = 448;
            PLayerVehiclePrice[playerid] = 12000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 5:
        {
            PlayerSeleteVehicle[playerid] = 463;
            PLayerVehiclePrice[playerid] = 30000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
            ShowVehicleSelect(playerid);
            return 1;
        }
        case 6:
        {
            PlayerSeleteVehicle[playerid] = 586;
            PLayerVehiclePrice[playerid] = 35000;
            PlayerVehicleColor1[playerid] = random(255);
            PlayerVehicleColor2[playerid] = random(255);
            SelectTextDraw(playerid, 0xFFFFFF95);
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


hook OP_ClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == VehiclebuyTD[playerid][2])
    {
        for(new v = 0; v < 14; v++)
        {
            PlayerTextDrawHide(playerid, VehiclebuyTD[playerid][v]);
        }
        CancelSelectTextDraw(playerid);
        return 1;
    }
    if(playertextid == VehiclebuyTD[playerid][4])
    {
        ShowVehicleBike(playerid);
        return 1;
    }
    if(playertextid == VehiclebuyTD[playerid][5])
    {
        ShowVehicleCompact(playerid);
        return 1;
    }
    if(playertextid == VehiclebuyTD[playerid][6])
    {
        ShowVehicleLuxury(playerid);
        return 1;
    }
    if(playertextid == VehiclebuyTD[playerid][7])
    {
        ShowVehicleService(playerid);
        return 1;
    }
    if(playertextid == VehiclebuyTD[playerid][8])
    {
        ShowVehicleHeavy(playerid);
        return 1;
    }
    if(playertextid == VehiclebuyTD[playerid][9])
    {
        ShowVehicleTrucks(playerid);
        return 1;
    }
    if(playertextid == VehiclebuyTD[playerid][10])
    {
        ShowVehicleVans(playerid);
        return 1;
    }
    if(playertextid == VehiclebuyTD[playerid][11])
    {
        ShowVehicleLowriders(playerid);
        return 1;
    }
    if(playertextid == VehiclebuyTD[playerid][12])
    {
        ShowVehicleMuscle(playerid);
        return 1;
    }
    if(playertextid == VehiclebuyTD[playerid][13])
    {
        ShowVehicleVip(playerid);
        return 1;
    }
    if(playertextid == VehicleBuySelect[playerid][4])
    {
        Dialog_Show(playerid, DIALOG_VEH_COLOR1, DIALOG_STYLE_INPUT, "ใส่สีรถ", "กรุณาเลือกสีรถที่คุณต้องการเปลี่ยน (0-255)", "ยืนยัน", "ยกเลิก");
        return 1;
    }
    if(playertextid == VehicleBuySelect[playerid][8])
    {
        Dialog_Show(playerid, DIALOG_VEH_COLOR2, DIALOG_STYLE_INPUT, "ใส่สีรถ", "กรุณาเลือกสีรถที่คุณต้องการเปลี่ยน (0-255)", "ยืนยัน", "ยกเลิก");
        return 1;
    }
    if(playertextid == VehicleBuySelect[playerid][2])
    {
        for(new v = 0; v < 9; v++)
        {
            PlayerTextDrawDestroy(playerid, VehicleBuySelect[playerid][v]);
        }
        ShowVehicleBuy(playerid);
        return 1;
    }
    if(playertextid == VehicleBuySelect[playerid][7])
    {
        
        return 1;
    }
    return 1;
}

stock ShowVehicleSelect(playerid)
{
    new str[MAX_STRING];

    /*format(str, sizeof(str), "VEHICLE NAME: %s", ReturnVehicleModelName(PlayerSeleteVehicle[playerid]));

    format(str, sizeof(str), "PRICE: %s", MoneyFormat(PLayerVehiclePrice[playerid]));*/

    VehicleBuySelect[playerid][0] = CreatePlayerTextDraw(playerid, 307.000000, 100.000000, "_");
    PlayerTextDrawFont(playerid, VehicleBuySelect[playerid][0], 1);
    PlayerTextDrawLetterSize(playerid, VehicleBuySelect[playerid][0], 0.600000, 34.850002);
    PlayerTextDrawTextSize(playerid, VehicleBuySelect[playerid][0], 298.500000, 510.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuySelect[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuySelect[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuySelect[playerid][0], 2);
    PlayerTextDrawColor(playerid, VehicleBuySelect[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuySelect[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuySelect[playerid][0], -1094795521);
    PlayerTextDrawUseBox(playerid, VehicleBuySelect[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuySelect[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuySelect[playerid][0], 0);

    VehicleBuySelect[playerid][1] = CreatePlayerTextDraw(playerid, 307.000000, 100.000000, "_");
    PlayerTextDrawFont(playerid, VehicleBuySelect[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid, VehicleBuySelect[playerid][1], 0.600000, 1.800003);
    PlayerTextDrawTextSize(playerid, VehicleBuySelect[playerid][1], 333.500000, 510.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuySelect[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuySelect[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuySelect[playerid][1], 2);
    PlayerTextDrawColor(playerid, VehicleBuySelect[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuySelect[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuySelect[playerid][1], 1296911871);
    PlayerTextDrawUseBox(playerid, VehicleBuySelect[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuySelect[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuySelect[playerid][1], 0);

    VehicleBuySelect[playerid][2] = CreatePlayerTextDraw(playerid, 555.000000, 93.000000, "X");
    PlayerTextDrawFont(playerid, VehicleBuySelect[playerid][2], 2);
    PlayerTextDrawLetterSize(playerid, VehicleBuySelect[playerid][2], 0.499998, 3.049999);
    PlayerTextDrawTextSize(playerid, VehicleBuySelect[playerid][2], 16.500000, 10.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuySelect[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuySelect[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuySelect[playerid][2], 2);
    PlayerTextDrawColor(playerid, VehicleBuySelect[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuySelect[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuySelect[playerid][2], 200);
    PlayerTextDrawUseBox(playerid, VehicleBuySelect[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuySelect[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuySelect[playerid][2], 1);

    VehicleBuySelect[playerid][3] = CreatePlayerTextDraw(playerid, 236.000000, 111.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehicleBuySelect[playerid][3], 5);
    PlayerTextDrawLetterSize(playerid, VehicleBuySelect[playerid][3], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuySelect[playerid][3], 157.500000, 156.000000);
    PlayerTextDrawSetOutline(playerid, VehicleBuySelect[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, VehicleBuySelect[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuySelect[playerid][3], 1);
    PlayerTextDrawColor(playerid, VehicleBuySelect[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuySelect[playerid][3], 0);
    PlayerTextDrawBoxColor(playerid, VehicleBuySelect[playerid][3], 255);
    PlayerTextDrawUseBox(playerid, VehicleBuySelect[playerid][3], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuySelect[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuySelect[playerid][3], 0);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuySelect[playerid][3], PlayerSeleteVehicle[playerid]);
    PlayerTextDrawSetPreviewRot(playerid, VehicleBuySelect[playerid][3], -10.000000, 0.000000, -36.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuySelect[playerid][3], PlayerVehicleColor1[playerid], PlayerVehicleColor2[playerid]);

    VehicleBuySelect[playerid][4] = CreatePlayerTextDraw(playerid, 252.000000, 239.000000, "COLOR 1");
    PlayerTextDrawFont(playerid, VehicleBuySelect[playerid][4], 2);
    PlayerTextDrawLetterSize(playerid, VehicleBuySelect[playerid][4], 0.258332, 1.750000);
    PlayerTextDrawTextSize(playerid, VehicleBuySelect[playerid][4], 16.500000, 45.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuySelect[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuySelect[playerid][4], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuySelect[playerid][4], 2);
    PlayerTextDrawColor(playerid, VehicleBuySelect[playerid][4], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuySelect[playerid][4], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuySelect[playerid][4], 200);
    PlayerTextDrawUseBox(playerid, VehicleBuySelect[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuySelect[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuySelect[playerid][4], 1);

    
    format(str, sizeof(str), "VEHICLE NAME: %s", ReturnVehicleModelName(PlayerSeleteVehicle[playerid]));
    VehicleBuySelect[playerid][5] = CreatePlayerTextDraw(playerid, 77.000000, 270.000000, str);
    PlayerTextDrawFont(playerid, VehicleBuySelect[playerid][5], 2);
    PlayerTextDrawLetterSize(playerid, VehicleBuySelect[playerid][5], 0.262499, 1.799999);
    PlayerTextDrawTextSize(playerid, VehicleBuySelect[playerid][5], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, VehicleBuySelect[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuySelect[playerid][5], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuySelect[playerid][5], 1);
    PlayerTextDrawColor(playerid, VehicleBuySelect[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuySelect[playerid][5], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuySelect[playerid][5], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuySelect[playerid][5], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuySelect[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuySelect[playerid][5], 0);

    format(str, sizeof(str), "PRICE: %s", MoneyFormat(PLayerVehiclePrice[playerid]));
    VehicleBuySelect[playerid][6] = CreatePlayerTextDraw(playerid, 77.000000, 288.000000, str);
    PlayerTextDrawFont(playerid, VehicleBuySelect[playerid][6], 2);
    PlayerTextDrawLetterSize(playerid, VehicleBuySelect[playerid][6], 0.262499, 1.799999);
    PlayerTextDrawTextSize(playerid, VehicleBuySelect[playerid][6], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, VehicleBuySelect[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuySelect[playerid][6], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuySelect[playerid][6], 1);
    PlayerTextDrawColor(playerid, VehicleBuySelect[playerid][6], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuySelect[playerid][6], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuySelect[playerid][6], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuySelect[playerid][6], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuySelect[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuySelect[playerid][6], 0);

    VehicleBuySelect[playerid][7] = CreatePlayerTextDraw(playerid, 517.000000, 398.000000, "BUY NOW!");
    PlayerTextDrawFont(playerid, VehicleBuySelect[playerid][7], 2);
    PlayerTextDrawLetterSize(playerid, VehicleBuySelect[playerid][7], 0.258332, 1.750000);
    PlayerTextDrawTextSize(playerid, VehicleBuySelect[playerid][7], 16.500000, 90.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuySelect[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuySelect[playerid][7], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuySelect[playerid][7], 2);
    PlayerTextDrawColor(playerid, VehicleBuySelect[playerid][7], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuySelect[playerid][7], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuySelect[playerid][7], 9109759);
    PlayerTextDrawUseBox(playerid, VehicleBuySelect[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuySelect[playerid][7], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuySelect[playerid][7], 1);

    VehicleBuySelect[playerid][8] = CreatePlayerTextDraw(playerid, 336.000000, 239.000000, "COLOR 2");
    PlayerTextDrawFont(playerid, VehicleBuySelect[playerid][8], 2);
    PlayerTextDrawLetterSize(playerid, VehicleBuySelect[playerid][8], 0.258332, 1.750000);
    PlayerTextDrawTextSize(playerid, VehicleBuySelect[playerid][8], 26.000000, 49.000000);
    PlayerTextDrawSetOutline(playerid, VehicleBuySelect[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuySelect[playerid][8], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuySelect[playerid][8], 2);
    PlayerTextDrawColor(playerid, VehicleBuySelect[playerid][8], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuySelect[playerid][8], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuySelect[playerid][8], 200);
    PlayerTextDrawUseBox(playerid, VehicleBuySelect[playerid][8], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuySelect[playerid][8], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuySelect[playerid][8], 1);

    for(new v = 0; v < 10; v++)
    {
        PlayerTextDrawShow(playerid, VehicleBuySelect[playerid][v]);
    }
    SelectTextDraw(playerid, 0xFFFFFF95);

    return 1;
}