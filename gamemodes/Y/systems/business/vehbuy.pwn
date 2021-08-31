#include <YSI_Coding\y_hooks>

new possibleVehiclePlates[][] = 
	{"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};

/*new PlayerText:VehicleBuyMenu[MAX_PLAYERS][23];

enum V_VEHICLE_BUY
{
    V_STEP,
    V_GROUP,
    V_GROUP_STEP,
}
new PlayerbuyVeh[MAX_PLAYERS][V_VEHICLE_BUY];


enum VehiclePriceID
{
    V_Name[60],
    V_Model,
    V_Type,
    V_PRICE
}

new g_aDealershipData[][VehiclePriceID] =
{
    {"Bike",509, 1, 1200}, //0
    {"Faggio",462, 1, 10000}, //1
    {"Pizzaboy",448, 1, 11000}, //2
    {"Freeway",463, 1, 35000}, //3
    {"Wayfarer",586, 1, 35000}, //4

    ///// 2 Door:
    {"Alpha",602, 2, 78000}, //5
    {"Blista",496, 2, 78000}, //6
    {"Bravura",401, 2, 78000}, //7
    {"Buccaneer",518, 2, 78000},//8
    {"Cadrona",527, 2, 89000},//9
    {"Club",589, 2, 89500},//10  
    {"Esperanto",419, 2, 78000},//11
    {"Euros",587, 2, 90000},//12
    {"Feltzer",533, 2, 90000},//13
    {"Fortune",526, 2, 120000},//14
    {"Hermes",474, 2, 120000},//15
    {"Hustler",545, 2, 250000},//16
    {"Majestic",517, 2, 65000},//17
    {"Manana",410, 2, 75000},//18
    {"Picador",600, 2, 55000},//19
    {"Previon",436, 2, 55000},//20
    {"Stallion",439, 2, 89000},//21
    {"Tampa",549, 2, 89000},//22
    {"Virgo",491, 2, 89000}//23
    ///// 2 Door:
    
};

hook OnPlayerConnect(playerid)
{
    PlayerbuyVeh[playerid][V_STEP] = 0;
    PlayerbuyVeh[playerid][V_GROUP] = 0;
    PlayerbuyVeh[playerid][V_GROUP_STEP] = 0;
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    PlayerbuyVeh[playerid][V_STEP] = 0;
    PlayerbuyVeh[playerid][V_GROUP] = 0;

    for(new i = 0; i < 23; i++)
    {
        PlayerTextDrawDestroy(playerid, VehicleBuyMenu[playerid][i]);
    }

    return 1;
}

hook OP_ClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(PlayerInfo[playerid][pGUI] == 2)
    {
        if(PlayerbuyVeh[playerid][V_GROUP] == 1)
        {
            if(!PlayerbuyVeh[playerid][V_GROUP_STEP])
            {
                if(playertextid == VehicleBuyMenu[playerid][14])
                {
                    for(new i = 17; i < 23; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                    }

                    PlayerbuyVeh[playerid][V_GROUP] = 0;
                    ShowVehicleMenuStep1(playerid);
                }
                return 1;
            }
            return 1;
        }
        else if(PlayerbuyVeh[playerid][V_GROUP] == 2)
        {
            if(!PlayerbuyVeh[playerid][V_GROUP_STEP])
            {
                if(playertextid == VehicleBuyMenu[playerid][14])
                {
                    for(new i = 17; i < 23; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                    }

                    PlayerbuyVeh[playerid][V_GROUP] = 0;
                    ShowVehicleMenuStep1(playerid);
                    return 1;
                }

                if(playertextid == VehicleBuyMenu[playerid][15])
                {
                    PlayerbuyVeh[playerid][V_GROUP_STEP] = 1;

                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][1], g_aDealershipData[11][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][0], g_aDealershipData[12][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][2], g_aDealershipData[13][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][3], g_aDealershipData[14][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][4], g_aDealershipData[15][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][5], g_aDealershipData[16][V_Model]);
                    
                    // เปลี่ยนชื่อ รถ
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][8], g_aDealershipData[11][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][9], g_aDealershipData[12][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][10], g_aDealershipData[13][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][11], g_aDealershipData[14][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][12], g_aDealershipData[15][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][13], g_aDealershipData[16][V_Name]);
                   
                    for(new i = 8; i < 14; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                    }


                    for(new i = 0; i < 6; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                    }

                     // Show ราคา
                    new str[100];
                    for(new i = 17; i < 23; i++)
                    {
                        for(new s = 11; s < 17; s++)
                        {
                            format(str, sizeof(str), "$%s",MoneyFormat(g_aDealershipData[s][V_PRICE]));
                        }

                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][i], str);
                    }

                    return 1;
                }
                return 1;
            }
            else if(PlayerbuyVeh[playerid][V_GROUP_STEP] == 1)
            {
                if(playertextid == VehicleBuyMenu[playerid][14])
                {
                    PlayerbuyVeh[playerid][V_GROUP_STEP] = 0;

                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][1], g_aDealershipData[5][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][0], g_aDealershipData[6][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][2], g_aDealershipData[7][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][3], g_aDealershipData[8][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][4], g_aDealershipData[9][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][5], g_aDealershipData[10][V_Model]);
                    
                    // เปลี่ยนชื่อ รถ
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][8], g_aDealershipData[5][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][9], g_aDealershipData[6][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][10], g_aDealershipData[7][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][11], g_aDealershipData[8][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][12], g_aDealershipData[9][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][13], g_aDealershipData[10][V_Name]);
                    for(new i = 8; i < 14; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                    }

                    for(new i = 0; i < 6; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                    }

                     // Show ราคา
                    new str[100];
                    for(new i = 17; i < 23; i++)
                    {
                        for(new s = 5; s < 11; s++)
                        {
                            format(str, sizeof(str), "$%s",MoneyFormat(g_aDealershipData[s][V_PRICE]));
                        }

                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][i], str);
                    }

                    return 1;
                }

                if(playertextid == VehicleBuyMenu[playerid][15])
                {
                    PlayerbuyVeh[playerid][V_GROUP_STEP] = 2;

                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][1], g_aDealershipData[17][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][0], g_aDealershipData[18][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][2], g_aDealershipData[19][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][3], g_aDealershipData[20][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][4], g_aDealershipData[21][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][5], g_aDealershipData[22][V_Model]);
                    
                    // เปลี่ยนชื่อ รถ
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][8], g_aDealershipData[17][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][9], g_aDealershipData[18][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][10], g_aDealershipData[19][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][11], g_aDealershipData[20][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][12], g_aDealershipData[21][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][13], g_aDealershipData[22][V_Name]);
                    for(new i = 8; i < 14; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                    }


                    for(new i = 0; i < 6; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                    }


                     // Show ราคา
                    new str[100];
                    for(new i = 17; i < 23; i++)
                    {
                        for(new s = 17; s < 23; s++)
                        {
                            format(str, sizeof(str), "$%s",MoneyFormat(g_aDealershipData[s][V_PRICE]));
                        }

                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][i], str);
                    }

                    return 1;
                }
            }
            else if(PlayerbuyVeh[playerid][V_GROUP_STEP] == 2)
            {
                if(playertextid == VehicleBuyMenu[playerid][14])
                {
                    PlayerbuyVeh[playerid][V_GROUP_STEP] = 1;

                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][1], g_aDealershipData[11][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][0], g_aDealershipData[12][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][2], g_aDealershipData[13][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][3], g_aDealershipData[14][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][4], g_aDealershipData[15][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][5], g_aDealershipData[16][V_Model]);
                    

                    // เปลี่ยนชื่อ รถ
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][8], g_aDealershipData[11][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][9], g_aDealershipData[12][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][10], g_aDealershipData[13][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][11], g_aDealershipData[14][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][12], g_aDealershipData[15][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][13], g_aDealershipData[16][V_Name]);
                    
                    for(new i = 8; i < 14; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                    }

                    for(new i = 0; i < 6; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                    }

                     // Show ราคา
                    new str[100];
                    for(new i = 17; i < 23; i++)
                    {
                        for(new s = 11; s < 17; s++)
                        {
                            format(str, sizeof(str), "$%s",MoneyFormat(g_aDealershipData[s][V_PRICE]));
                        }

                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][i], str);
                    }

                    return 1;
                }

                if(playertextid == VehicleBuyMenu[playerid][15])
                {
                    PlayerbuyVeh[playerid][V_GROUP_STEP] = 3;

                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][1], g_aDealershipData[23][V_Model]);
                    
                    // เปลี่ยนชื่อ รถ
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][8], g_aDealershipData[23][V_Name]);
                    for(new i = 9; i < 14; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                    }

                    for(new i = 0; i < 6; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][1]);
                    }

                     // Show ราคา
                    new str[100];
                    for(new i = 17; i < 23; i++)
                    {
                        format(str, sizeof(str), "$%s",MoneyFormat(g_aDealershipData[23][V_PRICE]));
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);

                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][17]);
                        PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][17], str);
                    }
                    return 1;
                }
            }
            else if(PlayerbuyVeh[playerid][V_GROUP_STEP] == 3)
            {
                if(playertextid == VehicleBuyMenu[playerid][14])
                {
                    PlayerbuyVeh[playerid][V_GROUP_STEP] = 2;

                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][1], g_aDealershipData[17][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][0], g_aDealershipData[18][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][2], g_aDealershipData[19][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][3], g_aDealershipData[20][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][4], g_aDealershipData[21][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][5], g_aDealershipData[22][V_Model]);
                    
                    // เปลี่ยนชื่อ รถ
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][8], g_aDealershipData[17][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][9], g_aDealershipData[18][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][10], g_aDealershipData[19][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][11], g_aDealershipData[20][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][12], g_aDealershipData[21][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][13], g_aDealershipData[22][V_Name]);
                    
                    for(new i = 8; i < 14; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                    }


                    for(new i = 0; i < 6; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                    }

                     // Show ราคา
                    new str[100];
                    for(new i = 17; i < 23; i++)
                    {
                        for(new s = 17; s < 23; s++)
                        {
                            format(str, sizeof(str), "$%s",MoneyFormat(g_aDealershipData[s][V_PRICE]));
                        }

                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][i], str);
                    }

                    return 1;
                }
            }
            return 1;
        }
        ///END

        if(!PlayerbuyVeh[playerid][V_GROUP])
        {
            if(playertextid == VehicleBuyMenu[playerid][14])
            {
                if(!PlayerbuyVeh[playerid][V_STEP])
                    return 1;
                
                PlayerbuyVeh[playerid][V_STEP]--;
                ShowVehicleMenuStep1(playerid);
            }
            if(playertextid == VehicleBuyMenu[playerid][15])
            {
                if(PlayerbuyVeh[playerid][V_STEP] == 1)
                    return 1;
                
                PlayerbuyVeh[playerid][V_STEP]++;
                ShowVehicleMenuStep2(playerid);
            }
            if(playertextid == VehicleBuyMenu[playerid][1])
            {
                if(!PlayerbuyVeh[playerid][V_STEP])
                {
                    PlayerbuyVeh[playerid][V_GROUP] = 1;

                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][1], g_aDealershipData[0][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][0], g_aDealershipData[1][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][2], g_aDealershipData[2][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][3], g_aDealershipData[3][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][4], g_aDealershipData[4][V_Model]);
                    
                    // เปลี่ยนชื่อ รถ
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][8], g_aDealershipData[0][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][9], g_aDealershipData[1][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][10], g_aDealershipData[2][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][11], g_aDealershipData[3][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][12], g_aDealershipData[4][V_Name]);


                    for(new i = 0; i < 6; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                    }

                     // Show ราคา
                    for(new i = 17; i < 22; i++)
                    {
                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                    }

                    new str[100];

                    format(str, sizeof(str), "$%s",MoneyFormat(g_aDealershipData[0][V_PRICE]));
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][17], str);

                    format(str, sizeof(str), "$%s",MoneyFormat(g_aDealershipData[1][V_PRICE]));
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][18], str);

                    format(str, sizeof(str), "$%s",MoneyFormat(g_aDealershipData[2][V_PRICE]));
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][19], str);

                    format(str, sizeof(str), "$%s",MoneyFormat(g_aDealershipData[3][V_PRICE]));
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][20], str);

                    format(str, sizeof(str), "$%s",MoneyFormat(g_aDealershipData[4][V_PRICE]));
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][21], str);

                    PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][5]);
                    PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][13]);
                    return 1;
                }

            }

            if(playertextid == VehicleBuyMenu[playerid][0])
            {
                if(!PlayerbuyVeh[playerid][V_STEP])
                {
                    PlayerbuyVeh[playerid][V_GROUP] = 2;

                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][1], g_aDealershipData[5][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][0], g_aDealershipData[6][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][2], g_aDealershipData[7][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][3], g_aDealershipData[8][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][4], g_aDealershipData[9][V_Model]);
                    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][5], g_aDealershipData[10][V_Model]);
                    
                    // เปลี่ยนชื่อ รถ
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][8], g_aDealershipData[5][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][9], g_aDealershipData[6][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][10], g_aDealershipData[7][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][11], g_aDealershipData[8][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][12], g_aDealershipData[9][V_Name]);
                    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][13], g_aDealershipData[10][V_Name]);


                    for(new i = 0; i < 6; i++)
                    {
                        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                    }

                     // Show ราคา
                    new str[100];
                    for(new i = 17; i < 23; i++)
                    {
                        for(new s = 5; s < 11; s++)
                        {
                            format(str, sizeof(str), "$%s",MoneyFormat(g_aDealershipData[s][V_PRICE]));
                        }

                        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
                        PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][i], str);
                    }

                    return 1;
                }
            }

            return 1; ///END
        }

    }
    return 1;
}

CMD:buyveh(playerid, params[])
{
    LoadVehicleMenu(playerid);
    
    for(new i = 0; i < 17; i++)
    {
        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
    }
    PlayerInfo[playerid][pGUI] = 2;
    SelectTextDraw(playerid, 0x33AA33FF);
    return 1;
}

stock LoadVehicleMenu(playerid)
{
    VehicleBuyMenu[playerid][0] = CreatePlayerTextDraw(playerid, 261.000000, 90.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][0], 5);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][0], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][0], 108.000000, 108.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][0], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][0], 181);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][0], 0);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][0], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][0], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][0], 602);
    PlayerTextDrawSetPreviewRot(playerid, VehicleBuyMenu[playerid][0], -19.000000, 0.000000, -62.000000, 0.860000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuyMenu[playerid][0], 20, 1);

    VehicleBuyMenu[playerid][1] = CreatePlayerTextDraw(playerid, 153.000000, 90.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][1], 5);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][1], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][1], 108.000000, 108.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][1], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][1], 181);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][1], 0);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][1], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][1], 481);
    PlayerTextDrawSetPreviewRot(playerid, VehicleBuyMenu[playerid][1], -19.000000, 0.000000, -62.000000, 0.680000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuyMenu[playerid][1], 4, 1);

    VehicleBuyMenu[playerid][2] = CreatePlayerTextDraw(playerid, 369.000000, 90.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][2], 5);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][2], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][2], 108.000000, 108.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][2], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][2], 181);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][2], 0);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][2], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][2], 492);
    PlayerTextDrawSetPreviewRot(playerid, VehicleBuyMenu[playerid][2], -19.000000, 0.000000, -62.000000, 0.860000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuyMenu[playerid][2], 16, 1);

    VehicleBuyMenu[playerid][3] = CreatePlayerTextDraw(playerid, 153.000000, 220.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][3], 5);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][3], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][3], 108.000000, 108.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][3], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][3], 181);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][3], 0);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][3], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][3], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][3], 420);
    PlayerTextDrawSetPreviewRot(playerid, VehicleBuyMenu[playerid][3], -19.000000, 0.000000, -62.000000, 0.779999);
    PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuyMenu[playerid][3], 6, 1);

    VehicleBuyMenu[playerid][4] = CreatePlayerTextDraw(playerid, 261.000000, 220.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][4], 5);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][4], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][4], 108.000000, 108.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][4], 0);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][4], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][4], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][4], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][4], 181);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][4], 0);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][4], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][4], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][4], 498);
    PlayerTextDrawSetPreviewRot(playerid, VehicleBuyMenu[playerid][4], -19.000000, 0.000000, -62.000000, 0.779999);
    PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuyMenu[playerid][4], 9, 1);

    VehicleBuyMenu[playerid][5] = CreatePlayerTextDraw(playerid, 369.000000, 220.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][5], 5);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][5], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][5], 108.000000, 108.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][5], 0);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][5], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][5], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][5], 181);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][5], 0);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][5], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][5], 1);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][5], 482);
    PlayerTextDrawSetPreviewRot(playerid, VehicleBuyMenu[playerid][5], -19.000000, 0.000000, -62.000000, 0.779999);
    PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuyMenu[playerid][5], 41, 1);

    VehicleBuyMenu[playerid][6] = CreatePlayerTextDraw(playerid, 315.000000, 200.000000, "_");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][6], 1);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][6], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][6], 298.500000, 320.000000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][6], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][6], 2);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][6], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][6], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][6], 255);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][6], 0);

    VehicleBuyMenu[playerid][7] = CreatePlayerTextDraw(playerid, 315.000000, 330.000000, "_");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][7], 1);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][7], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][7], 298.500000, 320.000000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][7], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][7], 2);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][7], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][7], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][7], 255);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][7], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][7], 0);

    VehicleBuyMenu[playerid][8] = CreatePlayerTextDraw(playerid, 172.000000, 198.000000, "Bikes");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][8], 3);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][8], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][8], 169.500000, 370.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][8], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][8], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][8], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][8], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][8], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][8], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][8], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][8], 0);

    VehicleBuyMenu[playerid][9] = CreatePlayerTextDraw(playerid, 272.000000, 199.000000, "Compact");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][9], 3);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][9], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][9], 169.500000, 370.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][9], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][9], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][9], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][9], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][9], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][9], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][9], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][9], 0);

    VehicleBuyMenu[playerid][10] = CreatePlayerTextDraw(playerid, 388.000000, 199.000000, "Luxury");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][10], 3);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][10], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][10], 169.500000, 370.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][10], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][10], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][10], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][10], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][10], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][10], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][10], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][10], 0);

    VehicleBuyMenu[playerid][11] = CreatePlayerTextDraw(playerid, 161.000000, 329.000000, "service");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][11], 3);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][11], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][11], 169.500000, 370.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][11], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][11], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][11], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][11], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][11], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][11], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][11], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][11], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][11], 0);

    VehicleBuyMenu[playerid][12] = CreatePlayerTextDraw(playerid, 274.000000, 329.000000, "Utility");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][12], 3);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][12], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][12], 169.500000, 370.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][12], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][12], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][12], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][12], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][12], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][12], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][12], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][12], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][12], 0);

    VehicleBuyMenu[playerid][13] = CreatePlayerTextDraw(playerid, 397.000000, 329.000000, "Vans");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][13], 3);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][13], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][13], 169.500000, 370.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][13], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][13], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][13], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][13], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][13], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][13], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][13], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][13], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][13], 0);

    VehicleBuyMenu[playerid][14] = CreatePlayerTextDraw(playerid, 124.000000, 189.000000, "ld_beat:left");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][14], 4);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][14], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][14], 39.000000, 42.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][14], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][14], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][14], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][14], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][14], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][14], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][14], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][14], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][14], 1);

    VehicleBuyMenu[playerid][15] = CreatePlayerTextDraw(playerid, 468.000000, 189.000000, "ld_beat:right");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][15], 4);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][15], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][15], 39.000000, 42.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][15], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][15], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][15], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][15], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][15], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][15], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][15], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][15], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][15], 1);

    VehicleBuyMenu[playerid][16] = CreatePlayerTextDraw(playerid, 153.000000, 64.000000, "Vehicle");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][16], 0);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][16], 1.037500, 3.649997);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][16], 169.500000, 370.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][16], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][16], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][16], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][16], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][16], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][16], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][16], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][16], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][16], 0);

    //// PICE:
    VehicleBuyMenu[playerid][17] = CreatePlayerTextDraw(playerid, 174.000000, 102.000000, "X,XXX,XXX");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][17], 1);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][17], 0.316666, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][17], 169.500000, 370.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][17], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][17], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][17], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][17], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][17], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][17], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][17], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][17], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][17], 0);

    VehicleBuyMenu[playerid][18] = CreatePlayerTextDraw(playerid, 284.000000, 102.000000, "X,XXX,XXX");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][18], 1);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][18], 0.316666, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][18], 169.500000, 370.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][18], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][18], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][18], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][18], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][18], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][18], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][18], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][18], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][18], 0);

    VehicleBuyMenu[playerid][19] = CreatePlayerTextDraw(playerid, 398.000000, 102.000000, "X,XXX,XXX");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][19], 1);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][19], 0.316666, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][19], 169.500000, 370.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][19], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][19], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][19], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][19], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][19], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][19], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][19], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][19], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][19], 0);

    VehicleBuyMenu[playerid][20] = CreatePlayerTextDraw(playerid, 174.000000, 225.000000, "X,XXX,XXX");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][20], 1);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][20], 0.316666, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][20], 169.500000, 370.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][20], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][20], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][20], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][20], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][20], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][20], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][20], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][20], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][20], 0);

    VehicleBuyMenu[playerid][21] = CreatePlayerTextDraw(playerid, 286.000000, 225.000000, "X,XXX,XXX");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][21], 1);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][21], 0.316666, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][21], 169.500000, 370.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][21], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][21], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][21], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][21], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][21], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][21], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][21], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][21], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][21], 0);

    VehicleBuyMenu[playerid][22] = CreatePlayerTextDraw(playerid, 397.000000, 225.000000, "X,XXX,XXX");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][22], 1);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][22], 0.316666, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][22], 169.500000, 370.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][22], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][22], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][22], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][22], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][22], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][22], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][22], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][22], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][22], 0);
    return 1;
}

stock ShowVehicleMenuStep2(playerid)
{
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][1], 579);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][0], 536);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][2], 402);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][3], 541);

    for(new i = 0; i < 4; i++)
    {
        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
    }

    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][8], "SUVs");
    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][9], "Lowriders");
    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][10], "Muscle");
    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][11], "Sport");

    PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][4]);
    PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][5]);
    PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][12]);
    PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][13]);
    return 1;
}

stock ShowVehicleMenuStep1(playerid)
{
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][1], 481);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][0], 602);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][2], 492);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][3], 402);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][4], 498);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][5], 482);

    for(new i = 0; i < 6; i++)
    {
        PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][i]);
        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
    }

    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][8], "Bikes");
    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][9], "Compact");
    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][10], "Luxury");
    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][11], "service");

    PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][12]);
    PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][13]);
    return 1;
}*/


new PlayerText:VehicleBuyMenu[MAX_PLAYERS][9];

enum V_VEHICLE_BUY
{
    V_STEP,
    V_COLOR[2],
    V_VEHSPAWN,
}
new PlayerbuyVeh[MAX_PLAYERS][V_VEHICLE_BUY];


enum VehiclePriceID
{
    V_Name[60],
    V_Model,
    V_Type,
    V_PRICE
}

new g_aDealershipData[][VehiclePriceID] =
{
    {"Bike",509, 1, 1200}, //0
    {"Faggio",462, 1, 10000}, //1
 //ไม่เอา   {"Pizzaboy",448, 1, 10000}, //2
    {"Freeway",463, 1, 50000}, //3
    {"Wayfarer",586, 1, 50000}, //4

    ///// 2 Door:
    {"Alpha",602, 2, 330000}, //5
    {"Blista",496, 2, 140000}, //6
    {"Bravura",401, 2, 40000}, //7
    {"Buccaneer",518, 2, 45000},//8
    {"Cadrona",527, 2, 45000},//9
    {"Club",589, 2, 160000},//10  
    {"Esperanto",419, 2, 50000},//11
    {"Euros",587, 2, 250000},//12
    {"Feltzer",533, 2, 65000},//13
    {"Fortune",526, 2, 55000},//14
    {"Hermes",474, 2, 60000},//15
    {"Hustler",545, 2, 85000},//16
    {"Majestic",517, 2, 65000},//17
    {"Manana",410, 2, 35000},//18
    {"Picador",600, 2, 38000},//19
    {"Previon",436, 2, 40000},//20
    {"Stallion",439, 2, 80000},//21
    {"Tampa",549, 2, 38000},//22
    {"Virgo",491, 2, 41000},//23
    ///// 2 Door:

    ///// 4 Door:
    {"Admiral",445, 3, 45000},//24
    {"Elegant",507, 3, 155000},//25
    {"Emperor",585, 3, 60000},//26
    {"Glendale",466, 3, 50000},//27
    {"Greenwood",492, 3,47000},//28
   // {"Intruder",546, 3,54600},//29
    {"Intruder",546, 3,46000},//30
    {"Merit",551, 3,150000},//31
    {"Nebula",516, 3,40000},//32
    {"Oceanic",467, 3,35000},//33
    {"Premier",426, 3,135000},//34
    {"Primo",547, 3,38000},//35
    {"Sentinel",405, 3,135000},//36
    {"Stafford",580, 3,200000},//37
    {"Stretch",409, 3,280000},//38
    {"Sunrise",550, 3,55000},//39
    {"Tahoma",566, 3,65000},//40
    {"Vincent",540, 3,51000},//41
    {"Washington",421, 3,100000},//42
    {"Willard",529, 3,45000},//43
    ///// 4 Door:

    ///// service:
    {"Bus",431, 4,70000},//44
    {"Cabbie",438, 4,50000},//45
    {"Coach",437, 4,75000},//46
    {"Taxi",420, 4,45000},//47
    {"Towtruck",525, 4,35000},//48
    ///// service:

    ///// Utility:
    {"Benson",499, 5,160000},//49
   //ซ้ำ {"Boxville,609, 5,89000},//50
    {"Boxville",498, 5,110000},//51
   //ซ้ำ {"Boxville",498, 5,89000},//52
    {"Hotdog",588, 5,80000},//53
    {"Linerunner",403, 5,750000},//54
    {"Mule",414, 5,175000},//55
    {"Roadtrain",515, 5,900000},//56
    {"Tanker",514, 5,800000},//57
   //ไม่เอา {"Tractor",431, 5,600000},//58
    {"Yankee",456, 5,250000},//59
  //ไม่เอา  {"Dune",573, 5,120000},//60
    ///// Utility:

    ///// Vans:
    {"Berkley's RC Van",459, 6,60000},//61
    {"Bobcat",422, 6,60000},//62
    {"Burrito",482, 6,120000},//63
    {"Moonbeam",418, 6,80000},//64
   //ไม่เอา {"News Van",582, 6,150000},//65
    {"Pony",582, 6,110000},//66
    {"Rumpo",440, 6,100000},//67
    {"Sadler",543, 6,25000},//68
    {"Walton",478, 6,40000},//69
    {"Yosemite",554, 6,110000},//70
    ///// Vans:

    ///// SUVs:
    {"Huntley",579, 7,300000},//71
    {"Landstalker",400, 7,180000},//72
    //ไม่เอา{"Perennial",404, 7,99000},//73
   //ซ้ำ {"Rancher",489, 7,99000},//74
    {"Rancher",505, 7,110000},//75
    {"Regina",479, 7,85000},//76
   //ไม่เอา {"Romero",442, 7,120000},//77
    {"Solair",458, 7,90000},//78
    ///// SUVs:

    ///// Lowriders:
    {"Blade",536, 8,65000},//79
    {"Broadway",575, 8,80000},//80
    {"Remington",534, 8,75000},//81
    {"Savanna",567, 8,85000},//82
    {"Slamvan",535, 8,110000},//83
    {"Tornado",576, 8,58000},//84
    {"Voodoo",412, 8,65000},//85
    ///// Lowriders:

    ///// Muscle cars:
    {"Buffalo",402, 9,420000},//86
    {"Clover",542, 9,135000},//87
    {"Phoenix",603, 9,650000},//88
    {"Sabre",475, 9,160000},//89

    ///// Street racers:
    {"Banshee",429, 10,850000},//90
    {"Bullet",541, 10,1200000},//91
    {"Cheetah",415, 10,8500000},//92
    {"Comet",480, 10,625000},//93
    {"Elegy",562, 10,220000},//94
    {"Flash",565, 10,180000},//95
  //ไม่เอา  {"Infernus",411, 10,460000},//96
    {"Jester",559, 10,200000},//97
    {"Stratum",561, 10,110000},//98
    {"Sultan",560, 10,785000},//99
    {"Uranus",558, 10,200000},//100

    {"FCR-900",521, 10,200000},//101
    {"PCJ-600",461, 10,200000},//102
    {"Sanchez",468, 10,200000}//103
    /////Street racers:
    
};

hook OnPlayerConnect(playerid)
{
    PlayerbuyVeh[playerid][V_STEP] = 0;
    PlayerbuyVeh[playerid][V_COLOR][0] = 0;
    PlayerbuyVeh[playerid][V_COLOR][1] = 0;
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    PlayerbuyVeh[playerid][V_STEP] = 0;
    PlayerbuyVeh[playerid][V_COLOR][0] = 0;
    PlayerbuyVeh[playerid][V_COLOR][1] = 0;
    for(new i = 0; i < 9; i++)
    {
        PlayerTextDrawDestroy(playerid, VehicleBuyMenu[playerid][i]);
    }

    DestroyVehicle(PlayerbuyVeh[playerid][V_VEHSPAWN]);
    PlayerbuyVeh[playerid][V_VEHSPAWN] = INVALID_VEHICLE_ID;
    return 1;
}

stock ShowVehicleMenu(playerid)
{
    LoadVehicleMenu(playerid);
    
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][6], g_aDealershipData[0][V_Model]);

    for(new i = 0; i < 9; i++)
    {
        PlayerTextDrawShow(playerid, VehicleBuyMenu[playerid][i]);
    }

    PlayerTextDrawHide(playerid, VehicleBuyMenu[playerid][6]);

    PlayerbuyVeh[playerid][V_VEHSPAWN] = CreateVehicle(g_aDealershipData[0][V_Model], 525.6993,-1287.3400,17.2422,281.1455, random(255), random(255), -1);
    SetPlayerVirtualWorld(playerid, playerid);
    SetVehicleVirtualWorld(PlayerbuyVeh[playerid][V_VEHSPAWN], playerid);
    
    new str[60];
    format(str, sizeof(str), "$%s", MoneyFormat(g_aDealershipData[0][V_PRICE]));
    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][7],str);
    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][2],g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_Name]);
    PlayerInfo[playerid][pGUI] = 2;
    SelectTextDraw(playerid, 0x33AA33FF);

    SetPlayerCameraLookAt(playerid, 525.6993,-1287.3400,17.2422, 3);
    SetPlayerCameraPos(playerid, 530.4976,-1278.6566,20.0702);
    SetPlayerPos(playerid, 535.6984,-1286.1117,17.2422);
    return 1;
}

