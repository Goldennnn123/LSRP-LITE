
#include <YSI_Coding\y_hooks>


hook OnGameModeInit()
{
    CreateDynamicObject(6134, 2150.220458, -2176.023681, 16.688199, 0.000000, 0.000000, 44.339950, -1, -1, -1, 9999.00, 9999.00); 
    CreateDynamicObject(19870, 2220.538085, -2209.208740, 14.326881, 0.000000, 0.000000, 47.500003, -1, -1, -1, 9999.00, 9999.00); 
    CreateDynamicObject(19870, 2217.403076, -2212.629394, 14.326881, 0.000000, 0.000000, 47.500003, -1, -1, -1, 9999.00, 9999.00); 
    CreateDynamicObject(19870, 2214.275634, -2216.042480, 14.326881, 0.000000, 0.000000, 47.500003, -1, -1, -1, 9999.00, 9999.00); 
    CreateDynamicObject(19870, 2211.140869, -2219.463867, 14.326881, 0.000000, 0.000000, 47.500003, -1, -1, -1, 9999.00, 9999.00); 
    CreateDynamicObject(19870, 2208.013183, -2222.877929, 14.326881, 0.000000, 0.000000, 47.500003, -1, -1, -1, 9999.00, 9999.00); 
    CreateDynamicObject(19870, 2204.885498, -2226.291503, 14.326881, 0.000000, 0.000000, 47.500003, -1, -1, -1, 9999.00, 9999.00); 
    CreateDynamicObject(19870, 2201.744873, -2229.720214, 14.326881, 0.000000, 0.000000, 47.500003, -1, -1, -1, 9999.00, 9999.00); 
    CreateDynamicObject(19870, 2194.494628, -2223.969970, 14.326881, 0.000000, 0.000000, -38.499942, -1, -1, -1, 9999.00, 9999.00); 
    CreateDynamicObject(19870, 2190.864013, -2221.085205, 14.326881, 0.000000, 0.000000, -38.499942, -1, -1, -1, 9999.00, 9999.00); 
    CreateDynamicObject(19870, 2187.240478, -2218.203369, 14.326881, 0.000000, 0.000000, -38.499942, -1, -1, -1, 9999.00, 9999.00); 
    CreateDynamicObject(19870, 2183.609375, -2215.317626, 14.326881, 0.000000, 0.000000, -38.499942, -1, -1, -1, 9999.00, 9999.00); 
    CreateDynamicObject(19870, 2179.977539, -2212.428466, 14.326881, 0.000000, 0.000000, -38.499942, -1, -1, -1, 9999.00, 9999.00); 
    CreateDynamicObject(19870, 2176.354492, -2209.549316, 14.326881, 0.000000, 0.000000, -38.499942, -1, -1, -1, 9999.00, 9999.00); 
    CreateDynamicObject(19870, 2172.714599, -2206.653320, 14.326881, 0.000000, 0.000000, -38.499942, -1, -1, -1, 9999.00, 9999.00); 
    return 1;
}


hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 3687, 2135.742, -2186.445, 15.671, 0.250);
    RemoveBuildingForPlayer(playerid, 3687, 2162.851, -2159.750, 15.671, 0.250);
    RemoveBuildingForPlayer(playerid, 3686, 2195.085, -2216.843, 15.906, 0.250);
    RemoveBuildingForPlayer(playerid, 3686, 2220.781, -2261.054, 15.906, 0.250);
    RemoveBuildingForPlayer(playerid, 3687, 2150.195, -2172.359, 15.671, 0.250);
    RemoveBuildingForPlayer(playerid, 3744, 2193.257, -2286.289, 14.812, 0.250);
    RemoveBuildingForPlayer(playerid, 3744, 2183.171, -2237.273, 14.812, 0.250);
    RemoveBuildingForPlayer(playerid, 3744, 2174.640, -2215.656, 15.101, 0.250);
    RemoveBuildingForPlayer(playerid, 3744, 2193.062, -2196.640, 15.101, 0.250);
    RemoveBuildingForPlayer(playerid, 3744, 2101.789, -2162.578, 15.132, 0.250);
    RemoveBuildingForPlayer(playerid, 5305, 2198.851, -2213.921, 14.882, 0.250);
    RemoveBuildingForPlayer(playerid, 3747, 2234.390, -2244.828, 14.937, 0.250);
    RemoveBuildingForPlayer(playerid, 3747, 2226.968, -2252.140, 14.937, 0.250);
    RemoveBuildingForPlayer(playerid, 3747, 2219.421, -2259.523, 14.882, 0.250);
    RemoveBuildingForPlayer(playerid, 3747, 2212.093, -2267.070, 14.937, 0.250);
    RemoveBuildingForPlayer(playerid, 3747, 2204.632, -2274.414, 14.937, 0.250);
    RemoveBuildingForPlayer(playerid, 1531, 2173.593, -2165.187, 15.304, 0.250);
    RemoveBuildingForPlayer(playerid, 3574, 2193.257, -2286.289, 14.812, 0.250);
    RemoveBuildingForPlayer(playerid, 3569, 2204.632, -2274.414, 14.937, 0.250);
    RemoveBuildingForPlayer(playerid, 3569, 2212.093, -2267.070, 14.937, 0.250);
    RemoveBuildingForPlayer(playerid, 3627, 2220.781, -2261.054, 15.906, 0.250);
    RemoveBuildingForPlayer(playerid, 3569, 2219.421, -2259.523, 14.882, 0.250);
    RemoveBuildingForPlayer(playerid, 3578, 2194.476, -2242.875, 13.257, 0.250);
    RemoveBuildingForPlayer(playerid, 3569, 2226.968, -2252.140, 14.937, 0.250);
    RemoveBuildingForPlayer(playerid, 3569, 2234.390, -2244.828, 14.937, 0.250);
    RemoveBuildingForPlayer(playerid, 3574, 2183.171, -2237.273, 14.812, 0.250);
    RemoveBuildingForPlayer(playerid, 3574, 2174.640, -2215.656, 15.101, 0.250);
    RemoveBuildingForPlayer(playerid, 3627, 2195.085, -2216.843, 15.906, 0.250);
    RemoveBuildingForPlayer(playerid, 5244, 2198.851, -2213.921, 14.882, 0.250);
    RemoveBuildingForPlayer(playerid, 3574, 2193.062, -2196.640, 15.101, 0.250);
    RemoveBuildingForPlayer(playerid, 3622, 2135.742, -2186.445, 15.671, 0.250);
    RemoveBuildingForPlayer(playerid, 1226, 2215.804, -2199.218, 16.312, 0.250);
    RemoveBuildingForPlayer(playerid, 1226, 2207.875, -2191.250, 16.312, 0.250);
    RemoveBuildingForPlayer(playerid, 1226, 2223.742, -2207.187, 16.312, 0.250);
    RemoveBuildingForPlayer(playerid, 3622, 2150.195, -2172.359, 15.671, 0.250);
    RemoveBuildingForPlayer(playerid, 3574, 2101.796, -2162.562, 15.070, 0.250);
    RemoveBuildingForPlayer(playerid, 3567, 2083.523, -2159.617, 13.257, 0.250);
    RemoveBuildingForPlayer(playerid, 3622, 2162.851, -2159.750, 15.671, 0.250);
    return 1;
}