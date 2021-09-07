

#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    CreateDynamicObject(19370, 682.23834, -445.77322, -26.72130,   0.04000, 90.18000, 0.00000);
    CreateDynamicObject(19370, 682.05579, -449.14877, -26.72130,   0.04000, 90.18000, 0.00000);

    CreateDynamicObject(19912, 493.43271, -1736.37854, 12.13180,   0.00000, 0.00000, -9.66000);
    CreateDynamicObject(19912, 1030.32129, -1029.33630, 32.67310,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19912, 2071.60889, -1837.61267, 14.18630,   0.00000, 0.00000, -90.00000);
    CreateDynamicObject(19912, 2392.60303, 1043.37488, 11.08500,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19912, 1968.83545, 2156.22046, 11.87510,   0.00000, 0.00000, -89.04000);
    CreateDynamicObject(19912, 719.97278, -462.54990, 9.98040,   0.00000, 90.00000, 0.00000);
    CreateDynamicObject(971, -99.93572, 1111.56482, 21.00910,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(971, -1420.66467, 2591.11230, 57.06510,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(971, -1904.68762, 277.67551, 43.03630,   0.00000, 0.00000, 0.00000);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 5422, 2071.4766, -1831.4219, 14.5625, 0.25);
    RemoveBuildingForPlayer(playerid, 5856, 1024.9844, -1029.3516, 33.1953, 0.25);
    RemoveBuildingForPlayer(playerid, 6400, 488.2813, -1734.6953, 12.3906, 0.25);
    RemoveBuildingForPlayer(playerid, 11319, -1904.5313, 277.8984, 42.9531, 0.25);
    RemoveBuildingForPlayer(playerid, 9093, 2386.6563, 1043.6016, 11.5938, 0.25);
    RemoveBuildingForPlayer(playerid, 7891, 1968.7422, 2162.4922, 12.0938, 0.25);
    RemoveBuildingForPlayer(playerid, 3294, -1420.5469, 2591.1563, 57.7422, 0.25);
    RemoveBuildingForPlayer(playerid, 3294, -100.0000, 1111.4141, 21.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 13028, 720.0156, -462.5234, 16.8594, 0.25);
    return 1;
}
