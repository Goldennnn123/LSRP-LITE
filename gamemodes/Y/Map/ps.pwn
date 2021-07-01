

#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    CreateDynamicObject(971, 2071.59180, -1831.14709, 13.00170,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(971, 489.17862, -1735.36230, 11.21730,   0.00000, 0.00000, -10.00000);
    CreateDynamicObject(971, 1042.41565, -1026.02466, 31.09630,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(971, 1025.54810, -1029.26270, 32.01040,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(971, 719.97028, -462.44781, 15.18000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(971, -99.85620, 1111.51343, 20.90430,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(971, -1412.54102, 2594.28296, 57.06500,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(971, 1968.44019, 2162.14526, 12.70990,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(971, -1936.07971, 238.44797, 36.16865,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(971, -1904.77368, 277.84430, 43.03630,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(971, -2716.30835, 218.18410, 3.80840,   0.00000, 0.00000, 90.00000);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 5422, 2071.4766, -1831.4219, 14.5625, 0.25);
    RemoveBuildingForPlayer(playerid, 5856, 1024.9844, -1029.3516, 33.1953, 0.25);
    RemoveBuildingForPlayer(playerid, 5779, 1041.3516, -1025.9297, 32.6719, 0.25);
    RemoveBuildingForPlayer(playerid, 6400, 488.2813, -1734.6953, 12.3906, 0.25);
    RemoveBuildingForPlayer(playerid, 10575, -2716.3516, 217.4766, 5.3828, 0.25);
    RemoveBuildingForPlayer(playerid, 11313, -1935.8594, 239.5313, 35.3516, 0.25);
    RemoveBuildingForPlayer(playerid, 11319, -1904.5313, 277.8984, 42.9531, 0.25);
    RemoveBuildingForPlayer(playerid, 7891, 1968.7422, 2162.4922, 12.0938, 0.25);
    RemoveBuildingForPlayer(playerid, 3294, -1420.5469, 2591.1563, 57.7422, 0.25);
    RemoveBuildingForPlayer(playerid, 3294, -100.0000, 1111.4141, 21.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 13028, 720.0156, -462.5234, 16.8594, 0.25);
    return 1;
}
