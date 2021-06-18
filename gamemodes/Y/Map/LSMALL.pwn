#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
//LSMALL
	RemoveBuildingForPlayer(playerid, 6130, 1117.5859, -1490.0078, 32.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 6255, 1117.5859, -1490.0078, 32.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1128.7344, -1518.4922, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1111.2578, -1512.3594, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1106.4375, -1501.3750, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1144.3984, -1512.7891, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1152.3828, -1502.5391, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1118.0156, -1467.4688, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 955, 1154.7266, -1460.8906, 15.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1139.9219, -1467.4688, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1139.9219, -1456.4375, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1118.0156, -1456.4375, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1139.9219, -1445.1016, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1118.0156, -1445.1016, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1139.9219, -1434.0703, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1118.0156, -1434.0703, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 615, 1147.6016, -1416.8750, 13.9531, 0.25);
    return 1;
}
hook OnGameModeInit()
{
    new jamiejjam;
    //LSMALL
	//๏ฟฝ๏ฟฝาน Ds
	jamiejjam = CreateDynamicObject(19480, 1147.903686, -1533.345947, 17.026266, 0.000000, 0.000000, 110.288589, -1);
	SetDynamicObjectMaterialText(jamiejjam, 0, "Didier Shchs", 120, "Times New Roman", 25, 1, -1, 0, 1);
	jamiejjam = CreateDynamicObject(19480, 1139.973510, -1523.210693, 19.386264, 0.000000, 0.000000, 111.788574, -1);
	SetDynamicObjectMaterialText(jamiejjam, 0, "Didier Shchs", 120, "Times New Roman", 25, 1, -1, 0, 1);

	jamiejjam = CreateDynamicObject(2413, 1148.6335, -1527.1855, 14.7861, 0.0000, 0.0000, -160.5000); //Shop_counter_3a
	SetDynamicObjectMaterial(jamiejjam, 0, 10023, "bigwhitesfe", "bigwhite_3", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 1, 16640, "a51", "a51_glass", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 5, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2413, 1147.1733, -1527.7032, 14.7861, 0.0000, 0.0000, -160.5000); //Shop_counter_3a
	SetDynamicObjectMaterial(jamiejjam, 0, 10023, "bigwhitesfe", "bigwhite_3", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 1, 16640, "a51", "a51_glass", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 5, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2413, 1145.7226, -1528.2170, 14.7861, 0.0000, 0.0000, -160.5000); //Shop_counter_3a
	SetDynamicObjectMaterial(jamiejjam, 0, 10023, "bigwhitesfe", "bigwhite_3", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 1, 16640, "a51", "a51_glass", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 5, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2413, 1144.2513, -1528.7375, 14.7861, 0.0000, 0.0000, -160.5000); //Shop_counter_3a
	SetDynamicObjectMaterial(jamiejjam, 0, 10023, "bigwhitesfe", "bigwhite_3", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 1, 16640, "a51", "a51_glass", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 5, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2413, 1143.4438, -1530.7091, 14.7861, 0.0000, 0.0000, -70.4000); //Shop_counter_3a
	SetDynamicObjectMaterial(jamiejjam, 0, 10023, "bigwhitesfe", "bigwhite_3", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 1, 16640, "a51", "a51_glass", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 5, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2413, 1142.9217, -1529.2397, 14.7861, 0.0000, 0.0000, -70.4000); //Shop_counter_3a
	SetDynamicObjectMaterial(jamiejjam, 0, 10023, "bigwhitesfe", "bigwhite_3", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 1, 16640, "a51", "a51_glass", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 5, 10023, "bigwhitesfe", "archgrnd2_SFE", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2196, 1147.2728, -1527.3132, 15.8030, 0.0000, 0.0000, 8.8999); //WORK_LAMP1
	jamiejjam = CreateDynamicObject(2196, 1145.9842, -1528.7413, 15.8030, 0.0000, 0.0000, -124.0998); //WORK_LAMP1
	jamiejjam = CreateDynamicObject(2196, 1143.3393, -1531.0644, 15.8030, 0.0000, 0.0000, 79.2994); //WORK_LAMP1
	jamiejjam = CreateDynamicObject(2710, 1147.2778, -1527.5909, 15.9074, 0.0000, 0.0000, 0.0000); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 3629, "arprtxxref_las", "dirtywhite", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1145.1805, -1528.3238, 15.4474, 0.0000, 0.0000, 179.0000); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1145.1745, -1528.3138, 15.8971, 0.0000, 0.0000, -139.5997); //WATCH_PICKUP
	jamiejjam = CreateDynamicObject(2710, 1144.9193, -1528.4200, 15.4474, 0.0000, 0.0000, 179.0000); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1145.4322, -1528.2270, 15.4474, 0.0000, 0.0000, 179.0000); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1145.6639, -1528.1507, 15.4474, 0.0000, 0.0000, 179.0000); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 14629, "ab_chande", "ab_goldpipe", 0xFFFFFFFF);
	CreateDynamicObject(19039, 1144.9641, -1528.1445, 15.8245, -26.1998, 0.0000, 0.0000); //WatchType1
	CreateDynamicObject(19040, 1145.0943, -1528.1009, 15.8141, -27.3999, 0.0000, 0.0000); //WatchType2
	CreateDynamicObject(957, 1143.4182, -1529.1268, 15.8802, 175.9998, 0.0000, 0.0000); //CJ_LIGHT_FIT_EXT
	CreateDynamicObject(1671, 1147.8470, -1529.1612, 15.2333, 0.0000, 0.0000, -144.3000); //swivelchair_A
	CreateDynamicObject(1671, 1145.4825, -1529.5102, 15.2333, 0.0000, 0.0000, 171.5000); //swivelchair_A
	CreateDynamicObject(1671, 1144.8159, -1531.1853, 15.2333, 0.0000, 0.0000, -96.9999); //swivelchair_A
	CreateDynamicObject(2728, 1143.8835, -1522.1466, 19.4986, 89.8999, -167.1000, 8.3999); //DS_BACKLIGHT
	jamiejjam = CreateDynamicObject(2475, 1147.1761, -1522.0697, 14.9414, 0.0000, 0.0000, -69.3000); //CJ_HOBBY_SHELF_3
	SetDynamicObjectMaterial(jamiejjam, 0, 10765, "airportgnd_sfse", "white", 0xFF1E1D13);
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8A794E);
	jamiejjam = CreateDynamicObject(2475, 1147.7071, -1523.4730, 14.9414, 0.0000, 0.0000, -69.3000); //CJ_HOBBY_SHELF_3
	SetDynamicObjectMaterial(jamiejjam, 0, 10765, "airportgnd_sfse", "white", 0xFF1E1D13);
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8A794E);
	jamiejjam = CreateDynamicObject(2475, 1148.2347, -1524.8675, 14.9414, 0.0000, 0.0000, -69.3000); //CJ_HOBBY_SHELF_3
	SetDynamicObjectMaterial(jamiejjam, 0, 10765, "airportgnd_sfse", "white", 0xFF1E1D13);
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8A794E);
	jamiejjam = CreateDynamicObject(2710, 1147.2406, -1522.6009, 16.5492, 0.0000, 0.2998, -66.1997); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8C8D94);
	SetDynamicObjectMaterial(jamiejjam, 2, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1147.0351, -1522.1341, 16.5517, 0.0000, 0.2998, -66.1997); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8C8D94);
	SetDynamicObjectMaterial(jamiejjam, 2, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1147.5268, -1523.4259, 16.5445, 0.0000, 0.2998, -66.1997); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8C8D94);
	SetDynamicObjectMaterial(jamiejjam, 2, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1147.7519, -1524.0588, 16.5510, 0.0000, 0.2998, -67.9999); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8C8D94);
	SetDynamicObjectMaterial(jamiejjam, 2, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1148.0251, -1524.7358, 16.5473, 0.0000, 0.2998, -67.9999); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8C8D94);
	SetDynamicObjectMaterial(jamiejjam, 2, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1148.2760, -1525.3575, 16.5438, 0.0000, 0.2998, -67.9999); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8C8D94);
	SetDynamicObjectMaterial(jamiejjam, 2, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1147.0284, -1522.1124, 15.8519, 0.0000, 0.2998, -68.6997); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8C8D94);
	SetDynamicObjectMaterial(jamiejjam, 2, 14407, "carter_block", "mp_carter_whitewall", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1147.2220, -1522.6059, 15.8491, 0.0000, 0.2998, -71.3998); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8C8D94);
	SetDynamicObjectMaterial(jamiejjam, 2, 14407, "carter_block", "mp_carter_whitewall", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1147.5024, -1523.4405, 15.8444, 0.0000, 1.1999, -66.8999); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8C8D94);
	SetDynamicObjectMaterial(jamiejjam, 2, 14407, "carter_block", "mp_carter_whitewall", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1147.7375, -1524.0150, 15.8415, 0.0000, 1.1999, -66.8999); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8C8D94);
	SetDynamicObjectMaterial(jamiejjam, 2, 14407, "carter_block", "mp_carter_whitewall", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1148.0124, -1524.7135, 15.8458, 0.0000, 1.1999, -66.8999); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8C8D94);
	SetDynamicObjectMaterial(jamiejjam, 2, 14407, "carter_block", "mp_carter_whitewall", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1148.2738, -1525.4287, 15.8499, 0.0000, 1.1999, -71.5998); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 10765, "airportgnd_sfse", "white", 0xFF8C8D94);
	SetDynamicObjectMaterial(jamiejjam, 2, 14407, "carter_block", "mp_carter_whitewall", 0xFFFFFFFF);
	CreateDynamicObject(2269, 1137.5495, -1527.2254, 16.3048, 0.0000, 0.0000, 108.5998); //Frame_WOOD_4
	SetDynamicObjectMaterialText(jamiejjam, 0, "don't touch\nthe rolex", 90, "Arial", 35, 1, 0xFF000000, 0xFFFFFFFF, 1);
	CreateDynamicObject(19174, 1137.8302, -1529.3907, 17.0522, 0.0000, 0.0000, 110.3000); //SAMPPicture3
	jamiejjam = CreateDynamicObject(2368, 1141.7972, -1523.3781, 14.7795, 0.0000, 0.0000, -159.1000); //Shop_counter_1
	SetDynamicObjectMaterial(jamiejjam, 0, 14652, "ab_trukstpa", "mp_diner_wood", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2368, 1139.1345, -1524.3951, 14.7795, 0.0000, 0.0000, -159.1000); //Shop_counter_1
	SetDynamicObjectMaterial(jamiejjam, 0, 14652, "ab_trukstpa", "mp_diner_wood", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2094, 1139.4051, -1529.3922, 14.5731, 0.0000, 0.0000, 110.8000); //SWANK_CABINET_4
	SetDynamicObjectMaterial(jamiejjam, 0, 14789, "ab_sfgymmain", "ab_wood02", 0xFFFFFFFF);
	CreateDynamicObject(2710, 1137.0482, -1524.8326, 15.5652, 0.0000, 0.0000, -176.5998); //WATCH_PICKUP
	CreateDynamicObject(2710, 1137.3719, -1524.6972, 15.5652, 0.0000, 0.0000, -136.3999); //WATCH_PICKUP
	jamiejjam = CreateDynamicObject(2710, 1137.1761, -1524.9459, 15.7453, 0.0000, 0.0000, -154.8999); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1138.0312, -1524.5550, 15.7453, 0.0000, 0.0000, -154.8999); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 3, 10810, "ap_build4e", "redwhite_stripe", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1137.4301, -1524.8275, 15.7453, 0.0000, 0.0000, -154.8999); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 3, 10810, "ap_build4e", "redwhite_stripe", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1138.1915, -1524.3797, 15.5652, 0.0000, 0.0000, -154.8999); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 3, 14789, "ab_sfgymmain", "ab_wood02", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1141.2701, -1523.3320, 15.7453, 0.0000, 0.0000, -154.8999); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1138.5318, -1524.3514, 15.7753, 0.0000, 0.0000, -154.8999); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 3629, "arprtxxref_las", "dirtywhite", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 10023, "bigwhitesfe", "archgrnd3_SFE", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 3, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1141.0080, -1523.4558, 15.7453, 0.0000, 0.0000, -154.8999); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 14581, "ab_mafiasuitea", "goldPillar", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1140.0666, -1523.7412, 15.7453, 0.0000, 0.0000, -156.4998); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 10023, "bigwhitesfe", "archgrnd3_SFE", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2710, 1139.7890, -1523.8509, 15.7453, 0.0000, 0.0000, -162.2998); //WATCH_PICKUP
	SetDynamicObjectMaterial(jamiejjam, 1, 10023, "bigwhitesfe", "archgrnd3_SFE", 0xFFFFFFFF);
	SetDynamicObjectMaterial(jamiejjam, 2, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0xFFFFFFFF);
	jamiejjam = CreateDynamicObject(2204, 1139.3796, -1533.4591, 14.8018, 0.0000, 0.0000, 110.0998); //MED_OFFICE8_CABINET
	SetDynamicObjectMaterial(jamiejjam, 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	CreateDynamicObject(940, 1147.3327, -1527.2969, 18.9680, 0.0000, 0.0000, 21.3000); //CJ_DF_LIGHT_2
	CreateDynamicObject(940, 1144.4533, -1528.4212, 18.9680, 0.0000, 0.0000, 21.3000); //CJ_DF_LIGHT_2
	CreateDynamicObject(940, 1143.3555, -1530.7542, 18.9680, 0.0000, 0.0000, 108.7000); //CJ_DF_LIGHT_2


	//๏ฟฝ๏ฟฝ๏ฟฝ๏ฟฝ Guitar and Record
	CreateDynamicObject(19318, 1086.8081, -1509.6915, 17.4090, 0.0000, 60.2000, 114.7000); //flyingv01
	CreateDynamicObject(19317, 1085.7987, -1507.1756, 17.3592, 0.0000, 56.8999, 111.8000); //bassguitar01
	CreateDynamicObject(19319, 1084.8302, -1504.7535, 17.2876, 3.0999, 59.5999, 113.9001); //warlock01
	CreateDynamicObject(1960, 1091.8792, -1512.8626, 17.3776, 0.0000, 0.0000, 21.7999); //record2
	CreateDynamicObject(1962, 1090.7913, -1513.2999, 17.3776, 0.0000, 0.0000, 20.1999); //record1
	CreateDynamicObject(1961, 1089.7574, -1513.7287, 17.3853, 0.0000, 0.0000, 22.0999); //record3
	//
	CreateDynamicObject(19322, 1117.58997, -1490.01001, 32.72000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19323, 1117.58997, -1490.01001, 32.71814,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2649, 10918.96973, -4055.87988, -3029.90991,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2231, -1526.19995, -1524.00000, 21.73000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19329, 1155.13000, -1440.40002, 18.53000,   0.00000, 0.00000, 89.23000);
	CreateDynamicObject(1847, 1168.95496, -1447.85034, 14.79000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1845, 1182.70996, -1433.62000, 14.79000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1844, 1174.26001, -1431.83997, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1847, 1178.91064, -1447.81970, 14.79000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1847, 1173.91772, -1447.80676, 14.79000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1847, 1163.95056, -1447.83044, 14.79000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1890, 1162.03003, -1438.14001, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1890, 1161.88000, -1442.21997, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1890, 1169.96497, -1445.50000, 14.79000,   0.00000, 0.00000, 88.43999);
	CreateDynamicObject(1890, 1170.04395, -1442.43176, 14.79000,   0.00000, 0.00000, 89.16000);
	CreateDynamicObject(1890, 1173.73999, -1442.21997, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1890, 1176.66003, -1442.21997, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1891, 1176.65002, -1438.07996, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1891, 1173.77002, -1438.10999, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1891, 1170.80005, -1438.12000, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1891, 1169.21057, -1434.83704, 14.79000,   0.00000, 0.00000, 87.06000);
	CreateDynamicObject(1891, 1161.96997, -1438.15002, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1890, 1164.83997, -1442.26001, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1891, 1164.92004, -1438.18005, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1844, 1162.45996, -1431.84998, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1844, 1165.43005, -1431.91003, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1844, 1168.35999, -1431.89001, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1844, 1171.31006, -1431.85999, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1842, 1175.06006, -1445.76001, 15.09000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1842, 1175.54004, -1434.88000, 15.09000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1842, 1164.89001, -1435.09998, 15.09000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1842, 1163.09998, -1445.62000, 15.09000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1845, 1182.67004, -1446.28003, 14.79000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2452, 1182.89001, -1443.43994, 14.69000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1885, 1156.06335, -1441.80750, 14.84169,   0.00000, 0.00000, 87.23998);
	CreateDynamicObject(7666, 1098.05005, -1415.90002, 37.31000,   0.00000, 0.00000, 299.66000);
	CreateDynamicObject(7666, 1158.96997, -1415.77002, 37.31000,   0.00000, 0.00000, 299.66000);
	CreateDynamicObject(1845, 1156.12292, -1446.85437, 14.79000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1845, 1160.00879, -1446.92114, 14.79000,   0.00000, 0.00000, 92.40005);
	CreateDynamicObject(1845, 1157.97717, -1444.90369, 14.79000,   0.00000, 0.00000, 180.84004);
	CreateDynamicObject(1984, 1157.41211, -1433.74072, 14.79372,   0.00000, 0.00000, -91.20001);
	CreateDynamicObject(712, 1152.72290, -1445.33691, 13.74913,   356.85840, 0.00000, -1.70885);
	CreateDynamicObject(1340, 1153.16602, -1452.32568, 15.82416,   0.00000, 0.00000, -179.04004);
	CreateDynamicObject(1728, 1160.15405, -1449.58191, 14.82678,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1814, 1160.66248, -1451.75745, 14.81187,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2343, 1165.31958, -1451.14978, 15.44228,   0.00000, 0.00000, -144.36002);
	CreateDynamicObject(2343, 1165.40161, -1453.69751, 15.44228,   0.00000, 0.00000, -205.13997);
	CreateDynamicObject(2343, 1165.24561, -1456.11255, 15.44228,   0.00000, 0.00000, -182.58003);
	CreateDynamicObject(1716, 1165.56177, -1451.76404, 14.85943,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1716, 1165.60889, -1454.22742, 14.85943,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1716, 1165.51855, -1456.62561, 14.85943,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1646, 1166.75342, -1459.28247, 15.06459,   0.00000, 0.00000, -180.53999);
	CreateDynamicObject(911, 1167.29980, -1451.29211, 15.33161,   0.00000, 0.00000, -88.97999);
	CreateDynamicObject(911, 1167.28467, -1454.01367, 15.33161,   0.00000, 0.00000, -88.97999);
	CreateDynamicObject(911, 1167.29675, -1456.55579, 15.33161,   0.00000, 0.00000, -88.97999);
	CreateDynamicObject(911, 1164.56702, -1459.94250, 15.33161,   0.00000, 0.00000, -180.66000);
	CreateDynamicObject(2296, 1162.49011, -1460.21326, 14.76837,   0.00000, 0.00000, -179.27992);
	CreateDynamicObject(2286, 1167.75378, -1454.03845, 17.18604,   0.00000, 0.00000, -90.18001);
	CreateDynamicObject(2287, 1167.32751, -1457.99536, 16.86682,   0.00000, 0.00000, -90.11999);
	CreateDynamicObject(2257, 1165.72229, -1449.08008, 17.13560,   0.00000, 0.00000, 1.02001);
	CreateDynamicObject(2256, 1157.64001, -1460.45068, 17.55966,   0.00000, 0.00000, -180.06004);
	CreateDynamicObject(2256, 1164.95703, -1460.43933, 17.55966,   0.00000, 0.00000, -180.06004);
	CreateDynamicObject(2604, 1157.73267, -1451.03760, 15.56216,   0.00000, 0.00000, -119.51994);
	CreateDynamicObject(1716, 1157.00220, -1449.79822, 14.85943,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2185, 1169.67029, -1477.97339, 14.79780,   0.00000, 0.00000, 107.40002);
	CreateDynamicObject(2185, 1168.62463, -1474.69592, 14.79780,   0.00000, 0.00000, 107.40002);
	CreateDynamicObject(2185, 1167.67896, -1471.68054, 14.79780,   0.00000, 0.00000, 107.40002);
	CreateDynamicObject(2185, 1166.74866, -1468.82190, 14.79780,   0.00000, 0.00000, 107.40002);
	CreateDynamicObject(2185, 1161.25195, -1477.94336, 14.79780,   0.00000, 0.00000, 288.12000);
	CreateDynamicObject(2185, 1160.46204, -1475.36816, 14.79780,   0.00000, 0.00000, 288.12000);
	CreateDynamicObject(2202, 1166.59082, -1479.63757, 14.78355,   0.00000, 0.00000, -162.42000);
	CreateDynamicObject(1714, 1165.49402, -1468.58362, 14.81465,   0.00000, 0.00000, -219.29999);
	CreateDynamicObject(1714, 1167.60315, -1474.13757, 14.81465,   0.00000, 0.00000, -75.59993);
	CreateDynamicObject(1714, 1166.38318, -1471.20422, 14.81465,   0.00000, 0.00000, -258.53998);
	CreateDynamicObject(1714, 1168.35767, -1477.55017, 14.81465,   0.00000, 0.00000, -304.79996);
	CreateDynamicObject(1714, 1161.65100, -1475.86182, 14.81465,   0.00000, 0.00000, -75.59993);
	CreateDynamicObject(1714, 1162.47083, -1478.35242, 14.81465,   0.00000, 0.00000, 144.42009);
	CreateDynamicObject(1723, 1166.05884, -1476.72839, 14.68285,   0.00000, 0.00000, -163.01994);
	CreateDynamicObject(1723, 1164.25696, -1471.36279, 14.68285,   0.00000, 0.00000, -163.01994);
	CreateDynamicObject(1723, 1162.64612, -1472.96912, 14.68285,   0.00000, 0.00000, 17.22004);
	CreateDynamicObject(1723, 1161.07617, -1467.86792, 14.68285,   0.00000, 0.00000, 17.22004);
	CreateDynamicObject(1817, 1162.31995, -1470.26819, 14.72599,   0.00000, 0.00000, 16.98000);
	CreateDynamicObject(1817, 1164.07385, -1475.63452, 14.72599,   0.00000, 0.00000, 16.98000);
	CreateDynamicObject(16151, 1160.97339, -1464.65161, 15.31099,   0.00000, 0.00000, 108.12001);
	CreateDynamicObject(3861, 1138.25049, -1490.19238, 15.94349,   0.00000, 0.00000, 89.80603);
	CreateDynamicObject(1514, 1139.00232, -1490.73462, 15.79406,   0.00000, 0.00000, 90.24001);
	CreateDynamicObject(2242, 1139.34692, -1489.28394, 14.90558,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2246, 1138.96008, -1492.25305, 15.20442,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2251, 1137.54797, -1492.20105, 15.70596,   0.00000, 0.00000, -52.56000);
	CreateDynamicObject(2243, 1139.52612, -1490.09131, 15.03393,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3802, 1138.19202, -1487.96008, 16.17242,   0.00000, 0.00000, 91.86000);
	CreateDynamicObject(1280, 1140.52832, -1464.72913, 15.11371,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1280, 1140.60754, -1461.52258, 15.11371,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1280, 1140.71667, -1456.57935, 15.11371,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1280, 1140.76685, -1452.72534, 15.11371,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1280, 1140.78101, -1447.44678, 15.11371,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1280, 1140.80188, -1443.79492, 15.11371,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(644, 1128.92786, -1464.08838, 15.04545,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(640, 1129.02527, -1459.16602, 15.44864,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(644, 1129.05664, -1454.38757, 15.04545,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(640, 1128.98547, -1448.97839, 15.44864,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(644, 1128.88086, -1444.02625, 15.04545,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(640, 1128.83020, -1438.71875, 15.44864,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1280, 1117.61218, -1464.59033, 15.11371,   0.00000, 0.00000, 180.60001);
	CreateDynamicObject(1280, 1117.59558, -1461.28955, 15.11371,   0.00000, 0.00000, 180.60001);
	CreateDynamicObject(1280, 1117.58130, -1456.24939, 15.11371,   0.00000, 0.00000, 180.60001);
	CreateDynamicObject(1280, 1117.54492, -1452.78894, 15.11371,   0.00000, 0.00000, 180.60001);
	CreateDynamicObject(1280, 1117.59448, -1446.80713, 15.11371,   0.00000, 0.00000, 180.60001);
	CreateDynamicObject(1280, 1117.65955, -1442.74548, 15.11371,   0.00000, 0.00000, 180.60001);
	CreateDynamicObject(1341, 1119.19348, -1493.68213, 15.74404,   0.00000, 0.00000, 90.00001);
	CreateDynamicObject(1340, 1119.38269, -1488.50867, 15.97704,   0.00000, 0.00000, 179.87990);
	CreateDynamicObject(2624, 1114.90051, -1532.83508, 16.45952,   0.00000, 0.00000, -110.52005);
	CreateDynamicObject(2622, 1111.39331, -1533.97290, 15.61317,   0.00000, 0.00000, -21.90000);
	CreateDynamicObject(14693, 1164.41357, -1451.85901, 15.23531,   0.00000, 0.00000, 107.40000);
	CreateDynamicObject(14693, 1164.32129, -1454.27783, 15.23531,   0.00000, 0.00000, 107.40000);
	CreateDynamicObject(14693, 1164.19165, -1456.61523, 15.23531,   0.00000, 0.00000, 107.40000);
	CreateDynamicObject(14693, 1164.43823, -1457.98157, 15.23531,   0.00000, 0.00000, 16.02001);
	CreateDynamicObject(2652, 1117.12573, -1531.60559, 15.40361,   0.00000, 0.00000, 156.59996);
	CreateDynamicObject(2389, 1118.61096, -1528.65308, 17.39013,   0.00000, 0.00000, 250.55475);
	CreateDynamicObject(19360, 1118.47961, -1529.59827, 16.51792,   0.00000, 0.00000, -20.46000);
	CreateDynamicObject(2374, 1118.30627, -1529.52686, 15.85560,   0.00000, 0.00000, -110.16000);
	CreateDynamicObject(2401, 1118.70740, -1528.61304, 15.86872,   0.00000, 0.00000, -112.13999);
	CreateDynamicObject(2374, 1118.30627, -1529.52686, 17.40661,   0.00000, 0.00000, -110.16000);
	CreateDynamicObject(2401, 1117.94360, -1530.48438, 17.42077,   0.00000, 0.00000, -112.13999);
	CreateDynamicObject(2389, 1117.84875, -1530.46155, 15.78044,   0.00000, 0.00000, 250.55475);
	CreateDynamicObject(2698, 1114.70508, -1528.24341, 15.75884,   0.00000, 0.00000, -54.66001);
	CreateDynamicObject(2699, 1111.02563, -1528.22729, 15.49670,   0.00000, 0.00000, -19.62000);
	CreateDynamicObject(2652, 1110.91333, -1528.16150, 16.62898,   0.00000, 0.00000, 156.59996);
	CreateDynamicObject(19360, 1119.57751, -1526.57129, 16.51792,   0.00000, 0.00000, -20.46000);
	CreateDynamicObject(2626, 1114.41870, -1524.81970, 15.25581,   0.00000, 0.00000, -19.56000);
	CreateDynamicObject(2625, 1109.34265, -1522.80847, 16.06543,   0.00000, 0.00000, 69.54000);
	CreateDynamicObject(2964, 1107.90271, -1531.67981, 14.81326,   0.00000, 0.00000, -20.16000);
	CreateDynamicObject(2628, 1107.74841, -1528.45776, 14.83720,   0.00000, 0.00000, 69.48000);
	CreateDynamicObject(2627, 1108.29102, -1527.41870, 14.71601,   0.00000, 0.00000, 69.06001);
	CreateDynamicObject(2629, 1108.58118, -1526.15491, 14.74454,   0.00000, 0.00000, 70.08001);
	CreateDynamicObject(1752, 1105.59875, -1532.16870, 18.27486,   0.00000, 0.00000, 128.45999);
	CreateDynamicObject(14403, 1119.01746, -1493.46301, 15.24797,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(14403, 1086.31262, -1508.27087, 16.80306,   0.00000, 0.00000, 21.23185);
	CreateDynamicObject(2104, 1087.80164, -1512.34827, 14.84466,   0.00000, 0.00000, 110.27993);
	CreateDynamicObject(2229, 1087.43616, -1510.84583, 14.84043,   0.00000, 0.00000, 111.48000);
	CreateDynamicObject(2229, 1088.41443, -1513.59827, 14.84043,   0.00000, 0.00000, 111.48000);
	CreateDynamicObject(19786, 1087.78040, -1512.54700, 17.73009,   0.00000, 0.00000, 111.29998);
	CreateDynamicObject(2256, 1087.04480, -1502.56396, 17.48863,   0.00000, 0.00000, 21.18000);
	CreateDynamicObject(1984, 1094.75464, -1502.21313, 14.75310,   0.00000, 0.00000, 110.58000);
	CreateDynamicObject(2583, 1098.63318, -1509.95227, 15.69228,   0.00000, 0.00000, -158.82002);
	CreateDynamicObject(2579, 1097.21521, -1510.72546, 16.32783,   0.00000, 0.00000, -158.70001);
	CreateDynamicObject(2556, 1095.45081, -1510.90833, 14.84260,   0.00000, 0.00000, 201.89989);
	CreateDynamicObject(1724, 1090.59082, -1502.40369, 14.81265,   0.00000, 0.00000, 65.03999);
	CreateDynamicObject(1724, 1092.07227, -1504.63684, 14.81265,   0.00000, 0.00000, 141.30002);
	CreateDynamicObject(2786, 1091.56665, -1464.41577, 15.63510,   0.00000, 0.00000, 72.06001);
	CreateDynamicObject(2786, 1093.97925, -1466.52258, 15.63510,   0.00000, 0.00000, 72.06001);
	CreateDynamicObject(2778, 1092.74524, -1475.02710, 14.78294,   0.00000, 0.00000, 72.06000);
	CreateDynamicObject(2778, 1092.99194, -1474.30237, 14.78294,   0.00000, 0.00000, 72.06000);
	CreateDynamicObject(2779, 1093.22302, -1473.56604, 14.78290,   0.00000, 0.00000, 72.06000);
	CreateDynamicObject(2779, 1093.45508, -1472.82068, 14.78290,   0.00000, 0.00000, 72.06000);
	CreateDynamicObject(2778, 1093.69946, -1472.10095, 14.78290,   0.00000, 0.00000, 72.06000);
	CreateDynamicObject(2778, 1093.94714, -1471.36084, 14.78290,   0.00000, 0.00000, 72.06000);
	CreateDynamicObject(2754, 1096.08704, -1477.59912, 15.67938,   0.00000, 0.00000, -19.19999);
	CreateDynamicObject(2754, 1095.81226, -1478.36316, 15.67938,   0.00000, 0.00000, -19.19999);
	CreateDynamicObject(2754, 1095.55725, -1479.13123, 15.67938,   0.00000, 0.00000, -19.19999);
	CreateDynamicObject(2784, 1087.77075, -1474.54382, 16.07735,   0.00000, 0.00000, 72.48000);
	CreateDynamicObject(2783, 1088.02966, -1474.53662, 16.07730,   0.00000, 0.00000, 72.48000);
	CreateDynamicObject(2779, 1092.76282, -1471.69751, 14.78290,   0.00000, 0.00000, 251.93999);
	CreateDynamicObject(2779, 1093.00000, -1470.97498, 14.78290,   0.00000, 0.00000, 251.93999);
	CreateDynamicObject(2779, 1092.03467, -1473.92664, 14.78290,   0.00000, 0.00000, 251.93999);
	CreateDynamicObject(2779, 1091.79797, -1474.64990, 14.78290,   0.00000, 0.00000, 251.93999);
	CreateDynamicObject(2778, 1092.51306, -1472.43530, 14.78294,   0.00000, 0.00000, -107.27999);
	CreateDynamicObject(2778, 1092.27649, -1473.17871, 14.78294,   0.00000, 0.00000, -107.27999);
	CreateDynamicObject(2964, 1096.68689, -1466.73206, 14.77390,   0.00000, 0.00000, -17.10000);
	CreateDynamicObject(1702, 1094.00415, -1463.54700, 14.75910,   0.00000, 0.00000, -16.20000);
	CreateDynamicObject(1702, 1096.22632, -1464.21497, 14.75910,   0.00000, 0.00000, -16.20000);
	CreateDynamicObject(11687, 1093.51086, -1466.94824, 14.77640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2229, 1100.54834, -1465.38074, 14.75226,   0.00000, 0.00000, -59.88000);
	CreateDynamicObject(2232, 1098.04895, -1471.32373, 15.37174,   0.00000, 0.00000, -106.91999);
	CreateDynamicObject(2229, 1094.85767, -1481.55347, 14.75226,   0.00000, 0.00000, -149.87993);
	CreateDynamicObject(2623, 1091.05957, -1478.87048, 16.36133,   0.00000, 0.00000, 162.35988);
	CreateDynamicObject(2350, 1088.29541, -1477.81738, 15.11343,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2350, 1088.75464, -1476.41504, 15.11343,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2350, 1089.72644, -1473.45020, 15.11343,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2350, 1090.20947, -1471.55396, 15.11343,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2188, 1089.81812, -1468.19385, 15.66189,   0.00000, 0.00000, 73.08002);
	CreateDynamicObject(2456, 1101.99817, -1455.94812, 14.79233,   0.00000, 0.00000, 90.65999);
	CreateDynamicObject(2808, 1096.60645, -1460.00464, 15.41328,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2808, 1091.46448, -1460.00183, 15.41328,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2808, 1085.84412, -1460.01208, 15.41328,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2637, 1096.66284, -1458.53589, 15.20391,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2637, 1091.50134, -1458.56177, 15.20391,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2637, 1085.86047, -1458.57605, 15.20391,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2693, 1099.87756, -1471.97546, 15.49928,   0.00000, 0.00000, 33.24001);
	CreateDynamicObject(2692, 1098.62219, -1475.36719, 15.49930,   0.00000, 0.00000, 94.07999);
	CreateDynamicObject(2454, 1081.65454, -1458.66577, 14.78993,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2455, 1081.78711, -1457.57007, 14.78990,   0.00000, 0.00000, 90.60001);
	CreateDynamicObject(2455, 1081.76929, -1456.64966, 14.78990,   0.00000, 0.00000, 90.60001);
	CreateDynamicObject(2455, 1081.75134, -1455.72949, 14.78990,   0.00000, 0.00000, 90.60001);
	CreateDynamicObject(2455, 1081.74805, -1454.80676, 14.78990,   0.00000, 0.00000, 90.60001);
	CreateDynamicObject(2455, 1081.73413, -1453.88135, 14.78990,   0.00000, 0.00000, 90.60001);
	CreateDynamicObject(2455, 1081.71948, -1452.96155, 14.78990,   0.00000, 0.00000, 90.60001);
	CreateDynamicObject(2454, 1081.71143, -1450.12085, 14.78990,   0.00000, 0.00000, 90.60000);
	CreateDynamicObject(2449, 1077.27234, -1459.85913, 14.79208,   0.00000, 0.00000, 89.76005);
	CreateDynamicObject(2457, 1081.71436, -1452.04016, 14.78990,   0.00000, 0.00000, 90.60000);
	CreateDynamicObject(2455, 1080.62427, -1449.99402, 14.78990,   0.00000, 0.00000, 180.90002);
	CreateDynamicObject(2455, 1079.70471, -1450.00305, 14.78990,   0.00000, 0.00000, 180.90002);
	CreateDynamicObject(2455, 1078.76807, -1450.02466, 14.78990,   0.00000, 0.00000, 180.90002);
	CreateDynamicObject(2455, 1077.83618, -1450.02722, 14.78990,   0.00000, 0.00000, 180.90002);
	CreateDynamicObject(2448, 1077.27917, -1457.51978, 14.79210,   0.00000, 0.00000, 89.76000);
	CreateDynamicObject(2443, 1077.38501, -1455.13806, 14.79210,   0.00000, 0.00000, 89.76000);
	CreateDynamicObject(19899, 1077.48035, -1453.31641, 14.79210,   0.00000, 0.00000, 0.17998);
	CreateDynamicObject(1370, 1077.58032, -1451.67688, 15.31207,   0.00000, 0.00000, 0.18000);
	CreateDynamicObject(1370, 1077.50952, -1450.91541, 15.31207,   0.00000, 0.00000, 0.18000);
	CreateDynamicObject(2642, 1080.79651, -1456.15356, 18.73358,   12.42001, 91.07999, 87.60007);
	CreateDynamicObject(2642, 1080.81311, -1454.26953, 18.69359,   12.42001, 91.07999, 87.60007);
	CreateDynamicObject(2642, 1080.57300, -1452.34814, 18.67359,   12.42001, 91.07999, 87.60007);
	CreateDynamicObject(2642, 1084.31421, -1449.16223, 17.28723,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2645, 1084.36340, -1460.45117, 17.53461,   0.00000, 0.00000, -177.77998);
	CreateDynamicObject(2808, 1085.43665, -1454.95471, 15.41330,   0.00000, 0.00000, -90.66000);
	CreateDynamicObject(2808, 1085.46484, -1450.13977, 15.41328,   0.00000, 0.00000, -90.66000);
	CreateDynamicObject(2808, 1098.15588, -1455.22412, 15.41328,   0.00000, 0.00000, 88.86002);
	CreateDynamicObject(2808, 1098.26453, -1450.17639, 15.41328,   0.00000, 0.00000, 89.46002);
	CreateDynamicObject(2637, 1087.27234, -1454.99670, 15.20391,   0.00000, 0.00000, 89.88003);
	CreateDynamicObject(2637, 1087.33801, -1450.14795, 15.20391,   0.00000, 0.00000, 89.88003);
	CreateDynamicObject(0, 1089.54822, -1454.93457, 15.41330,   0.00000, 0.00000, -90.66000);
	CreateDynamicObject(2808, 1080.87781, -1452.37000, 15.41330,   0.00000, 0.00000, -90.66000);
	CreateDynamicObject(2638, 1089.56885, -1455.03369, 15.38726,   0.00000, 0.00000, -89.69998);
	CreateDynamicObject(2638, 1089.51892, -1450.11267, 15.42690,   0.00000, 0.00000, -89.69998);
	CreateDynamicObject(2637, 1091.95752, -1454.98779, 15.20391,   0.00000, 0.00000, 89.88003);
	CreateDynamicObject(2637, 1091.99316, -1450.21948, 15.20391,   0.00000, 0.00000, 89.88003);
	CreateDynamicObject(2638, 1094.25745, -1450.16565, 15.42690,   0.00000, 0.00000, -89.69998);
	CreateDynamicObject(2638, 1094.18933, -1455.14246, 15.42690,   0.00000, 0.00000, -89.69998);
	CreateDynamicObject(2637, 1096.33447, -1455.05945, 15.20391,   0.00000, 0.00000, 89.88003);
	CreateDynamicObject(2637, 1096.42004, -1450.10950, 15.20391,   0.00000, 0.00000, 89.88003);
	CreateDynamicObject(2668, 1091.28503, -1454.98669, 18.39228,   0.00000, 0.00000, 87.47999);
	CreateDynamicObject(2668, 1086.43896, -1455.06909, 18.39228,   0.00000, 0.00000, 87.47999);
	CreateDynamicObject(2667, 1086.12598, -1450.95398, 18.39230,   0.00000, 0.00000, 87.48000);
	CreateDynamicObject(2666, 1091.67065, -1450.91284, 18.39230,   0.00000, 0.00000, 87.48000);
	CreateDynamicObject(19325, 1101.67920, -1452.25525, 15.93842,   0.00000, 0.00000, -1.38000);
	CreateDynamicObject(19325, 1101.77209, -1444.98230, 15.93842,   0.00000, 0.00000, -0.30000);
	CreateDynamicObject(19325, 1101.67590, -1435.08704, 15.93842,   0.00000, 0.00000, -1.50000);
	CreateDynamicObject(19325, 1099.67676, -1468.22534, 15.93842,   0.00000, 0.00000, -17.70000);
	CreateDynamicObject(19325, 1096.36853, -1478.31470, 15.93842,   0.00000, 0.00000, -17.70000);
	CreateDynamicObject(19325, 1097.23218, -1502.67847, 15.93842,   0.00000, 0.00000, 21.12000);
	CreateDynamicObject(19325, 1117.12891, -1523.58167, 16.04872,   0.00000, 0.00000, 69.05998);
	CreateDynamicObject(19325, 1139.35681, -1523.65271, 16.04872,   0.00000, 0.00000, 110.88001);
	CreateDynamicObject(19325, 1159.74609, -1502.18518, 16.04872,   0.00000, 0.00000, 159.89995);
	CreateDynamicObject(19325, 1160.55249, -1478.35876, 16.04872,   0.00000, 0.00000, 197.63989);
	CreateDynamicObject(19325, 1157.42261, -1468.10266, 16.04872,   0.00000, 0.00000, 198.29987);
	CreateDynamicObject(19325, 1155.39868, -1452.87988, 16.04872,   0.00000, 0.00000, 179.81981);
	CreateDynamicObject(19325, 1155.39868, -1452.87988, 16.04872,   0.00000, 0.00000, 179.81981);
	CreateDynamicObject(19325, 1157.42261, -1468.10266, 16.04872,   0.00000, 0.00000, 198.29987);
	CreateDynamicObject(19325, 1155.34729, -1445.05322, 16.04872,   0.00000, 0.00000, 179.16005);
	CreateDynamicObject(19325, 1155.42200, -1434.75403, 16.04872,   0.00000, 0.00000, 180.17978);
	CreateDynamicObject(19325, 1094.25732, -1444.35681, 23.74187,   0.00000, 0.00000, 0.18000);
	CreateDynamicObject(19325, 1094.34180, -1458.46960, 23.74187,   0.00000, 0.00000, 0.24000);
	CreateDynamicObject(19325, 1092.88342, -1517.29944, 23.76519,   0.00000, 0.00000, 41.57999);
	CreateDynamicObject(19325, 1100.84778, -1526.38708, 23.76519,   0.00000, 0.00000, 42.36000);
	CreateDynamicObject(19325, 1139.35681, -1523.65271, 16.04872,   0.00000, 0.00000, 110.88001);
	CreateDynamicObject(19325, 1154.96863, -1526.45776, 23.76630,   0.00000, 0.00000, 139.14000);
	CreateDynamicObject(19325, 1163.28845, -1517.03113, 23.76630,   0.00000, 0.00000, 139.14000);
	CreateDynamicObject(19325, 1163.12817, -1441.77185, 23.81000,   0.00000, 0.00000, 180.06006);
	CreateDynamicObject(19325, 1163.04663, -1428.40234, 23.81000,   0.00000, 0.00000, 180.06006);
	CreateDynamicObject(1281, 1104.65564, -1453.90002, 15.58628,   0.00000, 0.00000, 235.19997);
	CreateDynamicObject(1281, 1105.70166, -1449.86572, 15.58628,   0.00000, 0.00000, 90.18002);
	CreateDynamicObject(1281, 1104.61572, -1445.78345, 15.58628,   0.00000, 0.00000, 133.26007);
	CreateDynamicObject(2736, 1101.96851, -1440.26721, 20.24599,   0.00000, 0.00000, 89.94001);
	CreateDynamicObject(2403, 1097.46838, -1436.56555, 14.79214,   0.00000, 0.00000, 89.03999);
	CreateDynamicObject(2368, 1101.05505, -1442.00073, 14.79279,   0.00000, 0.00000, -181.43991);
	CreateDynamicObject(2368, 1099.08801, -1442.74243, 14.79338,   0.00000, 0.00000, -92.57999);
	CreateDynamicObject(1514, 1099.01672, -1442.67761, 16.05127,   0.00000, 0.00000, -91.20001);
	CreateDynamicObject(2375, 1093.62756, -1448.33777, 14.79346,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2376, 1097.78564, -1435.61182, 14.79350,   0.00000, 0.00000, -90.29999);
	CreateDynamicObject(2387, 1095.38806, -1445.23682, 14.79304,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2372, 1099.34937, -1448.65247, 14.79350,   0.00000, 0.00000, -90.30000);
	CreateDynamicObject(1723, 1098.91223, -1431.89453, 14.79041,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2409, 1101.54102, -1435.11646, 15.25930,   0.00000, 0.00000, 85.68002);
	CreateDynamicObject(2384, 1098.02393, -1437.30957, 15.21944,   0.00000, 0.00000, 90.30003);
	CreateDynamicObject(2384, 1098.58691, -1438.16284, 15.21944,   0.00000, 0.00000, 90.30003);
	CreateDynamicObject(2384, 1097.61304, -1435.44653, 15.21944,   0.00000, 0.00000, 90.30003);
	CreateDynamicObject(2386, 1098.05066, -1436.20679, 15.21940,   0.00000, 0.00000, 90.30000);
	CreateDynamicObject(2386, 1097.56604, -1438.15283, 15.21940,   0.00000, 0.00000, 90.30000);
	CreateDynamicObject(2386, 1098.63037, -1435.37805, 15.21940,   0.00000, 0.00000, 90.30000);
	CreateDynamicObject(2389, 1092.80920, -1435.71069, 16.82103,   0.00000, 0.00000, 80.70000);
	CreateDynamicObject(2390, 1093.21301, -1434.51672, 16.82100,   0.00000, 0.00000, 70.55999);
	CreateDynamicObject(2391, 1093.91809, -1433.49573, 16.82100,   0.00000, 0.00000, 61.26000);
	CreateDynamicObject(2392, 1094.82507, -1432.62708, 16.82100,   0.00000, 0.00000, 44.70000);
	CreateDynamicObject(2383, 1096.08618, -1431.94275, 16.82100,   0.00000, 0.00000, -71.58001);
	CreateDynamicObject(2611, 1092.43164, -1444.52625, 16.77520,   0.00000, 0.00000, 89.46001);
	CreateDynamicObject(2611, 1092.47119, -1441.56519, 17.78398,   0.00000, 0.00000, 89.46001);
	CreateDynamicObject(2611, 1092.47119, -1441.56519, 15.59182,   0.00000, 0.00000, 89.46001);
	CreateDynamicObject(2611, 1092.42627, -1438.84778, 17.16627,   0.00000, 0.00000, 89.46001);
	CreateDynamicObject(1280, 1125.56042, -1495.51550, 22.16088,   0.00000, 0.00000, -88.13999);
	CreateDynamicObject(1280, 1119.79724, -1495.53271, 22.16088,   0.00000, 0.00000, -88.13999);
	CreateDynamicObject(1280, 1113.57629, -1495.59241, 22.16088,   0.00000, 0.00000, -88.13999);
	CreateDynamicObject(1280, 1108.18872, -1495.54175, 22.16088,   0.00000, 0.00000, -88.13999);
	CreateDynamicObject(1280, 1109.37427, -1483.18628, 22.16088,   0.00000, 0.00000, -269.99988);
	CreateDynamicObject(1280, 1114.13550, -1483.19604, 22.16088,   0.00000, 0.00000, -269.99988);
	CreateDynamicObject(1280, 1119.61633, -1483.10779, 22.16088,   0.00000, 0.00000, -269.99988);
	CreateDynamicObject(1280, 1125.77661, -1483.14075, 22.16088,   0.00000, 0.00000, -269.99988);
	CreateDynamicObject(1280, 1132.72510, -1483.28125, 22.16088,   0.00000, 0.00000, -269.99988);
	CreateDynamicObject(1280, 1142.74438, -1483.28699, 22.16088,   0.00000, 0.00000, -269.99988);
	CreateDynamicObject(1280, 1153.55701, -1483.08923, 22.16088,   0.00000, 0.00000, -269.99988);
	CreateDynamicObject(1280, 1132.42163, -1495.34583, 22.16088,   0.00000, 0.00000, -88.13999);
	CreateDynamicObject(1280, 1144.56750, -1495.36584, 22.16088,   0.00000, 0.00000, -88.13999);
	CreateDynamicObject(1280, 1158.55103, -1495.42993, 22.16088,   0.00000, 0.00000, -88.13999);
	CreateDynamicObject(1726, 1167.06580, -1444.23291, 21.76190,   0.00000, 0.00000, 181.43999);
	CreateDynamicObject(1726, 1163.79065, -1443.18091, 21.76190,   0.00000, 0.00000, 90.96001);
	CreateDynamicObject(1827, 1165.90369, -1442.17822, 21.73509,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3850, 1165.14612, -1431.65735, 22.28367,   0.00000, 0.00000, 88.92002);
	CreateDynamicObject(3850, 1168.59668, -1431.72424, 22.28367,   0.00000, 0.00000, 88.92002);
	CreateDynamicObject(3850, 1172.05725, -1431.77283, 22.28367,   0.00000, 0.00000, 88.92002);
	CreateDynamicObject(2627, 1164.65723, -1426.42810, 21.74131,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2627, 1166.73950, -1426.47363, 21.74131,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2627, 1168.84070, -1426.47900, 21.74131,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2627, 1170.96826, -1426.46399, 21.74131,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2630, 1173.03894, -1426.70154, 21.73518,   0.00000, 0.00000, 180.06007);
	CreateDynamicObject(2630, 1175.17883, -1426.67273, 21.73518,   0.00000, 0.00000, 180.06007);
	CreateDynamicObject(2630, 1177.28247, -1426.73779, 21.73518,   0.00000, 0.00000, 180.06007);
	CreateDynamicObject(2915, 1179.49353, -1424.96582, 21.83551,   0.00000, 0.00000, -9.78000);
	CreateDynamicObject(1985, 1177.38770, -1434.28369, 25.00551,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19466, 1179.79065, -1432.76965, 24.14234,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19466, 1179.70349, -1435.03296, 24.14234,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19466, 1179.81677, -1437.31091, 24.14234,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19466, 1179.81824, -1439.57153, 24.14234,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19087, 1177.37976, -1434.31299, 27.28308,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1985, 1177.46814, -1437.06274, 25.00551,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19087, 1177.48315, -1437.07214, 27.28308,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2632, 1171.49609, -1430.60144, 21.76399,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2631, 1166.13086, -1430.61121, 21.76400,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2916, 1172.84485, -1431.14197, 21.89436,   0.00000, 0.00000, 69.06001);
	CreateDynamicObject(2916, 1172.99963, -1430.65588, 21.89436,   0.00000, 0.00000, 69.06001);
	CreateDynamicObject(19466, 1164.79712, -1424.51221, 24.14234,   0.00000, 0.00000, 90.05998);
	CreateDynamicObject(19466, 1167.17493, -1424.59338, 24.14234,   0.00000, 0.00000, 90.05998);
	CreateDynamicObject(19466, 1169.55847, -1424.59998, 24.14234,   0.00000, 0.00000, 90.05998);
	CreateDynamicObject(19466, 1171.96619, -1424.52771, 24.14234,   0.00000, 0.00000, 90.05998);
	CreateDynamicObject(19466, 1174.32678, -1424.51208, 24.14234,   0.00000, 0.00000, 90.05998);
	CreateDynamicObject(19466, 1176.70703, -1424.51660, 24.14234,   0.00000, 0.00000, 90.05998);
	CreateDynamicObject(2623, 1178.53003, -1442.87305, 23.31788,   0.00000, 0.00000, -90.71998);
	CreateDynamicObject(2628, 1174.08081, -1444.01794, 21.73578,   0.00000, 0.00000, -180.48007);
	CreateDynamicObject(2628, 1172.05737, -1444.01477, 21.73578,   0.00000, 0.00000, -180.48007);
	CreateDynamicObject(14772, 1179.56238, -1444.64990, 25.52717,   14.22000, 2.76000, -139.85999);
	CreateDynamicObject(2658, 1169.12976, -1444.94214, 24.26124,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2257, 1176.14551, -1444.90222, 24.24820,   0.00000, 0.00000, -179.94003);
	CreateDynamicObject(14791, 1171.41382, -1437.45752, 23.75386,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1257, 1151.01367, -1413.06555, 13.69203,   0.00000, 0.00000, -89.04000);
	CreateDynamicObject(997, 1059.19519, -1500.12585, 13.05360,   0.00000, 0.00000, -105.89999);
	CreateDynamicObject(997, 1060.19263, -1496.84460, 13.05360,   0.00000, 0.00000, -105.89999);
	CreateDynamicObject(997, 1061.23633, -1493.45020, 13.05360,   0.00000, 0.00000, -105.89999);
	CreateDynamicObject(997, 1185.44727, -1484.21948, 13.08482,   0.00000, 0.00000, 271.25851);
	CreateDynamicObject(997, 1185.49255, -1487.87903, 13.08482,   0.00000, 0.00000, 269.51855);
	CreateDynamicObject(997, 1185.42957, -1491.42334, 13.08482,   0.00000, 0.00000, 269.51855);
	CreateDynamicObject(997, 1185.27478, -1495.11084, 13.08482,   0.00000, 0.00000, 269.51855);
	CreateDynamicObject(997, 1131.88696, -1562.46643, 13.12575,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(997, 1128.38464, -1562.39612, 13.12575,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(997, 1124.84277, -1562.33362, 13.12575,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2314, 1087.34009, -1450.55615, 21.73849,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2314, 1084.93542, -1450.54541, 21.73849,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2318, 1085.10376, -1450.53479, 22.51567,   0.00000, 0.00000, -1.86001);
	CreateDynamicObject(2316, 1086.21753, -1450.57788, 22.59807,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1792, 1087.57056, -1450.29163, 22.20508,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1749, 1089.03796, -1450.35974, 22.21263,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1208, 1086.41431, -1445.79663, 21.73680,   0.00000, 0.00000, 181.20000);
	CreateDynamicObject(1208, 1087.11792, -1445.78284, 21.73680,   0.00000, 0.00000, 181.20000);
	CreateDynamicObject(1208, 1087.10583, -1445.14636, 21.73680,   0.00000, 0.00000, 360.95987);
	CreateDynamicObject(1208, 1086.40332, -1445.16602, 21.73680,   0.00000, 0.00000, 360.95987);
	CreateDynamicObject(1984, 1092.24097, -1445.95483, 21.73620,   0.00000, 0.00000, 90.90002);
	CreateDynamicObject(2337, 1088.31116, -1441.75964, 21.73576,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2131, 1086.16089, -1441.76770, 21.73630,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2604, 1081.76770, -1441.68677, 22.51372,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2186, 1078.06616, -1446.96484, 21.73773,   0.00000, 0.00000, 91.79997);
	CreateDynamicObject(2582, 1077.86279, -1450.52551, 22.59217,   0.00000, 0.00000, 90.35999);
	CreateDynamicObject(2579, 1077.69092, -1452.04822, 23.33771,   0.00000, 0.00000, 90.12002);
	CreateDynamicObject(2622, 1081.99609, -1448.30164, 22.49662,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2463, 1077.77759, -1454.02271, 21.67389,   0.00000, 0.00000, 90.12000);
	CreateDynamicObject(2463, 1077.81506, -1455.52063, 21.67389,   0.00000, 0.00000, 90.12000);
	CreateDynamicObject(2059, 1077.88867, -1453.99573, 21.81599,   0.00000, 0.00000, 68.64001);
	CreateDynamicObject(2059, 1077.89990, -1454.31604, 21.81599,   0.00000, 0.00000, 68.64001);
	CreateDynamicObject(2059, 1077.92114, -1455.15796, 21.81599,   0.00000, 0.00000, 68.64001);
	CreateDynamicObject(2059, 1077.93628, -1455.51807, 21.81599,   0.00000, 0.00000, 68.64001);
	CreateDynamicObject(2059, 1077.93628, -1455.51807, 22.13558,   0.00000, 0.00000, 68.64001);
	CreateDynamicObject(19807, 1078.04224, -1455.64502, 22.54157,   0.00000, 0.00000, 88.86001);
	CreateDynamicObject(11705, 1077.93970, -1453.88416, 22.46490,   0.00000, 0.00000, 93.42001);
	CreateDynamicObject(11705, 1077.97644, -1455.06213, 22.81001,   0.00000, 0.00000, 93.42001);
	CreateDynamicObject(2297, 1081.82959, -1461.62915, 21.73615,   0.00000, 0.00000, 134.57996);
	CreateDynamicObject(2230, 1078.14282, -1461.15381, 21.73182,   0.00000, 0.00000, 158.21994);
	CreateDynamicObject(2230, 1083.66992, -1461.56799, 21.73182,   0.00000, 0.00000, 199.92003);
	CreateDynamicObject(1723, 1080.23938, -1456.86157, 21.73798,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2230, 1079.55591, -1455.60425, 21.73182,   0.00000, 0.00000, 40.67998);
	CreateDynamicObject(2230, 1083.59900, -1455.87390, 21.73182,   0.00000, 0.00000, -29.76002);
	CreateDynamicObject(19428, 1086.49646, -1460.00562, 22.43675,   91.62001, 28.37999, -26.99998);
	CreateDynamicObject(1717, 1085.63806, -1458.05847, 21.73735,   0.00000, 0.00000, 222.05983);
	CreateDynamicObject(2093, 1085.76147, -1459.67493, 21.73748,   0.00000, 0.00000, -139.44003);
	CreateDynamicObject(2475, 1091.32202, -1461.63538, 21.51240,   0.00000, 0.00000, -180.05994);
	CreateDynamicObject(2475, 1092.82410, -1461.60901, 21.51015,   0.00000, 0.00000, -180.05994);
	CreateDynamicObject(2103, 1092.47339, -1461.59546, 22.30504,   0.00000, 0.00000, -177.90005);
	CreateDynamicObject(2226, 1091.92578, -1461.44788, 23.00471,   0.00000, 0.00000, -180.05997);
	CreateDynamicObject(1841, 1091.45923, -1461.53223, 22.30752,   0.00000, 0.00000, -89.40001);
	CreateDynamicObject(1841, 1090.57727, -1461.53796, 22.30752,   0.00000, 0.00000, -89.40001);
	CreateDynamicObject(2232, 1093.67017, -1455.12671, 22.31667,   0.00000, 0.00000, -90.48000);
	CreateDynamicObject(2231, 1093.85059, -1456.68225, 21.73759,   0.00000, 0.00000, 269.10004);
	CreateDynamicObject(2229, 1093.79822, -1457.96497, 21.73610,   0.00000, 0.00000, 270.84003);
	CreateDynamicObject(2233, 1094.10681, -1459.45142, 21.73597,   0.00000, 0.00000, -88.92000);
	CreateDynamicObject(2229, 1093.72351, -1460.92590, 21.73610,   0.00000, 0.00000, 240.30000);
	CreateDynamicObject(1723, 1090.44202, -1458.49634, 21.73725,   0.00000, 0.00000, 90.06001);
	CreateDynamicObject(2482, 1088.19055, -1461.53528, 21.73133,   0.00000, 0.00000, 180.30005);
	CreateDynamicObject(2482, 1089.56128, -1461.51855, 21.73705,   0.00000, 0.00000, 180.30005);
	CreateDynamicObject(14820, 1088.68835, -1461.35120, 22.83119,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2099, 1086.59802, -1460.48755, 21.73741,   0.00000, 0.00000, 88.79998);
	CreateDynamicObject(2231, 1086.53186, -1459.06738, 21.73755,   0.00000, 0.00000, 91.44002);
	CreateDynamicObject(2231, 1086.53198, -1458.40381, 21.73755,   0.00000, 0.00000, 90.17999);
	CreateDynamicObject(2257, 1084.00891, -1441.28467, 24.74544,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2258, 1077.59375, -1447.71887, 25.39820,   0.00000, 0.00000, 90.06001);
	CreateDynamicObject(2256, 1077.59436, -1458.40796, 24.77145,   0.00000, 0.00000, 89.81999);
	CreateDynamicObject(2267, 1083.79553, -1461.65295, 25.01527,   0.00000, 0.00000, 180.36015);
	CreateDynamicObject(1622, 1072.25085, -1444.55347, 25.88511,   0.00000, 0.00000, 108.00000);
	CreateDynamicObject(18005, 1166.83252, -1501.15259, 15.35876,   0.00000, 0.00000, -20.58000);
	CreateDynamicObject(18003, 1164.28247, -1502.10791, 15.39914,   0.00000, 0.00000, -24.53999);
	CreateDynamicObject(18004, 1168.41077, -1501.84119, 17.68285,   0.00000, 0.00000, 336.75589);
	CreateDynamicObject(18004, 1165.70056, -1500.79614, 17.68285,   0.00000, 0.00000, 336.75589);
	CreateDynamicObject(18001, 1165.82751, -1500.71484, 16.80229,   0.00000, 0.00000, 338.82278);
	CreateDynamicObject(18002, 1166.29688, -1500.94189, 15.94264,   0.00000, 0.00000, 338.28391);
	CreateDynamicObject(2010, 1172.20654, -1503.58887, 14.79304,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2267, 1161.41956, -1511.15833, 17.29661,   0.00000, 0.00000, 158.85742);
	CreateDynamicObject(2284, 1164.35632, -1511.82019, 16.90046,   0.00000, 0.00000, 159.16791);
	CreateDynamicObject(2276, 1167.09045, -1512.83826, 16.87342,   0.00000, 0.00000, -201.48009);
	CreateDynamicObject(2281, 1168.72961, -1511.83484, 16.85382,   0.00000, 0.00000, -111.23999);
	CreateDynamicObject(19172, 1171.17932, -1506.89502, 17.32014,   0.00000, 0.00000, 248.76001);
	CreateDynamicObject(2290, 1168.91370, -1511.52148, 14.76017,   0.00000, 0.00000, -111.65992);
	CreateDynamicObject(2290, 1168.19885, -1513.37646, 14.76017,   0.00000, 0.00000, -199.25974);
	CreateDynamicObject(1817, 1167.03491, -1510.75195, 14.78556,   0.00000, 0.00000, -114.60001);
	CreateDynamicObject(2010, 1158.00793, -1508.90088, 14.79304,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19128, 1092.83594, -1476.98376, 19.08136,   -179.93982, 0.18001, 340.64417);
	CreateDynamicObject(19128, 1094.13965, -1473.24304, 19.08136,   -179.93982, 0.18001, 340.64417);
	CreateDynamicObject(19128, 1095.44678, -1469.49292, 19.08136,   -179.93982, 0.18001, 340.64417);
	CreateDynamicObject(16779, 1164.48474, -1506.49292, 19.04782,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2571, 1163.48047, -1510.53577, 14.78997,   0.00000, 0.00000, -203.09995);
	CreateDynamicObject(19294, 1166.09766, -1507.53442, 24.23873,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19294, 1164.17273, -1505.62073, 14.79201,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2727, 1143.65027, -1521.80273, 19.52373,   89.69994, 191.45961, 13.20000);
	CreateDynamicObject(2728, 1143.54175, -1521.35620, 19.52089,   -90.90000, 155.82011, -1.26013);
	//CreateDynamicObject(19370, 1144.66394, -1521.65161, 16.31997,   0.00000, 0.00000, -67.01998); // Door
	//CreateDynamicObject(19967, 1144.28943, -1521.73608, 13.91135,   0.00000, 0.00000, -156.96002); // Do not enter ds
	//CreateDynamicObject(19862, 1139.72107, -1523.50891, 18.00995,   0.00000, 0.00000, 21.24000); // ๏ฟฝ๏ฟฝะจ๏ฟฝ
	//CreateDynamicObject(19862, 1139.72107, -1523.50891, 15.51667,   0.00000, 0.00000, 21.24000); ๏ฟฝ๏ฟฝะจ๏ฟฝ
	//CreateDynamicObject(19862, 1139.00281, -1523.79614, 15.51667,   0.00000, 0.00000, 21.24000);
	//CreateDynamicObject(19862, 1139.00281, -1523.79614, 17.99508,   0.00000, 0.00000, 21.24000);
	//CreateDynamicObject(2363, 1141.54614, -1521.80920, 14.77760,   0.00000, 0.00000, 247.62000); // ๏ฟฝ๏ฟฝ๏ฟฝ๏ฟฝ Ds
	CreateDynamicObject(2942, 1135.12170, -1524.70935, 15.44458,   0.00000, 0.00000, -158.93999);
	CreateDynamicObject(1727, 1154.60339, -1528.98181, 21.73509,   0.00000, 0.00000, 48.41998);
	CreateDynamicObject(1726, 1155.94604, -1531.78491, 21.73494,   0.00000, 0.00000, 139.02002);
	CreateDynamicObject(1727, 1157.07581, -1528.23413, 21.73509,   0.00000, 0.00000, -40.62003);
	CreateDynamicObject(1817, 1155.62415, -1529.83154, 21.73444,   0.00000, 0.00000, -40.98000);
	CreateDynamicObject(1726, 1163.46411, -1536.29749, 21.73494,   0.00000, 0.00000, 229.19978);
	CreateDynamicObject(1727, 1158.90979, -1535.18457, 21.73509,   0.00000, 0.00000, 48.41998);
	CreateDynamicObject(1727, 1159.75488, -1534.27612, 21.73509,   0.00000, 0.00000, 48.41998);
	CreateDynamicObject(1817, 1161.29578, -1536.44263, 21.73444,   0.00000, 0.00000, 48.95999);
	CreateDynamicObject(16151, 1169.38513, -1534.33093, 22.07034,   0.00000, 0.00000, -40.68000);
	CreateDynamicObject(1726, 1168.31592, -1529.29590, 21.73494,   0.00000, 0.00000, 229.19978);
	CreateDynamicObject(1726, 1164.52600, -1528.69800, 21.73494,   0.00000, 0.00000, 49.55980);
	CreateDynamicObject(1817, 1166.46655, -1529.74438, 21.73444,   0.00000, 0.00000, 48.95999);
	CreateDynamicObject(1726, 1176.27820, -1526.81067, 21.73494,   0.00000, 0.00000, 229.19978);
	CreateDynamicObject(1726, 1175.28345, -1523.56982, 21.73494,   0.00000, 0.00000, 318.71967);
	CreateDynamicObject(2010, 1177.13708, -1525.60193, 21.73258,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1817, 1174.73291, -1526.97949, 21.73444,   0.00000, 0.00000, 48.95999);
	CreateDynamicObject(1817, 1174.03613, -1526.37598, 21.73444,   0.00000, 0.00000, 48.95999);
	CreateDynamicObject(1555, 1166.21643, -1539.25586, 21.73122,   0.00000, 0.00000, 48.59999);
	CreateDynamicObject(1555, 1165.01477, -1540.63550, 21.73122,   0.00000, 0.00000, 48.59999);
	CreateDynamicObject(1726, 1164.58716, -1517.88953, 21.73494,   0.00000, 0.00000, 49.55980);
	CreateDynamicObject(1727, 1167.98804, -1520.27661, 21.73509,   0.00000, 0.00000, 189.71994);
	CreateDynamicObject(1727, 1169.07227, -1518.61963, 21.73509,   0.00000, 0.00000, 232.74005);
	CreateDynamicObject(1817, 1166.87463, -1518.90454, 21.73444,   0.00000, 0.00000, 48.95999);
	CreateDynamicObject(19447, 1173.48096, -1518.13892, 21.84727,   0.42001, 90.29990, -41.87997);
	CreateDynamicObject(2233, 1173.58862, -1521.00183, 21.90405,   0.00000, 0.00000, -40.08000);
	CreateDynamicObject(2233, 1171.14783, -1518.87903, 21.92202,   0.00000, 0.00000, -40.08000);
	CreateDynamicObject(19370, 1093.27185, -1511.43555, 14.45394,   0.18000, 3.30000, 21.17999);
	CreateDynamicObject(19370, 1090.56396, -1504.44238, 14.45394,   0.18000, 3.30000, 21.17999);
	CreateDynamicObject(19370, 1089.45251, -1501.60974, 14.45394,   0.18000, 3.30000, 21.17999);
	CreateDynamicObject(19447, 1171.97766, -1519.83740, 20.12798,   -90.41994, 180.06012, 49.67998);
	CreateDynamicObject(19611, 1170.69360, -1521.22131, 21.90236,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19610, 1170.70227, -1521.20569, 23.55365,   48.96001, 74.22001, -47.15995);
	CreateDynamicObject(2258, 1174.25146, -1529.99231, 23.98993,   0.00000, 0.00000, 228.77156);
	CreateDynamicObject(2258, 1168.56702, -1536.47327, 23.98993,   0.00000, 0.00000, 228.77156);
	CreateDynamicObject(2276, 1168.67297, -1517.01489, 23.38475,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2276, 1167.35071, -1516.53259, 23.78943,   0.00000, 0.00000, -41.63999);
	CreateDynamicObject(2267, 1160.07751, -1536.57629, 24.07759,   0.00000, 0.00000, 138.65974);
	CreateDynamicObject(2261, 1154.92896, -1531.41870, 23.73659,   0.00000, 0.00000, -220.92009);
	CreateDynamicObject(3096, 1097.40820, -1521.68774, 27.31033,   0.00000, 0.00000, -410.16013);
	CreateDynamicObject(2436, 1167.96716, -1534.79468, 22.60623,   0.00000, 0.00000, -130.68013);
	CreateDynamicObject(18064, 1101.42017, -1537.63892, 23.71083,   0.00000, 0.00000, 129.29997);
	CreateDynamicObject(18105, 1094.18970, -1530.33313, 23.68493,   0.00000, 0.00000, 130.02000);
	CreateDynamicObject(19360, 1089.58789, -1525.62610, 23.16733,   -90.30000, 5.40000, -44.93997);
	CreateDynamicObject(19360, 1087.28186, -1527.54358, 23.16733,   -90.30000, 5.40000, -44.93997);
	CreateDynamicObject(1463, 1089.05151, -1524.70740, 21.73584,   0.00000, 0.00000, -140.33995);
	CreateDynamicObject(11706, 1088.08618, -1525.58032, 21.73539,   0.00000, 0.00000, 36.24000);
	CreateDynamicObject(2068, 1083.21899, -1525.71069, 25.70185,   0.00000, 0.00000, -43.14001);
	CreateDynamicObject(1885, 1094.40515, -1520.48157, 21.73522,   0.00000, 0.00000, 41.03999);
	CreateDynamicObject(2358, 1097.95337, -1524.15222, 21.84309,   0.00000, 0.00000, -139.26001);
	CreateDynamicObject(2358, 1097.38208, -1524.61389, 21.84309,   0.00000, 0.00000, -139.26001);
	CreateDynamicObject(2358, 1096.80200, -1525.08911, 21.84309,   0.00000, 0.00000, -139.26001);
	CreateDynamicObject(2358, 1096.27808, -1525.51196, 21.84309,   0.00000, 0.00000, -139.26001);
	CreateDynamicObject(2358, 1096.53809, -1525.31104, 22.08687,   0.00000, 0.00000, -139.26001);
	CreateDynamicObject(2358, 1097.67859, -1524.35815, 22.08687,   0.00000, 0.00000, -139.26001);
	CreateDynamicObject(19815, 1081.64807, -1529.96289, 23.22897,   0.00000, 0.00000, 131.45987);
	CreateDynamicObject(19899, 1079.85083, -1527.17175, 21.67442,   0.00000, 0.00000, 40.26001);
	CreateDynamicObject(1432, 1087.81409, -1518.36548, 21.73320,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1594, 1085.59534, -1520.46118, 22.21455,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1514, 1096.47791, -1526.55139, 22.96882,   0.00000, 0.00000, -88.74003);
	CreateDynamicObject(2358, 1095.96448, -1525.76526, 22.03591,   -3.84000, 40.19999, -139.26001);
	CreateDynamicObject(2225, 1172.06750, -1519.99231, 21.89407,   0.00000, 0.00000, -40.68000);
	CreateDynamicObject(2060, 1087.02673, -1526.83154, 21.84587,   0.00000, 0.00000, 41.64001);
	CreateDynamicObject(2060, 1086.21851, -1527.71118, 21.84587,   0.00000, 0.00000, 41.64001);
	CreateDynamicObject(2060, 1086.72766, -1527.28149, 22.02852,   0.00000, 0.00000, 41.64001);
	CreateDynamicObject(18042, 1085.59851, -1516.98669, 22.19666,   0.00000, 0.00000, 491.09949);
	CreateDynamicObject(1764, 1092.63391, -1518.15833, 21.73538,   0.00000, 0.00000, -48.54000);
	CreateDynamicObject(1481, 1082.74036, -1521.56384, 22.37431,   0.00000, 0.00000, 41.51999);
	CreateDynamicObject(19900, 1082.64233, -1530.61792, 21.73415,   0.00000, 0.00000, 43.26002);
	CreateDynamicObject(19900, 1082.20581, -1530.14539, 21.73415,   0.00000, 0.00000, 43.26002);
	CreateDynamicObject(19900, 1081.76941, -1529.67297, 21.73415,   0.00000, 0.00000, 43.26002);
	CreateDynamicObject(18633, 1082.51160, -1530.36914, 22.61701,   -1.91999, 104.16003, 0.00000);
	CreateDynamicObject(19627, 1081.91333, -1529.55603, 22.60806,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18042, 1083.73657, -1541.10242, 22.20860,   0.00000, 0.00000, -319.38013);
	CreateDynamicObject(19899, 1085.84436, -1534.11255, 21.67442,   0.00000, 0.00000, 41.34002);
	CreateDynamicObject(1265, 1084.46545, -1532.83923, 22.13240,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1265, 1084.78125, -1532.35938, 22.13240,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1264, 1083.86523, -1532.29248, 21.99983,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2414, 1091.16125, -1540.25549, 21.73570,   0.00000, 0.00000, 130.44008);
	CreateDynamicObject(2414, 1089.87134, -1538.72620, 21.73570,   0.00000, 0.00000, 130.44008);
	CreateDynamicObject(2414, 1088.58545, -1537.21106, 21.73570,   0.00000, 0.00000, 130.44008);
	CreateDynamicObject(11738, 1090.99695, -1539.99780, 22.83102,   0.00000, 0.00000, -6.30001);
	CreateDynamicObject(2961, 1092.99878, -1539.26379, 23.46448,   0.00000, 0.00000, 40.73998);
	CreateDynamicObject(2690, 1089.00696, -1537.53540, 23.14061,   0.00000, 0.00000, 101.58000);
	CreateDynamicObject(2690, 1088.52014, -1537.15967, 23.14061,   0.00000, 0.00000, -125.39999);
	CreateDynamicObject(11738, 1090.60425, -1539.48267, 22.83102,   0.00000, 0.00000, -66.42001);
	CreateDynamicObject(11245, 1101.05652, -1522.43494, 28.41408,   0.00000, 0.00000, -323.58002);
	CreateDynamicObject(11245, 1097.16663, -1518.25220, 28.41408,   0.00000, 0.00000, -323.58002);
	CreateDynamicObject(18639, 1090.00195, -1538.84192, 22.86076,   -3.42000, -85.20002, 0.00000);
	CreateDynamicObject(18639, 1090.00195, -1538.84192, 22.86076,   -3.42000, -85.20002, 0.00000);
	CreateDynamicObject(18637, 1089.23120, -1538.18811, 22.78880,   0.00000, 0.00000, 40.79999);
	CreateDynamicObject(2068, 1094.93994, -1529.34827, 26.16114,   4.08000, -1.44000, -43.14001);
	CreateDynamicObject(1256, 1160.23279, -1415.54907, 13.19969,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1256, 1156.94885, -1415.53491, 13.19969,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(994, 1154.87695, -1412.06799, 12.82866,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(997, 1157.50281, -1413.47583, 12.75624,   0.00000, 0.00000, -89.16001);
	CreateDynamicObject(994, 1147.55261, -1412.09534, 12.82866,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(994, 1140.29724, -1412.13464, 12.82866,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(994, 1132.95911, -1412.15771, 12.82866,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(994, 1125.58093, -1412.13623, 12.82866,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(994, 1118.09314, -1412.13245, 12.82866,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(994, 1110.54236, -1412.17200, 12.82866,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(994, 1103.10205, -1412.24060, 12.82866,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(997, 1099.61328, -1413.98047, 12.75624,   0.00000, 0.00000, -89.16001);
	CreateDynamicObject(19545, 1105.34558, -1370.01331, 13.30436,   0.00000, 0.00000, -89.99998);
	CreateDynamicObject(19541, 1136.44482, -1377.49536, 13.30030,   0.00000, 0.00000, -179.46001);
	CreateDynamicObject(19541, 1094.66321, -1377.90723, 13.30030,   0.00000, 0.00000, -359.51978);
	CreateDynamicObject(5706, 1111.11560, -1375.47668, 9.46984,   0.00000, 0.00000, 0.66000);
	CreateDynamicObject(5706, 1119.85498, -1375.47339, 9.46984,   0.00000, 0.00000, 0.36000);
	CreateDynamicObject(14411, 1138.32153, -1373.68054, 10.04228,   0.00000, 0.00000, 89.22003);
	CreateDynamicObject(14411, 1138.32959, -1371.72034, 10.04228,   0.00000, 0.00000, 89.22003);
	CreateDynamicObject(647, 1137.67517, -1384.24976, 13.93782,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(647, 1139.71387, -1382.51672, 13.93782,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(647, 1139.38745, -1380.43774, 13.93782,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(647, 1139.18689, -1377.37451, 13.93782,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(647, 1137.27124, -1376.27502, 13.93782,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1280, 1136.82727, -1380.74268, 13.64008,   0.00000, 0.00000, 4.20000);
	CreateDynamicObject(1328, 1136.53674, -1378.90527, 13.79385,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(673, 1123.63953, -1381.18921, 13.29447,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(673, 1112.89246, -1381.30347, 13.29447,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(673, 1102.62073, -1381.33020, 13.29447,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19447, 1087.35327, -1377.41309, 11.53457,   0.00000, 0.00000, 90.12000);
	CreateDynamicObject(19447, 1090.06262, -1377.39172, 11.53457,   0.00000, 0.00000, 90.12000);
	CreateDynamicObject(19447, 1086.69897, -1362.60388, 11.53457,   0.00000, 0.00000, 90.12000);
	CreateDynamicObject(8673, 1088.21143, -1362.46179, 14.26378,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1331, 1092.24097, -1364.59631, 14.18957,   0.00000, 0.00000, -33.54000);
	CreateDynamicObject(1440, 1090.12170, -1363.52698, 13.80128,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1334, 1083.39600, -1365.79468, 14.40367,   0.00000, 0.00000, 90.30002);
	CreateDynamicObject(987, 1082.41821, -1335.75476, 12.44810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 1102.63989, -1381.28455, 13.72979,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 1112.97607, -1381.25818, 13.72979,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 1123.86902, -1381.06433, 13.72979,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1281, 1098.87195, -1381.59363, 14.08930,   0.00000, 0.00000, 69.05998);
	CreateDynamicObject(1281, 1107.86035, -1381.47510, 14.08930,   0.00000, 0.00000, 89.45998);
	CreateDynamicObject(1280, 1121.32837, -1381.26501, 13.64008,   0.00000, 0.00000, 1.74000);
	CreateDynamicObject(1280, 1126.23096, -1381.26782, 13.64008,   0.00000, 0.00000, 180.84006);
	CreateDynamicObject(19447, 1090.06262, -1377.39172, 11.53457,   0.00000, 0.00000, 90.12000);
	CreateDynamicObject(19447, 1143.73840, -1375.54321, 11.53457,   0.00000, 0.00000, 90.12000);
	CreateDynamicObject(19447, 1153.35291, -1375.52136, 11.53457,   0.00000, 0.00000, 90.12000);
	CreateDynamicObject(17550, 1146.55, -1397.65, 14.765, 0.00000, 0.00000, -72.4);

    return 1;
}