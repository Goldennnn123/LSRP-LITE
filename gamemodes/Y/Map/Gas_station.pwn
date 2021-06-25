#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 1412, 1917.320, -1797.421, 13.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1912.054, -1797.421, 13.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1906.773, -1797.421, 13.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1927.851, -1797.421, 13.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1922.585, -1797.421, 13.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1938.390, -1797.421, 13.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1933.125, -1797.421, 13.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1951.609, -1821.125, 13.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1951.609, -1815.859, 13.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1951.609, -1810.593, 13.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1951.609, -1805.328, 13.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1948.984, -1797.421, 13.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1943.687, -1797.421, 13.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1951.609, -1800.062, 13.812, 0.250);
    return 1;
}

hook OnGameModeInit()
{
    new tmpobjid;




    tmpobjid = CreateDynamicObject(19377, 1917.293212, -1802.088134, 12.462498, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1927.789306, -1802.088134, 12.462498, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1917.333251, -1811.689208, 12.462498, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1927.829101, -1811.689208, 12.462498, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1938.207763, -1802.088134, 12.462498, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1938.212646, -1811.684570, 12.462498, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1946.435302, -1811.692138, 12.462400, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1946.435302, -1802.088134, 12.462400, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1949.371459, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1950.197875, -1814.770874, 12.576583, -89.399963, 179.999984, -90.300025, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1950.210083, -1812.449951, 12.576583, -89.399963, 179.999984, -90.300025, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1947.297363, -1814.770874, 12.576583, -89.399963, 179.999984, -90.299980, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1947.309570, -1812.449951, 12.576583, -89.399963, 179.999984, -90.299980, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1947.040771, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1944.710937, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1944.296630, -1814.770874, 12.576583, -89.399963, 179.999984, -90.299964, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1944.308837, -1812.449951, 12.576583, -89.399963, 179.999984, -90.299964, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1942.380249, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1941.206054, -1814.770874, 12.576583, -89.399963, 179.999984, -90.299949, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1941.218261, -1812.449951, 12.576583, -89.399963, 179.999984, -90.299949, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1940.050659, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1937.740600, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1938.236206, -1814.770874, 12.576583, -89.399963, 179.999984, -90.299934, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1938.248413, -1812.449951, 12.576583, -89.399963, 179.999984, -90.299934, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1935.410644, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1935.226074, -1814.770874, 12.576583, -89.399963, 179.999984, -90.299919, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1935.238281, -1812.449951, 12.576583, -89.399963, 179.999984, -90.299919, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1933.079711, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1930.768676, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1928.429077, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1926.098388, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1923.797729, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1921.467407, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1919.146728, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1916.835815, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1914.525024, -1815.987792, 12.571545, -89.399963, 179.999267, 179.999267, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1932.386596, -1814.770874, 12.576583, -89.399963, 179.999984, -90.299903, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1932.398803, -1812.449951, 12.576583, -89.399963, 179.999984, -90.299903, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1929.375610, -1814.770874, 12.576583, -89.399963, 179.999984, -90.299888, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1929.387817, -1812.449951, 12.576583, -89.399963, 179.999984, -90.299888, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1926.255493, -1814.770874, 12.576583, -89.399963, 179.999984, -90.299858, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1926.267700, -1812.449951, 12.576583, -89.399963, 179.999984, -90.299858, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1923.124877, -1814.770874, 12.576583, -89.399963, 179.999984, -90.299842, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1923.137084, -1812.449951, 12.576583, -89.399963, 179.999984, -90.299842, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1920.064819, -1814.770874, 12.576583, -89.399963, 179.999984, -90.299827, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1920.077026, -1812.449951, 12.576583, -89.399963, 179.999984, -90.299827, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1916.934814, -1814.770874, 12.576583, -89.399963, 179.999984, -90.299812, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1916.947021, -1812.449951, 12.576583, -89.399963, 179.999984, -90.299812, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1913.604614, -1814.770874, 12.576583, -89.399963, 179.999984, -90.299797, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1913.616821, -1812.449951, 12.576583, -89.399963, 179.999984, -90.299797, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1940.226684, -1797.605834, 12.571545, -89.399963, 179.999267, 0.399246, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1939.228515, -1798.828491, 12.576583, -89.399963, 179.999984, 90.099929, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1939.232543, -1801.149536, 12.576583, -89.399963, 179.999984, 90.099929, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1942.128906, -1798.808227, 12.576583, -89.399963, 179.999984, 90.099975, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1942.132934, -1801.129272, 12.576583, -89.399963, 179.999984, 90.099975, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1942.557250, -1797.589599, 12.571545, -89.399963, 179.999267, 0.399246, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1944.887084, -1797.573242, 12.571545, -89.399963, 179.999267, 0.399246, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1945.129638, -1798.787353, 12.576583, -89.399963, 179.999984, 90.099990, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1945.133666, -1801.108276, 12.576583, -89.399963, 179.999984, 90.099990, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1947.217651, -1797.557006, 12.571545, -89.399963, 179.999267, 0.399246, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1948.220092, -1798.765747, 12.576583, -89.399963, 179.999984, 90.100006, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1948.224121, -1801.086791, 12.576583, -89.399963, 179.999984, 90.100006, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 1949.187744, -1816.568969, 12.477310, 0.000000, 0.000000, 90.000007, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 1944.197631, -1816.568969, 12.477310, 0.000000, 0.000000, 90.000007, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 1939.197509, -1816.568969, 12.477310, 0.000007, 0.000000, 89.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 1934.207397, -1816.568969, 12.477310, 0.000007, 0.000000, 89.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 1929.215576, -1816.568969, 12.477310, 0.000014, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 1924.225463, -1816.568969, 12.477310, 0.000014, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 1919.226074, -1816.568969, 12.477310, 0.000022, 0.000000, 89.999938, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 1914.496215, -1816.568969, 12.477310, 0.000022, 0.000000, 89.999938, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 1912.117797, -1799.751708, 12.477310, 0.000022, 0.000000, 179.900009, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 1912.108520, -1804.742431, 12.477310, 0.000022, 0.000000, 179.900009, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 1912.100463, -1809.723510, 12.477310, 0.000022, 0.000000, 179.900009, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 1912.092407, -1814.154418, 12.477310, 0.000022, 0.000000, 179.900009, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
    return 1;
}