hook OP_ClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(PlayerInfo[playerid][pGUI] == 2)
    {
        if(playertextid == VehicleBuyMenu[playerid][0])
        {
            if(!PlayerbuyVeh[playerid][V_STEP])
            {
                VehicleMenuClose(playerid);
                return 1;
            }

            PlayerbuyVeh[playerid][V_STEP]--;

            DestroyVehicle(PlayerbuyVeh[playerid][V_VEHSPAWN]);
            PlayerbuyVeh[playerid][V_VEHSPAWN] = CreateVehicle(g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_Model], 525.6993,-1287.3400,17.2422,281.1455, random(255), random(255), -1);
            SetPlayerVirtualWorld(playerid, playerid);
            SetVehicleVirtualWorld(PlayerbuyVeh[playerid][V_VEHSPAWN], playerid);

            new str[60];
            format(str, sizeof(str), "$%s", MoneyFormat(g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_PRICE]));
            PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][7],str);
            PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][2],g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_Name]);

            return 1;
        }
        if(playertextid == VehicleBuyMenu[playerid][1])
        {
            if(PlayerbuyVeh[playerid][V_STEP] == 91)
            {
                PlayerbuyVeh[playerid][V_STEP] = 0;
                SetVehicleModel(playerid);

                new str[60];
                format(str, sizeof(str), "$%s", MoneyFormat(g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_PRICE]));
                PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][7],str);
                PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][2],g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_Name]);
                return 1;
            }

            PlayerbuyVeh[playerid][V_STEP]++;
            SetVehicleModel(playerid);
            new str[60];
            format(str, sizeof(str), "$%s", MoneyFormat(g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_PRICE]));
            PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][7],str);
            PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][2],g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_Name]);
            return 1;
        }
        if(playertextid == VehicleBuyMenu[playerid][3])
        {
            Dialog_Show(playerid, DIALOG_VEH_COLOR1_V, DIALOG_STYLE_INPUT, "COLOR 1", "ใส่เลขสีที่คุณต้องการ","ยืนยัน", "ยกเลิก");
            return 1;
        }
        if(playertextid == VehicleBuyMenu[playerid][4])
        {
            Dialog_Show(playerid, DIALOG_VEH_COLOR2_V, DIALOG_STYLE_INPUT, "COLOR 2", "ใส่เลขสีที่คุณต้องการ","ยืนยัน", "ยกเลิก");
            return 1;
        }
        if(playertextid == VehicleBuyMenu[playerid][5])
        {
            if(PlayerInfo[playerid][pCash] < g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_PRICE])
            {

                SendErrorMessage(playerid,"คุณมีเงินไม่เพียงพอต่อการซื้อ ยังขาดอเงินอยู่ ($%s)",MoneyFormat(g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_PRICE] - PlayerInfo[playerid][pCash]));
                CancelSelectTextDraw(playerid);
                return 1;
            }

            if(g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_Type] == 10)
            {
                if(!PlayerInfo[playerid][pDonater])
                {   CancelSelectTextDraw(playerid);
                    SendErrorMessage(playerid, "คุณไม่ใช่ Donater");
                    return 1;
                }

                if(g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_Model] == 541)
                {
                    if(PlayerInfo[playerid][pDonater] < 3)
                    {
                        CancelSelectTextDraw(playerid);
                        SendErrorMessage(playerid, "คุณไม่ใช่ Donater ระดับ Platinum");
                        
                    }
                    return 1;
                }
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


            new modelid = g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_Model];
            new Price = g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_PRICE];

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
        if(playertextid == VehicleBuyMenu[playerid][8])
        {
            Dialog_Show(playerid, DIALOG_VEH_SEARCH, DIALOG_STYLE_INPUT, "INPUT VERHICLE MEDEL", "กรอก ไอดี ยานพาหนะที่ต้องการ", "ยืนยัน", "ยกเลิก");

            return 1;
        }
        return 1;
    }
    return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(PlayerInfo[playerid][pGUI] == 2)
    {
        if(clickedid == Text:INVALID_TEXT_DRAW)
        {
            VehicleMenuClose(playerid);
            return 1;
        }
        return 1;
    }
    return 1;
}

