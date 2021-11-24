#include <YSI_Coding\y_hooks>

#define MODEL_SELECTION_SKIN_MENU (0)
#define MODEL_CUSTOM_SKIN_MENU (1)
#define MODEL_CLOTHING_MENU (2)
#define MODEL_VEHBUY_MENU   (3)


enum C_MODEL_ID
{
    cmodel_id,
    cmode_type,
    cmode_modelid,
    cmode_price
}
new ClothmenuID[][C_MODEL_ID] =
{
    {0,1,19423,2},
    {1,1,19424,2},
    {2,1,19421,2},
    {3,1,19422,2},
    {4,1,19418,2},
    {5,1,19352,2},
    {6,1,19348,2},
    {7,1,19317,20},
    {8,1,19318,20},
    {9,1,19319,20},
    {10,1,19039,10},
    {10,1,19040,10},
    {11,1,19041,10},
    {12,1,19042,10},
    {13,1,19043,10},
    {14,1,19044,10},
    {15,1,19045,10},
    {16,1,19046,10},
    {17,1,19047,10},
    {18,1,19048,10},
    {19,1,19049,10},
    {20,1,19050,10},
    {21,1,19051,10},
    {22,1,19052,10},
    {23,1,19053,10},
    {24,1,19064,5},
    {25,1,19163,5},
    {26,1,19036,5},
    {27,1,19037,5},
    {28,1,19038,5},
    {29,1,18912,5},
    {30,1,18913,5},
    {31,1,18634,5},
    {32,1,18635,6},
    {33,1,18639,3},
    {34,1,18644,2},
    {35,1,18645,5},
    {36,1,18641,5},
    {37,1,18894,5},
    {38,1,18895,5},
    {39,1,18896,5},
    {40,1,18897,5},
    {41,1,18898,3},
    {42,1,18899,5},
    {43,1,18900,5},
    {44,1,18901,5},
    {45,1,18902,5},
    {46,1,18903,3},
    {47,1,18904,3},
    {48,1,18905,3},
    {49,1,18906,5},
    {50,1,18907,5},
    {51,1,18908,4},
    {52,1,18909,3},
    {53,1,18910,4},
    {54,1,18911,4},
    {55,1,18912,4},
    {56,1,18913,4},
    {57,1,18921,3},
    {58,1,18922,2},
    {59,1,18923,2},
    {60,1,18924,5},
    {61,1,18925,4},
    {62,1,18926,5},
    {63,1,18927,4},
    {64,1,18928,5},
    {65,1,18929,5},
    {66,1,18930,5},
    {67,1,18931,5},
    {68,1,18932,4},
    {69,1,18933,4},
    {70,1,18934,4},
    {71,1,18935,5},
    {72,1,18936,5},
    {73,1,18937,4},
    {74,1,18938,5},
    {75,1,18939,4},
    {76,1,18940,5},
    {77,1,18941,5},
    {78,1,18942,5},
    {79,1,18943,5},
    {80,1,18944,5},
    {81,1,18945,5},
    {82,1,18946,5},
    {83,1,18947,5},
    {84,1,18948,5},
    {85,1,18949,5},
    {86,1,18950,5},
    {87,1,18951,5},
    {88,1,18952,5},
    {89,1,18953,5},
    {90,1,18954,5},
    {91,1,18955,5},
    {92,1,18956,3},
    {83,1,18957,3},
    {84,1,18958,6},
    {85,1,18959,5},
    {86,1,18960,5},
    {87,1,18961,5},
    {88,1,18962,6},
    {89,1,18964,4},
    {90,1,18965,5},
    {91,1,18966,5},
    {92,1,18967,5},
    {93,1,18968,5},
    {94,1,18969,5},
    {95,1,18970,5},
    {96,1,18971,5},
    {97,1,18972,5},
    {98,1,18973,5},
    {99,1,18974,5},
    {100,1,18975,5},
    {101,1,18976,5},
    {102,1,18977,5},
    {103,1,18978,5},
    {104,1,18979,5},
    {105,1,19006,5},
    {106,1,19007,5},
    {107,1,19008,5},
    {108,1,19009,5},
    {109,1,19010,5},
    {110,1,19011,5}
};

enum VehiclePriceIDs
{
    V_Name[60],
    V_Model,
    V_Type,
    V_PRICE
}

