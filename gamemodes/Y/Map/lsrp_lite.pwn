#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 4976, 1931.0000, -1871.3906, 15.8438, 0.25);
    RemoveBuildingForPlayer(playerid, 1308, 1946.4766, -1877.1094, 11.5391, 0.25);
    RemoveBuildingForPlayer(playerid, 4848, 1931.0000, -1871.3906, 15.8438, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 1931.8750, -1863.4609, 16.3203, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 1915.7422, -1863.4609, 16.3203, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 1957.3672, -1867.2891, 16.3203, 0.25);
    return 1;
}

hook OnGameModeExit()
{
    CreateDynamicObject(18241, 1929.50964, -1872.11731, 14.46115,   0.00000, 0.00000, -181.62004);
    CreateDynamicObject(1594, 1925.75806, -1865.14868, 14.88150,   0.00000, 0.00000, 0.00000);
    return 1;
}