stock LoadVehicleMenu(playerid)
{
    VehicleBuyMenu[playerid][0] = CreatePlayerTextDraw(playerid, 96.000000, 216.000000, "ld_beat:left");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][0], 4);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][0], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][0], 51.500000, 51.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][0], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][0], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][0], 1);

    VehicleBuyMenu[playerid][1] = CreatePlayerTextDraw(playerid, 493.000000, 216.000000, "ld_beat:right");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][1], 4);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][1], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][1], 51.500000, 51.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][1], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][1], 1);

    VehicleBuyMenu[playerid][2] = CreatePlayerTextDraw(playerid, 247.000000, 299.000000, "Vehicle Name");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][2], 3);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][2], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][2], 418.000000, 128.000000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][2], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][2], 0);

    VehicleBuyMenu[playerid][3] = CreatePlayerTextDraw(playerid, 229.000000, 350.000000, "COLOR1");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][3], 2);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][3], 0.258332, 1.750000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][3], 16.500000, 90.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][3], 2);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][3], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][3], 200);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][3], 1);

    VehicleBuyMenu[playerid][4] = CreatePlayerTextDraw(playerid, 408.000000, 350.000000, "COLOR2");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][4], 2);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][4], 0.258332, 1.750000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][4], 16.500000, 90.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][4], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][4], 2);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][4], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][4], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][4], 200);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][4], 1);

    VehicleBuyMenu[playerid][5] = CreatePlayerTextDraw(playerid, 315.000000, 378.000000, "BUY NOW!");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][5], 2);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][5], 0.258332, 1.750000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][5], 16.500000, 90.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][5], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][5], 2);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][5], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][5], 200);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][5], 1);

    VehicleBuyMenu[playerid][6] = CreatePlayerTextDraw(playerid, 229.000000, 165.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][6], 5);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][6], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][6], 176.000000, 125.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][6], 0);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][6], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][6], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][6], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][6], 125);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][6], 255);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][6], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][6], 0);
    PlayerTextDrawSetPreviewModel(playerid, VehicleBuyMenu[playerid][6], 560);
    PlayerTextDrawSetPreviewRot(playerid, VehicleBuyMenu[playerid][6], -10.000000, 0.000000, -49.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, VehicleBuyMenu[playerid][6], 1, 1);

    VehicleBuyMenu[playerid][7] = CreatePlayerTextDraw(playerid, 250.000000, 320.000000, "$X,XXX,XXXX");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][7], 3);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][7], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][7], 418.000000, 128.000000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][7], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][7], 1);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][7], 9109759);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][7], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][7], 50);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][7], 0);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][7], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][7], 0);

    VehicleBuyMenu[playerid][8] = CreatePlayerTextDraw(playerid, 315.000000, 122.000000, "SEARCH");
    PlayerTextDrawFont(playerid, VehicleBuyMenu[playerid][8], 2);
    PlayerTextDrawLetterSize(playerid, VehicleBuyMenu[playerid][8], 0.258332, 1.750000);
    PlayerTextDrawTextSize(playerid, VehicleBuyMenu[playerid][8], 16.500000, 90.500000);
    PlayerTextDrawSetOutline(playerid, VehicleBuyMenu[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, VehicleBuyMenu[playerid][8], 0);
    PlayerTextDrawAlignment(playerid, VehicleBuyMenu[playerid][8], 2);
    PlayerTextDrawColor(playerid, VehicleBuyMenu[playerid][8], -1);
    PlayerTextDrawBackgroundColor(playerid, VehicleBuyMenu[playerid][8], 255);
    PlayerTextDrawBoxColor(playerid, VehicleBuyMenu[playerid][8], 200);
    PlayerTextDrawUseBox(playerid, VehicleBuyMenu[playerid][8], 1);
    PlayerTextDrawSetProportional(playerid, VehicleBuyMenu[playerid][8], 1);
    PlayerTextDrawSetSelectable(playerid, VehicleBuyMenu[playerid][8], 1);
    return 1;
}


