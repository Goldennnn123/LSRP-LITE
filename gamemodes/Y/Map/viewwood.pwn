
#include <YSI_Coding\y_hooks>


hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 5842, 1292.070, -1122.023, 37.406, 0.250);
    RemoveBuildingForPlayer(playerid, 727, 1319.687, -1112.906, 22.257, 0.250);
    RemoveBuildingForPlayer(playerid, 727, 1327.976, -1124.343, 21.968, 0.250);
    RemoveBuildingForPlayer(playerid, 717, 1322.273, -1134.234, 23.000, 0.250);
    RemoveBuildingForPlayer(playerid, 5738, 1292.070, -1122.023, 37.406, 0.250);



    //////
    RemoveBuildingForPlayer(playerid, 5842, 1292.070, -1122.023, 37.406, 0.250);
    RemoveBuildingForPlayer(playerid, 727, 1319.687, -1112.906, 22.257, 0.250);
    RemoveBuildingForPlayer(playerid, 727, 1327.976, -1124.343, 21.968, 0.250);
    RemoveBuildingForPlayer(playerid, 717, 1322.273, -1134.234, 23.000, 0.250);
    RemoveBuildingForPlayer(playerid, 5738, 1292.070, -1122.023, 37.406, 0.250);
    return 1;
}

hook OnGameModeInit()
{
    //Map Exported with Texture Studio By: [uL]Pottus////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////and Crayder////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //Map Information////////////////////////////////////////////////////////////////////////////////////////////////
    /*
        Exported on "2020-04-18 16:12:27" by "BearRoleplay"
        Created by "BearRoleplay"
        Spawn Position: 1296.605468, -1118.986572, 23.912729
    */
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //Remove Buildings/////////////////////////////////////////////////////////////////////////////////////////////

    //Objects////////////////////////////////////////////////////////////////////////////////////////////////////////
    new tmpobjid;
    tmpobjid = CreateDynamicObject(4018, 1305.772338, -1121.241333, 22.819660, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 2, 10755, "airportrminl_sfse", "ws_airportwin2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 16639, "a51_labs", "studiowall4_law", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 10755, "airportrminl_sfse", "ws_airportwin2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 10755, "airportrminl_sfse", "ws_airportwin2", 0x00000000);
    tmpobjid = CreateDynamicObject(11714, 1297.369995, -1124.594848, 24.074729, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10763, "airport1_sfse", "ws_airportdoors1", 0x00000000);
    tmpobjid = CreateDynamicObject(11714, 1298.848999, -1124.612182, 24.074699, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10763, "airport1_sfse", "ws_airportdoors1", 0x00000000);
    tmpobjid = CreateDynamicObject(11714, 1295.874023, -1124.588012, 24.074699, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10763, "airport1_sfse", "ws_airportdoors1", 0x00000000);
    tmpobjid = CreateDynamicObject(19550, 1331.886108, -1061.861694, 22.912729, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6282, "beafron2_law2", "boardwalk2_la", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1296.917968, -1123.157836, 24.587390, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(11714, 1297.350585, -1123.074218, 24.074729, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10763, "airport1_sfse", "ws_airportdoors1", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1299.283447, -1118.252319, 24.604610, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1298.088623, -1117.703613, 22.276960, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19353, 1293.355346, -1116.172485, 24.601619, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19353, 1293.341796, -1121.513061, 24.596639, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1278.772094, -1117.734375, 23.552736, 0.000000, 0.000000, -90.000007, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1298.088623, -1117.692626, 27.409057, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1282.371704, -1123.144897, 24.592733, 0.000000, 0.000000, -90.000007, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1294.499511, -1112.337524, 24.587390, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1299.287353, -1108.646118, 24.604610, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1284.873535, -1112.327514, 24.587390, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1289.302612, -1113.020874, 24.604610, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1287.292602, -1123.149780, 22.739990, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1287.292602, -1123.149780, 27.628900, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19383, 1293.357543, -1118.556396, 24.592350, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1277.651855, -1123.147705, 22.739990, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1277.698730, -1123.151733, 27.638902, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1272.933471, -1118.334960, 22.739999, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1272.971923, -1118.356079, 27.638900, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1277.328491, -1112.325317, 24.587390, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1272.966674, -1108.751464, 27.638900, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1272.940429, -1108.732788, 22.739999, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19353, 1287.673339, -1117.750244, 24.601600, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19383, 1293.357543, -1113.836181, 24.592350, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19353, 1282.433471, -1117.740234, 24.601600, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1282.805419, -1113.006347, 24.604610, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19383, 1284.783569, -1117.744995, 24.602350, 0.000000, 0.000000, 90.100006, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1278.060668, -1112.998535, 23.541139, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4c", 0x00000000);
    tmpobjid = CreateDynamicObject(19550, 1335.156250, -1060.770629, 26.311939, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19483, 1299.186279, -1119.366821, 25.502738, 0.000000, 0.000000, -179.899948, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "{000000}COMMUNITY EVENTS", 120, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19483, 1299.190307, -1121.406250, 25.502738, 0.000000, 0.000000, -179.899948, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "{000000}CRIME STATISTICS", 120, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19482, 1296.328369, -1117.819091, 23.782745, 0.000000, 0.000000, -90.000022, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "{000000}VINEWOOD", 90, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19482, 1296.328369, -1117.819091, 23.442745, 0.000000, 0.000000, -90.000022, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "{000000}COMMUNITY POLICE STATION", 130, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19445, 1296.917968, -1123.147827, 21.417385, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1287.297363, -1123.147827, 21.417385, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1277.796264, -1123.137817, 21.417385, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1282.606445, -1123.137817, 21.417385, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1272.947631, -1118.265380, 21.417385, 0.000000, 0.000000, 0.000008, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1272.947631, -1108.745605, 21.417385, 0.000000, 0.000000, 0.000008, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1278.068359, -1113.005859, 21.417385, 0.000000, 0.000000, 0.000008, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1278.038330, -1113.005859, 21.417385, 0.000000, 0.000000, 0.000008, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1282.798583, -1113.005859, 21.417385, 0.000000, 0.000000, 0.000008, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1277.797241, -1112.346313, 21.417385, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1287.428955, -1112.346313, 21.417385, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1297.009033, -1112.346313, 21.417385, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1299.279174, -1118.285034, 21.417385, 0.000000, 0.000000, 0.000008, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1299.279174, -1108.685668, 21.417385, 0.000000, 0.000000, 0.000008, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1298.088989, -1117.706420, 21.417385, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1278.771728, -1117.764404, 21.412723, 0.000000, 0.000000, -90.000007, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19353, 1282.423461, -1117.760253, 21.411615, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19353, 1282.423461, -1117.720214, 21.411615, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1278.782104, -1117.724365, 21.412723, 0.000000, 0.000000, -90.000007, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1282.808593, -1113.005859, 21.417385, 0.000000, 0.000000, 0.000008, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1289.278808, -1113.005859, 21.417385, 0.000000, 0.000000, 0.000008, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1289.308837, -1113.005859, 21.417385, 0.000000, 0.000000, 0.000008, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19353, 1287.114257, -1117.760253, 21.391572, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19353, 1287.114257, -1117.740234, 21.391572, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19353, 1287.624755, -1117.740234, 21.391572, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19353, 1287.794921, -1117.770263, 21.391572, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19383, 1293.347534, -1111.465087, 21.412336, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19383, 1293.367553, -1111.465087, 21.412336, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19383, 1293.367553, -1116.175781, 21.412336, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19383, 1293.347534, -1116.185791, 21.412336, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19383, 1293.327514, -1121.466796, 21.412336, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19383, 1293.327514, -1120.886352, 21.412336, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19383, 1293.377563, -1120.886352, 21.412336, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19383, 1293.377563, -1121.466918, 21.412336, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1298.088989, -1117.676391, 21.417385, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18787, "matramps", "redrailing", 0x00000000);
    tmpobjid = CreateDynamicObject(2641, 1293.208496, -1116.244628, 24.487823, 0.000000, -90.199989, -90.299995, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 8035, "vgsshospshop", "hosp_sign01b", 0x00000000);
    tmpobjid = CreateDynamicObject(19483, 1291.459350, -1112.460449, 25.682735, 0.000000, 0.000000, -89.699958, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "{000000}CELLS ROOM", 120, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19483, 1291.459350, -1112.460449, 25.512731, 0.000000, 0.000000, -89.699958, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "{000000}GARAGE", 120, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19483, 1284.781494, -1117.838745, 25.507642, 0.000000, 0.000000, -89.900001, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "{000000}WATCH COMMANDER", 120, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19786, 1274.267089, -1112.287353, 25.382741, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 19165, "gtamap", "gtasamapbit4", 0x00000000);
    tmpobjid = CreateDynamicObject(19483, 1276.726928, -1112.415039, 25.512733, 0.000000, 0.000000, -89.999954, 10001,1,-1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "{000000}UPPER LEVELS", 120, "Ariel", 20, 1, 0x00000000, 0x00000000, 1);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(18981, 1300.475952, -1136.292968, 22.127899, 1.000000, 90.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18981, 1281.574829, -1135.066406, 22.127899, 1.200000, 90.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(5726, 1319.339111, -1117.578369, 22.824800, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1689, 1323.842407, -1121.515747, 28.463069, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1688, 1317.995361, -1118.273193, 28.639459, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(5340, 1320.035400, -1130.796264, 24.189500, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(727, 1329.788940, -1108.795776, 21.968750, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1311.120849, -1125.042358, 23.433599, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1308.458496, -1125.037841, 23.433599, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1305.802612, -1125.042358, 23.433599, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19445, 1311.352905, -1125.418457, 21.070369, 1.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19445, 1308.233520, -1125.300781, 21.070369, 1.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19445, 1305.333618, -1125.246948, 21.070369, 1.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1303.126098, -1125.048339, 23.433599, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19445, 1302.371459, -1125.277832, 21.070369, 1.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1283.737060, -1124.911621, 23.433599, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1273.932495, -1125.223022, 23.433599, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1286.315307, -1124.917968, 23.433599, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1288.955566, -1124.926757, 23.433599, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1291.632080, -1124.908203, 23.433599, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(717, 1329.534912, -1128.730712, 23.000000, 356.858398, 0.000000, 3.141590, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(717, 1330.015136, -1122.605834, 23.000000, 356.858398, 0.000000, 3.141590, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(717, 1330.388427, -1116.807861, 23.000000, 356.858398, 0.000000, 3.141590, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19325, 1296.625122, -1117.690917, 26.781316, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19325, 1288.971923, -1123.201049, 25.557100, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19325, 1282.342773, -1123.201660, 25.557100, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19325, 1276.170288, -1123.205688, 25.557100, 0.000000, 0.000000, 90.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19325, 1272.830688, -1119.943115, 25.557100, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19325, 1272.847290, -1113.342041, 25.557100, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2611, 1299.143798, -1119.390869, 24.782732, 0.000000, 0.000000, -89.900001, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2611, 1299.147705, -1121.449951, 24.782732, 0.000000, 0.000000, -89.900001, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19173, 1293.441650, -1121.172973, 24.872735, 0.000000, 0.000000, 90.000007, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1815, 1293.582153, -1122.924072, 22.892728, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1721, 1293.735473, -1121.110473, 22.912729, 0.000000, 0.000000, -89.800003, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1721, 1293.682617, -1120.290527, 22.912729, 0.000000, 0.000000, -89.800003, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1893, 1295.904418, -1120.523681, 26.321096, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2611, 1293.208496, -1121.062011, 24.782732, 0.000000, 0.000000, -89.900001, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1893, 1287.944824, -1120.743896, 26.321096, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1537, 1292.266967, -1112.455932, 22.888708, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1893, 1283.495117, -1120.743896, 26.321096, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1893, 1278.314208, -1120.743896, 26.321096, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1721, 1288.885620, -1118.054443, 22.912729, 0.000000, 0.000000, 179.600067, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1721, 1288.115234, -1118.048828, 22.912729, 0.000000, 0.000000, 179.600067, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1721, 1287.305175, -1118.043457, 22.912729, 0.000000, 0.000000, 179.600067, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(948, 1286.155029, -1118.164306, 22.891651, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1808, 1283.607299, -1118.056030, 22.886682, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2008, 1287.083496, -1114.130004, 22.854110, 0.000000, 0.000000, 88.999954, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1806, 1288.416503, -1113.556152, 22.902347, 0.000000, 0.000000, 90.500007, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2309, 1285.408691, -1113.144653, 22.899768, 0.000000, 0.000000, -88.599975, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2309, 1285.431884, -1114.093750, 22.899768, 0.000000, 0.000000, -88.599975, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2161, 1282.936401, -1116.828735, 22.909820, 0.000000, 0.000000, 90.200004, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2199, 1282.958496, -1115.402221, 22.910240, 0.000000, 0.000000, 90.799949, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2161, 1282.926391, -1113.938720, 22.909820, 0.000000, 0.000000, 90.200004, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2007, 1288.669067, -1115.739501, 22.865451, 0.000000, 0.000000, -89.499938, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2007, 1288.678222, -1116.819213, 22.865451, 0.000000, 0.000000, -89.499938, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2202, 1279.313964, -1122.535400, 22.901239, 0.000000, 0.000000, -179.900009, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2202, 1281.254272, -1122.532226, 22.901239, 0.000000, 0.000000, -179.900009, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2165, 1277.099487, -1121.490112, 22.883426, 0.000000, 0.000000, -89.999992, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2165, 1273.489746, -1122.535888, 22.883426, 0.000000, 0.000000, 89.199943, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2165, 1274.567626, -1120.501098, 22.883426, 0.000000, 0.000000, -179.899887, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2165, 1273.525512, -1117.297119, 22.883426, 0.000000, 0.000000, -0.199899, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2165, 1275.478759, -1118.302490, 22.883426, 0.000000, 0.000000, 89.799934, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2165, 1273.540771, -1112.966186, 22.883426, 0.000000, 0.000000, -0.199899, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1806, 1274.071044, -1114.034912, 22.915027, 0.000000, 0.000000, -54.899997, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1806, 1273.867431, -1118.594238, 22.915027, 0.000000, 0.000000, -28.399990, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1806, 1276.614013, -1117.922363, 22.915027, 0.000000, 0.000000, 67.899978, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1806, 1276.011230, -1122.040771, 22.915027, 0.000000, 0.000000, -90.200027, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1806, 1274.643188, -1122.165161, 22.915027, 0.000000, 0.000000, 56.999954, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1806, 1273.321655, -1119.786987, 22.915027, 0.000000, 0.000000, -105.100044, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1538, 1275.987915, -1112.461669, 22.882728, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1893, 1276.133789, -1115.453979, 26.321096, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(14720, 1279.579956, -1112.848144, 22.892728, 0.000000, 0.000000, -89.899971, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2764, 1282.160644, -1115.342773, 23.316230, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2079, 1282.321411, -1116.605834, 23.551364, 0.000000, 0.000000, -87.600006, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2079, 1282.225952, -1114.047119, 23.551364, 0.000000, 0.000000, 90.699897, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2165, 1294.920532, -1117.093139, 22.883426, 0.000000, 0.000000, -179.899887, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2165, 1298.641479, -1117.087158, 22.883426, 0.000000, 0.000000, -179.899887, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1808, 1293.827514, -1112.645874, 22.886682, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2162, 1295.493896, -1112.433105, 22.881656, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2202, 1297.482543, -1112.944458, 22.885969, 0.000000, 0.000000, 0.000000, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1806, 1298.270263, -1115.923217, 22.915027, 0.000000, 0.000000, 164.399978, 10001,1,-1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1806, 1294.350219, -1115.754272, 22.915027, 0.000000, 0.000000, 175.799972, 10001,1,-1, 300.00, 300.00); 





    //Map Exported with Texture Studio By: [uL]Pottus////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////and Crayder////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //Map Information////////////////////////////////////////////////////////////////////////////////////////////////
    /*
        Exported on "2020-04-18 14:08:24" by "BearRoleplay"
        Created by "BearRoleplay"
        Spawn Position: 1299.979614, -1136.778442, 23.656250
    */
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //Remove Buildings///////////////////////////////////////////////////////////////////////////////////////////////
    //Objects////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(4018, 1305.772338, -1121.241333, 22.819660, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10755, "airportrminl_sfse", "ws_airportwin2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 16639, "a51_labs", "studiowall4_law", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 10755, "airportrminl_sfse", "ws_airportwin2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 10755, "airportrminl_sfse", "ws_airportwin2", 0x00000000);
    tmpobjid = CreateDynamicObject(5726, 1319.339111, -1117.578369, 22.824800, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(5340, 1320.035400, -1130.796264, 24.189500, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "sw_sheddoor2", 0x00000000);
    tmpobjid = CreateDynamicObject(11714, 1297.369995, -1124.594848, 24.074729, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10763, "airport1_sfse", "ws_airportdoors1", 0x00000000);
    tmpobjid = CreateDynamicObject(19480, 1292.022216, -1125.421508, 30.409626, 0.000000, 0.000000, -90.000007, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "{000000}LOS SANTOS POLICE DEPARTMENT", 110, "Ariel", 18, 1, 0x00000000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19480, 1292.022216, -1125.421508, 28.859617, 0.000000, 0.000000, -90.000007, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "{000000}VINEWOOD STATION", 110, "Ariel", 18, 1, 0x00000000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19480, 1311.032958, -1125.421508, 36.399612, 0.000000, 0.000000, -90.000007, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "{000000}2526", 80, "Ariel", 18, 1, 0x00000000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19480, 1320.022705, -1130.831542, 26.149610, 0.000000, 0.000000, -90.000007, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "{000000}AUTHORIZED VEHICLES ONLY", 120, "Ariel", 14, 1, 0x00000000, 0x00000000, 1);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(18981, 1300.475952, -1136.292968, 22.127899, 1.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18981, 1281.574829, -1135.066406, 22.127899, 1.200000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1689, 1323.842407, -1121.515747, 28.463069, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1688, 1317.995361, -1118.273193, 28.639459, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(727, 1329.788940, -1108.795776, 21.968750, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1311.120849, -1125.042358, 23.433599, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1308.458496, -1125.037841, 23.433599, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1305.802612, -1125.042358, 23.433599, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19445, 1311.352905, -1125.418457, 21.070369, 1.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19445, 1307.833007, -1125.300781, 21.070369, 1.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19445, 1304.183959, -1125.246948, 21.070369, 1.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1303.126098, -1125.048339, 23.433599, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1283.737060, -1124.911621, 23.433599, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1273.932495, -1125.223022, 23.433599, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1286.315307, -1124.917968, 23.433599, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1288.955566, -1124.926757, 23.433599, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 1291.632080, -1124.908203, 23.433599, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(717, 1329.534912, -1128.730712, 23.000000, 356.858398, 0.000000, 3.141590, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(717, 1330.015136, -1122.605834, 23.000000, 356.858398, 0.000000, 3.141590, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(717, 1330.388427, -1116.807861, 23.000000, 356.858398, 0.000000, 3.141590, -1, -1, -1, 300.00, 300.00); 

    return 1;
}