new g_aDealershipDatas[][VehiclePriceIDs] =
{
    {"Bike",509, 1, 1200}, //0
    {"Faggio",462, 1, 10000}, //1
 //ไม่เอา   {"Pizzaboy",448, 1, 10000}, //2
    {"Freeway",463, 1, 50000}, //3
    {"Wayfarer",586, 1, 50000}, //4

    {"BMX",481, 10,2300},//104

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
    {"Cheetah",415, 10,850000},//92
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


CMD:customskin(playerid, params[])
{
    if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");

    ShowCustomskin(playerid);
    return 1;
}

CMD:showskin(playerid, params[])
{
    if(!PlayerInfo[playerid][pAdmin])
        return SendUnauthMessage(playerid);
        
    ShowSkinModelMenu(playerid);
    return 1;
}

stock ShowClothmenu(playerid)
{
    new List:model = list_new();


    for(new i = 0; i < sizeof ClothmenuID; i++)
	{
		if(ClothmenuID[i][cmode_type] == 2)
			continue;
			
		 AddModelMenuItem(model, ClothmenuID[i][cmode_modelid]);
	}

    ShowModelSelectionMenu(playerid, "CLOTHMENU", MODEL_CLOTHING_MENU, model);
    return 1;
}

stock ShowCustomskin(playerid)
{
    new List:skins = list_new();

    new factionid = PlayerInfo[playerid][pFaction];

    for(new i = 1; i < 31; i++)
	{
		if(!CustomskinFacInfo[factionid][FactionSkin][i])
			continue;
			
		 AddModelMenuItem(skins, CustomskinFacInfo[factionid][FactionSkin][i]);
	}

    ShowModelSelectionMenu(playerid, "Skins", MODEL_CUSTOM_SKIN_MENU, skins);
    return 1;
}

stock ShowSkinModelMenu(playerid)
{
    new List:skins = list_new();

    if(IsPlayerAndroid(playerid) == false)
    {
        for(new i = 1; i < 301; i++)
            AddModelMenuItem(skins, i);

        for(new i = 29000; i < 29081; i++)
            AddModelMenuItem(skins, i);
    }
    else
    {
        for(new i = 1; i < 301; i++)
            AddModelMenuItem(skins, i);
    }

    ShowModelSelectionMenu(playerid, "Skins", MODEL_SELECTION_SKIN_MENU, skins);
}

stock ShowModelVehicleBuy(playerid)
{
    new List:model = list_new();
    new str[120];


    for(new i = 0; i < sizeof g_aDealershipDatas; i++)
	{
		if(g_aDealershipDatas[i][V_Type] == 10)
			continue;
		
        format(str, sizeof(str), "$%s",MoneyFormat(g_aDealershipDatas[i][V_PRICE]));

		AddModelMenuItem(model, g_aDealershipDatas[i][V_Model], str, true,-19.000000, 0.000000, -62.000000);
	}

    ShowModelSelectionMenu(playerid, "VEHICLE BUY", MODEL_VEHBUY_MENU, model);
    return 1;
}



public OnModelSelectionResponse(playerid, extraid, index, modelid, response)
{
    if(extraid == MODEL_SELECTION_SKIN_MENU)
    {
        if(response == MODEL_RESPONSE_SELECT)
        {
            SetPlayerSkin(playerid, modelid);
            PlayerInfo[playerid][pLastSkin] = modelid;
            return 1;
        }
    }
    else if(extraid == MODEL_CUSTOM_SKIN_MENU)
    {
        if(response == MODEL_RESPONSE_SELECT)
        {
            SetPlayerSkin(playerid, modelid);
            PlayerInfo[playerid][pLastSkin] = modelid;
            return 1;
        }
    }
    else if(extraid == MODEL_CLOTHING_MENU)
    {
        if(response == MODEL_RESPONSE_SELECT)
        {
            SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้เลือก Object %d", modelid);
            PlayerSeCloBuy[playerid] = modelid;
            Dialog_Show(playerid, D_CONFIRM_BUY_CLOTHING, DIALOG_STYLE_MSGBOX, "แน่ใจ?", "คุณยืนยันที่ต้องการจะเลือกสินค้าชิ้นนี้?", "ยืนยัน", "ยกเลิก");
            return 1;
        }
    }
    else if(extraid == MODEL_VEHBUY_MENU)
    {
        if(response == MODEL_RESPONSE_SELECT)
        {
            new veh_id;

            for(new i = 0; i < sizeof g_aDealershipDatas; i++)
            {
                if(modelid == g_aDealershipDatas[i][V_Model])
                {
                    if(g_aDealershipDatas[veh_id][V_Type] == 10)
                    {
                        if(!PlayerInfo[playerid][pDonater])
                            return SendErrorMessage(playerid, "คุณไม่ใช่ Donator");
                    }

                    veh_id = i;
                }
            }
            
            ShowVehiclePreview(playerid, g_aDealershipDatas[veh_id][V_Model], g_aDealershipDatas[veh_id][V_PRICE]);
            return 1;
        }
    }
    return 1;
}


Dialog:D_CONFIRM_BUY_CLOTHING(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        PlayerSeCloBuy[playerid] = 0;
    }
    else
    {
        new id = PlayerSeCloBuy[playerid];
        SetPlayerAttachedObject(playerid, 6, id, 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0,1.0,1.0);
        EditAttachedObject(playerid, 6);
    }
    return 1;
}