Dialog:DIALOG_VEH_COLOR1_V(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new color1 = strval(inputtext);

    if(color1 > 255)
        return SendErrorMessage(playerid,"โปรดใส่สีให้ถุกต้อง");

    PlayerbuyVeh[playerid][V_COLOR][0] = color1;

    SetVehicleModel(playerid);
    return 1;
}

Dialog:DIALOG_VEH_COLOR2_V(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new color2 = strval(inputtext);

    if(color2 > 255)
        return SendErrorMessage(playerid,"โปรดใส่สีให้ถุกต้อง");

    PlayerbuyVeh[playerid][V_COLOR][1] = color2;

    SetVehicleModel(playerid);
    return 1;
}

Dialog:DIALOG_VEH_SEARCH(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new modelid = strval(inputtext);

	if(modelid < 400 || modelid > 611)
		return SendErrorMessage(playerid, "ไม่มีไอดีรถที่คุณต้องการ");

    for(new i = 0; i < 101; i++)
    {
        if(modelid == g_aDealershipData[i][V_Model])
        {
            PlayerbuyVeh[playerid][V_STEP] = i;
            break;
        }
    }

    new str[60];
    format(str, sizeof(str), "$%s", MoneyFormat(g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_PRICE]));
    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][7],str);
    PlayerTextDrawSetString(playerid, VehicleBuyMenu[playerid][2],g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_Name]);
    SetVehicleModel(playerid);
    return 1;
}

