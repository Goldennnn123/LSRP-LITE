#include <YSI_Coding\y_hooks>


new dmv_vehicles[4];

hook OnGameModeInit()
{
    dmv_vehicles[0] = AddStaticVehicle(405,1270.5680,-1557.5950,13.4384,270.6683,1,1); SetVehicleNumberPlate(dmv_vehicles[0], "DMV");
    dmv_vehicles[1] = AddStaticVehicle(405,1270.4249,-1554.2535,13.4394,269.7206,1,1); SetVehicleNumberPlate(dmv_vehicles[1], "DMV");
    dmv_vehicles[2] = AddStaticVehicle(405,1270.3258,-1551.0619,13.4829,271.6855,1,1); SetVehicleNumberPlate(dmv_vehicles[2], "DMV");
    dmv_vehicles[3] = AddStaticVehicle(405,1270.4993,-1547.6730,13.4389,270.6118,1,1); SetVehicleNumberPlate(dmv_vehicles[3], "DMV");
    return 1;
}