stock SetVehicleModel(playerid)
{
    DestroyVehicle(PlayerbuyVeh[playerid][V_VEHSPAWN]);
    PlayerbuyVeh[playerid][V_VEHSPAWN] = CreateVehicle(g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_Model], 525.6993,-1287.3400,17.2422,281.1455, PlayerbuyVeh[playerid][V_COLOR][0], PlayerbuyVeh[playerid][V_COLOR][1], -1);
    SetPlayerVirtualWorld(playerid, playerid+99);
    SetVehicleVirtualWorld(PlayerbuyVeh[playerid][V_VEHSPAWN], playerid+99);
    return 1;
}

forward OnPlayerVehiclePurchase(playerid, newid, plates[], Float:x, Float:y, Float:z, Float:a);
public OnPlayerVehiclePurchase(playerid, newid, plates[], Float:x, Float:y, Float:z, Float:a)
{
    new modelid = g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_Model];
    new color1 = PlayerbuyVeh[playerid][V_COLOR][0];
    new color2 = PlayerbuyVeh[playerid][V_COLOR][1];
    new Price = g_aDealershipData[PlayerbuyVeh[playerid][V_STEP]][V_PRICE];
    new id = PlayerOwnerDBID[playerid];

    new
		vehicleid = INVALID_VEHICLE_ID
	;

    vehicleid = 
		CreateVehicle(modelid, x, y, z, a, color1, color2, -1);

    SetVehicleNumberPlate(vehicleid, plates); 
	SetVehicleToRespawn(vehicleid); 

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
    Saveglobal();

    PlayerbuyVeh[playerid][V_COLOR][0] = 0;
    PlayerbuyVeh[playerid][V_COLOR][1] = 0;
    PlayerbuyVeh[playerid][V_STEP] = 0;

    SetVehicleHp(vehicleid);

    for(new i = 0; i < 8; i++)
    {
        PlayerTextDrawDestroy(playerid, VehicleBuyMenu[playerid][i]);
    }

    CancelSelectTextDraw(playerid);
    SetCameraBehindPlayer(playerid);
    PutPlayerInVehicle(playerid, vehicleid, 0);
    TogglePlayerControllable(playerid, 1);
    return 1;
}

stock VehicleMenuClose(playerid)
{
    new Float:x, Float:y, Float:z, Float:a;

    GetPlayerPos(playerid, x, y, z);

    GetPlayerFacingAngle(playerid, a);

	PlayerInfo[playerid][pGUI] = 0;

    for(new i = 0; i < 9; i++)
    {
        PlayerTextDrawDestroy(playerid, VehicleBuyMenu[playerid][i]);
    }

    DestroyVehicle(PlayerbuyVeh[playerid][V_VEHSPAWN]);
    PlayerbuyVeh[playerid][V_VEHSPAWN] = INVALID_VEHICLE_ID;

    PlayerbuyVeh[playerid][V_STEP] = 0;
    PlayerbuyVeh[playerid][V_COLOR][0] = 0;
    PlayerbuyVeh[playerid][V_COLOR][1] = 0;

    CancelSelectTextDraw(playerid);

    SetPlayerPos(playerid, x, y, z);
    SetPlayerFacingAngle(playerid, a);
    SetPlayerVirtualWorld(playerid, 0);
    SetCameraBehindPlayer(playerid);
    return 1;
}